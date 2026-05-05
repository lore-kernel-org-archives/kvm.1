Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29C483E3C62
	for <kvm@vger.kernel.org>; Tue,  5 May 2026 19:53:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778010787; cv=none; b=Tj69tu5RRdLxrAcHHlgvEzMkctQSS/ioN6Rh6mqwfYj4tZzW9TU1uFRxADMQxk2LJI2a6bPoCZVviT2cVE+rv9Spg6jWyA4QbeJ9+YAOY24R+kTseSjVnbtBh9E9wG4UBgxM41pQLlkJGq5FM21A91XYq7xjLoj0DGaeEzFigS4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778010787; c=relaxed/simple;
	bh=UISj4AsBjDScyfEz+zzOrB16K7LyM3cpBQKP4JxoC+s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tGptzXBjpa65NaNoFsZtK7HKD3DjfFCzgDozAcOP/yZRM/mGQwavMi4dBg8Rqibf4edm8Y03yUQLsskIP9DLvQlG5R6jCT/no8EtIC1UUlvHphkavaKkWTBOlVXSk0Rh+Ghy0N1V6XQgyxZKQL1xpMWDzadOQALVD3tTKdpOKQk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=gl49hqzs; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=ox/e0sMF; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gl49hqzs";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="ox/e0sMF"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1778010785;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=kvp/N7DhJzlwzkEgaDhfKLJnVV+wtnlptrY57TizXX4=;
	b=gl49hqzsXBPAcwGwW5+ApYt5KnFv8UDc8yOWZitUnJouSB4q7j+ZORSD6vt+JhA/dcqazG
	HpuoUGFLL9/bEm5t196ADeoR94i5Jb6ShxcPw/KGWTO/WSfLQnL+Da3SqPhHVXB0VMGixH
	UVhhYqScbKyJMWp/pgaaJFkibpiUoPI=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-532-vE6Dw7GPPVSqcuifiZ2Usg-1; Tue, 05 May 2026 15:53:02 -0400
X-MC-Unique: vE6Dw7GPPVSqcuifiZ2Usg-1
X-Mimecast-MFC-AGG-ID: vE6Dw7GPPVSqcuifiZ2Usg_1778010781
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-48919890a95so37177135e9.2
        for <kvm@vger.kernel.org>; Tue, 05 May 2026 12:53:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1778010781; x=1778615581; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kvp/N7DhJzlwzkEgaDhfKLJnVV+wtnlptrY57TizXX4=;
        b=ox/e0sMFVWLkcIz7h9zxNlIfEAdItPdaMFKS6/9a3qKXntfDbRVh12O+YY8x7VYuFe
         YJnIUuSnDJbURUnfM9Xvvs2HK0bVGIIgRCMbLUWOzbp3X+MWr7bcPLCOlp0psOJb8Vfw
         w80SC/79f7Y9CNDA9YqCQ9+mGvFBcPOrdhXtznU8hn1/NumJrZpRnmmTMzxnlj/Uh3Pz
         3IKvbGVQn2SJgGho6bOB/PgMwSIC6iVktOaZbqv/F2cqLWQS1jDL0pWFtXhZt64SXILy
         Hiz2KnabwXljV02kgjxCa/tHu238oll9Xa0wYcherbtV9rW36afmr3mcv+ww2s3HLBxM
         a4fQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778010781; x=1778615581;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=kvp/N7DhJzlwzkEgaDhfKLJnVV+wtnlptrY57TizXX4=;
        b=ib5wRj9UHUy/FrpskY+xnSJTcMA2QbxhEhk60+oqEQNgF3S3dBBX02RAkAvYSjhvgk
         MCd2KxydKNRwsRwJihPSWjLPDEIRXl+u0a4gSz4xFuDCusGRrSQmqI/f1rb8CQf35ikH
         D/kVQfB4nmzB0JRIjLUH358tgekRgQPMEQzi5dY9YuPW6tpgqxR/UKwlrGdGauzgr4cb
         Jbr9F0/UfbG6NfpI2suqCYMuuW5IOYM3mUI9NBMw56uQL7HN+2+F0tDpk531NUDuoget
         mll9XEczTQaNrFTxScIZwClE3o3l7t4lX+5xhCQGd5pVjFXVB0jbXrLN8yYNtKEcKE1Y
         y9rw==
X-Forwarded-Encrypted: i=1; AFNElJ9vv1ZwqUrVHGF9Mw9B1cDtC0oiFiJvWDVQhh+zLaVAzxFZk5g5lwMxlu5Lg1gwxYo9rCU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwyqX2dU9MEfMlDOMg24KcaCdmi+PM98ne4IeCWft75DNX+kQUY
	eAVxlWEF2bPjhpDtP62p54JZF+S54kFsqZFm+jLzV210BfqzngXGJ2JT2gd3g5ik8Hcky0TVvWc
	NaObuvVbkoWr+lIPYF4WVE3q9ndq9oHtFtfWLlnpke6tbNc9tHdZpfTATKTU0zg==
X-Gm-Gg: AeBDieu8rf8TnNMf3ngAGfdvWQfhdm387+aJI36JA0BzORWsZqnwHLqBT/yC9keh02H
	ci/gyeedcjYPrqEYHOmnVgUX2JVHUTuVRMXLTYWu3WkTppy31w2wPTty8M6y0qLTANxO9klyLIO
	fZ26rjiYTIJkKsso84eXAu4WB3BrmrVmF+zwwHhDTUJT+QMZahrylId4f6qQptdXmWzayJPBnvc
	xa13XOmhW5xgUgF13lomNtWpOstPe8p6QBvjkfijT5mT4NWfIQoxpojFrXeSm/rAiQVZ8+Xx+NT
	Q5+mhmtlwugIx4q67gSWPMKRRngYUnBXqISavRmd7hqE5HJ3PbZ5V4/N4ylzahQRso+e6937PVK
	QXWpEtBLId8px3RqVG0G84yfIXkY+hriZsdVlosGYBaInW1KqwJuudLFjWksH4AYrKlTPzJM6X0
	nW2TNbg0ZMERv5DCPPp8XOCH5dg7RV7LTepIyTJ2Y=
X-Received: by 2002:a05:600c:2d16:b0:48a:72ab:f88c with SMTP id 5b1f17b1804b1-48e52be1069mr568805e9.17.1778010780993;
        Tue, 05 May 2026 12:53:00 -0700 (PDT)
X-Received: by 2002:a05:600c:2d16:b0:48a:72ab:f88c with SMTP id 5b1f17b1804b1-48e52be1069mr568655e9.17.1778010780518;
        Tue, 05 May 2026 12:53:00 -0700 (PDT)
Received: from [192.168.10.48] ([176.206.106.181])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4505238e174sm6945118f8f.1.2026.05.05.12.52.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 May 2026 12:52:58 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: linux-kernel@vger.kernel.org,
	kvm@vger.kernel.org
Cc: d.riley@proxmox.com,
	jon@nutanix.com
Subject: [PATCH 13/28] KVM: x86/mmu: split XS/XU bits for EPT
Date: Tue,  5 May 2026 21:52:11 +0200
Message-ID: <20260505195226.563317-14-pbonzini@redhat.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260505195226.563317-1-pbonzini@redhat.com>
References: <20260505195226.563317-1-pbonzini@redhat.com>
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

Replace shadow_x_mask with shadow_xs_mask/shadow_xu_mask, to allow setting
XS and XU bits separately in EPT entries.

In fact, ACC_USER_EXEC_MASK is already set through ACC_ALL in the
kvm_mmu_page roles and propagates to the XU bit of sPTEs even if
MBEC is not (yet) enabled in the execution controls.  This is fine,
because the XU bit is ignored by the processor, and even once KVM
supports MBEC this mode will remain for processors that lack the
feature.

Tested-by: David Riley <d.riley@proxmox.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 arch/x86/kvm/mmu.h          |  3 +-
 arch/x86/kvm/mmu/mmu.c      |  2 +-
 arch/x86/kvm/mmu/mmutrace.h |  6 ++--
 arch/x86/kvm/mmu/spte.c     | 62 ++++++++++++++++++++++++++-----------
 arch/x86/kvm/mmu/spte.h     | 16 +++++++---
 5 files changed, 62 insertions(+), 27 deletions(-)

diff --git a/arch/x86/kvm/mmu.h b/arch/x86/kvm/mmu.h
index 63be5c5efed9..d8c13e43c2d7 100644
--- a/arch/x86/kvm/mmu.h
+++ b/arch/x86/kvm/mmu.h
@@ -39,7 +39,8 @@ extern bool __read_mostly enable_mmio_caching;
 
 #define ACC_READ_MASK    PT_PRESENT_MASK
 #define ACC_WRITE_MASK   PT_WRITABLE_MASK
-#define ACC_USER_MASK    PT_USER_MASK
+#define ACC_USER_MASK    PT_USER_MASK   /* non EPT */
+#define ACC_USER_EXEC_MASK ACC_USER_MASK /* EPT only */
 #define ACC_EXEC_MASK    8
 #define ACC_ALL          (ACC_EXEC_MASK | ACC_WRITE_MASK | ACC_USER_MASK | ACC_READ_MASK)
 
diff --git a/arch/x86/kvm/mmu/mmu.c b/arch/x86/kvm/mmu/mmu.c
index 3dbac7ad044f..16eaf413b299 100644
--- a/arch/x86/kvm/mmu/mmu.c
+++ b/arch/x86/kvm/mmu/mmu.c
@@ -5491,7 +5491,7 @@ static void reset_shadow_zero_bits_mask(struct kvm_vcpu *vcpu,
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
index 1b7fb508098b..f41573b0ccfa 100644
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
@@ -217,21 +218,26 @@ bool make_spte(struct kvm_vcpu *vcpu, struct kvm_mmu_page *sp,
 	 * would tie make_spte() further to vCPU/MMU state, and add complexity
 	 * just to optimize a mode that is anything but performance critical.
 	 */
-	if (level > PG_LEVEL_4K && (pte_access & ACC_EXEC_MASK) &&
-	    is_nx_huge_page_enabled(vcpu->kvm)) {
+	if (level > PG_LEVEL_4K && is_nx_huge_page_enabled(vcpu->kvm)) {
 		pte_access &= ~ACC_EXEC_MASK;
+		if (shadow_xu_mask)
+			pte_access &= ~ACC_USER_EXEC_MASK;
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
@@ -318,11 +324,13 @@ static u64 change_spte_executable(u64 spte, u8 access)
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
 
@@ -389,7 +397,7 @@ u64 make_nonleaf_spte(u64 *child_pt, bool ad_disabled)
 
 	spte |= __pa(child_pt) | shadow_present_mask | PT_WRITABLE_MASK |
 		PT_PRESENT_MASK /* or VMX_EPT_READABLE_MASK */ |
-		shadow_user_mask | shadow_x_mask | shadow_me_value;
+		shadow_user_mask | shadow_xs_mask | shadow_xu_mask | shadow_me_value;
 
 	if (ad_disabled)
 		spte |= SPTE_TDP_AD_DISABLED;
@@ -497,10 +505,27 @@ void kvm_mmu_set_ept_masks(bool has_ad_bits)
 	shadow_accessed_mask	= VMX_EPT_ACCESS_BIT;
 	shadow_dirty_mask	= VMX_EPT_DIRTY_BIT;
 	shadow_nx_mask		= 0ull;
-	shadow_x_mask		= VMX_EPT_EXECUTABLE_MASK;
+	shadow_xs_mask		= VMX_EPT_EXECUTABLE_MASK;
+
+	/*
+	 * The MMU always maps ACC_EXEC_MASK and ACC_USER_EXEC_MASK to the
+	 * XS and XU bits of shadow EPT entries, regardless of whether MBEC
+	 * is available on the host or enabled in the VMCS.
+	 *
+	 * For the non-nested case, pages are mapped with ACC_EXEC_MASK
+	 * and ACC_USER_EXEC_MASK set in tandem, so XS == XU and the
+	 * host's MBEC setting does not matter.  On hardware without MBEC
+	 * the XU bit is reserved-as-ignored, and setting it does no harm.
+	 *
+	 * For nested EPT MBEC is not supported, but bit 10 of the gPTE has
+	 * no effect because (a) is_present_gpte() does not treat it as a
+	 * present bit, and (b) permission_fault() uses an mmu->permissions[]
+	 * array that effectively ignores ACC_USER_EXEC_MASK.
+	 */
+	shadow_xu_mask		= VMX_EPT_USER_EXECUTABLE_MASK;
 	shadow_present_mask	= VMX_EPT_SUPPRESS_VE_BIT;
 
-	shadow_acc_track_mask	= VMX_EPT_RWX_MASK;
+	shadow_acc_track_mask	= VMX_EPT_RWX_MASK | VMX_EPT_USER_EXECUTABLE_MASK;
 	shadow_host_writable_mask = EPT_SPTE_HOST_WRITABLE;
 	shadow_mmu_writable_mask  = EPT_SPTE_MMU_WRITABLE;
 
@@ -548,7 +573,8 @@ void kvm_mmu_reset_all_pte_masks(void)
 	shadow_accessed_mask	= PT_ACCESSED_MASK;
 	shadow_dirty_mask	= PT_DIRTY_MASK;
 	shadow_nx_mask		= PT64_NX_MASK;
-	shadow_x_mask		= 0;
+	shadow_xs_mask		= 0;
+	shadow_xu_mask		= 0;
 	shadow_present_mask	= PT_PRESENT_MASK;
 
 	shadow_acc_track_mask	= 0;
diff --git a/arch/x86/kvm/mmu/spte.h b/arch/x86/kvm/mmu/spte.h
index 8a4c09c5cdbf..f5261d993eac 100644
--- a/arch/x86/kvm/mmu/spte.h
+++ b/arch/x86/kvm/mmu/spte.h
@@ -24,7 +24,7 @@
  * - bits 55 (EPT only): MMU-writable
  * - bits 56-59: unused
  * - bits 60-61: type of A/D tracking
- * - bits 62: unused
+ * - bits 62 (EPT only): saved XU bit for disabled AD
  */
 
 /*
@@ -65,7 +65,8 @@ static_assert(SPTE_TDP_AD_ENABLED == 0);
  * must not overlap the A/D type mask.
  */
 #define SHADOW_ACC_TRACK_SAVED_BITS_MASK (VMX_EPT_READABLE_MASK | \
-					  VMX_EPT_EXECUTABLE_MASK)
+					  VMX_EPT_EXECUTABLE_MASK | \
+					  VMX_EPT_USER_EXECUTABLE_MASK)
 #define SHADOW_ACC_TRACK_SAVED_BITS_SHIFT 52
 #define SHADOW_ACC_TRACK_SAVED_MASK	(SHADOW_ACC_TRACK_SAVED_BITS_MASK << \
 					 SHADOW_ACC_TRACK_SAVED_BITS_SHIFT)
@@ -178,8 +179,9 @@ extern bool __read_mostly kvm_ad_enabled;
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
@@ -357,7 +359,13 @@ static inline bool is_last_spte(u64 pte, int level)
 
 static inline bool is_executable_pte(u64 spte)
 {
-	return (spte & (shadow_x_mask | shadow_nx_mask)) == shadow_x_mask;
+	/*
+	 * For now, return true if either the XS or XU bit is set
+	 * This function is only used for fast_page_fault,
+	 * which never processes shadow EPT, and regular page
+	 * tables always have XS==XU.
+	 */
+	return (spte & (shadow_xs_mask | shadow_xu_mask | shadow_nx_mask)) != shadow_nx_mask;
 }
 
 static inline kvm_pfn_t spte_to_pfn(u64 pte)
-- 
2.54.0

