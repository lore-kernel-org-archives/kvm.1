Received: from out28-170.mail.aliyun.com (out28-170.mail.aliyun.com [115.124.28.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D70C4356750;
	Sun, 13 Sep 2026 06:49:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.28.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789282170; cv=none; b=mVecCz8TwNU3SZySHJDCAFosIW4a8ALf4gLVr/PRaZs5ztb7OG9m8tFkVguuxQUDytBW4gGh3HSQgZ46Lx59w6iwd6N2+X2VTvSsaipYvF2jAPPRnQU9X+sEfYE/OusCakYbttH7q8Wfb7km/KL+EaSNYfIBeorqTyTCzeOVDAA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789282170; c=relaxed/simple;
	bh=7x8QtBB+wiJGB2umB5DHjOZqtLJRzkfYQIEWVdSP8j8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FTiH5KyJDQXpQLICIqFMpEEKCmRBCoCLogFSMpOKwIs/+dnmapB1Se8FQ5a7FZmuMpKAUlRdFHcoWIE8NTsuDhcwXuU/i1S87sSJwS1FB7QCZwYFmc72LQBFKRULTD27QVAPNNLmEbUHTwML8DEUWfenz7FPcYBCaTa27uN4CdI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=open-hieco.net; spf=pass smtp.mailfrom=open-hieco.net; arc=none smtp.client-ip=115.124.28.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=open-hieco.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=open-hieco.net
X-Alimail-AntiSpam:AC=CONTINUE;BC=0.0743695|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_regular_dialog|0.00574879-0.000771639-0.99348;FP=12601474251787808763|1|1|1|0|-1|-1|-1;HT=maildocker-contentspam033032053168;MF=zhang_wei@open-hieco.net;NM=1;PH=DS;RN=8;RT=8;SR=0;TI=SMTPD_---.jCORvnL_1789281837;
Received: from localhost.localdomain(mailfrom:zhang_wei@open-hieco.net fp:SMTPD_---.jCORvnL_1789281837 cluster:ay29)
          by smtp.aliyun-inc.com;
          Sun, 13 Sep 2026 14:43:57 +0800
From: Tina Zhang <zhang_wei@open-hieco.net>
To: Sean Christopherson <seanjc@google.com>,
	Jim Mattson <jmattson@google.com>,
	kvm@vger.kernel.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
	Shuah Khan <shuah@kernel.org>,
	zhouyanjing@hygon.cn,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v6 4/8] KVM: nSVM: Propagate hardware DecodeAssist bytes to VMCB12
Date: Sun, 13 Sep 2026 14:43:44 +0800
Message-ID: <40f8ac084021e48fbadd5697ef16f674554a4480.1789281096.git.zhang_wei@open-hieco.net>
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

DecodeAssists provides instruction bytes for nested page faults and
intercepted page faults caused by data accesses.  When the feature is
exposed to L1, copy fresh hardware-provided instruction bytes from VMCB02
to VMCB12 for these exits.

Leave the VMCB12 instruction-byte state untouched when DecodeAssists is
not exposed.  Otherwise, invalidate the state for instruction-fetch page
faults, unrelated exits, and exits without fresh hardware bytes.

Signed-off-by: Tina Zhang <zhang_wei@open-hieco.net>
---
 arch/x86/kvm/svm/nested.c | 37 +++++++++++++++++++++++++++++++++++++
 1 file changed, 37 insertions(+)

diff --git a/arch/x86/kvm/svm/nested.c b/arch/x86/kvm/svm/nested.c
index 1cc3af8247f2..fba230058870 100644
--- a/arch/x86/kvm/svm/nested.c
+++ b/arch/x86/kvm/svm/nested.c
@@ -40,6 +40,20 @@ static void nested_svm_invalidate_insn_bytes(struct vmcb *vmcb)
 	vmcb->control.insn_len = 0;
 }
 
+static void nested_svm_copy_insn_bytes(struct vmcb *to,
+				       const struct vmcb *from)
+{
+	u8 insn_len = from->control.insn_len;
+
+	if (WARN_ON_ONCE(insn_len > sizeof(from->control.insn_bytes))) {
+		nested_svm_invalidate_insn_bytes(to);
+		return;
+	}
+
+	memcpy(to->control.insn_bytes, from->control.insn_bytes, insn_len);
+	to->control.insn_len = insn_len;
+}
+
 static bool nested_svm_vmexit_supports_insn_bytes(const struct vmcb *vmcb)
 {
 	u64 exit_code = vmcb->control.exit_code;
@@ -64,6 +78,27 @@ static void nested_svm_invalidate_vmcb02_insn_bytes(struct vcpu_svm *svm)
 	svm->nested.vmcb02_insn_bytes_valid = false;
 }
 
+static void nested_svm_update_vmcb12_insn_bytes(struct kvm_vcpu *vcpu,
+						struct vmcb *vmcb12,
+						const struct vmcb *vmcb02)
+{
+	struct vcpu_svm *svm = to_svm(vcpu);
+
+	if (!guest_cpu_cap_has(vcpu, X86_FEATURE_DECODEASSISTS))
+		goto out;
+
+	if (!nested_svm_vmexit_supports_insn_bytes(vmcb02) ||
+	    !svm->nested.vmcb02_insn_bytes_valid) {
+		nested_svm_invalidate_insn_bytes(vmcb12);
+		goto out;
+	}
+
+	nested_svm_copy_insn_bytes(vmcb12, vmcb02);
+
+out:
+	svm->nested.vmcb02_insn_bytes_valid = false;
+}
+
 static void nested_svm_inject_npf_exit(struct kvm_vcpu *vcpu,
 				       struct x86_exception *fault,
 				       bool from_hardware)
@@ -1331,6 +1366,8 @@ static int nested_svm_vmexit_update_vmcb12(struct kvm_vcpu *vcpu)
 	if (guest_cpu_cap_has(vcpu, X86_FEATURE_NRIPS))
 		vmcb12->control.next_rip  = vmcb02->control.next_rip;
 
+	nested_svm_update_vmcb12_insn_bytes(vcpu, vmcb12, vmcb02);
+
 	if (nested_vmcb12_has_lbrv(vcpu))
 		svm_copy_lbrs(&vmcb12->save, &vmcb02->save);
 
-- 
2.43.7

