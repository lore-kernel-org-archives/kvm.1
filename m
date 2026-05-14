Received: from mail-pf1-f201.google.com (mail-pf1-f201.google.com [209.85.210.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDCE83CEB90
	for <kvm@vger.kernel.org>; Thu, 14 May 2026 21:05:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778792728; cv=none; b=bM1HWq4k0qez9w0AkfMrUab4xawEe64L8XBUYj8anyYblQ1ZbSHBAekiI30C2DwNPbC1D51HUjRG8GdxM6F1NPAmdSw5J6tHCBuKbLVWrPyH3Gtr7WBnQUK3PqBSDbJvkDUDvV29KozhEnEqAlumYZaYydmzVBSGI46p6jof9Ts=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778792728; c=relaxed/simple;
	bh=Mr9x2hBIjSOwf2cNhPkw1pMquaaoRxzm5gbQpM0gJ2o=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=S2U1CIwxNpQK2JsEZQlKgN9/BnTtawJSZA8HKZgklE4jDYgubs9IXjWRfFE5lqLjj8E2AoYFFnyhmgExyRwkbcl62+xLp93ud1arYF6comuzlQMNEM3957XXVlJN8k9F9dk0PCZEnYGjBIknNXoyB6rTKmLvUSEP4Z6/drHgWzE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=C/zosL/n; arc=none smtp.client-ip=209.85.210.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="C/zosL/n"
Received: by mail-pf1-f201.google.com with SMTP id d2e1a72fcca58-8230d6d54a5so172833b3a.1
        for <kvm@vger.kernel.org>; Thu, 14 May 2026 14:05:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1778792726; x=1779397526; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=nPTXKDcXR2TW8IlEbNVrUXvkGovtdFBfczfKTtEFf/g=;
        b=C/zosL/nJYifx2JIm6PqJjZi/iEKUx5ubTu4wd1RlmvzcnZJQDR5awB8h8GT0JpnMp
         NV7fDDKZxn7e/sZ1RUO0kjORHMhPmnLuHfQgq+Ev7yduZA5AaYO6GwjiLi5IkCM0/Q6s
         1TQYchzxd6RiqfamnzdzdEAgSx9LV/mfIyrPHxQJcxgDmzDmiGR/ZrMfzcv0PCN1N4Q0
         +AkgSWJq4ZHZNaHwFkxubFp3c0ow/gJGhqMQpL8ASNr9VVD0+0c9A7gPyMRrypZiFUVv
         SH/taXNg8LOWsUEWSj17kxjL+AT5PXSu9QBoL3puxd9vz6Q6f0MxmR9fJEdd1UzVS1NS
         wU1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778792726; x=1779397526;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nPTXKDcXR2TW8IlEbNVrUXvkGovtdFBfczfKTtEFf/g=;
        b=YoKDljS6jP9OtEYGmGcp8bgIv0qse67orFY0qtbDSCLSMqBAYP/alpm5RbRPlgVgk6
         HAE2HKupfL0xQN232oDN6RY5qNEh32VzoRK8DPbXrjbvkSPcXdA82NvK3RTfmx56Q5Qe
         ZTRGcTXbRwytJhRTF7W9AB1PO39fhREAOdF0pBQn00AWDmwkjrzuEsmT/BR9VDxJlS56
         5P7+E5rNJkIY3g0h3i+/mkC3Pbu2pro1Utd25RahysIhyX9/QhJCLe9ScGK2WjA30wBM
         ntjoZHnZ4Z6T7HAJ6KslmT2pcC6Fhv6qKQ+UcjvgMMfxCCK5wgICxCo8bmzdx/kKwrrj
         f2kg==
X-Gm-Message-State: AOJu0YwO8AonuYDSzOdVD9jb6raRqdD23+cIPpuhEtVn/0LbMDgsXeXQ
	/fhgPHcxgqyNyC2Tpb2IyNFjZW+I2k5Nu90v+jVQlnTCUjYR9Tg+Bbhu2sCl8yT6+ZmvS6vGHhj
	pi8UkoA==
X-Received: from pfbjw10.prod.google.com ([2002:a05:6a00:928a:b0:82f:86c3:55ba])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:12df:b0:835:3f9c:c681
 with SMTP id d2e1a72fcca58-83f18ef6fd4mr5024594b3a.34.1778792725724; Thu, 14
 May 2026 14:05:25 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Thu, 14 May 2026 14:05:00 -0700
In-Reply-To: <20260514210500.1626871-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260514210500.1626871-1-seanjc@google.com>
X-Mailer: git-send-email 2.54.0.563.g4f69b47b94-goog
Message-ID: <20260514210500.1626871-21-seanjc@google.com>
Subject: [kvm-unit-tests PATCH v3 20/20] x86: Prevent realmode test code
 instrumentation with nop-mcount
From: Sean Christopherson <seanjc@google.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, Sean Christopherson <seanjc@google.com>, 
	Mathias Krause <minipli@grsecurity.net>, Andrew Jones <andrew.jones@linux.dev>
Content-Type: text/plain; charset="UTF-8"

From: Mathias Krause <minipli@grsecurity.net>

Commit f01ea38a385a ("x86: Better backtraces for leaf functions") made
use of '-pg -mnop-mcount' to provide a lightweight way to force leaf
functions to emit a proper prologue for the backtracing code. However,
-mnop-mcount doesn't play well with 16-bit code generation for C code.
gcc happily emits a 5-byte NOP that transmutes to a 4-byte NOP followed
by a zero byte when executed in real mode, wrecking all code that
follows.

Fix that by selectively disabling '-mnop-mcount' for realmode.c, making
it call mcount(), which is provided as a stub function.

Note, a fix for the bad gcc behavior has been queued for gcc-16, i.e.
this workaround can be dropped when gcc-16 is the minimal supported
version for KUT (so in about 30 years).

Link: https://gcc.gnu.org/git/?p=gcc.git;a=commitdiff;h=114a19fae9bd [1]
Reported-by: Sean Christopherson <seanjc@google.com>
Fixes: f01ea38a385a ("x86: Better backtraces for leaf functions")
Signed-off-by: Mathias Krause <minipli@grsecurity.net>
[sean: add note regarding gcc bug]
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 x86/Makefile.common | 5 ++++-
 x86/realmode.c      | 3 +++
 2 files changed, 7 insertions(+), 1 deletion(-)

diff --git a/x86/Makefile.common b/x86/Makefile.common
index f7e3ba78..f5cbd9cf 100644
--- a/x86/Makefile.common
+++ b/x86/Makefile.common
@@ -51,7 +51,9 @@ ifneq ($(KEEP_FRAME_POINTER),)
 # We need to defer the cc-option test until -fno-pic or -no-pie have been
 # added to CFLAGS as -mnop-mcount needs it. The lazy evaluation of CFLAGS
 # during compilation makes this do "The Right Thing."
-LATE_CFLAGS += $(call cc-option, -pg -mnop-mcount, "")
+NOP_PGFLAGS := -pg -mnop-mcount
+LATE_CFLAGS += $(call cc-option, $(NOP_PGFLAGS), "")
+NO_NOP_MCOUNT = $(if $(filter $(NOP_PGFLAGS),$(LATE_CFLAGS)),-mno-nop-mcount)
 endif
 
 FLATLIBS = lib/libcflat.a
@@ -123,6 +125,7 @@ $(TEST_DIR)/realmode.elf: $(TEST_DIR)/realmode.o $(SRCDIR)/$(TEST_DIR)/realmode.
 	      -T $(SRCDIR)/$(TEST_DIR)/realmode.lds $(filter %.o, $^)
 
 $(TEST_DIR)/realmode.o: bits = $(realmode_bits)
+$(TEST_DIR)/realmode.o: CFLAGS += $(NO_NOP_MCOUNT)
 
 $(TEST_DIR)/access_test.$(bin): $(TEST_DIR)/access.o
 
diff --git a/x86/realmode.c b/x86/realmode.c
index 7a4423ec..0a7104d4 100644
--- a/x86/realmode.c
+++ b/x86/realmode.c
@@ -23,6 +23,9 @@ void test_function(void);
 asm(
 	"test_function: \n\t"
 	"mov $0x1234, %eax \n\t"
+	"ret\n\t"
+	/* mcount() stub */
+	"mcount:\n\t"
 	"ret"
    );
 
-- 
2.54.0.563.g4f69b47b94-goog

