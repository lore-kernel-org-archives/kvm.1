Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACC153ECBC9
	for <kvm@vger.kernel.org>; Thu, 28 May 2026 12:25:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779971160; cv=none; b=gMypvx4rqBT2DXi6WdIqO2eH/rcwuN87CYHRTg9v6Gt8IilC8L/r6DuftRUJ33zKwaAsUWiXfIm5W27k48XuLDnAijmXvjrgHC4V3RaYwI1sEYdpLXIK7V2cnKRo86NwClimUQ0u70+dN1VA/AKG9dk2KrEM6ocTRl0fYpTrQLI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779971160; c=relaxed/simple;
	bh=CS3tXF96iGynsc/FC/j6bWCV1ecwTJ1FM50bmC6Ib2Q=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=R3l8eLDJU560HZOqUqJ6WfaeDFUlT4PtOUgZ66xLU9yp4EZU0C+LhYT4c1woA+E9iDS/cJ3ID2h+/189b6BYia2wj5cxPS3jgdr7as4T0Nrc1RnHDnEwqsd1e6VpaAqJok3TVbMP64XFrgWOhtCm67dtw7XQSW8AcW5LglF1R78=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SZkZs1Kt; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SZkZs1Kt"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7EC911F00A3A;
	Thu, 28 May 2026 12:25:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779971159;
	bh=R755CXulFgTpelNvn2LuM+YGRMWfOwqJvxyHHFTSRB0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=SZkZs1Kt6YX83wUfufVDNLsQL5TRF1ptpn8k1K08kND/ojcB08SSukxgceCr3HIOR
	 8YmL/PpbCuoEoop/7UC0ML+bSNEfsaYxgpWWX3YnLU2lO90Uiq/6TJGxZqy1NfsKhR
	 464y15E1Y+osCsEpweq/ZLuWFfq4ebYlDosDL+G3DMkMVbCJWzmoe/JJKbAKnA1rFm
	 w/YvSYHa/KMYKzrZoC8xTccdF9ND9d/foxE2wqeMtvrWt0KCiuiG+MLaDvnu0TQGDs
	 XK9RAQzAFeCRwTdv9XwjCxPq62tLTXtgGsvRCnsZVVKrSr5YVWpcKXlulIHGfJA+Bp
	 ozliJuqSKEO4w==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 2/5] KVM/x86: Return -errno instead of "1" for APIC
 related MSR emulation
Reply-To: sashiko-reviews@lists.linux.dev
To: "Juergen Gross" <jgross@suse.com>
Cc: kvm@vger.kernel.org
In-Reply-To: <20260528111357.264809-3-jgross@suse.com>
References: <20260528111357.264809-3-jgross@suse.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 28 May 2026 12:25:59 +0000
Message-Id: <20260528122559.7EC911F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Critical] Changing the return value of APIC-related MSR emulation functi=
ons from `1` to a negative error code (`-EINVAL`) breaks KVM's MSR handling=
 contract, allowing a guest to crash the entire VM instead of receiving a #=
GP fault.
--

commit f7cc9a2fd2433a7138900d7cd7af1e72eb4fc13a
Author: Juergen Gross <jgross@suse.com>
KVM/x86: Return -errno instead of "1" for APIC related MSR emulation

This commit updates the APIC related MSR emulation code to return negative
errno values instead of a literal 1 on errors. It also cleans up some
unnecessary braces in the code.

> diff --git a/arch/x86/kvm/lapic.c b/arch/x86/kvm/lapic.c
> index 4078e624ca667..3e7d83db2f7ab 100644
> --- a/arch/x86/kvm/lapic.c
> +++ b/arch/x86/kvm/lapic.c
> @@ -2412,11 +2412,10 @@ static int kvm_lapic_reg_write(struct kvm_lapic *=
apic, u32 reg, u32 val)
> =20
>  	switch (reg) {
>  	case APIC_ID:		/* Local APIC ID */
> -		if (!apic_x2apic_mode(apic)) {
> +		if (!apic_x2apic_mode(apic))
>  			kvm_apic_set_xapic_id(apic, val >> 24);
> -		} else {
> -			ret =3D 1;
> -		}
> +		else
> +			ret =3D -EINVAL;

[Severity: Critical]
Does returning a negative error code here alter the KVM MSR handling contra=
ct?

In the x86 MSR emulation framework, returning a positive value like 1 signa=
ls
an architectural fault and results in a #GP being injected into the guest.
If a negative value like -EINVAL is returned, it is treated as an
unrecoverable ioctl error during MSR writes.

Functions like __kvm_emulate_wrmsr check for negative return values and
bubble them up through the VM-exit handler. This causes the KVM_RUN ioctl
to exit with -EINVAL, which typically causes the userspace VMM to abort.

Could this regression allow a guest OS to intentionally crash its own VM
process by performing an invalid MSR access, rather than correctly
receiving a general protection fault?

>  		break;

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260528111357.2648=
09-1-jgross@suse.com?part=3D2
