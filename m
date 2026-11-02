Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793643987;
	b=NJf8PGqggwEWraXNol8KsVHjX3LtB4lcqVB1eYK33OqwZBb/x88Dl/pKqs2yjxjNxXFQ
	 VQQQ1xqffqcA3imIKMxgFhDH/ZeKbIsP5+D3baX74PibytQpFCqPqU+dxidxGhJAH7yXK
	 +J3RbtItgIH/mIF8i9YBnIL1xwi5hMsM/l7j3JhaMz+MzVeiloCOCdqPYVlZQEtR2kHCN
	 6h1uGByvzqonXO+yrSEs/bnL1RiI6At4heMCY8cgLgUcUB9wEYmNWNrDw6m/3N4IFBVpb
	 TGfiRPGG7H7g0J3b9CCeqqyw5DlKVMDjpYzvIS/CEqpzoZkL3SEruhEmHcsxtnO4k/Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793643987;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=YbX4ld89BVi2NOpqITMYcv8Zu4oGPK1jjfzRXI2xG7w=;
	b=PNFOGEELkNR9t5pgWFDjeONMnT0WkC+NF7o2pqgZmSCBwIG792pgd70SJHH+MeEDMXmx
	 xGuXviNC9pfX4nhPHRl3rlqYVmgnPK/w593shbeSfkt0ITBUg9amqoflk9MolraAPWyg2
	 1ODyW1+MgMe0I3IwdnPkl2QOIxR7cmVmRet48sdVjdD5YKQFsHj5/mNEdqbrY/anOpFkH
	 +iSjL8FOQH2iUqIdFtkyYXLquyYH5eK/aovpUPaxWFIjX89VRQ1KEsMaV5A2Q1gMo5VV+
	 V3T3xR5Q36Bz5swV9Y3HB9ot68oO34KXYlv0WaXXggR/joQaccORCGjAi95RpbOAxiA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ATx7k7hh;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46764606A326
	for <kvm@vger.kernel.org>; Mon,  2 Nov 2026 18:26:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ATx7k7hh
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BD5F41F00A16;
	Mon,  2 Nov 2026 18:26:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793643986;
	bh=YbX4ld89BVi2NOpqITMYcv8Zu4oGPK1jjfzRXI2xG7w=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=ATx7k7hhav5PCj2v2hbPoGb9xDbrfHDKjuWAjBdFm8PuOWJJEZUC91x4HGcxDeZdN
	 CFaEsOp2mAU2xF30OVgbE87Jdp2cOOln1gBh6mQSLaqO9+XXoJH8l70FzEpPhT7ii0
	 dAvRcwYhc7siAU6cDRQy22LpIkg6bIQhQZ1w90Zauc3rtNi/LYnv5ujlWmPR2Uv2WN
	 h3llYE1SU3r9XaE2KXrrLdqPZQjQQNI69xu/hW88Kc+5x7OQZ4Zbuw8q6IeagmQW5H
	 HNde8UIaR7U5cajD9kfZoVTLl8x43dhXEN0GIhAr04eyK+zfpcqTJaLE8ZQJBYwsPP
	 NYAuI6/+mZEDg==
Message-ID: <sashiko-outbox-193934@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 28/45] KVM: x86/mmu: Take memory protection attributes
 into account during faults
Reply-To: sashiko-reviews@lists.linux.dev
To: "Paolo Bonzini" <pbonzini@redhat.com>, kvm@vger.kernel.org
In-Reply-To: <20261102174512.8903-12-pbonzini@redhat.com>
References: <20261102174130.8779-1-pbonzini@redhat.com>
 <20261102174512.8903-12-pbonzini@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 02 Nov 2026 18:26:26 +0000
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 4 potential issue(=
s) to consider:
- [High] KVM: x86/mmu: make_small_spte() re-enables exec on KVM_MEMORY_ATTR=
IBUTE_NX
- [High] KVM: x86/mmu: spurious -EFAULT in kvm_faultin_memory_protections()=
 with SMEP
- [Medium] KVM: x86/mmu: broken ACC_ALL check in kvm_faultin_memory_protect=
ions()
- [Medium] KVM: x86/mmu: FNAME(sync_spte) installs 0-permission EPT SPTE on=
 NX GFN
--

commit ed18ad0e63078d1672b15a00740ac1eefc27f904
Author: Nicolas Saenz Julienne <nsaenz@amazon.com>

KVM: x86/mmu: Take memory protection attributes into account during faults

This commit checks per-gfn memory protection attributes during guest page
faults and SPTE synchronization, restricting SPTE permissions or exiting to
userspace with -EFAULT when an access is prohibited. It also adds a trace
event when faulting in a gfn with restricted memory protections.

Link: https://patch.msgid.link/20260918135030.171564-26-pbonzini@redhat.com

> diff --git a/arch/x86/kvm/mmu/mmu.c b/arch/x86/kvm/mmu/mmu.c
> index 140a8dd5b3f5b..c4bd37427bb72 100644
> --- a/arch/x86/kvm/mmu/mmu.c
> +++ b/arch/x86/kvm/mmu/mmu.c
> @@ -4705,6 +4705,50 @@ static int kvm_mmu_faultin_pfn_gmem(struct kvm_vcp=
u *vcpu,
>  	return RET_PF_CONTINUE;
>  }
> =20
> +static inline unsigned kvm_get_gfn_protections(struct kvm_vcpu *vcpu, gf=
n_t gfn)
> +{
> +	struct kvm *kvm =3D vcpu->kvm;
> +	unsigned int access =3D vcpu->arch.mmu->root_role.access;
> +	unsigned long attrs =3D kvm_get_vm_memory_attributes(kvm, gfn);
> +	if (!attrs)
> +		return access;
> +
> +	WARN_ON_ONCE(!kvm_vm_mem_attributes_valid(kvm, attrs));
> +
> +	if (!kvm_mem_attributes_may_read(attrs))
> +		access &=3D ~ACC_READ_MASK;
> +	if (!kvm_mem_attributes_may_write(attrs))
> +		access &=3D ~ACC_WRITE_MASK;
> +	if (!kvm_mem_attributes_may_exec(attrs)) {
> +		access &=3D ~ACC_EXEC_MASK;
> +		if (shadow_xu_mask)
> +			access &=3D ~ACC_USER_EXEC_MASK;
> +	}
> +
> +	return access;
> +}
> +
> +static int kvm_faultin_memory_protections(struct kvm_vcpu *vcpu,
> +					  struct kvm_page_fault *fault)
> +{
> +	unsigned access;
> +
> +	/* Memory attributes don't apply to MMIO regions */
> +	if (unlikely(!fault->slot))
> +		return RET_PF_CONTINUE;
> +
> +	access =3D kvm_get_gfn_protections(vcpu, fault->gfn);
> +	if (access =3D=3D ACC_ALL)
> +		return RET_PF_CONTINUE;

[Severity: Medium]
On AMD processors with GMET enabled, does this fast-path check in
arch/x86/kvm/mmu/mmu.c:kvm_faultin_memory_protections() ever succeed when
no memory protection attributes are present?

In arch/x86/kvm/mmu/mmu.c:kvm_calc_tdp_mmu_root_page_role(), root_role.acce=
ss
has ACC_USER_MASK cleared when GMET is active:

	/* All TDP pages are supervisor-executable */
	role.access =3D ACC_ALL;
	if (role.cr4_smep && shadow_user_mask)
		role.access &=3D ~ACC_USER_MASK;

When attrs is 0, kvm_get_gfn_protections() returns root_role.access
(ACC_ALL & ~ACC_USER_MASK), so comparing access against ACC_ALL in
kvm_faultin_memory_protections() evaluates to false on every TDP page fault
and unconditionally triggers trace_kvm_faultin_memory_protections() and
__permission_fault(). Should this compare access against
vcpu->arch.mmu->root_role.access instead?

> +
> +	trace_kvm_faultin_memory_protections(vcpu, fault, access);
> +	if (__permission_fault(vcpu->arch.mmu, access, fault))
> +		return -EFAULT;

[Severity: High]
As reported by Sashiko on v2 [1], in
arch/x86/kvm/mmu/mmu.c:kvm_faultin_memory_protections(), can passing access
derived from vcpu->arch.mmu->root_role.access into __permission_fault() cau=
se
spurious -EFAULT exits on valid supervisor instruction fetches when SMEP or
nested GMET is enabled?

In arch/x86/kvm/mmu/mmu.c:init_kvm_shadow_mmu() (when the guest enables
cr4.smep) and arch/x86/kvm/mmu/mmu.c:kvm_init_shadow_npt_mmu() (when L1
enables GMET), root_role.cr4_smep is set to 1 while root_role.access remains
ACC_ALL (which includes ACC_USER_MASK):

	cpu_role.base.cr4_smep =3D (misc_ctl & SVM_MISC_ENABLE_GMET) !=3D 0;
	init_kvm_page_walk(vcpu, &vcpu->arch.ngpa_walk, cpu_role);
	root_role =3D cpu_role.base;

When arch/x86/kvm/mmu/mmu.c:__update_permission_bitmask() builds
mmu->fmt.permissions for non-EPT MMUs with cr4_smep enabled, any access mask
with ACC_USER_MASK set is marked as faulting on supervisor instruction
fetches:

	/* Disallow supervisor fetches of user code if cr4.smep */
	if (cr4_smep)
		ff |=3D (pfec & PFERR_FETCH_MASK) ? kf : 0;

If a guest under shadow paging or nested shadow NPT performs a supervisor
instruction fetch from a supervisor page (guest PTE U=3D0) whose GFN has
KVM_MEMORY_ATTRIBUTE_NW set, kvm_get_gfn_protections() returns
ACC_READ_MASK | ACC_EXEC_MASK | ACC_USER_MASK. Doesn't __permission_fault()
then treat the access as a SMEP violation because ACC_USER_MASK is still set
in access, returning a spurious -EFAULT to userspace?

> +
> +	fault->host_access &=3D access;
> +	return RET_PF_CONTINUE;
> +}

[Severity: High]
When a huge page is mapped on a GFN range with uniform
KVM_MEMORY_ATTRIBUTE_NX and later split into 4K pages, will
arch/x86/kvm/mmu/spte.c:make_small_spte() re-enable execute permissions on
the resulting child SPTEs?

During a read or write fault, kvm_faultin_memory_protections() clears
ACC_EXEC_MASK in fault->host_access, and make_spte() installs a
non-executable huge SPTE. However, sp->role.access retains ACC_EXEC_MASK.

When the huge page is later split via
arch/x86/kvm/mmu/tdp_mmu.c:tdp_mmu_split_huge_page() or
arch/x86/kvm/mmu/mmu.c:shadow_mmu_split_huge_page(), make_small_spte()
restores execute permissions from role.access whenever the NX huge page
mitigation is enabled:

	if (is_nx_huge_page_enabled(kvm))
		child_spte =3D change_spte_executable(child_spte, role.access);

Doesn't this make the split 4K SPTEs executable in hardware despite
KVM_MEMORY_ATTRIBUTE_NX being set on the underlying GFNs?

[ ... ]

> diff --git a/arch/x86/kvm/mmu/paging_tmpl.h b/arch/x86/kvm/mmu/paging_tmp=
l.h
> index 860dae872d044..e46182750567b 100644
> --- a/arch/x86/kvm/mmu/paging_tmpl.h
> +++ b/arch/x86/kvm/mmu/paging_tmpl.h
> @@ -994,7 +994,7 @@ static int FNAME(sync_spte)(struct kvm_vcpu *vcpu, st=
ruct kvm_mmu_page *sp, int
> =20
>  	sptep =3D &sp->spt[i];
>  	spte =3D *sptep;
> -	host_access =3D ACC_ALL;
> +	host_access =3D kvm_get_gfn_protections(vcpu, gfn);
>  	if (!(spte & shadow_host_writable_mask))
>  		host_access &=3D ~ACC_WRITE_MASK;
>  	slot =3D kvm_vcpu_gfn_to_memslot(vcpu, gfn);

[Severity: Medium]
In arch/x86/kvm/mmu/paging_tmpl.h:FNAME(sync_spte), what happens on nested
EPT with execute-only support when L1 updates an unsync EPT12 entry to be
execute-only (pte_access =3D ACC_EXEC_MASK | ACC_USER_EXEC_MASK) on a GFN t=
hat
has KVM_MEMORY_ATTRIBUTE_NX set?

Earlier in FNAME(sync_spte), the check for an effective non-present SPTE ru=
ns
before host_access is applied:

	if ((pte_access | shadow_present_mask) =3D=3D SHADOW_NONPRESENT_VALUE ||
	    gfn !=3D kvm_mmu_page_get_gfn(sp, i)) {
		drop_spte(vcpu->kvm, &sp->spt[i]);
		return 1;
	}

Because pte_access still has execute bits set at that point, the SPTE is not
dropped. When make_spte() then masks pte_access with host_access:

	WARN_ON_ONCE((pte_access | shadow_present_mask) =3D=3D SHADOW_NONPRESENT_V=
ALUE);
	...
	pte_access &=3D host_access;

all remaining permission bits in pte_access are cleared, leaving an EPT SPTE
with SPTE_MMU_PRESENT_MASK set but hardware bits 2:0 and 10 all zero. Should
the SHADOW_NONPRESENT_VALUE check in FNAME(sync_spte) account for the
protections from kvm_get_gfn_protections() so the SPTE is dropped instead?

[1] https://lore.kernel.org/r/20260918081543.139871-22-pbonzini@redhat.com

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261102174130.8779=
-1-pbonzini@redhat.com?part=3D28
