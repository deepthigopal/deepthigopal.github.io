$('.publication-arxiv').each(function() {
  var link = $(this).html();
  $(this).contents().wrap('<a href="https://arxiv.org/abs/'+link+'"></a>');
});

$('.publication-doi').each(function() {
  var link = $(this).html();
  $(this).contents().wrap('<a href="https://doi.org/'+link+'"></a>');
});
