Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com [209.85.210.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 032D243CE44
	for <kvm@vger.kernel.org>; Wed, 22 Jul 2026 21:41:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784756498; cv=none; b=O/tb1jfG1fm7u08ZT5ERl+dBz4VXk4ooRkzrq+IqsNh2lyrdb1qHZx9sHoHJAKS+Aaw2FzLQ1nN+lQ8dpAcpNuQaNM94/QjYsVzdhftsX6esaKO1xrFszgvqH1GrjjsKAQQGS5lwbSdGB3IOxcOODaKhZExK6NAG41j6PCUwMzE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784756498; c=relaxed/simple;
	bh=YfkqlJk+XSEH5Mo/29taOhKllufEXeXgArzlZpRjJUY=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=IUYMbDwIQJSTClgFIYD0u1bZOAChcml/x7aF4uOzbKxcwPLJGD6VzLewJlk+IoRgfBl418ZGndxO19zX17dALu9n5NgCxy7+izroTyolfm2qNE8SMZOjPeH3R7XX7y2vt22o7FSTALLwlfV2C/Txq8KhbiK5Y/20kYA/okG0Aq4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=gud3F5M+; arc=none smtp.client-ip=209.85.210.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="gud3F5M+"
Received: by mail-pf1-f200.google.com with SMTP id d2e1a72fcca58-84842381150so22719306b3a.3
        for <kvm@vger.kernel.org>; Wed, 22 Jul 2026 14:41:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1784756495; x=1785361295; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=653NAsUW4hEJZx8eIBt2dUKInbAtAlowc+ioGHT72WQ=;
        b=gud3F5M+hQ1XLZnAHjcqN10mR/WSw+Kk3h25kIfDehuFmXpd/tydr2Mirfsmd824W2
         P/YZz0AFLURUy2hHCo00X6ZP2GUpToOJYN5A1edWCA1rqO6TpsMdNiFEqT26Zjd7OBrQ
         7YuBukorQsy9Y4jH4GlhQtNskK7xum34236AKcXJkNjK8lBnC6F6B/vUkn2jltpCG2R0
         bNvfUxo9YSP8qEq+o8ScMZMgdSvNqQwS/mo/eSyCv5THsxYjeF0WfKLd68e22bS0oCbh
         ESmxztZX4mb8c+OYEhZeaU4LB5+YsrfxjbqmGHYgMezYKxdwqaj+lsNPi79oqKraCHFJ
         SNgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784756495; x=1785361295;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=653NAsUW4hEJZx8eIBt2dUKInbAtAlowc+ioGHT72WQ=;
        b=kFdVd4b2upTWTmtniFOxQyuLMoRuP6M2lm2nLaVGcLRUGHpGnayPDu+pHU7kX/QS/4
         ZBeB9VPmp2hK2lSp1idTDWL3sQye5O8WjSUgtnHgbUN8ASLDtu7UBpXW7LC7kDkpxjp3
         zEsqznaXDpPfwnX1vZYQQcgORf+84d+dntScblvYpKjLn4Vyb2hFwYyPR2pjCN3BNn1R
         mAj9ixGMvG9FW+139DYU2wWmpS3SahwbEYlXIJ1TTGiCanM/BYk75+aFUo9qqxCMvhrU
         LrjQvYf1hYUb8C4e1d/wnAtIdkCnGEcwnzQo8/PzxReZJsTwkE8iGNP0KdZPXe4ieb4z
         H0tQ==
X-Forwarded-Encrypted: i=1; AHgh+RoG8U9wQBoJOqj7aXKhv5o+9E96NPN1e7wEj8PrZ/F56oa95pTiZ/09ihznvuZshULPQ/I=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw59Z1+STthy/J5FTTNAi3M1RAtdJ2yYTBtWe3QSctoxYamc5pT
	tqumf0IMeist/z3T6EkubNyTXTHUHQ/QNHXY8gTMuJBZFu1ao6drHibZtmXCYVQQ6r24eGJUSZI
	8H6q62w==
X-Received: from pgaz10.prod.google.com ([2002:a05:6a02:50ea:b0:c88:b675:3609])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:32cf:b0:84e:1da9:6a53
 with SMTP id d2e1a72fcca58-84e2b8688bcmr624911b3a.19.1784756495031; Wed, 22
 Jul 2026 14:41:35 -0700 (PDT)
Date: Wed, 22 Jul 2026 14:41:34 -0700
In-Reply-To: <20260717060505.2971514-1-yosry@kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260717060505.2971514-1-yosry@kernel.org>
Message-ID: <amE5DiLbq5PdYuNn@google.com>
Subject: Re: [PATCH] KVM: nVMX: Only update last_vpid on a successful nested VM-Enter
From: Sean Christopherson <seanjc@google.com>
To: Yosry Ahmed <yosry@kernel.org>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Jim Mattson <jmattson@google.com>, kvm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org, 
	Sashiko <sashiko-bot@kernel.org>
Content-Type: text/plain; charset="us-ascii"

On Fri, Jul 17, 2026, Yosry Ahmed wrote:
> ---
>  arch/x86/kvm/vmx/nested.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/x86/kvm/vmx/nested.c b/arch/x86/kvm/vmx/nested.c
> index b5460de4b1a72..0a4ea410b0483 100644
> --- a/arch/x86/kvm/vmx/nested.c
> +++ b/arch/x86/kvm/vmx/nested.c
> @@ -2818,8 +2818,6 @@ static int prepare_vmcs02(struct kvm_vcpu *vcpu, struct vmcs12 *vmcs12,
>  	if (kvm_caps.has_tsc_control)
>  		vmcs_write64(TSC_MULTIPLIER, vcpu->arch.tsc_scaling_ratio);
>  
> -	nested_vmx_transition_tlb_flush(vcpu, vmcs12, true);
> -
>  	if (nested_cpu_has_ept(vmcs12))
>  		nested_ept_init_mmu_context(vcpu);
>  
> @@ -3739,6 +3737,8 @@ enum nvmx_vmentry_status nested_vmx_enter_non_root_mode(struct kvm_vcpu *vcpu,
>  		vmx_start_preemption_timer(vcpu, timer_value);
>  	}
>  
> +	nested_vmx_transition_tlb_flush(vcpu, vmcs12, true);

Hmm, so the SDM doesn't explicitly say _when_ TLB flushes happen, but I suspect
this doesn't match how hardware behaves.  My guess is that any TLB flushes happen
once VM-Enter has gotten past the VM-Fail consistency checks, i.e. once a VM-Exit
is guaranteed.

The SDM doesn't actually say anything about VM-Enter, so I don't think KVM *must*
implement *that* specific behavior, but I do think we should leave the call to
nested_vmx_transition_tlb_flush() where it's at, and instead service the local
pending flushes in the pseudo-VM-Exit path.  Because the other way the TLB flushes
can be queued during VM-Enter is via the MSR load lists:

  If any MSR is being loaded in such a way that would architecturally require
  a TLB flush, the TLBs are updated so that, after VM entry, the logical
  processor will not use any translations that were cached before the transition.

E.g. if L1 successfully loads one or more MTRRs on VM-Enter to L2[*], then fails
on a subsequent MSR, architecturally I believe L2 TLB entries are guaranteed to
be flushed.

I'm speculatingly heavily on all of this, but even if I'm wrong (or it's uarch-
specific behavior), explicitly servicing pending flushes in the VM-Exit(ish) path
feels safe in the long run:

diff --git arch/x86/kvm/vmx/nested.c arch/x86/kvm/vmx/nested.c
index 3266c63046ee..49aeecc2f093 100644
--- arch/x86/kvm/vmx/nested.c
+++ arch/x86/kvm/vmx/nested.c
@@ -3760,6 +3760,14 @@ enum nvmx_vmentry_status nested_vmx_enter_non_root_mode(struct kvm_vcpu *vcpu,
 vmentry_fail_vmexit_guest_mode:
        if (vmcs12->cpu_based_vm_exec_control & CPU_BASED_USE_TSC_OFFSETTING)
                vcpu->arch.tsc_offset -= vmcs12->tsc_offset;
+
+       /*
+        * Handle any TLB flush requests that were queued for L2 if KVM made it
+        * far enough along to switch to L2 context.  Note, loading host state
+        * will generate any flushes for L1 required by VM-Exit.
+        */
+       kvm_service_local_tlb_flush_requests(vcpu);
+
        leave_guest_mode(vcpu);
 
 vmentry_fail_vmexit:


[*] https://lore.kernel.org/all/20260717230542.3555587-4-jmattson@google.com

> +
>  	/*
>  	 * Note no nested_vmx_succeed or nested_vmx_fail here. At this point
>  	 * we are no longer running L1, and VMLAUNCH/VMRESUME has not yet
> 
> base-commit: 6bc96b971766fbbbbdd9fb2642cedacaf02da957
> -- 
> 2.55.0.229.g6434b31f56-goog
> 
