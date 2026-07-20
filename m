Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64F4731195C
	for <kvm@vger.kernel.org>; Mon, 20 Jul 2026 18:25:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784571909; cv=none; b=QMs0bTcTcy1P5sA/QBSBy301j4a44/JjHruC31HJiEywA0pJtHOCJmhT0QateFJyaQyg1tSa3LaUHhDbfz4JjdRXCZYqU/ZujtaNri34sIFCr4fyZsXk/YZ/9RaiTt5lvO+8wHKWZfqTQ2wQUNfW0K1YZsPpYkFlw1/sIU2SUeY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784571909; c=relaxed/simple;
	bh=so4faZKXzA6Dv7297lSpvqbzowy5vgqS4j9VYac6gDk=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=D4hrrQYXjRXLmGPd7evI0ghZ9dj35idZwmVgHDMInQvthM2jCovSEhBWd3UDWpkhKex/gCai6CAAUfYtBfQQU6thoQhX7s5qurkY8FAmln5xbY3dN8rqKqHjwMFtU59w4iigGwozVWO23koAKNLCp3aCYCK4oeYF5CzTqpcWUoY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=V7Yh7v2X; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="V7Yh7v2X"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7D03B1F00A3D;
	Mon, 20 Jul 2026 18:25:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784571907;
	bh=ykBinqGWysE4dy8n/xddPs7BBke0GOKJfiId+g6jqXk=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=V7Yh7v2XkqrSKQQSgKZcuAznbhghtzb5sdk0cSNJ6+GVDnMHvZ0XhncYxIjBYy0fg
	 lAtv/7j+AsmCCxAQAW8vyHbMY8d+RCqHXvuT+UGCe/ykkByb1rP6lF0M7KVtLvDmaF
	 PWpEbCpx9cgdvdZzAeKCdEkCGCrA9uARVaQ3t5DzqHngl0Mq5QktTNz/7zcFomxAcg
	 fTAIO5Hr0mGwftKqF3qC3vqz5b8xmGxDrZq1Knl9LnuhqgqL3H7T+69BW6SIHQSiKQ
	 5mUvL4UW9VbAevDtWmy//XsT1agACN3pvkXrAJxWiqbzVvqYPSnrt2CYFTZJwzO/wO
	 5aQh/mT4CxJzg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 16/20] KVM: x86: Add APX in supported XCR0
Reply-To: sashiko-reviews@lists.linux.dev
To: "Chang S. Bae" <chang.seok.bae@intel.com>
Cc: kvm@vger.kernel.org
In-Reply-To: <20260720171949.498680-17-chang.seok.bae@intel.com>
References: <20260720171949.498680-1-chang.seok.bae@intel.com>
 <20260720171949.498680-17-chang.seok.bae@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 20 Jul 2026 18:25:07 +0000
Message-Id: <20260720182507.7D03B1F00A3D@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Enabling APX pushes the default uncompacted FPU uABI size over 409=
6 bytes, which triggers a WARN_ON_ONCE on every vCPU creation and breaks th=
e legacy KVM_GET_XSAVE API.
--

--- Patch [16]: [PATCH v5 16/20] KVM: x86: Add APX in supported XCR0 ---
commit 0df85d22c18b5d5d318f03dea201f8b5d3746f25
Author: Chang S. Bae <chang.seok.bae@intel.com>

KVM: x86: Add APX in supported XCR0

This commit enables APX support in KVM by setting the APX bit in
kvm_caps.supported_xcr0 when the host has APX enabled and CONFIG_KVM_APX
is configured.

> diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
> index 266d7a02855bb..48f8a2d699879 100644
> --- a/arch/x86/kvm/x86.c
> +++ b/arch/x86/kvm/x86.c
> @@ -7082,6 +7082,8 @@ int kvm_x86_vendor_init(struct kvm_x86_init_ops *op=
s)
>  	if (boot_cpu_has(X86_FEATURE_XSAVE)) {
>  		kvm_host.xcr0 =3D xgetbv(XCR_XFEATURE_ENABLED_MASK);
>  		kvm_caps.supported_xcr0 =3D kvm_host.xcr0 & KVM_SUPPORTED_XCR0;
> +		if (IS_ENABLED(CONFIG_KVM_APX))
> +			kvm_caps.supported_xcr0 |=3D kvm_host.xcr0 & XFEATURE_MASK_APX;

[Severity: High]
This is a pre-existing issue, but does enabling APX here push the default
uncompacted FPU uABI size over 4096 bytes?

Because the uncompacted XSAVE layout fixed by CPUID places APX after AMX
(which is 8KB), the offset for APX appears to be over 10.7KB. Since APX is
not an XFD feature, it would be included in the default size calculation.

If fpu_user_cfg.default_size exceeds 4096 bytes (sizeof(struct kvm_xsave)),
it looks like fpu_alloc_guest_fpstate() will trigger a WARN_ON_ONCE on every
vCPU creation, potentially causing a local denial of service if panic_on_wa=
rn
is set:

arch/x86/kernel/fpu/core.c:fpu_alloc_guest_fpstate() {
...
	gfpu->uabi_size		=3D sizeof(struct kvm_xsave);
	if (WARN_ON_ONCE(fpu_user_cfg.default_size > gfpu->uabi_size))
		gfpu->uabi_size =3D fpu_user_cfg.default_size;
...
}

Could this also break the legacy KVM_GET_XSAVE API for userspace?
Once uabi_size exceeds sizeof(struct kvm_xsave), KVM_GET_XSAVE seems to
unconditionally fail:

arch/x86/kvm/x86.c:kvm_arch_vcpu_ioctl() {
...
	case KVM_GET_XSAVE: {
		r =3D -EINVAL;
		if (vcpu->arch.guest_fpu.uabi_size > sizeof(struct kvm_xsave))
			break;
...
}

>  	}
> =20
>  	if (boot_cpu_has(X86_FEATURE_XSAVES)) {

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260720171949.4986=
80-1-chang.seok.bae@intel.com?part=3D16
