// Generated by CoffeeScript 1.7.1
(function() {
  var rtrace;

  rtrace = window.rtrace;

  $(function() {
    return $('#myForm input').on('change', function() {
      var filename;
      filename = $('input[name="myRadio"]:checked', '#myForm').val();
      return rtrace.raytrace_01("scenes/01_raytrace/" + filename);
    });
  });

}).call(this);

//# sourceMappingURL=scene_choice.map
