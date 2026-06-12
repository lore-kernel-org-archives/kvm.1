Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCE873D810B
	for <kvm@vger.kernel.org>; Fri, 12 Jun 2026 23:01:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781305282; cv=none; b=LlUEuz5NkAf2PAUPAiZZ9FDlVZKbF3Q4Hgtzzhk5CrNbJoI9WfRbKAGriL6bVwrBUy3N42zjDyhQiSONao1AhIYhOJXW4znL+/XJgA8pNmJcM28HD//Kz5PrtVh1+8NInkq0PDDBziZKKRolkqlPwHONOZx+JJYX2uFQIDw8j3E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781305282; c=relaxed/simple;
	bh=9EfiWtDfFbNqVVMC/Fao29oObDR7IDsnb1QmgG5u62Y=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=OPWF+iG6tU7j3+fsr9/aZLsDn/4fXik0qbz/JTX9oZpvq226vDPKJdgJCogrdfPNR07HrXexjwPnatk5TzHORk6G2Co3JAsspSrWCosZmCTNrAjLCTm8LB1eZsoXJMpQhyVsznFwGqnz+uubSGhYoCOpArE/IJof4FwMrli2SAM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ko1W5laH; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ko1W5laH"
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-2bfdd99f6b7so24387045ad.0
        for <kvm@vger.kernel.org>; Fri, 12 Jun 2026 16:01:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1781305281; x=1781910081; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=S0l+jwQAw9AdDhvDUdYHfGnTWpsYaOO/BEuKKirwcds=;
        b=ko1W5laHM+rC7B3bjGIMfZ/woF0zC7A4+iBxfun9bN49HND6K0RtkC9B9stTjcMeud
         ykfTFC1OBQd7cDkhhINqE/qSlc+rhml07jD8HBqJBo5lJE1C1Q5M4DcIfZF99SFP51jg
         E8Tg0Gdt63rylpKRPHCmaVZVaAtSbyG9vOXRedWnxEYVLxbq21HqPHgbKMw3W8Uoerln
         YQ3ZXuaE5cV1k3h9PJ08HFCpjjVv+csC7OG3m2tp9m/nezsKKwZ5qVdSiUF/BkGPLTH+
         p4nOhlCtmezR/z7SAk4jwJSlHyMWTMmlL1qM7xARqCGM3qTwYcnDUASshrfSFdrm9/RA
         zn2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781305281; x=1781910081;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=S0l+jwQAw9AdDhvDUdYHfGnTWpsYaOO/BEuKKirwcds=;
        b=LZHMfvu9UHfDb13Slh9GOXIPtIGNGAaT+YPbNmJ/IrGx//g/7oKpzneUtvB0WFcqaD
         Iy7bCSoiihOi6j3L6TOcFijFmZWZ8koFH/THaDf1A6L5olYKRgfWF3EpPvOrUeSCUdxT
         eZc81Ls5o1KFqSWNiLHFpHTTSJ627l+AUEKB2jnaVd4e9i0CF31H6PI85A0KO2ZV0RFe
         8O160Q7zZJi98JmnPir+A5IRdWtTefNbwq52VsxmQzsNO2qO2C3QPW+xylWWknyzGEFQ
         +RZhX8bj3lkhHL2SbUEsf0dLg56N+ZxCjQQgTZxe8dHFkhJ9SFLCebgIuh+Jbnw+Qccs
         bZpw==
X-Gm-Message-State: AOJu0Yztnpq79zK4mXUys8nJ5cqerXC9wzWpgJEXLOzrZJK6pDx0qt7N
	xma4rNPvkTFXMAGnpHeUPccGM83I0+DyO3N6W3t4W/881aXKZ8YP0g5ycaGiiGaFmcqA0gaM8lF
	+unTGTw==
X-Received: from plnd4.prod.google.com ([2002:a17:903:1984:b0:2c0:bff2:48e4])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:cf4b:b0:2c0:c262:b91f
 with SMTP id d9443c01a7336-2c4109ed6cemr57967345ad.8.1781305280985; Fri, 12
 Jun 2026 16:01:20 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Fri, 12 Jun 2026 16:01:08 -0700
In-Reply-To: <20260612230113.684301-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260612230113.684301-1-seanjc@google.com>
X-Mailer: git-send-email 2.54.0.1136.gdb2ca164c4-goog
Message-ID: <20260612230113.684301-4-seanjc@google.com>
Subject: [PATCH v3 3/8] KVM: x86: Manually check DR4/5 write values to fix SVM
 intercept priority
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	"=?UTF-8?q?Carlos=20L=C3=B3pez?=" <clopez@suse.de>, "Maciej W . Rozycki" <macro@orcam.me.uk>
Content-Type: text/plain; charset="UTF-8"

Manually (pre)check the values being written to DR4/5, i.e. the DR6/DR7
aliases, instead of relying on ->set_dr() => kvm_set_dr() to signal a #GP.
SVM unfortunately prioritizes all exceptions over an instruction intercept,
i.e. nSVM is relying on the emulator to perform *all* exception checks
prior to attempting to execute the instruction.

Fixes: 3b88e41a4134 ("KVM: SVM: Add intercept check for accessing dr registers")
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/emulate.c | 14 +++++++++++---
 1 file changed, 11 insertions(+), 3 deletions(-)

diff --git a/arch/x86/kvm/emulate.c b/arch/x86/kvm/emulate.c
index 4484c5fa19e3..a1bccab0eefe 100644
--- a/arch/x86/kvm/emulate.c
+++ b/arch/x86/kvm/emulate.c
@@ -3853,15 +3853,23 @@ static int check_dr_read(struct x86_emulate_ctxt *ctxt)
 static int check_dr_write(struct x86_emulate_ctxt *ctxt)
 {
 	u64 new_val = ctxt->src.val64;
-	int dr = ctxt->modrm_reg;
 	int rc;
 
 	rc = check_dr_read(ctxt);
 	if (rc != X86EMUL_CONTINUE)
 		return rc;
 
-	if ((dr == 6 || dr == 7) && (new_val & 0xffffffff00000000ULL))
-		return emulate_gp(ctxt, 0);
+	switch (ctxt->modrm_reg) {
+	case 4:
+	case 5:
+	case 6:
+	case 7:
+		if (new_val & 0xffffffff00000000ULL)
+			return emulate_gp(ctxt, 0);
+		break;
+	default:
+		break;
+	}
 
 	return X86EMUL_CONTINUE;
 }
-- 
2.54.0.1136.gdb2ca164c4-goog

