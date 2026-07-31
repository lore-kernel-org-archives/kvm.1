Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8650E44AB65
	for <kvm@vger.kernel.org>; Fri, 31 Jul 2026 17:06:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785517612; cv=none; b=KTTUGW4e0wjxKPrCMs2LZod3KCQIU5VPs4AqUBnc/sUMFHB8rW/1rXEqdCsdXnJdO8xPc0SkkHX65/rwOVMF1AYx6ARmPxgOeuF7g3EBbG7rEvjcORFK+lxjumUBkvjtivVBT0xnRE/HO5EhQKq0a3GqFZ7gMMvo1BmJUo5b8NU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785517612; c=relaxed/simple;
	bh=6a6JMJBFVfVEQ+Hr8X0gMZYCLuqN5WOwaRhPFPLE4R4=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=YSzUdVBAlV3RRGNTd934vpQH2q5qxFokqWjci9rHiKZKtgg1h/1Qz/bju6BZ/9gWah7N6X7QIBmb1PsORqbRJOIx5ZbbSyE7TPsoXl2Wg0wUv2GsEXElhtAqfYKrIcRBhrlNqHbxgGnqc9dDCd3qe4+0qzdLWv2Ut84VqbS2sNU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=j0wpJypn; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="j0wpJypn"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EF6F91F0155B;
	Fri, 31 Jul 2026 17:06:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785517611;
	bh=Jkm7qTOwVu0f1PJw17vuWKPRppXrIVe/VWIbuaoVqGM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=j0wpJypnz/sVwU5Q5nTZwu3zR1REfib00/8OqkxYClAvlD4rjQ4rF46OxXF30Bv0B
	 Kw9F6e9anD9lJ1JVhSfqA5P/Ma4S8hWLT2IhvxxMrEz8UwWMuliYpyvaLJWGpuGf0P
	 Q7JIBEi1C+khYwM6Q+7kPSuyF+2y6giB2hFwYESuVpYtvi/BUVUomoKbDb43dy78X3
	 lAA9btFUcVCslQUvQLhaSQDr1ZUYB/paPRVt9xB9NiloEzbpIDGnDuq4MqqMdtmCY1
	 cOCik6Ox5Dmkb/aMTrhBBQcUDCKtiJ/MMBFYusrbVKiNXJ2hsrHq6UxIJvX0TP7bRe
	 NFXyQ3cl0HcpA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH RFT 2/3] drm/shmem_helper: use vmf_insert_pfn_mkwrite()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Paolo Bonzini" <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, dri-devel@lists.freedesktop.org
In-Reply-To: <20260731164341.1109827-3-pbonzini@redhat.com>
References: <20260731164341.1109827-1-pbonzini@redhat.com>
 <20260731164341.1109827-3-pbonzini@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 31 Jul 2026 17:06:50 +0000
Message-Id: <20260731170650.EF6F91F0155B@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Incorrect page offset calculation causes wrong pages to be mapped =
after VMA split (munmap/mremap)
--

--- Patch [2]: [PATCH RFT 2/3] drm/shmem_helper: use vmf_insert_pfn_mkwrite=
() ---
commit e238b92cc06e6221554d7e59a6c25c7b8c19b7ac
Author: Paolo Bonzini <pbonzini@redhat.com>

drm/shmem_helper: use vmf_insert_pfn_mkwrite()

This commit changes the shmem helper to use vmf_insert_pfn_mkwrite() to
ensure KVM or VFIO correctly see a writable PTE when requested. It also
updates the PMD mapping case to pass the write flag instead of recording
the write fault early.

Link: https://lore.kernel.org/kvm/20260729072044.25796-1-slp@redhat.com/

> diff --git a/drivers/gpu/drm/drm_gem_shmem_helper.c b/drivers/gpu/drm/drm=
_gem_shmem_helper.c
> index c989459eb2159..c81be3e973173 100644
> --- a/drivers/gpu/drm/drm_gem_shmem_helper.c
> +++ b/drivers/gpu/drm/drm_gem_shmem_helper.c
> @@ -589,11 +589,25 @@ static void drm_gem_shmem_record_mkwrite(struct vm_=
fault *vmf)
>  	folio_mark_dirty(page_folio(shmem->pages[page_offset]));
>  }

[Severity: High]
This is a pre-existing issue, but does this result in the wrong page being
marked dirty or mapped after a VMA split?

Looking at drm_gem_shmem_record_mkwrite() (line 583) and
drm_gem_shmem_any_fault() (line 638) in drivers/gpu/drm/drm_gem_shmem_helpe=
r.c,
page_offset is calculated as:

    pgoff_t page_offset =3D vmf->pgoff - vma->vm_pgoff;

If userspace maps a GEM object and then splits the VMA (e.g., via a partial
munmap() at the beginning of the VMA), the kernel advances vma->vm_pgoff to
account for the split. When a page fault subsequently occurs in the new VMA,
vmf->pgoff evaluates to the fake offset plus the split offset plus the fault
offset.

This makes the calculation mathematically equivalent to
(address - vma->vm_start) >> PAGE_SHIFT. This completely discards the split
offset, meaning the remaining VMA will erroneously map the GEM object start=
ing
from page 0 again, rather than the correct sub-page.

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260731164341.1109=
827-1-pbonzini@redhat.com?part=3D2
