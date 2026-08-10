Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44D9D3A6B92
	for <kvm@vger.kernel.org>; Mon, 10 Aug 2026 08:31:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786350684; cv=none; b=sF5KMzQfHM724dO3g+9TWoTgFuq3ITAuVNSI1mpQ9OaVrnnKdpjrtUbu3YirOCGvh7SlQjMWBr1wTkFEpZXxXA+Wa45JG7c5zNRdTOcKh4JixzE/Y+PdigUnMKnDCCoVu3/dDGGAZXhFNc99BAIonrU+KArsLzH5FIzsqJOnAkw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786350684; c=relaxed/simple;
	bh=EjmebTKojgu5FxRxl/ZSbTMYImOvIDwSE+BAgnzzgg4=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=S4IoIhJz7QXoVPLYelVHUzbnW8Ck7k1oLPtSbWtMU2lYRLakzILt/EWiJ2nRcFNHCh3bcFe4yP2e02NW3+RQ2pNfBZG55yXUq6lExv9O9oRhowbMZ4gw1DGi8b6LmyHi4g1PpiI1SY0msRpUqcvpg5/EifSbz6aaypof3ScLpJ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=b10QbblH; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="b10QbblH"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AD46C1F000E9;
	Mon, 10 Aug 2026 08:31:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786350682;
	bh=ntyXoeulvWjaxZSpAAGSWbGBNkBPHpAsZK5HbtD4fLQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=b10QbblHOhBLF/wyl1axPJiA8nHTQceEpkp4Jh2Tad50MUU6GiqG9b6L5OcpxbIk0
	 x5sMtHk2Vr/qM9F++NW4TTrQ1Rfeh1onzR6f4+s0kC/6U3z0UaWKkHqU/3k2s309f4
	 DJpWsqTf2tsQLBfthFBXYVh68bj9pLQ25ieAHnOgkgoB4h42YQ/vYXnjmvQaN4Lw/O
	 xaWqrqcLPeVWhZYAtwfsD0pRL90G38bYaXLrvWTaMcforHBpskQvsQ3NQkPdQnagQf
	 Whri+U45wd+kej3igUsXMJoszoDXfXeP5z5TzeRFMb1xs2Ysn6pkP17c4+F7TLsSrG
	 We709NCdOVwsA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] LoongArch: KVM: Fix TOCTOU race on pv_features
Reply-To: sashiko-reviews@lists.linux.dev
To: "Tao Cui" <cui.tao@linux.dev>
Cc: kvm@vger.kernel.org
In-Reply-To: <20260810081321.157258-1-cui.tao@linux.dev>
References: <20260810081321.157258-1-cui.tao@linux.dev>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 10 Aug 2026 08:31:22 +0000
Message-Id: <20260810083122.AD46C1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

Pre-existing issues:
- [High] KVM corrupts guest memory by unconditionally updating steal time f=
or a disabled feature due to an unhandled state-machine transition.
- [High] LoongArch PV features are silently enabled by default, violating K=
VM cross-architecture enumeration invariants.
--

--- Patch [1]: [PATCH] LoongArch: KVM: Fix TOCTOU race on pv_features ---
commit 28d84af1392db0a3c512a369b492d598370fb64d
Author: Tao Cui <cuitao@kylinos.cn>

LoongArch: KVM: Fix TOCTOU race on pv_features

This patch fixes a check-then-set race condition in
kvm_loongarch_cpucfg_set_attr() by replacing it with a cmpxchg loop. This
ensures atomic updates of kvm->arch.pv_features when concurrent vCPUs
attempt to set the attributes.

> diff --git a/arch/loongarch/kvm/vcpu.c b/arch/loongarch/kvm/vcpu.c
> index 20c207d80e31a..55030c37cf061 100644
> --- a/arch/loongarch/kvm/vcpu.c
> +++ b/arch/loongarch/kvm/vcpu.c
> @@ -1164,12 +1164,18 @@ static int kvm_loongarch_cpucfg_set_attr(struct k=
vm_vcpu *vcpu,
[ ... ]
> -		/* All vCPUs need set the same PV features */
> -		if ((kvm->arch.pv_features & LOONGARCH_PV_FEAT_UPDATED)
> -				&& ((kvm->arch.pv_features & valid) !=3D val))
> -			return -EINVAL;
> -		kvm->arch.pv_features =3D val | LOONGARCH_PV_FEAT_UPDATED;
> -		return 0;
> +		/* Atomically install val; the cmpxchg serializes concurrent setters. =
*/
> +		for (;;) {
> +			unsigned long old, new;
> +
> +			old =3D READ_ONCE(kvm->arch.pv_features);
> +			if ((old & LOONGARCH_PV_FEAT_UPDATED) &&
> +			    ((old & valid) !=3D val))
> +				return -EINVAL;

[Severity: High]
This isn't a bug introduced by this patch, but does this logic allow the fi=
rst
configuration write to disable features (ON-to-OFF) without clearing previo=
usly
initialized dependent states?

Since LOONGARCH_PV_FEAT_UPDATED is not yet set on the first write, an expli=
cit
ON-to-OFF transition is allowed.

If userspace initially configures KVM_LOONGARCH_VCPU_PVTIME_CTRL (because t=
he
feature is enabled by default), and later disables KVM_FEATURE_STEAL_TIME v=
ia
CPUCFG_KVM_FEATURE, _kvm_vcpu_load() will still unconditionally request
KVM_REQ_STEAL_UPDATE.

Could this lead to guest memory corruption? When kvm_update_stolen_time()
executes, it relies solely on the cached GPA valid bit:

arch/loongarch/kvm/vcpu.c:kvm_update_stolen_time() {
    ...
    if (!(gpa & KVM_STEAL_PHYS_VALID))
        return;
    ...
}

Should we verify if KVM_FEATURE_STEAL_TIME is still enabled before updating
steal time, or prevent the ON-to-OFF transition if dependent states are
already initialized?

[Severity: High]
This is also a pre-existing issue, but are LoongArch PV features silently
enabled by default?

Looking at kvm_vm_init_features() in arch/loongarch/kvm/vm.c:

arch/loongarch/kvm/vm.c:kvm_vm_init_features() {
    ...
    /* Enable all PV features by default */
    kvm->arch.pv_features |=3D BIT(KVM_FEATURE_IPI);
    kvm->arch.kvm_features |=3D BIT(KVM_LOONGARCH_VM_FEAT_PV_IPI);
    ...
}

Does this violate the KVM subsystem architecture rule that new guest-visible
features must be off by default and discoverable? It seems silently enabling
features could break capability negotiation and live migration.

> +			new =3D val | LOONGARCH_PV_FEAT_UPDATED;
> +			if (cmpxchg(&kvm->arch.pv_features, old, new) =3D=3D old)
> +				return 0;
> +		}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260810081321.1572=
58-1-cui.tao@linux.dev?part=3D1
