Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 771EA380FE3
	for <kvm@vger.kernel.org>; Wed, 29 Jul 2026 17:28:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785346113; cv=none; b=EGr3G1ExoyvtWy8fTi0KGquYH4cac3gQxDDph5XayoFtaFMSrVlw4/xK/DE8UFUUsJ+xwyAZL+kQXbtkq0+CPTe9+NAtewM77KnOl+3WqWejX08dAEuuW3ojQW6rKlOmamXYJ1a0RMBEy83MF+BNdoFJrHZBVWSDQUHe251vOWw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785346113; c=relaxed/simple;
	bh=4aV2oUeGKpH2JRtdHOgIsMP6ysB3q6ciRdeyG3bBfXc=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=kAmXq8ncQ2v7jLByA8/A93ZinwVN39eUubBiX7QLU8FaDt5fBZxUApwZYPASm6iWwrlL7mQUtq0XVQlAj//dh/psvB5VNPOe2o77q4O/CUJeRC04Rpbr7BqX4TXAOZTsptnvgmX50Szn5MRw/StFDv/za7RTTFE+hj3zwZ3jjEc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AS1TU86g; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AS1TU86g"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5BDE71F00A3A;
	Wed, 29 Jul 2026 17:28:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785346111;
	bh=UP5NYb4MKqbaHlwaYusHiAzprwNeq71Kp/yA64nftso=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=AS1TU86gW7pNhRR3cmebr98VoNH3/PvifwKaA6cbFzH+/yI4fYrDjHPy24xi/X7bx
	 E15Nk+qxFziMD0NdK4oZa/XvzfuwmDDXyUe3x/zcYjlhZBDxugbuQd0XeRNSt9nyG4
	 aT4mbGZ1aaBow7HM7OKJTMsCqzk7eSZOGAcpU4dKx/hBW/hSyWMY7lDqm3sYnBa+Z/
	 uHRuJI3XqG4qph0ASJq2syYV774RYHVVgS4OqMW4KuNbugi3W0vmvCQhKRvHFJefhN
	 1cLnZ9P3BAGaWLr+IZBuDGjzTAskYjik91QtJpxZUEuAFwBCKs9he4Ox4VtexSFunr
	 vvtdgGGn/Kp1Q==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 2/2] KVM: VMX: Fix stale PID-pointer table entry left
 after vCPU free
Reply-To: sashiko-reviews@lists.linux.dev
To: "Dmytro Maluka" <dmaluka@chromium.org>
Cc: kvm@vger.kernel.org
In-Reply-To: <20260729170621.308809-3-dmaluka@chromium.org>
References: <20260729170621.308809-1-dmaluka@chromium.org>
 <20260729170621.308809-3-dmaluka@chromium.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 29 Jul 2026 17:28:30 +0000
Message-Id: <20260729172831.5BDE71F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

Pre-existing issues:
- [Critical] Persistent Use-After-Free of AVIC backing page due to dangling=
 pointer in `avic_physical_id_table` when SVM vCPU creation fails.
- [High] Transient Use-After-Free of vcpu memory due to missing hardware ca=
che invalidation (VPID) and synchronization during VMX vCPU destruction.
--

--- Patch [2]: [PATCH v2 2/2] KVM: VMX: Fix stale PID-pointer table entry l=
eft after vCPU free ---
commit a1d19d2d3c1c1e5aad00c7f77f6736e2bfb89509
Author: Dmytro Maluka <dmaluka@chromium.org>

KVM: VMX: Fix stale PID-pointer table entry left after vCPU free

vCPU creation in kvm_vm_ioctl_create_vcpu() may fail after
kvm_arch_vcpu_create() -> vmx_vcpu_create() already succeeded. In such
case kvm_vm_ioctl_create_vcpu() destroys the newly created vCPU in the
failure path. However, that leaves a side effect: the IPIv pid_table
entry remains configured with this vCPU's pi_desc address.

Link: https://lore.kernel.org/kvm/al4rNqpBYy8FGKPw@blrnaveerao1/

> Note that the same issue exists for SVM AVIC as well [1], to be fixed.

[Severity: Critical]
This is a pre-existing issue, but does SVM vCPU destruction leave a dangling
pointer in avic_physical_id_table?

During KVM_CREATE_VCPU, avic_init_backing_page() sets
avic_physical_id_table[id] to point to the newly allocated AVIC backing page
and marks it valid.

If vCPU creation later fails in kvm_vm_ioctl_create_vcpu(), svm_vcpu_free()=
 is
called but fails to clear this physical ID table entry. kvm_arch_vcpu_destr=
oy()
then calls kvm_free_lapic(), which uses free_page() to release the backing =
page.

The avic_physical_id_table retains a valid physical pointer to this freed
page. If a guest sends an IPI to this freed vCPU ID, could the SVM AVIC
hardware use the stale table entry to perform memory writes on the freed pa=
ge,
causing host kernel memory corruption?

> diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
> index 6b96f7aea20bd..ebf26ea84a50b 100644
> --- a/arch/x86/kvm/vmx/vmx.c
> +++ b/arch/x86/kvm/vmx/vmx.c
> @@ -7572,6 +7572,9 @@ void vmx_vcpu_free(struct kvm_vcpu *vcpu)
>  	nested_vmx_free_vcpu(vcpu);
>  	free_loaded_vmcs(vmx->loaded_vmcs);
>  	free_page((unsigned long)vmx->ve_info);
> +
> +	if (vmx_can_use_ipiv(vcpu))
> +		WRITE_ONCE(to_kvm_vmx(vcpu->kvm)->pid_table[vcpu->vcpu_id], 0);

[Severity: High]
This isn't a bug introduced by this patch, but does clearing the pid_table
entry alone prevent hardware from writing to the freed pi_desc?

According to the Intel SDM (Section 29.1.5), the processor caches PID-point=
er
table entries in the VPID.

Because KVM immediately frees the vcpu memory into kvm_vcpu_cache after
kvm_arch_vcpu_destroy() without issuing a cross-vCPU flush (e.g., via
kvm_make_all_cpus_request(kvm, KVM_REQ_TLB_FLUSH)) to invalidate the VPID
caches of other running vCPUs and synchronize with in-flight IPI deliveries,
can other vCPUs still send hardware IPIs using the cached pi_desc pointer?

Could this result in the IPI hardware writing to the freed vcpu memory and
corrupting another newly created vCPU when the memory is reused from
kvm_vcpu_cache?

>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260729170621.3088=
09-1-dmaluka@chromium.org?part=3D2
