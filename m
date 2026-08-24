Received: from out28-171.mail.aliyun.com (out28-171.mail.aliyun.com [115.124.28.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B9A7408614;
	Mon, 24 Aug 2026 12:46:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.28.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787575564; cv=none; b=dvMy6Xuc+4ChqKK92NmQK33dy0i8+uk5nZnDPLvLsP0CNWPaz1UHvwiguVjuG+pIgyuCbyaQwhWQbFSWJE8sUDt1ZCFtQzM75mTRZCS+jiBwA8oHqBBtCs9qPI1D9qK3dzbDZjrHOg84ZIXNhKI2Bgpnu7ZOPLGSi2GQR1UElmY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787575564; c=relaxed/simple;
	bh=HTsTrf3GS8focgENfcnW4GUKxWGfWXBsY/M9EnYLQ54=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Z2E2Z3HYjAKVqbTll1e/FjkErygdpBF/gjx57mKDC3T15BJuQ1CPAlezgquD3PZv3Fy77YcTJRnIwIkz/a+v8HsGheK9CwhbASfgIFZNqYWC39oy6znDQ3iVonjDjqxeJwZIdITH8vPAgAxy04zgKHbaaYd5mVjd35l0XOx6lDA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=open-hieco.net; spf=pass smtp.mailfrom=open-hieco.net; arc=none smtp.client-ip=115.124.28.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=open-hieco.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=open-hieco.net
X-Alimail-AntiSpam:AC=CONTINUE;BC=0.07437645|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_regular_dialog|0.006685-0.00116533-0.99215;FP=16962640150030912499|1|1|1|0|-1|-1|-1;HT=maildocker-contentspam033068005250;MF=zhang_wei@open-hieco.net;NM=1;PH=DS;RN=9;RT=9;SR=0;TI=SMTPD_---.iw1ghAf_1787575232;
Received: from localhost.localdomain(mailfrom:zhang_wei@open-hieco.net fp:SMTPD_---.iw1ghAf_1787575232 cluster:ay29)
          by smtp.aliyun-inc.com;
          Mon, 24 Aug 2026 20:40:34 +0800
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
Subject: [PATCH v5 6/8] KVM: nSVM: Fetch missing DecodeAssist bytes for synthesized #NPF/#PF
Date: Mon, 24 Aug 2026 20:39:52 +0800
Message-ID: <20260824123954.315112-7-zhang_wei@open-hieco.net>
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

For a synthesized #NPF, the emulator fetch cache is not guaranteed to
contain the full architected 15-byte DecodeAssist window, e.g. it may
contain only the bytes needed to decode the instruction.

Keep preparation of synthesized state limited to capturing a matching
emulator fetch cache for #NPF.  When constructing VMCB12, copy those bytes
and fetch any missing tail through L2 guest page tables.  If no emulator
bytes are available, fetch the full window from L2 RIP, including for a
queued or synthesized #PF VM-Exit.  Stop at a translation fault, read
failure, non-canonical address, or CS limit overrun.

For a non-64-bit L2, truncate each incremented linear address to 32 bits
so that a fetch whose CS.base makes it cross the 4GB boundary wraps as
required.

Do not perform tail or fallback reads for SEV guests.  KVM cannot read
plaintext instruction bytes from encrypted guest memory, and the existing
SEV emulation path treats missing hardware DecodeAssist bytes as
unavailable instead of decoding guest memory.  For nested SEV, report only
matching emulator bytes already captured for a synthesized #NPF,
potentially a zero instruction-byte count.

Signed-off-by: Tina Zhang <zhang_wei@open-hieco.net>
---
 arch/x86/kvm/svm/nested.c | 58 ++++++++++++++++++++++++++++++++++++++-
 1 file changed, 57 insertions(+), 1 deletion(-)

diff --git a/arch/x86/kvm/svm/nested.c b/arch/x86/kvm/svm/nested.c
index 635ff20cc431..c677ad5df8d6 100644
--- a/arch/x86/kvm/svm/nested.c
+++ b/arch/x86/kvm/svm/nested.c
@@ -87,6 +87,54 @@ static void nested_svm_clear_synthesized_insn_bytes(struct vcpu_svm *svm)
 	svm->nested.synthesized_insn_bytes.insn_len = 0;
 }
 
+static u8 nested_svm_fetch_insn_bytes(struct kvm_vcpu *vcpu, u8 *bytes,
+				      u8 count, u8 max_bytes)
+{
+	struct kvm_pagewalk *gva_walk = &vcpu->arch.gva_walk;
+	u64 access = PFERR_FETCH_MASK;
+	gva_t rip = kvm_get_linear_rip(vcpu);
+	struct x86_exception e;
+
+	if (kvm_x86_call(get_cpl)(vcpu) == 3)
+		access |= PFERR_USER_MASK;
+
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
+		gva_t addr = rip + count;
+		unsigned int chunk;
+		gpa_t gpa;
+
+		if (!is_64_bit_mode(vcpu))
+			addr = (u32)addr;
+		else if (is_noncanonical_address(addr, vcpu, 0))
+			break;
+
+		chunk = min_t(unsigned int, max_bytes - count,
+			      PAGE_SIZE - offset_in_page(addr));
+		gpa = gva_walk->gva_to_gpa(vcpu, gva_walk, addr, access, &e);
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
@@ -120,6 +168,7 @@ static void nested_svm_update_vmcb12_insn_bytes(struct kvm_vcpu *vcpu,
 	struct vcpu_svm *svm = to_svm(vcpu);
 	struct nested_svm_insn_bytes *synthesized =
 		&svm->nested.synthesized_insn_bytes;
+	const u8 max_bytes = sizeof(vmcb12->control.insn_bytes);
 
 	nested_svm_clear_insn_bytes(vmcb12);
 
@@ -135,9 +184,16 @@ static void nested_svm_update_vmcb12_insn_bytes(struct kvm_vcpu *vcpu,
 	if (synthesized->prepared) {
 		vmcb12->control.insn_len = synthesized->insn_len;
 		memcpy(vmcb12->control.insn_bytes, synthesized->insn_bytes,
-		       vmcb12->control.insn_len);
+		       synthesized->insn_len);
 	}
 
+	if (!is_sev_guest(vcpu))
+		vmcb12->control.insn_len =
+			nested_svm_fetch_insn_bytes(vcpu,
+						    vmcb12->control.insn_bytes,
+						    vmcb12->control.insn_len,
+						    max_bytes);
+
 out:
 	svm->nested.vmcb02_insn_bytes_fresh = false;
 	nested_svm_clear_synthesized_insn_bytes(svm);
-- 
2.43.7

