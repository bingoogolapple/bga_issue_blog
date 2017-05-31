<template>
  <div id="toolbar">
    <i class="glyphicon logo"><img src="../assets/logo.png"></i>
    <i @click="openGitHub"><img src="../assets/github.png"></i>
    <i @click="openWeiBo"><img src="../assets/weibo.png"></i>
    <i @click="openGitBook"><img src="../assets/git.png"></i>
  </div>
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
  #toolbar {
    margin: 0px;
    float: left;
    width: 80px;
    height: 100%;
    background-color: #343f4b;
    padding: 35px 25px 25px 25px;
    i {
      font-size: 30px;
      margin-bottom: 50px;
      opacity: 0.8;
      cursor: pointer;
      transition: opacity 0.5s ease;
      &:hover {
        opacity: 1;
      }
      &:first-child {
        cursor: default;
        opacity: 1;
      }
      img {
        width: 30px;
        height: 30px;
      }
    }
  }
</style>
