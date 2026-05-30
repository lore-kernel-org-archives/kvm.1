Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5EC72E7379
	for <kvm@vger.kernel.org>; Sat, 30 May 2026 17:32:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780162340; cv=none; b=aJwAlVuwnrOkrYDlnls9KPhr7MokoUi3uvfnPl6DQblY98wj6ahx86jye3BJb+hDXP9Aj/xFUHbpikmNTNtUm4BfIXqR/RtFjWndbiV9icj3Lh2DrntXlYOzC8Ho5THXjA4E2bhIb7JfbyOHC5epnvXD1AI4xJXfzmWbN2BOOGY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780162340; c=relaxed/simple;
	bh=c91snvzIveT00Osc13oGeL8QOzLtY8axoWwSY1M/OJI=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=rdiYrzt7aZkEAtChKTWHawMixJxBKKE9U4CU0zHPDweKfkN+y/kZL/uQ9ZC4Otq2AnKlForKEiqYPFEvBgNR63q7R6kltJQZf/omXbFuXFDhaBJt+iJ2NhPVV7Ouq66bFPLn6cX/rG3Lql4u9qm7u5t7K0DOjNby+CN66NX1YCU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CiUuKqXK; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CiUuKqXK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 805841F00893;
	Sat, 30 May 2026 17:32:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780162339;
	bh=Wd1czGelwI752X/TxUm9qQJq3okdOtCX+ldrerIWagg=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=CiUuKqXKKQBQqXCqlk78OvkxUIq331qO6EPTOGl14yXg47v3pCyZUNHoQFqLPnkso
	 owajWwDbJZcighyzwHUAuGMQlj5Wvc3I0pYxG1HbJETRSWQlW3wNs8aCiO4jcCmUP4
	 hDPU713gFFx0YBoJdvCRAyZI9qj9ApCaQOcVHj8PeFhJddj5xfFcOKmIvVZDMMw94U
	 Fxoi/aaYUDnUJ8wxnGOTFvbBAULHolJkvDmdVD5aW4wO+FLRg8VSEBcNyTMH3XaaTL
	 HvilhsBwCkd9vhJtfbW4XkJJU0lkgUrRNE6XNIWRlWaN6fVzdrYjXYrIE/NUDmIzXW
	 e4ST82kQqIp+Q==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 3/5] KVM: nSVM: invalidate cached PDPTRs across
 nested NPT transitions
Reply-To: sashiko-reviews@lists.linux.dev
To: "Paolo Bonzini" <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org
In-Reply-To: <20260530165545.25599-4-pbonzini@redhat.com>
References: <20260530165545.25599-4-pbonzini@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 30 May 2026 17:32:19 +0000
Message-Id: <20260530173219.805841F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Uninitialized exit_reason when load_pdptrs() fails causes userspac=
e abort.
- [High] svm_cache_reg() leaves stale PDPTRs marked as available upon load =
failure.
--

commit b0f19570b3cb20ce2cbd28a0c0be3e7262edeceb
Author: Paolo Bonzini <pbonzini@redhat.com>

KVM: nSVM: invalidate cached PDPTRs across nested NPT transitions

This commit addresses an issue where KVM's cached PDPTRs hold stale values
after nested transitions under nested NPT and PAE paging. It clears the
available and dirty bits to force a reload when PDPTRs are needed.

> diff --git a/arch/x86/kvm/svm/nested.c b/arch/x86/kvm/svm/nested.c
> index 7ad4b4fb7a1c0..7d6f77c2e253f 100644
> --- a/arch/x86/kvm/svm/nested.c
> +++ b/arch/x86/kvm/svm/nested.c

[ ... ]

> @@ -2111,15 +2114,21 @@ static bool svm_get_nested_state_pages(struct kvm=
_vcpu *vcpu)
>  	if (WARN_ON(!is_guest_mode(vcpu)))
>  		return true;
> =20
> -	if (!vcpu->arch.pdptrs_from_userspace &&
> -	    !nested_npt_enabled(to_svm(vcpu)) && is_pae_paging(vcpu))
> +	if (is_pae_paging(vcpu)) {
>  		/*
> -		 * Reload the guest's PDPTRs since after a migration
> -		 * the guest CR3 might be restored prior to setting the nested
> -		 * state which can lead to a load of wrong PDPTRs.
> +		 * After migration, CR3 may have been restored before
> +		 * KVM_SET_NESTED_STATE, so the PDPTR load into mmu->pdptrs[]
> +		 * may have treated CR3 as an L1 GPA. For nNPT, drop the
> +		 * cache so the next access reloads them with the proper
> +		 * nGPA translation. For !nNPT, reload eagerly unless userspace
> +		 * already supplied authoritative PDPTRs via KVM_SET_SREGS2.
>  		 */
> -		if (CC(!load_pdptrs(vcpu, vcpu->arch.cr3)))
> +		if (nested_npt_enabled(to_svm(vcpu)))
> +			kvm_register_mark_for_reload(vcpu, VCPU_REG_PDPTR);
> +		else if (!vcpu->arch.pdptrs_from_userspace &&
> +			 CC(!load_pdptrs(vcpu, vcpu->arch.cr3)))
>  			return false;

[Severity: High]
This isn't a bug introduced by this patch, but if load_pdptrs() fails here
and we return false, is exit_reason left uninitialized?

If svm_get_nested_state_pages() returns false without setting exit_reason,
vcpu_enter_guest() will return 0 and break the vcpu_run() loop. This returns
to userspace with an unmodified exit_reason (often KVM_EXIT_UNKNOWN).
Userspace like QEMU typically aborts the VM on KVM_EXIT_UNKNOWN.

Should we populate vcpu->run->exit_reason with KVM_EXIT_INTERNAL_ERROR befo=
re
returning false?

> +	}
> =20
>  	if (!nested_svm_merge_msrpm(vcpu)) {

[ ... ]

[Severity: High]
This is a pre-existing issue, but since we are discussing PDPTR loads, does
svm_cache_reg() leave stale PDPTRs marked as available upon load failure?

Looking at svm_cache_reg() in arch/x86/kvm/svm/svm.c:

	kvm_register_mark_available(vcpu, reg);

	switch (reg) {
	case VCPU_REG_PDPTR:
		...
		if (npt_enabled)
			load_pdptrs(vcpu, kvm_read_cr3(vcpu));
		break;

If load_pdptrs() fails here (e.g., due to an invalid CR3 or unmapped guest
memory), it returns 0 without updating mmu->pdptrs. Because the register is
unconditionally marked as available before the load attempt, will subsequent
calls to kvm_pdptr_read() during instruction emulation return the stale
translations instead of failing?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260530165545.2559=
9-1-pbonzini@redhat.com?part=3D3
