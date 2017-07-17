<template>
  <el-card class="blog-detail-container" v-if="issue">
    <div slot="header">
      <span class="mr20">{{issue.title.trim()}}</span>
      <span class="m5 tag" v-for="tag in issue.labels" @click="setActiveLabel(tag)">
          <el-tag :color="'#' + tag.color">{{tag.name}}</el-tag>
      </span>
    </div>
    <div>
      <comment :comment="issue"/>
      <comment class="mt20" v-for="comment in comments" :comment="comment"/>
    </div>
  </el-card>
</template>
<style lang="scss" scoped>
  .blog-detail-container {
    overflow: scroll;
    border-radius: 0px;
    height: 100%;
  }
</style>
<script>
  import { mapActions } from 'vuex'
  import Comment from '../components/Comment.vue'

  export default{
    data () {
      return {
        issue: null,
        number: null,
        comments: []
      }
    },
    components: {Comment},
    methods: {
      ...mapActions([
        'updateActiveLabel'
      ]),
      setActiveLabel (label) {
        this.updateActiveLabel(label)
        this.$router.push('/')
      },
      getComments () {
        if (this.issue && this.issue.comments > 0) {
          this.$gitHubApi.getComments(this, this.issue.comments_url).then(response => {
            this.comments = response.data
          })
        }
      },
      getIssue () {
        this.$gitHubApi.getIssue(this, this.number).then(response => {
          this.issue = response.data
          this.getComments()
        })
      }
    },
    created () {
      if (this.$route.params.issue) {
        this.issue = this.$route.params.issue
      } else {
        if (this.$route.params.number) {
          this.number = this.$route.params.number
        } else {
          this.$router.replace('/')
        }
      }
    },
    mounted: function () {
      this.$nextTick(function () {
        if (this.issue) {
          this.getComments()
        } else {
          this.getIssue()
        }
      })
    }
  }
</script>
