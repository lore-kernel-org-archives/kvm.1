Received: from out28-145.mail.aliyun.com (out28-145.mail.aliyun.com [115.124.28.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CE802EEE88;
	Tue, 14 Jul 2026 05:10:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.28.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784005850; cv=none; b=uGRsLpPg1EhNfPiHtxwl7k2StrWENo2p8EnkQMAhLFscgucV5B2PUI8M+DvPrbdxdr8aLc8YMmlUZCFGgZcFfAnh5IgBUqsapoddlVPS6K7aInX2R3XyIM96Ox74WVxhGBQN2NO3mPbQc9WVblzcjGeHvhsZfSoQmkUt//4rA88=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784005850; c=relaxed/simple;
	bh=pQIQs+5gmtpHA1a9k1pi8+2qzdJacoqncWTMdmFXoUw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UHmEjJDt3yO28jrQDWyfqMA9yUqTAoDXj/K43RfuxpVja7IRIsY6lkF59V0nvCn2K2lSPV1c8aBLIH/Q9k5D/I/GddBEXYiks7TY+GobOZ+46w5cxX1671ZmipfSDmDRMoFnp8mvMtfmc+zAQxDN94j/3H2MA1/IxMujS7HpWak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=open-hieco.net; spf=pass smtp.mailfrom=open-hieco.net; arc=none smtp.client-ip=115.124.28.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=open-hieco.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=open-hieco.net
X-Alimail-AntiSpam:AC=CONTINUE;BC=0.07876458|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_alarm|0.130429-0.00019804-0.869373;FP=16580402972953747187|0|0|0|0|-1|-1|-1;HT=maildocker-contentspam033045018182;MF=zhang_wei@open-hieco.net;NM=1;PH=DS;RN=9;RT=9;SR=0;TI=SMTPD_---.iKeOCX9_1784005835;
Received: from localhost.localdomain(mailfrom:zhang_wei@open-hieco.net fp:SMTPD_---.iKeOCX9_1784005835 cluster:ay29)
          by smtp.aliyun-inc.com;
          Tue, 14 Jul 2026 13:10:35 +0800
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
Subject: [PATCH v2 1/8] KVM: x86: Add intercept_linear_addr to x86_instruction_info
Date: Tue, 14 Jul 2026 13:09:57 +0800
Message-ID: <6a7b096f43b0e97c6690160a407fd52162cfc1e6.1783999988.git.zhang_wei@open-hieco.net>
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

Add intercept_linear_addr to x86_instruction_info so that the emulator
can pass linear addresses needed by intercept handlers.

Populate the field for INVLPG from its decoded memory operand.  INVLPG
is decoded with NoAccess, and therefore src_val does not contain the
operand address.  Calculate the address in the emulator, where the
decoded segment and effective address are available.

Signed-off-by: Tina Zhang <zhang_wei@open-hieco.net>
---
 arch/x86/kvm/emulate.c     | 30 ++++++++++++++++++++++--------
 arch/x86/kvm/kvm_emulate.h |  1 +
 2 files changed, 23 insertions(+), 8 deletions(-)

diff --git a/arch/x86/kvm/emulate.c b/arch/x86/kvm/emulate.c
index 8013dccb3110..03bf95417275 100644
--- a/arch/x86/kvm/emulate.c
+++ b/arch/x86/kvm/emulate.c
@@ -410,6 +410,27 @@ static int em_salc(struct x86_emulate_ctxt *ctxt)
 	_fault ? X86EMUL_UNHANDLEABLE : X86EMUL_CONTINUE; \
 })
 
+static unsigned long seg_base(struct x86_emulate_ctxt *ctxt, int seg)
+{
+	if (ctxt->mode == X86EMUL_MODE_PROT64 && seg < VCPU_SREG_FS)
+		return 0;
+
+	return ctxt->ops->get_cached_segment_base(ctxt, seg);
+}
+
+/* Return the linear address for intercepts that report one. */
+static u64 get_intercept_linear_addr(struct x86_emulate_ctxt *ctxt,
+				     enum x86_intercept intercept)
+{
+	u64 la;
+
+	if (intercept != x86_intercept_invlpg)
+		return 0;
+
+	la = seg_base(ctxt, ctxt->src.addr.mem.seg) + ctxt->src.addr.mem.ea;
+	return ctxt->mode == X86EMUL_MODE_PROT64 ? la : (u32)la;
+}
+
 static int emulator_check_intercept(struct x86_emulate_ctxt *ctxt,
 				    enum x86_intercept intercept,
 				    enum x86_intercept_stage stage)
@@ -427,6 +448,7 @@ static int emulator_check_intercept(struct x86_emulate_ctxt *ctxt,
 		.src_type   = ctxt->src.type,
 		.dst_type   = ctxt->dst.type,
 		.ad_bytes   = ctxt->ad_bytes,
+		.intercept_linear_addr = get_intercept_linear_addr(ctxt, intercept),
 		.rip	    = ctxt->eip,
 		.next_rip   = ctxt->_eip,
 	};
@@ -520,14 +542,6 @@ static u32 desc_limit_scaled(struct desc_struct *desc)
 	return desc->g ? (limit << 12) | 0xfff : limit;
 }
 
-static unsigned long seg_base(struct x86_emulate_ctxt *ctxt, int seg)
-{
-	if (ctxt->mode == X86EMUL_MODE_PROT64 && seg < VCPU_SREG_FS)
-		return 0;
-
-	return ctxt->ops->get_cached_segment_base(ctxt, seg);
-}
-
 static int emulate_exception(struct x86_emulate_ctxt *ctxt, int vec,
 			     u32 error, bool valid)
 {
diff --git a/arch/x86/kvm/kvm_emulate.h b/arch/x86/kvm/kvm_emulate.h
index 0abff36d0994..900bd95e9e55 100644
--- a/arch/x86/kvm/kvm_emulate.h
+++ b/arch/x86/kvm/kvm_emulate.h
@@ -47,6 +47,7 @@ struct x86_instruction_info {
 	u8  src_type;		/* type of source operand		*/
 	u8  dst_type;		/* type of destination operand		*/
 	u8  ad_bytes;           /* size of src/dst address              */
+	u64 intercept_linear_addr;	/* arch-reported linear address, if any */
 	u64 rip;		/* rip of the instruction		*/
 	u64 next_rip;           /* rip following the instruction        */
 };
-- 
2.43.7

