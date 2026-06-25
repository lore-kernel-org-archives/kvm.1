Received: from mail-pg1-f202.google.com (mail-pg1-f202.google.com [209.85.215.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B56983793DE
	for <kvm@vger.kernel.org>; Thu, 25 Jun 2026 22:05:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782425113; cv=none; b=OR54a5m27keG+OojB/gcr72oA8qZfEFm9c/a4E3quHuFsVskvvRatBJbvSoQJEMCzehLg1x43LjgEcHUSe29AvDDwbMFxBCTxI9nnD/0rsM5yaDF8E0120navi0JOVtLnxVlzkRsthp6A5H+vKxyq9un4LouoM/OBfWte3NY1B8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782425113; c=relaxed/simple;
	bh=mD7qRJ4tWTYKul9nyqh7evQYsIh41idiEG4HedbvgB4=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=GP/2zUwnzoCcEQf8Rug/LrXg6C0KeVAYyKi7VsPAqs/07tcWqDfTVMsEx3ZjB1B3yIVBtAI8kAUS8a4v6yGQF26WyUT5EfGWely/cN7wvhw6ZF1k+4dN6Fje/wc/NZEciIOpMpSjWzwvz0V9qY4SpcgAt5Jn0y5K6AFBvFBTqDM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Dhu2DOfQ; arc=none smtp.client-ip=209.85.215.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Dhu2DOfQ"
Received: by mail-pg1-f202.google.com with SMTP id 41be03b00d2f7-c89956023dbso167840a12.0
        for <kvm@vger.kernel.org>; Thu, 25 Jun 2026 15:05:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1782425103; x=1783029903; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=HbM8iSooNI5ZtGNOvlQPJhXux6evN6doi/+axz0jSVg=;
        b=Dhu2DOfQty9I6ak+u2NASxtjjz27DPv3RvkbXTBrmtwUxGjUTA6a65u2c5eJYDBlI+
         OM/2IGS35M7FyJPUrOXpEPD35ryvh9J9Bu6XD0m9EfYYy3L0kiolzc9EKXs4SPKxYLY0
         O7t/FjIYkvtKKEtJOUBbYZQo6uKejdzf0KsBu4SrD+/CPy+PoOtZi08JGvKz9bhl+oTH
         5qqwzH2UcYKXS5X+nzfKo4td/4i6GIPjYv484mRgmWMMvo+wnoKRylOZxDtDbry34wk2
         kV5UqzE5avbgv0hyBGuqVehw3dpXaWA5gmFtvHG4EcYSWVbbOqe7Cd6L2OCGnICGhFSC
         /Wpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782425103; x=1783029903;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HbM8iSooNI5ZtGNOvlQPJhXux6evN6doi/+axz0jSVg=;
        b=OEXYSKDdzHQZZ6aXrwcaPWozxvT2HHSsWL6X7yXx+tXMOU7NyYlGKmlU35nmTK6LAQ
         9ofHHW6TnUrebaKwhClqQSrHQD/ZAcul5qU0WCSrXEGWKvCWwgHLiAxvvKec7usSQEll
         Dpvg0dpZf8wjS37Loz0oIXrp1FlHAn9tyLm6+WXKNzL7bM+XtpGTWNz+bwRzg7GQRdGj
         GNdmlrCWJm9YLIjIPoGef98SjJwFadwBn5i7BRDpH7Mntf/60hmK7PtSoPt2SqZTQeT9
         zmmeKl+8ITTCjJ7MGX6UJ1aGByCHPReTrac4QHw3Z7ptx8eGE0PFausPcG7Qqx9tQ8CK
         j0ig==
X-Gm-Message-State: AOJu0YyDiqaK8Zp594fPMTOQcrnfQnNHmEVwrEtlEC317U25oy5wBhGD
	q+BgRm/jzIWAMbJAGFTjv8ZGLV6pH4pNCLNovZs6eRBhH3bb8vfbE2Jo44zO6JlHVrG/KyGpag2
	LOT80Tg==
X-Received: from pgbbq3.prod.google.com ([2002:a05:6a02:443:b0:c82:26d4:bb49])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a20:734c:b0:398:9379:d04d
 with SMTP id adf61e73a8af0-3bd4aec5a05mr4943479637.24.1782425102478; Thu, 25
 Jun 2026 15:05:02 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Thu, 25 Jun 2026 15:04:49 -0700
In-Reply-To: <20260625220450.3354415-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260625220450.3354415-1-seanjc@google.com>
X-Mailer: git-send-email 2.55.0.rc0.799.gd6f94ed593-goog
Message-ID: <20260625220450.3354415-9-seanjc@google.com>
Subject: [PATCH 8/9] KVM: x86: Move "struct kvm_apic_map" definition from
 kvm_host.h => lapic.h
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>, 
	Vitaly Kuznetsov <vkuznets@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Binbin Wu <binbin.wu@linux.intel.com>, Kai Huang <kai.huang@intel.com>
Content-Type: text/plain; charset="UTF-8"

Move the definition of "struct kvm_apic_map", a.k.a. the optimized local
APIC map, to lapic.h, as it is very nearly an implementation details that's
internal to KVM's local APIC emulation (KVM also uses the map to do quick
lookups when a vCPU is yielding to a different vCPU).

No functional change intended.

Suggested-by: Kai Huang <kai.huang@intel.com>
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/include/asm/kvm_host.h | 35 ++-------------------------------
 arch/x86/kvm/lapic.h            | 33 +++++++++++++++++++++++++++++++
 2 files changed, 35 insertions(+), 33 deletions(-)

diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_host.h
index c7d53d46763b..90efc3c90b41 100644
--- a/arch/x86/include/asm/kvm_host.h
+++ b/arch/x86/include/asm/kvm_host.h
@@ -244,6 +244,8 @@ enum x86_intercept_stage;
 struct kvm_kernel_irqfd;
 struct kvm_kernel_irq_routing_entry;
 
+struct kvm_apic_map;
+
 struct kvm_x86_msr_filter;
 struct kvm_x86_pmu_event_filter;
 
@@ -1122,39 +1124,6 @@ struct kvm_arch_memory_slot {
 	unsigned short *gfn_write_track;
 };
 
-/*
- * Track the mode of the optimized logical map, as the rules for decoding the
- * destination vary per mode.  Enabling the optimized logical map requires all
- * software-enabled local APIs to be in the same mode, each addressable APIC to
- * be mapped to only one MDA, and each MDA to map to at most one APIC.
- */
-enum kvm_apic_logical_mode {
-	/* All local APICs are software disabled. */
-	KVM_APIC_MODE_SW_DISABLED,
-	/* All software enabled local APICs in xAPIC cluster addressing mode. */
-	KVM_APIC_MODE_XAPIC_CLUSTER,
-	/* All software enabled local APICs in xAPIC flat addressing mode. */
-	KVM_APIC_MODE_XAPIC_FLAT,
-	/* All software enabled local APICs in x2APIC mode. */
-	KVM_APIC_MODE_X2APIC,
-	/*
-	 * Optimized map disabled, e.g. not all local APICs in the same logical
-	 * mode, same logical ID assigned to multiple APICs, etc.
-	 */
-	KVM_APIC_MODE_MAP_DISABLED,
-};
-
-struct kvm_apic_map {
-	struct rcu_head rcu;
-	enum kvm_apic_logical_mode logical_mode;
-	u32 max_apic_id;
-	union {
-		struct kvm_lapic *xapic_flat_map[8];
-		struct kvm_lapic *xapic_cluster_map[16][4];
-	};
-	struct kvm_lapic *phys_map[];
-};
-
 /* Hyper-V synthetic debugger (SynDbg)*/
 struct kvm_hv_syndbg {
 	struct {
diff --git a/arch/x86/kvm/lapic.h b/arch/x86/kvm/lapic.h
index 58dbb94f980d..bd1098c89d99 100644
--- a/arch/x86/kvm/lapic.h
+++ b/arch/x86/kvm/lapic.h
@@ -32,6 +32,39 @@ enum lapic_mode {
 	LAPIC_MODE_X2APIC = MSR_IA32_APICBASE_ENABLE | X2APIC_ENABLE,
 };
 
+/*
+ * Track the mode of the optimized logical map, as the rules for decoding the
+ * destination vary per mode.  Enabling the optimized logical map requires all
+ * software-enabled local APIs to be in the same mode, each addressable APIC to
+ * be mapped to only one MDA, and each MDA to map to at most one APIC.
+ */
+enum kvm_apic_logical_mode {
+	/* All local APICs are software disabled. */
+	KVM_APIC_MODE_SW_DISABLED,
+	/* All software enabled local APICs in xAPIC cluster addressing mode. */
+	KVM_APIC_MODE_XAPIC_CLUSTER,
+	/* All software enabled local APICs in xAPIC flat addressing mode. */
+	KVM_APIC_MODE_XAPIC_FLAT,
+	/* All software enabled local APICs in x2APIC mode. */
+	KVM_APIC_MODE_X2APIC,
+	/*
+	 * Optimized map disabled, e.g. not all local APICs in the same logical
+	 * mode, same logical ID assigned to multiple APICs, etc.
+	 */
+	KVM_APIC_MODE_MAP_DISABLED,
+};
+
+struct kvm_apic_map {
+	struct rcu_head rcu;
+	enum kvm_apic_logical_mode logical_mode;
+	u32 max_apic_id;
+	union {
+		struct kvm_lapic *xapic_flat_map[8];
+		struct kvm_lapic *xapic_cluster_map[16][4];
+	};
+	struct kvm_lapic *phys_map[];
+};
+
 enum lapic_lvt_entry {
 	LVT_TIMER,
 	LVT_THERMAL_MONITOR,
-- 
2.55.0.rc0.799.gd6f94ed593-goog

