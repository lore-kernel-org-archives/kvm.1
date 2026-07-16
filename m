Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 020BB326924
	for <kvm@vger.kernel.org>; Thu, 16 Jul 2026 18:47:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784227672; cv=none; b=ZZ737XZyxUCZ0USqBq6OB1lu+jAm4nO9mNoWdvQ/cziz1LWZOD2CTys5yZ4H9IFx3FHgwXgmmmzmmFk/Qpw14YhL5qcw+JxFWo1lB0l8zH3XhuBPJI1lU0a3bh1KTN/UxvXqUu7C1KtgazgisxGfuYcJ+sfDqmf0NP0AsU1VdVA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784227672; c=relaxed/simple;
	bh=WYe/WaSwpFYKIEI6Kba2XNMbaELVNijphuRI50Kmgl0=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=t8fOsBFRgYDCZGsRKnrcxn+uRpdW/AC07joISqsJDzjo8hXpNisQpkzH2rdhUBGJ8sCZ9IMioFNP6sJyeDZ7woQHzR+Ij0OUc/eq/cZ8Q5t6AnRvm89Y/9II6uqVccc4ZGpRuWBBXt3/8Ro6SSXztuW1YV6Ohv+Jgun6UorWKyQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=I9iWFeJg; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="I9iWFeJg"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 78A5D1F000E9;
	Thu, 16 Jul 2026 18:47:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784227670;
	bh=HbehT+isLnbhA2Jm4/lAiZzYWwoKwmCnlt5HTsf4e1E=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=I9iWFeJg1FklrgYpS0CaYXGORmV8kLkWMhQxDYy/2UxOFMCz1gQqgW6h9QmHzjGBA
	 AVFchnRuQBUEZgVIrdhNM1gjCo61iFBLSxdtgFJ1cGnjj0P8iM2Q7FLo820z5RJ0sP
	 u3+PFD50jh2ZIi3GBXvb6hqmT9LpeYwnT7izm418WPMVTnziDWnI2xzKs4oPzMKHeg
	 RmPCL2dq3Nll0I99bpeTeC7VtRd3+WMtz5EAwIObozF/Ww2l/1l5dAw5CQTPGx28eD
	 TfbPXyHfuXYflYhC144c9c2MzDHa+SM9wS4/NZwqCFOrdu9MFJ20olSdZ+sSV0wf8H
	 JYtxbgNiNsegA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 18/24] KVM: x86/mmu: Issue memory fault exit if walk
 failed due to memory attribute
Reply-To: sashiko-reviews@lists.linux.dev
To: "Paolo Bonzini" <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org
In-Reply-To: <20260716181456.402786-19-pbonzini@redhat.com>
References: <20260716181456.402786-1-pbonzini@redhat.com>
 <20260716181456.402786-19-pbonzini@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 16 Jul 2026 18:47:50 +0000
Message-Id: <20260716184750.78A5D1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] KVM reports misleading access flags (read/write/exec) to userspace=
 in KVM_EXIT_MEMORY_FAULT when a software page table walk fails due to a me=
mory attribute violation.
- [High] During instruction emulation, memory attribute faults on guest pag=
e table walks are ignored by FNAME(gva_to_gpa), causing KVM to incorrectly =
inject a spurious #PF into the guest instead of exiting to userspace.
--

--- Patch [18]: [PATCH 18/24] KVM: x86/mmu: Issue memory fault exit if walk=
 failed due to memory attribute ---
commit 724220bf46ef5e18dcf744c814e78fa2b6296962
Author: Nicolas Saenz Julienne <nsaenz@amazon.com>

KVM: x86/mmu: Issue memory fault exit if walk failed due to memory attribute

This commit adds memory attribute checks to the guest page table walker. If
the walker encounters a page table entry residing in a memory region with
restricted attributes, it exits to userspace with a memory fault rather than
injecting a spurious page fault into the guest.

> diff --git a/arch/x86/kvm/mmu/paging_tmpl.h b/arch/x86/kvm/mmu/paging_tmp=
l.h
> index cdf05cd76d63d..23d7a7d9769fe 100644
> --- a/arch/x86/kvm/mmu/paging_tmpl.h
> +++ b/arch/x86/kvm/mmu/paging_tmpl.h

[ ... ]

> @@ -820,6 +828,12 @@ static int FNAME(page_fault)(struct kvm_vcpu *vcpu, =
struct kvm_page_fault *fault
>  	 * The page is not mapped by the guest.  Let the guest handle it.
>  	 */
>  	if (!r) {
> +		if (walker.memory_attributes_fault) {
> +			fault->gfn =3D walker.gfn;
> +			kvm_mmu_prepare_memory_fault_exit(vcpu, fault);

[Severity: High]
When setting up the memory fault exit here, do we end up reporting the
original instruction's access flags instead of the walker's?

The kvm_mmu_prepare_memory_fault_exit() function uses fault->write and
fault->exec. If an instruction fetch triggers the page fault, and KVM's
subsequent read of the guest page table fails the attribute check, userspace
might incorrectly be told the guest attempted to execute the page table
itself rather than just read it.

Could this cause the VMM to mismanage memory protections or spuriously
terminate the VM?

[Severity: High]
Does FNAME(gva_to_gpa) also need to check walker.memory_attributes_fault?

When FNAME(gva_to_gpa) translates guest virtual addresses during instruction
emulation, it calls into the walk functions but doesn't check the new
walker.memory_attributes_fault flag:

FNAME(gva_to_gpa)() {
        ...
        if (ndata) {
                ...
        } else if (exception)
                *exception =3D walker.fault;

        return gpa;
}

Will this cause KVM to incorrectly inject a spurious page fault into the gu=
est
instead of exiting to userspace if an attribute violation occurs during
emulation?

> +			return -EFAULT;
> +		}
> +
>  		if (!fault->prefetch)
>  			__kvm_inject_emulated_page_fault(vcpu, &walker.fault, true);
>

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260716181456.4027=
86-1-pbonzini@redhat.com?part=3D18
