require 'aws-sdk'

Aws.config.update({
  region: 'ap-southeast-1',
  credentials: Aws::Credentials.new(ENV['AWS_ACCESS_KEY_ID'], ENV['AWS_SECRET_ACCESS_KEY'],
   )
})

# S3_BUCKET =  AWS::S3.new.buckets[ENV['S3_BUCKET']]


