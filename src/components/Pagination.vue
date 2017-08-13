<template>
  <div class="paginataion-container">
    <span class="total-num">共&nbsp;{{totalNum}}&nbsp;条</span>
    <img :class="lastCurrentPage === 1 ? 'pre-page-disabled' : 'pre-page'" @click="selectPage(parseInt(page) - 1)"/>
    <input ref="currentPageInput" type="number" class="current-page" v-model="page"
           @keyup.enter="handleCurrentPageChanged()"/>
    <span class="page-count">/&nbsp;&nbsp;&nbsp;{{pageCount}}</span>
    <img :class="lastCurrentPage === pageCount ? 'next-page-disabled' : 'next-page'"
         @click="selectPage(parseInt(page) + 1)"/>
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
      flex: 0 0 38px;
      height: 38px;
    }
  }

  .total-num {
    font-size: 14px;
    color: #4b595f;
  }

  @mixin page-arrow($prefix) {
    content: url("../assets/#{$prefix}-page-normal.png");
    &:hover {
      content: url("../assets/#{$prefix}-page-hover.png");
    }

    // Firefox content base64 仅支持 after
    &::after {
      content: url("../assets/#{$prefix}-page-normal.png");
    }
    &:hover {
      &::after {
        content: url("../assets/#{$prefix}-page-hover.png");
      }
    }
  }

  @mixin page-arrow-disabled($prefix) {
    content: url("../assets/#{$prefix}-page-normal.png");

    // Firefox content base64 仅支持 after
    &::after {
      content: url("../assets/#{$prefix}-page-normal.png");
    }
  }

  .pre-page {
    @include page-arrow('pre');
  }

  .pre-page-disabled {
    @include page-arrow-disabled('pre');
  }

  .next-page {
    @include page-arrow('next');
  }

  .next-page-disabled {
    @include page-arrow-disabled('next');
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
    font-size: 14px;
    color: #4b595f;
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
        type: [Number],
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
      }
    },
    mounted () {
      this.$nextTick(() => {
        this.lastCurrentPage = this.currentPage
        this.page = this.currentPage
      })
    }
  }
</script>
