# spec/requests/todos_spec.rb
require 'rails_helper'

RSpec.describe 'Todos API', type: :request do
  # initialize test data
  let!(:todos) { create_list(:todo, 10) }
  let(:todo_id) { todos.first.id }

  # Test suite for GET /todos
  describe 'GET /todos' do
    # make HTTP get request before each example
    before { get '/todos' }

    it 'returns todos' do
      # Note `json` is a custom helper to parse JSON responses
      expect(json['data']).not_to be_empty
      expect(json['data'].size).to eq(10)
    end

    it 'returns status code 200' do
      expect(response).to have_http_status(200)
    end
  end

  # Test suite for GET /todos/:id
  describe 'GET /todos/:id' do
    before { get "/todos/#{todo_id}" }

    context 'when the record exists' do
      it 'returns the todo' do
        expect(json).not_to be_empty
        expect(json['data']['id']).to eq(todo_id)
      end

      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end
    end

    context 'when the record does not exist' do
      let(:todo_id) { 100 }

      it 'returns status code 404' do
        expect(response).to have_http_status(404)
      end

      it 'returns a not found message' do
        expect(response.body).to match(/Couldn't find Todo/)
      end
    end
  end

  # Test suite for POST /todos
  describe 'POST /todos' do
    # valid payload
    let(:valid_attributes) do
      { "data": {
          "attributes": {
            "title": "Bucket List",
            "created-by": "John Doe"
          },
          "type": "todos"
        }
      }
    end

    context 'when the request is valid' do
      before { post '/todos', params: valid_attributes }

      it 'returns status code 201' do
        expect(response).to have_http_status(201)
      end

      it 'creates a todo' do
        expect(json['data']['attributes']['title']).to eq('Bucket List')
      end
    end

    context 'when the request is invalid' do
      context 'bad params' do
        let(:attributes) do
          { "data": {
              "attributes": {
                "title": "Bucket List"
              },
              "type": "todos"
            }
          }
        end
        before { post '/todos', params: attributes }

        it 'returns status code 422' do
          expect(response).to have_http_status(422)
        end

        it 'returns a validation failure message' do
          expect(json).to eql({"message" => "Validation failed: Created by can't be blank"})
        end
      end
    end
  end

  # Test suite for PUT /todos/:id
  describe 'PUT /todos/:id' do
    let(:valid_attributes) do
      { "data": {
          "attributes": {
            "title": "Shopping"
          },
          "type": "todos"
        }
      }
    end

    context 'when the record exists' do
      subject { put "/todos/#{todo_id}", params: valid_attributes }

      it 'updates the record' do
        expect {
          expect(subject).to eql(204)
        }.to change {
          Todo.find(todo_id).title
        }.to('Shopping')
        expect(response.body).to be_empty
      end
    end
  end

  # Test suite for DELETE /todos/:id
  describe 'DELETE /todos/:id' do
    before { delete "/todos/#{todo_id}" }

    it 'returns status code 204' do
      expect(response).to have_http_status(204)
    end
  end
end
