Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7EBDA4F4043
	for <kvm@vger.kernel.org>; Tue, 29 Sep 2026 14:13:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790691201; cv=none; b=EVeVdn737VxYVkJLQkDTJC7FD3GlXrO77D6iZiCndqvS3/gahTHoteoubt1p3oydq2EXRoh80hJdUERT7TKzhcy8XlL9dYDjkO4SMWMj0HQmmHiPMay7mheyj2VhOJhMEBefG6kxCAZsTM92cqudl4OP3bvn1t8wOCzlo5fEMQI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790691201; c=relaxed/simple;
	bh=QVNPYRjccZ4oE0aDn4xWSSlGbXx+ahF7r87kLGC0Jyo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type:Content-Disposition; b=tAs0fv8YZ4miUAupgZAwXeXISdbk23UQkx+TlFA2msrCwz3mrO1XXolBJNvjEEfjROyc5tgo4GI7W7Vh+VDVnmB+wN8S55rxtF8gR+zNGGGbgee3/OJFGtYoQ1U/CeF5SF8L1ArwuflIUzBgwxupLHZvniekjHyvAfHCuy011q8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=kKKbU149; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="kKKbU149"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 790331476;
	Tue, 29 Sep 2026 07:13:15 -0700 (PDT)
Received: from LeoBrasDK.cambridge.arm.com (LeoBrasDK.cambridge.arm.com [10.2.212.21])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 7211F3F86F;
	Tue, 29 Sep 2026 07:13:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1790691199; bh=QVNPYRjccZ4oE0aDn4xWSSlGbXx+ahF7r87kLGC0Jyo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=kKKbU149tUlnraS3nYr9wtu6vKJQdOzXEFbhRRV3/uXmpH/2jzPVVUkKyP+hpi9ow
	 214ijdoB+nVu5j+KKzuvLsjiAKn92Phh1iNfgaPxvSIUs5QWP+DNn1XQWonOQej3W6
	 UGJLPUmJgo8tmDFkEftEJK0iZCuZAQfQqPPzPZLk=
From: Leonardo Bras <leo.bras@arm.com>
To: sashiko-reviews@lists.linux.dev
Cc: Leonardo Bras <leo.bras@arm.com>,
	kvm@vger.kernel.org
Subject: Re: [PATCH v1 3/3] KVM: selftests: dirty_log_perf_test: Add dirty-ring support
Date: Tue, 29 Sep 2026 15:13:12 +0100
Message-ID: <arvHeEVvnVmdtbSq@LeoBrasDK>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260929115347.5FE831F00898@smtp.kernel.org>
References: <20260929113711.2064390-1-leo.bras@arm.com> <20260929113711.2064390-4-leo.bras@arm.com> <20260929115347.5FE831F00898@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

On Tue, Sep 29, 2026 at 11:53:46AM +0000, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> - [Medium] kvm: selftests: dirty ring collection time excludes lock wait time
> --
> 
> commit 2c539bfee74e383775f9c7f30033144876ad2f45
> Author: Leonardo Bras <leo.bras@arm.com>
> 
> KVM: selftests: dirty_log_perf_test: Add dirty-ring support
> 
> This commit adds dirty-ring support to the dirty_log_perf_test to enable
> performance comparisons between dirty-bitmap and dirty-ring tracking
> mechanisms.
> 
> > diff --git a/tools/testing/selftests/kvm/dirty_log_perf_test.c b/tools/testing/selftests/kvm/dirty_log_perf_test.c
> > index 8f791ad7b86a8..af0ab654d46e2 100644
> > --- a/tools/testing/selftests/kvm/dirty_log_perf_test.c
> > +++ b/tools/testing/selftests/kvm/dirty_log_perf_test.c
> [ ... ]
> > @@ -29,9 +30,53 @@ static bool run_vcpus_while_disabling_dirty_logging;
> >  
> >  /* Host variables */
> >  static u64 dirty_log_manual_caps;
> > +static u32 dirty_ring_size;
> >  static bool host_quit;
> >  static int iteration;
> >  static int vcpu_last_completed_iteration[KVM_MAX_VCPUS];
> > +static struct timespec vcpu_dirty_ring_collect[KVM_MAX_VCPUS];
> > +
> > +static void dirty_ring_collect(struct kvm_vcpu *vcpu, u32 *ring_idx,
> > +				struct timespec *ts)
> > +{
> > +	static pthread_mutex_t collect = PTHREAD_MUTEX_INITIALIZER;
> > +	struct timespec start;
> > +	struct kvm_dirty_gfn *dirty_gfns = vcpu_map_dirty_ring(vcpu);
> > +	u32 idx = *ring_idx;
> > +	u32 ring_size = vcpu->vm->dirty_ring_size / sizeof(struct kvm_dirty_gfn);
> > +	int cleared, count;
> > +
> > +	pthread_mutex_lock(&collect);
> > +
> > +	clock_gettime(CLOCK_MONOTONIC, &start);
> 
> [Severity: Medium]
> Since the timer is initialized after acquiring the lock, the time spent
> waiting for the mutex is not recorded in the collection time. When multiple
> vCPUs fill their dirty rings concurrently and wait on this lock, will this
> lock contention time be incorrectly omitted from collect?

Yes, but that was a design choice.

> 
> > +
> > +	while (true) {
> > +		struct kvm_dirty_gfn *cur;
> [ ... ]
> > @@ -43,24 +88,45 @@ static void vcpu_worker(struct memstress_vcpu_args *vcpu_args)
> >  	struct timespec ts_diff;
> >  	struct timespec total = (struct timespec){0};
> >  	struct timespec avg;
> > +	bool use_dirty_ring = !!vcpu->vm->dirty_ring_size;
> > +	u32 ring_idx = 0;
> >  	int ret;
> >  
> >  	run = vcpu->run;
> >  
> >  	while (!READ_ONCE(host_quit)) {
> >  		int current_iteration = READ_ONCE(iteration);
> > +		struct timespec collect = (struct timespec){0};
> >  
> >  		clock_gettime(CLOCK_MONOTONIC, &start);
> > -		ret = _vcpu_run(vcpu);
> > +
> > +		do {
> > +			ret = _vcpu_run(vcpu);
> > +			if (!use_dirty_ring)
> > +				break;
> > +
> > +			dirty_ring_collect(vcpu, &ring_idx, &collect);
> > +		} while (!ret && run->exit_reason == KVM_EXIT_DIRTY_RING_FULL);
> > +
> >  		ts_diff = timespec_elapsed(start);
> >  
> > +		if (use_dirty_ring) {
> > +			ts_diff = timespec_sub(ts_diff, collect);
> 
> [Severity: Medium]
> Because collect does not include the lock wait time from
> dirty_ring_collect(), subtracting it from ts_diff leaves the lock
> contention overhead misattributed to the guest execution time. Doesn't this
> artificially inflate the reported guest execution time and obscure the true
> overhead of dirty ring synchronization?
> 

But that's what's going to happen in any VMM.
Also, doing otherwise would fakely account for the cleaning part, which is 
what we are trying to measure.

Thanks!
Leo
