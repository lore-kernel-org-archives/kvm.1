Received: from out198-11.us.a.mail.aliyun.com (out198-11.us.a.mail.aliyun.com [47.90.198.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89CFB3C2BB9;
	Sun, 13 Sep 2026 06:44:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=47.90.198.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789281866; cv=none; b=kI5HUNk5jQT/9+ruWVnGb8CqbeLYSBFT2elMCuhstwhA/s2z/40gswQ98vfO0KLr3KcUot0at+2tJqaWFUtzUAEUr4tawxGYC0HDoV/lJhXmawF4dLhklogTRCJIKRl69vLGGXfG8kmMP1AbSdLc+9yVREh1abMkpOj6oL9rqQY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789281866; c=relaxed/simple;
	bh=iA+Vk9W9LXUSStGGuXFWXeIo2zpYZVW/xu3f6c5kbAQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=c+2t0Pu2bc4JYqPObg4DlN9v9rN684fkGR44OzLwEh4rCwcwD/kT+JtRoKPRlvqEi7tcQgdxPZWmyZgV6iYRj+nNBRvQ13GAfMwe63Kr3oLSdTsVNfQRgP07M+xNFr+vUg3G6ApWO/nEvZtIBMU5QxNPJYEXqQn9k1Yzl0RzSdw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=open-hieco.net; spf=pass smtp.mailfrom=open-hieco.net; arc=none smtp.client-ip=47.90.198.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=open-hieco.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=open-hieco.net
X-Alimail-AntiSpam:AC=CONTINUE;BC=0.07436279|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_alarm|0.0253741-0.00363635-0.97099;FP=16890027095934979837|1|1|1|0|-1|-1|-1;HT=maildocker-contentspam033023018039;MF=zhang_wei@open-hieco.net;NM=1;PH=DS;RN=8;RT=8;SR=0;TI=SMTPD_---.jCORvnr_1789281837;
Received: from localhost.localdomain(mailfrom:zhang_wei@open-hieco.net fp:SMTPD_---.jCORvnr_1789281837 cluster:ay29)
          by smtp.aliyun-inc.com;
          Sun, 13 Sep 2026 14:43:58 +0800
From: Tina Zhang <zhang_wei@open-hieco.net>
To: Sean Christopherson <seanjc@google.com>,
	Jim Mattson <jmattson@google.com>,
	kvm@vger.kernel.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
	Shuah Khan <shuah@kernel.org>,
	zhouyanjing@hygon.cn,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v6 5/8] KVM: nSVM: Fetch DecodeAssist bytes for synthesized faults
Date: Sun, 13 Sep 2026 14:43:45 +0800
Message-ID: <2cb3eb8fa88f2992b895b68010874fa3261c3a37.1789281096.git.zhang_wei@open-hieco.net>
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

Hardware-reflected #NPF and #PF VM-Exits can propagate instruction bytes
from VMCB02, but KVM-synthesized exits have no hardware-provided state for
the current exit.

Add kvm_fetch_guest_virt() as a wrapper around the generic guest virtual
memory helper that applies instruction-fetch permissions.  When a
synthesized data #NPF or #PF has no valid VMCB02 instruction bytes, fetch
up to 15 bytes from L2's RIP while constructing VMCB12.  Preserve the bytes
already read if a subsequent read cannot be completed.

Limit each read to the current page so that linear address boundaries can
be checked before continuing.  Outside 64-bit mode, truncate each address
to 32 bits and limit the window at the code-segment limit.  In 64-bit mode,
stop at a non-canonical address.

Do not attempt the fallback for SEV guests, as KVM cannot read encrypted
guest memory directly.

Signed-off-by: Tina Zhang <zhang_wei@open-hieco.net>
---
 arch/x86/kvm/svm/nested.c | 64 +++++++++++++++++++++++++++++++++++++--
 arch/x86/kvm/x86.c        | 23 +++++++++++---
 arch/x86/kvm/x86.h        |  3 ++
 3 files changed, 83 insertions(+), 7 deletions(-)

diff --git a/arch/x86/kvm/svm/nested.c b/arch/x86/kvm/svm/nested.c
index fba230058870..5cb6a9d6907b 100644
--- a/arch/x86/kvm/svm/nested.c
+++ b/arch/x86/kvm/svm/nested.c
@@ -78,22 +78,80 @@ static void nested_svm_invalidate_vmcb02_insn_bytes(struct vcpu_svm *svm)
 	svm->nested.vmcb02_insn_bytes_valid = false;
 }
 
+static u8 nested_svm_get_insn_bytes_len(struct kvm_vcpu *vcpu, u8 max_bytes)
+{
+	if (!is_64_bit_mode(vcpu)) {
+		u32 eip = kvm_rip_read(vcpu);
+		u32 limit = to_svm(vcpu)->vmcb->save.cs.limit;
+
+		if (eip > limit)
+			return 0;
+		max_bytes = min_t(u64, max_bytes, (u64)limit - eip + 1);
+	}
+
+	return max_bytes;
+}
+
+static u8 nested_svm_fetch_insn_bytes(struct kvm_vcpu *vcpu, u8 *bytes,
+				      u8 max_bytes)
+{
+	struct x86_exception e;
+	gva_t rip = kvm_get_linear_rip(vcpu);
+	u8 count = 0;
+
+	max_bytes = nested_svm_get_insn_bytes_len(vcpu, max_bytes);
+
+	while (count < max_bytes) {
+		gva_t addr = rip + count;
+		u8 chunk;
+
+		if (!is_64_bit_mode(vcpu))
+			addr = (u32)addr;
+		else if (is_noncanonical_address(addr, vcpu, 0))
+			break;
+
+		/*
+		 * Read one page at a time to recheck the linear address at each
+		 * boundary.
+		 */
+		chunk = min_t(unsigned int, max_bytes - count,
+			      PAGE_SIZE - offset_in_page(addr));
+		if (kvm_fetch_guest_virt(vcpu, addr, bytes + count,
+					 chunk, &e) != X86EMUL_CONTINUE)
+			break;
+		count += chunk;
+	}
+
+	return count;
+}
+
 static void nested_svm_update_vmcb12_insn_bytes(struct kvm_vcpu *vcpu,
 						struct vmcb *vmcb12,
 						const struct vmcb *vmcb02)
 {
 	struct vcpu_svm *svm = to_svm(vcpu);
+	const u8 max_bytes = sizeof(vmcb12->control.insn_bytes);
 
 	if (!guest_cpu_cap_has(vcpu, X86_FEATURE_DECODEASSISTS))
 		goto out;
 
-	if (!nested_svm_vmexit_supports_insn_bytes(vmcb02) ||
-	    !svm->nested.vmcb02_insn_bytes_valid) {
+	if (!nested_svm_vmexit_supports_insn_bytes(vmcb02)) {
 		nested_svm_invalidate_insn_bytes(vmcb12);
 		goto out;
 	}
 
-	nested_svm_copy_insn_bytes(vmcb12, vmcb02);
+	if (svm->nested.vmcb02_insn_bytes_valid) {
+		nested_svm_copy_insn_bytes(vmcb12, vmcb02);
+		goto out;
+	}
+
+	if (!is_sev_guest(vcpu))
+		vmcb12->control.insn_len =
+			nested_svm_fetch_insn_bytes(vcpu,
+						    vmcb12->control.insn_bytes,
+						    max_bytes);
+	else
+		nested_svm_invalidate_insn_bytes(vmcb12);
 
 out:
 	svm->nested.vmcb02_insn_bytes_valid = false;
diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index 4b3681796c75..735b67781d55 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -4848,9 +4848,24 @@ static int kvm_read_guest_virt_helper(gva_t addr, void *val, unsigned int bytes,
 }
 
 /* used for instruction fetching */
-static int kvm_fetch_guest_virt(struct x86_emulate_ctxt *ctxt,
-				gva_t addr, void *val, unsigned int bytes,
-				struct x86_exception *exception)
+int kvm_fetch_guest_virt(struct kvm_vcpu *vcpu, gva_t addr, void *val,
+			 unsigned int bytes, struct x86_exception *exception)
+{
+	u64 access = PFERR_FETCH_MASK;
+
+	if (kvm_x86_call(get_cpl)(vcpu) == 3)
+		access |= PFERR_USER_MASK;
+
+	memset(exception, 0, sizeof(*exception));
+	return kvm_read_guest_virt_helper(addr, val, bytes, vcpu, access,
+					  exception);
+}
+EXPORT_SYMBOL_FOR_KVM_INTERNAL(kvm_fetch_guest_virt);
+
+static int emulator_fetch_guest_virt(struct x86_emulate_ctxt *ctxt,
+				     gva_t addr, void *val,
+				     unsigned int bytes,
+				     struct x86_exception *exception)
 {
 	struct kvm_vcpu *vcpu = emul_to_vcpu(ctxt);
 	struct kvm_pagewalk *gva_walk = &vcpu->arch.gva_walk;
@@ -5817,7 +5832,7 @@ static const struct x86_emulate_ops emulate_ops = {
 	.write_gpr           = emulator_write_gpr,
 	.read_std            = emulator_read_std,
 	.write_std           = emulator_write_std,
-	.fetch               = kvm_fetch_guest_virt,
+	.fetch               = emulator_fetch_guest_virt,
 	.read_emulated       = emulator_read_emulated,
 	.write_emulated      = emulator_write_emulated,
 	.cmpxchg_emulated    = emulator_cmpxchg_emulated,
diff --git a/arch/x86/kvm/x86.h b/arch/x86/kvm/x86.h
index 0f5919b092e4..f03419a79a11 100644
--- a/arch/x86/kvm/x86.h
+++ b/arch/x86/kvm/x86.h
@@ -356,6 +356,9 @@ static inline void adjust_tsc_offset_host(struct kvm_vcpu *vcpu, s64 adjustment)
 int kvm_read_guest_virt(struct kvm_vcpu *vcpu,
 	gva_t addr, void *val, unsigned int bytes,
 	struct x86_exception *exception);
+int kvm_fetch_guest_virt(struct kvm_vcpu *vcpu, gva_t addr, void *val,
+			 unsigned int bytes,
+			 struct x86_exception *exception);
 
 int kvm_write_guest_virt_system(struct kvm_vcpu *vcpu,
 	gva_t addr, void *val, unsigned int bytes,
-- 
2.43.7

