Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792428378;
	b=IxkSzJQjq+kD5/DKd7BMszzuIxXlM4F0NCqsFUTyUXkmgOyU0+IjcUYZlLMyRLp69gFZ
	 eOjX2UuBCj9WLkHiQdmzlV791wtGc2SlDVeZ0hP37YKXywpp547AXkInsVi5qsNfcZ8v/
	 TY2yh56sHznmKgiBPMljOADgzL5wsqQ0Uecy60Ri2CWxXNrljrESzuuX7hCibSA4FB4xt
	 /46caItaskIe6PNznN7O2rqwPOQKulkiGpucrEKpDVru3+ZBTngSv9GFpDw/nS6Vw2vX7
	 V9xigqqhV8tsohbUOxHKmnK4bugr/bi2KQ9NFSOTadxJivAdL99a0O/a2549L69YgYw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792428378;
	h=Received:DKIM-Signature:Received:Date:From:To:Cc:Subject:Message-ID:
	 MIME-Version:Content-Type:Content-Disposition;
	bh=zG9l3gdEZv24Wv1+jYwCr9vu8fFpf5WmZW/fv7xLtNI=;
	b=KM4rj/6+XgXRmU43CUkjC2QQLX8L08nf1PQerOcaoCQ159IqT+I1KxX/dvvHC45BFOEt
	 v3CpOK0fI9dpuTyziARrzqrBUKZre1Kpg2kPvzyhOXD1IbWGvKffFhvOvMbcPswLUOVvE
	 4AZ1TaUU9e1jkiL1NtTqWmEbqCihKDcZbUkbOK6UtUObdwRd25kxwfjmjjbBlbZTXRhgb
	 +YHIA6NCZH+42DnffKtgHCoj4e3Y90b0T34hW/Kbk1SWLrhiny91EDFMZK1dSyhjxrbCg
	 FxKxP+zNEfAdPrpGF/K/bUFftzXVREFL/G5kh2pi4C9dPpVCh8yl9EznGPgHiSIwLYw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=GYg7Jdh4;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28EA8606A31D;
	Mon, 19 Oct 2026 16:46:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=GYg7Jdh4
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 949271F000C4;
	Mon, 19 Oct 2026 16:46:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792428377;
	bh=zG9l3gdEZv24Wv1+jYwCr9vu8fFpf5WmZW/fv7xLtNI=;
	h=Date:From:To:Cc:Subject;
	b=GYg7Jdh4E8FUAFl8R+uAscN46oKSgEe3ROvwudBV21lFN2Sk6Yv/HG050fATFK/Lt
	 gdKdp81In8Ol/92ATo2aupE+kh1FTYtMtJGp133fhBIJs3STDC6m4fXeNIeVZKU46G
	 YIqPjzu3y0EXyyrGvAST74ge5zo5A40MkgyY+tAaMoIHEuqkt6hwbaiRZfTBDR2jwN
	 /5OZP7JYT7pBk8DAxx9ve4R5ysbXNF3L7IFNBbXxQcVj0Hq7URXIURyGhfpIE/IzbS
	 wkltKZdN09pd90PXLN6yL5C7tQVEMxsIA1e5beZz0Vdq598otH7TRpfKmHLi7QZ6NV
	 TjYj2eivSxW9A==
Received: by finisterre.sirena.org.uk (Postfix, from userid 1000)
	id 7AF921AC57D0; Mon, 19 Oct 2026 17:46:15 +0100 (BST)
Date: Mon, 19 Oct 2026 17:46:15 +0100
From: Mark Brown <broonie@kernel.org>
To: Oliver Upton <oupton@kernel.org>, Marc Zyngier <maz@kernel.org>
Cc: KVM <kvm@vger.kernel.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Linux Next Mailing List <linux-next@vger.kernel.org>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Suzuki K Poulose <suzuki.poulose@arm.com>
Subject: linux-next: manual merge of the kvm-arm tree with the kvm tree
Message-ID: <atZJV1B79VsZoy8u@sirena.co.uk>
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="72M+QjVQ4xoMSxcZ"
Content-Disposition: inline


--72M+QjVQ4xoMSxcZ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the kvm-arm tree got a conflict in:

  arch/arm64/kvm/mmu.c

between commit:

  dd0bc00e3e920 ("Merge branch kvm-arm64/cca-7.4 into kvmarm-master/next")

=66rom the kvm tree and commits:

  b44a8c32f0116 ("KVM: arm64: Abstract out memory abort handling")
  892c8a0bcc8e3 ("Merge branch kvm-arm64/cca-7.4 into kvmarm-master/next")

=66rom the kvm-arm tree.

I fixed it up (see below) and can carry the fix as necessary. This
is now fixed as far as linux-next is concerned, but any non trivial
conflicts should be mentioned to your upstream maintainer when your tree
is submitted for merging.  You may also want to consider cooperating
with the maintainer of the conflicting tree to minimise any particularly
complex conflicts.

diff --combined arch/arm64/kvm/mmu.c
index 6e28ded84b4d2,c9622b6e4c741..0000000000000
--- a/arch/arm64/kvm/mmu.c
+++ b/arch/arm64/kvm/mmu.c
@@@ -329,6 -329,9 +329,9 @@@ static void kvm_vm_stage2_unmap_range(s
  	struct kvm *kvm =3D kvm_s2_mmu_to_kvm(mmu);
  	int (*fn)(struct kvm_pgtable *, u64, u64);
 =20
+ 	lockdep_assert_held_write(&kvm->mmu_lock);
+ 	WARN_ON(size & ~PAGE_MASK);
+=20
  	if (kvm_is_nested_s2_mmu(kvm, mmu))
  		fn =3D kvm_pgtable_stage2_unmap_tracked;
  	else
@@@ -1585,11 -1588,32 +1588,11 @@@ transparent_hugepage_adjust(const struc
  	return PAGE_SIZE;
  }
 =20
 -static int get_vma_page_shift(struct vm_area_struct *vma, unsigned long h=
va)
 +static int get_vma_page_shift(struct vm_area_struct *vma)
  {
 -	unsigned long pa;
 -
 -	if (is_vm_hugetlb_page(vma) && !(vma->vm_flags & VM_PFNMAP))
 +	if (vma_is_hugetlb(vma))
  		return huge_page_shift(hstate_vma(vma));
 =20
 -	if (!(vma->vm_flags & VM_PFNMAP))
 -		return PAGE_SHIFT;
 -
 -	VM_BUG_ON(is_vm_hugetlb_page(vma));
 -
 -	pa =3D (vma->vm_pgoff << PAGE_SHIFT) + (hva - vma->vm_start);
 -
 -#ifndef __PAGETABLE_PMD_FOLDED
 -	if ((hva & (PUD_SIZE - 1)) =3D=3D (pa & (PUD_SIZE - 1)) &&
 -	    ALIGN_DOWN(hva, PUD_SIZE) >=3D vma->vm_start &&
 -	    ALIGN(hva, PUD_SIZE) <=3D vma->vm_end)
 -		return PUD_SHIFT;
 -#endif
 -
 -	if ((hva & (PMD_SIZE - 1)) =3D=3D (pa & (PMD_SIZE - 1)) &&
 -	    ALIGN_DOWN(hva, PMD_SIZE) >=3D vma->vm_start &&
 -	    ALIGN(hva, PMD_SIZE) <=3D vma->vm_end)
 -		return PMD_SHIFT;
 -
  	return PAGE_SHIFT;
  }
 =20
@@@ -1927,7 -1951,7 +1930,7 @@@ static short kvm_s2_resolve_vma_size(co
  		vma_shift =3D PAGE_SHIFT;
  	} else {
  		s2vi->max_map_size =3D PUD_SIZE;
 -		vma_shift =3D get_vma_page_shift(vma, s2fd->hva);
 +		vma_shift =3D get_vma_page_shift(vma);
  	}
 =20
  	switch (vma_shift) {
@@@ -2078,6 -2102,16 +2081,6 @@@ static int kvm_s2_fault_pin_pfn(const s
  				return -EFAULT;
  			}
  		} else {
 -			/*
 -			 * If the page was identified as device early by looking at
 -			 * the VMA flags, vma_pagesize is already representing the
 -			 * largest quantity we can map.  If instead it was mapped
 -			 * via __kvm_faultin_pfn(), vma_pagesize is set to PAGE_SIZE
 -			 * and must not be upgraded.
 -			 *
 -			 * In both cases, we don't let transparent_hugepage_adjust()
 -			 * change things at the last minute.
 -			 */
  			s2vi->map_non_cacheable =3D true;
  		}
 =20
@@@ -2179,10 -2213,10 +2182,10 @@@ static int kvm_s2_fault_map(const struc
 =20
  	/*
  	 * If we are not forced to use page mapping, check if we are
 -	 * backed by a THP and thus use block mapping if possible.
 +	 * backed by a huge stage-1 mapping and thus use block mapping if
 +	 * possible.
  	 */
 -	if (mapping_size =3D=3D PAGE_SIZE &&
 -	    !(s2vi->max_map_size =3D=3D PAGE_SIZE || s2vi->map_non_cacheable)) {
 +	if (mapping_size =3D=3D PAGE_SIZE && s2vi->max_map_size !=3D PAGE_SIZE) {
  		if (perm_fault_granule > PAGE_SIZE) {
  			mapping_size =3D perm_fault_granule;
  		} else {
@@@ -2276,6 -2310,10 +2279,6 @@@ static int user_mem_abort(const struct=20
  			return ret;
  	}
 =20
 -	/*
 -	 * Let's check if we will get back a huge page backed by hugetlbfs, or
 -	 * get block mapping for device MMIO region.
 -	 */
  	ret =3D kvm_s2_fault_pin_pfn(s2fd, &s2vi);
  	if (ret =3D=3D -EHWPOISON) {
  		/* If result is specified, let the caller handle this. */
@@@ -2298,9 -2336,11 +2301,11 @@@
 =20
  static int kvm_vm_mem_abort(const struct kvm_s2_fault_desc *s2fd)
  {
- 	VM_WARN_ON_ONCE(kvm_s2_fault_is_perm(s2fd) &&
- 			!esr_abt_is_write_fault(s2fd->esr) &&
- 			!kvm_s2_fault_is_exec(s2fd));
+ 	struct kvm_vcpu *vcpu =3D s2fd->vcpu;
+=20
+ 	VM_WARN_ON_ONCE(kvm_vcpu_trap_is_permission_fault(vcpu) &&
+ 			!kvm_is_write_fault(vcpu) &&
+ 			!esr_abt_is_exec_fault(kvm_vcpu_get_esr(vcpu)));
 =20
  	if (kvm_slot_has_gmem(s2fd->memslot))
  		return gmem_abort(s2fd, NULL);
@@@ -2953,18 -2993,18 +2958,18 @@@ void kvm_set_way_flush(struct kvm_vcpu=
=20
 =20
  	/*
  	 * If this is the first time we do a S/W operation
 -	 * (i.e. HCR_TVM not set) flush the whole memory, and set the
 +	 * (i.e. HCR_EL2_TVM not set) flush the whole memory, and set the
  	 * VM trapping.
  	 *
  	 * Otherwise, rely on the VM trapping to wait for the MMU +
  	 * Caches to be turned off. At that point, we'll be able to
  	 * clean the caches again.
  	 */
 -	if (!(hcr & HCR_TVM)) {
 +	if (!(hcr & HCR_EL2_TVM)) {
  		trace_kvm_set_way_flush(*vcpu_pc(vcpu),
  					vcpu_has_cache_enabled(vcpu));
  		stage2_flush_vm(vcpu->kvm);
 -		*vcpu_hcr(vcpu) =3D hcr | HCR_TVM;
 +		*vcpu_hcr(vcpu) =3D hcr | HCR_EL2_TVM;
  	}
  }
 =20
@@@ -2982,7 -3022,7 +2987,7 @@@ void kvm_toggle_cache(struct kvm_vcpu *
 =20
  	/* Caches are now on, stop trapping VM ops (until a S/W op) */
  	if (now_enabled)
 -		*vcpu_hcr(vcpu) &=3D ~HCR_TVM;
 +		*vcpu_hcr(vcpu) &=3D ~HCR_EL2_TVM;
 =20
  	trace_kvm_toggle_cache(*vcpu_pc(vcpu), was_enabled, now_enabled);
  }

--72M+QjVQ4xoMSxcZ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQReagvpf3TrrA7BoYYv73Ows9A4iQUCatZJVwAKCRAv73Ows9A4
iUArAP9MxhAaziYZm6gt5kMgAompfS0w+yvFAgvIBGMwpTy9+AD8CXQjiHiPF/m4
bR7VzHVTTX5Fna6hrPAmOebsBZfQgQk=
=q7Jb
-----END PGP SIGNATURE-----

--72M+QjVQ4xoMSxcZ--
