Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11D13384250
	for <kvm@vger.kernel.org>; Mon, 20 Jul 2026 23:26:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784590001; cv=none; b=p+jq+TwOHbmmewKvSmKNvgrNRjETgpOk8M4FxCzItNhhm6e+nyUgTiFVHLetP4mCQAZZ0ZghjyXPGlOYlNYPin7rn9TMwP9bdLjkHgvPirWwN3wfmFnHowg/FBBjVrZwhSz8fDIfqxnfYPaMJEV2wQkAylmp21RAzNQJqP6MOKo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784590001; c=relaxed/simple;
	bh=5/qU+GdTjxB6WXWYVq+Gx6ATnIYeKmzZEXmpc3TC8DE=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=f/us7uU0i+G+2zSJTc8DcrHqWs320dyOBqtzzI/KCSuFsNgI1yGtW4xVR/GiyAY8IE/e/ogdwdirMM7daTEgQYU6A5vr/hRZvA3LR3CV9/JVrsEpc+x9JGYcQwWa+qCkpQDOXet07NTGE5rgAmKIWpUmTRqoI2IzPZXSSEuxPSc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Awn3k9MR; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Awn3k9MR"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 764BC1F000E9;
	Mon, 20 Jul 2026 23:26:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784589999;
	bh=Jw7TIsUyDFzEwJ2tQapE3stTYPM5dzRCpcbaWEiM/q8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Awn3k9MRQuSIsBOE8H7fREjpU7hhG6UwxcDBzhLI9YzFSKqtkwHQ6JUP9yqDkpGKt
	 ZICPmlHFNSZMXPxJ7v+0mvVablweRB25q0wRV7nuhUD4oorsaABuAfln34sFNwJUT8
	 9qfOQeaZmhXNmGVR6UiHmnbdO+GIfDSEPKFpp2F5sr11E4sf6Nl7MRacvDw+R1bMoW
	 eecEukJWAdynb8Ck8y1hHtDd0lAO2v7Xv6QJxWi3s0doTdknrmEiIDruS1XfHF5bOG
	 6gxl0TzqpEg2Hr6deAIw0TGjVePVhaQC/thvBZsp19y4cPy7xSaEP1IUmR58vPq03q
	 TMiUgFVxJnOug==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2] KVM: VMX: Cap VMX preemption timer to work around
 Intel errata
Reply-To: sashiko-reviews@lists.linux.dev
To: "Jim Mattson" <jmattson@google.com>
Cc: kvm@vger.kernel.org
In-Reply-To: <20260720231639.1592848-1-jmattson@google.com>
References: <20260720231639.1592848-1-jmattson@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 20 Jul 2026 23:26:39 +0000
Message-Id: <20260720232639.764BC1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] The statically declared variable `preemption_timer_limit` is writte=
n to unconditionally but only read in a conditionally compiled function, ca=
using a `-Wunused-but-set-variable` compiler warning on 32-bit x86 builds.
--

--- Patch [1]: [PATCH v2] KVM: VMX: Cap VMX preemption timer to work around=
 Intel errata ---
commit b70aaa03571b4fcfb574b0df3d82309fea9e8407
Author: Jim Mattson <jmattson@google.com>

KVM: VMX: Cap VMX preemption timer to work around Intel errata

This commit works around an Intel erratum where the VMX-preemption timer
may expire earlier than expected. It limits the timer value based on CPUID
leaf 15H during hardware setup and returns -ERANGE if the shifted delta_tsc
reaches or exceeds this limit.

Closes: https://lore.kernel.org/all/Zn9X0yFxZi_Mrlnt@google.com/

> diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
> index 6b96f7aea20bd..36c765154d827 100644
> --- a/arch/x86/kvm/vmx/vmx.c
> +++ b/arch/x86/kvm/vmx/vmx.c
> @@ -143,6 +143,7 @@ module_param(dump_invalid_vmcs, bool, 0644);
>  /* Guest_tsc -> host_tsc conversion requires 64-bit division.  */
>  static int __read_mostly cpu_preemption_timer_multi;
>  static bool __read_mostly enable_preemption_timer =3D 1;
> +static u64 __read_mostly preemption_timer_limit =3D 1ULL << 32;

[Severity: Low]
Since preemption_timer_limit is read only in vmx_set_hv_timer() which is
conditionally compiled, does this unconditional declaration and later
assignment in vmx_hardware_setup() result in a -Wunused-but-set-variable
compiler warning on 32-bit x86 builds?

[ ... ]

> @@ -8241,12 +8242,12 @@ int vmx_set_hv_timer(struct kvm_vcpu *vcpu, u64 g=
uest_deadline_tsc,
>  		return -ERANGE;
> =20
>  	/*
> -	 * If the delta tsc can't fit in the 32 bit after the multi shift,
> -	 * we can't use the preemption timer.
> +	 * If the delta tsc exceeds the preemption timer limit after the
> +	 * multi shift, we can't use the preemption timer.
>  	 * It's possible that it fits on later vmentries, but checking
>  	 * on every vmentry is costly so we just use an hrtimer.
>  	 */
> -	if (delta_tsc >> (cpu_preemption_timer_multi + 32))
> +	if ((delta_tsc >> cpu_preemption_timer_multi) >=3D preemption_timer_lim=
it)
>  		return -ERANGE;

[ ... ]

> @@ -8630,6 +8651,8 @@ __init int vmx_hardware_setup(void)
>  		cpu_preemption_timer_multi =3D
>  			vmx_misc_preemption_timer_rate(vmcs_config.misc);
> =20
> +		preemption_timer_limit =3D calc_preemption_timer_limit();
> +
>  		if (tsc_khz)
>  			use_timer_freq =3D (u64)tsc_khz * 1000;

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260720231639.1592=
848-1-jmattson@google.com?part=3D1
