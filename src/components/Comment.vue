<template>
  <div class="panel panel-default">
    <div class="panel-body" v-html="renderedMarkdown"></div>
  </div>
</template>

<script>
  import { mapGetters } from 'vuex'

  export default {
    data: function () {
      return {
        renderedMarkdown: ''
      }
    },
    props: ['comment'],
    watch: {
      comment: function (comment) {
        this.fetchMarkdown()
      }
    },
    computed: {
      ...mapGetters([
        'gitHubUsername'
      ])
    },
    methods: {
      fetchMarkdown: function () {
        this.renderedMarkdown = ''
        if (this.comment.body) {
          this.$http.post('https://api.github.com/markdown', {
            'text': this.comment.body,
            'mode': 'gfm',
            'context': this.gitHubUsername + '/' + this.gitHubUsername + '.github.io'
          }).then(response => {
            console.log('renderedMarkdown', response.data)
            this.renderedMarkdown = response.data
          }).catch(response => {
            console.log(response.data)
          })
        }
      }
    },
    mounted: function () {
      this.$nextTick(function () {
        this.fetchMarkdown()
      })
    }
  }
</script>
