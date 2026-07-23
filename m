Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9554143B49B
	for <kvm@vger.kernel.org>; Thu, 23 Jul 2026 11:18:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784805520; cv=none; b=jXrGEB1w9WSWxZAKqhqK3PuTk8qGCCP4scUiN1ZuwOf+hdhTCF+8wACajbQq1zcN8tGSpB6Al2WsakuyO/cB+hF1PAaNPaWHC56EtmMRJ+yx3LKtYnjQiFy+DpK4xVxTizReGqfJxiMUXqFKJGEDwwyFEWpYQHeAqikj8goIf/A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784805520; c=relaxed/simple;
	bh=fdOfMdGREXKmB3BEGnQZXqUymrYIW/o3IFgdwgpH8UI=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=j0V85aXd7Qam/HQyOwFrh8fVc27XTTzFHTSqr827n5RIa5MYkifoqf4sgwdEXRTNrcDXDzn4EYLiCJhXZC3QsxphSGJJh3u/a4m08UmUN3l8VmKG0PYiR6CZP4KQefKO7GiHh0JdIxlyCFHQtBAypd3JjkJP2vntcQ1xRPB0n98=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TH2wvvez; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TH2wvvez"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1385D1F000E9;
	Thu, 23 Jul 2026 11:18:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784805519;
	bh=XU+BzbAbUADrIM+5VwjG6+HJKlMuBo/6LPjA1Ce1G8k=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=TH2wvvezPgQ6VotKIosRzZA9Y9uSMj4CUF8u1/K3FmGrDkYeez+Gbge7pyWAW0/6v
	 eL8wwuzC56H+uQI0DTca9wBHHtLc/N/DoVaAxmF+/uIgLw9C1QvoYujwTCM+9lUt1y
	 DAu7Pr9WQNVaBHh47eIemFT6U6yrrkTFhm1QD853tfsc7DG7pCg+zCzetbsywlwkhB
	 c5rzS2gbPiz6sTeku4VjtsYgEhyRrQjuUk97d8g/iTFm8bxNbOKVw5fBSNmNxnj9Q9
	 0+zTr2A1NrKVo6U5rogf0YU3N+h4qiYchVKNvz4kI1Y9miRbXaFtoeyGRsiwzdHKxj
	 ULFfTWZ1Oy6GQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2] KVM: x86/pmu: Add module param to batch
 emulated-instruction reprograms
Reply-To: sashiko-reviews@lists.linux.dev
To: "Luka Absandze" <absandze@amazon.de>
Cc: kvm@vger.kernel.org
In-Reply-To: <20260723105309.12145-1-absandze@amazon.de>
References: <20260723105309.12145-1-absandze@amazon.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 23 Jul 2026 11:18:34 +0000
Message-Id: <20260723111839.1385D1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:
- [High] Batching emulated counter reprograms delays or permanently loses o=
verflow PMIs and corrupts GLOBAL_STATUS across live migration.
- [Medium] Single-wrap overflow detection in pmc_pause_counter() silently f=
ails if the batched emulated counts exceed the counter's bitmask.
- [Low] Unprotected concurrent read of the `emulated_counter_reprogram_tole=
rance` module parameter.
--

--- Patch [1]: [PATCH v2] KVM: x86/pmu: Add module param to batch emulated-=
instruction reprograms ---
commit 85f50daf9aa2d9bd44f19438d6b61d03c98f6c16
Author: Luka Absandze <absandze@amazon.de>

KVM: x86/pmu: Add module param to batch emulated-instruction reprograms

This patch introduces a module parameter to batch PMU counter reprograms=20
triggered by emulated instructions. It defers the reprogramming until the
accumulated emulated count exceeds the specified tolerance, which reduces
the overhead on VM-entry.

Link: https://lore.kernel.org/kvm/20260720192221.72912-1-absandze@amazon.de/

> diff --git a/arch/x86/kvm/pmu.c b/arch/x86/kvm/pmu.c
> index dd1c57593f48b..33a73271186a5 100644
> --- a/arch/x86/kvm/pmu.c
> +++ b/arch/x86/kvm/pmu.c
[ ... ]
> @@ -39,6 +39,14 @@ bool __read_mostly enable_pmu =3D true;
>  EXPORT_SYMBOL_FOR_KVM_INTERNAL(enable_pmu);
>  module_param(enable_pmu, bool, 0444);
> =20
> +/*
> + * Number of KVM-emulated instructions that may accumulate on an emulated
> + * (perf-based) vPMU counter before KVM forces a counter reprogram to fo=
ld the
> + * emulated count into the backing perf_event
> + */
> +static uint __read_mostly emulated_counter_reprogram_tolerance;
> +module_param(emulated_counter_reprogram_tolerance, uint, 0644);

[Severity: Low]
Since the module parameter is exposed via sysfs with 0644 permissions, the
host administrator can modify it dynamically.=20

Could the unprotected concurrent read of emulated_counter_reprogram_toleran=
ce
in kvm_pmu_incr_counter() lead to inconsistent reads?=20

Using READ_ONCE() when accessing this shared mutable state might prevent
potential compiler optimization issues.

[ ... ]
> @@ -1072,7 +1080,15 @@ static void kvm_pmu_incr_counter(struct kvm_pmc *p=
mc)
>  	 */
>  	if (!kvm_vcpu_has_mediated_pmu(vcpu)) {
>  		pmc->emulated_counter++;
> -		kvm_pmu_request_counter_reprogram(pmc);
> +
> +		/*
> +		 * Batch reprograms: only force one once the accumulated
> +		 * emulated count exceeds the tolerance. The count is still
> +		 * reflected in guest counter reads via pmc->emulated_counter;
> +		 * this only bounds how late an overflow-driven PMI arrives.
> +		 */
> +		if (pmc->emulated_counter > emulated_counter_reprogram_tolerance)
> +			kvm_pmu_request_counter_reprogram(pmc);

[Severity: High]
Does this batching logic risk permanently delaying or dropping overflow
detection and PMI injection?

KVM relies on pmc_pause_counter() during a requested reprogram to detect
overflows and inject PMIs. By deferring the reprogram until the accumulated
emulated count exceeds the tolerance, the logical counter value becomes
decoupled from its overflow state.=20

If the guest stops executing the specific instruction before the tolerance
is reached, the reprogram is never requested and the PMI might be permanent=
ly
lost.

Additionally, during live migration, KVM_GET_MSRS saves the combined counter
value but the unmodified GLOBAL_STATUS. Could the target VM restore the
counter with emulated_counter implicitly zeroed, completely losing the
pending overflow?

[Severity: Medium]
Can deferring the reprogram create an issue with the single-wrap overflow
detection?

If a host administrator sets emulated_counter_reprogram_tolerance to a
pathologically high value like UINT_MAX, pmc->emulated_counter can exceed
the counter's bitmask.=20

Looking at pmc_pause_counter() in arch/x86/kvm/pmu.c:

counter +=3D pmc->emulated_counter;
pmc->counter =3D counter & pmc_bitmask(pmc);
...
return pmc->counter < prev_counter;

If emulated_counter reaches exactly 2^32, adding it to a 32-bit counter
wraps the value exactly once, resulting in pmc->counter =3D=3D prev_counter.
Will the less-than check evaluate to false, causing KVM to miss the overflo=
w?

>  		return;
>  	}
>

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260723105309.1214=
5-1-absandze@amazon.de?part=3D1
