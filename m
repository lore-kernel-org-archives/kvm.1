Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8737A28C009
	for <kvm@vger.kernel.org>; Sat, 21 Mar 2026 00:09:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774051789; cv=none; b=JDKyQiniuVLfnHtxgEh+e3uB4JK8/ZPEsFf8VaTLIa67oZ7al57DZ627ugGQFVn6Xtpd4fgpgOVtEYOViTdjyuVoUr6pifFOTaXtwy64jNvVodEH4poZhg5xHr2tlKsvggNT8Fqz/cLX04hQNNHELOi7N6tcVkApls2aml7oG8o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774051789; c=relaxed/simple;
	bh=z3zvzNjoHdnJl9hGaj4lEgJ4kD/PTw19cwfqw3eo3Yw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nhBPybum/8Kzs1D/MfOl8yIH315yH5UmgTyzsh6+liwmJzHzm0fjufRD2ye5ihd4N1h4TuAZ/7DzbUV2FBySA+t58h2mfpERnx0uUpSyu3aYD25zMDMO7ZjTk/LIfb1HJ1uSuGSaLQ66sE/e7Gp83aUjQJf/i5UcQRcoS6lQ2W0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=KS8gXGTi; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=PISf/7vB; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KS8gXGTi";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="PISf/7vB"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1774051784;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0x8Li3x48YFTevSqz2TQi+0tuTqD1+6xIYxZTsWPCJo=;
	b=KS8gXGTiifY4aoNlJKknLe3FeTc0MJKXaaq97exm7Jla0GWC/2E/x7u/BTwWwni56XUbLW
	cqsLivzh1CatBKjyIr8rG2K5vAfGQFFnyaiD9342dixFtrqOHGnq9M2QclGyiTrgUoSNU+
	3GDfMpV7XAqyQk+jzY8wQf5F3rQG6lA=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-125-A6q21acOOs-EEIqPNM78QQ-1; Fri, 20 Mar 2026 20:09:43 -0400
X-MC-Unique: A6q21acOOs-EEIqPNM78QQ-1
X-Mimecast-MFC-AGG-ID: A6q21acOOs-EEIqPNM78QQ_1774051782
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-439c112b1a4so592509f8f.3
        for <kvm@vger.kernel.org>; Fri, 20 Mar 2026 17:09:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1774051781; x=1774656581; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0x8Li3x48YFTevSqz2TQi+0tuTqD1+6xIYxZTsWPCJo=;
        b=PISf/7vBAZ0hB61DgnwJCPgUq+vrhK90dpaypWcSQcxYXJoRHoyUS6ONQ1MOl9/xH6
         1A+sqKAGZXQWT3J32RxIpdqCFZw7bUktnYkjpP1pvIfiFW9Q4/h9pN7oL0ykV3yWmXz8
         K/4C4+CKGONlo+7P7E0MluTp8UlRkLIYwFw0iKTd0I24+2DtYx39H57I2oC2cvp/q6gW
         MxnT4048TgDM6qFPWZ8RhH0TanT9ctJ+vNbsDkrRtYKoWCsXgCQH0mCtiaPsbz86urLo
         +Vv7aPrWRIK49ezTiAdPX7XuWyf4MHA6ch4qhInig7bdK9/AkEeZAe7T5UkJZdOoEyQv
         y96w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774051781; x=1774656581;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=0x8Li3x48YFTevSqz2TQi+0tuTqD1+6xIYxZTsWPCJo=;
        b=d93/JFuKiGFF1njdTb219kTCPrhWEROotAd4RMRQXHkikcKoSILiJQy7zkS1DI1Cmc
         TGhaGgbUpimuL2+SVnrmRArpH1UJfWNL38cHD/W5Y0rURDdqvdC1ASl9epcz0x4JmSWE
         Cbv30QyZGvzng4yRW2sUos1HYUajkFz8nHjMORZljXUKQmWCcf5MCvT7xor3974ZHnkW
         yn7M/RgX86AiCGrf94QEjFUov4t+WRZH8vkAvDs+FsvubzYP/30sDRNt5gBUTpjLj2/J
         WDylqU0b3IEvYBuXiY77PmUkelMhvaJJD8bAPAHXTIohZvQL2byvXG1cvNHi8t7raPP2
         7aOw==
X-Forwarded-Encrypted: i=1; AJvYcCWv9cQ21YQqaWQYrLZmTknEz+yKol+Am0Gi+atcMgYH5UVzyFPzhXY8vik2XuZN97lIADY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwicUHIltdM32xSZyz5nLT+kExxRIzXhVjwbe3S/eVtctq5bfu4
	t9rovjFX2xZwJQQscHucVIBKcCQnWMNeu97rrCrDvPQZPvj9tiVvH1TY2esYgA9yKK/+Sa8r+ib
	+D961B6Rxucph24DER11BlSBQQFYjl+9id7JiYn66ISpR4Cgw5x01yLN9yiZctw==
X-Gm-Gg: ATEYQzwYBr73V4NI+MKoXIIYdU5AVlJ0+u1eFHdliJSkWGzjC09FuPrh4Q9HBS0ORs+
	8I1pj4pOFnInEOaisBG0/b/eaUDCFn4sN5QkvkGvipj6gG6b0hmsfNgD7Bc29ZOoHLdhKibNcDI
	+ChD/PlyEOgEjH7+BJ6ipqy1j4EtJ4DkfeVLlEX09901wYIJjass2Zcj9UJQB8Zt6Y3oAkOJRDJ
	LjCoWTAd3Fd9p9B64PwnkqMMWyFIQL0+N34bBiSojAcwGCYbAAWmrjmU+5cHegFGrQTI3g/CSAM
	VVU4kvM5XGdpPxep9y1CicVnnAUd7Sv5d464ncEhwxZvdZN2HGFY9GCKg+efLshFGscau2uRJ+J
	EHKzf1oD7vzL2G6lFlM/jGZThbFtKWteR1ugsqGnba5gqyTELILoGRPc5XtpZJeBJURfXja0hy0
	Yf8VWAF6smiGqko3ZdpD97qh1w
X-Received: by 2002:a05:6000:2dc2:b0:43b:6352:a262 with SMTP id ffacd0b85a97d-43b64286a5amr8310930f8f.41.1774051781526;
        Fri, 20 Mar 2026 17:09:41 -0700 (PDT)
X-Received: by 2002:a05:6000:2dc2:b0:43b:6352:a262 with SMTP id ffacd0b85a97d-43b64286a5amr8310907f8f.41.1774051781069;
        Fri, 20 Mar 2026 17:09:41 -0700 (PDT)
Received: from [192.168.10.48] ([151.49.85.67])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43b644acb52sm11272304f8f.7.2026.03.20.17.09.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Mar 2026 17:09:39 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: linux-kernel@vger.kernel.org,
	kvm@vger.kernel.org
Cc: Jon Kohler <jon@nutanix.com>,
	Marcelo Tosatti <mtosatti@redhat.com>,
	Nikunj A Dadhania <nikunj@amd.com>,
	Amit Shah <amit.shah@amd.com>,
	Sean Christopherson <seanjc@google.com>,
	Kai Huang <kai.huang@intel.com>
Subject: [PATCH 03/22] KVM: x86/mmu: adjust MMIO generation bit allocation and allowed mask
Date: Sat, 21 Mar 2026 01:09:12 +0100
Message-ID: <20260321000931.1947084-4-pbonzini@redhat.com>
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

From: Jon Kohler <jon@nutanix.com>

Update SPTE_MMIO_ALLOWED_MASK to allow EPT user executable (bit 10) to
be treated like EPT RWX bit2:0, as when mode-based execute control is
enabled, bit 10 can act like a "present" bit.

No functional changes intended.

Cc: Kai Huang <kai.huang@intel.com>
Signed-off-by: Jon Kohler <jon@nutanix.com>
Message-ID: <20251223054806.1611168-4-jon@nutanix.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 arch/x86/kvm/mmu/spte.h | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/arch/x86/kvm/mmu/spte.h b/arch/x86/kvm/mmu/spte.h
index 0fc83c9064c5..b60666778f61 100644
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
-- 
2.52.0

