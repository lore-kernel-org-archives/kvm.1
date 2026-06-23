Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A1513AF665
	for <kvm@vger.kernel.org>; Tue, 23 Jun 2026 21:29:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782250145; cv=none; b=PvojjuQmEPQ8dWf30Upy5EqC+OG0BoDRwoTfyQkVW3w2bxIDth8n2pamgmYSNQxeaU8D5lFYGtvwCgPuFh1V6IrPSm4Co5Sqk4zRxOcuk8KZ62+Evsmq3cplCHjlZZt0nZsFXY+fPH2Frdy0mgUrT52TtvhgH+TD81tNg6EpUJ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782250145; c=relaxed/simple;
	bh=3cQMzhfg+25nxUHNtM7RtBNw+Rwmo7PzddlXDBN8VX8=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=V+opd+mQCb+pqn3FBncCT6IlAo8p7iZcWIJR4gXooCOmedLmVikwclTF1hEsavwKg5h7vRZ7opKecFObj6A8RdCkOu0cL8xXw0/MO8gtsgUmHMUViZ3ngFKa95M1oOHGsVhEMjkj5I1KwLxACC9ekVoCwM2MmXIJZTZUffMnMSs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=W97vRUgi; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="W97vRUgi"
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-8454912a507so501747b3a.2
        for <kvm@vger.kernel.org>; Tue, 23 Jun 2026 14:29:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1782250143; x=1782854943; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jkKWV5gdIkZ54834rDAP307RtZTIdKimOOX+hiOYKSU=;
        b=W97vRUgiXLe2iAFQL9R3dmQM8qPxAwAsAG533SnEAvx/K+h7mxXmUS2AdXKc7F9TGh
         6BMDcdoN4SFrBXDBazRYTZYWkLJPqJzOd2bc+yGbu+w/DX6SRex/AoHeMHDebVtbFUcN
         yip+39wAEg9MDPRabmtWhgZnT/AUTzqhonp8tX1yuF8VX1TOesEcnoeMGJgjOCPFQl83
         j7cFrrRbg3Sw7NGzg4OKJKMfihTunJad3d40wXbGYNo+2P9kc62cI0NQ2dfrMPNmvvbL
         xJlyMEYzwX8hbGEAHAJXgvtW76x/2KTTiTCOBwC0bdt7Dm2xahV47IxIMMFxCX2Uakgz
         fQFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782250143; x=1782854943;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=jkKWV5gdIkZ54834rDAP307RtZTIdKimOOX+hiOYKSU=;
        b=a+ZHES7Gloc1AW25jBAQ5qbkRJLEbAEb0ByFD9ny6VcsZJzj+2fl5sA1XxdnuM+wNP
         lBHTGYnn5Ya3tweFTBsh8jsFcs/eWahTq1X6SQiz8vXPsnWHGPCImtigSOZTc9f9zalY
         IANITtX2oDKgawmvxOETiARQS4vUEtppUflbbchVOWuTkF7dTzgXcMaz+TrykMxxYBco
         fSaSGR2uUAhhkAueaRUVtJUDkLpbbOqIGlR2Gig+7TzaHKkeQ1Cr77WpSO7Pcfpt9mkA
         uKiF7FrJlHG4UFN3Ea9kx0o+Adkmvnd2FBKOVu0YS/e87LQ7dZl0mkadGRVb3ZsrtRpc
         Tplg==
X-Forwarded-Encrypted: i=1; AFNElJ8ezJtWpa/LfsnX88jFWK8vwx4VSHP+knYbDsF/nRrKDATx0oyTYZYTyaOddsZp8EcOfA8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwL8TIqLVMaHV/HtGBjff3ov6upoePDAIKWRBfEG7Hi1dSD0Px2
	nsDbSJDqiqBsaOXQJjxWu7zQse1PQtjg6oRF9QHAjT3Rl/hD3PyHinofdO/epmrULEXJ+qaTgXn
	3gjHogw==
X-Received: from pfbjt37.prod.google.com ([2002:a05:6a00:91e5:b0:842:6be9:dfb1])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:b4a:b0:843:49f0:f5a0
 with SMTP id d2e1a72fcca58-845a2caa198mr862492b3a.32.1782250142206; Tue, 23
 Jun 2026 14:29:02 -0700 (PDT)
Date: Tue, 23 Jun 2026 14:29:01 -0700
In-Reply-To: <20260611123528.572255-5-joro@8bytes.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260611123528.572255-1-joro@8bytes.org> <20260611123528.572255-5-joro@8bytes.org>
Message-ID: <ajr6nW11Ss9IP4gp@google.com>
Subject: Re: [PATCH 4/4] kvm: svm: Support KVM_SEV_SNP_PAGE_TYPE_VMSA at SNP_LAUNCH_UPDATE
From: Sean Christopherson <seanjc@google.com>
To: "=?utf-8?B?SsO2cmcgUsO2ZGVs?=" <joro@8bytes.org>
Cc: Paolo Bonzini <pbonzini@redhat.com>, x86@kernel.org, 
	Tom Lendacky <thomas.lendacky@amd.com>, Michael Roth <michael.roth@amd.com>, kvm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, coconut-svsm@lists.linux.dev, 
	Joerg Roedel <joerg.roedel@amd.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 11, 2026, J=C3=B6rg R=C3=B6del wrote:
> From: Joerg Roedel <joerg.roedel@amd.com>
>=20
> Support setting a VMSA in guest physical memory during the SEV-SNP
> launch process. Only one VMSA can be provided which will then be used
> for the BSP. All of the APs will not have a VMSA allocated or assigned
> when this feature is used.
>=20
> This ensures stable launch measurements on SEV-SNP which are
> independent of the number of VCPUs the VM is launched with.
>=20
> Signed-off-by: Joerg Roedel <joerg.roedel@amd.com>
> ---
>  arch/x86/include/uapi/asm/kvm.h |  1 +
>  arch/x86/kvm/svm/sev.c          | 44 ++++++++++++++++++++++++++++++++-
>  arch/x86/kvm/x86.c              |  1 +
>  include/uapi/linux/kvm.h        |  1 +
>  4 files changed, 46 insertions(+), 1 deletion(-)
>=20
> diff --git a/arch/x86/include/uapi/asm/kvm.h b/arch/x86/include/uapi/asm/=
kvm.h
> index 5f2b30d0405c..fc87a5ba295b 100644
> --- a/arch/x86/include/uapi/asm/kvm.h
> +++ b/arch/x86/include/uapi/asm/kvm.h
> @@ -885,6 +885,7 @@ struct kvm_sev_snp_launch_start {
>  /* Kept in sync with firmware values for simplicity. */
>  #define KVM_SEV_PAGE_TYPE_INVALID		0x0
>  #define KVM_SEV_SNP_PAGE_TYPE_NORMAL		0x1
> +#define KVM_SEV_SNP_PAGE_TYPE_VMSA		0x2
>  #define KVM_SEV_SNP_PAGE_TYPE_ZERO		0x3
>  #define KVM_SEV_SNP_PAGE_TYPE_UNMEASURED	0x4
>  #define KVM_SEV_SNP_PAGE_TYPE_SECRETS		0x5
> diff --git a/arch/x86/kvm/svm/sev.c b/arch/x86/kvm/svm/sev.c
> index 88db83b3ff8e..90399d5d0358 100644
> --- a/arch/x86/kvm/svm/sev.c
> +++ b/arch/x86/kvm/svm/sev.c
> @@ -2520,6 +2520,20 @@ static int snp_launch_start(struct kvm *kvm, struc=
t kvm_sev_cmd *argp)
>  	return rc;
>  }
> =20
> +static bool snp_check_launch_vmsa(struct kvm_sev_info *sev,
> +				  struct sev_es_save_area *vmsa)
> +{
> +	/* VMSA sev_features must match VMs vmsa_features */
> +	if (vmsa->sev_features !=3D sev->vmsa_features)
> +		return false;
> +
> +	/* Must always boot from VMPL0 */

Why?

> +	if (vmsa->vmpl !=3D 0)
> +		return false;
> +
> +	return true;
> +}
> +
>  struct sev_gmem_populate_args {
>  	__u8 type;
>  	int sev_fd;
> @@ -2532,7 +2546,9 @@ static int sev_gmem_post_populate(struct kvm *kvm, =
gfn_t gfn, kvm_pfn_t pfn,
>  	struct sev_gmem_populate_args *sev_populate_args =3D opaque;
>  	struct sev_data_snp_launch_update fw_args =3D {0};
>  	struct kvm_sev_info *sev =3D to_kvm_sev_info(kvm);
> +	gpa_t gpa =3D gfn << PAGE_SHIFT;
>  	bool assigned =3D false;
> +	u64 sev_features =3D 0;
>  	int level;
>  	int ret;
> =20
> @@ -2550,14 +2566,27 @@ static int sev_gmem_post_populate(struct kvm *kvm=
, gfn_t gfn, kvm_pfn_t pfn,
>  	if (src_page) {
>  		void *src_vaddr =3D kmap_local_page(src_page);
>  		void *dst_vaddr =3D kmap_local_pfn(pfn);
> +		struct sev_es_save_area *vmsa =3D dst_vaddr;
> +		bool accept_page =3D true;
> =20
>  		memcpy(dst_vaddr, src_vaddr, PAGE_SIZE);
> =20
> +		if (sev_populate_args->type =3D=3D KVM_SEV_SNP_PAGE_TYPE_VMSA) {
> +			accept_page =3D snp_check_launch_vmsa(sev, vmsa);

Isn't this technically a breaking change?  AFAICT, nothing prevents userspa=
ce
from adding a VMSA page today.  Ah, never mind, snp_launch_update() does th=
e
check.

Anyways, given that SVM_VMGEXIT_AP_CREATE doesn't check the actual memory, =
and
that control.allowed_sev_features is what provides the "real" protection, I=
 would
rather either trust userspace to not screw up (first choice), or have users=
pace
provide the requested features as a param to the ioctl (second choice, beca=
use
it's purely a nice-to-have for userspace).

Then, assuming we don't *need* to enforce the VMPL0 thing, there's no need =
to
modify sev_gmem_post_populate().  I.e. decouple adding VMSA page(s) to the =
image
from associating a vCPU with a VMSA.

> +			if (accept_page)
> +				sev_features =3D vmsa->sev_features;
> +		}
> +
>  		kunmap_local(src_vaddr);
>  		kunmap_local(dst_vaddr);
> +
> +		if (!accept_page) {
> +			ret =3D -EINVAL;
> +			goto out;
> +		}
>  	}
> =20
> -	ret =3D rmp_make_private(pfn, gfn << PAGE_SHIFT, PG_LEVEL_4K,
> +	ret =3D rmp_make_private(pfn, gpa, PG_LEVEL_4K,
>  			       sev_get_asid(kvm), true);
>  	if (ret)
>  		goto out;
> @@ -2593,6 +2622,9 @@ static int sev_gmem_post_populate(struct kvm *kvm, =
gfn_t gfn, kvm_pfn_t pfn,
>  		kunmap_local(dst_vaddr);
>  	}
> =20
> +	if (ret =3D=3D 0 && sev_populate_args->type =3D=3D KVM_SEV_SNP_PAGE_TYP=
E_VMSA)
> +		sev->initial_vmsa_gpa =3D gpa;
> +
>  out:
>  	if (ret)
>  		pr_debug("%s: error updating GFN %llx, return code %d (fw_error %d)\n"=
,
> @@ -2620,12 +2652,22 @@ static int snp_launch_update(struct kvm *kvm, str=
uct kvm_sev_cmd *argp)
> =20
>  	if (!params.len || !PAGE_ALIGNED(params.len) || params.flags ||
>  	    (params.type !=3D KVM_SEV_SNP_PAGE_TYPE_NORMAL &&
> +	     params.type !=3D KVM_SEV_SNP_PAGE_TYPE_VMSA &&
>  	     params.type !=3D KVM_SEV_SNP_PAGE_TYPE_ZERO &&
>  	     params.type !=3D KVM_SEV_SNP_PAGE_TYPE_UNMEASURED &&
>  	     params.type !=3D KVM_SEV_SNP_PAGE_TYPE_SECRETS &&
>  	     params.type !=3D KVM_SEV_SNP_PAGE_TYPE_CPUID))
>  		return -EINVAL;
> =20
> +	if (params.type =3D=3D KVM_SEV_SNP_PAGE_TYPE_VMSA) {
> +		/* VMSA page are allowed only once */

Why?  What would go wrong if a VM image has a pile of pre-baked VMSAs?

> +		if (sev->initial_vmsa_gpa !=3D INVALID_PAGE)
> +			return -EBUSY;
> +		/* Can only deploy a single page as VMSA */
> +		if (params.len !=3D PAGE_SIZE)
> +			return -EINVAL;
> +	}
> +
>  	src =3D params.type =3D=3D KVM_SEV_SNP_PAGE_TYPE_ZERO ? NULL : u64_to_u=
ser_ptr(params.uaddr);
> =20
>  	if (!PAGE_ALIGNED(src))
> diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
> index 0550359ed798..dc9abe62476e 100644
> --- a/arch/x86/kvm/x86.c
> +++ b/arch/x86/kvm/x86.c
> @@ -4870,6 +4870,7 @@ int kvm_vm_ioctl_check_extension(struct kvm *kvm, l=
ong ext)
>  	case KVM_CAP_MEMORY_FAULT_INFO:
>  	case KVM_CAP_X86_GUEST_MODE:
>  	case KVM_CAP_ONE_REG:
> +	case KVM_CAP_SNP_DIRECT_VMSA:
>  		r =3D 1;
>  		break;
>  	case KVM_CAP_PRE_FAULT_MEMORY:
> diff --git a/include/uapi/linux/kvm.h b/include/uapi/linux/kvm.h
> index 6c8afa2047bf..bf034435f98c 100644
> --- a/include/uapi/linux/kvm.h
> +++ b/include/uapi/linux/kvm.h
> @@ -996,6 +996,7 @@ struct kvm_enable_cap {
>  #define KVM_CAP_S390_USER_OPEREXEC 246
>  #define KVM_CAP_S390_KEYOP 247
>  #define KVM_CAP_S390_VSIE_ESAMODE 248
> +#define KVM_CAP_SNP_DIRECT_VMSA 249
> =20
>  struct kvm_irq_routing_irqchip {
>  	__u32 irqchip;
> --=20
> 2.53.0
>=20
