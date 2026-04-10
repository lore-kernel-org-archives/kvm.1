Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A6C237F723
	for <kvm@vger.kernel.org>; Fri, 10 Apr 2026 19:54:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775850888; cv=none; b=UunFw2YcpzXci66+b3W4fq3DOxdn+8HOBIgPjZ0OHe/cPOHYVqz6zBF9r9bqyl2kFCiK17CG+RKkEdY0V0HuK9waK/9pUntX7yTVpyeioF44iuR4kfQQEWDWPOgEdOG7ZV0Xj2oS01VviFgIAM/0dgYldLCxAauOcAaBn4/nWO4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775850888; c=relaxed/simple;
	bh=Y3MzIFEmpDL+pfmtjGC+SXdgom8qJcHAqyzPTtP0pFM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UfoznTAK8UsuQaMMensIYw50SpuDNteO1en0r9xEbRZyhrY/t8HA3Bi1dh1vs706i9gDre6e/SEyakRzlBeosTtUTuyOt3hC469osFi6vcY3+jL9vUieB6Hs+6n4GA3tq+6BzQS5un2WVcB5yw87D0u167ouw1ggFFGWKjWXJDw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=gv7KiK0W; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="gv7KiK0W"
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-4887ca8e529so15687215e9.0
        for <kvm@vger.kernel.org>; Fri, 10 Apr 2026 12:54:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1775850886; x=1776455686; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=m5TS34D7gzjspZxEtF9wQrQfCaZf1oD4hCg5mbcwpKM=;
        b=gv7KiK0W2zeqy5AxQqYQ4Sae0h0euxyiyLM1/EIaQrvnwTMtx0qqKOco92XxoNjVI+
         TS8tTtdoUMR7oFWmusIzov0zQxTaxsxl8fb7pTMEzZ89wNskFQPHbDKSSLufy0ljSbJP
         mMQXxUIJdu6GwE8w6z1tud5hvnrPX5mvHSenxxQjC+yYGa2ZNR4P9YIuU+M4+/0wjVzZ
         G66M0uVLIOvqrEn9qvW/FRFLdhFdO0Mgb0MW/e6NLSOghY9BLUVzl9WeJ1nLhYFJSDgB
         Ql7QP+PR5Av6xA9nf6AxDD55a5CfRylk9n+sgcDrejsJS0XMqOtiJ1rE+H+K7n4WhkMc
         wbRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775850886; x=1776455686;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=m5TS34D7gzjspZxEtF9wQrQfCaZf1oD4hCg5mbcwpKM=;
        b=DUHrUCJq5maEcy4uTdOaEbw/jyL/Jp9JWkS1UWD73kiMyEfeUzJ+MZ7FL+4KG3ghZ+
         ocRfQa80zZ/79y96MkzPBZCBPwkBspL7ZaXqPrgO+AgGUolycltfqawfPt7X39HWTjMZ
         Fr84LcPWnvF31H+o+dXiBzzzU9D5Ms+dVxIhsy2HMP2gqaXEAEE257vv38/lbyZQYuR3
         pV6midmmLZmedH4d5eAdeMBWb9QQPQnNV4tdscpTVn3xdEHn+8ZtiuXKH6cunRhaTH0t
         k0GlQutL+C7+MCMyEWbaSgBNXdYawilv4W74gEIIaQkr5GldMocNBACQ+zv1IB6+Htv4
         QEjA==
X-Forwarded-Encrypted: i=1; AJvYcCWU9R7IEJH7pLmp12h5NCwc5lrqDnhd7c3/Lpq0v+bajA2Csq+TFu8mkWp8h1P1qCWVIlE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw0I4YEnO6zQwt4TyVC7Gc/Y+mPc3t/OT/svkW+sHZX1teSvwOy
	0QM2CF8Fy7Jq66+FXT1rClUYNjn41JrogwEiiLP00Yn1wKL/UBonR9x+S5Xq6tvkRSY=
X-Gm-Gg: AeBDies17VNPUqdeLlFgAjevmywzO1t7TBaMCAHFEFFJCthJ93Do8DmnktmLGTZIWLt
	pvnJtX0GI4YouwGw5T1AdICjZV6bve0wXbQMGKrFJ0+MztJv8uoQJglCNVsCleRVANTEbAPiH8q
	lN+p2SCjdIVjS142/9XEiEI09CA62yd3jmYShRARvpe0UTlCInWkZzqFdlPamqGOytNiaHpFSGM
	8AeytVL6pBddtD7pSiz2hEvAe3bIOCnMI2u6/UQFFgS1qrGtuYiRbV/tQoz+u4eRBP8OIInWSRD
	ejji+gLyOd2iScEcbcbVK+6PHoPf2qUQt0X3wSri0ce2ZhqDtK/PBy1jpZCBKEj0E93xm6qcZ3T
	hVS/2L7k99s02jYz4b10EzQA77ISQv7sVgNQzarJTGob7jkp0tVIt+D0ZEJnftiqk/BKVC6CDyU
	nslkB4Wj1kH540t5SkMRC2ak3sDfeWhvJJ3Bh+66hqLScIsbPNMvBxhKQgzoCFtpko8zHCS9Xw
X-Received: by 2002:a05:600c:3ba4:b0:488:c6e9:1e0c with SMTP id 5b1f17b1804b1-488d6847de9mr53887245e9.5.1775850885735;
        Fri, 10 Apr 2026 12:54:45 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net. [88.187.86.199])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-488d533e596sm100071985e9.6.2026.04.10.12.54.44
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 10 Apr 2026 12:54:44 -0700 (PDT)
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
	=?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v2 11/27] cpus: Introduce SysemuCPUOps::monitor_get_register() hook
Date: Fri, 10 Apr 2026 21:53:05 +0200
Message-ID: <20260410195323.17937-12-philmd@linaro.org>
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

Allow targets to register their legacy target_get_monitor_def()
in SysemuCPUOps; check it first in get_monitor_def() otherwise
fall back to previous per-target helper.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 include/hw/core/sysemu-cpu-ops.h | 8 ++++++++
 monitor/hmp.c                    | 6 +++++-
 2 files changed, 13 insertions(+), 1 deletion(-)

diff --git a/include/hw/core/sysemu-cpu-ops.h b/include/hw/core/sysemu-cpu-ops.h
index a96f4907d05..a9200ec5737 100644
--- a/include/hw/core/sysemu-cpu-ops.h
+++ b/include/hw/core/sysemu-cpu-ops.h
@@ -85,11 +85,19 @@ typedef struct SysemuCPUOps {
      */
     bool (*internal_is_big_endian)(CPUState *cpu);
 
+    /**
+     * @monitor_get_register: Callback to fill @pval with register @name.
+     *                        This field is legacy, use @gdb_core_xml_file
+     *                        to dump registers instead.
+     */
+    int (*monitor_get_register)(CPUState *cs, const char *name, uint64_t *pval);
+
     /**
      * @monitor_defs: Array of MonitorDef entries. This field is legacy,
      *                use @gdb_core_xml_file to dump registers instead.
      */
     const MonitorDef *monitor_defs;
+
     /**
      * @legacy_vmsd: Legacy state for migration.
      *               Do not use in new targets, use #DeviceClass::vmsd instead.
diff --git a/monitor/hmp.c b/monitor/hmp.c
index 3d812ea3068..799855f3f68 100644
--- a/monitor/hmp.c
+++ b/monitor/hmp.c
@@ -1632,7 +1632,11 @@ static int get_monitor_def(Monitor *mon, int64_t *pval, const char *name)
         }
     }
 
-    ret = target_get_monitor_def(cs, name, &tmp);
+    if (cs->cc->sysemu_ops->monitor_get_register) {
+        ret = cs->cc->sysemu_ops->monitor_get_register(cs, name, &tmp);
+    } else {
+        ret = target_get_monitor_def(cs, name, &tmp);
+    }
     if (!ret) {
         *pval = target_long_bits() == 32 ? (int32_t)tmp : tmp;
     }
-- 
2.53.0

