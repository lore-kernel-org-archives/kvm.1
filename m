Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A07E63AB260
	for <kvm@vger.kernel.org>; Thu,  9 Apr 2026 23:56:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775779010; cv=none; b=pV49PoGfRSuvJxo6Bmi86qV7PM6Snw3LcLrGZyPOL+i/k9kVdHXZxsTxpghOFIGxLlkoz9OObph9laUOX7Rm6v8Y2/pgI98Cy9f8hrJvCRHkg8WtXdLgW1LyVkKGTBO+6oqIJs3u6y4HMUYuob1j7Xtf2uk5VRzNnJu5vGDkiVw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775779010; c=relaxed/simple;
	bh=g68osq6pRQSr3t5f6y6XMOyV1XhIP81oCEWoVk8XeoQ=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=rYcKcb+pVRshBlaMEPZIM7axD5pHHZhXZbu6LJ6ejuHC6IY0BF3SRwMNkl75pFLGvFEq8+4YKHCMSeWBFaGiKLKGp0ns4vT3ttWJmB5CSy87l9kChRjKCx0yKXo6H+Dp7vTd7yD2kRVzATVU+cY49lh0LzwqCE4Dp2SynbCBK5E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=G/908ziU; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="G/908ziU"
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-35d90c7ec5aso3348394a91.2
        for <kvm@vger.kernel.org>; Thu, 09 Apr 2026 16:56:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1775779009; x=1776383809; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=2vfHPkdjdDnWWqHGKQSHc5fvDOSsHtdwUfzBfHbNRVQ=;
        b=G/908ziUPS7ABcOfBdbJCCKDI9RGngkWHt6sF0KcR9tNmh47Sxr4YEZoymDk6u/LZp
         +oA4o6fbsO4cXL/iSLfOeZLkFP0aepatMfQS5I1rrt7o3TBfwjYiXKFRLxwHTQgxt9D4
         5M6/2N31+SG04WchjB0aieFU44QXtYDAjfDgeImILRfobTOwYf4NrX/ItdzJhN+Yg0JM
         Sbr8z2cJZX7Bu6zLmo9/ST0QhdtDGkIgf6+cPAMrBgmYFlDq0ajuFyOnxL26LzaShsrI
         jtINd259jBQEC0JABSjWubuMC+BzhbqgVEGkuy5solG8kXsUEk+wIEoQVLuP34YL3bOo
         SBBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775779009; x=1776383809;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2vfHPkdjdDnWWqHGKQSHc5fvDOSsHtdwUfzBfHbNRVQ=;
        b=RM0c8kwfMuxN5882OoHRtZrMiKEz4p7PGV3Rxcz3OnITUrTHwcYvhxn1bDq1USBEQC
         H6X3MQjJxl+/Y9J7YOrlqCSJjOSCNljT9dJ4xm6+lLSLZy+2+m0mluTInJsKQ/5YuHQV
         jlrzwbgleutmG6Dm+QYOQAViTUrgb77sgcw3iBtS1qC1f9OeJNfvX7bNSeJv8jMclyHU
         sUwzBHAoWExyEJnkJ6xnJzIuyeai1IUthE1/Ph3NpM+GJqdumt+NL5UO8P3/t8IVDhS7
         2bLsokpaLmvYc69G0DPs9JjCcBxa1H57OuqisYNRICExPZ7GcSjNP2pPQD7vGmL4QB0f
         IkLg==
X-Gm-Message-State: AOJu0YyWJmVYsLYgpaetTtNd2fUqWNtil3Lj1YwOfp9cBfhFOeaaRA2p
	EmG2fnWdb8V+BeMWYqTLDWrUDpt9MTCDpHFLjnMygqYdgJWBc/zmXdZWu0iaXcv7teonG6mXa0O
	6zmxVrQ==
X-Received: from pjdx8.prod.google.com ([2002:a17:90a:bc8:b0:35d:a9eb:ff55])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:28d0:b0:35c:30a8:31f
 with SMTP id 98e67ed59e1d1-35e4276a26cmr986041a91.2.1775779008661; Thu, 09
 Apr 2026 16:56:48 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Thu,  9 Apr 2026 16:56:22 -0700
In-Reply-To: <20260409235622.2052730-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260409235622.2052730-1-seanjc@google.com>
X-Mailer: git-send-email 2.53.0.1213.gd9a14994de-goog
Message-ID: <20260409235622.2052730-12-seanjc@google.com>
Subject: [PATCH 11/11] KVM: x86: Harden is_64_bit_hypercall() against bugs on
 32-bit kernels
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>, 
	Vitaly Kuznetsov <vkuznets@redhat.com>, David Woodhouse <dwmw2@infradead.org>, Paul Durrant <paul@xen.org>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Yosry Ahmed <yosry@kernel.org>
Content-Type: text/plain; charset="UTF-8"

Unconditionally return %false for is_64_bit_hypercall() on 32-bit kernels
to guard against incorrectly setting guest_state_protected, and because
in a (very) hypothetical world where 32-bit KVM supports protected guests,
assuming a hypercall was made in 64-bit mode is flat out wrong.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/x86.h | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/x86/kvm/x86.h b/arch/x86/kvm/x86.h
index cebea89b296c..5a79ec5f5bad 100644
--- a/arch/x86/kvm/x86.h
+++ b/arch/x86/kvm/x86.h
@@ -271,12 +271,16 @@ static inline bool is_64_bit_mode(struct kvm_vcpu *vcpu)
 
 static inline bool is_64_bit_hypercall(struct kvm_vcpu *vcpu)
 {
+#ifdef CONFIG_X86_64
 	/*
 	 * If running with protected guest state, the CS register is not
 	 * accessible. The hypercall register values will have had to been
 	 * provided in 64-bit mode, so assume the guest is in 64-bit.
 	 */
 	return vcpu->arch.guest_state_protected || is_64_bit_mode(vcpu);
+#else
+	return false;
+#endif
 }
 
 static inline bool x86_exception_has_error_code(unsigned int vector)
-- 
2.53.0.1213.gd9a14994de-goog

