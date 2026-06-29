Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D8AF36C9ED
	for <kvm@vger.kernel.org>; Mon, 29 Jun 2026 11:14:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782731645; cv=none; b=Cq39sGOGVM48N12XNJovL8jlc9JQqPC0oo+p4tCwJVg/DooUkQleDBHMnUZ9A3dyk5BCW/mkG8qxA5pzOQ2ZUkj4sllykCzfxN6SKJaAcKlV/xseOTHemZsbE9bKzRZ8rOf86wSxykqGor9iBeMyizIq4wkmC/TJuvQmJnTyVxw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782731645; c=relaxed/simple;
	bh=frkeCdJzSGF5weW8BdPuybhjRSpQDbwpI0loDltyXcQ=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Z2ZLDYSqu1Z345eqKqpP1f1gglZOt7fEIB3y7u5I26mAHFUxQE+2CFweuWnaM6lg66tlfjQfrkme6b8Ux3hUlt4Uo5HpePG2tPRc4ZiphxYZM59a4KiH22rm3AltxIxqbOht1EfM3Ozw1/ye56slM8bFbBUbG/0rED0Gpwrw7Vo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nBwqbCM0; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nBwqbCM0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 99B061F000E9;
	Mon, 29 Jun 2026 11:14:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782731643;
	bh=0YYQvSc4ebTxcbnzv4ZM6ARzpCzaLSjk67XRFznK37s=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=nBwqbCM0eNYcDcpig8oL4fdpA+Csa1aQG/vtPAPETw790zAn0snS5rV5VfW2mIvet
	 /w/Xwvl0XmiD/5zZlseLp0MB9dYb/QERr1AwfAEhI8XQkn73ezfhbtt0gkghVmgbTW
	 xVDC/rdQ/SnS1rt0eYxlW1xUwSbVQaD8+InD9GVU+yLgYTNnaQCx4Ieh5TJhbMVB2Q
	 eTykZsu3c3Cx7arwDmxxSHGwFM0CVhhpgin/vj1iu65PiH5LS3qzdWITJAZ69iHiEc
	 m8Zf13+/R/c6aNe6biCvQS3zXWSb3cZX9OwfV+UpRDh0YOMXJR4JTXaQ9wiseWa5LY
	 nLmZd4nRKzHWQ==
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH v2 3/3] KVM: selftests: dirty_log_perf_test: Add
 dirty-ring support
Reply-To: sashiko-reviews@lists.linux.dev
To: "Leonardo Bras" <leo.bras@arm.com>
Cc: kvm@vger.kernel.org
In-Reply-To: <20260629105950.1790259-4-leo.bras@arm.com>
References: <20260629105950.1790259-1-leo.bras@arm.com>
 <20260629105950.1790259-4-leo.bras@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 29 Jun 2026 11:14:03 +0000
Message-Id: <20260629111403.99B061F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [Medium] The return value of `kvm_vm_reset_dirty_ring` is checked for `< =
0` using an unsigned integer, which silently masks ioctl failures.
- [Medium] Incompatible and misleading performance metric aggregation for d=
irty-ring vs. dirty-bitmap.
--

commit d0262c7100918c7ec336d54627e1c035fb7368ec
Author: Leonardo Bras <leo.bras@arm.com>

KVM: selftests: dirty_log_perf_test: Add dirty-ring support

This commit adds dirty-ring support to dirty_log_perf_test, allowing it to
be used alongside dirty-bitmap for performance comparisons.

> diff --git a/tools/testing/selftests/kvm/dirty_log_perf_test.c b/tools/te=
sting/selftests/kvm/dirty_log_perf_test.c
> index 69b38791440e7..9bb14340bff5a 100644
> --- a/tools/testing/selftests/kvm/dirty_log_perf_test.c
> +++ b/tools/testing/selftests/kvm/dirty_log_perf_test.c
[ ... ]
> @@ -29,9 +30,41 @@ static bool run_vcpus_while_disabling_dirty_logging;
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

[ ... ]

> +	*ring_idx =3D idx;
> +
> +	ret =3D kvm_vm_reset_dirty_ring(vcpu->vm);
> +
> +	TEST_ASSERT(ret >=3D 0, "Error (%d) found when cleaning dirty-ring\n", =
ret);

[Severity: Medium]
Will this TEST_ASSERT ever fail? The 'ret' variable is declared as a u32 ab=
ove,
so the condition 'ret >=3D 0' will always be true, masking negative error c=
odes
if kvm_vm_reset_dirty_ring() fails.

> +
> +	*ts =3D timespec_add(*ts, timespec_elapsed(start));
> +}

[ ... ]

> @@ -195,6 +247,21 @@ static void run_test(enum vm_guest_mode mode, void *=
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
> +
> +			clear_dirty_log_total =3D timespec_add(clear_dirty_log_total,
> +							     iteration_sum);

[Severity: Medium]
Does summing concurrent vCPU times here produce an accurate comparison agai=
nst
the single-threaded wall-clock metric used for the dirty-bitmap?

Since vcpu_dirty_ring_collect[] measures time collected concurrently across
vCPUs, linearly adding them inflates 'clear dirty ring time' compared to
the 'clear dirty log time' which seems to just measure the elapsed time
on the main thread.

> +			continue;
> +		}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260629105950.1790=
259-1-leo.bras@arm.com?part=3D3
