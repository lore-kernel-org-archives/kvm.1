Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 034233B47CA
	for <kvm@vger.kernel.org>; Sun,  2 Aug 2026 13:44:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785678302; cv=none; b=HAtCH/l3uRjWFJ5DT0OB065s4igUsn2qJ2za3UjbhyXUX5NuhnmoMbLYLmBZDr37/pwwwIslv5PWzu/de9n7KvmftKyUQS/pWcHEIqHkd1JvPHMqW5weCf5KdYLMioNIA74i6MrVnJtbv52jr57ZGUELiVzRAU+itNNPsL8xCUA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785678302; c=relaxed/simple;
	bh=gZ0UUdT48hbMs0jRzaOu4QypASHEVAG3ns1aMnD1mIs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FCJfFbBSaw6W+25LSd/NN2XRJ4eJ8frQGrA9dHH3ZhMoYzr0j4gGPTu7JlpkIrLNE004xrjcSYWNFm2dT4Ps/vAIQHcJQuJdsQLPyF07iNOGKuX/9L1HBWQl0yfmyM74LErWN0KJ4G+MFQKZZk/dd3oGF0xk6gKaPzsxZmqFLQY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=H1iYj0ES; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="H1iYj0ES"
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-4956d1d9fb2so2052965e9.0
        for <kvm@vger.kernel.org>; Sun, 02 Aug 2026 06:44:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785678297; x=1786283097; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=uvXixwprFJLlnKdN8GIk4RHMYlK0y98sLKZBpOoa3aw=;
        b=H1iYj0ESnbzVi2khpFQfnxuDo/hj6yy0IDkUhmAagxrC/t0buB/BuP4lhUnm4Ps1El
         tiXjkJJL+w2eYxgw7nfF8ME+yjxXtJBYSNnGeigPqoMMlQSZsyNlEugSHGPigsEIbzdm
         1LBwqy+WSJ1oMK4B7pXPlTGDOUmU5s5ny0FQApck29QmrccRYGVoyXfpZhQcY3TRXhGW
         41cysmD+qK+IDgaMAW3Y6obRsjWHgm9vlG3t56aCXtPlN+IAIS45xbo3N2aQxCo3lBhF
         WII4HClZgM2ZN1HMCA6mMiM71icNjIHY8Na0XgJzlHfXSrv0/pfq8ZFQMheqMdBK00K7
         YKSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785678297; x=1786283097;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=uvXixwprFJLlnKdN8GIk4RHMYlK0y98sLKZBpOoa3aw=;
        b=M1SNRwThAQt8oSuSHD8teYHzDmXbBly3jLdppBXlnZh8zu8m4MZi0L7HcwKr6L73Wf
         Xwv7XT1YSFAOp/ejoPDrKvrukwbk7tas8l5k75DNAIkWbZ5cksOSdDMlY3AT9YtdVLOA
         hjuWtf0tn6DTZD0Y483uy+V791ZYACQAImYSz+aCYFwZzkF2PwOTD/Qk/IeaNCkW/q1Y
         ujFWaRsYLdqBjJotOjaV7jPS4Rodhfz9EQfh083odcuUDZqy8XGCWkI8V3lT+x84RIEI
         X2IRyfm4e7Q1pTyj53B20L0ShSMJgpxIuHZ9Nh7dRfpyMIT8VSNoOhjhlXlyZzT9c2iW
         3c3g==
X-Forwarded-Encrypted: i=1; AHgh+RqFo3fNsTu5hBPC0O3H1GnezbEen76FFBVpqFy1s2rZK9St6CQrVkRfm2/0cbmwWDUlB/A=@vger.kernel.org
X-Gm-Message-State: AOJu0YwRfKmHzx3BqfEYjhxmJ/K9BB9D2lq3qXr5b4PQnIsbJ9Vxs1Gl
	y16xsxVA9tdIxha/8FpY3LCPPOYck4xTRHKZzooK5ObWX/q+pk2m8L+9
X-Gm-Gg: AR+sD12ox+B/CeOcE7q0w0cL3eSlgu3UNDv2M4xda5gho2t7aJjOor2Ja8tIlsKYaSI
	pPYKubC4yY3ZymbK1n6SUTGkhv/4qLWa0OlTbqUPYJ599qch4gG6kWNx1wKzcCUj2nhdWag+c7C
	Q7h+URCYHaEFchhMueBOv+V16Sclfk6dqG146CdRbqB82Qlyxnj25C7tlToNThdN8FkaO2wb0aq
	f0kvTPjG25Qrr1cEKzg4RoiyfAuunYmf/6FWVkMx79xwo1NO4/MKTyX7F3Wr+0IZw4u96VUXirY
	K0pi0Pq5/qpu1wF6KxZhb64jfSelCADPygGBZ6QrcbdEQqakdsmhp7xyJ2ZeByEb0jWSTOuH62o
	xViuaNWdHBxGIu0aeUP1PVYxSaGEU/9t15P7o3qmlM4hsKLmgVaS7rj8Eok4nh/WlSp0VPDh0wU
	xSDM9DIHRyGtCbaF1Yc8U5WKqQCJRPN0sJ+FizRh/sx6doKi4My6gZ1JaHIGkyGi6fosEarMOB0
	CA3/SeIkv4=
X-Received: by 2002:a05:600c:5487:b0:495:4505:dad0 with SMTP id 5b1f17b1804b1-4980c68e1b4mr68517975e9.2.1785678296748;
        Sun, 02 Aug 2026 06:44:56 -0700 (PDT)
Received: from lima-kdev.local ([85.99.180.157])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49807ba8032sm112278855e9.15.2026.08.02.06.44.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 02 Aug 2026 06:44:55 -0700 (PDT)
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
Subject: [PATCH v3 2/2] KVM: x86: Add limit check to IDT in __emulate_int_real()
Date: Sun,  2 Aug 2026 16:44:28 +0300
Message-ID: <20260802134428.69252-2-kayracizmeci@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260802134428.69252-1-kayracizmeci@gmail.com>
References: <20260802134428.69252-1-kayracizmeci@gmail.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Currently there are no limit check at __emulate_int_real(),
and normally greater numbers than the IDT limits needs to
cause a #GP, but currently there is no limit check for doing that.

So add a limit check for IDT to catch greater numbers than the IDT
limit and if the number is greater than the IDT limit inject a #GP.

Signed-off-by: Kayra Cizmeci <kayracizmeci@gmail.com>
---
v1: adds IDT limit check to __emulate_int_real(), link:
https://lore.kernel.org/kvm/20260608123503.23298-1-kayracizmeci@gmail.com/
v2: fixes the sign-extension of INT n, link:
https://lore.kernel.org/kvm/20260608134642.25849-1-kayracizmeci@gmail.com/
v3: rewrote commit messages, split 1 commit into 2 commits and rebased
onto current mainline.

 arch/x86/kvm/emulate.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/arch/x86/kvm/emulate.c b/arch/x86/kvm/emulate.c
index ec3138801bb7..68d099131d47 100644
--- a/arch/x86/kvm/emulate.c
+++ b/arch/x86/kvm/emulate.c
@@ -2023,7 +2023,11 @@ static int __emulate_int_real(struct x86_emulate_ctxt *ctxt, int irq)
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
@@ -2041,8 +2045,6 @@ static int __emulate_int_real(struct x86_emulate_ctxt *ctxt, int irq)
 	if (rc != X86EMUL_CONTINUE)
 		return rc;
 
-	ops->get_idt(ctxt, &dt);
-
 	eip_addr = dt.address + (irq << 2);
 	cs_addr = dt.address + (irq << 2) + 2;
 
-- 
2.53.0

