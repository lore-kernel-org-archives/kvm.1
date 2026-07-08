Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 520933F12C3
	for <kvm@vger.kernel.org>; Wed,  8 Jul 2026 15:23:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783524220; cv=none; b=CFxkDTRmHLySkryZvGqYeWEIqgwV8nhhtbg0jr8ZzCFDIwjkSCzRZj7A5HfKdH1VihQHTACgJJL6ZoPNL1uq9360DmTdOkqOPwLRPjzugTD7DJWVGAs7lL+z25W67NefcT4Spk7uliLx4CdUSDVkJKcLhj3Wr14uCHlLkIQ0EFU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783524220; c=relaxed/simple;
	bh=5CF+6Q7urA9Z5MQWXr/as2hcEkFvUylNo6DPZfCqww0=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=qS16Vt+I/HPJJJq8jKwBaK8mao9HfgdgyVyLJIerpb3GDM+F/zmo6T10/+yX0tV03UXr01PPkKQgYmLcEZ5ZRxsFob0pAQIi+xLSXmnZT4jDLlJfPrGbKtqYsa00NQyBnZp8KjZzr1CrvxBRy4DLqglfsGj1JfgmIm738iXMkso=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=LvD5A+27; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="LvD5A+27"
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-2c6bbd0afffso15396235ad.0
        for <kvm@vger.kernel.org>; Wed, 08 Jul 2026 08:23:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1783524218; x=1784129018; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=rRKgJkfMnsU7roGF3flBWPx+LAvOHI3FSDNy7Xjz8Wk=;
        b=LvD5A+27Pif0yJ70M2bIIBoJD7dLw95mDK2n+4xAsiTNnMmXMDBo4W61QiI9kUk3OV
         osak6+Bma52rrANVshhBywpvgJ/FO3sWSNTrHEWaCmhHxUNwRVQ3jZSnCPMBdsWlezH8
         ilc0ZrSHguLsDDKiCzZPDVz2/X98Zx5ZAehc/PwLDnJW8TxZSVBXaqx8w3tcaUCnWPVi
         zQUes9Pbl7lU8AG+nHYdhLaYk93C2VWI89GMg+X0rYNy3Gk8s7w2hxdVzsrwCI7A2yt6
         l0x6lHDvDmpelOPEjv1BjwencXL7/j2BjKLEZhu1jjzxLq2oWfaGWuCOmHH3C4TsDP9g
         a7pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783524218; x=1784129018;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=rRKgJkfMnsU7roGF3flBWPx+LAvOHI3FSDNy7Xjz8Wk=;
        b=cUi6iAUWSJUdEXqsZSgaJJLxzFpFrqNQJ1gjX+N/qgGaMT70g9URmvp5TEqXvkrPpA
         9hKrkgHtmmw3hOMXXmmC16Wltoqisd+ElenLi7vBX1sKYTFJo7RrWKUpaHv/hv3OHJAK
         3+lu56iyoLyt9+FA9a1tT5DSCE8iJBdBN+82NIz0GomwouD7C+JGSJ94BMI2GciuPAJ5
         Bn8FRm7ffEz8frUkA+BnCOro4hAwliDyFucb5ZuxM7pQyZKVUxsjqcOifPBu0zJ1rSkO
         mdikHp+T3MqgfUOqSW5MFR4Z4n5bnY0f5JAV5y20qmAP+dJgBDKFU1qgOQjPakIjnbmJ
         Cp8g==
X-Forwarded-Encrypted: i=1; AHgh+Rrfx1K4fe/QxPWCu4b7YF8//zb4eilwDpJSjQKfLk/ym3T2NZ8rZkD4K2p3JrmNz5S1I9g=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzq0k2NBPUKjM7vNolJpz6zCwW3tKnQazzbO5jQFctKP/HtVh/i
	7iLe1UyV034PN+4Du7Gb59rlKp8gCbbl93R84zIQ3Il3KyxPzst5GqyftfcNO+C+yAznaw5G2Wc
	ojpVjgg==
X-Received: from plim18.prod.google.com ([2002:a17:903:3b52:b0:2ca:ceab:34a3])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:2447:b0:2ca:619f:9733
 with SMTP id d9443c01a7336-2ccea3c0f1bmr31966755ad.17.1783524217234; Wed, 08
 Jul 2026 08:23:37 -0700 (PDT)
Date: Wed, 8 Jul 2026 08:23:36 -0700
In-Reply-To: <20260605143034.3603-9-dwmw2@infradead.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260605143034.3603-1-dwmw2@infradead.org> <20260605143034.3603-9-dwmw2@infradead.org>
Message-ID: <ak5reLzVpGuVJtEH@google.com>
Subject: Re: [PATCH 8/8] KVM: x86/xen: Use 32-bit locked ops in kvm_xen_inject_pending_events()
From: Sean Christopherson <seanjc@google.com>
To: David Woodhouse <dwmw2@infradead.org>
Cc: Paul Durrant <paul@xen.org>, Hyunwoo Kim <imv4bel@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>, 
	Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	"H. Peter Anvin" <hpa@zytor.com>, kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"

On Fri, Jun 05, 2026, David Woodhouse wrote:
> From: David Woodhouse <dwmw@amazon.co.uk>
> 
> The 64-bit path in kvm_xen_inject_pending_events() uses 'lock orq' and
> 'lock andq' on vcpu_info->evtchn_pending_sel. If the vcpu_info was
> registered with only 4-byte alignment (valid for a 32-bit guest that
> later switches to 64-bit mode), this 8-byte locked operation can cause
> split-lock #AC exceptions on hosts with split_lock_detect=fatal.
> 
> Use the original 64-bit atomics when the vcpu_info is 8-byte aligned
> (the common case). Fall back to a 32-bit loop for the rare case where
> vcpu_info was registered at only 4-byte alignment. For compat guests
> (32-bit evtchn_pending_sel) the loop executes once. For native guests
> it executes a second iteration only if the high half has bits to
> deliver.
> 
> Fixes: 14243b387137 ("KVM: x86/xen: Add KVM_IRQ_ROUTING_XEN_EVTCHN and event channel delivery")
> Reported-by: sashiko-bot@kernel.org
> Assisted-by: Kiro:claude-opus-4.6-1m
> Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
> ---
>  arch/x86/kvm/xen.c | 63 ++++++++++++++++++++++++++++++++--------------
>  1 file changed, 44 insertions(+), 19 deletions(-)
> 
> diff --git a/arch/x86/kvm/xen.c b/arch/x86/kvm/xen.c
> index 24e939ef5d64..e7b0263d5143 100644
> --- a/arch/x86/kvm/xen.c
> +++ b/arch/x86/kvm/xen.c
> @@ -638,11 +638,17 @@ void kvm_xen_inject_vcpu_vector(struct kvm_vcpu *v)
>   */
>  void kvm_xen_inject_pending_events(struct kvm_vcpu *v)
>  {
> -	unsigned long evtchn_pending_sel = READ_ONCE(v->arch.xen.evtchn_pending_sel);
>  	struct gfn_to_pfn_cache *gpc = &v->arch.xen.vcpu_info_cache;
> +	bool has_64bit_shinfo = kvm_xen_has_64bit_shinfo(v->kvm);
> +	union evtchn_pending_sel {
> +		u64 sel64;
> +		u32 sel32[2];
> +	} pending, *sel_addr;
> +	struct vcpu_info *vi;
>  	unsigned long flags;
>  
> -	if (!evtchn_pending_sel)
> +	pending.sel64 = READ_ONCE(v->arch.xen.evtchn_pending_sel);
> +	if (!pending.sel64)
>  		return;
>  
>  	/*
> @@ -661,31 +667,50 @@ void kvm_xen_inject_pending_events(struct kvm_vcpu *v)
>  	}
>  
>  	/* Now gpc->khva is a valid kernel address for the vcpu_info */
> -	if (kvm_xen_has_64bit_shinfo(v->kvm)) {
> -		struct vcpu_info *vi = gpc->khva;
> +	vi = gpc->khva;
> +	sel_addr = gpc->khva + (has_64bit_shinfo ?
> +				offsetof(struct vcpu_info, evtchn_pending_sel) :
> +				offsetof(struct compat_vcpu_info, evtchn_pending_sel));
>  
> +	if (has_64bit_shinfo && IS_ALIGNED((unsigned long)sel_addr, sizeof(u64))) {
> +		/*
> +		 * 64-bit shinfo with 8-byte aligned vcpu_info (the common
> +		 * case): use a single 64-bit atomic.

Nit, the "single 64-bit atomic" is confusing because there are obviously two
atomic operations in the assembly below.

> +		 */
>  		asm volatile(LOCK_PREFIX "orq %0, %1\n"
>  			     "notq %0\n"
>  			     LOCK_PREFIX "andq %0, %2\n"
> -			     : "=r" (evtchn_pending_sel),
> -			       "+m" (vi->evtchn_pending_sel),
> +			     : "=r" (pending.sel64),
> +			       "+m" (sel_addr->sel64),
>  			       "+m" (v->arch.xen.evtchn_pending_sel)
> -			     : "0" (evtchn_pending_sel));
> -		WRITE_ONCE(vi->evtchn_upcall_pending, 1);
> +			     : "0" (pending.sel64));
>  	} else {
> -		u32 evtchn_pending_sel32 = evtchn_pending_sel;
> -		struct compat_vcpu_info *vi = gpc->khva;
> -
> -		asm volatile(LOCK_PREFIX "orl %0, %1\n"
> -			     "notl %0\n"
> -			     LOCK_PREFIX "andl %0, %2\n"
> -			     : "=r" (evtchn_pending_sel32),
> -			       "+m" (vi->evtchn_pending_sel),
> -			       "+m" (v->arch.xen.evtchn_pending_sel)
> -			     : "0" (evtchn_pending_sel32));
> -		WRITE_ONCE(vi->evtchn_upcall_pending, 1);
> +		/*
> +		 * Use 32-bit operations to avoid splitlock on a vcpu_info
> +		 * that is only 4-byte aligned (registered in 32-bit mode).
> +		 * The loop copes with the extremely rare case that the
> +		 * vcpu_info was registered in 32-bit mode and only enforced
> +		 * 4-byte alignment, and then the VM was latched to 64-bit
> +		 * mode afterwards. Which Xen tolerates, so so should KVM.
> +		 */
> +		int i = 0;
> +		do {
> +			asm volatile(LOCK_PREFIX "orl %0, %1\n"
> +				     "notl %0\n"
> +				     LOCK_PREFIX "andl %0, %2\n"
> +				     : "=r" (pending.sel32[i]),
> +				       "+m" (sel_addr->sel32[i]),
> +				       "+m" (((u32 *)&v->arch.xen.evtchn_pending_sel)[i])
> +				     : "0" (pending.sel32[i]));
> +			i++;
> +		} while (has_64bit_shinfo && i < 2 && pending.sel32[i]);

This is... impressive?  Related to the above comment about there being two separate
atomic operation, only the access to vi->evtchn_pending_sel needs to deal with
potential split-lock issues.  And there's zero to handle the NOT in the asm blob.

Rather than munge the 32-bit and 64-bit cases together, just manually handle the
case where the bitwise-OR needs to be chunked in two.

--
From: Sean Christopherson <seanjc@google.com>
Date: Wed, 8 Jul 2026 08:09:19 -0700
Subject: [PATCH] KVM: x86/xen: Use 32-bit atomics if vCPU's evtchn_pending_sel
 isn't aligned

When propagating pending Xen events from KVM's "cache" to the guest-visible
structure, use two 32-bit atomic operations to do the bitwise-OR into the
guest-controlled structure if the structure isn't 64-bit aligned, i.e. if
the guest registered its vcpu_info in 32-bit mode and then switched to
64-bit mode, in which case using a 64-bit atomic OR will generate a
split-lock #AC (if enabled).

Opportunistically isolate the clearing of the bits from KVM's cache, as
that structure is KVM-controlled, i.e. is guaranteed to be 64-bit aligned.
This will allow dropping the open-coded inline asm blobs in the future.

Fixes: 14243b387137 ("KVM: x86/xen: Add KVM_IRQ_ROUTING_XEN_EVTCHN and event channel delivery")
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/xen.c | 22 +++++++++++++++-------
 1 file changed, 15 insertions(+), 7 deletions(-)

diff --git a/arch/x86/kvm/xen.c b/arch/x86/kvm/xen.c
index 24e939ef5d64..7a7f90710847 100644
--- a/arch/x86/kvm/xen.c
+++ b/arch/x86/kvm/xen.c
@@ -664,13 +664,21 @@ void kvm_xen_inject_pending_events(struct kvm_vcpu *v)
 	if (kvm_xen_has_64bit_shinfo(v->kvm)) {
 		struct vcpu_info *vi = gpc->khva;
 
-		asm volatile(LOCK_PREFIX "orq %0, %1\n"
-			     "notq %0\n"
-			     LOCK_PREFIX "andq %0, %2\n"
-			     : "=r" (evtchn_pending_sel),
-			       "+m" (vi->evtchn_pending_sel),
-			       "+m" (v->arch.xen.evtchn_pending_sel)
-			     : "0" (evtchn_pending_sel));
+		if (IS_ALIGNED((unsigned long)&vi->evtchn_pending_sel, sizeof(u64)))
+			asm volatile(LOCK_PREFIX "orq %[src], %[dst]\n"
+				     : [dst] "+m" (vi->evtchn_pending_sel)
+				     : [src] "r" (evtchn_pending_sel));
+		else
+			asm volatile(LOCK_PREFIX "orl %[src_lo], %[dst_lo]\n"
+				     LOCK_PREFIX "orl %[src_hi], %[dst_hi]\n"
+				     : [dst_lo] "+m" (vi->evtchn_pending_sel),
+				       [dst_hi] "+m" (*(((u32 *)&vi->evtchn_pending_sel) + 1))
+				     : [src_lo] "r" ((u32)evtchn_pending_sel),
+				       [src_hi] "r" ((u32)(evtchn_pending_sel >> 32)));
+
+		asm volatile(LOCK_PREFIX "andq %1, %0\n"
+			     : "+m" (v->arch.xen.evtchn_pending_sel)
+			     : "r" (~evtchn_pending_sel));
 		WRITE_ONCE(vi->evtchn_upcall_pending, 1);
 	} else {
 		u32 evtchn_pending_sel32 = evtchn_pending_sel;

base-commit: 0c393754b28263323bed3ac091744ff8456c97d0
-- 

And then as a follow-up, drop the inline asm:

--
From: Sean Christopherson <seanjc@google.com>
Date: Wed, 8 Jul 2026 08:16:22 -0700
Subject: [PATCH] KVM: x86/xen: Use atomic*() APIs instead of open coded
 equivalents

Replace the open coded atomic asm blobs in the Xen event injection code
with equivalent atomic{,64}_xxx() operations.  Casting the event channel
to atomic types is ugly, but not as ugly as asm blobs.

No functional change intended.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/xen.c | 32 ++++++++++----------------------
 1 file changed, 10 insertions(+), 22 deletions(-)

diff --git a/arch/x86/kvm/xen.c b/arch/x86/kvm/xen.c
index 7a7f90710847..94d1644ca6d1 100644
--- a/arch/x86/kvm/xen.c
+++ b/arch/x86/kvm/xen.c
@@ -663,34 +663,22 @@ void kvm_xen_inject_pending_events(struct kvm_vcpu *v)
 	/* Now gpc->khva is a valid kernel address for the vcpu_info */
 	if (kvm_xen_has_64bit_shinfo(v->kvm)) {
 		struct vcpu_info *vi = gpc->khva;
+		void *vi_pending_sel = &vi->evtchn_pending_sel;
 
-		if (IS_ALIGNED((unsigned long)&vi->evtchn_pending_sel, sizeof(u64)))
-			asm volatile(LOCK_PREFIX "orq %[src], %[dst]\n"
-				     : [dst] "+m" (vi->evtchn_pending_sel)
-				     : [src] "r" (evtchn_pending_sel));
-		else
-			asm volatile(LOCK_PREFIX "orl %[src_lo], %[dst_lo]\n"
-				     LOCK_PREFIX "orl %[src_hi], %[dst_hi]\n"
-				     : [dst_lo] "+m" (vi->evtchn_pending_sel),
-				       [dst_hi] "+m" (*(((u32 *)&vi->evtchn_pending_sel) + 1))
-				     : [src_lo] "r" ((u32)evtchn_pending_sel),
-				       [src_hi] "r" ((u32)(evtchn_pending_sel >> 32)));
+		if (IS_ALIGNED((unsigned long)vi_pending_sel, sizeof(u64))) {
+			atomic64_or(evtchn_pending_sel, vi_pending_sel);
+		} else {
+			atomic_or(evtchn_pending_sel, vi_pending_sel);
+			atomic_or(evtchn_pending_sel >> 32, vi_pending_sel + 4);
+		}
 
-		asm volatile(LOCK_PREFIX "andq %1, %0\n"
-			     : "+m" (v->arch.xen.evtchn_pending_sel)
-			     : "r" (~evtchn_pending_sel));
+		atomic64_andnot(evtchn_pending_sel, (void *)&v->arch.xen.evtchn_pending_sel);
 		WRITE_ONCE(vi->evtchn_upcall_pending, 1);
 	} else {
-		u32 evtchn_pending_sel32 = evtchn_pending_sel;
 		struct compat_vcpu_info *vi = gpc->khva;
 
-		asm volatile(LOCK_PREFIX "orl %0, %1\n"
-			     "notl %0\n"
-			     LOCK_PREFIX "andl %0, %2\n"
-			     : "=r" (evtchn_pending_sel32),
-			       "+m" (vi->evtchn_pending_sel),
-			       "+m" (v->arch.xen.evtchn_pending_sel)
-			     : "0" (evtchn_pending_sel32));
+		atomic_or(evtchn_pending_sel, (void *)&vi->evtchn_pending_sel);
+		atomic_andnot(evtchn_pending_sel, (void *)&v->arch.xen.evtchn_pending_sel);
 		WRITE_ONCE(vi->evtchn_upcall_pending, 1);
 	}
 

base-commit: f7a8319462668aa415333f2853b70eb82ea17f34
--
