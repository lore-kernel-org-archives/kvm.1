Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AF343D566C
	for <kvm@vger.kernel.org>; Thu,  9 Apr 2026 15:47:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775749627; cv=none; b=mOlun6dEAPR8jdT7g9+tZXiCg1X4BMrOcu4B4DW93015Y3qTp8FcG/Q+rErgm8lZnoFvKJnS8dBD2dICQzHziorFbD4OlZbMI6S5Jo9Vb0VlmSEb0rXvfVhuGduIP8LdyALhOF6ImOKONueKQ6/2vuqNyQ7YX47kZsDJn8u5tQU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775749627; c=relaxed/simple;
	bh=ltl8tl7LY9Yc/LcZI9NUoPzqx2MsoXnzCioP2vkGbtQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=geb9+v/gqwB3nyiLW972vdhHObhpWjDtvV+6i8YSf4JkclGSHV3+myG3X3ftngJ9689m77V8rvcwnr+viWYbuzXnUjrukAKoNMQgisYa1Iyl175T2HmKVJmgU1RIJ65mp3iNJp8A7Cfi4KETth9iPrptMuhhEHMqJ4tIxGlDYqk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=U2hU6F7x; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="U2hU6F7x"
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-48896199cbaso10909375e9.1
        for <kvm@vger.kernel.org>; Thu, 09 Apr 2026 08:47:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775749620; x=1776354420; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MEV02bcyH2Pdvd6Qd6GHWOafkuvPxsNvzJnUHt7jdc0=;
        b=U2hU6F7xrGf1BDgipo1KriCq4y6rc1AvyZNoNByCS+5ECFYnXHVvqsFROCKe9wIgqp
         tgUku+jW4rV/N43+mbn3UJSyaJEV/PhJ9yzfFpQLKs8odvWJLJM+XcolA0N4Dci8+MBx
         8tPCt4nDBBW5odlzRSQghsEJPOKIQPoBnRttKPUK7JN/YMw8jHRi3cVCLzlyGZhC0UHF
         Uz8UtdC6/qPAwRnU/zYsYIUwltvwx4ulGWfXvxHzUNv5iuVaUDDKyxVytYjIMT7wucKe
         MNwrnxBvWtOyLzKoaWMKBDl1/pHBccerLMqo2NFlN3hQVY/rgqvXMa5w5cQRXvEHJ82f
         lbAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775749620; x=1776354420;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=MEV02bcyH2Pdvd6Qd6GHWOafkuvPxsNvzJnUHt7jdc0=;
        b=GsE9uSRFMz7wk8xXnNG+c+deqRl7NiIoNmtcww16BLBUhGfRqGudbMKC6r/Qc5UxLw
         SR1lw3VUyi0hq8Y6RiI/XGjKf6GbumVV4Xv1mp7md/KEIkVd3b+G8gjT7i4Qsa95EzDj
         WDqVwxxjt5tNF8v1PsHKLgRcNf2mRfWfinr+gf6+Ze0xBhX5hdz+x3rbS/NH4cHKOL0q
         atwL5lMImfHPcqqEmi1bmC8+SRhq4uis+Z1seCiv752Hdnd+j6Jv9waVIRFZ5CZm0sxn
         c1cdwwupQDl1sD7nmHUtb/B1xhPZrwxYJCNSm8BuqY7VtM/+dvDCqIzknVFH1KrQvNMa
         M8xg==
X-Gm-Message-State: AOJu0YxkfwWP9z/+9c8oihN6ZpuOzQOtL2vq+FUMsqqjLAs6745m53dx
	ZzKQ0CfCpJ15AaDXcqkyscGiOQ5sbPj2/BkFpa5O8z1aaeBm8lHqQXix
X-Gm-Gg: AeBDievs9j7Rrvc5Zlk7JEZC6muxiRw8RoYMtxobFxG4Xave7fbQdA4HzASUDsdV9mq
	PyPYijun66u7L+qqTUNedShNou0ZoZUMQz8zGZAZUcvX851TJjHMLn08Ni3fMr/Na9HMySSekm+
	X8HwuYMrEsmHuy8d3pXkVhovOmPyKYDfEmdYb1Yl09GkM4Ih8GxiAjXLA9OSPPBi3U0WT02CBTj
	Pwg88640K7BYi/Pvj8kXf8E64hAKY3SehjzZE+8VGEQtCcNgfefkSzqQfROPdf3f0c0VfWrAH9D
	vumxa5qb3lI13/jsslnDuHA3H4Wx+WBwrm/mv3QQrcvbFTR+yl0FowtLK8d9b469wE1z3U+pB6S
	f2I3QDwJ+dMlpDmjhmPk7abLXqEe6BBFD5RO4ekEOYPUwFtAyfUH99sfBG+FAPdep2Yw9y8Asko
	5EAB4PTqSO4C/oFqn+2yYmkfaxjvtZI614ciptEl4=
X-Received: by 2002:a05:600c:37c7:b0:485:9a50:3384 with SMTP id 5b1f17b1804b1-488cd05a06dmr58089375e9.25.1775749619783;
        Thu, 09 Apr 2026 08:46:59 -0700 (PDT)
Received: from hisam ([2400:adcc:119:1300:e749:40f7:4497:4ea7])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-488cd1d171dsm41612405e9.5.2026.04.09.08.46.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Apr 2026 08:46:59 -0700 (PDT)
From: Hisam Mehboob <hisamshar@gmail.com>
To: Sean Christopherson <seanjc@google.com>,
	Shuah Khan <skhan@linuxfoundation.org>
Cc: kvm@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Aqib Faruqui <aqibaf@amazon.com>,
	shuah@kernel.org,
	pbonzini@redhat.com,
	Hisam Mehboob <hisamshar@gmail.com>
Subject: [PATCH v2] KVM: selftests: Guard execinfo.h inclusion for non-glibc builds
Date: Thu,  9 Apr 2026 20:38:47 +0500
Message-ID: <20260409153846.1502656-2-hisamshar@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260319000842.1213426-2-hisamshar@gmail.com>
References: <20260319000842.1213426-2-hisamshar@gmail.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The backtrace() function and execinfo.h are GNU extensions available
in glibc but not in non-glibc C libraries such as musl. Building KVM
selftests with musl-gcc fails with:

  lib/assert.c:9:10: fatal error: execinfo.h: No such file or directory

Fix this by guarding the inclusion of execinfo.h and the stack dumping
logic under #ifdef __GLIBC__. For non-glibc builds, provide a local
stub for test_dump_stack().

Suggested-by: Aqib Faruqui <aqibaf@amazon.com>
Suggested-by: Sean Christopherson <seanjc@google.com>
Signed-off-by: Hisam Mehboob <hisamshar@gmail.com>
---
Changes in v2:
- Replaced the __weak stub approach with a single #ifdef __GLIBC__
  and a local stub inside assert.c as suggested by Sean Christopherson.

 tools/testing/selftests/kvm/lib/assert.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/kvm/lib/assert.c b/tools/testing/selftests/kvm/lib/assert.c
index b49690658c60..8be0d09ecf0f 100644
--- a/tools/testing/selftests/kvm/lib/assert.c
+++ b/tools/testing/selftests/kvm/lib/assert.c
@@ -6,11 +6,14 @@
  */
 #include "test_util.h"
 
-#include <execinfo.h>
+
 #include <sys/syscall.h>
 
 #include "kselftest.h"
 
+#ifdef __GLIBC__
+#include <execinfo.h>
+
 /* Dumps the current stack trace to stderr. */
 static void __attribute__((noinline)) test_dump_stack(void);
 static void test_dump_stack(void)
@@ -57,6 +60,9 @@ static void test_dump_stack(void)
 	system(cmd);
 #pragma GCC diagnostic pop
 }
+#else
+static void test_dump_stack(void) {}
+#endif
 
 static pid_t _gettid(void)
 {
-- 
2.51.0

