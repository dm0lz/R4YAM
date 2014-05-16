require 'spec_helper'

describe Api::V1::EntriesController do

  describe "GET 'index'" do

    it "returns http success" do
      get 'index'
      expect(response.status).to eq(200)
    end

    it "returns json" do
      get 'index', {}, {'Accept' => Mime::JSON}
      expect(response.content_type).to eq(Mime::JSON.to_s)
    end

    it "returns a list of entries" do
      FactoryGirl.create(:entry)
      get 'index', {}, { 'Accept' => Mime::JSON }
      res = JSON(response.body)
      expect(res.count).to be >= 1
    end

    it "returns entries filtered by name" do
      a = FactoryGirl.create(:entry)
      b = FactoryGirl.create(:entry_b)
      get 'index', {name: a.name}, { 'Accept' => Mime::JSON }
      res = JSON.parse(response.body, symbolize_names: true)
      names = res.map{|l| l[:name]}
      expect(names).to include a.name
      expect(names).to_not include b.name
    end

    it "returns entries filtered by price" do
      a = FactoryGirl.create(:entry)
      b = FactoryGirl.create(:entry_b)
      get 'index', {price: a.price}, { 'Accept' => Mime::JSON }
      res = JSON.parse(response.body, symbolize_names: true)
      names = res.map{|l| l[:price]}
      expect(names).to include a.price
      expect(names).to_not include b.price
    end

    it "returns entries filtered by flag" do
      a = FactoryGirl.create(:entry)
      b = FactoryGirl.create(:entry_b)
      get 'index', {flag: a.flag}, { 'Accept' => Mime::JSON }
      res = JSON.parse(response.body, symbolize_names: true)
      names = res.map{|l| l[:flag]}
      expect(names).to include a.flag
      expect(names).to_not include b.flag
    end

  end

  describe "POST 'create'" do

    before(:each) do
      post 'create', {entry: {name: "Robert", price: 33, flag: false}}, { 'Accept' => Mime::JSON }
    end

    it "creates a new entry" do
      res = JSON.parse(response.body, symbolize_names: true)
      expect(res[:name]).to eq("Robert")
    end

    it "should repond with status 201" do
      expect(response.status).to eq(201)
    end

    it "should repond with json" do
      expect(response.content_type).to eq(Mime::JSON.to_s)     
    end

    it "should increase total number of entries by 1" do
      expect{post 'create', {entry: {name: "Robert", price: 33, flag: false}}, { 'Accept' => Mime::JSON }}.to change{Entry.count}.by(1)
    end

    it "should not create entry with name equal to nil" do
      post 'create', {entry: {name: nil, price: 33, flag: false}}, { 'Accept' => Mime::JSON }
      expect(response.status).to eq(422)
    end

  end

  describe "POST 'delete'" do 

    before(:each) do
      post 'create', {entry: {name: "Julien-delete", price: 33, flag: false}}, { 'Accept' => Mime::JSON }
      res = JSON.parse(response.body, symbolize_names: true)
      @id = res[:_id][:$oid]
    end

    it "should delete entry" do
      delete 'destroy', { id: @id }
      expect(response.status).to eq(204)
    end

  end

  describe "PUT 'update'" do

    before(:each) do
      post 'create', {entry: {name: "Julien-to-be-updated", price: 33, flag: false}}, { 'Accept' => Mime::JSON }
      res = JSON.parse(response.body, symbolize_names: true)
      @id = res[:_id][:$oid]
    end

    it "should update the entry with new data" do
      put 'update', { id: @id, entry: {name: "Julien-updated", price: 77, flag: true} }
      res = JSON.parse(response.body, symbolize_names: true)
      expect(res[:name]).to eq("Julien-updated")
    end

    it "should respond with json" do
      put 'update', { id: @id, entry: {name: "Julien-updated", price: 77, flag: true} }
      expect(response.content_type).to eq(Mime::JSON.to_s)
    end

  end

  describe "GET 'show'" do
    
    before(:each) do
      post 'create', {entry: {name: "Julien-to-be-showed", price: 33, flag: false}}, { 'Accept' => Mime::JSON }
      res = JSON.parse(response.body, symbolize_names: true)
      @id = res[:_id][:$oid]
    end

    it "should respond with json" do
      get 'show', { id: @id }, { 'Accept' => Mime::JSON }
      expect(response.content_type).to eq(Mime::JSON.to_s)
    end

    it "should return status success" do
      get 'show', { id: @id }
      expect(response.status).to eq(200)
    end

    it "should show entry" do
      get 'show', { id: @id}
      res = JSON.parse(response.body, symbolize_names: true)
      expect(res[:name]).to eq("Julien-to-be-showed")
    end

  end

end
