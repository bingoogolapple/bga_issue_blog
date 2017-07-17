<template>
  <div class="blog-container">
    <labels-list/>
    <router-view class="cl"/>
  </div>
</template>
<style lang="scss" scoped>
  .blog-container {
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
