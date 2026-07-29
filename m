Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 555443C584E;
	Wed, 29 Jul 2026 19:43:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785354218; cv=none; b=uKPXgNdsi1D3tBrchSYvhYdISOVfnk+sT/Am0bpHcW8xSqfroLquuvnoRQrYKjdWL7tPpdG64oA3CzprU3HFf9v2sJghEBGxBnMB98TTdn4pmYoc8BsWqBw/gVH6wk78EcypVRfbG3JkZpwvdL2h1F1aKGQo5Qg2Um4+Uj5DmeQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785354218; c=relaxed/simple;
	bh=RccZqAU7DsjT2BnjXuB9JQRn+cgJksFm9RQr9cHY5do=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=E2QU8NGSMXUXW8wyYqsQ0T0RWF70P5OUpaE7bvJLJecLH3/CUIDb3clTyBYoXPQpPn5kqfMKRKGGTm4vCXvse6kpEpdn+iVXSnGsqO7puWIbSccdfiz3qZ6bVJ+UV3lNEdXm+c5+iJG8KnpZbjInEKR3qrI7pFtQBsyERuvRjvE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Qp6Frifp; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Qp6Frifp"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1785354212; x=1816890212;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=RccZqAU7DsjT2BnjXuB9JQRn+cgJksFm9RQr9cHY5do=;
  b=Qp6Frifpmvy7/ZdLcXa1qj/FHVyskBt1jlzihFeDRJkiCTIVZPKmt3iC
   AGeioCbuU2N8gvV7SsvnqaSZJt7uHlXKvMllk4erI/vWFQQOdTuB3LOWc
   H84lPx2XwObAEJJUNu9e+TzREZjAcmDQqKjCVe31AIk8YozmkK4KA1wiE
   gjOCTzsNDvQwYi06UhRIxsNN6pUHV1n7W/tArrgb+mXTEbRbPUZGSpb94
   ypKsLtUEoxPkpNZTU2t/PbvOoTOYKXSzhYR6hZBFqvS+3KEuBebEJUvGE
   n8rGclaAOybq7HykynSQSWUwgNUrslBW5J64zvYbZIZtZY+uJ/hEAfLtn
   g==;
X-CSE-ConnectionGUID: B7jCaEYNQkeIPgoNCPFWow==
X-CSE-MsgGUID: LtrEOdGuQq+duTmdr0Zy+g==
X-IronPort-AV: E=McAfee;i="6800,10657,11859"; a="103508260"
X-IronPort-AV: E=Sophos;i="6.25,193,1779174000"; 
   d="scan'208";a="103508260"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jul 2026 12:43:22 -0700
X-CSE-ConnectionGUID: eE8rKsDRRI6I43LwA03kJA==
X-CSE-MsgGUID: /2oJn/9TR/C6J+LGT9y7hg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,193,1779174000"; 
   d="scan'208";a="256769237"
Received: from chang-linux-3.sc.intel.com (HELO chang-linux-3) ([172.25.66.174])
  by fmviesa007.fm.intel.com with ESMTP; 29 Jul 2026 12:43:22 -0700
From: "Chang S. Bae" <chang.seok.bae@intel.com>
To: pbonzini@redhat.com,
	seanjc@google.com
Cc: kvm@vger.kernel.org,
	x86@kernel.org,
	linux-kernel@vger.kernel.org,
	chang.seok.bae@intel.com
Subject: [PATCH v6 06/20] KVM: VMX: Remove unused control-register access defines
Date: Wed, 29 Jul 2026 19:16:42 +0000
Message-ID: <20260729191656.598771-7-chang.seok.bae@intel.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260729191656.598771-1-chang.seok.bae@intel.com>
References: <20260729191656.598771-1-chang.seok.bae@intel.com>
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

