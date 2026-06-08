Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 058913B5F59
	for <kvm@vger.kernel.org>; Mon,  8 Jun 2026 13:47:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780926428; cv=none; b=RNdPuYB3RxWJ/sr8v/aq78LVsqckWeAKSUrOxLmzFsgDIo+jJHyZVs/auAzJQxWgwCwjti68hOsoC1yk/68h48wsJh1ks50pQ1x7hYhhPk00HKZXvhwNCqYSif6IJUUQINh8zToCJGvjPc0bRBp38kHFZeSt6OLVpVBS6mbTOi8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780926428; c=relaxed/simple;
	bh=Wgyh5RGDNcaXhBO9drrH6wHNTUNGPADmhjOWy8yBp10=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bvc9de0JKJIfBxsnPuRuE/qSPbsKLaAA8KBXtij2nw0r5LQ1fawv9I+Oh6bg3Z+aJMGoPi7Jpm59EC35r966oJH/xfc4oRdus+1eVG73dvpGPfrSwrO7VeyyMBgynLZ6fewx4JEF0whnmQM6k1kSmPhC7OQG9rknz++Nu/7cAc4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OG2nZwtY; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OG2nZwtY"
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-68d05f6b3cbso805111a12.1
        for <kvm@vger.kernel.org>; Mon, 08 Jun 2026 06:47:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780926423; x=1781531223; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PlHLPmEPwYMjH3EElGOjjI09oO4lUI4b+lkKofR57Co=;
        b=OG2nZwtYv+SUeHhD8O9cElC9q5JwK2IL0G7mzrwvVr9zmgLBqggeFW6OPwtDiiTpJ4
         ZG9oXCdkr966vSHQqLERr0PCWKq/7GgwtUzSzUPnB6H2HMHM7e2kBi8McLl/z67Ttxjv
         VBvJgPvG10LyiNlpJuhqg4GQkKFRxa49LxbUsX72s2cN6a2KAOgppa7RgRPCJqPjkPED
         Ef8xx7pNtsFNbn8s3hwtKfkuSFppwg2/HNWquv90AotDNW2NveCdg498km9B1Wrhv0yV
         w2+y3CJdSBUNoVMkN8MqI9+yDTLdOCS+fZ/YlVa9SLxXDA5NKOObn9CXwfecXVAWUNzH
         q/yA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780926423; x=1781531223;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=PlHLPmEPwYMjH3EElGOjjI09oO4lUI4b+lkKofR57Co=;
        b=MKOl1rbNU/u/UaJjjf8s3Vy0qXgcP1+BJ7E69Mvj2QyNBVNfri69Io4+lEO9niu7Ab
         yL68ctIxWxKU/ZFGy6RQ/jhEzSuaNk/SODKBY66bID9z5xSj5OEiJHMD1cax1Ed5Pf0x
         iNon9P3JGHyGeDEyb0Oid+iIw2xl94zWwEyeDc53lOvijn0DoyGAjgsjMPY27+qvf5J6
         jMCe5kPYYEVUkwOi0/bRQCuYRajKyDJDKFpN9P5b6CbTzGabIZp50gG03jYmN394A4nG
         li7Q/iMZw4WAnOGakmfCNFM97xNeR/UqQH/tHcACurBkZEwsrWE9PkqDmLpivJMpP01a
         cOGg==
X-Forwarded-Encrypted: i=1; AFNElJ+jYfU9JdKZkoLDDA89JY2mQQhzz3DRK5Jif/KTqOebjykHS5omgi+yJOKgoiQaIbnFbqo=@vger.kernel.org
X-Gm-Message-State: AOJu0YyaBr3+TQKSRh/viTXbYWL1Cvla5D+fIa5qGIb3DzxtWl1A8D1B
	Qa8X+fysqCur77CDyaITSZCDzBolreJzckjpFvqJSHzAXvlNTfomeSEB
X-Gm-Gg: Acq92OFnuMMmQbP17cZnFToa/lWgSD0N+2Q4wsZlaSPLlEwoL4OLRcUl4juKy69c/rb
	P17CGl6Y5y4ZN6+AW0RNwYGStabYaQybQOFw5XvMTVY49WU4VyoifrloC61LKKSXW9vTHTIN2ca
	bZXpYI4KynXDgnDKN65UTZQHkGoDCc1mEG4C9Q5y5MG+N6oeMeiSakVY7X1wErpAqwQIKcBKXx4
	QNWGR/Ei1Bf+EtUbdBmYua7TGFeZrS+UOF4ewlWJkR15ChvUYe1hWOju3ZuTkoJl/oqEUJ/hpMr
	PRqqBGnest/DoOMZgeXMqXScalE67sYRYVib23snO7uTBaZk5WfHf/sWkIld54ILixe6ESJOULd
	hi7JpDkAExsDlWW/hlwsJq0Wc9Q8A03QlKnWybd3Y6QnPaP/0WMAM5oBzVSA2ko6noAnW6dmNhT
	H6TTTorefvsyr9NdMxxyKUcUJ8g4WS21LXuVR4RMlH7LdxtZgXcJ3hGIbCFkG6aF0+NIjzUg==
X-Received: by 2002:a05:6402:3609:b0:688:1d01:407b with SMTP id 4fb4d7f45d1cf-68fa503aea8mr3257144a12.4.1780926422874;
        Mon, 08 Jun 2026 06:47:02 -0700 (PDT)
Received: from Kayra-MacBook-Pro ([2a00:1d34:85f:fd00:9db9:b857:33b5:b17c])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-691afe82416sm1829797a12.13.2026.06.08.06.47.00
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 08 Jun 2026 06:47:02 -0700 (PDT)
From: Kayra Cizmeci <kayracizmeci@gmail.com>
To: seanjc@google.com,
	pbonzini@redhat.com
Cc: tglx@kernel.org,
	mingo@redhat.com,
	bp@alien8.de,
	dave.hansen@linux.intel.com,
	x86@kernel.org,
	hpa@zytor.com,
	kvm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Kayra Cizmeci <kayracizmeci@gmail.com>
Subject: [PATCH v2] KVM: x86: Add IDT limit check in __emulate_int_real()
Date: Mon,  8 Jun 2026 16:46:42 +0300
Message-ID: <20260608134642.25849-1-kayracizmeci@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260608123503.23298-1-kayracizmeci@gmail.com>
References: <20260608123503.23298-1-kayracizmeci@gmail.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

During real mode interrupt emulation, KVM currently pushes data to the
stack before checking IDT limits.

This patch fetches the IDT early and injects a #GP if the limit
is exceeded. This prevents potential corruption.

Signed-off-by: Kayra Cizmeci <kayracizmeci@gmail.com>
---
 arch/x86/kvm/emulate.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/arch/x86/kvm/emulate.c b/arch/x86/kvm/emulate.c
index 8013dccb3110..32168db07dd2 100644
--- a/arch/x86/kvm/emulate.c
+++ b/arch/x86/kvm/emulate.c
@@ -2022,7 +2022,11 @@ static int __emulate_int_real(struct x86_emulate_ctxt *ctxt, int irq)
 	gva_t eip_addr;
 	u16 cs, eip;
 
-	/* TODO: Add limit checks */
+	ops->get_idt(ctxt, &dt);
+
+	if (dt.size < (irq << 2) + 3)
+		return emulate_gp(ctxt, 0);
+
 	ctxt->src.val = ctxt->eflags;
 	rc = em_push(ctxt);
 	if (rc != X86EMUL_CONTINUE)
@@ -2040,8 +2044,6 @@ static int __emulate_int_real(struct x86_emulate_ctxt *ctxt, int irq)
 	if (rc != X86EMUL_CONTINUE)
 		return rc;
 
-	ops->get_idt(ctxt, &dt);
-
 	eip_addr = dt.address + (irq << 2);
 	cs_addr = dt.address + (irq << 2) + 2;
 
@@ -4324,7 +4326,7 @@ static const struct opcode opcode_table[256] = {
 	I(Stack, em_leave),
 	I(ImplicitOps | SrcImmU16 | IsBranch | ShadowStack, em_ret_far_imm),
 	I(ImplicitOps | IsBranch | ShadowStack, em_ret_far),
-	D(ImplicitOps | IsBranch), DI(SrcImmByte | IsBranch | ShadowStack, intn),
+	D(ImplicitOps | IsBranch), DI(SrcImmUByte | IsBranch | ShadowStack, intn),
 	D(ImplicitOps | No64 | IsBranch),
 	II(ImplicitOps | IsBranch | ShadowStack, em_iret, iret),
 	/* 0xD0 - 0xD7 */
-- 
2.54.0

