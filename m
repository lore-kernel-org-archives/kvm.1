Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com [209.85.215.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFBA231B82B
	for <kvm@vger.kernel.org>; Wed,  6 May 2026 18:55:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778093716; cv=none; b=CxXKHbTqFl6pnaDSEgfgZxpTnXrKlC47YBAXB5bEAljHvJ4PAdVmCUfJP2/rLe+vjHmIYGnqCs3WyMcNBAbPa0WChU5OMpoFsM/jRMmcvHp7U6gXKzud1WF9/+PUNaAWDFZmg8Wq+xIK/cU47nSfTvXEda6V5YOuKziv6d0Ew84=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778093716; c=relaxed/simple;
	bh=yHssYxe+d1L3diakdivL2N/THe9CWyDSi0ZG8dQK0OM=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=lFQKfAUwQAMG7mwl/quZOUlcMPxmz7jfWXRWx2ludo1LrMDysF9q6OGxx177YEQLwZbSZDZ+iUiR1Hv0jJqsP2TZ4BzWlWw3SLp8m1tlUpOkhSffVDjGS5o7uxoQk5JJBUerX8wZHHcSk2vjsIuwnAB95hX/dLTmAU082RTaLIg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ooXnLGnD; arc=none smtp.client-ip=209.85.215.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ooXnLGnD"
Received: by mail-pg1-f201.google.com with SMTP id 41be03b00d2f7-b62da7602a0so3485531a12.2
        for <kvm@vger.kernel.org>; Wed, 06 May 2026 11:55:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1778093713; x=1778698513; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:reply-to:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ktvOWlVT3a7FEstKZdm3BViZMt2PSHHxXfvnBjN58xo=;
        b=ooXnLGnDkrLU5QpI4EtEcgpJcVywAez1rtyovjxPnR1Xjngbg/S7lIocOpYI4jHulr
         7pMvnE0RUJuT048DInttZrphaSlG4eB8AUFe2fhLSsr5IxOQJq4aklpTHMTs6YIvUMWh
         OA/d3rbc/MevEt4GZN/7CA5sneKXwgOeqiuXglTkUoIbhMY4IbbmpTkZo0TGXgeFrAqX
         Q/V0D3tbegPtBw9A9gZtsaIIo9AX+R1FCMGNC84udQlTZsil0uEIQ2zoe2IlnNZBGZID
         gy4VCDBhaNc3qSQA88xR7NsIkeK1Ydxgp3WRuSNTWeNzkPMvQbqDwbve7uEbXoqwD/YI
         zmpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778093713; x=1778698513;
        h=cc:to:from:subject:message-id:mime-version:date:reply-to
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ktvOWlVT3a7FEstKZdm3BViZMt2PSHHxXfvnBjN58xo=;
        b=XMg6RH92+zBj4OzAjM9wmiCuNVLeV07FuPPRqAkDYhxamZswTkuTNB3lmOxWY3DXiD
         2FBLpSFA2UZOMh82idCFPYaw2Fq6uMC93xOY5+TYTFOFQ6cupW+7BvqKahueX9X7PxAs
         qrkGbcnIawHv69lc6lFEbCvlYML/Z/SXxOjPc7QU5O2r+mNPUtvLgKLdj8dn/gJ1PPW5
         EnLnTY1wOeipIqJRZ2jaVRLRUFnOmBUY7rlO8KO6fXKb6Y5jmO2UiL8dChP2Z49b2I7z
         iUC0C6s2FwqcRnHZ3m9NJ05VOcVWftlPZ7Cx8tEhFVGWerhSUI90cloDYyi/xUKmlg88
         NNFw==
X-Gm-Message-State: AOJu0Yxl/ZtVrRIWd54iq1kadDSz+JW7VSGoeWgWIC96Flue2wO4PIvP
	kLlbtXV1r37x0nMqp1gOLc4ZjfbwpnPTpaqfVt931rAIdwstwVtoPLrKomjBUCIcFuYXOl6Q6N1
	9QlEU6g==
X-Received: from pgll185.prod.google.com ([2002:a63:25c2:0:b0:c79:2fa5:7c6e])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a20:1584:b0:3a3:17f8:bedd
 with SMTP id adf61e73a8af0-3aa5a967596mr5295327637.17.1778093713018; Wed, 06
 May 2026 11:55:13 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Wed,  6 May 2026 11:55:10 -0700
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.54.0.545.g6539524ca2-goog
Message-ID: <20260506185510.2723091-1-seanjc@google.com>
Subject: [PATCH] KVM: x86: Swap the dst and src operand for MOVNTDQA
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Josh Eads <josheads@google.com>
Content-Type: text/plain; charset="UTF-8"

Swap the MOVNTDQA operands, as MOVNTDQA does NOT in fact have "the same
characteristics as 0F E7 (MOVNTDQ)"; MOVNTDQA loads from memory and stores
to registers, while MOVNTDQ loads from registers and stores to memory.

Per the SDM:

 MOVNTDQ - Move packed integer values in xmm1 to m128 using non-temporal
           hint.

 MOVNTDQA - Move double quadword from m128 to xmm1 using non-temporal hint
            if WC memory type.

Reported-by: Josh Eads <josheads@google.com>
Fixes: c57d9bafbd0b ("KVM: x86: Add support for emulating MOVNTDQA")
Cc: stable@vger.kernel.org
Signed-off-by: Sean Christopherson <seanjc@google.com>
---

I have updates to the xsave KUT test to verify the bug and the fix.

 arch/x86/kvm/emulate.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kvm/emulate.c b/arch/x86/kvm/emulate.c
index c8c6cc0406d6..0bb832a76868 100644
--- a/arch/x86/kvm/emulate.c
+++ b/arch/x86/kvm/emulate.c
@@ -4450,7 +4450,7 @@ static const struct opcode twobyte_table[256] = {
 	/* 0xD0 - 0xDF */
 	N, N, N, N, N, N, N, N, N, N, N, N, N, N, N, N,
 	/* 0xE0 - 0xEF */
-	N, N, N, N, N, N, N, GP(SrcReg | DstMem | ModRM | Mov, &pfx_0f_e7_0f_38_2a),
+	N, N, N, N, N, N, N, GP(SrcMem | DstReg | ModRM | Mov, &pfx_0f_e7_0f_38_2a),
 	N, N, N, N, N, N, N, N,
 	/* 0xF0 - 0xFF */
 	N, N, N, N, N, N, N, N, N, N, N, N, N, N, N, N
@@ -4481,7 +4481,7 @@ static const struct opcode opcode_map_0f_38[256] = {
 	X16(N), X16(N),
 	/* 0x20 - 0x2f */
 	X8(N),
-	X2(N), GP(SrcReg | DstMem | ModRM | Mov | Aligned, &pfx_0f_e7_0f_38_2a), N, N, N, N, N,
+	X2(N), GP(SrcMem | DstReg | ModRM | Mov | Aligned, &pfx_0f_e7_0f_38_2a), N, N, N, N, N,
 	/* 0x30 - 0x7f */
 	X16(N), X16(N), X16(N), X16(N), X16(N),
 	/* 0x80 - 0xef */

base-commit: 6d35786de28116ecf78797a62b84e6bf3c45aa5a
-- 
2.54.0.545.g6539524ca2-goog

