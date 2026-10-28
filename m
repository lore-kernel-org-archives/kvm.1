Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793202517;
	b=ajG6Dgav6KsAvJWEo1fKavWIbMczVuyXtBZW5dbsRT8Rz3hehn2+fYkEZFJVfr8o9jdP
	 dWp3scD7FlVtJ+Ucw4Y/QPpmv+7czeiRlkBHx4UL/7DwuQU8IkuodI/VxPHAe6N8KFjUa
	 /bG+U1hX5CWqfNNhY6krfjUfOMcQb2JISXRj2GMZRLww6xqYfbKCXyyC7udVz4NyZqILI
	 2Vm8ghHzpUelDlXa55mfiJKYkLh8k79zWUL2f4tacAYiNRqRmHl4G6U/T2GlRLHFXVbB4
	 0gTfACQEmBfWXehBaFQXpsDwnvZFlH+bYgpxt8OBvbzsEhE9uC2aYxdJKt3f9gMySTA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793202517;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=9BUU598ImlXJDkWhuDOvV3KESqhRPdPqqGol2Qfllgs=;
	b=2Ism4TXMRdFYfqU3u7YOOWxtUDdtF+qdnimUkSMqtcwCzCResRD7D6GD33AczYtt9Lmv
	 NNsxA0yZNydTcAl5C/NMnfhnpD6cJjqL7g/FQK/2OyLRuU15E8hN6p2Qj1VszEZfeS9yl
	 NE9ii+mhugBWLZGWT7sL8b0VflGXN/8dlSE+gAv4yJG8SIG/ci2bEfa6M+wJcnfoXrRIb
	 OALeAoxA2sfrmCPmLe17OfjE4BpU9ee2YkD4y9FBifUMsxi5R1WPbdmgJQgu4DiNhlPP1
	 YnNH4w+jmKdeQJncz8yAk/biOiSYAAidRaAXYoznYJ4NVf4JX/G79RihDGLvUCyq02Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=GdZMwfO4;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6A74606A32F
	for <kvm@vger.kernel.org>; Wed, 28 Oct 2026 15:48:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=GdZMwfO4
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5F0EC1F01828;
	Wed, 28 Oct 2026 15:48:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793202516;
	bh=9BUU598ImlXJDkWhuDOvV3KESqhRPdPqqGol2Qfllgs=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=GdZMwfO4YGAsK7nN1ZB5YZtC6dVxTk6v7fU4GYMfVkPAE8D2tUjwQSaCjcLyGvyNu
	 WEHtIL9O8MxSYphaPZCmv5mUpp3lwVa9j+n54qlu/tbkFbdOGb5kG4rBAUuCxk5FK3
	 fYP7Wd6EOqMI58TcbK5dwzcjEaIHZouRCY76R/7gLJL/lTDfgHxt+X59RKT2fQqvmD
	 iauiORfV8TW4MkbUkO2I7bNpI4QAcVh2ywrHLtlFwPeIj6RjyhjPGhshnqBefrIK+8
	 hC5Ck//EFEqyG4gXh9I2mxEUTnicnoFxaHg6d8l8SuhFEKRkaXqcj09/Etxtu+yrd5
	 l7wchGBjxUGDA==
Message-ID: <sashiko-outbox-188084@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH 02/14] KVM: guest_memfd: Support read-only frames
 from PFN mode providers
Reply-To: sashiko-reviews@lists.linux.dev
To: "Fred Griffoul" <griffoul@gmail.com>, "Ackerley Tng" <ackerleytng@google.com>, "Paolo
 Bonzini" <pbonzini@redhat.com>, "Sean Christopherson" <seanjc@google.com>, "Jason
 Gunthorpe" <jgg@ziepe.ca>, "Kevin Tian" <kevin.tian@intel.com>
Cc: "Alex Williamson" <alex@shazbot.org>, "Alexander Graf" <graf@amazon.de>, "Alexander
 Viro" <viro@zeniv.linux.org.uk>, "Alexey Kardashevskiy" <aik@amd.com>, "Andrew
 Morton" <akpm@linux-foundation.org>, "Aneesh Kumar K . V" <aneesh.kumar@kernel.org>, "Ashish
 Kalra" <ashish.kalra@amd.com>, "Baolin Wang" <baolin.wang@linux.alibaba.com>, "Baolu
 Lu" <baolu.lu@linux.intel.com>, "Bill Wendling" <morbo@google.com>, "Borislav
 Petkov" <bp@alien8.de>, "Catalin Marinas" <catalin.marinas@arm.com>, "Christian
 Brauner" <brauner@kernel.org>, =?utf-8?b?Q2hyaXN0aWFuIEvDtm5pZw==?= <christian.koenig@amd.com>, "Connor
 Williamson" <connordw@amazon.com>, "Dave Hansen" <dave.hansen@linux.intel.com>, "Dave
 Jiang" <dave.jiang@intel.com>, "David Hildenbrand" <david@kernel.org>, "David
 Rientjes" <rientjes@google.com>, "David Woodhouse" <dwmw2@infradead.org>, "Erdem
 Aktas" <erdemaktas@google.com>, "Frank van der Linden" <fvdl@google.com>, "Gregory
 Price" <gourry@gourry.net>, "H . Peter Anvin" <hpa@zytor.com>, "Hugh
 Dickins" <hughd@google.com>, "Ingo Molnar" <mingo@redhat.com>, "Jacob Pan" <jacob.pan@linux.microsoft.com>, "James
 Houghton" <jthoughton@google.com>, "Jan Kara" <jack@suse.cz>, "Jianxiong
 Gao" <jxgao@google.com>, "Joerg Roedel" <joro@8bytes.org>, "Joey Gouly" <joey.gouly@arm.com>, "John
 Starks" <John.Starks@microsoft.com>, "Jonathan Corbet" <corbet@lwn.net>, "Justin
 Stitt" <justinstitt@google.com>, "Lorenzo Stoakes" <ljs@kernel.org>, "Marc
 Zyngier" <maz@kernel.org>, "Michael Roth" <michael.roth@amd.com>, "Mike
 Rapoport" <rppt@kernel.org>, "Nathan Chancellor" <nathan@kernel.org>, "Nick
 Desaulniers" <ndesaulniers@google.com>, "Nicolin Chen" <nicolinc@nvidia.com>, "Oliver
 Upton" <oupton@kernel.org>, "Pratyush Yadav" <pratyush@kernel.org>, "Randy
 Dunlap" <rdunlap@infradead.org>, "Robin Murphy" <robin.murphy@arm.com>, "Samiullah
 Khawaja" <skhawaja@google.com>, "Shuah Khan" <shuah@kernel.org>, "Steffen
 Eiden" <seiden@linux.ibm.com>, "Steven Price" <steven.price@arm.com>, "Suzuki
 K Poulose" <suzuki.poulose@arm.com>, "Tarun Sahu" <tarunsahu@google.com>, "Thomas
 Gleixner" <tglx@kernel.org>, "Tom Lendacky" <thomas.lendacky@amd.com>, "Tycho
 Andersen" <tycho@kernel.org>, "Vishal Annapurve" <vannapurve@google.com>, "Vlastimil
 Babka" <vbabka@kernel.org>, "Will Deacon" <will@kernel.org>, "Xu Yilun" <yilun.xu@linux.intel.com>, "Yan
 Zhao" <yan.y.zhao@intel.com>, "Zenghui Yu" <yuzenghui@huawei.com>, x86@kernel.org, "Shuah
 Khan" <skhan@linuxfoundation.org>, "Fuad Tabba" <fuad.tabba@linux.dev>, kvm@vger.kernel.org, linux-mm@kvack.org
In-Reply-To: <20261027154649.91571-3-griffoul@gmail.com>
References: <20261022-gmem-alternative-providers-v2-0-5dd1dc6c660a@google.com>
 <20261027154649.91571-1-griffoul@gmail.com>
 <20261027154649.91571-3-griffoul@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 28 Oct 2026 15:48:33 +0000
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
- [High] KVM: guest_memfd: triggerable WARN_ON_ONCE(!writable) in kvm_gmem_=
get_pfn()
- [High] KVM: arm64: kvm_translate_vncr() rejects read-only frames on guest=
 reads
- [High] KVM: guest_memfd: premature unlock in kvm_gmem_pfn_mkwrite() allow=
s RO bypass
- [High] KVM: guest_memfd: Add block range before kvm_mmu_unmap_gfn_range()
--

commit 421ea1b76fdc664724f686d68f71491b37e2d2b4
Author: Fred Griffoul <fgriffo@amazon.co.uk>

KVM: guest_memfd: Support read-only frames from PFN mode providers

This commit adds an attributes output parameter to the PFN-mode provider
get_pfn() callback and defines GUEST_MEMFD_PFN_READONLY so providers can
lend read-only frames to guest_memfd. KVM maps such frames read-only in
guest and host page tables, exits to userspace on guest writes, raises
SIGBUS on host writes, and disallows using them to back private or
populated pages.

> diff --git a/arch/arm64/kvm/nested.c b/arch/arm64/kvm/nested.c
> index f1c414f1c3faf..ec3bcdc230cf9 100644
> --- a/arch/arm64/kvm/nested.c
> +++ b/arch/arm64/kvm/nested.c
> @@ -1615,12 +1615,19 @@ static int kvm_translate_vncr(struct kvm_vcpu *vc=
pu, bool *is_gmem)
>  			return -EFAULT;
>  		}
>  	} else {
> -		ret =3D kvm_gmem_get_pfn(vcpu->kvm, memslot, gfn, &pfn, NULL);
> +		ret =3D kvm_gmem_get_pfn(vcpu->kvm, memslot, gfn, &pfn, NULL,
> +				       &writable);
>  		if (ret) {
>  			kvm_prepare_memory_fault_exit(vcpu, vt->wr.pa, PAGE_SIZE,
>  					      write_fault, false, false);
>  			return ret;
>  		}
> +		/* The CPU writes the VNCR page: a read-only frame cannot back it. */
> +		if (!writable) {
> +			kvm_prepare_memory_fault_exit(vcpu, vt->wr.pa, PAGE_SIZE,
> +					      true, false, false);
> +			return -EFAULT;
> +		}
> =20
>  		writable =3D !(memslot->flags & KVM_MEM_READONLY);
>  	}

[Severity: High]
Does kvm_translate_vncr() need to reject read-only frames even when the
guest is only reading from the VNCR page?

Under FEAT_NV2, the CPU reads from the VNCR_EL2 page when the guest
executes an MRS of a redirected EL1 system register (write_fault is false)
and writes to it when the guest executes an MSR (write_fault is true).
The rest of the VNCR handling in kvm_handle_vncr_abort() and
kvm_map_l1_vncr() already supports read-only backing frames (such as a
KVM_MEM_READONLY memslot) by recording vt->hpa_writable =3D writable and
mapping the fixmap as PAGE_KERNEL_RO when vt->hpa_writable is false:

arch/arm64/kvm/nested.c:kvm_handle_vncr_abort() {
	...
	case 0:
		perm =3D kvm_is_write_fault(vcpu) ? vt->wr.pw && vt->hpa_writable : vt->w=
r.pr;
		if (!perm)
			handle_vncr_perm(vcpu);
		break;
}

arch/arm64/kvm/nested.c:kvm_map_l1_vncr() {
	...
	if (vt->hpa_writable && vt->wr.pw && vt->wr.pr)
		prot =3D PAGE_KERNEL;
	else if (vt->wr.pr)
		prot =3D PAGE_KERNEL_RO;
	else
		prot =3D PAGE_NONE;
}

By checking !writable unconditionally in kvm_translate_vncr() and
exiting to userspace with write_fault hardcoded to true, a guest MRS read
of a VNCR-redirected register backed by a GUEST_MEMFD_PFN_READONLY frame
fails with KVM_EXIT_MEMORY_FAULT instead of mapping the VNCR page
read-only. In addition, if the guest's own EL2 Stage-1 translation lacks
permission (!vt->wr.pr or !vt->wr.pw), exiting here bypasses
handle_vncr_perm() and exits to host userspace instead of injecting a
Stage-1 permission fault into the guest.

Should kvm_translate_vncr() instead fold writable into
writable =3D writable && !(memslot->flags & KVM_MEM_READONLY), or only exit
when write_fault && !writable after verifying guest Stage-1 permissions?

[ ... ]

> diff --git a/virt/kvm/guest_memfd.c b/virt/kvm/guest_memfd.c
> index be26bd16d4207..1554a17906da8 100644
> --- a/virt/kvm/guest_memfd.c
> +++ b/virt/kvm/guest_memfd.c

[ ... ]

> @@ -721,13 +728,71 @@ static bool kvm_gmem_supports_mmap(struct inode *in=
ode)

[ ... ]

> +/*
> + * A write to a read-only PTE, e.g. after mprotect(): allow it unless th=
e frame
> + * is read only.  The core upgrades the PTE under its lock only if it di=
d not
> + * change, and a provider that makes the frame read only revokes it firs=
t.
> + */
> +static vm_fault_t kvm_gmem_pfn_mkwrite(struct vm_fault *vmf)
> +{
> +	struct inode *inode =3D file_inode(vmf->vma->vm_file);
> +	vm_fault_t ret =3D 0;
> +	kvm_pfn_t pfn;
> +	u32 attrs;
> +	int r;
> +
> +	filemap_invalidate_lock_shared(inode->i_mapping);
> +	r =3D gmem_provider_get_pfn(GMEM_I(inode), vmf->pgoff, &pfn, NULL, &att=
rs);
> +	if (r)
> +		ret =3D vmf_error(r);
> +	else if (attrs & GUEST_MEMFD_PFN_READONLY)
> +		ret =3D VM_FAULT_SIGBUS;
> +	filemap_invalidate_unlock_shared(inode->i_mapping);
> +	return ret;
> +}

[Severity: High]
Can releasing filemap_invalidate_lock_shared() before returning from
kvm_gmem_pfn_mkwrite() allow a read-only frame to be upgraded to a
writable PTE after kvm_gmem_revoke()?

In mm/memory.c, wp_pfn_shared() drops the page table lock before calling
vma->vm_ops->pfn_mkwrite(vmf), and then calls finish_mkwrite_fault(),
which re-locks the PTE and upgrades it to writable if
pte_same(ptep_get(vmf->pte), vmf->orig_pte) holds:

mm/memory.c:wp_pfn_shared() {
	if (vma->vm_ops && vma->vm_ops->pfn_mkwrite) {
		...
		pte_unmap_unlock(vmf->pte, vmf->ptl);
		...
		ret =3D vma->vm_ops->pfn_mkwrite(vmf);
		if (ret & (VM_FAULT_ERROR | VM_FAULT_NOPAGE))
			return ret;
		return finish_mkwrite_fault(vmf, NULL);
	}
}

If a VMA with VM_WRITE | VM_SHARED has a present read-only special PTE
mapping PFN P (for example after mprotect(PROT_READ) followed by
mprotect(PROT_READ | PROT_WRITE), or faulted in while P was read-only and
later made writable), consider what happens when thread A writes to that
address:

1. Thread A enters wp_pfn_shared() -> kvm_gmem_pfn_mkwrite(), acquires
   filemap_invalidate_lock_shared(), sees attrs =3D=3D 0 for PFN P, and dro=
ps
   filemap_invalidate_lock_shared().
2. Before thread A reaches finish_mkwrite_fault(), the provider marks PFN P
   as GUEST_MEMFD_PFN_READONLY and calls kvm_gmem_revoke(), which takes
   filemap_invalidate_lock() exclusively, zaps the PTE via
   unmap_mapping_range(), and drops filemap_invalidate_lock().
3. Thread B triggers a read fault on the same address.
   kvm_gmem_fault_user_mapping() -> kvm_gmem_pfn_fault() sees
   GUEST_MEMFD_PFN_READONLY and calls vmf_insert_pfn_prot() with
   kvm_gmem_pfn_prot(vma, GUEST_MEMFD_PFN_READONLY), installing a
   read-only special PTE for PFN P that is bit-for-bit identical to
   thread A's vmf->orig_pte.
4. Thread A enters finish_mkwrite_fault(), sees
   pte_same(ptep_get(vmf->pte), vmf->orig_pte) is true, and calls
   wp_page_reuse(), making the PTE writable even though PFN P is now
   GUEST_MEMFD_PFN_READONLY and revocation already completed.

Also, kvm_gmem_pfn_mkwrite() does not check kvm_gmem_is_shared_mem() the
way kvm_gmem_fault_user_mapping() does.

[ ... ]

> @@ -1588,14 +1660,22 @@ static int kvm_gmem_pfn_map_order(struct inode *i=
node, pgoff_t index,
>  	return order;
>  }
> =20
> +/*
> + * @writable, if not NULL, is set to whether the guest may write the pag=
e.  It
> + * may be NULL only for private pages, which are always writable.
> + */
>  int kvm_gmem_get_pfn(struct kvm *kvm, struct kvm_memory_slot *slot,
> -		     gfn_t gfn, kvm_pfn_t *pfn, int *max_order)
> +		     gfn_t gfn, kvm_pfn_t *pfn, int *max_order,
> +		     bool *writable)
>  {
>  	pgoff_t index =3D kvm_gmem_get_index(slot, gfn);
>  	struct folio *folio;
>  	int r =3D 0, __order;
> +	u32 attrs =3D 0;
> =20
>  	max_order =3D max_order ?: &__order;
> +	if (writable)
> +		*writable =3D true;
> =20
>  	CLASS(gmem_get_file, file)(slot);
>  	if (!file)
> @@ -1603,15 +1683,28 @@ int kvm_gmem_get_pfn(struct kvm *kvm, struct kvm_=
memory_slot *slot,
> =20
>  	filemap_invalidate_lock_shared(file_inode(file)->i_mapping);
> =20
> -	folio =3D __kvm_gmem_get_pfn(file, slot, index, pfn, max_order);
> +	folio =3D __kvm_gmem_get_pfn(file, slot, index, pfn, max_order, &attrs);
>  	if (IS_ERR(folio)) {
>  		r =3D PTR_ERR(folio);
>  		goto out;
>  	}
> =20
> -	if (kvm_gmem_is_pfn_mode(GMEM_I(file_inode(file))))
> +	if (kvm_gmem_is_pfn_mode(GMEM_I(file_inode(file)))) {
> +		/*
> +		 * A read-only frame is not the guest's alone, so it never
> +		 * backs a private page: a private fault on it is a hole.
> +		 */
> +		if (attrs & GUEST_MEMFD_PFN_READONLY) {
> +			if (kvm_gmem_is_private_mem(file_inode(file), index) ||
> +			    WARN_ON_ONCE(!writable)) {
> +				r =3D -EFAULT;
> +				goto out;
> +			}
> +			*writable =3D false;
> +		}

[Severity: High]
Can a guest or host userspace trigger this WARN_ON_ONCE(!writable)?

In arch/x86/kvm/svm/sev.c, both __sev_snp_reload_vmsa() and
sev_handle_rmp_fault() pass writable =3D NULL to kvm_gmem_get_pfn():

arch/x86/kvm/svm/sev.c:__sev_snp_reload_vmsa() {
	...
	if (kvm_gmem_get_pfn(vcpu->kvm, slot, gfn, &pfn, NULL, NULL))
		return;
}

arch/x86/kvm/svm/sev.c:sev_handle_rmp_fault() {
	...
	if (!kvm_is_private_gfn(kvm, gfn)) {
		...
		return;
	}
	...
	ret =3D kvm_gmem_get_pfn(kvm, slot, gfn, &pfn, &order, NULL);
}

In __sev_snp_reload_vmsa(), there is no check that the GFN is marked
private before calling kvm_gmem_get_pfn(). An SEV-SNP guest can supply an
arbitrary GPA via SVM_VMGEXIT_AP_CREATE or SVM_VMGEXIT_AP_CREATE_ON_INIT
in sev_snp_ap_creation(), or host userspace can convert an existing VMSA
GPA from private to shared via KVM_SET_MEMORY_ATTRIBUTES2 (which triggers
sev_gmem_invalidate_range() and requests KVM_REQ_VMSA_PAGE_RELOAD). Similar=
ly,
in sev_handle_rmp_fault(), kvm_is_private_gfn() is checked before
filemap_invalidate_lock_shared() is acquired in kvm_gmem_get_pfn(), so a
concurrent private-to-shared attribute conversion can complete in between.

If the GFN is shared (so kvm_gmem_is_private_mem() returns false) and is
backed by a GUEST_MEMFD_PFN_READONLY frame, kvm_gmem_get_pfn() will
evaluate WARN_ON_ONCE(!writable) and warn in the host kernel.

>  		*max_order =3D kvm_gmem_pfn_map_order(file_inode(file), index, gfn,
>  						    *pfn, *max_order);
> +	}

[Severity: High]
When a provider changes GUEST_MEMFD_PFN_READONLY on a sub-range of a huge
PFN-mode block and calls kvm_gmem_revoke(), is the invalidation order in
__kvm_gmem_invalidate_start() sufficient to prevent a concurrent fault on
another GFN in the same block from installing a stale writable 2M/1G page?

In __kvm_gmem_invalidate_start(), kvm_mmu_unmap_gfn_range() is called
before kvm_mmu_invalidate_range_add() widens the invalidation range to the
PUD_ORDER-aligned block:

virt/kvm/guest_memfd.c:__kvm_gmem_invalidate_start() {
	...
		flush |=3D kvm_mmu_unmap_gfn_range(kvm, &gfn_range);

		kvm_mmu_invalidate_range_add(kvm,
					     round_down(gfn_range.start, blk),
					     round_up(gfn_range.end, blk));
}

Inside kvm_mmu_unmap_gfn_range(), only the unaligned [gfn_range.start,
gfn_range.end) sub-range is passed to kvm_mmu_invalidate_range_add() before
kvm_unmap_gfn_range() runs. Because gfn_range.may_block is true,
kvm_unmap_gfn_range() can yield kvm->mmu_lock while walking rmaps or roots
before __kvm_gmem_invalidate_start() adds the rounded-out block range.

If a vCPU faults on GFN B in the same 2M/1G block, finishes
kvm_gmem_get_pfn() (observing writable =3D true and *max_order >=3D PMD_ORD=
ER)
just before kvm_gmem_revoke() takes filemap_invalidate_lock(), and then
acquires kvm->mmu_lock while kvm_unmap_gfn_range() has yielded it on GFN A,
mmu_invalidate_retry_gfn() will not see GFN B in
[mmu_invalidate_range_start, mmu_invalidate_range_end) and
mmu_invalidate_seq has not yet been incremented. Couldn't that vCPU install
a writable 2M/1G mapping covering GFN A after kvm_unmap_gfn_range()
already zapped it?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261027154649.9157=
1-1-griffoul@gmail.com?part=3D2
