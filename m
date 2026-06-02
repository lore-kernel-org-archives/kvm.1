Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2142136F91F;
	Tue,  2 Jun 2026 10:07:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780394854; cv=none; b=p3smZ7jpVCnbDNLYCG84hY34fNTcAKCFLHVVRw51142IYdCnswol4PQE9K1tbzmWFdIq6Wb1CmFqadkcwezfOY1MELHS9Va/R6lQ1DeQ3Uv9m7uuCOfTwLcZdXzOT+BaZS+aGvmnWCM2/oqu7uR+DEGXopKaQYo5fJXgOFq3aps=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780394854; c=relaxed/simple;
	bh=DJ+YNfigE8pzfyVTIvkGTp3g8dr7vHyfhNo60hzahAQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HLKkdwPBPzRP6l+m23g75lUY7x5T2+jF83lt+i1490CSOJR5pjFdfd3nGPauKfBkt1QyvUbDwCO9IIQm8pIAlqg1jWRPnwk6NdjouZPUTBbDmOcoEbRB+zZIm3vKOYIdIi9yV+lLWmY0OdfYYM6wVu5w/AR/vCVxykh2Z8nxf88=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Kv2fE0bp; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Kv2fE0bp"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B312A1F00893;
	Tue,  2 Jun 2026 10:07:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780394852;
	bh=FArUgwzqGxSIYq6nsRbDRcCSW+jo1FsCY7Blcc7Vo5I=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=Kv2fE0bpyQXoK2UWojz99uTNM13VMJzQY8pttiWpI5b8+40hTJICG1z6mCK4HxzOt
	 WGAj2y5SJlJoIl+N9iHLKqVRWu9OrrHnx+/tz3FlIfzs7MJKFsAGpGxzFWxuyG8cBM
	 WrYnPscz8yfDI3CjGm3n7wUsfcglUz6lNDXUt3emdSCW12sVz1MKY0/BHu5mWG7lyI
	 dN+nfzkHl4QQvZFfAGkcO2JVbFceEzmni/FhHhQ1tddV0QOElD5gWZUecDoh8qPAX+
	 6wu9anSgJc0s666UALU4wXlDajOMwgfjPzHsI45oaFeSPwD+x8KBz2GcGUJ7aJGPII
	 gOS5yhOmWv2XA==
Date: Tue, 2 Jun 2026 13:07:24 +0300
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
Subject: Re: [PATCH v6 04/15] userfaultfd: test uffd VMA flags through the
 vma_flags_t API
Message-ID: <ah6rXJEYUsGfzPgi@kernel.org>
References: <20260529172716.357179-1-kas@kernel.org>
 <20260529172716.357179-5-kas@kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260529172716.357179-5-kas@kernel.org>

On Fri, May 29, 2026 at 06:26:33PM +0100, Kiryl Shutsemau (Meta) wrote:
> The uffd VMA-flag helpers read vma->vm_flags directly. Now that
> config-gated per-mode masks exist, switch them to the vma_flags_t
> accessor vma_test_any_mask(), which is the going-forward API and keeps a
> single place (the VMA_UFFD_* masks) that knows which modes are available
> on the current build.
> 
> No functional change: vma_flags_t is in union with vm_flags, so the same
> bits are read, and the masks fold to the same code the open-coded
> vm_flags tests produced -- verified identical on gcc and clang, 32- and
> 64-bit.
> 
> Suggested-by: Lorenzo Stoakes <ljs@kernel.org>
> Signed-off-by: Kiryl Shutsemau <kas@kernel.org>
> Assisted-by: Claude:claude-opus-4-8

Acked-by: Mike Rapoport (Microsoft) <rppt@kernel.org>

> ---
>  include/linux/userfaultfd_k.h | 14 ++++++++------
>  1 file changed, 8 insertions(+), 6 deletions(-)
> 
> diff --git a/include/linux/userfaultfd_k.h b/include/linux/userfaultfd_k.h
> index 658740df2978..c4f2cc6dfcf0 100644
> --- a/include/linux/userfaultfd_k.h
> +++ b/include/linux/userfaultfd_k.h
> @@ -178,7 +178,8 @@ static inline bool is_mergeable_vm_userfaultfd_ctx(struct vm_area_struct *vma,
>   */
>  static inline bool uffd_disable_huge_pmd_share(struct vm_area_struct *vma)
>  {
> -	return vma->vm_flags & (VM_UFFD_WP | VM_UFFD_MINOR);
> +	return vma_test_any_mask(vma,
> +		mk_vma_flags_from_masks(VMA_UFFD_WP, VMA_UFFD_MINOR));
>  }
>  
>  /*
> @@ -190,22 +191,23 @@ static inline bool uffd_disable_huge_pmd_share(struct vm_area_struct *vma)
>   */
>  static inline bool uffd_disable_fault_around(struct vm_area_struct *vma)
>  {
> -	return vma->vm_flags & (VM_UFFD_WP | VM_UFFD_MINOR);
> +	return vma_test_any_mask(vma,
> +		mk_vma_flags_from_masks(VMA_UFFD_WP, VMA_UFFD_MINOR));
>  }
>  
>  static inline bool userfaultfd_missing(struct vm_area_struct *vma)
>  {
> -	return vma->vm_flags & VM_UFFD_MISSING;
> +	return vma_test_any_mask(vma, VMA_UFFD_MISSING);
>  }
>  
>  static inline bool userfaultfd_wp(struct vm_area_struct *vma)
>  {
> -	return vma->vm_flags & VM_UFFD_WP;
> +	return vma_test_any_mask(vma, VMA_UFFD_WP);
>  }
>  
>  static inline bool userfaultfd_minor(struct vm_area_struct *vma)
>  {
> -	return vma->vm_flags & VM_UFFD_MINOR;
> +	return vma_test_any_mask(vma, VMA_UFFD_MINOR);
>  }
>  
>  static inline bool userfaultfd_pte_wp(struct vm_area_struct *vma,
> @@ -222,7 +224,7 @@ static inline bool userfaultfd_huge_pmd_wp(struct vm_area_struct *vma,
>  
>  static inline bool userfaultfd_armed(struct vm_area_struct *vma)
>  {
> -	return vma->vm_flags & __VM_UFFD_FLAGS;
> +	return vma_test_any_mask(vma, __VMA_UFFD_FLAGS);
>  }
>  
>  static inline bool vma_has_uffd_without_event_remap(struct vm_area_struct *vma)
> -- 
> 2.54.0
> 

-- 
Sincerely yours,
Mike.
