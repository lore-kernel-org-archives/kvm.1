Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98DE832E12E
	for <kvm@vger.kernel.org>; Wed, 26 Aug 2026 03:35:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787715338; cv=none; b=mDCZrPV1ZZV8nl2aOv5t7RO4IB3AxHf2clfTrLVLh9HO1juDmXBOBPgS5SM0HeVuSpWYT2lLcIa0LzI6p6/YrZYvXAQCyZ5J1Sa2cYQ6G5EAWICLQm91Yv12Mp0FgsuAsiDa1V8duOV6SqJIRf9QkPYPO5LIjAQpsPmReerQ34c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787715338; c=relaxed/simple;
	bh=TL0nsKy/oXqswhT7Lwv1p9BiWBw4zNH45YqxIkGZHLI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mGuantE4Am72SxjnxAPeAhARcdmcade4u1AsCuPTwvcJpFMj2vAQ2Js9ZEC3pjEfmY6T5HnkzoxdQpkdoLbm3zZ+F2UAhT3xUbQo8aNAtn5C0Stq/CNoiPQD3lQRRSbMNwJNCuiDd1sJPStqerHSxXkfKMNTF32TcS51PiZkr5o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Sj9AopnO; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Sj9AopnO"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1787715336; x=1819251336;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=TL0nsKy/oXqswhT7Lwv1p9BiWBw4zNH45YqxIkGZHLI=;
  b=Sj9AopnO7GJTg6DoVCeGpFR4B8FtHDl7vjJQW711JWQypEB54PycqrYR
   c4P8dMHzEvdJNTpdqmkUDkRXNWvW4o0cRaxXEU2rgaLyeK+nTFCv27B8z
   VHJ6U8aJ+yIe0SxNjbunMFfTNaMUzpCGsipSvjmqtpqjf1suuqV4+/NAI
   sgaNPEV6/s7/wuo3YZFDFEcIChq6HT5ys4AiFOmKAvH6j55yUr7I8YfKd
   Npukw4zPFzgxx5MlRnYNZ9PNKEsgCTHtOv4t0BWvPoGoEpaQwOoymUn9D
   iN3/vgmPkFxbZGpaBSYPq4Yg7zgG9V5h3LomNDhpDQA/E+QqD0PNW+GWG
   w==;
X-CSE-ConnectionGUID: LA7MuEqqS2KAfwzG+xp6cg==
X-CSE-MsgGUID: YJ9vurwJQDiaZwKvSODrFQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11886"; a="75728385"
X-IronPort-AV: E=Sophos;i="6.25,244,1779174000"; 
   d="scan'208";a="75728385"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Aug 2026 20:35:31 -0700
X-CSE-ConnectionGUID: YLyEMtjBQXCxoqDPF67y4w==
X-CSE-MsgGUID: IwedR1tATYm2ie0NB50pbQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,244,1779174000"; 
   d="scan'208";a="297364024"
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
Subject: [PATCH 5/5] target/i386: Introduce ClearwaterForest-v5 to enable LASS
Date: Tue, 25 Aug 2026 20:57:34 -0700
Message-ID: <20260826035734.114685-6-kishen.maloor@intel.com>
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

Add ClearwaterForest-v5 to expose Linear Address Space Separation (LASS)
on the ClearwaterForest CPU model.

Signed-off-by: Kishen Maloor <kishen.maloor@intel.com>
---
 target/i386/cpu.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index 167df0e6cb..1c333c2780 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -6190,6 +6190,14 @@ static const X86CPUDefinition builtin_x86_defs[] = {
                     { /* end of list */ },
                 }
             },
+            {
+                .version = 5,
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

