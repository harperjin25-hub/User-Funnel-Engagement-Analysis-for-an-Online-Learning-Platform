-- 1) Activity by Dates: a) start_date & end_date --> b) engagement_date BETWEEN?? -- MAX(paid) c) <student_engagement.csv>

-- 2) <career_track_funnel>: enroll --> attempt exam --> complete exam --> attemp final exam --> earn certificate

-- 3) <course ratings>: SINGLE Column 'course_rating'

-- 4) <course engagement>: minutes_watched --> per_students --> completion_rate

-- 5) <F2P Conversion Rate>: CTE f2p [0 or 1] --> total_minutes_watched --> case when [buckets]

-- 6) <subscription duration>: CTE MIN()&MAX()[first, last date] --> total_minutes_watched --> datediff()[num_paid_days] --> buckets[]

-- 7) <student certificates>: certificate_id & type & CASE WHEN date_issue [start, end] --> paid

-- 8) <student exam attempts>: exam info

-- 9)  <student learning>: CTE CASE WHEN paid --> minutes_watched

-- 10) <student onboarding>: [0, 1] onboard or not












