Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBBEA31ED8B
	for <kvm@vger.kernel.org>; Tue,  2 Jun 2026 02:46:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780368365; cv=none; b=mXpIHEaAdxYnKrqgvl0IbQce4OhJNU9ZBDpK21oFABMxZ0kxub6baxnMtU1db1pN2glY6ep/gHbYNLLyoYrZOLcz4QY3/Ba+L3X9aN8Ijn79uKdi5EHlm/QyPKoLUqast0rEyYQJv5PDmJp7KLhBXDQ0EPyDfbX7VPl6lE81z/M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780368365; c=relaxed/simple;
	bh=U+UvGn1DBDyhvwMIIjPk8lIjjUVoVrn9E9mZIq7w55Y=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=p3ectQSLCjHUGNpw1XRrq6UjYMb/yMfXHuo+z0Opp4A4thSSNQN3IUIXSuNklM7YZyDcb6TNjkc7IsQcP7H6xYxESFAth4r0PG25UcRP531tFh0gp+n2cQZ4yGXZnoxho5o+RD+WM2m3nFYtpzI0OUdsgq7eVrsYpfxJGtYyHak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=A8e5+vry; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="A8e5+vry"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E9F661F00893;
	Tue,  2 Jun 2026 02:46:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780368364;
	bh=BDzpnHWGHkRRfED2E7/SkrgBDlGKefHH7KyzVyjf7SM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=A8e5+vryY79u6vXWIgFKgDCk/W11XOOKM624lMqlDq7Q2FiKjrvlgDJ0RcNk6UNpV
	 Bd5xbBDDztH58LGijTyTBWXfQbYiCKHxjHGJVgZmMzEaPMRs4mc8M/h9ucKf51kFy5
	 FTCrKDlhx9ZCvO/shVyX5QOL76tVkEEyeufMpYu1N8RwDuy0xAsh1WUTr79lVn1YW8
	 DJTPA5FtocsaQiiMJkuWR9iZlxVt9Yy4QBsFqhl9LbAgD2HulTbQBHnLl927IEHZYt
	 1eGnALD+Q1uc7ZWfmT6Dj8waDJmsKf8YOd4c9YQ7G+17/CBhO5Hfs4noqg673GHUA9
	 tm1u1LOKB05QA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 3/4] LoongArch: KVM: Implement guest-side PV TLB
 flush
Reply-To: sashiko-reviews@lists.linux.dev
To: "Tao Cui" <cui.tao@linux.dev>
Cc: kvm@vger.kernel.org
In-Reply-To: <20260602021819.2373404-4-cui.tao@linux.dev>
References: <20260602021819.2373404-4-cui.tao@linux.dev>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 02 Jun 2026 02:46:03 +0000
Message-Id: <20260602024603.E9F661F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] kvm_flush_tlb_mask() accesses a per-CPU cpumask without disabling =
preemption, creating a severe data race.
--

commit d7f218c526b255a23f8247a1f67b9091d6410ff4
Author: Tao Cui <cuitao@kylinos.cn>

LoongArch: KVM: Implement guest-side PV TLB flush

Add the guest-side implementation of PV TLB flush for LoongArch KVM
guests, complementing the host-side support added in the previous commit.

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
> +
> +	cpumask_copy(flushmask, cpumask);

[Severity: High]
Does this per-CPU mask access require preemption to be disabled?

Looking at callers like flush_tlb_all(), flush_tlb_kernel_range(), and
flush_tlb_one(), it appears they call kvm_flush_tlb_mask() directly without
first disabling preemption. The fallback on_each_cpu() macro disables
preemption internally, but this new paravirt path does not.

If the task is preempted and migrated to another CPU after fetching the
local CPU's flushmask pointer, could it concurrently modify the original
CPU's mask alongside another task scheduled on that CPU?

Also, would this trigger a warning with CONFIG_DEBUG_PREEMPT since
this_cpu_cpumask_var_ptr() uses this_cpu_ptr() under the hood?

[ ... ]
> diff --git a/arch/loongarch/kernel/smp.c b/arch/loongarch/kernel/smp.c
> index 50922610758ba..bb3451b057ed2 100644
> --- a/arch/loongarch/kernel/smp.c
> +++ b/arch/loongarch/kernel/smp.c
> @@ -727,7 +727,10 @@ static void flush_tlb_all_ipi(void *info)
> =20
>  void flush_tlb_all(void)
>  {
> -	on_each_cpu(flush_tlb_all_ipi, NULL, 1);
> +	if (pv_tlb_flush_enabled())
> +		kvm_flush_tlb_mask(cpu_online_mask, flush_tlb_all_ipi, NULL);
> +	else
> +		on_each_cpu(flush_tlb_all_ipi, NULL, 1);
>  }

[Severity: High]
Are we missing a preempt_disable() around this call to kvm_flush_tlb_mask()?

Because kvm_flush_tlb_mask() accesses a per-CPU cpumask immediately upon
entry, calling it with preemption enabled could cause data races if the
task migrates to another CPU.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260602021819.2373=
404-1-cui.tao@linux.dev?part=3D3
