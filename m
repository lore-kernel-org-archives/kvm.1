Received: from out28-147.mail.aliyun.com (out28-147.mail.aliyun.com [115.124.28.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93A743CAE73;
	Sun, 13 Sep 2026 06:44:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.28.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789281850; cv=none; b=HQDQuOS7UqlnZOpfQaUm60gGCdBSRUUeRsD9xUlBNcD3vzst7X9WjW3nz8hAhx0WgOBx4mL+3GLiGVDHkr9B+ylm50M/WdHA7I/ZdCcGY7GMO+7CDY2s7hLCAwbKfBRieGFcURFN0t2NUvyNc4cz39SoZg+V1xNBdODLKrOe+U0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789281850; c=relaxed/simple;
	bh=RWba314owZ9Uv8BnWcX3Nxln4T+NcIItSeFQNF3m61I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=W1ATtGbIEDDYbOfeKJswNoI+OOZZHI39D4zWIakIom+gdEBlXSqj0n+oTRMsX2YtGvhN0RKZ/EkGch/nRdc8Xy4JZ5Y7paNua/erxT/Uxm8i+XA5uMNG+8Ctu6txBXlki+sErKds+xgHIzKQYGaLYqw58kCyMYpkBqrsZUMfJs0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=open-hieco.net; spf=pass smtp.mailfrom=open-hieco.net; arc=none smtp.client-ip=115.124.28.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=open-hieco.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=open-hieco.net
X-Alimail-AntiSpam:AC=CONTINUE;BC=0.07436349|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_system_inform|0.00351209-0.000496702-0.995991;FP=16636718210716602107|1|1|1|0|-1|-1|-1;HT=maildocker-contentspam033037032089;MF=zhang_wei@open-hieco.net;NM=1;PH=DS;RN=8;RT=8;SR=0;TI=SMTPD_---.jCORvmi_1789281836;
Received: from localhost.localdomain(mailfrom:zhang_wei@open-hieco.net fp:SMTPD_---.jCORvmi_1789281836 cluster:ay29)
          by smtp.aliyun-inc.com;
          Sun, 13 Sep 2026 14:43:56 +0800
From: Tina Zhang <zhang_wei@open-hieco.net>
To: Sean Christopherson <seanjc@google.com>,
	Jim Mattson <jmattson@google.com>,
	kvm@vger.kernel.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
	Shuah Khan <shuah@kernel.org>,
	zhouyanjing@hygon.cn,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v6 3/8] KVM: nSVM: Track valid hardware DecodeAssist bytes
Date: Sun, 13 Sep 2026 14:43:43 +0800
Message-ID: <37a1f336c303c78bbf942b1babcde828899968f6.1789281096.git.zhang_wei@open-hieco.net>
X-Mailer: git-send-email 2.43.7
In-Reply-To: <cover.1789281096.git.zhang_wei@open-hieco.net>
References: <cover.1789281096.git.zhang_wei@open-hieco.net>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

VMCB02 instruction bytes are valid only for the hardware VM-Exit that
populated them.  Track whether VMCB02 contains instruction bytes for the
data #PF or #NPF currently being reflected to L1 so that stale bytes are
not copied to VMCB12.

Invalidate VMCB02's instruction-byte state when preparing VMCB02,
normally in response to an emulated VMRUN.  Mark the bytes as valid only
when the current VMCB02 exit is a data #PF or #NPF.  Opcode exits and
instruction-fetch faults are excluded by inspecting the exit state.

A subsequent change will use this state when propagating hardware
DecodeAssist instruction bytes to VMCB12.

Signed-off-by: Tina Zhang <zhang_wei@open-hieco.net>
---
 arch/x86/kvm/svm/nested.c | 38 +++++++++++++++++++++++++++++++++++++-
 arch/x86/kvm/svm/svm.h    |  3 +++
 2 files changed, 40 insertions(+), 1 deletion(-)

diff --git a/arch/x86/kvm/svm/nested.c b/arch/x86/kvm/svm/nested.c
index 73f37b050d0a..1cc3af8247f2 100644
--- a/arch/x86/kvm/svm/nested.c
+++ b/arch/x86/kvm/svm/nested.c
@@ -35,6 +35,35 @@
 
 #define CC KVM_NESTED_VMENTER_CONSISTENCY_CHECK
 
+static void nested_svm_invalidate_insn_bytes(struct vmcb *vmcb)
+{
+	vmcb->control.insn_len = 0;
+}
+
+static bool nested_svm_vmexit_supports_insn_bytes(const struct vmcb *vmcb)
+{
+	u64 exit_code = vmcb->control.exit_code;
+
+	if (exit_code != SVM_EXIT_NPF &&
+	    exit_code != SVM_EXIT_EXCP_BASE + PF_VECTOR)
+		return false;
+
+	return !(vmcb->control.exit_info_1 & PFERR_FETCH_MASK);
+}
+
+static void nested_svm_set_vmcb02_insn_bytes_valid(struct vcpu_svm *svm)
+{
+	svm->nested.vmcb02_insn_bytes_valid =
+		static_cpu_has(X86_FEATURE_DECODEASSISTS) &&
+		nested_svm_vmexit_supports_insn_bytes(svm->nested.vmcb02.ptr);
+}
+
+static void nested_svm_invalidate_vmcb02_insn_bytes(struct vcpu_svm *svm)
+{
+	nested_svm_invalidate_insn_bytes(svm->nested.vmcb02.ptr);
+	svm->nested.vmcb02_insn_bytes_valid = false;
+}
+
 static void nested_svm_inject_npf_exit(struct kvm_vcpu *vcpu,
 				       struct x86_exception *fault,
 				       bool from_hardware)
@@ -68,6 +97,10 @@ static void nested_svm_inject_npf_exit(struct kvm_vcpu *vcpu,
 				    (fault->error_code & ~PFERR_GUEST_FAULT_STAGE_MASK);
 	vmcb->control.exit_info_2 = fault->address;
 
+	if (from_hardware)
+		nested_svm_set_vmcb02_insn_bytes_valid(svm);
+	else
+		svm->nested.vmcb02_insn_bytes_valid = false;
 	nested_svm_vmexit(svm);
 }
 
@@ -869,6 +902,7 @@ static void nested_vmcb02_prepare_control(struct vcpu_svm *svm)
 	 * Filled at exit: exit_code, exit_info_1, exit_info_2, exit_int_info,
 	 * exit_int_info_err, next_rip, insn_len, insn_bytes.
 	 */
+	nested_svm_invalidate_vmcb02_insn_bytes(svm);
 
 	if (guest_cpu_cap_has(vcpu, X86_FEATURE_VGIF) &&
 	    (vmcb12_ctrl->int_ctl & V_GIF_ENABLE_MASK))
@@ -1649,8 +1683,10 @@ int nested_svm_exit_handled(struct vcpu_svm *svm)
 
 	vmexit = nested_svm_intercept(svm);
 
-	if (vmexit == NESTED_EXIT_DONE)
+	if (vmexit == NESTED_EXIT_DONE) {
+		nested_svm_set_vmcb02_insn_bytes_valid(svm);
 		nested_svm_vmexit(svm);
+	}
 
 	return vmexit;
 }
diff --git a/arch/x86/kvm/svm/svm.h b/arch/x86/kvm/svm/svm.h
index e958943b8162..1e12ef1105c0 100644
--- a/arch/x86/kvm/svm/svm.h
+++ b/arch/x86/kvm/svm/svm.h
@@ -243,6 +243,9 @@ struct svm_nested_state {
 	 * on its side.
 	 */
 	bool force_msr_bitmap_recalc;
+
+	/* True if VMCB02 has instruction bytes for the current nested exit. */
+	bool vmcb02_insn_bytes_valid;
 };
 
 struct vcpu_sev_es_state {
-- 
2.43.7

