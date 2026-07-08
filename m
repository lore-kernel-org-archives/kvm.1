Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 712432D249E
	for <kvm@vger.kernel.org>; Wed,  8 Jul 2026 15:15:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783523743; cv=none; b=r8JBa3ChoqsuKnnKI0aaeFwUXSg8SMrY3py33N2qNZJzlGrZrnlbBjktZJSZPhHFecpOkXZbYQpYWMriD37Am96Pbzj8hO0poQl8LY3RUYjeMjSD8QFo3ew6WzgFRVziv7rXgeu+mMRb1tpUdcOGsJrVSl8YuKHYpRlnjP4S2xs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783523743; c=relaxed/simple;
	bh=EZfQJXw8FOXYjD5PyG+fxKzy0HOsT6OQLm/HB2Fq3zE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type:Content-Disposition; b=WGFiDfsiBj0lF14XrNWqs8YLZ0iXQgBsTVdpnoHpDRFV+4jMedRNt8ftr2QbH4Rh6bAjc4eLDMNujKtE6gCxZMhDAW3yAygBZF51XTa4NV0IVYcFDxsaNKdWQuYdo1LYKdQvPVRkVaphQr6gsTJp3ML61hUtLpDYGrkC+HW3nPU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=RIaWsffP; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="RIaWsffP"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8C5DF1CDD;
	Wed,  8 Jul 2026 08:15:36 -0700 (PDT)
Received: from LeoBrasDK.cambridge.arm.com (LeoBrasDK.cambridge.arm.com [10.2.212.21])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 44BE43F66F;
	Wed,  8 Jul 2026 08:15:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1783523740; bh=EZfQJXw8FOXYjD5PyG+fxKzy0HOsT6OQLm/HB2Fq3zE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=RIaWsffPpLPPxUqNqBG4Qe4xZn9HW/I112ao823Ui6IEFOGpY+Jq+cvfpd1Zbwmu+
	 LVI3eTQdUWzfsctEFJyH0whb2WJQa0xzJcEGE6dZAPWk5zFfmcs0F76q6QWmqtEAAG
	 3+qLxC6+Pil+VUBhFD3UpESs0ojcKBNYNdTvFcnk=
From: Leonardo Bras <leo.bras@arm.com>
To: sashiko-reviews@lists.linux.dev
Cc: Leonardo Bras <leo.bras@arm.com>,
	kvm@vger.kernel.org
Subject: Re: [RFC PATCH v2 3/3] KVM: selftests: dirty_log_perf_test: Add dirty-ring support
Date: Wed,  8 Jul 2026 16:15:35 +0100
Message-ID: <ak5pl43Dp2vIil8H@LeoBrasDK>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260629111403.99B061F000E9@smtp.kernel.org>
References: <20260629105950.1790259-1-leo.bras@arm.com> <20260629105950.1790259-4-leo.bras@arm.com> <20260629111403.99B061F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

On Mon, Jun 29, 2026 at 11:14:03AM +0000, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 2 potential issue(s) to consider:
> - [Medium] The return value of `kvm_vm_reset_dirty_ring` is checked for `< 0` using an unsigned integer, which silently masks ioctl failures.
> - [Medium] Incompatible and misleading performance metric aggregation for dirty-ring vs. dirty-bitmap.
> --
> 
> commit d0262c7100918c7ec336d54627e1c035fb7368ec
> Author: Leonardo Bras <leo.bras@arm.com>
> 
> KVM: selftests: dirty_log_perf_test: Add dirty-ring support
> 
> This commit adds dirty-ring support to dirty_log_perf_test, allowing it to
> be used alongside dirty-bitmap for performance comparisons.
> 
> > diff --git a/tools/testing/selftests/kvm/dirty_log_perf_test.c b/tools/testing/selftests/kvm/dirty_log_perf_test.c
> > index 69b38791440e7..9bb14340bff5a 100644
> > --- a/tools/testing/selftests/kvm/dirty_log_perf_test.c
> > +++ b/tools/testing/selftests/kvm/dirty_log_perf_test.c
> [ ... ]
> > @@ -29,9 +30,41 @@ static bool run_vcpus_while_disabling_dirty_logging;
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
> 
> [ ... ]
> 
> > +	*ring_idx = idx;
> > +
> > +	ret = kvm_vm_reset_dirty_ring(vcpu->vm);
> > +
> > +	TEST_ASSERT(ret >= 0, "Error (%d) found when cleaning dirty-ring\n", ret);
> 
> [Severity: Medium]
> Will this TEST_ASSERT ever fail? The 'ret' variable is declared as a u32 above,
> so the condition 'ret >= 0' will always be true, masking negative error codes
> if kvm_vm_reset_dirty_ring() fails.

kvm_vm_reset_dirty_ring() returns a u32, but the ioctl syscall used always 
return an int. In further investigation, I figured that the cleaning ioctl 
KVM_RESET_DIRTY_RINGS will always return a positive integer, and never an 
error, so it's pointeless testing for error in this.

As per previous review, it makes no sense to check per-vcpu counting, as 
the syscall will count reset entries on all vcpus that collected their 
per-cpu dirty-rings.

Options are: 
1 - No assert testing
2 - Assert testing only if nr_vcpus=1
3 - Hold a per-vm lock, 1 vcpu collect/clean at a time

> 
> > +
> > +	*ts = timespec_add(*ts, timespec_elapsed(start));
> > +}
> 
> [ ... ]
> 
> > @@ -195,6 +247,21 @@ static void run_test(enum vm_guest_mode mode, void *arg)
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
> > +
> > +			clear_dirty_log_total = timespec_add(clear_dirty_log_total,
> > +							     iteration_sum);
> 
> [Severity: Medium]
> Does summing concurrent vCPU times here produce an accurate comparison against
> the single-threaded wall-clock metric used for the dirty-bitmap?
> 
> Since vcpu_dirty_ring_collect[] measures time collected concurrently across
> vCPUs, linearly adding them inflates 'clear dirty ring time' compared to
> the 'clear dirty log time' which seems to just measure the elapsed time
> on the main thread.

The amount of dirty-pages should not change, as every vcpu will only add 
a page to their ring if it was the first to dirty it.

What causes the increased time is probably the fact that multiple vcpus 
waiting to reset their pages will wait on the syscall, as the dirty_ring 
reset will be serialized by kvm.slots_lock.

Above mentioned waiting time gets summed up in current implementation.

I know it's not the best solution, but I will add a userspace mutex to make 
sure time is accounted for one vcpu at a time.
It will keep time 'comparable' to dirty-bitmap, and also be able to assert 
if every ioctl cleaned all it was requested.

As it, on purpose, ignores the 'waiting for mutex' time it will fail to 
reflect the impact of concurrency on the lock, which could be relevant for 
some scenarios, but that's the trade of.

> 
> > +			continue;
> > +		}
> 
> -- 
> Sashiko AI review · https://sashiko.dev/#/patchset/20260629105950.1790259-1-leo.bras@arm.com?part=3
