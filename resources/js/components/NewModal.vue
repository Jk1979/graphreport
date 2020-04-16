<template>
<div>
  <modal :show="show" @close="close">
        <div class="modal-header">
            <h3>Edit product</h3>
        </div>
        <div class="modal-body">
            <label class="form-label">
                Title
                <input v-model="title" class="form-control">
            </label>
            <label class="form-label">
                Total
                <input v-model="total" class="form-control">
            </label>
            <label class="form-label">
                Date
                <input v-model="date" class="form-control">
            </label>
            
        </div>
        <div class="modal-footer text-right">
            <button class="modal-default-button" @click="savePost()">
                Save
            </button>
        </div>
    </modal>
</div>
</template>
<script>
  import modal from './Modal'
  export default {
      name:'NewModal',
      props: ['show','objdata'],
      components: { modal },
      data: function () {
        return {
          title: '',
          total: '',
          date: ''
        };
      },
      watch: {
         objdata: function() {
           if(Object.keys(this.objdata).length !== 0) {
            
             this.title = this.objdata.title;
             this.total = this.objdata.total;
             this.date = this.objdata.date;
           
          } 
         }
      },

      methods: {
      close: function () {
        this.$emit('close');
        this.title = '';
        this.total = '';
        this.date = '';
      },
      savePost: function () {
        // console.log(this.title,this.total);
        this.$emit('savePost',{
          title: this.title,
          total: this.total,
          date:  this.date
        });
        
        this.close();
      }
    }
  }
</script>