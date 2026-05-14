Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C8F83CF960
	for <kvm@vger.kernel.org>; Thu, 14 May 2026 21:05:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778792724; cv=none; b=EwKIUcgCByleYojd0QbFAAGmjQDGZ9T6XKezKPKd3nlGSO7Ohtw0sEWgr8RDFNhQ7ytEkdBhjkxo1I886Mk3Z4z5FdjGZXdAozLZN4w8KYFQQnXWzo7xFL9AWoF/wD5hdB/BmeH69bXEhQATvzMw07/NDkBeNysaKOXS6L1Y9h0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778792724; c=relaxed/simple;
	bh=ZiwP9jdCjnsjMvDj9YYxtXYRMmV/hbaMlL3FeWM4X1Y=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=EEeBaGUcAwoDoJQMRaKoeo+f4N0IXJdX8NXz1Air6h0kNeIhB3Zyd8PdfhKxe5PP6IrWdnMyEgnoemG6BPw3Xs8l8UlKlUDYIsZuOvdbvKSvjb9YqmTxc2oxh4561L04u2erc6xHgkxi8Bdq7cp2HtGS2F36aAvjPqJhsho+JHE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=dLuk94fe; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="dLuk94fe"
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-8354503d9acso10671897b3a.1
        for <kvm@vger.kernel.org>; Thu, 14 May 2026 14:05:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1778792722; x=1779397522; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=oBvkAOfb+oGsqMeud56xyHfv3sELwdW549T+sWexK0g=;
        b=dLuk94fedx4Ya5JEhTu85pC/iDDfamt5ddPvfCEeAT/YohlR3I3oEkIRX3v3n6W3qt
         qllbHkYDa7dxD7iyLjJZ0ZlYOeuskGMZvUISgL8rtLOz7rCAhh92reUOqoDW6TzrAS8g
         gmoIDmMuCehqu1FjAGNJYRXu6OupW6Po4DnL7AKka7H4VZAnFaRtfY9qKpbKlEUcWO9Y
         pGbozvIhNldn8ogU+9dOUno92+kd6CJxv//zAS+36GyD+ecMCh9Qyb8pR6OH4Lcn1I/K
         tNjulSF4dTyGWj1n1I1A+hvlTCv5QTNyyOAWlBDTdRQukNgbx+Uaup8iwX1qqoZ1PQt6
         ydSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778792722; x=1779397522;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=oBvkAOfb+oGsqMeud56xyHfv3sELwdW549T+sWexK0g=;
        b=bKMAcLr+QkoBRnUU0XgmZtl1BO2btV1tQpB0iW4AB4PFfYAXOKU9Hy7vQYg5WBjgJD
         C8h9RSYzgk0yk85G27kKlf6YqNuL6E56Z92AeVMBCj7/uFWbqCswz9k2WcUUNDBReUDE
         +BrHW11Qlnx37zr5Z1G4FlCcMT7pOoSn7i3n3/IwBG8X9hKpsbrtxDYw1vxs4Tq/d8g0
         tEMX5zAR/XsEJXfuuUxhucAoWIaFVQviU/AUAmqzoi/IQ012cU7VlPmM10qgh22mK3DC
         pqJlhzGnrZrBiCXEukjzeGQ0uaTkRkIQ7jzb9Q4wpz0SMFYa7f/RscqSSW1GQcWYW7J0
         1yLA==
X-Gm-Message-State: AOJu0Yyds9kCx/d/DqFFcbiPK1uUVwmPo5nMvTOO5IyzSFv5XcnqbUOj
	uZL4YsSj9DKx9ybGiwHn8tKzbIc/fn1LQNN3AldfVkjc5rBQ4QfUvBUk5wKKxmXSLXUfJB7D/qC
	o1SX4/Q==
X-Received: from pfbcm24.prod.google.com ([2002:a05:6a00:3398:b0:82f:a139:b084])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:bd8c:b0:82f:4f63:31e1
 with SMTP id d2e1a72fcca58-83f33aebdb9mr1322561b3a.8.1778792722177; Thu, 14
 May 2026 14:05:22 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Thu, 14 May 2026 14:04:57 -0700
In-Reply-To: <20260514210500.1626871-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260514210500.1626871-1-seanjc@google.com>
X-Mailer: git-send-email 2.54.0.563.g4f69b47b94-goog
Message-ID: <20260514210500.1626871-18-seanjc@google.com>
Subject: [kvm-unit-tests PATCH v3 17/20] x86/smp: Align the stack to a 16-byte
 boundary when invoking SMP function calls
From: Sean Christopherson <seanjc@google.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, Sean Christopherson <seanjc@google.com>, 
	Mathias Krause <minipli@grsecurity.net>, Andrew Jones <andrew.jones@linux.dev>
Content-Type: text/plain; charset="UTF-8"

Align RSP to a 16-byte boundary in the IPI handler for SMP function calls
before calling into C code, as required by the x86-64 ABI.  Failure to
ensure the stack is properly aligned leads to obscure failures if a struct
(or any other object) tagged with __attribute__((aligned(16))) (or any
alignment greater than 16) is place on the stack.  E.g. VM-Enter will fail
on VMX if a vmx_msr_entry structure is placed on the stack.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 lib/x86/smp.c | 21 ++++++++++++++++-----
 1 file changed, 16 insertions(+), 5 deletions(-)

diff --git a/lib/x86/smp.c b/lib/x86/smp.c
index 366e184c..0cd44cdc 100644
--- a/lib/x86/smp.c
+++ b/lib/x86/smp.c
@@ -58,12 +58,23 @@ static __attribute__((used)) void ipi(void)
 }
 
 asm (
-	 "ipi_entry: \n"
-	 "   call ipi \n"
-#ifndef __x86_64__
-	 "   iret"
+	"ipi_entry: \n"
+#ifdef __x86_64__
+	/*
+	 * Align the stack on a 16-byte boundary (as per x86_64 ABI) before
+	 * calling into C code.  Make sure not to clobber any regs!
+	 */
+	"	push %rbp\n"
+	"	mov %rsp, %rbp\n"
+	"	and $-0x10, %rsp\n"
+#endif
+	"	call ipi\n"
+#ifdef __x86_64__
+	"	mov %rbp, %rsp\n"
+	"	pop %rbp\n"
+	"	iretq"
 #else
-	 "   iretq"
+	"	iret"
 #endif
 	 );
 
-- 
2.54.0.563.g4f69b47b94-goog

