<template>
  <el-row class="toolbar" type="flex" justify="space-around">
    <el-col :span="3"><i @click="home()"><img src="../assets/logo.png"></i></el-col>
    <el-col :span="3"><i @click="openGitHub"><img src="../assets/github.png"></i></el-col>
    <el-col :span="3"><i @click="openWeiBo"><img src="../assets/weibo.png"></i></el-col>
    <el-col :span="3"><i @click="openGitBook"><img src="../assets/git.png"></i></el-col>
    <el-col :span="3" style="padding-top: 10px;color: white;">
      <router-link to="/GitHub">GitHub</router-link>
    </el-col>
    <el-col :span="3" style="padding-top: 10px;color: white;">
      <router-link to="/AboutMe">About Me</router-link>
    </el-col>
  </el-row>
</template>

<script>
  import { mapGetters } from 'vuex'

  export default {
    computed: {
      ...mapGetters([
        'gitHubUsername',
        'weiBoUsername'
      ])
    },
    methods: {
      home () {
        this.$router.push('/')
      },
      openGitHub: function () {
        window.open('https://github.com/' + this.gitHubUsername)
      },
      openWeiBo: function () {
        window.open('http://weibo.com/' + this.weiBoUsername)
      },
      openGitBook: function () {
        window.open('https://bingoogolapple.gitbooks.io/bgalearningnotes-git/content')
      }
    }
  }
</script>

<style lang="scss" scoped>
  .toolbar {
    position: fixed;
    left: 0px;
    top: 0px;
    right: 0px;
    height: 50px;
    background-color: #343f4b;
    img {
      margin-top: 10px;
      width: 30px;
      height: 30px;
      cursor: pointer;
    }
  }
</style>
