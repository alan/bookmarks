$(document).ready(function() {
	$('#suggestions-for').keyup(function(){
		if($(this).val()==""){
					$('#suggestions').html("")
				}else{
					$.getJSON('/searches/suggest?query=' + $(this).val(), function(data) {
						$('#suggestions').html("")
						$.each(data, function(i, url){
							$('#suggestions').append('<a href=\'/bookmarks/'+ url[1] + '\'>'+ url[0] +'</a>' + '<br/>')
						});
					});
				}
		
	});
})
