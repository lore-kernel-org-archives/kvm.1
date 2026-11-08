Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794098682;
	b=2uIG2T2t/LQQJjY7nkxQjTkffLb46CnhgEdgBEQsK6eKQy+MwIKBq9mt5jkeLaO89PMg
	 eW2lgSPmXB+07X2VTwCItJryoEEdHKActnfMUP/E847hObSnicBLfNWfbp2XuhsxGoS8m
	 VbpjaersxacYeHVtK1CN1F7L2SE/VpjFlUz2HAEM5vKGXBA2wbcrDF6G1KSgbp9/t9ul5
	 nKak4EwdK9ZVv+WeIMeswmT3Ex0LBgXFPyNLVNg1NmuNs1TM7ZUuBY5agUE48ocWQzTdb
	 itXH4EfD5QmZjZKhVbNp95dZxaC47oGvsdlmf66+gMeBuvVPQA1//ymlugr6VowcL9w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794098682;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=fR9Re5ZDd5XTnUKoH8w65OpXbdqyo213h0gpni69V6U=;
	b=aSqolHSgaYuhHmNGCyk/h3NP9i10z35qwvyNABKkCCB4xKxHtjBjXnmBNenw5DBg71bu
	 4ZPFThCjHF7zC8T1RoTKPHoNLOHYt2iLiOxlNzFRnlwsuA4eY6L2rxSQRiVbsJmFnHDNK
	 9L2oC3bir2bmTFEyx0uZMgCu31g+uEw6HhQhSJLdX6bOQoQcXJiMia+kqlrbyL9pZLGyG
	 DMx7kYow0A8xFBdrSIuomSljj2jhuG+fZTISRTits6jcihSOeo/cn/y6vN7+yPF15LTby
	 ilm0NeQA3jTKRvazzOLLk22504CZhuJqfPt+O62Yoq7Gu1uR4cx/numTYcymE1jeRaA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=agTlvQRc;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98DB5606A32F
	for <kvm@vger.kernel.org>; Sun,  8 Nov 2026 00:44:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=agTlvQRc
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9E2ED1F008A3;
	Sun,  8 Nov 2026 00:44:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794098682;
	bh=fR9Re5ZDd5XTnUKoH8w65OpXbdqyo213h0gpni69V6U=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=agTlvQRcexnHXTDYph5CQU33CYyOD/euPr8we+Ch/yQO1DVAXHt/3jJxWbOuIukPX
	 YQrdOFz7Md5fELSDZOfOoy7N2zIl7ETEqkKXrQzG24mdwrSSAi9ojfzvFErRc9zNUJ
	 kPNCRKB4b1TbtcSId5IvKYcV1gyt72SuDZN9d3jEm3Z3/bNmhmHksnvpC0nw7AH7X1
	 zjAMdGWgUoAkcs17c3MEyWPOWNbCTAucnxnFsNj/gwg6dCCmFrvXAnN4bof9xuzcm5
	 CzLXvBmar9533rGI/jlnUR0u+cEZOf3J3AOcPtmnbJ6yGWiG5edbdhZkWMKtBQrhuh
	 lonp0zyOeKKRg==
Message-ID: <sashiko-outbox-203498@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH RFC v3 87/88] QUESTION: KVM: guest_memfd: Disallow
 private mappings of shared-only PFNs
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ackerley Tng" <ackerleytng@google.com>, "Alexey Kardashevskiy" <aik@amd.com>, "Aneesh
 Kumar K.V" <aneesh.kumar@kernel.org>, "Christian Brauner" <brauner@kernel.org>, "David
 Hildenbrand" <david@kernel.org>, "David Woodhouse" <dwmw2@infradead.org>, "Fred
 Griffoul" <fgriffo@amazon.co.uk>, "Jacob Pan" <jacob.pan@linux.microsoft.com>, "Jianxiong
 Gao" <jxgao@google.com>, "John Starks" <John.Starks@microsoft.com>, "Michael
 Roth" <michael.roth@amd.com>, "Paolo Bonzini" <pbonzini@redhat.com>, "Samiullah
 Khawaja" <skhawaja@google.com>, "Sean Christopherson" <seanjc@google.com>, "Suzuki
 K Poulose" <suzuki.poulose@arm.com>, "Tarun Sahu" <tarunsahu@google.com>, "Vishal
 Annapurve" <vannapurve@google.com>, "Xu Yilun" <yilun.xu@linux.intel.com>, "Fuad
 Tabba" <fuad.tabba@linux.dev>
Cc: kvm@vger.kernel.org, linux-mm@kvack.org
In-Reply-To: <20261106-gmem-alternative-providers-v3-87-8484dde66a7e@google.com>
References: <20261106-gmem-alternative-providers-v3-0-8484dde66a7e@google.com>
 <20261106-gmem-alternative-providers-v3-87-8484dde66a7e@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 08 Nov 2026 00:44:41 +0000
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 1 potential
issue to consider:
- [Medium] KVM: guest_memfd: private attribute on MSI-X BAR page blocks
  VMM MMIO access
--

commit e4385565a5ed77222308f8b663cc4c2b0a672e04
Author: Ackerley Tng <ackerleytng@google.com>

QUESTION: KVM: guest_memfd: Disallow private mappings of shared-only PFNs

This commit replaces the check_set_attributes provider callback with the
GUEST_MEMFD_PFN_ATTRS_NO_PRIVATE PFN attribute so that VFIO PCI MSI-X
pages are blocked from private stage-2 mappings and population at fault
time rather than during attribute conversion.

> diff --git a/virt/kvm/guest_memfd.c b/virt/kvm/guest_memfd.c
> index 385b517b49ed5..cd484bdcb3f0c 100644
> --- a/virt/kvm/guest_memfd.c
> +++ b/virt/kvm/guest_memfd.c
[ ... ]
> @@ -1128,12 +1118,6 @@ static int __kvm_gmem_set_attributes(struct inode =
*inode, pgoff_t start,
>  	if (kvm_gmem_range_has_attributes(inode, start, nr_pages, attrs))
>  		goto out;
> =20
> -	r =3D gmem_provider_check_set_attributes(gi, start, nr_pages, attrs);
> -	if (r) {
> -		*err_index =3D start;
> -		goto out;
> -	}
> -
>  	mas_init(&mas, mt, start);
>  	r =3D kvm_gmem_mas_preallocate(&mas, attrs, start, nr_pages);
>  	if (r) {
> @@ -1774,10 +1758,11 @@ int kvm_gmem_get_pfn(struct kvm *kvm, struct kvm_=
memory_slot *slot,
> =20
>  	/*
>  	 * Private memory requires exclusive, writable guest ownership and
> -	 * cannot be backed by a read-only frame.
> +	 * cannot be backed by a read-only or shared-only frame.
>  	 */
>  	if (kvm_gmem_is_private_mem(file_inode(file), index) &&
> -	    (*pfn_attrs & GUEST_MEMFD_PFN_ATTRS_READONLY)) {
> +	    (*pfn_attrs & (GUEST_MEMFD_PFN_ATTRS_READONLY |
> +			   GUEST_MEMFD_PFN_ATTRS_NO_PRIVATE))) {
>  		r =3D -EFAULT;
>  		goto out_put_folio;
>  	}

[Severity: Medium]
If userspace converts an entire BAR to KVM_MEMORY_ATTRIBUTE_PRIVATE
without carving out the MSI-X range, does that block the VMM from
accessing the MSI-X Pending Bit Array or other device registers sharing
the MSI-X page?

When a VFIO PCI device is attached to guest_memfd, it is bound with
VFIO_DEVICE_BIND_FLAG_CTRL_ONLY, which rejects direct mmap(), pread(), and
pwrite() on the VFIO device fd for mappable BARs.  Once
__kvm_gmem_set_attributes() marks the MSI-X page private in
gi->attributes, guest stage-2 faults are rejected here with -EFAULT, while
host VMM accesses through guest_memfd are also rejected because both
kvm_gmem_fault_user_mapping() and kvm_gmem_rw() require the page's
software attribute to be shared:

virt/kvm/guest_memfd.c:kvm_gmem_fault_user_mapping() {
    ...
	if (!kvm_gmem_is_shared_mem(inode, vmf->pgoff)) {
		r =3D -EACCES;
    ...
}

virt/kvm/guest_memfd.c:kvm_gmem_rw() {
    ...
		if (!kvm_gmem_range_has_attributes(inode, start, nr_pages, 0)) {
			filemap_invalidate_unlock_shared(inode->i_mapping);
			return total_done ?: -EFAULT;
		}
    ...
}

As a result, even if the VMM places a memslot hole over the MSI-X range to
trap guest MMIO accesses, it has no way to read or write co-located
registers on that page unless the MSI-X range is kept shared in
gi->attributes.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261106-gmem-alter=
native-providers-v3-0-8484dde66a7e@google.com?part=3D87
