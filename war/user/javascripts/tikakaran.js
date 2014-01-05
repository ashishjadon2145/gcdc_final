  $(window).load(function() {
    $('#slider').orbit({
    	animation:'horizontal-push',
    	 	});
  });
  
  $(document).ready(function({
	  
	  
	  count  = 1;
  function addMoreChild(){
	  
	  
	  
	  $('#addMoreButton').remove();
	  $('#children').append('
			  <div class="four columns ">
			<div class="four columns">
			<input type="text" class="input-text six " id="ddob'+count+'"placeholder="Date"/>
				</div>
				<div class="four columns pull-two">
			<input type="text" class="input-text seven" id="mdob" placeholder="Month"/>
			</div>
			<div class="four columns pull-three">
			<input type="text" class="input-text six" id="ydob" placeholder="Year"/>
			</div>
		</div>
	  
	  '); 
  }
  
  
  }));