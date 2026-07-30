Received: from out28-101.mail.aliyun.com (out28-101.mail.aliyun.com [115.124.28.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17FF03B27C3;
	Thu, 30 Jul 2026 12:08:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.28.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785413331; cv=none; b=M0qM94XDiyT6q+LyAy+j3c9TCc1FArVUxqagjY8EkUzxxXYZq3sSMxa/2ABFP2g9I0edxhEtKA1T0FwQasnJSKIPG2r138OuR98/3VWFnY8XMtyql/Sp93KilcH2tyrAJWA58pVSYvkjp2+0yIIFOSmS9dFBTWinK8czvhbBH9s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785413331; c=relaxed/simple;
	bh=2z+Z6sXHWDLiembjeoAvWc23gdvPx7dIIpBEMAiS7j4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PAjAFZJ9XWwBiFlJLEUg2qOQBl55SvY8JBzjHKnUb6Eqr4uDbjZ6bt2PR1j2hcW1phpym+8MNWsIMeamrhUwmj1n09EzID8n6elFmaDZx89sLWTYSRl7BpkXF/L5D1LRogONsjDYtkP1ktI+4fBxkGIsYMnNQwQal2WcDI3c2p4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=open-hieco.net; spf=pass smtp.mailfrom=open-hieco.net; arc=none smtp.client-ip=115.124.28.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=open-hieco.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=open-hieco.net
X-Alimail-AntiSpam:AC=CONTINUE;BC=0.09751385|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_system_inform|0.0956124-8.82729e-05-0.904299;FP=4965285672310607027|1|1|1|0|-1|-1|-1;HT=maildocker-contentspam033037028158;MF=zhang_wei@open-hieco.net;NM=1;PH=DS;RN=9;RT=9;SR=0;TI=SMTPD_---.iZWlrs2_1785413317;
Received: from localhost.localdomain(mailfrom:zhang_wei@open-hieco.net fp:SMTPD_---.iZWlrs2_1785413317 cluster:ay29)
          by smtp.aliyun-inc.com;
          Thu, 30 Jul 2026 20:08:37 +0800
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
Subject: [PATCH v3 2/9] KVM: nSVM: Synthesize DecodeAssists EXITINFO for emulated intercepts
Date: Thu, 30 Jul 2026 20:08:05 +0800
Message-ID: <31fd4e46d29c57b004b635d8e6a23020cc9ba0fb.1785411877.git.zhang_wei@open-hieco.net>
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
index d68cba12c772..b63234a2feb8 100644
--- a/arch/x86/kvm/svm/svm.c
+++ b/arch/x86/kvm/svm/svm.c
@@ -4822,6 +4822,52 @@ static const struct __x86_intercept {
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
@@ -4943,6 +4989,8 @@ static int svm_check_intercept(struct kvm_vcpu *vcpu,
 		break;
 	}
 
+	svm_prepare_decode_assist_exit_info(vcpu, info);
+
 	/* TODO: Advertise NRIPS to guest hypervisor unconditionally */
 	if (static_cpu_has(X86_FEATURE_NRIPS))
 		vmcb->control.next_rip  = info->next_rip;
-- 
2.43.7

