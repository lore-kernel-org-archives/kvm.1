Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B3B9299943
	for <kvm@vger.kernel.org>; Fri, 11 Sep 2026 05:06:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789103213; cv=none; b=nxRe9FkrnMfl+YAB2wwd6wrUX9oOgvsiddBUoRpj9cOIOTxbFky5imS3wcP7Z0/60fVCeghQiscbVZUuTTX3IVFelMHZykUDhtIY6b+V5sjI1YBkzMypHyeSw2yJLnlPvhTTe0kDR32WV8NGWetpKEJikTLFbd59CVWklGk5r0g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789103213; c=relaxed/simple;
	bh=SpFClGSGKZH0osKi+2qJRNpDgF8ik/Q2H/PMWXkUILk=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=YuiG0Cx9DXBCiqTJqTNCcAS5tVTfOz57CSlozU6bCeh/9Cr79azKRkiuEY0Wu6Ohpj0CCAKmohxr3WaNXqa0kogWjYn3gvx6LNRX2pOFTftk5Tf1cog76NGpc1t5vlfW5FEbEfzVH2kqu1MDQgJilmTRz+5dVTyYesM1j2Np7I0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SD/hbtec; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SD/hbtec"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A81181F000FF;
	Fri, 11 Sep 2026 05:06:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789103211;
	bh=B6UQAgETtJ90JwZAxolr/p7xfKavgdjAC1u7G09YpJg=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=SD/hbtecbkxgvyiHKMfY59BtDT7NkpH5fvFymOoL3Nzpb4v1mErVTFiGvdsgPm4Cb
	 0RximTVCvXU9esmjtvU2ItrncujqTSBQXFUtv+/z9xWW0kE2byztD7MvWlggOvk2Lo
	 WYcXxygrSvHYTHT2TcxIKXn4/QAO7D0gpRLY5bp5mLvEA+GF4ApuNeu8LKJw6GBWKx
	 gsXtpK2hZSD7lYL9QvaXJ7YGMB+1GAAlrPmMXTXoYfPTWkUZjmXAqnstix3baijNiV
	 CpoW5Ypv8jwSsXnrkwtJYIpHp9frQqehWFtOYikxZDOog7ve3ZrUtPjn9UUjjgZxIo
	 Zuyfnb14S9m/g==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 1/3] KVM: PPC: selftests: add support for powerpc
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?Uml0ZXNoIEhhcmphbmkgKElCTSk=?= <ritesh.list@gmail.com>
Cc: kvm@vger.kernel.org
In-Reply-To: <4120e30a5f69e6480738f60d113033921579c32c.1789097569.git.ritesh.list@gmail.com>
References: <cover.1789097569.git.ritesh.list@gmail.com>
 <4120e30a5f69e6480738f60d113033921579c32c.1789097569.git.ritesh.list@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 11 Sep 2026 05:06:51 +0000
Message-Id: <20260911050651.A81181F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] The patch relies on a missing KVM selftests core infrastructure pat=
ch, leading to undefined function calls and a build failure.
--

commit abd17de4492c780fa3b8540774bca368e3f9baa2
Author: Nicholas Piggin <npiggin@gmail.com>

KVM: PPC: selftests: add support for powerpc

This commit implements KVM selftests support for powerpc (Book3S-64),
including virtual memory for the radix MMU and guest interrupt handling
in real-mode. It also updates various types and adapts to the new page
table allocator APIs.

Link: https://lore.kernel.org/linuxppc-dev/cover.1781093720.git.ritesh.list=
@gmail.com/

> diff --git a/tools/testing/selftests/kvm/lib/powerpc/processor.c b/tools/=
testing/selftests/kvm/lib/powerpc/processor.c
> new file mode 100644
> index 0000000000000..57f8d90b55e3d
> --- /dev/null
> +++ b/tools/testing/selftests/kvm/lib/powerpc/processor.c

[ ... ]

> +void virt_arch_pgd_alloc(struct kvm_vm *vm)
> +{
> +	struct kvm_ppc_mmuv3_cfg mmu_cfg;
> +	gpa_t prtb, pgtb;
> +	size_t pgd_pages;
> +
> +	TEST_ASSERT((vm->mode =3D=3D VM_MODE_P52V52_4K) ||
> +		    (vm->mode =3D=3D VM_MODE_P52V52_64K),
> +		    "Unsupported guest mode, mode: 0x%x", vm->mode);
> +
> +	if (vm->mmu.pgd_created)
> +		return;
> +
> +	prtb =3D vm_alloc_page_table(vm);
> +	vm->arch.prtb =3D prtb;
> +
> +	pgd_pages =3D (1UL << (RADIX_PGD_INDEX_SIZE + 3)) >> vm->page_shift;
> +	if (!pgd_pages)
> +		pgd_pages =3D 1;
> +	pgtb =3D vm_alloc_page_table_pages(vm, pgd_pages);

[Severity: Low]
Are we missing a prerequisite patch for the selftests core infrastructure?
Building the tests for powerpc fails in virt_arch_pgd_alloc() because
vm_alloc_page_table_pages() is undefined.

> +	vm->mmu.pgd =3D pgtb;
> +
> +	/* Set the base page directory in the proc table */
> +	set_radix_proc_table(vm, 0, pgtb);

[ ... ]

> +static gpa_t __vm_alloc_pt(struct kvm_vm *vm, u64 pt_shift)
> +{
> +	gpa_t pt;
> +
> +	if (pt_shift >=3D vm->page_shift) {
> +		size_t pt_pages =3D 1ULL << (pt_shift - vm->page_shift);
> +
> +		pt =3D vm_alloc_page_table_pages(vm, pt_pages);

[Severity: Low]
Is the definition for vm_alloc_page_table_pages() missing from the tree?
Calling this in __vm_alloc_pt() leads to an undefined function build failur=
e.

> +	} else {
> +		struct vm_pt_frag_cache *pt_frag_cache;

[ ... ]

> +void kvm_arch_vm_post_create(struct kvm_vm *vm, unsigned int nr_vcpus)
> +{
> +	size_t excp_size =3D __interrupts_end - __interrupts_start;
> +	size_t excp_pages =3D (excp_size + vm->page_size - 1) / vm->page_size;
> +	gpa_t excp_paddr;
> +	void *mem;
> +
> +	/*
> +	 * Guest interrupts are taken in real-mode, i.e. the vectors must live
> +	 * at gPA 0.  Use the innermost allocator to override the minimum GPA
> +	 * that MEM_REGION_DATA would otherwise impose.
> +	 */
> +	excp_paddr =3D ____vm_phy_pages_alloc(vm, excp_pages, 0,
> +					    vm->memslots[MEM_REGION_DATA],
> +					    vm_arch_has_protected_memory(vm),
> +					    false);

[Severity: Low]
Is the definition for ____vm_phy_pages_alloc() with 6 arguments missing?
Calling this undefined function in kvm_arch_vm_post_create() causes a build
failure when compiling the powerpc KVM selftests.

> +
> +	TEST_ASSERT(excp_paddr =3D=3D 0,
> +		    "Interrupt vectors not allocated at gPA address 0: (0x%lx)",
> +		    excp_paddr);
> +
> +	mem =3D addr_gpa2hva(vm, excp_paddr);
> +	memcpy(mem, __interrupts_start, excp_size);
> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1789097569.gi=
t.ritesh.list@gmail.com?part=3D1
