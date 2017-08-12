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
      <div v-if="accessToken" class="add-comment-container">
        <textarea rows="5" v-model="newComment" placeholder="说点什么？「支持 MarkDown 语法」"/>
        <div @click="addComment" class="width-match-parent-btn">评论</div>
      </div>
      <div v-else @click="login" class="width-match-parent-btn">使用 GitHub 登录</div>
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

  .width-match-parent-btn {
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

  .add-comment-container {
    display: flex;
    flex-direction: column;
    margin-top: 30px;
    textarea {
      border-radius: 3px;
      padding: 15px 30px 15px 15px;
      border: solid 1px #eeeeee;
      font-size: 14px;
      color: #4b595f;
      outline: none;
    }
  }
</style>
<script>
  import { mapActions, mapGetters } from 'vuex'
  import Comment from '../components/Comment.vue'

  export default{
    data () {
      return {
        issue: null,
        number: null,
        comments: [],
        newComment: null
      }
    },
    components: {Comment},
    computed: {
      ...mapGetters([
        'accessToken',
        'loginLink'
      ])
    },
    methods: {
      ...mapActions([
        'updateActiveLabel',
        'setAccessToken',
        'setTokenUser'
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
      login () {
        window.location.href = this.loginLink
      },
      fetchAccessToken () {
        const query = this.$queryParse()
        if (query.code) {
          const code = query.code
          delete query.code
          const replacedUrl = `${window.location.origin}${window.location.pathname}${this.$queryStringify(query)}${window.location.hash}`
          history.replaceState(null, null, replacedUrl)

          this.$gitHubApi.getAccessToken(this, code).then(response => {
            if (response.data && response.data.access_token) {
              this.setAccessToken(response.data.access_token)
            }
          })
        }
      },
      addComment () {
        if (this.issue && this.newComment && this.newComment.trim().length > 0) {
          this.$gitHubApi.addComment(this, this.issue.comments_url, this.newComment.trim()).then(response => {
            if (response.data && response.data) {
              this.comments.push(response.data)
              this.newComment = null
              this.$nextTick(() => {
                // 如果这里不加个 setTimeout 的话，Comment 数量太多时不会自动滚动到底部
                setTimeout(() => {
                  let commentContainer = this.$refs.commentContainer
                  commentContainer.scrollTop = commentContainer.scrollHeight - commentContainer.clientHeight
                }, 16)
              })
            }
          }).catch((error) => {
            if (error.response && error.response.status === 401) {
              this.setAccessToken(null)
            }
          })
        }
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
        this.fetchAccessToken()

        if (this.issue) {
          this.getComments()
        } else {
          this.getIssue()
        }
      })
    }
  }
</script>
