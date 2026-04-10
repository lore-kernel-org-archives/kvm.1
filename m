Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A546946C
	for <kvm@vger.kernel.org>; Fri, 10 Apr 2026 19:55:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775850945; cv=none; b=b1OpLRqA5z7jeyI57uWQzOGic8gVxF+vjTn0VngQsB1248wFmiKb0EbvEX++bpqtCD4deSKIz/mSFuWiGiWESqhBRVkKM3X0K8sENXKbOAjMZWYp5YH8A00dcfVad1Wp+bvBUNdWbNCrkTI25dvOi9g8y/lNifjyp8em/oLz2/Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775850945; c=relaxed/simple;
	bh=X0GPacqCzfami2zVoCdYzdnNdksLgTcbgJwdTHcdYKk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cUquUTberHw1nLmPDZDtF6F7y9vdpGEUEiriVV51xQwCmooOzvGeYwFobXV1xwjrfGonADHILhu/0sXLvWQCHPtTeBm1RAwpnRXBolicqq0g+yOiaD09NjvpFCDww127UrfhSXPqhmCLFDoD0C10LHiY3g4CTyM4VUZkUE7ZDiU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=R3lDXZGK; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="R3lDXZGK"
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-43cf906b007so1501052f8f.0
        for <kvm@vger.kernel.org>; Fri, 10 Apr 2026 12:55:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1775850942; x=1776455742; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KRKFl/rXH5Np5OO3Lz1ftI+bdnLkrX94FQ8eyhGxyK0=;
        b=R3lDXZGKJgNT4/Ra21s0wELR+mulhiGrHynG5KXkuYK/1XOSeG3wcGSqpgLukqWzVe
         hsiBi41xNtiqtGDR/M7jWlhVjIN1fSA1fJRv+gqmB7f7tm68yNY2t+rKtB9nYu9MGshz
         EMTFmuBqS0XUF99Ug/E+dwoMw1tO6IRkaADgqbgpnbMRMa6bY3aBUfqJgoxxVGO6HPzo
         jweJjhHzPVdkRFOpI2vlgFn/TlRp/cf8gE752i/9qAcY6u90lMD9tlpX+dg4qNb0XGG3
         m2PTuAg8LS3tD9KbretksrCwhQeMDpMT1lSuFvnv9FWXr/RekyNiKSRD8A61QiZWZkYb
         X81Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775850942; x=1776455742;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=KRKFl/rXH5Np5OO3Lz1ftI+bdnLkrX94FQ8eyhGxyK0=;
        b=gUvyQVXG0+Dv++RiZFK+qxqAHaU9RHwEua14UGJkkRpKvC30NjPfDx8yrsRvatmM8l
         KKr021oAba1GmrJuboaMjV3ZSJkaBB8ePmTfHUxFvJv/3XmXCY/UDz20bn806/XcAgEG
         m+t6A8MlFASujE4vA9KH9jUk2by8GHdAclkTy0WnPrO4P1eFdlv0He0h5B62Nb65rnP5
         lWDbRnawp5jGtiZXkyVHsMGxy+Ph6mFgb+Bo/UBXJgt038QGApg38RqCocSfyV9ibnes
         jnsUQfpDfbeHJ4eMnwQsC59xYEnAP+EioBrMhX2vFmxbgPcThImgamSJx9Y/L8xt1wW3
         N8Dg==
X-Forwarded-Encrypted: i=1; AJvYcCX6ooHylHK7iHppj0f0vs4I7TakJ4NCZ8v5XO4ehd7RmbybCETECd3322zkWxjEsJ0+GqQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwqvddCmOskgx1UTrKGVfgkpliGuIvHX5PBH0Aa2pYVy+RH5iCs
	MAuVcpxwzPKGyALz//xN+16fnIkm0RAFAkAjWhq+1b7qSPjCWOV4eaECb4DBGC5OUx0=
X-Gm-Gg: AeBDievjL7ygnmsKUPe1xEnvDW5efJE0l6ZHGHutE5ZZITbkm1VVnywOEH7d6SUb7mv
	XfZjwgoLewADa04jv3nsxlKmSmQ44dOCieYuwt+ALdk7ap0ZS8Iy0kWie/TDSCd/fRKYwHXM5PF
	Xls8+kxuJpDwBhx9kC2ZGdrtF+bBzor+/xJzKhyKXnmWSd3mxz/LJdIGOwq+XH6Uvf/m+WHiXqf
	Wgpq+5pVwJ0GUOKW4R1yTRN6JFQ5tFsYGs2QoWzNhPsyr9vRA2TYQ11EYAWkANLEW7A+ihHpD0G
	bW0jVCDtG8vpZUbSDufMQZVFikI3h6HWKp3S3EldGtfz0DhtH5eDVJbQjaW3sr7tn0c3hZ5xMyW
	+Bnu4dcuyDYEe8H4NjR5H8YUp2j5bdLYLori18pN9hf5zpyC/dx7vtskVf2SZPbxx1stZw8F52l
	NWb62dI0ztiH0rCB55riFlHqVXSDBbneGODZHcSXWvtL13J7gaM9fnUEhNQn4uxbytsUlMFndC
X-Received: by 2002:a05:6000:26cf:b0:43b:4212:2ee8 with SMTP id ffacd0b85a97d-43d642b9daamr6511764f8f.24.1775850942417;
        Fri, 10 Apr 2026 12:55:42 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net. [88.187.86.199])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43d63ab84cdsm9885795f8f.0.2026.04.10.12.55.41
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 10 Apr 2026 12:55:41 -0700 (PDT)
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
Subject: [PATCH v2 19/27] monitor: Introduce HMPCommand::arch_bitmask field
Date: Fri, 10 Apr 2026 21:53:13 +0200
Message-ID: <20260410195323.17937-20-philmd@linaro.org>
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

Add the @arch_bitmask field to the HMPCommand structure,
allowing to restrict a command to a set of target
architectures (represented by the QEMU_ARCH_* enum constants).

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 monitor/monitor-internal.h | 6 ++++++
 monitor/hmp-target.c       | 1 +
 monitor/hmp.c              | 4 ++++
 3 files changed, 11 insertions(+)

diff --git a/monitor/monitor-internal.h b/monitor/monitor-internal.h
index 3ecd394ecf6..78281928e7a 100644
--- a/monitor/monitor-internal.h
+++ b/monitor/monitor-internal.h
@@ -74,6 +74,12 @@ typedef struct HMPCommand {
     const char *params;
     const char *help;
     const char *flags; /* p=preconfig */
+    /**
+     * @arch_bitmask: bitmask of QEMU_ARCH_* constants
+     *     Allow to restrict the command for a particular set of
+     *     target architectures.
+     */
+    uint32_t arch_bitmask;
     void (*cmd)(Monitor *mon, const QDict *qdict);
     /*
      * If implementing a command that takes no arguments and simply
diff --git a/monitor/hmp-target.c b/monitor/hmp-target.c
index d07e545ef7e..9d8dcb8835a 100644
--- a/monitor/hmp-target.c
+++ b/monitor/hmp-target.c
@@ -23,6 +23,7 @@
  */
 
 #include "qemu/osdep.h"
+#include "qemu/base-arch-defs.h"
 #include "monitor-internal.h"
 #include "monitor/qdev.h"
 #include "net/slirp.h"
diff --git a/monitor/hmp.c b/monitor/hmp.c
index 3b9e180c1ca..c1e99c462b8 100644
--- a/monitor/hmp.c
+++ b/monitor/hmp.c
@@ -36,6 +36,7 @@
 #include "qemu/cutils.h"
 #include "qemu/log.h"
 #include "qemu/option.h"
+#include "qemu/base-arch-defs.h"
 #include "qemu/target-info.h"
 #include "qemu/units.h"
 #include "exec/gdbstub.h"
@@ -219,6 +220,9 @@ static bool cmd_can_preconfig(const HMPCommand *cmd)
 
 static bool cmd_available(const HMPCommand *cmd)
 {
+    if (cmd->arch_bitmask && !qemu_arch_available(cmd->arch_bitmask)) {
+        return false;
+    }
     return phase_check(PHASE_MACHINE_READY) || cmd_can_preconfig(cmd);
 }
 
-- 
2.53.0

