Received: from mail-pf1-f201.google.com (mail-pf1-f201.google.com [209.85.210.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21D393C1961
	for <kvm@vger.kernel.org>; Tue, 23 Jun 2026 14:46:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782226020; cv=none; b=UW9FD9AO+g+IkVfwztn1Z6U4Prhy+y767XfSZ0tRJr60x+AXanVa91l8kUKEDFY+M0bW2wW/rUQE69TQIEguwY4d2Gq7h0JoaQQe0Uy1PWsHhpRK5v+6lNoLAORa8mN7+fD98dPkap5pKQJN0iICeCpbg+bcDDOcP3PJ+jio8GY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782226020; c=relaxed/simple;
	bh=uCovmKLbfmFLoE2/urfF+dvVPy41a+i6I//kOeY8DcY=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=DsWluSkNiMZwY9KZHWI/wkNGmUYr0QJ9DaL/hr32m9yhK4XFRefzTkUYwFIdvVMGIqH3ANv0+LwnFLU79BP9sMKibPCWyAY64oN8Joqzvd7Oea6GdjSwh6ZOJhvoqaG7e+56BIl2V7tc4C2RiykeHkwRgHppW6oAinCevimC5is=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=TUM+gnCg; arc=none smtp.client-ip=209.85.210.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="TUM+gnCg"
Received: by mail-pf1-f201.google.com with SMTP id d2e1a72fcca58-8423f3e4728so3676558b3a.2
        for <kvm@vger.kernel.org>; Tue, 23 Jun 2026 07:46:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1782226017; x=1782830817; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UdMlzNzBO3Xt+yspWM89C1Xa5bIxqPG08PXu7xLh3sw=;
        b=TUM+gnCgsL6Lbfjlm/S6MCLZpoByFt5/nzsHZOHKAhPnfefuAz6eCNG9Vj0GvQYBCW
         zTrEWF+CRAjRWTR5jKC3LZKcgT6juztjL8UOucdQl0z9o2Thm7hu2Ws5tlS+S38Lj2Np
         jeghzLw2K3XBI8/wtENn9r3F4Fop6mIw7vpVQoMTKM8balfSyE4b2CMHAU8NMZ6yS3Nc
         8iMmSLsNb8rLqH6WLmF34u/E7K/dkpYTr9GbBIgEpdH+jaZFwX/RpaKK389R6PLSs+JG
         2yKA7URmKOVm8BRzPlq0JgqNwotrjiZUtqNbXsGJNxPSKPDVPEKn/lWdZ7bM0a3kjJPJ
         lG0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782226017; x=1782830817;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=UdMlzNzBO3Xt+yspWM89C1Xa5bIxqPG08PXu7xLh3sw=;
        b=baZ2LNdfzpMU5H22wpq7sPJt3EEfIy4W2IGIxW5hWovieq90/Xzue3ld+0vjEuKtIu
         3PovTMPbxA7s2dE95U3b7AfDvJjtqoZu/NyYwW09sxvu+2C2smerY6qtB3WKE2t6JCd8
         aUo9usJCevLarFlx8kCCdscBfxSiZyrD9tkx8Mu4GY0tspmho4dyGA+LGU5TXHIBTMju
         OykNLvcQVBInuAct75kIutZa4Hxvp61f2+u94vBBdguJ/CXi3xdu6gRbnFPtP+eDbs2L
         maXJYuVef4RNyjCnCsSx5eyZpYxLyaHBEy+OQopNdrc2Vcpq/x5bkHgZn8LlbcnRkVuE
         Er5g==
X-Forwarded-Encrypted: i=1; AFNElJ++he1uGaMO3A9/59/uRjeOfCTRnKvEF3UiP1GW0OSCutK7BxMWgWP8tZazgN9chtkR1h8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxq7RG4lgimm+IDcWbphYTofw/3KiGGehNPdROjPV+ftVNZ2Ba6
	SakDVoL38bSB++zZhTOmioPnjMcndtQcM8g7/Smbc+brzJcmJgu0mewSD3kjnq1ruE2cx9+fZqD
	1DdA0iQ==
X-Received: from pfcp22.prod.google.com ([2002:a05:6a00:a256:b0:842:83c0:8d73])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:438e:b0:845:3ac5:1b8a
 with SMTP id d2e1a72fcca58-84595115b40mr4016477b3a.0.1782226017134; Tue, 23
 Jun 2026 07:46:57 -0700 (PDT)
Date: Tue, 23 Jun 2026 07:46:56 -0700
In-Reply-To: <20260623091556.1500930-2-joro@8bytes.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260623091556.1500930-1-joro@8bytes.org> <20260623091556.1500930-2-joro@8bytes.org>
Message-ID: <ajqcYNMkfX0fsyF0@google.com>
Subject: Re: [PATCH 1/4] kvm: sev: Fix user-space triggerable WARN_ON on
 snp_launch_update path
From: Sean Christopherson <seanjc@google.com>
To: "=?utf-8?B?SsO2cmcgUsO2ZGVs?=" <joro@8bytes.org>
Cc: Paolo Bonzini <pbonzini@redhat.com>, x86@kernel.org, Kiryl Shutsemau <kas@kernel.org>, 
	Rick Edgecombe <rick.p.edgecombe@intel.com>, Tom Lendacky <thomas.lendacky@amd.com>, 
	Ashish Kalra <ashish.kalra@amd.com>, Michael Roth <michael.roth@amd.com>, kvm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-coco@lists.linux.dev, 
	Joerg Roedel <joerg.roedel@amd.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Please capitalize the scope, i.e. "KVM: SEV:".

On Tue, Jun 23, 2026, J=C3=B6rg R=C3=B6del wrote:
> From: Joerg Roedel <joerg.roedel@amd.com>
>=20
> Sashiko reported on an unrelated patch:
>=20
>   [Severity: High]
>   This is a pre-existing issue, but can a host userspace process trigger =
a
>   kernel warning by passing a NULL user address (uaddr =3D 0) here?
>=20
>   If params.uaddr is 0, src becomes NULL and passes the PAGE_ALIGNED(src)
>   check. kvm_gmem_populate() skips fetching the user page and passes
>   src_page =3D NULL to sev_gmem_post_populate().
>=20
>   That function then unconditionally evaluates:
>=20
>   WARN_ON_ONCE(sev_populate_args->type !=3D KVM_SEV_SNP_PAGE_TYPE_ZERO &&
>                !src_page)
>=20
>   Since the type isn't ZERO, won't this allow an unprivileged user to spa=
m
>   the kernel log?

Use Reported-by: + Closes to capture Sashiko's effecitve bug report instead=
 of
copy+pasting the finding.  There's no reason to treat Sashiko any different=
ly
than any other bot.

> The assessment is correct, so check for this condition earlier in the
> snp_launch_update() path to avoid the WARN_ON_ONCE.
>=20
> Fixes: dee5a47cc7a45 ("KVM: SEV: Add KVM_SEV_SNP_LAUNCH_UPDATE command")
> Signed-off-by: Joerg Roedel <joerg.roedel@amd.com>
> ---
>  arch/x86/kvm/svm/sev.c | 7 +++++++
>  1 file changed, 7 insertions(+)
>=20
> diff --git a/arch/x86/kvm/svm/sev.c b/arch/x86/kvm/svm/sev.c
> index 6c6a6d663e29..41dcba5180ca 100644
> --- a/arch/x86/kvm/svm/sev.c
> +++ b/arch/x86/kvm/svm/sev.c
> @@ -2438,6 +2438,13 @@ static int snp_launch_update(struct kvm *kvm, stru=
ct kvm_sev_cmd *argp)
>  	if (!PAGE_ALIGNED(src))
>  		return -EINVAL;
> =20
> +	/*
> +	 * Make sure user-mode did not pass NULL as src with
> +	 * type !=3D KVM_SEV_SNP_PAGE_TYPE_ZERO.

Meh, that's pretty obvious from the code.

> +	 */
> +	if (src =3D=3D NULL && params.type !=3D KVM_SEV_SNP_PAGE_TYPE_ZERO)

I think I'd prefer this over checking for KVM_SEV_SNP_PAGE_TYPE_ZERO twice,
especially since the PAGE_ALIGNED() check for the NULL pointer case is rath=
er
weird.

	if (params.type =3D=3D KVM_SEV_SNP_PAGE_TYPE_ZERO)
		src =3D NULL;
	else if (!params.uaddr || !PAGE_ALIGNED(params.uaddr))
		return -EINVAL;
	else
		src =3D u64_to_user_ptr(params.uaddr);


> +		return -EINVAL;

Gah, we created quite the mess for ourselves.  TDX returns -EOPNOTSUPP inst=
ead
of -EINVAL, I guess as a placeholder for in-place conversion?  I don't care=
 which
error code is returned, but I do want KVM to be consistent.

We should also adjust TDX to pre-check the source address, because checking=
 only
in the post-populate flow subtly relies on tdx_vcpu_init_mem_region() retur=
ning
immediately on error.  If that weren't the case (ignoring for the moment th=
at
continuing on would be nonsensical), KVM would advace the address by PAGE_S=
IZE
and suddenly a NULL userspace address becomes non-NULL.

I also think it makes sense to drop the WARN in sev_gmem_post_populate(), i=
t's
completely redundant once this bug is fixed.

Ugh, and both SNP and TDX fail to account for tags, and fail to check for
striding into kernel space.  Which I suppose is fine, since gup() handles t=
hose
correctly.  And I don't see a strong argument for disallowing tagged addres=
ses,
because unlike the userspace address for memslots, KVM doesn't keep the add=
ress
around long-term.

So over two patches, the below?  I can send a v2, I've already got changelo=
gs
written (I was fiddling around with extracting and reusing kvm_set_memory_r=
egion()'s
checks on the userspace address+size, but as above, convinced myself that K=
VM
should continue to allow tagged addresses for SNP and TDX).

---
 arch/x86/kvm/svm/sev.c | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/arch/x86/kvm/svm/sev.c b/arch/x86/kvm/svm/sev.c
index 74fb15551e83..621a2eaa58f2 100644
--- a/arch/x86/kvm/svm/sev.c
+++ b/arch/x86/kvm/svm/sev.c
@@ -2330,9 +2330,6 @@ static int sev_gmem_post_populate(struct kvm *kvm, gf=
n_t gfn, kvm_pfn_t pfn,
 	int level;
 	int ret;
=20
-	if (WARN_ON_ONCE(sev_populate_args->type !=3D KVM_SEV_SNP_PAGE_TYPE_ZERO =
&& !src_page))
-		return -EINVAL;
-
 	ret =3D snp_lookup_rmpentry((u64)pfn, &assigned, &level);
 	if (ret || assigned) {
 		pr_debug("%s: Failed to ensure GFN 0x%llx RMP entry is initial shared st=
ate, ret: %d assigned: %d\n",
@@ -2421,10 +2418,12 @@ static int snp_launch_update(struct kvm *kvm, struc=
t kvm_sev_cmd *argp)
 	     params.type !=3D KVM_SEV_SNP_PAGE_TYPE_CPUID))
 		return -EINVAL;
=20
-	src =3D params.type =3D=3D KVM_SEV_SNP_PAGE_TYPE_ZERO ? NULL : u64_to_use=
r_ptr(params.uaddr);
-
-	if (!PAGE_ALIGNED(src))
+	if (params.type =3D=3D KVM_SEV_SNP_PAGE_TYPE_ZERO)
+		src =3D NULL;
+	else if (!params.uaddr || !PAGE_ALIGNED(params.uaddr))
 		return -EINVAL;
+	else
+		src =3D u64_to_user_ptr(params.uaddr);
=20
 	npages =3D params.len / PAGE_SIZE;

---
 arch/x86/kvm/vmx/tdx.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/arch/x86/kvm/vmx/tdx.c b/arch/x86/kvm/vmx/tdx.c
index ffe9d0db58c5..b0ec054732b9 100644
--- a/arch/x86/kvm/vmx/tdx.c
+++ b/arch/x86/kvm/vmx/tdx.c
@@ -3198,9 +3198,6 @@ static int tdx_gmem_post_populate(struct kvm *kvm, gf=
n_t gfn, kvm_pfn_t pfn,
 	if (KVM_BUG_ON(kvm_tdx->page_add_src, kvm))
 		return -EIO;
=20
-	if (!src_page)
-		return -EOPNOTSUPP;
-
 	kvm_tdx->page_add_src =3D src_page;
 	ret =3D kvm_tdp_mmu_map_private_pfn(arg->vcpu, gfn, pfn);
 	kvm_tdx->page_add_src =3D NULL;
@@ -3247,8 +3244,8 @@ static int tdx_vcpu_init_mem_region(struct kvm_vcpu *=
vcpu, struct kvm_tdx_cmd *c
 	if (copy_from_user(&region, u64_to_user_ptr(cmd->data), sizeof(region)))
 		return -EFAULT;
=20
-	if (!PAGE_ALIGNED(region.source_addr) || !PAGE_ALIGNED(region.gpa) ||
-	    !region.nr_pages ||
+	if (!PAGE_ALIGNED(region.source_addr) || !region.source_addr ||
+	    !PAGE_ALIGNED(region.gpa) || !region.nr_pages ||
 	    region.gpa + (region.nr_pages << PAGE_SHIFT) <=3D region.gpa ||
 	    !vt_is_tdx_private_gpa(kvm, region.gpa) ||
 	    !vt_is_tdx_private_gpa(kvm, region.gpa + (region.nr_pages << PAGE_SHI=
FT) - 1))
--=20
