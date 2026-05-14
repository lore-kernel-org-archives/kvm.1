Received: from mail-pg1-f202.google.com (mail-pg1-f202.google.com [209.85.215.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA9653CFF44
	for <kvm@vger.kernel.org>; Thu, 14 May 2026 21:05:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778792726; cv=none; b=TgNTVnVvMjch29GCPbO/2C21xJgFIRlMrDRllDv/rEuviCCyqQR8mCf10HcPOp8v3aVOc2IW1G35GTGFMw/2gdNz1hgJu2W08vtCLv4+/NFBDc2Floao+rgw29q5/M3/gAZ+hCbZ1IIzamOYrUybYS5MsVv2/yHyJRKDYzoHQa8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778792726; c=relaxed/simple;
	bh=iiC6JEuwmYFJnXijN5bZU+UsEbjKwXAAe+L1XUgq8ic=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=S6j2vKvJKKtJHWEOEwss9zxwbDTJtWU8l+XT+RigiDD1VCo0wr6gWpHPVzE4zyRj8AdCqrD/lRkvPbeSRT8ldF8B7Y1Ej3iwmpRLTNw5HEkIqUUPCGrRDgDeWNu2YhyH0ETpLFpXhNnTJ2Hkb5tQJq23ITrqIXIIKEU19Gv1dIU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=doQ/oYct; arc=none smtp.client-ip=209.85.215.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="doQ/oYct"
Received: by mail-pg1-f202.google.com with SMTP id 41be03b00d2f7-c709551ec08so10265943a12.3
        for <kvm@vger.kernel.org>; Thu, 14 May 2026 14:05:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1778792725; x=1779397525; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=t5dj5wuGntrdeYQ/lqRvyyU2GzSVuNp7EDDzxmhSR00=;
        b=doQ/oYctb2EloORml98Mm3/ZAVAv+Tn7DEQk/6uySJqx45oGGD29kqvfgxZdqsX0EB
         hruFApHPssi0Q/DZnAsrP8VwTPrGYH/vakjEEZtaHDJPCbfd1Aw4MExlscds33jZxQr3
         mwNd7Wq/l6+Cml4a2LOozjeijZjjz+2AEYs/5LEEqp50xBxj4vqclH2kze+fjEZjUzGr
         xjguMywwRLZnuT3YrF/c67VyaQZTcaiYDVPc3dBTCszoF6jcDoRz+TCVoRFRpK+mXiUk
         NZDJhgrRZqhXCAP0Kx+KaMqp8kUc5KGMQ+vTEjEuWB6vYhwLBf3MmT43mBjkgypr2Ybp
         rC+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778792725; x=1779397525;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=t5dj5wuGntrdeYQ/lqRvyyU2GzSVuNp7EDDzxmhSR00=;
        b=LxUE/M5HKC/jT30ledr/c2tp9CKbDdsBcIARpdmIvimvDiF9+5AR/p0BPYEyEXEpdX
         cOUmhuy0oeUCyhJ1Ex1UEfNN10aIjVVPtucPT3acpWf8hekJoiBme7O9Tu+AX/bfF4vu
         WobALo8r7NJ32clUEDuA70mrUsP1ddmJ/DaUazjvj3u5cSH3yj3QkZz4lYX65eGEqZfS
         xrs4IdBFL8fcPXEdkk4OJsZ5b6DxdFszBcg8YDwiNzQOyLgJ7hqWRUmMLYfuuHCjSwSC
         CC9HMV8m03bAXa5U5l35qjuwV/YlHVaCE1KCdwqHAmt4IY7YJMxyyDZLzVcLu9hEhCyC
         hjzA==
X-Gm-Message-State: AOJu0YxczmKD4+TBectOK+6jMjY/KnPdsqgnS2S0bFTHo8dbAnAfwjJz
	36ZFWnMl4eAJVofGyMsUgfzJ1VAlI5bzJi26AAqWc1KqjrWmD3glq7yJmE1QH3YL5VVjSt5mMUd
	NDQOnVQ==
X-Received: from pfbik6.prod.google.com ([2002:a05:6a00:8d06:b0:835:394c:6e39])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:3925:b0:837:a211:4ef3
 with SMTP id d2e1a72fcca58-83f33df84a0mr1082460b3a.42.1778792724592; Thu, 14
 May 2026 14:05:24 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Thu, 14 May 2026 14:04:59 -0700
In-Reply-To: <20260514210500.1626871-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260514210500.1626871-1-seanjc@google.com>
X-Mailer: git-send-email 2.54.0.563.g4f69b47b94-goog
Message-ID: <20260514210500.1626871-20-seanjc@google.com>
Subject: [kvm-unit-tests PATCH v3 19/20] x86: Better backtraces for leaf functions
From: Sean Christopherson <seanjc@google.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, Sean Christopherson <seanjc@google.com>, 
	Mathias Krause <minipli@grsecurity.net>, Andrew Jones <andrew.jones@linux.dev>
Content-Type: text/plain; charset="UTF-8"

From: Mathias Krause <minipli@grsecurity.net>

Leaf functions are problematic for backtraces as they lack the frame
pointer setup epilogue. If such a function causes a fault, the original
caller won't be part of the backtrace. That's problematic if, for
example, memcpy() is failing because it got passed a bad pointer. The
generated backtrace will look like this, providing no clue what the
issue may be:

	STACK: @401b31 4001ad
  0x0000000000401b31: memcpy at lib/string.c:136 (discriminator 3)
        	for (i = 0; i < n; ++i)
      > 		a[i] = b[i];

  0x00000000004001ac: gdt32_end at x86/cstart64.S:127
        	lea __environ(%rip), %rdx
      > 	call main
        	mov %eax, %edi

By abusing profiling, we can force the compiler to emit a frame pointer
setup epilogue even for leaf functions, making the above backtrace
change like this:

	STACK: @401c21 400512 4001ad
  0x0000000000401c21: memcpy at lib/string.c:136 (discriminator 3)
        	for (i = 0; i < n; ++i)
      > 		a[i] = b[i];

  0x0000000000400511: main at x86/hypercall.c:91 (discriminator 24)

      > 	memcpy((void *)~0xbadc0de, (void *)0xdeadbeef, 42);

  0x00000000004001ac: gdt32_end at x86/cstart64.S:127
        	lea __environ(%rip), %rdx
      > 	call main
        	mov %eax, %edi

Above backtrace includes the failing memcpy() call, making it much
easier to spot the bug.

Enable "fake profiling" if supported by the compiler to get better
backtraces. The runtime overhead should be negligible for the gained
debugability as the profiling call is actually a NOP.

Signed-off-by: Mathias Krause <minipli@grsecurity.net>
Reviewed-by: Andrew Jones <andrew.jones@linux.dev>
Tested-by: Andrew Jones <andrew.jones@linux.dev>
Fixes: f01ea38a385a ("x86: Better backtraces for leaf functions")
Reported-by: Sean Christopherson <seanjc@google.com>
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 x86/Makefile.common | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/x86/Makefile.common b/x86/Makefile.common
index ef0e09a6..f7e3ba78 100644
--- a/x86/Makefile.common
+++ b/x86/Makefile.common
@@ -43,6 +43,17 @@ COMMON_CFLAGS += -O1
 # stack.o relies on frame pointers.
 KEEP_FRAME_POINTER := y
 
+ifneq ($(KEEP_FRAME_POINTER),)
+# Fake profiling to force the compiler to emit a frame pointer setup also in
+# leaf function (-mno-omit-leaf-frame-pointer doesn't work, unfortunately).
+#
+# Note:
+# We need to defer the cc-option test until -fno-pic or -no-pie have been
+# added to CFLAGS as -mnop-mcount needs it. The lazy evaluation of CFLAGS
+# during compilation makes this do "The Right Thing."
+LATE_CFLAGS += $(call cc-option, -pg -mnop-mcount, "")
+endif
+
 FLATLIBS = lib/libcflat.a
 
 ifeq ($(CONFIG_EFI),y)
-- 
2.54.0.563.g4f69b47b94-goog

