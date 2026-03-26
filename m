Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81FB33A5445
	for <kvm@vger.kernel.org>; Thu, 26 Mar 2026 18:17:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774549063; cv=none; b=IAXZcwWLeGSJ1Sv2+uDIL1jP1LO8R6UmkyHWL5sdvVsB4ihHXU4l5JqOJbNUYdpN783KPPfI8rN2ExE1EDRnyeSTQWD1RIBtPrgKqDgmP78rujrvelDg/cG5mxcQDXZ6QSvDj3iwfDqS38OhJu5i+CUhUk3qnLI0ARMEihhovjI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774549063; c=relaxed/simple;
	bh=EHbcGD+CliNxFdwTD/e44sSeACaNU52lZoDEYih1YMU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=G4z9UatBXtEg5wFXCRdJXtUAG215XNKy4thJV9ylECYg6MG7brRTKOQBEE/n/Py5jxWV59M5BgkZw8a1OiL+SyN38CtgvVp47HBcV3BLQ8K6ulU36xWdUQmVkOrG9DZsDftxlEAHplN8OVyLVtWseCwm+jLZSxoqhW5fzGk8cVc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=U7/wUag7; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=O9fl+JBc; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="U7/wUag7";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="O9fl+JBc"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1774549059;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=K+PRAD6ImQakVlkZ0yBf7cjYkcmyWuSTP98TeOw2OH0=;
	b=U7/wUag7q29fDbAuk5vW4arYZw0yL5dJ1Y8S0m6C2g9Qf7RNQcTY7Rm8LguLvoZONEirEv
	CCpR2jnL3dYl88tYwcL0ipyQhKVic7BdP8v6wRQFAbQSlIib2/5KbIApgm+bFpcnxBp6qB
	GrZolVAtQ7LP6hap/IyvJVExkhIL2FQ=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-664-1aEDUzzmOvCL7Fbx9Yt7ew-1; Thu, 26 Mar 2026 14:17:37 -0400
X-MC-Unique: 1aEDUzzmOvCL7Fbx9Yt7ew-1
X-Mimecast-MFC-AGG-ID: 1aEDUzzmOvCL7Fbx9Yt7ew_1774549057
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-486fe36cf73so12854255e9.1
        for <kvm@vger.kernel.org>; Thu, 26 Mar 2026 11:17:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1774549057; x=1775153857; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=K+PRAD6ImQakVlkZ0yBf7cjYkcmyWuSTP98TeOw2OH0=;
        b=O9fl+JBc8qaGRVAb/5g0o2E/lEeNCJOVXQS9nDxaKPuTiDL5+lKLOcd7DYH6MroT/9
         obiZg+jpq0a1HzGzw8ffu9pP5FuCBUh/XQWhQC1RC1UceABRZFhwLc/n+RqRXee2ckzA
         bF4yUK+2TAMzyj8MQeaWXxnk61e9XSdBSHbgV6oP8vWrClgvYg0+HNNQPANzB0ChDMDt
         ZPVvIc46C/Kav/T8o2eNGKW5QiZiiwyMPEfCZIBOxLQiSA7gQoPJSbSOlWkTdZ8YBDgH
         eLJEjDguxD4qacYcT+xPfSJXjnuTXBsP6GTN1HR8CAXOh30MGNAtPLKcM+vDSzQOB9Wg
         b7SQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774549057; x=1775153857;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=K+PRAD6ImQakVlkZ0yBf7cjYkcmyWuSTP98TeOw2OH0=;
        b=OaXHGFTgu8iB+pGNyUUBffTehFMzSRTxKtw4AmBGKk/AL3w0FNG5lQTCyTHhR9yQV7
         8tcJA1iM6rcaVTu1xIvVIPYRkFA7SF/ZOC5Tm/FimfHpbn9xL0QAkjW86rMqWzMhrZ+N
         pZu1EbZtPh6Luk63u5YNw6qKVr6wXzoie4f7QmdlXpe3pqJ0WkqjZbKD8OR9GeUF8Q7o
         fHkxWCpFax/0T+VzY6xuOLlrXZzbM49ftXH+j8T2g1GIE0UjOQFfFrb/Jc/VT+RKzMr1
         8MoZGDHwkrzPQsFLVQoGhOoTiAi8WHqAToqf7zPens7zdOba/+WTMSq46o4lXD6VYF4t
         jIIQ==
X-Forwarded-Encrypted: i=1; AJvYcCWFh68MvmiZqm2N98EIBJVXvECpqbE4y4gbREZsGd43HI1YXj1MZnmzOu4AvJJjjJedxN8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxGB/mcZanpXiByNjnnhF0LfRzhTNjUliX2JfIdIgW93h5748IZ
	Lf7nzqwWUAYr0T4UGJ+qyS2iQYDGOXAlxsfr7VkIwCOeBQbM2idIRI4le5jdyVCY6VAytVgQie9
	PQnZXwunHCgkKG5awaVZrsEw91RgcXUfP90prvg5triw2ivoF+eNp1g==
X-Gm-Gg: ATEYQzxgm4VPnSxmDLPY5a/mU5xdW7bwjU4Z0AUE4e/ubTf5q/58Snpzp43CE4PruEU
	ELXn9r7yOnHFUjI4EGAmCXOarePK/dHVZ742/Qm82X5ajv2P1JXjDws8WZdqmLcGuoQrKqd9fr8
	S24iNoxLQEOPt55HR8wqF3M64AOneM0PqqMcBVqvWAaiWo1rNjxREOhJsfLwLV91Umf1YK3Kh4M
	ezGW86r4nI96qDxwphHVE7gRw0hfnNZoQ1a6ANgLZCRpLvzBazk7F0d/kYwrhlRQToL96sS9xZC
	lr9LWWm1aY6Jrityfd17DUDaGziM6RoRqZpNU3XXNZAXONswrzkElcqzyvy2CHM2Zv4gpGaBHRR
	qIT1s+GM10iEOnajVORtN54m2zcEpKleecnZePwRguEOlwQfuQtzyajiPcStgKuk/1DdITK75eN
	qJal+6pPRdD7v8C/oPCh+3oXQ8
X-Received: by 2002:a05:600c:a15:b0:486:fc46:be9e with SMTP id 5b1f17b1804b1-4871606c911mr152137385e9.24.1774549056491;
        Thu, 26 Mar 2026 11:17:36 -0700 (PDT)
X-Received: by 2002:a05:600c:a15:b0:486:fc46:be9e with SMTP id 5b1f17b1804b1-4871606c911mr152136755e9.24.1774549056026;
        Thu, 26 Mar 2026 11:17:36 -0700 (PDT)
Received: from [192.168.10.48] ([151.49.85.67])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48722d2366dsm42436215e9.10.2026.03.26.11.17.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Mar 2026 11:17:35 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: linux-kernel@vger.kernel.org,
	kvm@vger.kernel.org
Cc: Jon Kohler <jon@nutanix.com>,
	Nikunj A Dadhania <nikunj@amd.com>,
	Amit Shah <amit.shah@amd.com>,
	Sean Christopherson <seanjc@google.com>,
	Marcelo Tosatti <mtosatti@redhat.com>
Subject: [PATCH 04/24] KVM: x86/mmu: shuffle high bits of SPTEs in preparation for MBEC
Date: Thu, 26 Mar 2026 19:17:02 +0100
Message-ID: <20260326181723.218115-5-pbonzini@redhat.com>
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

Access tracking will need to save bit 10 when MBEC is enabled.
Right now it is simply shifting the R and X bits into bits 54 and 56,
but bit 10 would not fit with the same scheme.  Reorganize the
high bits so that access tracking will use bits 52, 54 and 62.
As a side effect, the free bits are compacted slightly, with
56-59 still unused.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 arch/x86/kvm/mmu/spte.h | 20 +++++++++++++++-----
 1 file changed, 15 insertions(+), 5 deletions(-)

diff --git a/arch/x86/kvm/mmu/spte.h b/arch/x86/kvm/mmu/spte.h
index 4283cea3e66c..317b9cd1537c 100644
--- a/arch/x86/kvm/mmu/spte.h
+++ b/arch/x86/kvm/mmu/spte.h
@@ -17,10 +17,20 @@
  */
 #define SPTE_MMU_PRESENT_MASK		BIT_ULL(11)
 
+/*
+ * The ignored high bits are allocated as follows:
+ * - bits 52, 54: saved X-R bits for access tracking when EPT does not have A/D
+ * - bits 53 (EPT only): host writable
+ * - bits 55 (EPT only): MMU-writable
+ * - bits 56-59: unused
+ * - bits 60-61: type of A/D tracking
+ * - bits 62: unused
+ */
+
 /*
  * TDP SPTES (more specifically, EPT SPTEs) may not have A/D bits, and may also
  * be restricted to using write-protection (for L2 when CPU dirty logging, i.e.
- * PML, is enabled).  Use bits 52 and 53 to hold the type of A/D tracking that
+ * PML, is enabled).  Use bits 60 and 61 to hold the type of A/D tracking that
  * is must be employed for a given TDP SPTE.
  *
  * Note, the "enabled" mask must be '0', as bits 62:52 are _reserved_ for PAE
@@ -29,7 +39,7 @@
  * TDP with CPU dirty logging (PML).  If NPT ever gains PML-like support, it
  * must be restricted to 64-bit KVM.
  */
-#define SPTE_TDP_AD_SHIFT		52
+#define SPTE_TDP_AD_SHIFT		60
 #define SPTE_TDP_AD_MASK		(3ULL << SPTE_TDP_AD_SHIFT)
 #define SPTE_TDP_AD_ENABLED		(0ULL << SPTE_TDP_AD_SHIFT)
 #define SPTE_TDP_AD_DISABLED		(1ULL << SPTE_TDP_AD_SHIFT)
@@ -65,7 +75,7 @@ static_assert(SPTE_TDP_AD_ENABLED == 0);
  */
 #define SHADOW_ACC_TRACK_SAVED_BITS_MASK (SPTE_EPT_READABLE_MASK | \
 					  SPTE_EPT_EXECUTABLE_MASK)
-#define SHADOW_ACC_TRACK_SAVED_BITS_SHIFT 54
+#define SHADOW_ACC_TRACK_SAVED_BITS_SHIFT 52
 #define SHADOW_ACC_TRACK_SAVED_MASK	(SHADOW_ACC_TRACK_SAVED_BITS_MASK << \
 					 SHADOW_ACC_TRACK_SAVED_BITS_SHIFT)
 static_assert(!(SPTE_TDP_AD_MASK & SHADOW_ACC_TRACK_SAVED_MASK));
@@ -84,8 +94,8 @@ static_assert(!(SPTE_TDP_AD_MASK & SHADOW_ACC_TRACK_SAVED_MASK));
  * to not overlap the A/D type mask or the saved access bits of access-tracked
  * SPTEs when A/D bits are disabled.
  */
-#define EPT_SPTE_HOST_WRITABLE		BIT_ULL(57)
-#define EPT_SPTE_MMU_WRITABLE		BIT_ULL(58)
+#define EPT_SPTE_HOST_WRITABLE		BIT_ULL(53)
+#define EPT_SPTE_MMU_WRITABLE		BIT_ULL(55)
 
 static_assert(!(EPT_SPTE_HOST_WRITABLE & SPTE_TDP_AD_MASK));
 static_assert(!(EPT_SPTE_MMU_WRITABLE & SPTE_TDP_AD_MASK));
-- 
2.53.0

