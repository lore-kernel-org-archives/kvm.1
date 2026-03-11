Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E67371A3164
	for <kvm@vger.kernel.org>; Wed, 11 Mar 2026 01:59:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773194371; cv=none; b=hy14gecE+R/trlwTq/sB860YBtM/l/+P9ZRX8ox09jr0CVAsmk+ZbMdmnrcvjbIEAzEuyA99e862/ZGxBrro0fqnX7oaUrFHQXe5k6HZdnr1iY+ZHSM5WHwcEkXxPtteheIE1/T+Rl/dLm3zp61D7hu2OSjp6o9Sh4UDvhEb6CU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773194371; c=relaxed/simple;
	bh=LWK+I08EXWB9IgaAPxS4/Jb1wAD/qklgx6HZMrdy3U8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=NBIAMy1Niii+349Nz/wHgaVYl9gP2ehVJJ4avZlo0XQ5QJrcBtCPP38igh9XMvydl3weBE2zUDhuWd0mUWtyTq+wSNEwv7uAB4MnEIUYwcL6oX8xpHd9XdiTew1WHS+a7BZCI3jOec7P7Jc8n4kL8w1h9ZHkf939opRY1Z5HzLw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=CGUcTlaO; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="CGUcTlaO"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1773194370; x=1804730370;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=LWK+I08EXWB9IgaAPxS4/Jb1wAD/qklgx6HZMrdy3U8=;
  b=CGUcTlaO1ZYso8ES88MjqqdzXLipvCuaySwn2k9J6WocOgoCpSM2kq0t
   CyHWuHSHJw7CeY6Eo4aMFaAH6qEWPrvg/op7zL6KoYdxJGjoBE120ySQx
   XecejYuizKGWD8WZ2TRp7B9Y4tdBBRGQdz1KkMHJLhB8S1a1EFgAfqfzi
   UXxFir/SuAVmhptNRBSkbLLDPZISlsXhEHArTxOSCjY1cVUq24vQ/Zl9B
   XXCwywpG6tj4PhQ31oUhylfYPSzrocuf/wDYQsVrrKklURWawAHo0UqD8
   KENKLJpbdnUCGflKO/VP6P8iHE1B+VUAXCT05oRaUrs//EHytnnRs3DLP
   w==;
X-CSE-ConnectionGUID: vtehfVFiRj2m53S2boQJlA==
X-CSE-MsgGUID: TAVWey/MQQ2TTh1tTm3iAw==
X-IronPort-AV: E=McAfee;i="6800,10657,11725"; a="73954870"
X-IronPort-AV: E=Sophos;i="6.23,113,1770624000"; 
   d="scan'208";a="73954870"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Mar 2026 18:59:29 -0700
X-CSE-ConnectionGUID: XZ95tlEGQEiG4+/Z//8hKg==
X-CSE-MsgGUID: WknVCiUpR+aJa5x/a7496w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,113,1770624000"; 
   d="scan'208";a="225003454"
Received: from iherna2-mobl4.amr.corp.intel.com (HELO localhost) ([10.124.222.32])
  by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Mar 2026 18:59:29 -0700
From: isaku.yamahata@intel.com
To: kvm@vger.kernel.org
Cc: isaku.yamahata@intel.com,
	isaku.yamahata@gmail.com,
	Paolo Bonzini <pbonzini@redhat.com>,
	Sean Christopherson <seanjc@google.com>,
	kernel test robot <lkp@intel.com>
Subject: [PATCH] KVM: VMX: Eliminate warnings by sparse in vmcs12.c and hyperv_evmcs.c
Date: Tue, 10 Mar 2026 18:59:10 -0700
Message-ID: <47e4570a1db6f68eacdde989c6cf4f53175cea75.1773193126.git.isaku.yamahata@intel.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Isaku Yamahata <isaku.yamahata@intel.com>

Make ROL16() explicitly mask instead of the truncation by u16 cast.
Sparse complains as follows for vmcs12.c and hyperv_evmcs.c.
  > vmcs12.c:17:9: warning: cast truncates bits from constant value
  > (20002 becomes 2)

It is because ROL16(val, n) includes "(u16)(val) << (n)" whose type is int,
not u16, due to integer promotion even with a u16 cast.  The outermost u16
cast in ROL16() may truncate it.  Explicitly mask it to avoid truncation by
the u16 cast.

Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202603061942.wdSsERnL-lkp@intel.com/
Signed-off-by: Isaku Yamahata <isaku.yamahata@intel.com>
---
 arch/x86/kvm/vmx/vmcs.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/x86/kvm/vmx/vmcs.h b/arch/x86/kvm/vmx/vmcs.h
index 1f16ddeae9cb..b5b5f4870655 100644
--- a/arch/x86/kvm/vmx/vmcs.h
+++ b/arch/x86/kvm/vmx/vmcs.h
@@ -18,7 +18,8 @@
  * wasting too much memory, while the "algorithm" is fast enough to be used to
  * lookup vmcs12 fields on-demand, e.g. for emulation.
  */
-#define ROL16(val, n) ((u16)(((u16)(val) << (n)) | ((u16)(val) >> (16 - (n)))))
+#define ROL16(val, n) ((u16)((((u16)(val) << (n)) & GENMASK_U16(15, 0)) | \
+			     ((u16)(val) >> (16 - (n)))))
 #define VMCS12_IDX_TO_ENC(idx) ROL16(idx, 10)
 #define ENC_TO_VMCS12_IDX(enc) ROL16(enc, 6)
 

base-commit: 5128b972fb2801ad9aca54d990a75611ab5283a9
-- 
2.45.2

