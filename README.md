## Ruby on Rails before_render filter

Adds missing `before_render` filter

Bypasses Rails filtering mechanism to ensure simplicity and compatibility with Rails 3, 4 and 5.

### Install

Gemfile

`gem 'rails_before_filter'`


### Example

We will add filter that will dump @product to json

* if we are in development
* params[:debug] is present
* @product is defined

```ruby
class AppllicationController

  before_render do
    if Rails.env.development && params[:debug]
      render json: @product.to_h if @product
    end
  end

end
```



