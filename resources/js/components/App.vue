<template>
<div class="container">
   <h1>Orders</h1>
  <div class="row">
    
    <div class="col-md-12">
      <form class="form-inline" v-on:submit.prevent="submitHandler(true)">
      <div class="form-group mb-2">
        <label for="query" class="sr-only">Query</label>
        <input class="form-control" v-model="query"  type="text" placeholder="Search" aria-label="Search">
      </div>
      <div class="form-group mx-sm-3 mb-2">
        
        <select class="form-control"  v-model="keyword">
          <option value="all" selected="selected">All</option>
          <option value="client">Client</option>
          <option value="product">Product</option>
          <option value="total">Total </option>
          <option value="date">Date</option>
        </select>
      </div>
      <button type="submit" class="btn btn-primary mb-2">Search</button>
    </form>
      
    <div v-for="checkbox in selected" :key="checkbox.name">
    <label><input type="checkbox" v-model="checkbox.checked" /> {{ checkbox.name }}</label>
    </div>
    <chart :selected="selected" :lineData="lineData"></chart>
    </div>
    <div v-if="showTable" class="col-md-12">
     <button class="btn btn-default" @click="prevPage">prev</button>
     <button class="btn btn-default" @click="nextPage">next</button>
     <p>
        <span>Page: </span>{{currentPage}}  <span>Total pages: </span>{{tableData.last_page}}  
        <span>Sort: </span>{{currentSort}}|{{currentSortDir}}
     </p>
      <table class="rwd-table">
        <tr>
          <th @click="sort('client')">Client</th>
          <th @click="sort('product')">Product</th>
          <th @click="sort('total')">Total</th>
          <th @click="sort('date')">Date</th>
          <th>Actions</th>
        </tr>
        <tr v-for="prod in tableData.data" :key="prod.id">
          <td data-th="Client">{{prod.client}}</td>
          <td data-th="Product">{{prod.product}}</td>
          <td data-th="Total">{{prod.total}}</td>
          <td data-th="Date">{{prod.date}}</td>
          <td data-th="Actions">
            <button class="btn btn-success" @click="showModalUpdate(prod.id)">Edit</button>
            <button class="btn btn-danger" @click="deleteHandler(prod.id)">Delete</button>
          </td>
        </tr>
      </table>
      <div><button class="btn btn-danger" @click="sendReport">Report</button></div>
    </div>
  </div>
  <modal :show="showModal" :objdata="editObject" @close="showModal = false" @savePost="updObject">
    
  </modal>
</div>

</template>
<script>
import Chart from './Chart'
import modal from './NewModal'
import _ from 'lodash'

export default {
  name: 'AppComponent',
  components: {
    'chart': Chart,
    modal
  },
  data: ()=>({
    selected: [{
      "name": "Acme",
      "checked": true
    }, {
      "name": "Microsoft",
      "checked": true
    }, {
      "name": "Apple",
      "checked": true
    }],
    labels: [],
    prevData: {},
    lineData: {},
    tableData: [],
    showTable: false,
    query:'',
    keyword: 'all',
    showModal: false,
    currentPage:1,
    currentSort:'client',
    currentSortDir:'asc',
    editObject:null,
    editId:null
     

  }),
  watch: {
    unSelected: function() {
        if(Object.keys(this.lineData).length !== 0 && this.unSelected.length === 1 && this.labels.length) {
          
          let newlabels = [];
          this.lineData.datasets.map(it => {
            if(it.label === this.unSelected[0].name) {
              newlabels = [...newlabels,...it.lbs];
              it.data = it.data.filter( dt => dt !== 0);
            }
          });
          this.lineData.labels = newlabels;
        } else {
          this.lineData.labels = this.labels;
          this.lineData = _.cloneDeep(this.prevData);
        }
    }
  },
  computed: {
    selChanged: function() {
      return  !this.selected.every(it => it.checked === true);
    },
    unSelected: function() {
      if(this.selChanged) {
        return  this.selected.filter(it => it.checked === true);
      }
      else return false;
    },

  },
  methods: {
    showModalUpdate(id){
      const prod = this.tableData.data.filter(el => el.id === id)[0];
      this.editId = id;
      this.editObject = {
        title: prod.product,
        total: prod.total,
        date: prod.date

      };
      this.showModal = true;
    },
    updObject:function(obj){
        // console.log(obj);
        obj = obj || {};
        axios.post('/updproduct',{
         _method: 'put',
        data: {
           id:this.editId,
           product: obj.title,
           total: obj.total,
           date: obj.date
         }
       }).then( res => {
          
          this.submitHandler();
       }).catch(err => {console.log(err) });
    },
    submitHandler(newQuery = false) {
      if(newQuery) this.currentPage = 1;
      this.showTable = false;
       axios.post('/chart-data',{
         query: this.query,
         keyword: this.keyword,
         sort: this.currentSort,
         sortdir: this.currentSortDir,
         page: this.currentPage
       }).then( res => {
        if(res.data) {
          let lineData = res.data.chartData;
          lineData.datasets.forEach(dataset => {
            dataset.data = Object.keys(dataset.data).map(function(key) {
                    return dataset.data[key];
            })
          });
          this.lineData = lineData;
          this.labels = lineData.labels;
          this.prevData = _.cloneDeep(lineData);
          this.tableData = res.data.tableData;
          if(Object.keys(this.tableData).length !== 0) this.showTable = true;
        }
       }).catch(err => {console.log(err) });
       
    },
    sendReport() {
       axios.post('/report',{
         query: this.query,
         keyword: this.keyword,
         sort: this.currentSort,
         sortdir: this.currentSortDir,
         page: this.currentPage
       }).then( res => {
             console.log(res);
       }).catch(err => {console.log(err) });
       
    },
    deleteHandler(id) {
     
      axios.post('/delproduct/'+id,{_method: 'delete'}).then( res => {
          this.submitHandler();
      });

    },
    
    sort:function(s) {
    //if s == current sort, reverse
    if(s === this.currentSort) {
      this.currentSortDir = this.currentSortDir==='asc'?'desc':'asc';
      
    }
    this.currentSort = s;
    this.currentPage = 1;
    this.submitHandler();
    },
    nextPage:function() {
        if(this.currentPage < this.tableData.last_page) this.currentPage++;
        this.submitHandler();
    },
    prevPage:function() {
        if(this.currentPage > 1) this.currentPage--;
        this.submitHandler();
    }
  },
  mounted() {
    axios.get('/test-data').then(res => {
      if(res.data) {
        let lineData = res.data.chartData;
        lineData.datasets.forEach(dataset => {
          dataset.data = Object.keys(dataset.data).map(function(key) {
                  return dataset.data[key];
          })
        });
        
        this.lineData = {...lineData};
        this.prevData = _.cloneDeep(lineData);
        this.labels = lineData.labels;
        this.tableData = res.data.tableData;
        if(Object.keys(this.tableData).length !== 0) this.showTable = true;
      }
      }).catch(err => {console.log(err) });
    
  },
  
}
</script>
<style>

</style>