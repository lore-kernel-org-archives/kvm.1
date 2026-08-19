Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B618B44A402;
	Wed, 19 Aug 2026 09:54:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787133280; cv=none; b=AgAjrbIOGYkfoAsJJ6+gcVtLoeyG5OrajLG6L8MEoXPf5dhAw9/kSHR7ohSoEGaVaaYX5YZ5mmFBG/P3wy9y+91qQhZ0MprWzzxVn+7llIFFfBW4hdS/HWNDvhDXRkyFiC8+s6aGKPWXmuryW7aLWG0wn2L+KOk6o5mk7MTjKi0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787133280; c=relaxed/simple;
	bh=pNkqq2dwqlcQDn1HUnduSrLVReavua1ZNSuOBY8FdLM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NNrxVv/T0Pyq4I3+t3aaXC2k7kE/YFjD/iDz6tpPNJGXvVbBB46gGf3RWNzrOAmGbOTD4fyQHtnSndp/z7qt42ZZMPtYRyjhntZDrXTM/XgH0q9UU8DAv9pEJSf6cJoNB8PQuu0uSi5DY5fW+UaxyBAsx/iocgUlrk3MRJfkw/8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=VEXleniP; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="VEXleniP"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1787133275; x=1818669275;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=pNkqq2dwqlcQDn1HUnduSrLVReavua1ZNSuOBY8FdLM=;
  b=VEXleniPNcqkXpRGFg4QLQVqtAcNYDstAHCHT1irr3PXZwtynEgefOE1
   AvcEzOn0ggwDlvWZie25P/cK6OPNHHrFnyfJWPAGPd3AWJP+S5Xd9SI7F
   jxSzhpZgk8WCpXiClnI5lKVMUwS5e8YsQ335IYcV8QdrmBJVhhfVG/5Ct
   Kx2voBaFdAGMrDYaG5OnopLiEcD/uMD/OnDoLXuMa5PqN/zoDZO4kUTwJ
   pPBJrDr9hK2+JdzPxDparIrIGBOdtxvjYoRqbAzQN+A6t64fN3au2gvCN
   R7R14JIotGdDt4orEaZU6IMBLXNT6whf9W8iz1iVRe/Gh3GauIxyaodGD
   w==;
X-CSE-ConnectionGUID: cl5n7Xt9TfyHWPng0du4zQ==
X-CSE-MsgGUID: NVaOEHzSR6iTY/3QA/I1oA==
X-IronPort-AV: E=McAfee;i="6800,10657,11879"; a="87514946"
X-IronPort-AV: E=Sophos;i="6.25,231,1779174000"; 
   d="scan'208";a="87514946"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Aug 2026 02:54:28 -0700
X-CSE-ConnectionGUID: oe0TwS+QQ2+rLWoWKduaBw==
X-CSE-MsgGUID: vjNQwiIKQ3u9GcJt6a6Emw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,231,1779174000"; 
   d="scan'208";a="303708878"
Received: from lxy-clx-4s.sh.intel.com ([10.239.48.33])
  by orviesa001.jf.intel.com with ESMTP; 19 Aug 2026 02:54:23 -0700
From: Xiaoyao Li <xiaoyao.li@intel.com>
To: Sean Christopherson <seanjc@google.com>,
	Paolo Bonzini <pbonzini@redhat.com>
Cc: Kiryl Shutsemau <kas@kernel.org>,
	Rick Edgecombe <rick.p.edgecombe@intel.com>,
	Xiaoyao Li <xiaoyao.li@intel.com>,
	kvm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-coco@lists.linux.dev,
	nik.borisov@suse.com
Subject: [PATCH v4 5/9] KVM: TDX: Update exit_reason on wait_for_sept_zap return
Date: Wed, 19 Aug 2026 17:48:59 +0800
Message-ID: <20260819094903.3060020-6-xiaoyao.li@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260819094903.3060020-1-xiaoyao.li@intel.com>
References: <20260819094903.3060020-1-xiaoyao.li@intel.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Update exit_reason to a value with bit[31:16] cleared and bit[15:0]
set to TDX_INVALID_EXIT_REASON when it needs to return early due to
wait_for_sept_zap in tdx_vcpu_run().  This avoids the stale exit_reason
of the previous Exit being consumed twice.

Fixes: 4b2abc49712b ("KVM: TDX: Kick off vCPUs when SEAMCALL is busy during TD page removal")
Cc: stable@vger.kernel.org
Signed-off-by: Xiaoyao Li <xiaoyao.li@intel.com>
---
Changes in v4:
- new patch;
---
 arch/x86/kvm/vmx/tdx.c | 15 ++++++++++++++-
 1 file changed, 14 insertions(+), 1 deletion(-)

diff --git a/arch/x86/kvm/vmx/tdx.c b/arch/x86/kvm/vmx/tdx.c
index 987092283955..014710945e8a 100644
--- a/arch/x86/kvm/vmx/tdx.c
+++ b/arch/x86/kvm/vmx/tdx.c
@@ -1088,8 +1088,21 @@ fastpath_t tdx_vcpu_run(struct kvm_vcpu *vcpu, u64 run_flags)
 	 * allowing vCPU entry to avoid contention with tdh_vp_enter() and
 	 * TDCALLs.
 	 */
-	if (unlikely(READ_ONCE(to_kvm_tdx(vcpu->kvm)->wait_for_sept_zap)))
+	if (unlikely(READ_ONCE(to_kvm_tdx(vcpu->kvm)->wait_for_sept_zap))) {
+		/*
+		 * The vCPU never entered the guest, but this looks like a
+		 * handled exit to the caller.  Synthesize an invalid exit
+		 * reason so the previous exit's stale value isn't consumed
+		 * a second time.
+		 *
+		 * Make it super clear that bit[31:16] is cleared to 0 and only
+		 * basic exit reason (bit[15:0]) is set to the synthesized
+		 * invalid exit reason.
+		 */
+		vt->exit_reason.full = 0;
+		vt->exit_reason.basic = TDX_INVALID_EXIT_REASON;
 		return EXIT_FASTPATH_EXIT_HANDLED;
+	}
 
 	trace_kvm_entry(vcpu, run_flags & KVM_RUN_FORCE_IMMEDIATE_EXIT);
 
-- 
2.43.0

