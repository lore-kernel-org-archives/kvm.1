Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4C364CCDCA
	for <kvm@vger.kernel.org>; Wed,  2 Sep 2026 03:07:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788318430; cv=none; b=towC7YTof1Ks92QdyD4nCBTTscruT+bUeSQoiqI4WSXhxscoH3Z1GfeO7mBNY0UcrlHA1M+AYzQL2XHYEMMi2EcA0kjj7ZvogZsRa5LXYN2jOhYwpLrvHG15lH42gHCIFvlLJUr30dHn60oePMKjkUmv/Tg5MRM6GBcXp5TR0ig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788318430; c=relaxed/simple;
	bh=WdqUsj3DowOVJwFW6/fX7Oyw3LgQan2U8L/tpERpf3E=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=bLOwTP53xcXDgrbAFcsQwoHbvI+I5r1+SlOK3jPIkC5w9nj8mqIBbyqlpcCPOndhsumvQ48B7ncklSk29AlKfKwdW4uuEx0Kk2k0RZAssOMf9ZvlODvb6+blFTXM+gppZULC5beSV6m5RZFxAxKBJRcxpvebm/7bD01PS/GAliE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nNZ55Myz; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nNZ55Myz"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8AA051F000E9;
	Wed,  2 Sep 2026 03:07:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788318428;
	bh=IHtxY/2l4NcynocGUuMNzjN4HvPvqUJSoh7vNR3XKJ0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=nNZ55Myzkk4F9h7Yz4o1gpv3ztYMZ5BbAv3qyjehdm+XHaOfZkBnZZBjFtzkAFDn3
	 IbQojwFj1jWM1bb7DWaUqso6QAkDF+6N4nNYCatZLoKZNG7oqPsog+svhRoc68wkFN
	 oU1r6MFjPh65NPQIwrPnH20a4FjAgpYLVU73ndYZHWn+8t9VGmZocfxB8DREn2X1qo
	 D7O77e7cukedzukTbs5VYJ/cUYj55VqvFsZDR6gAXqskgTBCOgoymyIjs1pWSF8nkT
	 hSOF+sM0g5uSS7ngdKs8MF5Zb4iZkiR6F7C8OYB6SXRuIcvBi+BUQh3c3JW26zLu5O
	 R2lJB9QMV+Wgg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7 16/20] KVM: x86: Add APX to supported XCR0
Reply-To: sashiko-reviews@lists.linux.dev
To: "Chang S. Bae" <chang.seok.bae@intel.com>
Cc: kvm@vger.kernel.org
In-Reply-To: <20260902021804.718676-17-chang.seok.bae@intel.com>
References: <20260902021804.718676-1-chang.seok.bae@intel.com>
 <20260902021804.718676-17-chang.seok.bae@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 02 Sep 2026 03:07:08 +0000
Message-Id: <20260902030708.8AA051F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Adding APX host support inflates KVM's FPU uabi_size beyond 4096 b=
ytes for all VMs, completely breaking the KVM_GET_XSAVE and KVM_SET_XSAVE U=
APIs for legacy VMMs on APX-capable hosts.
--

commit f809671f7be8f3b21dbbd90937f8c5a3e917c643
Author: Chang S. Bae <chang.seok.bae@intel.com>

KVM: x86: Add APX to supported XCR0

This commit sets kvm_caps.supported_xcr0 for APX when the host has enabled
the APX state and CONFIG_KVM_APX is configured. This allows KVM to expose
APX features to guests.

> diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
> index 76f70d2631f67..8c6365122efb8 100644
> --- a/arch/x86/kvm/x86.c
> +++ b/arch/x86/kvm/x86.c

[ ... ]

> @@ -7132,6 +7132,8 @@ int kvm_x86_vendor_init(struct kvm_x86_init_ops *op=
s)
>  	if (boot_cpu_has(X86_FEATURE_XSAVE)) {
>  		kvm_host.xcr0 =3D xgetbv(XCR_XFEATURE_ENABLED_MASK);
>  		kvm_caps.supported_xcr0 =3D kvm_host.xcr0 & KVM_SUPPORTED_XCR0;
> +		if (IS_ENABLED(CONFIG_KVM_APX))
> +			kvm_caps.supported_xcr0 |=3D kvm_host.xcr0 & XFEATURE_MASK_APX;

[Severity: High]
This is a pre-existing issue, but does enabling APX host support here
inadvertently break the KVM_GET_XSAVE and KVM_SET_XSAVE UAPIs for legacy
VMMs?

Because APX (component 19) is a static user feature, its inclusion in
fpu_user_cfg.default_features requires an uncompacted offset that
accommodates the 8KB AMX (component 18) hole. This results in an uncompacted
offset greater than 10KB, which inflates fpu_user_cfg.default_size.

When KVM initializes a vCPU, it sets the baseline uabi_size to this
inflated value:

arch/x86/kernel/fpu/core.c:fpu_alloc_guest_fpstate() {
    ...
    if (WARN_ON_ONCE(fpu_user_cfg.default_size > gfpu->uabi_size))
        gfpu->uabi_size =3D fpu_user_cfg.default_size;
    ...
}

Consequently, uabi_size grows beyond the standard 4096 bytes for all VMs.

For older VMMs attempting to use the standard 4096-byte buffers,
kvm_arch_vcpu_ioctl() handles the UAPI boundary by unconditionally failing
KVM_GET_XSAVE with -EINVAL:

arch/x86/kvm/x86.c:kvm_arch_vcpu_ioctl() {
    ...
    case KVM_GET_XSAVE: {
        r =3D -EINVAL;
        if (vcpu->arch.guest_fpu.uabi_size > sizeof(struct kvm_xsave))
            break;
    ...
}

Similarly, for KVM_SET_XSAVE, it reads out of bounds from the 4096-byte user
buffer, returning -EFAULT:

arch/x86/kvm/x86.c:kvm_arch_vcpu_ioctl() {
    ...
    case KVM_SET_XSAVE: {
        int size =3D vcpu->arch.guest_fpu.uabi_size;

        u.xsave =3D memdup_user(argp, size);
    ...
}

Could this deterministically break VM creation and live migration on
APX-capable hosts for legacy VMMs?

>  	}
> =20
>  	if (boot_cpu_has(X86_FEATURE_XSAVES)) {

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260902021804.7186=
76-1-chang.seok.bae@intel.com?part=3D16
