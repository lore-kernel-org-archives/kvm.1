Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBF7A3976A0
	for <kvm@vger.kernel.org>; Mon,  8 Jun 2026 20:48:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780951733; cv=none; b=nQtImvgWl0lshaJhP4DaIBcGmZ7XyYS5HsqALlOQBiFvAqP4tarkmrrCcT+7jqTm+smx+ey2FCy0ViZVFt8GdbsV2Nta+8xPUB/jFa4DlUox+dFvzWE/UiwjekEfFzpq6xqU/DVXkNw1SPB3WXJDxqpekI+oqBgQnKxdKwJJD88=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780951733; c=relaxed/simple;
	bh=vvqJiwaTaPbwiSFW0y5S+Pdj4cexUUWFOld9lBW8pnM=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=hBmZj8FrgNd7MGGumaPI3i+GdmlISmQlLCaS6B2eUdndM6m7AEw81PYGbsiTf3PqxDYgvNc8vsappfkkO7QBq2HIqgl34q5+LeeepRiaF7NnODuay3mG3YBx0bFfpgQ0peaW0F5XsSUKY9hV7NjxPdaskUQXObIK1cjMHCr9a30=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TlIEecKa; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TlIEecKa"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 75C301F00893;
	Mon,  8 Jun 2026 20:48:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780951731;
	bh=werhy65zy0RfJlW41P3Zz++dmduOvV3FJfNj9lWBxcE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=TlIEecKaK5LJO7bOkbtLbuic5JU+ROZDyQqGi0azVWO4qWxKX32I7+n0TouSYLOMU
	 +nnX1pxYazAYKwyPtnAaxFO3af0nV+55RlGtjKvqwdEnPKfNn0FDvaeFttb5svWPQZ
	 LAWK6N8v8wwj34mKOecf/hDekER0HsuzAUu84+vKS3rvWf4LtNfk/ecFLSn2LZWf7g
	 r6KIYfXHcg/zKWsc0wRJL+1xyn9pYHxIfNtEhLhRS0QdsNfKrw7mCZSmuBEJUVaO+h
	 P5pRopw9By6BZKaIHs2liQllAilce3MXR5FA3QNU8otQQ++5jKhb6uNJLVccgGH96Z
	 f2usmPpQBbAGg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 45/60] kvm: x86: Update state for all plane VCPUs after
 CPUID update
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?SsO2cmcgUsO2ZGVs?= <joro@8bytes.org>
Cc: kvm@vger.kernel.org
In-Reply-To: <20260608144252.351443-46-joro@8bytes.org>
References: <20260608144252.351443-46-joro@8bytes.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 08 Jun 2026 20:48:51 +0000
Message-Id: <20260608204851.75C301F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:
- [Critical] `kvm_check_cpuid()` is called solely on the target `vcpu` outs=
ide the `vcpu_for_each_plane` loop, failing to expand the FPU state buffer =
(`guest_fpu`) for secondary vCPUs.
- [High] `kvm_hv_vcpu_init()` is incorrectly called on the target `vcpu` in=
stead of the loop variable `v` within the `vcpu_for_each_plane` loop, leavi=
ng sibling vCPUs' Hyper-V state uninitialized.
- [High] Bypassing KVM_RUN protection on CPUID updates leads to plane-wide =
state corruption and `KVM_BUG_ON` crashes because `kvm_can_set_cpuid_and_fe=
ature_msrs` is only evaluated on the target `vcpu`.
--

commit 456fecfe1475933e67e33e9b01b14d9e0c1dc102
Author: Joerg Roedel <joerg.roedel@amd.com>

Make sure to update CPUID dependent state for all VCPUs of a given
plane when CPUID state is updated.

This commit modifies KVM to update CPUID-dependent state across all vCPUs
in a plane when a CPUID update occurs. It iterates over sibling vCPUs to
apply Hyper-V initialization, Xen CPUID updates, and general post-CPUID
state synchronization.

> diff --git a/arch/x86/kvm/cpuid.c b/arch/x86/kvm/cpuid.c
> index 27e2f7e25038..fab075bb6fdc 100644
> --- a/arch/x86/kvm/cpuid.c
> +++ b/arch/x86/kvm/cpuid.c
> @@ -513,6 +513,8 @@ static int kvm_set_cpuid(struct kvm_vcpu *vcpu, struc=
t kvm_cpuid_entry2 *e2,
>  {
>  	struct kvm_vcpu_common *common =3D vcpu->common;
>  	u32 vcpu_caps[NR_KVM_CPU_CAPS];
> +	struct kvm_vcpu *v;
> +	unsigned i;
>  	int r;
> =20
>  	/*

[Severity: High]
Does this plane-wide update bypass the run protection for sibling vCPUs?

The immutability gate kvm_can_set_cpuid_and_feature_msrs() is checked only
against the target vcpu before this newly added plane-wide update.

Could userspace execute the first vCPU, and then successfully call
KVM_SET_CPUID on an un-run second vCPU?

This would apply the CPUID change to the entire plane and invoke:
kvm_vcpu_after_set_cpuid()
  kvm_mmu_after_set_cpuid()

on the already-run first vCPU, which then triggers a KVM_BUG_ON().

[ ... ]

> @@ -562,9 +564,11 @@ static int kvm_set_cpuid(struct kvm_vcpu *vcpu, stru=
ct kvm_cpuid_entry2 *e2,
> =20
>  #ifdef CONFIG_KVM_HYPERV
>  	if (kvm_cpuid_has_hyperv(vcpu)) {
> -		r =3D kvm_hv_vcpu_init(vcpu);
> -		if (r)
> -			goto err;
> +		vcpu_for_each_plane(common, i, v) {
> +			r =3D kvm_hv_vcpu_init(vcpu);

[Severity: High]
Does this loop initialize the target vcpu rather than the iterator v?

This leaves v->arch.hyperv unallocated for secondary vCPUs.

When kvm_vcpu_after_set_cpuid() later invokes kvm_hv_set_cpuid(), can it
trigger a WARN_ON_ONCE if an unprivileged host-userspace process triggers
this path?

> +			if (r)
> +				goto err;
> +		}
>  	}
>  #endif
> =20
>  	r =3D kvm_check_cpuid(vcpu);
>  	if (r)
>  		goto err;

[Severity: Critical]
Is kvm_check_cpuid() expected to be called on all siblings?

Because kvm_check_cpuid() handles dynamic reallocation of the guest_fpu
buffer for XFD features like AMX, calling it only on the target vcpu means
sibling vCPUs miss the expansion.

Could this lead to a host kernel heap out-of-bounds write when the hardware
xsave operation stores expanded FPU state into the unexpanded buffer of a
sibling?

> +	vcpu_for_each_plane(vcpu->common, i, v) {
>  #ifdef CONFIG_KVM_XEN
> -	vcpu->arch.xen.cpuid =3D kvm_get_hypervisor_cpuid(vcpu, XEN_SIGNATURE);
> +		v->arch.xen.cpuid =3D kvm_get_hypervisor_cpuid(vcpu, XEN_SIGNATURE);
>  #endif
> -	kvm_vcpu_after_set_cpuid(vcpu);
> +		kvm_vcpu_after_set_cpuid(v);
> +	}
> =20
>  success:
>  	kvfree(e2);

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260608144252.3514=
43-1-joro@8bytes.org?part=3D45
