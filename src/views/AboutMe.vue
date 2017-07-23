<template>
  <div class="about-me bga-back-top">
    <article class="markdown-body" v-html="renderedMarkdown"/>
    <bga-back-top :svgMajorColor="'#7b79e5'" :svgMinorColor="'#ba6fda'" :svgType="'rocket_smoke'"/>
  </div>
</template>
<style lang="scss" scoped>
  .about-me {
    padding: 30px;
    overflow: scroll;
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
    mounted () {
      this.$nextTick(() => {
        this.getReadme()
      })
    }
  }
</script>
