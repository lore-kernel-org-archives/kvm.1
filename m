Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792999167;
	b=SlxLrvWZq++w8LYGWFulWzDTbsA4aSEWSM2IP5ekh1eKOgHK89MVGgJc350jx2t9rvG/
	 /JjAgeBBoJ3EJ8+ujcKCSqoPHEsmSj03a8fI6wx66+ikTl70LmCFYpwpSHRYUc5qD43eJ
	 a3vzXU2d8Tlog5eVbFiz4/M5zZT77b+hjFsUBae3ll7V0HHzaoNGTNjoOYgUXJqyJnHti
	 drRHRHK8aODyDHM1CwO6GLyCZkqx61USzTKTTd8gaa0cYkItl2saHreijSK/KrAdWSN4j
	 2ZTasbnmYNd7ueTj/WjIcf5tSebO8xcrXYdMmhspKLXWi9DISH7VrSGCcv/exiWtHrA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792999167;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=49JESZcsjiw1c/C+26eVc6rSdXnULsa0Qk2GhTMeOpw=;
	b=Uo2zbIyJjst7SpeHd6L3tTSZ4SrVfTeX/Aqzw/0N4UmSNN2Cp6YcpSnjhIFMbYRIxcDl
	 qjeqVEBHnuyZuweVoOwSsojOrKt5Fj7gKS7eRxxZyLGOOoacMlmz9HkKiR1t71JbKCMzY
	 f8139Q10xal7X7s9vRZDhfaxZZkYYRyVgP/+Zy544YUqq3kUSk4JFCTBThYqaD8WsjN5X
	 9hFTuDKj6dfj7LxWiMhoIladRldo1iYPtub5NwkLVM2+8wXE39f7OWKcrsHisojYJRUgX
	 dNtfnSP6FsD8iBUFGYrdNl14w0XGz8KY0kCNkRxxiDIOOB7bntOIilswhevwNtD1Txw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=f6Fzsh2B;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F35BB606A31A
	for <kvm@vger.kernel.org>; Mon, 26 Oct 2026 07:19:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=f6Fzsh2B
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 71AAA1F01828;
	Mon, 26 Oct 2026 07:19:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792999166;
	bh=49JESZcsjiw1c/C+26eVc6rSdXnULsa0Qk2GhTMeOpw=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=f6Fzsh2BNkPMKE7Ii/WpLkAjzDdbghOGLv0IDDbfoQHDWW9SztlcImGiZa/X3GdDZ
	 rAz5GtwT8GwWThY2mXA8TYn8pOppHnzWrdrmbcjixDRH7C0TbJhbdeZh8HNo4FBFtk
	 qNA2ZtzctBqYMXbEME9zxJ2sZ9FMNzpEvvQQneUsDbJ2zGzQfCHPobIzhVUg9vTPJs
	 XZylrlqWGQ9G2J0FnTUTgZMIqRzvwPnFtS2VM0UAK+hkiNmYbQ35qDNNx6hIjczT5l
	 VQvk/F018UFjgoN2m9GZQ8CfRVSw9G1P3QgJ8Ow39OCeOf8sY7CMJEZhl8lFX0v4MZ
	 +cNWx+aWjZUfQ==
Message-ID: <sashiko-outbox-184655@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH v3 2/5] KVM: guest_memfd: Add ioctl
 KVM_LINK_GUEST_MEMFD
Reply-To: sashiko-reviews@lists.linux.dev
To: "Tao Gong" <gongtao@google.com>, kvm@vger.kernel.org
In-Reply-To: <20261026064424.3003536-3-gongtao@google.com>
References: <20261026064424.3003536-1-gongtao@google.com>
 <20261026064424.3003536-3-gongtao@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 26 Oct 2026 07:19:26 +0000
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] KVM: guest_memfd: multiple same-VM links to one inode in kvm_gmem_=
link()
- [High] KVM: x86: kvm_arch_gmem_link_allowed() allows unsafe TDX and SEV g=
uest_memfd linking
--

commit f69df48ff894e872fc6ccbcb9ce7d8cfde5a15f3
Author: Ackerley Tng <ackerleytng@google.com>

KVM: guest_memfd: Add ioctl KVM_LINK_GUEST_MEMFD

This commit introduces the KVM_LINK_GUEST_MEMFD ioctl to link an existing
guest_memfd's underlying inode to a new file descriptor bound to a target V=
M,
allowing compatible VMs to share the same underlying guest_memfd memory.

> diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
> index c081e4b9b25de..4427d32290c0f 100644
> --- a/arch/x86/kvm/x86.c
> +++ b/arch/x86/kvm/x86.c
> @@ -10648,6 +10648,16 @@ bool kvm_arch_supports_gmem_init_shared(struct k=
vm *kvm)
>  	return gmem_in_place_conversion || !kvm_arch_has_private_mem(kvm);
>  }
> =20
> +bool kvm_arch_gmem_link_allowed(struct kvm *dst, struct kvm *src)
> +{
> +	/*
> +	 * Different VM types have different requirements for, and different
> +	 * (vendor) state associated with, guest_memfd memory, e.g. memory that
> +	 * is private to a TDX guest must never be mapped into a non-TDX VM.
> +	 */
> +	return dst->arch.vm_type =3D=3D src->arch.vm_type;
> +}

[Severity: High]
Is checking dst->arch.vm_type =3D=3D src->arch.vm_type in
kvm_arch_gmem_link_allowed() sufficient for confidential VM types on x86?

On Intel TDX (KVM_X86_TDX_VM), each physical page in a guest_memfd is
exclusively owned in the TDX Module PAMT by a single TD's TDR and encrypted
with that TD's private HKID. If userspace links a guest_memfd between two T=
DX
VMs and both VMs populate or fault in the same private page via
tdx_mem_page_add() or tdx_mem_page_aug(), the second TD's SEAMCALL will fail
with TDX_PAGE_NOT_FREE and trigger a host WARN_ON_ONCE via TDX_BUG_ON_2():

arch/x86/kvm/vmx/tdx.c:tdx_mem_page_aug() {
	err =3D tdh_mem_page_aug(&kvm_tdx->td, gpa, level, pfn, &entry, &level_sta=
te);
	if (unlikely(tdx_operand_busy(err)))
		return -EBUSY;

	if (TDX_BUG_ON_2(err, TDH_MEM_PAGE_AUG, entry, level_state, kvm))
		return -EIO;
}

On AMD SEV-SNP (KVM_X86_SNP_VM), each physical page's hardware RMP entry
records a single (ASID, GPA) owner. If two SNP VMs link the same guest_memf=
d:

1. When dst faults in a private page already assigned in the RMP to src,
   sev_gmem_make_private() checks snp_lookup_rmpentry() without verifying t=
he
   owning ASID or GPA, and returns 0, installing an NPT mapping in dst for a
   PFN owned by src's ASID:

arch/x86/kvm/svm/sev.c:sev_gmem_make_private() {
	rc =3D snp_lookup_rmpentry(pfn, &assigned, &level);
	...
	if (assigned) {
		pr_debug("%s: already assigned: gfn %llx pfn %llx nr_pages %llx level %d\=
n",
			 __func__, gfn, pfn, nr_pages, level);
		return 0;
	}
}

2. If src closes its guest_memfd and is destroyed while dst keeps the linked
   guest_memfd open, the shared inode's folios are not freed, so
   kvm_gmem_free_folio() -> sev_gmem_make_shared() does not run.
   sev_vm_destroy() then decommissions src's SNP context and frees src's AS=
ID
   via sev_asid_free() while physical pages in the guest_memfd remain
   Assigned=3D1 to that freed/recycled ASID in the RMP.

3. If dst converts pages to shared or punches a hole while src has pages
   marked Immutable=3D1 in the RMP via KVM_SEV_SNP_LAUNCH_UPDATE,
   sev_gmem_make_shared() -> rmp_make_shared() fails and triggers WARN_ONCE=
().

In addition, for legacy SEV and SEV-ES VMs initialized via KVM_SEV_INIT or
KVM_SEV_ES_INIT, sev_guest_init() leaves kvm->arch.vm_type set to
KVM_X86_DEFAULT_VM, so kvm_arch_gmem_link_allowed() treats legacy SEV/SEV-ES
VMs and non-SEV default VMs as having the same vm_type.

Should kvm_arch_gmem_link_allowed() disallow linking when either VM is a
confidential VM (or only allow KVM_X86_DEFAULT_VM without SEV enabled)?

> diff --git a/virt/kvm/guest_memfd.c b/virt/kvm/guest_memfd.c
> index 3ca6f64d48040..54b11747a8c48 100644
> --- a/virt/kvm/guest_memfd.c
> +++ b/virt/kvm/guest_memfd.c
[ ... ]
> @@ -970,7 +979,10 @@ static struct file *kvm_gmem_alloc_file(struct kvm *=
kvm, struct inode *inode,
>  	kvm_get_kvm(kvm);
>  	f->kvm =3D kvm;
>  	xa_init(&f->bindings);
> +
> +	filemap_invalidate_lock(inode->i_mapping);
>  	list_add(&f->entry, &GMEM_I(inode)->gmem_file_list);
> +	filemap_invalidate_unlock(inode->i_mapping);
> =20
>  	return file;
>  }
> @@ -1026,6 +1038,77 @@ int kvm_gmem_create(struct kvm *kvm, struct kvm_cr=
eate_guest_memfd *args)
>  	return __kvm_gmem_create(kvm, size, flags);
>  }
> =20
> +int kvm_gmem_link(struct kvm *kvm, struct kvm_link_guest_memfd *args)
> +{
[ ... ]
> +	ret =3D -EINVAL;
> +	if (src_file->f_op !=3D &kvm_gmem_fops)
> +		goto out;
> +
> +	/* Cannot link a gmem file with the same VM again. */
> +	gmem =3D src_file->private_data;
> +	if (gmem->kvm =3D=3D kvm)
> +		goto out;
> +
> +	if (!kvm_arch_gmem_link_allowed(kvm, gmem->kvm))
> +		goto out;
> +
> +	fd =3D get_unused_fd_flags(0);
> +	if (fd < 0) {
> +		ret =3D fd;
> +		goto out;
> +	}
> +
> +	inode =3D file_inode(src_file);
> +	ihold(inode);
> +
> +	dst_file =3D kvm_gmem_alloc_file(kvm, inode, name);
> +	if (IS_ERR(dst_file)) {
> +		iput(inode);
> +		ret =3D PTR_ERR(dst_file);
> +		goto out_fd;
> +	}

[Severity: High]
Can kvm_gmem_link() still link the same guest_memfd inode to the same VM
multiple times?

In kvm_gmem_link(), the check only verifies whether src_file's immediate
gmem_file->kvm matches the target kvm, and does so without holding
filemap_invalidate_lock(inode->i_mapping).

If userspace creates fd1 on VM1 and links fd1 to VM2 (producing fd2), it can
then:
1. Call KVM_LINK_GUEST_MEMFD(fd1) on VM2 a second time,
2. Call KVM_LINK_GUEST_MEMFD(fd2) back onto VM1, or
3. Call KVM_LINK_GUEST_MEMFD(fd1) concurrently from two threads on VM2.

In all three cases, gmem->kvm =3D=3D kvm is false, so kvm_gmem_alloc_file()
inserts a second struct gmem_file for the same struct kvm onto
GMEM_I(inode)->gmem_file_list.

Having multiple struct gmem_file instances for the same VM on the same inode
breaks two assumptions elsewhere in guest_memfd.c:

First, kvm_gmem_commit_memory_region() only checks f->bindings on the single
gmem_file being bound:

virt/kvm/guest_memfd.c:kvm_gmem_commit_memory_region() {
	if (!xa_empty(&f->bindings) &&
	    xa_find(&f->bindings, &start, end - 1, XA_PRESENT)) {
		filemap_invalidate_unlock(inode->i_mapping);
		return -EEXIST;
	}
}

With two gmem_file fds for the same VM and inode, a single VM can bind two
memslots at different GPAs to the exact same pgoff range of the same
guest_memfd inode.

Second, kvm_gmem_invalidate_start() iterates over gmem_file_list and calls
__kvm_gmem_invalidate_start() per gmem_file, which acquires and releases
KVM_MMU_LOCK(kvm) per gmem_file while mmu_invalidate_in_progress is active.

Should GMEM_I(inode)->gmem_file_list be walked while holding
filemap_invalidate_lock(inode->i_mapping) to reject any link where an entry
with f->kvm =3D=3D kvm already exists on the inode?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261026064424.3003=
536-1-gongtao@google.com?part=3D2
