Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3DCE3BA236
	for <kvm@vger.kernel.org>; Fri, 18 Sep 2026 14:47:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789742822; cv=none; b=efVLvQGZsLaPO32Nph8fXfk0+7SeixzBGtBGOrF1JJnL2RV1Jhv2R54Xd7IxO57t5H/V8wRWoi2RHHDRzJONZ6Amb67MUGhMobah/UHbmBGYzKC/avXFCynxNfHJkjOz8IcgMhJhenu/GYHBxQEVEfry/F74nuH1uyhQw2a9g2A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789742822; c=relaxed/simple;
	bh=XJZ7MGu4V6ibdWweU8z8NpG+iZ3K4qZJy9/Y1XCnZFQ=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=kxtJgNqn3jpYoGCczBeVzgr9iz+zM1l4RUw+tpyL2fG5geXbNO1HU4A3Sb+8fqQEpqySo7pn+0tq4vt2ihrH51dyeqsZVEKGXCmB5u7VaTskuiTUdWaQMulb6Nxlr2SYRvk7fhpSH8gHpJuhK79okDEo0UiG3q8IxxZaHCY8rUY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=F+Tjag6G; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="F+Tjag6G"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4ADE51F00898;
	Fri, 18 Sep 2026 14:47:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789742820;
	bh=VxD6d3ATHbIsMKIEqmP9GDnjU0lXkkRVGgRWZHSOnjI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=F+Tjag6GddGlgKsm6nzEsM37MZzptyP1rSOoJMFvCtlofFfYiiwQcMVcj3UCUDM9M
	 fGfRLdPyvXg9p63Az4oUptoAprsO2gfMlHWPLhpvrbyh5Rf4KWwEwM1Idrwdhs5qnS
	 SURzaezFF8aTCmPYgu3vnK7gDW4Se2eR/i8wawj5zvhVP753LxE16gbI6R96jfauAR
	 DW74gy+7NkdquyfX7sTKg1tv1ntmQCpnfyrZQP79pbICCByyRCe7gKtn5aaCSLqMTF
	 UzdnlJNKnm5MKxk/14wxIY6to5slXGXNpkRiAXzvqGDyStGm3oZGiPDmGxxuXqi+9B
	 ZQvd9zy2Glxzg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 26/31] KVM: x86/mmu: Issue memory fault exit if walk
 failed due to memory attribute
Reply-To: sashiko-reviews@lists.linux.dev
To: "Paolo Bonzini" <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org
In-Reply-To: <20260918135030.171564-27-pbonzini@redhat.com>
References: <20260918135030.171564-1-pbonzini@redhat.com>
 <20260918135030.171564-27-pbonzini@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 18 Sep 2026 14:46:59 +0000
Message-Id: <20260918144700.4ADE51F00898@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] kvm: x86/mmu: lost memory attribute fault on GVA to GPA translatio=
n during emulation
--

commit a5b7ea3b514c528d86717bda8577133bab95a9d8
Author: Nicolas Saenz Julienne <nsaenz@amazon.com>

    KVM: x86/mmu: Issue memory fault exit if walk failed due to memory attr=
ibute

This commit modifies the guest page table walk to issue a user-space
memory fault exit if it fails due to memory attributes, instead of
injecting a page fault. It introduces the memory_attributes_fault
flag to the guest_walker structure.

> diff --git a/arch/x86/kvm/mmu/paging_tmpl.h b/arch/x86/kvm/mmu/paging_tmp=
l.h
> index b031123fcb369..cd055bfb1eb6b 100644
> --- a/arch/x86/kvm/mmu/paging_tmpl.h
> +++ b/arch/x86/kvm/mmu/paging_tmpl.h
[ ... ]
> @@ -820,6 +831,12 @@ static int FNAME(page_fault)(struct kvm_vcpu *vcpu, =
struct kvm_page_fault *fault
>  	 * The page is not mapped by the guest.  Let the guest handle it.
>  	 */
>  	if (!r) {
> +		if (walker.memory_attributes_fault) {
> +			kvm_prepare_memory_fault_exit(vcpu, walker.gfn << PAGE_SHIFT,
> +						      PAGE_SIZE, false, false, false);
> +			return -EFAULT;
> +		}
> +
>  		if (!fault->prefetch)
>  			__kvm_inject_emulated_page_fault(vcpu, &walker.fault, true);

[Severity: High]
Does FNAME(gva_to_gpa)() also need to handle the new memory_attributes_fault
flag?

FNAME(gva_to_gpa)() uses a local walker to translate guest virtual addresses
by calling FNAME(walk_addr_generic)():

static gpa_t FNAME(gva_to_gpa)(struct kvm_vcpu *vcpu, struct kvm_pagewalk *=
w,
			       gpa_t addr, u64 access,
			       struct x86_exception *exception)
{
	struct guest_walker walker;
	gpa_t gpa =3D INVALID_GPA;
	int r;

[ ... ]

	r =3D FNAME(walk_addr_generic)(&walker, vcpu, w, addr, access);

	if (r) {
		gpa =3D gfn_to_gpa(walker.gfn);
		gpa |=3D addr & ~PAGE_MASK;
	} else if (exception)
		*exception =3D walker.fault;

	return gpa;
}

If FNAME(walk_addr_generic)() detects a memory attribute fault when reading
guest page tables, it returns 0 with walker.memory_attributes_fault set.
However, FNAME(gva_to_gpa)() appears to ignore the new flag and only copies
walker.fault to the output exception.

Can this result in the instruction emulator improperly injecting a spurious
page fault into the guest instead of exiting to userspace with
KVM_EXIT_MEMORY_FAULT when guest page tables reside in memory restricted by
KVM memory attributes?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260918135030.1715=
64-2-pbonzini@redhat.com?part=3D26
