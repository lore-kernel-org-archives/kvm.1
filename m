Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36F872264A7;
	Wed,  3 Jun 2026 12:54:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780491264; cv=none; b=CsiiIYAxGNYCIKUWbVAwIQextCKIO34sQIQEvuufVj13CTiHU33yKZtxT9NmSo2XCLTCzRcSEXSoPO3J3cM+43ycvcGHrdCcV5BIcMX3Syy0+HxIFrL6XSUwtcvA2pMsUjTHt2Hcqy3b28wm8YjXIOpTaLc7dZxcQ2ulpwuagrw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780491264; c=relaxed/simple;
	bh=eZi8vwjyiB0EiBnWR0Z9EDefeR6C9PAHxvmQiULsKOk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eVv1oGXnCWTxdiP5C2SRS93p+HLy8cH31D7rYD3gbbuAw/Nc52zpTAsXtbFYzU5kbY3Or8A/bhyuc/nnWknF9W7Bo0aM2UOCI5z9yLFWzYlUbFqScW9/OI8h79q7URLJfvawnk8pQZpUJd7lL0+ao4ZRPYfKjQvvYflLuovHP6I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oKld6tc8; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oKld6tc8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C06B11F00893;
	Wed,  3 Jun 2026 12:54:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780491262;
	bh=30TlrB+n50Kd02bZUSUoY+UoKZNYPWG5yVxkJ95GHA0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=oKld6tc89tXPvQ+Ce4LoyO3EWpk6t09l7ALcOBmE9UcFl2b5rSDRjGyhEgl7k8sml
	 kBtuhQYcOxkSa9Db29wn5Piol8H6yXp2VPK4MxoXYihtLmibdkBlDbeiQ75MANBdc4
	 ggwGWirs8KRwx0Zc4qz9sqt6DzcJlnDfV8c1QBo443+2I9oqvxqT1kYdWV1vUPry5r
	 KKsEQirB2k0vNFONmWMQN1KRLN0/8WbKLwEZC5q41sWq3Ofsv5ZTLYyapYzx14jCrI
	 wvoUnqr5U7sPWZ45LYmA59Lwt9hxQwZyVyt3v+TdaOGxY87g0FPpc9d7pNYJDxUO5f
	 2nsQDmcx4o2sA==
Date: Wed, 3 Jun 2026 13:54:14 +0100
From: Lorenzo Stoakes <ljs@kernel.org>
To: "Kiryl Shutsemau (Meta)" <kas@kernel.org>
Cc: akpm@linux-foundation.org, rppt@kernel.org, peterx@redhat.com, 
	david@kernel.org, surenb@google.com, vbabka@kernel.org, Liam.Howlett@oracle.com, 
	ziy@nvidia.com, corbet@lwn.net, skhan@linuxfoundation.org, seanjc@google.com, 
	pbonzini@redhat.com, jthoughton@google.com, aarcange@redhat.com, sj@kernel.org, 
	usama.arif@linux.dev, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org, kvm@vger.kernel.org, 
	kernel-team@meta.com
Subject: Re: [PATCH v6 04/15] userfaultfd: test uffd VMA flags through the
 vma_flags_t API
Message-ID: <aiAj3teg1-9-GoyQ@lucifer>
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

Thanks, LGTM so:

Reviewed-by: Lorenzo Stoakes <ljs@kernel.org>

> Assisted-by: Claude:claude-opus-4-8
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
