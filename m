Received: from mail-pg1-f202.google.com (mail-pg1-f202.google.com [209.85.215.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FA0345106F
	for <kvm@vger.kernel.org>; Wed, 27 May 2026 17:44:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779903848; cv=none; b=XYv+Q2WUwX+WO/HsOJ7KCjcrpY8fKzGzjddqxqgJk9cnVebcFOUH9CFaoYEq9LwJzcj5ki2W2hYXfZ0IfcCi+gPhOWlMTEYbzVsUVKOKcsxpiyzIbErSrpkR0EJyzdn8YrjSor46gleQ3yclB4en2vnOBHGylVkUzVoMOZfD0xw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779903848; c=relaxed/simple;
	bh=YxP5krwdaVeOHE62Vd0PtLNRMCzqWyUDf/4m/oTbqYY=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=l6b3XtHTSx89BqdutJyrqQs4I5LwSJXkKdWWncsb8gHVxQArF/YxK6f3len9nWyS6bWlWNOPLsBYHL3i/FaOfSxxoOmHZJ1CJWDlapAXEV5HOcnx2kMuuKSFQJFkqj1842Txdj2R+r28awpan/Z6ZtpQGLMzm7ANuX5MsOPGKqA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jmattson.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=d7sPZDLK; arc=none smtp.client-ip=209.85.215.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jmattson.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="d7sPZDLK"
Received: by mail-pg1-f202.google.com with SMTP id 41be03b00d2f7-c8525f0807aso7147704a12.3
        for <kvm@vger.kernel.org>; Wed, 27 May 2026 10:44:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1779903845; x=1780508645; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=9qEcLhasCephgp3AS7VyEnF08Tw7w+64XAN+eU0Mxdw=;
        b=d7sPZDLK/mQVhUOG8LhwZ/IlmW2xfdFHHbZ7uGFAe5QJAhRl2CNDFc7Uw9q2dn9UNG
         QHA2wvsixvOY1Oal5VOcyek3x5xhIKLm///cfT1FagNDQsBY5zsiHI1xidS5myr6pYl5
         +hRKIYUGYpDuBpto/sC9N9G3Ha0xroguKBkWhvswvS6z2X5aBZ0cGZ/ArQ5v3RU7u4Xe
         ffBH5yX4ZXZ6AuIHalMWTMCZRyylQ6EIiIhPOx7erEeAcHKqO14Iy9GGNejWLfr6CrYt
         qqGuJMJ7HnCKHqkqQb2C5TmriCioya+7Nul4AlkCeL4U5sqEPDymMYhuZ2+Qk54/BAdS
         hGcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779903845; x=1780508645;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9qEcLhasCephgp3AS7VyEnF08Tw7w+64XAN+eU0Mxdw=;
        b=OHViQUMPQ6lEyWfvX6wbiqM0D0hx66l42cizBGWX7Or++/fh+kNvDvVElr/m1vyogY
         Dt/NUv41fylu88N/bGYe7JqD6O4NDYM0gONongYAv3cSYvbvq+R23Hcg46Klx7bTV/Gu
         MIv3FMcCRuuK/kWnUTTFymPKeP8jSoQ0Q2n0vTU/KGU3t48ix/TVn+hAYf0G+ZWgYW58
         TUzL+zwoLoMcY0xYRrKnsAeA8gNsXVB+SeLjarm2bWXxRCMTv1DxYFC/agDEB2AF+piF
         +TozXParmPndcXdJ5ltqdb5TzBC67KJKbVK1LiYueYLzMGiPmJpaZfeqJk/AklhjdWFZ
         wlIw==
X-Forwarded-Encrypted: i=1; AFNElJ8I/EQwc+I0Vl8xd3Hs858xTlquRRmu9i9ZXZF6kDweAK3dPAQdZndWGCuQfF21nsmBHXw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzvqOybuK8m8+nmzjiDf6O7asDwcbqKuaxhUMEWPmGQ0GJmvgbw
	1xxeuJrLfjBSrxva649x0oS80vCnvXbnxOLV08oMCNrmkBQ1GHicqXaU7jqlYjlxbe5JcXQDEtN
	j43lsOQWI7LG9sg==
X-Received: from pfkk16.prod.google.com ([2002:aa7:90d0:0:b0:841:9a0c:2108])
 (user=jmattson job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a00:4fc1:b0:83e:b47f:8994 with SMTP id d2e1a72fcca58-8415f0e87f7mr25477524b3a.6.1779903844354;
 Wed, 27 May 2026 10:44:04 -0700 (PDT)
Date: Wed, 27 May 2026 10:43:45 -0700
In-Reply-To: <20260527174347.2356165-1-jmattson@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260527174347.2356165-1-jmattson@google.com>
X-Mailer: git-send-email 2.54.0.794.g4f17f83d09-goog
Message-ID: <20260527174347.2356165-4-jmattson@google.com>
Subject: [PATCH v4 3/5] KVM: x86: Remove supports_cpuid_fault() helper
From: Jim Mattson <jmattson@google.com>
To: seanjc@google.com, pbonzini@redhat.com, tglx@kernel.org, mingo@redhat.com, 
	bp@alien8.de, dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com, 
	shuah@kernel.org, kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, ctpence@google.com, David.Kaplan@amd.com, 
	binbin.wu@linux.intel.com
Cc: Jim Mattson <jmattson@google.com>
Content-Type: text/plain; charset="UTF-8"

The function, supports_cpuid_fault(), tests specifically for guest support
of Intel's CPUID faulting feature. It does not test for guest support of
AMD's CPUID faulting feature.

To avoid confusion, remove the helper.

Suggested-by: Sean Christopherson <seanjc@google.com>
Signed-off-by: Jim Mattson <jmattson@google.com>
Reviewed-by: Binbin Wu <binbin.wu@linux.intel.com>
---
 arch/x86/kvm/cpuid.h | 5 -----
 arch/x86/kvm/x86.c   | 2 +-
 2 files changed, 1 insertion(+), 6 deletions(-)

diff --git a/arch/x86/kvm/cpuid.h b/arch/x86/kvm/cpuid.h
index bc4a8428b836..95d09ccbf951 100644
--- a/arch/x86/kvm/cpuid.h
+++ b/arch/x86/kvm/cpuid.h
@@ -183,11 +183,6 @@ static inline int guest_cpuid_stepping(struct kvm_vcpu *vcpu)
 	return x86_stepping(best->eax);
 }
 
-static inline bool supports_cpuid_fault(struct kvm_vcpu *vcpu)
-{
-	return vcpu->arch.msr_platform_info & MSR_PLATFORM_INFO_CPUID_FAULT;
-}
-
 static inline bool cpuid_fault_enabled(struct kvm_vcpu *vcpu)
 {
 	return vcpu->arch.msr_misc_features_enables &
diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index 72bd3cddb026..d5a2d794c3c9 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -4264,7 +4264,7 @@ int kvm_set_msr_common(struct kvm_vcpu *vcpu, struct msr_data *msr_info)
 	case MSR_MISC_FEATURES_ENABLES:
 		if (data & ~MSR_MISC_FEATURES_ENABLES_CPUID_FAULT ||
 		    (data & MSR_MISC_FEATURES_ENABLES_CPUID_FAULT &&
-		     !supports_cpuid_fault(vcpu)))
+		     !(vcpu->arch.msr_platform_info & MSR_PLATFORM_INFO_CPUID_FAULT)))
 			return 1;
 		vcpu->arch.msr_misc_features_enables = data;
 		break;
-- 
2.54.0.794.g4f17f83d09-goog

