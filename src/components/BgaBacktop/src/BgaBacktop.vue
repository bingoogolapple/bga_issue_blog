<template>
  <img :style="style" v-show="show" @click="startScrollToTop" :src="icon"/>
</template>
<style lang="scss" scoped>
</style>
<script>
  import Vue from 'vue'

  export default {
    props: {
      threshold: {
        type: Number,
        required: false,
        default: 150,
        validator (val) {
          return val >= 100
        }
      },
      animationTime: {
        type: Number,
        required: false,
        default: 150,
        validator (val) {
          return val >= 100 && val <= 200
        }
      },
      icon: {
        type: String,
        required: false,
        default: '/static/img/bga-backtop.png'
      },
      right: {
        type: Number,
        required: false,
        default: 30
      },
      bottom: {
        type: Number,
        required: false,
        default: 60
      },
      width: {
        type: Number,
        required: false,
        default: 40
      },
      height: {
        type: Number,
        required: false,
        default: 40
      }
    },
    data () {
      return {
        show: false,
        intervalTime: 20,
        scrollableElement: null,
        scrollToTopTimer: Number.MIN_VALUE,
        addScrollListenerTimeout: Number.MIN_VALUE,
        addScrollListenerTimeoutCount: 0,
        style: {
          width: this.width + 'px',
          height: this.height + 'px',
          bottom: this.bottom + 'px',
          right: this.right + 'px',
          position: 'fixed',
          cursor: 'pointer',
          'z-index': 999
        }
      }
    },
    watch: {
      $route (val) {
        setTimeout(this.addScrollListener, 200)
      }
    },
    methods: {
      clearTimer () {
        if (this.scrollToTopTimer !== Number.MIN_VALUE) {
          clearInterval(this.scrollToTopTimer)
          this.scrollToTopTimer = Number.MIN_VALUE
        }
        if (this.addScrollListenerTimeout !== Number.MIN_VALUE) {
          clearTimeout(this.addScrollListenerTimeout)
          this.addScrollListenerTimeout = Number.MIN_VALUE
        }
      },
      removeScrollListener () {
        this.show = false
        this.clearTimer()
        if (this.scrollableElement) {
          this.scrollableElement.removeEventListener('scroll', this.handleScrolling)
          this.scrollableElement = null
        }
      },
      addScrollListener () {
        this.removeScrollListener()
        this.scrollableElement = document.getElementsByClassName('bga-backtop')[0]
        if (this.scrollableElement) {
          this.scrollableElement.addEventListener('scroll', this.handleScrolling)
        } else if (this.addScrollListenerTimeoutCount < 6) {
          // 可能是在可滚动节点上用了 v-if 来判断某个对象（可能生产这个对象时需要从网络加载数据，会要好几秒的时间）是否为空导致获取不到该节点
          // 这里每 1.5 秒获取一次可滚动节点，一共 6 次，如果 6 次后还是获取不到可滚动节点的话就不会再获取了，触发路由发生变化
          this.addScrollListenerTimeout = setTimeout(this.addScrollListener, 1500)
          this.addScrollListenerTimeoutCount++
        }
      },
      handleScrolling (e) {
        if (e.target.scrollTop > this.threshold) {
          this.show = true
        } else {
          this.show = false
        }
      },
      startScrollToTop () {
        if (this.scrollableElement) {
          let scrollTop = this.scrollableElement.scrollTop
          let speed = this.intervalTime / this.animationTime
          this.scrollToTopTimer = setInterval(() => {
            if (this.scrollableElement) {
              scrollTop -= scrollTop * speed
              if (scrollTop <= 1) {
                scrollTop = 0
                this.clearTimer()
              }
              this.scrollableElement.scrollTop = scrollTop
            } else {
              this.clearTimer()
            }
          }, this.intervalTime)
        }
      }
    },
    created () {
      Vue.prototype.$bagBacktopInstance = this
    },
    destroyed () {
      Vue.prototype.$bagBacktopInstance = null
    },
    beforeDestroy () {
      this.removeScrollListener()
    }
  }
</script>
