Received: from mail-pg1-f202.google.com (mail-pg1-f202.google.com [209.85.215.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91ED942048
	for <kvm@vger.kernel.org>; Sat, 13 Jun 2026 00:03:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781309031; cv=none; b=nQc6osTGLcK6hbt0/A1dC/aAhVpIaGbMzVCDA0Fnpg8NPmjalokT33CmjHO6SZ0W/mpfrqb4sbWcxDJI4xILfqLQdxmuZwWf4a3lX1ihBunP2CylYE15v8ypZYCtFzM1+2mOoezy5jw7JJaAlWu48Su+EqW2O84/k4FQFFZXiug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781309031; c=relaxed/simple;
	bh=MnpsvvijNtbTUs1CpTOBk2diwDJl4VN3pPGd+QyBodU=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=O2+wkAxuFADyFAF2T1z5Fi7o+Dgs2TZpxk7ZVONFrUB3F0kmvP54znQ3S8ARi+DQk+Qqmr0ZClfUyz146+nL4zkVXMux3GYwDvPGMbPDcoyGkNZoVx4xN5Z0UdTloHLJfJgblsDu9H6TbN9W1Y6jVsZZ2Sx4fDN3POy0rHwiO4k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=HGzHWG0V; arc=none smtp.client-ip=209.85.215.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="HGzHWG0V"
Received: by mail-pg1-f202.google.com with SMTP id 41be03b00d2f7-c860544c077so1734866a12.3
        for <kvm@vger.kernel.org>; Fri, 12 Jun 2026 17:03:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1781309025; x=1781913825; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=NLX3qZqnlfQGl3+jDRSZTVljrDKgqUaF9/x0hgpCIZE=;
        b=HGzHWG0VrJEfOsE/SvAlOVUd0QYTL6akbsTaMfSyFilsFa6I765ECzaxgCkmQqEsCw
         9lG/y8ABTWh/bC7Djgmk2V4e0kucamLp6XMLVJ8p2E4hnoCJhuOyyzZ9Xk6+wcCm48Z8
         r6uXfxbljgNnGvjsC7zb2sxyHgzVkO2rwLCleS5GhqoLa05VAHApsp8nXOaWfq5OaNOO
         rEIu6l87euU4DcQug/I6ERN1z0jMex2+sbo4POU2evTpfqccBHtL5vWX9eYX/re7srUM
         nnTFEC/cIwoWHmAKW3CBSFloTtx1N0StDisvZz7ZoWN7xwd7+vQpqwJTf7KNMq6ZpYgD
         zvGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781309025; x=1781913825;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NLX3qZqnlfQGl3+jDRSZTVljrDKgqUaF9/x0hgpCIZE=;
        b=mT67FslBnH2BKk9xGW8VcKm6U/By0c78julM4Bs0IlYoCPAJ5z2SkukXwPlhFF1BH6
         5Dblyrj4LurUD+lvRHtq9PZeJ6GUpbpuV6RUhfjG5sGDGF65K2LmzQbP2MFnk/B6qgRx
         diXRVIybKYzts/SAdI3OfJEIgnluEjkLpHf4cz4syYnUQVGWkfQIMU1aLVoN9C3KHz+K
         SyVUujCTh9PFCAOVJM8gZj+WAQpdZEmQJnM8kV6YlCWN6FE5i7agzSts5J1GgDqBdmxu
         K8fTfIXhuEXeC+XydBuG+tNvS0C0bjXLYFuBlwTdlgxZWCspiVuIgrrd0x1SzKLT811w
         VCEA==
X-Gm-Message-State: AOJu0YwaN2ku0l2BqxLFvupfA5CfGrAixjiPlVKs7+4BoCXFpjIzF1wN
	032Rz+1DwzB+pgbXOEMTT7og9CSpjn8WR+LxzfUrfEsTzSBSL734mI7yapDEj/rjQsPA6MDVdYW
	mWbDaGQ==
X-Received: from pfww5-n1.prod.google.com ([2002:a05:6a00:8885:10b0:842:6e9f:9d2])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:2da8:b0:842:6099:c55c
 with SMTP id d2e1a72fcca58-8434caeba21mr5555654b3a.3.1781309024666; Fri, 12
 Jun 2026 17:03:44 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Fri, 12 Jun 2026 17:03:08 -0700
In-Reply-To: <20260613000329.732085-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260613000329.732085-1-seanjc@google.com>
X-Mailer: git-send-email 2.54.0.1136.gdb2ca164c4-goog
Message-ID: <20260613000329.732085-10-seanjc@google.com>
Subject: [PATCH v4 09/30] KVM: x86: Move eager_page_split to mmu.{c,h}
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>, 
	Vitaly Kuznetsov <vkuznets@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Yosry Ahmed <yosry@kernel.org>, Kai Huang <kai.huang@intel.com>
Content-Type: text/plain; charset="UTF-8"

Move KVM's eager_page_split module param to the MMU, as it is very much an
MMU knob.

No functional change intended.

Reviewed-by: Kai Huang <kai.huang@intel.com>
Reviewed-by: Yosry Ahmed <yosry@kernel.org>
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
index 9368a71336fe..313106e84a64 100644
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
index 9eb46b370fad..3813078cc028 100644
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
2.54.0.1136.gdb2ca164c4-goog

