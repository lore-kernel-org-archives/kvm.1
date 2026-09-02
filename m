Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0B1436920D;
	Wed,  2 Sep 2026 02:44:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788317090; cv=none; b=cNrH1kcHUZ8BYdVENDKXggRjb2SpH29xZWHHBTPxTuS5nlTwcRvwMJHKPFIdyzM/Ec6kQf5Rwt5dZURRzi79t+1ZLDJiXAXIs9EieV76PWnKJtH2ChaLMMhm7LcjKnC9IhGxhJEF/bsxZ/LhdQhJEQPBLUKk5pr3b1/g3r/08wM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788317090; c=relaxed/simple;
	bh=52Zrc0GzNstnCVirbFc4z4GE6+i+UGKURtTP+/Bd2vE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ekmavUgVclqU5d3JSIvAW4GGBo567xIPkrgk0XuR+wQ9IfWhHHITk5/9kcob4C3QhD/xvAyLInemwzNmcNSiW0ONsjxmrGnTKHxkkIU9hzTEdiqL3dQXnI5+aWiiQWm0zQyPLP3S+YPr2M7z5e6L6EI9MErm6RH4Kc2OwNBHUqU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=XFF0XDdc; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="XFF0XDdc"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1788317089; x=1819853089;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=52Zrc0GzNstnCVirbFc4z4GE6+i+UGKURtTP+/Bd2vE=;
  b=XFF0XDdcbYaNLf09armn9T0YI+Bk/z6LziRsb5clLzZppqjDX/DyxbIe
   JaD/r9YA5h3LUAV3F70vJWwd5y13s25b45VhmIYRU06LNOXZM6wiwx2jX
   /e0fSx3NXzdLakN9RpD2ZrTDS9zoJnizbI9Bcs3I0Ihex54CteNVVoI3w
   KRFNMVxC51elZJmZK1ZgEDQoCVoJsa2TlR799TsrSwn89f4gWzZoUeyFk
   xLw7MV4qhWs/4kmExu/zTw6Iscgm3Ib26CD2zcc4nAFFFEjafK/Vk5095
   F7vw1MyzqiBSVgROT2JJZ4W/QDUcduZqVpkfkssXmIudoRMdRLVoVXidN
   g==;
X-CSE-ConnectionGUID: /mB+8VzATMebvDjJJQgK7A==
X-CSE-MsgGUID: wIrRQNBgTa2tYGtrmQa69A==
X-IronPort-AV: E=McAfee;i="6800,10657,11893"; a="106282913"
X-IronPort-AV: E=Sophos;i="6.25,257,1779174000"; 
   d="scan'208";a="106282913"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Sep 2026 19:44:48 -0700
X-CSE-ConnectionGUID: UMad5BZMTCiEK9g86j5c6g==
X-CSE-MsgGUID: wxcXi6OaSnGa9M9uB4TVYA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,257,1779174000"; 
   d="scan'208";a="272775504"
Received: from chang-linux-3.sc.intel.com (HELO chang-linux-3) ([172.25.66.174])
  by orviesa003.jf.intel.com with ESMTP; 01 Sep 2026 19:44:48 -0700
From: "Chang S. Bae" <chang.seok.bae@intel.com>
To: pbonzini@redhat.com,
	seanjc@google.com
Cc: kvm@vger.kernel.org,
	x86@kernel.org,
	linux-kernel@vger.kernel.org,
	chang.seok.bae@intel.com
Subject: [PATCH v7 06/20] KVM: VMX: Remove unused control-register access defines
Date: Wed,  2 Sep 2026 02:17:50 +0000
Message-ID: <20260902021804.718676-7-chang.seok.bae@intel.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260902021804.718676-1-chang.seok.bae@intel.com>
References: <20260902021804.718676-1-chang.seok.bae@intel.com>
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

