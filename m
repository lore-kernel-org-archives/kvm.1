Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AE0B49AA3A
	for <kvm@vger.kernel.org>; Wed,  9 Sep 2026 09:13:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788945241; cv=none; b=fhz/S5TNPHdZXm4HCSxdcteq51RNZ9DLTls5wv5sl38wPTXCo3Exkei7t4DTndi8WwyQZ7zVjhWS4scsHk5wYa0bbet87hjmAPS/L8Ez4rGDwXkmYciqLp2cQ6tujMktg0wqy/lUXeNmDlX6pHwntvB104pQTYt1bjP/a7VtaIE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788945241; c=relaxed/simple;
	bh=QgKJCcfz8Us6N/GZpeVoCm7twDEfGPR/jlC/Ch1nAac=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=idZRCUwQ6JMg3k3qTf4goxPjVJ+235JVrRWlvUpwnj4+0kmxUMiImM42lTXyZmMzGM00q7khXNr8mH0TVwJ4nNR5Zxa8WUW1OOl6Tl98D/6xZmGONLEEoQq8fmL5yQOzr4PgsdgYrwpUs7HKs2cfSMKt35tW2Dfus7+UD1VyD+M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Z0kpNsfc; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Z0kpNsfc"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7FBC71F00A3A;
	Wed,  9 Sep 2026 09:13:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788945234;
	bh=p0Q0XWqjZT/ZwDIuAVGK2AUgs/EdvV+VSyHzubAyT6Y=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Z0kpNsfc5rVyY4HeU34xREPHcw+/J19bVcWRmfigeTVP6/TuFRXVP1FVvu/rjqDY7
	 B4f+YR//KiKj/EaH8wgsrKTRB3o3U/frg6XLBES3wAkT5r9YxniQ/k6RZdjsO/N2fD
	 mz5uoJWVx20TegEBQK/AS7pImhII/ImlyofY6qaGTlKuGnfpUpn311EJsOsFfKyoJl
	 ny5hDWDUROXYZYwNNyRDUzs9ADrYQGU6ihkwgGlt15wT2x5YGaZSEAVgJch8c5TTkf
	 w9WDBkI+/4nRq0kYm+toc5xBQ54VMIeEkrXAB3z7ysLs/kyKJZJgxHBpBlU0Pmre4t
	 WPVbtvoy6BKgA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] LoongArch: KVM: Add hypercall crash support
Reply-To: sashiko-reviews@lists.linux.dev
To: "Bibo Mao" <maobibo@loongson.cn>
Cc: kvm@vger.kernel.org
In-Reply-To: <20260909085350.2046788-1-maobibo@loongson.cn>
References: <20260909085350.2046788-1-maobibo@loongson.cn>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 09 Sep 2026 09:13:54 +0000
Message-Id: <20260909091354.7FBC71F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] The KVM_LOONGARCH_VM_FEAT_CRASH capability cannot be discovered by=
 userspace due to a missing case in kvm_vm_feature_has_attr().
- [High] The KVM_FEATURE_CRASH capability is silently enabled by default, v=
iolating KVM cross-architecture rules and breaking live migration with olde=
r VMMs.
--

commit db8910e8d85912033e28dc04e11026a25b4bdbb8
Author: Bibo Mao <maobibo@loongson.cn>

LoongArch: KVM: Add hypercall crash support
   =20
This commit adds a generic pvpanic-like hypercall for LoongArch KVM to
notify the VMM about VM crashes. It provides a direct, low-level crash
method that is useful when the CPU hardware context or kernel stack is
corrupted.

> diff --git a/arch/loongarch/include/uapi/asm/kvm.h b/arch/loongarch/inclu=
de/uapi/asm/kvm.h
> index cd0b5c11ca9c2..b222bfc480427 100644
> --- a/arch/loongarch/include/uapi/asm/kvm.h
> +++ b/arch/loongarch/include/uapi/asm/kvm.h
> @@ -106,6 +106,7 @@ struct kvm_fpu {
>  #define  KVM_LOONGARCH_VM_FEAT_PTW		8
>  #define  KVM_LOONGARCH_VM_FEAT_MSGINT		9
>  #define  KVM_LOONGARCH_VM_FEAT_PV_PREEMPT	10
> +#define  KVM_LOONGARCH_VM_FEAT_CRASH		11

[Severity: High]
Does this omission prevent userspace from discovering the capability?

This feature is defined here, but it appears to be missing from the
switch statement in kvm_vm_feature_has_attr() in arch/loongarch/kvm/vm.c.
If a VMM queries this via KVM_HAS_DEVICE_ATTR, won't it hit the default
branch and return -ENXIO, falsely indicating the feature is unavailable?

[ ... ]

> diff --git a/arch/loongarch/kvm/vm.c b/arch/loongarch/kvm/vm.c
> index 6dabb227a7321..e5d10ceb5e67f 100644
> --- a/arch/loongarch/kvm/vm.c
> +++ b/arch/loongarch/kvm/vm.c
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
Could this regression break live migration with older VMMs?

Currently, KVM_FEATURE_CRASH is unconditionally enabled for all new VMs.
If an older VMM that does not support the crash hypercall runs on this
kernel, and the guest executes KVM_HCALL_CRASH, the VMM will receive an
unrecognized KVM_EXIT_SYSTEM_EVENT of type KVM_SYSTEM_EVENT_CRASH.

This usually causes an older VMM to ungracefully abort the VM. KVM
cross-architecture rules require new guest-visible features and exit
reasons to be off by default, relying on explicit VMM opt-in during
capability negotiation.

>  	if (kvm_pvtime_supported()) {
>  		kvm->arch.pv_features |=3D BIT(KVM_FEATURE_PREEMPT);
>  		kvm->arch.pv_features |=3D BIT(KVM_FEATURE_STEAL_TIME);

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260909085350.2046=
788-1-maobibo@loongson.cn?part=3D1
