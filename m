Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 354F0489894
	for <kvm@vger.kernel.org>; Wed, 29 Jul 2026 20:06:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785355602; cv=none; b=LyS2yUDw4KHomUTvzfucHuNaMtClI+Z0GyfbhXTK/Qf9L2Xh8ENjsThdCOmSUxyGCaYxjC93lECwMNIKx2QldA8bMUwJd9d8VZqqKQMd2/cL2j1zi1S9r1MrKJUV0DzUeZmoKIjNs+Pt8pB7shOgQPhHIPiA9iAE2StWcHjM548=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785355602; c=relaxed/simple;
	bh=Hy0szj9C4kAH2MWjOGVB2oHievYMMsD8LAjbwgdKvAI=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=CcIziCgAbd5+yM2BGvquPITnuwA9BjzpBB/Xl883Tfz7/haKejNYibIexZ4pnmDSHuCsyo6XVtXLrhAY8A2WMvdBdLD5fzOrLR4ZIRM0lXAqf/tCrKlPlwGBEFTirPk/+lXpbudLD0fuWgFzkYdtkwRom8PPrR0R7p61Z4sNI7o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PYQRrr+x; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PYQRrr+x"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ECA6A1F000E9;
	Wed, 29 Jul 2026 20:06:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785355601;
	bh=1WhoGEMg8Q4d3DgonMuLFDazCWA5rAGZbdZ/MeoGxrc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=PYQRrr+xtTaFoGOTviSAbxXMddKPSpRAlTgdae5pBX93Ll5hObfR2at5yrAtYFHAC
	 245pBOk3lZ4QropIdpIUPUGPfv3oshgP3bJ1GgYercvaNOCVWCg78L6dvPgQhnqsPJ
	 KRdkvN8b9+XCbkV4hXMA0HSwy06NNMomFe2r1X3YBZ7TbNZ+v3xHywMbtYW0G3wo8s
	 +fr6stGQSBpFb82ODm4V+ng7nQq+nBgnwgfLMqcl+r8OWieG5kbSbNmUFa8BlfZIJ/
	 B/UzmntHqkBa7uN2bpSzM/hSaCM120jTTODfAOXOTxGidWeNmgFKH2vKgxEdWj7H9x
	 2WI3eRNkX0lmg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 16/20] KVM: x86: Add APX to supported XCR0
Reply-To: sashiko-reviews@lists.linux.dev
To: "Chang S. Bae" <chang.seok.bae@intel.com>
Cc: kvm@vger.kernel.org
In-Reply-To: <20260729191656.598771-17-chang.seok.bae@intel.com>
References: <20260729191656.598771-1-chang.seok.bae@intel.com>
 <20260729191656.598771-17-chang.seok.bae@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 29 Jul 2026 20:06:40 +0000
Message-Id: <20260729200640.ECA6A1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] Premature exposure of APX XSTATE support to userspace via CPUID =
leaf 0xD.
--

--- Patch [16]: [PATCH v6 16/20] KVM: x86: Add APX to supported XCR0 ---
commit 1240d82e8b8dccfbe1fa4527616e2e4b0d49ebec
Author: Chang S. Bae <chang.seok.bae@intel.com>

KVM: x86: Add APX to supported XCR0

This commit modifies KVM to include the APX state bit in its supported XCR0
capabilities when the host has APX enabled. This is done conditionally
based on CONFIG_KVM_APX.

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

[Severity: Medium]
The commit notes mention separating this out from userspace exposure, but
doesn't adding this flag to kvm_caps.supported_xcr0 directly expose APX to
userspace via KVM_GET_SUPPORTED_CPUID for leaf 0xD?

If userspace tools pass this leaf to the guest, would this allow the guest =
to
discover and enable APX state saving via XSETBV without standard capability
gating? This seems to conflict with KVM's expectation that new guest-visible
features default off and remain enumerable through standard interfaces.

>  	}
> =20
>  	if (boot_cpu_has(X86_FEATURE_XSAVES)) {

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260729191656.5987=
71-1-chang.seok.bae@intel.com?part=3D16
