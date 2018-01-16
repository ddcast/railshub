namespace :railshub do
  desc "For polling GitHub API to update issues"
  
  task :update_issues => [:environment] do |t, args|

    Railshub::IssueUpdater.update_from_remote({
      by_comment_count: true,
      by_component: true
    })

    print "Done!\n"
  end
end
