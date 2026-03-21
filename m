Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D92723643F
	for <kvm@vger.kernel.org>; Sat, 21 Mar 2026 00:10:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774051808; cv=none; b=La7aFJVktbJlWMulV8JVOv8g8LgsfSQUrAmPsYsN6hkfbGq91VTzb4QEfzCYn/kFw60Een3iONil21X4Kor9il4Vb/3LgJrRSHeDc6eSiDqS64fgm0rOX+ikYR++N7AM3Yvt/PzqhRWUhmXh9TNTbrcvyNxID0TMi9A7DexDPCw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774051808; c=relaxed/simple;
	bh=5iUWbtzlz2YObxdoLlpGeHo0/a6BjtfyWEcRu3CZ6MQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=W0RVIxiHn7MM3gciHx7eIj8FUwPsiLuyfw36b2/lz+M5zaG0lfAtTwFHzN0O52UwxalpriO7h9sbvhoDe2BqQgfOIT07s2P6yhBH47KLUcXdBkJ3CpkU5USQgiawo0Uu+wOXZQV9esFYDI1C6SOLXSGr6scvDx/jdU8ZbyJ6SoM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=hAyV2kcB; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=AuFbAax8; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hAyV2kcB";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="AuFbAax8"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1774051801;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=MJQ8BDq4XDZQi2opeGtHBzWX/P8/hfIOuCb1cE+lngI=;
	b=hAyV2kcBIzEU5LEq8QuyBUWrozb7QNRHGe/qfDEUPkrRwoCi12Pmr8UJntdyNjw5nEthYN
	z5D6R73UWXyJakp39CIDMN+KF0vSJqqCwLlU0mzs11xN4D7sj8ZXJAz1Id+PLOD7IoxJMq
	knj5zjKKRagypRr23QO0WDWzWXk+wrI=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-456-7tYnmqPfN8ajorM8AdY95w-1; Fri, 20 Mar 2026 20:09:59 -0400
X-MC-Unique: 7tYnmqPfN8ajorM8AdY95w-1
X-Mimecast-MFC-AGG-ID: 7tYnmqPfN8ajorM8AdY95w_1774051798
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-4853b474594so25795775e9.1
        for <kvm@vger.kernel.org>; Fri, 20 Mar 2026 17:09:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1774051798; x=1774656598; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MJQ8BDq4XDZQi2opeGtHBzWX/P8/hfIOuCb1cE+lngI=;
        b=AuFbAax8XOrHUYAxxfNVDqGz40Ma4ADH5rwlnY4P9a6T/zpMcgNYaFgkl0csltDbkl
         RV3vBa9MaXENnYxUmcIrc4bJpoySQCPLKtWFkvvnB6/XTUv6nbF5NefJ6bJit0MxKRxO
         17j6rwkMkItRDi1AbT+DlfvnIICpKLDaLMEO8lpqk8m9YtA9TOPVn40O+BGt1PCWKkuV
         aZ02QceDP6wCv+uTgGEc+l6Ij/yCBfpSJJPBisBnozBj76HSaVC1DP5q9bmS/XZIfTlk
         nhGn7ANKZaK/hPkwVN7LulpRsaAp67Zfw7e3jY1Zqoci4YJdqaSeAg4Cu6teywXtkqWQ
         vhMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774051798; x=1774656598;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=MJQ8BDq4XDZQi2opeGtHBzWX/P8/hfIOuCb1cE+lngI=;
        b=TS84m7ebgOLKflMLI3QKAHEzPQbJiKj2zFme2ljiie37e/E3gR33zMUyUnV6FtbyUa
         qRVz2FWXrdTeakUFYDRCt1sxTpGddpDjEOdo3W11T+FGOFbpyFzp2PIo4aL4v8Lp+gH4
         45yT222plbjGSk43a4UU7D734ZMJm4LUC3pI3lPlXTHjznkmoNUuVPvAkmPxnQ+YCamF
         yjWlw/O27lHfhY7bT0cABjrWT3z//rt4eIA2yJY8zQeJc+P+mlm8Y0J/++vMNAVSdal6
         scm91zckdH3UEL1DMzcyq4BNAfStvvFYnowBhZ9uUUM1+J6kcj/WDkSeS+pKxpCQ31jU
         gu7A==
X-Forwarded-Encrypted: i=1; AJvYcCWYNq159xMKZ4lpOqs26WfT7e+7qF2DY8ikhTrOOy44OdTOgQ/YoUPMhsdxa8biYPOqh6w=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx4LIktp4IMS2koTBRaNY4VFOOD0HLDfpsJBO37fps1cAh4cNoX
	E05sDG6sobTdiu00vafr88ECxxy93kOyCdcTm/pDH7nMrMtbKWVM2BfxuWETfVL0g38YtAfYlr4
	9U0hHmULfHnqN/PmmefymNS19gmZiiwa0wAHjnEsCZ7RHs9BErr8boA==
X-Gm-Gg: ATEYQzxDr+/Jb/GRqk9Ci+z7HrnnwDZ876v58XOmZdYiFxGefBkMIR29G0SniyReZob
	A6Lt5yvteaNbC2EdpfsuZqvt1DyPzcUj6+SK0pomFFQo9tA1wEXRBWSOckx0Drp+YpwuqSY92BI
	AeUuqCFXztPrWBPnmFwjLtWO/pXFJsA73JwPSvrIbFTXvHiUARbfd4xuveDcLLijorp2kmhYkGP
	1+WtvGxLif7gIpXhJop3kMMBWfbiQOkttt1OtcaFliATM7VtP95wO3rceDegdaEyFord7oVmH/A
	YFcarfNqfbA+O7nKBwifH5t8y5+M7BEPGNgwR5PrnjAECEEjJZEyAHJK0QBgwXpKjzmWHd7y1gl
	pVF7VH44Ho0MppT8ZDexX28xzIUwFuX7x3QI5ysHDD/pGmbaCMmdZNap1Medif3C95Fz9nnt4ty
	MNvqKPZPw5nE+3xhMgL80ln/NC
X-Received: by 2002:a05:600c:3286:b0:486:fdb9:c065 with SMTP id 5b1f17b1804b1-486fdb9c0f4mr66311315e9.2.1774051798308;
        Fri, 20 Mar 2026 17:09:58 -0700 (PDT)
X-Received: by 2002:a05:600c:3286:b0:486:fdb9:c065 with SMTP id 5b1f17b1804b1-486fdb9c0f4mr66311105e9.2.1774051797771;
        Fri, 20 Mar 2026 17:09:57 -0700 (PDT)
Received: from [192.168.10.48] ([151.49.85.67])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43b6470393fsm10985743f8f.17.2026.03.20.17.09.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Mar 2026 17:09:55 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: linux-kernel@vger.kernel.org,
	kvm@vger.kernel.org
Cc: Jon Kohler <jon@nutanix.com>,
	Marcelo Tosatti <mtosatti@redhat.com>,
	Nikunj A Dadhania <nikunj@amd.com>,
	Amit Shah <amit.shah@amd.com>,
	Sean Christopherson <seanjc@google.com>
Subject: [PATCH 10/22] KVM: x86/mmu: split XS/XU bits for MBEC
Date: Sat, 21 Mar 2026 01:09:19 +0100
Message-ID: <20260321000931.1947084-11-pbonzini@redhat.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260321000931.1947084-1-pbonzini@redhat.com>
References: <20260321000931.1947084-1-pbonzini@redhat.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 8bit

When EPT is in use, replace ACC_USER_MASK with ACC_USER_EXEC_MASK,
so that supervisor and user-mode execution can be controlled
independently (ACC_USER_MASK would not allow a setting similar to
XU=0 XS=1 W=1 R=1).

Replace shadow_x_mask with shadow_xs_mask/shadow_xu_mask, to allow
setting XS and XU bits separately in EPT entries.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 arch/x86/include/asm/vmx.h     |  1 +
 arch/x86/kvm/mmu/mmu.c         | 15 ++++++++---
 arch/x86/kvm/mmu/mmutrace.h    |  6 ++---
 arch/x86/kvm/mmu/paging_tmpl.h |  4 +++
 arch/x86/kvm/mmu/spte.c        | 47 ++++++++++++++++++++++------------
 arch/x86/kvm/mmu/spte.h        |  8 +++---
 6 files changed, 55 insertions(+), 26 deletions(-)

diff --git a/arch/x86/include/asm/vmx.h b/arch/x86/include/asm/vmx.h
index 4a0804cc7c82..0041f8a77447 100644
--- a/arch/x86/include/asm/vmx.h
+++ b/arch/x86/include/asm/vmx.h
@@ -538,6 +538,7 @@ enum vmcs_field {
 #define VMX_EPT_IPAT_BIT    			(1ull << 6)
 #define VMX_EPT_ACCESS_BIT			(1ull << 8)
 #define VMX_EPT_DIRTY_BIT			(1ull << 9)
+#define VMX_EPT_USER_EXECUTABLE_MASK		(1ull << 10)
 #define VMX_EPT_SUPPRESS_VE_BIT			(1ull << 63)
 #define VMX_EPT_RWX_MASK                        (VMX_EPT_READABLE_MASK |       \
 						 VMX_EPT_WRITABLE_MASK |       \
diff --git a/arch/x86/kvm/mmu/mmu.c b/arch/x86/kvm/mmu/mmu.c
index b7366e416baa..254d69c4b9f3 100644
--- a/arch/x86/kvm/mmu/mmu.c
+++ b/arch/x86/kvm/mmu/mmu.c
@@ -5371,7 +5371,7 @@ static void reset_shadow_zero_bits_mask(struct kvm_vcpu *vcpu,
 static inline bool boot_cpu_is_amd(void)
 {
 	WARN_ON_ONCE(!tdp_enabled);
-	return shadow_x_mask == 0;
+	return shadow_xs_mask == 0;
 }
 
 /*
@@ -5450,7 +5450,6 @@ static void update_permission_bitmask(struct kvm_mmu *mmu, bool ept)
 {
 	unsigned byte;
 
-	const u16 x = ACC_BITS_MASK(ACC_EXEC_MASK);
 	const u16 w = ACC_BITS_MASK(ACC_WRITE_MASK);
 	const u16 r = ACC_BITS_MASK(ACC_READ_MASK);
 
@@ -5491,8 +5490,18 @@ static void update_permission_bitmask(struct kvm_mmu *mmu, bool ept)
 		u16 smapf = 0;
 
 		if (ept) {
-			ff = (pfec & PFERR_FETCH_MASK) ? (u16)~x : 0;
+			const u16 xs = ACC_BITS_MASK(ACC_EXEC_MASK);
+			const u16 xu = ACC_BITS_MASK(ACC_USER_EXEC_MASK);
+
+			if (pfec & PFERR_FETCH_MASK) {
+				/* Ignore XU unless MBEC is enabled.  */
+				if (cr4_smep)
+					ff = pfec & PFERR_USER_MASK ? (u16)~xu : (u16)~xs;
+				else
+					ff = (u16)~xs;
+			}
 		} else {
+			const u16 x = ACC_BITS_MASK(ACC_EXEC_MASK);
 			const u16 u = ACC_BITS_MASK(ACC_USER_MASK);
 
 			/* Faults from kernel mode accesses to user pages */
diff --git a/arch/x86/kvm/mmu/mmutrace.h b/arch/x86/kvm/mmu/mmutrace.h
index 44545f6f860a..e22588d3e145 100644
--- a/arch/x86/kvm/mmu/mmutrace.h
+++ b/arch/x86/kvm/mmu/mmutrace.h
@@ -354,8 +354,8 @@ TRACE_EVENT(
 		__entry->sptep = virt_to_phys(sptep);
 		__entry->level = level;
 		__entry->r = shadow_present_mask || (__entry->spte & PT_PRESENT_MASK);
-		__entry->x = is_executable_pte(__entry->spte);
-		__entry->u = shadow_user_mask ? !!(__entry->spte & shadow_user_mask) : -1;
+		__entry->x = (__entry->spte & (shadow_xs_mask | shadow_nx_mask)) == shadow_xs_mask;
+		__entry->u = !!(__entry->spte & (shadow_xu_mask | shadow_user_mask));
 	),
 
 	TP_printk("gfn %llx spte %llx (%s%s%s%s) level %d at %llx",
@@ -363,7 +363,7 @@ TRACE_EVENT(
 		  __entry->r ? "r" : "-",
 		  __entry->spte & PT_WRITABLE_MASK ? "w" : "-",
 		  __entry->x ? "x" : "-",
-		  __entry->u == -1 ? "" : (__entry->u ? "u" : "-"),
+		  __entry->u ? "u" : "-",
 		  __entry->level, __entry->sptep
 	)
 );
diff --git a/arch/x86/kvm/mmu/paging_tmpl.h b/arch/x86/kvm/mmu/paging_tmpl.h
index bbdbf4ae2d65..c657ea90bb33 100644
--- a/arch/x86/kvm/mmu/paging_tmpl.h
+++ b/arch/x86/kvm/mmu/paging_tmpl.h
@@ -174,6 +174,10 @@ static inline unsigned FNAME(gpte_access)(u64 gpte)
 {
 	unsigned access;
 #if PTTYPE == PTTYPE_EPT
+	/*
+	 * For now nested MBEC is not supported and permission_fault() ignores
+	 * ACC_USER_EXEC_MASK.
+	 */
 	access = ((gpte & VMX_EPT_WRITABLE_MASK) ? ACC_WRITE_MASK : 0) |
 		((gpte & VMX_EPT_EXECUTABLE_MASK) ? ACC_EXEC_MASK : 0) |
 		((gpte & VMX_EPT_READABLE_MASK) ? ACC_READ_MASK : 0);
diff --git a/arch/x86/kvm/mmu/spte.c b/arch/x86/kvm/mmu/spte.c
index 0b09124b0d54..0b3e2b97afbf 100644
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
@@ -317,11 +326,13 @@ static u64 modify_spte_protections(u64 spte, u64 set, u64 clear)
 static u64 make_spte_executable(u64 spte, u8 access)
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
 
@@ -388,7 +399,7 @@ u64 make_nonleaf_spte(u64 *child_pt, bool ad_disabled)
 
 	spte |= __pa(child_pt) | shadow_present_mask | PT_WRITABLE_MASK |
 		PT_PRESENT_MASK /* or VMX_EPT_READABLE_MASK */ |
-		shadow_user_mask | shadow_x_mask | shadow_me_value;
+		shadow_user_mask | shadow_xs_mask | shadow_xu_mask | shadow_me_value;
 
 	if (ad_disabled)
 		spte |= SPTE_TDP_AD_DISABLED;
@@ -496,7 +507,8 @@ void kvm_mmu_set_ept_masks(bool has_ad_bits)
 	shadow_accessed_mask	= VMX_EPT_ACCESS_BIT;
 	shadow_dirty_mask	= VMX_EPT_DIRTY_BIT;
 	shadow_nx_mask		= 0ull;
-	shadow_x_mask		= VMX_EPT_EXECUTABLE_MASK;
+	shadow_xs_mask		= VMX_EPT_EXECUTABLE_MASK;
+	shadow_xu_mask		= VMX_EPT_EXECUTABLE_MASK;
 	shadow_present_mask	= VMX_EPT_SUPPRESS_VE_BIT;
 
 	shadow_acc_track_mask	= VMX_EPT_RWX_MASK;
@@ -547,7 +559,8 @@ void kvm_mmu_reset_all_pte_masks(void)
 	shadow_accessed_mask	= PT_ACCESSED_MASK;
 	shadow_dirty_mask	= PT_DIRTY_MASK;
 	shadow_nx_mask		= PT64_NX_MASK;
-	shadow_x_mask		= 0;
+	shadow_xs_mask		= 0;
+	shadow_xu_mask		= 0;
 	shadow_present_mask	= PT_PRESENT_MASK;
 
 	shadow_acc_track_mask	= 0;
diff --git a/arch/x86/kvm/mmu/spte.h b/arch/x86/kvm/mmu/spte.h
index 0c305f2f4ba0..7323ff19056b 100644
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
@@ -352,7 +354,7 @@ static inline bool is_last_spte(u64 pte, int level)
 
 static inline bool is_executable_pte(u64 spte)
 {
-	return (spte & (shadow_x_mask | shadow_nx_mask)) == shadow_x_mask;
+	return (spte & (shadow_xs_mask | shadow_xu_mask | shadow_nx_mask)) != shadow_nx_mask;
 }
 
 static inline kvm_pfn_t spte_to_pfn(u64 pte)
-- 
2.52.0

