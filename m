Received: from mail-dl2-f43.google.com (mail-dl2-f43.google.com [74.125.229.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3ABF362154
	for <kvm@vger.kernel.org>; Sat, 26 Sep 2026 07:03:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.229.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790406187; cv=none; b=mIGPSYRJ50Np9C66ORWZiA2R6iQ8VlIDqr5wgOiP4AdBp+yy9qn9zYjjbv0nBxhn+/maDPPUlkz9K7hllDwtGP7o7ZkUF/j6jh2xLii0iDjAVImA+b3vZHGs13+G0or+dXZy9khQ33x7eG+O3HFkzRH2/DbrwOgJTL7qxaSggdY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790406187; c=relaxed/simple;
	bh=RATcikF021VvJ11yLIshXBATVC7AdPrNUiPLQR8XDog=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aq7mvEiYeajQW9HpRE1R9ma/6HAFzMM/lKF+4dHFy9WnEbJWpdna5t8S5KwaXZAZdLDztzK4xGbU2LaYrAEKv9nrGWqzfMLe68VKofH6ggPxM55CTTemkDcXPCbRS6lCT0asUYFW0ZpHYyw78TNzRh2Xet5mYipyVGgwVaqlHAg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kRnFRYWr; arc=none smtp.client-ip=74.125.229.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kRnFRYWr"
Received: by mail-dl2-f43.google.com with SMTP id a92af1059eb24-144f9160b81so556715c88.0
        for <kvm@vger.kernel.org>; Sat, 26 Sep 2026 00:03:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790406185; x=1791010985; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ALxUX35YxAT0/hMJem0o96GiSG/xYkkLx16debZXGzM=;
        b=kRnFRYWrVATy3I2ek/DBYd7oV1699Jv239jbY8MVbrgkvjpecNQe0fUKtLBi7jIP8D
         m319uSkvgogbXtbCNKy6FiD3bf5dduluSymuMbuLfPJC1irM2S7czYaKeG5ZzgfNY7So
         qnKdSafR6MnpUDYCvQkilC5/3jAvI1APsDJUIxjsDvlvpCUx7+rbMQwuYOxMX7Krztb3
         NWaMdsO7L9gd3ulcFd0YHcg69HuQgqP3m1sAxEnO7MqrVc3jNZg0jKtwBOvM8Mq++3QN
         Z/9sxp8A+1At4V0fsfPBqaPJ53BE8/ZRGX4cfnRVo5ain9uoM8RG82t7ufU5na42nBmK
         sPyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790406185; x=1791010985;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=ALxUX35YxAT0/hMJem0o96GiSG/xYkkLx16debZXGzM=;
        b=DXHtIBXvf9jhpmZXVdo42Qro49NvWtf6juHstp0B+lQ3zy8OERQEZbDeHsUeJnVmeu
         sKBOlYMTcs8i0QeM150WPTSxmgkXqr2OTOcXTTR468Q2B6KtcYqt621egmzN3EptGrUC
         UZLlAFxFfi2d/+McgHlW5JGCu0iaUVE88mOkBE0mEh4bpKiUE/Hs336efXfog22R/2IX
         8c6pxaLDRG2FvAIatWvbGl9K9Mq08TiG8FF8sy+nL6N6HPBVJy9S8Jn6b2HbRXGx9ZLi
         lHE811weXrXBU8DUFiNdpuZqGixrXJjPDmxysDnJ2AVMs1nqy8E04WvFPG0a4aq5L2So
         lJfw==
X-Forwarded-Encrypted: i=1; AKwUvBw5VPPeTchKMtHDedSx59o+c3wXEB3v93/cFKeshYuD9FQaesBpGBd/1RrgC7kxvpfpR+o=@vger.kernel.org
X-Gm-Message-State: AFuF++kjVowaggv6fFnBHIA+lU/NSq53c2vWEMCf2aQ8Zg4XT8z/CHjA
	jBLsM+afra5FvE7rW7e7jCbnf2gIcTXo40ybvVlrwAagv85MY1YegLDz
X-Gm-Gg: AYBFou1QM3N+/1M68GKIaCmZmDGnPhojOhWJ/Xopyl+L2ZA67rG7ptQ/hlTje9dbNFN
	I6wtexaNPeCv8eSAvo+B6DW2TL0D9hD8I01EYmUA31wx3dRKxJthPHkWWmQ5A6P/KHFE1ZGcOCW
	sttQB0qnLnEuNI0KrxVE5sT3Ct6Rh2hX1vMbK2swoJKsJmvNdxxnVr84trnnl4uUHf72fr4s4w4
	WeXG9gM1zv5Tmbfvfr0zLCl2WrtjNd62zs7aqgcPqiyfbB5HlS7rW6jSt6zehZxdEU1YIid+KxR
	kJtlYjTgWjGb9pJ7YuqqHuYnXP4auMU0Wx9b+dCcoDgMHeM++2q4T+R0ZwJTAUUtrrN5kcbk2Ih
	vlMnRmSHpc7clxy9QUhIbyC3f46wt44YPASaCUPhgMuGHHvaZ3Ceuj6Y8t0QVVNvrkaL+vDLeGY
	kNc2FANvMqv0A0yStrmJV3giNtXKypj1GGXDBE9AxSVUtZhJ74AJpD/I3XN01x2nb2YtRhGbFOo
	kAWkTBSPFrsQA3ez6M2GslbtfRTZUE=
X-Received: by 2002:a05:7022:f108:b0:144:fb42:52 with SMTP id a92af1059eb24-146cfdd1e08mr1944186c88.28.1790406184037;
        Sat, 26 Sep 2026 00:03:04 -0700 (PDT)
Received: from WIN-BH9M8FJACR9 ([103.94.185.75])
        by smtp.googlemail.com with ESMTPSA id 5a478bee46e88-34145c166cfsm10615141eec.28.2026.09.26.00.03.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 26 Sep 2026 00:03:03 -0700 (PDT)
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
Subject: [PATCH v4 30/55] accel/tcg: move helper_lookup_tb_ptr into cpu-exec.h
Date: Sat, 26 Sep 2026 15:00:29 +0800
Message-ID: <20260926070057.1234-31-luoyonggang@gmail.com>
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

helper_lookup_tb_ptr is implemented in cpu-exec.c. Move its
DEF_HELPER line to cpu-exec.h and emit helper_info_lookup_tb_ptr
from that file.

Signed-off-by: Yonggang Luo <luoyonggang@gmail.com>
---
 accel/tcg/cpu-exec.c               | 5 +++++
 accel/tcg/cpu-exec.h               | 1 +
 accel/tcg/tcg-runtime.h            | 2 --
 include/exec/helper-gen-common.h   | 4 ++++
 include/exec/helper-proto-common.h | 4 ++++
 5 files changed, 14 insertions(+), 2 deletions(-)
 create mode 100644 accel/tcg/cpu-exec.h

diff --git a/accel/tcg/cpu-exec.c b/accel/tcg/cpu-exec.c
index 5b4bca5084f..021912dc022 100644
--- a/accel/tcg/cpu-exec.c
+++ b/accel/tcg/cpu-exec.c
@@ -40,6 +40,11 @@
 #include "exec/replay-core.h"
 #include "system/tcg.h"
 #include "exec/helper-proto-common.h"
+
+#define HELPER_H "accel/tcg/cpu-exec.h"
+#include "exec/helper-info.c.inc"
+#undef  HELPER_H
+
 #include "tcg-accel-ops.h"
 #include "tb-jmp-cache.h"
 #include "tb-hash.h"
diff --git a/accel/tcg/cpu-exec.h b/accel/tcg/cpu-exec.h
new file mode 100644
index 00000000000..e4803ebc1a6
--- /dev/null
+++ b/accel/tcg/cpu-exec.h
@@ -0,0 +1 @@
+DEF_HELPER_FLAGS_1(lookup_tb_ptr, TCG_CALL_NO_WG_SE, cptr, env)
diff --git a/accel/tcg/tcg-runtime.h b/accel/tcg/tcg-runtime.h
index c0626fa0e02..26e0baeca51 100644
--- a/accel/tcg/tcg-runtime.h
+++ b/accel/tcg/tcg-runtime.h
@@ -20,8 +20,6 @@ DEF_HELPER_FLAGS_1(clrsb_i64, TCG_CALL_NO_RWG_SE, i64, i64)
 DEF_HELPER_FLAGS_1(ctpop_i32, TCG_CALL_NO_RWG_SE, i32, i32)
 DEF_HELPER_FLAGS_1(ctpop_i64, TCG_CALL_NO_RWG_SE, i64, i64)
 
-DEF_HELPER_FLAGS_1(lookup_tb_ptr, TCG_CALL_NO_WG_SE, cptr, env)
-
 #ifndef IN_HELPER_PROTO
 /*
  * Pass calls to memset directly to libc, without a thunk in qemu.
diff --git a/include/exec/helper-gen-common.h b/include/exec/helper-gen-common.h
index fa571d88147..73e979a35f3 100644
--- a/include/exec/helper-gen-common.h
+++ b/include/exec/helper-gen-common.h
@@ -11,6 +11,10 @@
 #include "exec/helper-gen.h.inc"
 #undef  HELPER_H
 
+#define HELPER_H "accel/tcg/cpu-exec.h"
+#include "exec/helper-gen.h.inc"
+#undef  HELPER_H
+
 #define HELPER_H "accel/tcg/tcg-runtime.h"
 #include "exec/helper-gen.h.inc"
 #undef  HELPER_H
diff --git a/include/exec/helper-proto-common.h b/include/exec/helper-proto-common.h
index 1b098777e8d..3c32f95f4c1 100644
--- a/include/exec/helper-proto-common.h
+++ b/include/exec/helper-proto-common.h
@@ -13,6 +13,10 @@
 #include "exec/helper-proto.h.inc"
 #undef  HELPER_H
 
+#define HELPER_H "accel/tcg/cpu-exec.h"
+#include "exec/helper-proto.h.inc"
+#undef  HELPER_H
+
 #define HELPER_H "accel/tcg/tcg-runtime.h"
 #include "exec/helper-proto.h.inc"
 #undef  HELPER_H
-- 
2.52.0.windows.1

