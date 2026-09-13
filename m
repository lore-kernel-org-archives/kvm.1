Received: from out28-123.mail.aliyun.com (out28-123.mail.aliyun.com [115.124.28.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 428E53542F8;
	Sun, 13 Sep 2026 06:43:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.28.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789281844; cv=none; b=Werj0Y1eUuLHjSvbFaKWabO1dVT3DjUsNYC7gRzN6CR1Ry0VHHgcCra6N+gQxtuRNGcKInOKKizLkS9XV+80LCDCKQMB23i7TyRtdpnVs34cPdG6zLN8i3M+7BpSv2THI2S7FFfbHdi8AuHj7kBJU/qaMMfBT9okGydSq2phAkY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789281844; c=relaxed/simple;
	bh=fGdNZ8wbUnDKryPWMhczDMu4D0+aE0A/tqw1KK2pfK8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ESSo3KIIrHdbxD1mlFCDoHcF1qdYOikOn01xzPzDhyihBPeZePOmOM2b2msnO+NA4AaPkXNlfyUpwVNONWOXrKSoXJl4QA7b4RoqaEec/q8ul8nZxkDlTMe9W3WzasWEGweo1QRFwcPZnES9JPiycbA27bASdP7wPRLEj5xrjnw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=open-hieco.net; spf=pass smtp.mailfrom=open-hieco.net; arc=none smtp.client-ip=115.124.28.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=open-hieco.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=open-hieco.net
X-Alimail-AntiSpam:AC=CONTINUE;BC=0.5486717|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_regular_dialog|0.130133-0.00141973-0.868447;FP=4970688693919567799|1|1|1|0|-1|-1|-1;HT=maildocker-contentspam033037028158;MF=zhang_wei@open-hieco.net;NM=1;PH=DS;RN=8;RT=8;SR=0;TI=SMTPD_---.jCORvm0_1789281835;
Received: from localhost.localdomain(mailfrom:zhang_wei@open-hieco.net fp:SMTPD_---.jCORvm0_1789281835 cluster:ay29)
          by smtp.aliyun-inc.com;
          Sun, 13 Sep 2026 14:43:56 +0800
From: Tina Zhang <zhang_wei@open-hieco.net>
To: Sean Christopherson <seanjc@google.com>,
	Jim Mattson <jmattson@google.com>,
	kvm@vger.kernel.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
	Shuah Khan <shuah@kernel.org>,
	zhouyanjing@hygon.cn,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v6 2/8] KVM: nSVM: Synthesize DecodeAssists EXITINFO for emulated intercepts
Date: Sun, 13 Sep 2026 14:43:42 +0800
Message-ID: <a362ecf119a7e1c6a42c0643537cc51e83f78bb2.1789281096.git.zhang_wei@open-hieco.net>
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

When the x86 emulator encounters an instruction intercepted by L1,
svm_check_intercept() synthesizes a nested VM-Exit without fresh hardware
DecodeAssist state.  Populate the architectural EXITINFO1 field when
DecodeAssists is exposed to L1.

Provide the GPR number for MOV CR/DR, the interrupt vector for INTn, and
the linear address for INVLPG.  Leave EXITINFO1 clear for CLTS, LMSW,
SMSW, selective CR0 writes, and INVLPGA; the INVLPGA address remains in
guest rAX.  Leave EXITINFO1 unchanged when DecodeAssists is not exposed,
and leave unrelated intercepts unchanged.

Signed-off-by: Tina Zhang <zhang_wei@open-hieco.net>
---
 arch/x86/kvm/svm/svm.c | 32 +++++++++++++++++++++++++++++++-
 1 file changed, 31 insertions(+), 1 deletion(-)

diff --git a/arch/x86/kvm/svm/svm.c b/arch/x86/kvm/svm/svm.c
index ea647938a2a6..6834e1101bb6 100644
--- a/arch/x86/kvm/svm/svm.c
+++ b/arch/x86/kvm/svm/svm.c
@@ -4837,6 +4837,7 @@ static int svm_check_intercept(struct kvm_vcpu *vcpu,
 	int vmexit, ret = X86EMUL_CONTINUE;
 	struct __x86_intercept icpt_info;
 	struct vmcb *vmcb = svm->vmcb;
+	bool decode_assists;
 
 	if (info->intercept >= ARRAY_SIZE(x86_intercept_map))
 		goto out;
@@ -4846,14 +4847,26 @@ static int svm_check_intercept(struct kvm_vcpu *vcpu,
 	if (stage != icpt_info.stage)
 		goto out;
 
+	decode_assists = guest_cpu_cap_has(vcpu, X86_FEATURE_DECODEASSISTS);
+
 	switch (icpt_info.exit_code) {
 	case SVM_EXIT_READ_CR0:
 		if (info->intercept == x86_intercept_cr_read)
 			icpt_info.exit_code += info->modrm_reg;
+
+		if (decode_assists)
+			vmcb->control.exit_info_1 =
+				info->intercept == x86_intercept_cr_read ?
+				BIT_ULL(63) | (info->modrm_rm & 0xf) : 0;
 		break;
 	case SVM_EXIT_WRITE_CR0: {
 		unsigned long cr0, val;
 
+		if (decode_assists)
+			vmcb->control.exit_info_1 =
+				info->intercept == x86_intercept_cr_write ?
+				BIT_ULL(63) | (info->modrm_rm & 0xf) : 0;
+
 		/*
 		 * Adjust the exit code accordingly if a CR other than CR0 is
 		 * being written, and skip straight to the common handling as
@@ -4891,13 +4904,30 @@ static int svm_check_intercept(struct kvm_vcpu *vcpu,
 		 */
 		cr0 = vcpu->arch.cr0 & ~SVM_CR0_SELECTIVE_MASK;
 		val = info->src_val  & ~SVM_CR0_SELECTIVE_MASK;
-		if (cr0 ^ val)
+		if (cr0 ^ val) {
 			icpt_info.exit_code = SVM_EXIT_CR0_SEL_WRITE;
+			if (decode_assists)
+				vmcb->control.exit_info_1 = 0;
+		}
 		break;
 	}
 	case SVM_EXIT_READ_DR0:
 	case SVM_EXIT_WRITE_DR0:
 		icpt_info.exit_code += info->modrm_reg;
+		if (decode_assists)
+			vmcb->control.exit_info_1 = info->modrm_rm & 0xf;
+		break;
+	case SVM_EXIT_SWINT:
+		if (decode_assists)
+			vmcb->control.exit_info_1 = info->src_val & 0xff;
+		break;
+	case SVM_EXIT_INVLPG:
+		if (decode_assists)
+			vmcb->control.exit_info_1 = info->invlpg_linear_addr;
+		break;
+	case SVM_EXIT_INVLPGA:
+		if (decode_assists)
+			vmcb->control.exit_info_1 = 0;
 		break;
 	case SVM_EXIT_MSR:
 		if (info->intercept == x86_intercept_wrmsr)
-- 
2.43.7

