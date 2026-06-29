Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14AF7394797
	for <kvm@vger.kernel.org>; Mon, 29 Jun 2026 06:06:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782713186; cv=none; b=EFzbkY6RDsXQ1ctnTXl6bCem+RAdeHhUtj11WmR8pUfRvHgIOUvKpNXNzAuWyXuhjjyQ6EXSmhIwLTTScw7S7Cv1oO+uKlfcj/dssLSNgoY8PiMh3/L1LKlnsmgjj4KNYW+yuLp0xMRV18qy1oh692HShC41J/lOc+/t3sAPva4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782713186; c=relaxed/simple;
	bh=phg2XQItjNKrlp3CVEYwWnXy0k4ukjpYWgk5FyzbvtM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=m4GnqeCOBvvq1/L+e0lL/ca036ttC9SDYEWWKdIJlUacdzFjfuHsxaae+Y3qAXzZu/SO3vkDbU7vWExQEStkyri1j5RuTufN82lfvwe9tpFp72dPOj515eCOLgVBuX35ax0GlzZJn0TeWtFPpvnkGYtSWZ9HfOXEbZ3CUWeBte4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 8FE117599A;
	Mon, 29 Jun 2026 06:06:23 +0000 (UTC)
Authentication-Results: smtp-out2.suse.de;
	none
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 270E7779A8;
	Mon, 29 Jun 2026 06:06:23 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id pbgVCF8LQmruEQAAD6G6ig
	(envelope-from <jgross@suse.com>); Mon, 29 Jun 2026 06:06:23 +0000
From: Juergen Gross <jgross@suse.com>
To: linux-kernel@vger.kernel.org,
	x86@kernel.org,
	kvm@vger.kernel.org,
	linux-coco@lists.linux.dev
Cc: Juergen Gross <jgross@suse.com>,
	Sean Christopherson <seanjc@google.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Thomas Gleixner <tglx@kernel.org>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H. Peter Anvin" <hpa@zytor.com>,
	Kiryl Shutsemau <kas@kernel.org>,
	Rick Edgecombe <rick.p.edgecombe@intel.com>
Subject: [PATCH 09/32] KVM/x86: Stop using 32-bit MSR interfaces
Date: Mon, 29 Jun 2026 08:05:00 +0200
Message-ID: <20260629060526.3638272-10-jgross@suse.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260629060526.3638272-1-jgross@suse.com>
References: <20260629060526.3638272-1-jgross@suse.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Pre-Result: action=no action;
	module=replies;
	Message is reply to one we originated
X-Rspamd-Queue-Id: 8FE117599A
X-Spam-Flag: NO
X-Spam-Score: -4.00
X-Spam-Level: 
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Pre-Result: action=no action;
	module=replies;
	Message is reply to one we originated
X-Spamd-Result: default: False [-4.00 / 50.00];
	REPLY(-4.00)[]

The 32-bit MSR interfaces rdmsr(), wrmsr() and  rdmsr_safe() are
planned to be removed. Use the related 64-bit variants instead.

Signed-off-by: Juergen Gross <jgross@suse.com>
---
 arch/x86/kvm/vmx/vmx.c      | 24 +++++++++++++-----------
 arch/x86/kvm/x86.c          |  4 ++--
 arch/x86/virt/vmx/tdx/tdx.c |  6 ++++--
 3 files changed, 19 insertions(+), 15 deletions(-)

diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
index 2325be57d3d7..49948bbaf2de 100644
--- a/arch/x86/kvm/vmx/vmx.c
+++ b/arch/x86/kvm/vmx/vmx.c
@@ -2676,13 +2676,13 @@ static bool cpu_has_sgx(void)
 
 static int adjust_vmx_controls(u32 ctl_min, u32 ctl_opt, u32 msr, u32 *result)
 {
-	u32 vmx_msr_low, vmx_msr_high;
+	struct msr vmx_msr;
 	u32 ctl = ctl_min | ctl_opt;
 
-	rdmsr(msr, vmx_msr_low, vmx_msr_high);
+	rdmsrq(msr, vmx_msr.q);
 
-	ctl &= vmx_msr_high; /* bit == 0 in high word ==> must be zero */
-	ctl |= vmx_msr_low;  /* bit == 1 in low word  ==> must be one  */
+	ctl &= vmx_msr.h;  /* bit == 0 in high word ==> must be zero */
+	ctl |= vmx_msr.l;  /* bit == 1 in low word  ==> must be one  */
 
 	/* Ensure minimum (required) set of control bits are supported. */
 	if (ctl_min & ~ctl)
@@ -2738,6 +2738,7 @@ static int setup_vmcs_config(struct vmcs_config *vmcs_conf,
 	u64 _cpu_based_3rd_exec_control = 0;
 	u32 _vmexit_control = 0;
 	u32 _vmentry_control = 0;
+	struct msr val;
 	u64 basic_msr;
 	u64 misc_msr;
 
@@ -2787,8 +2788,9 @@ static int setup_vmcs_config(struct vmcs_config *vmcs_conf,
 				SECONDARY_EXEC_VIRTUALIZE_X2APIC_MODE |
 				SECONDARY_EXEC_VIRTUAL_INTR_DELIVERY);
 
-	rdmsr_safe(MSR_IA32_VMX_EPT_VPID_CAP,
-		&vmx_cap->ept, &vmx_cap->vpid);
+	rdmsrq_safe(MSR_IA32_VMX_EPT_VPID_CAP, &val.q);
+	vmx_cap->ept = val.l;
+	vmx_cap->vpid = val.h;
 
 	if (!(_cpu_based_2nd_exec_control & SECONDARY_EXEC_ENABLE_EPT) &&
 	    vmx_cap->ept) {
@@ -4435,7 +4437,7 @@ void vmx_deliver_interrupt(struct kvm_lapic *apic, int delivery_mode,
  */
 void vmx_set_constant_host_state(struct vcpu_vmx *vmx)
 {
-	u32 low32, high32;
+	struct msr val;
 	unsigned long tmpl;
 	unsigned long cr0, cr3, cr4;
 
@@ -4476,8 +4478,8 @@ void vmx_set_constant_host_state(struct vcpu_vmx *vmx)
 
 	vmcs_writel(HOST_RIP, (unsigned long)vmx_vmexit); /* 22.2.5 */
 
-	rdmsr(MSR_IA32_SYSENTER_CS, low32, high32);
-	vmcs_write32(HOST_IA32_SYSENTER_CS, low32);
+	rdmsrq(MSR_IA32_SYSENTER_CS, val.q);
+	vmcs_write32(HOST_IA32_SYSENTER_CS, val.l);
 
 	/*
 	 * SYSENTER is used for 32-bit system calls on either 32-bit or
@@ -4492,8 +4494,8 @@ void vmx_set_constant_host_state(struct vcpu_vmx *vmx)
 	vmcs_writel(HOST_IA32_SYSENTER_EIP, tmpl);   /* 22.2.3 */
 
 	if (vmcs_config.vmexit_ctrl & VM_EXIT_LOAD_IA32_PAT) {
-		rdmsr(MSR_IA32_CR_PAT, low32, high32);
-		vmcs_write64(HOST_IA32_PAT, low32 | ((u64) high32 << 32));
+		rdmsrq(MSR_IA32_CR_PAT, val.q);
+		vmcs_write64(HOST_IA32_PAT, val.q);
 	}
 
 	if (cpu_has_load_ia32_efer())
diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index afcac1042947..9b645563ece9 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -7633,9 +7633,9 @@ static void kvm_probe_feature_msr(u32 msr_index)
 
 static void kvm_probe_msr_to_save(u32 msr_index)
 {
-	u32 dummy[2];
+	u64 dummy;
 
-	if (rdmsr_safe(msr_index, &dummy[0], &dummy[1]))
+	if (rdmsrq_safe(msr_index, &dummy))
 		return;
 
 	/*
diff --git a/arch/x86/virt/vmx/tdx/tdx.c b/arch/x86/virt/vmx/tdx/tdx.c
index 42df8ea464c4..1b9ff749dd8e 100644
--- a/arch/x86/virt/vmx/tdx/tdx.c
+++ b/arch/x86/virt/vmx/tdx/tdx.c
@@ -1430,6 +1430,7 @@ static __init int record_keyid_partitioning(u32 *tdx_keyid_start,
 					    u32 *nr_tdx_keyids)
 {
 	u32 _nr_mktme_keyids, _tdx_keyid_start, _nr_tdx_keyids;
+	struct msr val;
 	int ret;
 
 	/*
@@ -1437,8 +1438,9 @@ static __init int record_keyid_partitioning(u32 *tdx_keyid_start,
 	 *   Bit [31:0]:	Number of MKTME KeyIDs.
 	 *   Bit [63:32]:	Number of TDX private KeyIDs.
 	 */
-	ret = rdmsr_safe(MSR_IA32_MKTME_KEYID_PARTITIONING, &_nr_mktme_keyids,
-			&_nr_tdx_keyids);
+	ret = rdmsrq_safe(MSR_IA32_MKTME_KEYID_PARTITIONING, &val.q);
+	_nr_mktme_keyids = val.l;
+	_nr_tdx_keyids = val.h;
 	if (ret || !_nr_tdx_keyids)
 		return -EINVAL;
 
-- 
2.54.0

