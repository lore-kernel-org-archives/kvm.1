Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA32D37D114
	for <kvm@vger.kernel.org>; Fri, 10 Apr 2026 19:53:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775850817; cv=none; b=AsFm7sLUs9GdZgssIVVDJna7QkzN7COOffrddvsgiswWgK44sqU9kgIoOG9/0YvdZ3wPDP6RxIxu4HLWlRc5TYNlzgZSSd1zZXgfLrgDbhqtv33ydWnT3swxRCvdGEF0JAPEzHhv4HDHT0OkvV/bSpOjFuu39oxuZT5JP7KQPvk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775850817; c=relaxed/simple;
	bh=7av7a5wWlCflkQcEYgv35qsmE82bQQbfzzId97hFzIk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tYO0sgadfs+Ab/BCw/B0wF4C8T3/VeZichP0EeeDgozFmwadJRMdhKWi5ObqVedHw7V4kZEs1isrnyPIT7dIEA1bmaCn2MlQszHZu71yMFRRS5noQh/h+X01aI3pKqObhHAf/ewVy42jaJIHCwyTN900XBJADeqlt/Cm4L001nU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=kpqU9e25; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="kpqU9e25"
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-43cf73bbfbdso1477979f8f.1
        for <kvm@vger.kernel.org>; Fri, 10 Apr 2026 12:53:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1775850813; x=1776455613; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vgSDBpX5CLw08pNI+SPMIuoznTVCeN74IG0qPtzmxwM=;
        b=kpqU9e25XWVZp+qmQmHkFQH6VMm9npI+sjDXeTOon7x0+bJKw9bUl2vM/f480MTfwU
         CGOm5kM2h7l+VgaUIdYuxgOe9UwVNn300/hIG2Rdu2zGMNc8HqPhyE5q76jKoNJ06rf1
         HnlXmvVPE5rDmu6MbVDcjpo0Lk9wNOeAW7PrI80estGt8YsB8WZs1J2Zgt2uLUML4Eqz
         rPC+DtqT0CFIUjxdSn0mVD5B9DKetnWQWnyQ7UTJL/4LJZ1kxVtBWX5RWgrve1ilMV3d
         vlhqnSNoevWHhKePHx9VTEd0lHVgJvsi9QPFPejNVzMqlIcWUcikReLzbBztndK/kvUu
         pa/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775850813; x=1776455613;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=vgSDBpX5CLw08pNI+SPMIuoznTVCeN74IG0qPtzmxwM=;
        b=CR66QVwV50uZKl9/1O9+XSKyHBuGnICQq/ehB2IZDVJjDa/kfsVr1xpC8Goe7VBv8Z
         7P5hlqWiCCGXFqgCt8CweQ4EOiSXH9ccUAdKaLxsejuZ3zrgtqH0ZMzPfD2BDaB3h5WT
         xfp/c1P43bVmoztdNGi7+rAGGOal0m1a5DdRwhXYp2KQX4d6witJdfnLYQLaJIFaNK7I
         jy2yPTTR3uAW1Q0VxBWu6l3SReNY4Y40n4ZShaYEmmSlntaT49FvmRTRO6gaG4Ta8D78
         9cP+QrPzCF+4FRLtXtHGWJCpbIufhbfn5AZtj0oK/h16XTo4uto6CqgROfORll3vWDB1
         kRFw==
X-Forwarded-Encrypted: i=1; AJvYcCWLoM7vgpX+ihhULGiQp8CQ0Mw/RA/CVuiPreiKEfzby3ztXQCPX8e1iG6IT6ptfzSsOHE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx9riGNEa+nuNrNLRXHyPSycDkmuN/WtKrM/z3cl71ABnc/gpfi
	6gg3DMpbM42BsK3FXxC/i9bc+ES0sfnWHCPadUev0vHsCxHGabnzHU6MuAHnKHg7qSU=
X-Gm-Gg: AeBDiet4aI1TYcbKJrowzybuXGEN3Xc5z2Onrr+JdI61GJTSy0B541UPhny1GKagCkt
	Plrrv0dWvWxGkY3AC+UThRDo+zoVzZSbsJBjBdW0xgDzIxF1hWCLxqJldjPN9MGrctzBb1h51jh
	8JAdxTj4MRU1jgefrlDXmOI3RLldHz8cT50TkY22YsnTSZg3lhTBCPcTXf0cQYFaTUpnoeru6Oi
	G3uo7d0b+ojMfDD3rRdV0zR79lkZdNHwl/6fNXNwT3kx+ia6GHLg/UOl0TXqfJw0f+NOo1oajXn
	CaaFF23rKdlXG8ozfMAofKY3X1FQveG7c1TI7tR+mU5bygYOb0ouE2jjRbuenHTEZG8KSxgcXCs
	iB02NA8vh0lq6TMlbLVga/vih1Pou1BgoYU6lafacjoQvib1XJqhmn0HjL9PqV6FyrXRDkr6h0r
	uhLeDtf47hGB7qJKEqpRiLorY05r0+vuRaYgdnjfsXpTpN3qbWBwUQwbk1xMg4zRHbiVoJvwIn
X-Received: by 2002:a05:6000:420b:b0:43c:fd18:a30e with SMTP id ffacd0b85a97d-43d642b4653mr6664483f8f.35.1775850812787;
        Fri, 10 Apr 2026 12:53:32 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net. [88.187.86.199])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43d63deba9esm10266885f8f.10.2026.04.10.12.53.31
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 10 Apr 2026 12:53:32 -0700 (PDT)
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
	Paolo Bonzini <pbonzini@redhat.com>,
	Zhao Liu <zhao1.liu@intel.com>
Subject: [PATCH v2 01/27] monitor: Have MonitorDef::get_value() always return int64_t type
Date: Fri, 10 Apr 2026 21:52:55 +0200
Message-ID: <20260410195323.17937-2-philmd@linaro.org>
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

Simplify MonitorDef::get_value() handler by having it always
return a int64_t type. Truncate to 32-bit in the single caller.

Note, this handler is only implemented once for the x86 targets.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 include/monitor/hmp-target.h | 6 +-----
 monitor/hmp-target.c         | 4 +++-
 target/i386/monitor.c        | 4 ++--
 3 files changed, 6 insertions(+), 8 deletions(-)

diff --git a/include/monitor/hmp-target.h b/include/monitor/hmp-target.h
index ce0bb1983cc..6364c94edf8 100644
--- a/include/monitor/hmp-target.h
+++ b/include/monitor/hmp-target.h
@@ -27,15 +27,11 @@
 
 typedef struct MonitorDef MonitorDef;
 
-#ifdef COMPILING_PER_TARGET
-#include "exec/target_long.h"
 struct MonitorDef {
     const char *name;
     int offset;
-    target_long (*get_value)(Monitor *mon, const struct MonitorDef *md,
-                             int val);
+    int64_t (*get_value)(Monitor *mon, const struct MonitorDef *md, int offset);
 };
-#endif
 
 const MonitorDef *target_monitor_defs(void);
 int target_get_monitor_def(CPUState *cs, const char *name, uint64_t *pval);
diff --git a/monitor/hmp-target.c b/monitor/hmp-target.c
index da7dd7f31f2..812714ada01 100644
--- a/monitor/hmp-target.c
+++ b/monitor/hmp-target.c
@@ -23,6 +23,7 @@
  */
 
 #include "qemu/osdep.h"
+#include "qemu/target-info.h"
 #include "monitor-internal.h"
 #include "monitor/qdev.h"
 #include "net/slirp.h"
@@ -79,7 +80,8 @@ int get_monitor_def(Monitor *mon, int64_t *pval, const char *name)
     for(; md->name != NULL; md++) {
         if (hmp_compare_cmd(name, md->name)) {
             if (md->get_value) {
-                *pval = md->get_value(mon, md, md->offset);
+                int64_t val = md->get_value(mon, md, md->offset);
+                *pval = target_long_bits() == 32 ? (int32_t)val : val;
             } else {
                 CPUArchState *env = mon_get_cpu_env(mon);
                 ptr = (uint8_t *)env + md->offset;
diff --git a/target/i386/monitor.c b/target/i386/monitor.c
index 977f65fe16c..b128334e571 100644
--- a/target/i386/monitor.c
+++ b/target/i386/monitor.c
@@ -593,8 +593,8 @@ void hmp_mce(Monitor *mon, const QDict *qdict)
     }
 }
 
-static target_long monitor_get_pc(Monitor *mon, const struct MonitorDef *md,
-                                  int val)
+static int64_t monitor_get_pc(Monitor *mon, const struct MonitorDef *md,
+                              int offset)
 {
     CPUArchState *env = mon_get_cpu_env(mon);
     return env->eip + env->segs[R_CS].base;
-- 
2.53.0

