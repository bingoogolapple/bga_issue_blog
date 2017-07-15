<template>
  <el-card class="home">
    <div slot="header">
      <el-input v-model="keyword" placeholder="Search issues" @keyup.enter.native="searchIssues()"/>
    </div>
    <ul>
      <li v-for="issue in issues">
        <router-link :to="{name:'Detail', params: {number: issue.number, issue: issue}}">{{issue.title.trim().substring(0, 35)}}</router-link>
        <span class="m5 tag" v-for="tag in issue.labels" @click="setActiveLabel(tag)">
          <el-tag :color="'#' + tag.color">{{tag.name}}</el-tag>
        </span>
        <span class="fr time">
          {{$moment(issue.created_at).format('YYYY-MM-DD HH:mm')}}
        </span>
      </li>
    </ul>

    <el-pagination
      class="mt20"
      @size-change="handleSizeChange"
      @current-change="handleCurrentChange"
      :current-page="currentPage"
      :page-sizes="[10, 25, 50]"
      :page-size="pageSize"
      layout="total, sizes, prev, pager, next"
      :total="totalNum">
    </el-pagination>
  </el-card>
</template>
<style lang="scss" scoped>
  .home {
    position: fixed;
    left: 150px;
    top: 50px;
    right: 0px;
    bottom: 0px;
    overflow: scroll;
    border-radius: 0px;
    ul {
      min-height: 400px;
      li {
        list-style-type: none;
        border-bottom: 1px dashed lightgray;
        padding: 8px 0px 12px 0px;
        .time {
          color: #6a6a6a;
          font-size: 0.95em;
          cursor: default;
        }
        a {
          color: #228fcd;
        }
        a:hover {
          color: gray;
        }
      }
    }
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
      handleSizeChange (val) {
        this.pageSize = val
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
