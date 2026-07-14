Received: from out28-75.mail.aliyun.com (out28-75.mail.aliyun.com [115.124.28.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F16B1AAE28;
	Tue, 14 Jul 2026 05:16:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.28.75
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784006165; cv=none; b=ZQQOOyb6SjRZOy8UVVTaezmEzg2QhSIGVNguBLzCcsqC16fZ+Kbb2pehgFc9FAKJAwRfhJesm2f1rCkJYkNClnv6C9jxr4jrdgvNulPnbrqMTk/Pnnsi5AU/CO5NsybdcHWm/AUvZWze/u7HlJUx09PihNK+7gI2OQqAaTh/A4Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784006165; c=relaxed/simple;
	bh=4dUa7eQJddOaaDTOSb1GKzqKEPvJK6UnUQEmdpQ8Q5k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=m3Zo00Me6T0daBtAuagtDrHwj6mfvtMvH1s2zbh4iLJTCk+oBIzgxbBaUtXZdvRE+/bk7aY/tERQpXswyuGmomY0nNOxsQ7AxSi0w4xoER5Gf7P+aLdhs3ObcDA8Fq4KXr8uMHW2yEXEXTuECwyn/SVirhyGWQcI8/pymg4wgzk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=open-hieco.net; spf=pass smtp.mailfrom=open-hieco.net; arc=none smtp.client-ip=115.124.28.75
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=open-hieco.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=open-hieco.net
X-Alimail-AntiSpam:AC=CONTINUE;BC=0.09963188|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_system_inform|0.0956124-8.82729e-05-0.904299;FP=4965285672310604979|1|1|1|0|-1|-1|-1;HT=maildocker-contentspam033037025160;MF=zhang_wei@open-hieco.net;NM=1;PH=DS;RN=9;RT=9;SR=0;TI=SMTPD_---.iKeOCYB_1784005835;
Received: from localhost.localdomain(mailfrom:zhang_wei@open-hieco.net fp:SMTPD_---.iKeOCYB_1784005835 cluster:ay29)
          by smtp.aliyun-inc.com;
          Tue, 14 Jul 2026 13:10:36 +0800
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
Subject: [PATCH v2 2/8] KVM: nSVM: Synthesize DecodeAssists EXITINFO for emulated intercepts
Date: Tue, 14 Jul 2026 13:09:58 +0800
Message-ID: <f794550ecf8a78ce7095d699a7508bc8cc955679.1783999988.git.zhang_wei@open-hieco.net>
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

When the x86 emulator encounters an instruction intercepted by L1,
svm_check_intercept() synthesizes a nested VM-Exit without fresh hardware
DecodeAssist state.  Populate the architectural EXITINFO fields when
DecodeAssists is exposed to L1.

Generate EXITINFO1 with the GPR number for MOV CR/DR, the interrupt vector
for INTn, and the linear address for INVLPG.  Set EXITINFO1 to zero for
CLTS, LMSW, SMSW, and INVLPGA; the INVLPGA address remains in guest rAX.
Clear EXITINFO2 for all covered intercepts and leave unrelated intercepts
unchanged.

Signed-off-by: Tina Zhang <zhang_wei@open-hieco.net>
---
 arch/x86/kvm/svm/svm.c | 48 ++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 48 insertions(+)

diff --git a/arch/x86/kvm/svm/svm.c b/arch/x86/kvm/svm/svm.c
index e02a38da5296..cc35afb59623 100644
--- a/arch/x86/kvm/svm/svm.c
+++ b/arch/x86/kvm/svm/svm.c
@@ -4754,6 +4754,52 @@ static const struct __x86_intercept {
 #undef POST_EX
 #undef POST_MEM
 
+static void svm_prepare_decode_assist_exit_info(struct kvm_vcpu *vcpu,
+						const struct x86_instruction_info *info)
+{
+	struct vmcb *vmcb = to_svm(vcpu)->vmcb;
+	u64 exit_info_1;
+
+	if (!guest_cpu_cap_has(vcpu, X86_FEATURE_DECODEASSISTS))
+		return;
+
+	switch (info->intercept) {
+	case x86_intercept_cr_read:
+	case x86_intercept_cr_write:
+		/* MOV CRx: bit 63 set, GPR number in bits 3:0. */
+		exit_info_1 = BIT_ULL(63) | (info->modrm_rm & 0xf);
+		break;
+	case x86_intercept_clts:
+	case x86_intercept_lmsw:
+	case x86_intercept_smsw:
+		/* CLTS/LMSW/SMSW: no decode information, bit 63 clear. */
+		exit_info_1 = 0;
+		break;
+	case x86_intercept_dr_read:
+	case x86_intercept_dr_write:
+		/* MOV DRx: GPR number in bits 3:0. */
+		exit_info_1 = info->modrm_rm & 0xf;
+		break;
+	case x86_intercept_intn:
+		/* INTn: software interrupt number in bits 7:0. */
+		exit_info_1 = info->src_val & 0xff;
+		break;
+	case x86_intercept_invlpg:
+		/* INVLPG: linear address of the target page. */
+		exit_info_1 = info->intercept_linear_addr;
+		break;
+	case x86_intercept_invlpga:
+		/* INVLPGA: the address remains available in guest rAX. */
+		exit_info_1 = 0;
+		break;
+	default:
+		return;
+	}
+
+	vmcb->control.exit_info_1 = exit_info_1;
+	vmcb->control.exit_info_2 = 0;
+}
+
 static int svm_check_intercept(struct kvm_vcpu *vcpu,
 			       struct x86_instruction_info *info,
 			       enum x86_intercept_stage stage,
@@ -4875,6 +4921,8 @@ static int svm_check_intercept(struct kvm_vcpu *vcpu,
 		break;
 	}
 
+	svm_prepare_decode_assist_exit_info(vcpu, info);
+
 	/* TODO: Advertise NRIPS to guest hypervisor unconditionally */
 	if (static_cpu_has(X86_FEATURE_NRIPS))
 		vmcb->control.next_rip  = info->next_rip;
-- 
2.43.7

