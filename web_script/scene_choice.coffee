rtrace = window.rtrace

$ ->
  $('#myForm input').on 'change', ->
    filename = $('input[name="myRadio"]:checked', '#myForm').val()
    rtrace.raytrace_01("scenes/01_raytrace/"+filename)