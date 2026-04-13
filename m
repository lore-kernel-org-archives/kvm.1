Received: from mail-pf1-f201.google.com (mail-pf1-f201.google.com [209.85.210.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E196222599
	for <kvm@vger.kernel.org>; Mon, 13 Apr 2026 21:41:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776116508; cv=none; b=YR/oS5oSPONAMhY75fECNML/C2QRw3IkKElRUrWcFQ2HltmpuvaIu7zcCoVoCNGBWpQwp3BR2eS1scf+kUaMXoOuTKBSe/RSh2MomSgGHn7/AQPcMJ+4QoelwtspxPA+XziskuFeEYVESKB3XEoOculpXS7fK0FPy9eaHWyNRv8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776116508; c=relaxed/simple;
	bh=+mYr0i+wqulUdPNMhl4mt7ReG1quSqZZy4ttjj/3YQ4=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=CaS7jcK8Fp3TCiD55o6/9RqW0C1X9JbiHqLCb9ef7UEW16jphP5Fwcxpht80F7Y8lq4XxPa9O/eVKSGKDo0xGHyfJGCxRakWhc/li1y49RXyi5nD1UDHxIwcPK/REQEJy4h/yxZoHyUzJTEWUhdaLRSuRGihgII21ICg9BJsluA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=X5NfBQ2s; arc=none smtp.client-ip=209.85.210.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="X5NfBQ2s"
Received: by mail-pf1-f201.google.com with SMTP id d2e1a72fcca58-82f543bae3cso83682b3a.1
        for <kvm@vger.kernel.org>; Mon, 13 Apr 2026 14:41:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1776116505; x=1776721305; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=z7lWK1jf1RNiLlblY2ZsIs3TqjLl3fcQgMgh6tAW+Zc=;
        b=X5NfBQ2sCdzFIHie6EcYPvBy1XmXTaJa15ITlKHIfX+2hbiPofGh75TdHZSNMRcqNH
         AdSkyeq5XVKPN1ZpbphOmpI152hPgR1UB+Ut5QzQ7H/l8Ce4suMiM2TMZzAsu4zLvkUc
         utaLG/OxTPSwyzL5Q22O8ECb4o8ghKXYhcW1BinuOwB7Fwh6e52nbT3+BHp/JScy6hcO
         U4u9bLAILg87VV7NTeHfvA8hcZZuFtUAsVMcuB+hxGcvtjrsjLQnl+wank+fX3hFP9PT
         rCXDuSRC4ZBa668iXhmTem0+lhMsVdCIukZMvlK8smJFc+HIG0rMk0goSpLnb9qLXl0p
         bOXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776116505; x=1776721305;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=z7lWK1jf1RNiLlblY2ZsIs3TqjLl3fcQgMgh6tAW+Zc=;
        b=cE7mFDqooigG6+hovfVkGTQjOnCzlDOFDJemIS17GyNl452OebKcS8rlpStRiaGwq/
         Ku6J00W6NqDfT+DMvfqvwnStpQf3kBBRawkNdFs04ilj+HVZja0i3xs4H27w1hTssY8D
         YZWWg5LjYv/ytZUswvKpVThidfv1HKVe3j2OUyWz04l8Jru4LVEpxwEUhnrUQ8LijYud
         HEY+jzDGoYsnNfkZ9Xx+4Liupe6h6XjLI1w/la/8qNXEj3YM5S2HRZ0vOYk/GfaGtu7t
         l2yClOeZSZrHnUMooj6Lx+acb9QkWI5EonYLGvvwkz1a3ovv5CbFGUViE2rwxu1jtTeb
         zK0Q==
X-Forwarded-Encrypted: i=1; AFNElJ/fLiPK7sqLMdhfOUMf83b+/rc+EAk8FMLT/tBmQt87eQsAU+jttzw+simdb9u36PqQAO0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz9b8bDP5MqWuDAfcLOOMSDkmhRRql+pwV9gRC1CjJJO1b4SqBq
	O/zUaG5fHa4nE2Y/qfKi08+H0J55/Kl0TsSflrm51VAu/5DCWUNwPano/qM46DGVII2dYiA4cYp
	NwpmVfw==
X-Received: from pfbha15.prod.google.com ([2002:a05:6a00:850f:b0:824:ad09:91fa])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:aa7:888f:0:b0:827:2792:e401
 with SMTP id d2e1a72fcca58-82dd8ab396bmr16282295b3a.15.1776116505234; Mon, 13
 Apr 2026 14:41:45 -0700 (PDT)
Date: Mon, 13 Apr 2026 14:41:43 -0700
In-Reply-To: <20260413170009.380778-1-pbonzini@redhat.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260413170009.380778-1-pbonzini@redhat.com>
Message-ID: <ad1jFw5IPY78nDDw@google.com>
Subject: Re: [PATCH] KVM: x86: use inlines instead of macros for is_sev_*guest
From: Sean Christopherson <seanjc@google.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"

On Mon, Apr 13, 2026, Paolo Bonzini wrote:
> This helps avoiding more embarrassment to this maintainer,

Not building SEV support before pushing to kvm/queue is certainly a choice :-D

> but also will catch mistakes more easily for others.
> 
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>  arch/x86/kvm/svm/svm.h | 16 +++++++++++++---
>  1 file changed, 13 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/x86/kvm/svm/svm.h b/arch/x86/kvm/svm/svm.h
> index fd0652b32c81..a10668d17a16 100644
> --- a/arch/x86/kvm/svm/svm.h
> +++ b/arch/x86/kvm/svm/svm.h
> @@ -422,9 +422,19 @@ static __always_inline bool is_sev_snp_guest(struct kvm_vcpu *vcpu)
>  	return ____sev_snp_guest(vcpu->kvm);
>  }
>  #else
> -#define is_sev_guest(vcpu) false
> -#define is_sev_es_guest(vcpu) false
> -#define is_sev_snp_guest(vcpu) false
> +static __always_inline bool is_sev_guest(struct kvm_vcpu *vcpu)
> +{
> +	return false;
> +}
> +static __always_inline bool is_sev_es_guest(struct kvm_vcpu *vcpu)
> +{
> +	return false;
> +}
> +
> +static __always_inline bool is_sev_snp_guest(struct kvm_vcpu *vcpu)
> +{
> +	return false;
> +}

As called out in commit 45d522d3ee9c ("KVM: SVM: Macrofy SEV=n versions of
sev_xxx_guest()"), use of macros is intentional as gcc-12 at least generates
suboptimal code if there's a proper function.

That said, gcc-11 (I don't think I have gcc-12 laying around anywhere) generates
identical code for all of kvm-amd.ko with and without macros, so maybe whatever I
saw a transient issue?  I don't have a strong motivation for caring about any
version of gcc, so I'm a-ok using __always_inline functions.

Alternatively, e.g. if a "bad code generation" issue pops up again, we could use
BUILD_BUG_ON_INVALID() to validate the input.

diff --git a/arch/x86/kvm/svm/svm.h b/arch/x86/kvm/svm/svm.h
index 5440486a3d32..3f572f30f28c 100644
--- a/arch/x86/kvm/svm/svm.h
+++ b/arch/x86/kvm/svm/svm.h
@@ -425,19 +425,9 @@ static __always_inline bool is_sev_snp_guest(struct kvm_vcpu *vcpu)
        return ____sev_snp_guest(vcpu->kvm);
 }
 #else
-static __always_inline bool is_sev_guest(struct kvm_vcpu *vcpu)
-{
-       return false;
-}
-static __always_inline bool is_sev_es_guest(struct kvm_vcpu *vcpu)
-{
-       return false;
-}
-
-static __always_inline bool is_sev_snp_guest(struct kvm_vcpu *vcpu)
-{
-       return false;
-}
+#define is_sev_guest(vcpu) ({ BUILD_BUG_ON_INVALID((vcpu)->kvm); false; })
+#define is_sev_es_guest(vcpu) ({ BUILD_BUG_ON_INVALID((vcpu)->kvm); false; })
+#define is_sev_snp_guest(vcpu) ({ BUILD_BUG_ON_INVALID((vcpu)->kvm); false; })
 #endif
 
 static inline bool ghcb_gpa_is_registered(struct vcpu_svm *svm, u64 val)
