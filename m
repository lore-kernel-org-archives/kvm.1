Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE1753A7848
	for <kvm@vger.kernel.org>; Fri, 19 Jun 2026 15:20:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781882427; cv=none; b=cqChR+tvtuYAXo5J0HSt2uZ8n9OlXogMQUoZyZiol/9IDWcMoyoSmVdpVBBffXrVdTmWINSx+p3L7Tvv6QuL8oGVd5Hf59Q0/JqOFXWbXLi1fN/gtoxZnU5QbgTsfN1CCzLDJRszdwN2YSz0qSbAONn8yjHTqAl2aVIzXykfzzk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781882427; c=relaxed/simple;
	bh=NQsj8iYU85Xf+mfUkBzv5es4sl3G3qNpHqSe21FjftU=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=XXHU0GkSuimkf1VaA1pAB28y1Gos2bvAQ1I8E8DXEzSDRUpR0kGvmdFUfRLXKO4cfbU96qRJlcC0DqI9Ep+jPfHuaHG2QVhKfx/g1wrrkIPOc4Dzf6c3DHb+ibLOxEI7tsso6CRxYAYwwetgXMw13hGiVCdVVd0x2kXIB3lYJKs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jmattson.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ddjP9l8x; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jmattson.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ddjP9l8x"
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-36d985df4cfso2117861a91.1
        for <kvm@vger.kernel.org>; Fri, 19 Jun 2026 08:20:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1781882425; x=1782487225; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=gDkpDj0IOMeBan2mZUfK8ZgkIskUkR9cM5RX0PavjGE=;
        b=ddjP9l8xC+8YRXlj1ieqCNy64JfyvhtOxud0y6pOl6/Pj+RN+EEtICaZH9ghUpkHeV
         ykHZZUU6SNG6G22vxPYD7MdotYNNzCcWaPXluAPglAxUH0MRF91fl2+G1ONqzG/rUPM2
         yR++2NDNSyoiFy8EcSwbMhDazGGr7vsHhPgI41E/GNDCqAKcQKy3NOAUmwoq0Za2PzLR
         wRn8hzOE1DGSo8hPm2mF5IlmFQjgAgiS48H/prvDKPu3SQgw+B9lIeMq8S39SOH+53xo
         q2rO6E0duW8GW4vbJb33rAjJM0i+t0YfER3dpG+e5Dy5CTNcEFRYvcxDNPbjH5t2TbaF
         s0DA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781882425; x=1782487225;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gDkpDj0IOMeBan2mZUfK8ZgkIskUkR9cM5RX0PavjGE=;
        b=TXtizQ7wbTQ4TVWoAwbEi9wxNsEb2To4Ca9g2Z8GEBfnfJIJhFeV415iV2TX6/PF/a
         5eg1FPZQl3JCzjf2OtwqPf6nzztOewlHPU7lHQR7W53ywr3INuWHvYwr4MkUhC1nlAoD
         HnlohbYVJDOo4tbEJoj8lAVLqOHfckXDyU6kbeFn/JZvcacO0GYMzx+OHGV1zDtRyc36
         qtLLDcXCEH5IQVCQkvN3M1h2rPWOH2gB3Jb2F2P4swMjdnlA4XGlWHDE0btDah5Xbf7A
         ILJzVKMzY+EFmlxIz/ocmIrhHLl9vLQzcj+BHqLpTNX8sQIFGlJolUY6pl9zVIZ25qSG
         w8iw==
X-Forwarded-Encrypted: i=1; AFNElJ9iYO3DGJqzfgx9Om/6qSn6K3GXNWyL463Re3F791HwluUejEsTDQ83biSXBqI3xCJzSW4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzd/oVFukELMOMHafcMk/PuTZUSr3eDjiBC9Stz5rkvqfFD6QeL
	724h9KdIhOT/yE0o4mMeUfY5maAdq0ZCrAWGMDkAjZZ2JgYZaxs5FktfBjEgDI9cVQWsyjwCtfS
	zQTttmS63m7JDfw==
X-Received: from pgjn9.prod.google.com ([2002:a63:e049:0:b0:c80:16d6:ed0])
 (user=jmattson job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:90b:57ee:b0:36b:bbee:fb28 with SMTP id 98e67ed59e1d1-37d160bd6dcmr4322850a91.2.1781882424668;
 Fri, 19 Jun 2026 08:20:24 -0700 (PDT)
Date: Fri, 19 Jun 2026 08:19:25 -0700
In-Reply-To: <20260619152006.3684428-1-jmattson@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260619152006.3684428-1-jmattson@google.com>
X-Mailer: git-send-email 2.55.0.rc0.799.gd6f94ed593-goog
Message-ID: <20260619152006.3684428-3-jmattson@google.com>
Subject: [kvm-unit-tests PATCH 2/5] lib: Hoist test selection logic to library
 for code reuse
From: Jim Mattson <jmattson@google.com>
To: pbonzini@redhat.com, kvm@vger.kernel.org
Cc: Jim Mattson <jmattson@google.com>
Content-Type: text/plain; charset="UTF-8"

Hoist the 'test_wanted()' helper from x86/vmexit.c into the common
library as 'argv_test_wanted()' to facilitate code reuse.

This eliminates duplicate code and provides a generic,
architecture-independent helper that any test suite can leverage to
support running a subset of tests specified via command-line arguments.

Refactor x86/vmexit.c to use the new library helper.

Assisted-by: Gemini:gemini-3.1-pro
Signed-off-by: Jim Mattson <jmattson@google.com>
---
 lib/argv.c   | 14 ++++++++++++++
 lib/argv.h   |  3 +++
 x86/vmexit.c | 15 ++-------------
 3 files changed, 19 insertions(+), 13 deletions(-)

diff --git a/lib/argv.c b/lib/argv.c
index fa5ff9ae9d28..b290c1f33903 100644
--- a/lib/argv.c
+++ b/lib/argv.c
@@ -146,3 +146,17 @@ void setup_env(char *env, int size)
 		*env++ = '\0';
 	}
 }
+
+bool argv_test_wanted(const char *name, char *wanted[], int nwanted)
+{
+	int i;
+
+	if (!nwanted)
+		return true;
+
+	for (i = 0; i < nwanted; ++i)
+		if (strcmp(wanted[i], name) == 0)
+			return true;
+
+	return false;
+}
diff --git a/lib/argv.h b/lib/argv.h
index 0fa7772549da..bb539b0dcb44 100644
--- a/lib/argv.h
+++ b/lib/argv.h
@@ -8,10 +8,13 @@
 #ifndef _ARGV_H_
 #define _ARGV_H_
 
+#include <stdbool.h>
+
 extern void __setup_args(void);
 extern void setup_args(const char *args);
 extern void setup_args_progname(const char *args);
 extern void setup_env(char *env, int size);
 extern void add_setup_arg(const char *arg);
+extern bool argv_test_wanted(const char *name, char *wanted[], int nwanted);
 
 #endif
diff --git a/x86/vmexit.c b/x86/vmexit.c
index 1b675c00f930..82f13a2faa5f 100644
--- a/x86/vmexit.c
+++ b/x86/vmexit.c
@@ -1,4 +1,5 @@
 #include "libcflat.h"
+#include "argv.h"
 #include "acpi.h"
 #include "smp.h"
 #include "vmalloc.h"
@@ -594,19 +595,7 @@ static void enable_nx(void *junk)
 		wrmsr(MSR_EFER, rdmsr(MSR_EFER) | EFER_NX_MASK);
 }
 
-static bool test_wanted(struct test *test, char *wanted[], int nwanted)
-{
-	int i;
-
-	if (!nwanted)
-		return true;
-
-	for (i = 0; i < nwanted; ++i)
-		if (strcmp(wanted[i], test->name) == 0)
-			return true;
 
-	return false;
-}
 
 int main(int ac, char **av)
 {
@@ -636,7 +625,7 @@ int main(int ac, char **av)
 	}
 
 	for (i = 0; i < ARRAY_SIZE(tests); ++i)
-		if (test_wanted(&tests[i], av + 1, ac - 1))
+		if (argv_test_wanted(tests[i].name, av + 1, ac - 1))
 			while (do_test(&tests[i])) {}
 
 	return 0;
-- 
2.55.0.rc0.799.gd6f94ed593-goog

