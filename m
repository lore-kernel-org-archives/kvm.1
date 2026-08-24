Received: from out28-98.mail.aliyun.com (out28-98.mail.aliyun.com [115.124.28.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9526F41D106;
	Mon, 24 Aug 2026 12:40:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.28.98
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787575237; cv=none; b=gNX/VMSHo+U/lrMzZV4/hD09pYIqhZYf7Ntm00vBqSoXFOwQ2Y/3HQKxfWgygfW6NskoaQylXQVr4CMaigyCkAlO+lZspvQgN9ikfJDTlRZmjTSJi9TZZrHnpST5pzvrPpli88vWJwHabCVMp0MzOi3w5Nu3FFMDifBeVVp1L/Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787575237; c=relaxed/simple;
	bh=wDy/Py089/L7PFM09ZV1p73EN303ObxO58eeY3f9z3k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ROiY7OcCg5D/RHd3lhqw3UxRHZyt31UTbc9L48MwGiApeWHNE5zFE/VsZ5yRmz5WMtGijkTkulnyUM+BDn/SUDC5jqQ1ND3M92nfuFFqmGMOfMkjT13NKbReQnY8Rv1B76Kg5jABNx3TOCxwDeR6KqAWewgvzGxDOsUlpSzIMGY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=open-hieco.net; spf=pass smtp.mailfrom=open-hieco.net; arc=none smtp.client-ip=115.124.28.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=open-hieco.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=open-hieco.net
X-Alimail-AntiSpam:AC=CONTINUE;BC=0.07436831|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_regular_dialog|0.00510203-0.00091654-0.993981;FP=13826171909849165819|1|1|1|0|-1|-1|-1;HT=maildocker-contentspam033037026024;MF=zhang_wei@open-hieco.net;NM=1;PH=DS;RN=9;RT=9;SR=0;TI=SMTPD_---.iw1gh3c_1787575230;
Received: from localhost.localdomain(mailfrom:zhang_wei@open-hieco.net fp:SMTPD_---.iw1gh3c_1787575230 cluster:ay29)
          by smtp.aliyun-inc.com;
          Mon, 24 Aug 2026 20:40:31 +0800
From: Tina Zhang <zhang_wei@open-hieco.net>
To: Sean Christopherson <seanjc@google.com>,
	Jim Mattson <jmattson@google.com>,
	kvm@vger.kernel.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
	Shuah Khan <shuah@kernel.org>,
	zhouyanjing@hygon.cn,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Tina Zhang <zhang_wei@open-hieco.net>
Subject: [PATCH v5 4/8] KVM: nSVM: Propagate hardware DecodeAssist bytes to VMCB12
Date: Mon, 24 Aug 2026 20:39:50 +0800
Message-ID: <20260824123954.315112-5-zhang_wei@open-hieco.net>
X-Mailer: git-send-email 2.43.7
In-Reply-To: <20260824123954.315112-1-zhang_wei@open-hieco.net>
References: <20260824123954.315112-1-zhang_wei@open-hieco.net>
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

Clear the VMCB12 instruction-byte state before rebuilding it, and leave the
length zero for instruction-fetch page faults, unrelated exits, and exits
without fresh hardware bytes.

Signed-off-by: Tina Zhang <zhang_wei@open-hieco.net>
---
 arch/x86/kvm/svm/nested.c | 35 +++++++++++++++++++++++++++++++++++
 1 file changed, 35 insertions(+)

diff --git a/arch/x86/kvm/svm/nested.c b/arch/x86/kvm/svm/nested.c
index 6770721d4e4c..2db0ec66e8dc 100644
--- a/arch/x86/kvm/svm/nested.c
+++ b/arch/x86/kvm/svm/nested.c
@@ -42,6 +42,20 @@ static void nested_svm_clear_insn_bytes(struct vmcb *vmcb)
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
 static bool nested_svm_vmexit_has_insn_bytes(const struct vmcb *vmcb)
 {
 	u64 exit_code = vmcb->control.exit_code;
@@ -67,6 +81,25 @@ static void nested_svm_clear_vmcb02_insn_bytes(struct vcpu_svm *svm)
 	svm->nested.vmcb02_insn_bytes_fresh = false;
 }
 
+static void nested_svm_update_vmcb12_insn_bytes(struct kvm_vcpu *vcpu,
+						struct vmcb *vmcb12,
+						const struct vmcb *vmcb02)
+{
+	struct vcpu_svm *svm = to_svm(vcpu);
+
+	nested_svm_clear_insn_bytes(vmcb12);
+
+	if (!guest_cpu_cap_has(vcpu, X86_FEATURE_DECODEASSISTS) ||
+	    !nested_svm_vmexit_has_insn_bytes(vmcb02))
+		goto out;
+
+	if (svm->nested.vmcb02_insn_bytes_fresh)
+		nested_svm_copy_insn_bytes(vmcb12, vmcb02);
+
+out:
+	svm->nested.vmcb02_insn_bytes_fresh = false;
+}
+
 static void nested_svm_inject_npf_exit(struct kvm_vcpu *vcpu,
 				       struct x86_exception *fault,
 				       bool from_hardware)
@@ -1332,6 +1365,8 @@ static int nested_svm_vmexit_update_vmcb12(struct kvm_vcpu *vcpu)
 	if (guest_cpu_cap_has(vcpu, X86_FEATURE_NRIPS))
 		vmcb12->control.next_rip  = vmcb02->control.next_rip;
 
+	nested_svm_update_vmcb12_insn_bytes(vcpu, vmcb12, vmcb02);
+
 	if (nested_vmcb12_has_lbrv(vcpu))
 		svm_copy_lbrs(&vmcb12->save, &vmcb02->save);
 
-- 
2.43.7

