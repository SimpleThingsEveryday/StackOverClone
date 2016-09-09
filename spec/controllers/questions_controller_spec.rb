require 'rails_helper'

RSpec.describe QuestionsController, type: :controller do
  let(:question) { FactoryGirl.create(:question)}

  describe 'GET #index' do
      let(:questions) {FactoryGirl.create_list(:question, 2)}
      before(:each) do
        get :index
      end
      it 'populates an array of all questions' do
            expect(assigns(:questions)).to match_array(questions)
      end
      it 'renders index view' do
            expect(response).to render_template :index
      end
    end
    describe 'Get #show' do
     before(:each) do
  get :show, id: question
end
    it 'assigns the requested question to @question' do
      expect(assigns(:question)).to eq question
    end
    it 'renders show view' do
      expect(response).to render_template :show
    end
  end
    describe 'GET #new' do

    before(:each) do
      get :new
    end
  it'assigns a new Question to @question' do
    expect(assigns(:question)).to be_a_new(Question)
  end
    it 'renders new view' do
      expect(response).to render_template :new
    end
  end
  describe 'GET #edit' do


    before(:each) do
      get :edit, id: question
    end

    it 'assngs the requested question to @question' do
      expect(assigns(:question)).to eq question
    end

    it 'renders edit view' do
      expect(response).to render_template :edit
    end
  end
  describe 'POST #create' do

    context 'with valid attributes' do

      it 'saves the new question in the db' do
      expect{post :create, question: have_attributes(:question)}.to change(Question,  :count).by(1)

      end

      it 'redirects to show view' do
        post :create, question: have_attributes(:question)
        expect(response).to redirect_to question_path(assigns(:question))
      end
    end
    context 'with invalid attributes' do
      it 'does not save question ' do
        expect{post :create, question: have_attributes(:invalid_question)}.to_not change(Question,  :count)
      end
      it 're-renders new view' do
        post :create, question: have_attributes(:invalid_question)
        expect(response).to render_template :new
      end
    end
  end
  describe 'PATCH #update' do
    context 'valid attributes'do
      it 'assing the requested question to @question' do
        patch :update, id: question, question: have_attributes(:question)
        expect(assigns(:question)).to eq question
      end
      it 'changes question attributes' do
        patch :update, id: question, question: {title: ' new title ', body: ' new body '}
        question.reload
        expect(question.title).to eq ' new title '
        expect(question.body).to eq ' new body '
      end
      it 'redirects to the updated question' do
       patch :update, id: question, question: have_attributes(:question)
        expect(response).to redirect_to question
      end
    end
    context 'invalid attributes' do
      it 'does not change question attributes' do
        patch :update, id: question, question: {title: ' new title ', body: ' new body '}
        question.reload
        expect(question.title).to eq ' MyString '
        expect(question.body).to eq ' new body '
      end
      it ' re-render ' do
        patch :update, id: question, question: have_attributes(:question)
        expect(response).to render_template :edit
      end
    end
  end
  describe 'DELETE #destroy' do
    it 'delete question' do
      question
      expect {delete :destroy, id: question}.to change(Question, :count).by(-1)
    end
    it ' redirect to index new' do
      delete :destroy, id: question
      expect(response).to redirect_to questions_path
    end
  end
end
