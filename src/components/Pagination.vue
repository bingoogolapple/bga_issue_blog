<template>
  <div class="paginataion-container">
    <span class="total-num">共&nbsp;{{totalNum}}&nbsp;条</span>
    <img :class="lastCurrentPage === 1 ? 'pre-page-disabled' : 'pre-page'" @click="selectPage(parseInt(page) - 1)"/>
    <input ref="currentPageInput" type="number" class="current-page" v-model="page"
           @keyup.enter="handleCurrentPageChanged()"/>
    <span class="page-count">/&nbsp;&nbsp;&nbsp;{{pageCount}}</span>
    <img :class="lastCurrentPage === pageCount ? 'next-page-disabled' : 'next-page'" @click="selectPage(parseInt(page) + 1)"/>
  </div>
</template>
<style lang="scss" scoped>
  .paginataion-container {
    display: flex;
    justify-content: space-around;
    align-items: center;
    width: 300px;
    height: 38px;
    img {
      width: 38px;
      height: 38px;
    }
  }

  .total-num {
    height: 20px;
    line-height: 20px;
    font-size: 14px;
    color: #4b595f;
  }

  .pre-page {
    content: url("../assets/pre-page-normal.png");
    &:hover {
      content: url("../assets/pre-page-hover.png");
    }
  }

  .pre-page-disabled {
    content: url("../assets/pre-page-normal.png");
  }

  .current-page {
    width: 48px;
    height: 24px;
    line-height: 24px;
    border: solid 1px #ebeef0;
    font-size: 14px;
    text-align: center;
    color: #03a9f4;
    outline: none;
  }

  .page-count {
    height: 16px;
    line-height: 16px;
    font-size: 14px;
    color: #4b595f;
  }

  .next-page {
    content: url("../assets/next-page-normal.png");
    &:hover {
      content: url("../assets/next-page-hover.png");
    }
  }

  .next-page-disabled {
    content: url("../assets/next-page-normal.png");
  }
</style>
<script>
  export default {
    props: {
      totalNum: {
        type: Number,
        required: false,
        default: 0,
        validator (val) {
          return val >= 0
        }
      },
      currentPage: {
        type: Number,
        required: false,
        default: 1
      },
      pageSize: {
        type: [Number, String],
        required: false,
        default: 10,
        validator (val) {
          return val >= 5
        }
      }
    },
    data () {
      return {
        lastCurrentPage: 1,
        page: 1
      }
    },
    computed: {
      pageCount () {
        if (this.totalNum === 0) {
          return 1
        }
        return parseInt((this.totalNum - 1) / this.pageSize) + 1
      }
    },
    methods: {
      selectPage (newCurrentPage) {
        this.page = newCurrentPage
        this.handleCurrentPageChanged()
      },
      handleCurrentPageChanged () {
        let newCurrentPage = parseInt(this.page)
        if (newCurrentPage <= 0) {
          this.page = newCurrentPage = 1
        }
        if (newCurrentPage > this.pageCount) {
          this.page = newCurrentPage = this.pageCount
        }
        if (newCurrentPage !== this.lastCurrentPage) {
          this.lastCurrentPage = newCurrentPage
          this.$emit('currentPageChanged', parseInt(newCurrentPage))
        }
      }
    },
    watch: {
      currentPage (val) {
        this.lastCurrentPage = this.currentPage
        this.page = this.currentPage
        console.log('currentPage changed')
      }
    },
    mounted: function () {
      this.$nextTick(function () {
        this.lastCurrentPage = this.currentPage
        this.page = this.currentPage
      })
    }
  }
</script>
