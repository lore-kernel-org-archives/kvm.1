Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05A73412BFB;
	Thu, 17 Sep 2026 08:55:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789635363; cv=none; b=HkR1J/GJdidDKtVuwCT4G2FR94OpLw1oroL+7qcnE7oQbaClaV571ulhr4M0bdmUX91f277QU2kIxilsWUipbEkLIHcO4LuUvwQycFBJ3iXECoZwAT+4Q0UdrI9/Dmj047Bt3AiKRVzBB/bcEnDBXoa8dEHo/+FbaEN6VYQ46C4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789635363; c=relaxed/simple;
	bh=Mc0lFG0Z0oBzNs3L58U9sL+1iv+RkGg36M51tN5iKSo=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=iCx4d8yTjOMoiVKzh1K8nO+3dOFNZB9o9JetaFlazwSvxd3/V9PlgoDshNJt95uLA93l3cnST3qxu6LL2fjxu2bMEOQDYFQ9D0aDZHkPybEYkWyaxF4m+CaceBMkHXOeHYQ34Lkw5utYl/xUHE133jmmbK8XM6Diin6bNcfkmFE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=TbjybCJX; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="TbjybCJX"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1789635360; x=1821171360;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=Mc0lFG0Z0oBzNs3L58U9sL+1iv+RkGg36M51tN5iKSo=;
  b=TbjybCJXqENA5/dQpEa7D4cEXa1qrnqwisf+U1O2WnvEQUBT2Xf6ZceU
   2ndyJPz8FDUUhbGXj5x6yLM1XVkFQf8CBesmT+o8J2dT9TAi5PGFzGR8/
   oP/jyKZ4cX+eb13Do+zAYoIUuzUpPOPK+ZO9463KX5eNFzh1TR5qffUIx
   QJlQPe88g6J3ziuv9yYXPfzPQUvlXUma/TblrPyKAHfytfnTdrr/+UrKQ
   5figb03P9H10T9J4fH2TiAI9xPACdJab1stkr8BMSWMyvpUZGxbr+ZuNV
   m3PoC000Ma+7HUmAkQ/247/CeppF9ke/QYeCeHKLkudlAfWZfXXD//wAg
   w==;
X-CSE-ConnectionGUID: y6KVqTEuQSOD/ZfqHTskVA==
X-CSE-MsgGUID: ODra5nZkSoeCl/1bU2xBVA==
X-IronPort-AV: E=McAfee;i="6800,10657,11905"; a="93861767"
X-IronPort-AV: E=Sophos;i="6.27,103,1787036400"; 
   d="scan'208";a="93861767"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Sep 2026 01:55:57 -0700
X-CSE-ConnectionGUID: RE2V7s0YTmi6smSY9w/WPw==
X-CSE-MsgGUID: ob9ktvbyR++ZXnBHTxTu5A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,103,1787036400"; 
   d="scan'208";a="275621273"
Received: from ubuntu.bj.intel.com ([10.238.152.72])
  by fmviesa004.fm.intel.com with ESMTP; 17 Sep 2026 01:55:55 -0700
From: Jun Miao <jun.miao@intel.com>
To: sathyanarayanan.kuppuswamy@linux.intel.com,
	rick.p.edgecombe@intel.com,
	dave.hansen@linux.intel.com,
	kas@kernel.org
Cc: linux-coco@lists.linux.dev,
	kvm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	jun.miao@intel.com
Subject: [PATCH v2] virt: tdx-guest: Use read_poll_timeout() to shorten get-quote polling interval
Date: Thu, 17 Sep 2026 16:55:33 +0800
Message-Id: <20260917085533.750434-1-jun.miao@intel.com>
X-Mailer: git-send-email 2.32.0
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The TD guest sends TDREPORT to the TD Quoting Enclave via a vsock or
a tdvmcall. In general, vsock is indeed much faster than tdvmcall,
and Quote requests usually take a few millisecond to complete rather
than seconds based on actual measurements.

The following get quote time via tdvmcall were obtained on the GNR:

| msleep_interruptible(time)     | 1s       | 5ms      | 1ms        |
| ------------------------------ | -------- | -------- | ---------- |
| Duration                       | 1.004 s  | 1.005 s  | 1.036 s    |
| Total(Get Quote)               | 167      | 142      | 167        |
| Success:                       | 167      | 142      | 167        |
| Failure:                       | 0        | 0        | 0          |
| Avg total / 1s                 | 0.97     | 141.31   | 166.35     |
| Avg success / 1s               | 0.97     | 141.31   | 166.35     |
| Avg total / 1s / thread        | 0.97     | 141.31   | 166.35     |
| Avg success / 1s / thread      | 0.97     | 141.31   | 166.35     |
| Min elapsed_time               | 1025.95ms| 6.85 ms  | 2.99 ms    |
| Max elapsed_time               | 1025.95ms| 10.93 ms | 10.76 ms   |

According to trace analysis, the typical execution tdvmcall get the
quote time is 4 ms. Therefore, 5 ms is a reasonable balance between
performance efficiency and CPU overhead.

Since it's a real issue, updating the polling interval to 5ms. Given
that deployed QEs respond fast, we should also reduce the maximum wait
time to 2 seconds (from 30 seconds) to fail faster on errors

And compared to the previous throughput of one request per second,
the current 5ms can get 142 requests per second delivers a
142× performance improvement, which is critical for high-frequency
use cases without vsock.

So, change the 1s (MSEC_PER_SEC) -> 5ms (5 * USEC_PER_MSEC)

Suggested-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
Signed-off-by: Jun Miao <jun.miao@intel.com>
---

v1 -> v2:
 - Add "Suggested-by: Sathyanarayanan Kuppuswamy"
 - Use read_poll_timeout() from <linux/iopoll.h> to simplify the
   timeout handling instead of manual loop counters.
 - Reduce the maximum wait time to 2 seconds (from 30 seconds) to fail
   faster on errors.

---
 drivers/virt/coco/tdx-guest/tdx-guest.c | 34 +++++++++++++++++--------
 1 file changed, 24 insertions(+), 10 deletions(-)

diff --git a/drivers/virt/coco/tdx-guest/tdx-guest.c b/drivers/virt/coco/tdx-guest/tdx-guest.c
index d0303e31e816..a73d1f0335be 100644
--- a/drivers/virt/coco/tdx-guest/tdx-guest.c
+++ b/drivers/virt/coco/tdx-guest/tdx-guest.c
@@ -16,6 +16,7 @@
 #include <linux/set_memory.h>
 #include <linux/io.h>
 #include <linux/delay.h>
+#include <linux/iopoll.h>
 #include <linux/sockptr.h>
 #include <linux/tsm.h>
 #include <linux/tsm-mr.h>
@@ -198,10 +199,10 @@ static void *quote_data;
 static DEFINE_MUTEX(quote_lock);
 
 /*
- * GetQuote request timeout in seconds. Expect that 30 seconds
+ * GetQuote request timeout in seconds. Expect that 2 seconds
  * is enough time for QE to respond to any Quote requests.
  */
-static u32 getquote_timeout = 30;
+static u32 getquote_timeout = 2;
 
 static long tdx_get_report0(struct tdx_report_req __user *req)
 {
@@ -251,18 +252,31 @@ static void *alloc_quote_buf(void)
  */
 static int wait_for_quote_completion(struct tdx_quote_buf *quote_buf, u32 timeout)
 {
-	int i = 0;
+	u64 status;
+	int ret;
 
 	/*
-	 * Quote requests usually take a few seconds to complete, so waking up
-	 * once per second to recheck the status is fine for this use case.
+	 * Quote requests usually take a few milliseconds to complete, so waking
+	 * up once per 5 milliseconds to recheck the status is fine for this use
+	 * case. Fixed-interval polling doesn't scale well since QE response
+	 * times vary by implementation; an interrupt-based approach would be
+	 * the proper long-term solution.
+	 *
+	 * Also break out early if a signal is pending so the caller can be
+	 * interrupted while waiting.
 	 */
-	while (quote_buf->status == GET_QUOTE_IN_FLIGHT && i++ < timeout) {
-		if (msleep_interruptible(MSEC_PER_SEC))
-			return -EINTR;
-	}
+	ret = read_poll_timeout(READ_ONCE, status,
+				status != GET_QUOTE_IN_FLIGHT ||
+					signal_pending(current),
+				5 * USEC_PER_MSEC, timeout * USEC_PER_SEC,
+				false, quote_buf->status);
+	if (ret)
+		return ret;
+
+	if (signal_pending(current))
+		return -EINTR;
 
-	return (i == timeout) ? -ETIMEDOUT : 0;
+	return 0;
 }
 
 static int tdx_report_new_locked(struct tsm_report *report, void *data)
-- 
2.43.0

