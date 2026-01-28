Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC0A62DECBD
	for <kvm@vger.kernel.org>; Wed, 28 Jan 2026 23:17:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769642259; cv=none; b=eII7EtuegZ3P9/2ys4FECsP1e8usuL19zwlqdoZj/yvv0KW6ov4EYtqoj2MVuc1KN1SM0MsNuYeemGewbc2FdCZiQg0HWri0k76PcEtfRyX8/aKBedwwBBEWC9i6Rsweix9aLvzEM8oCNSQbVNtCa+yLAEcqDvoNeh6ocAFZUes=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769642259; c=relaxed/simple;
	bh=cDOJd1yKGHPrdejhdewjiE4LxByY8+m66Yja9TVYMFo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZBwqJxau6bfpLbv9/BndniJqTrl5uNplI5mEzf4HI17PhvPOb71u0r0H/Zdd/Mx57gkjfADNJUbET8BCahrXSBgNhWgvQAhZ3YBIxNUWxpjdPH7MK1mIc5/RY7rKBTASsA0zEPZuThAK9961vKkW+xAfz4UGG1St07bx4h8TCtI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=AT7cy+Ar; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="AT7cy+Ar"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1769642259; x=1801178259;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=cDOJd1yKGHPrdejhdewjiE4LxByY8+m66Yja9TVYMFo=;
  b=AT7cy+ArPtK4osgKJtxIlO6za0ufgc19WTMU8aZud49eohYyU/vwhdqp
   8Q2skz/1/lG3fyclHiDmJ+d0DWwmqEB1dqfJyLQ6tOPc34FMDM3KoN/9Z
   P5FvKZWR/gEhTdMT1IbHqUUZTSBYou+Bu7DhUD9Ort5VfUEH6ceYcrghM
   CUXMlGPxYBecTzwESJW7ZLmfWyaLbv+JwfkllXRVGaXNti8Bnk53XbQcE
   ZhALoGPoa67P4TSqQrgo78OhqhCjnjEn4U30UswqSGCBprtvz1NE7+DB3
   Qvyc2lihNMppMAABHzHFvjhasX4OsFG0svG3URn+Bnv9SrlR07KiixEPd
   w==;
X-CSE-ConnectionGUID: 5j4FtGVtRHOUdZQOI/UQrA==
X-CSE-MsgGUID: LjDWngmBTh6/2AjjJ3F57A==
X-IronPort-AV: E=McAfee;i="6800,10657,11685"; a="73462309"
X-IronPort-AV: E=Sophos;i="6.21,258,1763452800"; 
   d="scan'208";a="73462309"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jan 2026 15:17:37 -0800
X-CSE-ConnectionGUID: thiR9T5xQ02UQxzDyTEXYA==
X-CSE-MsgGUID: BuWH7TluS5mABVm+PPRu5A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,258,1763452800"; 
   d="scan'208";a="208001760"
Received: from 9cc2c43eec6b.jf.intel.com ([10.54.77.43])
  by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jan 2026 15:17:36 -0800
From: Zide Chen <zide.chen@intel.com>
To: qemu-devel@nongnu.org,
	kvm@vger.kernel.org,
	Paolo Bonzini <pbonzini@redhat.com>,
	Zhao Liu <zhao1.liu@intel.com>,
	Peter Xu <peterx@redhat.com>,
	Fabiano Rosas <farosas@suse.de>
Cc: Xiaoyao Li <xiaoyao.li@intel.com>,
	Dongli Zhang <dongli.zhang@oracle.com>,
	Dapeng Mi <dapeng1.mi@linux.intel.com>,
	Zide Chen <zide.chen@intel.com>
Subject: [PATCH V2 01/11] target/i386: Disable unsupported BTS for guest
Date: Wed, 28 Jan 2026 15:09:38 -0800
Message-ID: <20260128231003.268981-2-zide.chen@intel.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260128231003.268981-1-zide.chen@intel.com>
References: <20260128231003.268981-1-zide.chen@intel.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

BTS (Branch Trace Store), enumerated by IA32_MISC_ENABLE.BTS_UNAVAILABLE
(bit 11), is deprecated and has been superseded by LBR and Intel PT.

KVM yields control of the above mentioned bit to userspace since KVM
commit 9fc222967a39 ("KVM: x86: Give host userspace full control of
MSR_IA32_MISC_ENABLES").

However, QEMU does not set this bit, which allows guests to write the
BTS and BTINT bits in IA32_DEBUGCTL.  Since KVM doesn't support BTS,
this may lead to unexpected MSR access errors.

Signed-off-by: Zide Chen <zide.chen@intel.com>
---
V2:
- Address Dapeng's comments.
- Remove mention of VMState version_id from the commit message.

 target/i386/cpu.h | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/target/i386/cpu.h b/target/i386/cpu.h
index 2bbc977d9088..f02812bfd19f 100644
--- a/target/i386/cpu.h
+++ b/target/i386/cpu.h
@@ -474,8 +474,11 @@ typedef enum X86Seg {
 
 #define MSR_IA32_MISC_ENABLE            0x1a0
 /* Indicates good rep/movs microcode on some processors: */
-#define MSR_IA32_MISC_ENABLE_DEFAULT    1
+#define MSR_IA32_MISC_ENABLE_FASTSTRING    (1ULL << 0)
+#define MSR_IA32_MISC_ENABLE_BTS_UNAVAIL   (1ULL << 11)
 #define MSR_IA32_MISC_ENABLE_MWAIT      (1ULL << 18)
+#define MSR_IA32_MISC_ENABLE_DEFAULT    (MSR_IA32_MISC_ENABLE_FASTSTRING     |\
+                                         MSR_IA32_MISC_ENABLE_BTS_UNAVAIL)
 
 #define MSR_MTRRphysBase(reg)           (0x200 + 2 * (reg))
 #define MSR_MTRRphysMask(reg)           (0x200 + 2 * (reg) + 1)
-- 
2.52.0

