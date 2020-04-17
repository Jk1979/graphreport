Hello!
<p>This is an email for testing reports!</p>
@if (count($reportData) )
<table class="rwd-table">
    <tr>
      <th>Client</th>
      <th>Product</th>
      <th>Total</th>
      <th>Date</th>
    </tr>
   @foreach ($reportData as $dt)
    <tr>
      <td>{{ $dt->client }}</td>
      <td>{{ $dt->product }}</td>
      <td>{{ $dt->total }}</td>
      <td>{{ $dt->date }}</td>
    </tr>
  @endforeach
</table>
 
  <br/>
  <i>Kind regards</i>
@else    
    No data
@endif

