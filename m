Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.175.65.15
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795457885;
	b=IL/Y6zMdx5y66dEh3f6//o7s7xgV06neyzzu84+wXrsXho8XEF8JMkFB1MKv8vX6xuYc
	 GWajnLatVF6m/UOr9RYGdl5ULxDmgjbkCqL95pWGI3LBJjaSB7yFGf3FsgAhz10tdgX/+
	 eHPMXj51p0xEgC7WyTbujRyxu+UvLm3odzqruzqEWq+XDozyNdW7DxORPs+mGfQOkOEA4
	 f8regz4T2PAFRe7xZ84EFsCnTFbAFe9RItGMck5lmI0T5Y1dCVwF12xAFOmVk4H9ETEUi
	 ODhVHBBWmWnUMUjVCdOhTKAPuLg2DFeAq52cjSZj+wr5XLMt781ksezrT+MYT4s7Saw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795457885;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=Gg+ehJ2HGC9dWPUKwLePbwD9mlm6IlQD+RPBdGpC4C4=;
	b=HcXtj/7WwfXIF8F5oLrY4s38DMhtjrM+Kg+eVvimm+gch3xYp6D/WARbO89/3VbQumBk
	 wYBzybe/k1GssYyWpmixDo+123ngZ5gjC0uK5JYka46lTm04PE83Ib9u2VD1Gj/+iC10A
	 H0Dc/v/DOx3a19jHpi/sGSX0SCbXjv66wXiEojTDRY5Ouz/bFhMXWHsbqI1whEeBHWx32
	 nh4rf9LJj7mRny362u1MIw0WxVSwvbpgTvBfAoRZ2ksiq+2Q2+nKG2IxaIsvQ3sgsDand
	 7afICXPMJ2WbQ7nGsGa9rW3ky0Q9se82kXJ8VJ4W/jQrB00+NLBlMrt9sxqHph4CSTw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=Yg1dfb+N;
	arc=none smtp.remote-ip=198.175.65.15
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24FB960A2638;
	Mon, 23 Nov 2026 18:18:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 24FB960A2638
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=Yg1dfb+N
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1795457885; x=1826993885;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=tVs1toSb8l0V5BYa07sP0WKwxQSV0Fe6SzcqIQLr7oI=;
  b=Yg1dfb+NhzA6aLRr6i0BSiA3RXqbGiAeeiDyhEmOdgpTtOklzLKjf6yU
   jDCHvXtNxv1wvmNVaE9RWiEMOzjDbj1x6WTNpN/stY0ap/Ip9BXoZSXwR
   IY7m/ZDNlJiCv1REVNk3ZBq9q4AwJ+yr3uzhddHdZr5dWfQVwJWtAb9RA
   JD6k6wU4vEfmlxzgMirrkg5T1MmOI8MmRtA9lWIM1aXpT3SS4ylcMb485
   LBZT2rkPWYPo3jwfxFz5+DRfzwdJuQYohlSdd860f2tuEuN9g3GKcPdaj
   0NOAl3+EjFzGon0riKvopV0xy+p23jRLmQWhQF95m0qm1CrNLyHBUeOKw
   A==;
X-CSE-ConnectionGUID: Vg0cS1uZSGig3pND5PJDvQ==
X-CSE-MsgGUID: LnFWXH27TWi9AiKVOEbpEg==
X-IronPort-AV: E=McAfee;i="6800,10657,11975"; a="4288804"
X-IronPort-AV: E=Sophos;i="6.27,229,1787036400"; 
   d="scan'208";a="4288804"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Nov 2026 10:05:15 -0800
X-CSE-ConnectionGUID: CNHjlh6cS6SwWTy8pG4jcA==
X-CSE-MsgGUID: e5e4A6LGQ1iIs3VVB3e/Iw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,229,1787036400"; 
   d="scan'208";a="11241096"
Received: from chang-linux-3.sc.intel.com (HELO chang-linux-3) ([172.25.66.174])
  by orviesa004.jf.intel.com with ESMTP; 23 Nov 2026 10:05:15 -0800
From: "Chang S. Bae" <chang.seok.bae@intel.com>
To: seanjc@google.com,
	jmattson@google.com
Cc: pbonzini@redhat.com,
	kvm@vger.kernel.org,
	x86@kernel.org,
	linux-kernel@vger.kernel.org,
	zhao1.liu@intel.com,
	chang.seok.bae@intel.com
Subject: [PATCH v10 07/20] KVM: VMX: Remove unused control-register access defines
Date: Mon, 23 Nov 2026 17:37:19 +0000
Message-ID: <20261123173732.1072124-8-chang.seok.bae@intel.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261123173732.1072124-1-chang.seok.bae@intel.com>
References: <20261123173732.1072124-1-chang.seok.bae@intel.com>
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

CONTROL_REG_ACCESS_REG becomes misleading with EGPRs. Rather than leave
stale, unused definitions behind, remove them all.

Signed-off-by: Chang S. Bae <chang.seok.bae@intel.com>
Reviewed-by: Jim Mattson <jmattson@google.com>
---
 arch/x86/include/asm/vmx.h | 19 -------------------
 1 file changed, 19 deletions(-)

diff --git a/arch/x86/include/asm/vmx.h b/arch/x86/include/asm/vmx.h
index e49b836c7313..def6d3a6d154 100644
--- a/arch/x86/include/asm/vmx.h
+++ b/arch/x86/include/asm/vmx.h
@@ -453,27 +453,8 @@ enum vmcs_field {
 /*
  * Exit Qualifications for MOV for Control Register Access
  */
-#define CONTROL_REG_ACCESS_NUM          0x7     /* 2:0, number of control reg.*/
-#define CONTROL_REG_ACCESS_TYPE         0x30    /* 5:4, access type */
-#define CONTROL_REG_ACCESS_REG          0xf00   /* 10:8, general purpose reg. */
 #define LMSW_SOURCE_DATA_SHIFT 16
 #define LMSW_SOURCE_DATA  (0xFFFF << LMSW_SOURCE_DATA_SHIFT) /* 16:31 lmsw source */
-#define REG_EAX                         (0 << 8)
-#define REG_ECX                         (1 << 8)
-#define REG_EDX                         (2 << 8)
-#define REG_EBX                         (3 << 8)
-#define REG_ESP                         (4 << 8)
-#define REG_EBP                         (5 << 8)
-#define REG_ESI                         (6 << 8)
-#define REG_EDI                         (7 << 8)
-#define REG_R8                         (8 << 8)
-#define REG_R9                         (9 << 8)
-#define REG_R10                        (10 << 8)
-#define REG_R11                        (11 << 8)
-#define REG_R12                        (12 << 8)
-#define REG_R13                        (13 << 8)
-#define REG_R14                        (14 << 8)
-#define REG_R15                        (15 << 8)
 
 /*
  * Exit Qualifications for MOV for Debug Register Access
-- 
2.53.0

