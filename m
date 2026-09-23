Received: from out28-3.mail.aliyun.com (out28-3.mail.aliyun.com [115.124.28.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73ADD535FA7;
	Wed, 23 Sep 2026 14:03:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.28.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790172189; cv=none; b=iL8a9GH4nvcuBDGhAmwqBI5a1nhDtQHmnM37CwoL0u7ZlUr64fcfzX8HY4Wv8Rny9RP3ikKR1aCiROmmSHLq9GlMyMbePeOUg1RYBn29JQqW93jE4xed+0fS5EuGatsK4K6fGJWuvy7p8L91HyyRiugTQTT/eY9Kmvex5zNNSlM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790172189; c=relaxed/simple;
	bh=Y94i4DVTmvOXfXhndTni7pFNA9nad6Unacl59U/v7E0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mvS3GAEwIbF5VWx849C7/A4HkDKSENLVA9zJJeWEIGWA0Yx9ikXeWwwZh7YryS0U9aSrTf6i5sqye93JKi/bDK6dYkX/F4O4DbqYeS+/IWYG4TKUD2TL7Xuh6+eSKeF5+mFXiEj5EBJlRFhqRTak0EWIWkwma30JSoTPFgJXoDg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=open-hieco.net; spf=pass smtp.mailfrom=open-hieco.net; arc=none smtp.client-ip=115.124.28.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=open-hieco.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=open-hieco.net
X-Alimail-AntiSpam:AC=CONTINUE;BC=0.07437167|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_regular_dialog|0.0051405-0.000603857-0.994256;FP=17213160270248751099|0|0|0|0|-1|-1|-1;HT=maildocker-contentspam011083013073;MF=zhang_wei@open-hieco.net;NM=1;PH=DS;RN=8;RT=8;SR=0;TI=SMTPD_---.jL9oyh7_1790172175;
Received: from localhost.localdomain(mailfrom:zhang_wei@open-hieco.net fp:SMTPD_---.jL9oyh7_1790172175 cluster:ay29)
          by smtp.aliyun-inc.com;
          Wed, 23 Sep 2026 22:02:55 +0800
From: Tina Zhang <zhang_wei@open-hieco.net>
To: Sean Christopherson <seanjc@google.com>,
	Jim Mattson <jmattson@google.com>,
	kvm@vger.kernel.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
	Shuah Khan <shuah@kernel.org>,
	zhouyanjing@hygon.cn,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v8 4/8] KVM: nSVM: Propagate hardware DecodeAssist bytes to VMCB12
Date: Wed, 23 Sep 2026 22:02:29 +0800
Message-ID: <867809464c5659328516196c65b0b2eb5a9bd9c7.1790171702.git.zhang_wei@open-hieco.net>
X-Mailer: git-send-email 2.43.7
In-Reply-To: <cover.1790171702.git.zhang_wei@open-hieco.net>
References: <cover.1790171702.git.zhang_wei@open-hieco.net>
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
Reviewed-by: Jim Mattson <jmattson@google.com>
---
 arch/x86/kvm/svm/nested.c | 37 +++++++++++++++++++++++++++++++++++++
 1 file changed, 37 insertions(+)

diff --git a/arch/x86/kvm/svm/nested.c b/arch/x86/kvm/svm/nested.c
index a87b88d8eeac..e839f61211c9 100644
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
@@ -1335,6 +1370,8 @@ static int nested_svm_vmexit_update_vmcb12(struct kvm_vcpu *vcpu)
 	if (guest_cpu_cap_has(vcpu, X86_FEATURE_NRIPS))
 		vmcb12->control.next_rip  = vmcb02->control.next_rip;
 
+	nested_svm_update_vmcb12_insn_bytes(vcpu, vmcb12, vmcb02);
+
 	if (nested_vmcb12_has_lbrv(vcpu))
 		svm_copy_lbrs(&vmcb12->save, &vmcb02->save);
 
-- 
2.43.7

