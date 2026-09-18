Received: from out198-9.us.a.mail.aliyun.com (out198-9.us.a.mail.aliyun.com [47.90.198.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C7E248CD55;
	Fri, 18 Sep 2026 08:56:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=47.90.198.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789721817; cv=none; b=fmb0f7/mmQptom1WJYik6ITRx2VgduTuik1EoRQon4ZHtFoeNiCTZ99Zh3GcEMx42lwVsXNJMeZaVPIo2l5TOef1v5E8O56uXFltPiC8/zEVyIe1NUPOnWLYM+buFqpFAJQVCxZwAQ/eSTiNnugwkFcxzeAyXlM427Z0GmgNj08=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789721817; c=relaxed/simple;
	bh=BHNgv2FTupZU8JntjR1wmat88mdo8D11gHTxj+pZr/E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=afs5EW8r0qHcsk0q2I32GcRXVAN8BUJbztfdV4Cv4zIvUkvMN/XtfSkM1l8s4kueO8fWTMEES0P+W3JxShlcztSRyKo0JGdqBfNm25RWlFok1kNhogA38oWZn8YvdUZ8bWtbLwXw2phMo0+kFMrHxt5GSLwBev38lCZx0VJnOFM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=open-hieco.net; spf=pass smtp.mailfrom=open-hieco.net; arc=none smtp.client-ip=47.90.198.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=open-hieco.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=open-hieco.net
X-Alimail-AntiSpam:AC=CONTINUE;BC=0.1630166|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_system_inform|0.0297771-0.000281065-0.969942;FP=17185029095361038327|0|0|0|0|-1|-1|-1;HT=maildocker-contentspam033045220102;MF=zhang_wei@open-hieco.net;NM=1;PH=DS;RN=8;RT=8;SR=0;TI=SMTPD_---.jGgS5O5_1789721786;
Received: from localhost.localdomain(mailfrom:zhang_wei@open-hieco.net fp:SMTPD_---.jGgS5O5_1789721786 cluster:ay29)
          by smtp.aliyun-inc.com;
          Fri, 18 Sep 2026 16:56:26 +0800
From: Tina Zhang <zhang_wei@open-hieco.net>
To: Sean Christopherson <seanjc@google.com>,
	Jim Mattson <jmattson@google.com>,
	kvm@vger.kernel.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
	Shuah Khan <shuah@kernel.org>,
	zhouyanjing@hygon.cn,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v7 1/8] KVM: x86: Provide INVLPG linear address to intercept handlers
Date: Fri, 18 Sep 2026 16:56:11 +0800
Message-ID: <2d608f82681532f3010db14ff8d4293f57620514.1789721173.git.zhang_wei@open-hieco.net>
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

INVLPG's memory operand is decoded with NoAccess, and thus src_val does
not contain the operand address.  Intercept handlers therefore cannot
construct exit state that reports the linear address from the existing
x86_instruction_info fields.

Add get_invlpg_linear_addr() to compute the address through __linearize(),
using the same flags as em_invlpg(), and pass the result through
x86_instruction_info.

Signed-off-by: Tina Zhang <zhang_wei@open-hieco.net>
---
 arch/x86/kvm/emulate.c     | 23 +++++++++++++++++++++++
 arch/x86/kvm/kvm_emulate.h |  1 +
 2 files changed, 24 insertions(+)

diff --git a/arch/x86/kvm/emulate.c b/arch/x86/kvm/emulate.c
index c1b21282187f..2972a35b0ac0 100644
--- a/arch/x86/kvm/emulate.c
+++ b/arch/x86/kvm/emulate.c
@@ -411,6 +411,9 @@ static int em_salc(struct x86_emulate_ctxt *ctxt)
 	_fault ? X86EMUL_UNHANDLEABLE : X86EMUL_CONTINUE; \
 })
 
+static u64 get_invlpg_linear_addr(struct x86_emulate_ctxt *ctxt,
+				  enum x86_intercept intercept);
+
 static int emulator_check_intercept(struct x86_emulate_ctxt *ctxt,
 				    enum x86_intercept intercept,
 				    enum x86_intercept_stage stage)
@@ -428,6 +431,7 @@ static int emulator_check_intercept(struct x86_emulate_ctxt *ctxt,
 		.src_type   = ctxt->src.type,
 		.dst_type   = ctxt->dst.type,
 		.ad_bytes   = ctxt->ad_bytes,
+		.invlpg_linear_addr = get_invlpg_linear_addr(ctxt, intercept),
 		.rip	    = ctxt->eip,
 		.next_rip   = ctxt->_eip,
 	};
@@ -684,6 +688,25 @@ static __always_inline int __linearize(struct x86_emulate_ctxt *ctxt,
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
+	/*
+	 * Use the same address calculation as em_invlpg() for the address
+	 * reported to L1.  Ignore address-check failures, as __linearize()
+	 * sets linear before reporting a failure.
+	 */
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

