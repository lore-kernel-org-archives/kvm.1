Received: from mail-pg1-f202.google.com (mail-pg1-f202.google.com [209.85.215.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3056335AC32
	for <kvm@vger.kernel.org>; Thu, 25 Jun 2026 22:04:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782425096; cv=none; b=rQNvoCdYw9Q+ornvULUQrUzKK9VRfttm8wlOD3rQH5fbJKKDMheB+s13Cdu4cbo77gMQeR90gqkN1T+m5YsU1fe7DMJr2SKPfSqBM9AZjS0QXka5fkhdb2CGCGdpuDlvnHw+eNBc7ZAJGek8H4EtLZXD8Mb7y5H+IYJX9rjpVY4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782425096; c=relaxed/simple;
	bh=Artiy9CjaTysZXIYJ3Ptl2edwTCWboJKnYmf4WWBv+8=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=ePuAD+e5hqtA/sRo1+9SM8g91V3wCLMHRF8CuDoBcymKJiutJsgN7y8JJ3RQl/CkFdP/BsytzIEERPASmYDs1AWVfWzQIiHbknkFkcScFS0Ask5SrGc3qXiyOlqSP7qhOgrcc8SiOqa5hmFA0ClO4W3rd8j7VHziCSlOWYkshuw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=PSeGbxIp; arc=none smtp.client-ip=209.85.215.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="PSeGbxIp"
Received: by mail-pg1-f202.google.com with SMTP id 41be03b00d2f7-c856470fe9fso173136a12.2
        for <kvm@vger.kernel.org>; Thu, 25 Jun 2026 15:04:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1782425094; x=1783029894; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=UvJmFa71K+nG0zm065a0BE9QWjrL3MH6l4Vf9hIU7qA=;
        b=PSeGbxIpikUytE9sEuE+GWSqk6iSEpFq5YWJy2lUiEZT+b3aLvPV/zWL78bxGIKhnK
         rjAeMKnLRnAj3z3dXJYbouVbPbLkf1t3nKp0cHzPuko8+lCwzH/tdBSV9iEgCxwWS66u
         ZxT3mcHhkzvmnlsCj+Wv7tek9ey2HuwBlo6DXMEJsN7zK9otisEsMsjQHm+vPGZTSduz
         rdv7pYbS76wVmssKYKMlPD1/CuKZMNlHOjLsHDYfj+cB3EWknE3eDPLqXJNAlYMjJTEB
         fp0c+sWfy5qLWFYQbzvOGkBU/LSlHEglbS5AdTg25RfKTSQhRo3wMIu7ESW+YyjbMIJn
         fW/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782425094; x=1783029894;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UvJmFa71K+nG0zm065a0BE9QWjrL3MH6l4Vf9hIU7qA=;
        b=hpXNOZ4Orjc61B77p6IOG4VbqNYsMDQ80jWugO76DjT9bTRu4dHgNuU8aSUDAshFlI
         ipMZ+Ek1+KHhAs6R6HWb1k/sBtn9oF17p+QMH3iWFJTNjamxvUldQoR4ediPuvXD/7j4
         rzbQ84x87QE0kN43rojzWVtHUFvVm9AIflhkghE+XerQ+nsj47QcV10wHZHO5eCAKqXJ
         efhwHwWuKxVJrbMC0ePKjBXKCnEnhuzUNN+/SAf8QerEVLMv+F3CeHXbItKbC+oorlr7
         N+yekt6XkRsbAdgeZRw2Hw/JBVTeQADyklusB5ZBYRAfiDDvTGwTnMIzQvr6E1oRsDlF
         U6bQ==
X-Gm-Message-State: AOJu0YxFsD2KaTuDCpm1h5q84xPGHLFGdDxd9u4ztWWhKR8uXy5KZHlG
	W/jCy8U+Hhbpl5+iHF4MqECW8nQi20Z0Sx3KlQkSH2AMnB6UOKUvV40U+z88Erv087/UmVYdLZ3
	o00y5IA==
X-Received: from pjbpd13.prod.google.com ([2002:a17:90b:1dcd:b0:36b:c408:4c00])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:3c4e:b0:37d:ac3a:2f4f
 with SMTP id 98e67ed59e1d1-37dfa25153fmr4415377a91.13.1782425094193; Thu, 25
 Jun 2026 15:04:54 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Thu, 25 Jun 2026 15:04:42 -0700
In-Reply-To: <20260625220450.3354415-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260625220450.3354415-1-seanjc@google.com>
X-Mailer: git-send-email 2.55.0.rc0.799.gd6f94ed593-goog
Message-ID: <20260625220450.3354415-2-seanjc@google.com>
Subject: [PATCH 1/9] KVM: x86: Move the "APIC attention" macros from
 kvm_host.h => lapic.c
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>, 
	Vitaly Kuznetsov <vkuznets@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Binbin Wu <binbin.wu@linux.intel.com>, Kai Huang <kai.huang@intel.com>
Content-Type: text/plain; charset="UTF-8"

Move the macros that define the mostly-obsolete apic_attention bits into
lapic.c, as the gory details of PV EOIs and the pre-APICv TPR acceleration
are 100% internal to KVM's local APIC emulation.

No functional change intended.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/include/asm/kvm_host.h | 10 ----------
 arch/x86/kvm/lapic.c            | 10 ++++++++++
 2 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_host.h
index b517257a6315..9ba8aa739f93 100644
--- a/arch/x86/include/asm/kvm_host.h
+++ b/arch/x86/include/asm/kvm_host.h
@@ -290,16 +290,6 @@ enum x86_intercept_stage;
 #define PFERR_PRIVATE_ACCESS   BIT_ULL(49)
 #define PFERR_SYNTHETIC_MASK   (PFERR_IMPLICIT_ACCESS | PFERR_PRIVATE_ACCESS)
 
-/* apic attention bits */
-#define KVM_APIC_CHECK_VAPIC	0
-/*
- * The following bit is set with PV-EOI, unset on EOI.
- * We detect PV-EOI changes by guest by comparing
- * this bit with PV-EOI in guest memory.
- * See the implementation in apic_update_pv_eoi.
- */
-#define KVM_APIC_PV_EOI_PENDING	1
-
 struct kvm_kernel_irqfd;
 struct kvm_kernel_irq_routing_entry;
 
diff --git a/arch/x86/kvm/lapic.c b/arch/x86/kvm/lapic.c
index 6f30bbdddb5a..0354db0f2c0f 100644
--- a/arch/x86/kvm/lapic.c
+++ b/arch/x86/kvm/lapic.c
@@ -75,6 +75,16 @@ module_param(lapic_timer_advance, bool, 0444);
 /* step-by-step approximation to mitigate fluctuation */
 #define LAPIC_TIMER_ADVANCE_ADJUST_STEP 8
 
+/* apic attention bits */
+#define KVM_APIC_CHECK_VAPIC	0
+/*
+ * The following bit is set with PV-EOI, unset on EOI.
+ * We detect PV-EOI changes by guest by comparing
+ * this bit with PV-EOI in guest memory.
+ * See the implementation in apic_update_pv_eoi.
+ */
+#define KVM_APIC_PV_EOI_PENDING	1
+
 static bool __read_mostly vector_hashing_enabled = true;
 module_param_named(vector_hashing, vector_hashing_enabled, bool, 0444);
 
-- 
2.55.0.rc0.799.gd6f94ed593-goog

