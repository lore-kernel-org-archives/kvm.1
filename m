Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EBD7345750
	for <kvm@vger.kernel.org>; Fri, 10 Apr 2026 19:55:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775850952; cv=none; b=RDS5sRpY9oCMOIvzOd07ZMbpJ+EKfSVZQD9cKiVHwNFuqlbE6cUr2gGMBuaYWEU3Pcrsc7jbi8E7j53zvhIp4mM5lIm4LSU2YegYiD/X3BjDfNkbJ/9rqzgJL38VJJNxXJxJ17AMuIrxbRewHTe5+AMXrfqEnVWQrLktfII23x8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775850952; c=relaxed/simple;
	bh=1yL5jZ+1xkQvqOror3INGmbzRcnWFDdcbu3jaVhfLqQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=r8zzZAbijD5Wpg5K/w5pVqtN4+LWwVc6awjj7uwgZh6OZ/yzVow0hU/Oa2DYLHOfZhR6NEP3WvAbcRwevPcZC3na+OsqH7xZEbB4nfcHhaymwnBFS1J6RqpZbMPjTS0Ij9Aq1QZcCvzPKkM9KV3KATf5hvjbjNgxETRST5fo+kM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Qoq4tloq; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Qoq4tloq"
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-488b00ed86fso25871655e9.3
        for <kvm@vger.kernel.org>; Fri, 10 Apr 2026 12:55:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1775850950; x=1776455750; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=j1FsrkHiiVfTWUBHqJkrxULfXG6j6GR2S4+XnGN40SU=;
        b=Qoq4tloq9ra/C/kMYVVyy/KTomL9qC4Kvsb71Dd8ShFLrlnxlQDh3HH0AQT5T45TlP
         U2HBoYAJZ/zOpITmYA1WCOp+MhqkarGFrEo7sId7sXmfz/DaQLpVrpi3fssx92YB7/II
         dsQMGvxAUKdKFSgmflCgsyx/7Z4LiavBH1S4xmX3EUpVoxjG0c8l6juc7+VcVyBlro6E
         UOnCHCd0BgB/PhvbYDAwQhz0npmEQXK8+cYRodz1NaoiX2/Q8MP1vO219XfxhG4JLgbC
         MgtWXiInO8zJdE8qu6aUNrdYoSwG8wiF+yuPwXLTiXXxQFGgPFGR4E/HPlRn01OKYjiT
         EWhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775850950; x=1776455750;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=j1FsrkHiiVfTWUBHqJkrxULfXG6j6GR2S4+XnGN40SU=;
        b=Kuq4AvKh8ilvowM2ER9Oi7uJeNiUBHLB+oxCLyDhg9x52vZsXyCNREJ2nkYTMJ9Mxm
         xPJwDsJ0dwrDaxdHIhmTcRjYMPayoB99lazPvSRmvRJMgz54mSZmEN5MHikSQcDcX3nr
         n1gbhoBj5rqV/kNKHUgrN1wc2h/mGXLrDVX6d0NRvcnbRCwPnXP/nI1dwe0naikVJ9nS
         qK/ITmHh9YZlHbn7WLzMGPvu18FPGhkNHrGgKbtWqPXkGzJ7CBXnHBycRVLdDZqMvP+9
         7rcZ0mJAT9N8vAoh8WymQt/412GfloEpMpkny8qNl8KXahhQ8aUUr21+GgyhBr55lME2
         nCyg==
X-Forwarded-Encrypted: i=1; AJvYcCXxbjSt5HrKiQ/1exi9vBA+V71GcAJxv7J4/0HONnr/IJd83ju60E7gNiyP76QXgzTxNzg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx5Slfr5mqB3Kiym8bd9g0o5PWHPjOn3udL1ydgzv/0ZOvLs6zL
	vIqA7LdoEJPect4NvORkGtH68lg3Leit9dZutWcwa64QQmywS89zvJlf1TDcZy7YBOc=
X-Gm-Gg: AeBDievxOTWi4kDA6dUUJ/OpgJjMGhIaAY5PGBljAUAkiCVP0gx4H+L+OfzOgxgPIj9
	jZOQOqo2bfVSG3dfBu0b3CDon4x8GmdoEl0gCDQPxxvvJz0DvlvVA6EF9frDBD+M52OFaSwSBpV
	Z8tTLFj8SjtWc1dWdJv9bqLT+vslg/KUr79+23wOv51Bg6rRrorU14+04Y8/UpLRMT3UMT1kx2k
	jdA6waW016DtMRVB1oDnJks2pQKH3SEbn5PIerSppCQrXaunJHCnfXRYHHvTzvsiSi4UJpXDUkQ
	BsQBVdt5lyJDDXAuO9h+j8ynEdN9lLjsunZe8rc4BnFWrybXBMhrx/lB5Is72CWtMq9uuix+c9F
	Wz/vTSbdWZwXQbm0ZC8KryiOXxLZzViSM2eI86LphgOz/qAMuWWOwYcF+bIyIwKx/62WQZOtgJq
	zkf6F1S5SdopS8FF8naff6PPv8MyFkx/SeeQO6EInza2AkqglUFK4hFZibgHkIJEYBR5ejDoGL
X-Received: by 2002:a05:600c:871a:b0:488:c683:be89 with SMTP id 5b1f17b1804b1-488d67f0b8fmr60065145e9.9.1775850949623;
        Fri, 10 Apr 2026 12:55:49 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net. [88.187.86.199])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-488d525c931sm98623515e9.0.2026.04.10.12.55.48
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 10 Apr 2026 12:55:49 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
	"Dr. David Alan Gilbert" <dave@treblig.org>,
	Pierrick Bouvier <pierrick.bouvier@linaro.org>,
	qemu-riscv@nongnu.org,
	Markus Armbruster <armbru@redhat.com>,
	qemu-s390x@nongnu.org,
	kvm@vger.kernel.org,
	qemu-ppc@nongnu.org,
	=?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
	Halil Pasic <pasic@linux.ibm.com>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	Jason Herne <jjherne@linux.ibm.com>,
	Eric Farman <farman@linux.ibm.com>,
	Matthew Rosato <mjrosato@linux.ibm.com>,
	Ilya Leoshkevich <iii@linux.ibm.com>,
	David Hildenbrand <david@kernel.org>,
	Cornelia Huck <cohuck@redhat.com>
Subject: [PATCH v2 20/27] hw/s390x: Reduce 'monitor/monitor.h' inclusions
Date: Fri, 10 Apr 2026 21:53:14 +0200
Message-ID: <20260410195323.17937-21-philmd@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260410195323.17937-1-philmd@linaro.org>
References: <20260410195323.17937-1-philmd@linaro.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

We want to make the HMP commands available for all targets,
move the declarations to "monitor/hmp.h" where all other
are, and only include the monitor headers in the source files.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 include/hw/s390x/storage-attributes.h | 4 ----
 include/hw/s390x/storage-keys.h       | 3 ---
 include/monitor/hmp.h                 | 5 +++++
 hw/s390x/s390-skeys.c                 | 2 ++
 hw/s390x/s390-stattrib.c              | 2 ++
 5 files changed, 9 insertions(+), 7 deletions(-)

diff --git a/include/hw/s390x/storage-attributes.h b/include/hw/s390x/storage-attributes.h
index 66716a97c05..0305873b019 100644
--- a/include/hw/s390x/storage-attributes.h
+++ b/include/hw/s390x/storage-attributes.h
@@ -13,7 +13,6 @@
 #define S390_STORAGE_ATTRIBUTES_H
 
 #include "hw/core/qdev.h"
-#include "monitor/monitor.h"
 #include "qom/object.h"
 
 #define TYPE_S390_STATTRIB "s390-storage_attributes"
@@ -72,7 +71,4 @@ static inline Object *kvm_s390_stattrib_create(void)
 }
 #endif
 
-void hmp_info_cmma(Monitor *mon, const QDict *qdict);
-void hmp_migrationmode(Monitor *mon, const QDict *qdict);
-
 #endif /* S390_STORAGE_ATTRIBUTES_H */
diff --git a/include/hw/s390x/storage-keys.h b/include/hw/s390x/storage-keys.h
index 2d02936c31c..666c05e2996 100644
--- a/include/hw/s390x/storage-keys.h
+++ b/include/hw/s390x/storage-keys.h
@@ -13,7 +13,6 @@
 #define S390_STORAGE_KEYS_H
 
 #include "hw/core/qdev.h"
-#include "monitor/monitor.h"
 #include "qom/object.h"
 
 #define TYPE_S390_SKEYS "s390-skeys"
@@ -123,8 +122,6 @@ int s390_skeys_set(S390SKeysState *ks, uint64_t start_gfn,
 S390SKeysState *s390_get_skeys_device(void);
 
 void s390_qmp_dump_skeys(const char *filename, Error **errp);
-void hmp_dump_skeys(Monitor *mon, const QDict *qdict);
-void hmp_info_skeys(Monitor *mon, const QDict *qdict);
 
 #define TYPE_DUMP_SKEYS_INTERFACE "dump-skeys-interface"
 
diff --git a/include/monitor/hmp.h b/include/monitor/hmp.h
index b444095f684..a0a063db8e4 100644
--- a/include/monitor/hmp.h
+++ b/include/monitor/hmp.h
@@ -182,4 +182,9 @@ void hmp_gva2gpa(Monitor *mon, const QDict *qdict);
 void hmp_gpa2hva(Monitor *mon, const QDict *qdict);
 void hmp_gpa2hpa(Monitor *mon, const QDict *qdict);
 
+void hmp_dump_skeys(Monitor *mon, const QDict *qdict);
+void hmp_info_skeys(Monitor *mon, const QDict *qdict);
+void hmp_info_cmma(Monitor *mon, const QDict *qdict);
+void hmp_migrationmode(Monitor *mon, const QDict *qdict);
+
 #endif
diff --git a/hw/s390x/s390-skeys.c b/hw/s390x/s390-skeys.c
index d974d97b5e7..7dca67d6618 100644
--- a/hw/s390x/s390-skeys.c
+++ b/hw/s390x/s390-skeys.c
@@ -24,6 +24,8 @@
 #include "system/kvm.h"
 #include "migration/qemu-file-types.h"
 #include "migration/register.h"
+#include "monitor/hmp.h"
+#include "monitor/monitor.h"
 #include "trace.h"
 
 #define S390_SKEYS_BUFFER_SIZE (128 * KiB)  /* Room for 128k storage keys */
diff --git a/hw/s390x/s390-stattrib.c b/hw/s390x/s390-stattrib.c
index 2e83aa211cd..74b23b0a995 100644
--- a/hw/s390x/s390-stattrib.c
+++ b/hw/s390x/s390-stattrib.c
@@ -15,6 +15,8 @@
 #include "system/ram_addr.h"
 #include "migration/qemu-file.h"
 #include "migration/register.h"
+#include "monitor/hmp.h"
+#include "monitor/monitor.h"
 #include "hw/core/qdev-properties.h"
 #include "hw/s390x/storage-attributes.h"
 #include "qemu/error-report.h"
-- 
2.53.0

