Received: from out28-173.mail.aliyun.com (out28-173.mail.aliyun.com [115.124.28.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DD034A6CFB;
	Fri, 18 Sep 2026 08:56:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.28.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789721805; cv=none; b=g3Ks/qGsM2xYW0fGWQMl4lB4ZeS/5RX+Q2eu+khvC1SlxiTTqdZTs2sstkeFBw4hQdB2h5HYNgrLdbmKx0E6KZnSnJgNgD4DP7kmg+A+pMQM39F3bwJrj8Pn2gaYQ3+O6Ufv83xswINhAZCJ/4HSHn4GM02BHaEFSuDdP/ZmcD4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789721805; c=relaxed/simple;
	bh=q/jrRFTbP7ROaTK4FUqOWWE6YjOvkIR4dZveVTKToL0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mY+jVU4Z8h28Za+lCAbPFU2dzUXwW6eWMdU9rp6E3SpR0YnV4OwvHLBPa99E1OonYOV2LMtY51qsnpU72S2s1/hOyL0DQn+BwoiF330c2R/yQoToZdX+GSKNwgr3efk3vWUIE8+UxHNUP8S1OU+Sgqiw/E1NCMWhcZHyBED5do8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=open-hieco.net; spf=pass smtp.mailfrom=open-hieco.net; arc=none smtp.client-ip=115.124.28.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=open-hieco.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=open-hieco.net
X-Alimail-AntiSpam:AC=CONTINUE;BC=0.2100021|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_regular_dialog|0.158478-0.00122291-0.840299;FP=4966202699363141559|1|1|1|0|-1|-1|-1;HT=maildocker-contentspam011083013073;MF=zhang_wei@open-hieco.net;NM=1;PH=DS;RN=8;RT=8;SR=0;TI=SMTPD_---.jGgS5Oq_1789721787;
Received: from localhost.localdomain(mailfrom:zhang_wei@open-hieco.net fp:SMTPD_---.jGgS5Oq_1789721787 cluster:ay29)
          by smtp.aliyun-inc.com;
          Fri, 18 Sep 2026 16:56:27 +0800
From: Tina Zhang <zhang_wei@open-hieco.net>
To: Sean Christopherson <seanjc@google.com>,
	Jim Mattson <jmattson@google.com>,
	kvm@vger.kernel.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
	Shuah Khan <shuah@kernel.org>,
	zhouyanjing@hygon.cn,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v7 2/8] KVM: nSVM: Synthesize DecodeAssists EXITINFO for emulated intercepts
Date: Fri, 18 Sep 2026 16:56:12 +0800
Message-ID: <2b30c180a7ec1fb22033cc1b89debc36c9f569d0.1789721173.git.zhang_wei@open-hieco.net>
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

When the x86 emulator encounters an instruction intercepted by L1,
svm_check_intercept() synthesizes a nested VM-Exit without fresh hardware
DecodeAssist state.  Populate the architectural EXITINFO1 field when
DecodeAssists is exposed to L1.

Provide the GPR number for MOV CR/DR, the interrupt vector for INTn, and
the linear address for INVLPG.  Preserve the MOV-to-CR0 decode information
when a selective CR0 write intercept is triggered.  Leave EXITINFO1 clear
for CLTS, LMSW, SMSW, and INVLPGA; the INVLPGA address remains in guest
rAX.  Leave EXITINFO1 unchanged when DecodeAssists is not exposed, and
leave unrelated intercepts unchanged.

Signed-off-by: Tina Zhang <zhang_wei@open-hieco.net>
---
 arch/x86/kvm/svm/svm.c | 27 +++++++++++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/arch/x86/kvm/svm/svm.c b/arch/x86/kvm/svm/svm.c
index f5aa3d7d3a10..e83e4e5e7b93 100644
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
+				CR_VALID | (info->modrm_rm & SVM_EXITINFO_REG_MASK) : 0;
 		break;
 	case SVM_EXIT_WRITE_CR0: {
 		unsigned long cr0, val;
 
+		if (decode_assists)
+			vmcb->control.exit_info_1 =
+				info->intercept == x86_intercept_cr_write ?
+				CR_VALID | (info->modrm_rm & SVM_EXITINFO_REG_MASK) : 0;
+
 		/*
 		 * Adjust the exit code accordingly if a CR other than CR0 is
 		 * being written, and skip straight to the common handling as
@@ -4898,6 +4911,20 @@ static int svm_check_intercept(struct kvm_vcpu *vcpu,
 	case SVM_EXIT_READ_DR0:
 	case SVM_EXIT_WRITE_DR0:
 		icpt_info.exit_code += info->modrm_reg;
+		if (decode_assists)
+			vmcb->control.exit_info_1 = info->modrm_rm & SVM_EXITINFO_REG_MASK;
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

