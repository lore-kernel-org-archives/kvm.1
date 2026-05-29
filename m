Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com [209.85.215.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 778D844CAE0
	for <kvm@vger.kernel.org>; Fri, 29 May 2026 22:23:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780093389; cv=none; b=N3q4/Mq9Ai/5UuFEIYB2jD539ttig+/padVY6Wd+nrwz0MZ8G35ddBktYDTTCAJnpVMe5GyfoMPRzv4JP5fcq4A5F1+nW1REgNXlXaKzS2nIscHmMv3nPIJDm2kv0rZ0wafDzSzbHYwpHVMdLb+hnXKSVgiMiTazShn00XlcwHs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780093389; c=relaxed/simple;
	bh=3bWgCpS2MbNhs++wve21pEQGVhhVlqSYucSuMxg7WfU=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=VjHmqMa8kwCioP0F/D61Imik+UZ/M2bJwcKZPGZ8zuNYId4V22fbxelCu77sr65ZtxiHW/68XVN++QaqS1crjdNp8RzfHbnQmLQQKmHyWGwGkUvsYeHizip07tXOOxJbZ/pP4whvP62HUWFuOTwrTSZ7bHrjykiLDOrswneXd+Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=DnMzeHGD; arc=none smtp.client-ip=209.85.215.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="DnMzeHGD"
Received: by mail-pg1-f201.google.com with SMTP id 41be03b00d2f7-c827bda3052so18866181a12.1
        for <kvm@vger.kernel.org>; Fri, 29 May 2026 15:23:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780093387; x=1780698187; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=z4vKYiOMnnjQ6reYOu2qF0Gs5UxLrj65gv1yx1wc+84=;
        b=DnMzeHGDitw8KxuzKkhnriPV5vF7Ij/+PuXXEgP6t5sprmpIokgLBPirv9Wm237O6P
         TmeSHAJlI5lQzoAAWo0JCSRuJ72q1o5x7I9AMCjAk7jsMrLTSy1OBcpvo8Vo4gK5DYWo
         VGHS02HxOMUSHCKNPACB1iQbvjlqi2U695bt0vFSLecpyyIiWzr9CoB0RAwc0YtETlRQ
         KZ9H2QIlp9yV27xQC7aBanrXKZls+ZFTpRwfpaqI04uFt2jHBgTxLPIWGPpye2gq9rsE
         6Hjv/Jy9hWL8ozacCfDxLZhdViaUqk98pKfnYL+zsy3RzMC4ib3G3Ifa9LnGVXiTsfqk
         qKJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780093387; x=1780698187;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=z4vKYiOMnnjQ6reYOu2qF0Gs5UxLrj65gv1yx1wc+84=;
        b=p+GGiRB13scQjEs5nTG3f6MrlDg1H8o1VCiceYv7aK/p6PXk3IQBNNa9pKcCOZlPrS
         BbGR/ImyQ/XlcLoss3aTOcyvoUUjzqvaLF5WdEwq97YC5YZhLVPnh8UCPwUtjmGITama
         GJGQEQ/yDupWAvzpcY1iEUEZpEwxDM7crMc9QiVGCGSd4sEsi58ZK4crm222GmNznnQk
         MaQHqkkt/q26cpm/kFsGvPDmmSC8Z+zcaMGgVuvOhsFQI9RHehTtU28MqwyG5iCVnjgN
         gweoT4HLAcnWAtW/WM+ay2+i6+YLxl4Zzc5lMuuL7QWzibSqVN7eFxSMB2fD02nnwoCG
         4XHg==
X-Gm-Message-State: AOJu0YyfvTMLbYtyOC6zjpoPhei2U8jOJvNgnmmnv5GuHN/k4S6Gu27f
	deoUQjupujVNp1FBvJquHETCCU1MemZvOfmgB0BNQKs5PgdJLUA4J6GmvKYfR05R6qcvS88gcrx
	/ZlEnkQ==
X-Received: from pgcq19.prod.google.com ([2002:a63:7513:0:b0:c76:3f60:53ff])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a21:6017:b0:39f:a42:9251
 with SMTP id adf61e73a8af0-3b427f2af2cmr1232182637.22.1780093386530; Fri, 29
 May 2026 15:23:06 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Fri, 29 May 2026 15:22:03 -0700
In-Reply-To: <20260529222223.870923-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260529222223.870923-1-seanjc@google.com>
X-Mailer: git-send-email 2.54.0.823.g6e5bcc1fc9-goog
Message-ID: <20260529222223.870923-21-seanjc@google.com>
Subject: [PATCH v3 20/40] KVM: x86: Move tdp_enabled from kvm_host.h to mmu.h
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>, 
	Vitaly Kuznetsov <vkuznets@redhat.com>, David Woodhouse <dwmw2@infradead.org>, Paul Durrant <paul@xen.org>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Yosry Ahmed <yosry@kernel.org>, Binbin Wu <binbin.wu@linux.intel.com>, 
	David Woodhouse <dwmw@amazon.co.uk>, Kai Huang <kai.huang@intel.com>
Content-Type: text/plain; charset="UTF-8"

Relocated the declaration of tdp_enabled into mmu.h, and opportunistically
hoist tdp_mmu_enabled up to the top so that the two are co-located.

No functional change intended.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/include/asm/kvm_host.h |  2 --
 arch/x86/kvm/mmu.h              | 12 ++++++------
 2 files changed, 6 insertions(+), 8 deletions(-)

diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_host.h
index f7130eb98473..19091d89d3cc 100644
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
2.54.0.823.g6e5bcc1fc9-goog

