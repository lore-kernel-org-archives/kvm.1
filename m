Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66EFF3F12E3
	for <kvm@vger.kernel.org>; Wed,  8 Jul 2026 16:57:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783529863; cv=none; b=AYeYvu9dT3nklVjhjh240Z0l7s0JINopug/UfE9oEipA9NxpOgqlXoZcY1+wXeU94Odhah5TSvnm6BbUjnjzQm2K5liPImGkKicbl3NjEtCdQFkxd+Lg5AgW5rlpxl81/p9IxIm4AtJFTmSsweoKhTE/T3Tc4OG16j6+jmpBfBI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783529863; c=relaxed/simple;
	bh=cRH++9O1Ay2nLjpSJWEr2bbXp3Rt2/8JjlV7JrV0hCc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type:Content-Disposition; b=lnOTlLQP0wkjWToJvXj/TVg3MAe2WBee4naUE+CQZDuLz4hGwYWZRitNq4R5AMlvmK7+rgSZifY57p1lP40zkcfW+fjBcKOTINOw4JM5vuuQ9c68lQ002YzpVlmdB5AxUxLUcRbSJkqf1yyJr6JK4Bt1fU01w+Zudz0q3rPCi24=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=qfBdT/w2; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="qfBdT/w2"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 725531D14;
	Wed,  8 Jul 2026 09:57:36 -0700 (PDT)
Received: from LeoBrasDK.cambridge.arm.com (LeoBrasDK.cambridge.arm.com [10.2.212.21])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 4528F3F7B4;
	Wed,  8 Jul 2026 09:57:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1783529860; bh=cRH++9O1Ay2nLjpSJWEr2bbXp3Rt2/8JjlV7JrV0hCc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=qfBdT/w2M2Z4iUuxuIuiZiLVxQEA2g/Me9cjHtFyP+7lpCkpth6s8Q4rlVZN+QMS4
	 oWLveh78UbZluKy+2h0aT3q6fjHGn+ySZmHGQ8PkXQ+u+rTEGiJ+NlkMIq6TWwBlKc
	 fpI0zMt5deoSU8da9dAV+toD2Q1V02oPGLXhom5Q=
From: Leonardo Bras <leo.bras@arm.com>
To: sashiko-reviews@lists.linux.dev
Cc: Leonardo Bras <leo.bras@arm.com>,
	kvm@vger.kernel.org
Subject: Re: [RFC PATCH v3 3/3] KVM: selftests: dirty_log_perf_test: Add dirty-ring support
Date: Wed,  8 Jul 2026 17:57:38 +0100
Message-ID: <ak6BgqS_YS3UOqdU@LeoBrasDK>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260708153613.8F7AF1F000E9@smtp.kernel.org>
References: <20260708152232.2568907-1-leo.bras@arm.com> <20260708152232.2568907-4-leo.bras@arm.com> <20260708153613.8F7AF1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

On Wed, Jul 08, 2026 at 03:36:13PM +0000, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 2 potential issue(s) to consider:
> - [Medium] The 'dirty memory time' metric incorrectly includes the time vCPU threads spend waiting for the global `collect` mutex, misattributing it to guest execution time and underreporting dirty ring management overhead.
> - [Medium] Lockless synchronization between the vCPU threads and the main thread lacks memory barriers, creating a data race on the `vcpu_dirty_ring_collect` timespec payload.
> --
> 
> --- Patch [3]: [RFC PATCH v3 3/3] KVM: selftests: dirty_log_perf_test: Add dirty-ring support ---
> commit d30bfe94110209591fe009dbe43668ba5266de12
> Author: Leonardo Bras <leo.bras@arm.com>
> 
> KVM: selftests: dirty_log_perf_test: Add dirty-ring support
> 
> dirty_log_test supports both dirty-bitmap and dirty-ring as dirty-page
> tracking mechanisms, while dirty_log_perf_test only supports dirty-bitmap.
>     
> Add support to dirty-ring on dirty_log_perf_test so it can be used to
> compare performance between changes in the mechanism.
> 
> > diff --git a/tools/testing/selftests/kvm/dirty_log_perf_test.c b/tools/testing/selftests/kvm/dirty_log_perf_test.c
> > index 69b38791440e7..181f521c9be96 100644
> > --- a/tools/testing/selftests/kvm/dirty_log_perf_test.c
> > +++ b/tools/testing/selftests/kvm/dirty_log_perf_test.c
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
> Will this timer placement incorrectly measure performance metrics?
> 
> Because clock_gettime() is called after acquiring the collect mutex, the
> returned ts will not include any time the vCPU thread spends waiting for the
> lock.
> 
> Later in vcpu_worker():
> 
> 	ts_diff = timespec_elapsed(start);
> 
> 	if (use_dirty_ring) {
> 		ts_diff = timespec_sub(ts_diff, collect);
> 	}
> 
> Since collect excludes lock contention time, subtracting it leaves that
> contention overhead in ts_diff. Does this result in misattributing lock
> contention to guest execution time?

Yes, but that's expected, if we want to isolate the dirty-ring cleaning 
time from the waiting on lock time. Another option would be to add a 
different variable to account for that time, and just remove it before 
returning.

Question is: are people worried about dirtying time accounting enough so we 
have to subtract the waiting on lock time?

> 
> > +
> > +	while (true) {
> > +		struct kvm_dirty_gfn *cur;
> 
> [ ... ]
> 
> > @@ -43,17 +88,33 @@ static void vcpu_worker(struct memstress_vcpu_args *vcpu_args)
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
> > +		} while (run->exit_reason == KVM_EXIT_DIRTY_RING_FULL);
> > +
> >  		ts_diff = timespec_elapsed(start);
> >  
> > +		if (use_dirty_ring) {
> > +			ts_diff = timespec_sub(ts_diff, collect);
> > +			vcpu_dirty_ring_collect[vcpu_idx] = collect;
> > +		}
> > +
> >  		TEST_ASSERT(ret == 0, "vcpu_run failed: %d", ret);
> >  		TEST_ASSERT(get_ucall(vcpu, NULL) == UCALL_SYNC,
> >  			    "Invalid guest sync status: exit_reason=%s",
> >  			    exit_reason_str(run->exit_reason));
> >  
> >  		pr_debug("Got sync event from vCPU %d\n", vcpu_idx);
> >  		vcpu_last_completed_iteration[vcpu_idx] = current_iteration;
> 
> [Severity: Medium]
> Are memory barriers needed for this lockless synchronization?
> 
> The worker thread updates vcpu_dirty_ring_collect and then sets
> vcpu_last_completed_iteration to signal completion. However, this is done
> without store-release semantics.
> 
> Meanwhile, the main thread in run_test() spins on the completion flag and
> then reads the array:
> 
> 	for (i = 0; i < nr_vcpus; i++) {
> 		while (READ_ONCE(vcpu_last_completed_iteration[i]) != iteration)
> 			;
> 	}
> 	
> 	/* ... */
> 	
> 	if (dirty_ring_size) {
> 		for (i = 0; i < nr_vcpus; i++)
> 			iteration_sum = timespec_add(iteration_sum,
> 						     vcpu_dirty_ring_collect[i]);
> 	}
> 
> Could weakly-ordered architectures like ARM64 reorder the worker thread's
> stores (or the main thread's loads), causing the main thread to read torn or
> stale struct timespec data?
> 

I see the point. We have to make sure the order is kept. Easiest way would 
be to use an acquire/release pair here. Will do for next version.


Thanks!
Leo
