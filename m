Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4879F318140
	for <kvm@vger.kernel.org>; Wed, 27 May 2026 20:22:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779913351; cv=none; b=Ozh7uhDXbe+2nC4oxohjmEoHb25GFrAS9VtD7A/XTwxZ2++GECUp7lVMT6IQ00fYKm5uM3KxwPDWZ/7BmwSWtHTOZ0+5AWeeL9gBvolOHIuCenMbtrF6pvw8tLm9xxrjeY0zzkxcjiLGZCNemuDIvqBUKPXnRRFRoJ76D/7w75g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779913351; c=relaxed/simple;
	bh=Mo59a1BLAz9E6kmHqr7N/cnUIijgeurnKkrlECN41PQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=sKXPzlfeQyBoWIvTWG7qIDwdMWQexufadLRi0y/Dttt1oJhnkDlZ45RFxj+b5pzVNccV18AnEjBMez2LyTbaxErhnTHVA/Ue0PmMFqN4RLxH7MIdL8+/ef1PVyOFehSWcWboT/HLz0l6O7R6h9+uws+SxCLg9vbPQgmJEQ9fSPQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=grsecurity.net; spf=pass smtp.mailfrom=opensrcsec.com; dkim=pass (2048-bit key) header.d=grsecurity.net header.i=@grsecurity.net header.b=V0uc9oKZ; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=grsecurity.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=opensrcsec.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=grsecurity.net header.i=@grsecurity.net header.b="V0uc9oKZ"
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-449d6c68ed8so7744439f8f.0
        for <kvm@vger.kernel.org>; Wed, 27 May 2026 13:22:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=grsecurity.net; s=grsec; t=1779913347; x=1780518147; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=/phIBob5/LsGUgS2huwvTHIrgd30MG/BLjw8NBB3TPA=;
        b=V0uc9oKZQOmQOa5aL2hPRa5Flj7HwlAtMB93H946oBghl83oZ9ZrFCt8L29Y7H2/NG
         BM1c3sxG4rQiKfh5V/ddCZSprh1EmipVk2oAD3ikLw9tm+Mx55pLMBndTh7zIGEThLxF
         g5ukR4tayj6syEXqomfBVH9QGsiodNWRZDRA5KAsw/n1xxLYbwn6YsaGx0xXUevVPZLM
         23sZNcByoCnjZ6fMoTi1q12DiSv1MX0CAlEL99Ov0RMCGpEG1c2T5fbH0ugxZYTae5uw
         GRD8XFhUEXVOgdskKnoBynK0wIQrvxt7kqqdTd75Rn/jBI0zPRwqISUs/CB4RJdWFqrq
         DuDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779913347; x=1780518147;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/phIBob5/LsGUgS2huwvTHIrgd30MG/BLjw8NBB3TPA=;
        b=AwRx12cqIY0mow7re9H4izzTcUzN9wW1KY9lXBocRrB+07+t7p+n8ohSFUmjKnlVTM
         QFJF6+A+QtCyH5Tv+QhlZrAuossArnrzaXzbrApfDi7cZzvv/CKZQjYE8OMmChEUUkPo
         gDBgTO4M0eno1TyZUgZSTkVjF0Whp47J+tgMGpJ2bLRUB7CQGFjaccLf7Miwvd3249VC
         ydCMuK2oXYuHRPoXU6z19gb4obup3D5nbUnq2E5e0MpdBt8iVcaBeZGY54PQHzhFUHvH
         hxNSLkrAI5w0IBy/sm6kuGQNvh44TRGYp9ylgroAouGXbyXwWzA/a9PcdC+NkiZI7eRD
         Bl1g==
X-Forwarded-Encrypted: i=1; AFNElJ8qOH7anyWuAyWiKLFt0m3dqrTULlCpn5JnAkcu1Tn1g4KO954AglUiS2yi4Rz7IQtOfOQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz9wR3yqCLgdP60v9tJJSZwbpLj9jgZws9wpA4WSwFMmCG5Cw7Y
	jAKOHeLYnWCqoS0DY9NwLgjCmFDMbaEv8rWx6FUb9L2S+7JWgztg7GKlVxcklgCqnoU=
X-Gm-Gg: Acq92OFBraybHPGVJnLAM8BNjjMppG/O6JpsNgTumsjUDEdEqmN9kVA+fTwn+zeQqSC
	7mo1rGIb3i7zVu8DYKOYSdIHxL/wPt5EEW2FB9gc9YhO8OudfJ5mkMORounl6PZgVLXbIRyRL/4
	mlDs261t9kRn/C0o6lSn7I0kkCqIkb6+1QpojvGdX5jfQyt52FbZWaPM2I6Gsf0JaglgJrahWtp
	S1scHZr2tkvYE11KfbXe4CcXGaDabcLjtrf7vqwYI0ev+gtVmHabNG+HgWlTw8/5tmBfx2eIILu
	c+Wiyan69g4oJDoAuwCidiVYYoTAA/YDYN9AqXp/RCzV/hHxjeTM9W8nvwV8ljl5TnqQCcpeIVv
	cM8fi4v4rtsiTtl3ZHdsSenVCnUO+kjXOWBEEjGVRxASo5QvHHfLOvgbHiG2xXAX4QyU/YiAnnt
	xT8j/18EPtscRpyRDjWu8ktQn5wsnzVMW5bgSWt6SAcBa11UfQ57yAEoN2cZTMjOkr4y8CZkzzY
	VVg84WKKrMklvSlKD9IUBzEdrCDhw==
X-Received: by 2002:adf:e005:0:10b0:439:c18f:5aaf with SMTP id ffacd0b85a97d-45eb38bafbcmr30089616f8f.34.1779913347447;
        Wed, 27 May 2026 13:22:27 -0700 (PDT)
Received: from bell.fritz.box (p200300faaf260200051aef03a698a1fc.dip0.t-ipconnect.de. [2003:fa:af26:200:51a:ef03:a698:a1fc])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-45edb54959bsm9247841f8f.1.2026.05.27.13.22.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 May 2026 13:22:26 -0700 (PDT)
From: Mathias Krause <minipli@grsecurity.net>
To: Paolo Bonzini <pbonzini@redhat.com>,
	Sean Christopherson <seanjc@google.com>
Cc: Andrew Jones <andrew.jones@linux.dev>,
	kvm@vger.kernel.org,
	Mathias Krause <minipli@grsecurity.net>
Subject: [kvm-unit-tests PATCH v4] x86: Better backtraces for leaf functions
Date: Wed, 27 May 2026 22:22:19 +0200
Message-ID: <20260527202219.1502399-1-minipli@grsecurity.net>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

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

Unfortunately, compiler bugs and nitpicks require additional quirks.
Namely, -mnop-mcount doesn't play well with 16-bit code generation for C
code. gcc happily emits a 5-byte NOP that transmutes to a 4-byte NOP
followed by a zero byte when executed in real mode, wrecking all code
that follows.

Fix that by selectively disabling '-mnop-mcount' for realmode.c, making
it call mcount / __fentry__, which are provided as stub functions.

Another quirk is the requirement of -mfentry which recent gcc-16 started
complaining about if it's not used together with -pg.

Thanks a lot Sean and Paolo for helping finding and fixing these issues!

Note, a fix[1] for the bad gcc behavior has been shipped with gcc-16,
i.e. this workaround can be dropped when gcc-16 is the minimal
supported version for KUT (so in about 30 years).

Link: https://gcc.gnu.org/git/?p=gcc.git;a=commitdiff;h=114a19fae9bd [1]
Reported-by: Paolo Bonzini <pbonzini@redhat.com>
Reported-by: Sean Christopherson <seanjc@google.com>
Signed-off-by: Mathias Krause <minipli@grsecurity.net>
---

Sean, I dropped your SoB because it felt inappropriate to keep it after
mangling the patch so much.

v4:
- squashed the realmode fix into this change
- integrated -mfentry, reported by Paolo
v3: https://lore.kernel.org/kvm/20260514210500.1626871-1-seanjc@google.com/

 x86/Makefile.common | 22 ++++++++++++++++++++++
 x86/realmode.c      |  4 ++++
 2 files changed, 26 insertions(+)

diff --git a/x86/Makefile.common b/x86/Makefile.common
index a251dd71e3b6..88a671187fe9 100644
--- a/x86/Makefile.common
+++ b/x86/Makefile.common
@@ -43,6 +43,27 @@ COMMON_CFLAGS += -O1
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
+#
+# -mfentry is only needed because recent versions of gcc otherwise warn about
+# the lack of it, that it may cause placing the profiling call not directly
+# after the prologue but somewhere later -- not that we care but be nice and
+# avoid that warning.
+#
+# NO_NOP_MCOUNT is needed for the 16-bit realmode.o which causes gcc before
+# gcc-16 to generate broken code (5-byte NOP instead of 3-byte one).
+NOP_PGFLAGS := -pg -mfentry -mnop-mcount
+LATE_CFLAGS += $(call cc-option, $(NOP_PGFLAGS), "")
+NO_NOP_MCOUNT = $(if $(filter $(NOP_PGFLAGS),$(LATE_CFLAGS)),-mno-nop-mcount)
+endif
+
 FLATLIBS = lib/libcflat.a
 
 ifeq ($(CONFIG_EFI),y)
@@ -113,6 +134,7 @@ $(TEST_DIR)/realmode.elf: $(TEST_DIR)/realmode.o $(SRCDIR)/$(TEST_DIR)/realmode.
 
 $(TEST_DIR)/realmode.o: bits = $(realmode_bits)
 $(TEST_DIR)/realmode.o: CFLAGS += -Os -Wno-array-bounds
+$(TEST_DIR)/realmode.o: CFLAGS += $(NO_NOP_MCOUNT)
 
 $(TEST_DIR)/access_test.$(bin): $(TEST_DIR)/access.o
 
diff --git a/x86/realmode.c b/x86/realmode.c
index 7a4423ec6098..38bd6cdbabc1 100644
--- a/x86/realmode.c
+++ b/x86/realmode.c
@@ -23,6 +23,10 @@ void test_function(void);
 asm(
 	"test_function: \n\t"
 	"mov $0x1234, %eax \n\t"
+	"ret\n\t"
+	/* profiling stubs */
+	"__fentry__:\n\t"
+	"mcount:\n\t"
 	"ret"
    );
 
-- 
2.47.3

