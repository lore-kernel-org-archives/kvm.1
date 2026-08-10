Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6B40325485
	for <kvm@vger.kernel.org>; Mon, 10 Aug 2026 15:50:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786377003; cv=none; b=L2YUTXZUd/y6WnFRz+22dVZOoOTkgZHxVuZqWjb5WAuEJH6YPNbumVnCzO417HgaWhzO6x0xLVcNrON4YdQqch2UR8mwZfYyKxQsv3AARD7Lp8k37025l/2CsRU9xNpIwO3MTjVgPc7eN+EaVeYolX27p1YqOa0Rv5NxQGD+MXQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786377003; c=relaxed/simple;
	bh=oUSFIovW7v66clkVhh6j+TYfNDm38/OidcisQ+/Rurg=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=bTMcmUgpFE9jNpmUXZg7Ffnac4Nr1SLHmkHGsayTHCAspUs7TI7ofA+m5IjwL5GKRZytDOSuDXb3qZUQc2HepAO7Zu3l0CuarpuZ0jBvf0ExjZSmMi5t4w9I8Fm5+CPIKkARibfQM+n9Oiit75Hiz8FimUrCQhmSek8G4fR76+k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ntzUaxYf; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ntzUaxYf"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5CAC21F00A3A;
	Mon, 10 Aug 2026 15:50:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786377001;
	bh=xju5Sj/Q9WS0K16poj7PUx/1HXjTENpV/q1N6mSnJiE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ntzUaxYf6g8CfJLhuTnY3SMdcGZweQobLn1MW9aVfjaRg7D7gQuB8dRIqjvsAVtKH
	 iKFZo7dRIX1vbtDqenek6mE0AHjyoYUgW56P+jt13NsTvm93IpchVsN5DnVpO3pjnd
	 cVev03Gv84GfbeRYn+lBdVbDEM4zJ611fkXsbkfX4E/pK5Cd4vMIUPXLMwwmladobW
	 QALDmpTBptJH75/6hRGXImgMZilV1UV+8NAFcIrqSDCGcEEIzp6xSRB+hrnoe4wsTS
	 V7L7r9asgdLnIFrat4dPfEblBptoWHsOUvpNTjuZc062vpWBhUfX8tTQfSeBrVJTNg
	 NxoafuusGPzsA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] KVM: SEV: Fix page dirtying in sev_gmem_post_populate()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Jann Horn" <jannh@google.com>
Cc: kvm@vger.kernel.org
In-Reply-To: <20260810-x86-kvm-setpagedirty-v1-1-85f180892d4f@google.com>
References: <20260810-x86-kvm-setpagedirty-v1-1-85f180892d4f@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 10 Aug 2026 15:50:00 +0000
Message-Id: <20260810155001.5CAC21F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

Pre-existing issues:
- [Critical] Leaked SEV-SNP pages (via snp_leak_pages) are incorrectly retu=
rned to the buddy allocator, causing host panics (RMP violations) upon reus=
e.
- [High] Unprivileged host userspace can trigger a kernel warning (WARN_ON_=
ONCE) in sev_gmem_post_populate() by passing a NULL user address.
--

--- Patch [1]: [PATCH] KVM: SEV: Fix page dirtying in sev_gmem_post_populat=
e() ---
commit 6e5ffd2f92a045c6125ad2d714ea329e1a9b8c9a
Author: Jann Horn <jannh@google.com>

KVM: SEV: Fix page dirtying in sev_gmem_post_populate()

This patch fixes a potential use-after-free by replacing set_page_dirty()
with set_page_dirty_lock() for pages obtained from get_user_pages_fast().
This ensures the page's mapping cannot concurrently go away during the
dirtying process.

> diff --git a/arch/x86/kvm/svm/sev.c b/arch/x86/kvm/svm/sev.c
> index 0f0ea7896af5b..49feef14787af 100644
> --- a/arch/x86/kvm/svm/sev.c
> +++ b/arch/x86/kvm/svm/sev.c
> @@ -2337,7 +2337,7 @@ static int sev_gmem_post_populate(struct kvm *kvm, =
gfn_t gfn, kvm_pfn_t pfn,
>  	bool assigned =3D false;
>  	int level;
>  	int ret;
> =20
>  	if (WARN_ON_ONCE(sev_populate_args->type !=3D KVM_SEV_SNP_PAGE_TYPE_ZER=
O && !src_page))

[Severity: High]
This isn't a bug introduced by this patch, but can an unprivileged host
userspace process trigger this WARN_ON_ONCE by passing a NULL user address?

If a userspace process invokes the KVM_SEV_SNP_LAUNCH_UPDATE ioctl with
params.type =3D=3D KVM_SEV_SNP_PAGE_TYPE_CPUID and params.uaddr =3D=3D 0, t=
he
snp_launch_update() function computes src =3D NULL and bypasses the
PAGE_ALIGNED check:

arch/x86/kvm/svm/sev.c:snp_launch_update() {
    src =3D params.type =3D=3D KVM_SEV_SNP_PAGE_TYPE_ZERO ? NULL :
          u64_to_user_ptr(params.uaddr);
    if (!PAGE_ALIGNED(src))
        return -EINVAL;
}

Since 0 is page-aligned, src remains NULL. When kvm_gmem_populate() is
subsequently called, it skips fetching user pages because src is NULL:

virt/kvm/guest_memfd.c:kvm_gmem_populate() {
    if (src) {
        unsigned long uaddr =3D (unsigned long)src + i * PAGE_SIZE;
        ...
    }
}

This leaves src_page as NULL when it is passed to sev_gmem_post_populate(),
which triggers the WARN_ON_ONCE. Does this allow a malicious user to trigger
a host-side denial of service if the kernel boots with panic_on_warn?

>  		return -EINVAL;

[ ... ]

> @@ -2381,15 +2381,15 @@ static int sev_gmem_post_populate(struct kvm *kvm=
, gfn_t gfn, kvm_pfn_t pfn,
>  	 * Copy this page back into the source buffer so userspace can use this
>  	 * information to provide information on which CPUID leaves/fields
>  	 * failed CPUID validation.
>  	 */
>  	if (ret && !snp_page_reclaim(kvm, pfn) &&

[Severity: Critical]
This is a pre-existing issue, but does snp_page_reclaim() properly manage
reference counts for leaked pages?

If snp_page_reclaim() fails, it permanently leaks the page via
snp_leak_pages(). However, the page is added to the snp_leaked_pages_list
without taking an additional reference:

arch/x86/virt/svm/sev.c:__snp_leak_pages() {
    if (likely(!PageCompound(page)) || ...)
        list_add_tail(&page->buddy_list, &snp_leaked_pages_list);
}

For pages from guest_memfd, the owning subsystem controls the reference. Wh=
en
operations drop references to the leaked folio (such as when the file is
closed or truncated), the reference count can drop to zero:

virt/kvm/guest_memfd.c:__kvm_gmem_populate() {
out_put_folio:
    folio_put(folio);
}

Could this cause the leaked SEV-SNP page to be erroneously returned to the
buddy allocator while still in a hardware-enforced private state, leading to
fatal RMP violations upon subsequent reuse?

>  	    sev_populate_args->type =3D=3D KVM_SEV_SNP_PAGE_TYPE_CPUID &&
>  	    sev_populate_args->fw_error =3D=3D SEV_RET_INVALID_PARAM) {
>  		void *src_vaddr =3D kmap_local_page(src_page);
>  		void *dst_vaddr =3D kmap_local_pfn(pfn);
> =20
>  		memcpy(src_vaddr, dst_vaddr, PAGE_SIZE);
> -		set_page_dirty(src_page);
> +		set_page_dirty_lock(src_page);
> =20
>  		kunmap_local(dst_vaddr);
>  		kunmap_local(src_vaddr);

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260810-x86-kvm-se=
tpagedirty-v1-1-85f180892d4f@google.com?part=3D1
