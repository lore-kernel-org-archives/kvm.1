Received: from mail-pf1-f201.google.com (mail-pf1-f201.google.com [209.85.210.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68CBB3CEB9E
	for <kvm@vger.kernel.org>; Thu, 14 May 2026 21:05:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778792714; cv=none; b=TzBRg0OJZzbyQPPm6koqLLFLluex7aCC/krcbmvwAzlBNIOToEdm5OYu8De7WybSgecdSpbHcy4k0pyg7ChZPzm+rmtPzpfDgStIKnhdcK1NGnBAD/t4SYPu5qMY3l5GEK4RNv1s7fn/HS2IW0s3IP1w9J37chTIVhUkssfRuEc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778792714; c=relaxed/simple;
	bh=gySK+rIGkMrhTb/5dusoNgKNNxBUP92SX7Yfj3QYsJA=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=FOkbBCUfZH3XbFXzjOtGhbGl+s/Y1MRRNd5Sbp4fRxc1G2EpBksyIGGNAGTzUBJuacf/K9PsB8GVTGBwXGK9yGIkhyjJFBIDRAKvinCNpYBMh6OsbawvUAKhnRAcheJoohsc/Mz6Bo5HnGxoXk62fImHbo147hq/fWXyNJrt/3U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=KsMAMt7A; arc=none smtp.client-ip=209.85.210.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="KsMAMt7A"
Received: by mail-pf1-f201.google.com with SMTP id d2e1a72fcca58-83836443305so4815611b3a.1
        for <kvm@vger.kernel.org>; Thu, 14 May 2026 14:05:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1778792713; x=1779397513; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=pKDTH1rggRgv6LvT/Qb38hRUEURrkTmQDEHlE8GRVT0=;
        b=KsMAMt7AGEErTCHe21Gkg4jOIaomvOlA5+F82UabKSdU4e/T51Hf8mfxBVkEUh6u5i
         /iCrcmMW5cWEYCnkrqz1mLYUjh1EmpBfDPpUiD8ZHHWHznsQXfHI6ku3DrzHD6kbBqEs
         Qp8EKOWA3L6yqSqp208yspHdTTIUCMm5EEY6G+58P4XzgSq74ekQD75Wgf6SuhKr1Ofv
         szTSfK9Z+8unrsb/QHjkZuTcmjxyEEgXsIlhcM6uuyDkc0H7BxlPG152JaigmCLdVh9/
         n83i+/RUAcf59TTcv3ALijMcemVgxScjcknLIg+6l+w3Sug289hMJZH4vSIY8sbz4en5
         eBZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778792713; x=1779397513;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pKDTH1rggRgv6LvT/Qb38hRUEURrkTmQDEHlE8GRVT0=;
        b=OFc0Zr4w7skFtdz1MN8l1wAUis0khhldGUVcVy5+LxCEpZfiE+Hha2HkxDbEMXCjv8
         sXhRcxGaKR+NAi/B/5MXSM5fJR064di4vnl9iqykM5LDYJkFA3M20om/l9rz1OJQima/
         oEwP54GI26CuNfy5N1p/XE58jOiaZl2/g4JOb7wm5JpmBzjHcISk7m1Tw1BxO0T3Wzeq
         QugLWLtC8Gj2RZZdkF5H+two6Cu4ci+koMiWRrDNtkSyV+kFf44E84cRmtEZD/qDn9bv
         h0X9cym0IDOfmUvToo9bikv3uwan+tGqWnCUq8CWircYFvIGgg887VO+4+GOQNxLsrS/
         AVzQ==
X-Gm-Message-State: AOJu0YxUxvsbwLzK0pHv6bWyj9v1cQ0n5jewutMA3aav2wE93hq5mxTz
	fTc0OcUBo7Nx9evJhrpZr18cxi+qcHbvauzIZzIiau4RJNXru6eVcay96EXfnwrGde753KKcAhq
	7JBzRsw==
X-Received: from pfbly26.prod.google.com ([2002:a05:6a00:759a:b0:82f:a4cc:2fb3])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:a80a:b0:82c:249e:a85b
 with SMTP id d2e1a72fcca58-83f33bf562emr1239266b3a.13.1778792712502; Thu, 14
 May 2026 14:05:12 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Thu, 14 May 2026 14:04:49 -0700
In-Reply-To: <20260514210500.1626871-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260514210500.1626871-1-seanjc@google.com>
X-Mailer: git-send-email 2.54.0.563.g4f69b47b94-goog
Message-ID: <20260514210500.1626871-10-seanjc@google.com>
Subject: [kvm-unit-tests PATCH v3 09/20] x86/vmx: Swap GPRs after checking
 "launched" status
From: Sean Christopherson <seanjc@google.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, Sean Christopherson <seanjc@google.com>, 
	Mathias Krause <minipli@grsecurity.net>, Andrew Jones <andrew.jones@linux.dev>
Content-Type: text/plain; charset="UTF-8"

When context switching GPRs before VM-Enter, check if the VMCS has been
launched before loading guest GPRs to ensure the assembly sequence doesn't
consume a guest GPR.  The code currently works because "launched" is a
global variable and can be read with RIP-relative addressing, but that
won't hold true when launched is tracked per-CPU (or per-VMCS).

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 x86/vmx.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/x86/vmx.c b/x86/vmx.c
index 4cb8d66c..7da549d1 100644
--- a/x86/vmx.c
+++ b/x86/vmx.c
@@ -1734,8 +1734,8 @@ static noinline void vmx_enter_guest(struct vmentry_result *result)
 	asm volatile (
 		"mov %[HOST_RSP], %%rdi\n\t"
 		"vmwrite %%rsp, %%rdi\n\t"
-		SWAP_GPRS
 		"cmpb $0, %[launched]\n\t"
+		SWAP_GPRS
 		"jne 1f\n\t"
 		"vmlaunch\n\t"
 		"jmp 2f\n\t"
-- 
2.54.0.563.g4f69b47b94-goog

