Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8273C27A907
	for <kvm@vger.kernel.org>; Tue, 28 Jul 2026 15:21:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785252118; cv=none; b=abHFsKqmgJua38F0JtYQ6VTWO1DrvfLJ6ONsNQg5g36YV/Q6eh+iRiXwFspshDOv8OQeJz4NsT8BSxFbj+695jmGPiIlqVAR9FMpicwWTKRLVPZOvcfpqhUSEaKvWwuH2cASBa0whP0+naDqaClke/BhhR9PnPOVzn4QA1zlImc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785252118; c=relaxed/simple;
	bh=v24ZWPy1EH+3VJJzu4DlUUo+z5PXLx4FmQ+bnTBMMHc=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=d6SYxEhWI2aQc4sbwfkfIdF1GQXp2m/2aNcbuDUEpGnNURXTiMx9xd69SC0+q/Baz8c1ZO6O6XFr7mqvXfojWRnxaGHQLU+a23Eqsm3NIYhr9J2AY8rTmi4D6FSnupail+JQgJYmhIAkMmlJmefic4+0vWi7cRs8RLA66hsUyz4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OLJ94hWO; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OLJ94hWO"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A48831F000E9;
	Tue, 28 Jul 2026 15:21:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785252117;
	bh=0qzdD7dKeJjX30B/NQAhwMQ57YqjL5mbwvqW2e79mvw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=OLJ94hWOYLPmXOpfLACpXkOffUHOGmouzaAR9FhGmlTgUlzJbvfLpZO/lkhAwQr8c
	 FL/V4wA+KUzxBaSGUGF07sZaxt4sNsGwOWMEQOvAx1BHVb5MDy3vBLFX86mzT3fF2p
	 XxvcpVMYFkbsGXDxz5KkYc23pCXUQzjuKo2svz6b7CZWVzUhsgvfzkbney9N7RfXnP
	 x6OL5OWG+CwDevw/mwH7vqcn4DSZBBOeUxNaJ3EwHCOUjA8nv20iMc/CgbvNVSRB/D
	 HlDHHMgmsOrxBcysiQsVUKrjfFeBJSa4qwe4UfEj81yJXaTZfb2CWwxMESHIumT0KA
	 Glmh9SwmmRKAQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7 24/36] KVM: x86: Use ktime_get_snapshot_id() for
 master clock
Reply-To: sashiko-reviews@lists.linux.dev
To: "David Woodhouse" <dwmw2@infradead.org>
Cc: kvm@vger.kernel.org
In-Reply-To: <20260728144954.355376-25-dwmw2@infradead.org>
References: <20260728144954.355376-1-dwmw2@infradead.org>
 <20260728144954.355376-25-dwmw2@infradead.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 28 Jul 2026 15:21:56 +0000
Message-Id: <20260728152156.A48831F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 6 potential issue(=
s) to consider:
- [High] Mathematically incorrect usage of `ktime_mono_to_any()` with a RAW=
 timestamp.
- [High] Cannot retrieve CLOCK_MONOTONIC using only the standard system_tim=
e_snapshot.
- [High] The patch silently breaks KVM masterclock support on Hyper-V hosts.
- [High] Missing validation for zero cycles in kvm_snapshot_has_tsc leads t=
o a massive guest time jump and potential DoS.
- [Low] The patch introduces a build failure by calling a non-existent kern=
el API and accessing non-existent struct fields.
- [Low] Static helper functions were abandoned but not removed, breaking th=
e build.
--

--- Patch [24]: [PATCH v7 24/36] KVM: x86: Use ktime_get_snapshot_id() for =
master clock ---
commit 08cee26ad4312fb3cda5c262811876db0f33c933
Author: David Woodhouse <dwmw@amazon.co.uk>

KVM: x86: Use ktime_get_snapshot_id() for master clock

This commit replaces the KVM-private timekeeping reimplementation with call=
s=20
to a generic ktime_get_snapshot_id interface. It is intended as a step towa=
rds=20
eliminating the pvclock_gtod_data private copy of timekeeping state.

> diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
> index 57494812cc839..45a768fd7cb35 100644
> --- a/arch/x86/kvm/x86.c
> +++ b/arch/x86/kvm/x86.c

[ ... ]

> @@ -1580,14 +1581,39 @@ static int do_realtime(struct timespec64 *ts, u64=
 *tsc_timestamp)

[Severity: Low]
The commit message mentions replacing do_kvmclock_base, do_monotonic,=20
do_realtime, and vgettsc. Were these functions meant to be removed in this=
=20
patch? Leaving them defined as static helper functions without any callers=
=20
will break builds compiled with -Werror=3Dunused-function.

>   * reports the TSC value from which it do so. Returns true if host is
>   * using TSC based clocksource.
>   */
> +static bool kvm_snapshot_has_tsc(struct system_time_snapshot *snap,
> +				u64 *tsc_timestamp)
> +{
> +	/*
> +	 * ktime_get_snapshot_id() cannot fail for standard clock IDs
> +	 * (only for invalid/aux clocks or during suspend, with a WARN).
> +	 */
> +	if (!snap->valid)

[Severity: Low]
Does the system_time_snapshot structure have a valid field? It appears this=
=20
field, along with hw_csid and hw_cycles used below, might not exist in the=
=20
mainline struct system_time_snapshot, which would cause a build failure.

> +		return false;
> +
> +	if (snap->cs_id =3D=3D CSID_X86_TSC) {

[Severity: High]
Does this explicit check for CSID_X86_TSC exclude the previously supported=
=20
Hyper-V clocksource? Since VDSO_CLOCKMODE_HVCLOCK defaults to CSID_GENERIC,=
=20
it seems this might silently break KVM masterclock support for nested VMs=20
running on Hyper-V hosts.

[Severity: High]
If the hardware read transiently fails (such as during host migration) and=
=20
snap->cycles is 0, this block unconditionally returns true and passes 0 as =
the=20
host TSC reference. Could this result in a massive leap in guest time and=20
cause a timer storm that soft-locks or crashes the guest VM? The commit=20
message mentions raw_cycles being zero means the clocksource could not prov=
ide=20
a raw counter value, but it does not appear to be handled here.

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
> +	struct system_time_snapshot snap =3D {};
> +
> +	ktime_get_snapshot_id(CLOCK_MONOTONIC_RAW, &snap);

[Severity: Low]
Is ktime_get_snapshot_id available in the generic timekeeping code? Calling=
 a=20
non-existent API will result in a build failure.

> +	if (!kvm_snapshot_has_tsc(&snap, tsc_timestamp))
>  		return false;
> =20
> -	return gtod_is_based_on_tsc(do_kvmclock_base(kernel_ns,
> -						     tsc_timestamp));
> +	*kernel_ns =3D ktime_to_ns(ktime_mono_to_any(snap.systime, TK_OFFS_BOOT=
));

[Severity: High]
Does passing a RAW timestamp (from CLOCK_MONOTONIC_RAW) to ktime_mono_to_an=
y=20
mathematically mix two different time domains? It looks like this adds the=
=20
monotonic-to-boot offset to a raw monotonic timestamp, which could corrupt=
=20
the guest masterclock base time.

Additionally, does snap.systime exist in struct system_time_snapshot, or is=
=20
this another missing field that will break the build?

> +	return true;
>  }
> =20
>  /*
> @@ -1596,12 +1622,14 @@ static bool kvm_get_time_and_clockread(s64 *kerne=
l_ns, u64 *tsc_timestamp)
>   */
>  bool kvm_get_monotonic_and_clockread(s64 *kernel_ns, u64 *tsc_timestamp)
>  {
> -	/* checked again under seqlock below */
> -	if (!gtod_is_based_on_tsc(pvclock_gtod_data.clock.vclock_mode))
> +	struct system_time_snapshot snap =3D {};
> +
> +	ktime_get_snapshot_id(CLOCK_MONOTONIC, &snap);
> +	if (!kvm_snapshot_has_tsc(&snap, tsc_timestamp))
>  		return false;
> =20
> -	return gtod_is_based_on_tsc(do_monotonic(kernel_ns,
> -						 tsc_timestamp));
> +	*kernel_ns =3D ktime_to_ns(snap.systime);

[Severity: High]
Can CLOCK_MONOTONIC time actually be retrieved using only the standard=20
system_time_snapshot? The standard struct captures real, boot, and raw time=
s,=20
but lacks the timekeeper offsets needed to properly compute monotonic time.=
=20
KVM guest timekeeping requests might return corrupt data if relying solely =
on=20
this structure without proper offsets.

> +	return true;
>  }

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260728144954.3553=
76-1-dwmw2@infradead.org?part=3D24
