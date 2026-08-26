Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35B0032B989
	for <kvm@vger.kernel.org>; Wed, 26 Aug 2026 03:35:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787715338; cv=none; b=bb5L5zZ/ytehT08hq0sycqx9gcYz2Q9yfK9HaxTpLp134QXRxvzyfcXiHum2dwOReiHlPYQRFtsz3M43JH0+Xg7vaENjb9jJ6n9emt715EBBgS/l+qjwE6auvCGWimktjs0jHVdaB99oc66QHXJtGi2RdbpEQN0wtxEXO6cqSw4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787715338; c=relaxed/simple;
	bh=fIqB/q6xq21Itqsn2ztBWJFiSntXIZKCsqRrTY+RK/U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oZlOSVx3HVzjn3suV8+0+CAfhnAo5hnLtHHSSP9Vz7p4XC0P8iHegOx1bDzRJC77VhMOq4eRIR4KJkLyFZehEdiCo6YZEVuU/lOiA90883BLgeMrbTgukHEdgkNCWumqMuhLCgAR1+2cMayJ0RhMzSw4H11WUkbniLSTfhrmp+0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ZL17NlmI; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ZL17NlmI"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1787715336; x=1819251336;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=fIqB/q6xq21Itqsn2ztBWJFiSntXIZKCsqRrTY+RK/U=;
  b=ZL17NlmIlZevCleAKJb1VGmwFikYe6eOl9XHWJcnArev47Tx5OaQfS3T
   7tR6Wj0g0FMqKUucJeUbVCzJldIRPfUST0IRxeep4PM9oZax6S14vR1y+
   isbGS8W7GnTz97562C9wfcR2kuaCz0eP008hrCIBsAppCddagfKdYjK9Y
   VbaGPG9xlF/fbcp20LRSsMTUhL3M8a+ey85mTXI64fR6LeyjrJ1SY2fPZ
   UzThp5yxMsIm9LGDgMB+HC1y8rqMBQY9QH7cVM4NbjEom+pcYrUVXqOWu
   s6z2IBZdJ6YFCOwOrvn3mAFuyEoe3BWnbIG7Sjxmrw29r0Zjx53RMMZMQ
   A==;
X-CSE-ConnectionGUID: XrzSJPDDQQi0RvaY+OizdA==
X-CSE-MsgGUID: u/L2qWNESf6uHf4vyxuElw==
X-IronPort-AV: E=McAfee;i="6800,10657,11886"; a="75728382"
X-IronPort-AV: E=Sophos;i="6.25,244,1779174000"; 
   d="scan'208";a="75728382"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Aug 2026 20:35:31 -0700
X-CSE-ConnectionGUID: V0DeUYCfThqt7OfqTVKgCg==
X-CSE-MsgGUID: t4X+5MgxRVuHTSLeJg+vSA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,244,1779174000"; 
   d="scan'208";a="297364020"
Received: from d404e69c8b80.jf.intel.com ([10.54.34.91])
  by orviesa002.jf.intel.com with ESMTP; 25 Aug 2026 20:35:32 -0700
From: Kishen Maloor <kishen.maloor@intel.com>
To: qemu-devel@nongnu.org
Cc: pbonzini@redhat.com,
	zhao1.liu@intel.com,
	kvm@vger.kernel.org,
	sohil.mehta@intel.com,
	xiaoyao.li@intel.com,
	binbin.wu@linux.intel.com,
	farrah.chen@intel.com,
	kishen.maloor@intel.com
Subject: [PATCH 4/5] target/i386: Introduce SierraForest-v7 to enable LASS
Date: Tue, 25 Aug 2026 20:57:33 -0700
Message-ID: <20260826035734.114685-5-kishen.maloor@intel.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20260826035734.114685-1-kishen.maloor@intel.com>
References: <20260826035734.114685-1-kishen.maloor@intel.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add SierraForest-v7 to expose Linear Address Space Separation (LASS)
on the SierraForest CPU model.

Signed-off-by: Kishen Maloor <kishen.maloor@intel.com>
---
 target/i386/cpu.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index fa6b76be27..167df0e6cb 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -6018,6 +6018,14 @@ static const X86CPUDefinition builtin_x86_defs[] = {
                     { /* end of list */ },
                 }
             },
+            {
+                .version = 7,
+                .note = "with LASS",
+                .props = (PropValue[]) {
+                    { "lass", "on" },
+                    { /* end of list */ },
+                }
+            },
             { /* end of list */ },
         },
     },
-- 
2.47.1

