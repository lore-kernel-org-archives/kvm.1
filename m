Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2451A2F39C7
	for <kvm@vger.kernel.org>; Mon,  5 Oct 2026 04:01:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791172888; cv=none; b=WXr+pJDxaoz1MVOYFmp0ExlEIyHX2wW4yP+5xaQkcRk/yzl6RzT0wugXi9Es/w/EIyb1hlgxBNQKT07d3Qm8oZCdmtHEGVOqQgmgSahzTpQf+Xap5Dh6a2Ci653gbcWqruBCbkPBAnbLQDNN1Xz1pbV1UA5OnKMtNE+vU1Oyeuc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791172888; c=relaxed/simple;
	bh=pis0CitsxtXzfl0QIwFooAwCrcUDN5zs4MNvRryJsPc=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=nBVb7xosG3kgc3OwrBMkrENjOIOFiRifAy9wcly4avsPtCpImZk7jp5yhtY5lnhZ+jZ78FwmGadrXpepyxdGXRYuuoJRSndxSla9pJRM1RbFxQ/9hRflpfA1zEUKO1EB/Ov/Q6ODD408e03c8rhkBjYU2Z4hISlSdjwNDMU7fcM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GpvTF8SD; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GpvTF8SD"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 820CE1F000FF;
	Mon,  5 Oct 2026 04:01:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791172886;
	bh=kOM4BjIZRquWOLjR3dE48kni2u+yPDxXjH2nxKDGgXk=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=GpvTF8SDe/vtcf6bkkwUssHdlE/Qj156uqPE6JBWhg4qpBhESO3j4gOXuK/5C9a/f
	 6h/0j0K51bwfWMoT9VIEeW3zmpV0qS4aWtvauuFl23LiudONTASLpEhMM3nofZ1p0E
	 BpbjrItOWufngNomEmFIsaY4lFwCq85xX/JHLE433muMfFz42LD7S1kZSBJ3P0lzr8
	 uriO5HT004Ef2XqNQRejKQi7xtyVmWRVYX5xLMPRl/+7lYaT57ST7rfgpOZeO2ogey
	 vL7Yq2y2z3Qcj6CmowE1hPnPWQWu3+g/DUrDnOHlOq4bXIWtcLxuDB5ZeOcj3XfIA2
	 sNaJHIjcfRYbQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 1/5] KVM: PPC: selftests: add support for powerpc
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?Uml0ZXNoIEhhcmphbmkgKElCTSk=?= <ritesh.list@gmail.com>
Cc: kvm@vger.kernel.org
In-Reply-To: <45909dd7ddefdfa688271322561b64109af1d116.1791014923.git.ritesh.list@gmail.com>
References: <cover.1791014923.git.ritesh.list@gmail.com>
 <45909dd7ddefdfa688271322561b64109af1d116.1791014923.git.ritesh.list@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 05 Oct 2026 04:01:26 +0000
Message-Id: <20261005040126.820CE1F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] selftests: build failure due to undeclared memory allocation functi=
ons
--

commit 504c1ed58b27eced07a127f9dbb77eee82c18970
Author: Nicholas Piggin <npiggin@gmail.com>
Subject: KVM: PPC: selftests: add support for powerpc

This commit implements KVM selftests support for powerpc (Book3S-64).
However, it introduces build failures because of calls to undeclared
memory allocation functions.

Link: https://lore.kernel.org/linuxppc-dev/cover.1781093720.git.ritesh.list=
@gmail.com/

> diff --git a/tools/testing/selftests/kvm/lib/powerpc/processor.c b/tools/=
testing/selftests/kvm/lib/powerpc/processor.c
> new file mode 100644
> index 0000000000000..301455024571e
> --- /dev/null
> +++ b/tools/testing/selftests/kvm/lib/powerpc/processor.c
> @@ -0,0 +1,512 @@
> [ ... ]
> +void virt_arch_pgd_alloc(struct kvm_vm *vm)
> +{
> [ ... ]
> +	pgd_pages =3D (1UL << (RADIX_PGD_INDEX_SIZE + 3)) >> vm->page_shift;
> +	if (!pgd_pages)
> +		pgd_pages =3D 1;
> +	pgtb =3D vm_alloc_page_table_pages(vm, pgd_pages);

[Severity: Low]
Is the definition of vm_alloc_page_table_pages missing? This causes
the module to fail compiling and linking because the function is
undefined.

> +	vm->mmu.pgd =3D pgtb;
> [ ... ]
> +static gpa_t __vm_alloc_pt(struct kvm_vm *vm, u64 pt_shift)
> +{
> +	gpa_t pt;
> +
> +	if (pt_shift >=3D vm->page_shift) {
> +		size_t pt_pages =3D 1ULL << (pt_shift - vm->page_shift);
> +
> +		pt =3D vm_alloc_page_table_pages(vm, pt_pages);

[Severity: Low]
Does this code also rely on the undefined vm_alloc_page_table_pages
function?

> +	} else {
> [ ... ]
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
Could this call to an undeclared function ____vm_phy_pages_alloc be a
mistake? This call passes 6 arguments, which differs from the standard
5 arguments.

> +
> +	TEST_ASSERT(excp_paddr =3D=3D 0,

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1791014923.gi=
t.ritesh.list@gmail.com?part=3D1
