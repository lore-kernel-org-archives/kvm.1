Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2044A3382D3
	for <kvm@vger.kernel.org>; Fri, 10 Apr 2026 22:21:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775859668; cv=none; b=EFti9W3exQ0ne4fv6HFxneqST/Qj5Q5/F9WdCPm/8ahBoQhmVCLprSzkk6Ae8Cs3Qu55iH+C7mUB+V35F0VN4BAWuyGyhWyfr69l5fIvcEBqfP4TOrUIecFEe+kPxImbWlmtTvdO56WXjM/K2/DbUU7PS3uREATwRnI35dU5XMc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775859668; c=relaxed/simple;
	bh=9/8WqCFepXx+i5+ghZ6Y69Au4rXMKwm4NYm/KXQRyAM=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=JlZYgnmyPSFHt0LMUX4cXSS0UjzteCShhYUvWjLZpzxDVLmGWFDH+LSv93id+PVq84E6F2JFtZrLW+/j14J1n4EHpJgCUi03d5yzOkb/jKOS6rOfYf4VTTgStaImH4jsF2Ji51vnzFghDVFbLyoddQoJamy5PtRykLQ1mQuVwp8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ZNfFtQ9U; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ZNfFtQ9U"
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-82f07078eaaso1207250b3a.0
        for <kvm@vger.kernel.org>; Fri, 10 Apr 2026 15:21:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1775859666; x=1776464466; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=UhZ/Ltw66Ex5f+gr2Z+6oCt2Y2I6rxgzOwsvUIVNGec=;
        b=ZNfFtQ9UeOeAVs750C66HjW6hFjTlJtflkOvOdQnCboBj9ZimU/itxUssVnizz8o3c
         zoIa0sPI/hnKLPDuOTnY6VMKrY2oHJc5DCLdqMH86MK4XxAeC5eDwc20jX1W2qUZMo9L
         aeCbLqkJvDDvdk7JcoBtmm2NZzDROp5xj3hYqN8l1vc4BS2SXiVmplV/n/eq4KONYT0o
         VGzylTO0I2M4E8wk7/a7drPNH++n5+YViza+6pvW78jF7o+gS6+uLZax4rkkUkzr2f+L
         xwsd3v6csWEnf5US8QClIrYKcHFVc/GDVILSaKVBI0gwxDhkmYpDcI1PUPu3YZhdQNfZ
         9WcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775859666; x=1776464466;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UhZ/Ltw66Ex5f+gr2Z+6oCt2Y2I6rxgzOwsvUIVNGec=;
        b=mlQkOIAIgm2THpF4AIZJoShyP5AM6Pj5mClM/Ndfjc8G+DUBb1FivhSyDQWjFvhebY
         O2WjetrtFagLu6qPYs4IyJamqClgUQRK3uC0nOe2p1a6o1l4HTrqJt7l3m84hF3KwrYJ
         9AXnzXcKqfnq3mUiE8onDrIIrf8HLFeAHK29EU8w8YoLTO5KNuTOSC2Qax1Bn8vIruQx
         TqDQUSs60alHXGAgAZKWV9intOn6S+uSQcdtLWD9w49iJVjWBL9OqECB0Cud4HnM3gmw
         uZzZUJME86l3EE9sEusnzZBOBA9o5sCjb01y2P8mWvO6Zgs6D4z45j895sk4f/zwcRL8
         2aTw==
X-Forwarded-Encrypted: i=1; AJvYcCWbrEAJyd1/7+SZPtiaoARvXx9IVSf8Ien5YljrDRZBESc5NZdrkqB2jFsmQwUy60WDIlM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxiKzixZqEmLns1O9dyJyo/LhIk0px6e+NaNKnHGps/CZSoeMoT
	9jyhOvHoavFwfNHt7q+7u2wFt9a/4mSNvt2Q387RZdlhaObL/paexCcVFkLcGqVy+76TqBpD4eQ
	k4cDKUw==
X-Received: from pfbdh12.prod.google.com ([2002:a05:6a00:478c:b0:82c:e148:ec37])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:2387:b0:81f:ac81:d597
 with SMTP id d2e1a72fcca58-82f0bf6da94mr5531243b3a.0.1775859665961; Fri, 10
 Apr 2026 15:21:05 -0700 (PDT)
Date: Fri, 10 Apr 2026 15:21:04 -0700
In-Reply-To: <20260402223108.650572-2-jmattson@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260402223108.650572-1-jmattson@google.com> <20260402223108.650572-2-jmattson@google.com>
Message-ID: <adl30JQXxxQGmHvj@google.com>
Subject: Re: [PATCH 1/3] KVM: x86: Rename supports_cpuid_fault to supports_intel_cpuid_fault
From: Sean Christopherson <seanjc@google.com>
To: Jim Mattson <jmattson@google.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, 
	Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	"H. Peter Anvin" <hpa@zytor.com>, Shuah Khan <shuah@kernel.org>, kvm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	Clayton Pence <ctpence@google.com>
Content-Type: text/plain; charset="us-ascii"

On Thu, Apr 02, 2026, Jim Mattson wrote:
> The function, supports_cpuid_fault(), tests for guest support of Intel's
> CPUID faulting feature. Rename the function to supports_intel_cpuid_fault()
> for clarity.
> 
> Signed-off-by: Jim Mattson <jmattson@google.com>
> ---
>  arch/x86/kvm/cpuid.h | 2 +-
>  arch/x86/kvm/x86.c   | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/x86/kvm/cpuid.h b/arch/x86/kvm/cpuid.h
> index 039b8e6f40ba..51cbe67c992a 100644
> --- a/arch/x86/kvm/cpuid.h
> +++ b/arch/x86/kvm/cpuid.h
> @@ -181,7 +181,7 @@ static inline int guest_cpuid_stepping(struct kvm_vcpu *vcpu)
>  	return x86_stepping(best->eax);
>  }
>  
> -static inline bool supports_cpuid_fault(struct kvm_vcpu *vcpu)
> +static inline bool supports_intel_cpuid_fault(struct kvm_vcpu *vcpu)

*sigh*

I was going to suggest supports_misc_enables_cpuid_fault(), since KVM emulates
the MSR for all CPU vendors, but the enable is in MISC_FEATURE_ENABLES, not
IA32_MISC_ENABLES.

What if we just drop the helper?  There's only one user.  I.e.

diff --git a/arch/x86/kvm/cpuid.h b/arch/x86/kvm/cpuid.h
index 039b8e6f40ba..8b64d863e19c 100644
--- a/arch/x86/kvm/cpuid.h
+++ b/arch/x86/kvm/cpuid.h
@@ -181,11 +181,6 @@ static inline int guest_cpuid_stepping(struct kvm_vcpu *vcpu)
        return x86_stepping(best->eax);
 }
 
-static inline bool supports_cpuid_fault(struct kvm_vcpu *vcpu)
-{
-       return vcpu->arch.msr_platform_info & MSR_PLATFORM_INFO_CPUID_FAULT;
-}
-
 static inline bool cpuid_fault_enabled(struct kvm_vcpu *vcpu)
 {
        return vcpu->arch.msr_misc_features_enables &
diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index 2410401c57d8..c72ea99422ca 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -4262,7 +4262,7 @@ int kvm_set_msr_common(struct kvm_vcpu *vcpu, struct msr_data *msr_info)
        case MSR_MISC_FEATURES_ENABLES:
                if (data & ~MSR_MISC_FEATURES_ENABLES_CPUID_FAULT ||
                    (data & MSR_MISC_FEATURES_ENABLES_CPUID_FAULT &&
-                    !supports_cpuid_fault(vcpu)))
+                    !(vcpu->arch.msr_platform_info & MSR_PLATFORM_INFO_CPUID_FAULT)))
                        return 1;
                vcpu->arch.msr_misc_features_enables = data;
                break;
