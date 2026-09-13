Received: from out198-3.us.a.mail.aliyun.com (out198-3.us.a.mail.aliyun.com [47.90.198.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1A6538C40C;
	Sun, 13 Sep 2026 06:44:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=47.90.198.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789281861; cv=none; b=oaHZAdLFsX47KPwZ1Kk4W9WhqtWSQpJOnlKf4j+0eSqkO/obGsZShTFpEcd9Q1DtFTBk217MxLq6AjGrYJxjY1F53GHQhsrJmy8r4C4QDQM12Zqh+uDOw60uYnhZuue3RNC+0UECWf5GJuCAJ3wN8ZfzZY6cc9+wcc9jStVHNGs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789281861; c=relaxed/simple;
	bh=wAfoApbiKg4FZ0HY+eTjuhQKVqQcrN2b3NJl72iRBF8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XccSIMQ5CBLC4AANytC11hl47icBqtpHsPPsr8fpHCL+mxFrO3gE16gwpM706PzOYbyBEIAKxN3q8rbV+R+ldu61xB4EJGr7akpL/1ppaKvdxvPyo2242OrpLhWIDFHgR/w1qPob0oFlh2EKhQ3v8SjADscKC3Rsq1d2kJcOzJ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=open-hieco.net; spf=pass smtp.mailfrom=open-hieco.net; arc=none smtp.client-ip=47.90.198.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=open-hieco.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=open-hieco.net
X-Alimail-AntiSpam:AC=CONTINUE;BC=0.2039089|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_regular_dialog|0.0302074-0.000243454-0.969549;FP=17183902916247750647|0|0|0|0|-1|-1|-1;HT=maildocker-contentspam033022149254;MF=zhang_wei@open-hieco.net;NM=1;PH=DS;RN=8;RT=8;SR=0;TI=SMTPD_---.jCORvlD_1789281834;
Received: from localhost.localdomain(mailfrom:zhang_wei@open-hieco.net fp:SMTPD_---.jCORvlD_1789281834 cluster:ay29)
          by smtp.aliyun-inc.com;
          Sun, 13 Sep 2026 14:43:55 +0800
From: Tina Zhang <zhang_wei@open-hieco.net>
To: Sean Christopherson <seanjc@google.com>,
	Jim Mattson <jmattson@google.com>,
	kvm@vger.kernel.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
	Shuah Khan <shuah@kernel.org>,
	zhouyanjing@hygon.cn,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v6 1/8] KVM: x86: Provide INVLPG linear address to intercept handlers
Date: Sun, 13 Sep 2026 14:43:41 +0800
Message-ID: <fc88f299f41c99ddb5851c24d97970dc29584876.1789281096.git.zhang_wei@open-hieco.net>
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

INVLPG's memory operand is decoded with NoAccess, and thus src_val does
not contain the operand address.  Intercept handlers therefore cannot
construct exit state that reports the linear address from the existing
x86_instruction_info fields.

Add get_invlpg_linear_addr() to compute the address through __linearize(),
using the same flags as em_invlpg(), and pass the result through
x86_instruction_info.

Signed-off-by: Tina Zhang <zhang_wei@open-hieco.net>
---
 arch/x86/kvm/emulate.c     | 18 ++++++++++++++++++
 arch/x86/kvm/kvm_emulate.h |  1 +
 2 files changed, 19 insertions(+)

diff --git a/arch/x86/kvm/emulate.c b/arch/x86/kvm/emulate.c
index 8071b372d233..1dfece6af81e 100644
--- a/arch/x86/kvm/emulate.c
+++ b/arch/x86/kvm/emulate.c
@@ -410,6 +410,9 @@ static int em_salc(struct x86_emulate_ctxt *ctxt)
 	_fault ? X86EMUL_UNHANDLEABLE : X86EMUL_CONTINUE; \
 })
 
+static u64 get_invlpg_linear_addr(struct x86_emulate_ctxt *ctxt,
+				  enum x86_intercept intercept);
+
 static int emulator_check_intercept(struct x86_emulate_ctxt *ctxt,
 				    enum x86_intercept intercept,
 				    enum x86_intercept_stage stage)
@@ -427,6 +430,7 @@ static int emulator_check_intercept(struct x86_emulate_ctxt *ctxt,
 		.src_type   = ctxt->src.type,
 		.dst_type   = ctxt->dst.type,
 		.ad_bytes   = ctxt->ad_bytes,
+		.invlpg_linear_addr = get_invlpg_linear_addr(ctxt, intercept),
 		.rip	    = ctxt->eip,
 		.next_rip   = ctxt->_eip,
 	};
@@ -702,6 +706,20 @@ static __always_inline int __linearize(struct x86_emulate_ctxt *ctxt,
 		return emulate_gp(ctxt, 0);
 }
 
+static u64 get_invlpg_linear_addr(struct x86_emulate_ctxt *ctxt,
+				  enum x86_intercept intercept)
+{
+	unsigned int max_size;
+	unsigned long linear = 0;
+
+	if (intercept != x86_intercept_invlpg)
+		return 0;
+
+	__linearize(ctxt, ctxt->src.addr.mem, &max_size, 1, ctxt->mode,
+		    &linear, X86EMUL_F_INVLPG);
+	return linear;
+}
+
 static int linearize(struct x86_emulate_ctxt *ctxt,
 		     struct segmented_address addr,
 		     unsigned size, bool write,
diff --git a/arch/x86/kvm/kvm_emulate.h b/arch/x86/kvm/kvm_emulate.h
index 3e375af15c03..d05558ef28ae 100644
--- a/arch/x86/kvm/kvm_emulate.h
+++ b/arch/x86/kvm/kvm_emulate.h
@@ -51,6 +51,7 @@ struct x86_instruction_info {
 	u8  src_type;		/* type of source operand		*/
 	u8  dst_type;		/* type of destination operand		*/
 	u8  ad_bytes;           /* size of src/dst address              */
+	u64 invlpg_linear_addr;	/* linear address, if INVLPG */
 	u64 rip;		/* rip of the instruction		*/
 	u64 next_rip;           /* rip following the instruction        */
 };
-- 
2.43.7

