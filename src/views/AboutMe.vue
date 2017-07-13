<template>
  <el-card class="about-me">
    <div v-html="renderedMarkdown"/>
  </el-card>
</template>
<style lang="scss" scoped>
  .about-me {
    position: fixed;
    left: 0px;
    top: 50px;
    right: 0px;
    bottom: 0px;
    overflow: scroll;
    border-radius: 0px;
  }
</style>
<script>
  export default {
    data () {
      return {
        renderedMarkdown: ''
      }
    },
    methods: {
      getReadme () {
        this.$gitHubApi.getReadme(this).then(response => {
          if (response.data) {
            this.renderedMarkdown = this.$marked(response.data)
          }
        })
      }
    },
    mounted: function () {
      this.$nextTick(function () {
        this.getReadme()
      })
    }
  }
</script>
