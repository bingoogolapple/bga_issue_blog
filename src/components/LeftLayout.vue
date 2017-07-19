<template>
  <div class="left-layout-container" v-if="gitHubUser">
    <img @click="home" class="avatar" :src="gitHubUser.avatar_url">
    <div class="login-name">{{gitHubUser.login}}</div>
    <div class="bio">{{gitHubUser.bio}}</div>
    <ul class="other-site">
      <li @click="openWeiBo"><img src="../assets/weibo.png"></li>
      <li @click="openGitHub"><img src="../assets/github.png"></li>
      <li @click="openGitBook"><img src="../assets/git.png"></li>
    </ul>
    <ul class="left-menu">
      <router-link :class="isBlog ? 'selected-menu':''" tag="li" to="/Blog">个人博客</router-link>
      <router-link :class="isAboutMe ? 'selected-menu':''" tag="li" to="/AboutMe">关于我</router-link>
    </ul>
  </div>
</template>
<style lang="scss" scoped>
  $indicator-color: #3593f2;

  .left-layout-container {
    position: fixed;
    left: 0px;
    top: 0px;
    bottom: 0px;
    width: 199px;
    background-color: #ffffff;
    border-right: 1px solid #eeeeee;
  }

  .avatar {
    width: 70px;
    height: 70px;
    border-radius: 35px;
    margin-top: 60px;
    margin-left: 65px;
    cursor: pointer;
  }

  .login-name {
    text-align: center;
    margin: 14px auto;
    font-size: 14px;
    color: #4b595f;
  }

  .bio {
    text-align: center;
    margin: 0px auto;
    font-size: 13px;
    color: #849aa4;
  }

  .other-site {
    list-style: none;
    margin-top: 20px;
    li {
      float: left;
      cursor: pointer;
      img {
        width: 20px;
        height: 20px;
      }
    }
    li:first-child {
      margin-right: 20px;
      margin-left: 50px;
    }
    li:last-child {
      margin-left: 20px;
    }
  }

  .left-menu {
    list-style: none;
    margin-top: 87px;
    color: #4b595f;
    li {
      width: 199px;
      height: 60px;
      line-height: 60px;
      cursor: pointer;
      font-size: 16px;
      &:before {
        width: 4px;
        height: 100%;
        content: '';
        margin-right: 46px;
        float: left;
        display: table;
      }
    }
    li:hover {
      &:before {
        background-color: $indicator-color;
      }
    }
    :first-child {
      margin-bottom: 30px;
    }
  }

  .selected-menu {
    background-color: #e5f1fc;
    color: $indicator-color;
    &:before {
      background-color: $indicator-color;
    }
  }
</style>
<script>
  import { mapGetters } from 'vuex'

  export default {
    computed: {
      ...mapGetters([
        'gitHubUser',
        'gitHubUsername',
        'weiBoUsername'
      ]),
      isBlog () {
        return this.$route.name && this.$route.name.startsWith('Blog')
      },
      isAboutMe () {
        return this.$route.name === 'AboutMe'
      }
    },
    methods: {
      home () {
        this.$router.push('/')
      },
      openGitHub () {
        window.open('https://github.com/' + this.gitHubUsername)
      },
      openWeiBo () {
        window.open('http://weibo.com/' + this.weiBoUsername)
      },
      openGitBook () {
        window.open('https://bingoogolapple.gitbooks.io/bgalearningnotes-git/content')
      }
    }
  }
</script>
