Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71FB9411632;
	Thu,  5 Mar 2026 17:44:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772732685; cv=none; b=Tn3Osde07KTr3gU1+W9RhkzENk98Bf8J7WameK5kGtlOoqPEO6I/b0uc5d3lNt/zwHL4VpGFJfguUrpY/5DvQvELEBugSiqtTCkm+Y+Jfnxd//MT9UbzJGHGVd3c4jNeztv0Q2yLFOPwTEoQtSOgy42lSTllDeYdafmwCG/BpM4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772732685; c=relaxed/simple;
	bh=veZLFw252ZuZG/1W+qVgSJzBNoneJh//dkRFwAcadfo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mzW1tjGe9u/vstsSyhiYc/wnW5vCNum8YC+aNKwdkkBE5J+bFeu7j0xZs16lmUdROyBV6DwiixAFiPegBGrUk/JuJfljoqkeTSJ3KLNaPrJNnfbAaBa5kqg4OhJxR1BJDNGO27mGeN8gk1W8tyi1h5HQe1K5h+kbUbhsTLkTAw4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=gI+XYczt; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gI+XYczt"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1772732684; x=1804268684;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=veZLFw252ZuZG/1W+qVgSJzBNoneJh//dkRFwAcadfo=;
  b=gI+XYczt4MmWOTTdWthWcdDQlu/43EmQVVinwf5c3nrfKIaIS1kK2+KQ
   nz9zKaS0Dn78rO7qHE7eCyTVcYUBA2+WuABWR96RYCk3RWDrCCDu+tr9K
   Yv8lEP1mvRJ4p35frxbPdXJ8ZPSESMOBAwtmaYCxKaSYkt2edf0oMWwqN
   aY1S3c6d2vYSQn2u+j1xPQVJ/GoweEhApghBhfMcxSiTXNNporn3VStAt
   DHli6Hl2BYjtiYO52U+GUFW2KWYrMSoQRrpW+3Dt2LpwCEavXnaDaj7CG
   P1dueohryC2NaRTNuH0fW/FVe2EFxPUiIh4SPug1lHm64+krH2jxEgg2d
   g==;
X-CSE-ConnectionGUID: gq5MYFKvRA26F7XRm/ioMg==
X-CSE-MsgGUID: aSsLhDE5Sheh4gx+MUpvfQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11720"; a="77701127"
X-IronPort-AV: E=Sophos;i="6.23,103,1770624000"; 
   d="scan'208";a="77701127"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Mar 2026 09:44:43 -0800
X-CSE-ConnectionGUID: i5rKjPoWT520bQQ3U1osNw==
X-CSE-MsgGUID: GLSzLUnMQySJbIFIUKMrNg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,103,1770624000"; 
   d="scan'208";a="256647619"
Received: from mdroper-mobl2.amr.corp.intel.com (HELO localhost) ([10.124.220.244])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Mar 2026 09:44:43 -0800
From: isaku.yamahata@intel.com
To: kvm@vger.kernel.org
Cc: isaku.yamahata@intel.com,
	isaku.yamahata@gmail.com,
	Paolo Bonzini <pbonzini@redhat.com>,
	Sean Christopherson <seanjc@google.com>,
	linux-kernel@vger.kernel.org,
	Yang Zhong <yang.zhong@linux.intel.com>
Subject: [PATCH v2 21/36] KVM: VMX: dump_vmcs() support the guest virt timer
Date: Thu,  5 Mar 2026 09:44:01 -0800
Message-ID: <dc183f91744647b2f6ed7512076b2835705e6959.1772732517.git.isaku.yamahata@intel.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <cover.1772732517.git.isaku.yamahata@intel.com>
References: <cover.1772732517.git.isaku.yamahata@intel.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Yang Zhong <yang.zhong@linux.intel.com>

Add three VMCS fields from the guest virt timer into dump_vmcs().

Signed-off-by: Yang Zhong <yang.zhong@linux.intel.com>
Signed-off-by: Isaku Yamahata <isaku.yamahata@intel.com>
---
 arch/x86/kvm/vmx/vmx.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
index 8c2ab0164714..e665fc7f3377 100644
--- a/arch/x86/kvm/vmx/vmx.c
+++ b/arch/x86/kvm/vmx/vmx.c
@@ -6594,6 +6594,12 @@ void dump_vmcs(struct kvm_vcpu *vcpu)
 		vmx_dump_msrs("guest autoload", &vmx->msr_autoload.guest);
 	if (vmcs_read32(VM_EXIT_MSR_STORE_COUNT) > 0)
 		vmx_dump_msrs("autostore", &vmx->msr_autostore);
+	if (tertiary_exec_control & TERTIARY_EXEC_GUEST_APIC_TIMER) {
+		pr_err("DeadlinePhy = 0x%016llx\n", vmcs_read64(GUEST_DEADLINE_PHY));
+		pr_err("DeadlineVir = 0x%016llx\n", vmcs_read64(GUEST_DEADLINE_VIR));
+		pr_err("GuestApicTimerVector = 0x%04x\n",
+		       vmcs_read16(GUEST_APIC_TIMER_VECTOR));
+	}
 
 	if (vmentry_ctl & VM_ENTRY_LOAD_CET_STATE)
 		pr_err("S_CET = 0x%016lx, SSP = 0x%016lx, SSP TABLE = 0x%016lx\n",
-- 
2.45.2

