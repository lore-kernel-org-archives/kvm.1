Received: from mail.8bytes.org (mail.8bytes.org [85.214.250.239])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C576B405844
	for <kvm@vger.kernel.org>; Thu, 11 Jun 2026 15:23:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.214.250.239
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781191391; cv=none; b=Kn2oKZKWgR8X5la/uAMgyy7qpBaXdis/3lUW/Dp6V30nVA1l7tlRxKmjJtwQ+zbdeGhRbRzIQesCFy7d3qDuYdjiK1rd4F86bxxVZJRhE+9J9qKX2fmNZJMTnCLZ5pQlRGAiItTZ0u3KK9GHIzOmYtbg3CwDSjCEu9LrnKF2VPg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781191391; c=relaxed/simple;
	bh=eTpQfbLcqqj819+kBcAMgXhw/4WgxMKJxSH+HkbeMuQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EnFEezj9PjqA7cVxgzOPZh5oXhfMKNzOrcwNlgq1Zl7eKqnOSMmDuSv1NUotv5nO4BxgYhk5zpDFdkLSaunPMxWyqm35v7LEtrDYBQ/Cu8LKFHw1BL/EnyW7NoJypILlQHDzVPkP3Y+MBjC0b022+LzwrWFK45gziTtX4klhr4g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=8bytes.org; spf=pass smtp.mailfrom=8bytes.org; arc=none smtp.client-ip=85.214.250.239
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=8bytes.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=8bytes.org
Received: from 8bytes.org (p4ffe1d30.dip0.t-ipconnect.de [79.254.29.48])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.8bytes.org (Postfix) with ESMTPSA id 5F4911C1C3A;
	Thu, 11 Jun 2026 17:23:08 +0200 (CEST)
Date: Thu, 11 Jun 2026 17:23:07 +0200
From: =?utf-8?B?SsO2cmcgUsO2ZGVs?= <joro@8bytes.org>
To: sashiko-reviews@lists.linux.dev
Cc: kvm@vger.kernel.org
Subject: Re: [PATCH 4/4] kvm: svm: Support KVM_SEV_SNP_PAGE_TYPE_VMSA at
 SNP_LAUNCH_UPDATE
Message-ID: <airKLGYTBK2gRbIJ@8bytes.org>
References: <20260611123528.572255-5-joro@8bytes.org>
 <20260611125849.9ED631F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260611125849.9ED631F00893@smtp.kernel.org>

On Thu, Jun 11, 2026 at 12:58:49PM +0000, sashiko-bot@kernel.org wrote:
> [Severity: Low]
> Is the sev_features variable necessary? It gets assigned below when
> processing a KVM_SEV_SNP_PAGE_TYPE_VMSA page but doesn't appear to be
> used anywhere else in this function.

Yes, that is a left-over and can be removed.

> [Severity: High]
> This is a pre-existing issue, but does this violate the LIFO unmapping
> requirement of the highmem API?
> 
> The kmap_local_page() documentation requires mappings to be unmapped in the
> exact reverse order. Here src_vaddr is mapped first, then dst_vaddr, but
> they are unmapped in the same order instead of reverse. Could this corrupt
> the internal stack on the next kmap/kunmap operations?

Right, I will fix it in this patch.

> [Severity: High]
> Will this new VMSA initialization path expose a use-after-free of KVM
> memslots during launch finish?
> 
> By setting sev->initial_vmsa_gpa to a valid page here, the ioctl path
> KVM_SEV_SNP_LAUNCH_FINISH can now call sev_es_vmsa_pa(), which looks up the
> slot:
> 
> arch/x86/kvm/svm/sev.c:sev_es_vmsa_pa() {
>     ...
>     slot = gfn_to_memslot(vcpu->kvm, gfn);
>     ...
> }
> 
> Since the launch finish ioctl takes kvm->lock and vcpu->mutex, but not
> srcu_read_lock(), could a concurrent memslot update swap and free the
> memslot before it is accessed in kvm_gmem_get_pfn()?

Will further investigate this. If there is an issue it is independent of this
series.

> [Severity: Critical]
> This isn't a bug introduced by this patch, but does the error recovery path
> for KVM_SEV_SNP_PAGE_TYPE_CPUID write to a potentially read-only page?
> 
> When handling the CPUID type, kvm_gmem_populate() calls get_user_pages_fast()
> with gup_flags = 0, requesting read-only access. If userspace mapped a
> read-only page like the global zero page, GUP will succeed.
> 
> If the firmware returns SEV_RET_INVALID_PARAM, sev_gmem_post_populate() maps
> the page with kmap_local_page() and copies the expected values into it:
> 
> memcpy(src_vaddr, dst_vaddr, PAGE_SIZE);
> 
> Could this illegally overwrite read-only memory and corrupt the global zero
> page?

Looks like this can happen, but not introduced by this series. It needs a
separate fix.

> [Severity: High]
> This is a pre-existing issue, but can a host userspace process trigger a
> kernel warning by passing a NULL user address (uaddr = 0) here?
> 
> If params.uaddr is 0, src becomes NULL and passes the PAGE_ALIGNED(src)
> check. kvm_gmem_populate() skips fetching the user page and passes
> src_page = NULL to sev_gmem_post_populate().
> 
> That function then unconditionally evaluates:
> 
> WARN_ON_ONCE(sev_populate_args->type != KVM_SEV_SNP_PAGE_TYPE_ZERO &&
>              !src_page)
> 
> Since the type isn't ZERO, won't this allow an unprivileged user to spam
> the kernel log?

This is correct, we will send a separate fix.

-Joerg
