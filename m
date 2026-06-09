Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B9382D0602
	for <kvm@vger.kernel.org>; Tue,  9 Jun 2026 01:23:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780968226; cv=none; b=SdjEI4rTpCGBgR5llMeHgHkwgsdaYetlTasi0iE6Ety5tkuTH1o4K14HTtkNoxEpRcQGejt7+8ZiH6sg4l0WcwgbbaMWglvxwnqRswA5psdjpIo+DCQILl3O5VDAiYkZFbHIaQofq1Z9seYvDDSuQpWB2Lbdd5S24qZUUK30Zvo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780968226; c=relaxed/simple;
	bh=7S7S+4qFdZAcOIEweB5ndmN9jzOHUFfNoQ6vZjhK6zI=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=TYEQav+0FBH1JP9nsyPWJItArnx8Z2Qy2RAgFMS26iZQjPBhCtzRvyoyJYdHY++duP9Aul0syLLNIAv4jK767gUGSrFvIcB3/ULUGffczoxqbYm9z9ELc0/aB8l4/paZRvd8dXmFuzmTFCBXkE6O2ZOg6ETNChHBDpQ6ctk1Y9M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=R67Wo33e; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="R67Wo33e"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CC5D91F00893;
	Tue,  9 Jun 2026 01:23:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780968225;
	bh=5IbmjOQvxJUvOx2wwKlNGUxOA4hiaZVxfuUgiGR3s7M=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=R67Wo33e4+ny+KdfHV4rwsctafmRGqMYoxxIi0cWnLVOlSNkylrrs5p0ne0eZk7Ws
	 HjTM7phU7tg5GzfqoI4ofoi4bp+xjRv1jS0lxg0Cb2R7pVFZh8uuUvTpoxkZz805CK
	 u9YlbnqtKa7sHGeBxHjGcbta2PorgCYSojcL1BWgVWjPOtbWCguFi2sNCG86/M3T9s
	 RPAbsoInIA+Qcz7arYIgB/6oq/PfD+risxyBmIboQhMLBG4RFROlXmFKrZIMFsuSby
	 cjyBK2RiXZ4WXEvuE7GbuG87nfLP7m3kCAduQl3Db1sutpROCnxnruZZ19liEbp5qu
	 y3xWZSCje4wNQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 33/34] KVM: x86: Replace pvclock_gtod_data
 vclock_mode with boolean
Reply-To: sashiko-reviews@lists.linux.dev
To: "David Woodhouse" <dwmw2@infradead.org>
Cc: kvm@vger.kernel.org
In-Reply-To: <20260608145455.89187-34-dwmw2@infradead.org>
References: <20260608145455.89187-34-dwmw2@infradead.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 09 Jun 2026 01:23:44 +0000
Message-Id: <20260609012344.CC5D91F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] `kvm_check_tsc_unstable()` incorrectly masks TSC instability when =
the host uses a native TSC clocksource, breaking backward TSC compensation.
- [Medium] Tracepoints expect a clock mode enum but now receive a collapsed=
 boolean value, changing trace output and breaking observability tooling.
--

commit e7585c139257b84c3968a9648d71f5c5478115f9
Author: David Woodhouse <dwmw@amazon.co.uk>
Subject: KVM: x86: Replace vclock_mode checks with kvm_host_has_tsc_clockso=
urce

This commit replaces remaining users of pvclock_gtod_data with a simple
kvm_host_has_tsc_clocksource boolean. This removes the need for tracking
the exact vclock_mode when determining if the host clocksource is
TSC-based.

> diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
> index c18947c5b63f..93a428c37847 100644
> --- a/arch/x86/kvm/x86.c
> +++ b/arch/x86/kvm/x86.c
[ ... ]
> @@ -2726,7 +2727,7 @@ static void kvm_track_tsc_matching(struct kvm_vcpu =
*vcpu, bool new_generation)
> =20
>  	trace_kvm_track_tsc(vcpu->vcpu_id, ka->nr_vcpus_matched_tsc,
>  			    atomic_read(&vcpu->kvm->online_vcpus),
> -		            ka->use_master_clock, gtod->clock.vclock_mode);
> +		            ka->use_master_clock, kvm_host_has_tsc_clocksource);

[Severity: Medium]
Will this change break ABI for observability tooling that expects the
tracepoint to log the original vclock_mode integer enum?

Since kvm_host_has_tsc_clocksource is a boolean, a true value will
implicitly cast to 1 (VDSO_CLOCKMODE_TSC). If the actual mode is
VDSO_CLOCKMODE_HVCLOCK (3), the boolean still evaluates to 1, causing the
trace output to erroneously log 'tsc' instead of the expected integer 3.

[ ... ]
> @@ -2850,7 +2851,7 @@ static inline bool kvm_check_tsc_unstable(void)
>  	 * TSC is marked unstable when we're running on Hyper-V,
>  	 * 'TSC page' clocksource is good.
>  	 */
> -	if (pvclock_gtod_data.clock.vclock_mode =3D=3D VDSO_CLOCKMODE_HVCLOCK)
> +	if (kvm_host_has_tsc_clocksource)
>  		return false;

[Severity: High]
Does this change unintentionally mask TSC instability when the host uses a
native TSC clocksource?

Previously, this check bypassed check_tsc_unstable() only when the clocksou=
rce
was VDSO_CLOCKMODE_HVCLOCK. Now, it evaluates to true for both HVCLOCK and
native TSC clocksources.

When using a native TSC clocksource, KVM detects backwards TSCs in
kvm_arch_vcpu_load() and synchronously calls mark_tsc_unstable(). However,
because kvm_host_has_tsc_clocksource remains true until the timekeeper
notifier fires, the subsequent call to kvm_check_tsc_unstable() will
immediately return false.

Will this completely bypass the TSC offset catchup logic, directly exposing
the backwards TSC jump to the guest?

[ ... ]
> @@ -3315,7 +3316,7 @@ static void pvclock_update_vm_gtod_copy(struct kvm =
*kvm)
>  			ka->use_master_clock =3D false;
>  	}
> =20
> -	vclock_mode =3D pvclock_gtod_data.clock.vclock_mode;
> +	vclock_mode =3D kvm_host_has_tsc_clocksource;
>  	trace_kvm_update_master_clock(ka->use_master_clock, vclock_mode,
>  					ka->all_vcpus_matched_freq);
>  #endif

[Severity: Medium]
Similar to trace_kvm_track_tsc above, does passing a boolean here break
tools expecting the original vclock_mode enum for
trace_kvm_update_master_clock?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260608145455.8918=
7-1-dwmw2@infradead.org?part=3D33
