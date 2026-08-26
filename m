Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35BE3330650
	for <kvm@vger.kernel.org>; Wed, 26 Aug 2026 03:35:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787715337; cv=none; b=sBKxturxPkF5xVVtgA3WTo/dnAFEhbhTPGAYYoyzr3+M/4FAHJu1sZjiG+esB35U2EWdiZJTBd4QQcVCQWKRYcGWkfPPmtc8wCKmCuQOzc2yZHqAhUZzVv0XEfal9TB6rs4JmtnwkNfiRMp7SXQABt1+PUF2NsE26iHm6Om2WzY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787715337; c=relaxed/simple;
	bh=JCvozlbhtWc8/ELDOqYDJCTpu/31ARVWwhTeS6u40sA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uoRr9d/oEdKs50Ci31JyQbR9UqYBU4sYepJS4RpnMxNgc1BM8Tzb1rwFG4sSIlI3vk4MfTR6vM9N0P9CKpdg9Cp+L6Jx82s9daBBYoGP+BuF3XEMoqMXssnSmSaqyjDhDeaUbvbXaMD9YCWuoqd4HGPTw2crz190kCncwVgNd48=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=NvAD6yce; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="NvAD6yce"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1787715336; x=1819251336;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=JCvozlbhtWc8/ELDOqYDJCTpu/31ARVWwhTeS6u40sA=;
  b=NvAD6yceN2QCxSN0F9vdt6r6MYYhyTcCH7vbWDBVloJjiXwDuwiqfkYP
   BOr/F4FRe+JuFnXa9B2/zCnaJ1uJbmTzGQ6clAHYSwPr2BHM1CAj3DVC2
   bpt1nTTiF5wlprWwTdjU47CxhzWxgOLPE6vp8+9LUJh1bPuPOge7abyry
   sBYFEuhTTKmW1LoatSUT7+rGCkX/UvPw7Zo0pzq8vxiFa3oGUMsUFtOmW
   hq/JW8gbttmdU7IsfWAgX2MQ92TICMEow8iRwc9NTdIsILf0Yhm+lqvEZ
   jz75ocH+2DXlYOJi4bFirp0HL8628ADMrzFabLpAcGu859g4Uc99VDZXJ
   A==;
X-CSE-ConnectionGUID: H/Q6lbCaTNmZnRCgrkBJyg==
X-CSE-MsgGUID: rZVsJTcySVGcKu01DyD4wA==
X-IronPort-AV: E=McAfee;i="6800,10657,11886"; a="75728379"
X-IronPort-AV: E=Sophos;i="6.25,244,1779174000"; 
   d="scan'208";a="75728379"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Aug 2026 20:35:31 -0700
X-CSE-ConnectionGUID: dK+PnWOcQL6ODLi5prAxaA==
X-CSE-MsgGUID: YyzYYi5uRbO/FkhGJeKwmQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,244,1779174000"; 
   d="scan'208";a="297364017"
Received: from d404e69c8b80.jf.intel.com ([10.54.34.91])
  by orviesa002.jf.intel.com with ESMTP; 25 Aug 2026 20:35:31 -0700
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
Subject: [PATCH 3/5] target/i386: Introduce DiamondRapids-v3 to enable LASS
Date: Tue, 25 Aug 2026 20:57:32 -0700
Message-ID: <20260826035734.114685-4-kishen.maloor@intel.com>
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

Add DiamondRapids-v3 to expose Linear Address Space Separation (LASS)
on the DiamondRapids CPU model.

Signed-off-by: Kishen Maloor <kishen.maloor@intel.com>
---
 target/i386/cpu.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index 5496e9475b..fa6b76be27 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -5829,6 +5829,14 @@ static const X86CPUDefinition builtin_x86_defs[] = {
                     { /* end of list */ },
                 }
             },
+            {
+                .version = 3,
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

