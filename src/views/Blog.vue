<template>
  <div class="blog-container">
    <labels-list/>
    <router-view/>
  </div>
</template>
<style lang="scss" scoped>
  .blog-container {
    width: calc(100% - 200px); // 兼容 IE 10
    flex-grow: 1;
    display: flex;
    flex-direction: column;
  }
</style>
<script>
  import LabelsList from '../components/LabelsList.vue'

  export default {
    components: {
      LabelsList
    }
  }
</script>
