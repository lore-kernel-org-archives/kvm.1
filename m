Received: from out28-146.mail.aliyun.com (out28-146.mail.aliyun.com [115.124.28.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 405F42EEE9E;
	Tue, 14 Jul 2026 05:10:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.28.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784005851; cv=none; b=NiFa5oCnHy9EqpWPZsBPfl5el4gWzNlKe+saA7hOc/E8gaGtcX15bu4Xg/DlzqQUgSpNQCDfdKUtfxLcW/ImF6RAkapgClftN4ZQe42qSDrs95CAYSC1Rlggcs8Qy9E83Tcedo79IgV8+adcDwqg1Mih/uZ6ccTXHH3sqzvxnn8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784005851; c=relaxed/simple;
	bh=bjj33wySkv4V1fyTH1jdRrmoSvUQ3NreRObG2rTkofo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WXnGs2YfJ3TA8bY1tDXSWuY80eeOdanp4NPthbmkKt8Z1bug85f1pEOR60rlFCCgKB/qmxmXb7QBGT8RenYzqqgkX4PeAE7GKbeTcSgtyVFbUXMgTBPflGlcDrnhg6A2+ePI0B0AMi5mTOXVj4HKm4rhSVW/QZ316HVRvvMr2Tw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=open-hieco.net; spf=pass smtp.mailfrom=open-hieco.net; arc=none smtp.client-ip=115.124.28.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=open-hieco.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=open-hieco.net
X-Alimail-AntiSpam:AC=CONTINUE;BC=0.0743687|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_regular_dialog|0.00277275-0.000469179-0.996758;FP=12601192811204381883|1|1|1|0|-1|-1|-1;HT=maildocker-contentspam033045213054;MF=zhang_wei@open-hieco.net;NM=1;PH=DS;RN=9;RT=9;SR=0;TI=SMTPD_---.iKeOCaE_1784005837;
Received: from localhost.localdomain(mailfrom:zhang_wei@open-hieco.net fp:SMTPD_---.iKeOCaE_1784005837 cluster:ay29)
          by smtp.aliyun-inc.com;
          Tue, 14 Jul 2026 13:10:37 +0800
From: Tina Zhang <zhang_wei@open-hieco.net>
To: Sean Christopherson <seanjc@google.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	kvm@vger.kernel.org
Cc: Shuah Khan <shuah@kernel.org>,
	zhouyanjing@hygon.cn,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Jim Mattson <jmattson@google.com>,
	Tina Zhang <zhang_wei@open-hieco.net>
Subject: [PATCH v2 4/8] KVM: nSVM: Propagate hardware DecodeAssist bytes to VMCB12
Date: Tue, 14 Jul 2026 13:10:00 +0800
Message-ID: <fa4f6cd7845aa6bc86cce8547bddc3ec60a8684f.1783999988.git.zhang_wei@open-hieco.net>
X-Mailer: git-send-email 2.43.7
In-Reply-To: <cover.1783999988.git.zhang_wei@open-hieco.net>
References: <cover.1783999988.git.zhang_wei@open-hieco.net>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When DecodeAssists is exposed to L1, copy fresh hardware instruction
bytes from VMCB02 to VMCB12 for data #NPF and intercepted #PF VM-Exits.

Clear VMCB12's instruction-byte state for instruction-fetch faults,
unrelated exits, and exits without fresh VMCB02 state so that stale bytes
are not exposed to L1.

Signed-off-by: Tina Zhang <zhang_wei@open-hieco.net>
---
 arch/x86/kvm/svm/nested.c | 53 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 53 insertions(+)

diff --git a/arch/x86/kvm/svm/nested.c b/arch/x86/kvm/svm/nested.c
index 70e2ee3af78b..9e12eab7eed9 100644
--- a/arch/x86/kvm/svm/nested.c
+++ b/arch/x86/kvm/svm/nested.c
@@ -40,6 +40,57 @@ static void nested_svm_clear_insn_bytes(struct vmcb *vmcb)
 	       sizeof(vmcb->control.insn_bytes));
 }
 
+static void nested_svm_copy_insn_bytes(struct vmcb *to,
+				       const struct vmcb *from)
+{
+	u8 insn_len = from->control.insn_len;
+
+	nested_svm_clear_insn_bytes(to);
+
+	if (WARN_ON_ONCE(insn_len > sizeof(from->control.insn_bytes)))
+		return;
+
+	to->control.insn_len = insn_len;
+	memcpy(to->control.insn_bytes, from->control.insn_bytes, insn_len);
+}
+
+static bool nested_svm_vmexit_supports_insn_bytes(struct kvm_vcpu *vcpu,
+						  const struct vmcb *vmcb12)
+{
+	u64 exit_code = vmcb12->control.exit_code;
+
+	if (!guest_cpu_cap_has(vcpu, X86_FEATURE_DECODEASSISTS))
+		return false;
+
+	if (exit_code != SVM_EXIT_NPF &&
+	    exit_code != SVM_EXIT_EXCP_BASE + PF_VECTOR)
+		return false;
+
+	return !(vmcb12->control.exit_info_1 & PFERR_FETCH_MASK);
+}
+
+/*
+ * Rebuild VMCB12's DecodeAssist bytes for the nested VM-Exit.  Use fresh
+ * hardware VMCB02 state when available; otherwise report a zero byte count.
+ */
+static void nested_svm_update_vmcb12_insn_bytes(struct kvm_vcpu *vcpu,
+						struct vmcb *vmcb12,
+						struct vmcb *vmcb02)
+{
+	struct vcpu_svm *svm = to_svm(vcpu);
+	bool vmcb02_insn_bytes_fresh = svm->nested.vmcb02_insn_bytes_fresh;
+
+	svm->nested.vmcb02_insn_bytes_fresh = false;
+
+	nested_svm_clear_insn_bytes(vmcb12);
+
+	if (!nested_svm_vmexit_supports_insn_bytes(vcpu, vmcb12))
+		return;
+
+	if (vmcb02_insn_bytes_fresh)
+		nested_svm_copy_insn_bytes(vmcb12, vmcb02);
+}
+
 static void nested_svm_inject_npf_exit(struct kvm_vcpu *vcpu,
 				       struct x86_exception *fault)
 {
@@ -1263,6 +1314,8 @@ static int nested_svm_vmexit_update_vmcb12(struct kvm_vcpu *vcpu)
 	if (guest_cpu_cap_has(vcpu, X86_FEATURE_NRIPS))
 		vmcb12->control.next_rip  = vmcb02->control.next_rip;
 
+	nested_svm_update_vmcb12_insn_bytes(vcpu, vmcb12, vmcb02);
+
 	if (nested_vmcb12_has_lbrv(vcpu))
 		svm_copy_lbrs(&vmcb12->save, &vmcb02->save);
 
-- 
2.43.7

