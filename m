Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37E183A0E8F
	for <kvm@vger.kernel.org>; Mon,  6 Apr 2026 23:27:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775518057; cv=none; b=WDk7/R0VhYXQdg3N6+xfvNhs+uLTr/vJb20vpKBaWFJovO9lEzel/o8nbJ5+/xdBjiyy30dS9BzD5n8dVNVA0wHRT2Fw1Zw99rkK8Vm4cEVCCK1s73ApGJKxAUZIPe7ktK23xyJCw27U8wv7U5Zf9JmNmPU7q57vpr46DXWPXB8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775518057; c=relaxed/simple;
	bh=FRR5sT0zQ8QWo/7kVJ3OR2zaSQRcCfEM05VHXvhpgd0=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=NNBegP+kAi14/7Oi+D134a0XBAS/laT6O+r4fbxAlFrZ8LtUjLaMaOzCxrVxzC3dllMG4CH8WQydt0s/nePF//rWSrvwQxMvp8Z4skyax7xTSsQGWrmPuwgVo0DaXE4iL3Kk86CKdfv0F5oDxJTHmCG+4F1VUcTLmY0Fe6WF6jE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=JF1Fteto; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="JF1Fteto"
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-35c0cbe0f64so10682554a91.0
        for <kvm@vger.kernel.org>; Mon, 06 Apr 2026 16:27:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1775518056; x=1776122856; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=SJTcZf1UujVpWDgwH0mVsCXrQUf/rG8HnnvzMBPDQG0=;
        b=JF1FtetoaC+OMcNZ0zG0TBp7xLgLwlwG2Ndt+w/hH3lV4s1EYUNvGoBto4bEY6W3o9
         R4TkUnCG+nV+ESGUrfxk02KIeD433mI8LEOaqj/sj+7urmH1gBRjaVsrR9zsGIj1Qwtl
         jEhOvhgX8FdFmka3DFGKY4XGfs42Uv+k3sb4kE+i/kUp5KEvdOJLyapvHUA1uQD0/W6+
         Sc6TqAgDjQY1iL/rxywukMAP7FFRCpAIM/gzUury85jY2hwahom+4dJlW4Foiqtk4WFN
         CeKNyQrOGUaeeEO1tIIi9625+aAzx39TjEwXuhAWoerOXk5yJ3iZVHe3hFxOxM7X9R7q
         jYMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775518056; x=1776122856;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SJTcZf1UujVpWDgwH0mVsCXrQUf/rG8HnnvzMBPDQG0=;
        b=HYcj+3BD5n9+K9l8/XEugW6XGnBGR3dlzNub/oULjUv4r2jM8ayjjhZdGo57LXPg1A
         xcz1Kod+3JCAfbrtMNgQHfB/fsvgBoZg0xDGg62mhpybY0aJyyjYnfbW0hTJcKbsZ8bQ
         ffro0ZwxceWU9N0YAcESIkO0DlpkG2XMdYJy8ZFWsJ9kNdAMaXOEDZDMOAiVzGa5JB0L
         erWRQKEuNKeGry4cetJSb/8wHoGe/4+eCva2G2O1jO6GX2BLf54UnXTFAoDD+taNtXpP
         n/40wtX5JLjEl1jCIaBvi99qj8Q50y8BHi/1Ar+ItLDIfKJ4aPd12UYUsoYghVA/f+Ij
         h42w==
X-Forwarded-Encrypted: i=1; AJvYcCUqrgARA6dRH8n+VtkQSuACDGR6LIQDAgTx5veWVtf9U+Al4PTS2wtM7sa5rkRoqYDIMaY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyd0qP4CWIHvda7seHqVxhglnkbYlqK4RCLfZxskKKOKGgtbZev
	zNa7gvapfi84b0g/vfej2kaKf6x0wXkfWWdYMzkJHiNyaSnRCaEoQ1QYvWEyzPPd92dQK445Q6X
	8LM1wwg==
X-Received: from pjre2.prod.google.com ([2002:a17:90a:b382:b0:35d:a63e:32e9])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:1d49:b0:35d:9927:e023
 with SMTP id 98e67ed59e1d1-35de67df8c1mr13530992a91.8.1775518055475; Mon, 06
 Apr 2026 16:27:35 -0700 (PDT)
Date: Mon, 6 Apr 2026 16:27:34 -0700
In-Reply-To: <20260327234023.2659476-2-jmattson@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260327234023.2659476-1-jmattson@google.com> <20260327234023.2659476-2-jmattson@google.com>
Message-ID: <adRBZuqNlBozaDrK@google.com>
Subject: Re: [PATCH v7 1/9] KVM: x86: Define KVM_X86_QUIRK_NESTED_SVM_SHARED_PAT
From: Sean Christopherson <seanjc@google.com>
To: Jim Mattson <jmattson@google.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Jonathan Corbet <corbet@lwn.net>, 
	Shuah Khan <skhan@linuxfoundation.org>, Thomas Gleixner <tglx@kernel.org>, 
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	"H. Peter Anvin" <hpa@zytor.com>, kvm@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	Yosry Ahmed <yosry@kernel.org>
Content-Type: text/plain; charset="us-ascii"

On Fri, Mar 27, 2026, Jim Mattson wrote:
> diff --git a/arch/x86/kvm/svm/svm.h b/arch/x86/kvm/svm/svm.h
> index ff1e4b4dc998..74014110b550 100644
> --- a/arch/x86/kvm/svm/svm.h
> +++ b/arch/x86/kvm/svm/svm.h
> @@ -616,6 +616,17 @@ static inline bool nested_npt_enabled(struct vcpu_svm *svm)
>  	return svm->nested.ctl.misc_ctl & SVM_MISC_ENABLE_NP;
>  }
>  
> +static inline bool l2_has_separate_pat(struct vcpu_svm *svm)

Take @vcpu instead of @svm.  All of the callers have a "vcpu", but not all have
a local "svm".  That will shorten the quirk check far enough to let it poke out.

> +{
> +	/*
> +	 * If KVM_X86_QUIRK_NESTED_SVM_SHARED_PAT is disabled while a vCPU
> +	 * is running, the L2 IA32_PAT semantics for that vCPU are undefined.
> +	 */
> +	return nested_npt_enabled(svm) &&
> +		!kvm_check_has_quirk(svm->vcpu.kvm,
> +				     KVM_X86_QUIRK_NESTED_SVM_SHARED_PAT);

Align indentation.  With the @svm => @vcpu change, this becomes:

	return nested_npt_enabled(to_svm(vcpu)) &&
	       !kvm_check_has_quirk(vcpu->kvm, KVM_X86_QUIRK_NESTED_SVM_SHARED_PAT);

> +}
> +
>  static inline bool nested_vnmi_enabled(struct vcpu_svm *svm)
>  {
>  	return guest_cpu_cap_has(&svm->vcpu, X86_FEATURE_VNMI) &&
> -- 
> 2.53.0.1018.g2bb0e51243-goog
> 
