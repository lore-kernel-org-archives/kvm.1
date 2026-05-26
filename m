Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79319212F89
	for <kvm@vger.kernel.org>; Tue, 26 May 2026 03:17:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779765433; cv=none; b=AmoKyzvsAMIDWzpu/6z1GgFbooFCKI2sBNXAUcOH1LydJBS0/z5R5sumYp7Gdncfz8I6qzyvelAMHLNyRtzUVecFPj6jDFqX53aoM34a96DhJ+lfvxYXMw9XiBI6YYzvv7nmu5hv9EcIaW7oAFqrlno/8lt9TxW0LokATJY4Zj0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779765433; c=relaxed/simple;
	bh=6yZcOpbIBNEELWZmN1hqVu5JIX53IXTmTqS3CmGJxfk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=tVmFopBYNLtZrCagcp1kQYlkMmMugq3QA0JipkQnt1mKX4Xihe2Cke+HUYJvJfkQK+ux24mXQcUZoGjcGfgoBhUnWrs2rrClqfkJen+reD1PlGG2osiTbbVi+zOIRPONIZKnZZZtp3FFCvStAd548PbmVIfW/wp0HOZ1DZ0gMlM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=gypDsw85; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gypDsw85"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1779765431; x=1811301431;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=6yZcOpbIBNEELWZmN1hqVu5JIX53IXTmTqS3CmGJxfk=;
  b=gypDsw85ZrhRYUbYDtQ+QZ886u71QPRzv00LXQREC/hMi4NzkZzRHuJ5
   5ILy4sanypQ+tKFxTgOKfASTdndIGprgsJaKV7/Ww5RnhDRXOi+ZAvgk4
   k4fvJC54mxHL/EetDQ+FUgJTv84G1aLt6mdMIU2GxYw5UysHI5963YuoA
   K802LbZs8ZTeM8/Q0TRvk5BUagiSyTEYMauRwfbc8FRK9QEy/Xm5ozkRG
   fpRspYG7t/tQ/Ch1YGmupSAe9cvKuJNpcsJG6ubPjWatWFVJz1PYI9yBc
   o9cIEUvPxlTcKPANIKtEhfBnT0WWs3U/GpTbyTUAK/FeFgIrdRjRl02eG
   g==;
X-CSE-ConnectionGUID: EYTTdv6VSSuQcWzRWq2dbg==
X-CSE-MsgGUID: Cvk9SF6fR3Wbq5PJs8gPyw==
X-IronPort-AV: E=McAfee;i="6800,10657,11797"; a="80479552"
X-IronPort-AV: E=Sophos;i="6.24,169,1774335600"; 
   d="scan'208";a="80479552"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 May 2026 20:17:11 -0700
X-CSE-ConnectionGUID: /Bt2Fv9DSiabcXENdQg1Hg==
X-CSE-MsgGUID: iwIyNaqNRTOM5jFG3rStDw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,169,1774335600"; 
   d="scan'208";a="246741729"
Received: from emr-bkc.sh.intel.com ([10.112.230.82])
  by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 May 2026 20:17:09 -0700
From: Chenyi Qiang <chenyi.qiang@intel.com>
To: kvm@vger.kernel.org
Cc: Chenyi Qiang <chenyi.qiang@intel.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Sean Christopherson <seanjc@google.com>,
	Xiaoyao Li <xiaoyao.li@intel.com>
Subject: [kvm-unit-tests PATCH v2 0/4] nVMX: Improve IA32_DEBUGCTLMSR test on debug controls
Date: Tue, 26 May 2026 11:16:33 +0800
Message-ID: <20260526031704.109102-1-chenyi.qiang@intel.com>
X-Mailer: git-send-email 2.43.5
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Current nested debugctls test focuses on DR7 value and fakes the result of
IA32_DEBUGCTLMSR in comment. Although the test can pass because DR7 is the
only criterion to determine the result, there are some error messages
appearing in dmesg due to accessing to BTF | LBR bits in IA32_DEBUGCTLMSR
with report_ignored_msrs KVM parameter enabled.

Clean up the old test so that it focuses on DR7, then add separate tests for
DEBUGCTLMSR bits that are actually supported and can be validated during VMX
transitions.

Tested on:
  Emerald Rapids:
    vmx_bus_lock_detect_test  PASS
    vmx_rtm_test              PASS
    vmx_legacy_lbr_test       SKIP

  Skylake:
    vmx_bus_lock_detect_test  SKIP
    vmx_rtm_test              PASS
    vmx_legacy_lbr_test       PASS

Changes since v1:
- Modify the commit message in patch 1 (Xiaoyao)
- Add dedicated tests (for BUS_LOCK_DETECT and LBR) covering the DEBUGCTL
  reads and writes during VMX transitions (Sean)
- Add one additional test for RTM_DEBUG bit that was not mentioned in v1.
- https://lore.kernel.org/kvm/20250811063035.12626-1-chenyi.qiang@intel.com/

Chenyi Qiang (4):
  nVMX: Remove the IA32_DEBUGCTLMSR access in debugctls test
  nVMX: Validate DEBUGCTLMSR_BUS_LOCK_DETECT states during VMX
    transitions
  nVMX: Validate DEBUGCTLMSR_RTM_DEBUG states during VMX transitions
  nVMX: Validate DEBUGCTLMSR_LBR states during VMX transitions

 lib/x86/msr.h     |   2 +
 x86/unittests.cfg |  25 +++++++
 x86/vmx_tests.c   | 175 +++++++++++++++++++++++++++++++++++++---------
 3 files changed, 170 insertions(+), 32 deletions(-)

-- 
2.43.5

