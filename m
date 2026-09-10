Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com [209.85.216.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 548874FB9C9
	for <kvm@vger.kernel.org>; Thu, 10 Sep 2026 16:30:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789057827; cv=none; b=gZy8kv6GN9D1xKLtSCt/B5t/rzr9oX07diyLU/alTvc8ZfoQwISgQ7bTqYMn1l/3CmJzrEf0IH/VMC1yuzTxiJLOm4LlX5Ma7oU2MpPxlresXFb7LxMbhDOVVYG7xPrd7BqP+r87ldCk6BynLdFoOk+j62UxoGaJVlonn7T+w2g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789057827; c=relaxed/simple;
	bh=wZ3LykXDLiXZdcN2B90HGOb4AiKilHNsRIIn78r352U=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=X6FE4J7SvxHtrKlLNW2BCPWBsMS0DtqEqgotIJJYXA3yPx1i8eANR9CJ7uDeJgTQiYPDIrcTZ4fYDZ9wD3tG/Eh8Cq+eIBGy8SYrQIzVuy2hvdKdRHYWi1SYmBWUVtinLZjew9F/rOFe9qwb6IBcjUBhLl6OWUcTrYQlER4sJ7g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=U49mev5Q; arc=none smtp.client-ip=209.85.216.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="U49mev5Q"
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-39aee9b4cf2so11757029a91.0
        for <kvm@vger.kernel.org>; Thu, 10 Sep 2026 09:30:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1789057824; x=1789662624; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=VnJnwdOYGIGCcjx8YGUUXxvfpBjYI69LyTf3vI3u8ek=;
        b=U49mev5Qh4L2dNyaLHKWR51jr7ucv9HSEXXNNgPRNHeAweqUbvN/QyuY74gWgKQpUW
         PsBlEnEOBPy6moNn+B28WZ7JLUA0bI9sjer99mM9NEB5Zsvd/moxucnzWL9qMNkNgnvC
         DuYG7p48buLQNORzABL1o8tjpJdkXbvq5QbA4dwzOLaXfoCDzURa8V3IX8AvPdfe83fS
         GFQvs+am9MUaZvK6N1mtc7wQoDGG1cHOeppfK+RWN52o/ikWjXUPG9g7V7PL9EVjEkFE
         ZR0msZ+N8Q0IXrBiA4NN6GNb0NHNnvcMNwm+5Im4Lhsfgef0zSZG9gHd5/qvlKDrfnAt
         O1Nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789057824; x=1789662624;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=VnJnwdOYGIGCcjx8YGUUXxvfpBjYI69LyTf3vI3u8ek=;
        b=HItnlKW0X1+eD8/4iGm5zcKxw/BbNW5z/IiFilODH1Odj9Yupnzdmboi0Yby2FK525
         no5vB6Wio7Y1vLTeN/AKOfwhSiaF3x1SW1jUG4VZwgCPbCTaavgj8+3vPcrJECjJNaaZ
         P4/BnBJX6inxYDkBPYg9z1M9WJsGRW3uiRfwsFhFSEBwHFK0AOnGeRHcWEEuEmkd7gZP
         ntMdPTTXQgUfkE4WPEF13N26e7CsRYTQyAIBiFou8S3DaifcYpMyInJqBurVrjZ+JZDn
         HQJKCrqyOTTTpCUdayAYKo3zp037UZBkAakx5QYR2XMLIYZO3dnZaCzysRS5362AO+bS
         cyaA==
X-Forwarded-Encrypted: i=1; AKwUvBy7kJ7IEoMCwfH7TSly73Vfw//Hvbh3lGC+PBx6hapTOzC3BXdsS8aGYMpWllkyLRilNRU=@vger.kernel.org
X-Gm-Message-State: AFuF++mw7wOHGqQsQ6rBLYNduiGE/jqpl4XFloHj52cT2GHTA8I4SIBZ
	75AJjhWm6qV7EldIIMZzJ/48IL0HNgbwojNFx3O/GqG8lL8Tgpf+mGvx/XKYfH96hUpdnDic/h0
	qlQSxgQ==
X-Received: from pjbdw14.prod.google.com ([2002:a17:90b:94e:b0:39d:631c:22bf])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90a:64f:b0:39d:83d0:41b2
 with SMTP id 98e67ed59e1d1-39d83d046d3mr3518065a91.15.1789057823466; Thu, 10
 Sep 2026 09:30:23 -0700 (PDT)
Date: Thu, 10 Sep 2026 09:30:22 -0700
In-Reply-To: <20260910162343.4092060-3-elver@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260910162343.4092060-1-elver@google.com> <20260910162343.4092060-3-elver@google.com>
Message-ID: <aqLbHvD5lqQP8PRd@google.com>
Subject: Re: [PATCH RFC 02/10] KVM: Allow reading memslots while holding slots_arch_lock
From: Sean Christopherson <seanjc@google.com>
To: Marco Elver <elver@google.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, 
	Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	"H. Peter Anvin" <hpa@zytor.com>, Vitaly Kuznetsov <vkuznets@redhat.com>, Kiryl Shutsemau <kas@kernel.org>, 
	Rick Edgecombe <rick.p.edgecombe@intel.com>, David Hildenbrand <david@kernel.org>, kvm@vger.kernel.org, 
	linux-coco@lists.linux.dev, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"

On Thu, Sep 10, 2026, Marco Elver wrote:
> kvm_swap_active_memslots() updates kvm->memslots[as_id] while holding both
> kvm->slots_lock and kvm->slots_arch_lock. Holding either lock guarantees
> that memslots cannot be concurrently modified.

Sure, but that's irrelevant.  The goal of the srcu_dereference_check() is to
ensure that readers see a stable view of the VM's overall memory, not simply that
kvm->memslots can't be written.

> Allow reading memslots in __kvm_memslots() when kvm->slots_arch_lock is
> held.

Why?

> 
> Signed-off-by: Marco Elver <elver@google.com>
> ---
>  include/linux/kvm_host.h | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/include/linux/kvm_host.h b/include/linux/kvm_host.h
> index 03bfc92864b6..5ed8260ef01f 100644
> --- a/include/linux/kvm_host.h
> +++ b/include/linux/kvm_host.h
> @@ -1089,6 +1089,7 @@ static inline struct kvm_memslots *__kvm_memslots(struct kvm *kvm, int as_id)
>  	as_id = array_index_nospec(as_id, KVM_MAX_NR_ADDRESS_SPACES);
>  	return srcu_dereference_check(kvm->memslots[as_id], &kvm->srcu,
>  			lockdep_is_held(&kvm->slots_lock) ||
> +			lockdep_is_held(&kvm->slots_arch_lock) ||
>  			!refcount_read(&kvm->users_count));
>  }
>  
> -- 
> 2.55.0.1003.g10538fe699-goog
> 
