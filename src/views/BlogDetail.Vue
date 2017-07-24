<template>
  <div v-if="issue" class="blog-detail-container">
    <div class="title-container">
      <span class="title">{{issue.title.trim()}}</span>
      <ul>
        <li class="tag tag-small" v-for="label in issue.labels" :key="label.id" @click="setActiveLabel(label)"
            :style="{ backgroundColor: '#' + label.color}">{{label.name}}
        </li>
      </ul>
      <span class="back" @click="back">
        <img src="../assets/back-icon.svg"
             class="back-icon">返回
      </span>
    </div>
    <div class="comment-container bga-back-top">
      <comment :comment="issue"/>
      <comment v-for="comment in comments" :key="comment.id" :comment="comment"/>
      <div @click="remark" class="remark">评论</div>
    </div>
  </div>
</template>
<style lang="scss" scoped>
  .blog-detail-container {
    flex-grow: 1;
    display: flex;
    overflow: scroll; // 本来只在 comment-container 上添加 overflow: scroll 就可以的，在 blog-detail-container 里也添加 overflow: scroll 是为了兼容 Firefox 和 Android
    flex-direction: column;
  }

  .title-container {
    flex: 0 0 48px;
    display: flex;
    align-items: center;
    background-color: #f9fafc;
    padding: 0px 50px;
    border-top: 1px solid #eeeeee;
    border-bottom: 1px solid #eeeeee;
    .title {
      font-size: 22px;
      color: #4b595f;
      margin-right: 30px;
    }
    ul {
      display: flex;
      flex-grow: 1;
    }
    .back {
      font-size: 14px;
      color: #4b595f;
      margin-right: 30px;
      cursor: pointer;
      img {
        display: inline-block;
        margin-right: 10px;
        width: 18px;
        height: 12px;
        object-fit: contain;
      }
    }
  }

  .comment-container {
    flex-grow: 1;
    overflow: scroll;
    padding: 0px 50px;
  }

  .remark {
    cursor: pointer;
    user-select: none;
    margin: 30px 0px;
    height: 50px;
    line-height: 50px;
    text-align: center;
    border-radius: 4px;
    font-size: 16px;
    background-color: #eff7ff;
    color: #3593f2;
    &:hover {
      background-color: #3593f2;
      color: #ffffff;
    }
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
      },
      back () {
        this.$router.go(-1)
      },
      remark () {
        window.open(this.issue.html_url)
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
    mounted () {
      this.$nextTick(() => {
        if (this.issue) {
          this.getComments()
        } else {
          this.getIssue()
        }
      })
    }
  }
</script>
