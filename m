Received: from out28-217.mail.aliyun.com (out28-217.mail.aliyun.com [115.124.28.217])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F48141B37D;
	Mon, 24 Aug 2026 12:40:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.28.217
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787575243; cv=none; b=Fgd8byv9EcVw6Qe+1neyiPo++nb+2nk1ZEPU+YNqe8dxrwZZvf6sjaGri61O1mLeiIMYbeYOU7CeNoGEDZhi0snL8cxqSkxK+q0PkBunhClBtrmWUII2hOGXqA3168UDp7JcdBURl3ccrN0qFAkOOzrVhc64Jn6C6xpDsWKSIec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787575243; c=relaxed/simple;
	bh=oQKj2gG7VT+v/fK2Y1FTo/AHvqiW7BLnSvF+geSP600=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LVELuUEUaERMD5QLcMc3KkCCYrulvnK30jMUQYQvY44lpy+gYupZvgCxxp59h1IVyqhdZqAVM/RJ17x7Y56axuVHl1UOR6Ej2/BSZL81/khTkBtpnwqUb8ytclf+bNpZh7qbcQVmRwF+nnBiUMpX5pMqBti0yoc5XubTczYxNw8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=open-hieco.net; spf=pass smtp.mailfrom=open-hieco.net; arc=none smtp.client-ip=115.124.28.217
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=open-hieco.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=open-hieco.net
X-Alimail-AntiSpam:AC=CONTINUE;BC=0.09897623|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_system_inform|0.0982147-9.01477e-05-0.901695;FP=4965848656623764659|1|1|1|0|-1|-1|-1;HT=maildocker-contentspam033032053168;MF=zhang_wei@open-hieco.net;NM=1;PH=DS;RN=9;RT=9;SR=0;TI=SMTPD_---.iw1ggtS_1787575225;
Received: from localhost.localdomain(mailfrom:zhang_wei@open-hieco.net fp:SMTPD_---.iw1ggtS_1787575225 cluster:ay29)
          by smtp.aliyun-inc.com;
          Mon, 24 Aug 2026 20:40:27 +0800
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
Subject: [PATCH v5 2/8] KVM: nSVM: Synthesize DecodeAssists EXITINFO for emulated intercepts
Date: Mon, 24 Aug 2026 20:39:48 +0800
Message-ID: <20260824123954.315112-3-zhang_wei@open-hieco.net>
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

