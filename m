Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5708C18AE3
	for <kvm@vger.kernel.org>; Thu, 19 Mar 2026 00:13:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773879211; cv=none; b=QC8O4IyqIBU4ERurTtQSEswsmP49wPkUVS8Am7xlahDIdlF9UUzMPI4Z8ataB7lIEMU7Yq601ln4lle6UD7le2PRO2KUS8fgRay7xbmWA7hrDKi72BePI92gwoJYoYIrpBO/CjXcIibUVDoMfr9Q8TCaPEc7DuVuKNN52a85JT4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773879211; c=relaxed/simple;
	bh=f8uvFrDubU4oOhXNlCQqhnRLfgNBkZw1tWtV4CEa0KM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=YNP38V1UAw72dsWwTmkbz67SdUuMqB5Bb+yszxe7Wa5tW9f8dh3U346tyacchklhYh+QrZLrU7HtW9PKOzbRxBvxqb5OccgmvPYDijsLu96rCkQ6D7vlslmJwcxORR19QRxdepRQXN8vfvbiWZBhW9DR3JMKOEdbaTgv9t/OMYM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HwycfhF4; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HwycfhF4"
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-4856cd3f1ffso3960025e9.3
        for <kvm@vger.kernel.org>; Wed, 18 Mar 2026 17:13:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773879209; x=1774484009; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=nTjxE3JQqOolAqKstJpX9T/NdJfvt6h9kQqpuq86OH0=;
        b=HwycfhF4BjwkWgoq0tKiPgH+meH5nr6TL2jwyBk8cK6QefDJxEUph2Cdea620ckA/w
         WymxbYJlrNfLjraO5fL0rbTFhRucWz/DR98zNUfBfi04TUHXVhOiIcO6ay4UZ+Le0OMM
         CFunkAC1YOe3PIV+vNHsSJJQC5aC6voHX913WSqq3h+N1+JkuR/QT/x+PPiGpU0oKuxR
         84xiOder6ELKqCNUGtWA1wbLQ31tIltp4fwuszo/q6fx5uGvTeasWnlfBb+YvMlAYNaJ
         J0IdwD39hqNjFADUEdOBq7zvTInCg16M+3C0QLJgnD2G9kwloasNQMRAEU95anwLsm36
         yYhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773879209; x=1774484009;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nTjxE3JQqOolAqKstJpX9T/NdJfvt6h9kQqpuq86OH0=;
        b=UJokLhE51QJZNMXwWvpStzamFG6su/KnSOgJvj88rbhJk2TAkXimvCQExwc+Rjmh9A
         fc/4oE2DFuolpTklCHgpYEva3AyiGKbth5TO3rFT2zTuLumZwi3fjUzZW/4DAJDdy7Gw
         AKoCxsztI4GDrcEOE7NfUcL/GvloyD4bvHtlY8qMVr657Kk8EKaZADG+hbZdcKJ5OHKR
         SkTn33WN6UgMy3gT6fcudz/nCeb/qvj8g9ZMxyZqp7WMShzepkUFfE1Eq/CEmVqp/950
         9yZT8Y1rd5paXTddwr02CjbTuwsrpmoGs6LncEu4cI4lBEmqrE+qvWnc4xgd4qOSgC3P
         f9UQ==
X-Gm-Message-State: AOJu0YzmrTm+1WY8JkNk+b4D1ifE2OrHZ86VhpNgcJn5BezbWdWIXXVx
	VS1AU3vCYoevfDVSHfKEdnxDQY8H5V3EaLQCM5UXAehljzHBI6GT5SBC
X-Gm-Gg: ATEYQzzLuQDyzZowbM5jppnaTG0nvDwAU6g9xt+4okHo02EmoV8OoZa+rHtyAWf2zJP
	6j80UG/pyiuU4Wv1YYG2rYKFq3pl+0bAO6KxrbHq9sOqoNdhKJM9z3EdF0e/perw3pQ+z+LQdxh
	re4yioqEdGWfEf8MyDSONzsVeGGsMy6cYwSdk/CxaJWtZ6MdQqhPMWPZlPkfTAD0Jiz7R8Rj5Qd
	e7Hyslm5XFYI9ejmtO0zf405YgSHkgsZvGw8FGzYAxct0fSfZ4wMasLlEsnSHj921+y831a6fwW
	B8cIB3e6rFtjou+GPQ7fynhv2lcn5z4V5ExUBcDDDNsHPYWCajdlltI8wr99CfInx6XsuSRvqO0
	b3RP6qIVDN2fvmQljLYRVpyL62J4uarI/atsFL1Xbpm4UDAXkU0QO6Kyaf+8qWeUns0eE63SjWJ
	GSwDnnCVJ/trvu1FYgFrqL8SbFsQ==
X-Received: by 2002:a05:600c:1f10:b0:485:3d3e:1675 with SMTP id 5b1f17b1804b1-486f4429137mr85938665e9.8.1773879208383;
        Wed, 18 Mar 2026 17:13:28 -0700 (PDT)
Received: from hisam ([2402:ad80:86:fe00:bbdd:7f3:b302:5b46])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-486f8c5318dsm24682245e9.14.2026.03.18.17.13.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Mar 2026 17:13:28 -0700 (PDT)
From: Hisam Mehboob <hisamshar@gmail.com>
To: pbonzini@redhat.com,
	shuah@kernel.org,
	seanjc@google.com
Cc: kvm@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Hisam Mehboob <hisamshar@gmail.com>,
	Aqib Faruqui <aqibaf@amazon.com>
Subject: [PATCH] KVM: selftests: Guard execinfo.h inclusion for non-glibc builds
Date: Thu, 19 Mar 2026 05:08:43 +0500
Message-ID: <20260319000842.1213426-2-hisamshar@gmail.com>
X-Mailer: git-send-email 2.51.0
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

Guard the inclusion of execinfo.h under #ifdef __GLIBC__, and wrap
all backtrace() usage under the same guard with a fallback message
for non-glibc builds indicating that stack traces are not available.

Unlike the approach of adding a weak stub for backtrace(), this
explicitly handles the non-glibc case rather than silently providing
an empty implementation.

Link: https://lore.kernel.org/kvm/20250829142556.72577-7-aqibaf@amazon.com/

Suggested-by: Aqib Faruqui <aqibaf@amazon.com>
Signed-off-by: Hisam Mehboob <hisamshar@gmail.com>
---
 tools/testing/selftests/kvm/lib/assert.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/tools/testing/selftests/kvm/lib/assert.c b/tools/testing/selftests/kvm/lib/assert.c
index b49690658c60..3442b80c37c1 100644
--- a/tools/testing/selftests/kvm/lib/assert.c
+++ b/tools/testing/selftests/kvm/lib/assert.c
@@ -6,7 +6,9 @@
  */
 #include "test_util.h"
 
+#ifdef __GLIBC__
 #include <execinfo.h>
+#endif
 #include <sys/syscall.h>
 
 #include "kselftest.h"
@@ -15,6 +17,7 @@
 static void __attribute__((noinline)) test_dump_stack(void);
 static void test_dump_stack(void)
 {
+#ifdef __GLIBC__
 	/*
 	 * Build and run this command:
 	 *
@@ -56,6 +59,10 @@ static void test_dump_stack(void)
 #pragma GCC diagnostic ignored "-Wunused-result"
 	system(cmd);
 #pragma GCC diagnostic pop
+
+#else /* !__GLIBC__ */
+	fputs("  (stack trace not available: compiled without glibc)\n", stderr);
+#endif
 }
 
 static pid_t _gettid(void)
-- 
2.51.0

