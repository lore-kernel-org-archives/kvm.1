Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2988234CFAB
	for <kvm@vger.kernel.org>; Wed, 30 Sep 2026 01:28:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790731685; cv=none; b=ofPVFnTlpVfHtYHo9gBvqSsZ6z+1xqAG9RAVerRPlaTcR4iwGMQWGKVz0dh0BMGFkY2ZFt/n+ja8Z1lPCEozgnM0RPVxKxTIGT9uT3MON6ggWDwQ4dDf8JvyvgnaIfMFW1LK6KNtPU+EzXtjaa7E/CUeZ/sx2/Jjn8E5fzeCIp4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790731685; c=relaxed/simple;
	bh=QqTMZSIX1EXr0Fz8a5KXVYyXKvRG8yP7zO4eowiFImU=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=mwy2ZCIN4ZWjKhfnbaBlT10T7FJEJnZsx0XwGFbnv8t/xuoahwDzX0hcJ60xpKHsQvLxWM188IpylGNLO8K1AXoV+8OEuW9XJgAh2vCdMkcb1m4WMI7Io6OO478D+f5as6xTcWWhz2cl5m+eSzO1USA1/SSSy4IBeNeq1LzGJFw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MXkrwEN5; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MXkrwEN5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7E46E1F000FF;
	Wed, 30 Sep 2026 01:28:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790731683;
	bh=KeqES5GBV5s3tkEJp3jYzav3QbzUxJ281y52CWyBnlY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=MXkrwEN5o4yFwt10sshfatj0yA1EyVLbtUzr6jh7SiVxuof0bxk9DQ2d01x+G4DK2
	 V/3R76fpFEOBeVctNpOFcLy5EBio4QBG0D2bfXg0hzroXH3dPeriQseYlhzySU4d3S
	 l2nQk9L47dz8uJtwSMm4XjH5Dp/6l+SuvifeZQHowyqJeo/xvSxGPqZLCUVpGOaS3S
	 SP6W6kKjppM8KcBmNurfK1dt8AHDfBqmkS104wbM25L8qhq7pPFy4tNOtFxLzO1DB3
	 aFFrfNqZGFO1SuDK7hYDfXU/P+jeUqXGmo4onqHTD1GfEwSCTrzrCwJEGcuBWq/XvT
	 c12unn9Cga98w==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 06/12] KVM: x86: Kill off DR6_FIXED_1 to prevent
 future misuse
Reply-To: sashiko-reviews@lists.linux.dev
To: "Sean Christopherson" <seanjc@google.com>
Cc: kvm@vger.kernel.org
In-Reply-To: <20260930011313.3197688-7-seanjc@google.com>
References: <20260930011313.3197688-1-seanjc@google.com>
 <20260930011313.3197688-7-seanjc@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 30 Sep 2026 01:28:02 +0000
Message-Id: <20260930012803.7E46E1F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] x86/kvm: Host-triggerable WARN_ON_ONCE in kvm_deliver_exception_pa=
yload()
--

commit 48eae248dd35f5828c9a4c63f37a8c7de96050db
Author: Sean Christopherson <seanjc@google.com>

KVM: x86: Kill off DR6_FIXED_1 to prevent future misuse

This commit drops the hardcoded DR6_FIXED_1 macro to force all references
to fixed-1 bits to use the vCPU-aware helper. It also rewords the comment
about DR6_ACTIVE_LOW to explain why treating fixed-1 bits as active-low is
correct. No functional change is intended.

> diff --git a/arch/x86/kvm/regs.c b/arch/x86/kvm/regs.c
> index db43ade8ceb10..0c76cf17e8847 100644
> --- a/arch/x86/kvm/regs.c
> +++ b/arch/x86/kvm/regs.c
> @@ -774,7 +774,7 @@ EXPORT_SYMBOL_FOR_KVM_INTERNAL(kvm_update_dr7);
> =20
>  unsigned long kvm_get_dr6_fixed_1(struct kvm_vcpu *vcpu)
>  {
> -	unsigned long fixed =3D DR6_FIXED_1;
> +	unsigned long fixed =3D DR6_ACTIVE_LOW & ~DR6_VOLATILE;
> =20
>  	if (!guest_cpu_cap_has(vcpu, X86_FEATURE_RTM))
>  		fixed |=3D DR6_RTM;

[Severity: High]
Does this code allow an unvalidated exception payload to trigger a host
WARN_ON_ONCE?

Looking at kvm_vcpu_ioctl_x86_set_vcpu_events(), it accepts an unvalidated
exception payload from host userspace into the vcpu state:

arch/x86/kvm/x86.c:kvm_vcpu_ioctl_x86_set_vcpu_events()
    vcpu->arch.exception.payload =3D events->exception_payload;

When KVM later processes this exception in kvm_deliver_exception_payload(),
it computes dr6_fixed_1 using kvm_get_dr6_fixed_1() and then clears any
active-low bits present in the payload from vcpu->arch.dr6:

arch/x86/kvm/x86.c:kvm_deliver_exception_payload()
    vcpu->arch.dr6 &=3D ~(ex->payload & DR6_ACTIVE_LOW);

If a malicious payload sets active-low fixed-1 bits (like DR6_RTM when it is
unsupported by the guest), those bits are improperly cleared from the guest=
's
DR6 register.

This causes the subsequent check to fail and trigger the warning:

arch/x86/kvm/x86.c:kvm_deliver_exception_payload()
    if (WARN_ON_ONCE((vcpu->arch.dr6 & dr6_fixed_1) !=3D dr6_fixed_1))
        vcpu->arch.dr6 |=3D dr6_fixed_1;

Since panic_on_warn could be enabled, could an unprivileged host userspace
process use this regression to trigger a host-side Denial of Service?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260930011313.3197=
688-1-seanjc@google.com?part=3D6
