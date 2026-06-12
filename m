Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A19228E0
	for <kvm@vger.kernel.org>; Fri, 12 Jun 2026 01:48:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781228916; cv=none; b=IraolXcWiz7YVqVPmJKKQ4UaIwMlFOkINcAZFuQ8L+E4WXbbJt3N3auxugpyH7yqKRJhcXlN85SVg1+oJkLcm491Ino11pUEXBVwUCr4hoqqvW0aiPlWx66eAYDANe6Vs7ljJTcxYycH7Wne+j3dI174rjTLlZU+OJdv1R6AzsM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781228916; c=relaxed/simple;
	bh=LrE/TtccPqGdOvkE2fh4kdUQya5FjGTMR/WWEPp6YG0=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=izkPwA7kdpQJTqQMr0SW4i0WtQO6qGmtkAHbLwdYm0X0qkF7xrS4UOLcVEbrEFtutiqG6mrVvLkR3L3iBu9Jn2a8WNm06qCKSTNWlA2fYaO2jxwj0WaMecb1scOMLa5w9l9b5ixuuc2JWaoIYTA346oQLfuXTIK9ULXXXoYrHLc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aCrF0Mm0; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aCrF0Mm0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 07F5D1F000E9;
	Fri, 12 Jun 2026 01:48:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781228915;
	bh=jx2GDw+srPxlhHRiST+FzTVlyhjh+iHqVc/hNskpg2o=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=aCrF0Mm0yWbnp+Okl30e9uZGONehMg22gYyFs+cLFqmVqz9p8Kt+477QragHjNBpv
	 9m4goYZzIHtLFkKMuz5oQLRiC2fqJkdhBUJ+ADAwkPDFgPsG1FW2ycLz471XtZUP/W
	 ruK8jZ6R8kNnOckiW0ycHC3gVDyzVlJ73Ae19TH7u9ZIRKIdDYMhM0M8S/+VDmTj8N
	 Ozbb8AjNRotlNvIVECtGkx2865iGhD44J7iCiJOZabYPXpwisMdxNJC0VO9X5KSbdB
	 rUBCobZCS4FJDsCBz7Eo/IGHQm9VhxqWJhh1XFpDKVknPtuqa6Ldpds8FubqtspV0l
	 rwHzYNrj0hH1g==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 09/10] KVM: Add IPI-aware directed-yield candidate
 selection
Reply-To: sashiko-reviews@lists.linux.dev
To: "Wanpeng Li" <kernellwp@gmail.com>
Cc: kvm@vger.kernel.org
In-Reply-To: <20260612013355.59231-10-kernellwp@gmail.com>
References: <20260612013355.59231-10-kernellwp@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 12 Jun 2026 01:48:34 +0000
Message-Id: <20260612014835.07F5D1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] The new candidate filter incorrectly excludes woken-up, runnable v=
CPUs from being yield targets by strictly requiring the `preempted` flag.
--

commit f2a5464aa09eda51a02ed6e5f04bf8ea0072c9ba
Author: Wanpeng Li <wanpengli@tencent.com>

KVM: Add IPI-aware directed-yield candidate selection

This commit introduces a priority-based candidate filter for directed yields
in kvm_vcpu_on_spin(). It prefers recent IPI receivers or vCPUs with pending
interrupts before falling back to the legacy preempted heuristic.

> diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
> --- a/virt/kvm/kvm_main.c
> +++ b/virt/kvm/kvm_main.c

[ ... ]

> +static bool kvm_vcpu_is_good_yield_candidate(struct kvm_vcpu *me,
> +					     struct kvm_vcpu *vcpu,
> +					     bool yield_to_kernel_mode)
> +{
> +	/* Priority 1: confirmed recent IPI receiver. */
> +	if (kvm_vcpu_is_ipi_receiver(me, vcpu))
> +		return true;
> +
> +	/* Priority 2: arch-specific pending-interrupt hint. */
> +	if (kvm_arch_dy_has_pending_interrupt(vcpu))
> +		return true;
> +
> +	/* Priority 3: preempted, with optional in-kernel requirement. */
> +	if (!READ_ONCE(vcpu->preempted))
> +		return false;

[Severity: High]
Does this code inadvertently exclude runnable but non-preempted vCPUs
from being yield targets?

In the previous implementation, the preempted check was part of a compound
skip condition:

	if (READ_ONCE(vcpu->preempted) && yield_to_kernel_mode &&
	    !kvm_arch_dy_has_pending_interrupt(vcpu) &&
	    !kvm_arch_vcpu_preempted_in_kernel(vcpu))
		continue;

This meant that if a vCPU was not preempted (for instance, it was recently
woken up from a blocking state and is ready to run), it bypassed the skip
condition and was considered a valid target.

By explicitly returning false here when vcpu->preempted is false, this
new filter seems to drop those valid targets.

> +
> +	if (yield_to_kernel_mode && !kvm_arch_vcpu_preempted_in_kernel(vcpu))
> +		return false;
> +
> +	return true;
> +}

[ ... ]

>  		if (kvm_vcpu_is_blocking(vcpu) && !vcpu_dy_runnable(vcpu))
>  			continue;
> =20
> -		/*
> -		 * Treat the target vCPU as being in-kernel if it has a pending
> -		 * interrupt, as the vCPU trying to yield may be spinning
> -		 * waiting on IPI delivery, i.e. the target vCPU is in-kernel
> -		 * for the purposes of directed yield.
> -		 */
> -		if (READ_ONCE(vcpu->preempted) && yield_to_kernel_mode &&
> -		    !kvm_arch_dy_has_pending_interrupt(vcpu) &&
> -		    !kvm_arch_vcpu_preempted_in_kernel(vcpu))
> -			continue;
> +		if (first_round) {
> +			/* Strict round: IPI-aware and legacy preempted filters. */
> +			if (!kvm_vcpu_is_good_yield_candidate(me, vcpu,
> +							      yield_to_kernel_mode))
> +				continue;
> +		} else {
> +			/*
> +			 * Relaxed round: only require preempted. This is the
> +			 * safety net for missed IPI tracking (e.g. APICv) or
> +			 * transient runnable-set changes since the strict
> +			 * scan.
> +			 */
> +			if (!READ_ONCE(vcpu->preempted))
> +				continue;

[Severity: High]
Similarly, does this relaxed round unconditionally skip non-preempted
vCPUs?

If the vCPU is simply runnable but not marked as preempted, this safety net
will completely bypass it.

>  		}
> =20
>  		if (!kvm_vcpu_eligible_for_directed_yield(vcpu))

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260612013355.5923=
1-1-kernellwp@gmail.com?part=3D9
