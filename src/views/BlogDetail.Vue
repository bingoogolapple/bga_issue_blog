<template>
  <div v-if="issue" class="blog-detail-container">
    <div class="title-container">
      <span class="title">{{issue.title}}</span>
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
    <div class="comment-container bga-back-top" ref="commentContainer">
      <comment :comment="issue"/>
      <comment v-for="comment in comments" :key="comment.id" :comment="comment"/>
      <add-comment :commentsUrl="issue.comments_url" @addCommentSuccess="handleAddCommentSuccess"/>
    </div>
  </div>
</template>
<style lang="scss" scoped>
  .blog-detail-container {
    flex-grow: 1;
    display: flex;
    overflow-y: auto; // 本来只在 comment-container 上添加 overflow-y: auto 就可以的，在 blog-detail-container 里也添加 overflow-y: auto 是为了兼容 Firefox 和 Android
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
      white-space: nowrap;
      overflow: hidden;
      text-overflow: ellipsis;
    }
    ul {
      list-style: none;
      display: flex;
      flex: 1 0 auto;
      margin: 0 30px;
    }
    .back {
      flex: 0 0 65px;
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
    overflow-y: auto;
    padding: 0px 50px;
  }
</style>
<script>
  import { mapActions } from 'vuex'
  import Comment from '../components/Comment.vue'
  import AddComment from '../components/AddComment.vue'

  export default{
    data () {
      return {
        issue: null,
        number: null,
        comments: [],
        newComment: null
      }
    },
    components: {Comment, AddComment},
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
      handleAddCommentSuccess (comment) {
        this.comments.push(comment)
        this.$nextTick(() => {
          // 如果这里不加个 setTimeout 的话，Comment 数量太多时不会自动滚动到底部
          setTimeout(() => {
            let commentContainer = this.$refs.commentContainer
            commentContainer.scrollTop = commentContainer.scrollHeight - commentContainer.clientHeight
          }, 16)
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
