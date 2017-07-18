<template>
  <div class="blog-list-container">
    <div class="table-header">
      <span>名称</span>
      <span class="fr">创建时间</span>
    </div>
    <div class="scrollable-container">
      <ul class="issue-list">
        <li v-for="issue in issues">
          <router-link class="mr20" :to="{name:'BlogDetail', params: {number: issue.number, issue: issue}}">
            {{issue.title.trim().substring(0, 35)}}
          </router-link>
          <span class="tag" v-for="tag in issue.labels" @click="setActiveLabel(tag)">
          <el-tag :color="'#' + tag.color">{{tag.name}}</el-tag>
        </span>
          <span class="fr time">
          {{$moment(issue.created_at).format('YYYY-MM-DD HH:mm')}}
        </span>
        </li>
      </ul>
      <div class="bottom-bar">
        <input type="text" class="fl query" v-model="keyword" placeholder="Search issues" @keyup.enter="searchIssues()"/>
        <!--<el-input class="fl query" v-model="keyword" placeholder="Search issues" @keyup.enter.native="searchIssues()"/>-->
        <el-pagination
          class="mt20 fr"
          @current-change="handleCurrentChange"
          :current-page="currentPage"
          :page-size="pageSize"
          layout="total, prev, pager, next"
          :total="totalNum">
        </el-pagination>
      </div>
    </div>
  </div>
</template>
<style lang="scss" scoped>
  $item-height: 69px;
  $time-width: 240px;
  $title-pdding-left: 67px;
  $bottom-bar-height: 70px;

  .blog-list-container {
    height: 100%;
  }

  .issue-list {
    li {
      list-style-type: none;
      height: $item-height;
      border-bottom: solid 1px #eeeeee;
      padding-left: $title-pdding-left;
      .time {
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
    height: $item-height;
    background-color: #f9fafc;
    font-size: 12px;
    color: #a3b4bc;
    line-height: $item-height;
    :first-child {
      padding-left: $title-pdding-left;
    }
    :last-child {
      width: $time-width;
    }
  }

  .scrollable-container {
    overflow: scroll;
    height: calc(100% - 196px);
  }

  .bottom-bar {
    border-top: 1px solid rgba(0, 0, 0, 0.1);
    height: $bottom-bar-height;
    margin-top: 80px;
    padding-left: 50px;
    padding-right: 50px;
  }

  .query {
    margin-top: 11px;
    height: 16px;
    border-radius: 3px;
    padding: 15px 30px 15px 15px;
    border: solid 1px #eeeeee;
    font-size: 14px;
    color: #849aa4;
    width: 250px;
    background: url("../assets/enter-icon.svg") no-repeat 270px center;
    background-color: #f9fafc;
    outline: none;
  }
</style>
<script>
  import { mapGetters, mapActions } from 'vuex'

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
    watch: {
      activeLabel: function (label) {
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
      handleCurrentChange (val) {
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
          this.totalNum = response.data.total_count
          this.issues = response.data.items
        })
      }
    },
    mounted: function () {
      this.$nextTick(function () {
        this.getIssues()
      })
    }
  }
</script>
