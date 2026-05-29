Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 214D03FC5C3
	for <kvm@vger.kernel.org>; Fri, 29 May 2026 16:51:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780073498; cv=none; b=Q1jeYfgPpcTfD2EQTqb7whjYv4TmwnFVXE0Vx7tallI/Zwl31ppKsPUjHXE+f396CqOQJ4BKRWCEMmJotMYO/XPj/SGvZ71cGLJOi02dWLxoZ/Dy4AR8Xeqy2fIxmIsIrUUkd6JqNeg5tXWtiiQfdT8xWZEuOnPTTe2iIvr6Y4Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780073498; c=relaxed/simple;
	bh=NVsUxQn7yEnpEgTJFXM8nf5/FDwzPHZmaJDH/It9iwA=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=ikPjRdGZdT1j+ERIgsTnGx9o2yltTgQh+7/cvRiR3zuXEZuqwVL/Fw+T1BoYXd5OCYmoaqkx+xaWacO0vbzza+kQ5HjeKcj9exFFKxj6fEDMu5C4/E19OdJYYXmCoqptAQhNj+8oeWlSoLteD1Ej7WWxy6rqLJgLzJgAzR8a/u8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=IHhngFZF; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="IHhngFZF"
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-82fa2165c3eso9354403b3a.0
        for <kvm@vger.kernel.org>; Fri, 29 May 2026 09:51:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780073494; x=1780678294; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=nlnbyJQj2RcPXqGfb4WvTtzInmRvbkDj8NcLEcQU12w=;
        b=IHhngFZFEeRZdfh1lXlTH4H34+X2CA6zXtNAzqL9S+QaJ01RnmtMAetjuPPOsSxT0V
         OxQWKyk1sOTMhZrjzTE9B027iOvcg9d/n+e1G4EWUzywiwPUXJZRpiRGWQzZ4DlGLdqb
         HanI1cQn4UmHOy9SRh4vp1YNinRZ3d7+IrPlWipLZ9v53hvoKUxSQmy9qbE4BTJa2V0l
         Pqh6/F2gE8QcrLqPwPMGBPDwTB3xJSlf8lqwHHQfdm4LyViqJif8DVMMEqKA1X29Elfd
         bCy9jJiLvSiQc0Kf20C/CMdWUrF3u1hE7Pk5XXso84o5lQzw23dCWcN3ThzdI+kRZY+l
         Q7wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780073494; x=1780678294;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nlnbyJQj2RcPXqGfb4WvTtzInmRvbkDj8NcLEcQU12w=;
        b=edBRj58qP4V9ZQl1z+XphYUfdqjLrip8yyhZnLighdjoJE2By5e1o08Yvg90lMiuRX
         BjH0JBDyC7YHvU2hlb6FYyKjETyCaUTjTymfj3lGYnATtxWlRZFkTy2s1ihHgyF5ctXw
         DKBtIsumJbivbIF+pwICpVELt5KtOIfsfW6VZPK6Def/eT+EgljnhsU/tLIy5vVtCFmb
         G+8ctkybGXa7be2CPs41cUVEGfhDSWna14BgyWq/lqQOSFG8yhVy/EM+ko7xhX1qQow8
         V0dkJzPVn17EpeNW7qQvuLU4ioSoirxA1oepPeE+TOcTYXVX2YPEibs1WlPZLzc/+c+u
         7RkA==
X-Forwarded-Encrypted: i=1; AFNElJ9EMwTVeIXt8xuPjQp1+eVriVhEOq6Wz2URENK+BFQ8Bp1x14fHPntxKk211Pe1ClqccMQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzREVHBpShpC/eYniB1lLVg8atIffQHrpjGnKAarhCCcUl/egRZ
	g1w8PPQU4NrMEYLGKlszBHP0z/sdrVlfpRDeotpg/r6Attr2iOMVX6tumpMyJi1U37zNstrCHJT
	B69GuZg==
X-Received: from pfbjs9.prod.google.com ([2002:a05:6a00:9189:b0:835:62a8:bbc])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:32cb:b0:82f:38:a5b2
 with SMTP id d2e1a72fcca58-842255ce40emr302011b3a.40.1780073493982; Fri, 29
 May 2026 09:51:33 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Fri, 29 May 2026 09:51:04 -0700
In-Reply-To: <20260529165114.748639-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260529165114.748639-1-seanjc@google.com>
X-Mailer: git-send-email 2.54.0.823.g6e5bcc1fc9-goog
Message-ID: <20260529165114.748639-11-seanjc@google.com>
Subject: [PATCH v2 10/20] KVM: Move {g,p}fn <=> {g,h}pa conversion helpers to kvm_types.h
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>, 
	David Woodhouse <dwmw2@infradead.org>, Paul Durrant <paul@xen.org>, 
	Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>, 
	Boqun Feng <boqun@kernel.org>
Cc: Waiman Long <longman@redhat.com>, kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	David Woodhouse <dwmw@amazon.co.uk>, Sebastian Andrzej Siewior <bigeasy@linutronix.de>, 
	syzbot+208f7f3e5f59c11aeb90@syzkaller.appspotmail.com, 
	Carsten Stollmaier <stollmc@amazon.com>
Content-Type: text/plain; charset="UTF-8"

Move the helpers to convert between pfns and physical addresses (for host
and guest) into kvm_types.h so that they can be used throughout kvm_host.h
(and any other KVM-related header) without having to worry about ordering.

No functional change intended.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 include/linux/kvm_host.h  | 15 ---------------
 include/linux/kvm_types.h | 16 ++++++++++++++++
 2 files changed, 16 insertions(+), 15 deletions(-)

diff --git a/include/linux/kvm_host.h b/include/linux/kvm_host.h
index 0dc4eb78b6d9..ffbae1e6e84e 100644
--- a/include/linux/kvm_host.h
+++ b/include/linux/kvm_host.h
@@ -1923,21 +1923,6 @@ hva_to_gfn_memslot(unsigned long hva, struct kvm_memory_slot *slot)
 	return slot->base_gfn + gfn_offset;
 }
 
-static inline gpa_t gfn_to_gpa(gfn_t gfn)
-{
-	return (gpa_t)gfn << PAGE_SHIFT;
-}
-
-static inline gfn_t gpa_to_gfn(gpa_t gpa)
-{
-	return (gfn_t)(gpa >> PAGE_SHIFT);
-}
-
-static inline hpa_t pfn_to_hpa(kvm_pfn_t pfn)
-{
-	return (hpa_t)pfn << PAGE_SHIFT;
-}
-
 static inline bool kvm_is_gpa_in_memslot(struct kvm *kvm, gpa_t gpa)
 {
 	unsigned long hva = gfn_to_hva(kvm, gpa_to_gfn(gpa));
diff --git a/include/linux/kvm_types.h b/include/linux/kvm_types.h
index e850adc3f47e..961572e102f0 100644
--- a/include/linux/kvm_types.h
+++ b/include/linux/kvm_types.h
@@ -6,6 +6,7 @@
 #include <linux/bits.h>
 #include <linux/export.h>
 #include <linux/types.h>
+#include <vdso/page.h>
 #include <asm/kvm_types.h>
 
 #ifdef KVM_SUB_MODULES
@@ -73,6 +74,21 @@ typedef u64            hfn_t;
 
 typedef hfn_t kvm_pfn_t;
 
+static inline gpa_t gfn_to_gpa(gfn_t gfn)
+{
+	return (gpa_t)gfn << PAGE_SHIFT;
+}
+
+static inline gfn_t gpa_to_gfn(gpa_t gpa)
+{
+	return (gfn_t)(gpa >> PAGE_SHIFT);
+}
+
+static inline hpa_t pfn_to_hpa(kvm_pfn_t pfn)
+{
+	return (hpa_t)pfn << PAGE_SHIFT;
+}
+
 struct gfn_to_hva_cache {
 	u64 generation;
 	gpa_t gpa;
-- 
2.54.0.823.g6e5bcc1fc9-goog

