Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com [209.85.216.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 656CC35C19D
	for <kvm@vger.kernel.org>; Fri, 28 Aug 2026 18:17:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787941066; cv=none; b=oURUvDUbvvxNDjaZRsH76PUgDRDlXDXvPedJtPU6/7uO5RTq5tAN/D9gFIdmzPkujBxuth8nUTkTIyL834Neyia/3/3JptyYhaMpILqUb3aBWrOCMV9TiVkPk3NAddgQzJ2nKRxKvRFFlD8bTljoYLAZYRoYNN2Dv8itLtmLBuI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787941066; c=relaxed/simple;
	bh=wf4GFcwgFiZKi8h1HQtOMGSGi+wGJdBr+OaGETvTHCY=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=eAqNdoQR2qI/N8yR93yT2G+Fsb6R2iBUNe8n6zJ6xPQNoJkshHLXzpuWazdm3y631Cq/fUdtc6gNYyLXytZDx7a+5TyEUyslAq1Caj5KDfVGNdBC6oiMAOVuR0DNZ+ulCDVbXOfKr8DuxvmzTjOw9wBzIqw5u4jwTuJHFd5kt2k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=bCnjM+0l; arc=none smtp.client-ip=209.85.216.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="bCnjM+0l"
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-38f5ac7354dso2072743a91.1
        for <kvm@vger.kernel.org>; Fri, 28 Aug 2026 11:17:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1787941065; x=1788545865; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=EV21blSkqS4pBbf3co1T0g2dHUvrCRkk1EaQJh53qYs=;
        b=bCnjM+0lZHVbgGxq//3iPFlRF3s2rmEzSIB98fqvKxJ5+Ql8sRvUuqd2wG24zeU/wP
         Kg/oNKhO3287HhpQf6OfrX9rjhQCg9vQ/A7qz9GAkE0n8fl1DthQ6Bf0OlaRLziaGZCL
         eYyOC0Iv7Om+Es9l6Di8Kktn0IRTkInvMzoVIIPB2uo8yLM/CapLjDuobB5ujTkJS4ZW
         q/R47g2RUdn/J2oaJMqyFi9GCvNXgP+2XgLg30WgWj4Ivm5aYAfjPR9TBfy6QneWbDEK
         FXD4VTPBknOPQbJ5S6Xni6IpzGjvVihoIvb/M/ZLO3N5lF6fUSx+BvP9C8iXAkO5imzQ
         D5yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787941065; x=1788545865;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=EV21blSkqS4pBbf3co1T0g2dHUvrCRkk1EaQJh53qYs=;
        b=FLwp6AFAD35TaQLeHg66/Lo8NLw9sNZ6H20nNIQBvhNOLHaSqVenYkt1Gmfo5BG5SE
         5HaK4OT7ADxDFq4jVsF3gdM7Vbrw3gUrwW2jtCTtLLblTOC46atUVkUPJhlN1hR0OzbF
         KDC4ULr4anrhYmq/liMePIcDcDFdKmUJGLJASBF66fL31bM3pLIkVqR3SecSscjTcmRz
         2lwYV4KTDQOIe43+15zz52/CNvt3hAxYpaYVNYbMluLtmGx0+K+I3HTmGyKcTWjp4Pyh
         kYRDLrBLNDkBD6AzMKJ4kTAoXmkBk3GCuIf6CoZq/7PL6XOoEsrGbXrvtiJ0BU51Yb5C
         e8dA==
X-Forwarded-Encrypted: i=1; AKwUvBwARzsYEZmzNo7i86NZaQqxiR8pkEGSiYUU87lgWH6NkXamIUi8XFhn+UT2mmpc2Xx+nSs=@vger.kernel.org
X-Gm-Message-State: AFuF++m6QGPxQ2uxmtIu/Tr29u+16ZldaHvjvoMglXPF1KTyiTaOXH1e
	W2QDpbx0ZWfcgvfVAj8iLe9qlszy0kf5BnpBSit2OS9Qp0ztOSre84K51TnKXbn6EVDa8/Soqgg
	/AafDRQ==
X-Received: from pjtf12.prod.google.com ([2002:a17:90a:c28c:b0:38f:e6f2:5944])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:4a42:b0:37f:e326:6557
 with SMTP id 98e67ed59e1d1-396d0e7c071mr15682439a91.4.1787941064498; Fri, 28
 Aug 2026 11:17:44 -0700 (PDT)
Date: Fri, 28 Aug 2026 11:17:43 -0700
In-Reply-To: <apHCG78KyLuzPrNa@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <apCD3F3oOyC6E5oN@google.com> <20260828102728.1308266-1-zeng_chi911@163.com>
 <apHCG78KyLuzPrNa@google.com>
Message-ID: <apHQxz5fCPf6JQAg@google.com>
Subject: Re: [PATCH v2] KVM: Don't treat reserved xarray entries as having
 memory attributes
From: Sean Christopherson <seanjc@google.com>
To: Zeng Chi <zeng_chi911@163.com>
Cc: chao.p.peng@linux.intel.com, kvm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, pbonzini@redhat.com, zengchi@kylinos.cn
Content-Type: text/plain; charset="us-ascii"

On Fri, Aug 28, 2026, Sean Christopherson wrote:
> So after way, waaay too much fiddling, this?  As a bonus, the changelog can call
> out that xas_next_entry() is essentially an optimized version of xas_find(),
> e.g. to communicate that the effective diff is actually just adding xas_retry().
> 
> diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
> index 65eb26a0520d..cc94d9881582 100644
> --- a/virt/kvm/kvm_main.c
> +++ b/virt/kvm/kvm_main.c
> @@ -2447,14 +2447,39 @@ bool kvm_range_has_memory_attributes(struct kvm *kvm, gfn_t start, gfn_t end,
>  		return (kvm_get_memory_attributes(kvm, start) & mask) == attrs;
>  
>  	guard(rcu)();
> -	if (!attrs)
> -		return !xas_find(&xas, end - 1);
>  
> +	/*
> +	 * Lookup the entry for each index instead of iterating over the xarray
> +	 * as KVM deletes/nullifies entries to represent "no attributes", and
> +	 * the xas index is effectively invalid when no entry is found.  I.e.
> +	 * matching non-zero attributes for *every* entry effectively requires
> +	 * a manually lookup for each index.
> +	 *
> +	 * Skip pre-allocated, reserved entries, or restart the lookup if the
> +	 * xarray was concurrently modified, via xas_retry() ("retry" means the
> +	 * entry holds an internal xarray value, i.e. is either invalid or NULL
> +	 * from the caller's perspective.
> +	 *
> +	 * Use xas_next() when looking for non-zero attributes to optimize for
> +	 * the case where the start of the range (or the entire range) doesn't
> +	 * have any attributes, as xas_next() returns literally the next entry,
> +	 * whereas xas_next_entry() returns the next non-NULL entry (bounded by
> +	 * a maximum index).
> +	 */
>  	for (index = start; index < end; index++) {
>  		do {
> -			entry = xas_next(&xas);
> +			entry = attrs ? xas_next(&xas) :
> +					xas_next_entry(&xas, end - 1);
>  		} while (xas_retry(&xas, entry));
>  
> +		/*
> +		 * Don't check the index if there's no entry; as above, the xas
> +		 * index is invalid (and if no entry was found, then the entire
> +		 * range has no attributes).
> +		 */
> +		if (!entry)
> +			return !attrs;

One "flaw" with this exact code is that if KVM managed to get a non-null, '0'
entry into the xarray, the index check could mismatch and this function could
technically get a false negative.

Swapping the checks would also work:

		if (!attrs)
			return !entry;

but I don't love that that violates the "don't check the index because it's bogus"
statement above.  And practically speaking, KVM should *never* observe a non-NULL
entry with a value of zero, assuming xas_retry() works as I think it does.  So to
harden against KVM changes/goofs, maybe do this as well?

diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
index cc94d9881582..f009cb3e687d 100644
--- a/virt/kvm/kvm_main.c
+++ b/virt/kvm/kvm_main.c
@@ -2480,6 +2480,8 @@ bool kvm_range_has_memory_attributes(struct kvm *kvm, gfn_t start, gfn_t end,
 		if (!entry)
 			return !attrs;
 
+		WARN_ON_ONCE(!xa_to_value(entry));
+
 		if (xas.xa_index != index ||
 		    (xa_to_value(entry) & mask) != attrs)
 			return false;


> +
>  		if (xas.xa_index != index ||
>  		    (xa_to_value(entry) & mask) != attrs)
>  			return false;
> 
