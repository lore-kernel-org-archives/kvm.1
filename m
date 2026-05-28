Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5202529C33F
	for <kvm@vger.kernel.org>; Thu, 28 May 2026 15:06:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779980768; cv=none; b=Va1sC++1KSY48rydjRv/WZ19ciXmkUlXbsaYXUkz9Dh7inlyKGYJikebiFM9TbChpYp0HBsoNetxjlAemUrtmiQ3DH+fJQhyJcd53Q+Fv9XWBRE0QB/N2VzHV2jlTgc8uTClEk9hMUHZwjzlgM0QHc6cBg2UUusMkN48ygFvHF8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779980768; c=relaxed/simple;
	bh=dDhwckfcE//IeaFeF/nC4F9d1IEHxYI6VZnYWXZing4=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=L3wHmpOoJpZI66QgpDkjDsNZlTwSM3qwLg95jZO7sm+rxgbXypSYn5le+IGP3/K7CmaflI+DxJnnL+1aIbdlTvTZSMNAGkmBbaLYLFtLrnWVAjicLGZ98bioQQZz7oI1tIyfpvtcLtQ8euu1rhoDYqTkPhDhrPlgf9QQoheRCY0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=h+wvTCSe; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="h+wvTCSe"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B4D141F000E9;
	Thu, 28 May 2026 15:06:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779980765;
	bh=ZlEQW2f4eooCIeN7agnVyCkTOH+eBp0lITxKBu2xpzs=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=h+wvTCSeWArRquJvVZhs0kMI6lDijB0Gz1Uaipop+0eAcHx6RB9Y93Vibtf0QQUld
	 YLhf3uOF3Cvd732z4Xjw3uBq6tH70tycezPD8zOGomMDct2Uk4OSsnbrnsmP+oH8si
	 /gjZ2KqmEnJRnV59mhAJw0HYDEyVT4kCObdPwo/tvitPptV1C5yTlPoaqSybBytta3
	 nISOnRaqvYUfyJ0ozcBlyjqVb4ksaP3cx0AhNT2hRcSmdLQqK0+XEI7/Al5Nh9Renv
	 c1RQ1Y/fozRBDmKgipmdQqXkmlf1bJvHHH8CcsakUILM2CUFxX8HkPF4B2JOQNvFvN
	 P9S3ZMHg8YsiQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 3/4] LoongArch: KVM: Implement guest-side PV TLB
 flush
Reply-To: sashiko-reviews@lists.linux.dev
To: "Tao Cui" <cuitao@kylinos.cn>
Cc: kvm@vger.kernel.org
In-Reply-To: <20260528133558.2196416-4-cuitao@kylinos.cn>
References: <20260528133558.2196416-4-cuitao@kylinos.cn>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 28 May 2026 15:06:05 +0000
Message-Id: <20260528150605.B4D141F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] kvm_flush_tlb_mask() accesses a per-CPU cpumask variable without d=
isabling preemption, leading to data races and mask corruption.
- [Low] Memory leak of cpumasks on allocation failure in pv_tlb_flush_init(=
).
--

commit 307754fac0ebe193667415fd56b7cca8fe390bdb
Author: Tao Cui <cuitao@kylinos.cn>

LoongArch: KVM: Implement guest-side PV TLB flush

This patch adds the guest-side implementation of PV TLB flush for LoongArch
KVM guests, replacing IPIs to preempted vCPUs with shared memory flags.

> diff --git a/arch/loongarch/kernel/paravirt.c b/arch/loongarch/kernel/par=
avirt.c
> index 10821cce554c0..34e3ae2d25016 100644
> --- a/arch/loongarch/kernel/paravirt.c
> +++ b/arch/loongarch/kernel/paravirt.c

[ ... ]

> @@ -208,6 +210,58 @@ int __init pv_ipi_init(void)
>  	return 0;
>  }
> =20
> +#ifdef CONFIG_SMP
> +void kvm_flush_tlb_mask(const struct cpumask *cpumask,
> +			       smp_call_func_t func, void *info)
> +{
> +	int cpu;
> +	struct kvm_steal_time *src;
> +	struct cpumask *flushmask =3D this_cpu_cpumask_var_ptr(__pv_cpu_mask);

[Severity: High]
Does this code safely access the per-CPU cpumask without disabling preempti=
on?

If a caller like flush_tlb_all() or flush_tlb_one() invokes this without
preemption disabled, couldn't the thread be preempted and scheduled on
another CPU, or clobbered by a concurrent TLB flush on the same CPU?

Should operations on the per-CPU mask be enclosed in preempt_disable() and
preempt_enable() to prevent corrupting the IPI mask?

> +
> +	cpumask_copy(flushmask, cpumask);

[ ... ]

> +static int __init pv_tlb_flush_init(void)
> +{
> +	int cpu;
> +
> +	if (!kvm_pv_tlb_flush_supported())
> +		return 0;
> +
> +	for_each_possible_cpu(cpu) {
> +		if (!zalloc_cpumask_var_node(per_cpu_ptr(&__pv_cpu_mask, cpu),
> +					    GFP_KERNEL, cpu_to_node(cpu)))
> +			return -ENOMEM;

[Severity: Low]
Does this error path leak memory?

If zalloc_cpumask_var_node() fails for a CPU, it immediately returns
-ENOMEM without freeing the cpumasks successfully allocated for preceding
CPUs.

> +	}
> +
> +	static_branch_enable(&pv_tlb_flush_key);
> +	pr_info("KVM setup pv remote TLB flush\n");
> +
> +	return 0;
> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260528133558.2196=
416-1-cuitao@kylinos.cn?part=3D3
