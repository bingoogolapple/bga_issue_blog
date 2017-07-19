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
    <div v-if="showQQGroup" class="qq-group">
      <span>BGA 系列</span>
      <span>开源库 QQ 群</span>
      <img src="../assets/qq-group.png">
    </div>
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
    overflow: scroll;
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
    margin-bottom: 12px;
    font-size: 14px;
    height: 16px;
    line-height: 16px;
    color: #4b595f;
  }

  .bio {
    text-align: center;
    margin: 0px auto;
    font-size: 13px;
    height: 18px;
    line-height: 18px;
    color: #849aa4;
  }

  .other-site {
    list-style: none;
    margin-top: 20px;
    margin-bottom: 87px;
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
    // 上面总的高度为 280px，下面 QQ 群的 margin + 高度为 260px，自身 margin-bottom 为 50px
    height: calc(100% - 280px - 260px - 50px);
    margin-bottom: 50px;
    min-height: 150px;
    list-style: none;
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
      &:hover {
        &:before {
          background-color: $indicator-color;
        }
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

  .qq-group {
    margin-top: 60px;
    margin-left: 55px;
    margin-bottom: 60px;
    height: 140px;
    width: 90px;
    span {
      display: block;
      width: 100%;
      height: 15px;
      line-height: 15px;
      font-size: 12px;
      text-align: center;
      color: #849aa4;
      margin-bottom: 10px;
    }
    span:first-child {
      color: #4b595f;
    }
    img {
      width: 90px;
      height: 90px;
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
        'weiBoUsername',
        'showQQGroup'
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
