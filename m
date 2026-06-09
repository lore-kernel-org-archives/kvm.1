Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17075285041
	for <kvm@vger.kernel.org>; Tue,  9 Jun 2026 01:03:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780967006; cv=none; b=PhqXp41X2LVbG7Ry1Es3Am3z67UIub/i4K3wftnxGMaI7tb7LgJa569sPClQDzwlj55y2E2pO1BihO1dGmiICtAQamwlcs0lFhqxBfICgSSDn3lo0CMSF278VX/b3OYPtyeOcAqEHAJMoAR3CYZlWyT9cjQx+5msoLYKYxUMoVQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780967006; c=relaxed/simple;
	bh=MJcL//qTSVwVpDu41+UeK4BLnUca14FygczeW0QKPLw=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=BSz4gjA9IR6HAHf4/CCCH52ccTJw72hmU9D17YV1JRVPn/85xrcy1JjTGX/xORRycAh3om3AD0Ya0LR0N8yXXJkTmGgJl3xT7JlQH0B9qXemuVLmZJDi5BioRuV10ZzGS9lfIDLwlwV3dAXnplCMOPiT4YfxjVlKJRn/WFUe4YU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Y3O+BkVh; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Y3O+BkVh"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 867871F00893;
	Tue,  9 Jun 2026 01:03:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780967004;
	bh=9mTCikEN+tXEtB8DIqTuvTF7eNgTxja017qZ6Dty1Lg=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Y3O+BkVhGY2g1S1c1tAkEwnwlIz/di8tR7X11bb3SBH6v65CWhOba5FmuQVNVx3yv
	 WB1QI91vjeQqqvWVgx7nKCvF2K3bSvMIK2dWAWhxnl0Fk2fN8PyeQVaKN6+YJ1PSfV
	 Ll+15k30W4DyrKDAGTcvvyQaYC9Z/CJJBFoI92lE1vJRqtJ1BEw0WLs7BAmoDDvyR/
	 9I1pZXEDUo8xco/xik572roilxHdhqRDzD3CzGc1ejMxscO1Yg99ayA+p3RFOwA9T3
	 w+Q+MMyLXxTYl8ZzZa1zdzTHvZMnuXySRRcq37j1FReUKK4iBb/TSTNHkrLFs1O3qa
	 isMe7RaFIbphA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 31/34] KVM: x86: Use ktime_get_snapshot_id() for
 master clock
Reply-To: sashiko-reviews@lists.linux.dev
To: "David Woodhouse" <dwmw2@infradead.org>
Cc: kvm@vger.kernel.org
In-Reply-To: <20260608145455.89187-32-dwmw2@infradead.org>
References: <20260608145455.89187-32-dwmw2@infradead.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 09 Jun 2026 01:03:24 +0000
Message-Id: <20260609010324.867871F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [Critical] Uninitialized stack memory used on failure path in KVM timekee=
ping.
- [Low] Unused static functions left in the code, causing `-Wunused-functio=
n` warnings.
--

commit 25989314a763f4ae38067d7da21492c86ffa8fa4
Author: David Woodhouse <dwmw@amazon.co.uk>

Replace the KVM-private vgettsc()/do_kvmclock_base()/do_monotonic()/
do_realtime() timekeeping reimplementation with calls to the generic
ktime_get_snapshot_id() interface.

This patch replaces the KVM-private timekeeping functions with generic
ktime_get_snapshot_id() calls. It provides system time and raw cycles=20
atomically paired to simplify the timekeeping state.

> diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
> index 96250264d403..2713aebb96ae 100644
> --- a/arch/x86/kvm/x86.c
> +++ b/arch/x86/kvm/x86.c
[ ... ]
> @@ -3162,14 +3163,32 @@ static int do_realtime(struct timespec64 *ts, u64=
 *tsc_timestamp)

[Severity: Low]
The patch description mentions replacing the private timekeeping functions
(vgettsc, do_kvmclock_base, do_monotonic, and do_realtime), but it appears
they were not removed from the source code.

Does leaving these unused static functions trigger -Wunused-function
compiler warnings during the build?

>   * reports the TSC value from which it do so. Returns true if host is
>   * using TSC based clocksource.
>   */
> +static bool kvm_snapshot_has_tsc(struct system_time_snapshot *snap,
> +				u64 *tsc_timestamp)
> +{
> +	if (snap->cs_id =3D=3D CSID_X86_TSC) {
> +		*tsc_timestamp =3D snap->cycles;
> +		return true;
> +	}
> +
> +	if (snap->hw_csid =3D=3D CSID_X86_TSC && snap->hw_cycles) {
> +		*tsc_timestamp =3D snap->hw_cycles;
> +		return true;
> +	}
> +
> +	return false;
> +}
> +
>  static bool kvm_get_time_and_clockread(s64 *kernel_ns, u64 *tsc_timestam=
p)
>  {
> -	/* checked again under seqlock below */
> -	if (!gtod_is_based_on_tsc(pvclock_gtod_data.clock.vclock_mode))
> +	struct system_time_snapshot snap;
> +
> +	ktime_get_snapshot_id(CLOCK_MONOTONIC_RAW, &snap);
> +	if (!kvm_snapshot_has_tsc(&snap, tsc_timestamp))

[Severity: Critical]
If ktime_get_snapshot_id() encounters a failure (such as when timekeeping is
suspended), it only sets snap.valid =3D false and returns immediately, leav=
ing
the rest of the struct uninitialized.

Since snap.valid is not checked before calling kvm_snapshot_has_tsc(), could
this pass uninitialized stack memory into the helper?

If the uninitialized snap->cs_id happens to match CSID_X86_TSC, could KVM
expose uninitialized host kernel stack data to the guest VM?

>  		return false;
> =20
> -	return gtod_is_based_on_tsc(do_kvmclock_base(kernel_ns,
> -						     tsc_timestamp));
> +	*kernel_ns =3D ktime_to_ns(ktime_mono_to_any(snap.systime, TK_OFFS_BOOT=
));
> +	return true;
>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260608145455.8918=
7-1-dwmw2@infradead.org?part=3D31
