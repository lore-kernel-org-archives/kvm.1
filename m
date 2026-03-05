Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D9243EBF16;
	Thu,  5 Mar 2026 17:44:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772732681; cv=none; b=FzdCKFrFEiAFdTG5FpX1GX5PEut+AQPpmSvbnIxtsw8VE+5Qjs6JLlp5JMZtWd9o3eBRxL5Mfei6yBefTMxr8uyslWadOdBoPlpeyAotvekeLNgKJ1G/20UuNOt6dOp3UWeylcAreKM2SzfDaqNChK7PTS9BVL768eiHlfuqeQY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772732681; c=relaxed/simple;
	bh=wXZavH4PFskMoph6+sp6WaxRRQcx0bbNdaC4hw/pmB4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Q882GOgIdQgR+rbqczYUo1UjlFvKvR4dne0yksYyKifyj6IXbSTIDGzSsyPvKD0Rqu2yrcin9l1xB/Eq92GZ0bcrr337LiuuIS50d4X3NGvCRyjZlPLbCn0kyxAM/aT4+kFMkr62Kc+OSpH7fIe0Zln5EOGgkvpTCvaXKlDPgJI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=eoyDarV2; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="eoyDarV2"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1772732679; x=1804268679;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=wXZavH4PFskMoph6+sp6WaxRRQcx0bbNdaC4hw/pmB4=;
  b=eoyDarV2OLTIfADJCUFEb81SSJ72XfEtR3JlXjltIaIA0SgsITFwCMXr
   /yy4siHBTwtfzUFf8O6AJejVJTl4ma8N8F6+EzV6Gm/XAZvNp2/z930F6
   FaU+jWq5VLijvPHXIluMa/dcf6UqMPiZkKKe3Rmk8E/wzyJis1Lg3dByU
   x6i+4eDKLU6titT6OLwpfQVAEyVduYfvlPBn31G8yyFTMVlZMACegDbyI
   vQPqWpGI5PrDKoGgjP+AIFWDb+OheMtQ1Q8V/DnjV5E8xqrYpTFnpCj6U
   h+m2O0jGmyB0FVLtsJ0lOIzNH0c7pipzIERi/yv8350e8Q6n9KhucwhDB
   A==;
X-CSE-ConnectionGUID: oByQ+lkAS8SUgwwJrq2DKA==
X-CSE-MsgGUID: ShUYAmOhQuGh/EetOk9gpA==
X-IronPort-AV: E=McAfee;i="6800,10657,11720"; a="73798235"
X-IronPort-AV: E=Sophos;i="6.23,103,1770624000"; 
   d="scan'208";a="73798235"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Mar 2026 09:44:39 -0800
X-CSE-ConnectionGUID: 0Zoys+SbT2Kfet9GNXhITQ==
X-CSE-MsgGUID: WHXnxA1STpucYuiqLWfsgA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,103,1770624000"; 
   d="scan'208";a="215527274"
Received: from mdroper-mobl2.amr.corp.intel.com (HELO localhost) ([10.124.220.244])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Mar 2026 09:44:39 -0800
From: isaku.yamahata@intel.com
To: kvm@vger.kernel.org
Cc: isaku.yamahata@intel.com,
	isaku.yamahata@gmail.com,
	Paolo Bonzini <pbonzini@redhat.com>,
	Sean Christopherson <seanjc@google.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 17/36] KVM: nVMX: Add VM entry checks related to APIC timer virtualization
Date: Thu,  5 Mar 2026 09:43:57 -0800
Message-ID: <daaf78a433b9e7448cc06da787225fb6b801ff2e.1772732517.git.isaku.yamahata@intel.com>
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

From: Isaku Yamahata <isaku.yamahata@intel.com>

Add checks of VMX controls for APIC timer virtualization on VM entries.

The spec adds some checks on VMX controls related to the APIC timer
virtualization on VM entry.

Signed-off-by: Isaku Yamahata <isaku.yamahata@intel.com>
---
 arch/x86/kvm/vmx/nested.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/x86/kvm/vmx/nested.c b/arch/x86/kvm/vmx/nested.c
index 3f1318736205..65f7260d02df 100644
--- a/arch/x86/kvm/vmx/nested.c
+++ b/arch/x86/kvm/vmx/nested.c
@@ -3069,6 +3069,12 @@ static int nested_check_vm_execution_controls(struct kvm_vcpu *vcpu,
 	    CC(!vmcs12->tsc_multiplier))
 		return -EINVAL;
 
+	if (nested_cpu_has_guest_apic_timer(vmcs12) &&
+	    (CC(!nested_cpu_has_vid(vmcs12)) ||
+	     CC(nested_cpu_has(vmcs12, CPU_BASED_RDTSC_EXITING)) ||
+	     CC(vmcs12->virtual_timer_vector > 255)))
+		return -EINVAL;
+
 	return 0;
 }
 
-- 
2.45.2

