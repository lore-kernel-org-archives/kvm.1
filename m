Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F26CE442109;
	Thu,  6 Aug 2026 11:24:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786015468; cv=none; b=A5Ffvfk+Sk3ju9iCYQp+pmgh1ovj4xi7HyGSqdhO/nRquG4cs8CjxCIyhZ8Jqy/O7KnKwTW9WoMHcwABNXSqkHplaJ2OSV1Hh/umJZ9k8prAHaM37INaRNhev7poA08x8qgdYNNZaj4xGad71VI0HZr08ld81WaoIv0XCzH2bpU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786015468; c=relaxed/simple;
	bh=3KkpcMoXk1SfzZ1pej697qfkjitEwD71lPhdPRbkJz8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=S7xqUn/OW6ZtekDFG9cSjAOseIRbEbgSuHshNAODzJu+it2REUVEvAg02EulyvPLJ7gRy509R7dTu+gDD297//BOfOvIKUnLDOuFjtM7zwFPHp5XtCyBe68Pd/DXyu26nhARtBgYJ0y2qqe/h+6J66exrM04Vku7TXx1vTGM9hI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Do3s0b+l; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Do3s0b+l"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1786015467; x=1817551467;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=3KkpcMoXk1SfzZ1pej697qfkjitEwD71lPhdPRbkJz8=;
  b=Do3s0b+l6vYD5l4Yz3rw20Kit1h/wPkxPIb4gsofUvP5pCht5a/988oz
   K8men1ByRXDWk9Un9Q0DVFC3BMCktg6AcGPS60cK94wk8F9stUxt1fENT
   vD2JVrFTgF8SePjpo7bwdY3D4e2bZP0BF5nggpCRm9VR8vmncuBfSwkWL
   +2pdw9bva8CFykuW8v4H3tmh7Xmabedc5AdlSAfzidyXSQ642fTh+1uIf
   Yt0h2PvRK2o5aNlAXkLirC45Oi1RjawoJk6A2LkhJj4ZhOMWGjs7Z0ZeR
   JSwk4VlXWC1CadNKaZmCEfZCdkmMyqk9ACBelWewn0y0lF2/4KcoIzn+R
   g==;
X-CSE-ConnectionGUID: TwmIll1ITJqIr5hw92nX5Q==
X-CSE-MsgGUID: Qy/g7mTpRSuAh58ma/MddQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11866"; a="86617193"
X-IronPort-AV: E=Sophos;i="6.25,208,1779174000"; 
   d="scan'208";a="86617193"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Aug 2026 04:24:26 -0700
X-CSE-ConnectionGUID: ULBzP72VQLatutIf5T4tBQ==
X-CSE-MsgGUID: EZR5F/OdSJOZuuEdPOKYeA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,208,1779174000"; 
   d="scan'208";a="267225057"
Received: from lxy-clx-4s.sh.intel.com ([10.239.48.33])
  by fmviesa005.fm.intel.com with ESMTP; 06 Aug 2026 04:24:25 -0700
From: Xiaoyao Li <xiaoyao.li@intel.com>
To: Sean Christopherson <seanjc@google.com>,
	Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	xiaoyao.li@intel.com
Subject: [PATCH 1/3] KVM: VMX: Preserve negative return value in vmx_handle_exit() with bus lock detected
Date: Thu,  6 Aug 2026 19:19:21 +0800
Message-ID: <20260806111923.1990562-2-xiaoyao.li@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260806111923.1990562-1-xiaoyao.li@intel.com>
References: <20260806111923.1990562-1-xiaoyao.li@intel.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Preserve the negative return value from __vmx_handle_exit() when a bus
lock is detected, instead of always overwriting it with 0.

The purpose of bus_lock_detected handling is to force a userspace exit to
inform userspace that a bus lock happened. The negative return value can
achieve this purpose, and changing the negative value to 0 fails to return
an error to userspace. So, preserve the negative return value.

Fixes: fe6b6bc802b4 ("KVM: VMX: Enable bus lock VM exit")
Reported-by: sashiko-bot@kernel.org
Closes: https://lore.kernel.org/all/20260805034602.5B2BB1F000E9@smtp.kernel.org/
Signed-off-by: Xiaoyao Li <xiaoyao.li@intel.com>
---
I'm not sure on the Closes: link, since Sashiko didn't find the VMX
issue directly.
---
 arch/x86/kvm/vmx/vmx.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
index e3bfe6aca1a0..1cd120b5d4a5 100644
--- a/arch/x86/kvm/vmx/vmx.c
+++ b/arch/x86/kvm/vmx/vmx.c
@@ -6871,11 +6871,12 @@ int vmx_handle_exit(struct kvm_vcpu *vcpu, fastpath_t exit_fastpath)
 	 * a bus lock in guest.
 	 */
 	if (vmx_get_exit_reason(vcpu).bus_lock_detected) {
-		if (ret > 0)
+		if (ret > 0) {
 			vcpu->run->exit_reason = KVM_EXIT_X86_BUS_LOCK;
+			ret = 0;
+		}
 
 		vcpu->run->flags |= KVM_RUN_X86_BUS_LOCK;
-		return 0;
 	}
 	return ret;
 }
-- 
2.43.0

