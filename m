Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E99133242AC
	for <kvm@vger.kernel.org>; Mon,  8 Jun 2026 22:57:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780959464; cv=none; b=pSWgmK18eEEOScFpFlPu8t7Yp8ZAj2aoaeTYE7ub/sj6DKh1WotLZ/DMLoBcgaPl7QIHRwZUMdD5GK8OwLPNIAtgeJu4eIFvjfp7Duy/+aMH9GbQSJ+vbr4BRQuO7EmhlpwL338sOG+ySaf4PmbDmJt/gDq8+r1gYb0esmGDWXs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780959464; c=relaxed/simple;
	bh=pWZWj3U8GXAUUKrpXWLr982hdvcWLbDw2+Mjl7wqULc=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=qnH7Ihdw1Tz8jLkjzlQT5CWebxMxod0vQnnFdGUKf19Q+XZ+63TSgVfb5iu4rXRVN7NHXuplGcJ+n6kjcYqX3xIPb9DrCskrUkl88grVyMSZ0cmGFi5vTiauF8Xz5ZWVGN8/d1zkqQalXvD/qs/XAJorHMmPdEXlVkIYN7dWCys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AvpNQK1F; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AvpNQK1F"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6C23B1F00893;
	Mon,  8 Jun 2026 22:57:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780959462;
	bh=cT93iUEX8kZxNre7/j2MHLxbcTY9cDJ8Yf/JGv2MfJc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=AvpNQK1FpWag23ipT9d1MkXFU+uoCUCrdg0szJ8vFZORizY4oqEcU394w1KQiofmg
	 WiOQHJywTkdX9yigEfeZXzyj+mg/j1eUoissHG/IW3+ofrD2ncUanXLC4a1GHqW245
	 /PALuMnoiksOzNqtWhWA+gBEN7m3Lhq1n+2id9H8RHmntvpv1RxUMEuUN+7GhsBmo8
	 xXxXaUJub2zgNNB7doBvJ2MhuOIZSfUoFqZ4O/tinBxBojfFDY8/rSTQwe6mrF9r3F
	 R2lwqJ+zughyPoe6+g/8nUuiVQnn9sow8AaQLMjqTa4rK2sXpnW11U73/JRzcN+y/j
	 bZU8tFn8GXEZg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 56/60] kvm: svm: Implement GET_AP_APIC_IDS NAE event
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?SsO2cmcgUsO2ZGVs?= <joro@8bytes.org>
Cc: kvm@vger.kernel.org
In-Reply-To: <20260608144252.351443-57-joro@8bytes.org>
References: <20260608144252.351443-57-joro@8bytes.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 08 Jun 2026 22:57:42 +0000
Message-Id: <20260608225742.6C23B1F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 4 potential issue(=
s) to consider:
- [High] sev_get_apic_ids() returns SUCCESS when the guest provides an insu=
fficiently sized buffer, failing to notify the guest to retry.
- [High] The new GET_APIC_IDS feature is unconditionally enabled and expose=
d to the guest, breaking live migration capability negotiation.
- [Medium] The patch completely omits several core features that the commit=
 message explicitly claims to implement.
- [Low] The `if (!pages) return;` check in `sev_get_apic_ids()` is mathemat=
ically unreachable dead code.
--

commit 63e24b674ae7db27c05f8c784dd84af4c400d3f0
Author: Tom Lendacky <thomas.lendacky@amd.com>

kvm: svm: Implement GET_AP_APIC_IDS NAE event

This commit implements the GET_APIC_IDS NAE event to gather and return the
list of APIC IDs for all vCPUs in the guest.

> Since it is now possible to launch vCPUs without going through the
> LAUNCH_UPDATE process, be sure to mark the guest state protected and to
> enable LBR virtualization.
>
> Since it is now possible to launch vCPUs by APIC ID before the first
> INIT-SIPI request, be sure to check for the AP create event in the
> kvm_arch_vcpu_ioctl_run() loop when the AP is in the uninitialized state.

[Severity: Medium]
Are these changes missing from the patch? The commit message describes
modifications to mark guest state protected, enable LBR virtualization,
and check for the AP create event in the kvm_arch_vcpu_ioctl_run() loop,
but these features do not appear in the code changes below.

> diff --git a/arch/x86/kvm/svm/sev.c b/arch/x86/kvm/svm/sev.c
> --- a/arch/x86/kvm/svm/sev.c
> +++ b/arch/x86/kvm/svm/sev.c
> @@ -40,9 +40,10 @@
>  #define GHCB_VERSION_MAX	2ULL
>  #define GHCB_VERSION_MIN	1ULL
> =20
> -#define GHCB_HV_FT_SUPPORTED	(GHCB_HV_FT_SNP |		\
> -				 GHCB_HV_FT_SNP_AP_CREATION |	\
> -				 GHCB_HV_FT_SNP_RINJ)
> +#define GHCB_HV_FT_SUPPORTED	(GHCB_HV_FT_SNP			| \
> +				 GHCB_HV_FT_SNP_AP_CREATION	| \
> +				 GHCB_HV_FT_SNP_RINJ		| \
> +				 GHCB_HV_FT_APIC_ID_LIST)

[Severity: High]
Is it safe to expose this new feature to the guest unconditionally?

If a VM discovers the GET_APIC_IDS capability and is later live-migrated
to an older kernel that does not support it, will the VM crash upon
attempting to use the hypercall? Could this feature be left disabled by
default and explicitly gated on host userspace enablement?

[ ... ]

> @@ -4419,6 +4424,78 @@ static int sev_snp_hv_ipi(struct vcpu_svm *svm)
>  	return 0;
>  }
> =20
> +struct sev_apic_id_desc {
> +	u32	num_entries;
> +	u32	apic_ids[];
> +};
> +
> +static void sev_get_apic_ids(struct vcpu_svm *svm)
> +{
> +	struct ghcb *ghcb =3D svm->sev_es.ghcb;
> +	struct kvm_vcpu *vcpu =3D &svm->vcpu, *loop_vcpu;
> +	struct kvm *kvm =3D vcpu->kvm;
> +	unsigned int id_desc_size;
> +	struct sev_apic_id_desc *desc;
> +	struct page *page;
> +	gpa_t gpa;
> +	u64 pages;
> +	unsigned long i;
> +	int n;
> +
> +	pages =3D vcpu->arch.regs[VCPU_REGS_RAX];
> +
> +	/* Each APIC ID is 32-bits in size, so make sure there is room */
> +	n =3D atomic_read(&kvm->online_vcpus);
> +	/*TODO: is this possible? */
> +	if (n < 0)
> +		return;
> +
> +	id_desc_size =3D sizeof(*desc);
> +	id_desc_size +=3D n * sizeof(desc->apic_ids[0]);
> +	if (id_desc_size > (pages * PAGE_SIZE)) {
> +		vcpu->arch.regs[VCPU_REGS_RAX] =3D PFN_UP(id_desc_size);
> +		return;
> +	}

[Severity: High]
Does this early return successfully notify the guest of the failure?

Since svm_vmgexit_success() initializes sw_exit_info_1 and sw_exit_info_2
to 0 (SUCCESS) before sev_get_apic_ids() executes, returning here without
updating the error code leaves it as SUCCESS. Will the guest incorrectly
assume the APIC IDs buffer is successfully populated instead of allocating
a larger buffer to retry?

> +
> +	gpa =3D svm->vmcb->control.exit_info_1;
> +
> +	ghcb_set_sw_exit_info_1(ghcb, 2);
> +	ghcb_set_sw_exit_info_2(ghcb, 5);
> +
> +	if (!page_address_valid(vcpu, gpa))
> +		return;
> +
> +	page =3D gfn_to_page(kvm, gpa_to_gfn(gpa));
> +	kvm_release_page_unused(page);
> +	if (!page)
> +		return;
> +
> +	if (!pages)
> +		return;

[Severity: Low]
Is this check reachable? Since id_desc_size is strictly greater than 0,
if pages is 0, the earlier check for id_desc_size > (pages * PAGE_SIZE)
will evaluate to true and return early.

> +
> +	/* Allocate a buffer to hold the APIC IDs */
> +	desc =3D kvzalloc(id_desc_size, GFP_KERNEL_ACCOUNT);

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260608144252.3514=
43-1-joro@8bytes.org?part=3D56
