<template>
  <div class="app">
    <left-layout class="left-container"/>
    <router-view/>
  </div>
</template>
<style lang="scss" scoped>
  .app {
    display: flex;
    height: 100%;
    overflow: hidden;
  }

  .left-container {
    flex: 0 0 199px;
    border-right: 1px solid #eeeeee;
  }
</style>
<script>
  import LeftLayout from './components/LeftLayout.vue'
  import { mapActions } from 'vuex'

  export default {
    components: {
      LeftLayout
    },
    methods: {
      ...mapActions([
        'setLabels',
        'setGitHubUser'
      ])
    },
    mounted () {
      this.$nextTick(function () {
        this.$gitHubApi.getUserInfo(this).then(this.$http.spread((userResp, labelResp) => {
          this.setGitHubUser(userResp.data)
          this.setLabels(labelResp.data)
        }))
      })
    }
  }
</script>
