<template>
  <el-card>
    <div slot="header">
      {{$moment(comment.created_at).format('YYYY-MM-DD HH:mm')}}
    </div>
    <div v-html="renderedMarkdown"></div>
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
      renderMarkdown: function () {
        this.renderedMarkdown = ''
        if (this.comment.body) {
          this.renderedMarkdown = this.$marked(this.comment.body)
        }
      }
    },
    mounted: function () {
      this.$nextTick(function () {
        this.renderMarkdown()
      })
    }
  }
</script>
