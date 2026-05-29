Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7277244D03B
	for <kvm@vger.kernel.org>; Fri, 29 May 2026 22:23:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780093391; cv=none; b=cV2RaTIDw+WHn5cC4hcIlOeVc5IP45LfcKU1x9c0VmOFtDciyQSKa68lHzY6F4QS0l6hLK5mVB749UuZ8LD6IOSUKruQWdKy9Bpj90Gj5AwiUD3cTcCm0GBsTWgHaQQWpxdFiuNvEvjOwYwLDl8lYxSqWbtjblexVtloZl4lV3k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780093391; c=relaxed/simple;
	bh=Ti1Cn/2X567vIP0NAUi9gjSta7WxFw3xhtt5JfIZGN4=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=bvYPh2otEpG5VRnO35qIAF8leKt60s6Mu9kJjP1f1k2B6JkH5YegUF/qliYOlpfOJ7rEO4UlHhhQIrVh/RBpqyr8/DMh97QF6nkXCeBXnzSwGbGOFBsTPC9856l/tKfg+VgcYyc4uU+muyWoTn+Scv2Jv+EpM9Z6Yk8QyTDrNW8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=SeK0Aelb; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="SeK0Aelb"
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-2bd6aeb3637so318818195ad.2
        for <kvm@vger.kernel.org>; Fri, 29 May 2026 15:23:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780093388; x=1780698188; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=C+zNop4iFEAB4FpwyQmbvIE0zFzjyJkNdQov+dfVU9Y=;
        b=SeK0AelbGS0+kvO7zIBBx3oCqA9pIFhqI0U7jcrJy38jHGfxx7DWirJ50GbFX9KLNx
         +FVIMSMQt+R/jkGKC3fp3VIU7itGGXFn7jOkioMxqVLeuRFD9NUIXNZTSIexDueyVpMa
         TSmWCPtSRKO+oX1mqzpumj//xRSx2XacMfhAvPV2c8YWZt6IoePcAsJJIebplUfO3Mzs
         +/sWCgJaIyTc19A4Jdafq1tMldec66lbMEzRfGcf1axKqgss84ZWun4/7NTIfpRIFgIJ
         VSB0rUvT4o6uvYd8K/8LaWIvCvqlgDwSbXj4nfvsU8Qml6raY+9oGru9MifV8Zah6dWV
         MreA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780093388; x=1780698188;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=C+zNop4iFEAB4FpwyQmbvIE0zFzjyJkNdQov+dfVU9Y=;
        b=OqRo01LzEcLOzHjzRlOIgZZNPrZzlud0aO9QqzPD9PVXxRSqvo2g5/UFz4UwLQ2K7R
         sgzSvmforj0gZtz4DcHCPBUUC+rXLZvMJEZlXSiiB6fPcLd/RXq2SboWrgZjVenjXb2A
         PxutH42TNKZS71O/lOv5mLTYGsqCmnXn9pnL3GuoZVe5rdVfwdVL1pXHQGACILML89Ot
         nQFKQVA2OazpkceRs1OYhzzTMiGZOki6Z+phgPG8A98F9yMPm2N03SvdW+/+4knKy8A4
         kl+Me/vEgHEdw3PTP9XH0D9NJM+Fkb/39Kw1/6YwhFDUgvGd4Hbc7/56/U3fkqM0XJ57
         cYrg==
X-Gm-Message-State: AOJu0YwqmAz2A0xvg+fynsTP8zpYM8eK4rYfEeQZ6AXyKXoQmKCTjHIx
	nE+oOI0sb+pnXyRecoBAzbimuOeUa7YP62WXe5ysOaIg0RVcXCVvjw93DedYwbkSYNix+WiE6v8
	HRgALyw==
X-Received: from pgww11.prod.google.com ([2002:a05:6a02:2c8b:b0:c85:f23:dde3])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:e88c:b0:2b2:4d36:7aa
 with SMTP id d9443c01a7336-2bf368859d8mr18740315ad.35.1780093387619; Fri, 29
 May 2026 15:23:07 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Fri, 29 May 2026 15:22:04 -0700
In-Reply-To: <20260529222223.870923-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260529222223.870923-1-seanjc@google.com>
X-Mailer: git-send-email 2.54.0.823.g6e5bcc1fc9-goog
Message-ID: <20260529222223.870923-22-seanjc@google.com>
Subject: [PATCH v3 21/40] KVM: x86: Move eager_page_split to mmu.{c,h}
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>, 
	Vitaly Kuznetsov <vkuznets@redhat.com>, David Woodhouse <dwmw2@infradead.org>, Paul Durrant <paul@xen.org>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Yosry Ahmed <yosry@kernel.org>, Binbin Wu <binbin.wu@linux.intel.com>, 
	David Woodhouse <dwmw@amazon.co.uk>, Kai Huang <kai.huang@intel.com>
Content-Type: text/plain; charset="UTF-8"

Move KVM's eager_page_split module param to the MMU, as it is very much an
MMU knob.

No functional change intended.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/mmu.h     | 1 +
 arch/x86/kvm/mmu/mmu.c | 3 +++
 arch/x86/kvm/x86.c     | 3 ---
 arch/x86/kvm/x86.h     | 2 --
 4 files changed, 4 insertions(+), 5 deletions(-)

diff --git a/arch/x86/kvm/mmu.h b/arch/x86/kvm/mmu.h
index 0eaea2d4fac9..d30676935fff 100644
--- a/arch/x86/kvm/mmu.h
+++ b/arch/x86/kvm/mmu.h
@@ -13,6 +13,7 @@ extern bool tdp_mmu_enabled;
 #define tdp_mmu_enabled false
 #endif
 extern bool __read_mostly enable_mmio_caching;
+extern bool eager_page_split;
 
 #define PT_WRITABLE_SHIFT 1
 #define PT_USER_SHIFT 2
diff --git a/arch/x86/kvm/mmu/mmu.c b/arch/x86/kvm/mmu/mmu.c
index b8f2edf2cfeb..e4d971d42f0e 100644
--- a/arch/x86/kvm/mmu/mmu.c
+++ b/arch/x86/kvm/mmu/mmu.c
@@ -114,6 +114,9 @@ module_param_named(tdp_mmu, tdp_mmu_enabled, bool, 0444);
 EXPORT_SYMBOL_FOR_KVM_INTERNAL(tdp_mmu_enabled);
 #endif
 
+bool __read_mostly eager_page_split = true;
+module_param(eager_page_split, bool, 0644);
+
 static int max_huge_page_level __read_mostly;
 static int tdp_root_level __read_mostly;
 static int max_tdp_level __read_mostly;
diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index 20eeff79b46d..be421f467563 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -177,9 +177,6 @@ module_param(force_emulation_prefix, int, 0644);
 int __read_mostly pi_inject_timer = -1;
 module_param(pi_inject_timer, bint, 0644);
 
-bool __read_mostly eager_page_split = true;
-module_param(eager_page_split, bool, 0644);
-
 /* Enable/disable SMT_RSB bug mitigation */
 static bool __read_mostly mitigate_smt_rsb;
 module_param(mitigate_smt_rsb, bool, 0444);
diff --git a/arch/x86/kvm/x86.h b/arch/x86/kvm/x86.h
index a0e68eaf1f80..635a21bfa681 100644
--- a/arch/x86/kvm/x86.h
+++ b/arch/x86/kvm/x86.h
@@ -415,8 +415,6 @@ extern int pi_inject_timer;
 
 extern bool report_ignored_msrs;
 
-extern bool eager_page_split;
-
 static inline void kvm_pr_unimpl_wrmsr(struct kvm_vcpu *vcpu, u32 msr, u64 data)
 {
 	if (report_ignored_msrs)
-- 
2.54.0.823.g6e5bcc1fc9-goog

