Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E259A30FF31
	for <kvm@vger.kernel.org>; Wed, 24 Jun 2026 17:29:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782322152; cv=none; b=vCmSLgaWNX4ScXgamXz2wqSSYafyuyWntXJ5yhGiL3umqCU/CTEdMBOkHkrff4q5wIqeb4EpOCnNiCc4a/yuBMvSUKKmfucJi9ldurYbvWwHnB045o6xUEai9i2WywkFF2hfxNrUDlQHl9b56Tp4tW1OH7u9K44YnkdnKkiEjqc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782322152; c=relaxed/simple;
	bh=F/iWQZtwC9xedcCRJSorKO6BbN/7dXnw1ZajW3wFAqs=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=jDhq9U7eU9iNdP8wvLRYZ47Or7WrpHyZHc0fR9G53Ulg8NNeLAYCT0xmBSK5/3pqsx5p7PshR//Z9l5ac1+Q2lgpRBsYRmG6dGTfxhasMCKDMXuvvlDPcS2m/vr3hg3/yA7LJpelWG3c0P+Mv7DYFnLCG2GvvSx2UeKBzy3UTcc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LQmxQ9N9; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LQmxQ9N9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5AB821F000E9;
	Wed, 24 Jun 2026 17:29:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782322150;
	bh=DsU86h9Emtg/htxbuVBRZy5ClLsUO9EZZHMQzxVOQh4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=LQmxQ9N9Q5xrwYWB5mEFFfVROdZXfUT6HtJXB6ZgfgB0ck+pn8Hzay00V+xJV16JS
	 Yn9qSa6I3a6azmmgHm9JMwxL/PPMlMKYqJ5BYD9HLHKTp6Dc+UPA22XWipRsaPCZJV
	 kpk4/ydsjWZuGse3qiJ6Rupv4FYtjvC9y6Y2RgzL9Ph9WBfNqfTQt6GUL+WaSNhTmM
	 QmeAoUacdMVR5HJt6aQppNOI6zGiPjZFYnJf4WrQX5txBxJ17QU3zuS+oTN/PJM1Fw
	 5raWnhuoeWLsO5GF0LE0PwaXVPblIGqvGg3cIrMcD5kxgs30t4O2g70SEqWn2riWQH
	 9oa5tHtZRemfQ==
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH 3/3] KVM: selftests: dirty_log_perf_test: Add
 dirty-ring support
Reply-To: sashiko-reviews@lists.linux.dev
To: "Leonardo Bras" <leo.bras@arm.com>
Cc: kvm@vger.kernel.org
In-Reply-To: <20260624171656.1737580-4-leo.bras@arm.com>
References: <20260624171656.1737580-1-leo.bras@arm.com>
 <20260624171656.1737580-4-leo.bras@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 24 Jun 2026 17:29:09 +0000
Message-Id: <20260624172910.5AB821F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 4 potential issue(=
s) to consider:
- [Medium] dirty_ring_collect() computes array indices using the dirty ring=
 size in bytes rather than the number of elements, causing a severe out-of-=
bounds memory access.
- [Medium] The do-while loop in vcpu_worker() terminates prematurely becaus=
e it incorrectly checks the _vcpu_run() return value instead of the KVM exi=
t reason, artificially shortening the workload.
- [Medium] Concurrent calls to kvm_vm_reset_dirty_ring() by multiple vCPU t=
hreads cause a TEST_ASSERT failure because the VM-wide reset count is compa=
red against a thread-local harvested count.
- [Medium] The elapsed time calculation for clearing the dirty ring incorre=
ctly aggregates parallel CPU time instead of serial wall-clock time, causin=
g an unfair comparison with the dirty-bitmap mechanism.
--

commit 70a79bc8da1cc1134a0b9d174c9a32912039dc85
Author: Leonardo Bras <leo.bras@arm.com>
Subject: KVM: selftests: dirty_log_perf_test: Add dirty-ring support

dirty_log_test supports both dirty-bitmap and dirty-ring as dirty-page
tracking mechanisms, while dirty_log_perf_test only supports dirty-bitmap.
Add support to dirty-ring on dirty_log_perf_test so it can be used to
compare performance between changes in the mechanism.

> diff --git a/tools/testing/selftests/kvm/dirty_log_perf_test.c b/tools/te=
sting/selftests/kvm/dirty_log_perf_test.c
> index 69b38791440e7..659efa679bc74 100644
> --- a/tools/testing/selftests/kvm/dirty_log_perf_test.c
> +++ b/tools/testing/selftests/kvm/dirty_log_perf_test.c
[ ... ]
> @@ -29,9 +30,43 @@ static bool run_vcpus_while_disabling_dirty_logging;
> =20
>  /* Host variables */
>  static u64 dirty_log_manual_caps;
> +static u32 dirty_ring_size;
>  static bool host_quit;
>  static int iteration;
>  static int vcpu_last_completed_iteration[KVM_MAX_VCPUS];
> +static struct timespec vcpu_dirty_ring_collect[KVM_MAX_VCPUS];
> +
> +static void dirty_ring_collect(struct kvm_vcpu *vcpu, u32 *ring_idx,
> +				struct timespec *ts)
> +{
> +	struct timespec start;
> +	struct kvm_dirty_gfn *dirty_gfns =3D vcpu_map_dirty_ring(vcpu);
> +	u32 ret, idx =3D *ring_idx;
> +	u32 ring_size =3D vcpu->vm->dirty_ring_size;
> +
> +	clock_gettime(CLOCK_MONOTONIC, &start);
> +
> +	while (true) {
> +		struct kvm_dirty_gfn *cur;
> +
> +		cur =3D &dirty_gfns[idx % ring_size];

[Severity: Medium]
Since the ring size is configured in bytes (e.g., in main() via
dirty_ring_size *=3D sizeof(struct kvm_dirty_gfn)), does using it here as a
modulo for indexing into an array of structs cause out-of-bounds memory
accesses?

> +		if (smp_load_acquire(&cur->flags) !=3D KVM_DIRTY_GFN_F_DIRTY)
> +			break;
> +
> +		smp_store_release(&cur->flags, KVM_DIRTY_GFN_F_RESET);
> +		idx++;
> +	}
> +
> +	idx -=3D *ring_idx;
> +	*ring_idx +=3D idx;
> +
> +	ret =3D kvm_vm_reset_dirty_ring(vcpu->vm);
> +
> +	TEST_ASSERT(ret =3D=3D idx, "Reset dirty pages (%u) mismatch "
> +		    "with collected (%u)", ret, idx);

[Severity: Medium]
Will this assertion falsely fail under concurrency?

The kvm_vm_reset_dirty_ring() call performs a VM-wide reset of the dirty
rings for all vCPUs.

In a multi-vCPU test, is it possible for one thread's ioctl call to reap
reset entries prepared by other threads, resulting in a return value greater
than its local idx count?

> +
> +	*ts =3D timespec_add(*ts, timespec_elapsed(start));
> +}
> =20
>  static void vcpu_worker(struct memstress_vcpu_args *vcpu_args)
>  {
[ ... ]
> @@ -43,19 +78,36 @@ static void vcpu_worker(struct memstress_vcpu_args *v=
cpu_args)
>  	struct timespec ts_diff;
>  	struct timespec total =3D (struct timespec){0};
>  	struct timespec avg;
> +	bool use_dirty_ring =3D !!vcpu->vm->dirty_ring_size;
> +	u32 ring_idx =3D 0;
>  	int ret;
> =20
>  	run =3D vcpu->run;
> =20
>  	while (!READ_ONCE(host_quit)) {
>  		int current_iteration =3D READ_ONCE(iteration);
> +		struct timespec collect =3D (struct timespec){0};
> =20
>  		clock_gettime(CLOCK_MONOTONIC, &start);
> -		ret =3D _vcpu_run(vcpu);
> +
> +		do {
> +			ret =3D _vcpu_run(vcpu);
> +			if (!use_dirty_ring)
> +				break;
> +
> +			dirty_ring_collect(vcpu, &ring_idx, &collect);
> +		} while (ret =3D=3D KVM_EXIT_DIRTY_RING_FULL);

[Severity: Medium]
Does this loop terminate prematurely because it compares the return value of
_vcpu_run() instead of the KVM exit reason?

_vcpu_run() returns the ioctl status (0 on success), not the exit reason.

This means the condition evaluates to while (0 =3D=3D KVM_EXIT_DIRTY_RING_F=
ULL)
and will exit after the very first dirty ring fill.

> +
>  		ts_diff =3D timespec_elapsed(start);
> =20
> +		if (use_dirty_ring) {
> +			ts_diff =3D timespec_sub(ts_diff, collect);
> +			vcpu_dirty_ring_collect[vcpu_idx] =3D collect;
> +		}
> +
>  		TEST_ASSERT(ret =3D=3D 0, "vcpu_run failed: %d", ret);
[ ... ]
> @@ -195,6 +250,21 @@ static void run_test(enum vm_guest_mode mode, void *=
arg)
>  		pr_info("Iteration %d dirty memory time: %ld.%.9lds\n",
>  			iteration, ts_diff.tv_sec, ts_diff.tv_nsec);
> =20
> +		if (dirty_ring_size) {
> +			struct timespec iteration_sum =3D (struct timespec){0};
> +
> +			for (i =3D 0; i < nr_vcpus; i++)
> +				iteration_sum =3D timespec_add(iteration_sum,
> +							     vcpu_dirty_ring_collect[i]);
> +
> +			pr_info("Iteration %d clear dirty ring time: %ld.%.9lds\n",
> +				iteration, iteration_sum.tv_sec, iteration_sum.tv_nsec);

[Severity: Medium]
Does aggregating the parallel execution times of all vCPU threads into
iteration_sum artificially inflate the reported dirty-ring clearing time?

The dirty-bitmap mechanism measures sequential wall-clock time in the main
thread. By summing parallel CPU times here (which scales linearly with the
number of vCPUs), it seems this will produce misleading performance metrics
when comparing the two mechanisms.

> +
> +			clear_dirty_log_total =3D timespec_add(clear_dirty_log_total,
> +							     iteration_sum);
> +			continue;
> +		}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260624171656.1737=
580-1-leo.bras@arm.com?part=3D3
