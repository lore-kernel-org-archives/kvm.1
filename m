Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.175.65.12
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794940302;
	b=nTj20e+gq4up58RWWQze3a9dOvrdFdKS4SKsH5CC/zgSWdMB+UUPx3vI6eWLRi6VAZvu
	 epSXwFfZayWfKqhk6dByRPK70cvpXOpsl6f1hmaQS2a5DeNfs1q7uwQr+AmoaxJ4YNP0l
	 V2C3FaEX8wL/7IDaQtYH76MQyyCWzEjaJaZ81lxqlx4qIgEkAUfrmR65BMZC9+kmJwiuB
	 RGsquPVHhChBxU/6Y7wtOhsOrEKuNfPuvKnuT18QYyiGt8iBvB3HXihXUTLpD7TZNNaXi
	 DprRv23GuDB1EtFuT63kegG66zszh2FOhGmvSh2K4SbJJlExeEUW//3cs9kHRL4CaCQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794940302;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=XnunHmyL4XwE0qte7Kz3QftqMo1KZMNwCZzNmhB3cME=;
	b=0M3GU0thz8B8jSlduoHBZbq5mSL/gl9VEM/u534I0kGpbZLrM5VhzN14JymBLvPvVX5s
	 lHHuhXQ3mmrNP4AjvISZYTUlcVyeTXeQuVIRfohJ5HCVjS88wCyxdMBH28lkD/O+jZ2h0
	 ED91o3qPHZHzEB56xPn0SVukMfgyFJHKQptWFgFCNCBT7l+G4EXEAFX7n5XPCjOZhyobB
	 lKnsqH5zq+VYbe5T26s70AtBeWIDYAReVRbZPvV2tdiKar/vHtJdS70o8lSMt5X//HzBS
	 4YKv3EwZnzlSpezVZBoF97Gz7gsoDdKyN2OQFERf98ACL9tfCZNOlW1adcwMI4M/uuQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=ejcx1rex;
	arc=none smtp.remote-ip=198.175.65.12
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C1D7606A334;
	Tue, 17 Nov 2026 18:31:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4C1D7606A334
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=ejcx1rex
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1794940302; x=1826476302;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=jnB1m4ZcgktA+fwwhU+v+6g5xXw9pF45HqzuiTGDj9I=;
  b=ejcx1rexFm7IfEnbTpScOx1ZK1iMt0tRtDGohDxT0AQOOhisYZWjQUPM
   WijXlP6j+6rWx8aesqZmsGfCT3ebh4xBV9646NwSwyLovO2hkPOXOgagJ
   ekcNEg8DI9Dls0P6JxvAvINfydosA1cwBcGlhzMggND1T51ETpHFvRtQ2
   +RDxXvXAfuC2+/5gOInps8vevHO/9jpljtSlZdDwf761hxQz3siFv98yc
   OQkpXLmG7H6+iIc0Af+qFfUmAo+qNDtanO0Rswm5LE+LSQegv2pxo1jc0
   LTEouEG4NqWugiQRMNWXVCeE8epRO57s9OKpGw3oR6Nm+reNL6FF0ce6j
   g==;
X-CSE-ConnectionGUID: pfBmmJbtQ7mw5gJNmWW5VQ==
X-CSE-MsgGUID: RLbwZOkeR5qEYFNPJCWIew==
X-IronPort-AV: E=McAfee;i="6800,10657,11969"; a="3607200"
X-IronPort-AV: E=Sophos;i="6.27,218,1787036400"; 
   d="scan'208";a="3607200"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Nov 2026 10:30:43 -0800
X-CSE-ConnectionGUID: jAyTKsJNSmqvBWmNjnkaOA==
X-CSE-MsgGUID: rV3j1AAjTcudb1pSTKQllQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,218,1787036400"; 
   d="scan'208";a="9774998"
Received: from chang-linux-3.sc.intel.com (HELO chang-linux-3) ([172.25.66.174])
  by orviesa003.jf.intel.com with ESMTP; 17 Nov 2026 10:30:43 -0800
From: "Chang S. Bae" <chang.seok.bae@intel.com>
To: seanjc@google.com,
	jmattson@google.com
Cc: pbonzini@redhat.com,
	kvm@vger.kernel.org,
	x86@kernel.org,
	linux-kernel@vger.kernel.org,
	zhao1.liu@intel.com,
	chang.seok.bae@intel.com
Subject: [PATCH v9 03/20] KVM: x86: Support EGPRs on VCPU RESET/INIT events
Date: Tue, 17 Nov 2026 18:02:53 +0000
Message-ID: <20261117180310.921701-4-chang.seok.bae@intel.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261117180310.921701-1-chang.seok.bae@intel.com>
References: <20261117180310.921701-1-chang.seok.bae@intel.com>
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

EGPRs are not zeroed on CPU INIT. Handle each register based on index to
support this EGPR behavior while preserving the existing behavior for
legacy GPRs.

Refactor the rest of GPR handling together as the reset comment mentions it.

Signed-off-by: Chang S. Bae <chang.seok.bae@intel.com>
---
V8 -> V9: New patch (Jim Mattson)
---
 arch/x86/kvm/x86.c | 40 ++++++++++++++++++++++++++--------------
 1 file changed, 26 insertions(+), 14 deletions(-)

diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index 2cd9ee316aad..73bb1d25931c 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -9601,9 +9601,33 @@ static void kvm_xstate_reset(struct kvm_vcpu *vcpu, bool init_event)
 		kvm_load_guest_fpu(vcpu);
 }
 
-void kvm_vcpu_reset(struct kvm_vcpu *vcpu, bool init_event)
+static void kvm_vcpu_regs_reset(struct kvm_vcpu *vcpu, bool init_event)
 {
 	struct kvm_cpuid_entry2 *cpuid_0x1;
+	int idx;
+
+	/*
+	 * All legacy GPRs except RDX (handled below) are zeroed on RESET/INIT.
+	 * EGPRs (R16-R31), however, retain their values on INIT.
+	 */
+	for (idx = VCPU_REGS_RAX; idx < NR_VCPU_GENERAL_PURPOSE_REGS; idx++)
+		vcpu->arch.regs[idx] = idx > 15 && init_event ? vcpu->arch.regs[idx] : 0;
+
+	kvm_register_mark_dirty(vcpu, VCPU_REGS_RSP);
+
+	/*
+	 * Fall back to KVM's default Family/Model/Stepping of 0x600 (P6/Athlon)
+	 * if no CPUID match is found.  Note, it's impossible to get a match at
+	 * RESET since KVM emulates RESET before exposing the vCPU to userspace,
+	 * i.e. it's impossible for kvm_find_cpuid_entry() to find a valid entry
+	 * on RESET.  But, go through the motions in case that's ever remedied.
+	 */
+	cpuid_0x1 = kvm_find_cpuid_entry(vcpu, 1);
+	kvm_edx_write(vcpu, cpuid_0x1 ? cpuid_0x1->eax : 0x600);
+}
+
+void kvm_vcpu_reset(struct kvm_vcpu *vcpu, bool init_event)
+{
 	unsigned long old_cr0 = kvm_read_cr0(vcpu);
 	unsigned long new_cr0;
 
@@ -9673,19 +9697,7 @@ void kvm_vcpu_reset(struct kvm_vcpu *vcpu, bool init_event)
 		kvm_msr_write(vcpu, MSR_IA32_XSS, 0);
 	}
 
-	/* All GPRs except RDX (handled below) are zeroed on RESET/INIT. */
-	memset(vcpu->arch.regs, 0, sizeof(vcpu->arch.regs));
-	kvm_register_mark_dirty(vcpu, VCPU_REGS_RSP);
-
-	/*
-	 * Fall back to KVM's default Family/Model/Stepping of 0x600 (P6/Athlon)
-	 * if no CPUID match is found.  Note, it's impossible to get a match at
-	 * RESET since KVM emulates RESET before exposing the vCPU to userspace,
-	 * i.e. it's impossible for kvm_find_cpuid_entry() to find a valid entry
-	 * on RESET.  But, go through the motions in case that's ever remedied.
-	 */
-	cpuid_0x1 = kvm_find_cpuid_entry(vcpu, 1);
-	kvm_edx_write(vcpu, cpuid_0x1 ? cpuid_0x1->eax : 0x600);
+	kvm_vcpu_regs_reset(vcpu, init_event);
 
 	kvm_x86_call(vcpu_reset)(vcpu, init_event);
 
-- 
2.53.0

