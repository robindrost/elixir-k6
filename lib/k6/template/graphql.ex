defmodule K6.Template.Graphql do
  @moduledoc """
  Generates a graphql template
  """
  use K6.Template

  @impl true
  def generate(opts) do
    url = Keyword.get(opts, :url, default_http_base_url())
    graphql_template(url: url)
  end

  embed_template(:graphql, """
  import http from 'k6/http';
  import { sleep } from 'k6';

  export default function() {
    let query = `
      query Query {
        field(arg: "arg") {
          data
        }
      }`;

    let headers = {'Content-Type': 'application/json'};

    let res = http.post('<%= @url %>',
      JSON.stringify({ query: query }),
      {headers: headers}
    );

    sleep(0.3);
  };
  """)
end
