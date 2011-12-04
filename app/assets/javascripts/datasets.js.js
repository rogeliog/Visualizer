(function() {
  var Dataset;
  Dataset = (function() {
    function Dataset(id, name, path, container) {
      this.id = id;
      this.processing = false;
      this.link = $("<a></a>");
      this.link.attr("href", path);
      this.link.append(name);
      container.append($("<li></li>").append(this.link));
      this.link.click(this.onclick);
    }
    Dataset.prototype.startProcessingCheck = function(ajaxy_indicator) {
      var spinner, stillProcessing, url;
      url = '/datasets/' + this.id + '/processing_status';
      spinner = $("<img src=\"/assets/ajax-loader-small.gif\" />");
      this.link.append(spinner);
      this.processing = true;
      stillProcessing = function() {
        return $.get(url, function(data) {
          if (data.processing === 't') {
            return setTimeout(stillProcessing, 1000);
          } else {
            spinner.remove();
            return this.processing = false;
          }
        });
      };
      return stillProcessing();
    };
    Dataset.prototype.onclick = function(e) {
      if (this.processing === 't') {
        return e.preventDefault();
      }
    };
    return Dataset;
  })();
  window.Dataset = Dataset;
  $(function() {
    var append_dataset_column, generate_x_match_form, select_x_matches;
    generate_x_match_form = function(column_names, id) {
      $("#config #form_x_match").html("");
      $("#config").append("<div id='form_x_match'><h3>Add a cross match</h3>                        <form accept-charset='UTF-8' action=\"/datasets/" + id + "/add\" enctype='multipart/form-data' method='post'>                        </form></div>");
      select_x_matches(column_names, 1);
      select_x_matches(column_names, 2);
      return $("#config form").append($("<input type='text' name='name' /><input name='commit' type='submit' value='Add'>"));
    };
    select_x_matches = function(column_names, num) {
      var column, select, _i, _len;
      select = "<div id=\"x_matcher_" + num + "\"><select name=\"matcher-" + num + "\">";
      for (_i = 0, _len = column_names.length; _i < _len; _i++) {
        column = column_names[_i];
        select += "<option value=\"" + column + "\">" + column + "</option>";
      }
      select += "</select></div>";
      return $("#config form").append($(select));
    };
    return append_dataset_column = function(column_name) {
      var item, label, radio;
      radio = $("<input type=\"radio\" name=\"column_name\" id=\"" + column_name + "\" value=\"" + column_name + "\" />");
      label = $("<label for=\"" + column_name + "\"> " + column_name + "</label>");
      item = $("<li></li>").append(radio).append(label);
      return $('#config ul').append(item);
    };
  });
}).call(this);
