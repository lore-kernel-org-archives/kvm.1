Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 859CA470EB0
	for <kvm@vger.kernel.org>; Sat, 17 Oct 2026 14:06:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792245966; cv=none; b=ESG7+dX7W6L0D1mMgtkappwCBHna+V0S3BreuqxRY3b896bXrKi88kiClMtz6C21GGqI+sXa/BKVRKwqmXuX8PQ5RLEzb/Gu4ox/whr343Y8Lv0yUK800//Wx4VbtFsOeRaJBBsjhTmP5zDc1KhwG89UG1LLEe4sEwD+zIAR7ps=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792245966; c=relaxed/simple;
	bh=I2SzU/X0UsUkDnk+7F4P+NF2JrYj+zJ90hjnCQGIqZk=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=mKS0Fkq5qeHA2CXn7wM3n4Flm/RPTWDIvPhw0Pbc1hOwEA6/ie/Js/RP8/O1hRgEyFe33ANMszLRSEnw2eFQ34cjnKFoNRYpNHoPMkUOOEOdt4waYIKwBhOE0x3ueXQ9evaraAi5q/njLQIRjdee8+bMsGfiiHW4MkTIfx6GqPA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=eFA0LTSG; arc=none smtp.client-ip=209.85.214.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="eFA0LTSG"
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-2e818ca61bfso6530885ad.2
        for <kvm@vger.kernel.org>; Sat, 17 Oct 2026 07:06:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1792245963; x=1792850763; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ZVdY7DMl2n2rpVG1smOAYr0lCvQQYHVvm5gpWtCLbZs=;
        b=eFA0LTSGDlkCoVsC9GP5rvIAEU9A5uyVS7yaG8S2W/dyrgmOiZmBoCxiQq8N4+7MHQ
         g+1+omNTDjIK3KVhbdtJ8EWlXJ8EAUjHvr3jwDXvwjqrw3AwlTFgQpgkGuqLEsOckjR+
         mjc5KkhTX0G8TBAyr20TG+0jIFL2XewlxFF3Ae7mTHPFCh3qnS2QmaOHXVirv9XSSndc
         pOAS+OiW1btYCx7pkBV6F2yFSovRXehkmpUmu1Eo6CBbbiMBq/PA201kI4FqzJnjYjLS
         xEJgcQ/5DjdVY0dRAwcwIqYcp/93h7KU+DkZ2AIv/adVWC5TtPoSxfyW2HWSe6RdEWAX
         wpPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792245963; x=1792850763;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ZVdY7DMl2n2rpVG1smOAYr0lCvQQYHVvm5gpWtCLbZs=;
        b=RNHo9KDSd3C8GJQQxI9p80nE8jwkuTO9xee+Y+VNIErhC+WHOxSjDrdSWhQ8Tj5OLo
         ejrH+jMio3LQIZGuqPdmoaFqxPXi0Ht0Qy6KRuzR0AkWTQTjJ1NmwTpGU1mch0gezlNk
         VST9kS2r4nSx+VmA02A2BbRkIxPg1rGvO+LLKCV5Mi3CI3kKIi0bVAoma4ZZBhmTMG+j
         nWDddTrXY1z+9/rDXEp+2qQBWdO7D4oW/NgxVnHnLuJN8vPBoOenoIZSaZhF3FE0PWpk
         //QLg29NOhRSSUibXT4/sVhHovELuzqS+/PdyCTHvVRFYKo13Se11r7Vw9UE7PMZ0kcy
         LLZA==
X-Forwarded-Encrypted: i=1; AKwUvByGxadwyy6h6wm064qahjntgBMDXSGgsR+PqaItGLkHK2uAGMI8BIW2rVwG5EurXMVEzJ0=@vger.kernel.org
X-Gm-Message-State: AFq9FYJGw/TXs4Lfh0Z8xJOJvIxVHWe1B4Yni16JN0wfvMEJyLJM5jE9
	UqLIJdLv8Hq5ressirW15i12x5znRNQDpewI87Qjq76gk9nuH0QIj7D579ESn2UUq+sG9pST9Fy
	KwgUb5Q==
X-Received: from plble14.prod.google.com ([2002:a17:902:fb0e:b0:2e1:326b:da73])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:1111:b0:2e8:965c:aedf
 with SMTP id d9443c01a7336-2e9a6c206b7mr23610075ad.42.1792245962200; Sat, 17
 Oct 2026 07:06:02 -0700 (PDT)
Date: Sat, 17 Oct 2026 07:06:01 -0700
In-Reply-To: <20261017093016.32348-7-amirmohammad.eftekhar@cispa.de>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20261017093016.32348-7-amirmohammad.eftekhar@cispa.de>
Message-ID: <atOAyUIiGLBsgsWI@google.com>
Subject: Re: [BUG] KVM: x86: Hyper-V VP-assist page reuses the KVM PV-EOI
 gfn_to_hva_cache, so enabling both WARNs and fails KVM_RUN
From: Sean Christopherson <seanjc@google.com>
To: Amirmohammad Eftekhar <amirmohammad.eftekhar@cispa.de>
Cc: pbonzini@redhat.com, kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"

On Sat, Oct 17, 2026, Amirmohammad Eftekhar wrote:
> Hi,
> 
> Reporting a guest self-DoS (correctness/robustness; not memory-safety, not
> guest->host).

And a KVM WARN, that's the only reason I care about "fixing" this.

> The Hyper-V VP-assist page and KVM's PV-EOI feature share a single
> gfn_to_hva_cache, vcpu->arch.pv_eoi.data:

I'm still flabbergasted that this is the case (I recently learned about this thanks
to another AI-found bug).

>  - Writing HV_X64_MSR_VP_ASSIST_PAGE arms the cache for the VP-assist page via
>    kvm_lapic_set_pv_eoi(vcpu, gfn_to_gpa(gfn) | KVM_MSR_ENABLED,
>    sizeof(struct hv_vp_assist_page))   /* hyperv.c ~1600 */
>  - kvm_hv_get_assist_page() then reads it back with that same cache and the
>    VP-assist length:
>    kvm_read_guest_cached(kvm, &vcpu->arch.pv_eoi.data,
>                          &hv_vcpu->vp_assist_page,
>                          sizeof(struct hv_vp_assist_page))  /* hyperv.c ~952 */
> 
> pv_eoi.data is the one gfn_to_hva_cache shared between the two features. A guest
> that has VP-assist enabled and then writes MSR_KVM_PV_EOI_EN (a different GPA,
> len 1) re-initializes pv_eoi.data for the 1-byte PV-EOI object while VP-assist
> stays enabled. The next kvm_hv_get_assist_page() then does a cached read of
> sizeof(struct hv_vp_assist_page) against a cache set up for len 1 -> the
> length/GPA mismatch trips the cache and KVM fails the read, surfacing as a WARN
> and a failed KVM_RUN for a guest that did nothing architecturally illegal (the
> two features are independent and both legitimately enableable).

Eh, given that no one has ever complained, and that enabling both at different
locations would probably break the guest anyways, I don't see any reason to go
out of our way to make this work.  If someone wants to clean up the Hyper-V mess,
they're more than welcome to, but for an immediate fix, I just want to prevent
KVM from tripping the WARN.

So as a stopgap (which will probably become the long-term behavior...), this?

diff --git a/arch/x86/kvm/hyperv.c b/arch/x86/kvm/hyperv.c
index c18f45f66c24..88cc5a6ce170 100644
--- a/arch/x86/kvm/hyperv.c
+++ b/arch/x86/kvm/hyperv.c
@@ -947,6 +947,15 @@ int kvm_hv_get_assist_page(struct kvm_vcpu *vcpu)
 	if (!hv_vcpu || !kvm_hv_assist_page_enabled(vcpu))
 		return -EFAULT;
 
+	/*
+	 * KVM reuses its own PV EOI feature to emulate Hyper-V's EOI Assist,
+	 * and rather stupidly reuses the same MSR and cache storage.  Treat
+	 * the assist page as inaccessible if the shared state is configured
+	 * only for PV EOI's single byte of data.
+	 */
+	if (vcpu->arch.pv_eoi.data.len < sizeof(struct hv_vp_assist_page))
+		return -EFAULT;
+
 	return kvm_read_guest_cached(vcpu->kvm, &vcpu->arch.pv_eoi.data,
 				     &hv_vcpu->vp_assist_page, sizeof(struct hv_vp_assist_page));
 }
