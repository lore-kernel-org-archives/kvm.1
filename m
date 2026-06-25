Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51F773A783F
	for <kvm@vger.kernel.org>; Thu, 25 Jun 2026 12:41:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782391284; cv=none; b=kXgldgjQZqsqNaLSvmsp+zQL8TP0GsqHJ8WRd93TisM/NIvEcvDxcJKlNhggNfNrviDN3Ds1zUwep0Lq7Gum195+DlB3htgpxhUhetHPb9lNCTeL3kuheu4qEOxOKPwh+xUGh3Kj9BgjHU2xSSk18ZNfQ5hotmMsoX12XeNApZM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782391284; c=relaxed/simple;
	bh=36VUwfc11jh4GcYdG81Y9Zzfigvn0Y3VHGl7vnOI/CE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type:Content-Disposition; b=S7yEq7TziAFP+A2iLiIkxjYA1wrmjQ06UPQLPT1jlUIAS0YT4pc62Ir3LusvQ2Li0Q9Wkvi5WnMV5KEe++y+fmPcUfpTXJqpyQYbT0UwSB40zlr523eGC6iGj3E9reP6D+oD8uLDGv+F8qD2IHTqaPddmu97eqPej9yo55he+jI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=diXFTyLG; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="diXFTyLG"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A066A1713;
	Thu, 25 Jun 2026 05:41:16 -0700 (PDT)
Received: from LeoBrasDK.cambridge.arm.com (LeoBrasDK.cambridge.arm.com [10.2.212.21])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C40DC3F836;
	Thu, 25 Jun 2026 05:41:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1782391281; bh=36VUwfc11jh4GcYdG81Y9Zzfigvn0Y3VHGl7vnOI/CE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=diXFTyLG8sksGNVkJL7fasXQ+R/hL16+8AhqUj6jwJ+EeSO6pVDt836+9YzYOYee9
	 yCUA1F1s9wZ3EdcGRlDRshGZwuAhvnUwP3mBCXZtNUcDg1A+vZ0KjvGN4LzVgTh8vt
	 5zCcIYjcfZ4nC2X7tSN30Js3i5daa8s1gteFxMz0=
From: Leonardo Bras <leo.bras@arm.com>
To: kvm@vger.kernel.org
Cc: Leonardo Bras <leo.bras@arm.com>
Subject: Re: [RFC PATCH 3/3] KVM: selftests: dirty_log_perf_test: Add dirty-ring support
Date: Thu, 25 Jun 2026 13:41:12 +0100
Message-ID: <aj0h6InhWlN7A7-G@LeoBrasDK>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260624172910.5AB821F000E9@smtp.kernel.org>
References: <20260624171656.1737580-1-leo.bras@arm.com> <20260624171656.1737580-4-leo.bras@arm.com> <20260624172910.5AB821F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

On Wed, Jun 24, 2026 at 05:29:09PM +0000, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 4 potential issue(s) to consider:
> - [Medium] dirty_ring_collect() computes array indices using the dirty ring size in bytes rather than the number of elements, causing a severe out-of-bounds memory access.
> - [Medium] The do-while loop in vcpu_worker() terminates prematurely because it incorrectly checks the _vcpu_run() return value instead of the KVM exit reason, artificially shortening the workload.
> - [Medium] Concurrent calls to kvm_vm_reset_dirty_ring() by multiple vCPU threads cause a TEST_ASSERT failure because the VM-wide reset count is compared against a thread-local harvested count.
> - [Medium] The elapsed time calculation for clearing the dirty ring incorrectly aggregates parallel CPU time instead of serial wall-clock time, causing an unfair comparison with the dirty-bitmap mechanism.
> --
> 
> commit 70a79bc8da1cc1134a0b9d174c9a32912039dc85
> Author: Leonardo Bras <leo.bras@arm.com>
> Subject: KVM: selftests: dirty_log_perf_test: Add dirty-ring support
> 
> dirty_log_test supports both dirty-bitmap and dirty-ring as dirty-page
> tracking mechanisms, while dirty_log_perf_test only supports dirty-bitmap.
> Add support to dirty-ring on dirty_log_perf_test so it can be used to
> compare performance between changes in the mechanism.
> 
> > diff --git a/tools/testing/selftests/kvm/dirty_log_perf_test.c b/tools/testing/selftests/kvm/dirty_log_perf_test.c
> > index 69b38791440e7..659efa679bc74 100644
> > --- a/tools/testing/selftests/kvm/dirty_log_perf_test.c
> > +++ b/tools/testing/selftests/kvm/dirty_log_perf_test.c
> [ ... ]
> > @@ -29,9 +30,43 @@ static bool run_vcpus_while_disabling_dirty_logging;
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
> > +	struct timespec start;
> > +	struct kvm_dirty_gfn *dirty_gfns = vcpu_map_dirty_ring(vcpu);
> > +	u32 ret, idx = *ring_idx;
> > +	u32 ring_size = vcpu->vm->dirty_ring_size;
> > +
> > +	clock_gettime(CLOCK_MONOTONIC, &start);
> > +
> > +	while (true) {
> > +		struct kvm_dirty_gfn *cur;
> > +
> > +		cur = &dirty_gfns[idx % ring_size];
> 
> [Severity: Medium]
> Since the ring size is configured in bytes (e.g., in main() via
> dirty_ring_size *= sizeof(struct kvm_dirty_gfn)), does using it here as a
> modulo for indexing into an array of structs cause out-of-bounds memory
> accesses?

Oh, good catch.
Dividing the value by struct size in above ring_size assignment should do 
the trick.

> 
> > +		if (smp_load_acquire(&cur->flags) != KVM_DIRTY_GFN_F_DIRTY)
> > +			break;
> > +
> > +		smp_store_release(&cur->flags, KVM_DIRTY_GFN_F_RESET);
> > +		idx++;
> > +	}
> > +
> > +	idx -= *ring_idx;
> > +	*ring_idx += idx;
> > +
> > +	ret = kvm_vm_reset_dirty_ring(vcpu->vm);
> > +
> > +	TEST_ASSERT(ret == idx, "Reset dirty pages (%u) mismatch "
> > +		    "with collected (%u)", ret, idx);
> 
> [Severity: Medium]
> Will this assertion falsely fail under concurrency?
> 
> The kvm_vm_reset_dirty_ring() call performs a VM-wide reset of the dirty
> rings for all vCPUs.
> 

Uh, I was under the impression that this was a per-vcpu syscall.
My fault for not checking.


> In a multi-vCPU test, is it possible for one thread's ioctl call to reap
> reset entries prepared by other threads, resulting in a return value greater
> than its local idx count?
> 

Yeap, without my previous assumption, I have to rewrite the collecting 
strategy altogether.

 
> > +
> > +	*ts = timespec_add(*ts, timespec_elapsed(start));
> > +}
> >  
> >  static void vcpu_worker(struct memstress_vcpu_args *vcpu_args)
> >  {
> [ ... ]
> > @@ -43,19 +78,36 @@ static void vcpu_worker(struct memstress_vcpu_args *vcpu_args)
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
> > +		} while (ret == KVM_EXIT_DIRTY_RING_FULL);
> 
> [Severity: Medium]
> Does this loop terminate prematurely because it compares the return value of
> _vcpu_run() instead of the KVM exit reason?
> 
> _vcpu_run() returns the ioctl status (0 on success), not the exit reason.
> 
> This means the condition evaluates to while (0 == KVM_EXIT_DIRTY_RING_FULL)
> and will exit after the very first dirty ring fill.

Correct, I missed that too :/
Will fix that.

> 
> > +
> >  		ts_diff = timespec_elapsed(start);
> >  
> > +		if (use_dirty_ring) {
> > +			ts_diff = timespec_sub(ts_diff, collect);
> > +			vcpu_dirty_ring_collect[vcpu_idx] = collect;
> > +		}
> > +
> >  		TEST_ASSERT(ret == 0, "vcpu_run failed: %d", ret);
> [ ... ]
> > @@ -195,6 +250,21 @@ static void run_test(enum vm_guest_mode mode, void *arg)
> >  		pr_info("Iteration %d dirty memory time: %ld.%.9lds\n",
> >  			iteration, ts_diff.tv_sec, ts_diff.tv_nsec);
> >  
> > +		if (dirty_ring_size) {
> > +			struct timespec iteration_sum = (struct timespec){0};
> > +
> > +			for (i = 0; i < nr_vcpus; i++)
> > +				iteration_sum = timespec_add(iteration_sum,
> > +							     vcpu_dirty_ring_collect[i]);
> > +
> > +			pr_info("Iteration %d clear dirty ring time: %ld.%.9lds\n",
> > +				iteration, iteration_sum.tv_sec, iteration_sum.tv_nsec);
> 
> [Severity: Medium]
> Does aggregating the parallel execution times of all vCPU threads into
> iteration_sum artificially inflate the reported dirty-ring clearing time?
> 
> The dirty-bitmap mechanism measures sequential wall-clock time in the main
> thread. By summing parallel CPU times here (which scales linearly with the
> number of vCPUs), it seems this will produce misleading performance metrics
> when comparing the two mechanisms.
> 

The thing, as mentioned above, is that all cpus may call the collecting 
ioctl, and that will drain for all vcpus. 
The time will be kind of proportional to the amount of pages dirtied. 
If the same amount of pages is dirtied between both methods, and the 
number of ioctls is about the same, summing up the time for all vcpus here 
will hold about the same time.

Does the dirty-ring call their cleaning syscall more often, due to it's 
design? yes
But that's supposed to get measured as well, as that's the difference 
between both mechanisms.

Thanks!
Leo
