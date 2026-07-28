Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F36F13ABD9D
	for <kvm@vger.kernel.org>; Tue, 28 Jul 2026 15:26:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785252387; cv=none; b=eIwxHI6EmN2ADSO+78mxPRYPZMXiBowBGz1WLleFyakEJlX25am862AWiZwWzQ2tKJnGStpltNbfMgct2/VOqvLEWBMNhzksXR8LLOvcIcLOrK4cAKp7U5SysSZEK0pb7L8L2ZooCI3fRHlUh2HvtNbtmxYrDQ5NssOw+ffIgB8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785252387; c=relaxed/simple;
	bh=lw/tF7r5fBNkCcJO6f/Z7SjU3GgUFACM4PTl+PBuvm0=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=uK4kFVdjwu8Y9eWGrr82TpFdqrwuIuB1VuJdFQOPfeZH2kRtGso0+lPk51usggcGTr3ZOjTOmZ2I+NYjukwlP6zJyq9ZhumNwiupDuQKvUMuK09vYre3mQzPZmFAFjAICF5gQorC8p6M9UEw2UDpzNIK47qaA0NoaW1iArS7grw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=L8eq1TjF; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="L8eq1TjF"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7447F1F000E9;
	Tue, 28 Jul 2026 15:26:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785252385;
	bh=DBL/IFzhSVUiJ2vXlvB2TqyMz4mgxLb1iy/1X36ZB8c=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=L8eq1TjFOzeS2sKc/Jc5zlCrYiki778BF2rovkbjLkp/qitxCiiINSE7e6fEyftc3
	 +K+zXphJk51ATpFFA25OktgB+bafwQO/c9ojQOlMWwuLoN+IoheD0Eo0uHyCZrv2jC
	 AzfqB/XX93N7iQlMxA2Mo7PsWHymtalOKysdbBvybCJOUJIOn8l50Sa2RNU4eJLyYo
	 z0rPv7nSBTsglrh6ImU+gbKRUOZ3YU5f9pRRtHgxRofi9hYVIqv5+r9GVhSozdjWZk
	 3q7mtPs+jAIGFqOLAIlnkaumkgZpQxXWD0KhV6INy9ksj9R2PzuZ7EkgpFVDE7GPX1
	 fCbVjM6FIjpRA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7 26/36] KVM: x86: Cache host vclock_mode for
 masterclock eligibility checks
Reply-To: sashiko-reviews@lists.linux.dev
To: "David Woodhouse" <dwmw2@infradead.org>
Cc: kvm@vger.kernel.org
In-Reply-To: <20260728144954.355376-27-dwmw2@infradead.org>
References: <20260728144954.355376-1-dwmw2@infradead.org>
 <20260728144954.355376-27-dwmw2@infradead.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 28 Jul 2026 15:26:25 +0000
Message-Id: <20260728152625.7447F1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] The patch leaves behind unused static functions (`do_kvmclock_base=
`, `do_monotonic`, `do_realtime`, `read_tsc`, `vgettsc`) and a useless data=
 structure update (`update_pvclock_gtod` updating `pvclock_gtod_data`). Thi=
s causes a build failure under `CONFIG_WERROR` due to `-Wunused-function` a=
nd introduces unnecessary performance overhead on every timekeeper tick.
- [Medium] Lockless accesses to `kvm_host_vclock_mode` lack `READ_ONCE()` a=
nd `WRITE_ONCE()`, which can lead to compiler-optimized double-loads and sp=
urious state transitions.
--

--- Patch [26]: [PATCH v7 26/36] KVM: x86: Cache host vclock_mode for maste=
rclock eligibility checks ---
commit d71eb6f562c183153e68671d8422238c00275229
Author: David Woodhouse <dwmw@amazon.co.uk>

KVM: x86: Cache host vclock_mode for masterclock eligibility checks
   =20
This commit changes KVM to cache the host clocksource mode in a new
kvm_host_vclock_mode variable. It removes the remaining readers of
pvclock_gtod_data, opting to use gtod_is_based_on_tsc() with the cached
value instead.

> diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
> index 32f0550c5c0dd..3f660bdea8a28 100644
> --- a/arch/x86/kvm/x86.c
> +++ b/arch/x86/kvm/x86.c

[ ... ]

> @@ -1155,7 +1156,7 @@ static void kvm_track_tsc_matching(struct kvm_vcpu =
*vcpu, bool update_mclock)
>  	 * accounts for its offset.
>  	 */
>  	bool use_master_clock =3D kvm_use_master_clock(vcpu->kvm) &&
> -				gtod_is_based_on_tsc(gtod->clock.vclock_mode);
> +				gtod_is_based_on_tsc(kvm_host_vclock_mode);

[Severity: Medium]
Should this lockless read of kvm_host_vclock_mode use READ_ONCE()?

Because gtod_is_based_on_tsc() is inline and evaluates the mode multiple
times:

	return mode =3D=3D VDSO_CLOCKMODE_TSC || mode =3D=3D VDSO_CLOCKMODE_HVCLOC=
K;

If the compiler inlines the function and reads the global variable twice,
could a concurrent update during a clocksource change cause both checks
to evaluate to false?

This could cause the code to spuriously drop masterclock usage.

[ ... ]

> @@ -7055,12 +7055,15 @@ static int pvclock_gtod_notify(struct notifier_bl=
ock *nb, unsigned long unused,
>  	update_pvclock_gtod(tk);

[Severity: High]
Does this commit leave behind unused static functions?

With pvclock_gtod_data no longer being read by KVM, it appears
update_pvclock_gtod() is now updating a useless data structure on every
timekeeper tick, which adds unnecessary overhead.

Additionally, does this leave behind static functions like do_kvmclock_base=
(),
do_monotonic(), do_realtime(), read_tsc(), and vgettsc() which are no longer
referenced?

Could this cause a build failure due to -Wunused-function when compiling wi=
th
CONFIG_WERROR?

> =20
>  #ifdef CONFIG_X86_64
> +	kvm_host_vclock_mode =3D
> +		tk->tkr_mono.clock->vdso_clock_mode;

[Severity: Medium]
Should this update to kvm_host_vclock_mode use WRITE_ONCE()?

Since readers access this global variable locklessly, missing WRITE_ONCE()
could lead to compiler-optimized tearing and trigger KCSAN data race warnin=
gs.

> +
>  	/*
>  	 * Disable master clock if host does not trust, or does not use,
>  	 * TSC based clocksource. Delegate queue_work() to irq_work as
>  	 * this is invoked with tk_core.seq write held.
>  	 */
> -	if (!gtod_is_based_on_tsc(pvclock_gtod_data.clock.vclock_mode) &&
> +	if (!gtod_is_based_on_tsc(kvm_host_vclock_mode) &&
>  	    atomic_read(&kvm_guest_has_master_clock) !=3D 0)
>  		irq_work_queue(&pvclock_irq_work);
>  #endif

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260728144954.3553=
76-1-dwmw2@infradead.org?part=3D26
