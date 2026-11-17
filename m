Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.175.65.12
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794940324;
	b=vfC7hbKUXqrA7deue4qJ8ryIH1SDwbHPZq2rjLVr5QLQp64wjbKEylzR9VHhFEjRWb+n
	 fM6Dh9oaCrzdozSFbv4g+/vCirJJ2fuUqNiZfa63FOPbWhRETNkVyyni5YqgISB8axGNz
	 E4lOzaHBGTXa0afVjKnEewtKtv7ENP4a79P/Oa5jWu+YcN0IY902lhLdGUeUB2WqRWlIB
	 1JlQV7dNmiRC2q18QycmrIJTHqSeSOHNgL5rvS/5zNAjtXQzooQ7RjZaXcjn3lEbFPmiG
	 5QwEdc7xskB7HekqeSOO0k2PzJ0fRJiSQbTlZs4OWBdK7AUO7rnKYrUUZLMtd9NcflA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794940324;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=Gg+ehJ2HGC9dWPUKwLePbwD9mlm6IlQD+RPBdGpC4C4=;
	b=onVmmTQUwIMfwn+VpBufdCGK3N1F9r/Qa7h23SuRfFR80BTIRaIfOdOWEaY/kSkEIr0B
	 Fwi3BZV92JGdZ81vLVKbb+gopQIDVrWenq8Suyeh8dbl9i2CQQez4T3FFB+wbm8JCihJc
	 ZGgeKQcX8usomSuDB1yx0NAYB3dqOfCUBYX50uYG6ofZ9fJ+PgD+JbuouRNeuEyAfpUak
	 3fvbG+egEGKKkXWK9aLMSbvnKE5t684dauoy4gSJsmPmVMKyjHyCIlBZUSJCO63/WGgqz
	 hX0Ezha6mLjr4foyRZGHXzpn+gBnz+Rq+IE+9Uh570VlcfjEDVcA2jERpR2D9XhD5AQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=k2N5dyzZ;
	arc=none smtp.remote-ip=198.175.65.12
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E45560A383F;
	Tue, 17 Nov 2026 18:32:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6E45560A383F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=k2N5dyzZ
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1794940324; x=1826476324;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=tVs1toSb8l0V5BYa07sP0WKwxQSV0Fe6SzcqIQLr7oI=;
  b=k2N5dyzZALt9ZZ/Dsyfj6dVC1REU3GbC4EMhYZ2Lwxsp8kdMFfV0thms
   GdEq9gnCZjQBwh+6kP+je++ob/r88RFFLVcQzfpgMtbtsNK3DkRsxxnvE
   0MbcaTd7zF0OROtocl1ocdb+/CZ4jnuSZ9Xt9p8nm8kL03OqTAUHal0DN
   SmpHIjho45uypCr+wqA4Ydm2nAFgwH+yoG0WiRmju0Nj1ZYhsyqlSGKJX
   sd3IM6OPF2KITZEGcWSJuq+stT9/8CdEf3GPiPYTSuLZnUUh1n+Jhhdrh
   1OLgUySQbpumvo+TDAgh5AEJBik5Qm9TIyZ+wOLVolY1Ie5JAG2IT1U67
   g==;
X-CSE-ConnectionGUID: DbuW7ATiR1C8Rywp6F6tFw==
X-CSE-MsgGUID: xB5vBwXJQV+vlA4KpjnSfg==
X-IronPort-AV: E=McAfee;i="6800,10657,11969"; a="3607273"
X-IronPort-AV: E=Sophos;i="6.27,218,1787036400"; 
   d="scan'208";a="3607273"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Nov 2026 10:30:50 -0800
X-CSE-ConnectionGUID: wgC2QjPqT2GbbzFtf1m4DA==
X-CSE-MsgGUID: 9QPHxLH4Qiu4m8nZRLz11A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,218,1787036400"; 
   d="scan'208";a="9775043"
Received: from chang-linux-3.sc.intel.com (HELO chang-linux-3) ([172.25.66.174])
  by orviesa003.jf.intel.com with ESMTP; 17 Nov 2026 10:30:50 -0800
From: "Chang S. Bae" <chang.seok.bae@intel.com>
To: seanjc@google.com,
	jmattson@google.com
Cc: pbonzini@redhat.com,
	kvm@vger.kernel.org,
	x86@kernel.org,
	linux-kernel@vger.kernel.org,
	zhao1.liu@intel.com,
	chang.seok.bae@intel.com
Subject: [PATCH v9 07/20] KVM: VMX: Remove unused control-register access defines
Date: Tue, 17 Nov 2026 18:02:57 +0000
Message-ID: <20261117180310.921701-8-chang.seok.bae@intel.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261117180310.921701-1-chang.seok.bae@intel.com>
References: <20261117180310.921701-1-chang.seok.bae@intel.com>
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

