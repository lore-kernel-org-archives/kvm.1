Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD94E3F88BB
	for <kvm@vger.kernel.org>; Thu, 11 Jun 2026 12:58:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781182731; cv=none; b=rvYg7Z3vsBzQeT2s5bpZ58so/wU9Nax5g1d/ZQeuedauMeNsrByD6ftR0qZ9xCWrkc+wLvPf6kZqtmuIXWdY/Ypf0p7lzk3AVyR6ue8fvaWETX9/9hAzYbZ18uLUxk6qYzojmlOnfq8PUUYNvlW86Zj9Z15z3spQjnrBVHp7+mo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781182731; c=relaxed/simple;
	bh=JgTdTIgEKDu7c4xh60cOrp6tvph15X5Z2fyTzt5M3hk=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=bLq/YNNwnI+WFfwHcWRcpLLRius1IVU21/tFZ7tkZWmqYTMaK0ebYaUSM92hD98minj2U5o6I70LgFZYsMqeNxjomeTWJz5hJayjPxeGRdwxk0Lgw1O3SgJkYuUdPsuhG4NXCoKj9dR/bZPzLalmssB2OVwjNeYqzbGezh9IIdk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AwgGuLPG; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AwgGuLPG"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9ED631F00893;
	Thu, 11 Jun 2026 12:58:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781182729;
	bh=Kp1AyRHQnM2AA9WTGDVQb4qt84arujeigHrNax8uwCE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=AwgGuLPGy4ltYMruKNpsPlL6h0iE+RHmXYQTREpGrmU67B5OJ7lSZEIZ+6yLOx9Uk
	 gcYkMxFRY4b49hf4PceL8hx7bGF49bo8XHvbCbslOXYq11Wqcg3VP0gxWB/inEh/gd
	 KylUPTnFwtWbNkbxL1oQQGNvufjf4ZKjKIcIQjkaV8U77+zem00m/H0pGvF8GLGq5N
	 HWAJPje4Gai5m0uZ9ZXgZ8X5jeZTHcm4gcXB5YHK3z1BJUvVHtMiuJqoj/CYmsKJ1D
	 J76quryPV3zp2QdT2ZTDl2YD/UX5mN4Z7Jenx1Pj46M+1H+sIlorkjwfxITVWI3NIy
	 F6yTlgzcrDJWA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 4/4] kvm: svm: Support KVM_SEV_SNP_PAGE_TYPE_VMSA at
 SNP_LAUNCH_UPDATE
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?SsO2cmcgUsO2ZGVs?= <joro@8bytes.org>
Cc: kvm@vger.kernel.org
In-Reply-To: <20260611123528.572255-5-joro@8bytes.org>
References: <20260611123528.572255-5-joro@8bytes.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 11 Jun 2026 12:58:49 +0000
Message-Id: <20260611125849.9ED631F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 5 potential issue(=
s) to consider:

New issues:
- [High] Missing `srcu_read_lock()` when calling `gfn_to_memslot()` in `sev=
_es_vmsa_pa()`, leading to a potential Use-After-Free of KVM memslots.
- [Low] The local variable `sev_features` in `sev_gmem_post_populate()` is =
assigned but never used.

Pre-existing issues:
- [Critical] KVM writes firmware data to a potentially read-only userspace =
page during CPUID error recovery, which could corrupt the global zero page.
- [High] Out-of-order `kunmap_local()` calls violate the highmem API's stri=
ct LIFO unmapping requirement.
- [High] A malicious host userspace process can trigger a kernel warning (`=
WARN_ON_ONCE`) by passing a NULL user address (`uaddr =3D 0`) when issuing =
`KVM_SEV_SNP_LAUNCH_UPDATE` for any non-ZERO page type.
--

commit f2475c503a445642b6525297ce3c8dd1d2a1067f
Author: Joerg Roedel <joerg.roedel@amd.com>

kvm: svm: Support KVM_SEV_SNP_PAGE_TYPE_VMSA at SNP_LAUNCH_UPDATE

This commit adds support for setting a VMSA in guest physical memory
during the SEV-SNP launch process. It introduces a new page type,
KVM_SEV_SNP_PAGE_TYPE_VMSA, which is used for the BSP.

> diff --git a/arch/x86/kvm/svm/sev.c b/arch/x86/kvm/svm/sev.c
> index 0c42af2e62016..52d0fa5ebdab1 100644
> --- a/arch/x86/kvm/svm/sev.c
> +++ b/arch/x86/kvm/svm/sev.c

[ ... ]

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

[Severity: Low]
Is the sev_features variable necessary? It gets assigned below when
processing a KVM_SEV_SNP_PAGE_TYPE_VMSA page but doesn't appear to be
used anywhere else in this function.

[ ... ]

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
> +			if (accept_page)
> +				sev_features =3D vmsa->sev_features;
> +		}
> =20
>  		kunmap_local(src_vaddr);
>  		kunmap_local(dst_vaddr);

[Severity: High]
This is a pre-existing issue, but does this violate the LIFO unmapping
requirement of the highmem API?

The kmap_local_page() documentation requires mappings to be unmapped in the
exact reverse order. Here src_vaddr is mapped first, then dst_vaddr, but
they are unmapped in the same order instead of reverse. Could this corrupt
the internal stack on the next kmap/kunmap operations?

[ ... ]

> @@ -2593,6 +2622,9 @@ static int sev_gmem_post_populate(struct kvm *kvm, =
gfn_t gfn, kvm_pfn_t pfn,
>  		kunmap_local(dst_vaddr);
>  	}
> =20
> +	if (ret =3D=3D 0 && sev_populate_args->type =3D=3D KVM_SEV_SNP_PAGE_TYP=
E_VMSA)
> +		sev->initial_vmsa_gpa =3D gpa;
> +

[Severity: High]
Will this new VMSA initialization path expose a use-after-free of KVM
memslots during launch finish?

By setting sev->initial_vmsa_gpa to a valid page here, the ioctl path
KVM_SEV_SNP_LAUNCH_FINISH can now call sev_es_vmsa_pa(), which looks up the
slot:

arch/x86/kvm/svm/sev.c:sev_es_vmsa_pa() {
    ...
    slot =3D gfn_to_memslot(vcpu->kvm, gfn);
    ...
}

Since the launch finish ioctl takes kvm->lock and vcpu->mutex, but not
srcu_read_lock(), could a concurrent memslot update swap and free the
memslot before it is accessed in kvm_gmem_get_pfn()?

>  out:
>  	if (ret)
>  		pr_debug("%s: error updating GFN %llx, return code %d (fw_error %d)\n",
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

[Severity: Critical]
This isn't a bug introduced by this patch, but does the error recovery path
for KVM_SEV_SNP_PAGE_TYPE_CPUID write to a potentially read-only page?

When handling the CPUID type, kvm_gmem_populate() calls get_user_pages_fast=
()
with gup_flags =3D 0, requesting read-only access. If userspace mapped a
read-only page like the global zero page, GUP will succeed.

If the firmware returns SEV_RET_INVALID_PARAM, sev_gmem_post_populate() maps
the page with kmap_local_page() and copies the expected values into it:

memcpy(src_vaddr, dst_vaddr, PAGE_SIZE);

Could this illegally overwrite read-only memory and corrupt the global zero
page?

> +	if (params.type =3D=3D KVM_SEV_SNP_PAGE_TYPE_VMSA) {
> +		/* VMSA page are allowed only once */
> +		if (sev->initial_vmsa_gpa !=3D INVALID_PAGE)
> +			return -EBUSY;
> +		/* Can only deploy a single page as VMSA */
> +		if (params.len !=3D PAGE_SIZE)
> +			return -EINVAL;
> +	}
> =20
>  	src =3D params.type =3D=3D KVM_SEV_SNP_PAGE_TYPE_ZERO ? NULL : u64_to_u=
ser_ptr(params.uaddr);

[Severity: High]
This is a pre-existing issue, but can a host userspace process trigger a
kernel warning by passing a NULL user address (uaddr =3D 0) here?

If params.uaddr is 0, src becomes NULL and passes the PAGE_ALIGNED(src)
check. kvm_gmem_populate() skips fetching the user page and passes
src_page =3D NULL to sev_gmem_post_populate().

That function then unconditionally evaluates:

WARN_ON_ONCE(sev_populate_args->type !=3D KVM_SEV_SNP_PAGE_TYPE_ZERO &&
             !src_page)

Since the type isn't ZERO, won't this allow an unprivileged user to spam
the kernel log?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260611123528.5722=
55-1-joro@8bytes.org?part=3D4
