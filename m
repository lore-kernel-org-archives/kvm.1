Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C75A47CC8F
	for <kvm@vger.kernel.org>; Fri, 31 Jul 2026 18:46:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785523614; cv=none; b=LmB+kq19Q11KYi4Sg2c1NXTpZNytF1d8OXMVKZ15K2ED7WvhhKkizjaA+HFGHirqjrr6ur3LrCYDdfaMzPHEZaFj4Mo7EEzZaCyGJ/mwRB29IwDChgLg99IwU45qaOH2yfccT77FqowvrFgVtepBchGZtyygHlNJOjBTM/w8m1A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785523614; c=relaxed/simple;
	bh=J9CJJngSEkGxvW0KdIe9U0T3muoZkE0J8ZChPn5T/Rc=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=VagBDsuFtRlaCC21JJTZyY2l7D2v1tLQ1qxGun7ajssWS3VWetLFavCEpT0EqEpXbXTEF5NaxKHFvR/SKzRg3QNFK/UjHuf3nOBDY25C1vk1ILBfQ/37h+a9dipd2nOYIl9LlrBN85uLvb13HwFKRu3y10WjkmZwYD/3xx8uRXc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=H+vJN02A; arc=none smtp.client-ip=209.85.214.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="H+vJN02A"
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-2cc6dd43737so27693195ad.2
        for <kvm@vger.kernel.org>; Fri, 31 Jul 2026 11:46:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1785523610; x=1786128410; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=zTbunwlWGL4ObDbgs2Q2RbR+6N7LoKlc6q6xk+L8cCw=;
        b=H+vJN02A8QddMMm9cJlpgh+KPcmxMPXsnz8zYTtf8kVEPJn9dYfKczxvZRLV1DgnhG
         9oN0+CVw2ovRwC6xh3IZQyy9HmDhBNPTaThxrCObqP6hz5RYMxcNOeNoa1jnUZ0VbDPb
         LjmfebhUB+I7gW7jvD5lzGAIEEMEyzQBKDmZ+W7zHVP7vaIAt5T1I1g8o+rC+/XIpQt4
         5tfaH8OSY/kFeh7g2yiqyV7VY3EZ+QOGYqOdqAn38y3tAD+9mftUJzQ+qP2Ft661LA9g
         R5XM8lkZlFosAx+ZoBWEuIN9u1qPsaA9aB5GrtCP3EfpvPMOuEy3+dJNc87yK1QTfuku
         TWMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785523610; x=1786128410;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=zTbunwlWGL4ObDbgs2Q2RbR+6N7LoKlc6q6xk+L8cCw=;
        b=cfXAj6nPSvW+9kRNT3suNsmgc/7WSQKdw59AXhtet3PgFDYqFa3HW4eahA0SfmlLIK
         xM9v6f3FKgJyROhgVYtjv2aCgE7S/EqC2N1qqUWinb7iK9mpVUE2/rxAoy5B3ZXYnjVf
         ebs3t3taKeOy/vbPDcoMvGLjRqS3JmoyN6go9QU/j9MRQ9eWX+mo3OcVW1onHZa9yJ8m
         Qv/o59t/nInIhEau0kUTNlADRdDsf7SQQwz4KhWqtFU/WuCLJvjvGR5NWQdnmChwc6VX
         8EUKwzYpvjEE2/Bn/BL+16sav+5dT56X+/5/M9loLNH9rEvSPDu2bJjls3xIiy7B9pB1
         D/sw==
X-Forwarded-Encrypted: i=1; AHgh+RqCyVeLEokoV3/Qo/THSiBno/OIbyHFTtgAwg/OIDxkWvug69mWrBLd22/8x8INysDHWUI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzeInh3SaH6egYxISl4SQ7Z0YV8FRGrEvYEkgNZ5NuwnYQH8n+M
	igBI2o4TT/O2mKTFTZN5f09kejCs49G+Oq3ZjWVnaVNrZcbDOnqc5vPB6eLizbBZtnBxvUj5Bx+
	fkVC/Bg==
X-Received: from plbja1.prod.google.com ([2002:a17:902:efc1:b0:2ce:fa1a:2684])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:1a4d:b0:2cc:df15:91de
 with SMTP id d9443c01a7336-2d0524a2b59mr9441425ad.42.1785523610000; Fri, 31
 Jul 2026 11:46:50 -0700 (PDT)
Date: Fri, 31 Jul 2026 11:46:49 -0700
In-Reply-To: <20260731175834.1121005-1-pbonzini@redhat.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260731175834.1121005-1-pbonzini@redhat.com>
Message-ID: <amztmWhHXUR4zBv1@google.com>
Subject: Re: [PATCH] kvm: apply VM_READ/VM_WRITE checks to all VMA types
From: Sean Christopherson <seanjc@google.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"

On Fri, Jul 31, 2026, Paolo Bonzini wrote:
> The VM_READ and VM_WRITE flags are checked only at the very end of
> hva_to_pfn().  For both the hva_to_pfn_remapped() case and for regular
> mappings, this adds unnecessary cases and inconsistent error behavior.
> 
> For hva_to_pfn_remapped(), the code is relying on fixup_user_fault() to
> detect this situation.  This is fragile because hva_to_pfn_remapped()
> returns different error codes for a !VM_WRITE VMA depending on whether
> the PTE happens to be mapped:
> 
> * if the PTE is present, follow_pfnmap_start() sets args.writable to
>   false and KVM_PFN_ERR_RO_FAULT is returned;
> 
> * if no PTE is present, fixup_user_fault(FAULT_FLAG_WRITE) returns
>   -EFAULT after checking vma_permits_fault(), and hva_to_pfn() ends
>   up returning KVM_PFN_ERR_FAULT.
> 
> With this patch KVM_PFN_ERR_RO_FAULT is returned uniformly.

IMO, returning KVM_PFN_ERR_RO_FAULT on a read-only VMA is wrong.  AFAICT, that
behavior for VM_{IO,PFNMAP} was added by commit bd2fae8da794 ("KVM: do not assume
PTE is writable after follow_pfn").  Given that that's the only case where KVM
returns KVM_PFN_ERR_RO_FAULT, I would much prefer to fix that wart and cross our
fingers nothing has come to rely on the behavior in the last ~5 years.

> Likewise, a PROT_NONE pfnmap VMA would be mapped into the guest if the PTE
> was pte_present()[1] when the guest attempted to read it; with the patch
> instead KVM uniformly returns KVM_PFN_ERR_FAULT.  Doing the check early
> avoids these special cases and also sidesteps the issue pointed out at
> https://sashiko.dev/#/patchset/20260731160514.1101989-1-pbonzini%40redhat.com.
> 
> For regular mappings a PROT_READ VMA, if placed in a writable memslot,
> would return KVM_PFN_ERR_FAULT instead of KVM_PFN_ERR_RO_FAULT when
> the guest writes to it.  This would cause a -EFAULT exit to userspace,
> instead of triggering emulation as the VM_IO|VM_PFNMAP arm would do;

No, arm64 is checking the memslot, not the VMA.

	hva = gfn_to_hva_memslot_prot(memslot, gfn, &writable);
	write_fault = kvm_is_write_fault(vcpu);
	if (kvm_is_error_hva(hva) || (write_fault && !writable)) {

Or are you talking about different code?

> however it should be considered part of the KVM API because mmu_stress_test
> relies on it.

...

>  	} else {
> -		if ((kfp->flags & FOLL_NOWAIT) &&
> -		    vma_is_valid(vma, kfp->flags & FOLL_WRITE))
> -			pfn = KVM_PFN_ERR_NEEDS_IO;
> -		else
> -			pfn = KVM_PFN_ERR_FAULT;
> +		pfn = kfp->flags & FOLL_NOWAIT
> +			? KVM_PFN_ERR_NEEDS_IO : KVM_PFN_ERR_FAULT;

I find this style much easier to read:

		pfn = kfp->flags & FOLL_NOWAIT ? KVM_PFN_ERR_NEEDS_IO :
						 KVM_PFN_ERR_FAULT;

If we "fix" the read-only behavior, isn't it this?

	/*
	 * GUP failed.  It could be an inaccessible mapping, a pfnmap one,
	 * or the page might be absent.
	 */
	if (vma == NULL || unlikely(!(vma->vm_flags & VM_READ)) ||
	    ((kfp->flags & FOLL_WRITE) && unlikely(!(vma->vm_flags & VM_WRITE)))) {
		pfn = KVM_PFN_ERR_FAULT;
	} else if (vma->vm_flags & (VM_IO | VM_PFNMAP)) {
		r = hva_to_pfn_remapped(vma, kfp, &pfn);
		if (r == -EAGAIN)
			goto retry;
		if (r < 0)
			pfn = KVM_PFN_ERR_FAULT;
	} else {
		pfn = kfp->flags & FOLL_NOWAIT ? KVM_PFN_ERR_NEEDS_IO :
						 KVM_PFN_ERR_FAULT;
	}


>  	}
>  	mmap_read_unlock(current->mm);
>  	return pfn;
> -- 
> 2.55.0
> 
