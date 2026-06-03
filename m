Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CACC73002DD
	for <kvm@vger.kernel.org>; Wed,  3 Jun 2026 11:27:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780486053; cv=none; b=QWdphW7E6u+9WxZ1gGD0fI/t+2E8txY8BzZ8oXWczITQOfefNCo11LUYg2L2nUiRpZwN5jb78Bb0udSOyOqxWiu6iQJhpwBr+Iq8iUKtYMxYKZaqZVt9jsjS8nkGzAyGZMkAAR8SObUoaaroxLQtdKR47krgYWaLLbNQ+JOUuyQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780486053; c=relaxed/simple;
	bh=IK5HluziswfkVFnx+wFGzWYdQKNEg1lIsNBfp0MFtw4=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=d7rPIyYjH66W36nnzazVf0s2pQZmPfdYOjYDosxqtm4giqdQux/Q+Z5w5aX6nB53Ns/VcBgZDX5giZuJiNwG3N7G+7wOgl49/LSkQis37v/Q6BH4tc91sHazZwumFXBoXUql+RKz9sa3bFyPLzqO/L7fQP8Uxnaad1km7Y00Vww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=anriq5WU; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="anriq5WU"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 89DF71F00898;
	Wed,  3 Jun 2026 11:27:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780486052;
	bh=KQMKsUIro2PcMaMjiG6TR4483qUHpDl76DEZME5YIRE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=anriq5WUZbgLDnXZgK7Ob2YsXXKHjpYZDE/bYWcUmC8jbwi09QJMwbbD5fN1qTzOw
	 hVVfEfZzBIXmdQJL5pszODGWp6E3Xu2OshJ7zXMvvvA2INwuyua7jnvmyJu01ob68v
	 gGbHRr2L5OKw5Ir99i2BuxpnDpMqxR1kA/R8/I13R5j6Wekv5gKbFnJSm+T9qOWvoA
	 PLgBAjGUlzWLHubRRy5DkLf6ebe8eRY5Z1s8SJAgXjMRgM/kb9L1+0I0ic3DiTCGQW
	 ucA8ce66aP1w/IwxeTMK9XUIPfq171pnlEzfocnqnHCsOp4NU8DbDKBSL/6VwMIi4M
	 oNgmPd47PRwww==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 12/24] KVM: x86/mmu: move CPU-related fields to struct
 kvm_pagewalk
Reply-To: sashiko-reviews@lists.linux.dev
To: "Paolo Bonzini" <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org
In-Reply-To: <20260603105814.10236-13-pbonzini@redhat.com>
References: <20260603105814.10236-13-pbonzini@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 03 Jun 2026 11:27:32 +0000
Message-Id: <20260603112732.89DF71F00898@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [Critical] When using nested virtualization with shadow paging (EPT disab=
led), L1's PDPTRs are overwritten by L2's PDPTRs during a nested VM-Entry b=
ut are never restored on a failed VM-Entry. This allows L2 to control L1's =
shadow page tables.
--

commit a87d952b84013700c29cd0401e35d07fb7710cf4
Author: Paolo Bonzini <pbonzini@redhat.com>

    KVM: x86/mmu: move CPU-related fields to struct kvm_pagewalk

This commit moves CPU-related fields and their page format dependencies
into struct kvm_pagewalk. This allows the walk_mmu function to remain
self-contained while cleaning up the accessor functions.

> diff --git a/arch/x86/kvm/mmu/mmu.c b/arch/x86/kvm/mmu/mmu.c
> index 4fbb7508e2413..e2bfecf655d9a 100644
> --- a/arch/x86/kvm/mmu/mmu.c
> +++ b/arch/x86/kvm/mmu/mmu.c

[ ... ]

> @@ -4083,7 +4083,7 @@ static int mmu_alloc_shadow_roots(struct kvm_vcpu *=
vcpu)
>  	 * On SVM, reading PDPTRs might access guest memory, which might fault
>  	 * and thus might sleep.  Grab the PDPTRs before acquiring mmu_lock.
>  	 */
> -	if (mmu->cpu_role.base.level =3D=3D PT32E_ROOT_LEVEL) {
> +	if (mmu->w.cpu_role.base.level =3D=3D PT32E_ROOT_LEVEL) {
>  		for (i =3D 0; i < 4; ++i) {
>  			pdptrs[i] =3D mmu->w.get_pdptr(vcpu, i);

[Severity: Critical]
This is a pre-existing issue, but while reviewing the PDPTR accesses here,
I noticed a problem with how PDPTRs are handled on nested VM-Entry failures.

When using nested virtualization with shadow paging (EPT disabled), L1's
PDPTRs are overwritten by L2's PDPTRs during a nested VM-Entry but are never
restored on a failed VM-Entry.

Looking at nested_vmx_restore_host_state() in arch/x86/kvm/vmx/nested.c:

	vcpu->arch.cr3 =3D vmcs_readl(GUEST_CR3);
	kvm_register_mark_available(vcpu, VCPU_REG_CR3);

	/*
	 * Use ept_save_pdptrs(vcpu) to load the MMU's cached PDPTRs
	 * from vmcs01 (if necessary).  The PDPTRs are not loaded on
	 * VMFail, like everything else we just need to ensure our
	 * software model is up-to-date.
	 */
	if (enable_ept && is_pae_paging(vcpu))
		ept_save_pdptrs(vcpu);

L1's CR3 is restored here upon a VM-Entry failure, but the PDPTRs are only
restored if EPT is enabled. If shadow paging is used (enable_ept is false),
the L2 PDPTRs loaded during the aborted entry attempt remain in KVM's softw=
are
model (vcpu->arch.pdptrs).

Furthermore, in vmx_cache_reg() in arch/x86/kvm/vmx/vmx.c:

	case VCPU_REG_PDPTR:
		if (enable_ept)
			ept_save_pdptrs(vcpu);
		break;

After the failed VM-Entry, VCPU_REG_PDPTR is marked as unavailable. When KV=
M's
shadow MMU reads the PDPTRs via get_pdptr(), it calls vmx_cache_reg(). For
shadow paging, this does nothing and simply marks the register as available,
causing the MMU to use the stale L2 PDPTRs.

Since L2 can provide arbitrary addresses for its PDPTRs, does this enable L2
to hijack L1's memory mappings and escalate privileges from the nested guest
to the L1 hypervisor?

>  			if (!(pdptrs[i] & PT_PRESENT_MASK))
>  				continue;

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260603105814.1023=
6-1-pbonzini@redhat.com?part=3D12
