Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6ABD53CFF42
	for <kvm@vger.kernel.org>; Thu, 26 Mar 2026 18:17:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774549081; cv=none; b=HjoUfBsDZNJgWnamUSkk2w6ZYypA3Gf3vVPKBli6ncFp50F1FWTJVPM0mCMKlza2CMmKj9EnhGAvaxEP5y+SRFXcNdsyP0OMS06djU8k3JutflPG+mrzLzpWXx1zOl7+3UT+ZCsGAnjD4eIwd30IdgNY7jg26RNdtc6CjpBLw88=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774549081; c=relaxed/simple;
	bh=pS1J8W8fO4+3tnDj88CZnxAyKm0FKvsBhMP+n0FPrMc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pX2UHMU+Qh5LI66XIR9zw3o5klXlGTr6UeEuxrUr5sdHxYnE7Ib11Oq5RaDzFFLxwCwEMrf2Jv59P10yKt0pj/GO3jTioA6N+a5FSJQbUgTHtT0IT2Z6uOXaio/ezhJPCmN0zZJE3EI558pL4WNGpcgsWWVHVZs7/7UoIhZyfks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=VHLwbOfe; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=pv76CWUR; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VHLwbOfe";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="pv76CWUR"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1774549075;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=K8T8CyELIjmZrSOM7uiAWDk5u4n6lA2+sMqy1wRdzGU=;
	b=VHLwbOfeWoYEC4v2zsR67kJwOcCH+hk1tMmfrdtqROZHdyvHHSJL4QykpHzow7FfxFS/1l
	NDSMF8JNdXUKfLzvmTECi0YjvMe/nKTbE13YJEUWXXXPJb+2svJzb8xVU9BITwRrLpY3ZX
	1i7AdegOVnhXL893fhx9dLM1jqitCpU=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-613-5A1e-aGFNXKhE6NT-t5XFA-1; Thu, 26 Mar 2026 14:17:53 -0400
X-MC-Unique: 5A1e-aGFNXKhE6NT-t5XFA-1
X-Mimecast-MFC-AGG-ID: 5A1e-aGFNXKhE6NT-t5XFA_1774549072
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-439a85832c0so81285f8f.2
        for <kvm@vger.kernel.org>; Thu, 26 Mar 2026 11:17:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1774549072; x=1775153872; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=K8T8CyELIjmZrSOM7uiAWDk5u4n6lA2+sMqy1wRdzGU=;
        b=pv76CWUR+uVQiJITEeL8bO/xrA/ZgiMrciFb7w8oQiRuZjtQqLgK3VW4oqwyZuepdS
         enfDCJhdhKiKdJdCsBzaenxKQs7iA3T0T2z/FfMv2E4evMxIutVUh3vOtxjACry8wZT7
         MysqHU86lo2VgR0g5YWgzm/Um4oI9L7yHlEJcmipIzcgFlFspodJaQbCCiuV9Y19n1H7
         NafDZxct59bQrfRyyk0SBah65N3O4//XmVRrk5wsydeWEnz22f8B9s/ls/DlmAO+fguo
         357jxcgzwFwbmxEgTQPztqE9V/17YzysDZkwqurYdgzcu/gXiIbc+7Rp1Qx54fjilhy/
         yFnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774549072; x=1775153872;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=K8T8CyELIjmZrSOM7uiAWDk5u4n6lA2+sMqy1wRdzGU=;
        b=BRlO7tgVQ5P9uFVSuPPIHrLGs/x0x7GRkeCpU0SmkjqtQKqmmIOcMqtAqdfyDXOeod
         58L1L215KzOaU+chaPOJOegfJSbYr2vTcpcB6bb8S15zb/+khuH4I8H+HP8NwBZwjQpS
         le9nfwTU1XU1tYJSq6MlOz3BOrZhF9lppybbZeG26z63sUF70dj9m8t7HpCVIWdGLRFg
         Av0Pdq4jVZ1Zb+Qxo04n8hJEPJtHCD3uVDG1BKLA+i7FrQci2RHXdICkKCdD1ymXXSjQ
         QkCV3f/2JZjjJCEWC1m8G5vbBxSkF8b1JdT+EtYLDmg/Cn4R39IRPK8by2kIWl2JKUmX
         MBRw==
X-Forwarded-Encrypted: i=1; AJvYcCWeU2H4bH5pT6yyRhjZXRKc0HXmU5p8gcM/ECrJpvuNml/2N+iJv+tegsZz/+bVUAODiuo=@vger.kernel.org
X-Gm-Message-State: AOJu0YxTiqeWpIZuel0qU23yrU70MilcmzevlHUu/HaJgkq2KOrZUxtc
	6kjNvSy6IuzIu6o01fJNkj+CB4CiafFgy//ThTvy5vDNzjRwxw2xr+T2Zx/fyizNkfDm0fyhfUK
	t2K6zPXJ7YZ5XuooWQHsryM5LDXqzi4s/J3oJnDwt49QhvuF4Z7YM9w==
X-Gm-Gg: ATEYQzzPWKN4W6cS+fKkZbbGsbxDXFgGykT3lIR1V6MPh1qfCxuMMghnt2Nw3lMzO7E
	jOaR+EMdkZchKWcuiAkyvtMA9532e9uZN6LWziv6gA5rczcPPU9425q/4O+8cR8kl5Mf9Va3E3W
	0b93X2yOvLEfOM5kW2xieQte3nEU/jnKrrLwqt/IYz4IZFZ9u9UCHw7CyeVNwEMx9sO43SekvT3
	yWDSsirTNWnxLOWwTPexivpBE0pXpReVzJkzpivZRjGgJkSRSvJfbiutx78Imb4Pi8XxNzWk8I+
	BR6o9o4AtXdrTG6DtNvwULO7/7Ip82hi5qps7x1/4x0HRs08Tg1jFE7MRYIlUco4159d1m0Bh6o
	/eall07yF57aT7rkpTPXnSt0u7fxwLx8tpV45q64RjS9NgcDFly4AUA+jYZ80oIiHmPXPpIgMck
	nxu30LWlJc6S529bKyguEVLZK7
X-Received: by 2002:a05:6000:220b:b0:43b:43ae:8c25 with SMTP id ffacd0b85a97d-43b88a44842mr13657636f8f.52.1774549072092;
        Thu, 26 Mar 2026 11:17:52 -0700 (PDT)
X-Received: by 2002:a05:6000:220b:b0:43b:43ae:8c25 with SMTP id ffacd0b85a97d-43b88a44842mr13657569f8f.52.1774549071543;
        Thu, 26 Mar 2026 11:17:51 -0700 (PDT)
Received: from [192.168.10.48] ([151.49.85.67])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43b9192e3f9sm10324620f8f.7.2026.03.26.11.17.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Mar 2026 11:17:50 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: linux-kernel@vger.kernel.org,
	kvm@vger.kernel.org
Cc: Jon Kohler <jon@nutanix.com>,
	Nikunj A Dadhania <nikunj@amd.com>,
	Amit Shah <amit.shah@amd.com>,
	Sean Christopherson <seanjc@google.com>,
	Marcelo Tosatti <mtosatti@redhat.com>
Subject: [PATCH 10/24] KVM: x86/mmu: split XS/XU bits for EPT
Date: Thu, 26 Mar 2026 19:17:08 +0100
Message-ID: <20260326181723.218115-11-pbonzini@redhat.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260326181723.218115-1-pbonzini@redhat.com>
References: <20260326181723.218115-1-pbonzini@redhat.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When EPT is in use, replace ACC_USER_MASK with ACC_USER_EXEC_MASK,
so that supervisor and user-mode execution can be controlled
independently (ACC_USER_MASK would not allow a setting similar to
XU=0 XS=1 W=1 R=1).

Replace shadow_x_mask with shadow_xs_mask/shadow_xu_mask, to allow
setting XS and XU bits separately in EPT entries.

Note that ACC_USER_EXEC_MASK is already set through ACC_ALL in
the kvm_mmu_page roles, but it does not propagate to the XU bit
because shadow_xs_mask == shadow_xu_mask.  On the other hand,
access tracking for eptad=0 does take it into account when
saving/restoring page permissions.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 arch/x86/kvm/mmu/mmu.c      |  2 +-
 arch/x86/kvm/mmu/mmutrace.h |  6 ++---
 arch/x86/kvm/mmu/spte.c     | 49 +++++++++++++++++++++++--------------
 arch/x86/kvm/mmu/spte.h     |  8 +++---
 4 files changed, 40 insertions(+), 25 deletions(-)

diff --git a/arch/x86/kvm/mmu/mmu.c b/arch/x86/kvm/mmu/mmu.c
index dd5419a1f891..a6ee467ad838 100644
--- a/arch/x86/kvm/mmu/mmu.c
+++ b/arch/x86/kvm/mmu/mmu.c
@@ -5472,7 +5472,7 @@ static void reset_shadow_zero_bits_mask(struct kvm_vcpu *vcpu,
 static inline bool boot_cpu_is_amd(void)
 {
 	WARN_ON_ONCE(!tdp_enabled);
-	return shadow_x_mask == 0;
+	return shadow_xs_mask == 0;
 }
 
 /*
diff --git a/arch/x86/kvm/mmu/mmutrace.h b/arch/x86/kvm/mmu/mmutrace.h
index dcfdfedfc4e9..3429c1413f42 100644
--- a/arch/x86/kvm/mmu/mmutrace.h
+++ b/arch/x86/kvm/mmu/mmutrace.h
@@ -357,8 +357,8 @@ TRACE_EVENT(
 		__entry->sptep = virt_to_phys(sptep);
 		__entry->level = level;
 		__entry->r = shadow_present_mask || (__entry->spte & PT_PRESENT_MASK);
-		__entry->x = is_executable_pte(__entry->spte);
-		__entry->u = shadow_user_mask ? !!(__entry->spte & shadow_user_mask) : -1;
+		__entry->x = (__entry->spte & (shadow_xs_mask | shadow_nx_mask)) == shadow_xs_mask;
+		__entry->u = !!(__entry->spte & (shadow_xu_mask | shadow_user_mask));
 	),
 
 	TP_printk("gfn %llx spte %llx (%s%s%s%s) level %d at %llx",
@@ -366,7 +366,7 @@ TRACE_EVENT(
 		  __entry->r ? "r" : "-",
 		  __entry->spte & PT_WRITABLE_MASK ? "w" : "-",
 		  __entry->x ? "x" : "-",
-		  __entry->u == -1 ? "" : (__entry->u ? "u" : "-"),
+		  __entry->u ? "u" : "-",
 		  __entry->level, __entry->sptep
 	)
 );
diff --git a/arch/x86/kvm/mmu/spte.c b/arch/x86/kvm/mmu/spte.c
index 7b5f118ae211..fc7eb73476f6 100644
--- a/arch/x86/kvm/mmu/spte.c
+++ b/arch/x86/kvm/mmu/spte.c
@@ -29,8 +29,9 @@ bool __read_mostly kvm_ad_enabled;
 u64 __read_mostly shadow_host_writable_mask;
 u64 __read_mostly shadow_mmu_writable_mask;
 u64 __read_mostly shadow_nx_mask;
-u64 __read_mostly shadow_x_mask; /* mutual exclusive with nx_mask */
 u64 __read_mostly shadow_user_mask;
+u64 __read_mostly shadow_xs_mask; /* mutual exclusive with nx_mask and user_mask */
+u64 __read_mostly shadow_xu_mask; /* mutual exclusive with nx_mask and user_mask */
 u64 __read_mostly shadow_accessed_mask;
 u64 __read_mostly shadow_dirty_mask;
 u64 __read_mostly shadow_mmio_value;
@@ -216,22 +217,30 @@ bool make_spte(struct kvm_vcpu *vcpu, struct kvm_mmu_page *sp,
 	 * when CR0.PG is toggled, but leveraging that to ignore the mitigation
 	 * would tie make_spte() further to vCPU/MMU state, and add complexity
 	 * just to optimize a mode that is anything but performance critical.
+	 *
+	 * Use ACC_USER_EXEC_MASK here assuming only Intel processors (EPT)
+	 * are affected by the NX huge page erratum.
 	 */
-	if (level > PG_LEVEL_4K && (pte_access & ACC_EXEC_MASK) &&
+	if (level > PG_LEVEL_4K &&
+	    (pte_access & (ACC_EXEC_MASK | ACC_USER_EXEC_MASK)) &&
 	    is_nx_huge_page_enabled(vcpu->kvm)) {
-		pte_access &= ~ACC_EXEC_MASK;
+		pte_access &= ~(ACC_EXEC_MASK | ACC_USER_EXEC_MASK);
 	}
 
 	if (pte_access & ACC_READ_MASK)
 		spte |= PT_PRESENT_MASK; /* or VMX_EPT_READABLE_MASK */
 
-	if (pte_access & ACC_EXEC_MASK)
-		spte |= shadow_x_mask;
-	else
-		spte |= shadow_nx_mask;
-
-	if (pte_access & ACC_USER_MASK)
-		spte |= shadow_user_mask;
+	if (shadow_nx_mask) {
+		if (!(pte_access & ACC_EXEC_MASK))
+			spte |= shadow_nx_mask;
+		if (pte_access & ACC_USER_MASK)
+			spte |= shadow_user_mask;
+	} else {
+		if (pte_access & ACC_EXEC_MASK)
+			spte |= shadow_xs_mask;
+		if (pte_access & ACC_USER_EXEC_MASK)
+			spte |= shadow_xu_mask;
+	}
 
 	if (level > PG_LEVEL_4K)
 		spte |= PT_PAGE_SIZE_MASK;
@@ -318,11 +327,13 @@ static u64 make_spte_executable(u64 spte, u8 access)
 {
 	u64 set, clear;
 
-	if (access & ACC_EXEC_MASK)
-		set = shadow_x_mask;
+	if (shadow_nx_mask)
+		set = (access & ACC_EXEC_MASK) ? 0 : shadow_nx_mask;
 	else
-		set = shadow_nx_mask;
-	clear = set ^ (shadow_nx_mask | shadow_x_mask);
+		set =
+			(access & ACC_EXEC_MASK ? shadow_xs_mask : 0) |
+			(access & ACC_USER_EXEC_MASK ? shadow_xu_mask : 0);
+	clear = set ^ (shadow_nx_mask | shadow_xs_mask | shadow_xu_mask);
 	return modify_spte_protections(spte, set, clear);
 }
 
@@ -389,7 +400,7 @@ u64 make_nonleaf_spte(u64 *child_pt, bool ad_disabled)
 
 	spte |= __pa(child_pt) | shadow_present_mask | PT_WRITABLE_MASK |
 		PT_PRESENT_MASK /* or VMX_EPT_READABLE_MASK */ |
-		shadow_user_mask | shadow_x_mask | shadow_me_value;
+		shadow_user_mask | shadow_xs_mask | shadow_xu_mask | shadow_me_value;
 
 	if (ad_disabled)
 		spte |= SPTE_TDP_AD_DISABLED;
@@ -497,10 +508,11 @@ void kvm_mmu_set_ept_masks(bool has_ad_bits)
 	shadow_accessed_mask	= VMX_EPT_ACCESS_BIT;
 	shadow_dirty_mask	= VMX_EPT_DIRTY_BIT;
 	shadow_nx_mask		= 0ull;
-	shadow_x_mask		= VMX_EPT_EXECUTABLE_MASK;
+	shadow_xs_mask		= VMX_EPT_EXECUTABLE_MASK;
+	shadow_xu_mask		= VMX_EPT_EXECUTABLE_MASK;
 	shadow_present_mask	= VMX_EPT_SUPPRESS_VE_BIT;
 
-	shadow_acc_track_mask	= VMX_EPT_RWX_MASK;
+	shadow_acc_track_mask	= VMX_EPT_RWX_MASK | VMX_EPT_USER_EXECUTABLE_MASK;
 	shadow_host_writable_mask = EPT_SPTE_HOST_WRITABLE;
 	shadow_mmu_writable_mask  = EPT_SPTE_MMU_WRITABLE;
 
@@ -548,7 +560,8 @@ void kvm_mmu_reset_all_pte_masks(void)
 	shadow_accessed_mask	= PT_ACCESSED_MASK;
 	shadow_dirty_mask	= PT_DIRTY_MASK;
 	shadow_nx_mask		= PT64_NX_MASK;
-	shadow_x_mask		= 0;
+	shadow_xs_mask		= 0;
+	shadow_xu_mask		= 0;
 	shadow_present_mask	= PT_PRESENT_MASK;
 
 	shadow_acc_track_mask	= 0;
diff --git a/arch/x86/kvm/mmu/spte.h b/arch/x86/kvm/mmu/spte.h
index 121bfb2217e8..204f16aaf4e5 100644
--- a/arch/x86/kvm/mmu/spte.h
+++ b/arch/x86/kvm/mmu/spte.h
@@ -54,7 +54,8 @@ static_assert(SPTE_TDP_AD_ENABLED == 0);
 
 #define ACC_READ_MASK    PT_PRESENT_MASK
 #define ACC_WRITE_MASK   PT_WRITABLE_MASK
-#define ACC_USER_MASK    PT_USER_MASK
+#define ACC_USER_MASK    PT_USER_MASK   /* non EPT */
+#define ACC_USER_EXEC_MASK ACC_USER_MASK /* EPT only */
 #define ACC_EXEC_MASK    8
 #define ACC_ALL          (ACC_EXEC_MASK | ACC_WRITE_MASK | ACC_USER_MASK | ACC_READ_MASK)
 
@@ -184,8 +185,9 @@ extern bool __read_mostly kvm_ad_enabled;
 extern u64 __read_mostly shadow_host_writable_mask;
 extern u64 __read_mostly shadow_mmu_writable_mask;
 extern u64 __read_mostly shadow_nx_mask;
-extern u64 __read_mostly shadow_x_mask; /* mutual exclusive with nx_mask */
 extern u64 __read_mostly shadow_user_mask;
+extern u64 __read_mostly shadow_xs_mask; /* mutual exclusive with nx_mask and user_mask */
+extern u64 __read_mostly shadow_xu_mask; /* mutual exclusive with nx_mask and user_mask */
 extern u64 __read_mostly shadow_accessed_mask;
 extern u64 __read_mostly shadow_dirty_mask;
 extern u64 __read_mostly shadow_mmio_value;
@@ -363,7 +365,7 @@ static inline bool is_last_spte(u64 pte, int level)
 
 static inline bool is_executable_pte(u64 spte)
 {
-	return (spte & (shadow_x_mask | shadow_nx_mask)) == shadow_x_mask;
+	return (spte & (shadow_xs_mask | shadow_xu_mask | shadow_nx_mask)) != shadow_nx_mask;
 }
 
 static inline kvm_pfn_t spte_to_pfn(u64 pte)
-- 
2.53.0

