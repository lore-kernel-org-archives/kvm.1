Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 622163E8C5C;
	Tue,  3 Feb 2026 18:17:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770142670; cv=none; b=fK3aIDAXgqlIM5CysKO7gvD97RapcO55WwopvvDjMy29pWvFriW+rP9LtLJNtGieqtEbBoA2KrsKkSzlhghNnnWhb6mnq2sZsVDpYg2gtOmi7KecF2od7mSAfKJ6JesuqYySG5e9zvpStu5vC2W7klYN3djeoBhplZzZVMT7poI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770142670; c=relaxed/simple;
	bh=5Jz0V9XuxzAVJr8QmZ5HTOdNpc3K/kmgi9wZva0kZe4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XxFwgAQbyH+UtnCGBjHCvQjn7tPyzGm0yB3YEiwJcazgo1si31Dl3lQdO6ie9EnSRuz9FnLJM6lvf0a2mzsTcpw31Ry/lErQfanNa5nY5mhEqvkWfRnp4K4Bpn1y0nTfngVNVOo9+Ru0LTnnye0nH9pvpFRJ91xd389Io0nZtgk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mQYTp+56; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mQYTp+56"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1770142669; x=1801678669;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=5Jz0V9XuxzAVJr8QmZ5HTOdNpc3K/kmgi9wZva0kZe4=;
  b=mQYTp+56MDzz3W4orT6dRf/7mtcUdWu7LyIpFdF1GOY7TornIdWT6rAy
   zPQfsWbUMHJjGYi6RyTT8M5IKw3hiJIZrw4eGE8HlR9AfkrO3ipVWBLAP
   i+4JBLh+45hjX5v1neg9KMkwt7P5IarCT9YXjuDuFJsMfcDcOJ3aUWkf1
   P6HBNykAlgqN+Z0nDfOJiBlVcM16v33PU9Pj1OyikU1jQI1eBND4CT3r8
   QItWg7OtOA95dS6DFOcC0zqsto7/vC3mrNI0KLTRqh1oXy8E+2KWodOym
   W+pdI/+Yz1630uXBgvL31jZ6DrVQPB2qImVEFWhh56ysdTcLDrHg/GGVJ
   g==;
X-CSE-ConnectionGUID: 5oLu+ue+TUadAhwWMZhlvg==
X-CSE-MsgGUID: nk6vnGdmQhmkhT1lFfxrDA==
X-IronPort-AV: E=McAfee;i="6800,10657,11691"; a="88745839"
X-IronPort-AV: E=Sophos;i="6.21,271,1763452800"; 
   d="scan'208";a="88745839"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Feb 2026 10:17:45 -0800
X-CSE-ConnectionGUID: EVGNVp7lRHSpUqhg0kbH8g==
X-CSE-MsgGUID: FcFELbLaQ0eWLljrTbjUzg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,271,1763452800"; 
   d="scan'208";a="209605513"
Received: from khuang2-desk.gar.corp.intel.com (HELO localhost) ([10.124.221.188])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Feb 2026 10:17:44 -0800
From: isaku.yamahata@intel.com
To: kvm@vger.kernel.org
Cc: isaku.yamahata@intel.com,
	isaku.yamahata@gmail.com,
	Paolo Bonzini <pbonzini@redhat.com>,
	Sean Christopherson <seanjc@google.com>,
	linux-kernel@vger.kernel.org,
	Yang Zhong <yang.zhong@linux.intel.com>
Subject: [PATCH 20/32] KVM: VMX: dump_vmcs() support the guest virt timer
Date: Tue,  3 Feb 2026 10:17:03 -0800
Message-ID: <2ae528c16a244e8c138835217c2a190e350dcde8.1770116051.git.isaku.yamahata@intel.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <cover.1770116050.git.isaku.yamahata@intel.com>
References: <cover.1770116050.git.isaku.yamahata@intel.com>
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
index 50d4390d41f0..5496f4230424 100644
--- a/arch/x86/kvm/vmx/vmx.c
+++ b/arch/x86/kvm/vmx/vmx.c
@@ -6522,6 +6522,12 @@ void dump_vmcs(struct kvm_vcpu *vcpu)
 		vmx_dump_msrs("guest autoload", &vmx->msr_autoload.guest);
 	if (vmcs_read32(VM_EXIT_MSR_STORE_COUNT) > 0)
 		vmx_dump_msrs("guest autostore", &vmx->msr_autostore.guest);
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

