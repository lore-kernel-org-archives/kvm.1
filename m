Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 513F245517E
	for <kvm@vger.kernel.org>; Wed, 29 Jul 2026 16:26:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785342372; cv=none; b=HHAQ6UptfWAVPKcrL5qs1lrak2t9Ai4XS7mcy1sWGPWN3zYQsI7xlocHNBOMZHxvYPXfG6GUK4WhT61rXIq18HtAYbkqDv3zL6nF/igH5Daf/k5mB52j3NIOmeAzdjsF+JFKMdBR/2jwFet2CqCoqaRdJCsjlh3fWUgfBbP84R0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785342372; c=relaxed/simple;
	bh=js/gk0bOwiK81KqK4+pXXlkybf6x0fcrzgEmOclGcfk=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=sFckYCnPfUMF6UruaRLIaUkxu6s081BXSmilk6pi48wKc2R+gcXYOmHN7mdlqXSaZpOJG28aJLsys1xu0lFkoJxpmIVqDr2UnlF5PztpBovLgJ6MLFVjJQsbuM3W5pvtFQWp2adI80VS6HQLY5pljBotI7nptfLnUxYOa51xJeQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JpMp9iwm; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JpMp9iwm"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 06EA91F00A3A;
	Wed, 29 Jul 2026 16:26:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785342366;
	bh=kgikkfPzKSZTV2f/YcrZZ7hMRqbxtLjDEKesjAiLt3w=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=JpMp9iwmd6ojx/XapOeLRwtcweyi/so+6eKkwrHln9GhH1yybEAGibSwtMLvBlJUO
	 0l6YnhxnEfWR/TOrVyxFEb5rng8JKMsdVxGftG0BEUppX8A4cTXbDv9+mCDK/Rn0gm
	 cIsGPU2xj4q17mX/hVhsy31BwZoWjWdre06qLfeon0Zjv1mQ6ZqThrsnVRe/YOZODx
	 laQ8cY1ZE3xcXwBUh0Y9MoUMkn+Xm+WJwXvbJCwZUVz6Z37IwSPROZ4PXOHD0f+/nF
	 /NGL3ffhvW5WGegNgnsAsiKOxVj93trleO6YFm6VuJX8Wkw6v+xlVnG9URUVySqFCH
	 H7od9vxOswDNw==
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH v4 3/3] KVM: selftests: dirty_log_perf_test: Add
 dirty-ring support
Reply-To: sashiko-reviews@lists.linux.dev
To: "Leonardo Bras" <leo.bras@arm.com>
Cc: kvm@vger.kernel.org
In-Reply-To: <20260729161519.3778839-5-leo.bras@arm.com>
References: <20260729161519.3778839-2-leo.bras@arm.com>
 <20260729161519.3778839-5-leo.bras@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 29 Jul 2026 16:26:05 +0000
Message-Id: <20260729162606.06EA91F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] Lock contention wait time is incorrectly attributed to guest exe=
cution time instead of dirty ring clearing time.
--

--- Patch [3]: [RFC PATCH v4 3/3] KVM: selftests: dirty_log_perf_test: Add =
dirty-ring support ---
commit 314e5490e434eab524cfacd4f66a4c83a152147e
Author: Leonardo Bras <leo.bras@arm.com>

KVM: selftests: dirty_log_perf_test: Add dirty-ring support
   =20
This commit adds dirty-ring tracking support to dirty_log_perf_test.
This allows comparing the performance of the dirty-ring mechanism against
the existing dirty-bitmap implementation.

> diff --git a/tools/testing/selftests/kvm/dirty_log_perf_test.c b/tools/te=
sting/selftests/kvm/dirty_log_perf_test.c
> index 69b38791440e7..6e80d36cc61a3 100644
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
Will this clock_gettime() placement exclude the mutex lock contention time
from the collected clearing metric?

By taking the start time after acquiring the mutex, any time spent waiting
for the lock will not be included in the 'collect' time.

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
> +			vcpu_dirty_ring_collect[vcpu_idx] =3D collect;
> +		}

[Severity: Medium]
Does subtracting this incomplete 'collect' time strand the lock contention =
time
inside the guest execution time?

Since the lock contention time is excluded from 'collect' in
dirty_ring_collect(), subtracting it from the total 'ts_diff' leaves the
contention time attributed to the guest execution time rather than the
dirty ring clearing time.

Could this artificially inflate the guest execution metric when multiple
vCPUs contend on the lock?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260729161519.3778=
839-2-leo.bras@arm.com?part=3D3
