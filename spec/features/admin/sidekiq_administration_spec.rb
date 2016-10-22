require 'rails_helper'

describe 'When Administering Sidekiq' do

  before do
    sign_in_as_admin(admin)
  end

  context 'as a System Admin' do
    let(:admin) { create(:admin, :sys_admin) }
    
    describe "the menu bar" do
      before do
        visit admin_root_path
      end
      it { expect(current_path).to eq(admin_root_path) }
      it { within('aside.left-panel') { expect(page).to have_link('Sidekiq') } }
    end

    describe "the sidekiq route" do
      before do
        visit sidekiq_web_path
      end
      it { expect(current_path).to eq(sidekiq_web_path) }
    end
  end

  context 'as a non-System Administrator' do
    let(:admin) { create(:admin) }

    describe "the menu bar" do
      before do
        visit admin_root_path
      end
      it { expect(current_path).to eq(admin_root_path) }
    end

    describe "the sidekiq route" do
      it "should raise a Routing error when accessed" do
        expect {
          visit sidekiq_web_path
        }.to raise_error(ActionController::RoutingError, 'No route matches [GET] "/sidekiq"')
      end
    end
  end
end
