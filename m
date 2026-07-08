Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01B6B34A78F
	for <kvm@vger.kernel.org>; Wed,  8 Jul 2026 15:36:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783524975; cv=none; b=mILwSbZCre4PJMZYr91/RNX/DaUmmk+D3QStBIADgZ1WRuMavvFNdxyBW4sEK4x1jzAEF0kLL2mRuyyI0Q42yXfm2rrC1R8PukPpBK9BiPowOjQbOWjH4Fe78oErLFRHW50dGV/QImjkpGMCGbGAIV71Z0TmWk13ouDMSkc3ei8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783524975; c=relaxed/simple;
	bh=TUGtX64WJ5vrigosGbXfsdULwsbiCwERm/l55BTskNY=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=evn0xhIp/iPD6g3qd46hWpEazXs9A0eZm8i3ZM/z+YPYrlwUsHxn4P4tLrazZFPCEV7hDtUpJfCUg4N4d96nQWF8YFsgOsyy+7nPMB3kpKhZTs0zvVvtUswJPdtEWknO6/Wc2RSZYZOr4qV0N2gOVGKGCAIjKhkINfJCeLaYj9M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=J5IMFZgR; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="J5IMFZgR"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8F7AF1F000E9;
	Wed,  8 Jul 2026 15:36:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783524973;
	bh=pEtNztU3wIjydz4M1RuLf2AA4qZFv2VTnYxrm0gCrWQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=J5IMFZgR6/TjY3K2So+Jt60N3o6m3lnE+VB8SHcAq7FlRlPTi9ejTO50gKJyzrKFO
	 RdusiyHV05+GE6Hyl89D1JSdSPqG2bpwzfaaqq05u3B7g2W4onLJZZ7JOVvreXAhO+
	 z6KNdB6uwd2Tq8b6++99lD0LBsxfOxmesjyx2lgtYNAwZSoNqM7EBa66NPhODiy6EK
	 ipq0QuUd7uPUH/+RBhNlWD7RLxjocRVqGPdnL5HJov4CMN/NIYGsNuxwLHjkbb9JGT
	 kuIPMxa2haGAEkfSkmqN1m/R8f8iFGgvDM8souM3vAYEdkICZ1NONbkd0byjA4ZgIG
	 ZmbNFb3oPmOwg==
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH v3 3/3] KVM: selftests: dirty_log_perf_test: Add
 dirty-ring support
Reply-To: sashiko-reviews@lists.linux.dev
To: "Leonardo Bras" <leo.bras@arm.com>
Cc: kvm@vger.kernel.org
In-Reply-To: <20260708152232.2568907-4-leo.bras@arm.com>
References: <20260708152232.2568907-1-leo.bras@arm.com>
 <20260708152232.2568907-4-leo.bras@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 08 Jul 2026 15:36:13 +0000
Message-Id: <20260708153613.8F7AF1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [Medium] The 'dirty memory time' metric incorrectly includes the time vCP=
U threads spend waiting for the global `collect` mutex, misattributing it t=
o guest execution time and underreporting dirty ring management overhead.
- [Medium] Lockless synchronization between the vCPU threads and the main t=
hread lacks memory barriers, creating a data race on the `vcpu_dirty_ring_c=
ollect` timespec payload.
--

--- Patch [3]: [RFC PATCH v3 3/3] KVM: selftests: dirty_log_perf_test: Add =
dirty-ring support ---
commit d30bfe94110209591fe009dbe43668ba5266de12
Author: Leonardo Bras <leo.bras@arm.com>

KVM: selftests: dirty_log_perf_test: Add dirty-ring support

dirty_log_test supports both dirty-bitmap and dirty-ring as dirty-page
tracking mechanisms, while dirty_log_perf_test only supports dirty-bitmap.
   =20
Add support to dirty-ring on dirty_log_perf_test so it can be used to
compare performance between changes in the mechanism.

> diff --git a/tools/testing/selftests/kvm/dirty_log_perf_test.c b/tools/te=
sting/selftests/kvm/dirty_log_perf_test.c
> index 69b38791440e7..181f521c9be96 100644
> --- a/tools/testing/selftests/kvm/dirty_log_perf_test.c
> +++ b/tools/testing/selftests/kvm/dirty_log_perf_test.c
> @@ -29,9 +30,53 @@ static bool run_vcpus_while_disabling_dirty_logging;
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
> +	static pthread_mutex_t collect =3D PTHREAD_MUTEX_INITIALIZER;
> +	struct timespec start;
> +	struct kvm_dirty_gfn *dirty_gfns =3D vcpu_map_dirty_ring(vcpu);
> +	u32 idx =3D *ring_idx;
> +	u32 ring_size =3D vcpu->vm->dirty_ring_size / sizeof(struct kvm_dirty_g=
fn);
> +	int cleared, count;
> +
> +	pthread_mutex_lock(&collect);
> +
> +	clock_gettime(CLOCK_MONOTONIC, &start);

[Severity: Medium]
Will this timer placement incorrectly measure performance metrics?

Because clock_gettime() is called after acquiring the collect mutex, the
returned ts will not include any time the vCPU thread spends waiting for the
lock.

Later in vcpu_worker():

	ts_diff =3D timespec_elapsed(start);

	if (use_dirty_ring) {
		ts_diff =3D timespec_sub(ts_diff, collect);
	}

Since collect excludes lock contention time, subtracting it leaves that
contention overhead in ts_diff. Does this result in misattributing lock
contention to guest execution time?

> +
> +	while (true) {
> +		struct kvm_dirty_gfn *cur;

[ ... ]

> @@ -43,17 +88,33 @@ static void vcpu_worker(struct memstress_vcpu_args *v=
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
> +		} while (run->exit_reason =3D=3D KVM_EXIT_DIRTY_RING_FULL);
> +
>  		ts_diff =3D timespec_elapsed(start);
> =20
> +		if (use_dirty_ring) {
> +			ts_diff =3D timespec_sub(ts_diff, collect);
> +			vcpu_dirty_ring_collect[vcpu_idx] =3D collect;
> +		}
> +
>  		TEST_ASSERT(ret =3D=3D 0, "vcpu_run failed: %d", ret);
>  		TEST_ASSERT(get_ucall(vcpu, NULL) =3D=3D UCALL_SYNC,
>  			    "Invalid guest sync status: exit_reason=3D%s",
>  			    exit_reason_str(run->exit_reason));
> =20
>  		pr_debug("Got sync event from vCPU %d\n", vcpu_idx);
>  		vcpu_last_completed_iteration[vcpu_idx] =3D current_iteration;

[Severity: Medium]
Are memory barriers needed for this lockless synchronization?

The worker thread updates vcpu_dirty_ring_collect and then sets
vcpu_last_completed_iteration to signal completion. However, this is done
without store-release semantics.

Meanwhile, the main thread in run_test() spins on the completion flag and
then reads the array:

	for (i =3D 0; i < nr_vcpus; i++) {
		while (READ_ONCE(vcpu_last_completed_iteration[i]) !=3D iteration)
			;
	}
=09
	/* ... */
=09
	if (dirty_ring_size) {
		for (i =3D 0; i < nr_vcpus; i++)
			iteration_sum =3D timespec_add(iteration_sum,
						     vcpu_dirty_ring_collect[i]);
	}

Could weakly-ordered architectures like ARM64 reorder the worker thread's
stores (or the main thread's loads), causing the main thread to read torn or
stale struct timespec data?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260708152232.2568=
907-1-leo.bras@arm.com?part=3D3
