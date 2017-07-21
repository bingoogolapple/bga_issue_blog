<template>
  <div class="blog-list-container">
    <div class="table-header">
      <span>名称</span>
      <span class="fr">创建时间</span>
    </div>
    <div class="scrollable-container">
      <ul class="issue-list">
        <li v-for="issue in issues" :key="issue.id">
          <router-link class="mr30" :to="{name:'BlogDetail', params: {number: issue.number, issue: issue}}">
            {{issue.title.trim().substring(0, 35)}}
          </router-link>
          <span class="tag tag-small" v-for="label in issue.labels" :key="label.id" @click="setActiveLabel(label)"
                :style="{ backgroundColor: '#' + label.color}">{{label.name}}</span>
          <span class="time">
          {{$moment(issue.created_at).format('YYYY-MM-DD HH:mm')}}
        </span>
        </li>
      </ul>
      <div class="bottom-bar">
        <input type="text" class="fl query" v-model="keyword" placeholder="Search issues"
               @keyup.enter="searchIssues()"/>
        <pagination class="pagination" :totalNum="totalNum" :currentPage="currentPage" :pageSize="pageSize"
                    @currentPageChanged="handleCurrentPageChanged"/>
      </div>
    </div>
  </div>
</template>
<style lang="scss" scoped>
  @import "../css/common";

  $table-header-height: 50px;
  $item-height: 69px;
  $time-width: 240px;
  $title-pdding-left: 67px;
  $bottom-bar-height: 70px;

  .blog-list-container {
    @include excludeLabelListHeightBox();
  }

  .issue-list {
    li {
      list-style-type: none;
      height: $item-height;
      border-bottom: solid 1px #eeeeee;
      padding-left: $title-pdding-left;
      .time {
        float: right;
        height: $item-height;
        line-height: $item-height;
        font-size: 15px;
        color: #4b595f;
        cursor: default;
        width: $time-width;
      }
      a {
        height: $item-height;
        line-height: $item-height;
        font-size: 15px;
        color: #4b595f;
      }
      a:hover {
        color: #3593f2;
      }
    }
  }

  .table-header {
    height: $table-header-height;
    background-color: #f9fafc;
    font-size: 12px;
    color: #a3b4bc;
    line-height: $table-header-height;
    :first-child {
      padding-left: $title-pdding-left;
    }
    :last-child {
      width: $time-width;
    }
  }

  .scrollable-container {
    overflow: scroll;
    @include heightBox($table-header-height);
  }

  .bottom-bar {
    height: $bottom-bar-height;
    margin-top: 50px;
    padding: 0px 40px;
  }

  .query {
    margin-top: 11px;
    height: 16px;
    border-radius: 3px;
    padding: 15px 30px 15px 15px;
    border: solid 1px #eeeeee;
    font-size: 14px;
    color: #4b595f;
    margin-right: 20px;
    width: calc(100% - 50px - 300px - 20px - 2px);
    outline: none;
    background: url("../assets/enter-icon.svg") no-repeat calc(100% - 10px) center;
    background-color: #f9fafc;
  }

  .query::placeholder {
    color: #849aa4;
  }

  .pagination {
    float: right;
    margin: 16px 0px;
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
        pageSize: 10,
        issues: []
      }
    },
    components: {Pagination},
    watch: {
      activeLabel (label) {
        this.keyword = ''
        this.totalNum = 0
        this.currentPage = 1
        this.pageSize = 10
        this.getIssues()
      }
    },
    computed: {
      ...mapGetters([
        'activeLabel'
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
          this.$bgaBacktop()
          this.totalNum = response.data.total_count
          this.issues = response.data.items
        })
      }
    },
    mounted () {
      this.$nextTick(function () {
        this.getIssues()
      })
    }
  }
</script>
