Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793202524;
	b=nVdvb/BpPI5RGqUwwn/ol3K2F+1KVtMmep1PgvVbbomlRgNMVtfLrL8XxVBQKXqiDGdH
	 IRZQLZ2HKjaxweU+U1ixQ9le0u/XNG1vWLymHHN4ZAG+Kqwe/2H1YKzoS3BcGLeePsfha
	 Q2zNG8mZQNeaTwKiaxgYZSjeUx8oTvJmBIKKygfHt7fj5zgrZ3WHJzNDVMubGZn3FdUm0
	 8m+O6BHcak+aQq1k8j67xryJDz76S848q6wRgVqZmuRk/KmbkQ3e1eJeWcgiMgTnlK9Jk
	 Vf6GBSfpFmq9rhceX4l/A7aAdQ0srYzmqV3FtEcmexW1n9Lo/dj1by6BvQAS3++cnAQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793202524;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=WB+g+Slbuqa3OAFsR/L9R+koPQb3pE6dF2HAbJEZAnQ=;
	b=Qg1irVnKG+sJ6CuwIuYWNGk0yMvd/cI4XBcE027MC7HCBDRh9641uQW8Jf4KQUcSAWka
	 AA7ja7k29x2NFwLSlOqodNgzcaoZrhKboz1uATud0nMGl0gn3FD+uJDUZJYChCnpvHKZR
	 Csdcri+lfmdSXW6goZvRRtyFeWhHD8TGniOussX216Gf4KBN+prlNPatXrqFsnhZd56cC
	 wSCI4Xcpi1L8fvkVZlxF5zuuWx24UkDoF6g9sCiWLnolMB9UsVnNP0inXld0/neHzWtAj
	 zuv+QliJxR+y2/8GSO3WBoT9LsqX1STiXql/uFj5fd+gozvJLblqsjJRNO0rcIBWUKQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=UcB6K23C;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05ACA606A758
	for <kvm@vger.kernel.org>; Wed, 28 Oct 2026 15:48:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=UcB6K23C
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7C9361F01825;
	Wed, 28 Oct 2026 15:48:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793202523;
	bh=WB+g+Slbuqa3OAFsR/L9R+koPQb3pE6dF2HAbJEZAnQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=UcB6K23CVpLO8P10LHZqJX9STIGFLjDAkR4Z2JOHlTMmVdxlQK1gQFGZQ5YZBKNrZ
	 GCsvWHVAJt+/YfJhux+cVn7zLG+hYDgRYSKLht5Wy39cUp1bY8FnS1rkxBXKggmW8+
	 ufYcdx0lrb8+8W3bM0Qz7iQFN2vFi3ms6sG7ySHH64j2eNEbU+T7CJ89yGdVAicFMu
	 qbdNAjTCJ7yV9IkMmA1VBtbHgsF9ghrif1/gRYoJ94Nsr6G+WmcxfYKJVRKLLRpFCM
	 MKLDmU9vUZGGP+Ixtq08YhHNec4bMivEO9QLU5mxPymN0FAqYuIFd6FmhSNn64j3WN
	 +q/asZnjvgo5Q==
Message-ID: <sashiko-outbox-188089@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH 07/14] KVM: guest_memfd: Update exports when pages
 are allocated
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
In-Reply-To: <20261027154649.91571-8-griffoul@gmail.com>
References: <20261022-gmem-alternative-providers-v2-0-5dd1dc6c660a@google.com>
 <20261027154649.91571-1-griffoul@gmail.com>
 <20261027154649.91571-8-griffoul@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 28 Oct 2026 15:48:40 +0000
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
- [High] KVM: guest_memfd: race between lookup and export update in kvm_gme=
m_pfn_get()
- [High] KVM: guest_memfd: missing export update in kvm_gmem_pfn_mkwrite()
--

commit 4b6454858c8ba7cdab87cd12917c8977ac8eab47
Author: Fred Griffoul <fgriffo@amazon.co.uk>

KVM: guest_memfd: Update exports when pages are allocated

This commit updates attached exports when guest_memfd pages gain backing
memory via host faults, KVM get_pfn(), or fallocate(). In folio mode it
zeroes newly allocated folios, marks them dirty, and notifies exports under
the invalidate lock, while in PFN mode it checks if the page was a hole
before get_pfn() and updates exports for the populated block.

> diff --git a/virt/kvm/guest_memfd.c b/virt/kvm/guest_memfd.c
> index 1c5826c5384ed..42bb5f263e234 100644
> --- a/virt/kvm/guest_memfd.c
> +++ b/virt/kvm/guest_memfd.c
[ ... ]
> @@ -590,6 +592,64 @@ int kvm_gmem_revoke(struct inode *inode, pgoff_t sta=
rt, size_t nr_pages,
>  }
>  EXPORT_SYMBOL_GPL(kvm_gmem_revoke);
> =20
[ ... ]
> +/*
> + * get_pfn() in PFN mode, which may back a hole: then tell the exports a=
bout
> + * the whole block that get_pfn() reports, as the provider may have back=
ed all
> + * of it.  Called with the invalidate lock held.
> + */
> +static int kvm_gmem_pfn_get(struct inode *inode, pgoff_t index,
> +			    kvm_pfn_t *pfn, int *max_order, u32 *attrs)
> +{
> +	pgoff_t npages =3D i_size_read(inode) >> PAGE_SHIFT;
> +	struct gmem_inode *gi =3D GMEM_I(inode);
> +	bool hole =3D false;
> +	unsigned long raw;
> +	pgoff_t first;
> +	int order, r;
> +	size_t nr;
> +
> +	if (!list_empty(&gi->exports))
> +		hole =3D gi->provider_ops->lookup_pfn_range(gi->provider, index,
> +							  &raw, &nr) =3D=3D -ENOENT;
> +
> +	r =3D gmem_provider_get_pfn(gi, index, pfn, &order, attrs);
> +	if (r)
> +		return r;
> +
> +	if (hole) {
> +		first =3D round_down(index, 1UL << order);
> +		kvm_gmem_update_exports(inode, first,
> +					min(first + (1UL << order), npages));
> +	}
> +	if (max_order)
> +		*max_order =3D order;
> +	return 0;
> +}

[Severity: High]
Can concurrent calls to kvm_gmem_pfn_get() race between lookup_pfn_range(),
gmem_provider_get_pfn(), and kvm_gmem_update_exports()?

All shared-access callers of kvm_gmem_pfn_get() -- kvm_gmem_allocate(),
kvm_gmem_pfn_fault(), and kvm_gmem_get_pfn() -> __kvm_gmem_get_pfn() -- hold
inode->i_mapping->invalidate_lock in shared mode via
filemap_invalidate_lock_shared(). Unlike folio mode, where
kvm_gmem_get_folio() returns a locked folio and holds the folio lock across
both kvm_gmem_folio_zero() and kvm_gmem_update_exports(), kvm_gmem_pfn_get()
has no per-range synchronization across the lookup, allocation, and export
notification steps.

If thread A calls kvm_gmem_pfn_get() on an unbacked index,
lookup_pfn_range() returns -ENOENT (setting hole =3D true) and
gmem_provider_get_pfn() populates the backing frame or 1UL << order block in
the provider. If a concurrent thread B calls kvm_gmem_pfn_get() for the same
index (or another index within that newly populated block) after thread A's
gmem_provider_get_pfn() completes, but before thread A finishes
kvm_gmem_update_exports(), thread B will see lookup_pfn_range() =3D=3D 0
(hole =3D false), skip kvm_gmem_update_exports(), and return to fallocate(),
the host fault handler, or the guest vCPU fault handler while the export's
IOMMU mapping is not yet installed.

Conversely, if both thread A and thread B call lookup_pfn_range() before
either thread's gmem_provider_get_pfn() populates the block, both observe
hole =3D true. After thread A finishes kvm_gmem_update_exports() and returns
the mapped page to userspace or the guest (which may immediately start DMA),
thread B will run a second kvm_gmem_update_exports() on the same block,
causing export consumers such as iommufd to unmap and tear down the live
IOMMU mapping.

[ ... ]
> @@ -819,7 +881,7 @@ static vm_fault_t kvm_gmem_pfn_fault(struct vm_fault =
*vmf)
>  	u32 attrs;
>  	int r;
> =20
> -	r =3D gmem_provider_get_pfn(GMEM_I(inode), vmf->pgoff, &pfn, NULL, &att=
rs);
> +	r =3D kvm_gmem_pfn_get(inode, vmf->pgoff, &pfn, NULL, &attrs);
>  	if (r)
>  		return vmf_error(r);

[Severity: High]
Should kvm_gmem_pfn_mkwrite() also call kvm_gmem_pfn_get() instead of
gmem_provider_get_pfn()?

In virt/kvm/guest_memfd.c, kvm_gmem_pfn_mkwrite() still calls
gmem_provider_get_pfn() directly:

static vm_fault_t kvm_gmem_pfn_mkwrite(struct vm_fault *vmf)
{
	struct inode *inode =3D file_inode(vmf->vma->vm_file);
	vm_fault_t ret =3D 0;
	kvm_pfn_t pfn;
	u32 attrs;
	int r;

	filemap_invalidate_lock_shared(inode->i_mapping);
	r =3D gmem_provider_get_pfn(GMEM_I(inode), vmf->pgoff, &pfn, NULL, &attrs);
	...

When userspace writes to a present read-only PTE in a shared VM_PFNMAP VMA,
handle_pte_fault() -> do_wp_page() -> wp_pfn_shared() drops the PTE lock via
pte_unmap_unlock() before invoking vma->vm_ops->pfn_mkwrite(vmf):

mm/memory.c:wp_pfn_shared() {
	...
	pte_unmap_unlock(vmf->pte, vmf->ptl);
	ret =3D vmf_can_call_fault(vmf);
	if (ret)
		return ret;

	vmf->flags |=3D FAULT_FLAG_MKWRITE;
	ret =3D vma->vm_ops->pfn_mkwrite(vmf);
	if (ret & (VM_FAULT_ERROR | VM_FAULT_NOPAGE))
		return ret;
	return finish_mkwrite_fault(vmf, NULL);
}

In the window before kvm_gmem_pfn_mkwrite() acquires
filemap_invalidate_lock_shared(), a concurrent hole punch via
kvm_gmem_punch_hole() -> __kvm_gmem_revoke() can acquire the invalidate lock
exclusively, unmap the PTE, notify exports to unmap the hole, and release
the backing frame in the provider.

When kvm_gmem_pfn_mkwrite() then acquires the shared invalidate lock and
calls gmem_provider_get_pfn(), the provider allocates a new frame for the
hole without calling kvm_gmem_update_exports(). Afterwards,
finish_mkwrite_fault() sees that the PTE was cleared and retries the fault
through kvm_gmem_fault_user_mapping() -> kvm_gmem_pfn_fault() ->
kvm_gmem_pfn_get(), where lookup_pfn_range() finds the frame already
allocated by kvm_gmem_pfn_mkwrite() and sets hole =3D false, leaving the
export unmapped.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261027154649.9157=
1-1-griffoul@gmail.com?part=3D7
