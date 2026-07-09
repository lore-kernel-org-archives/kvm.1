Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B273D3B14D0
	for <kvm@vger.kernel.org>; Thu,  9 Jul 2026 21:07:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783631249; cv=none; b=Uxlvix/yQf8gvztqWmGEZrp1q4zdVYCqeEpMuUoCKEN26LLTCEIqR9VEOZ5+ZAsiuyDi4zKH19/QswAz1VdrikJOinFfE4hqXytFN5bfWtWgp80Hhl6uKPGmJnQhQ9HU2ALEo+wc2IeX5m0+fwd0YYlNdizcSQJj94y/SZD8OrU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783631249; c=relaxed/simple;
	bh=EKBGLTFmeX22J0M7l/E0XUX4keKBP18j0gsKcnJkz0A=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=COk/sPr/SEvq6pEdSNcVAtYCw3Xptm7u4uRoNMMtMZCr34PRHrGOg2G8IWEHUPOX4Zm2WmyEheQlRFGY6ahN9mXyjB1JJOuGFRRjD31xogB0O2oPVHVcIagyQG5baIwljw/Hqmc7YxM5LiKKtwbi57TziQL0WjDZtEjotcz10UY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=K09ka3od; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="K09ka3od"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1205A1F000E9;
	Thu,  9 Jul 2026 21:07:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783631248;
	bh=V2QvryPN3b9yPbDSBSbjtIZ3TJyWVrf/iXCguKsl2lo=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=K09ka3od4gJ0mGXkcezx7ZQga93pQEgPliHW/oM7cliIsYFTyBMKBpJyMD+oFq8r7
	 BCChmNksAgVCdMAR/tWU36D71Jxh9/6BfHLwCAvXjy54+LlmqI8vpHg6+K2n6Cs2t7
	 1LE6nmxTOhkuoMGP3RrXswMkjaqdl15LCE2CYNoKw4t2F/7S4TQGmUEP+/XYyii37X
	 zPkX1/6/iiWLYMGAKjglyWArwdg65PuJPUOjh3kE9YTyr41eBd+k0R7Zz+VSYFkGxf
	 6qEoxKiDEblfJZ+zrFTG83OiDVSp4ucay4vVCeAaiumGsFURCQemKVVPJ+vhUV2f+C
	 cqRmeuWWPd/sQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 01/18] KVM: SEV: Track the GPA of the
 guest-controlled VMSA used for SNP guests
Reply-To: sashiko-reviews@lists.linux.dev
To: "Sean Christopherson" <seanjc@google.com>
Cc: kvm@vger.kernel.org
In-Reply-To: <20260709204948.1988414-2-seanjc@google.com>
References: <20260709204948.1988414-1-seanjc@google.com>
 <20260709204948.1988414-2-seanjc@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 09 Jul 2026 21:07:27 +0000
Message-Id: <20260709210728.1205A1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [Critical] Missing MMU invalidation retry protocol when resolving and ins=
talling the guest_memfd VMSA page, causing a TOCTOU race leading to physica=
l Use-After-Free.
--

--- Patch [1]: [PATCH v4 01/18] KVM: SEV: Track the GPA of the guest-contro=
lled VMSA used for SNP guests ---
commit 78360a5e270c82d6286a0a511ee0ec1f25aec337
Author: Sean Christopherson <seanjc@google.com>

KVM: SEV: Track the GPA of the guest-controlled VMSA used for SNP guests
   =20
This commit tracks the GPA of the guest-provided VMSA used after AP_CREATION
events for SNP guests. It renames the tracking variables to clarify pending
vs. in-use GPAs to facilitate reacting to MMU invalidation events.

> diff --git a/arch/x86/kvm/svm/sev.c b/arch/x86/kvm/svm/sev.c
> index 74fb15551e83f..827f5dc061023 100644
> --- a/arch/x86/kvm/svm/sev.c
> +++ b/arch/x86/kvm/svm/sev.c
[ ... ]
> @@ -4039,6 +4040,7 @@ static void sev_snp_init_protected_guest_state(stru=
ct kvm_vcpu *vcpu)
>  	svm->sev_es.snp_has_guest_vmsa =3D true;
> =20
>  	/* Use the new VMSA */
> +	svm->sev_es.snp_guest_vmsa_gpa =3D gfn_to_gpa(gfn);
>  	svm->vmcb->control.vmsa_pa =3D pfn_to_hpa(pfn);

[Severity: Critical]
This is a pre-existing issue, but does this bypass the MMU invalidation ret=
ry
protocol?

Looking at sev_snp_init_protected_guest_state(), KVM resolves the PFN via
kvm_gmem_get_pfn(), directly installs it into the hardware VMCB, and drops
the page reference:

	if (kvm_gmem_get_pfn(vcpu->kvm, slot, gfn, &pfn, &page, NULL))
		return;
	...
	svm->vmcb->control.vmsa_pa =3D pfn_to_hpa(pfn);
	...
	kvm_release_page_clean(page);

Can this race with a concurrent guest_memfd hole punch if kvm->mmu_lock isn=
't
held and the invalidation sequence counter isn't verified?

If the page is freed back to the host allocator, could the hardware continue
to use a freed host physical page for the VMSA, leading to a physical
use-after-free?

>  	/* Mark the vCPU as runnable */
>  	kvm_set_mp_state(vcpu, KVM_MP_STATE_RUNNABLE);

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260709204948.1988=
414-1-seanjc@google.com?part=3D1
