Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07C0233B6E3
	for <kvm@vger.kernel.org>; Tue,  2 Jun 2026 02:37:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780367879; cv=none; b=kV7vuNPlvBnr3/XbAoBGF6jKvWW5C+DhsE27lcbSmWFlWkOxgIov7BYrvBG7V1yYAfAgI6erHJVJh+UPWwOQ6F+yOQjjDTQAVYnh4GV4iPFV0nn7bX+1/JRxFrraTuVszQOivTIT1x1XLmQKC5N0add2efOkKkVoo+sA1Z4M+/4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780367879; c=relaxed/simple;
	bh=VzYfQQk3Ajz1Y2HYxSAsojOldOqYaM8ZPPjo28zlYsg=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=ReP8sFUKW8T+nDkJsV3IGiJ6DKuVtMg1/AoOh0p1uXx2FlgOQIU2Iuystq2O923mF30nuaU4zI+NHPBkkspCTe3KVRvhQg91fnY0XF6WYXydFbjWZJ2fY76wSR/zRN7e562A+wrrh+vzf+h/FPztEhp4xavJexD53A28ZatPBD0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HOHJW3mn; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HOHJW3mn"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8520A1F00893;
	Tue,  2 Jun 2026 02:37:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780367877;
	bh=xwBjStryVMTs+s1TbJRrvKUDdvsCYWcPA/GYJ6qBLts=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=HOHJW3mn1lLZlDPrgC3xTiRT1EJExroA6ahOcgN9RVCTtL7qks7z1Nt6L3ju5FlN4
	 fMYlWuw4Xx5ARNFDEmAlF5i6prkWVTWRI8/YTV5C3cLqUSKk9qcZCLiR+FnCa/uxxH
	 anBg5EE7TGmaaGHtPiMpACHC+3b/uuR17ZyXgdWxJWau7M1TflqZJi9Q0THmhCCQxp
	 6mZaJVCP618B2dm8PB8OOoNKhy6nF+/l6h/L9fiYE0jw4730GaNiciDyAV23eyVADM
	 ghZOc3oUHp0EraMGOVPYDF09UjEJh9jA82UTka3poDxB5D1dGIvtwFWFbiMTC3O3dS
	 iuoJYSJnZjaAg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 2/4] LoongArch: KVM: Add PV TLB flush support via
 steal-time shared memory
Reply-To: sashiko-reviews@lists.linux.dev
To: "Tao Cui" <cui.tao@linux.dev>
Cc: kvm@vger.kernel.org
In-Reply-To: <20260602021819.2373404-3-cui.tao@linux.dev>
References: <20260602021819.2373404-3-cui.tao@linux.dev>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 02 Jun 2026 02:37:57 +0000
Message-Id: <20260602023757.8520A1F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Critical] The KVM_FEATURE_PV_TLB_FLUSH feature is forcefully enabled by =
default via `pv_auto_features`, bypassing capability negotiation and breaki=
ng backward live migration.
--

commit 36054232bc9801e8c8c49df0b88a0802cdab7a98
Author: Tao Cui <cuitao@kylinos.cn>

LoongArch: KVM: Add PV TLB flush support via steal-time shared memory

This commit implements a paravirtualized TLB flush for LoongArch KVM guests
using the steal-time shared memory page. It uses the preempted byte to allow
guests to request a remote TLB flush without sending an IPI when the target
vCPU is preempted.

> diff --git a/arch/loongarch/kvm/vm.c b/arch/loongarch/kvm/vm.c
> index 8af874e0b36b2..4be70e4f1279f 100644
> --- a/arch/loongarch/kvm/vm.c
> +++ b/arch/loongarch/kvm/vm.c
[ ... ]
> @@ -54,8 +54,10 @@ static void kvm_vm_init_features(struct kvm *kvm)
>  	if (kvm_pvtime_supported()) {
>  		kvm->arch.pv_features |=3D BIT(KVM_FEATURE_PREEMPT);
>  		kvm->arch.pv_features |=3D BIT(KVM_FEATURE_STEAL_TIME);
> +		kvm->arch.pv_features |=3D BIT(KVM_FEATURE_PV_TLB_FLUSH);
>  		kvm->arch.kvm_features |=3D BIT(KVM_LOONGARCH_VM_FEAT_PV_PREEMPT);
>  		kvm->arch.kvm_features |=3D BIT(KVM_LOONGARCH_VM_FEAT_PV_STEALTIME);
> +		kvm->arch.kvm_features |=3D BIT(KVM_LOONGARCH_VM_FEAT_PV_TLB_FLUSH);
>  	}
>  	kvm->arch.pv_auto_features =3D kvm->arch.pv_features;
>  }

[Severity: Critical]
Does unconditionally adding KVM_FEATURE_PV_TLB_FLUSH to pv_features here
force the feature on by default, breaking capability negotiation?

Because kvm_vm_init_features() assigns pv_features to pv_auto_features, the
new PV TLB flush feature is included in the auto-enabled set. Looking at
kvm_loongarch_cpucfg_set_attr() in arch/loongarch/kvm/vcpu.c, it forces
auto-enabled features on:

    val =3D (val | kvm->arch.pv_auto_features) & valid;

Will this cause the source kernel to override userspace if the vmm explicit=
ly
requests the feature to be disabled to maintain live-migration compatibility
with older hosts?

If the guest discovers and uses the feature, but migrates to an older host
that either ignores the requests or rejects the unknown feature flag, could
this result in silent memory corruption or migration failure?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260602021819.2373=
404-1-cui.tao@linux.dev?part=3D2
