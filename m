Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B42D3537E5;
	Mon,  7 Sep 2026 17:47:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788803234; cv=none; b=m9S0DdyUbcjp/pd2w2+TBXoJJhRxwMAaynEOtgwljpZM0Trjrorj+V1iY75mIA47YMg5cFzkXtgtZgyMpovxmdMd783gO/8kq1oBB9klkzU4L03LcrB7qK3tnJihdCQCit3DCJsgThdV1eBeTor7crJ1mWOkh4IiYI4S1sSIyP8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788803234; c=relaxed/simple;
	bh=m9FMQDOcT4FQPnknbDFlfjy6QjpVnNqyIJ8B8YERdZI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tT/JzyPDy7WYYvApsDVRteZBaFWUPpM9Jbls3TWaiNkL03Rfa7GEuhB966intgcPj/bMSMpQK3B3tQrUAWL7x47xtZ+hvZ+jjuPLasJpnQQlfWYR+Lc+6Vn2sx5WtS0fNhht87PdQxQT1OwL4vu/Vyzkjq1ponMG2mmjfzYBklI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=K5CKxkTz; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="K5CKxkTz"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4FC751F00A3A;
	Mon,  7 Sep 2026 17:47:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788803232;
	bh=idlbhkKiTt/twN0uI3E3GTXch8QGLkjoueh0C9NXOMI=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=K5CKxkTzIc2iHDlS5Ls7aScP2LHvSXuI6yB7Z2S2jJdEgKw9XanNUxg/+6EG+gk20
	 5V89+AZPWGeZYRS3iFTp4yOHkS7tiSgJ0JeTDl0fQsKFpUr5l1lNMSAKbf+RT7NmLV
	 MYPav4GMBELPcLE+0R/F9VWpNSGEpZmf0JrJlrxdSsB1JbBC/oFVCriNIxAQcnYXGA
	 EIFzAU4ZOGITcKP6WAwj3+vgi7vb0zxfVH4PBMHskCkGz6jJ5raUnjRpr51TAJhqrX
	 CDxWO1wAbaPA7grjy/CG9uLiLyrX+8jxsEGvgTEdrzZPPNFd58xDVlE2X/PJPwpavk
	 2MdN3pTLIt3BQ==
Message-ID: <b0035ada-8760-4c43-aac5-264d6b1d0099@kernel.org>
Date: Mon, 7 Sep 2026 19:47:08 +0200
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 3/4] KVM: guest_memfd: Establish memslot<=>guest_memfd
 bindings *after* memslot is ready
To: Sean Christopherson <seanjc@google.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
 Stefan Teodorescu <fane@google.com>, Dennis Tighe <dtighe@google.com>,
 Sashiko Bot <sashiko-bot@kernel.org>, Yan Zhao <yan.y.zhao@intel.com>
References: <20260904004342.3162959-1-seanjc@google.com>
 <20260904004342.3162959-4-seanjc@google.com>
From: "David Hildenbrand (Arm)" <david@kernel.org>
Content-Language: en-US
Autocrypt: addr=david@kernel.org; keydata=
 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
 qIws/H2t
In-Reply-To: <20260904004342.3162959-4-seanjc@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 9/4/26 02:43, Sean Christopherson wrote:
> Wait to bind a memslot to a guest_memfd instance until *after* the memslot
> is fully prepared, as creating the binding in guest_memfd will effectively
> expose the memslot to readers.  As pointed out by Sashiko, binding the
> memslot before it's ready to be exposed to the rest of the world can break
> various memslot assumption and rules.  E.g. x86 could observe a NULL rmap
> pointer if a PUNCH_HOLE hit the guest_memfd after the binding was created,
> but before KVM made it through kvm_prepare_memory_region().
> 
> Begrudgingly resort to passing in the guest_memfd fd+offset pair to
> kvm_set_memslot(), as creating the binding really does need to happen in
> the middle of setting the new memslot.  Alternatively, to preserve the
> aesthetically pleasing function prototype, "struct kvm_memory_slot" could
> be expanded to track the fd and the file, but that would create the
> possibility for TOCTOU bugs on the fd vs. file, and would add zero value
> beyond making kvm_set_memslot() look pretty.
> 
> Fixes:a7800aa80ea4 ("KVM: Add KVM_CREATE_GUEST_MEMFD ioctl() for guest-specific backing memory")
> Cc: stable@vger.kernel.org
> Reported-by: Sashiko Bot <sashiko-bot@kernel.org>
> Closes: https://lore.kernel.org/all/20260826170551.BEF801F000E9@smtp.kernel.org
> Signed-off-by: Sean Christopherson <seanjc@google.com>
> ---
>  virt/kvm/kvm_main.c | 34 ++++++++++++++++++++++------------
>  1 file changed, 22 insertions(+), 12 deletions(-)
> 
> diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
> index 3c0dbe60a5b4..21c10cbbac66 100644
> --- a/virt/kvm/kvm_main.c
> +++ b/virt/kvm/kvm_main.c
> @@ -1887,7 +1887,8 @@ static void kvm_update_flags_memslot(struct kvm *kvm,
>  static int kvm_set_memslot(struct kvm *kvm,
>  			   struct kvm_memory_slot *old,
>  			   struct kvm_memory_slot *new,
> -			   enum kvm_mr_change change)
> +			   enum kvm_mr_change change,
> +			   unsigned int gmem_fd, uoff_t gmem_offset)
>  {
>  	struct kvm_memory_slot *invalid_slot;
>  	int r;
> @@ -1934,6 +1935,15 @@ static int kvm_set_memslot(struct kvm *kvm,
>  	if (r)
>  		goto err;
>  
> +	if (new && new->flags & KVM_MEM_GUEST_MEMFD) {

For readability I'd throw in an extra pair of (). But KVM seems to use both
styles, so there is no clear preference when staring at the existing code :)

> +		if (WARN_ON_ONCE(change != KVM_MR_CREATE))
> +			goto err_bind;
> +
> +		r = kvm_gmem_bind(kvm, new, gmem_fd, gmem_offset);
> +		if (r)
> +			goto err_bind;
> +	}
> +
>  	/*
>  	 * For DELETE and MOVE, the working slot is now active as the INVALID
>  	 * version of the old slot.  MOVE is particularly special as it reuses
> @@ -1965,6 +1975,13 @@ static int kvm_set_memslot(struct kvm *kvm,
>  
>  	return 0;
>  
> +err_bind:
> +	if (new) {

We'd never end up here with !new, right?

> +		kvm_arch_free_memslot(kvm, new);
> +
> +		if (new->dirty_bitmap && (!old || !old->dirty_bitmap))
> +			kvm_destroy_dirty_bitmap(new);

That's essentially the cleanup path in kvm_prepare_memory_region().

I guess with some more reshuffling we could have a single dirty bitmap cleanup
path in this code.

> +	}
>  err:
>  	/*
>  	 * For DELETE/MOVE, revert the above INVALID change.  No modifications
> @@ -2059,7 +2076,7 @@ static int kvm_set_memory_region(struct kvm *kvm,
>  		if (WARN_ON_ONCE(kvm->nr_memslot_pages < old->npages))
>  			return -EIO;
>  
> -		return kvm_set_memslot(kvm, old, NULL, KVM_MR_DELETE);
> +		return kvm_set_memslot(kvm, old, NULL, KVM_MR_DELETE, -1, 0);
>  	}
>  
>  	base_gfn = (mem->guest_phys_addr >> PAGE_SHIFT);
> @@ -2106,21 +2123,14 @@ static int kvm_set_memory_region(struct kvm *kvm,
>  	new->npages = npages;
>  	new->flags = mem->flags;
>  	new->userspace_addr = mem->userspace_addr;
> -	if (mem->flags & KVM_MEM_GUEST_MEMFD) {
> -		r = kvm_gmem_bind(kvm, new, mem->guest_memfd, mem->guest_memfd_offset);
> -		if (r)
> -			goto out;
> -	}
>  
> -	r = kvm_set_memslot(kvm, old, new, change);
> +	r = kvm_set_memslot(kvm, old, new, change,
> +			    mem->guest_memfd, mem->guest_memfd_offset);
>  	if (r)
> -		goto out_unbind;
> +		goto out;
>  
>  	return 0;
>  
> -out_unbind:
> -	if (mem->flags & KVM_MEM_GUEST_MEMFD)
> -		kvm_gmem_unbind(new);
>  out:
>  	kfree(new);
>  	return r;

In general LGTM.

-- 
Cheers,

David
