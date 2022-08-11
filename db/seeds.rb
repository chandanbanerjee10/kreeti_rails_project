# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

# Users
admin = User.create(
    username: 'admin',
    email: 'admin@gmail.com',
    password: 'admin',
    role: 'admin'
)
candidate = User.create(
    username: 'candidate',
    email: 'candidate@gmail.com',
    password: 'candidate',
    role: 'candidate'
)
recruiter = User.create(
    username: 'recruiter',
    email: 'recruiter@gmail.com',
    password: 'recruiter',
    role: 'recruiter'
)
recruiter1 = User.create(
    username: 'recruiter1',
    email: 'recruiter1@gmail.com',
    password: 'recruiter1',
    role: 'recruiter'
)

# Sectors
sector1 = Sector.create(name: "IT Service", user_id: admin.id)
sector2 = Sector.create(name: "Finances", user_id: admin.id)
sector3 = Sector.create(name: "Banking", user_id: admin.id)

# Types
type1 = Type.create(name: "Web Developer", user_id: admin.id)
type2 = Type.create(name: "RND", user_id: admin.id)
type3 = Type.create(name: "Clerk", user_id: admin.id)
type4 = Type.create(name: "Investment Banker", user_id: admin.id)

# Admin Approved Jobs
job1 = Job.create(
    title: 'Web Developer',
    job_description: 'This requires sound knowledge of programming.',
    job_location: 'Kolkata',
    keyskills: 'Ruby and Rails',
    organisation_name: 'Kreeti Technologies',
    sector: sector1,
    type: type1,
    user: recruiter,
    approved_by: admin.id
)

job2 = Job.create(
    title: 'Clerk',
    job_description: 'This requires extensive work.',
    job_location: 'Kolkata',
    keyskills: 'Maths',
    organisation_name: 'State Bank Of India',
    sector: sector3,
    type: type3,
    user: recruiter,
    approved_by: admin.id
)

job3 = Job.create(
    title: 'Investment Banker',
    job_description: 'This requires extensive work.',
    job_location: 'Bangalore',
    keyskills: 'MBA',
    organisation_name: 'Goldmann Sachs',
    sector: sector2,
    type: type4,
    user: recruiter1,
    approved_by: admin.id
)
job4 = Job.create(
    title: 'Web Developer 1',
    job_description: 'This requires sound knowledge of programming.',
    job_location: 'Kolkata',
    keyskills: 'Ruby and Rails',
    organisation_name: 'Kreeti Technologies',
    sector: sector1,
    type: type2,
    user: recruiter,
    approved_by: admin.id
)


# Pending Jobs for Admin Approval
j1 = Job.create(
    title: 'Investment Banker 2',
    job_description: 'This requires extensive work.',
    job_location: 'Mumbai',
    keyskills: 'BBA',
    organisation_name: 'JP Morgan',
    sector: sector2,
    type: type4,
    user: recruiter,
    approved_by: 0
)

j2 = Job.create(
    title: 'Clerk 1',
    job_description: 'This requires extensive work.',
    job_location: 'Jamshedpur',
    keyskills: 'English',
    organisation_name: 'Punjab National Bank',
    sector: sector3,
    type: type3,
    user: recruiter1,
    approved_by: 0
)

# Posts
post1 = Post.create(
    name: 'John Doe',
    post_description: 'Hi, I am interested in doing this job',
    username: 'johnd@123',
    phone_number: '1234567890',
    city: 'Kolkata',
    user_id: candidate.id,
    job: job1,
    is_approved: true
)

post2 = Post.create(
    name: 'Jane Doe',
    post_description: 'Hi, I am interested in doing this job',
    username: 'janed@123',
    phone_number: '1234567890',
    city: 'Chennai',
    user_id: candidate.id,
    job: job1
)