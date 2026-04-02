Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E255B273D6D;
	Thu,  2 Apr 2026 06:32:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775111540; cv=none; b=sbPRI/85f02uA/dhrzbcpwZg5/7uRmTujKrlC3sLi3cQpTWEcgORgwoWCS+AqgupugkML+Mec0QjRIBCOfAIcLISHP/KXEoLRWpzLFXUC6XqhJLmeUXy9/G8omjMeFZ4/E8Qfiam/FuvqI/VYZi85mitxHkkfSlFfWNpJr15vAk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775111540; c=relaxed/simple;
	bh=Y7Ua1tTxbyu3RHHfvSbNLGU41KLjM+Y+DPVJVkjgAKU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Pkl745zK491vGuxTlDSm5y/oE4ka/tlEvlCZ9NTU0nNaisSg+x1qAkfJjYJ4EN1Sv89OkteYiJAUrAjV35SiWJ5988fUjmmVrh8FWSJD3aRPC/NXMIYod+8Tzer/rZ2bPGGrkJhHXakm0Bx32tjyWJZzTtq75kOcS05LZAYuVEc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=na9thpgf; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="na9thpgf"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1775111539; x=1806647539;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=Y7Ua1tTxbyu3RHHfvSbNLGU41KLjM+Y+DPVJVkjgAKU=;
  b=na9thpgfs5gNd964KVcvZfjAnQW5MDz+CBBVvsIelQ5HAb8OGbzW0p3K
   AYqasecmgteQ/22IaF/9Bm3/yIHAiq0KicCL93/uHlRMXrChJxkU1CCk4
   Dt3Zi3cJK2nEbI9sPp/cZVLidxQS7zgxXP+ndcPoC49GEMWahhgRlRZxm
   S5SeqrDubiv6BGFcGKPpJOS/HPTBgpuWF1WdMfFyUY6ks3x4TENTahB2d
   k1ISVcAQrx7uuA/K8QpHaq2is3/73/NglllXwZ8uQ2zl6rRXyzkl6KGG1
   Yp5cBxNWpwkELNgJjQ7rtGWQ5BNqSOM+5gV92MFpt8+n+ita/COGQ39Dy
   g==;
X-CSE-ConnectionGUID: f2ZkYrKZQqq8+b33YyBGuw==
X-CSE-MsgGUID: dufkjK/WR0eOyDP3oTRVaw==
X-IronPort-AV: E=McAfee;i="6800,10657,11746"; a="75884370"
X-IronPort-AV: E=Sophos;i="6.23,155,1770624000"; 
   d="scan'208";a="75884370"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Apr 2026 23:32:18 -0700
X-CSE-ConnectionGUID: ZkgXaa7nQuGfvTrmMZCHYQ==
X-CSE-MsgGUID: J3i6E2J0RI+jehS8/ngL1g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,155,1770624000"; 
   d="scan'208";a="222042377"
Received: from vverma7-desk1.amr.corp.intel.com (HELO [192.168.1.200]) ([10.124.223.130])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Apr 2026 23:32:17 -0700
From: Vishal Verma <vishal.l.verma@intel.com>
Date: Thu, 02 Apr 2026 00:32:01 -0600
Subject: [PATCH v3 1/5] x86/tdx: Move TDX architectural error codes into
 <asm/shared/tdx_errno.h>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260402-fuller_tdx_kexec_support-v3-1-34438d7094bf@intel.com>
References: <20260402-fuller_tdx_kexec_support-v3-0-34438d7094bf@intel.com>
In-Reply-To: <20260402-fuller_tdx_kexec_support-v3-0-34438d7094bf@intel.com>
To: Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, 
 Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, 
 x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>, 
 Kiryl Shutsemau <kas@kernel.org>, 
 Rick Edgecombe <rick.p.edgecombe@intel.com>, 
 Sean Christopherson <seanjc@google.com>, 
 Paolo Bonzini <pbonzini@redhat.com>
Cc: linux-kernel@vger.kernel.org, linux-coco@lists.linux.dev, 
 kvm@vger.kernel.org, Vishal Verma <vishal.l.verma@intel.com>, 
 Chao Gao <chao.gao@intel.com>, Kiryl Shutsemau <kas@kernel.org>, 
 Kiryl Shutsemau <kas@kernel.org>
X-Mailer: b4 0.16-dev-ad80c
X-Developer-Signature: v=1; a=openpgp-sha256; l=2852;
 i=vishal.l.verma@intel.com; h=from:subject:message-id;
 bh=agfGwcrJeqkoZjgG7fo/o/bPRZsU/u//ymwQrBtXti4=;
 b=owGbwMvMwCXGf25diOft7jLG02pJDJnneAuEPP3evk44muz+/Zce24r+Xd16ivJPI21aJvNU8
 qaKRgh2lLIwiHExyIopsvzd85HxmNz2fJ7ABEeYOaxMIEMYuDgFYCJTFBgZTpwxuC/6uzjEgvEB
 +6aKgrmxu/ZPmCY79SWzwg6pXZNefmD47zntf8Btrd6jG861PxZI9lZbefF/x9RTp7v3iN6ee+l
 VFDsA
X-Developer-Key: i=vishal.l.verma@intel.com; a=openpgp;
 fpr=F8682BE134C67A12332A2ED07AFA61BEA3B84DFF

From: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>

Today there are two separate locations where TDX error codes are defined:

  arch/x86/include/asm/tdx.h
  arch/x86/kvm/vmx/tdx_errno.h

They have some overlap that is already defined similarly. Reduce the
duplication by unifying the architectural error codes at:

  asm/shared/tdx_errno.h

...and update the headers that contained the duplicated definitions to
include the new unified header.

"asm/shared" is used for sharing TDX code between the early compressed
code and the normal kernel code. While the compressed code for the guest
doesn't use these error code header definitions today, it does make the
types of calls that return the values they define. So place the defines in
"shared" location so that it can, but leave such cleanups for future
changes.

[Rick: enhance log]
[Vishal: reduce to a simple move of architectural defines only]
Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Signed-off-by: Rick Edgecombe <rick.p.edgecombe@intel.com>
Signed-off-by: Vishal Verma <vishal.l.verma@intel.com>
Reviewed-by: Chao Gao <chao.gao@intel.com>
---
 arch/x86/include/asm/shared/tdx.h                    | 1 +
 arch/x86/{kvm/vmx => include/asm/shared}/tdx_errno.h | 7 +++----
 arch/x86/kvm/vmx/tdx.h                               | 1 -
 3 files changed, 4 insertions(+), 5 deletions(-)

diff --git a/arch/x86/include/asm/shared/tdx.h b/arch/x86/include/asm/shared/tdx.h
index 8bc074c8d7c6..6a1646fc2b2f 100644
--- a/arch/x86/include/asm/shared/tdx.h
+++ b/arch/x86/include/asm/shared/tdx.h
@@ -4,6 +4,7 @@
 
 #include <linux/bits.h>
 #include <linux/types.h>
+#include <asm/shared/tdx_errno.h>
 
 #define TDX_HYPERCALL_STANDARD  0
 
diff --git a/arch/x86/kvm/vmx/tdx_errno.h b/arch/x86/include/asm/shared/tdx_errno.h
similarity index 92%
rename from arch/x86/kvm/vmx/tdx_errno.h
rename to arch/x86/include/asm/shared/tdx_errno.h
index 6ff4672c4181..3c1e8ce716e3 100644
--- a/arch/x86/kvm/vmx/tdx_errno.h
+++ b/arch/x86/include/asm/shared/tdx_errno.h
@@ -1,8 +1,7 @@
 /* SPDX-License-Identifier: GPL-2.0 */
 /* architectural status code for SEAMCALL */
-
-#ifndef __KVM_X86_TDX_ERRNO_H
-#define __KVM_X86_TDX_ERRNO_H
+#ifndef _ASM_X86_SHARED_TDX_ERRNO_H
+#define _ASM_X86_SHARED_TDX_ERRNO_H
 
 #define TDX_SEAMCALL_STATUS_MASK		0xFFFFFFFF00000000ULL
 
@@ -37,4 +36,4 @@
 #define TDX_OPERAND_ID_SEPT			0x92
 #define TDX_OPERAND_ID_TD_EPOCH			0xa9
 
-#endif /* __KVM_X86_TDX_ERRNO_H */
+#endif /* _ASM_X86_SHARED_TDX_ERRNO_H */
diff --git a/arch/x86/kvm/vmx/tdx.h b/arch/x86/kvm/vmx/tdx.h
index b5cd2ffb303e..ac8323a68b16 100644
--- a/arch/x86/kvm/vmx/tdx.h
+++ b/arch/x86/kvm/vmx/tdx.h
@@ -3,7 +3,6 @@
 #define __KVM_X86_VMX_TDX_H
 
 #include "tdx_arch.h"
-#include "tdx_errno.h"
 
 #ifdef CONFIG_KVM_INTEL_TDX
 #include "common.h"

-- 
2.53.0

