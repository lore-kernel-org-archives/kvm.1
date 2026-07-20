Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EAF74499A6;
	Mon, 20 Jul 2026 17:46:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784569579; cv=none; b=MKfORQ6/mzcoXt+VSRW6GUQMPVBvBUWwYg1Y+eY12D19G4inU+C5eIXIhIAZH8yFoP+2XtWA40aJulDtRSpnKpfjxhLxh09H+Nqsu+W72ur8lil6Oi/tVU8h0+W+PNb4TqO1OArRo24+dq9S6MpQtYd5EO/B8c0ArTTW05miVv0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784569579; c=relaxed/simple;
	bh=RccZqAU7DsjT2BnjXuB9JQRn+cgJksFm9RQr9cHY5do=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mmDAIvYckpYWR7GQpNkYVVfOpdY41Xnyd7F2DZPulGsRwfI4MQpWvixmphqDVkl1yl7qOhSdkNLSlj84jlkkShs07WhmmCtXfzYyYWv3IY7kEllPNvHw3/pGcx7JC7b4QEgUzqSmvKidJdtUDG08wRPzTidbnU/ymPAKJwsHGPc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=BniZSHTD; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="BniZSHTD"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1784569574; x=1816105574;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=RccZqAU7DsjT2BnjXuB9JQRn+cgJksFm9RQr9cHY5do=;
  b=BniZSHTDy5Hjg+Wjj6nfXRNTmABzwMyFIgsAUcE5Kgtzl8pZ4o715tuI
   J6pmO/L+68N247VSs48rR+F2KYrOGZt0MVyXOnj5C2dU82MjrrBxIJSvn
   m/iwGtj90moEgpSQEbf/bz+Eg6Ho8JdICfV6QamdPYI3obeWbAzuGmHsb
   k8LBDaLCiAoCIqC3qTLD+zDYxhURQdDt9ptDPEZHPYBqxoCLm7NnGtKZd
   Je3s5zvCaBzP4VR88sllViaIY1wKx/A4x6NYtRo2AJOpG7qdu8cn3MwTJ
   Ft7a459KbU36/wI798ULm4ZPTr+DfdYGkSQQ/EnVnQcBhz0j+p5MQxvLs
   Q==;
X-CSE-ConnectionGUID: eXhQxQvPSB+LtJ9x7S4cRA==
X-CSE-MsgGUID: a9t1/KL9R0GiAQ3d7k1D6w==
X-IronPort-AV: E=McAfee;i="6800,10657,11852"; a="72691656"
X-IronPort-AV: E=Sophos;i="6.25,175,1779174000"; 
   d="scan'208";a="72691656"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jul 2026 10:46:02 -0700
X-CSE-ConnectionGUID: xriCJnXXQ6u0+hY+2tPoBw==
X-CSE-MsgGUID: 9JwKUzuxQ5STwsGHhQe78g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,175,1779174000"; 
   d="scan'208";a="257575353"
Received: from chang-linux-3.sc.intel.com (HELO chang-linux-3) ([172.25.66.174])
  by orviesa007.jf.intel.com with ESMTP; 20 Jul 2026 10:46:01 -0700
From: "Chang S. Bae" <chang.seok.bae@intel.com>
To: pbonzini@redhat.com,
	seanjc@google.com
Cc: kvm@vger.kernel.org,
	x86@kernel.org,
	linux-kernel@vger.kernel.org,
	chang.seok.bae@intel.com
Subject: [PATCH v5 06/20] KVM: VMX: Remove unused control-register access defines
Date: Mon, 20 Jul 2026 17:19:35 +0000
Message-ID: <20260720171949.498680-7-chang.seok.bae@intel.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260720171949.498680-1-chang.seok.bae@intel.com>
References: <20260720171949.498680-1-chang.seok.bae@intel.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

CONTROL_REG_ACCESS_REG becomes misleading with EGPRs. Rather than leave
stale, unused definitions behind, remove them all.

Signed-off-by: Chang S. Bae <chang.seok.bae@intel.com>
---
V4 -> V5: New patch

When looking around DEBUG_REG_ACCESS_REG() for the next patch, this dead
code was discovered.
---
 arch/x86/include/asm/vmx.h | 19 -------------------
 1 file changed, 19 deletions(-)

diff --git a/arch/x86/include/asm/vmx.h b/arch/x86/include/asm/vmx.h
index ed2ded531e55..30cf48e1c390 100644
--- a/arch/x86/include/asm/vmx.h
+++ b/arch/x86/include/asm/vmx.h
@@ -444,27 +444,8 @@ enum vmcs_field {
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

