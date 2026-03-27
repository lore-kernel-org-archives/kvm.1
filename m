Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46DBB39184C;
	Fri, 27 Mar 2026 20:14:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774642473; cv=none; b=U6InoJQD8jlMUrFQtNCQqSbEJBk8enaS0HOibBeq04xNDuA8XEMu2m91oc9Xm7wA4oeQZtZWDqvsITBwKSssJFHBevEN0xIMor2TX+sDZHqKN2/IDnMv1y2BFMAWzuewzivCc1sR6iSI181fc8ayM/FbogUSswluT2MZuLRHrWc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774642473; c=relaxed/simple;
	bh=BnLASTfk0bboPsP8BzC/w01D2X3PlCKuz/a3ZXgxiYY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VqqZM9bzkGbS5RsLfSIyXw6mc5ttpICd+ax4nFS++7J3bmFUVKBku0yz+37TZ4hg6coxj8T9A94mBptCWtZSBqhCRchZ9RyKs+EiprZAs3W6RpKsu98D/GokJMQB1vex8D6wotK/PYhWDQYKqS9Z0yMI+5UgJ99VQncQwLsrAo0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mzOTH5YL; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mzOTH5YL"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1774642471; x=1806178471;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=BnLASTfk0bboPsP8BzC/w01D2X3PlCKuz/a3ZXgxiYY=;
  b=mzOTH5YLf7S9fmFBeXKGBiQSq9N1HqNRiuQM9YIc+rm/idSauCjPY8TG
   6ZVD3y1QiIOd1JOLFrCWxtg4VO9QoqOwOSWwHHWgoK5LrlYQlQj4BuqcZ
   /tTLXWBzovjsv8JFnTgFqMCYE8XCYTkI55tt/EradjMnLDsfPFD7Ld9vM
   iDcBg8/QWj68D4joNqzgXu5HQOTz2lR1eCLcIgt1VMh57gyE/fgI8vATx
   Hoku86iCeclPgvN0c4vHsp+wHoP0ZprfhJ+jrjXGkUM6n8KJ2ASYJlcCr
   TIkfJ+HV8kTFXP0xUce3kf+bx8xhUaUkdCw49XjLMF9YDp3J3VQHt4nEt
   w==;
X-CSE-ConnectionGUID: Kj3ai58JTb6aL3GcG0rvfA==
X-CSE-MsgGUID: wV92g3mFQxyMgCLxhb6G0Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11742"; a="101182734"
X-IronPort-AV: E=Sophos;i="6.23,144,1770624000"; 
   d="scan'208";a="101182734"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Mar 2026 13:14:27 -0700
X-CSE-ConnectionGUID: hPUbbZq+T5uEZVlsp+4kxQ==
X-CSE-MsgGUID: 0cyV7rpkRcKlx1x+mFxr9A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,144,1770624000"; 
   d="scan'208";a="255922897"
Received: from rpedgeco-desk.jf.intel.com ([10.88.27.139])
  by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Mar 2026 13:14:26 -0700
From: Rick Edgecombe <rick.p.edgecombe@intel.com>
To: seanjc@google.com,
	pbonzini@redhat.com,
	yan.y.zhao@intel.com,
	kai.huang@intel.com,
	kvm@vger.kernel.org,
	kas@kernel.org
Cc: linux-kernel@vger.kernel.org,
	x86@kernel.org,
	dave.hansen@intel.com,
	rick.p.edgecombe@intel.com
Subject: [PATCH 04/17] KVM: x86: Make "external SPTE" ops that can fail RET0 static calls
Date: Fri, 27 Mar 2026 13:14:08 -0700
Message-ID: <20260327201421.2824383-5-rick.p.edgecombe@intel.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260327201421.2824383-1-rick.p.edgecombe@intel.com>
References: <20260327201421.2824383-1-rick.p.edgecombe@intel.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Sean Christopherson <seanjc@google.com>

Define kvm_x86_ops .link_external_spt(), .set_external_spte(), and
.free_external_spt() as RET0 static calls so that an unexpected call to a
a default operation doesn't consume garbage.

Fixes: 77ac7079e66d ("KVM: x86/tdp_mmu: Propagate building mirror page tables")
Fixes: 94faba8999b9 ("KVM: x86/tdp_mmu: Propagate tearing down mirror page tables")
Signed-off-by: Sean Christopherson <seanjc@google.com>
Signed-off-by: Rick Edgecombe <rick.p.edgecombe@intel.com>
---
 arch/x86/include/asm/kvm-x86-ops.h | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/x86/include/asm/kvm-x86-ops.h b/arch/x86/include/asm/kvm-x86-ops.h
index 3776cf5382a2..31d5c5d58ae6 100644
--- a/arch/x86/include/asm/kvm-x86-ops.h
+++ b/arch/x86/include/asm/kvm-x86-ops.h
@@ -95,9 +95,9 @@ KVM_X86_OP_OPTIONAL_RET0(set_tss_addr)
 KVM_X86_OP_OPTIONAL_RET0(set_identity_map_addr)
 KVM_X86_OP_OPTIONAL_RET0(get_mt_mask)
 KVM_X86_OP(load_mmu_pgd)
-KVM_X86_OP_OPTIONAL(link_external_spt)
-KVM_X86_OP_OPTIONAL(set_external_spte)
-KVM_X86_OP_OPTIONAL(free_external_spt)
+KVM_X86_OP_OPTIONAL_RET0(link_external_spt)
+KVM_X86_OP_OPTIONAL_RET0(set_external_spte)
+KVM_X86_OP_OPTIONAL_RET0(free_external_spt)
 KVM_X86_OP_OPTIONAL(remove_external_spte)
 KVM_X86_OP(has_wbinvd_exit)
 KVM_X86_OP(get_l2_tsc_offset)
-- 
2.53.0

