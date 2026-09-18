Received: from out28-219.mail.aliyun.com (out28-219.mail.aliyun.com [115.124.28.219])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F96B4B0E42;
	Fri, 18 Sep 2026 08:56:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.28.219
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789721805; cv=none; b=cscZL8OPDzQ0ahFA6SjCNrCiGj2jyGZMjT4qNJEZXwufnALqX2+GlxXvSS3INk0iHSo9YSnLHuD13JTh06eSEB9kUHBh0Y14f4U2mbZ7DroCz69wmN0oWJxvAAlUnDs4bHjAgGfIzsJ2fpKjf6JtutUEiAXUlJfGlc5YrjIjK9o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789721805; c=relaxed/simple;
	bh=GGrBd1JPod5b8wirbHV8e2EzhGSyqSsABh+ZvLK9UTg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VnU0einMjHuRyHzziK89hzVOyTNZ0aH/WDcLDxup4kfcE23ob9TdNs2UN9ybAaTg7TO2IL6D7D93QyUzFJ1J0W/F9Gq/Xgxrnmr19avVJko/SDsYjH9e3oILn6C2ssExh8SVOQeRW6K5t7s5GDlVq1B1/a98Rl3A8QXaI/VEqWQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=open-hieco.net; spf=pass smtp.mailfrom=open-hieco.net; arc=none smtp.client-ip=115.124.28.219
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=open-hieco.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=open-hieco.net
X-Alimail-AntiSpam:AC=CONTINUE;BC=0.0743626|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_alarm|0.00461945-0.000697874-0.994683;FP=16889411511807332083|1|1|1|0|-1|-1|-1;HT=maildocker-contentspam011083013073;MF=zhang_wei@open-hieco.net;NM=1;PH=DS;RN=8;RT=8;SR=0;TI=SMTPD_---.jGgS5Rg_1789721789;
Received: from localhost.localdomain(mailfrom:zhang_wei@open-hieco.net fp:SMTPD_---.jGgS5Rg_1789721789 cluster:ay29)
          by smtp.aliyun-inc.com;
          Fri, 18 Sep 2026 16:56:30 +0800
From: Tina Zhang <zhang_wei@open-hieco.net>
To: Sean Christopherson <seanjc@google.com>,
	Jim Mattson <jmattson@google.com>,
	kvm@vger.kernel.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
	Shuah Khan <shuah@kernel.org>,
	zhouyanjing@hygon.cn,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v7 6/8] KVM: nSVM: Use emulator bytes for synthesized nested #NPF
Date: Fri, 18 Sep 2026 16:56:16 +0800
Message-ID: <95301258748704c6b63664015ea18d3632739256.1789721173.git.zhang_wei@open-hieco.net>
X-Mailer: git-send-email 2.43.7
In-Reply-To: <cover.1789721173.git.zhang_wei@open-hieco.net>
References: <cover.1789721173.git.zhang_wei@open-hieco.net>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Preserve the bytes used by the emulator when synthesizing a data #NPF.
Reuse the fetch cache only when the fault is the current emulator
exception, identified by fault == &ctxt->exception.

Add an emulator accessor to copy cached instruction bytes, checking
the RIP and cache bounds.  These checks alone do not establish that
the cache belongs to the current emulation.

Write the cached bytes directly to VMCB02 and fetch any missing tail
through the instruction-fetch helper.  If the tail cannot be read,
report only the bytes already available.  For SEV guests, retain only
the cached bytes because KVM cannot fetch plaintext guest instructions.

Signed-off-by: Tina Zhang <zhang_wei@open-hieco.net>
Reviewed-by: Jim Mattson <jmattson@gmail.com>
---
 arch/x86/kvm/emulate.c     | 22 ++++++++++++++++++++++
 arch/x86/kvm/kvm_emulate.h |  3 +++
 arch/x86/kvm/svm/nested.c  | 36 ++++++++++++++++++++++++++++++++++--
 3 files changed, 59 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kvm/emulate.c b/arch/x86/kvm/emulate.c
index 2972a35b0ac0..0e67e70f7b70 100644
--- a/arch/x86/kvm/emulate.c
+++ b/arch/x86/kvm/emulate.c
@@ -900,6 +900,28 @@ static __always_inline int do_insn_fetch_bytes(struct x86_emulate_ctxt *ctxt,
 		return X86EMUL_CONTINUE;
 }
 
+/*
+ * The caller is responsible for ensuring that the fetch cache belongs to
+ * the current instruction.  Matching EIP alone does not guarantee this.
+ */
+unsigned int x86_emulator_copy_insn_bytes(struct x86_emulate_ctxt *ctxt,
+					  unsigned long eip, u8 *bytes,
+					  unsigned int max_bytes)
+{
+	unsigned int nr_bytes;
+
+	if (!ctxt || ctxt->eip != eip ||
+	    ctxt->fetch.end < ctxt->fetch.data ||
+	    ctxt->fetch.end > ctxt->fetch.data + sizeof(ctxt->fetch.data))
+		return 0;
+
+	nr_bytes = min_t(unsigned int, ctxt->fetch.end - ctxt->fetch.data,
+			 max_bytes);
+	memcpy(bytes, ctxt->fetch.data, nr_bytes);
+	return nr_bytes;
+}
+EXPORT_SYMBOL_FOR_KVM_INTERNAL(x86_emulator_copy_insn_bytes);
+
 /* Fetch next part of the instruction being emulated. */
 #define insn_fetch(_type, _ctxt)					\
 ({	_type _x;							\
diff --git a/arch/x86/kvm/kvm_emulate.h b/arch/x86/kvm/kvm_emulate.h
index d05558ef28ae..5361d42e6e05 100644
--- a/arch/x86/kvm/kvm_emulate.h
+++ b/arch/x86/kvm/kvm_emulate.h
@@ -528,6 +528,9 @@ enum x86_intercept {
 };
 
 int x86_decode_insn(struct x86_emulate_ctxt *ctxt, void *insn, int insn_len, int emulation_type);
+unsigned int x86_emulator_copy_insn_bytes(struct x86_emulate_ctxt *ctxt,
+					  unsigned long eip, u8 *bytes,
+					  unsigned int max_bytes);
 bool x86_page_table_writing_insn(struct x86_emulate_ctxt *ctxt);
 #define EMULATION_FAILED -1
 #define EMULATION_OK 0
diff --git a/arch/x86/kvm/svm/nested.c b/arch/x86/kvm/svm/nested.c
index c17df8c2e75f..1d3086eb08b7 100644
--- a/arch/x86/kvm/svm/nested.c
+++ b/arch/x86/kvm/svm/nested.c
@@ -93,13 +93,40 @@ static u8 nested_svm_get_insn_bytes_len(struct kvm_vcpu *vcpu, u8 max_bytes)
 }
 
 static u8 nested_svm_fetch_insn_bytes(struct kvm_vcpu *vcpu, u8 *bytes,
-				      u8 max_bytes)
+				      u8 count, u8 max_bytes)
 {
 	gva_t rip = kvm_get_linear_rip(vcpu);
 
 	max_bytes = nested_svm_get_insn_bytes_len(vcpu, max_bytes);
+	count = min(count, max_bytes);
 
-	return kvm_fetch_guest_virt(vcpu, rip, bytes, max_bytes);
+	return count + kvm_fetch_guest_virt(vcpu, rip + count, bytes + count,
+					   max_bytes - count);
+}
+
+static void nested_svm_prepare_synthesized_insn_bytes(struct kvm_vcpu *vcpu)
+{
+	struct vcpu_svm *svm = to_svm(vcpu);
+	struct vmcb *vmcb02 = svm->nested.vmcb02.ptr;
+	struct x86_emulate_ctxt *ctxt = vcpu->arch.emulate_ctxt;
+	u8 max_bytes = sizeof(vmcb02->control.insn_bytes);
+	u8 count;
+
+	nested_svm_invalidate_vmcb02_insn_bytes(svm);
+
+	if (!guest_cpu_cap_has(vcpu, X86_FEATURE_DECODEASSISTS))
+		return;
+
+	max_bytes = nested_svm_get_insn_bytes_len(vcpu, max_bytes);
+	count = x86_emulator_copy_insn_bytes(ctxt, kvm_rip_read(vcpu),
+					     vmcb02->control.insn_bytes, max_bytes);
+	if (!is_sev_guest(vcpu))
+		count = nested_svm_fetch_insn_bytes(vcpu,
+						    vmcb02->control.insn_bytes,
+						    count, max_bytes);
+	vmcb02->control.insn_len = count;
+
+	svm->nested.vmcb02_insn_bytes_valid = true;
 }
 
 static void nested_svm_update_vmcb12_insn_bytes(struct kvm_vcpu *vcpu,
@@ -126,6 +153,7 @@ static void nested_svm_update_vmcb12_insn_bytes(struct kvm_vcpu *vcpu,
 		vmcb12->control.insn_len =
 			nested_svm_fetch_insn_bytes(vcpu,
 						    vmcb12->control.insn_bytes,
+						    0,
 						    max_bytes);
 	else
 		nested_svm_invalidate_insn_bytes(vmcb12);
@@ -140,6 +168,8 @@ static void nested_svm_inject_npf_exit(struct kvm_vcpu *vcpu,
 {
 	struct vcpu_svm *svm = to_svm(vcpu);
 	struct vmcb *vmcb = svm->vmcb;
+	struct x86_emulate_ctxt *ctxt = vcpu->arch.emulate_ctxt;
+	bool from_emulation = ctxt && fault == &ctxt->exception;
 	u64 fault_stage;
 
 	/*
@@ -169,6 +199,8 @@ static void nested_svm_inject_npf_exit(struct kvm_vcpu *vcpu,
 
 	if (from_hardware)
 		nested_svm_set_vmcb02_insn_bytes_valid(svm);
+	else if (from_emulation && !(fault->error_code & PFERR_FETCH_MASK))
+		nested_svm_prepare_synthesized_insn_bytes(vcpu);
 	else
 		nested_svm_invalidate_vmcb02_insn_bytes(svm);
 	nested_svm_vmexit(svm);
-- 
2.43.7

