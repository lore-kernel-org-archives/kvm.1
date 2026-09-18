Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3719044AB8A
	for <kvm@vger.kernel.org>; Fri, 18 Sep 2026 08:37:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789720650; cv=none; b=Y9Lbz6Wc0ZqH7n9NYztc1Zr6oOwig5mKXnYnXfaLnf1CV0g/bABjA0KIPw8KhgENUsdwmM2KhF+kJ+UC7kCw7vZjBjR82PGqpFzwySggYhw67AoDO46g9kJ/WiVih45B4vc2159hnJGReIu9gR7PN6WzNNvZnEOF2iDV0D/Khyg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789720650; c=relaxed/simple;
	bh=KGBDuMfUmhRQblJsPT69GK+jcROS6fw7GVvGhiPbeQE=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=PInGEd5nanNNIOHAZjE5MZ4Qfr0LfN9K9zhpK4BgVr0BHQcZLZfNdmxHepk4dWhcFY41eMIrDygesSzI5/Njgrg09A0JcA+BNrwsTlCp/kDmlk9RlMr0vidZEwNuDFMV1aIiuUm9IZWUxgkOcgCCf83Y5kBl2U3yAf1rOp6yPvU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DsMi5ghm; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DsMi5ghm"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 931541F000FF;
	Fri, 18 Sep 2026 08:37:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789720648;
	bh=udnemYPNMJcWkKaB4XljCTFTN4+vAh134vfVsdWLgXc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=DsMi5ghmTGg+iUapwNLW4c0MwxdlkvJUZ/I+HD5BZmwNEgTgSYcJG2m7kvEy2QSnU
	 vu7hrSqJuCj3tRsCuKBhm3PdJ0aptlRceXcVipv3pWpH9sXGrdvSI6TF+Gn2aSRvSq
	 0NyLchn5xiXoO38MNh/EvZY+5w0LJb+yd+FzsL0qKZ7a/0bywjCV3r14Vwxndo94KK
	 QDtqtG4hlm7h+FVds8pGrobrW0JFB60wYi/TnFbtphrp5RzytgBfg0SUxKQXgEcpG6
	 Gng2EQzOHS/KRIT4LVRC/mLKLrua92UFJRrhjf4CA8yO1MigZrbEC+WV/JT42AKtaV
	 SkBUS8N3GXGLw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 22/28] KVM: x86/mmu: Issue memory fault exit if walk
 failed due to memory attribute
Reply-To: sashiko-reviews@lists.linux.dev
To: "Paolo Bonzini" <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org
In-Reply-To: <20260918081543.139871-23-pbonzini@redhat.com>
References: <20260918081543.139871-1-pbonzini@redhat.com>
 <20260918081543.139871-23-pbonzini@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 18 Sep 2026 08:37:28 +0000
Message-Id: <20260918083728.931541F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] kvm: KVM_EXIT_MEMORY_FAULT reports original access type instead of=
 PTE read
- [High] kvm: memory attribute violations during emulation inject spurious =
#PF
--

commit f13a0662fba26c69b7ab24d7639e44c8da7ee24c
Author: Nicolas Saenz Julienne <nsaenz@amazon.com>

KVM: x86/mmu: Issue memory fault exit if walk failed due to memory attribute

This patch adds a check during guest page table walks to identify if a walk
fails due to a memory attribute restriction. When this occurs, it populates
the newly added memory_attributes_fault flag and attempts to exit to usersp=
ace
with a memory fault.

> diff --git a/arch/x86/kvm/mmu/paging_tmpl.h b/arch/x86/kvm/mmu/paging_tmp=
l.h
> index b031123fcb369..d2836a327bc99 100644
> --- a/arch/x86/kvm/mmu/paging_tmpl.h
> +++ b/arch/x86/kvm/mmu/paging_tmpl.h
[ ... ]
> @@ -411,6 +413,12 @@ static int FNAME(walk_addr_generic)(struct guest_wal=
ker *walker,
>  		if (unlikely(kvm_is_error_hva(host_addr)))
>  			goto error;
> =20
> +		if (!kvm_mem_attributes_may_read_gfn(vcpu->kvm, gpa_to_gfn(real_gpa)))=
 {
> +			walker->memory_attributes_fault =3D true;
> +			walker->gfn =3D gpa_to_gfn(real_gpa);
> +			goto error;
> +		}
> +

[Severity: High]
When this flag is set and FNAME(walk_addr_generic)() returns an error, how =
is
it handled by other callers that aren't updated in this patch?

For example, in arch/x86/kvm/mmu/paging_tmpl.h within FNAME(gva_to_gpa)():

static gpa_t FNAME(gva_to_gpa)(struct kvm_vcpu *vcpu, struct kvm_pagewalk *=
w,
			       gpa_t addr, u64 access,
			       struct x86_exception *exception)
{
	struct guest_walker walker;
	gpa_t gpa =3D INVALID_GPA;
	int r;

	r =3D FNAME(walk_addr_generic)(&walker, vcpu, w, addr, access);

	if (r) {
		gpa =3D gfn_to_gpa(walker.gfn);
		gpa |=3D addr & ~PAGE_MASK;
	} else if (exception)
		*exception =3D walker.fault;

If instruction emulation encounters a memory attribute violation here durin=
g a
page table walk, does this drop the walker.memory_attributes_fault flag and
blindly return the fabricated #PF exception?

Could this inject a spurious #PF into the guest instead of exiting to users=
pace
with KVM_EXIT_MEMORY_FAULT?

[ ... ]
> @@ -820,6 +828,12 @@ static int FNAME(page_fault)(struct kvm_vcpu *vcpu, =
struct kvm_page_fault *fault
>  	 * The page is not mapped by the guest.  Let the guest handle it.
>  	 */
>  	if (!r) {
> +		if (walker.memory_attributes_fault) {
> +			fault->gfn =3D walker.gfn;
> +			kvm_mmu_prepare_memory_fault_exit(vcpu, fault);
> +			return -EFAULT;
> +		}
> +

[Severity: High]
In arch/x86/kvm/mmu/paging_tmpl.h within FNAME(page_fault)(), if
walker.memory_attributes_fault is true, we prepare a memory fault exit.

However, does kvm_mmu_prepare_memory_fault_exit() use the original fault's
properties (fault->write, fault->exec) instead of the properties of the page
table read itself?

Could this incorrectly report the access flags to userspace (e.g., reporting
WRITE or EXEC instead of READ) when a page table walk fails due to KVM memo=
ry
attributes?

>  		if (!fault->prefetch)
>  			__kvm_inject_emulated_page_fault(vcpu, &walker.fault, true);
>

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260918081543.1398=
71-1-pbonzini@redhat.com?part=3D22
