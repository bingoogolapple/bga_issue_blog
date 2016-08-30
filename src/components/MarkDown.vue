<template>
  <div class="panel panel-default">
    <div class="panel-body">
      {{{renderedMarkdown}}}
    </div>
  </div>
</template>

<script>
  export default {
    data: function () {
      return {
        renderedMarkdown: ''
      }
    },
    props: ['comment'],
    watch: {
      comment: function (comment) {
        if (comment.body) {
          this.$http.post('https://api.github.com/markdown', {
            "text": comment.body,
            "mode": "gfm",
            "context": "bingoogolapple/bingoogolapple.github.io"
          }).then(function (response) {
            this.renderedMarkdown = response.data
          }, function (response) {
            console.log(response.data)
          })
        } else {
          this.renderedMarkdown = ''
        }
      }
    }
  }
</script>

<style scoped>

</style>
