Received: from mail-pf1-f201.google.com (mail-pf1-f201.google.com [209.85.210.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70A953A63EF
	for <kvm@vger.kernel.org>; Thu, 14 May 2026 21:05:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778792710; cv=none; b=hUIkSn/w6WtFny8/NX3kqfa9OdT7jzy+5Aa2bwxq3Wza9Rso96Bau6xMpWNayY3RYS21fC/Q0s1LMzwnZZ+myTXeiNC8G8YZiQ2n4shvNLIjCHIzwiEfppCUaOOJVbahuAMYvcXLBIHaavjMaK4cc92GoIQXt+nSzUpjt5Qs758=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778792710; c=relaxed/simple;
	bh=9Nz8yPwBqAfl708xA4MmPW2jh0XXpCXzT+0IBW+SIew=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=OtlQTIsLnSIN2oxMOBgW/uVBDirRvFz1hQMqvPz+zAAVlzj0CKyTifG527+LF6AacQsWM/6UXC/gk7pqF4KZ86orPC2TonriHpi19mu1OjRtAiiqt28J3VqTvqXaom0dtmNgATG0PPC9x5Aqzncwd+BGw8dFHbbKvh0Z/Zv2Kfg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=jbLyE7Xc; arc=none smtp.client-ip=209.85.210.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="jbLyE7Xc"
Received: by mail-pf1-f201.google.com with SMTP id d2e1a72fcca58-83f24cd00f8so660592b3a.0
        for <kvm@vger.kernel.org>; Thu, 14 May 2026 14:05:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1778792706; x=1779397506; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=JctxnuHqrJIRzKLQVwp30xplIAtKqxuoHDX0QajkF6U=;
        b=jbLyE7XcgrpN8QgOjJmWfkLGuE+6LUTRfAK6c/cSPl6+gmxGyre3lZDZMdWvRD7BNA
         RYHLFvvVAHNPvEBMF8L1bvkQ7OdBWiJUEQVl7djnM48ETCoWjVjPGMtRmXJFE3yuAJda
         vuRG7AKbugKjZ3OrfgAD6eB510SqHWU6Tr91XA/bbZieSD3iRK+CNLmzjeGYsDU5LiQ5
         HxYLTTQAjOy+tbJ4yJHc1JzSg6K90PNRrBDwd+UltwE76CZvYBKP/pGxpmtdzUAP6w5p
         7Cw4xR82YSFS/SnKg3OppIHqqRfKK04+rp/OE/k/253z2ulCJs8A0E2dckrh+3AlzQSk
         8R4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778792706; x=1779397506;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JctxnuHqrJIRzKLQVwp30xplIAtKqxuoHDX0QajkF6U=;
        b=e1IQi+hS0jErZ9NhKigMRa5+LosI858nZmYK6szbr8D914PttYFlkiWZ0EmX0xOBQ2
         FrW9g6XCt1kbAgzQ0giKl9KvQ436FIIAZ/0mqpApNVYHPCgbFv+zb5BHbQQ0bqivWX9Q
         uAmdgwlo805Sy1hw2xClhQBkF+V0haz3PK3MoLS+hX61mSEIallMwkkxypBiqOMI2Fgp
         kd6n8bIFJZosSGVar6kie978pOmBrfsLAstG7x3mt8N0lxuP7elLEUzjcFRnv/jB+2d7
         rLILPhZebWXcvhtbYN1dH2hxTqeM3sJ3szJaiT5EYSfQf8thfGdrz91zFTGFxBkanZ4D
         2eng==
X-Gm-Message-State: AOJu0YyTlIQ8CYk5F2Tir790AvO7Yy0ZhhIplgCCSkSlIOBvxXzppIrY
	fbecIPiJxrh1GpWclWb3hA4escZzQizMRBQ6L3qKVRC/rCHyhWwdKB9dF1k9+QXxPsK4tVTmv1X
	TcXeLxA==
X-Received: from pflb19.prod.google.com ([2002:a05:6a00:a93:b0:835:4315:3453])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:12e7:b0:837:666f:8fcb
 with SMTP id d2e1a72fcca58-83f33ba1603mr1129041b3a.5.1778792705713; Thu, 14
 May 2026 14:05:05 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Thu, 14 May 2026 14:04:43 -0700
In-Reply-To: <20260514210500.1626871-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260514210500.1626871-1-seanjc@google.com>
X-Mailer: git-send-email 2.54.0.563.g4f69b47b94-goog
Message-ID: <20260514210500.1626871-4-seanjc@google.com>
Subject: [kvm-unit-tests PATCH v3 03/20] x86/svm: Sort (and swap) GPRs by
 their index, not alphabetically
From: Sean Christopherson <seanjc@google.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, Sean Christopherson <seanjc@google.com>, 
	Mathias Krause <minipli@grsecurity.net>, Andrew Jones <andrew.jones@linux.dev>
Content-Type: text/plain; charset="UTF-8"

Sort all GPRs in the nested SVM infrastructure by their index, not
alphabetically.  This will allow sharing code between SVM and VMX for
context switching GPRs between guest and host.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 x86/svm.h | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/x86/svm.h b/x86/svm.h
index 385c1289..d9f7c731 100644
--- a/x86/svm.h
+++ b/x86/svm.h
@@ -392,9 +392,9 @@ struct svm_test {
 
 struct regs {
 	u64 rax;
-	u64 rbx;
 	u64 rcx;
 	u64 rdx;
+	u64 rbx;
 	u64 cr2;
 	u64 rbp;
 	u64 rsi;
@@ -457,9 +457,9 @@ static inline void clgi(void)
 
 
 #define SAVE_GPR_C                              \
-        "xchg %%rbx, regs+0x8\n\t"              \
-        "xchg %%rcx, regs+0x10\n\t"             \
-        "xchg %%rdx, regs+0x18\n\t"             \
+        "xchg %%rcx, regs+0x8\n\t"              \
+        "xchg %%rdx, regs+0x10\n\t"             \
+        "xchg %%rbx, regs+0x18\n\t"             \
         "xchg %%rbp, regs+0x28\n\t"             \
         "xchg %%rsi, regs+0x30\n\t"             \
         "xchg %%rdi, regs+0x38\n\t"             \
-- 
2.54.0.563.g4f69b47b94-goog

