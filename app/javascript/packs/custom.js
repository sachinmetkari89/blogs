
$(document).ready(function () {

  function getStatusBadge(status) {
    if (status == 'draft') {
      return "<span class='badge badge-pill badge-dark'>Draft</span>";
    } else if (status == 'published') {
      return "<span class='badge badge-pill badge-info'>Published</span>";
    } else if (status == 'archived') {
      return "<span class='badge badge-pill badge-success'>Archived</span>"
    }
    return '';
  }

  function showFlashMessage(type, message) {
    if (type === 'success') {
      return `<div class="alert alert-success alert-dismissible">
        <button type="button" class="close" data-dismiss="alert">&times;</button>
        ${message}
      </div>`
    } else if (type === 'errors') {
      return `<div class="alert alert-danger alert-dismissible">
        <button type="button" class="close" data-dismiss="alert">&times;</button>
        ${message}
      </div>`
    } else if (type === 'warning') {
      return `<div class="alert alert-warning alert-dismissible">
        <button type="button" class="close" data-dismiss="alert">&times;</button>
        ${message}
      </div>`
    } else if (type === 'info') {
      return `<div class="alert alert-info alert-dismissible">
        <button type="button" class="close" data-dismiss="alert">&times;</button>
        ${message}
      </div>`
    }
  }

  $('.article-state').change(function () {
    var state = $(this).val();
    var article_id = $(this).attr('data-article-id');
    if (state && article_id) {
      $.ajax({
        url: `/articles/${article_id}/update_state?article[state]=${state}`,
        type: 'PUT',
        contentType: 'application/json',
        success: function(response, status) {

          var badgeStatus = getStatusBadge(response.data.state);
          if (badgeStatus) {
            $(`.article-state-${response.data.id}`).html(badgeStatus);            
          }

          var flash_message = showFlashMessage(status, response.meta.notice);
          if (flash_message) {
            $(`.flash-message`).html(flash_message);            
          }
        },
        error: function(request,msg,error) {
          alert(msg);
        }
      });
    } else {
      var flash_message = showFlashMessage('warning', 'Please select status.');
      if (flash_message) {
        $(`.flash-message`).html(flash_message);            
      }
    }
  })
  
})



























