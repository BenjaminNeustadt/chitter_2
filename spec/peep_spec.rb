require 'peep'

RSpec.describe Peep do

  describe '.all' do

    it 'has 1 peep' do
      connection = PG.connect(dbname: 'chit_test')
      connection.exec("INSERT INTO peeps (content) VALUES ('first peep');")

      expect(Peep.all.size).to eq 1
    end

    it 'has the content of the first peep' do
      connection = PG.connect(dbname: 'chit_test')
      connection.exec("INSERT INTO peeps (content) VALUES ('first peep');")

      expect(Peep.all.first.content).to eq 'first peep'
    end

    it 'has the content of the second peep' do
      connection = PG.connect(dbname: 'chit_test')
      connection.exec("INSERT INTO peeps (content) VALUES ('first peep');")
      connection.exec("INSERT INTO peeps (content) VALUES ('second peep');")

      expect(Peep.all.first.content).to eq 'second peep'

    end

    it 'has two peeps' do
      connection = PG.connect(dbname: 'chit_test')
      connection.exec("INSERT INTO peeps (content) VALUES ('first peep');")
      connection.exec("INSERT INTO peeps (content) VALUES ('second peep');")

      expect(Peep.all.size).to eq 2
    end

    scenario 'returns in reverse chronological order' do
      connection = PG.connect(dbname: 'chit_test')

      connection.exec("INSERT INTO peeps (content) VALUES ('first peep');")
      connection.exec("INSERT INTO peeps (content) VALUES ('second peep');")
      connection.exec("INSERT INTO peeps (content) VALUES ('third peep');")
      connection.exec("INSERT INTO peeps (content) VALUES ('fourth peep');")

      peeps = Peep.all
      expect(peeps[0].content).to eq 'fourth peep'
      expect(peeps[1].content).to eq 'third peep'
      expect(peeps[2].content).to eq 'second peep'
      expect(peeps[3].content).to eq 'first peep'
    end

    scenario 'has time_stamp property' do
      connection = PG.connect(dbname: 'chit_test')
      connection.exec("INSERT INTO peeps (content) VALUES ('first peep');")
      connection.exec("INSERT INTO peeps (content) VALUES ('second peep');")
      connection.exec("INSERT INTO peeps (content) VALUES ('third peep');")

      peeps = Peep.all
      all_peeps_have_time_stamps = peeps.all? do |peep|
        peep.time_stamp =~ /\d{4}.\d{2}.\d{2}\s\d{2}.\d{2}/
      end
      expect(all_peeps_have_time_stamps).to be true
    end

    scenario 'has user_id property' do

      user = User.create(
        username: 'Humphrey',
        email: 'humphrey@bogart.com',
        password: 'bogarT1!'
      )

      peep = Peep.create(
        content: %Q[somethingbogart],
        user_id: user.id
      )
      peep_list = Peep.all
      expect(peep_list.first.user_id.to_s).to eq user.id
    end

  end

  describe '.get_author' do

    it 'returns the name of the author' do

      user = User.create(
        username: 'Jerry',
        email: 'Jerry@Ben.com',
        password: 'iceCream!'
      )
      peep = Peep.create(
        content: %Q[when icecream?],
        user_id: user.id
      )
      peeps = Peep.all
      the_peep = peeps.first
      peep_user_id = the_peep.user_id
      expect(the_peep.get_author(peep_user_id)).to eq 'Jerry'

    end

  end

  describe '.create' do

    it 'a new peep assigned to a user' do
      Peep.create(content: 'This is a test', user_id: 1)
      peeps = Peep.all

      expect(peeps.first.content).to eq 'This is a test'
      expect(peeps.first.user_id).to eq(1)
    end

  end

end

