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
          <option selected>All</option>
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
          <th>Movie Title</th>
          <th>Genre</th>
          <th>Year</th>
          <th>Gross</th>
        </tr>
        <tr>
          <td data-th="Movie Title">Star Wars</td>
          <td data-th="Genre">Adventure, Sci-fi</td>
          <td data-th="Year">1977</td>
          <td data-th="Gross">$460,935,665</td>
        </tr>
        <tr>
          <td data-th="Movie Title">Howard The Duck</td>
          <td data-th="Genre">"Comedy"</td>
          <td data-th="Year">1986</td>
          <td data-th="Gross">$16,295,774</td>
        </tr>
        <tr>
          <td data-th="Movie Title">American Graffiti</td>
          <td data-th="Genre">Comedy, Drama</td>
          <td data-th="Year">1973</td>
          <td data-th="Gross">$115,000,000</td>
        </tr>
      </table>
    </div>
  </div>
</div>

</template>
<script>
import Chart from './Chart'
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
    lineData: {},
    showTable: false,
    query:'',
    keyword:'' 

  }),
  methods: {
    submitHandler() {
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
    axios.get('/chart-data').then(res => {
      let lineData = res.data;
      lineData.datasets.forEach(dataset => {
        dataset.data = Object.keys(dataset.data).map(function(key) {
                return dataset.data[key];
        })
      });
      this.lineData = lineData;
      console.log(this.lineData);
      this.showTable = true;
      })
    
  }
}
</script>
<style>

</style>