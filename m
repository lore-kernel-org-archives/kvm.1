Received: from mail-dy2-f41.google.com (mail-dy2-f41.google.com [74.125.229.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1ED113A168E
	for <kvm@vger.kernel.org>; Sat, 26 Sep 2026 07:02:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.229.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790406170; cv=none; b=H6OBy/MvRHTaw/alTMBQedRySvALq3CpajMrVdt3xTD3srlWtz5istVuFSZzsflQgMJaYrnBXN7OZJJ1yoeFPXEwT3vbRvDnggHJxbmUegH6SefTdLi7Lihb9Ya0FJsmywsHapA51IKBDeKdeca5xYYstPDJbwyasFFjADcsU9I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790406170; c=relaxed/simple;
	bh=MR+NAF54LL/HgF+jfuf2LKJGvEOyyJwNncYOaNLfP8U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=W7vYqXJjgMk9vIm7eUVv09orr0WhDBNUSuMqVv6RHmD1YwkyF0eD9BT8UffCQ9zDNjsXGPm+7FB3IcAq7RTWpKIzKS1dGkcMpIt4Jyvq2kVyC8rZcSyYT+EU8L0eI/KEQrQQd5c1ubvCPLqg+S906p+muUDAd84qHypfwWO3lnA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aDUxdmqh; arc=none smtp.client-ip=74.125.229.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aDUxdmqh"
Received: by mail-dy2-f41.google.com with SMTP id 5a478bee46e88-3437a48f386so62166eec.3
        for <kvm@vger.kernel.org>; Sat, 26 Sep 2026 00:02:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790406168; x=1791010968; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=13Vpk3slAVMN43yepfwDbpWXacf+qhSBumghvgGIwSM=;
        b=aDUxdmqhKFyucr+xfxJbmUBAAVTbCDCGy64vC1HB7RhKxeiVy9xECLjEbcaGXIIkJN
         3Njn9Ss1v8l3TxWSaw0KhDhaTuzRMMcN/Wpj57coMk8p0rYVTSylyLwtrr5T6nNizIq8
         yOeIOxauKG0lriweC+RTck7XhauZUx5/dKJIwn13v9ih/cDv6/bhtg/gD+d7vJiChRoA
         TeVUiXarV/mXs7BzH7riREsCKlgOBgYytN1wOAnk3G+Mf2gjzUo+Pw2KbZYlGCCSvTsC
         gB073H4hS0cThnr+V65XAnkng4IvjSckfOVuCx0gT6b/P7JSK9aVph7ZBihe17JmuXtn
         dcdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790406168; x=1791010968;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=13Vpk3slAVMN43yepfwDbpWXacf+qhSBumghvgGIwSM=;
        b=oGJgGjemMwVP29bNRbIAE5XGiNeLy2Q85oJt5iK90ivjvjBQyw/dFrq9rnaJTzNhQz
         nkV/FLLeDUGXEJs/HbKz4tFFpDG2ksApXGKbkAWrt8fSuh/VYGEKT3mLeH/WS7DCdWLD
         DLolNiCzV1x4wtjDlxXnRBUMev1eDHBEVfeZiU3cDs2kuzmPqRsBL9vCLoOtQ7JbuffG
         ApB2WsfrMkVpNuc9MQKnPJSHPbxDZ5HtGBpSN0S12rYW76iwmjdmPa8kvGAPuZR9g5f/
         ogM7BhVFtkCpireak5BsYfCVFGIIq/7JNJULG1ZbgO9tB9Dlo0YsVMVQ6sdwDZgP8IXU
         aK6w==
X-Forwarded-Encrypted: i=1; AKwUvBwSfqmDmghATFso2vWbbizF4M0p1iA+9REonKv9Fp7f9IQ371jW+R120UVQlvuZWXNF2C0=@vger.kernel.org
X-Gm-Message-State: AFuF++mp5PnS8GCPqOcmTrrAhtfNEWdD+YwZorYy2qkCkTdR3oXYmn/y
	YRToiSe0AR+/ocJzsu918blFNzRlAiz1XRDpe6WnW7BJLjO+8Oudncc5
X-Gm-Gg: AYBFou3clQKva8Dam1knhJiRi5yM0IZXua7FaflGryIfJgKeZpYr4uDlR++MQ9dWyi0
	2nid7zd6eD6GM+iuw3L7DSEAzb4qdVFaRlEHzKWGaHtpRkDUezbHNzMgwoJaOrwqQOTGXalf2mz
	QXJ+uPrNGlZX7OJVdyKWF97Sup4j0YIem4S2xxRc9zNGXLb2HESdGi+AtDYYoHqRFnZmCXdLu14
	POKPNBICSp+btlSiuNcyPV6NzJC9yakx+b6SjwbspOIs0CM8SlBuAZI603+CxzX+wi8ZlyAOt2T
	aK3gnzoWY5k3GxgmL+vpv2ZZUYmVtF9zvl/YAtQ3vQ5+fKP0WYkh1LZsquVgGME7Y7PbBMdIx6z
	VOSqynfxy7m5Ffn5soplg0JuQtNb5h17mgfizp3e2MndCCJ2R3bKZaaDtVuzT/rpJIhYeyMlEjW
	uYo1ITZEhHeNVgBBLvM/GzRR/0trqY0+b/NiCl5/SjLKBRsb6ZJJBN/AqL9e0QhpUClRJTrbLX6
	A3+5h7w4+EkL7LzD4mn5F3RmDtpZnQ=
X-Received: by 2002:a05:7300:ae0f:b0:33b:eadd:9013 with SMTP id 5a478bee46e88-342705b9cb5mr2029096eec.6.1790406168140;
        Sat, 26 Sep 2026 00:02:48 -0700 (PDT)
Received: from WIN-BH9M8FJACR9 ([103.94.185.75])
        by smtp.googlemail.com with ESMTPSA id 5a478bee46e88-34145c166cfsm10615141eec.28.2026.09.26.00.02.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 26 Sep 2026 00:02:47 -0700 (PDT)
From: Yonggang Luo <luoyonggang@gmail.com>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
	=?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
	=?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
	"Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
	Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
	Fabiano Rosas <farosas@suse.de>,
	Laurent Vivier <lvivier@redhat.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Alistair Francis <alistair@alistair23.me>,
	Peter Maydell <peter.maydell@linaro.org>,
	=?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
	qemu-arm@nongnu.org,
	kvm@vger.kernel.org
Subject: [PATCH v4 26/55] accel/tcg: move helper_exit_atomic next to cpu_loop_exit_atomic
Date: Sat, 26 Sep 2026 15:00:25 +0800
Message-ID: <20260926070057.1234-27-luoyonggang@gmail.com>
X-Mailer: git-send-email 2.52.0.windows.1
In-Reply-To: <20260926070057.1234-1-luoyonggang@gmail.com>
References: <20260926070057.1234-1-luoyonggang@gmail.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

helper_exit_atomic only forwards to cpu_loop_exit_atomic. Define it
in cpu-exec-common.c with that function, and move its DEF_HELPER line
to cpu-exec-common.h. That file emits helper_info_exit_atomic.
tcg-runtime.c keeps the integer helpers.

Signed-off-by: Yonggang Luo <luoyonggang@gmail.com>
---
 accel/tcg/cpu-exec-common.c        | 10 ++++++++++
 accel/tcg/cpu-exec-common.h        |  1 +
 accel/tcg/tcg-runtime.c            |  8 --------
 accel/tcg/tcg-runtime.h            |  2 --
 include/exec/helper-gen-common.h   |  4 ++++
 include/exec/helper-proto-common.h |  4 ++++
 6 files changed, 19 insertions(+), 10 deletions(-)
 create mode 100644 accel/tcg/cpu-exec-common.h

diff --git a/accel/tcg/cpu-exec-common.c b/accel/tcg/cpu-exec-common.c
index 68077c8fd9d..d20cece1c5f 100644
--- a/accel/tcg/cpu-exec-common.c
+++ b/accel/tcg/cpu-exec-common.c
@@ -23,8 +23,13 @@
 #include "qemu/plugin.h"
 #include "qemu/main-loop.h"
 #include "accel/tcg/cpu-loop.h"
+#include "exec/helper-proto-common.h"
 #include "internal-common.h"
 
+#define HELPER_H "accel/tcg/cpu-exec-common.h"
+#include "exec/helper-info.c.inc"
+#undef  HELPER_H
+
 bool tcg_allowed;
 
 /*
@@ -120,3 +125,8 @@ void cpu_loop_exit_atomic(CPUState *cpu, uintptr_t pc)
     cpu->exception_index = EXCP_ATOMIC;
     cpu_loop_exit_restore(cpu, pc);
 }
+
+void HELPER(exit_atomic)(CPUArchState *env)
+{
+    cpu_loop_exit_atomic(env_cpu(env), GETPC());
+}
diff --git a/accel/tcg/cpu-exec-common.h b/accel/tcg/cpu-exec-common.h
new file mode 100644
index 00000000000..922acc2179d
--- /dev/null
+++ b/accel/tcg/cpu-exec-common.h
@@ -0,0 +1 @@
+DEF_HELPER_FLAGS_1(exit_atomic, TCG_CALL_NO_WG, noreturn, env)
diff --git a/accel/tcg/tcg-runtime.c b/accel/tcg/tcg-runtime.c
index 7c0aab98a80..764c62c684d 100644
--- a/accel/tcg/tcg-runtime.c
+++ b/accel/tcg/tcg-runtime.c
@@ -23,10 +23,7 @@
  */
 #include "qemu/osdep.h"
 #include "qemu/host-utils.h"
-#include "exec/cpu-common.h"
 #include "exec/helper-proto-common.h"
-#include "accel/tcg/cpu-loop.h"
-#include "accel/tcg/getpc.h"
 
 #define HELPER_H  "accel/tcg/tcg-runtime.h"
 #include "exec/helper-info.c.inc"
@@ -129,8 +126,3 @@ uint64_t HELPER(ctpop_i64)(uint64_t arg)
 {
     return ctpop64(arg);
 }
-
-void HELPER(exit_atomic)(CPUArchState *env)
-{
-    cpu_loop_exit_atomic(env_cpu(env), GETPC());
-}
diff --git a/accel/tcg/tcg-runtime.h b/accel/tcg/tcg-runtime.h
index 0b832176b33..9b4c1c24916 100644
--- a/accel/tcg/tcg-runtime.h
+++ b/accel/tcg/tcg-runtime.h
@@ -22,8 +22,6 @@ DEF_HELPER_FLAGS_1(ctpop_i64, TCG_CALL_NO_RWG_SE, i64, i64)
 
 DEF_HELPER_FLAGS_1(lookup_tb_ptr, TCG_CALL_NO_WG_SE, cptr, env)
 
-DEF_HELPER_FLAGS_1(exit_atomic, TCG_CALL_NO_WG, noreturn, env)
-
 #ifndef IN_HELPER_PROTO
 /*
  * Pass calls to memset directly to libc, without a thunk in qemu.
diff --git a/include/exec/helper-gen-common.h b/include/exec/helper-gen-common.h
index 834590dc4e5..ed5521ad881 100644
--- a/include/exec/helper-gen-common.h
+++ b/include/exec/helper-gen-common.h
@@ -7,6 +7,10 @@
 #ifndef HELPER_GEN_COMMON_H
 #define HELPER_GEN_COMMON_H
 
+#define HELPER_H "accel/tcg/cpu-exec-common.h"
+#include "exec/helper-gen.h.inc"
+#undef  HELPER_H
+
 #define HELPER_H "accel/tcg/tcg-runtime.h"
 #include "exec/helper-gen.h.inc"
 #undef  HELPER_H
diff --git a/include/exec/helper-proto-common.h b/include/exec/helper-proto-common.h
index 76e6c25becb..28afa7782d0 100644
--- a/include/exec/helper-proto-common.h
+++ b/include/exec/helper-proto-common.h
@@ -9,6 +9,10 @@
 
 #include "qemu/atomic128.h"  /* for HAVE_CMPXCHG128 */
 
+#define HELPER_H "accel/tcg/cpu-exec-common.h"
+#include "exec/helper-proto.h.inc"
+#undef  HELPER_H
+
 #define HELPER_H "accel/tcg/tcg-runtime.h"
 #include "exec/helper-proto.h.inc"
 #undef  HELPER_H
-- 
2.52.0.windows.1

