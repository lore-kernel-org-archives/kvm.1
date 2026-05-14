Received: from mail-pf1-f201.google.com (mail-pf1-f201.google.com [209.85.210.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85DE73CF69C
	for <kvm@vger.kernel.org>; Thu, 14 May 2026 21:05:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778792725; cv=none; b=bWmRAJb9Xa+pDt41a5KXr3KVt3smAZNVZerKmRR7NCu0VN77D1mnaGv/AOjlWqn0afVjRa+Zk8zIkm/UOhfSfqKUWT6bIGqgE5zdgJVr4A389nShjswknJdoF9rpdd//TU5RORC+8SWmomuHGj8NBwXusi0Z4CgAOLrjPvUu5jU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778792725; c=relaxed/simple;
	bh=9NiAGFD6fc9+GqxizoCZND1kvjkTRFGhZAVcgu9n7xE=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=W6iex2L9MQbzE/GDz/GIxaVRPTY+5CtGOisQA1YI+4hc14bHz1CYS7+xxx45mwJbLFyICgb+ZpG64uYNd9Ht9FvwDmgsP8KtejB83lU9BcmUtIWnx5V9+hpqzYwPGJduksVPa6qQNFJ0mrAlNk84FcxH7eWmGV1OCmBnaJkv4mM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=gB+AUqqZ; arc=none smtp.client-ip=209.85.210.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="gB+AUqqZ"
Received: by mail-pf1-f201.google.com with SMTP id d2e1a72fcca58-82fa860e71eso4795710b3a.0
        for <kvm@vger.kernel.org>; Thu, 14 May 2026 14:05:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1778792724; x=1779397524; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=vRbHNla8IFW1HB3HQkxE0Wf2iPARUBWXsUP0btJ7pIA=;
        b=gB+AUqqZv8N7hEm3c+farKVtva7HZn07Ij5FG61+iS2gQwIpPiby8+QOoOy9Eh54Pp
         ZcBEHXdatX3M+r+Z/QfLUn6o6nvvbdqcD5cL0QOEnHv9dPfcsdT7Z7swCQqgHqZgt2dK
         n36piXyMZgd9ZdXdZRiWxK7jq5iEb/mwdQkLKdorb4yffqWC48OlniDIqA9AGJppB7nn
         u8j1jqNw/4RR5u9XVzHc8zUic0fZSHWZJ+lf6LiEnK0unL4rkH+sjQgOmMUX+cUx21Y/
         A0qK0G7kJMcR8+cv72doehkg9B8nEZ4EBBKT0XXQDzeo7vqn6t3DZ5RGNTAMfDdaBCHV
         itqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778792724; x=1779397524;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vRbHNla8IFW1HB3HQkxE0Wf2iPARUBWXsUP0btJ7pIA=;
        b=KOl2hS7qi+psd18tLthOw966AE3ltL/OcjBiTkjG4Ai4W4zr1nyQGkted7ai/vI2Cp
         BqCdP7eVW0rORex4w23pqxuhEJbt+lJDZ6O7erEQcVotYlrI5HkbhnS+7rJg1R4CXYqg
         somyjQd0X1OvjwY2TQ0TKy266fLx2F1rg61nWn6ONT4xn6k1+pQvNtu7dFWjoSWBxbeI
         YcgFh+JeQ8GZ/fbuT+2qH5WYGeysiqSfZulHtFGkn+OR6guGDZ6kHuDh+/W6ZJOedHyj
         3+ceKc4LVPxBlU11Gyp/7H2ZlcGAJqPyzP1vQfPHwLIpcOkPJua47zUF8U1CBEoDZ+g6
         tS+A==
X-Gm-Message-State: AOJu0YwVHDZoxhf1n4IDDoRP1aX7LCUjaiJOt6rsvPLiEPDxBtZLW92X
	FRCBVUc75r/RZmH7YPpYOV2CT+6/RrZ7yUlpq59F3Mr1MUxI96QQAq6A0qgNakuh6NQWE6zM/an
	4gb+YaQ==
X-Received: from pfbgo19.prod.google.com ([2002:a05:6a00:3b13:b0:82f:8a3b:87f0])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:94f7:b0:83e:b22f:373a
 with SMTP id d2e1a72fcca58-83f33b0aba9mr1298313b3a.11.1778792723431; Thu, 14
 May 2026 14:05:23 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Thu, 14 May 2026 14:04:58 -0700
In-Reply-To: <20260514210500.1626871-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260514210500.1626871-1-seanjc@google.com>
X-Mailer: git-send-email 2.54.0.563.g4f69b47b94-goog
Message-ID: <20260514210500.1626871-19-seanjc@google.com>
Subject: [kvm-unit-tests PATCH v3 18/20] x86/vmx: Write to KVM's WALL_CLOCK
 MSR via VM-Entry load list sync in SIPI test
From: Sean Christopherson <seanjc@google.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, Sean Christopherson <seanjc@google.com>, 
	Mathias Krause <minipli@grsecurity.net>, Andrew Jones <andrew.jones@linux.dev>
Content-Type: text/plain; charset="UTF-8"

In the VMX Wait-for-SIPI => SIPI VM-Exit test, signal that the AP has
entered the guest by writing to MSR_KVM_WALL_CLOCK_NEW (when supported)
via the VM-Entry MSR load list instead of writing to memory from the AP
_before_ actually doing VM-Enter.  Abusing the MSR load list ensures that
the AP's "ready" signal to the BSP happens atomically with respect to
VM-Enter, and thus fixes a race where the BSP can see "ready" and send the
SIPI before the AP has executed VM-Enter.  E.g. with a delay inserted on
the AP, and no delay on the BSP, the test will hang 100% of the time.

Use MSR_KVM_WALL_CLOCK_NEW as it is pretty much the only MSR that KVM
emulates as a per-VM MSR, and that has a high likelihood of being
available.

Keep the BSP's delay before send the SIPI so that the test continues to
work if MSR_KVM_WALL_CLOCK_NEW isn't available, e.g. in bare metal (and
most KVM) setups, hitting the race is practically impossible.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 x86/vmx_tests.c | 26 +++++++++++++++++++++++++-
 1 file changed, 25 insertions(+), 1 deletion(-)

diff --git a/x86/vmx_tests.c b/x86/vmx_tests.c
index 31c7672c..ac0250b7 100644
--- a/x86/vmx_tests.c
+++ b/x86/vmx_tests.c
@@ -6,6 +6,7 @@
 
 #include <asm/debugreg.h>
 
+#include "kvmclock.h"
 #include "vmx.h"
 #include "msr.h"
 #include "processor.h"
@@ -10155,6 +10156,8 @@ static void vmx_init_signal_test(void)
 	 */
 }
 
+static bool use_kvm_wall_clock;
+
 #define SIPI_SIGNAL_TEST_DELAY	100000000ULL
 
 static void vmx_sipi_test_guest(void)
@@ -10199,6 +10202,11 @@ static void vmx_sipi_test_guest(void)
 
 static void sipi_test_ap_thread(void *data)
 {
+	const struct vmx_msr_entry msr_load_wall_clock = {
+		.index = MSR_KVM_WALL_CLOCK_NEW,
+		.reserved = 0,
+		.value = 1,
+	};
 	struct guest_regs *regs = this_cpu_guest_regs();
 	struct vmcs *ap_vmcs;
 	u64 *ap_vmxon_region;
@@ -10231,7 +10239,13 @@ static void sipi_test_ap_thread(void *data)
 	/* Set guest activity state to wait-for-SIPI state */
 	vmcs_write(GUEST_ACTV_STATE, ACTV_WAIT_SIPI);
 
-	vmx_set_test_stage(1);
+	if (use_kvm_wall_clock) {
+		wrmsr(MSR_KVM_WALL_CLOCK_NEW, 0);
+		vmcs_write(ENT_MSR_LD_CNT, 1);
+		vmcs_write(ENTER_MSR_LD_ADDR, virt_to_phys(&msr_load_wall_clock));
+	} else {
+		vmx_set_test_stage(1);
+	}
 
 	/* AP enter guest */
 	enter_guest();
@@ -10274,6 +10288,9 @@ static void vmx_sipi_signal_test(void)
 	u64 cpu_ctrl_0 = CPU_SECONDARY;
 	u64 cpu_ctrl_1 = 0;
 
+	use_kvm_wall_clock = this_cpu_has_kvm() &&
+			     this_cpu_has(KVM_FEATURE_CLOCKSOURCE2);
+
 	/* passthrough lapic to L2 */
 	disable_intercept_for_x2apic_msrs();
 	vmcs_write(PIN_CONTROLS, vmcs_read(PIN_CONTROLS) & ~PIN_EXTINT);
@@ -10290,6 +10307,13 @@ static void vmx_sipi_signal_test(void)
 	/* start AP */
 	on_cpu_async(1, sipi_test_ap_thread, NULL);
 
+	if (use_kvm_wall_clock) {
+		while (rdmsr(MSR_KVM_WALL_CLOCK_NEW) != 1)
+			cpu_relax();
+
+		vmx_set_test_stage(1);
+	}
+
 	/* BSP enter guest */
 	enter_guest();
 }
-- 
2.54.0.563.g4f69b47b94-goog

