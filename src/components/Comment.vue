<template>
  <el-card>
    <div slot="header">
      {{$moment(comment.created_at).format('YYYY-MM-DD HH:mm')}}
    </div>
    <article class="markdown-body" v-html="renderedMarkdown"/>
  </el-card>
</template>

<script>
  export default {
    data: function () {
      return {
        renderedMarkdown: ''
      }
    },
    props: ['comment'],
    methods: {
      renderMarkdown () {
        this.renderedMarkdown = ''
        if (this.comment.body) {
          this.renderedMarkdown = this.$marked(this.comment.body)
        }
      },
      test () {
        this.$gitHubApi.test(this).then(response => {
          console.error(response.data)
        })
      }
    },
    mounted: function () {
      this.$nextTick(function () {
        this.renderMarkdown()
      })
    }
  }
</script>
