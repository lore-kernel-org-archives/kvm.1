Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE97E43C04B
	for <kvm@vger.kernel.org>; Fri, 29 May 2026 22:23:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780093382; cv=none; b=PvKXoyzVcPVbPdKbq/OPhWHeVd7EuKeqNFFvAX2dZQiaOXIVldcSZSnN1lW10MYV+UHEpLkaYqTGTcLywMxINnM8U4DcRJKFtAzig6qcZhaHM3xCX4qsOAzpHv6yjXx5ijZKuMG0RrxcAM8303h3UgGH6ZFC25dXJluv24Gz4Oc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780093382; c=relaxed/simple;
	bh=qffHEhD8jn09UL+S8DChESHEdACOyGeIIvRkxBpQBls=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=W9WQh6hB9rNn2wnmYnUEG+4poNJ9ME9Alr6SId9XwKTD0ZLvBCPmE6tGoNjl+ULD6borYNcW/Rp1LtiXMviin1DKQfnd+sLXAJuTbLVOS9XJUaSsosRxZCqhp1+ijdPjXe2jhzbpaEtePCDEMShvgRyXtQVBGlwBkvJfXLD8ITc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=bmpBtRgj; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="bmpBtRgj"
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-2bf1dece2ecso16221425ad.1
        for <kvm@vger.kernel.org>; Fri, 29 May 2026 15:23:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780093380; x=1780698180; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=crjIC5UMAinWx92xFzz94uywqWRodLGcvs3KzXYdEwU=;
        b=bmpBtRgjyBR868UjCZ/DbOaNz3Ql5sdY1qTFQoBtdmLH+y9gmwE9aIb1AT9DILjlbF
         7PS2695KEf/M8S1OYG6Nwkxg1kdWPXyui8yB4CFgEvGNlwPWMHJwCSAToZJln975NT2I
         DLBdt78LX/BFolAbta3/DbWCctrZT4jrSjcZ1cFU6yfjUE10bKYktuGM1fdja/FaIz2c
         6Yz+6zKwOSv2rku5L7mnny7/yN+f7+DPFsVuL/qM7v/3vTh2B6nqP2JwLDoMggPuBtMY
         qT1AQrTogY4Tri587fOpzY1qCIpt2tsOx28wzwSAUeAv1w8LHRkqfsfvuepLzSAGZnFS
         fQIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780093380; x=1780698180;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=crjIC5UMAinWx92xFzz94uywqWRodLGcvs3KzXYdEwU=;
        b=KhnxGGzDWAGye4CNe4rUU/aa5BQAJbuqGWAlulzP/vTSXzo8BbIMHKaJBrr9ujBm3e
         guJRaHWb4rjvaIFxK6i238DkVr2is+OECf5jG4/tIHSu4AYUZQH4v75ZP1lKT3A4d5aq
         mXhWP6sce7iNlmNrH+g7S8FwM43J+kOKfBb9KmkBRKDPmj4Pg+IdSnvyn+ZEKSXkk8ju
         8gHaD+ghOQCabQg70WRhR4Q9yffPLn68TbKJBjlSS0JSElViAEinerqgDZZq4LBN9Myc
         4XVBIAj3UuJ8bRu/qcMGbyak0S8Q0z1vqXaN7w69AVj9k8ZgOmwbBI/xfAGlf8ZZN3xw
         Uvng==
X-Gm-Message-State: AOJu0YxcPmnqUaIUVhhtbnZqgls9GAbe5/GjFdboYEoYF4KBky2JJB91
	tft6kWVNzdknWoXEoOKevGGwEOPV+1fcQ3Z+R4e3OXXOxMmPuUu7PxdQ1ogCxVqrXux5KcbfO3O
	LhT6sjg==
X-Received: from plmk20.prod.google.com ([2002:a17:903:1814:b0:2bd:a0e6:1a81])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:e54c:b0:2bf:30d2:e891
 with SMTP id d9443c01a7336-2bf36894119mr21171075ad.36.1780093379894; Fri, 29
 May 2026 15:22:59 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Fri, 29 May 2026 15:21:57 -0700
In-Reply-To: <20260529222223.870923-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260529222223.870923-1-seanjc@google.com>
X-Mailer: git-send-email 2.54.0.823.g6e5bcc1fc9-goog
Message-ID: <20260529222223.870923-15-seanjc@google.com>
Subject: [PATCH v3 14/40] KVM: x86: Move async #PF helpers to x86.h (as inlines)
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>, 
	Vitaly Kuznetsov <vkuznets@redhat.com>, David Woodhouse <dwmw2@infradead.org>, Paul Durrant <paul@xen.org>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Yosry Ahmed <yosry@kernel.org>, Binbin Wu <binbin.wu@linux.intel.com>, 
	David Woodhouse <dwmw@amazon.co.uk>, Kai Huang <kai.huang@intel.com>
Content-Type: text/plain; charset="UTF-8"

Move kvm_pv_async_pf_enabled() and kvm_async_pf_hash_reset() to x86.h in
anticipation of extracting the majority of register and MSR specific code
out of x86.c.

No functional change intended.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/x86.c | 19 -------------------
 arch/x86/kvm/x86.h | 19 +++++++++++++++++++
 2 files changed, 19 insertions(+), 19 deletions(-)

diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index 034428b3d8e9..cd68a5bad0c6 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -566,13 +566,6 @@ static struct kmem_cache *kvm_alloc_emulator_cache(void)
 
 static int emulator_fix_hypercall(struct x86_emulate_ctxt *ctxt);
 
-static inline void kvm_async_pf_hash_reset(struct kvm_vcpu *vcpu)
-{
-	int i;
-	for (i = 0; i < ASYNC_PF_PER_VCPU; i++)
-		vcpu->arch.apf.gfns[i] = ~0;
-}
-
 static void kvm_destroy_user_return_msrs(void)
 {
 	int cpu;
@@ -1023,18 +1016,6 @@ bool kvm_require_dr(struct kvm_vcpu *vcpu, int dr)
 }
 EXPORT_SYMBOL_FOR_KVM_INTERNAL(kvm_require_dr);
 
-static bool __kvm_pv_async_pf_enabled(u64 data)
-{
-	u64 mask = KVM_ASYNC_PF_ENABLED | KVM_ASYNC_PF_DELIVERY_AS_INT;
-
-	return (data & mask) == mask;
-}
-
-static bool kvm_pv_async_pf_enabled(struct kvm_vcpu *vcpu)
-{
-	return __kvm_pv_async_pf_enabled(vcpu->arch.apf.msr_en_val);
-}
-
 static inline u64 pdptr_rsvd_bits(struct kvm_vcpu *vcpu)
 {
 	return vcpu->arch.reserved_gpa_bits | rsvd_bits(5, 8) | rsvd_bits(1, 2);
diff --git a/arch/x86/kvm/x86.h b/arch/x86/kvm/x86.h
index 3845b10020c9..acb22167901f 100644
--- a/arch/x86/kvm/x86.h
+++ b/arch/x86/kvm/x86.h
@@ -556,6 +556,25 @@ static inline bool kvm_pat_valid(u64 data)
 	return (data | ((data & 0x0202020202020202ull) << 1)) == data;
 }
 
+static inline bool __kvm_pv_async_pf_enabled(u64 data)
+{
+	u64 mask = KVM_ASYNC_PF_ENABLED | KVM_ASYNC_PF_DELIVERY_AS_INT;
+
+	return (data & mask) == mask;
+}
+
+static inline bool kvm_pv_async_pf_enabled(struct kvm_vcpu *vcpu)
+{
+	return __kvm_pv_async_pf_enabled(vcpu->arch.apf.msr_en_val);
+}
+
+static inline void kvm_async_pf_hash_reset(struct kvm_vcpu *vcpu)
+{
+	int i;
+	for (i = 0; i < ASYNC_PF_PER_VCPU; i++)
+		vcpu->arch.apf.gfns[i] = ~0;
+}
+
 /*
  * Trigger machine check on the host. We assume all the MSRs are already set up
  * by the CPU and that we still run on the same CPU as the MCE occurred on.
-- 
2.54.0.823.g6e5bcc1fc9-goog

