<template>
  <div id="toolbar">
    <i class="glyphicon logo"><img src="../assets/logo.png" width="30" height="30"></i>
    <i>B</i>
    <i>G</i>
    <i>A</i>
    <i>&nbsp;</i>
    <i>&nbsp;</i>
    <i>&nbsp;</i>
    <i>B</i>
    <i>L</i>
    <i>O</i>
    <i>G</i>
  </div>
</template>

<script>
</script>

<style lang="scss" scoped>
  #toolbar{
    float: left;
    width: 80px;
    height: 100%;
    background-color: #343f4b;
    color: #748392;
    padding: 35px 25px 25px 25px;
    .starred {
      color: #F7AE4F;
    }
    i{
      font-size: 30px;
      margin-bottom: 35px;
      opacity: 0.8;
      transition: opacity 0.5s ease;
      &:hover{
        opacity: 1;
      }
    }
  }
</style>
