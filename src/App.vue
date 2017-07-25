<template>
  <div class="app">
    <left-layout class="left-container"/>
    <router-view class="main-container"/>
    <bga-back-top :svgMajorColor="'#7b79e5'" :svgMinorColor="'#ba6fda'" :svgType="'rocket_smoke'"/>
  </div>
</template>
<style lang="scss" scoped>
  .app {
    display: flex;
    height: 100%;
  }

  .left-container {
    flex: 0 0 199px;
    border-right: 1px solid #eeeeee;
    height: 100%;
  }

  .main-container {
    width: 100%;
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
