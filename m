Received: from out28-221.mail.aliyun.com (out28-221.mail.aliyun.com [115.124.28.221])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00C9C402453;
	Mon, 29 Jun 2026 12:52:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.28.221
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782737552; cv=none; b=VzgoFije1aFA1cAQmIpL6IPirBV0RNiNAeZeRmP3uX92YyByKZhyabEuAzSaPvSvIf8yfMPpNKr7DcNpn1EZgqLlYdpx09hrPQADtrPOiE9rHDDGFNm5PhdGXX4kZaE44eI5vP2zPvHxY8s8/HwVrdWeF3BM4A/1Bic1OVovwu0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782737552; c=relaxed/simple;
	bh=gff3RsnB8GN2QYEdD6g1t+yshP46mb/BFqUXFY3MN6s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=E24Gks6edoc0n1dI94+F2p8ZtUFN32Ax/gpcrzV10zb/N181OHzMEgmKqSQrRyScLzisfftLJbqJwwc5oeXY7NeRqnw2oBxjT5XPIzWchI+VEc/3VX6uBZvua2Z1CB7GQPRx8U4k1G6kUR1GNeBR3z7MJC2P74ue/EQokpzEaAk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=open-hieco.net; spf=pass smtp.mailfrom=open-hieco.net; arc=none smtp.client-ip=115.124.28.221
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=open-hieco.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=open-hieco.net
X-Alimail-AntiSpam:AC=CONTINUE;BC=0.0746412|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_alarm|0.00200947-0.00103341-0.996957;FP=12567415814603082931|0|0|0|0|-1|-1|-1;HT=maildocker-contentspam033068016216;MF=zhang_wei@open-hieco.net;NM=1;PH=DS;RN=7;RT=7;SR=0;TI=SMTPD_---.i8gsqKP_1782737534;
Received: from tina-home.taild49858.ts.net(mailfrom:zhang_wei@open-hieco.net fp:SMTPD_---.i8gsqKP_1782737534 cluster:ay29)
          by smtp.aliyun-inc.com;
          Mon, 29 Jun 2026 20:52:17 +0800
From: Tina Zhang <zhang_wei@open-hieco.net>
To: Sean Christopherson <seanjc@google.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	kvm@vger.kernel.org
Cc: Shuah Khan <shuah@kernel.org>,
	zhouyanjing@hygon.cn,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] KVM: nSVM: Virtualize DecodeAssists for nested guests
Date: Mon, 29 Jun 2026 20:52:04 +0800
Message-ID: <20260629125205.52394-2-zhang_wei@open-hieco.net>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260629125205.52394-1-zhang_wei@open-hieco.net>
References: <20260629125205.52394-1-zhang_wei@open-hieco.net>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hardware records DecodeAssist information, i.e. the instruction length and
bytes, in the VMCB for exits such as #NPF.  KVM does not currently expose
that information when an L2 exit is reflected to L1, so a nested hypervisor
cannot consume the hardware-provided decode state and may need to fetch and
decode the L2 instruction itself.

Advertise DecodeAssists to L1 when the host supports it, and copy
insn_len/insn_bytes from VMCB02 to VMCB12 for nested VM-Exits that
reflect a real hardware exit.  Gate the copy on L1's guest CPUID so the
advertised feature and the propagated state stay in sync.

Report decode information only for exits that actually have fresh hardware
state.  KVM synthesizes several nested VM-Exits, e.g. VMRUN failures,
synthetic #NPF exits, reflected exceptions, and interrupt/NMI windows, that
do not carry VMCB02 DecodeAssist output.  Track only the verbatim VMCB02
reflection path with nested.decode_assists_valid, clear VMCB02's decode
fields before VMRUN, and clear VMCB12's fields for ineligible exits.  Use
insn_len == 0 to tell L1 that no decode information is available, and avoid
exposing stale bytes from a previous L2 exit.

Tested-by: Yongwei Xu <xuyongwei@hygon.cn>
Signed-off-by: Tina Zhang <zhang_wei@open-hieco.net>
---
 arch/x86/kvm/svm/nested.c | 47 ++++++++++++++++++++++++++++++++++++++-
 arch/x86/kvm/svm/svm.c    |  3 +++
 arch/x86/kvm/svm/svm.h    |  6 +++++
 3 files changed, 55 insertions(+), 1 deletion(-)

diff --git a/arch/x86/kvm/svm/nested.c b/arch/x86/kvm/svm/nested.c
index b340dc9991ad..50e9ffa5f9fd 100644
--- a/arch/x86/kvm/svm/nested.c
+++ b/arch/x86/kvm/svm/nested.c
@@ -33,6 +33,33 @@
 
 #define CC KVM_NESTED_VMENTER_CONSISTENCY_CHECK
 
+static void nested_svm_clear_decode_assists(struct vmcb *vmcb)
+{
+	vmcb->control.insn_len = 0;
+	memset(vmcb->control.insn_bytes, 0,
+	       sizeof(vmcb->control.insn_bytes));
+}
+
+static void nested_svm_copy_decode_assists(struct vmcb *to, struct vmcb *from)
+{
+	u8 insn_len = from->control.insn_len;
+
+	nested_svm_clear_decode_assists(to);
+
+	/*
+	 * Hardware leaves insn_len zero when no DecodeAssist data is available.
+	 * Keep that as the nested-visible "no decode info" marker.
+	 */
+	if (!insn_len)
+		return;
+
+	if (WARN_ON_ONCE(insn_len > sizeof(from->control.insn_bytes)))
+		return;
+
+	to->control.insn_len = insn_len;
+	memcpy(to->control.insn_bytes, from->control.insn_bytes, insn_len);
+}
+
 static void nested_svm_inject_npf_exit(struct kvm_vcpu *vcpu,
 				       struct x86_exception *fault)
 {
@@ -838,7 +865,10 @@ static void nested_vmcb02_prepare_control(struct vcpu_svm *svm)
 	/*
 	 * Filled at exit: exit_code, exit_info_1, exit_info_2, exit_int_info,
 	 * exit_int_info_err, next_rip, insn_len, insn_bytes.
+	 * Clear stale DecodeAssist data before L2 runs.
 	 */
+	nested_svm_clear_decode_assists(vmcb02);
+	svm->nested.decode_assists_valid = false;
 
 	if (guest_cpu_cap_has(vcpu, X86_FEATURE_VGIF) &&
 	    (vmcb12_ctrl->int_ctl & V_GIF_ENABLE_MASK))
@@ -1251,6 +1281,18 @@ static int nested_svm_vmexit_update_vmcb12(struct kvm_vcpu *vcpu)
 	if (guest_cpu_cap_has(vcpu, X86_FEATURE_NRIPS))
 		vmcb12->control.next_rip  = vmcb02->control.next_rip;
 
+	/*
+	 * Copy DecodeAssist data only for real VMCB02 exits.  KVM-synthesized
+	 * exits report no decode info to L1.
+	 */
+	if (svm->nested.decode_assists_valid &&
+	    guest_cpu_cap_has(vcpu, X86_FEATURE_DECODEASSISTS))
+		nested_svm_copy_decode_assists(vmcb12, vmcb02);
+	else
+		nested_svm_clear_decode_assists(vmcb12);
+
+	svm->nested.decode_assists_valid = false;
+
 	if (nested_vmcb12_has_lbrv(vcpu))
 		svm_copy_lbrs(&vmcb12->save, &vmcb02->save);
 
@@ -1593,8 +1635,11 @@ int nested_svm_exit_handled(struct vcpu_svm *svm)
 
 	vmexit = nested_svm_intercept(svm);
 
-	if (vmexit == NESTED_EXIT_DONE)
+	if (vmexit == NESTED_EXIT_DONE) {
+		/* This path reflects a real VMCB02 exit directly to L1. */
+		svm->nested.decode_assists_valid = true;
 		nested_svm_vmexit(svm);
+	}
 
 	return vmexit;
 }
diff --git a/arch/x86/kvm/svm/svm.c b/arch/x86/kvm/svm/svm.c
index e02a38da5296..366e7ef787b2 100644
--- a/arch/x86/kvm/svm/svm.c
+++ b/arch/x86/kvm/svm/svm.c
@@ -5470,6 +5470,9 @@ static __init void svm_set_cpu_caps(void)
 		 */
 		kvm_cpu_cap_set(X86_FEATURE_FLUSHBYASID);
 
+		if (boot_cpu_has(X86_FEATURE_DECODEASSISTS))
+			kvm_cpu_cap_set(X86_FEATURE_DECODEASSISTS);
+
 		if (nrips)
 			kvm_cpu_cap_set(X86_FEATURE_NRIPS);
 
diff --git a/arch/x86/kvm/svm/svm.h b/arch/x86/kvm/svm/svm.h
index 5137416be593..be7fdcd124b7 100644
--- a/arch/x86/kvm/svm/svm.h
+++ b/arch/x86/kvm/svm/svm.h
@@ -238,6 +238,12 @@ struct svm_nested_state {
 	 * on its side.
 	 */
 	bool force_msr_bitmap_recalc;
+
+	/*
+	 * True only while reflecting a real VMCB02 exit whose DecodeAssist
+	 * fields may be copied to VMCB12.  KVM-synthesized exits leave it clear.
+	 */
+	bool decode_assists_valid;
 };
 
 struct vcpu_sev_es_state {
-- 
2.43.0

