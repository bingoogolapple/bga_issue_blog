<template>
  <!-- 最外层套一层 div 避免 gitHubUser 还未加载完时，右侧占满整个浏览器 -->
  <div>
    <div class="left-layout-container" v-if="gitHubUser">
      <img @click="home" class="avatar" :src="gitHubUser.avatar_url">
      <div class="login-name">{{gitHubUser.login}}</div>
      <div class="bio">{{gitHubUser.bio}}</div>
      <ul class="other-site">
        <li v-for="site in thirdPartySite" :key="site.url" @click="openThirdPartySite(site.url)">
          <img :src="site.img">
        </li>
      </ul>
      <ul class="left-menu">
        <router-link :class="isBlog ? 'selected-menu':''" tag="li" to="/Blog">个人博客</router-link>
        <router-link :class="isAboutMe ? 'selected-menu':''" tag="li" to="/AboutMe">关于我</router-link>
      </ul>
      <div v-if="showQQGroup" class="qq-group">
        <span>BGA 系列</span>
        <span>开源库 QQ 群</span>
        <img src="/static/img/qq-group.png">
      </div>
    </div>
  </div>
</template>
<style lang="scss" scoped>
  $indicator-color: #3593f2;

  .left-layout-container {
    display: flex;
    flex-direction: column;
    height: 100%;
    overflow: scroll;
  }

  .avatar {
    width: 70px;
    height: 70px;
    border-radius: 35px;
    margin-top: 50px;
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
    margin-bottom: 67px;
    height: 20px;
    display: flex;
    justify-content: center;
    li {
      cursor: pointer;
      margin-right: 20px;
      img {
        width: 20px;
        height: 20px;
      }
    }
    li:last-child {
      margin-right: 0px;
    }
  }

  .left-menu {
    flex-grow: 1;
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
    margin-top: 50px;
    margin-left: 55px;
    margin-bottom: 50px;
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
        'showQQGroup',
        'thirdPartySite'
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
      openThirdPartySite (url) {
        window.open(url)
      }
    }
  }
</script>
