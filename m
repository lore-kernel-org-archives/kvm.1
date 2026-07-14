Received: from out198-19.us.a.mail.aliyun.com (out198-19.us.a.mail.aliyun.com [47.90.198.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 763E62F616B;
	Tue, 14 Jul 2026 05:10:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=47.90.198.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784005863; cv=none; b=sUffWYQUmOpGjHmo1k7716CvT6EIWuz7gcOtNRVmoYVhaOLLJhL1WAaFoQGXQSbUIPhvw0GVPZc9gNTRjMgf9iVIlkuDiybzCe3HTwA7NjFRT4QXLoiqawiBzauLj2nFLHCwkVQQA2BrtdrZbd8k4OjoG0NUEYDxdVJTiYWCRZ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784005863; c=relaxed/simple;
	bh=4cxnULvkI2mdVBmWNMmv8pyGI9dqx6Tl/lSDFG7fNh0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kVEEGURjZYYDZQILIwRGh0dL8ijARFCsb7PkTjmuTWTq829V6EITqLcRf33KdmkQAxhgaGEcdaWVXkAAnlyWqHQatKTqFDEzdet8bCkpO4KCGic/ixZicW9b0GINDkOi51M5qTSHSKi3fyH0yesw61RJWFrx63Lh3iE/Rd4w/qI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=open-hieco.net; spf=pass smtp.mailfrom=open-hieco.net; arc=none smtp.client-ip=47.90.198.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=open-hieco.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=open-hieco.net
X-Alimail-AntiSpam:AC=CONTINUE;BC=0.07436457|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_regular_dialog|0.00326502-0.000548113-0.996187;FP=18042105206661779195|1|1|1|0|-1|-1|-1;HT=maildocker-contentspam033037032089;MF=zhang_wei@open-hieco.net;NM=1;PH=DS;RN=9;RT=9;SR=0;TI=SMTPD_---.iKeOCcS_1784005838;
Received: from localhost.localdomain(mailfrom:zhang_wei@open-hieco.net fp:SMTPD_---.iKeOCcS_1784005838 cluster:ay29)
          by smtp.aliyun-inc.com;
          Tue, 14 Jul 2026 13:10:39 +0800
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
Subject: [PATCH v2 6/8] KVM: nSVM: Fetch missing DecodeAssist bytes for synthesized #NPF/#PF
Date: Tue, 14 Jul 2026 13:10:02 +0800
Message-ID: <341a0d64b31f03bf580beab32a36bf58042ccf2a.1783999988.git.zhang_wei@open-hieco.net>
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

The emulator fetch cache is not guaranteed to contain the full
architected 15-byte DecodeAssist window, e.g. it may only contain the
bytes needed to decode the instruction.

Keep preparation of synthesized state limited to capturing a matching
emulator fetch cache.  When constructing VMCB12, copy those bytes and
fetch any missing tail through L2 guest page tables, stopping at the
first translation fault, read failure, or CS limit overrun.  If no
matching emulator bytes are available, fetch the full window from L2
RIP, e.g. for a #PF injected by userspace.

Do not perform tail or fallback reads for SEV guests.  KVM cannot read
plaintext instruction bytes from encrypted guest memory, and the
existing SEV emulation path treats missing hardware DecodeAssist bytes
as unavailable instead of decoding guest memory.  For nested SEV,
report only matching emulator bytes that are already available,
potentially a zero instruction-byte count.

Signed-off-by: Tina Zhang <zhang_wei@open-hieco.net>
---
 arch/x86/kvm/svm/nested.c | 65 ++++++++++++++++++++++++++++++++++++++-
 arch/x86/kvm/svm/svm.h    |  6 ++--
 2 files changed, 68 insertions(+), 3 deletions(-)

diff --git a/arch/x86/kvm/svm/nested.c b/arch/x86/kvm/svm/nested.c
index 8cee9aeaf4f2..aaad36c23914 100644
--- a/arch/x86/kvm/svm/nested.c
+++ b/arch/x86/kvm/svm/nested.c
@@ -75,6 +75,54 @@ static void nested_svm_clear_synthesized_insn_bytes(struct vcpu_svm *svm)
 	svm->nested.synthesized_insn_bytes.insn_len = 0;
 }
 
+/*
+ * Fetch up to 15 bytes at L2's instruction pointer.  Honor the architectural
+ * fetch boundaries by stopping at a translation failure, read failure, or CS
+ * limit.
+ */
+static u8 nested_svm_fetch_insn_bytes(struct kvm_vcpu *vcpu, u8 *bytes,
+				      u8 count, u8 max_bytes)
+{
+	struct kvm_mmu *mmu = vcpu->arch.walk_mmu;
+	u64 access = PFERR_FETCH_MASK;
+	gva_t rip = kvm_get_linear_rip(vcpu);
+	struct x86_exception e;
+
+	if (to_svm(vcpu)->vmcb->save.cpl == 3)
+		access |= PFERR_USER_MASK;
+
+	/*
+	 * Hardware truncates the fetch at the CS limit.  CS.base and CS.limit
+	 * checks do not apply in 64-bit mode.
+	 */
+	if (!is_64_bit_mode(vcpu)) {
+		u32 eip = kvm_rip_read(vcpu);
+		u32 limit = to_svm(vcpu)->vmcb->save.cs.limit;
+
+		if (eip > limit)
+			return 0;
+		max_bytes = min_t(u64, max_bytes, (u64)limit - eip + 1);
+	}
+
+	count = min(count, max_bytes);
+
+	while (count < max_bytes) {
+		unsigned int chunk = min_t(unsigned int, max_bytes - count,
+				PAGE_SIZE - offset_in_page(rip + count));
+		gpa_t gpa = mmu->gva_to_gpa(vcpu, mmu, rip + count, access, &e);
+
+		if (gpa == INVALID_GPA ||
+		    kvm_vcpu_read_guest_page(vcpu, gpa_to_gfn(gpa),
+					     bytes + count,
+					     offset_in_page(gpa), chunk))
+			break;
+
+		count += chunk;
+	}
+
+	return count;
+}
+
 static void nested_svm_prepare_synthesized_insn_bytes(struct kvm_vcpu *vcpu)
 {
 	struct vcpu_svm *svm = to_svm(vcpu);
@@ -102,7 +150,8 @@ static void nested_svm_prepare_synthesized_insn_bytes(struct kvm_vcpu *vcpu)
 /*
  * Rebuild VMCB12's DecodeAssist bytes for the nested VM-Exit.  Use fresh
  * hardware VMCB02 state when available; otherwise use synthesized bytes from
- * the emulator fetch cache for KVM-generated #NPF/#PF exits.
+ * the emulator fetch cache for KVM-generated #NPF/#PF exits, or fetch from
+ * L2 RIP as a last resort.
  */
 static void nested_svm_update_vmcb12_insn_bytes(struct kvm_vcpu *vcpu,
 						struct vmcb *vmcb12,
@@ -133,8 +182,22 @@ static void nested_svm_update_vmcb12_insn_bytes(struct kvm_vcpu *vcpu,
 		vmcb12->control.insn_len = min(synthesized_len, max_bytes);
 		memcpy(vmcb12->control.insn_bytes, insn_bytes->insn_bytes,
 		       vmcb12->control.insn_len);
+
+		if (!is_sev_guest(vcpu))
+			vmcb12->control.insn_len =
+				nested_svm_fetch_insn_bytes(vcpu,
+							    vmcb12->control.insn_bytes,
+							    vmcb12->control.insn_len,
+							    max_bytes);
 		return;
 	}
+
+	if (is_sev_guest(vcpu))
+		return;
+
+	vmcb12->control.insn_len =
+		nested_svm_fetch_insn_bytes(vcpu, vmcb12->control.insn_bytes,
+					    0, max_bytes);
 }
 
 static void nested_svm_inject_npf_exit(struct kvm_vcpu *vcpu,
diff --git a/arch/x86/kvm/svm/svm.h b/arch/x86/kvm/svm/svm.h
index ef7701ddaea0..7fe5fb9706dd 100644
--- a/arch/x86/kvm/svm/svm.h
+++ b/arch/x86/kvm/svm/svm.h
@@ -249,13 +249,15 @@ struct svm_nested_state {
 	 * True if VMCB02's DecodeAssist instruction bytes belong to the hardware
 	 * VM-Exit currently being reflected to L1.  KVM-synthesized exits leave
 	 * it clear, in which case the #NPF/#PF instruction bytes are synthesized
-	 * from the emulator fetch cache when possible.
+	 * from the emulator fetch cache and/or refetched through the guest page
+	 * tables.
 	 */
 	bool vmcb02_insn_bytes_fresh;
 
 	/*
 	 * DecodeAssist instruction bytes for a KVM-synthesized nested #NPF/#PF.
-	 * Populated from the emulator's fetch cache when possible.
+	 * Populated from the emulator's fetch cache when it describes the
+	 * instruction at L2's current RIP.
 	 */
 	struct nested_svm_insn_bytes synthesized_insn_bytes;
 };
-- 
2.43.7

