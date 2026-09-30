Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86C2A51EE1E;
	Wed, 30 Sep 2026 21:35:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790804102; cv=none; b=P1KjAUg4supg1druiBybhdTVAGVzMT0B6ymmQs0z0iMecm5BlY452GiuZlZDwwycjB3SxF+aeJw8qpG2b9AuaeheXgcWONxhC+sRjLyg8vmydCQVggjUpyyDgq1CytzKmvT+x6zHa+6t+kZVIalxN73Hvn1705nYze64q6gGYFU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790804102; c=relaxed/simple;
	bh=52Zrc0GzNstnCVirbFc4z4GE6+i+UGKURtTP+/Bd2vE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SsA7QgM4wFnjQkO+rq4sQnMxoM+0QdpX3sIq3J/rXcvZ8C7T2uuK5wDswQLQJOEWmWj5Ed0h9s1Ynjx0otUnP1ceXOTNbCVb4bCrxf2tM0KiqvqwcjWz7Fs/QjvUaDNN2qyaz0U5C67p4L/dinZGgI+zFRuAp8q5pUelKoXAyuY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ZW8jBC2g; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ZW8jBC2g"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1790804100; x=1822340100;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=52Zrc0GzNstnCVirbFc4z4GE6+i+UGKURtTP+/Bd2vE=;
  b=ZW8jBC2gluejUE/mXW2TEM+1AOOxRvTgMl/D1kut1ssJpZyNEuYjtDyt
   4xMB1m/xHFGWFOPYQ8cnpkntyGi1olPL22nfOPuPDJeuLdYT3nf9h2fkz
   4+boECiCKVng9gTK7DPeA8aujVGNdDGR+koTrWuoK5neFzUhqn6oN5WGG
   8QogA1ZceuPzLcdRp3Plum6/d2iyzL1ncYiUywAjq3d7SEJqBJ3hMm3Kp
   gkR7AQLC/d5G4SYjZpEi/ked6mRiowk0ozwpFtsQIypQuamAYenUe4pHv
   ncbhnEMZ+MJvVt3nDy+7xBRiscuhZpf3l0FdzmfdcGDtM97ZmLcet7uYg
   Q==;
X-CSE-ConnectionGUID: g47VY34eSca2nlRQMVmvrA==
X-CSE-MsgGUID: VO/OgcZATNuySJVwjdOtUQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11921"; a="94432678"
X-IronPort-AV: E=Sophos;i="6.27,133,1787036400"; 
   d="scan'208";a="94432678"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Sep 2026 14:35:00 -0700
X-CSE-ConnectionGUID: E54/tDAtQF62QwcJXxVOog==
X-CSE-MsgGUID: 3fq5iF+9QNaw3mvk20sRbg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,133,1787036400"; 
   d="scan'208";a="283867225"
Received: from chang-linux-3.sc.intel.com (HELO chang-linux-3) ([172.25.66.174])
  by fmviesa005.fm.intel.com with ESMTP; 30 Sep 2026 14:35:00 -0700
From: "Chang S. Bae" <chang.seok.bae@intel.com>
To: pbonzini@redhat.com,
	seanjc@google.com
Cc: kvm@vger.kernel.org,
	x86@kernel.org,
	linux-kernel@vger.kernel.org,
	zhao1.liu@intel.com,
	chang.seok.bae@intel.com
Subject: [PATCH v8 06/20] KVM: VMX: Remove unused control-register access defines
Date: Wed, 30 Sep 2026 21:07:36 +0000
Message-ID: <20260930210750.1487547-7-chang.seok.bae@intel.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260930210750.1487547-1-chang.seok.bae@intel.com>
References: <20260930210750.1487547-1-chang.seok.bae@intel.com>
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
 arch/x86/include/asm/vmx.h | 19 -------------------
 1 file changed, 19 deletions(-)

diff --git a/arch/x86/include/asm/vmx.h b/arch/x86/include/asm/vmx.h
index 3f1b3096ff04..68835ad9af71 100644
--- a/arch/x86/include/asm/vmx.h
+++ b/arch/x86/include/asm/vmx.h
@@ -445,27 +445,8 @@ enum vmcs_field {
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

