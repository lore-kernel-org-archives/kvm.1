Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57AF523E334
	for <kvm@vger.kernel.org>; Fri, 18 Sep 2026 08:46:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789721172; cv=none; b=ixDWVepjQnDviue3C0tOEMKWszEcavCGHoTLcxtGQ5iHZyOda7W+SKmxWCqfU4CVFCLn9nGgfya0azdrY5VznYxhGlJKV5D2TJTZzioerLccH7ZMhbNBlE02QqAsxlcjxTvbsN5QAfgRlnxXWVNXVGvkAejVMQje5NmlUNPg+zY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789721172; c=relaxed/simple;
	bh=ydODeynV8LR3a1WkHsm5qlhqiVO+nGaInkry7o/xXp8=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=PTYzo/OLuFPIKkLDuM8sLnOE9areU6VkqHRdBVxJrqHnyAxKthMLiGdQMewx1fLhyV4jdZQWxQwkU7vVllchKzlarfb2eoOVjzCQFCMYh0msfR7Lf18TZ3wVifxD1FIQkgjcSvA61iviiNwphq107RwgpTZgORo2YcXjr80sKlk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=APO6G3uo; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="APO6G3uo"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 95BB61F0089F;
	Fri, 18 Sep 2026 08:46:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789721169;
	bh=MhRu0YxMj9zw8j/PsUAbiWbIq4kL3YlHmmDBGkhrXxM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=APO6G3uofBFfT81+0XaJC6r5cV1AaQ7ipgVZWUOrmp++xsXXGXjquhNdWqRB4OZIa
	 C/v+wq5kivXUAlicZWjYZF+kD29F1IexyY1PkL8MJ5HN8iP8N2lB+GXaOkneyqAnR9
	 /SFPGbO+PV2p9z6I5zpXzd7LejO0vybVOYJQMajk3XWfDz0Yan89fxlh8LeSdKB90M
	 U/R309r0d/HTfDb5XICeVl3ysGTjQvjmlG+TTq+JpH6TVrcIlJj7DUDTl23U+kwSHh
	 pogQ11dqoGZyEiJLzXmxIQkuiod/VCh7yFmKTN6PDn9w0YysANlJqCgWKEG+Fp1lAE
	 rTNO2bi4KyJ4Q==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 21/28] KVM: x86/mmu: Take memory protection
 attributes into account during faults
Reply-To: sashiko-reviews@lists.linux.dev
To: "Paolo Bonzini" <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org
In-Reply-To: <20260918081543.139871-22-pbonzini@redhat.com>
References: <20260918081543.139871-1-pbonzini@redhat.com>
 <20260918081543.139871-22-pbonzini@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 18 Sep 2026 08:46:09 +0000
Message-Id: <20260918084609.95BB61F0089F@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:
- [Critical] kvm: mmu: prefetching completely bypasses memory protections
- [Critical] kvm: mmu: missing SPTE invalidation allows bypass of shared me=
mory protections
- [High] kvm: mmu: host access permissions conflated with guest root_role.a=
ccess
--

commit 5aa6405feba846a8b81344070caa806c21c16bfd
Author: Nicolas Saenz Julienne <nsaenz@amazon.com>
Subject: KVM: x86/mmu: Take memory protection attributes into account durin=
g faults

This commit updates KVM x86 MMU to respect memory protection attributes when
faulting guest memory. Prohibited accesses will cause a user-space -EFAULT
exit. The access type is checked using the existing kvm_page_format
permissions table.

> diff --git a/arch/x86/kvm/mmu/mmu.c b/arch/x86/kvm/mmu/mmu.c
> index 797b18201d982..3fd4cc3c57a53 100644
> --- a/arch/x86/kvm/mmu/mmu.c
> +++ b/arch/x86/kvm/mmu/mmu.c
> @@ -4642,6 +4642,50 @@ static int kvm_mmu_faultin_pfn_gmem(struct kvm_vcp=
u *vcpu,
>  	return RET_PF_CONTINUE;
>  }
> =20
> +static inline unsigned kvm_get_gfn_protections(struct kvm_vcpu *vcpu, gf=
n_t gfn)
> +{
> +	struct kvm *kvm =3D vcpu->kvm;
> +	unsigned int access =3D vcpu->arch.mmu->root_role.access;
> +	unsigned long attrs =3D kvm_get_memory_attributes(kvm, gfn);
> +	if (!attrs)
> +		return access;

[Severity: High]
Does initializing host access rules with the guest's root_role.access confl=
ate
host and guest permissions, potentially causing spurious -EFAULT exits?

If attrs is 0, this returns the guest mask. Then in
kvm_faultin_memory_protections(), this access mask is evaluated against the
hardware fault code using __permission_fault().

If the guest's root page table is restricted (e.g., lacks write access), any
guest write fault could return -EFAULT, causing a KVM_EXIT_MEMORY_FAULT to
userspace instead of injecting a normal guest #PF. A guest could trigger th=
is
by executing code with restricted root page table permissions.

> +
> +	WARN_ON_ONCE(!kvm_mem_attributes_valid(kvm, attrs));
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
> +
> +	trace_kvm_faultin_memory_protections(vcpu, fault, access);
> +	if (__permission_fault(vcpu->arch.mmu, access, fault))
> +		return -EFAULT;
> +
> +	fault->host_access &=3D access;
> +	return RET_PF_CONTINUE;
> +}

[Severity: Critical]
When memory protections are applied to shared memory, do we properly invali=
date
existing writable SPTEs so that guests cannot bypass the protections?

Looking at kvm_arch_pre_set_memory_attributes() in arch/x86/kvm/mmu/mmu.c:

    /* Unmap the old attribute page. */
    if (range->arg.attributes & KVM_MEMORY_ATTRIBUTE_PRIVATE)
        range->attr_filter =3D KVM_FILTER_SHARED;
    else
        range->attr_filter =3D KVM_FILTER_PRIVATE;

    return kvm_unmap_gfn_range(kvm, range);

If userspace sets memory protections (like KVM_MEMORY_ATTRIBUTE_NW) without
setting PRIVATE, the filter falls back to KVM_FILTER_PRIVATE. The subsequent
call to kvm_unmap_gfn_range() only zaps private KVM_MIRROR_ROOTS and comple=
tely
skips shared KVM_DIRECT_ROOTS.

This could allow a guest to retain full read/write/execute access via exist=
ing
shared SPTEs to memory that was explicitly restricted by userspace.

[ ... ]

> diff --git a/arch/x86/kvm/mmu/paging_tmpl.h b/arch/x86/kvm/mmu/paging_tmp=
l.h
> index e6ec14165f400..b031123fcb369 100644
> --- a/arch/x86/kvm/mmu/paging_tmpl.h
> +++ b/arch/x86/kvm/mmu/paging_tmpl.h
> @@ -992,7 +992,7 @@ static int FNAME(sync_spte)(struct kvm_vcpu *vcpu, st=
ruct kvm_mmu_page *sp, int
> =20
>  	sptep =3D &sp->spt[i];
>  	spte =3D *sptep;
> -	host_access =3D ACC_ALL;
> +	host_access =3D kvm_get_gfn_protections(vcpu, gfn);

[Severity: Critical]
Since we are replacing ACC_ALL with kvm_get_gfn_protections() here, does
mmu_set_spte() also need to be updated to prevent prefetching from bypassing
memory protections?

Looking at mmu_set_spte() in arch/x86/kvm/mmu/mmu.c:

    unsigned host_access =3D fault ? fault->host_access : ACC_ALL;

If a guest touches a page adjacent to a protected page, triggering
kvm_mmu_prefetch_sptes(), mmu_set_spte() is called with a NULL fault pointe=
r.
This causes it to default to ACC_ALL instead of querying the host attribute=
s,
which could allow a malicious guest to bypass NR/NW/NX protections.

(Note: Patch 24 in this series attempts to fix this but introduces an inver=
ted
condition "if (!kvm_get_memory_attributes(kvm, gfn)) continue;", which skips
prefetching only when there are NO attributes, and still grants ACC_ALL to
pages WITH attributes.)

>  	if (!(spte & shadow_host_writable_mask))
>  		host_access &=3D ~ACC_WRITE_MASK;
>  	slot =3D kvm_vcpu_gfn_to_memslot(vcpu, gfn);

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260918081543.1398=
71-1-pbonzini@redhat.com?part=3D21
