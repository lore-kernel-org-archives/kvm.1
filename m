Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 637EB33F58B
	for <kvm@vger.kernel.org>; Mon, 14 Sep 2026 17:11:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789405866; cv=none; b=BhiksUWKmT6M2iijnGhTDtMYaLXhaeVDEO9reTt8onkfQb82rK8r3YEtDJ09RdDVxRALyE9mBXlN26HQyVzPP78uCq5dZu7QrqzPDet05bKFeUk3rMd1h70iJYOuEWfm3TlL12RfgJuhrROz/wrx9BORqkvLljOz1ldmdj8FmLY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789405866; c=relaxed/simple;
	bh=Z88Leqtb87gnVIW5YMZdRyfxdeqO2DtaII5dFzY9mfk=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=WsZuM8jG2YH9PuhGi0g/vZDRB+cRPHly8NIj6AUL0wlhpvzFrj8kE+Zmsqu/KL31ryI7/x3KpOL0kb+u844mN6MQweaWKl35mbZO3iP4YiS1WxBo7CvGXa7XbzOIqWrmdaVvoDUJSLWSJGvr/mWKX6c/NcjNm3GfpjGtZdoyD7Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Q8J1mjuP; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Q8J1mjuP"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CD8181F000FF;
	Mon, 14 Sep 2026 17:11:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789405865;
	bh=ZRnT4qKCcY56+UiI9ak/ncGwk+E7ZG2Qd1Utz77ZEfI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Q8J1mjuPPuRXDX11X30+qb4PI2V/Yaut4XAgJmC2HvWaTyXWlaZC6l4kyVhauEcan
	 75AsmykmbRIfvJyEnT2LrppO90FRrYtgEAfe1Q/deKCJ7lg8pT7sJzCUVV124krq16
	 ygkC6Wc0LQAYtRMRBTv3Q8ypZG5dV+NkaH43ZV2XGGYvZ2Lj79ppwspxKC2Mo/2wYn
	 TTCAzTJ0MaM6rYyb0GVg3pz0nt7x/Tx1ShVR5MhG4k7QE64tv5x9elQb5WVV20YNaI
	 M3NMV8jOUzSHxba3HugCUp/ME4MmFZfqKkepqU40vlogno1Pp1PgNbD0Of1qZHfmX1
	 p4CaMkNCL5wtA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 3/3] x86/sev: Add guest support for Enhanced SMT
 Protection
Reply-To: sashiko-reviews@lists.linux.dev
To: "Pratik R. Sampat" <prsampat@amd.com>
Cc: kvm@vger.kernel.org
In-Reply-To: <56d81f0c1527c8291733aaea72fb70742fb96719.1789399214.git.prsampat@amd.com>
References: <cover.1789399214.git.prsampat@amd.com>
 <56d81f0c1527c8291733aaea72fb70742fb96719.1789399214.git.prsampat@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 14 Sep 2026 17:11:04 +0000
Message-Id: <20260914171104.CD8181F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] Hyper-V SEV-SNP AP boot path entirely ignores ESMT, leaving VMSA f=
ields as zeroes.
- [Low] The tools header for msr-index.h was not synchronized with the kern=
el header changes.
--

commit 8604f276ddd2e9fc69ba0b3ddf175ec09324c70a
Author: Pratik R. Sampat <prsampat@amd.com>

x86/sev: Add guest support for Enhanced SMT Protection

This commit enables guest support for Enhanced SMT Protection by
populating the vCPU's identity and SMT sibling mask in the VMSA during
AP bringup. The sibling mask is fully set to allow threads of the same
guest to be co-resident.

> diff --git a/arch/x86/coco/sev/core.c b/arch/x86/coco/sev/core.c
> index ecd77d3217f3c..acf25eca1a5c9 100644
> --- a/arch/x86/coco/sev/core.c
> +++ b/arch/x86/coco/sev/core.c
[ ... ]
> @@ -849,6 +850,18 @@ static int wakeup_cpu_via_vmgexit(u32 apic_id, unsig=
ned long start_ip, unsigned
>  	vmsa->vmpl		=3D snp_vmpl;
>  	vmsa->sev_features	=3D sev_status >> 2;
> =20
> +	if (cc_platform_has(CC_ATTR_GUEST_SEV_SNP) &&
> +	    (sev_status & MSR_AMD64_SNP_ESMT_PROT)) {
> +		vmsa->vcpu_id =3D apic_id;
> +		/*
> +		 * The mask fully set puts every vCPU in one group, so any two
> +		 * of them may be co-resident. A legal ESMTP sibling must
> +		 * also match on ASID, so the sibling of a vCPU in guest mode is
> +		 * always either another vCPU of this same guest or idle.
> +		 */
> +		vmsa->vcpu_sibling_mask =3D U32_MAX;
> +	}
> +
>  	/* Populate AP's TSC scale/offset to get accurate TSC values. */
>  	if (cc_platform_has(CC_ATTR_GUEST_SNP_SECURE_TSC)) {

[Severity: High]
Does the Hyper-V SEV-SNP AP boot path also need to initialize ESMT fields?

Looking at hv_snp_boot_ap() in arch/x86/hyperv/ivm.c, the VMSA is initializ=
ed
without the new ESMT fields:

arch/x86/hyperv/ivm.c:hv_snp_boot_ap() {
    ...
	vmsa->vmpl =3D 0;
	vmsa->sev_features =3D sev_status >> 2;

	ret =3D snp_set_vmsa(vmsa, true);
    ...
}

If a Hyper-V SEV-SNP guest with >1 vCPUs is booted with ESMT enabled, the A=
Ps
will be launched with a sibling mask of 0. A mask of 0 does not intersect w=
ith
any other mask, which could prevent the AP from being co-scheduled with any
sibling, leading to a hardware violation or a failure to boot APs.

> diff --git a/arch/x86/include/asm/msr-index.h b/arch/x86/include/asm/msr-=
index.h
> index ee9fb820a1cd7..638867e7b4ec2 100644
> --- a/arch/x86/include/asm/msr-index.h
> +++ b/arch/x86/include/asm/msr-index.h
> @@ -745,7 +745,9 @@
>  #define MSR_AMD64_SNP_SMT_PROT		BIT_ULL(MSR_AMD64_SNP_SMT_PROT_BIT)
>  #define MSR_AMD64_SNP_SECURE_AVIC_BIT	18
>  #define MSR_AMD64_SNP_SECURE_AVIC	BIT_ULL(MSR_AMD64_SNP_SECURE_AVIC_BIT)
> -#define MSR_AMD64_SNP_RESERVED_BITS19_22 GENMASK_ULL(22, 19)
> +#define MSR_AMD64_SNP_ESMT_PROT_BIT	19
> +#define MSR_AMD64_SNP_ESMT_PROT	BIT_ULL(MSR_AMD64_SNP_ESMT_PROT_BIT)
> +#define MSR_AMD64_SNP_RESERVED_BITS20_22 GENMASK_ULL(22, 20)

[Severity: Low]
Does tools/arch/x86/include/asm/msr-index.h need to be synchronized with
these changes?

Currently, MSR_AMD64_SNP_RESERVED_BITS19_22 remains defined in the tools
header without the ESMT_PROT definitions. This missed synchronization could
lead to inconsistencies or warnings when building tools that depend on this
header.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1789399214.gi=
t.prsampat@amd.com?part=3D3
