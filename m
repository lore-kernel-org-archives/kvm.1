Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.175.65.15
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795457880;
	b=W6oJskTx6g6/3TVyjYVmfTWwDsM+fusgPR0lEcSAnqcXQahXaGmlM5/HHiM7dJqbZu7b
	 Cux93gz/BJYxxGHiD6wPQ8MhznKjtxFIBfy32FOQowLnWZ3IjnF0A1P7YsfHYMMq+g5/p
	 JNg4155Kg04bglC3piunTmw78e263zLIWhuyr4jLjgf+X07ToWZ8Zj82o4e5jETPCE9De
	 UEVFj2HCmxD7QL/2T4IEWLiY/k9hSX4XMSLMEExLdQSBnTxpBzlzzYvy+YaSZHfYhpTM7
	 MsiRNEYaqvkHRHsWsGAbF3eBMxjjli2VrQO1G+VmilEhNgVXp4+Js4A1xkkRpnhpdXA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795457880;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=C46CwKglAwHNiJou9hRaTAIWpfitLUgFMP744CaGo5I=;
	b=Qu0Km+9s8dLET3wT3EDXFV2JMxDDcssaM7Fw67qAZPQaIeX6sd218swu/4dkL0sC1paE
	 W6r0XnowXtTN3u3BOpb4eG8H+86igDmXZqkDByOLFyppuHwHQ5EjbIzccRUTKbXzKPcjO
	 O7RCuXmRN6oDehSjmNhsacx6MEf2yXKE/zHxzY52TQLbG4Xs8jJF0eT5ukdCPLYjAN+FD
	 gD871uz+nDRZFDX5cCQlPPTgIIbyu5Aho8QQ6QBBKgBO5N693IBAJjwvHgAaxSnLC9OuX
	 ljv92c5KxFPk8mHaww9nq26m1HHxpLksUf/ZZQf9d4hsib34LpNK0n9PHGtDQKL1IzA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=XAJOafC2;
	arc=none smtp.remote-ip=198.175.65.15
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC155606A332;
	Mon, 23 Nov 2026 18:17:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CC155606A332
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=XAJOafC2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1795457880; x=1826993880;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=5nROMkrSQbmrSRfTMBcM57Mc5NyNODBJiEW4pGuoDrY=;
  b=XAJOafC2b1IRp2/4M5i8TtroTokeVdCnoLFYv80PIJZAQu6d8LaCXJvq
   8Jp7Tsk9gT3UJlGJkqyU3HoWv0HW0uG9TtBEc7BAmpBkC/YsMxU1Ks+sN
   W4696PYADPCka1Dp1ak0EsZMGBW74pF5MsMQhxkF4jex3OMrcut1dWGoE
   cprqAPWJveWVnz6EYGpp7SWIXIJMbXqZf903nwVFfBra4hVrs95NxQgX1
   5Q5NW25qXnQerjrpj/I+OlPgBhW2wlG8cFHIDvC7j0vogTVE1SSQ1kewA
   nSR4TXy2YMGGamyb/xLAvLI9wDMpvCOqjgi+VHhay9y2ka/nWJ5lHuG2y
   g==;
X-CSE-ConnectionGUID: 4WjTX9ZmT4ad+uNXMiwdCg==
X-CSE-MsgGUID: 74KrtI9hRLu8iOakerBdBw==
X-IronPort-AV: E=McAfee;i="6800,10657,11975"; a="4288767"
X-IronPort-AV: E=Sophos;i="6.27,229,1787036400"; 
   d="scan'208";a="4288767"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Nov 2026 10:05:03 -0800
X-CSE-ConnectionGUID: jW/wiaLSQ7i5DTCAfMle9g==
X-CSE-MsgGUID: yV7b5U80TGSE5RZTzbkTMw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,229,1787036400"; 
   d="scan'208";a="11241049"
Received: from chang-linux-3.sc.intel.com (HELO chang-linux-3) ([172.25.66.174])
  by orviesa004.jf.intel.com with ESMTP; 23 Nov 2026 10:05:03 -0800
From: "Chang S. Bae" <chang.seok.bae@intel.com>
To: seanjc@google.com,
	jmattson@google.com
Cc: pbonzini@redhat.com,
	kvm@vger.kernel.org,
	x86@kernel.org,
	linux-kernel@vger.kernel.org,
	zhao1.liu@intel.com,
	chang.seok.bae@intel.com
Subject: [PATCH v10 01/20] KVM: x86: Extend vCPU registers for EGPRs
Date: Mon, 23 Nov 2026 17:37:13 +0000
Message-ID: <20261123173732.1072124-2-chang.seok.bae@intel.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261123173732.1072124-1-chang.seok.bae@intel.com>
References: <20261123173732.1072124-1-chang.seok.bae@intel.com>
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Extend the storage to include extended general-purpose registers (EGPRs:
R16-R31) when CONFIG_KVM_APX=y. This option is for VMX only.

Although EGPR state is XSAVE-managed, and thus could be stored in the
guest fpstate, vCPU storage provides a more convenient and efficient
access path for KVM.

Suggested-by: Sean Christopherson <seanjc@google.com>
Signed-off-by: Chang S. Bae <chang.seok.bae@intel.com>
Reviewed-by: Jim Mattson <jmattson@google.com>
Link: https://lore.kernel.org/abL8SW5JS1aV5goa@google.com
---
V9 -> V10: Collect a review tag
---
 arch/x86/include/asm/kvm_host.h | 18 ++++++++++++++++++
 arch/x86/kvm/Kconfig            |  4 ++++
 2 files changed, 22 insertions(+)

diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_host.h
index 3efef3415f8e..7db87bc99f4a 100644
--- a/arch/x86/include/asm/kvm_host.h
+++ b/arch/x86/include/asm/kvm_host.h
@@ -168,6 +168,24 @@ enum kvm_reg {
 	VCPU_REGS_R13,
 	VCPU_REGS_R14,
 	VCPU_REGS_R15,
+#endif
+#ifdef CONFIG_KVM_APX
+	VCPU_REGS_R16,
+	VCPU_REGS_R17,
+	VCPU_REGS_R18,
+	VCPU_REGS_R19,
+	VCPU_REGS_R20,
+	VCPU_REGS_R21,
+	VCPU_REGS_R22,
+	VCPU_REGS_R23,
+	VCPU_REGS_R24,
+	VCPU_REGS_R25,
+	VCPU_REGS_R26,
+	VCPU_REGS_R27,
+	VCPU_REGS_R28,
+	VCPU_REGS_R29,
+	VCPU_REGS_R30,
+	VCPU_REGS_R31,
 #endif
 	NR_VCPU_GENERAL_PURPOSE_REGS,
 
diff --git a/arch/x86/kvm/Kconfig b/arch/x86/kvm/Kconfig
index 1719059570fb..2bee4d4791d3 100644
--- a/arch/x86/kvm/Kconfig
+++ b/arch/x86/kvm/Kconfig
@@ -102,10 +102,14 @@ config KVM_SW_PROTECTED_VM
 
 	  If unsure, say "N".
 
+config KVM_APX
+	bool
+
 config KVM_INTEL
 	tristate "KVM for Intel (and compatible) processors support"
 	depends on KVM && IA32_FEAT_CTL
 	select X86_FRED if X86_64
+	select KVM_APX if X86_64
 	help
 	  Provides support for KVM on processors equipped with Intel's VT
 	  extensions, a.k.a. Virtual Machine Extensions (VMX).
-- 
2.53.0

