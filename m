Received: from out28-75.mail.aliyun.com (out28-75.mail.aliyun.com [115.124.28.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5540B5372CB;
	Wed, 23 Sep 2026 14:03:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.28.75
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790172190; cv=none; b=qE6nGNGskqrQHk9P7UamdRTWjlG3ZcyDKYdD7yMWu+VXZNbdS5Wqblp872xK22pMR5tbxjqZtHUIDIPY9g23p4MUSzccyxJhRzfjs7PQI/ABtK9N5tEYwweP/Y4wD8onQ/d+4n5g3gyXNvVnBWpUo77wgzay01jM1zZP2yTaW5o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790172190; c=relaxed/simple;
	bh=fN3Ng616+ijrAnPgwqgyiGDwviuUJ+eo7OHUbLmkMYM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GIj8rm/x7REyykImLd0mV3ZZuIc3dVEXgGzc1TCgd8jW90DO3VN2ppIc1XfhWt4m2NPE/ADXFYOMJIQvKOGLxX6ifGbnKreT0NUMobum+Y3oVm3V7T5BoOZZOVKENeyiMx4KOV8lVkh9aBN4NteuU+FY3ErRwBMzkP6iDlC6tk4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=open-hieco.net; spf=pass smtp.mailfrom=open-hieco.net; arc=none smtp.client-ip=115.124.28.75
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=open-hieco.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=open-hieco.net
X-Alimail-AntiSpam:AC=CONTINUE;BC=0.0743626|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_alarm|0.0287089-0.00277421-0.968517;FP=14583058187074620669|0|0|0|0|-1|-1|-1;HT=maildocker-contentspam033037031241;MF=zhang_wei@open-hieco.net;NM=1;PH=DS;RN=8;RT=8;SR=0;TI=SMTPD_---.jL9oyhq_1790172175;
Received: from localhost.localdomain(mailfrom:zhang_wei@open-hieco.net fp:SMTPD_---.jL9oyhq_1790172175 cluster:ay29)
          by smtp.aliyun-inc.com;
          Wed, 23 Sep 2026 22:02:56 +0800
From: Tina Zhang <zhang_wei@open-hieco.net>
To: Sean Christopherson <seanjc@google.com>,
	Jim Mattson <jmattson@google.com>,
	kvm@vger.kernel.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
	Shuah Khan <shuah@kernel.org>,
	zhouyanjing@hygon.cn,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v8 5/8] KVM: nSVM: Fetch DecodeAssist bytes for synthesized faults
Date: Wed, 23 Sep 2026 22:02:30 +0800
Message-ID: <b614e927c6c1ce9265cb9a37b296b0b30598da72.1790171702.git.zhang_wei@open-hieco.net>
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

Hardware-reflected #NPF and #PF VM-Exits can propagate instruction bytes
from VMCB02, but KVM-synthesized exits have no hardware-provided state for
the current exit.

Extend kvm_read_guest_virt_helper() to optionally report the number of
bytes read, including partial reads.  Add kvm_fetch_guest_virt() to apply
instruction-fetch permissions and return that count, reusing the generic
helper's page-by-page read loop.

When a synthesized data #NPF or #PF has no valid VMCB02 instruction bytes,
fetch up to 15 bytes from L2's RIP while constructing VMCB12.  Preserve
the bytes already read if a subsequent read cannot be completed.

For instruction fetches, truncate each linear address to 32 bits outside
64-bit mode and stop at a non-canonical address in 64-bit mode.  Limit
the fetch window at the code-segment limit outside 64-bit mode.

Do not attempt the fallback for SEV guests, as KVM cannot read encrypted
guest memory directly.

Signed-off-by: Tina Zhang <zhang_wei@open-hieco.net>
---
 arch/x86/kvm/svm/nested.c | 41 +++++++++++++++++++++++++---
 arch/x86/kvm/x86.c        | 56 +++++++++++++++++++++++++++++++--------
 arch/x86/kvm/x86.h        |  2 ++
 3 files changed, 85 insertions(+), 14 deletions(-)

diff --git a/arch/x86/kvm/svm/nested.c b/arch/x86/kvm/svm/nested.c
index e839f61211c9..813b0fc663c6 100644
--- a/arch/x86/kvm/svm/nested.c
+++ b/arch/x86/kvm/svm/nested.c
@@ -78,22 +78,57 @@ static void nested_svm_invalidate_vmcb02_insn_bytes(struct vcpu_svm *svm)
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
+	gva_t rip = kvm_get_linear_rip(vcpu);
+
+	max_bytes = nested_svm_get_insn_bytes_len(vcpu, max_bytes);
+
+	return kvm_fetch_guest_virt(vcpu, rip, bytes, max_bytes);
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
index 1705e7be46ec..ad8b35f2219d 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -4772,20 +4772,34 @@ gpa_t kvm_mmu_gva_to_gpa_system(struct kvm_vcpu *vcpu, gva_t gva,
 
 static int kvm_read_guest_virt_helper(gva_t addr, void *val, unsigned int bytes,
 				      struct kvm_vcpu *vcpu, u64 access,
-				      struct x86_exception *exception)
+				      struct x86_exception *exception,
+				      unsigned int *bytes_read)
 {
 	struct kvm_pagewalk *gva_walk = &vcpu->arch.gva_walk;
 	void *data = val;
 	int r = X86EMUL_CONTINUE;
 
 	while (bytes) {
-		gpa_t gpa = gva_walk->gva_to_gpa(vcpu, gva_walk, addr, access, exception);
+		gpa_t gpa;
 		unsigned offset = addr & (PAGE_SIZE-1);
 		unsigned toread = min(bytes, (unsigned)PAGE_SIZE - offset);
 		int ret;
 
-		if (gpa == INVALID_GPA)
-			return X86EMUL_PROPAGATE_FAULT;
+		/* Apply address wrapping or canonicality checks before each fetch chunk. */
+		if (access & PFERR_FETCH_MASK) {
+			if (!is_64_bit_mode(vcpu))
+				addr = (u32)addr;
+			else if (is_noncanonical_address(addr, vcpu, 0)) {
+				r = X86EMUL_UNHANDLEABLE;
+				goto out;
+			}
+		}
+
+		gpa = gva_walk->gva_to_gpa(vcpu, gva_walk, addr, access, exception);
+		if (gpa == INVALID_GPA) {
+			r = X86EMUL_PROPAGATE_FAULT;
+			goto out;
+		}
 		ret = kvm_vcpu_read_guest_page(vcpu, gpa >> PAGE_SHIFT, data,
 					       offset, toread);
 		if (ret < 0) {
@@ -4798,13 +4812,32 @@ static int kvm_read_guest_virt_helper(gva_t addr, void *val, unsigned int bytes,
 		addr += toread;
 	}
 out:
+	if (bytes_read)
+		*bytes_read = data - val;
 	return r;
 }
 
-/* used for instruction fetching */
-static int kvm_fetch_guest_virt(struct x86_emulate_ctxt *ctxt,
-				gva_t addr, void *val, unsigned int bytes,
-				struct x86_exception *exception)
+/* Return the number of instruction bytes read, including partial reads. */
+unsigned int kvm_fetch_guest_virt(struct kvm_vcpu *vcpu, gva_t addr,
+				 void *val, unsigned int bytes)
+{
+	struct x86_exception exception = {};
+	unsigned int bytes_read;
+	u64 access = PFERR_FETCH_MASK;
+
+	if (kvm_x86_call(get_cpl)(vcpu) == 3)
+		access |= PFERR_USER_MASK;
+
+	kvm_read_guest_virt_helper(addr, val, bytes, vcpu, access,
+				  &exception, &bytes_read);
+	return bytes_read;
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
@@ -4843,7 +4876,7 @@ int kvm_read_guest_virt(struct kvm_vcpu *vcpu,
 	 */
 	memset(exception, 0, sizeof(*exception));
 	return kvm_read_guest_virt_helper(addr, val, bytes, vcpu, access,
-					  exception);
+					  exception, NULL);
 }
 EXPORT_SYMBOL_FOR_KVM_INTERNAL(kvm_read_guest_virt);
 
@@ -4859,7 +4892,8 @@ static int emulator_read_std(struct x86_emulate_ctxt *ctxt,
 	else if (kvm_x86_call(get_cpl)(vcpu) == 3)
 		access |= PFERR_USER_MASK;
 
-	return kvm_read_guest_virt_helper(addr, val, bytes, vcpu, access, exception);
+	return kvm_read_guest_virt_helper(addr, val, bytes, vcpu, access,
+					  exception, NULL);
 }
 
 static int kvm_write_guest_virt_helper(gva_t addr, void *val, unsigned int bytes,
@@ -5771,7 +5805,7 @@ static const struct x86_emulate_ops emulate_ops = {
 	.write_gpr           = emulator_write_gpr,
 	.read_std            = emulator_read_std,
 	.write_std           = emulator_write_std,
-	.fetch               = kvm_fetch_guest_virt,
+	.fetch               = emulator_fetch_guest_virt,
 	.read_emulated       = emulator_read_emulated,
 	.write_emulated      = emulator_write_emulated,
 	.cmpxchg_emulated    = emulator_cmpxchg_emulated,
diff --git a/arch/x86/kvm/x86.h b/arch/x86/kvm/x86.h
index 1d9a66048b01..dbf0a4e6e9c1 100644
--- a/arch/x86/kvm/x86.h
+++ b/arch/x86/kvm/x86.h
@@ -357,6 +357,8 @@ static inline void adjust_tsc_offset_host(struct kvm_vcpu *vcpu, s64 adjustment)
 int kvm_read_guest_virt(struct kvm_vcpu *vcpu,
 	gva_t addr, void *val, unsigned int bytes,
 	struct x86_exception *exception);
+unsigned int kvm_fetch_guest_virt(struct kvm_vcpu *vcpu, gva_t addr,
+				 void *val, unsigned int bytes);
 
 int kvm_write_guest_virt_system(struct kvm_vcpu *vcpu,
 	gva_t addr, void *val, unsigned int bytes,
-- 
2.43.7

