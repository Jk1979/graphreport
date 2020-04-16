<template>
<div class="container">
   <h1>Orders</h1>
  <div class="row">
    
    <div class="col-md-12">
      <form class="form-inline" v-on:submit.prevent="submitHandler">
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
     
      <table class="rwd-table">
        <tr>
          <th>Client</th>
          <th>Product</th>
          <th>Total</th>
          <th>Date</th>
          <th>Actions</th>
        </tr>
        <tr v-for="prod in tableData.data" :key="prod.id">
          <td data-th="Client">{{prod.client}}</td>
          <td data-th="Product">{{prod.product}}</td>
          <td data-th="Total">{{prod.total}}</td>
          <td data-th="Date">{{prod.date}}</td>
          <td data-th="Actions">
            <button class="btn btn-success">Edit</button>
            <button class="btn btn-danger">Delete</button>
          </td>
        </tr>
      </table>
    </div>
  </div>
</div>

</template>
<script>
import Chart from './Chart'
import _ from 'lodash'

export default {
  name: 'AppComponent',
  components: {
    'chart': Chart
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
    
    currentSort:'product',
    currentSortDir:'asc' 

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
    submitHandler() {
      this.showTable = false;
       axios.post('/test-data',{
         query: this.query,
         keyword: this.keyword
       }).then( res => {
        console.log(res.data);
        let lineData = res.data.chartData;
        lineData.datasets.forEach(dataset => {
          dataset.data = Object.keys(dataset.data).map(function(key) {
                  return dataset.data[key];
          })
        });
        this.labels = lineData.labels;
        this.prevData = lineData;
        this.lineData = lineData;
        this.tableData = res.data.tableData;
        if(Object.keys(this.tableData).length !== 0) this.showTable = true;
       });
       
    },
    submitHandler2() {
      this.showTable = false;
       axios.post('/chart-data',{
         query: this.query,
         keyword: this.keyword
       }).then( res => {
        console.log(res.data);
        let lineData = res.data;
        lineData.datasets.forEach(dataset => {
          dataset.data = Object.keys(dataset.data).map(function(key) {
                  return dataset.data[key];
          })
        });
        this.lineData = lineData;
        this.showTable = true;
       });
       
    }
  },
  mounted() {
    axios.get('/test-data?page=4').then(res => {
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
      console.log(this.lineData);
      console.log(this.tableData);
      if(Object.keys(this.tableData).length !== 0) this.showTable = true;
      })
    
  }
}
</script>
<style>

</style>