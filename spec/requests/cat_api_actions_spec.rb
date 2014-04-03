require 'spec_helper'

describe "ListingCats" do

  include Helpers

  setup { host! 'api.example.com' }

  let(:cat) { Cat.create!(name:'DefaultKitty', breed:'NetCat', age:20) }
  let(:cats) { json(response.body) }

  before(:each) do
    @garfield = Cat.create!(name:'Garfield', breed:'Housecat', age: 35)
    @lolzCat = Cat.create!(name:'Lolz', breed:'Netcat', age: 10)
  end

  describe "GET /listing_cats" do

    it "should return cats in JSON" do
      # Asks for a response with the request header of MIME::JSON
      # which tells the server that we want JSON format
      get '/cats', {}, { 'Accept' => Mime::JSON }
      json_success(response)
    end

    it "should return cats in XML" do
      get '/cats', {}, { 'Accept' => Mime::XML }
      xml_success(response)
    end

    it "should return list of cats in english" do
      get '/cats', {}, { 'Accept-Language' => 'en', 'Accept' => Mime::JSON }
      json_success(response)
      cats[0][:message].should eq "#{cats[0][:name]} is a cat"
    end

    it "should return a list of cats in portuguese" do
    get '/cats', {}, { 'Accept-Language' => 'pt-BR', 'Accept' => Mime::JSON }
    json_success(response)

    cats[0][:message].should eq "#{cats[0][:name]} es un gato"
    end
  end

  describe "SHOW /showing cats" do

    # This method tests nothing but it helps me remember a principle
    it "show method should return only the oldest cats" do
      get "/cats/#{@garfield.id}"

      json_success(response)
      # If you think you might get either a string or array, this will
      # ensure that your data stays array
      names = [*cats[:name]]
      names.should include 'Garfield'
      names.should_not include 'Lolz'

    end
  end

  describe "POST /creating cats" do

    it "should create a cat" do

      post '/cats',
           { cat:
            { name: "Tinyface", breed: 'housecat', age: 1}
           }.to_json,
           { 'Accept' => Mime::JSON, 'Content-Type' => Mime::JSON.to_s }

      response.status.should be 201
      response.content_type.should be Mime::JSON

      response.location.should eq "/cats/#{cats[:id]}"
    end

    it "should not create a cat with no name" do

      post '/cats',
           { cat:
             {name: nil, breed: 'netcat', age: 2}
           }.to_json,
           { 'Accept' => Mime::JSON, 'Content-Type' => Mime::JSON.to_s }

      response.status.should be 422
      response.content_type.should be Mime::JSON
    end
  end

  describe "PATCH /updating cats" do

    it "should successfully update a cat" do

      patch "/cats/#{cat.id}",
            { cat: { name: 'NewCat'} }.to_json,
            { 'Accept' => Mime::JSON, 'Content-Type' => Mime::JSON.to_s }

      json_success(response)
      cat.reload.name.should eq 'NewCat'
    end

    it "should not update a cat with a nil name" do

      patch "/cats/#{cat.id}",
            { cat: { name: nil } }.to_json,
            { 'Accept' => Mime::JSON, 'Content-Type' => Mime::JSON.to_s }

      response.status.should be 422
    end
  end

  describe "DELETE /deleting cats" do

    it "should delete a cat" do

      delete "/cats/#{cat.id}"
      #204 is successful response but no body.
      response.status.should be 204
    end
  end
end