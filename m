Received: from out198-7.us.a.mail.aliyun.com (out198-7.us.a.mail.aliyun.com [47.90.198.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EDB441B37D;
	Thu, 30 Jul 2026 12:08:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=47.90.198.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785413333; cv=none; b=Laulb9X81UV1WVlAuVUIZ67JIlfzsUx/pzqEQh+LGzjwbMmBEmyp9EUfvRnpA/aefJbMfjPSu5wlDE4pVpuxAXffsBwRnil33Ep2mZ9xPbpQx6LtymcFgzfDoeJnGFjIHnM8GX7txBfMegjzPyUPT8PCAj4Jwu3At7sQWCzaFFg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785413333; c=relaxed/simple;
	bh=DVoGd2k7c3YJDk6Pu8bW9exF2yK1d6ma1PIF4O5Z+vU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QEjALAInI2ucYKe5XQ11q5iqXfi6TH4MfwP849x2YRkDoZMSWzuV0LeD209FgWdtBNIN1o1TLBkyTWPr5bnaCjMndXgeb2tcnFhJ4Ql5AT6NGnX0JBW/nCFsE+S9ObMj/JelIyAZrLH+Ls6hWeo2CZ9j8wYiQdKdWtW84DbPaxI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=open-hieco.net; spf=pass smtp.mailfrom=open-hieco.net; arc=none smtp.client-ip=47.90.198.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=open-hieco.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=open-hieco.net
X-Alimail-AntiSpam:AC=CONTINUE;BC=0.07643151|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_system_inform|0.0752867-0.000145675-0.924568;FP=17174877986327699443|0|0|0|0|-1|-1|-1;HT=maildocker-contentspam033037022039;MF=zhang_wei@open-hieco.net;NM=1;PH=DS;RN=9;RT=9;SR=0;TI=SMTPD_---.iZWlrrA_1785413316;
Received: from localhost.localdomain(mailfrom:zhang_wei@open-hieco.net fp:SMTPD_---.iZWlrrA_1785413316 cluster:ay29)
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
Subject: [PATCH v3 1/9] KVM: x86: Add helper to provide intercept linear addresses
Date: Thu, 30 Jul 2026 20:08:04 +0800
Message-ID: <233ea37ecf646692c2d2aa6d335643c3dbb1fe09.1785411877.git.zhang_wei@open-hieco.net>
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

Add get_intercept_linear_addr() to compute the linear address for
intercepts that report one, and pass the result through
x86_instruction_info.

Handle INVLPG as the initial user.  INVLPG's memory operand is decoded
with NoAccess, and thus src_val does not contain the operand address.
Compute the address from the decoded segment base and effective address
in the emulator, where the operand state is available.

This allows intercept handlers to use the linear address directly
without duplicating the emulator's address calculation.

Signed-off-by: Tina Zhang <zhang_wei@open-hieco.net>
---
 arch/x86/kvm/emulate.c     | 29 +++++++++++++++++++++--------
 arch/x86/kvm/kvm_emulate.h |  1 +
 2 files changed, 22 insertions(+), 8 deletions(-)

diff --git a/arch/x86/kvm/emulate.c b/arch/x86/kvm/emulate.c
index 8071b372d233..a0e57b64cadd 100644
--- a/arch/x86/kvm/emulate.c
+++ b/arch/x86/kvm/emulate.c
@@ -410,6 +410,26 @@ static int em_salc(struct x86_emulate_ctxt *ctxt)
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
@@ -427,6 +447,7 @@ static int emulator_check_intercept(struct x86_emulate_ctxt *ctxt,
 		.src_type   = ctxt->src.type,
 		.dst_type   = ctxt->dst.type,
 		.ad_bytes   = ctxt->ad_bytes,
+		.intercept_linear_addr = get_intercept_linear_addr(ctxt, intercept),
 		.rip	    = ctxt->eip,
 		.next_rip   = ctxt->_eip,
 	};
@@ -520,14 +541,6 @@ static u32 desc_limit_scaled(struct desc_struct *desc)
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
index 3e375af15c03..9eda648a1314 100644
--- a/arch/x86/kvm/kvm_emulate.h
+++ b/arch/x86/kvm/kvm_emulate.h
@@ -51,6 +51,7 @@ struct x86_instruction_info {
 	u8  src_type;		/* type of source operand		*/
 	u8  dst_type;		/* type of destination operand		*/
 	u8  ad_bytes;           /* size of src/dst address              */
+	u64 intercept_linear_addr;	/* arch-reported linear address, if any */
 	u64 rip;		/* rip of the instruction		*/
 	u64 next_rip;           /* rip following the instruction        */
 };
-- 
2.43.7

