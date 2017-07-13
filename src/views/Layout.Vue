<template>
  <div>
    <labels-list/>
    <router-view/>
  </div>
</template>
<style lang="scss" scoped>
</style>
<script>
  import LabelsList from '../components/LabelsList.vue'

  export default {
    components: {
      LabelsList
    }
  }
</script>
