Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com [209.85.215.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FA843BFAD9
	for <kvm@vger.kernel.org>; Wed,  8 Jul 2026 03:36:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783481797; cv=none; b=PbwVhRJyIulgqBx+rJVf/F6N1hu0hOnmBcee6xZVK+bikk89L8xZ+n5wEosXJBOWqsiaWnF6xDOjR+/ug0ETDASnNfPtBLaEJXgVqmUnRjM7fYiDeIpFELPFiYbyOHHwX/Gg0y29qigLw0DtKKxBOur8agM9YPmHD2cP1KJSYKE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783481797; c=relaxed/simple;
	bh=8h6OBVit0ds2zZ8RVCdpLv2LV7rJmlpswIauG6njnhM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=XepqAmvZyRpQ7lTzgWoXHxOsObi5J172PIooVwCBigCN8MQEFqhNoTzp9QnSEzjsnsq0beYdlSxbWzHJdMJ7qYP1ZdNHUH2KYdLAFuzSRjTqheF9cpR9+php13sLEmE4QrZjLHRv8H7LgYcTwP+7X4Tya2N4ylMKFwWzNo/7VqM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=D6+tJvg1; arc=none smtp.client-ip=209.85.215.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="D6+tJvg1"
Received: by mail-pg1-f177.google.com with SMTP id 41be03b00d2f7-c95d0a54ea5so133372a12.0
        for <kvm@vger.kernel.org>; Tue, 07 Jul 2026 20:36:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783481795; x=1784086595; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=SQP7Zg98ed5QAQ3p607k58/RvHAX4L5abtdMGBqW+Xg=;
        b=D6+tJvg1sORIrpBWx1b9M9Kr9l49uXZ5BBXVByA3yCVXnZgvFlyjmpZdOrl+Jzvpph
         Nt3o4wqD8yGHoYNys6IxFUO+8iIz/8q5GQ5ONFs58YR2HkkVCXul9ypfauCtOGbYcq+6
         SW3JEsckAF//gCiF3MLmd+AHvJ+lumk8+eq564+MWlBZHu46K0VvTbthpjXAu+CDtT7n
         c3TSyEBv4Mal0XEeqnbdifh8rPzMymrTVREqob8S/vdmYmcaoFIGf4/Bix+0IBVXG+o/
         D0Ce5+FmTbtE7gblnJHIx8/wuhhHZ/A49vbxBlW0xeGj7cuALkDrqnUNzFT9mcnbejV5
         PSNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783481795; x=1784086595;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=SQP7Zg98ed5QAQ3p607k58/RvHAX4L5abtdMGBqW+Xg=;
        b=KfjW/KVMywZagmNRK6RLYy3sHVku9uC4G1xY/aTf5LtGOllYc3Q6ashtFFQNEpUZ16
         WGKDLXHxtvbDa9JxfHb2iKMeuYXYyQ/XeMbRd1wAIfH14EQLjpwTCDx78uXHlamJgyrP
         MxMuBhsdN1BBCzuKcfKyLP7YO/cE3n73/QrqpGQarTPvyLmmtIc4/70pe6KP35d7MJez
         xHyEHT8Q2lc6zo7a8L/b014Wd513rzfJ7xmqzt85Ugqcexv8nIJbmwkx6GSx8H5nKKQz
         tjn4xv0z6RtLDqehUy9rsjrHXtlt7Ft7JUEsBqQ258yI494bdi4/E4cjzQwe1G53mEOj
         eUBg==
X-Forwarded-Encrypted: i=1; AHgh+RqWLXNRYKU3cOQa9qSikhToG8lUQwhrwqbKLo8g3Cmne9uE0KOyCLjuuG72HUpXZMcueXA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy7oqxHvb2XjGjIVjrhuR473Q9wqqGnFJVroHxGrCJ7c4aV9Vqu
	6HTXBwxideEaerLNHe2FeZ4ECEIgV+22NaTJaoxOHIPEiTCDaqoUy4+b
X-Gm-Gg: AfdE7cklZiMuEEGfp9VFU1Ek0bGqTYlWgcSRNPA3/SkHZXCk0E9nEW54G4X3gtGyDre
	S6fqDpHcpWEWmmtgZwdlASJS/R7eysRYJ7YOETavn6UYSAtWxafKVHL9ogWfVESGJGSJAMTxwqf
	1oY+aukNoMeFJwv0dV+WPpxEP6/1nq4YAqzg0Dn2YZeeXTSdvTcizImUX4zHKd7+SuSUdE9roYv
	/Hk0FwwXsEcqpcw2v+/STX1rH5MgU5IPCJ3J8tcHQXCbYwjJEZsJH7esPsQtpEnyxd/eXq4y0h6
	WyYT14lnaycPgmu5GJMdIHZkolDVWdquOjvw4kHDjiWaNF2l/iLDMo0Niwt97CesxFsntJmLCPn
	3rOHOaHOOzTOmh515BcfbPHH3uPcGplyVoO6qPELi9FeGXNvdosIPDSMwE9y4Nk52WSihUmfJXC
	rl+rIAGzL+4inxfHrtlda53xeBSCdZJ3DtOE7IhLM=
X-Received: by 2002:a05:6a20:12d0:b0:3bf:b182:94e with SMTP id adf61e73a8af0-3c0bc8c3838mr706484637.5.1783481794544;
        Tue, 07 Jul 2026 20:36:34 -0700 (PDT)
Received: from [10.0.0.65] ([2601:647:6700:64d0::94ac])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-31174accae5sm21092850eec.29.2026.07.07.20.36.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jul 2026 20:36:34 -0700 (PDT)
From: Charlie Jenkins <thecharlesjenkins@gmail.com>
Date: Tue, 07 Jul 2026 20:34:32 -0700
Subject: [PATCH v3 09/17] riscv: kvm: Use generated instruction headers for
 csr code
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260707-riscv_insn_table-v3-9-3f8e5f75ba97@gmail.com>
References: <20260707-riscv_insn_table-v3-0-3f8e5f75ba97@gmail.com>
In-Reply-To: <20260707-riscv_insn_table-v3-0-3f8e5f75ba97@gmail.com>
To: Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>, 
 Nam Cao <namcao@linutronix.de>, Alexandre Ghiti <alex@ghiti.fr>, 
 Anup Patel <anup@brainfault.org>, Atish Patra <atish.patra@linux.dev>, 
 Conor Dooley <conor@kernel.org>, Paolo Bonzini <pbonzini@redhat.com>, 
 Andrew Morton <akpm@linux-foundation.org>, Shuah Khan <shuah@kernel.org>, 
 =?utf-8?q?Radim_Kr=C4=8Dm=C3=A1=C5=99?= <radim.krcmar@oss.qualcomm.com>, 
 Jesse Taube <jtaubepe@redhat.com>
Cc: linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org, 
 kvm@vger.kernel.org, kvm-riscv@lists.infradead.org, 
 linux-kselftest@vger.kernel.org, 
 Charlie Jenkins <thecharlesjenkins@gmail.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1783481777; l=3063;
 i=thecharlesjenkins@gmail.com; s=20260605; h=from:subject:message-id;
 bh=8h6OBVit0ds2zZ8RVCdpLv2LV7rJmlpswIauG6njnhM=;
 b=nvPyCvQ98MT+LzRjxR/eVGC5foeEGKAjYI/KWit5kqNp0b4lsnz1ixztK11IvVWEoTuM2qj9P
 MpHVRzte8/HCD0KZ4tfz44btH0dFJxu0tvHmYpcZ8QBhsv3AvWMzkeH
X-Developer-Key: i=thecharlesjenkins@gmail.com; a=ed25519;
 pk=ajnnRQ98PIdwKp4HeMkq9U32okYbnh6Zb4G3o5XXvkg=

Migrate the csr parsing code to use the generated instruction headers
instead of the hand-written instruction composition functions.

Signed-off-by: Charlie Jenkins <thecharlesjenkins@gmail.com>

---

This is a simple transformation that I have again validated through
brute force.
---
 arch/riscv/kvm/vcpu_insn.c | 50 +++++++++++++++++++++++++---------------------
 1 file changed, 27 insertions(+), 23 deletions(-)

diff --git a/arch/riscv/kvm/vcpu_insn.c b/arch/riscv/kvm/vcpu_insn.c
index f09f9251d1f0..a1898ab8bbe8 100644
--- a/arch/riscv/kvm/vcpu_insn.c
+++ b/arch/riscv/kvm/vcpu_insn.c
@@ -144,45 +144,49 @@ int kvm_riscv_vcpu_csr_return(struct kvm_vcpu *vcpu, struct kvm_run *run)
 	return 0;
 }
 
+static inline unsigned long get_reg(struct kvm_cpu_context *context, unsigned int rd)
+{
+	return *((unsigned long *)(context) + rd);
+}
+
 static int csr_insn(struct kvm_vcpu *vcpu, struct kvm_run *run, ulong insn)
 {
 	int i, rc = KVM_INSN_ILLEGAL_TRAP;
-	unsigned int csr_num = insn >> SH_RS2;
-	unsigned int rs1_num = (insn >> SH_RS1) & MASK_RX;
-	ulong rs1_val = GET_RS1(insn, &vcpu->arch.guest_context);
+	unsigned int csr_num;
 	const struct csr_func *tcfn, *cfn = NULL;
 	ulong val = 0, wr_mask = 0, new_val = 0;
 
 	/* Decode the CSR instruction */
-	switch (GET_FUNCT3(insn)) {
-	case GET_FUNCT3(INSN_MATCH_CSRRW):
+	if (riscv_insn_is_csrrw(insn)) {
 		wr_mask = -1UL;
-		new_val = rs1_val;
-		break;
-	case GET_FUNCT3(INSN_MATCH_CSRRS):
-		wr_mask = rs1_val;
+		new_val = get_reg(&vcpu->arch.guest_context, riscv_insn_csrrw_extract_xs1(insn));
+		csr_num = riscv_insn_csrrw_extract_csr(insn);
+	} else if (riscv_insn_is_csrrs(insn)) {
+		wr_mask = get_reg(&vcpu->arch.guest_context, riscv_insn_csrrs_extract_xs1(insn));
 		new_val = -1UL;
-		break;
-	case GET_FUNCT3(INSN_MATCH_CSRRC):
-		wr_mask = rs1_val;
+		csr_num = riscv_insn_csrrs_extract_csr(insn);
+	} else if (riscv_insn_is_csrrc(insn)) {
+		wr_mask = get_reg(&vcpu->arch.guest_context, riscv_insn_csrrc_extract_xs1(insn));
 		new_val = 0;
-		break;
-	case GET_FUNCT3(INSN_MATCH_CSRRWI):
+		csr_num = riscv_insn_csrrc_extract_csr(insn);
+	} else if (riscv_insn_is_csrrwi(insn)) {
 		wr_mask = -1UL;
-		new_val = rs1_num;
-		break;
-	case GET_FUNCT3(INSN_MATCH_CSRRSI):
-		wr_mask = rs1_num;
+		new_val = riscv_insn_csrrwi_extract_imm(insn);
+		csr_num = riscv_insn_csrrwi_extract_csr(insn);
+	} else if (riscv_insn_is_csrrsi(insn)) {
+		wr_mask = riscv_insn_csrrwi_extract_imm(insn);
 		new_val = -1UL;
-		break;
-	case GET_FUNCT3(INSN_MATCH_CSRRCI):
-		wr_mask = rs1_num;
+		csr_num = riscv_insn_csrrsi_extract_csr(insn);
+	} else if (riscv_insn_is_csrrci(insn)) {
+		wr_mask = GET_REG(riscv_insn_csrrwi_extract_imm(insn));
 		new_val = 0;
-		break;
-	default:
+		csr_num = riscv_insn_csrrwi_extract_csr(insn);
+	} else {
 		return rc;
 	}
 
+	#undef GET_REG
+
 	/* Save instruction decode info */
 	vcpu->arch.csr_decode.insn = insn;
 	vcpu->arch.csr_decode.return_handled = 0;

-- 
2.54.0

