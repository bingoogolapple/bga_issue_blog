<template>
  <div class="blog-list-container">
    <div class="table-header">
      <span>名称</span>
      <span>创建时间</span>
    </div>
    <ul class="issue-list" ref="issueList">
      <li class="issue-item" v-for="issue in issues" :key="issue.id">
        <router-link tag="a" :to="{name: 'BlogDetail', params: {number: issue.number, issue: issue}}">
          {{issue.title}}
        </router-link>
        <ul>
          <li class="tag tag-small" v-for="label in issue.labels" :key="label.id" @click="setActiveLabel(label)"
              :style="{ backgroundColor: '#' + label.color}">{{label.name}}
          </li>
        </ul>
        <span class="time">
          {{$moment(issue.created_at).format('YYYY-MM-DD HH:mm')}}
        </span>
      </li>
    </ul>
    <div class="bottom-bar">
      <input type="text" class="fl query" v-model="keyword" placeholder="Search issues"
             @keyup.enter="searchIssues()"/>
      <pagination :totalNum="totalNum" :currentPage="currentPage" :pageSize="pageSize"
                  @currentPageChanged="handleCurrentPageChanged"/>
    </div>
  </div>
</template>
<style lang="scss" scoped>
  $time-width: 150px;

  .blog-list-container {
    flex-grow: 1;
    display: flex;
    overflow-y: auto; // 本来只在 issue-list 上添加 overflow-y: auto 就可以的，在 blog-list-container 里也添加 overflow-y: auto 是为了兼容 Firefox 和 Android
    flex-direction: column;
  }

  .table-header {
    flex: 0 0 48px;
    display: flex;
    align-items: center;
    background-color: #f9fafc;
    padding: 0px 70px;
    border-top: 1px solid #eeeeee;
    border-bottom: 1px solid #eeeeee;
    font-size: 12px;
    color: #a3b4bc;
    :first-child {
      flex-grow: 1;
    }
    :last-child {
      flex: 0 0 $time-width;
    }
  }

  .issue-list {
    flex-grow: 1;
    overflow-y: auto;
    display: flex;
    flex-direction: column;
    list-style: none;
    .issue-item {
      flex: 0 0 69px;
      border-bottom: solid 1px #eeeeee;
      display: flex;
      align-items: center;
      padding: 0px 70px;
      a {
        font-size: 15px;
        color: #4b595f;
        white-space: nowrap;
        overflow: hidden;
        text-overflow: ellipsis;
      }
      a:hover {
        color: #3593f2;
      }
      ul {
        display: flex;
        flex-grow: 1;
        margin: 0 30px;
        list-style: none;
      }
      .time {
        font-size: 15px;
        color: #4b595f;
        cursor: default;
        flex: 0 0 $time-width;
      }
    }
  }

  .bottom-bar {
    flex: 0 0 69px;
    padding: 0px 40px;
    border-top: 1px solid #eeeeee;
    display: flex;
    align-items: center;
    .query {
      flex-grow: 1;
      height: 16px;
      border-radius: 3px;
      padding: 15px 30px 15px 15px;
      border: solid 1px #eeeeee;
      font-size: 14px;
      color: #4b595f;
      margin-right: 20px;
      outline: none;
      background: #f9fafc url("../assets/enter-icon.svg") no-repeat calc(100% - 10px) center;
    }

    .query::placeholder {
      color: #849aa4;
    }
  }
</style>
<script>
  import { mapGetters, mapActions } from 'vuex'
  import Pagination from '../components/Pagination.vue'

  export default {
    data () {
      return {
        keyword: '',
        totalNum: 0,
        currentPage: 1,
        issues: []
      }
    },
    components: {Pagination},
    watch: {
      activeLabel (label) {
        this.keyword = ''
        this.totalNum = 0
        this.currentPage = 1
        this.getIssues()
      }
    },
    computed: {
      ...mapGetters([
        'activeLabel',
        'pageSize'
      ])
    },
    methods: {
      ...mapActions([
        'updateActiveLabel'
      ]),
      setActiveLabel (label) {
        this.updateActiveLabel(label)
      },
      searchIssues () {
        this.currentPage = 1
        this.getIssues()
      },
      handleCurrentPageChanged (val) {
        this.currentPage = val
        this.getIssues()
      },
      getIssues () {
        this.$gitHubApi.getIssues(this, {
          label: this.activeLabel ? this.activeLabel.name : '',
          keyword: this.keyword,
          currentPage: this.currentPage,
          pageSize: this.pageSize
        }).then(response => {
          // 加载完数据后滚动到顶部
          this.$refs.issueList.scrollTop = 0
          this.totalNum = response.data.total_count
          this.issues = response.data.items
        })
      }
    },
    mounted () {
      this.$nextTick(() => {
        this.getIssues()
      })
    }
  }
</script>
