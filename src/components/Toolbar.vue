<template>
  <div id="toolbar">
    <i class="glyphicon logo"><img src="../assets/logo.png" width="30" height="30"></i>
    <i @click="openGithub"><img src="../assets/github.png" width="30" height="30"></i>
    <i @click="openWeibo"><img src="../assets/weibo.png" width="30" height="30"></i>
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
    float: left;
    width: 80px;
    height: 100%;
    background-color: #343f4b;
    color: #748392;
    padding: 35px 25px 25px 25px;
    .starred {
      color: #F7AE4F;
    }
    i {
      font-size: 30px;
      margin-bottom: 35px;
      opacity: 0.8;
      cursor: pointer;
      transition: opacity 0.5s ease;
      &:hover {
        opacity: 1;
      }
    }
  }
</style>
