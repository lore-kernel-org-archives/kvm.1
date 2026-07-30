Received: from out198-18.us.a.mail.aliyun.com (out198-18.us.a.mail.aliyun.com [47.90.198.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EC974248AE;
	Thu, 30 Jul 2026 12:09:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=47.90.198.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785413344; cv=none; b=EE7K/7oQYbxiWEd6cEOZxjkrY9ZRnmJPE1ZKuekdmgDl2jSLayXGqucjBV1y+5cEob3W1IquF8ZZ31y1SWA+1V3Z5WzySDefBzJPe7YnCcsPY0LQdlgDe10CFzB14lYjlDV7GCcK6tdF+RYL/524WLKw8Xh2LDY24nGS6xd+Pcs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785413344; c=relaxed/simple;
	bh=vCJWJUrb0OWwXkWGK1r2fY06v6ibFV9jvpLaYK8v7t8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DYbdBQfJcr+ZDYPFS2dOIj1QaxWfc6X+4HUskrmFQJ/ly2IzSwKMG+d/C5AL8w+HRMFl8jJWefjDkXWC6dR+UsdHk+dH0TW38CdRA374saDH1VC+K6hx/dAA6/9gbVp4hguK7N5Y6OYbrkEih1SOjsmLj2avzvFhKPsY7p1cOz4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=open-hieco.net; spf=pass smtp.mailfrom=open-hieco.net; arc=none smtp.client-ip=47.90.198.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=open-hieco.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=open-hieco.net
X-Alimail-AntiSpam:AC=CONTINUE;BC=0.07436951|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_regular_dialog|0.00567934-0.000846732-0.993474;FP=12601192811204390651|1|1|1|0|-1|-1|-1;HT=maildocker-contentspam033068005250;MF=zhang_wei@open-hieco.net;NM=1;PH=DS;RN=9;RT=9;SR=0;TI=SMTPD_---.iZWlrtM_1785413318;
Received: from localhost.localdomain(mailfrom:zhang_wei@open-hieco.net fp:SMTPD_---.iZWlrtM_1785413318 cluster:ay29)
          by smtp.aliyun-inc.com;
          Thu, 30 Jul 2026 20:08:39 +0800
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
Subject: [PATCH v3 4/9] KVM: nSVM: Propagate hardware DecodeAssist bytes to VMCB12
Date: Thu, 30 Jul 2026 20:08:07 +0800
Message-ID: <2a773f2704845f23145943ea227a50e4adc38ff8.1785411877.git.zhang_wei@open-hieco.net>
X-Mailer: git-send-email 2.43.7
In-Reply-To: <cover.1785411877.git.zhang_wei@open-hieco.net>
References: <cover.1785411877.git.zhang_wei@open-hieco.net>
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
 arch/x86/kvm/svm/nested.c | 49 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 49 insertions(+)

diff --git a/arch/x86/kvm/svm/nested.c b/arch/x86/kvm/svm/nested.c
index ce059d3a1322..5ad744ea668d 100644
--- a/arch/x86/kvm/svm/nested.c
+++ b/arch/x86/kvm/svm/nested.c
@@ -42,6 +42,53 @@ static void nested_svm_clear_insn_bytes(struct vmcb *vmcb)
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
+						  const struct vmcb *vmcb02)
+{
+	u64 exit_code = vmcb02->control.exit_code;
+
+	if (!guest_cpu_cap_has(vcpu, X86_FEATURE_DECODEASSISTS))
+		return false;
+
+	if (exit_code != SVM_EXIT_NPF &&
+	    exit_code != SVM_EXIT_EXCP_BASE + PF_VECTOR)
+		return false;
+
+	return !(vmcb02->control.exit_info_1 & PFERR_FETCH_MASK);
+}
+
+static void nested_svm_update_vmcb12_insn_bytes(struct kvm_vcpu *vcpu,
+						struct vmcb *vmcb12,
+						struct vmcb *vmcb02)
+{
+	struct vcpu_svm *svm = to_svm(vcpu);
+
+	nested_svm_clear_insn_bytes(vmcb12);
+
+	if (!nested_svm_vmexit_supports_insn_bytes(vcpu, vmcb02))
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
@@ -1311,6 +1358,8 @@ static int nested_svm_vmexit_update_vmcb12(struct kvm_vcpu *vcpu)
 	if (guest_cpu_cap_has(vcpu, X86_FEATURE_NRIPS))
 		vmcb12->control.next_rip  = vmcb02->control.next_rip;
 
+	nested_svm_update_vmcb12_insn_bytes(vcpu, vmcb12, vmcb02);
+
 	if (nested_vmcb12_has_lbrv(vcpu))
 		svm_copy_lbrs(&vmcb12->save, &vmcb02->save);
 
-- 
2.43.7

