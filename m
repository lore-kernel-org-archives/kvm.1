Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com [209.85.216.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD27F414DFA
	for <kvm@vger.kernel.org>; Thu, 24 Sep 2026 19:40:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790278827; cv=none; b=OBMK5nPwBVzFKx+9ErzDwOYbZwk5fHJ9gJ7mde/QDevTlEfsrrR25JhX9XLdqYWINAn6IeMpAFm/G18XnmoMS1fuvqs0gVSaiin3X3CCEd/Fn5dOuqND3ysaon7Isuxr2N1AeoGD9A3HihSICsRxLhJE7jNHX082xyNvnY7JqeE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790278827; c=relaxed/simple;
	bh=v2mr3yEeVPCA53lv8cWAiEEbb7C20MRdeH9IJtvRkCE=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=agFYtnWKMh7CiTO5XVsaDQpOdoEOvNIZckuuiGLt/MVoJrfFXUHHiMrE204K6Tgm2dzKOBAmFJVhxwDqFNcrOyRSKz4T+WU7Ue/TQG27/ju7g9IABvyQFUs8HeQHAM3kphHrnBClR6v9+YEOVcPhrtZvxIpzcCr9gnl5Cixwdow=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=eq/9jZfy; arc=none smtp.client-ip=209.85.216.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="eq/9jZfy"
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-39af92138f9so234206a91.0
        for <kvm@vger.kernel.org>; Thu, 24 Sep 2026 12:40:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790278825; x=1790883625; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=gTjGHblkjZzhraXaqnhHaeUgHULa4Gd97a7Hy/6dpCQ=;
        b=eq/9jZfySlVnBTKdp7AW6n2nnS4sv5A75EMdwNbY4hKF1ehvXzsAwVb8px8ardvgDY
         +Y3pQuZ8A/hzP9tCIbNf4j8U1fadQhiN3U3GETy3Smwf18PRJ/IF7DyTa22wVtb1Vp+g
         75/mdTLRcO3OSA4CXxxAUp5UIvAy4B1LewgtN8YlRoZfAJCkOU9xrLTajkSy+VZUTi6e
         SFPL1NSjC0JprnhkFGPidMNrO+siuoOvoYQsVZ0Hh5WCSOoxzt6ebWImKijqdXeihd1x
         OxdPF1By1T16yNQbEAqEwyanFq/U3iDJVBVQsrLt93SVGbWRLdIHpIA6+dfK+S5ScE7Z
         TvLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790278825; x=1790883625;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=gTjGHblkjZzhraXaqnhHaeUgHULa4Gd97a7Hy/6dpCQ=;
        b=FdKmD1BpxlImtvfO30hgHQC4prdSdCN4V9qD0Js93/v+PoRfT4B594yPsdDvMhmOv2
         Mm3fgnyVTtIsN040/vGgZSgsbJx0QfLIQXHgBorXGYGGbz9U5lYlPt0mYD6247ovqGNh
         pPsECMOW6UdhQgSVZA5EBxOrjlZyz/vpPqJAoZUFRonkBawST7GfcXcDuOWogC7Pi75k
         wDgoPOQa/rr2OfV53Ed2+8Giz+JHearKcPzindmKWkixJs5JJncDgM0/f9Yx+u5rWQGY
         WX/nLOIsWlkNOKsDIapWVW8IkcpL1Gscmxr/1NaIlNNlbvW1585K9oCLJEVV8rR+m0PT
         h53Q==
X-Forwarded-Encrypted: i=1; AKwUvBzoMTnLHRAcvWELvJVTty01yZ9gz5PmAVvuLaqNocFA+mPOh8t6GUImrvi5rzkNHiMcM5s=@vger.kernel.org
X-Gm-Message-State: AFuF++ndFnzCas77HxKXU0qx/4SsOjQsoaTk5D5szav96uxIn7jfGOXd
	5S+p7TJ/mKm1WqV27+VrKOWCm0fysrgEPC9ufCJML4hTTA5otQbapRs525Au4rxjbMKQkazC5lW
	ITSdOrA==
X-Received: from pjbem2.prod.google.com ([2002:a17:90b:142:b0:3a0:6f00:2a50])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:2f84:b0:39e:3221:aff5
 with SMTP id 98e67ed59e1d1-3a098608b12mr1720472a91.9.1790278824909; Thu, 24
 Sep 2026 12:40:24 -0700 (PDT)
Date: Thu, 24 Sep 2026 12:40:24 -0700
In-Reply-To: <arV6iiz4kB8LrByl@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260922001332.1121266-1-seanjc@google.com> <20260922001332.1121266-5-seanjc@google.com>
 <CAEvNRgH6w_a9+2rOr6r+47JqWc+-8cHq=c7r76nYG2i5deOxSg@mail.gmail.com>
 <arV4SS8FHwd6Qjs1@google.com> <arV6iiz4kB8LrByl@google.com>
Message-ID: <arV8qBw-aC5f2nUX@google.com>
Subject: Re: [PATCH v5 4/6] KVM: guest_memfd: Split bind() into
 prepare()+commit() phases
From: Sean Christopherson <seanjc@google.com>
To: Ackerley Tng <ackerleytng@google.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, David Hildenbrand <david@kernel.org>, kvm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Stefan Teodorescu <fane@google.com>, 
	Dennis Tighe <dtighe@google.com>, Sashiko Bot <sashiko-bot@kernel.org>, 
	Yan Zhao <yan.y.zhao@intel.com>
Content-Type: text/plain; charset="us-ascii"

On Thu, Sep 24, 2026, Sean Christopherson wrote:
> On Thu, Sep 24, 2026, Sean Christopherson wrote:
> > On Thu, Sep 24, 2026, Ackerley Tng wrote:
> > But after fiddling with this for an hour or so, I realized that if we fully commit
> > to configuring new.gmem in kvm_set_memory_region(), then we can move the prepare()
> > call into kvm_prepare_memory_region() without needing to plumb extra parameters,
> > and make the gmem stuff look a lot more like the rest of the memslot code.  E.g.
> > 
> > 	if (mem->flags & KVM_MEM_GUEST_MEMFD) {
> > #ifdef CONFIG_KVM_GUEST_MEMFD
> > 		new->gmem.file = fget(mem->guest_memfd);
> > 		if (!new->gmem.file) {
> > 			r = -EBADF;
> > 			goto out;
> > 		}
> > 
> > 		new->gmem.pgoff = mem->guest_memfd_offset >> PAGE_SHIFT;
> > #endif
> > 	}
> > 
> > 	r = kvm_set_memslot(kvm, old, new, change);
> > 
> > 	/*
> > 	 * Drop the reference to the gmem file, even on success.  The file pins
> > 	 * KVM, not the other way 'round.  Active bindings are invalidated if
> > 	 * the file is closed before memslots are destroyed.
> > 	 */
> > #ifdef CONFIG_KVM_GUEST_MEMFD
> > 	if (new->gmem.file)
> > 		fput(new->gmem.file);
> > #endif
> > 
> > Not being able to get rid of the #ifdefs is a shame, but from a control flow
> > perspective, this feels more right than anything else.  Full diff (not fully
> > tested, and would need to be split into 3+ patches):
> 
> Actually, plumbing in @old and @change can wait.  As much as I want to make the
> calls match the other prepare()+commit() hooks, @old and @change aren't needed
> until flags-only updates come along, and adding them at that time provide a better
> git history as the additional plumbing will directly precede their usage (or maybe
> even be in the same patch).

Aaaaand talking to myself again.  I take this back.  Plumbing in @change is
desirable, otherwise both kvm_set_memory_region() and kvm_prepare_memory_region()
need to check KVM_MR_CREATE, which is ugly and unnecessarily fragile.
