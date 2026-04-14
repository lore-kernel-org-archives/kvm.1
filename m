Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EEE7310784
	for <kvm@vger.kernel.org>; Tue, 14 Apr 2026 18:08:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776190084; cv=none; b=BxTsQPOYYNDLOb4RGc7egqjT90IMxUG5kTt46ggHrhh/Q3+oQhjELur/F+1MPkYRnyXYn6upobSCy9Ha1bJaHFJB/FukDw6O8Z9ocr0CrD4jAIloIkrgdH6xwNGejfJFXRRUEghhtD4JwaW8dP1n4zjhNBFgCQHWePtvSmyjNEY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776190084; c=relaxed/simple;
	bh=cCHZn38WYTfp/PfpDh6xqMgiUCYfrrR68b4aQ76CpZI=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=n3V+Er+qn/yCdCxZEeqkyJd23txxfDMMDe4N1tt9n6AEGIvixOHOqLPskGePdBTvvEmgPmYbVHQTNlEXuAtoFb/PYoNuyGN8n+LvAP0aXiBCmC2k37etBsbRnelYdpHwuAScHytsAfGZxYQYZd7AvhlSk6H/v4Dxj4ae4cAXQOc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ackerleytng.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=F0rjWN5D; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ackerleytng.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="F0rjWN5D"
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-35dacc40f92so6098912a91.2
        for <kvm@vger.kernel.org>; Tue, 14 Apr 2026 11:08:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1776190083; x=1776794883; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=o70ztLmmao+vAPqOCIv6vc9Rx7/bbrrSC8znt4hxDkc=;
        b=F0rjWN5DEpfi5t/0KqqIphWLFwvJJ2Kh3dXZ9fOSXj85yRftB8bWvg8ikYsuQKCNjz
         AMK0JNXEThWPI+a/rV7CDazIZnepjwZRxPPW8EdTJhPoRIaluyA7oAahwQuKk4rw/M5W
         DQpuH2NWhUq+3iQ3sC5O3RrBKiUz5UQaTow2PuXdMZ5yAl0RJ/Vv6g9//vDI2T1Ze77J
         uLtf/ZCJBHJhcvE/AsN6VDpt9JuRXB4pdU3mG3pA70PPgOuUCpOlg4hWgU/bA5AP81Gk
         nBV7TW6vFJ/FeqIVKPeuseHuTtjjowW+GtSoKRJOXP4bKQitwJ/6E3yVSTJnvjU8jHeO
         jtUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776190083; x=1776794883;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=o70ztLmmao+vAPqOCIv6vc9Rx7/bbrrSC8znt4hxDkc=;
        b=NxihCCN//9nbHVeu0LUz4w3yf9mZ7ptG4JxCPxNgKHol5KD2P5FH/Sz7WiYQYUTp/q
         I8tj9pCYgyVwvNmQ5uvCg7tZW7JFnfAEZbcNYlwQcrSSYEWUQQ5j+sTU7HT7/U1ZDTpr
         NrNhHPeKn+EZajDBacs/AI2dIZoEPTqDOZVkhFFIaMSxBFRNZgvWKpxDNsqZn/6mAw3+
         w0XrewVdFmUS57jLW7tAwZxbIodUFe20IZKTInsxokj/dvXSz73BbSgKNvAACDZWScTg
         aU2BCzx/Q6uD+wXJ/Afu5uSifjleNnAQbE3hctq410paXH69YgrHAxrw1Hi3jqq/wIF4
         vdVA==
X-Forwarded-Encrypted: i=1; AFNElJ9WO7+szyP3Zi7bUFnYVBA9ryp9vGs4X0H5gs2+lRHAS5d5SjOLldDH50Av+5b9mr7S0t8=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywd/dCEgfDmuyJCsMg4hm63wijNsoo1Y6stCZaKtPSFYpVvNmei
	NO+v9huwFJFoETl8Zl7Fs9k3mo6YNgZYgdS3gCp0b7OwnpDg8Gaf+nrr7UNvudPSu8JYBR6COL+
	q3ZFZLs0Bdq8wOKkgNLlOzUvtDw==
X-Received: from pjbpc11.prod.google.com ([2002:a17:90b:3b8b:b0:35f:bc0b:9e68])
 (user=ackerleytng job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:90b:4a41:b0:35f:bf4b:c396 with SMTP id 98e67ed59e1d1-35fbf4bc5afmr5869715a91.1.1776190082419;
 Tue, 14 Apr 2026 11:08:02 -0700 (PDT)
Date: Tue, 14 Apr 2026 11:07:51 -0700
In-Reply-To: <20260414-selftest-global-metadata-v1-0-fd223922bc57@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260414-selftest-global-metadata-v1-0-fd223922bc57@google.com>
X-Developer-Key: i=ackerleytng@google.com; a=ed25519; pk=sAZDYXdm6Iz8FHitpHeFlCMXwabodTm7p8/3/8xUxuU=
X-Developer-Signature: v=1; a=ed25519-sha256; t=1776190073; l=2614;
 i=ackerleytng@google.com; s=20260225; h=from:subject:message-id;
 bh=cCHZn38WYTfp/PfpDh6xqMgiUCYfrrR68b4aQ76CpZI=; b=sSACYS9gSD/hjegQqS7FunUv1uUKDq73UvxPXisnBycuA3wBRv2EP5SYXkK8+6nVYNmc3wtqs
 9STcGZMFigcBSlsymzSgW9FjARexZWfRpJl5Dsc2zKMPcQMypdK7twp
X-Mailer: b4 0.14.3
Message-ID: <20260414-selftest-global-metadata-v1-4-fd223922bc57@google.com>
Subject: [PATCH RFC 4/4] HACK: Show that the teardown function is called from
 KVM selftests
From: Ackerley Tng <ackerleytng@google.com>
To: Kees Cook <kees@kernel.org>, Andy Lutomirski <luto@amacapital.net>, Will Drewry <wad@chromium.org>, 
	Shuah Khan <shuah@kernel.org>, Paolo Bonzini <pbonzini@redhat.com>, 
	Sean Christopherson <seanjc@google.com>, thomas.weissschuh@linutronix.de, linux@weissschuh.net
Cc: linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	kvm@vger.kernel.org, Ackerley Tng <ackerleytng@google.com>
Content-Type: text/plain; charset="utf-8"

Running the selftest tools/testing/selftests/kvm/kvm_test_harness_selftest
gets me this:

$ tools/testing/selftests/kvm/kvm_test_harness_selftest
Random seed: 0x6b8b4567
TAP version 13
1..2
setup
teardown
ok 1 my_fixture.my_test_pass
setup
==== Test Assertion Failure ====
  kvm_test_harness_selftest.c:28: false
  pid=73044 tid=73044 errno=0 - Success
     1  0x0000000000402c04: my_fixture_my_test_assert at kvm_test_harness_selftest.c:28
     2   (inlined by) wrapper_my_fixture_my_test_assert at kvm_test_harness_selftest.c:26
     3  0x0000000000403497: __run_test at kselftest_harness.h:1185
     4  0x0000000000402340: test_harness_run at kselftest_harness.h:1256
     5   (inlined by) main at kvm_test_harness_selftest.c:33
     6  0x000000000041ef10: __libc_start_call_main at libc-start.o:?
     7  0x000000000042108c: __libc_start_main_impl at ??:?
     8  0x00000000004026e0: _start at ??:?
  foobar
teardown
not ok 2 my_fixture.my_test_assert

Signed-off-by: Ackerley Tng <ackerleytng@google.com>
---
 tools/testing/selftests/kvm/Makefile.kvm           |  1 +
 .../selftests/kvm/kvm_test_harness_selftest.c      | 34 ++++++++++++++++++++++
 2 files changed, 35 insertions(+)

diff --git a/tools/testing/selftests/kvm/Makefile.kvm b/tools/testing/selftests/kvm/Makefile.kvm
index 6471fa214a9f9..d32045f7d9396 100644
--- a/tools/testing/selftests/kvm/Makefile.kvm
+++ b/tools/testing/selftests/kvm/Makefile.kvm
@@ -64,6 +64,7 @@ TEST_GEN_PROGS_COMMON += kvm_binary_stats_test
 TEST_GEN_PROGS_COMMON += kvm_create_max_vcpus
 TEST_GEN_PROGS_COMMON += kvm_page_table_test
 TEST_GEN_PROGS_COMMON += set_memory_region_test
+TEST_GEN_PROGS_COMMON += kvm_test_harness_selftest
 
 # Compiled test targets
 TEST_GEN_PROGS_x86 = $(TEST_GEN_PROGS_COMMON)
diff --git a/tools/testing/selftests/kvm/kvm_test_harness_selftest.c b/tools/testing/selftests/kvm/kvm_test_harness_selftest.c
new file mode 100644
index 0000000000000..36ce14226fdb7
--- /dev/null
+++ b/tools/testing/selftests/kvm/kvm_test_harness_selftest.c
@@ -0,0 +1,34 @@
+#include <stdio.h>
+
+#include "kselftest_harness.h"
+#include "test_util.h"
+
+FIXTURE(my_fixture)
+{
+
+};
+
+FIXTURE_SETUP(my_fixture)
+{
+	pr_info("setup\n");
+}
+
+FIXTURE_TEARDOWN(my_fixture)
+{
+	pr_info("teardown\n");
+}
+
+TEST_F(my_fixture, my_test_pass)
+{
+	TEST_ASSERT(true, "foobar");
+}
+
+TEST_F(my_fixture, my_test_assert)
+{
+	TEST_ASSERT(false, "foobar");
+}
+
+int main(int argc, char **argv)
+{
+	return test_harness_run(argc, argv);
+}

-- 
2.54.0.rc0.605.g598a273b03-goog

