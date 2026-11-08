Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794098657;
	b=nPL/mV+fkm6kjmBKXhWgVfsvCHe3BH6jQkyf71BQ8pIGeIiEduDwTLbo5XuriMsScAcA
	 0IisbAXHf9I8KaJFiTLiXWsTZNj9iA55ZnDCDq95l9VozRROlnJ066QFwKD8UKqND+49r
	 wrA0ErG6zU4Mk1S7RIk9ZMatTLX5LveMrF6fZeCEiI1zxhUsE+PE9zPK8souLqnogieu+
	 b5aZACEQGzPAvMnGav4dTJr5mOIA/rbo2JzFraL00jqpcknaiUKFqMCiu4vz3UDKO03Vf
	 xlYan2xwg+DSSxRXHiESCuzjkUyM8YJ9cuBwIlOoY6Hx/amuoHZta3ksuafjCoTmM7A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794098657;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=E2KkAkl+NVXgKCoi6ASrSyMiMBJsAg9qAqcOWsd3wPc=;
	b=eFkK6AuGDnjRjURHAS2VMIkbBTOY/r3WJVx0LK22/rq4tUk8PwD1xeW3+e7bXVc+QHkb
	 7tjkBlbhdMhTLkHzMPmrLzJjEHCIlgjdjmbnyzccvOICl8SNW1mc0R9N9c8SPLodE9SiL
	 K92N65YAw6D6PzU7uivZPTEEmdI9jImfsp+OySJVYPF6msXUyQ+M1UQtBMLF6g+eVmoP2
	 adPobqoT/FbBPscWISCCr4ucL8hNt9lSm68/6x+k+3cOly1t82EaJnFfdmXmHN0iyyipc
	 dnNUp+lr1Pi5QpM9IOrOtBHgo5H+5KzIZew0Oq7QxS+WqRShib6XQCH/tbI/PMQ6UPA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=dTOLwSAe;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90202606D805
	for <kvm@vger.kernel.org>; Sun,  8 Nov 2026 00:44:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=dTOLwSAe
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7CA5A1F0089F;
	Sun,  8 Nov 2026 00:44:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794098657;
	bh=E2KkAkl+NVXgKCoi6ASrSyMiMBJsAg9qAqcOWsd3wPc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=dTOLwSAe863MLpQUUIkQs8ypUGkcYK+RmsQ/BE3MMWEdMJ9OYE/N4y2a9eUnSkGnm
	 Hso3tWqgC2naZDdhCsnQl1oJwtQJm+Oq80m3g35fDkMEShYkO9dcV3mvV4ds9pJCd7
	 bBDI7Q7EB+BweD6YuF+YXBAc6R4bduoHAHxqKPbz4qdBHE27UfxGVlnAMZqnMo1OVE
	 UAj02ppuG/SGwOOadPm72t6deY+5DYDrSILya4ZyKsUno30YYkWJioRzS7c+uWrtHJ
	 t1u4yRDCJcBnZ1bpb0wQym6IiyEMILfTwPP5Ii22DZDKmD+7Bv6HsZBxhnLypf4FVI
	 EhMdtF+GPGNOg==
Message-ID: <sashiko-outbox-203463@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH RFC v3 52/88] KVM: guest_memfd: Support mmap provider
 operation
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
In-Reply-To: <20261106-gmem-alternative-providers-v3-52-8484dde66a7e@google.com>
References: <20261106-gmem-alternative-providers-v3-0-8484dde66a7e@google.com>
 <20261106-gmem-alternative-providers-v3-52-8484dde66a7e@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 08 Nov 2026 00:44:16 +0000
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 3 potential
issues to consider:
- [High] KVM: guest_memfd: gmem_insert_pfn() discards provider mmap
  vm_page_prot
- [Low] KVM: guest_memfd: duplicate @mmap kernel-doc in
  guest_memfd_provider_operations
- [Low] KVM: guest_memfd: missing vm_area_struct forward declaration in
  guest_memfd.h
--

commit 649219a71c7e85644f581e90c9dd003891e92c1c
Author: Ackerley Tng <ackerleytng@google.com>

KVM: guest_memfd: Support mmap provider operation

This commit adds an optional .mmap callback to struct
guest_memfd_provider_operations and invokes it from kvm_gmem_mmap() so
memory providers can customize VMA setup when userspace maps a
guest_memfd file.

> diff --git a/include/linux/guest_memfd.h b/include/linux/guest_memfd.h
> index 8cdc334d1c9aa..a2af279cd3c34 100644
> --- a/include/linux/guest_memfd.h
> +++ b/include/linux/guest_memfd.h
> @@ -85,6 +85,9 @@ static inline bool kvm_gmem_pfn_is_cacheable(u64 pfn_at=
trs)
>   *                 available, the provider should skip the unbacked rang=
e. Not
>   *                 called on kvm_gmem_revoke(). Do not take locks held a=
cross
>   *                 kvm_gmem_revoke().
> + * @mmap: Optional callback to set up user mappings. Called when userspa=
ce calls
> + *        mmap() on guest_memfd. The provider can customize VMA flags, o=
r reject
> + *        the mapping.

[Severity: Low]
Does this add a duplicate @mmap entry to the kernel-doc comment for
struct guest_memfd_provider_operations?

Earlier in the series, commit "KVM: guest_memfd: Export kvm_gmem_revoke
for provider-driven revocation" already added an @mmap description to
this comment block (right after @get_pfn), so scripts/kernel-doc will
warn about a duplicate section name.

>   *
>   * Used by filesystems and device drivers that provide memory for guest_=
memfd.
>   */
> @@ -99,6 +102,7 @@ struct guest_memfd_provider_operations {
>  	int (*lookup_pfn_range)(void *provider, pgoff_t index,
>  				unsigned long *pfn, size_t *nr_pages);
>  	void (*put_pfn_range)(void *provider, pgoff_t index, size_t nr_pages);
> +	int (*mmap)(void *provider, struct vm_area_struct *vma);
>  };

[Severity: Low]
Should include/linux/guest_memfd.h also forward-declare struct
vm_area_struct alongside struct file, struct folio, struct inode, and
struct mempolicy?

Without a prior file-scope declaration, a translation unit that includes
linux/guest_memfd.h before struct vm_area_struct is declared will scope
the incomplete type to the parameter list of .mmap and trigger a
-Wvisibility warning.

> diff --git a/virt/kvm/guest_memfd.c b/virt/kvm/guest_memfd.c
> index 1fbb719f0e31f..ec908419e5faa 100644
> --- a/virt/kvm/guest_memfd.c
> +++ b/virt/kvm/guest_memfd.c
[ ... ]
> @@ -869,6 +878,10 @@ static int kvm_gmem_mmap(struct file *file, struct v=
m_area_struct *vma)
>  		return -EINVAL;
>  	}
> =20
> +	ret =3D gmem_provider_mmap(gi, vma);
> +	if (ret)
> +		return ret;
> +
>  	if (kvm_gmem_is_pfn_mode(gi))
>  		vm_flags_set(vma, VM_PFNMAP);

[Severity: High]
When a PFN-mode provider customizes vma->vm_page_prot in its .mmap
callback (such as vfio_pci_core_mmap() setting pgprot_noncached() and
pgprot_decrypted() in commit "vfio: Implement mmap provider op for
guest_memfd"), does gmem_insert_pfn() discard those protection bits on
fault?

virt/kvm/guest_memfd.c:gmem_insert_pfn() {
	...
	return vmf_insert_pfn_prot(vma, vmf->address, pfn,
				   vm_get_page_prot(flags));
}

gmem_insert_pfn() recomputes the page protection from scratch via
vm_get_page_prot(flags) instead of preserving the provider's attributes
in vma->vm_page_prot.  On arm64 (which does not select
__HAVE_PFNMAP_TRACKING, making pfnmap_setup_cachemode_pfn() a no-op),
device MMIO BARs will be mapped into host userspace as write-back normal
memory instead of device memory, and on x86 hosts with memory encryption
enabled, vm_get_page_prot(flags) will re-set the encryption bit and drop
pgprot_decrypted().

Deriving the fault protection with pgprot_modify(vma->vm_page_prot,
vm_get_page_prot(flags)) would preserve the provider's vma->vm_page_prot
customizations while still clearing VM_WRITE on read-only PFNs.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261106-gmem-alter=
native-providers-v3-0-8484dde66a7e@google.com?part=3D52
