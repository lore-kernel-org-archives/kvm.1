Received: from out198-21.us.a.mail.aliyun.com (out198-21.us.a.mail.aliyun.com [47.90.198.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D55D721B192;
	Wed, 19 Aug 2026 05:52:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=47.90.198.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787118728; cv=none; b=b5mYB/yWRssImPwQrimmaVuGD8nEQmO66m1+jNORxlJ1KFLPiIGtqf0uF4X71IVm3oNcNiWSTd72PN1zNhih8usxHS5YbZx29rtbVgANcfovpLPAI8eG3PG8Q0OoGoy5OKnRBJEx8RI6MEZ33BnHcrCwD9QXTLOrlG3fvlH/PqU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787118728; c=relaxed/simple;
	bh=oQKj2gG7VT+v/fK2Y1FTo/AHvqiW7BLnSvF+geSP600=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RsjuotcoNYeQPTzk+nY0N8M23YWC0s+bZJ7ENW1ds3qTYwnuDMlktqqXPQGH6j7+iGJZlWMUupKMTcDk5hX6qjoL5vi1jqWZHa0MIsja8RYXOhs536dd+DJKGjWxsLcTFf3vtenO5iMU46VN1xgNGcc2patMzRhogSaWyUr8vHM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=open-hieco.net; spf=pass smtp.mailfrom=open-hieco.net; arc=none smtp.client-ip=47.90.198.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=open-hieco.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=open-hieco.net
X-Alimail-AntiSpam:AC=CONTINUE;BC=0.1009196|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_system_inform|0.0982147-9.01477e-05-0.901695;FP=4965848617968993459|1|1|1|0|-1|-1|-1;HT=maildocker-contentspam033037025160;MF=zhang_wei@open-hieco.net;NM=1;PH=DS;RN=9;RT=9;SR=0;TI=SMTPD_---.ir-3Hbl_1787118708;
Received: from localhost.localdomain(mailfrom:zhang_wei@open-hieco.net fp:SMTPD_---.ir-3Hbl_1787118708 cluster:ay29)
          by smtp.aliyun-inc.com;
          Wed, 19 Aug 2026 13:51:48 +0800
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
Subject: [PATCH v4 2/9] KVM: nSVM: Synthesize DecodeAssists EXITINFO for emulated intercepts
Date: Wed, 19 Aug 2026 13:51:17 +0800
Message-ID: <083e80aeb0c49620871e719a0ee81a2b80338d96.1787116250.git.zhang_wei@open-hieco.net>
X-Mailer: git-send-email 2.43.7
In-Reply-To: <cover.1787116250.git.zhang_wei@open-hieco.net>
References: <cover.1787116250.git.zhang_wei@open-hieco.net>
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
index 9d607b98bd06..c7c1f1527c3c 100644
--- a/arch/x86/kvm/svm/svm.c
+++ b/arch/x86/kvm/svm/svm.c
@@ -4810,6 +4810,52 @@ static const struct __x86_intercept {
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
@@ -4931,6 +4977,8 @@ static int svm_check_intercept(struct kvm_vcpu *vcpu,
 		break;
 	}
 
+	svm_prepare_decode_assist_exit_info(vcpu, info);
+
 	/* TODO: Advertise NRIPS to guest hypervisor unconditionally */
 	if (static_cpu_has(X86_FEATURE_NRIPS))
 		vmcb->control.next_rip  = info->next_rip;
-- 
2.43.7

