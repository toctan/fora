require "spec_helper"

describe TopicsController do
  describe "#index" do
    it "unsigned user" do
      get "index"

      expect(response).to be_success
    end
  end

  describe "#show" do
    it "unsigned user" do
      user = create(:confirmed_user)
      topic = create(:topic, user: user)
      get "show", id: topic.id

      expect(response).to be_success
    end
  end

  describe "#new" do
    let(:node) { create(:node) }

    it "unsigned user" do
      get "new", key: node.key

      expect(response).to redirect_to new_user_session_path
    end

    describe "signed user" do
      before do
        user = sign_in_as(:confirmed_user)
      end

      it "unexisted node" do
        get "new", key: node.key + "fake"

        expect(response).to redirect_to root_url
      end

      it "existed node" do
        get "new", key: node.key

        expect(response).to be_success
      end
    end
  end

  describe "#create" do
    let(:node) { create(:node) }
    let(:topic) { build(:topic) }

    it "unsigned user" do
      post "create", node_id: node.id

      expect(response).to redirect_to new_user_session_path
    end


    describe "signed user create a topic with" do
      before do
        sign_in_as(:confirmed_user)
      end

      it "valid data" do
        expect do
          post "create", node_id: node.id,
                         topic: { title: topic.title, body: topic.body }
        end.to change{ Topic.count }.by(1)
      end

      it "invalid data" do
        post "create", node_id: node.id,
                       topic: { title: ""}

        response.should render_template("new")
      end
    end
  end

  describe "#destroy" do
    let!(:topic) do
      user = create(:confirmed_user)
      topic = create(:topic, user: user)
    end

    it "unsigned user" do
      delete "destroy", id: topic.id

      expect(response).to redirect_to new_user_session_path
    end

    describe "signed user" do
      it "common user" do
        sign_in_as(:confirmed_user)

        expect do
          delete "destroy", id: topic.id
        end.to raise_error(CanCan::AccessDenied)

      end

      it "admin user" do
        sign_in_as(:admin)
        num = Topic.count

        expect do
          delete "destroy", id: topic.id
        end.to change{Topic.count}.from(1).to(0)

      end
    end
  end

  describe "#star" do
    let!(:topic) do
      user = create(:confirmed_user)
      topic = create(:topic, user: user)
    end

    it "unsigned user" do
      patch "star", id: topic.id

      expect(response).to redirect_to new_user_session_path
    end

    it "signed user" do
      sign_in_as(:confirmed_user)

      request.env["HTTP_REFERER"] = topic_path topic
      patch "star", id: topic.id

      expect(response).to redirect_to topic
    end
  end

  describe "#unstar" do
    let!(:topic) do
      user = create(:confirmed_user)
      topic = create(:topic, user: user)
    end

    it "unsigned user" do
      patch "unstar", id: topic.id

      expect(response).to redirect_to new_user_session_path
    end

    it "signed user" do
      sign_in_as(:confirmed_user)

      request.env["HTTP_REFERER"] = topic_path topic
      patch "unstar", id: topic.id

      expect(response).to redirect_to topic
    end
  end
end