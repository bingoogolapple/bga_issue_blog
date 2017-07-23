<template>
  <div class="blog-container">
    <labels-list/>
    <router-view/>
  </div>
</template>
<style lang="scss" scoped>
  .blog-container {
    display: flex;
    flex-direction: column;
    height: 100%;
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
