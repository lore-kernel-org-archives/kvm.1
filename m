Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D0263E1204
	for <kvm@vger.kernel.org>; Tue, 31 Mar 2026 19:42:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774986149; cv=none; b=o0Dzzj/jnPpAstpPsTRwktFfbYkiMRTTOtMC5PzbjONcXlt8H+7ZHtJ9oNX8F4h+AcmDSlIiN1aNuVLiBEw1Ph7ChkW0qUi+/PUSyaxrDxDerHiiMp4ajQLcwvBdpy5pAh4Idu6WM3Ia5jCIrREATFxfNLft3cLIrjnxNvN49EM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774986149; c=relaxed/simple;
	bh=uI0SPO45nQ55zfm6jOzEO7zUNIVAxE6AaTYr9tc1xrw=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=OVVUiP5Gc8BgQsft4vIhfQ59S+e7pK+ExAlqK2J4T4gKb3O/pEbsL6IrFfohTv30njYeAmZDszF5B4leRuoPfjLEmRCzcy/HZ8FBNZk7k5vj2uZI1iZf4kflrEiph2hd8fxuB+hXg2HNvhdfp3aiW/uumN6hs+S5VAbTwEFdTfc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--vipinsh.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=rVAJcHwi; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--vipinsh.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="rVAJcHwi"
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-35d9e67f6dcso8953112a91.1
        for <kvm@vger.kernel.org>; Tue, 31 Mar 2026 12:42:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1774986147; x=1775590947; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=EMAEEYc33pbDyh5jLNn4+2ckaUXnuUr3hoaO2wyMBMY=;
        b=rVAJcHwiF5dflFZ9BRUX1axME8xC8IGnCAvfglKeanvoD/PatIOVpDhT3zLPRx9sPQ
         kf0FRMfvNp+Mp5OfExGFTpRFzqkKFDLbjTSvbpC7WYc6I6fNSy/p2sQ/OH4STFHxJh2J
         7Ggkjgn/88FK2Bht4eDEia3+1/eHN7MSKUUoikQGvYBBoSp0QocQYNiCXWdbKnaBVlrk
         OPU6FL0O0deW3c96E1mZRiUibIuM0IthQsyy0R8RRO+e+Y4DTKh5k9QcMZEZyBWCr2Fv
         ZfCxa4JwaCq6jjzuzU4/0KDM3lLF/gBQqNgyZY24WmI6/FULgTxuQfbtLxU7cMXXAYYH
         U3TA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774986147; x=1775590947;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=EMAEEYc33pbDyh5jLNn4+2ckaUXnuUr3hoaO2wyMBMY=;
        b=RnZfZhY5xaeckJU9GPqs59GWY42KbX/I2Yw2ehMVL3aiAPEFT2pIaGpWCHA7a9WaNC
         Yfovb8UIAnoHbOWSaJrTE97yEbDPXkV9TI4Ov/DgoJHRoOHnE7Z3QiEUAqnwu+BP4OSA
         uUb1CYdyGEMd/Mkeh3jthOZAugMvvhFgg91t81YVqENbqrR/tr9G9h+xYHjnqRviICUf
         pR4QmL/wNAInVa2G+Koxk4MlMnzo9YmFoQ6MeqxMSNnqCcvOXHyx5JoZXe/7229HqnhA
         3EzieejN97LZorU5rb4D5SQFAXkHYXeggCuTJrvDEZBCSCYDNfHRvLXI64HTfPYnwEYo
         eJbg==
X-Gm-Message-State: AOJu0Ywj+MFMGacMp8meAEMg+os9enoUzz1LrAnGSrpVqh/dyVnFQiWf
	pI9ah+W5tsTlp1v7Oj5884mYeMQF2yYwaxjp3aAP9QsimmAlSS4YT7YTK9BTP07F+zmFMydoEut
	ohQnGtn49KGr/pUel5RTH9Ns0tOkJTRq8GO5vCCJ4e3deOK+/1Zlmd4ptkwYGwbjpl44wvnCf56
	ONf7jneHOhkC93MiNx9wlEj+FghYkCv5LyC6rvvQ==
X-Received: from pjpe5.prod.google.com ([2002:a17:90a:9a85:b0:35d:9d42:3153])
 (user=vipinsh job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:1850:b0:359:ff8a:ee4f
 with SMTP id 98e67ed59e1d1-35dc6e9bc88mr571073a91.7.1774986147217; Tue, 31
 Mar 2026 12:42:27 -0700 (PDT)
Date: Tue, 31 Mar 2026 12:42:01 -0700
In-Reply-To: <20260331194202.1722082-1-vipinsh@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260331194202.1722082-1-vipinsh@google.com>
X-Mailer: git-send-email 2.53.0.1118.gaef5881109-goog
Message-ID: <20260331194202.1722082-9-vipinsh@google.com>
Subject: [PATCH v4 8/9] KVM: selftests: Add rule to generate default tests for
 KVM selftests runner
From: Vipin Sharma <vipinsh@google.com>
To: kvm@vger.kernel.org, kvmarm@lists.linux.dev, kvm-riscv@lists.infradead.org
Cc: seanjc@google.com, pbonzini@redhat.com, borntraeger@linux.ibm.com, 
	frankja@linux.ibm.com, imbrenda@linux.ibm.com, anup@brainfault.org, 
	atish.patra@linux.dev, zhaotianrui@loongson.cn, maobibo@loongson.cn, 
	chenhuacai@kernel.org, maz@kernel.org, oliver.upton@linux.dev, 
	ajones@ventanamicro.com, Vipin Sharma <vipinsh@google.com>
Content-Type: text/plain; charset="UTF-8"

Add 'tests_install' rule in the Makefile.kvm to auto generate default
testcases for KVM selftests runner. Preserve the hierarchy of test
executables for autogenerated files. Remove these testcases on
invocation of 'make clean'.

Autogeneration of default test files allows runner to execute default
testcases easily. These default testcases don't need to be checked in as
they are just executing the test without any command line options.

Signed-off-by: Vipin Sharma <vipinsh@google.com>
---
 tools/testing/selftests/kvm/.gitignore   |  1 +
 tools/testing/selftests/kvm/Makefile.kvm | 26 +++++++++++++++++++++++-
 2 files changed, 26 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/kvm/.gitignore b/tools/testing/selftests/kvm/.gitignore
index 95af97b1ff9e..548d435bde2f 100644
--- a/tools/testing/selftests/kvm/.gitignore
+++ b/tools/testing/selftests/kvm/.gitignore
@@ -7,6 +7,7 @@
 !*.S
 !*.sh
 !*.test
+default.test
 !.gitignore
 !config
 !settings
diff --git a/tools/testing/selftests/kvm/Makefile.kvm b/tools/testing/selftests/kvm/Makefile.kvm
index 6471fa214a9f..fb9439cb5f3d 100644
--- a/tools/testing/selftests/kvm/Makefile.kvm
+++ b/tools/testing/selftests/kvm/Makefile.kvm
@@ -1,7 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0-only
 include ../../../build/Build.include
 
-all:
+all: tests_install
 
 LIBKVM += lib/assert.c
 LIBKVM += lib/elf.c
@@ -330,11 +330,15 @@ $(SPLIT_TEST_GEN_PROGS): $(OUTPUT)/%: $(OUTPUT)/%.o $(OUTPUT)/$(ARCH)/%.o
 $(SPLIT_TEST_GEN_OBJ): $(OUTPUT)/$(ARCH)/%.o: $(ARCH)/%.c
 	$(CC) $(CFLAGS) $(CPPFLAGS) $(TARGET_ARCH) -c $< -o $@
 
+# Default testcases for KVM selftests runner will be generated in this directory.
+DEFAULT_TESTCASES = testcases_default_gen
+
 EXTRA_CLEAN += $(GEN_HDRS) \
 	       $(LIBKVM_OBJS) \
 	       $(SPLIT_TEST_GEN_OBJ) \
 	       $(TEST_DEP_FILES) \
 	       $(TEST_GEN_OBJ) \
+	       $(OUTPUT)/$(DEFAULT_TESTCASES) \
 	       cscope.*
 
 $(LIBKVM_C_OBJ): $(OUTPUT)/%.o: %.c $(GEN_HDRS)
@@ -363,3 +367,23 @@ cscope:
 	find . -name '*.c' \
 		-exec realpath --relative-base=$(PWD) {} \;) | sort -u > cscope.files
 	cscope -b
+
+# Generate runner testcases in DEFAULT_TESTCASES directory.
+# $(OUTPUT) is either CWD or specified in the make command.
+tests_install: list_progs = $(patsubst $(OUTPUT)/%,%,$(TEST_GEN_PROGS))
+tests_install:
+	$(foreach tc, $(TEST_PROGS), \
+		$(shell mkdir -p $(OUTPUT)/$(DEFAULT_TESTCASES)/$(patsubst %.sh,%,$(tc))))
+	$(foreach tc, $(TEST_PROGS), \
+		$(shell echo $(tc) > $(patsubst %.sh,$(OUTPUT)/$(DEFAULT_TESTCASES)/%/default.test,$(tc))))
+
+	$(foreach tc, $(list_progs), \
+		$(shell mkdir -p $(OUTPUT)/$(DEFAULT_TESTCASES)/$(tc)))
+	$(foreach tc, $(list_progs), \
+		$(shell echo $(tc) > $(patsubst %,$(OUTPUT)/$(DEFAULT_TESTCASES)/%/default.test,$(tc))))
+
+	@if [ ! -d $(OUTPUT)/runner ]; then             \
+		cp -r $(selfdir)/kvm/runner $(OUTPUT);  \
+	fi
+
+	@:
-- 
2.53.0.1118.gaef5881109-goog

