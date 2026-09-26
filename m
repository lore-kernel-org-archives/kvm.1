Received: from mail-dy1-f169.google.com (mail-dy1-f169.google.com [74.125.82.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C000345731
	for <kvm@vger.kernel.org>; Sat, 26 Sep 2026 07:03:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790406205; cv=none; b=En+jvVkRJ4el4j7Na3TJBCcDIvnsLPBXxnsiAwLFBmS5RNyU383Ie84v4018Eu/LZO+E/K/Fvw6/oPwGwue9XAvSeiu9b2pqlCOig3hI+oTqrf3X/5Hyr6sBd/cJQBArly/6ciIzHaoG/fF/4uuIw4ZQGFGrXHoKFBGeZs2/InE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790406205; c=relaxed/simple;
	bh=oPRii1OVUkhAvppLZOh2tyB4J4k31h5qF51Mn43ryzo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RdFK+fmCZmJa1+xKF05YnQuND4ZQyCym99uVQzMw8w99vJB7CruwlSsyZeZSUx+olts3cdInjGU2KIgli2+GOP0senADP0dG6t4II9PpCYJCjugZ+JiYA7n8lLeq7MbWc2ewVu/7BX7+NpzoKhEwZBFTM4J/HQ/w0uOxpYpeWjc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cBmpaHyc; arc=none smtp.client-ip=74.125.82.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cBmpaHyc"
Received: by mail-dy1-f169.google.com with SMTP id 5a478bee46e88-3425f2b24a4so534338eec.0
        for <kvm@vger.kernel.org>; Sat, 26 Sep 2026 00:03:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790406203; x=1791011003; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=qRAWcqy39t4YH/MXWwtDPnaCtpTkj9m6y8wjd7e4fZo=;
        b=cBmpaHycsQM6ymz955uizxeNX2ml2Aekei4A5WGSvGWfSFALaGEySG3fKSLxMVohhq
         7bLFdGM9pzA4VbC3oiwHWNEgZlQuFWEBpwLjpZhlMreiO5OZH6mNb9X0sicjsVkyYZBZ
         /aU6CK99bskV6cmR0Z+AkiuFnqQOSLoSI+Z3dCYQ2cO7a51jTyniXeT4bCJD70xrW3gu
         GIE4fgB9iV1/eJ2Qdhh6X4KW/YmeoG3vgqhFaagf+7BCJBCzRwYxBsxGZyGE7APY/Rn8
         K32WmAf9mBYtRzJM5KMpBjXWeGdk36JaYTTnVntzhApPzOtwHriKfVuGzjuwUt2Bm6Lb
         2kGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790406203; x=1791011003;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=qRAWcqy39t4YH/MXWwtDPnaCtpTkj9m6y8wjd7e4fZo=;
        b=m700q1rKHRClotCaqrD/UzA42PTylCmWP1vMif8shnEETTViN6nYyTuv0cf7IlSrox
         HyCIKpdzixZ0rtSqXwqlCUF5JUsRrflID9yzAJsg82Y1iGs+XNt8AcF3YKZWjFbge+zX
         zizHdovFlZmuuT8+sT81fpZIU0Pczz0oJtKsE8wKtvxzxbh0QtodVHMt/D2TUNAfzZTB
         Wq7hnLaU2J4t2CUnEZTrd3el3zaPmnHqCrOHkn2imsDuwRGzxSUHHiL2iwi7m7+9urGE
         5TAf8jqXAsPHtdSKfydOyTifFniQKcCesQVReQxnGWQFq/olP09Bir7sq/FIsWKlm3cT
         0+Mg==
X-Forwarded-Encrypted: i=1; AKwUvByTwu2gu+CSYRy9yBf3hUs6Z4ZySZhnSB6TWY5gEd37iaXB4+ZLQNFslBqVm6iFH53y6vM=@vger.kernel.org
X-Gm-Message-State: AFuF++m2bgCYQxEaU5XepEh7UfmEG5j+/fYn2n5C7pYMJSTF/uum12AQ
	qtVsXtWGohxs6jeks53c+axA7Dj+xUCkMSeKa+KR69Cct8wguwW3rPOgllc2gLAH
X-Gm-Gg: AYBFou2Ht0NL865nQKORpqUcBX7wFDNZ1Ol/nKX+U5bogguVPVRsBp/eobbrCWxs5lw
	gmL9i/ioZ4Snmhatx1slRtuH0MY9bZTWTCF6FBhUVjHP5WsomzXBA+kPpgz8JNlgMkOGSaRbcQh
	D8xi5G4ReBg9FNtmf6lrTsnzgus+v0gEcnOBY/N2XoSTbTmuDqdwa2etJTaJOvAKkA51iXgoQ9v
	oxjNzI0SvYs4YN1pj2FoX4DiRDeOyUcLpTPEsRIDtHjXNHIsmuD9GZKPNu0Gcpo7NtNCgPh03M8
	0TZeE2E2T6OaoiKmu77shDGT9pgJR34itJ3G/uEnxRAIJNGtmjB+sdTJieMRtdIuq6WwD7uS2xO
	A0z2QeC0vVgMU//XCL6MmRwhFHMMs1MX3B5VD+VwdL7XMkeJbQAltMTfyZsDtDhZNKf4fRybVAn
	mbTBd8ia1+TNxjbWcqTNJnmnBVqCpLcH4iagVKXkPfFEPGnQCTB6POVvA4NcEYEEF+MAzwUp9wD
	OK/Ab112ySfzVXJ1GCNTN65NwdbzMAp
X-Received: by 2002:a05:7022:504:b0:144:eb3f:563a with SMTP id a92af1059eb24-146d02a9b40mr2755957c88.15.1790406203367;
        Sat, 26 Sep 2026 00:03:23 -0700 (PDT)
Received: from WIN-BH9M8FJACR9 ([103.94.185.75])
        by smtp.googlemail.com with ESMTPSA id 5a478bee46e88-34145c166cfsm10615141eec.28.2026.09.26.00.03.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 26 Sep 2026 00:03:22 -0700 (PDT)
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
Subject: [PATCH v4 35/55] exec: provide target_ulong for softmmu common code
Date: Sat, 26 Sep 2026 15:00:34 +0800
Message-ID: <20260926070057.1234-36-luoyonggang@gmail.com>
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

Softmmu common code gets a 64-bit target_ulong and a runtime MO_TL.
target_long and TARGET_FMT_* stay per-target. The per-target half of
target_long.h is unchanged.

Signed-off-by: Yonggang Luo <luoyonggang@gmail.com>
---
 include/exec/target_long.h | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/include/exec/target_long.h b/include/exec/target_long.h
index 3cd8e26a23f..c7bc65a60c9 100644
--- a/include/exec/target_long.h
+++ b/include/exec/target_long.h
@@ -10,6 +10,7 @@
 #ifndef _TARGET_LONG_H_
 #define _TARGET_LONG_H_
 
+#if defined(COMPILING_PER_TARGET)
 /*
  * Usually this should only be included via cpu-defs.h however for
  * certain cases where we want to build only two versions of a binary
@@ -40,5 +41,15 @@ typedef uint64_t target_ulong;
 #else
 #error TARGET_LONG_SIZE undefined
 #endif
+#elif defined(CONFIG_SOFTMMU)
+/*
+ * softmmu common: widest target_ulong and runtime MO_TL only.
+ * target_long, TARGET_LONG_SIZE, and TARGET_FMT_* stay per-target
+ * (TARGET_LONG_BITS / TARGET_FMT_* are poisoned here).
+ */
+#include "qemu/target-info.h"
+typedef uint64_t target_ulong;
+#define MO_TL (target_long_bits() == 64 ? MO_64 : MO_32)
+#endif
 
 #endif /* _TARGET_LONG_H_ */
-- 
2.52.0.windows.1

