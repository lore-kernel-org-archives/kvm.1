Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 364D13C81B3;
	Tue, 12 May 2026 17:20:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778606426; cv=none; b=K6xad7NhuSFvi+FEE2B/Su+3boSIYMj0HyxZE4VI8Izi5JsyuCq/dnLS4i2c+ifbpWv8QJZyZX2WSayyYXGjciflS5UiXsWorUothBsuwtcG4WmAHpE+vgmooiBFS0LQg8ailAAOkjeQHDjR9feiYPbdoW2vDPTZ2qoR+PmE5lE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778606426; c=relaxed/simple;
	bh=DRoLtgIvcD2e2vf2baoMKR6QXNkbxpK/O1mp/m/ymfU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uIdzeVFCBWIcs9Of6o78h80GbP3vG0/y9iLOIezSnbCBGbuiDU+rx7f0RrfxD6km6mPXkR29ASpY4lhby3e8CRsYvH9v57uqDZlmv5i/7LtHovFf3DB6JXKyg++x/OoigG91q6kud4JgkRE/ndetY+XLEwk+AI7zj85Wd6sW6uc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YIsvNhVm; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YIsvNhVm"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DB4AEC2BCF6;
	Tue, 12 May 2026 17:20:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778606425;
	bh=DRoLtgIvcD2e2vf2baoMKR6QXNkbxpK/O1mp/m/ymfU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=YIsvNhVmAYXymKaSFDsIZLzQKlZ79T6SkCywkU24ZoKbuOSR9wkaJafMAQxn3MHnW
	 LlsNQCAsJWNJ8n+Jp3KfprZWydWAS0nLhVY9L9atoR/TgYwS7SBGdNgrx8Zk1LprqI
	 q0Nps/N9ITY1XhzQx5tDBcueyh6ovjN02qUFqlqP/cyPRVOOr7+OHS1B92f8yewJPo
	 wtiCkeNXZ4f8dGZTIfgdsUW+/j67oSsSjp+5fedQZHVJe8l/KgrvUU+ubsi2UI3Fmz
	 lOB0Yrigesl7xoDwcYLVwUlvzGKQcXbjjmopo/Q1+0ueAp/Yosl/B6ZLZtz9sp2Vqc
	 fWWsdcsBxaJkA==
Date: Tue, 12 May 2026 20:20:14 +0300
From: Mike Rapoport <rppt@kernel.org>
To: "Kiryl Shutsemau (Meta)" <kas@kernel.org>
Cc: akpm@linux-foundation.org, peterx@redhat.com, david@kernel.org,
	ljs@kernel.org, surenb@google.com, vbabka@kernel.org,
	Liam.Howlett@oracle.com, ziy@nvidia.com, corbet@lwn.net,
	skhan@linuxfoundation.org, seanjc@google.com, pbonzini@redhat.com,
	jthoughton@google.com, aarcange@redhat.com, sj@kernel.org,
	usama.arif@linux.dev, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-kselftest@vger.kernel.org, kvm@vger.kernel.org,
	kernel-team@meta.com
Subject: Re: [PATCH v2 08/14] userfaultfd: add UFFDIO_REGISTER_MODE_RWP and
 UFFDIO_RWPROTECT plumbing
Message-ID: <agNhTvqeOD1eo8mD@kernel.org>
References: <cover.1778254670.git.kas@kernel.org>
 <1ad0cb61a7b5a33a5375baadbd0720ba2ba43d2f.1778254670.git.kas@kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1ad0cb61a7b5a33a5375baadbd0720ba2ba43d2f.1778254670.git.kas@kernel.org>

On Fri, May 08, 2026 at 04:55:20PM +0100, Kiryl Shutsemau (Meta) wrote:
> Add the userspace interface for read-write protection tracking:
> 
>   - UFFDIO_REGISTER_MODE_RWP      register a range for RWP tracking
>   - UFFD_FEATURE_RWP              capability bit
>   - UFFDIO_RWPROTECT              install / remove RWP on a range
> 
> Registration sets VM_UFFD_RWP on the VMA. Combining MODE_WP with
> MODE_RWP is rejected because both modes claim the uffd PTE bit.
> 
> UFFDIO_RWPROTECT is the bidirectional counterpart of
> UFFDIO_WRITEPROTECT:
> 
>   - MODE_RWP              change_protection() with MM_CP_UFFD_RWP
>                           installs PAGE_NONE and sets the uffd bit on
>                           present PTEs
>   - !MODE_RWP             change_protection() with MM_CP_UFFD_RWP_RESOLVE
>                           restores vma->vm_page_prot and clears the bit
> 
> userfaultfd_clear_vma() runs the same resolve pass on unregister so
> RWP state cannot outlive the uffd.
> 
> Re-registering a range must not drop a mode that installs per-PTE
> markers (WP or RWP); doing so returns -EBUSY. This also closes a
> pre-existing window where re-registering without MODE_WP would strand
> uffd-wp markers: before, those caused extra write-faults but were
> otherwise benign; with RWP preservation in place, a subsequent
> mprotect() on a VM_UFFD_RWP VMA would silently promote the stale
> markers to RWP.
> 
> The feature is not yet advertised. UFFDIO_REGISTER_MODE_RWP,
> UFFD_FEATURE_RWP, and _UFFDIO_RWPROTECT are intentionally absent from
> UFFD_API_REGISTER_MODES, UFFD_API_FEATURES, and UFFD_API_RANGE_IOCTLS,
> so UFFDIO_API masks them out and the register-mode validator rejects
> the bit. The follow-up patch adds fault dispatch and exposes the UAPI.
> 
> Signed-off-by: Kiryl Shutsemau <kas@kernel.org>
> Assisted-by: Claude:claude-opus-4-6

Reviewed-by: Mike Rapoport (Microsoft) <rppt@kernel.org>

with a comment below

> ---
>  Documentation/admin-guide/mm/userfaultfd.rst | 10 ++
>  fs/userfaultfd.c                             | 84 +++++++++++++++++
>  include/linux/userfaultfd_k.h                |  2 +
>  include/uapi/linux/userfaultfd.h             | 19 ++++
>  mm/userfaultfd.c                             | 97 +++++++++++++++++++-
>  5 files changed, 209 insertions(+), 3 deletions(-)
> 
> +	/*
> +	 * Pre-scan the range: validate every spanned VMA before applying
> +	 * any change_protection() so a partial failure cannot leave the
> +	 * process with only a prefix of the range re-protected.
> +	 */
> +	err = -ENOENT;
> +	for_each_vma_range(vmi, dst_vma, end) {
> +		if (!userfaultfd_rwp(dst_vma))
> +			return -ENOENT;
> +
> +		if (is_vm_hugetlb_page(dst_vma)) {
> +			unsigned long page_mask;
> +
> +			page_mask = vma_kernel_pagesize(dst_vma) - 1;
> +			if ((start & page_mask) || (len & page_mask))
> +				return -EINVAL;
> +		}
> +		err = 0;
> +	}
> +	if (err)
> +		return err;

It's an interesting way to say "no VMA found in range" :)
I think bool found and
	
	if (!found)
		return -ENOENT;

looks more readable.

-- 
Sincerely yours,
Mike.
