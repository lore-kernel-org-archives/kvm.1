Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82F1231E850
	for <kvm@vger.kernel.org>; Tue, 14 Apr 2026 18:08:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776190082; cv=none; b=E0vxaP+xe1Ry/ddoDwSZQA9y8BuAomxlUcx9IVrC9U+TZ6QkotBWiAZw+YKOfBlVkPK+8LUk48EFszUis69IBHjXQh5b7ytdabisPpuarQVPtTLl0NwyMSnO4WWDbBzOjYrCqS5zxqakWcynXq7As/xdF7pFxExZ/EsXN5SLV/U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776190082; c=relaxed/simple;
	bh=3eOaP1PjqwIMhC9h/73po0HRLNeVuCigZDPpl5LivDs=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=O7G+ZxGzEVGuVpCJpoJmnvR/Jr4Yqo04k5jKIor3Un5pJ+UG+BYhHRZro+3bg01MxNdALAupHt/vZO5JQKKpMNeDniJTNkzRT7wdT3QcRJqMR3rLI4RKpNTuVzO5tNRhMHJxbjQ3IqFhzMVST/UqhMSEoQPy8cyK4DmfBoDR/8M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ackerleytng.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=pvW9ZfkH; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ackerleytng.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="pvW9ZfkH"
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-35dacc40f92so6098899a91.2
        for <kvm@vger.kernel.org>; Tue, 14 Apr 2026 11:08:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1776190081; x=1776794881; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=xRzVsTq7xtAKE6uuc9zkrMY4DjEcTQtxRmj4+xciBiE=;
        b=pvW9ZfkHzjQod1r8mbEYINaokPs+tD0x9mWNrUApygLP3VbttvwygHf0oqnZhhiJTF
         62q+NBfCoIi19Fdc7mX9ag5I3cr75Redya1R0MBgLKjHB6PbeWmT2SMFFHzFs/g0OmLZ
         /EXJkRIxkzQI9h7hU16H/UkOA2HNOTcHrhcvtlx9zRXaLisDUzQtfHu5ZTPQdly98FOd
         jSA0yUsUANpyrY3A0QqqLgyiRk5dSXly/yA19CTVLJ1wf7xvV2vlNvNEX5Ndcc3wyMyT
         AzxwWNIR0+ZOzSyb3veJAGOkpIEV3CkgIKL3cDbDN9N/Av8tkroEfDbS0xH/7S1dYL3A
         A/wQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776190081; x=1776794881;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xRzVsTq7xtAKE6uuc9zkrMY4DjEcTQtxRmj4+xciBiE=;
        b=lfZnYwx+3SRjtAx8KZYP+zHXf1XBPMT126LDS8xWCSjsLULJ/RNtAa4hsL6844lU0A
         4U0FJvSxZ0QHOoVuhOZoEIX1WWAhG/PJlS2e+Zydc3iADhOikuocwfRCW1LiwcADqj7S
         oHhWq53I/QDAFGdasQw5roAQL2+uu5pCkA6g4cFPR8OAm87Sk5WMrKU+DUbro6Y5j+IL
         OVQrGEJAU/xM39xj74VwDRf/TZp6q2TCVNE7ruZnZX5Nbf5ljq9ybGs7YcTSzl8wLMvZ
         9rsBEDRok5uldm6VUvI0+fEJFBvip5hwirVzoiAMRqDXCKuvOf5Yiwp56XAMhLuCFX6M
         oZPQ==
X-Forwarded-Encrypted: i=1; AFNElJ/WV8rZgiHH5Yg9I1yp44sm9EncqgPlU0mYJ05BzsXcSFZNET7GN8A6QZUxUiVNR/Ehrkg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwWMVXQJdblRgvwXeW9O0Uh2J7nnH8pcDkh2urJ0HprAyTuphiM
	DdKcAYNq0BGfETswxyAkz3HLEmGCsnFuRAye5gp3d1+8fl9Gkcrccbw+K3wu/4VjOkbKLxiDAA0
	HatigqgP/nw9oYHiUhF7fUFNviA==
X-Received: from pjbme4.prod.google.com ([2002:a17:90b:17c4:b0:35d:9eb5:1fe])
 (user=ackerleytng job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:90b:4c10:b0:35f:bb33:d72c with SMTP id 98e67ed59e1d1-35fbb33da86mr7504039a91.4.1776190080795;
 Tue, 14 Apr 2026 11:08:00 -0700 (PDT)
Date: Tue, 14 Apr 2026 11:07:50 -0700
In-Reply-To: <20260414-selftest-global-metadata-v1-0-fd223922bc57@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260414-selftest-global-metadata-v1-0-fd223922bc57@google.com>
X-Developer-Key: i=ackerleytng@google.com; a=ed25519; pk=sAZDYXdm6Iz8FHitpHeFlCMXwabodTm7p8/3/8xUxuU=
X-Developer-Signature: v=1; a=ed25519-sha256; t=1776190073; l=1745;
 i=ackerleytng@google.com; s=20260225; h=from:subject:message-id;
 bh=3eOaP1PjqwIMhC9h/73po0HRLNeVuCigZDPpl5LivDs=; b=7AFWyQ0DVP8h1/H+jFzj0I9KP+8m36LoteufdUTQT1V3Bt1TjzwWMjtAG3ddTNHhhqSOQAXCI
 xAoJNSVc15ZCct8aMwX/ex+6ZAs+81QmZuhps/YOEOAFMsC3uP9Fz3G
X-Mailer: b4 0.14.3
Message-ID: <20260414-selftest-global-metadata-v1-3-fd223922bc57@google.com>
Subject: [PATCH RFC 3/4] KVM: selftests: Do teardown from kselftest harness if
 kselftest_harness is used
From: Ackerley Tng <ackerleytng@google.com>
To: Kees Cook <kees@kernel.org>, Andy Lutomirski <luto@amacapital.net>, Will Drewry <wad@chromium.org>, 
	Shuah Khan <shuah@kernel.org>, Paolo Bonzini <pbonzini@redhat.com>, 
	Sean Christopherson <seanjc@google.com>, thomas.weissschuh@linutronix.de, linux@weissschuh.net
Cc: linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	kvm@vger.kernel.org, Ackerley Tng <ackerleytng@google.com>
Content-Type: text/plain; charset="utf-8"

If kselftest_harness is used, when an KVM selftest assertion fails, make
sure to perform teardown (like kselftest_harness) before exiting.

Provide a weak struct definition and default the pointer's value to NULL so
KVM selftests that don't use kselftest_harness will still work as before.

Signed-off-by: Ackerley Tng <ackerleytng@google.com>
---
 tools/testing/selftests/kvm/lib/assert.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/tools/testing/selftests/kvm/lib/assert.c b/tools/testing/selftests/kvm/lib/assert.c
index b49690658c606..06970611317fd 100644
--- a/tools/testing/selftests/kvm/lib/assert.c
+++ b/tools/testing/selftests/kvm/lib/assert.c
@@ -9,6 +9,7 @@
 #include <execinfo.h>
 #include <sys/syscall.h>
 
+#include "kselftest_harness_structs.h"
 #include "kselftest.h"
 
 /* Dumps the current stack trace to stderr. */
@@ -63,6 +64,8 @@ static pid_t _gettid(void)
 	return syscall(SYS_gettid);
 }
 
+struct __test_metadata *current_test_metadata __attribute__((weak)) = NULL;
+
 void __attribute__((noinline))
 test_assert(bool exp, const char *exp_str,
 	const char *file, unsigned int line, const char *fmt, ...)
@@ -89,6 +92,19 @@ test_assert(bool exp, const char *exp_str,
 			print_skip("Access denied - Exiting");
 			exit(KSFT_SKIP);
 		}
+
+		/*
+		 * When used with kselftest_harness, do teardown like
+		 * __bail() does. KVM only has TEST_ASSERT (no EXPECT
+		 * equivalent) and will definitely exit.
+		 */
+		if (current_test_metadata) {
+			struct __test_metadata *t = current_test_metadata;
+
+			if (t->teardown_fn)
+				t->teardown_fn(false, t, t->self, t->variant);
+		}
+
 		exit(254);
 	}
 

-- 
2.54.0.rc0.605.g598a273b03-goog

