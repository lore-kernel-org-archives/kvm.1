Received: from out28-76.mail.aliyun.com (out28-76.mail.aliyun.com [115.124.28.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB99B417BE5;
	Thu, 30 Jul 2026 12:08:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.28.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785413332; cv=none; b=Zywejbd9TzPI/ffgQHsgVOMHrS66knZOSYHXP1+wCTbUkoscZf4eBFMAfuAqwoIxtTqWp1wwosGUxF0jsx14V5F+IiAo+REMRHpABxDg1QBUVxAHvZqbTg0rZQHlNwCOk4qxmyPgGBe3whRtb2OYGT7gKRRdtED4KQCjMX1c1EY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785413332; c=relaxed/simple;
	bh=Qk/Ld6qXkwa6ra+04Udhd5gOepH2o9pNAJEvZnjtQ1M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qZKKQirSG9+JMTtLw20zOy8qgKF/wohYagaqVZzxONDOEdpPAZfu1vfznLZ5S4JEYsp1PbGZYsaf6nQXE0/MO+nUsKEm6G7tXiL557AESgWUotO5F79uBdtupqrbyAANReuHGQFqKcoFrT1LpMdKdfLcfqI95sO2Vd48ws62Noc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=open-hieco.net; spf=pass smtp.mailfrom=open-hieco.net; arc=none smtp.client-ip=115.124.28.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=open-hieco.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=open-hieco.net
X-Alimail-AntiSpam:AC=CONTINUE;BC=0.07436482|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_regular_dialog|0.00448623-0.000976733-0.994537;FP=16962649083562888177|1|1|1|0|-1|-1|-1;HT=maildocker-contentspam033040074035;MF=zhang_wei@open-hieco.net;NM=1;PH=DS;RN=9;RT=9;SR=0;TI=SMTPD_---.iZWlrvU_1785413320;
Received: from localhost.localdomain(mailfrom:zhang_wei@open-hieco.net fp:SMTPD_---.iZWlrvU_1785413320 cluster:ay29)
          by smtp.aliyun-inc.com;
          Thu, 30 Jul 2026 20:08:41 +0800
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
Subject: [PATCH v3 7/9] KVM: nSVM: Fetch missing DecodeAssist bytes for synthesized #NPF/#PF
Date: Thu, 30 Jul 2026 20:08:10 +0800
Message-ID: <9dae4bd5ad241b72193b38cfe8857c968c47a4b7.1785411877.git.zhang_wei@open-hieco.net>
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

The emulator fetch cache is not guaranteed to contain the full
architected 15-byte DecodeAssist window, e.g. it may only contain the
bytes needed to decode the instruction.

Keep preparation of synthesized state limited to capturing a matching
emulator fetch cache.  When constructing VMCB12, copy those bytes and
fetch any missing tail through L2 guest page tables, stopping at a
translation fault, read failure, non-canonical address, or CS limit
overrun.  If no matching emulator bytes are available, fetch the full
window from L2 RIP, e.g. for a #PF injected by userspace.

For a non-64-bit L2, truncate each incremented linear address to 32 bits
so that a fetch whose CS.base makes it cross the 4GB boundary wraps as
required.

Do not perform tail or fallback reads for SEV guests.  KVM cannot read
plaintext instruction bytes from encrypted guest memory, and the
existing SEV emulation path treats missing hardware DecodeAssist bytes
as unavailable instead of decoding guest memory.  For nested SEV,
report only matching emulator bytes that are already available,
potentially a zero instruction-byte count.

Signed-off-by: Tina Zhang <zhang_wei@open-hieco.net>
---
 arch/x86/kvm/svm/nested.c | 63 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 63 insertions(+)

diff --git a/arch/x86/kvm/svm/nested.c b/arch/x86/kvm/svm/nested.c
index cfb686c29bb4..cf2b6bb8126f 100644
--- a/arch/x86/kvm/svm/nested.c
+++ b/arch/x86/kvm/svm/nested.c
@@ -77,6 +77,54 @@ static void nested_svm_clear_synthesized_insn_bytes(struct vcpu_svm *svm)
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
@@ -110,6 +158,7 @@ static void nested_svm_update_vmcb12_insn_bytes(struct kvm_vcpu *vcpu,
 	struct vcpu_svm *svm = to_svm(vcpu);
 	struct nested_svm_insn_bytes *insn_bytes =
 		&svm->nested.synthesized_insn_bytes;
+	const u8 max_bytes = sizeof(vmcb12->control.insn_bytes);
 
 	nested_svm_clear_insn_bytes(vmcb12);
 
@@ -125,8 +174,22 @@ static void nested_svm_update_vmcb12_insn_bytes(struct kvm_vcpu *vcpu,
 		vmcb12->control.insn_len = insn_bytes->insn_len;
 		memcpy(vmcb12->control.insn_bytes, insn_bytes->insn_bytes,
 		       vmcb12->control.insn_len);
+
+		if (!is_sev_guest(vcpu))
+			vmcb12->control.insn_len =
+				nested_svm_fetch_insn_bytes(vcpu,
+							    vmcb12->control.insn_bytes,
+							    vmcb12->control.insn_len,
+							    max_bytes);
+		goto out;
 	}
 
+	if (!is_sev_guest(vcpu))
+		vmcb12->control.insn_len =
+			nested_svm_fetch_insn_bytes(vcpu,
+						    vmcb12->control.insn_bytes,
+						    0, max_bytes);
+
 out:
 	svm->nested.vmcb02_insn_bytes_fresh = false;
 	nested_svm_clear_synthesized_insn_bytes(svm);
-- 
2.43.7

