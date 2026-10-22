Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.70
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792689690;
	b=vBbTA+5oqXboSb7YwnQqt+nFPJI1xmqfC1o4uqYbphExx74z7VuNq6duhd7jRH0TiIiH
	 rcp1SHtJejz7fDKIHb3SwwgA2DVC8jrdFCTPH1BRDq6DdT4b7b1C1v5YTvdTd18ZQCDhu
	 /j4GWbf8uUomZRz44ZVeWQlThhDRG8TtGuoVDTFli105lMvjariLY4GBt326keieIDaR6
	 JDSQ1PMfUOmwVOC9MokfRgQn2ohRWRr0cZjFrBLTcVdjDyfQacqmG7Ute7qa1nrsqPe3A
	 DWIVUx8/aBYF4U+zQ8cUDFdNq7dovNypPXckkRd6T9zpl220pavFW0Z+PRGws1TwFig==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792689690;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:Message-ID:Subject:From:To:Cc:Content-Type;
	bh=OgThn990Yb6qPgczIQMhrPZJbCH52JyOkasQf7xIIHE=;
	b=UPyWUMA4k69uYO6cyOtLGrV3Kg834NlWOCnbVCA+vbGQuytdCfpjFiP6AK6WbyW+YkSW
	 8a1vAoYbgbb97oO5n5bGVgpTAQWmxT5l9ykuXUbF/g7JIgC52svqPklRzXEa3jERfZBsX
	 cKBUfVTrZEwRR5qODw1bVEdlw6RR20AZWXSGaWZUj19N+IZNACdLvF/aLogsaYLeI2pO8
	 FvueeSDJ6e0hSbLJWqqy/KYRRkydkFO5lzi44z1pG+pvvKF9CPySbS3e6ZvXWLoYEjnEc
	 E+5vsnb7HzWscbgQ839CVM62Qy7Q3vvpDt8Nq8gxY1Q2w4OqZosGT6wr2ORt7/vLzrg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=m4Bulbhs;
	arc=none smtp.remote-ip=209.85.216.70
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com [209.85.216.70])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9F8C606A31B
	for <kvm@vger.kernel.org>; Thu, 22 Oct 2026 17:21:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B9F8C606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=m4Bulbhs
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-39de4e72b33so79463a91.2
        for <kvm@vger.kernel.org>; Thu, 22 Oct 2026 10:21:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1792689689; x=1793294489; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=OgThn990Yb6qPgczIQMhrPZJbCH52JyOkasQf7xIIHE=;
        b=m4BulbhsUgzW7fFrghGkBQI4hNRW+0wNDCo+Klfcyfir8ATNfqGIIryeb7JeKert4b
         Y9jaasJzOSpDCqe4UCHnwfcYQnB7d6R1njKiYhmTUzlAYUIy6rgQ7CDf7ScjX/Fpb9OR
         6CWVMdtNnC6bA143Ui9Na0GtKGkVkidC54b8Lu0bxfCZWY1e6308iwBc3rQvhOU9U3UE
         STqw6IRa1eAf9KJ8iWTfYgSDm60EnQEvKUIiy1sRxFqnN/vdrqYd4efkbi+ktLqNE43b
         dGULfIJG8OYhfD8gVF4wEidZP5qxythYMDc02jQqWl152kJTKT8zAnlAMhVAbNyl/lHc
         v2Ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792689689; x=1793294489;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=OgThn990Yb6qPgczIQMhrPZJbCH52JyOkasQf7xIIHE=;
        b=M36XtD+n7PQ3M+eYFYYmOP7ZVhy9mjD1k/nVB1+q5cgmTdHwLg66pGWDQTn/if9+Zh
         QdXydXjVG7XU1iWJ6zQeDkb6qVsCnsNcf2z9BOhTAfzl68u6iTcMYGY8O5Xf6OUd6MqI
         G2Avv0R+N6P151UegdRk/C6CgNNjLiOThE4fdu9gAbppgZD+5dLppyj37PUSzuOLed8C
         I0xbQkrL6NPTNqDvP3Kzuq4+EP4nNvfJc11L/+bFPpFjH9FoEMkX/ImFIiPlqh31bcya
         DqUb9CzdB1jCtvjTcUo9iub9aSvNxx784diwQtvTH4YXS6x0fxfwjml0gcUvG6y7WURD
         Zodw==
X-Forwarded-Encrypted: i=1; AKwUvBxW9QCJVYvSbkpTikFM+rgcWK7CbI0w7KF0oWLrgkC10lot1PqOwgPvN8WoORrB/qTf9HI=@vger.kernel.org
X-Gm-Message-State: AFq9FYLkrWtjyVNfoNd1qBZfTh7OaYufzvfkf5AlDabNaFjXhhQFpCpr
	ItO+zE6oqHsTF2WuyKcB/Td5b4E8eRJR3wPC7J4PBo15eQwHOMn4lJnVxSOYnJ+b7PssXbn7Uo6
	9uM4DRg==
X-Received: from pjbnc3.prod.google.com ([2002:a17:90b:37c3:b0:3ac:4c80:15de])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90a:dfcb:b0:3ab:d45c:59da
 with SMTP id 98e67ed59e1d1-3ad86f717fcmr4648988a91.40.1792689688890; Thu, 22
 Oct 2026 10:21:28 -0700 (PDT)
Date: Thu, 22 Oct 2026 10:21:28 -0700
In-Reply-To: <20261016235221.33726-2-amirmohammad.eftekhar@cispa.de>
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <20261016235221.33726-2-amirmohammad.eftekhar@cispa.de>
Message-ID: <atpGGKVAL3bAnmnk@google.com>
Subject: Re: [PATCH] KVM: nSVM: Reset the virtual VMLOAD/VMSAVE bit in vmcb02
 on every nested VMRUN
From: Sean Christopherson <seanjc@google.com>
To: Amirmohammad Eftekhar <amirmohammad.eftekhar@cispa.de>
Cc: pbonzini@redhat.com, kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Yosry Ahmed <yosry@kernel.org>, Jim Mattson <jmattson@google.com>
Content-Type: text/plain; charset="us-ascii"

+Yosry and Jim

On Sat, Oct 17, 2026, Amirmohammad Eftekhar wrote:
> The SVM_MISC2_ENABLE_V_VMLOAD_VMSAVE (VLS) bit in
> vmcb02->control.misc_ctl2 is OR-set in nested_vmcb02_prepare_control()
> when L2 is allowed to use virtual VMLOAD/VMSAVE, but it is never reset.
> vmcb02 is a persistent per-vCPU structure reused across nested VMRUNs,
> so once one nested entry enables VLS the bit leaks into every later
> entry -- including entries where vmcb12 has VLS cleared and L1 has asked
> KVM to intercept VMLOAD/VMSAVE.  Per AMD's APM, virtual VMLOAD/VMSAVE is
> honored over the VMLOAD/VMSAVE intercepts, so with the stale bit set
> L2's VMLOAD/VMSAVE are virtualized and run without a #VMEXIT, and the
> intercept L1 explicitly requested is silently dropped.
> 
> misc_ctl is reset from vmcb01 a few lines earlier; misc_ctl2's VLS bit
> has no equivalent reset.  The only writes to misc_ctl2 are this OR-set,
> the vmcb01 init OR-set, and the independent V_LBR (bit 0) set/clear, so
> nothing clears bit 1 between entries.  nested_vmcb02_recalc_intercepts()
> sets INTERCEPT_VMLOAD/VMSAVE when nested_vmcb_needs_vls_intercept() is
> true and otherwise only WARNs on the reverse condition; it never catches
> the real hazard of VLS on while the intercept is also set.
> 
> Reset the VLS bit before the conditional set, mirroring misc_ctl, and
> add a forward WARN so a future regression trips immediately.
> 
> This is distinct from CVE-2021-3656 (single-VMRUN under-sanitization of
> a VLS bit L1 set in vmcb12 without being granted the feature); here L1
> is granted VLS and uses it legitimately, and the bit goes stale across
> VMRUNs.
> 
> Signed-off-by: Amirmohammad Eftekhar <amirmohammad.eftekhar@cispa.de>
> ---
>  arch/x86/kvm/svm/nested.c | 15 +++++++++++++++
>  1 file changed, 15 insertions(+)
> 
> diff --git a/arch/x86/kvm/svm/nested.c b/arch/x86/kvm/svm/nested.c
> index af0ef6784..65e61b796 100644
> --- a/arch/x86/kvm/svm/nested.c
> +++ b/arch/x86/kvm/svm/nested.c
> @@ -197,6 +197,14 @@ void nested_vmcb02_recalc_intercepts(struct vcpu_svm *svm)
>  	} else {
>  		WARN_ON_ONCE(!(vmcb02->control.misc_ctl2 & SVM_MISC2_ENABLE_V_VMLOAD_VMSAVE));
>  	}
> +
> +	/*
> +	 * If KVM is intercepting VMLOAD/VMSAVE, virtual VMLOAD/VMSAVE must be
> +	 * off, or hardware would honor the virtualization and render the
> +	 * intercept inert.
> +	 */
> +	WARN_ON_ONCE(vmcb_is_intercept(&vmcb02->control, INTERCEPT_VMLOAD) &&
> +		     (vmcb02->control.misc_ctl2 & SVM_MISC2_ENABLE_V_VMLOAD_VMSAVE));
>  }
>  
>  /*
> @@ -994,6 +1002,13 @@ static void nested_vmcb02_prepare_control(struct vcpu_svm *svm)
>  
>  	/* SVM_MISC2_ENABLE_V_LBR is controlled by svm_update_lbrv() */
>  
> +	/*
> +	 * vmcb02 is reused across nested VMRUNs and the VLS bit below is only
> +	 * OR-set, so clear it first; a stale bit would let L2 run VMLOAD/VMSAVE
> +	 * unintercepted even on a VMRUN that asks KVM to intercept them.
> +	 */

This becomes self-explanatory if written as:

	if (nested_vmcb_needs_vls_intercept(svm))
		vmcb02->control.misc_ctl2 &= ~SVM_MISC2_ENABLE_V_VMLOAD_VMSAVE;
	else
		vmcb02->control.misc_ctl2 |= SVM_MISC2_ENABLE_V_VMLOAD_VMSAVE;

and I definitely think we should un-invert the check to match nested_vmcb02_recalc_intercepts().

That said, not explicitly initializing all of misc_ctl2 is crazy.  AFAICT, LBR
virtualization is the only other bit in misc_ctl2, and it to is always computed
dynamically so I'd rather do this:

diff --git a/arch/x86/kvm/svm/nested.c b/arch/x86/kvm/svm/nested.c
index 1503fee15baa..6ea35a3dc361 100644
--- a/arch/x86/kvm/svm/nested.c
+++ b/arch/x86/kvm/svm/nested.c
@@ -884,8 +884,6 @@ static void nested_vmcb02_prepare_control(struct vcpu_svm *svm)
 	}
 
 	/*
-	 * Copied from vmcb01.  msrpm_base can be overwritten later.
-	 *
 	 * SVM_MISC_ENABLE_NP in vmcb12 is only used for consistency checks.  If
 	 * L1 enables NPTs, KVM shadows L1's NPTs and uses those to run L2. If
 	 * L1 disables NPT, KVM runs L2 with the same NPTs used to run L1. For
@@ -893,6 +891,7 @@ static void nested_vmcb02_prepare_control(struct vcpu_svm *svm)
 	 * to L1 GPAs, so the same NPTs can be used for L1 and L2.
 	 */
 	vmcb02->control.misc_ctl = vmcb01->control.misc_ctl & (SVM_MISC_ENABLE_NP | SVM_MISC_ENABLE_GMET);
+	vmcb02->control.misc_ctl2 = 0;
 	vmcb02->control.iopm_base_pa = vmcb01->control.iopm_base_pa;
 	vmcb02->control.msrpm_base_pa = vmcb01->control.msrpm_base_pa;
 	vmcb_mark_dirty(vmcb02, VMCB_PERM_MAP);

Argh!  But nested_vmcb02_prepare_save() isn't called in the svm_set_nested_state()
case, so AFAICT svm_update_lbrv() is never called.  Though that seems like a
pre-existing?
