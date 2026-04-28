Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6677E389E18
	for <kvm@vger.kernel.org>; Tue, 28 Apr 2026 07:03:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777359839; cv=none; b=ck5T4ffN1rTemTuOC8kL7iTkz9+2jlqsyuEozVrh6+VhjUqHBRoVvrCS3tQVwu51tHCtkwwSkrN2z0jE8Q6OvQFlPyFks5hRpRT41xNDTewAGYUluimbP5L+vH9kSuFe0Dj6cPZmFDRwA7L3m41lvCPR8NrVYh744Sh4gvTflI8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777359839; c=relaxed/simple;
	bh=vZrwHsYKaiOo6cp4xIbTsy3+95RfnU375oJ1Bni4EK4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=aVqsm5VNkABU0BgiRF+Qo7Mpgc7w8yXICZ/41Di6pH3/6WW7jqZew26AIeYkq5lgS2IHlIJcyPK3fJPoiQklqGljK7/Dgqn7tQeGET00BQBnnrBMP9MGPsdtes7pSWT9pqioMTPUximP6eWvDF3X86nAZeAqUr3anXwp/dqz0F8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ALv5DB93; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ALv5DB93"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1777359837; x=1808895837;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=vZrwHsYKaiOo6cp4xIbTsy3+95RfnU375oJ1Bni4EK4=;
  b=ALv5DB935sw2PbvggTYtFcGUq7dJ+kT0UWsAgHfj0BzMlBb+wkYBwDQi
   Kf6//L1Y2bWeZ+XT7TriiBHoolzVXJg1xMhheZWRwYw74Uf0rTH1/NRpo
   kzMiF2rWvWhnl3AEIbQ3AJSi0yaWqxMvJsVNJGAG7/fJ3TbtfNzQXguAl
   lUoqJ8P7dGR7be/k6pxzxww2OaGdry9Sy3pFKPi4UEZ+R0euh1BWyRMcf
   XQtcFt3C5ziFAPV1tVsYbDTYwtojiTOmK2RjTmHphCMfejwRY6vEHmj7M
   ZkQaZWbyNolAcbZfCmVLGc2DxUIHL751xCDzo0owRUt2Mk9o+/zUYUOOB
   w==;
X-CSE-ConnectionGUID: rfHdyEW9TDqh2HK5TLVQpQ==
X-CSE-MsgGUID: 2LX5D7YZSVSKRKc/Ce5uvA==
X-IronPort-AV: E=McAfee;i="6800,10657,11769"; a="88571827"
X-IronPort-AV: E=Sophos;i="6.23,203,1770624000"; 
   d="scan'208";a="88571827"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Apr 2026 00:03:56 -0700
X-CSE-ConnectionGUID: rBNhLOiURUuRUZILX1VpJw==
X-CSE-MsgGUID: 0jS/rjQ4QwOg2hwxmE67CA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,203,1770624000"; 
   d="scan'208";a="227350871"
Received: from emr-bkc.sh.intel.com ([10.112.230.82])
  by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Apr 2026 00:03:54 -0700
From: Chenyi Qiang <chenyi.qiang@intel.com>
To: kvm@vger.kernel.org
Cc: Chenyi Qiang <chenyi.qiang@intel.com>,
	Sean Christopherson <seanjc@google.com>,
	Jim Mattson <jmattson@google.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Gao Chao <chao.gao@intel.com>,
	Farrah Chen <farrah.chen@intel.com>
Subject: [PATCH] KVM: VMX: Fall back to IRR scan when PIR is empty despite PID.ON being set
Date: Tue, 28 Apr 2026 15:03:26 +0800
Message-ID: <20260428070349.1633238-1-chenyi.qiang@intel.com>
X-Mailer: git-send-email 2.43.5
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fall back to kvm_lapic_find_highest_irr() in vmx_sync_pir_to_irr() when
PID.ON is set but PIR turns out to be empty, to correctly report the
highest pending interrupt from the existing IRR.

In a nested VM stress test, the following WARNING fires in
vmx_check_nested_events() when kvm_cpu_has_interrupt() reports a pending
interrupt but the subsequent kvm_apic_has_interrupt() (which invokes
vmx_sync_pir_to_irr() again) returns -1:

  WARNING: CPU: 99 PID: 57767 at arch/x86/kvm/vmx/nested.c:4449 vmx_check_nested_events+0x6bf/0x6e0 [kvm_intel]
  Call Trace:
   kvm_check_and_inject_events
   vcpu_enter_guest.constprop.0
   vcpu_run
   kvm_arch_vcpu_ioctl_run
   kvm_vcpu_ioctl
   __x64_sys_ioctl
   do_syscall_64
   entry_SYSCALL_64_after_hwframe

The root cause is a race between vmx_sync_pir_to_irr() on the target vCPU
and __vmx_deliver_posted_interrupt() on a sender vCPU.  The sender
performs two individually-atomic operations that are not a single
transaction:

  1. pi_test_and_set_pir(vector)  -- sets the PIR bit
  2. pi_test_and_set_on()         -- sets PID.ON

The following interleaving triggers the bug:

  Sender vCPU (IPI):              Target vCPU (1st sync_pir_to_irr):
  B1: set PIR[vector]
                                  A1: pi_clear_on()
                                  A2: pi_harvest_pir() -> sees B1 bit
                                  A3: xchg() -> consumes bit, PIR=0
                                      (1st sync returns correct max_irr)
  B2: set PID.ON = 1

                                  Target vCPU (2nd sync_pir_to_irr):
                                  C1: pi_test_on() -> TRUE (from B2)
                                  C2: pi_clear_on() -> ON=0
                                  C3: pi_harvest_pir() -> PIR empty
                                  C4: *max_irr = -1, early return
                                      IRR NOT SCANNED

The interrupt is not lost (it resides in the IRR from the first sync and
is recovered on the next vcpu_enter_guest() iteration), but the incorrect
max_irr causes a spurious WARNING and a wasted L2 VM-Enter/VM-Exit cycle.

Fixes: b41f8638b9d3 ("KVM: VMX: Isolate pure loads from atomic XCHG when processing PIR")
Reported-by: Farrah Chen <farrah.chen@intel.com>
Assisted-by: GitHub Copilot:Claude Opus 4.6
Signed-off-by: Chenyi Qiang <chenyi.qiang@intel.com>

---
There is a WARNING call trace during a nested VM stress test. AI
provided an analysis of a race condition and the related fix, which
looks reasonable to me. With the patch applied, the WARNING can not
be reproduced in overnight stress testing.
---
 arch/x86/kvm/vmx/vmx.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
index 8b24e682535b..e2da29371e00 100644
--- a/arch/x86/kvm/vmx/vmx.c
+++ b/arch/x86/kvm/vmx/vmx.c
@@ -7153,6 +7153,16 @@ int vmx_sync_pir_to_irr(struct kvm_vcpu *vcpu)
 		smp_mb__after_atomic();
 		got_posted_interrupt =
 			kvm_apic_update_irr(vcpu, vt->pi_desc.pir, &max_irr);
+		/*
+		 * If PID.ON was set but PIR is empty, another CPU may have
+		 * set PID.ON via __vmx_deliver_posted_interrupt() after a
+		 * previous sync already consumed the PIR bits.  In this
+		 * case, kvm_apic_update_irr() will not have scanned the
+		 * existing IRR, so fall back to scanning the IRR directly
+		 * to correctly report the highest pending interrupt.
+		 */
+		if (max_irr == -1)
+			max_irr = kvm_lapic_find_highest_irr(vcpu);
 	} else {
 		max_irr = kvm_lapic_find_highest_irr(vcpu);
 		got_posted_interrupt = false;
-- 
2.43.5

