<template>
  <el-card class="github-container" v-if="gitHubUser">
    <div slot="header">
      <span class="mr20">{{gitHubUser.name}}</span>
      <span class="mr20">{{gitHubUser.location}}</span>
      <span>{{gitHubUser.bio}}</span>
    </div>
    <el-table :data="repos" border stripe style="width: 100%">
      <el-table-column label="Name" prop="name">
        <template scope="scope">
          <a :href="scope.row.html_url" target="_blank">{{scope.row.name}}</a>
        </template>
      </el-table-column>
      <el-table-column label="Description" prop="description"/>
      <el-table-column label="Star" prop="stargazers_count"/>
      <el-table-column label="Fork" prop="forks_count"/>
    </el-table>
  </el-card>
</template>
<style lang="scss" scoped>
  .github-container {
    position: fixed;
    left: 0px;
    top: 50px;
    right: 0px;
    bottom: 0px;
    overflow: scroll;
    border-radius: 0px;
  }
</style>
<script>
  export default {
    data () {
      return {
        repos: [],
        gitHubUser: null
      }
    },
    methods: {
      handleCurrentChange (val) {
        this.currentPage = val
        this.getRepos()
      },
      handleSizeChange (val) {
        this.pageSize = val
        this.getRepos()
      },
      getGitHubUser () {
        this.$gitHubApi.getGitHubUser(this).then(response => {
          this.gitHubUser = response.data
          this.totalNum = this.gitHubUser.public_repos
          this.getRepos()
        })
      },
      getRepos () {
        this.$gitHubApi.getRepos(this, {
          currentPage: this.currentPage,
          pageSize: this.pageSize
        }).then(response => {
          let repos = response.data
          repos = this._.orderBy(repos, ['stargazers_count'], ['desc'])
          this.repos = this._.slice(repos, 0, Math.min(repos.length, 10))
        })
      }
    },
    mounted: function () {
      this.$nextTick(function () {
        this.getGitHubUser()
      })
    }
  }
</script>
