Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77FC53845D4
	for <kvm@vger.kernel.org>; Fri, 10 Apr 2026 19:54:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775850845; cv=none; b=LZokTwIKcmVKcvHSKr0mH0r1KNG2xDSo6N2dAks2VS75Nb6aYAwWvSJXcHXWPBn1PVMxIyGBLtsYbNBmkfYpBDFGuj0Y2ZzsRts6UhycIV2ea0IYa6N0sd6dtcN6LAQuuO/hnfmTEn7S9nSM0MjGj+cfMkVRA4mCctVdEnEf064=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775850845; c=relaxed/simple;
	bh=saQYI+zYfPlL6M8bkNDlhGNCe6LAExNbihcrH8/r0vU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bum/xBRepgjMNZO/qjCBN1P60a1D4VdwWo/z/E08oH+qNb7Ka11g/xWWxAFI8i82EeF6MWbV+gk+0ZlyWa/NSnhizK5iPF7GYgzQuv+54aj59q3DoYJGIKKwWpZiRGoWNuvqc1MvYOCx1hvLOfpYSQALn95heYIYWci0NKu+gXs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=RbmWLgP0; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="RbmWLgP0"
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-43cfde3c3f3so2360041f8f.3
        for <kvm@vger.kernel.org>; Fri, 10 Apr 2026 12:54:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1775850843; x=1776455643; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MpWqUPwhfS1fPWpJ/GJCnH26mtliLzp4q5CtM+NZCuc=;
        b=RbmWLgP0lvmgMfaIJTFjGqscO+f1b5v6U9vvgIIJr8O2xstUL7Dtl4L32C+R/cVQ3P
         G3db289tIxgEDo1Tx8i2uNjWZFzwEjN16Wmy5b58HJu1e7UX87tew/8ZyykcJk2Wemv3
         lK1p8lFwJwZY3hf6gLJMYI7Ho6ygb8I9wWg0b7lxXFpo0b1i6IG6YPVnWN7pyolgx0Ml
         KPosgySP+iQQ/vMN1dJsDp7SRgRWzI551g4pd/YRdsixxYSi7OloCLiIcYfgzlc/YyMQ
         +3urHzJRCcr1+luc1IqFU8FW1RiljYSHH03qWiGaN1RqXT7D84G9ThMp0iLTk8XIIWXV
         1reA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775850843; x=1776455643;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=MpWqUPwhfS1fPWpJ/GJCnH26mtliLzp4q5CtM+NZCuc=;
        b=Sk/m9Yto4+bbhv06KmAJG3B3NzetfopvLqRBcN4/n/TuppDFFqkXIrGPz6fR+4LsTz
         XdEBL8JI/qe/KbjrPGVWAae4okg726FNQnc/dI3YMm8gCzunioNG0ClQZSD/oIoNzVNz
         9FELI5r5+bmk/YkHZzk9DJbAjYktffSpoQoyTZLcrDw55hDUwTQyBenDJVn50dVe7uE1
         2fo7sV3BSHxgUEjg6xmNWmsQu42O8kQ8KEUlufksxw+YIbYYZ2lqDN2NSxCak+RuodbF
         Ag5Iyde1v4CfPfOZMZjQd4xzM1uPaleaMC8bE3sc+5B6N7Y5TPAzt/QXHif4FTXsvhlX
         Gadg==
X-Forwarded-Encrypted: i=1; AJvYcCUQSuvZ84tnpY0VUN5pxGxW21JPIx7aGa2okKCRXBVhmedVRNtbQhoU4tYh3joahSwM3RQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwQi/SFIkkLG0L5NOQXwqzNSzZlqHSRtMCP/Q++0HJMWL17y08d
	U5aPWaF2NsgZaUS03VG6KS/YhogFyDTe2hmAOxHmG0pizMZ5JDXLavOZ3jQNUtm/snI=
X-Gm-Gg: AeBDietTUHajYyECC6B7WWjTSfOUe4qY6cHs7N6PIrlze6OQqZBetb0e5dATKm0i1Km
	blw2NvFhx+gXQF0cx/bbGrK3ErIkC6DYuvTa0oxyCseK75MBgMD7iIx27offW3qhZo8KLInKWD8
	ZWaRZnaW+V6My3aSlXx2elOveXGd5xeGU3gkWdR7x+GzUuR94gQgYAcS6x4u2XM0DojQfHiXdho
	wuUKLxpwMrCZSnXXt20FBmlP9I/Dt3nCmxzVWIFkFJerq7SYC1AxeEsQfm2JVdPbK+/31NOe/Rr
	jPP5Ft5BQPL1+6dTy1aFjmYxxqAjf8wShf49N5nhlHfxAOZe6rh9EAQDj1gWLWa/Pmes4Z31aC6
	mMCPUT3ZfMVgSFPC68Rrdc2Ywe/crLJ6pCzyhAx9jK56GgJPdgXH4jbkHpSmdVmViID1WZLhr8X
	rziRgW5ODJHpySunGvmTM7/LFRr4lprvATQg+fS38hgg8Q9+B8dwo1ycvbYSRvp+fF7pcXqdeY
X-Received: by 2002:a05:6000:2886:b0:43b:7ff5:fdf7 with SMTP id ffacd0b85a97d-43d642c8664mr6778189f8f.29.1775850842547;
        Fri, 10 Apr 2026 12:54:02 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net. [88.187.86.199])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43d63e5d85fsm8599729f8f.36.2026.04.10.12.54.01
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 10 Apr 2026 12:54:01 -0700 (PDT)
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
Subject: [PATCH v2 05/27] monitor: Forward-declare the MonitorDef type
Date: Fri, 10 Apr 2026 21:52:59 +0200
Message-ID: <20260410195323.17937-6-philmd@linaro.org>
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

Rather than having core header forced to include "monitor/hmp.h"
to get the MonitorDef type declaration, forward-declare it in
"qemu/typedefs.h".

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 include/monitor/hmp.h   | 6 +++---
 include/qemu/typedefs.h | 1 +
 2 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/include/monitor/hmp.h b/include/monitor/hmp.h
index f17a50a3fed..516089eb5c6 100644
--- a/include/monitor/hmp.h
+++ b/include/monitor/hmp.h
@@ -17,11 +17,11 @@
 #include "qemu/readline.h"
 #include "qapi/qapi-types-common.h"
 
-typedef struct MonitorDef {
+struct MonitorDef {
     const char *name;
     int offset;
-    int64_t (*get_value)(Monitor *mon, const struct MonitorDef *md, int offset);
-} MonitorDef;
+    int64_t (*get_value)(Monitor *mon, const MonitorDef *md, int offset);
+};
 
 const MonitorDef *target_monitor_defs(void);
 int target_get_monitor_def(CPUState *cs, const char *name, uint64_t *pval);
diff --git a/include/qemu/typedefs.h b/include/qemu/typedefs.h
index 416a8c9acea..07f2ae7c9f1 100644
--- a/include/qemu/typedefs.h
+++ b/include/qemu/typedefs.h
@@ -72,6 +72,7 @@ typedef struct MemoryRegionSection MemoryRegionSection;
 typedef struct MigrationIncomingState MigrationIncomingState;
 typedef struct MigrationState MigrationState;
 typedef struct Monitor Monitor;
+typedef struct MonitorDef MonitorDef;
 typedef struct MSIMessage MSIMessage;
 typedef struct NetClientState NetClientState;
 typedef struct NetFilterState NetFilterState;
-- 
2.53.0

