Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27B2D3BB9FA
	for <kvm@vger.kernel.org>; Wed,  8 Jul 2026 03:36:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783481795; cv=none; b=JAPoSDmU4WIP1uKLPdVb5Us9JRW5c7PHSh17UdXHpli5Uhfpml0qGt47CtNzZoKY2UhzcVHj6z69V5wp3+XUWgQdvS+/kkVAJxeth6WsS8Chkna3AcGcBo/U+YGMhwp5EDA3zrA8YPeXDGWoJf5hDX/ehzRTa/9C3yzy4Gx8JxU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783481795; c=relaxed/simple;
	bh=DCPKi33NYT6bX9zlswitk1aeo+c7wEE6BumaxclqcxQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=FRXw1pJfB8lXUmGoghXVTkwf4v+pp7Zrih7b31e7qtNfrJAqSOlcJjMIdvdfE4tad3sfXxa4T3+iDwIi3WdvEq5kq6laev91aEu6JI8G0r3IYtMmO7Y0tIUgQ/M6c/ZmLe59qlbIv3/3Q6m6u0OGXAZ1oUBWnfe3ocQBqAUcroM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Lri5tohc; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Lri5tohc"
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-38175907a56so1149902a91.0
        for <kvm@vger.kernel.org>; Tue, 07 Jul 2026 20:36:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783481791; x=1784086591; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7uwJLmhKNEIHTwQycd7laGxNA3BK/zUUdv4a0SBN/M4=;
        b=Lri5tohcjBZunv9ewOIov+3BKrwWekZrFv+MSdaPFYkQnkipWHzIQHMCWyO0xDWjht
         aCBir20aA/kFrGhJL1PxQAxXm4NqEx43iesFJLKTGpJo3Y6gWGvCQizIQLV6wwn+Qw9z
         InyyM3eapUlXXGMzkhJBV71txHQ+Ruktu5XM7dUvzWoMF+mvDF/ixB4qgf5pHQrCVTQ5
         D3xG8YOB4yGRaFCFWl1HzTUs3NtqReL/dRl+PUIph3SW/17Q8zyG4asRn6K1irnF1AGi
         WHrK7pUZmK9WJ4O9V+FXJWxJVBw0k4Cp4cr7foxBVT9X57Iaq0dLr4cPFgT5pIDA5DM1
         nx8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783481791; x=1784086591;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=7uwJLmhKNEIHTwQycd7laGxNA3BK/zUUdv4a0SBN/M4=;
        b=N4aPguhr+/eLke9On01THL5RNZX6zNgPttRHcKlJmLLZcZjVnGI84K8UAQiayqvYeo
         zpwBvGJWVShMcatWQL5/9WEtQRBUlMjdYrRvtAQVHOBqJyAynQ0POl0O/3SztYvq66nx
         4UviJGJeiPr0lwGyBPcaa2k3dQj52zhnDgFSWM7z0IPnOyHxXKC1RVkdXMaM/YmdIIV/
         ceeLOJtbRHmEE80xMqQ40akCP03mz75zU9UrZBZVD1nmjGbyOBn9zZ/wZlrBaHRjmU14
         90D2eb9OWG0CrKY3Kxmg1XPqsXnPt0Yzl5NJsoLa7+BvFNfecgGu+tS9ZCyNEhlE3MTX
         FOwg==
X-Forwarded-Encrypted: i=1; AHgh+RrTdFwc4UjJFuIblz7KYZGzrwyw+5ZfkqkfbxAQG8bLoVmC+MVtpN6zU7tPp0nNMKCyqv4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxuZqWHpq8gWw0ne/oRu+ZGGCC2kOnsG9lIbL2Ryao6zCBOLnOR
	xJkDin575L+XmjgMqs2nQ9duLTiUh13626m2l/A79jfRYGIm3LLhbx4/
X-Gm-Gg: AfdE7cky23RGaFkspDMPZGWEPOSQcKPD0i/QiIR+X10DEsBASoJEw5eeav2gBzoX3LX
	RYvHQ0Pe/H7YiVM5y38DcUdpDV4wkAsS0RnH6LDz/6wx23Yxih01MVoNxC0uAWGsErVRXGFnJ2N
	xemRJtZdZfgDGgUohepvHwe1tWXk2HRpRsV1f3WPge+dapOateNsXMl45SXXrERQW51gQ0LYdyR
	2UvN6IN6LOX/Z/CzqBRxhe5T19kvEVRHAhRtjNL5FSujGTcwTTtK0yy0JLeaPE9DMygPqkFO4Kc
	XYst9pLZGE7ppvMf7ImwSxRowinuey30nIJxX71iFbCS/DW3kvmGU8NQPjuliZ7MHGjHsXO9m6R
	FgScmaUewAjZLjfD/JjxWWuee8Bi2xLTUbQLR4owvo1vjlRBfOwZpNjbVT8xA9GzHUUEgFRxOYm
	ZJmXky9vRn7yMFcsJP6BxGr7F1fqQU7T7fJFF6HqM=
X-Received: by 2002:a17:90b:5544:b0:36b:de66:92c3 with SMTP id 98e67ed59e1d1-387d880b730mr5823258a91.10.1783481791130;
        Tue, 07 Jul 2026 20:36:31 -0700 (PDT)
Received: from [10.0.0.65] ([2601:647:6700:64d0::94ac])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-31174accae5sm21092850eec.29.2026.07.07.20.36.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jul 2026 20:36:30 -0700 (PDT)
From: Charlie Jenkins <thecharlesjenkins@gmail.com>
Date: Tue, 07 Jul 2026 20:34:30 -0700
Subject: [PATCH v3 07/17] riscv: Maintain epc on misaligned emulation error
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260707-riscv_insn_table-v3-7-3f8e5f75ba97@gmail.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1783481777; l=1589;
 i=thecharlesjenkins@gmail.com; s=20260605; h=from:subject:message-id;
 bh=DCPKi33NYT6bX9zlswitk1aeo+c7wEE6BumaxclqcxQ=;
 b=zvComs8b88dWvy8jLEjCRmfCDTkUEyxqVH8c14cT2/SUZEuhkK2O/aL6Gz7C5H53JvlCy3eJM
 ZgtW3tHJOY9B6zTgPHaM+IBbpBPY7YSN2Dmbugepwe7vF4SZTq+lmse
X-Developer-Key: i=thecharlesjenkins@gmail.com; a=ed25519;
 pk=ajnnRQ98PIdwKp4HeMkq9U32okYbnh6Zb4G3o5XXvkg=

Currently the epc is set to zero when there is a misaligned emulation
error. This will print a misleading error message with the current epc
value of zero instead of the epc value that triggered the emulation.
Avoid setting epc to zero to maintain the state of epc.

Signed-off-by: Charlie Jenkins <thecharlesjenkins@gmail.com>
---
 arch/riscv/kernel/traps_misaligned.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/arch/riscv/kernel/traps_misaligned.c b/arch/riscv/kernel/traps_misaligned.c
index 81b7682e6c6d..524215a186e0 100644
--- a/arch/riscv/kernel/traps_misaligned.c
+++ b/arch/riscv/kernel/traps_misaligned.c
@@ -238,8 +238,6 @@ static int handle_scalar_misaligned_load(struct pt_regs *regs)
 	if (get_insn(regs, epc, &insn))
 		return -1;
 
-	regs->epc = 0;
-
 	if ((insn & INSN_MASK_LW) == INSN_MATCH_LW) {
 		len = 4;
 		shift = 8 * (sizeof(unsigned long) - len);
@@ -303,7 +301,6 @@ static int handle_scalar_misaligned_load(struct pt_regs *regs)
 		shift = 8 * (sizeof(ulong) - len);
 		insn = RVC_RS2S(insn) << SH_RD;
 	} else {
-		regs->epc = epc;
 		return -1;
 	}
 
@@ -349,8 +346,6 @@ static int handle_scalar_misaligned_store(struct pt_regs *regs)
 	if (get_insn(regs, epc, &insn))
 		return -1;
 
-	regs->epc = 0;
-
 	val.data_ulong = GET_RS2(insn, regs);
 
 	if ((insn & INSN_MASK_SW) == INSN_MATCH_SW) {
@@ -405,7 +400,6 @@ static int handle_scalar_misaligned_store(struct pt_regs *regs)
 		len = 2;
 		val.data_ulong = GET_RS2S(insn, regs);
 	} else {
-		regs->epc = epc;
 		return -1;
 	}
 

-- 
2.54.0

