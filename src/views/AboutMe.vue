<template>
  <div class="about-me">
    <article class="markdown-body" v-html="renderedMarkdown"/>
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
    mounted: function () {
      this.$nextTick(function () {
        this.getReadme()
      })
    }
  }
</script>
