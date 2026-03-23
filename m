Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBC192877DA
	for <kvm@vger.kernel.org>; Mon, 23 Mar 2026 15:03:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774278182; cv=none; b=J1cMN+DcfHA1JcJKKW02zFy50NQ0mP/FhVJ8/kEfcPoAGE/N0nMBg5/R/tArvMGhG+sVONIsXpqNvWNIl4F+vEdL4/GM4LpTQgQPtcV10v+bMFVNt7CzZhq+15vSaGZInwYFeAsOim4Cbk2Ff70JHK/PGjlvQtFWNMU4cpFU1B4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774278182; c=relaxed/simple;
	bh=gJJWmmzvM4LL6Q5UWpLeK2cQ8f6mWqj6dnAww/W73Ac=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DQ/RyJ550oPXAv8blc/Gin+ZTc7enzzmEN51McnznCkPQjVfejEzVbVEvyRCkXZOJWR24LoRmjgU8fmrzh51AFqnPeQ+Lq2H+7sn03ytRVL+Fr92/wvN0zdAvmGiwNxJl/ghBH0tKqzyrneCx3vYTjrYgnQYMyXQ5uUBDRL/htw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6A1A51516;
	Mon, 23 Mar 2026 08:02:54 -0700 (PDT)
Received: from raptor (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 41EE53F694;
	Mon, 23 Mar 2026 08:02:58 -0700 (PDT)
From: Alexandru Elisei <alexandru.elisei@arm.com>
To: will@kernel.org,
	julien.thierry.kdev@gmail.com,
	maz@kernel.org,
	oupton@kernel.org,
	jean-philippe@linaro.org,
	andre.przywara@arm.com,
	suzuki.poulose@arm.com,
	kvm@vger.kernel.org
Subject: [PATCH kvmtool 5/6] util: Allow die_perror() to take a variable list of argument
Date: Mon, 23 Mar 2026 15:02:20 +0000
Message-ID: <20260323150221.49256-6-alexandru.elisei@arm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260323150221.49256-1-alexandru.elisei@arm.com>
References: <20260323150221.49256-1-alexandru.elisei@arm.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Make die_perror() more similar to die() by allowing the user to specify
a format string and arguments.

Signed-off-by: Alexandru Elisei <alexandru.elisei@arm.com>
---
 include/kvm/util.h |  2 +-
 util/util.c        | 17 +++++++++++++++--
 2 files changed, 16 insertions(+), 3 deletions(-)

diff --git a/include/kvm/util.h b/include/kvm/util.h
index ac8515f8c46b..a6dba1147d68 100644
--- a/include/kvm/util.h
+++ b/include/kvm/util.h
@@ -41,7 +41,7 @@
 #define MAP_ANON_NORESERVE (MAP_PRIVATE | MAP_ANONYMOUS | MAP_NORESERVE)
 
 extern void die(const char *err, ...) NORETURN __attribute__((format (printf, 1, 2)));
-extern void die_perror(const char *s) NORETURN;
+extern void die_perror(const char *fmt, ...) NORETURN __attribute__((format (printf, 1, 2)));
 extern void pr_err(const char *err, ...) __attribute__((format (printf, 1, 2)));
 extern void pr_warning(const char *err, ...) __attribute__((format (printf, 1, 2)));
 extern void pr_info(const char *err, ...) __attribute__((format (printf, 1, 2)));
diff --git a/util/util.c b/util/util.c
index fc732200f2dc..0f116e0ac459 100644
--- a/util/util.c
+++ b/util/util.c
@@ -1,6 +1,7 @@
 /*
  * Taken from perf which in turn take it from GIT
  */
+#include <stdio.h>
 
 #include "kvm/util.h"
 
@@ -98,11 +99,23 @@ void __pr_debug(const char *debug, ...)
 	va_end(params);
 }
 
-void die_perror(const char *s)
+void die_perror(const char *fmt, ...)
 {
+	char buf[1024];
+	va_list params;
 	int e = errno;
+	int ret;
+
+	va_start(params, fmt);
+	ret = vsnprintf(buf, sizeof(buf), fmt, params);
+	if (ret < 0) {
+		e = errno;
+		strncpy(buf, "vsnprintf", ARRAY_SIZE(buf) - 1);
+	}
+	va_end(params);
 
-	perror(s);
+	errno = e;
+	perror(buf);
 	exit(e);
 }
 
-- 
2.53.0

