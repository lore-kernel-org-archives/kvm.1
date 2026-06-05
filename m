Received: from smtp186.sjtu.edu.cn (smtp186.sjtu.edu.cn [202.120.2.186])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD33F3B71A6;
	Fri,  5 Jun 2026 09:39:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.120.2.186
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780652369; cv=none; b=XqjaRmV+ZeTX2DjR/u1GX0Hii0CeJJ58yEf/1ffbCxS6N1NxMIZvE5cj6OGsfIhxL1/D+CORt0PM0ZoD7GeRsLQIiL3KduP31YZgfDZb9qagaFjJyDdCFhORMKgbp1q/q5QMy+ifxvdMabXEYKJzkxfIYHv74c01GoA+KHV0EEE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780652369; c=relaxed/simple;
	bh=0kC+0SP1J7c/ktNyTh0NStfgv49xOboWMUIpauhPEII=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HoGV1gFJhX3u203ZJNc17NKTcL/hlq6mJDU+4lI9kAAI9qq+02uANjQiRRl5bTgciPb/HAcFyelpgIBCJrZ/cYFRZOteeZd0uDYP5zCLkyIHqVwZrTaQeyx3LV+p7NX29TEkvFUUmoJOe8JygqTOJIZ+DM3bw1Q3LzLYWfJN2Kc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sjtu.edu.cn; spf=pass smtp.mailfrom=sjtu.edu.cn; dkim=pass (2048-bit key) header.d=sjtu.edu.cn header.i=@sjtu.edu.cn header.b=R+xnV0UM; arc=none smtp.client-ip=202.120.2.186
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sjtu.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sjtu.edu.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sjtu.edu.cn header.i=@sjtu.edu.cn header.b="R+xnV0UM"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=sjtu.edu.cn;
	s=default; t=1780652347;
	bh=0kC+0SP1J7c/ktNyTh0NStfgv49xOboWMUIpauhPEII=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=R+xnV0UM0V66LpeppTv9ZY3JxN64P9Fd84JMYbRY0tRaeR3J/estEZ4bTVPcbFg4j
	 H/Vr2j4LuxYxD5aDPTQmi7zz7zhy/+8Euhbixp4rkSGqvD9odKnpLWxcTYmSY90wdm
	 yTGwYZ/cSBuXMGkbhgNEGOhdqWq0tz1ibQ3O0O5fIVhAn/hOuJe+KBPLoybCIxlXRS
	 EW1t18g0qfErgiQj0UvuS5GkFxjdhfluHJhAVY27UGYEKuQP7TdVlD+5cimDIsWjrH
	 7lgL0VQHi/TO+/0n0PejwBUhW8TUjULGPzztrRXxV4KbFpou/qJYexMh7QwhdMHTNO
	 jAQ7ydaCVAsdg==
Received: from proxy188.sjtu.edu.cn (smtp188.sjtu.edu.cn [202.120.2.188])
	by smtp186.sjtu.edu.cn (Postfix) with ESMTPS id 7FB092FF555;
	Fri,  5 Jun 2026 09:39:07 +0000 (UTC)
Received: from mshou-H610M-K-DDR4.. (unknown [202.120.40.100])
	by proxy188.sjtu.edu.cn (Postfix) with ESMTPSA id EE15237C983;
	Fri,  5 Jun 2026 17:39:06 +0800 (CST)
From: "muliang.shou" <muliang.shou@sjtu.edu.cn>
To: kvm@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	seanjc@google.com,
	pbonzini@redhat.com,
	tglx@kernel.org,
	mingo@redhat.com,
	bp@alien8.de,
	dave.hansen@linux.intel.com,
	x86@kernel.org,
	hpa@zytor.com,
	olivier.hault@level-it.be,
	jon@nutanix.com,
	"muliang.shou" <muliang.shou@sjtu.edu.cn>
Subject: [PATCH 1/3] KVM: x86: add DSM IRQ forwarding ABI and state
Date: Fri,  5 Jun 2026 17:38:55 +0800
Message-ID: <20260605093857.747735-2-muliang.shou@sjtu.edu.cn>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260605093857.747735-1-muliang.shou@sjtu.edu.cn>
References: <20260605093857.747735-1-muliang.shou@sjtu.edu.cn>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add the Kconfig knob, request id, per-vCPU state, and userspace ABI
needed to report DSM IRQ forwarding events to userspace.

Signed-off-by: muliang.shou <muliang.shou@sjtu.edu.cn>
---
 arch/x86/include/asm/kvm_host.h | 17 +++++++++++++++++
 arch/x86/kvm/Kconfig            | 12 ++++++++++++
 include/uapi/linux/kvm.h        | 33 ++++++++++++++++++++++++++++++++-
 3 files changed, 61 insertions(+), 1 deletion(-)

diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_host.h
index f14009f25a3b6..7dccfeaee432d 100644
--- a/arch/x86/include/asm/kvm_host.h
+++ b/arch/x86/include/asm/kvm_host.h
@@ -131,6 +131,11 @@
 #define KVM_REQ_UPDATE_PROTECTED_GUEST_STATE \
 	KVM_ARCH_REQ_FLAGS(34, KVM_REQUEST_WAIT)
 
+#ifdef CONFIG_KVM_DSM_IRQ_FORWARD
+#define KVM_REQ_DSM_IRQ_FORWARD	\
+	KVM_ARCH_REQ(33)
+#endif
+
 #define CR0_RESERVED_BITS                                               \
 	(~(unsigned long)(X86_CR0_PE | X86_CR0_MP | X86_CR0_EM | X86_CR0_TS \
 			  | X86_CR0_ET | X86_CR0_NE | X86_CR0_WP | X86_CR0_AM \
@@ -1074,6 +1079,14 @@ struct kvm_vcpu_arch {
 	/* AMD MSRC001_0015 Hardware Configuration */
 	u64 msr_hwcr;
 
+#ifdef CONFIG_KVM_DSM_IRQ_FORWARD
+	/* DSM interrupt forwarding */
+	bool dsm_irq_forward_pending;
+	u32 dsm_irq_forward_reg;
+	u32 dsm_irq_forward_val;
+	u32 dsm_irq_forward_dest_id;
+#endif
+
 	/* pv related cpuid info */
 	struct {
 		/*
@@ -1667,6 +1680,10 @@ struct kvm_arch {
 	 * current VM.
 	 */
 	int cpu_dirty_log_size;
+
+#ifdef CONFIG_KVM_DSM_IRQ_FORWARD
+	int dsm_id;
+#endif
 };
 
 struct kvm_vm_stat {
diff --git a/arch/x86/kvm/Kconfig b/arch/x86/kvm/Kconfig
index 801bf9e520db3..bd3a97f115284 100644
--- a/arch/x86/kvm/Kconfig
+++ b/arch/x86/kvm/Kconfig
@@ -240,4 +240,16 @@ config KVM_MAX_NR_VCPUS
 	  the memory footprint of each KVM guest, regardless of how many vCPUs are
 	  created for a given VM.
 
+config KVM_DSM_IRQ_FORWARD
+	bool "KVM DSM interrupt forwarding support"
+	depends on KVM && KVM_INTEL
+	default n
+	help
+	  Provide support for interrupt forwarding in distributed KVM.
+	  When enabled, guest ICR/ICR2 writes are intercepted and
+	  forwarded to userspace via KVM_EXIT_DSM_SEND_IRQ exit,
+	  allowing cross-node IPI delivery in a distributed KVM setup.
+	  This feature can be used independently of the full DSM memory
+	  coherence framework.
+
 endif # VIRTUALIZATION
diff --git a/include/uapi/linux/kvm.h b/include/uapi/linux/kvm.h
index 6c8afa2047bf3..75a11e72e232e 100644
--- a/include/uapi/linux/kvm.h
+++ b/include/uapi/linux/kvm.h
@@ -194,6 +194,17 @@ struct kvm_exit_snp_req_certs {
 #define KVM_EXIT_ARM_LDST64B      42
 #define KVM_EXIT_SNP_REQ_CERTS    43
 
+#ifdef CONFIG_KVM_DSM_IRQ_FORWARD
+/* DSM exit reason: distributed APIC region access */
+#define KVM_EXIT_DAPIC            44
+/* DSM exit reason: IPI forwarding to userspace */
+#define KVM_EXIT_DSM_SEND_IRQ     45
+/* DSM exit reason: X2APIC ICR write forwarding to userspace */
+#define KVM_EXIT_DSM_X2_ICR       46
+/* DSM exit reason: APIC base MSR write forwarding to userspace */
+#define KVM_EXIT_DSM_APIC_BASE    47
+#endif
+
 /* For KVM_EXIT_INTERNAL_ERROR */
 /* Emulate instruction failed. */
 #define KVM_INTERNAL_ERROR_EMULATION	1
@@ -243,7 +254,27 @@ struct kvm_run {
 	__u64 psw_addr; /* psw lower half */
 #endif
 	union {
-		/* KVM_EXIT_UNKNOWN */
+#ifdef CONFIG_KVM_DSM_IRQ_FORWARD
+		/* DSM IPI forwarding data (KVM_EXIT_DSM_SEND_IRQ) */
+		struct {
+			__u32 id;
+			__u32 val;
+			__u32 val2;
+			__u32 dest_id;
+		} lapic_irq;
+		/* DSM X2APIC write data (KVM_EXIT_DSM_X2APIC) */
+		struct {
+			__u32 id;
+			__u64 data;
+		} x2apic;
+		/* DSM APIC base write data (KVM_EXIT_DSM_APIC_BASE) */
+		struct {
+			__u32 id;
+			bool host;
+			__u32 index;
+			__u64 data;
+		} x2msr_base;
+#endif
 		struct {
 			__u64 hardware_exit_reason;
 		} hw;
-- 
2.43.0

