<template>
  <div id="toolbar">
    <i class="glyphicon logo"><img src="../assets/logo.png"></i>
    <i @click="openGithub"><img src="../assets/github.png"></i>
    <i @click="openWeibo"><img src="../assets/weibo.png"></i>
  </div>
</template>

<script>
  export default {
    methods: {
      openGithub: function () {
        window.open("https://github.com/bingoogolapple")
      },
      openWeibo: function () {
        window.open("http://weibo.com/bingoogol")
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
      margin-bottom: 35px;
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
