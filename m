Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D319C3112DA
	for <kvm@vger.kernel.org>; Wed, 30 Sep 2026 01:36:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790732166; cv=none; b=Z+4h8MHT3xJ5fFPRIhk8RZbn/GVzAM1+88Tfk1hI5FJQFiSBZRm/MXPJJOTQV/DdbTKO33HdgzJLv8g4DQKjTr3pBp1gPyxCtEcUCAkHR16BRepOEHsYvy9ORKT8F/W0KW3Irut8WnrwsJxsXfjFbwruxhkiLwzcvyHFOyLi09k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790732166; c=relaxed/simple;
	bh=sdcmZsC0cryQdj/KAJKyq7FPJJliuyprVFv3Ssk1ZUg=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=e+mAYrqzyVisGQCEDcxYq+wOTSx0o45NIJoRUroamCvTzmnc+g9qaFp/JPoxnoKCpyfn/Yn9Dyd7ep9OQ//HWz7zkYskX4V5U8Gug6WSZEvUAzQG6SM/Aq6gxwSHKbZqmbJ63Q7fbgbIEWuJd4m/AEG6Ql8ZzatKuv8Au8M1Z9M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iX4ifzEa; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iX4ifzEa"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3B1281F000FF;
	Wed, 30 Sep 2026 01:36:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790732164;
	bh=bpDBCnzdr+aGlkM2DNB0UFdtJdZl2I1xYiTRe9F3N/I=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=iX4ifzEaGzU7o4Hwy4lqhj8/nR0dXQLFm2orZ3WtUIRShk2AOnYZyqK8T/4KH4tLg
	 1nYQOEKe/c31a6l043+RewMd6/4cTH2RarzHks6pO0L4OI9f+C/0QQmxbS6oO/AZPF
	 4DDolsHyTcGV1wfKlQTFg+nEPDyKayq2jp3k2pz1ppLsOTJlWuLxWPiBbaxJnrIe9+
	 IJ+tpKlabexZhO8NJ/I9Yhudjas7XSWnodeusY/6M1uiyQogxrtgbXA0HeiuhmyRaU
	 b2RA0D9wwffQtOus+hL+a6RxLc9NSNyHGpKqA9T1ZFKu3qLR/Mnk0xtYtGK/dE/sYe
	 b18PLTTFnzGXg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 12/12] KVM: SVM: Add support for virtualizating Bus
 Lock Detect
Reply-To: sashiko-reviews@lists.linux.dev
To: "Sean Christopherson" <seanjc@google.com>
Cc: kvm@vger.kernel.org
In-Reply-To: <20260930011313.3197688-13-seanjc@google.com>
References: <20260930011313.3197688-1-seanjc@google.com>
 <20260930011313.3197688-13-seanjc@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 30 Sep 2026 01:36:03 +0000
Message-Id: <20260930013604.3B1281F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] kvm: x86: Host DoS via WARN_ON_ONCE in kvm_deliver_exception_paylo=
ad()
--

commit ae1e356a2c3cc9178bead14afcfa89eabb330003
Author: Ravi Bangoria <ravi.bangoria@amd.com>

    KVM: SVM: Add support for virtualizating Bus Lock Detect
   =20
    Advertise support for virtualizing Bus Lock Detect and allow the guest =
to
    enable BUS_LOCK_DETECT if LBR Virtualization is enabled (Bus Lock Detec=
t is
    enabled through MSR_IA32_DEBUGCTLMSR, which context-switched if and onl=
y if
    LBR Virtualization is enabled).

> diff --git a/arch/x86/kvm/svm/svm.c b/arch/x86/kvm/svm/svm.c
> index 1e58ad8691e92..e7c296c52591f 100644
> --- a/arch/x86/kvm/svm/svm.c
> +++ b/arch/x86/kvm/svm/svm.c
[ ... ]
> @@ -5712,9 +5712,17 @@ static __init void svm_set_cpu_caps(void)
>  	 * Clear capabilities that are automatically configured by common code,
>  	 * but that require explicit SVM support (that isn't yet implemented).
>  	 */
> -	kvm_cpu_cap_clear(X86_FEATURE_BUS_LOCK_DETECT);
>  	kvm_cpu_cap_clear(X86_FEATURE_MSR_IMM);
> =20
> +	/*
> +	 * LBR Virtualization must be enabled to support BusLockTrap inside the
> +	 * guest, since BusLockTrap is enabled through MSR_IA32_DEBUGCTLMSR and
> +	 * MSR_IA32_DEBUGCTLMSR is virtualized only if LBR Virtualization is
> +	 * enabled.
> +	 */
> +	if (!lbrv)
> +		kvm_cpu_cap_clear(X86_FEATURE_BUS_LOCK_DETECT);

[Severity: High]
Could exposing X86_FEATURE_BUS_LOCK_DETECT introduce a regression where a
malicious unprivileged userspace process can cause a host denial of service
via WARN_ON_ONCE?

A malicious unprivileged userspace process can call KVM_SET_VCPU_EVENTS
with an exception payload that has bit 11 (DR6_BUS_LOCK) or bit 16
(DR6_RTM) set. This unsanitized payload is accepted and passed into the
vcpu architecture state:

arch/x86/kvm/x86.c:kvm_vcpu_ioctl_x86_set_vcpu_events()
	vcpu->arch.exception.payload =3D events->exception_payload;

When KVM_RUN injects the exception, it calls kvm_deliver_exception_payload(=
).
Because these bits are within DR6_ACTIVE_LOW, the payload application
clears them from vcpu->arch.dr6.

However, if the guest CPU lacks support for these features, dr6_fixed_1
will have these bits set to 1. The subsequent sanity check evaluates to
true because the bits were just cleared, reliably triggering the WARN_ON_ON=
CE:

arch/x86/kvm/x86.c:kvm_deliver_exception_payload()
		if (WARN_ON_ONCE((vcpu->arch.dr6 & dr6_fixed_1) !=3D dr6_fixed_1))
			vcpu->arch.dr6 |=3D dr6_fixed_1;

Any unprivileged process with access to /dev/kvm can trigger this, which
may panic the host if panic_on_warn is set.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260930011313.3197=
688-1-seanjc@google.com?part=3D12
