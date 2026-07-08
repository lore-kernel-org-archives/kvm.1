Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B364E3E1CE5;
	Wed,  8 Jul 2026 06:35:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783492505; cv=none; b=E+N2WPEh3hNH1gx8PnQQgXxEmB2p75scGLkLrEQB4GjcnNGtfIst90c4nzvrFHgMgILhFOm5AxRxhypv1tl4LSNIfJsp9iCCYnPtfvo/rN9LuISAS0PuMwldIFM9QoESejxiFa9V2SA+M4RBCq+jlG62YrF1+6D4n5Dn89qbtqc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783492505; c=relaxed/simple;
	bh=6/6SdHHWj1NXPcskKtJAe8vs4tb1RNlTtGg3iHdd30I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=b7/a/VXfYsbW1JljyHQQGpcEAoGiwBCGTvT3YAoL4qKU7XLxsepL8HV62iJHy2N1QEEV2TS5hybeo9kTR2QFvPRC9ILGEgigxmnvUgLg57pOtDYlLtMTtRWBbqPOq5fvAJAUzmn6/9lFYJbDGaKTDdtmxvY4XttTKEtzW4tgP2k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=N8S2FxrO; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="N8S2FxrO"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6CD3B1F00A3D;
	Wed,  8 Jul 2026 06:35:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783492503;
	bh=GcFcGROSvldX+efo1gLqZu8kI9BHrY98Ely0PvdHhxY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=N8S2FxrOgGN1gZmz32haoiPEJekzZid6oTSTL7n8o5BP00vZBvXSHzdYZnRPFAY1P
	 JYat2Hz6nap8aVT1fmizW6/WBEU9V3gAzRGLTG9XRed3NxAN7yJI2Yg+vxTisp6o/U
	 KUUQYduPdNLk3yq1qxKjIdgM4r6bJhiQEy+opLXUiWdhRJY7v/PIDOrlwsUR3pkp87
	 K1YHlBislubgnqjwWntpwNJFwdOuy1hL4mv031bkLMbR/oLAs7ucJd3NjftYMI7SjY
	 PWJmkgdpPhrGTdNIWNwemz1hSrEcNNKcfqymWxk/pdO+v9HY3lqByT/WiucRiduJJ/
	 gFroNQxKiRbWg==
From: "Naveen N Rao (AMD)" <naveen@kernel.org>
To: Sean Christopherson <seanjc@google.com>,
	Borislav Petkov <bp@alien8.de>
Cc: <kvm@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Nikunj A Dadhania <nikunj@amd.com>,
	Tom Lendacky <thomas.lendacky@amd.com>,
	Neeraj Upadhyay <neeraj.upadhyay@amd.com>,
	Tianyu Lan <tiala@microsoft.com>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Thomas Gleixner <tglx@kernel.org>
Subject: [RFC PATCH v3 04/27] x86/apic: Use AVIC_INCOMPLETE_IPI VMGEXIT for Secure AVIC IPI handling
Date: Wed,  8 Jul 2026 12:02:02 +0530
Message-ID: <97a8081fb548567f004f31e2afb02bd06d7a9982.1783490022.git.naveen@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <cover.1783490022.git.naveen@kernel.org>
References: <cover.1783490022.git.naveen@kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

x2apic_savic driver currently uses SVM_EXIT_MSR to have the hypervisor
emulate ICR writes and to be able to deliver IPIs. However, the driver
also sets APIC_IRR in the APIC backing page of the target vCPU, so the
expectation is only for the hypervisor to notify/wake up the target
vCPU.

This is incorrect since SVM_EXIT_MSR is for requesting full emulation of
a certain MSR access -- and hypervisors expect to be able to _inject_
(set APIC_IRR) *and* deliver the interrupt to the target. This can
result in duplicate interrupts at the guest (assuming the guest is
allowing that vector to be injected by the hypervisor).

Instead, have the driver do AVIC_INCOMPLETE_IPI exit so that it is clear
on what the hypervisor needs to do. This is the same exit used by SVM
AVIC when it has already set APIC_IRR in the target vCPU APIC backing
page to request the hypervisor to send an AVIC doorbell/wake up the
target vCPU. Add the newly added exit ID AVIC_IPI_FAILURE_UNACCELERATED
(ID number 5) and use the same to signal that this is a Secure AVIC
access that is not accelerated by hardware.

Fixes: 2c6978ea1a85 ("x86/apic: Add support to send IPI for Secure AVIC")
Signed-off-by: Naveen N Rao (AMD) <naveen@kernel.org>
---
 arch/x86/include/asm/svm.h |  1 +
 arch/x86/coco/sev/core.c   | 18 +++++++++++++++++-
 2 files changed, 18 insertions(+), 1 deletion(-)

diff --git a/arch/x86/include/asm/svm.h b/arch/x86/include/asm/svm.h
index aa63431ba92c..42ececa8963d 100644
--- a/arch/x86/include/asm/svm.h
+++ b/arch/x86/include/asm/svm.h
@@ -284,6 +284,7 @@ enum avic_ipi_failure_cause {
 	AVIC_IPI_FAILURE_INVALID_TARGET,
 	AVIC_IPI_FAILURE_INVALID_BACKING_PAGE,
 	AVIC_IPI_FAILURE_INVALID_IPI_VECTOR,
+	AVIC_IPI_FAILURE_UNACCELERATED,
 };
 
 #define AVIC_PHYSICAL_MAX_INDEX_MASK	GENMASK_ULL(11, 0)
diff --git a/arch/x86/coco/sev/core.c b/arch/x86/coco/sev/core.c
index 7ed3da998489..69c75ea543a3 100644
--- a/arch/x86/coco/sev/core.c
+++ b/arch/x86/coco/sev/core.c
@@ -1014,13 +1014,29 @@ void savic_ghcb_msr_write(u32 reg, u64 value)
 	struct ghcb_state state;
 	enum es_result res;
 	struct ghcb *ghcb;
+	u64 exit_info_2;
 
 	guard(irqsave)();
 
 	ghcb = __sev_get_ghcb(&state);
 	vc_ghcb_invalidate(ghcb);
 
-	res = __vc_handle_msr(ghcb, &ctxt, true);
+	if (reg == APIC_ICR) {
+		/*
+		 * Exit with AVIC_INCOMPLETE_IPI to request hypervisor to notify
+		 * the target vCPU(s). exit_info_1 is just the ICR value.
+		 * exit_info_2 encodes exit id in the upper 32-bits, and icrh
+		 * (IPI dest, since Secure AVIC is x2APIC-only) in the lower 32-bits.
+		 */
+		exit_info_2 = (u64)(AVIC_IPI_FAILURE_UNACCELERATED) << 32;
+		exit_info_2 |= upper_32_bits(value);
+
+		res = sev_es_ghcb_hv_call(ghcb, &ctxt, SVM_EXIT_AVIC_INCOMPLETE_IPI,
+					  value, exit_info_2);
+	} else {
+		res = __vc_handle_msr(ghcb, &ctxt, true);
+	}
+
 	if (res != ES_OK) {
 		pr_err("Secure AVIC MSR (0x%llx) write returned error (%d)\n", msr, res);
 		/* MSR writes should never fail. Any failure is fatal error for SNP guest */
-- 
2.54.0

