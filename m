Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A316421A15;
	Thu, 17 Sep 2026 10:22:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789640551; cv=none; b=JCV46Zd0DmmRcb0layuWWJdaX/OXyYmBtiCIhR2nG/l7w3AxWhAcWtf4+LHTwNKYjVUYBhqpo5yfghr7v/Ovt0f/HmOLCNpEMEoFdqChPMD6jY76ctaiBn8V+ftYxlXs4H3SkDFySaYBVgApsADnRhcGsvkx0LkchWXzRM7lDU0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789640551; c=relaxed/simple;
	bh=FMK0j1cD9oVuGtD8qu0jG7j2ZEkw1Z91TBlshXuldO0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=DaF2WHxB+1PiC73et2lFoyZnBfqh66a6JZdZUd++/NpTLeKgGL5RFi5N2QCtgKZ0PPNo2Tc0CLmf96/8aEz0wgxVgeScxAqNao9+2Tg2TNKED8aURZqKssS/wHao6XCjT/tflll6waCiv3mctX9IxC+cvNqBX6fOCaz9JD9EfqE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hgTRNkqy; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hgTRNkqy"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1789640547; x=1821176547;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=FMK0j1cD9oVuGtD8qu0jG7j2ZEkw1Z91TBlshXuldO0=;
  b=hgTRNkqy6vlq+Lfbq/ostkTv1hgwmdOobb2WtMbbaCAwEyXgYwhJ3gzZ
   eC+fLCpDbqQpzzPB4scuxeHajRIYg7+/R79LLyqJDYto4YPYEnOnPypWC
   BZzoWwU1EpWY2WBMrRp9rsl2PfS/vzdGeX8u9j38iHcdzZk2vt+GFEl3Z
   g0XvWUJt+5JlcjG7cEOl3z4PCA94UVx5+8S9YxvBpMrWm+eXDWeYUqopx
   Bq+NMmG2CgjRjjcxxkVMrOOD57rkoMsNUKgGi+VT6oJasybVA1qBkB04M
   /xI3iEYgScC5QS8ImWinjCmCLUmWwrN2xeiCNf/xeCLZkNEth+JzhKS2S
   A==;
X-CSE-ConnectionGUID: orSabg4URSaxLY3VSRXE0A==
X-CSE-MsgGUID: 4yJcNUBASR+LZSWbjozdxg==
X-IronPort-AV: E=McAfee;i="6800,10657,11905"; a="77612442"
X-IronPort-AV: E=Sophos;i="6.27,103,1787036400"; 
   d="scan'208";a="77612442"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Sep 2026 03:22:25 -0700
X-CSE-ConnectionGUID: I/BT8hxyTH2Iec9pyI32Wg==
X-CSE-MsgGUID: EZh/2oHnQSCfWKz7EtCYww==
X-ExtLoop1: 1
Received: from ubuntu.bj.intel.com ([10.238.152.72])
  by fmviesa003.fm.intel.com with ESMTP; 17 Sep 2026 03:22:22 -0700
From: Jun Miao <jun.miao@intel.com>
To: sathyanarayanan.kuppuswamy@linux.intel.com,
	rick.p.edgecombe@intel.com,
	dave.hansen@linux.intel.com,
	kas@kernel.org
Cc: linux-coco@lists.linux.dev,
	kvm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	jun.miao@intel.com
Subject: [PATCH v3] virt: tdx-guest: Use read_poll_timeout() to shorten get-quote polling interval
Date: Thu, 17 Sep 2026 18:22:02 +0800
Message-Id: <20260917102202.750895-1-jun.miao@intel.com>
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

The following get quote time via tdvmcall were obtained on the GNR.
Test case tdx-quote-generation-sample/test_tdx_attest:
Start tdx_att_get_quote concurrent loop, duration: 1 s.

| msleep_interruptible(time)| 1s       | 5ms      | 2ms      | 1ms    |
| ------------------------- | -------- | -------- | -------- |--------|
| Duration                  | 1.004 s  | 1.005 s  | 1.003 s  |1.036 s |
| Total(Get Quote)          | 2        | 201      | 451      |490     |
| Success:                  | 2        | 201      | 451      |490     |
| Failure:                  | 0        | 0        | 0        |0       |
| Avg total / 1s            | 1.03     | 200.05   | 450.05   |489.89  |
| Avg success / 1s          | 1.03     | 200.05   | 450.05   |489.89  |
| Avg total / 1s / thread   | 1.03     | 200.05   | 450.05   |489.89  |
| Avg success / 1s / thread | 1.03     | 200.05   | 450.05   |489.89  |
| Min elapsed_time          | 938.05 ms| 4.84 ms  | 1.86 ms  |1.80 ms |
| Max elapsed_time          | 938.05 ms| 5.04 ms  | 4.71 ms  |3.82 ms |

According to trace analysis, the typical execution tdvmcall get the
quote time is 1.8 ms. Therefore, 2 ms is a reasonable balance between
performance efficiency and CPU overhead.

Since it's a real issue, updating the polling interval to 2ms. Given
that deployed QEs respond fast, we should also reduce the maximum wait
time to 1 seconds (from 30 seconds) to fail faster on errors.

And compared to the previous throughput of one request per second,
the current 5ms can get 451 requests per second delivers a
451× performance improvement, which is critical for high-frequency
use cases without vsock.

So, change the 1s (MSEC_PER_SEC) -> 2ms (2 * USEC_PER_MSEC)

Suggested-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
Signed-off-by: Jun Miao <jun.miao@intel.com>
---

v1 -> v2:
 - Add "Suggested-by: Sathyanarayanan Kuppuswamy"
 - Use read_poll_timeout() from <linux/iopoll.h> to simplify the
   timeout handling instead of manual loop counters.
 - Reduce the maximum wait time to 2 seconds (from 30 seconds) to fail
   faster on errors.

v2 -> v3:
 - Reflash the test (1s 5ms 2ms 1ms) results.
 - Using read_poll_timeout() significantly shortens the wait compared with
   the previous while loop. So reduce to 2ms from the test case results.
 - Add the get quote test use case in commit:
   tdx-quote-generation-sample/test_tdx_attest

---
 drivers/virt/coco/tdx-guest/tdx-guest.c | 32 +++++++++++++++++--------
 1 file changed, 22 insertions(+), 10 deletions(-)

diff --git a/drivers/virt/coco/tdx-guest/tdx-guest.c b/drivers/virt/coco/tdx-guest/tdx-guest.c
index d0303e31e816..bac7cb9403f9 100644
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
+ * GetQuote request timeout in seconds. Expect that 1 seconds
  * is enough time for QE to respond to any Quote requests.
  */
-static u32 getquote_timeout = 30;
+static u32 getquote_timeout = 1;
 
 static long tdx_get_report0(struct tdx_report_req __user *req)
 {
@@ -251,18 +252,29 @@ static void *alloc_quote_buf(void)
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
+	 * up once per 2 milliseconds to recheck the status is fine for this use
+	 * case.
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
+				2 * USEC_PER_MSEC, timeout * USEC_PER_SEC,
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

