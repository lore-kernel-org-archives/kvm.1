Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CF8178F2F
	for <kvm@vger.kernel.org>; Wed, 26 Aug 2026 21:49:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787780993; cv=none; b=ud5oOxXdr6+p/5yd5gY6FITb4UtjZW1t6tire1I5+KuVC5F/gvTI/t2Af+S0uNDm1r+KNQqJrsYDa+j7pAoHNWlBK8OufbZNf6j9yCzvDHUwi1L4Z2Q3AKEHbnFwNIQMLNc8sf+O/NhaEHNi15zv0CnNAvjdLlodrBaQfOGL2ck=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787780993; c=relaxed/simple;
	bh=EKb93Bz9CGd8kyh0NfhqAT+V1bikb0kIzSQJ9NiK2RY=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=gDM17vRW5V1u5TGqTa8TRHuZsp+hYCtWSnPTkPUL2Zr0VCHVNmV+0T5amKTp2tDQ6uS20V3f8U/cC5bjdwmuf0tWxLEmR/oYNedap3IYoA3DuevTQQ32Fw9rEJ+h1MN03AzjRF+kvsMRKqlnyOiBIKiLeTH/GP7DyGjlDCyd68A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IuoA46vJ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IuoA46vJ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 129BB1F000E9;
	Wed, 26 Aug 2026 21:49:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787780992;
	bh=9ySh1aZOCkTAlixz4w6AM6aqWkBeLH5mnKIzyZUF8Lk=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=IuoA46vJGkOCqv+IREJ8iNSxSgz+4U5a+qU+WRdK38HPTCM/1QhrBsS4BrMxfIzrC
	 X5drhDjr+TbXsjhjiNO9KJh04xdDm7aPTgMCLG4d/7Jevm15KCZezXoilQSv6OfgF1
	 YKK/dmcri5ebSYy/TLn8ROWf+hYwIhkkuTYdUpksnPcp8kukoZbXOBt56ZfK8A8zRg
	 7KZfeC1NoADmFhNZTVkMPbqrDwFZQDphrF4ChMUUVI92GTloI2SVqejTQxdqs8YlZs
	 2oCqS/CKvmIZtVJ2+spip+IHOzqLF1QWj5/l25AksKSvIvik6PTHdOe2FHceV5Uju6
	 DKw4Q7Bch5l9Q==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v10 21/21] KVM: x86: Use kernel timekeeping snapshot to
 get walltime+TSC
Reply-To: sashiko-reviews@lists.linux.dev
To: "Sean Christopherson" <seanjc@google.com>
Cc: kvm@vger.kernel.org
In-Reply-To: <20260826213303.914988-22-seanjc@google.com>
References: <20260826213303.914988-1-seanjc@google.com>
 <20260826213303.914988-22-seanjc@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 26 Aug 2026 21:49:51 +0000
Message-Id: <20260826214952.129BB1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] Removal of KVM's local TSC clamping exposes guests to mismatched (=
tsc, walltime) pairs when the host TSC goes backwards, causing guest time t=
o jump forward.
--

commit 538536e82164aaa6297ef0ce3bf878f455e79fc7
Author: Sean Christopherson <seanjc@google.com>

KVM: x86: Use kernel timekeeping snapshot to get walltime+TSC

This commit replaces the KVM-private timekeeping reimplementation with calls
to the generic ktime_get_snapshot_id() interface. It provides both the syst=
em
time and raw cycles atomically paired using a sequence counter, allowing the
deletion of the unused read_tsc() and vgettsc() functions.

> diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
> index 0352bd147c400..34eadc75fee46 100644
> --- a/arch/x86/kvm/x86.c
> +++ b/arch/x86/kvm/x86.c
[ ... ]
> @@ -1525,11 +1449,14 @@ bool kvm_get_monotonic_and_clockread(s64 *kernel_=
ns, u64 *tsc_timestamp)
>  static bool kvm_get_walltime_and_clockread(struct timespec64 *ts,
>  					   u64 *tsc_timestamp)
>  {
> -	/* checked again under seqlock below */
> -	if (!gtod_is_based_on_tsc(pvclock_gtod_data.clock.vclock_mode))
> +	struct system_time_snapshot snap =3D {};
> +
> +	ktime_get_snapshot_id(CLOCK_REALTIME, &snap);
        ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

[Severity: High]
Does removing KVM's local TSC clamping expose guests to mismatched time pai=
rs?

When establishing the guest's PV clock, KVM provides a master clock
snapshot pairing a host TSC with a system time. The previous read_tsc()
logic explicitly clamped the TSC to cycle_last to maintain mathematical
consistency.

Looking at ktime_get_snapshot_id() in kernel/time/timekeeping.c, the
function does not clamp the returned raw TSC (cycles):

kernel/time/timekeeping.c:ktime_get_snapshot_id() {
    ...
	systime_snapshot->cycles =3D now;
    ...
}

However, the system time is clamped by timekeeping_cycles_to_ns(), which
skips the negative delta if now < cycle_last.

If the host TSC read on the current CPU is slightly behind tkr->cycle_last
(for example, due to cross-CPU TSC skew), could this result in KVM
returning a mathematically mismatched pair?

An older unclamped TSC (now) paired with a clamped future walltime
(at cycle_last) would cause the elapsed delta (guest_tsc - master_tsc)
to be artificially inflated when the guest later reads the TSC.

Could this cause the guest's clock to jump forward by that offset?

> +	if (!kvm_snapshot_has_tsc(&snap, tsc_timestamp))
>  		return false;
> =20
> -	return gtod_is_based_on_tsc(do_realtime(ts, tsc_timestamp));
> +	*ts =3D ktime_to_timespec64(snap.systime);
> +	return true;
>  }
>  #endif

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260826213303.9149=
88-1-seanjc@google.com?part=3D21
