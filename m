Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7862519909
	for <kvm@vger.kernel.org>; Tue, 29 Sep 2026 11:53:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790682829; cv=none; b=ZsGU8wVqHf2VgPTqDoesYFLOpsZfN2vq990y+RHE+8NPdoDe4w9c7wrVYJ6ZZuYp6wC05B6rftNXOc4ptykwGWa7NU8hsMpuBqJZoeJ9F9LaAFH4LRwMmHcM6qZ2bnhPrxxSU+kr44f+bmQDGlL3hv0Gg2FcE2LAdD3QV9sB1Hc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790682829; c=relaxed/simple;
	bh=g4g2cwMO176VdUCWdqN85c3miIvSOkjBwzz1S4H+4bU=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=k9BmE0eLuYe0KqYZaSdg8Iy37z9ArFI7P6egPTih93Se5p6UM+4BCFFkBmC11hfF562U7I6X4VQXk7UXRAFY4mtNL7pw8rG5ic0N7mNcWU8+tsYkSPtn5TM2uoP0bVaA5fBUH4/JToxGngtQGxFsHHIW+Xr0dvZ9cSRoRrpG/9A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NH/RKKmA; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NH/RKKmA"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5FE831F00898;
	Tue, 29 Sep 2026 11:53:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790682827;
	bh=EnDuh/21BYzQ89nx6t9gdl4Srsee79XVAC5JK9BcWS4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=NH/RKKmACRR4h4ujk8awCTXh3Hy3izUfEqjquDqabEnJ7AKIh/3gGgpFDojOHuxys
	 c+OLxM5uDowG8pl7g1wlCgiNFk+VceJ2KWMV1vF40DSly2I8ljvJ2ISvA2hmMyWlEF
	 AEx75lNbfNtMCG10hIks/MCaMvDrbZ2JDrKYFc9mMHLfLGhsAzQRrWOwtbka1fLTzC
	 8PFbCjp+FLVCYlTYunYZyBexkvj6O1ywhSbKUHtW1/+lpjbAZ6+PRnpmHW/ASaKolr
	 6ql5EbAERn+vpCe9OQC41qUhEufXDXEWnmdbd4S1yJdfDnDQIAUvgaNP1qsMyg752A
	 lgHCnJFJjsM6A==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v1 3/3] KVM: selftests: dirty_log_perf_test: Add
 dirty-ring support
Reply-To: sashiko-reviews@lists.linux.dev
To: "Leonardo Bras" <leo.bras@arm.com>
Cc: kvm@vger.kernel.org
In-Reply-To: <20260929113711.2064390-4-leo.bras@arm.com>
References: <20260929113711.2064390-1-leo.bras@arm.com>
 <20260929113711.2064390-4-leo.bras@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 29 Sep 2026 11:53:46 +0000
Message-Id: <20260929115347.5FE831F00898@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] kvm: selftests: dirty ring collection time excludes lock wait ti=
me
--

commit 2c539bfee74e383775f9c7f30033144876ad2f45
Author: Leonardo Bras <leo.bras@arm.com>

KVM: selftests: dirty_log_perf_test: Add dirty-ring support

This commit adds dirty-ring support to the dirty_log_perf_test to enable
performance comparisons between dirty-bitmap and dirty-ring tracking
mechanisms.

> diff --git a/tools/testing/selftests/kvm/dirty_log_perf_test.c b/tools/te=
sting/selftests/kvm/dirty_log_perf_test.c
> index 8f791ad7b86a8..af0ab654d46e2 100644
> --- a/tools/testing/selftests/kvm/dirty_log_perf_test.c
> +++ b/tools/testing/selftests/kvm/dirty_log_perf_test.c
[ ... ]
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
Since the timer is initialized after acquiring the lock, the time spent
waiting for the mutex is not recorded in the collection time. When multiple
vCPUs fill their dirty rings concurrently and wait on this lock, will this
lock contention time be incorrectly omitted from collect?

> +
> +	while (true) {
> +		struct kvm_dirty_gfn *cur;
[ ... ]
> @@ -43,24 +88,45 @@ static void vcpu_worker(struct memstress_vcpu_args *v=
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
> +		} while (!ret && run->exit_reason =3D=3D KVM_EXIT_DIRTY_RING_FULL);
> +
>  		ts_diff =3D timespec_elapsed(start);
> =20
> +		if (use_dirty_ring) {
> +			ts_diff =3D timespec_sub(ts_diff, collect);

[Severity: Medium]
Because collect does not include the lock wait time from
dirty_ring_collect(), subtracting it from ts_diff leaves the lock
contention overhead misattributed to the guest execution time. Doesn't this
artificially inflate the reported guest execution time and obscure the true
overhead of dirty ring synchronization?

> +			vcpu_dirty_ring_collect[vcpu_idx] =3D collect;
> +		}
> +
>  		TEST_ASSERT(ret =3D=3D 0, "vcpu_run failed: %d", ret);

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260929113711.2064=
390-1-leo.bras@arm.com?part=3D3
