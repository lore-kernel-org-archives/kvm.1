Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D440449B35
	for <kvm@vger.kernel.org>; Fri, 31 Jul 2026 17:04:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785517450; cv=none; b=FGzs+aOrCRBSRLL3KO2cFLFqB8Mda3TqRBo1abLz7McIQLnhivZc1Cn/fytumCAwlRLM9YhlL/4Qt0jjPq7lz0KWtuV7uKTaak0FXHbAzm452NMeiqIUU1X3x18p1fLqZb/q5OCU6Iqom3iFhjWEzv4YE/hmzilzbB7fAPF8s24=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785517450; c=relaxed/simple;
	bh=HJPTMsAqjP/0tTcXCwYfAu02jDZ/s2Ve0GAy+YBcsYM=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Ag/QArHIqFPoPAUMCNL7Y221lwZIWV9U65C3iM/Sn2pv/BZMRE7Sl2C1n3uSxYKJhH/u4rQa65+/tc435KXE0Hc6gJAHIRHQAXLPBpLVJxt2LrjEJ39FCjTg1xWb3llolmbdbiXFsiofTceVr5Lel5xvB1H5nCdm8Pv9t3GdXVA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ML/MPAUM; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ML/MPAUM"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A6E2C1F00AC4;
	Fri, 31 Jul 2026 17:04:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785517448;
	bh=48slKgHxjiAkfEQfYx65c/7xMAQDGWLUjtrIdsOu1dw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ML/MPAUM2AYPpCalDK5VfltaJg6OyaXnY4hKBlrF8KO41oCtsxMkJjXWKW/BGMUcj
	 tFc+Yk1Zr6ytBldnBLYQSA55Y1beyGCxnXf+bYXAZ51KnXVznzwTkjWDhXw91VrYfl
	 aIHAY080H8Ekzmd4lsvhoQY0/wtZaqJpISJNXuCgWlrIFBcoB40nLMEACAqkpjjeEv
	 QddBHjkw8ukDOxTjocd6mdPSXbxvDGL2WGhJ97mFG+bgaGiMQK4py5GI2QWbib7JbB
	 v6dZuZPj9tGbVDSgWXO9sehJnRz4w8DfqfuFAQ64BUrJQSBBrcr1PDF7qb0ftGdQdl
	 naUQkasYhXfcg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH RFT 3/3] drm/ttm, drm/vmwgfx: directly create writable
 PTEs when mkwrite is in use
Reply-To: sashiko-reviews@lists.linux.dev
To: "Paolo Bonzini" <pbonzini@redhat.com>
Cc: dri-devel@lists.freedesktop.org, kvm@vger.kernel.org
In-Reply-To: <20260731164341.1109827-4-pbonzini@redhat.com>
References: <20260731164341.1109827-1-pbonzini@redhat.com>
 <20260731164341.1109827-4-pbonzini@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 31 Jul 2026 17:04:08 +0000
Message-Id: <20260731170408.A6E2C1F00AC4@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

Pre-existing issues:
- [Critical] The dirty tracking structure `vbo->dirty` can be freed concurr=
ently by `vmw_bo_dirty_release()` without holding the buffer object's reser=
vation lock, causing a use-after-free in `vmw_bo_dirty_mkwrite()`.
- [High] Inverted error handling in ttm_bo_vm_fault_reserved masks primary =
fault errors (causing infinite page fault loops) and erroneously surfaces s=
peculative prefault errors.
--

--- Patch [3]: [PATCH RFT 3/3] drm/ttm, drm/vmwgfx: directly create writabl=
e PTEs when mkwrite is in use ---
commit 894d8cfbec765789074f38bcd9f120fdcf49cba5
Author: Paolo Bonzini <pbonzini@redhat.com>

drm/ttm, drm/vmwgfx: directly create writable PTEs when mkwrite is in use

This commit changes the fault handler to directly insert writable PTEs for =
the
first page when write access is requested. It achieves this by manually
recording the write fault instead of relying on the .pfn_mkwrite() callback.

> diff --git a/drivers/gpu/drm/ttm/ttm_bo_vm.c b/drivers/gpu/drm/ttm/ttm_bo=
_vm.c
> index a80510489c456..ef27a2d7afc07 100644
> --- a/drivers/gpu/drm/ttm/ttm_bo_vm.c
> +++ b/drivers/gpu/drm/ttm/ttm_bo_vm.c
> @@ -263,7 +263,8 @@ vm_fault_t ttm_bo_vm_fault_reserved(struct vm_fault *=
vmf,
>  		 * at arbitrary times while the data is mmap'ed.
>  		 * See vmf_insert_pfn_prot() for a discussion.
>  		 */
> -		ret =3D vmf_insert_pfn_prot(vma, address, pfn, prot);
> +		ret =3D __vmf_insert_pfn_prot(vma, address, pfn, prot,
> +					    i =3D=3D 0 && !!(vmf->flags & FAULT_FLAG_WRITE));
> =20
>  		/* Never error on prefaulted PTEs */
>  		if (unlikely((ret & VM_FAULT_ERROR))) {
>  			if (i =3D=3D 0)
>  				return VM_FAULT_NOPAGE;
>  			else
>  				break;
>  		}

[Severity: High]
This is a pre-existing issue, but could this error handling in
ttm_bo_vm_fault_reserved() lead to infinite page fault loops or unwarranted
SIGBUS crashes?

If __vmf_insert_pfn_prot() returns an error like VM_FAULT_SIGBUS or
VM_FAULT_OOM, and it is the primary fault (i =3D=3D 0), this block returns
VM_FAULT_NOPAGE (success). Does this cause the kernel to infinitely retry
the faulting instruction?=20

Also, if it is a speculative prefault (i > 0), the loop breaks and returns
the prefault error, crashing the application even though the primary fault
succeeded. Is this the intended behavior?

[ ... ]

> diff --git a/drivers/gpu/drm/vmwgfx/vmwgfx_page_dirty.c b/drivers/gpu/drm=
/vmwgfx/vmwgfx_page_dirty.c
> index 45561bc1c9eff..3099558c0762f 100644
> --- a/drivers/gpu/drm/vmwgfx/vmwgfx_page_dirty.c
> +++ b/drivers/gpu/drm/vmwgfx/vmwgfx_page_dirty.c
> @@ -398,15 +398,33 @@ void vmw_bo_dirty_clear_res(struct vmw_resource *re=
s)
>  		dirty->end =3D res_start;
>  }
> =20
> +static vm_fault_t vmw_bo_dirty_mkwrite(struct vm_fault *vmf, struct ttm_=
buffer_object *bo)
> +{
> +	unsigned long page_offset;
> +	struct vmw_bo *vbo =3D to_vmw_bo(&bo->base);
> +
> +	page_offset =3D vmf->pgoff - drm_vma_node_start(&bo->base.vma_node);
> +	if (unlikely(page_offset >=3D PFN_UP(bo->resource->size)))
> +		return VM_FAULT_SIGBUS;
> +
> +	if (vbo->dirty && vbo->dirty->method =3D=3D VMW_BO_DIRTY_MKWRITE &&
> +	    !test_bit(page_offset, &vbo->dirty->bitmap[0])) {
> +		struct vmw_bo_dirty *dirty =3D vbo->dirty;
> +
> +		__set_bit(page_offset, &dirty->bitmap[0]);
> +		dirty->start =3D min(dirty->start, page_offset);
> +		dirty->end =3D max(dirty->end, page_offset + 1);
> +	}

[Severity: Critical]
This isn't a bug introduced by this patch, but is it possible for vbo->dirty
to be freed concurrently without holding the buffer object's reservation lo=
ck?

If user space destroys the framebuffer, vmw_bo_dirty_release() is called,
which modifies and frees vbo->dirty:

void vmw_bo_dirty_release(struct vmw_bo *vbo)
{
	struct vmw_bo_dirty *dirty =3D vbo->dirty;

	if (dirty && kref_put(&dirty->ref_count, vmw_bo_dirty_free))
		vbo->dirty =3D NULL;
}

Since vmw_bo_dirty_release() doesn't appear to take the resv lock, can a
concurrent write to a mapped buffer object (which triggers the page fault
handler and calls vmw_bo_dirty_mkwrite() under the resv lock) dereference
the freed vbo->dirty memory here, leading to a use-after-free?

> +	return 0;
> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260731164341.1109=
827-1-pbonzini@redhat.com?part=3D3
