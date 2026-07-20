Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com [209.85.210.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 464C7271443
	for <kvm@vger.kernel.org>; Mon, 20 Jul 2026 21:00:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784581229; cv=none; b=eTXneIulBQiLwuJz0qRAqLr7dZ+YB6U9kNnNueU0/GCxp6s4EMvgNBT7dsynVoKWo2xyo8nbTEVU98hm7oAOamKd9Ld5uTGMqhUgRu5fQwsIW5xHdGy5tsxMlMljw7a72irezR7kfDmaDGnd5Q9XaAZg2X5Pl2C163c6KLrDWYI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784581229; c=relaxed/simple;
	bh=2Vq+ro6B0PPniq0ikURpC0bcNnStBIP9sneWesKnoXk=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=t3HzUvEgMsXILAHlZp7fPYje8zY5xDT5WwbugsUIxBxMal6oIIm/g+Khnxm1DtGhqlNJ3cIz+ldPkoAbxS3lcnQmVXsBaYQYr51gHPOqBuwATg14Y48pe0Y1yvABUIvOGunnSYL84CrDksoNCK5l+jhddGAqrxJTJyynp0gBCMY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jmattson.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=sP3V2mEd; arc=none smtp.client-ip=209.85.210.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jmattson.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="sP3V2mEd"
Received: by mail-pf1-f197.google.com with SMTP id d2e1a72fcca58-848551b54f5so19866980b3a.0
        for <kvm@vger.kernel.org>; Mon, 20 Jul 2026 14:00:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1784581227; x=1785186027; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:mime-version:date:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=+d1HUOdnB1UvHL+YsqIk9JpxuCEjPul+yJD8ri0HGRc=;
        b=sP3V2mEdTr/pIGFZimopvxSqACrkeswS4Z6NzvA+m7wN9lCEx6I9H2phpZQvVVn+Ia
         jf1eZI9gNqkxLrKXDUumsQu+Eg/1jRBRqTk0FITMYgHRaEN8M4nGq7ZKvSGUn3Nshw2K
         Jxv1txvJlcrUd4uetGpnzdWJCeMwt22XATtXwr9A1xia0IK2gogFv99mNprVuvLTdRZR
         FeW8Z/b+79T/803ot8xcywv/+ARkWg0a81ZG+rvn4vHn4OBvL5tLdFk+w6hovyZOOCHl
         z5r+wmudl/q8gS0wl32vBg6QvNrVgg80Tg86qU7YzMbbfkhJMSzi9J76ZYfk4JoMvRAt
         yuBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784581227; x=1785186027;
        h=content-type:cc:to:from:subject:message-id:mime-version:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=+d1HUOdnB1UvHL+YsqIk9JpxuCEjPul+yJD8ri0HGRc=;
        b=FrcqgPGS/qOLK/ZAZCBn4C1oOm4ERhr6Fr2cCZ8DHJQgSIG1KC1txKEPK/NT8IvFSp
         lKloGivH9k8IhW9WT6QOkl6p8e9PP6qjYL7DH3VofPl3M32nF5CprI+OAcKeQ/V/jYCh
         D8431bgC4I7vYvhHtfg0pumuyD8ylh/usOnZHOyxI82WQs6/LkXBV2s2zJ4OqSicDMBr
         oppibE9S21tXL57GxR4azFvc3+d6RingXn5tFtA2VDcLAEkPo+AbwrL3HBJZjGb2vlBP
         Z1dD+Ovtb4V7rzsLmWtUP50TsCefaHDOm4E+B2rQCohVNieW4GdzEMRwTl3jSWn5TBla
         cCKg==
X-Forwarded-Encrypted: i=1; AHgh+RriuBs7dgsdYIqEUqGKJzb1wru+3bC6YySoxT64A06leesumsWkWtHLdcssYiio77gtZx0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxaA0VBfOChhotmSMw6Ar+MgBMdF0ftcaPzLyYUX1ArYZ5h+LUm
	Nrp0/2ncsIhjMJOcot/vYmtDOTLL/8hEMmmAZUn2OQUHI7zHDsuVr+lrOIju7hsXntbsJI6KFPR
	TPTeRxOBTOidlzg==
X-Received: from pfbbn19.prod.google.com ([2002:a05:6a00:3253:b0:847:9cc9:a40d])
 (user=jmattson job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a00:1945:b0:845:e8b9:347 with SMTP id d2e1a72fcca58-84c2926be85mr15734291b3a.13.1784581227190;
 Mon, 20 Jul 2026 14:00:27 -0700 (PDT)
Date: Mon, 20 Jul 2026 13:52:30 -0700
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.55.0.229.g6434b31f56-goog
Message-ID: <20260720205230.1457146-1-jmattson@google.com>
Subject: [PATCH] KVM: VMX: Cap VMX preemption timer to work around Intel errata
From: Jim Mattson <jmattson@google.com>
To: seanjc@google.com, pbonzini@redhat.com
Cc: chao.gao@intel.com, kvm@vger.kernel.org, Jim Mattson <jmattson@google.com>
Content-Type: text/plain; charset="UTF-8"

Due to a widespread Intel erratum (e.g. EMR158), programming the
VMX-preemption timer with certain large values may cause the timer to
expire earlier than expected.  The recommended workaround is to cap the
VMX-preemption timer value to strictly less than 2^25 * CPUID.15H:EBX[31:0]
/ CPUID.15H:EAX[31:0].

Calculate preemption_timer_limit during hardware setup based on CPUID 15H
when available, and return -ERANGE in vmx_set_hv_timer() if the shifted
delta_tsc reaches or exceeds preemption_timer_limit.

Reported-by: Sean Christopherson <seanjc@google.com>
Closes: https://lore.kernel.org/all/Zn9X0yFxZi_Mrlnt@google.com/
Suggested-by: Chao Gao <chao.gao@intel.com>
Assisted-by: Gemini:Gemini-Next
Signed-off-by: Jim Mattson <jmattson@google.com>
---
 arch/x86/kvm/vmx/vmx.c | 29 ++++++++++++++++++++++++++---
 1 file changed, 26 insertions(+), 3 deletions(-)

diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
index cc75feec05da..1e958c1032ce 100644
--- a/arch/x86/kvm/vmx/vmx.c
+++ b/arch/x86/kvm/vmx/vmx.c
@@ -151,6 +151,7 @@ module_param(dump_invalid_vmcs, bool, 0644);
 /* Guest_tsc -> host_tsc conversion requires 64-bit division.  */
 static int __read_mostly cpu_preemption_timer_multi;
 static bool __read_mostly enable_preemption_timer = 1;
+static u64 __read_mostly preemption_timer_limit = 1ULL << 32;
 #ifdef CONFIG_X86_64
 module_param_named(preemption_timer, enable_preemption_timer, bool, S_IRUGO);
 #endif
@@ -8338,12 +8339,12 @@ int vmx_set_hv_timer(struct kvm_vcpu *vcpu, u64 guest_deadline_tsc,
 		return -ERANGE;
 
 	/*
-	 * If the delta tsc can't fit in the 32 bit after the multi shift,
-	 * we can't use the preemption timer.
+	 * If the delta tsc exceeds the preemption timer limit after the
+	 * multi shift, we can't use the preemption timer.
 	 * It's possible that it fits on later vmentries, but checking
 	 * on every vmentry is costly so we just use an hrtimer.
 	 */
-	if (delta_tsc >> (cpu_preemption_timer_multi + 32))
+	if ((delta_tsc >> cpu_preemption_timer_multi) >= preemption_timer_limit)
 		return -ERANGE;
 
 	vmx->hv_deadline_tsc = tscl + delta_tsc;
@@ -8585,6 +8586,26 @@ static void __init vmx_setup_me_spte_mask(void)
 	kvm_mmu_set_me_spte_mask(0, me_mask);
 }
 
+/*
+ * Workaround for a widespread Intel erratum (e.g. EMR158) where the
+ * VMX-preemption timer may expire earlier than expected when programmed
+ * with large values. The workaround is to cap the timer value to strictly
+ * less than 2^25 * CPUID.15H:EBX / CPUID.15H:EAX.
+ */
+static __init u64 calc_preemption_timer_limit(void)
+{
+	u32 eax, ebx, ecx, edx;
+
+	if (cpuid_eax(0) < 0x15)
+		return 1ULL << 32;
+
+	cpuid(0x15, &eax, &ebx, &ecx, &edx);
+	if (!eax || !ebx)
+		return 1ULL << 32;
+
+	return min_t(u64, 1ULL << 32, ((u64)ebx << 25) / eax);
+}
+
 __init int vmx_hardware_setup(void)
 {
 	unsigned long host_bndcfgs;
@@ -8726,6 +8747,8 @@ __init int vmx_hardware_setup(void)
 		cpu_preemption_timer_multi =
 			vmx_misc_preemption_timer_rate(vmcs_config.misc);
 
+		preemption_timer_limit = calc_preemption_timer_limit();
+
 		if (tsc_khz)
 			use_timer_freq = (u64)tsc_khz * 1000;
 		use_timer_freq >>= cpu_preemption_timer_multi;
-- 
2.55.0.229.g6434b31f56-goog

