Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 274AE2EC090
	for <kvm@vger.kernel.org>; Wed, 29 Jul 2026 16:46:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785343584; cv=none; b=gI11NCHvbt9tdpMb7XY03Wm5dzPojeKAgfcAX746/Crw8Q5Iz11w6ei6+j5Syl6p5JBAIG5MP0XASEqnyyc/5ie9d+FSSp3lmFwxVowtSl8EoTvxn73pUf7FdfHn39fI7D6hYVU2qRjQfDQUP90RjFFecI1V21ZSHkHD/DFtTCY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785343584; c=relaxed/simple;
	bh=25ype5RoJhJGhyl+eVhHNn3i5QfWvs7b8RwnLrzqKNo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type:Content-Disposition; b=IQZyy8Fd9Muit2t1roAJPRhpm/2QL/K1K5GD6Jt6pVREV63E4cOdhIwGXi/9fnTN7dkXKkMkh1iw59xMOeNhRts9FgeZaJy7BZk/LcXVPkkndJvU9jp3taACRJAB9gFJmPTsMo8zAq+AqAkoIiqyg92+Kd7F7Gfyin0Q9wwSj2M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=ZxrtQUqD; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="ZxrtQUqD"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4CB891684;
	Wed, 29 Jul 2026 09:46:18 -0700 (PDT)
Received: from LeoBrasDK.cambridge.arm.com (LeoBrasDK.cambridge.arm.com [10.2.212.21])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D3A5B3F66F;
	Wed, 29 Jul 2026 09:46:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1785343582; bh=25ype5RoJhJGhyl+eVhHNn3i5QfWvs7b8RwnLrzqKNo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ZxrtQUqDliIbMRIigZ+gIzkGXPZZbiAFc+P/tkjkrXpB0NNkxq3NWRbnxMPgZh0Jh
	 oEZsYvsVtwB/eueaAF6Zi6O8rCjW21YU6VMjkk7AZ1qdzscnMZ+7ExwzP9ytDFqyWi
	 5GHZkcL/4/WN9HIRJW3mXYu2SqHqLRUAtUCNwQ4s=
From: Leonardo Bras <leo.bras@arm.com>
To: sashiko-reviews@lists.linux.dev
Cc: Leonardo Bras <leo.bras@arm.com>,
	kvm@vger.kernel.org
Subject: Re: [RFC PATCH v4 3/3] KVM: selftests: dirty_log_perf_test: Add dirty-ring support
Date: Wed, 29 Jul 2026 17:46:19 +0100
Message-ID: <amouW-HY8mHWnf_3@LeoBrasDK>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260729162606.06EA91F00A3A@smtp.kernel.org>
References: <20260729161519.3778839-2-leo.bras@arm.com> <20260729161519.3778839-5-leo.bras@arm.com> <20260729162606.06EA91F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

On Wed, Jul 29, 2026 at 04:26:05PM +0000, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> - [Medium] Lock contention wait time is incorrectly attributed to guest execution time instead of dirty ring clearing time.
> --
> 
> --- Patch [3]: [RFC PATCH v4 3/3] KVM: selftests: dirty_log_perf_test: Add dirty-ring support ---
> commit 314e5490e434eab524cfacd4f66a4c83a152147e
> Author: Leonardo Bras <leo.bras@arm.com>
> 
> KVM: selftests: dirty_log_perf_test: Add dirty-ring support
>     
> This commit adds dirty-ring tracking support to dirty_log_perf_test.
> This allows comparing the performance of the dirty-ring mechanism against
> the existing dirty-bitmap implementation.
> 
> > diff --git a/tools/testing/selftests/kvm/dirty_log_perf_test.c b/tools/testing/selftests/kvm/dirty_log_perf_test.c
> > index 69b38791440e7..6e80d36cc61a3 100644
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
> Will this clock_gettime() placement exclude the mutex lock contention time
> from the collected clearing metric?
> 
> By taking the start time after acquiring the mutex, any time spent waiting
> for the lock will not be included in the 'collect' time.

Yes, that's supposed to measure the time spent on cleaning the dirty-bits, 
not the time waiting for possible contention, as contention is not 
predictable and would affect the perception of improvements in 
dirty-cleaning.

> 
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
> > +			vcpu_dirty_ring_collect[vcpu_idx] = collect;
> > +		}
> 
> [Severity: Medium]
> Does subtracting this incomplete 'collect' time strand the lock contention time
> inside the guest execution time?
> 
> Since the lock contention time is excluded from 'collect' in
> dirty_ring_collect(), subtracting it from the total 'ts_diff' leaves the
> contention time attributed to the guest execution time rather than the
> dirty ring clearing time.
> 
> Could this artificially inflate the guest execution metric when multiple
> vCPUs contend on the lock?

Yes, but that's the tradeoff think works best.
Alternativelly, we could:  
- Get the lock inside the cleaning time, which would cause contention to be 
  accounted as cleaning, which is terrible for getting reproducible 
  results, or
- Exclude the contention time from both cleaning and guest_execution, which 
  would make code more complex, possibly adding a third time log 
  "contention"

I could swich to the second approach if anybody cares about the inflation 
of guest execution times, and don't care if time spent is not accounted.

Thanks!
Leo
