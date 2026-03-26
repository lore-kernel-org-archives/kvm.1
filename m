Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 570363A3800
	for <kvm@vger.kernel.org>; Thu, 26 Mar 2026 18:17:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774549060; cv=none; b=nPjw7kgKVVUTFvbg6oFp2z555Jb/7Va+UqmJiQs1L3z8NjpCNF/Wu32asDyQ5N+JZCefGeiHajXSpNmFjJe60XcfaofUN9Zer44s6yZFVEfrBItw52OQhiMB3UM+HOJc3GvddPa0sGw219bZdIdfDvR2j2D8JhLwicyfJTFzPm4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774549060; c=relaxed/simple;
	bh=7JemvNNoOufT8khf9NIwCsgFBjTJIPEeSZZYRInFR38=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hSEtSEhPmjbgvBmyz13pkPzWeQGfWGS/Tcuuw2E9MzkziEpNIAfvy/P6UcdCyR4Qg4Xg7wK56jJ+Vgvyo2+ZGQ4nSofxW3jhgk4i7kDAhK8WDb6hDO1Gw+IjFXd5vBt7y/UK6dKIjnAMiSseBWFXLO1K6+XBqPfGqgFHTXqf5Tc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=harqfMUo; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=EEtcTRgQ; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="harqfMUo";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="EEtcTRgQ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1774549057;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wIHJPa1WNIV5ql1TvVIKEU7DKhOmL9oCEIdtc3rKxnQ=;
	b=harqfMUoJ5H62n5uw0PSH/McPo1bo3+3uPS6eKIgXpNzKdhtNTcHR/CcVeDtcbeXwpJO9g
	/Iau90lWHGXgFUWiAtF9KXuSjHT2lN1+0z1pBgr1Ck+3BwMcIicxD5sajI5kBu+Gp2SvoF
	3+4DJbdjljNmcboQljPkRV/kwZrKqhA=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-602-bK0aKUdqNDqQBeAgY_9Ewg-1; Thu, 26 Mar 2026 14:17:36 -0400
X-MC-Unique: bK0aKUdqNDqQBeAgY_9Ewg-1
X-Mimecast-MFC-AGG-ID: bK0aKUdqNDqQBeAgY_9Ewg_1774549055
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-439b3011be7so760952f8f.1
        for <kvm@vger.kernel.org>; Thu, 26 Mar 2026 11:17:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1774549054; x=1775153854; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wIHJPa1WNIV5ql1TvVIKEU7DKhOmL9oCEIdtc3rKxnQ=;
        b=EEtcTRgQpDXVYuAf9xFIglvbUt+LmlAFW/UvthUkj6zZbQqiSpsCDIRx40dT5fGvT3
         kUc7/osjXa+bYuiPqeVhopqjAp1TuJOKn0sdTtsVe9umGDTMRJlTpZkB46507NcUtZEM
         SAqIlbBp70EaBVrUflkw5+F8Tn1TOISGDOEPRCCtZny9PQad8LyApqSTL5IVZxz50825
         b3uqZhBSfivOkvYqYwZ/RyJkX8lcdpJR5puv0S3so4hNFrtwzMrYAg1qlrfvc1CQCoyQ
         5yUf4tYI5CoAmwmR2UNgdq6zyGYEXnoIUi1O6NPGzClhIfI6VJW2XFu3DoELMXkpWzV2
         SPBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774549054; x=1775153854;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=wIHJPa1WNIV5ql1TvVIKEU7DKhOmL9oCEIdtc3rKxnQ=;
        b=WfauOW/BjxlKB97EkCoC6d+8wgDAQMoxC70Ro0Ajo9dFCeTGwLqHlDoM3oCY5oj74k
         DhPJoNOslFt/Xpj9wT0DkJGsHhu0OE0jGogm9zm03EfmLn/3hlF9v4N897W3m5d4Wqy6
         LDs74xVt1AcI8W2cLWTjTOn4aIHfZcPaUh+cF3YOzOX4fy2H1NrPe+i/cEXxzqF7qFl9
         Q7JhH72P9jSeJahsQdwTfZog35Fx7iKpSNkCprCio7+aEPRkfvgP8MW2aA3cAr7lRLid
         Pbaf9PEZuGJvHCiV2Ow8HfZq0t7ehXZ1V4FnNzKvRNQMaZOImmx0KDTlrHXs/V307Epg
         nd0Q==
X-Forwarded-Encrypted: i=1; AJvYcCWWGBRD6vUIvqBdf7u5QP9gDAuBfhBEIeY6UvexzjL9yp7A12mRrTYB3nT8GnHvS+WkEq4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzrwEMctNeqEioFbGsoAXhTBtmnJCwlAvzUs6mF52k970raxoBU
	TLoAPffJNZ2WUtN5V8dknWuBRhh0eicTV6TOq16xG8ycwayWzXxw5ypabIT9ekRx8gpTptEBd1x
	7xpgkjfFq5ucOHIfKAQuyPB6/FAH6C2FckMi8ZMGrnA7VCEJ3l5srwkwMbulHQA==
X-Gm-Gg: ATEYQzzZiXyXg+pw7tQCPtWcetwnCXHyY2o27oIeLBJmVqejPu223f2s0A3BYdA1UDJ
	2SXxn9FuHX9dVLbj+e35dFcpp5fiviXe4JWRI+4MfdA8mX/wWGTOLKZbSoLNHO8G0+ObJ5444Hm
	3yGWkEGOVkgPFCYtQq1meYnPVoFf/gzQnanmaID30lwrNS4SdqhRipDsA+dG6D40klwVDkJwboV
	ilVpKWaHf6b4Lp5jADbILy6/vDqksiI8ced1MuBYxWJildTbMynIjhB8UNfBnybWhe2n87LmC/n
	4msKC6UkIw/Vu+RWRT1ZQfWpRY2YpXGPmtcRRj0pFYdiKM6a6VMTmrpu3AW6NgQDnaVg1JkYXuC
	FE/uANlcAByhFjX6Lv3QdLfnGAkxaHbD20G+x9qN7PaohNOVNBY4sBOGL44F+nCP55Hp46vVfGP
	kh6AKf+0/PzjaTZgzeGPEq6L9a
X-Received: by 2002:a05:6000:220b:b0:43b:8023:8b2 with SMTP id ffacd0b85a97d-43b88a25a22mr13537231f8f.45.1774549054192;
        Thu, 26 Mar 2026 11:17:34 -0700 (PDT)
X-Received: by 2002:a05:6000:220b:b0:43b:8023:8b2 with SMTP id ffacd0b85a97d-43b88a25a22mr13537159f8f.45.1774549053644;
        Thu, 26 Mar 2026 11:17:33 -0700 (PDT)
Received: from [192.168.10.48] ([151.49.85.67])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43b91942e52sm9561389f8f.9.2026.03.26.11.17.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Mar 2026 11:17:32 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: linux-kernel@vger.kernel.org,
	kvm@vger.kernel.org
Cc: Jon Kohler <jon@nutanix.com>,
	Nikunj A Dadhania <nikunj@amd.com>,
	Amit Shah <amit.shah@amd.com>,
	Sean Christopherson <seanjc@google.com>,
	Marcelo Tosatti <mtosatti@redhat.com>,
	Kai Huang <kai.huang@intel.com>
Subject: [PATCH 03/24] KVM: x86/mmu: free up bit 10 of PTEs in preparation for MBEC
Date: Thu, 26 Mar 2026 19:17:01 +0100
Message-ID: <20260326181723.218115-4-pbonzini@redhat.com>
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
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 arch/x86/include/asm/vmx.h |  2 ++
 arch/x86/kvm/mmu/spte.h    | 20 +++++++++++---------
 2 files changed, 13 insertions(+), 9 deletions(-)

diff --git a/arch/x86/include/asm/vmx.h b/arch/x86/include/asm/vmx.h
index 7fdc6b787d70..59e3b095a315 100644
--- a/arch/x86/include/asm/vmx.h
+++ b/arch/x86/include/asm/vmx.h
@@ -549,10 +549,12 @@ enum vmcs_field {
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
2.53.0

