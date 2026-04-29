Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6E6C2DF153
	for <kvm@vger.kernel.org>; Wed, 29 Apr 2026 07:29:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777447743; cv=none; b=aTMIRd5yXd1OxDqA6tqai1T0pcxM6M0FXhMjiqIOE/lUKftrhcGkVqmcyYS9TF9IDgyvTSuBYzPjIhT0kdL4RlugLegvC1LzCCXm3ndIJ2TsBA/FPcFFTZHK4MdjBnNlVet+NVxocrQhG8gztcgOSsWv1qHg1BvQZbqxX4nIx1M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777447743; c=relaxed/simple;
	bh=3xa1UQa08cE25rP1nygGbEoUCnbB3YZwvUNHlhrBcSI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=QhmU8HU/iS95PFnfgqcrvIjhwNbCg09rYyh+i8YmS7vf+x0MwfyIoCC4btcQVU8Zrqpi08Ai3xR4TIR3dRljQCENK14rN0o4c0uY92qdijmHJubRnN9xE4/iUwmOpa89lEy3ffnhoiGcrkFSEsIkpTEXMAzfnDJlPBN0l+txJ5I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jvtGievV; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jvtGievV"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1777447742; x=1808983742;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=3xa1UQa08cE25rP1nygGbEoUCnbB3YZwvUNHlhrBcSI=;
  b=jvtGievV8YQ3I+GtQAJiOD9OnUSrPmYfAl14P91utY5EM9CPSWeOrvvx
   vQJHq0h4IjdrpCAeC4zTLSruRqE1v+weAxBijoG5wLZqDOfHlsY2txFye
   KNbMQh/uw+t8NfWCEjl69X1bFPYos6Bl1Y+wn4NzpXcFL3t2PC/+hTJiE
   vzqGHJbT9RCEg7gx5ZcZLZ4GPICy+0HbMdi5bncVijIzVoY2kOORPG2P0
   aiaoGOdexJTm5b/u9WFqe2+ia1Lmux5+4k4OmuHOFwWkOSYMfyq0Ms7fn
   gXTcNQ0D5/HRHxzuDNIxwey5BJlvFUq4+eHzKodxzLkPRqIJdPKLO8S3B
   g==;
X-CSE-ConnectionGUID: XcdlUniQRHakSH1efRR0bg==
X-CSE-MsgGUID: LsnR/VrbQE6KEUuQJKW8kA==
X-IronPort-AV: E=McAfee;i="6800,10657,11770"; a="78385795"
X-IronPort-AV: E=Sophos;i="6.23,205,1770624000"; 
   d="scan'208";a="78385795"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Apr 2026 00:29:01 -0700
X-CSE-ConnectionGUID: BxxFYMfnRy+RNdOgW143gA==
X-CSE-MsgGUID: Tx6+rYyzR5Gi61ifNvnFtQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,205,1770624000"; 
   d="scan'208";a="272324242"
Received: from emr-bkc.sh.intel.com ([10.112.230.82])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Apr 2026 00:29:00 -0700
From: Chenyi Qiang <chenyi.qiang@intel.com>
To: kvm@vger.kernel.org
Cc: Chenyi Qiang <chenyi.qiang@intel.com>,
	Sean Christopherson <seanjc@google.com>,
	Jim Mattson <jmattson@google.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Gao Chao <chao.gao@intel.com>
Subject: [PATCH v2 0/2] KVM: x86: Fix max_irr reporting when PIR is empty despite PID.ON
Date: Wed, 29 Apr 2026 15:28:06 +0800
Message-ID: <20260429072851.3004430-1-chenyi.qiang@intel.com>
X-Mailer: git-send-email 2.43.5
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fix a race in the PIR-to-IRR synchronization path where PID.ON is set
but PIR is empty, causing __kvm_apic_update_irr() to report max_irr as
-1 even though there are pending interrupts in the IRR.  This triggers a
spurious WARNING in vmx_check_nested_events() during nested VM stress
tests.

v2:
  - Move the fix from vmx_sync_pir_to_irr() to __kvm_apic_update_irr()
    as suggested by Paolo along with some commit message changes. [Paolo]
  - Add Cc: stable, Suggested-by, Reviewed-by tags.
  - Carry Sean's cleanup patch for variable renames and expanded
    comments. [Sean]

v1: https://lore.kernel.org/kvm/20260428070349.1633238-1-chenyi.qiang@intel.com/

Chenyi Qiang (1):
  KVM: x86: Always report highest IRR from __kvm_apic_update_irr()

Sean Christopherson (1):
  KVM: x86: Fix misleading variable names and add more comments for
    PIR=>IRR flow

 arch/x86/kvm/lapic.c   | 24 +++++++++++++-----------
 arch/x86/kvm/vmx/vmx.c | 40 ++++++++++++++++++++++++++++++++--------
 2 files changed, 45 insertions(+), 19 deletions(-)

-- 
2.43.5

