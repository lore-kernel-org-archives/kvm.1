Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2996F1B3957
	for <kvm@vger.kernel.org>; Fri, 16 Oct 2026 03:57:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792123050; cv=none; b=ukUg/MYRhmtVOQAo5v+EjWQRpZOz0fyIs5vdtk2wMAaUmbYMyNVGpiuW+0RAvbPLIq29L4riO8dCtcbX2ffTtGD4KTYz/XybUkOpbT0tuUy5gKldNG4zJ7ZhwFjlNJwo+Oxz7sLRg7EqNuO3C5KheONFKWy3spYF1TAYj/FbMN0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792123050; c=relaxed/simple;
	bh=06rEXKSbxLm8j9tKPZMR29PqsY2jO72ACEqPvvS4pWk=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=dBWJ3v0H33Cb9x2GhPZHpmUsZlD3pOdhU3Co8nxEA0H8R7ijz4oxZSif8XojehlZDrEmm4dEElrt/hE5byTWjIb4UZPSMBjp419tuzp/0idQQhMVVHBym3nIFfxMcaDkjQS9wdFc7/dSsd1j3hRAYbUpsLpMjOXb9+R2arBZtgk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nOARyrd2; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nOARyrd2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 926F61F000C4;
	Fri, 16 Oct 2026 03:57:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792123048;
	bh=LxIuw3WqJEYMGXrA4wz5DNd7bFw9vqRXi2jTuOLwou4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=nOARyrd2p+JjzN0mIYVE4spd3c9Gdt9yQZy1EeMLo5zzWwT6UUlHDwakR2sDzi+1Y
	 plwxoiyi1lssP4PFGyPbLuKNlREGRu85oX2BmjnW43aPpkzZACInUTMwZSp+tKXuRC
	 cTWpzwtybFpqGT5cgwPleVPI2mLqnquSwSWHYH0afoC7p2y5tzppck5KuIw3oMoGjm
	 GYLQEHM/sUHOOU9lLd8UcZoQNbnWhtidvW1g5uKcNt//ZA1EuTTmS3Rb7F9z8/BEbd
	 KLNVXOi8nLTKDH7DnaHsH1R1MxtC9CnJcHXT5Wjuok0BnCNlpdyzZdVYCl4y6KYwyo
	 uJWL2tumWu6gQ==
Message-ID: <sashiko-outbox-173719@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2] LoongArch: KVM: Add hypercall crash support
Reply-To: sashiko-reviews@lists.linux.dev
To: "Bibo Mao" <maobibo@loongson.cn>
Cc: kvm@vger.kernel.org
In-Reply-To: <20261016034245.3002859-1-maobibo@loongson.cn>
References: <20261016034245.3002859-1-maobibo@loongson.cn>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 16 Oct 2026 03:57:28 +0000
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] kvm: new guest-visible KVM_FEATURE_CRASH capability is silently en=
abled by default
--

commit 6d0e897e0c46a79eb02651baa4b7271884b07abb
Author: Bibo Mao <maobibo@loongson.cn>
LoongArch: KVM: Add hypercall crash support

This commit adds hypercall crash support (KVM_HCALL_CRASH) to LoongArch KVM
to provide a more direct, low-level crash notification method. It allows the
VMM to capture CPU crash context during exception entry even if the CPU
hardware context or kernel stack is corrupted.

> diff --git a/arch/loongarch/kvm/vm.c b/arch/loongarch/kvm/vm.c
> index 6dabb227a7321..9bf4b3bb8f25a 100644
> --- a/arch/loongarch/kvm/vm.c
> +++ b/arch/loongarch/kvm/vm.c

[ ... ]

> @@ -49,8 +49,9 @@ static void kvm_vm_init_features(struct kvm *kvm)
>  		kvm->arch.kvm_features |=3D BIT(KVM_LOONGARCH_VM_FEAT_PMU);
> =20
>  	/* Enable all PV features by default */
> -	kvm->arch.pv_features |=3D BIT(KVM_FEATURE_IPI);
> +	kvm->arch.pv_features |=3D BIT(KVM_FEATURE_IPI) | BIT(KVM_FEATURE_CRASH=
);
>  	kvm->arch.kvm_features |=3D BIT(KVM_LOONGARCH_VM_FEAT_PV_IPI);
> +	kvm->arch.kvm_features |=3D BIT(KVM_LOONGARCH_VM_FEAT_CRASH);

[Severity: High]
Does unconditionally setting BIT(KVM_FEATURE_CRASH) and
BIT(KVM_LOONGARCH_VM_FEAT_CRASH) here break live migration and backward
compatibility?

If a VM is migrated to a newer kernel with this patch, an older VMM unaware
of the capability will not explicitly disable it. If the guest discovers
and triggers the new KVM_HCALL_CRASH hypercall, the older VMM will receive
an unexpected KVM_EXIT_SYSTEM_EVENT and will likely terminate the VM.

Should new guest-visible capabilities be left off by default and require
explicit VMM opt-in through capability negotiation?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261016034245.3002=
859-1-maobibo@loongson.cn?part=3D1
