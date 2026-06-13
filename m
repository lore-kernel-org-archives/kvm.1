Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E47538DD3
	for <kvm@vger.kernel.org>; Sat, 13 Jun 2026 00:03:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781309029; cv=none; b=Dxj+jeeUYV1pkkqKtQvRd3qDloNY2Ydz7Krbxpf91WxFsEgofPl50fDegLgGgIyoCIWyaT5Z9ooFDEhOLaunk5ye3GY/E7m4AVdJM0atZyk2fTtza+DrOEMaL2FxvxwPWoI6yuVrM3v5rrYQ9iwW8LDJqLPehhdk/ZiTs++lhw0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781309029; c=relaxed/simple;
	bh=ylefe9JgIcNwU2nDRKF4DQxEjsugSsIymNueIngwpBM=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=H2kBSipWxsb2Hgy0j5a+opf2BOWqiYs1LFMTyz/nUNTqNvXCGlDAD05zz5l+rOVviPy8gV6AMhBeoEwVOGSkEBut4p4b2bkiDYXDUhn+3siRJFXDWGFIh04dYS1E/twojCrPs1x7UapfbMivvbhMERxiQsGkS9zjSX+2xKydWko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=hRNNKT+Y; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="hRNNKT+Y"
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-8422ca754d8so1163728b3a.1
        for <kvm@vger.kernel.org>; Fri, 12 Jun 2026 17:03:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1781309024; x=1781913824; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=oRysUbRevtt3nFHcLXAJjhNOc5YQ8z/NfKqLVpBQ8Mk=;
        b=hRNNKT+YMOGjccM0wJKJbuNGEKSD4XhMkFJsshMdzTCzhqLkxX3uZKvfN8yXJo5R/F
         +b6S231f157k2b0EI1Aga9ejaAmK6eCxGNVWUalKgvuP+jGUyDWSsMNwn4Gl8wKWCijK
         E3YGxC5iqq6V507DqZQkfGjEesKAjwmA7eXe0DRs5KDibYYQrb4bIP4UEYFpgsfBNvsJ
         Cwe+faW/Sw16Y9zO7JMAVMrvF8M4SsTJA2EVjwQDXFZqGQ7uRhS0G75wIkkcscbTd4VB
         ZchZ8QQy3m+ZYWhX9Gg4ku2xQHJb7lW4F3ZAW7RiuTh8R93ImUSn4R/8F7uHkpSoIJ1d
         H6/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781309024; x=1781913824;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=oRysUbRevtt3nFHcLXAJjhNOc5YQ8z/NfKqLVpBQ8Mk=;
        b=ewNmr2pCemrHPiJRUgI6LJd8kZJpJX0oBA55ai3wQOglGgE+tN8fQ8N1Td+kHXzOzH
         D4ijdw6SBKjVUD80pwdp7EMcYQHjeY60/CqgaJY36W8elGJCypR6fGELILCew0YRpEvx
         MEKtXG976MKQUxdqRK7w69Pa2o207WHUyEJUZBIB7lQdfwaz8JTN9ZMOwKhaXnvjKCqs
         OTd+9HVNfROy3BmQpnxJBFW56nKowGczIi2gp2MeB+rEG7kcmnL60VO4ByUIyd6DiUEE
         dNg3GwC/EDiiatg9DWeDxQpUdlRrPlD7joawEjEPjF6W159A81H8az3ra/kpuZr/Yijo
         2dIw==
X-Gm-Message-State: AOJu0Yw5l02v8QT0+4JccnoeO42CEukzHq8WMZLR3HG7IY982eiaEDJd
	VTHiZuLqM+EYvyc18BNvM/B08x6cegvaYUCckVfUCgkj7sTcY2bA0franM1br8a+rqmzlkWkCJp
	Tn5lD+g==
X-Received: from pfjc12.prod.google.com ([2002:a05:6a00:8c:b0:82f:6a26:5f78])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:9519:b0:841:dc85:1638
 with SMTP id d2e1a72fcca58-8434d1009dcmr5178798b3a.42.1781309023496; Fri, 12
 Jun 2026 17:03:43 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Fri, 12 Jun 2026 17:03:07 -0700
In-Reply-To: <20260613000329.732085-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260613000329.732085-1-seanjc@google.com>
X-Mailer: git-send-email 2.54.0.1136.gdb2ca164c4-goog
Message-ID: <20260613000329.732085-9-seanjc@google.com>
Subject: [PATCH v4 08/30] KVM: x86: Move tdp_enabled from kvm_host.h to mmu.h
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>, 
	Vitaly Kuznetsov <vkuznets@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Yosry Ahmed <yosry@kernel.org>, Kai Huang <kai.huang@intel.com>
Content-Type: text/plain; charset="UTF-8"

Relocated the declaration of tdp_enabled into mmu.h, and opportunistically
hoist tdp_mmu_enabled up to the top so that the two are co-located.

No functional change intended.

Reviewed-by: Kai Huang <kai.huang@intel.com>
Reviewed-by: Yosry Ahmed <yosry@kernel.org>
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/include/asm/kvm_host.h |  2 --
 arch/x86/kvm/mmu.h              | 12 ++++++------
 2 files changed, 6 insertions(+), 8 deletions(-)

diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_host.h
index 57e67bad4abe..153ed5611c2e 100644
--- a/arch/x86/include/asm/kvm_host.h
+++ b/arch/x86/include/asm/kvm_host.h
@@ -2188,8 +2188,6 @@ void kvm_zap_gfn_range(struct kvm *kvm, gfn_t gfn_start, gfn_t gfn_end);
 
 int load_pdptrs(struct kvm_vcpu *vcpu, unsigned long cr3);
 
-extern bool tdp_enabled;
-
 /*
  * EMULTYPE_NO_DECODE - Set when re-emulating an instruction (after completing
  *			userspace I/O) to indicate that the emulation context
diff --git a/arch/x86/kvm/mmu.h b/arch/x86/kvm/mmu.h
index 28fca48dcf64..0eaea2d4fac9 100644
--- a/arch/x86/kvm/mmu.h
+++ b/arch/x86/kvm/mmu.h
@@ -6,6 +6,12 @@
 #include "regs.h"
 #include "cpuid.h"
 
+extern bool tdp_enabled;
+#ifdef CONFIG_X86_64
+extern bool tdp_mmu_enabled;
+#else
+#define tdp_mmu_enabled false
+#endif
 extern bool __read_mostly enable_mmio_caching;
 
 #define PT_WRITABLE_SHIFT 1
@@ -260,12 +266,6 @@ static inline bool kvm_shadow_root_allocated(struct kvm *kvm)
 	return smp_load_acquire(&kvm->arch.shadow_root_allocated);
 }
 
-#ifdef CONFIG_X86_64
-extern bool tdp_mmu_enabled;
-#else
-#define tdp_mmu_enabled false
-#endif
-
 int kvm_tdp_mmu_map_private_pfn(struct kvm_vcpu *vcpu, gfn_t gfn, kvm_pfn_t pfn);
 
 static inline bool kvm_memslots_have_rmaps(struct kvm *kvm)
-- 
2.54.0.1136.gdb2ca164c4-goog

