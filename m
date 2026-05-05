Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92EA63CC9F6
	for <kvm@vger.kernel.org>; Tue,  5 May 2026 19:52:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778010762; cv=none; b=e0dpDbTaWiaRzX83L499rH+nbws+rMCRyUW57srCAwv0A5sp1WcKF0T2wRunNGfBpALYeiY19WltRWYFd7M+XmzN+/Myd2kVqxreqLT6d4gWUFkixDqm97zEPt5t7xcYFkd15w+VIVxiZr5KS/ps5FpieBLh+y8qATesJ7zMp1o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778010762; c=relaxed/simple;
	bh=UeCcQiAJNASRWapDvBTvXFFa5EobN7uyDQqfy2BiEAo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eJF2OfRveuFJSzYI9ufQSAXBkmp/lOxs+ycBYhTMJf5CDs+91FKnsHZJxXNos8whTDGDvqzStLhGJYu2KZcr995xu/8O50TpuxIBzpWJPZ+0S66M0uWtTFwfMnNEfdXroVsDHBhWTnRinm0EBYhhG/7g1iAX/KOwMa0NunKBzYY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=btdkZWTS; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=uL7BDN58; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="btdkZWTS";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="uL7BDN58"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1778010759;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=V1nV1dP/HomEyaZPGYBVjDHBdSv77gl5a3DkMHCHB+0=;
	b=btdkZWTSj0NEXXpRWyZuKt6uyVj8QVdut08dB1BEyzSO8PBSigJpJQ95tqQqpe0us3/gD4
	ARxlb4ODDvqnvV+KYeIdGItSNmCngsGIGGGUp/eZCSCzI6lgx+furwLvv7TMN26X31krnZ
	6f8IU3o2+wO/mAe2pdd5jSCNrRPuiTc=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-29-zUOsaOAcOTOmVsDorikzSg-1; Tue, 05 May 2026 15:52:38 -0400
X-MC-Unique: zUOsaOAcOTOmVsDorikzSg-1
X-Mimecast-MFC-AGG-ID: zUOsaOAcOTOmVsDorikzSg_1778010757
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-44cc3c9b2feso2680491f8f.1
        for <kvm@vger.kernel.org>; Tue, 05 May 2026 12:52:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1778010757; x=1778615557; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=V1nV1dP/HomEyaZPGYBVjDHBdSv77gl5a3DkMHCHB+0=;
        b=uL7BDN58bXkBV+R2zJA5nXyX7lL/4Yao1c8rl0Zo0AzZF5EoPkZNzw3HOpbRi1ux1F
         q+CnkDp2aniyA8HPNsCj9OEvHZlVbQYudnPh9g3YD1nj1Rtfd8RMo9ZCFVDS5TkyUXyx
         Piv2sz4MsnnFQGKPDSbwh1j3npkMOmu7atekzRT1AMMgf8ygxu5Zp/VUePqw3xAppb5b
         2+WQPLZ6+L0cA5Tk6gOcEx9a2tYc3YhA8RFikHCUCg15i+WajI/hFS9HdV9jMvE3PeDo
         jkOX1ouT9OXU6pw89GiLnt9Ee9Ne+pcyM1jTcAqnN+zaM3BXuW9rY+lkBHqqYFDGFpjS
         TRcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778010757; x=1778615557;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=V1nV1dP/HomEyaZPGYBVjDHBdSv77gl5a3DkMHCHB+0=;
        b=tJpndlvEEZRrsyMXhd2hCRrrWaey4eD+nunPQ4a5GnCg06qk81r13/xdAtCJESVLZo
         Uf4HPcjGla4/gyLA8P04kiihJoyp/CCLci8/bJWeFOfa/2LaHMJ9HETVddY6OlyImJr6
         VyTz7qd2noH0D0Go9gEHArPchiglUwpNr+BxR0XbvK0YCRN9QKaN5eYFmn5T6/4DvZdM
         bYzgR92XWdNM3GXjI0yFzsed2G8oJoKK5RJvqrTWeMKyEnOiKcSKo8i0960gmcObZmuc
         SmJsptp563Y/zrsFFepDH+YDxSNLkMn1Tbq8C9ATEHslqonyfZE9qwIv9Tfso+l0bfjG
         MV5g==
X-Forwarded-Encrypted: i=1; AFNElJ/bYJr2moyZDivgs9F8X537H2t1ya/o1zElsy7mpNwyQnzvK8ToX/A8PuSMUVrD5Hzt6RM=@vger.kernel.org
X-Gm-Message-State: AOJu0YyAZMh/wUjUSpL+98hMRqHuoI0usjW4aNvrleyOdwQbh0vJxRhV
	vdmDOxnMbEy5GAIWfVV2wB6de+30p0DimDjUsvjz5sgWxJCwlshzWVLYkicY4P1cFJ1jtbW5cl/
	NVMF9agk+2WGyTn5U/BxTcYBIDqAIkdx17r0Z9HkkY9+tmEZMP8/3xDVRkY0w2g==
X-Gm-Gg: AeBDieu+VpQFeiejK+cyXUdfDHosaWJdd3ER5I3kdRQRSWGzcuLEtJIDp/Y7s2hWhni
	UH0CdhSTI/ErYUUvpCGR4lgxKJpNd3nkZDVp2upyTLPtsCLzKGvWYpYj9XDbOwkHZ9VgQ961ZJl
	9Ty84sXe75HoYe2Zwnfjwv5x+vAoZT4l/FIDda5u43C1d0jV4lL16VGhnPmyDRFNAOWB/Mqr8Er
	gnCoQlmzk3+k9mvcPYZuddtnZCyZ3mYzuWZQ1cQhAGIQA/IP4v0HwsNAALKNBLCCqkwpku5GI6b
	qqAa1l9Vwj+d45zu5VjFyvj059KgRB55pOysOXQMQ60vyKA520j9roz4DODoxmZ3XCFWi0j9AKW
	07sXhHkBLOpzpi7qmnPKn+HOkDR/f9rTzx8g7LQWEa+9UTMJ6qIYZdjPns6+HtTzAAbtgR3Bz3u
	9rWsSiPovh5SLuZ2osC/LJs/wHhyT45/Tp1toGqVk=
X-Received: by 2002:a05:600c:811a:b0:489:1c32:210d with SMTP id 5b1f17b1804b1-48e51f369c3mr11679085e9.15.1778010756848;
        Tue, 05 May 2026 12:52:36 -0700 (PDT)
X-Received: by 2002:a05:600c:811a:b0:489:1c32:210d with SMTP id 5b1f17b1804b1-48e51f369c3mr11678645e9.15.1778010756314;
        Tue, 05 May 2026 12:52:36 -0700 (PDT)
Received: from [192.168.10.48] ([176.206.106.181])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48e529a2170sm479095e9.31.2026.05.05.12.52.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 May 2026 12:52:34 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: linux-kernel@vger.kernel.org,
	kvm@vger.kernel.org
Cc: d.riley@proxmox.com,
	jon@nutanix.com,
	Kai Huang <kai.huang@intel.com>
Subject: [PATCH 03/28] KVM: x86/mmu: free up bit 10 of PTEs in preparation for MBEC
Date: Tue,  5 May 2026 21:52:01 +0200
Message-ID: <20260505195226.563317-4-pbonzini@redhat.com>
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

From: Jon Kohler <jon@nutanix.com>

Update SPTE_MMIO_ALLOWED_MASK to allow EPT user executable (bit 10) to
be treated like EPT RWX bit2:0, as when mode-based execute control is
enabled, bit 10 can act like a "present" bit.  Likewise do not include
it in FROZEN_SPTE.

No functional changes intended, other than the reduction of the maximum
MMIO generation that is stored in page tables.

Cc: Kai Huang <kai.huang@intel.com>
Signed-off-by: Jon Kohler <jon@nutanix.com>
Message-ID: <20251223054806.1611168-4-jon@nutanix.com>
Reviewed-by: Kai Huang <kai.huang@intel.com>
Tested-by: David Riley <d.riley@proxmox.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 arch/x86/include/asm/vmx.h |  2 ++
 arch/x86/kvm/mmu/spte.h    | 20 +++++++++++---------
 2 files changed, 13 insertions(+), 9 deletions(-)

diff --git a/arch/x86/include/asm/vmx.h b/arch/x86/include/asm/vmx.h
index b2291a766e3f..2b30b921b375 100644
--- a/arch/x86/include/asm/vmx.h
+++ b/arch/x86/include/asm/vmx.h
@@ -560,10 +560,12 @@ enum vmcs_field {
 #define VMX_EPT_ACCESS_BIT			(1ull << 8)
 #define VMX_EPT_DIRTY_BIT			(1ull << 9)
 #define VMX_EPT_SUPPRESS_VE_BIT			(1ull << 63)
+
 #define VMX_EPT_RWX_MASK                        (VMX_EPT_READABLE_MASK |       \
 						 VMX_EPT_WRITABLE_MASK |       \
 						 VMX_EPT_EXECUTABLE_MASK)
 #define VMX_EPT_MT_MASK				(7ull << VMX_EPT_MT_EPTE_SHIFT)
+#define VMX_EPT_USER_EXECUTABLE_MASK		(1ull << 10)
 
 static inline u8 vmx_eptp_page_walk_level(u64 eptp)
 {
diff --git a/arch/x86/kvm/mmu/spte.h b/arch/x86/kvm/mmu/spte.h
index 28086fa86fe0..4283cea3e66c 100644
--- a/arch/x86/kvm/mmu/spte.h
+++ b/arch/x86/kvm/mmu/spte.h
@@ -96,11 +96,11 @@ static_assert(!(EPT_SPTE_MMU_WRITABLE & SHADOW_ACC_TRACK_SAVED_MASK));
 #undef SHADOW_ACC_TRACK_SAVED_MASK
 
 /*
- * Due to limited space in PTEs, the MMIO generation is a 19 bit subset of
+ * Due to limited space in PTEs, the MMIO generation is an 18 bit subset of
  * the memslots generation and is derived as follows:
  *
- * Bits 0-7 of the MMIO generation are propagated to spte bits 3-10
- * Bits 8-18 of the MMIO generation are propagated to spte bits 52-62
+ * Bits 0-6 of the MMIO generation are propagated to spte bits 3-9
+ * Bits 7-17 of the MMIO generation are propagated to spte bits 52-62
  *
  * The KVM_MEMSLOT_GEN_UPDATE_IN_PROGRESS flag is intentionally not included in
  * the MMIO generation number, as doing so would require stealing a bit from
@@ -111,7 +111,7 @@ static_assert(!(EPT_SPTE_MMU_WRITABLE & SHADOW_ACC_TRACK_SAVED_MASK));
  */
 
 #define MMIO_SPTE_GEN_LOW_START		3
-#define MMIO_SPTE_GEN_LOW_END		10
+#define MMIO_SPTE_GEN_LOW_END		9
 
 #define MMIO_SPTE_GEN_HIGH_START	52
 #define MMIO_SPTE_GEN_HIGH_END		62
@@ -133,7 +133,8 @@ static_assert(!(SPTE_MMU_PRESENT_MASK &
  * and so they're off-limits for generation; additional checks ensure the mask
  * doesn't overlap legal PA bits), and bit 63 (carved out for future usage).
  */
-#define SPTE_MMIO_ALLOWED_MASK (BIT_ULL(63) | GENMASK_ULL(51, 12) | GENMASK_ULL(2, 0))
+#define SPTE_MMIO_ALLOWED_MASK (BIT_ULL(63) | GENMASK_ULL(51, 12) | \
+				BIT_ULL(10) | GENMASK_ULL(2, 0))
 static_assert(!(SPTE_MMIO_ALLOWED_MASK &
 		(SPTE_MMU_PRESENT_MASK | MMIO_SPTE_GEN_LOW_MASK | MMIO_SPTE_GEN_HIGH_MASK)));
 
@@ -141,7 +142,7 @@ static_assert(!(SPTE_MMIO_ALLOWED_MASK &
 #define MMIO_SPTE_GEN_HIGH_BITS		(MMIO_SPTE_GEN_HIGH_END - MMIO_SPTE_GEN_HIGH_START + 1)
 
 /* remember to adjust the comment above as well if you change these */
-static_assert(MMIO_SPTE_GEN_LOW_BITS == 8 && MMIO_SPTE_GEN_HIGH_BITS == 11);
+static_assert(MMIO_SPTE_GEN_LOW_BITS == 7 && MMIO_SPTE_GEN_HIGH_BITS == 11);
 
 #define MMIO_SPTE_GEN_LOW_SHIFT		(MMIO_SPTE_GEN_LOW_START - 0)
 #define MMIO_SPTE_GEN_HIGH_SHIFT	(MMIO_SPTE_GEN_HIGH_START - MMIO_SPTE_GEN_LOW_BITS)
@@ -217,10 +218,11 @@ extern u64 __read_mostly shadow_nonpresent_or_rsvd_mask;
  *
  * Only used by the TDP MMU.
  */
-#define FROZEN_SPTE	(SHADOW_NONPRESENT_VALUE | 0x5a0ULL)
+#define FROZEN_SPTE	(SHADOW_NONPRESENT_VALUE | 0x1a0ULL)
 
-/* Frozen SPTEs must not be misconstrued as shadow present PTEs. */
-static_assert(!(FROZEN_SPTE & SPTE_MMU_PRESENT_MASK));
+/* Frozen SPTEs must not be misconstrued as shadow or MMU present PTEs. */
+static_assert(!(FROZEN_SPTE & (SPTE_MMU_PRESENT_MASK |
+			       VMX_EPT_RWX_MASK | VMX_EPT_USER_EXECUTABLE_MASK)));
 
 static inline bool is_frozen_spte(u64 spte)
 {
-- 
2.54.0

