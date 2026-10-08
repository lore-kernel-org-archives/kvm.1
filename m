Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2FBE25771
	for <kvm@vger.kernel.org>; Thu,  8 Oct 2026 00:30:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791419428; cv=none; b=E+QUxiHveGvFYx0Vgn74Zml9JlKus9w0ayCn2gtVUirvg/YFRsErU+bMNmUtFdEGZJQQKbPIIi7/x73yl0OFzcCK2ETyetJd/3DYQBMGoPmh8oGOkr7PhCe4oKiZG6Euf+XSH6c50PEr4UAQqrt0daEo7sAlaHVx0bwc5th6axM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791419428; c=relaxed/simple;
	bh=8pr/jnp3aXeACLFtXHI1i6vtwroT/wQkWVAJH/y9KxQ=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=bmVX3IigV87Jzhg68tIF9v5LTOpctEHOIExJ75T22wEcSsZ8hGGXPfmPloz+VXVFfBC1f2HbcHjf3v/LAzAqnphJ6QGaQdCJL3ZJn+YOiARBXaaynwcHYD8JKVSu4ibEhI5OdBdU5YpVPLc39+0A1/sRZHAsd8xh53H5S2ddoy0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gMarFOVF; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gMarFOVF"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5BF171F000FF;
	Thu,  8 Oct 2026 00:30:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791419427;
	bh=G2585Iqr+VGLFXKhXmzIM5Mgie3cLaURgBSPGllVQeI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=gMarFOVFI6vMUvT9aLsd/ujQukBU4DuKUFCrxLFoQfjf89uCvS/MRt5ppRjiforzz
	 FFQspnxIvq8q01ykVaukDbI4MOb9kBW5ylO/rQMY1pedXtMgMiS18MtxOrqf757+Jd
	 FIjV/AOjCyuN/hn8fkyV0BYCyR8KxS3mD3x5eKgCxRRneNmRG7ETy2GeJNreP9wgb0
	 5wzmpDrBVDCe4R/HgbZOiNt+cF3MVDu8D3in0gt79MyIJwH9KlMlTwIzXhrUGEw+bG
	 /wA8mogZ+3rqmS07M9N+vgaAJUWaFyA6HMwndu9hUeQiC666fbuyz2WNY86J0r4EAc
	 nG1oQqMx/hJWg==
Message-ID: <sashiko-outbox-163471@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 10/29] KVM: SVM: Use a static ASID per vCPU
Reply-To: sashiko-reviews@lists.linux.dev
To: "Yosry Ahmed" <yosry@kernel.org>
Cc: kvm@vger.kernel.org
In-Reply-To: <20261008001425.2458927-11-yosry@kernel.org>
References: <20261008001425.2458927-1-yosry@kernel.org>
 <20261008001425.2458927-11-yosry@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 08 Oct 2026 00:30:26 +0000
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Critical] kvm: SEV VM intra-host migration leaves source vCPUs with the =
migrated SEV ASID, enabling cross-VM encryption context sharing
--

commit f1bcd0115d8d6ff1f7f41fcb1c4ff86d4d68a34e
Author: Yosry Ahmed <yosry@kernel.org>

KVM: SVM: Use a static ASID per vCPU

This commit switches KVM from dynamic ASID allocation to a static per-vCPU
ASID scheme on SVM. It removes the generation-based wraparound tracking,
instead tracking pending flushes in the VMCB and reusing the same ASID
across physical CPUs.

> diff --git a/arch/x86/kvm/svm/svm.c b/arch/x86/kvm/svm/svm.c
> index 0c3befd9bc850..8f27722bc4faf 100644
> --- a/arch/x86/kvm/svm/svm.c
> +++ b/arch/x86/kvm/svm/svm.c
[ ... ]
> @@ -3875,37 +3868,24 @@ static int pre_svm_run(struct kvm_vcpu *vcpu)
>  {
[ ... ]
>  	if (is_sev_guest(vcpu))
>  		return pre_sev_run(svm, vcpu->cpu);
> =20
> -	/* FIXME: handle wraparound of asid_generation */
> -	if (svm->current_vmcb->asid_generation !=3D sd->asid_generation)
> -		new_asid(svm, sd);
> +	if (unlikely(svm->vmcb->control.asid =3D=3D fallback_asid))
> +		vmcb_set_flush_asid(svm->vmcb);
> =20
>  	return 0;
>  }

[Severity: Critical]
With the removal of dynamic ASID reallocation in pre_svm_run(), can a source
vCPU permanently retain its migrated SEV ASID after a
KVM_CAP_VM_MOVE_ENC_CONTEXT_FROM migration?

During a KVM_CAP_VM_MOVE_ENC_CONTEXT_FROM migration,
sev_vm_move_enc_context_from() transfers the SEV ASID to the destination VM
and marks the source VM as non-SEV. However, it intentionally skips the
source vCPUs for vanilla SEV VMs:

arch/x86/kvm/svm/sev.c:sev_vm_move_enc_context_from() {
        ...
		if (!dst->es_active)
			continue;

		src_vcpu =3D kvm_get_vcpu(src_kvm, i);
		src_svm =3D to_svm(src_vcpu);
        ...
}

As a result, the source vCPUs retain the transferred SEV ASID (svm->asid)
and the SVM_MISC_ENABLE_SEV bit in their VMCBs.

Previously, because the source VM was no longer considered an SEV guest,
is_sev_guest() would return false, and the dynamic ASID allocation logic in
pre_svm_run() would force the source vCPU to acquire a new, non-SEV ASID
before running.

Now that the dynamic allocation logic is removed, the source vCPU will
permanently retain the migrated SEV ASID.

If a malicious userspace hypervisor executes KVM_RUN on these zombie source
vCPUs, KVM will treat the VM as non-SEV, allowing the hypervisor to bypass
software protections and map its own nested page tables.

Because the VMCB still has the SEV ASID and SEV=3D1, the hardware will decr=
ypt
the destination VM's memory using the destination's key. Does this break
SEV confidentiality and memory isolation by allowing cross-VM encryption
context sharing?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261008001425.2458=
927-1-yosry@kernel.org?part=3D10
