Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40A0944D688
	for <kvm@vger.kernel.org>; Thu, 30 Apr 2026 18:22:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777573346; cv=none; b=JtlNyvw9tLQ54248ouYwjIh4of/I1o3b+C133VNBMNNEgAD5r59B255HmZr03ehj4hvUNcszUIAq+QC9ZAr0hdcOsJfvAxAmlOBKtkeg8CPgJTUK6YvcKvy5ABkHIvFRFp07k7kt4xyhl/dkHxq9I3L4BTdWBmCJ6/y6tbdsoB4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777573346; c=relaxed/simple;
	bh=hkaiGCBRlKrxasZwRJj+im75/6IVVtwwqH/eTvnVg5A=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=LlXwNODUP9bYKFmWg235MgVAnKRAr5RkR8WQ336wtn4ZjoE1KA66Wmp7/DiNjK5CfYV8F+wo4gSvaq30jPwBXLBHRqxZH73UZrcO6IdPGBAAa1PU+zs2nh1RZLUeZyAQRBPqo74tYhCamP5XHAdsDtkhR5GffAnBwN2sj6Vb6Gk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=s4NsOKn6; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="s4NsOKn6"
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-2aad5fec175so18404135ad.2
        for <kvm@vger.kernel.org>; Thu, 30 Apr 2026 11:22:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1777573343; x=1778178143; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=7+lavt0WBeQHhVi1KvPlEVAg70lOs5ntZWgQXq4easQ=;
        b=s4NsOKn6/1uIIaRNlbgLaRHrGMmxsJRRNvaXCK8Vql7lUufCC9VUudR0JaXVDTaqVb
         mCsjShxaemSTRtMzTPucyzK88vFR0/tV31s7mFmVTzAFBom+mSK5m3Cy6vWcfTlGR9rx
         /f719zd0793VBob6IYGLL+jmXRQvMGwStEcPEYIaP5pwG/cyvpjnCiuE1ttTK+MmffnA
         paCVscZaqXIaE26dgod3LAw78himM6iwbrjcGikNSflyklD8mlaXy2I3RFCqrRUL0NE7
         nnFzU0PIJVQP6mfBR/7pQTQ0bVXLBCl08DyFK2TpT1RygbCRdttkkBLuJWravZFJLyVJ
         PHfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777573343; x=1778178143;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7+lavt0WBeQHhVi1KvPlEVAg70lOs5ntZWgQXq4easQ=;
        b=U0Roj2DiO7hAOGlYrVgO6n/zOCrCzBmwil4H/homGv0wcJM5kFLLFVqh+Q7zVzJycv
         YkbZTq4YiGueET2XjYKNJs0AAWVgPJxmyKngJct0xGFkiFCRk3fgM35XGga70Xqj8FpC
         S2qt/ZgEw5Us1aP/zWsIuHmDgdSn4uLUqUERs1pKf9SllUfwIaElhi8bQ2ELrcVDWLtw
         vWtafRM8YQNEHtGb+omnW2CAoNeCvMGkKaA9Dl3PHAARGPDGK+bav4R1SVaI6lTUhWdN
         NvUp3WxCE8VU6X5+tfv7FlyGdhc2WJcOwDfCUf/mfPagJqc+eRdO/qwxUb9IfkhXXlny
         9Wsg==
X-Forwarded-Encrypted: i=1; AFNElJ/gonLyWQDVBomeBBOxwmAdTlWu8dc1aY/cfYCXnXALyEsT4Gv091shO33F5IO4zO7fbDk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwX65nGp4B6kj3EpkGQWhh2Ee80X/VR4xH66W9EJTazeYHpVTYf
	eZhWkcZEKbS2MYt83SeOcEbf+LigEV83/J+03N+vnHAqQct3/zTgsAUlkO0+2JmrVsR0mDdQhGC
	ZXSUIcA==
X-Received: from plpo6.prod.google.com ([2002:a17:903:3e06:b0:2b4:595d:7de])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:7586:b0:2b7:ade8:2407
 with SMTP id d9443c01a7336-2b9a24c251fmr31949825ad.19.1777573343496; Thu, 30
 Apr 2026 11:22:23 -0700 (PDT)
Date: Thu, 30 Apr 2026 11:22:22 -0700
In-Reply-To: <20260430150747.76749-7-pbonzini@redhat.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260430150747.76749-1-pbonzini@redhat.com> <20260430150747.76749-7-pbonzini@redhat.com>
Message-ID: <afOd3ppLy_RhqaSy@google.com>
Subject: Re: [PATCH 06/28] KVM: x86/mmu: merge make_spte_{non,}executable
From: Sean Christopherson <seanjc@google.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: linux-kernel@vger.kernel.org, kvm@vger.kernel.org, d.riley@proxmox.com, 
	jon@nutanix.com
Content-Type: text/plain; charset="us-ascii"

On Thu, Apr 30, 2026, Paolo Bonzini wrote:
> As the logic will become more complicated with the introduction
> of MBEC, at least write it only once.
> 
> Tested-by: David Riley <d.riley@proxmox.com>
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>  arch/x86/kvm/mmu/spte.c | 20 +++++++++++---------
>  1 file changed, 11 insertions(+), 9 deletions(-)
> 
> diff --git a/arch/x86/kvm/mmu/spte.c b/arch/x86/kvm/mmu/spte.c
> index 85a0473809b0..e9dc0ae44274 100644
> --- a/arch/x86/kvm/mmu/spte.c
> +++ b/arch/x86/kvm/mmu/spte.c
> @@ -317,14 +317,16 @@ static u64 modify_spte_protections(u64 spte, u64 set, u64 clear)
>  	return spte;
>  }
>  
> -static u64 make_spte_executable(u64 spte)
> +static u64 make_spte_executable(u64 spte, u8 access)

make_spte_executable() is a less-than-awesome name for the combined functionality.
I read it as "Make an executable SPTE", but when called from make_huge_spte() it's
obviously not making an executable SPTE.

What about something like this, either as fixup or on top? (completely untested)

diff --git a/arch/x86/kvm/mmu/spte.c b/arch/x86/kvm/mmu/spte.c
index 9b5ce4d1fa65..84d716e91566 100644
--- a/arch/x86/kvm/mmu/spte.c
+++ b/arch/x86/kvm/mmu/spte.c
@@ -320,10 +320,13 @@ static u64 modify_spte_protections(u64 spte, u64 set, u64 clear)
        return spte;
 }
 
-static u64 make_spte_executable(u64 spte, u8 access)
+static u64 apply_nx_huge_page_adjustments(struct kvm *kvm, u64 spte, u8 access)
 {
        u64 set, clear;
 
+       if (!is_nx_huge_page_enabled(kvm))
+               return spte;
+
        if (shadow_nx_mask)
                set = (access & ACC_EXEC_MASK) ? 0 : shadow_nx_mask;
        else
@@ -363,8 +366,8 @@ u64 make_small_spte(struct kvm *kvm, u64 huge_spte,
                 * the page executable as the NX hugepage mitigation no longer
                 * applies.
                 */
-               if (is_nx_huge_page_enabled(kvm))
-                       child_spte = make_spte_executable(child_spte, role.access);
+               child_spte = apply_nx_huge_page_adjustments(kvm, child_spte,
+                                                           role.access);
        }
 
        return child_spte;
@@ -384,11 +387,7 @@ u64 make_huge_spte(struct kvm *kvm, u64 small_spte, int level)
         * huge page address.
         */
        huge_spte &= KVM_HPAGE_MASK(level) | ~PAGE_MASK;
-
-       if (is_nx_huge_page_enabled(kvm))
-               huge_spte = make_spte_executable(huge_spte, 0);
-
-       return huge_spte;
+       return apply_nx_huge_page_adjustments(kvm, huge_spte, 0);
 }
 
 u64 make_nonleaf_spte(u64 *child_pt, bool ad_disabled)

