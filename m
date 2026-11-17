Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.175.65.12
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794940286;
	b=zR/1cb/JBsRtDAprLnBJqb2ewxECFQBzUGSY7u53Y/GziU9b5DNmP656EP8UDo+P3PJh
	 lRACgrLASWcGb4d76xyuu0t2Xo5ZyIWd/05EnZiEWyFmsPmF4rZwCjwnbgugpi1uJf2ho
	 DoCOgQ9xt1jc6a6OJ88UqXA3WAXoul4n1DJU1a464utnwEliDRXBW2jcmbay3hDiqqCiI
	 U3YzA+bL1l9iEvHCE19Kl37Ld23ErcviYXEqfw816a1PybnOJf9JGiuDpg8lsmmjIG1JR
	 kbzz7zRUKEYejulAy6RU0J5CXcva1kB3kUS71keZIYb4VFBk8iJa8SmHpZILOi/T8Gw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794940286;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=cdrq3L07Ufe8h7bk1nCLLo8z5oriaJu+j1AqBe3JoOs=;
	b=rnnEw0vbIPHdXLTsRtHsLqXIPWCnilqeY4dXx8WhDoiBZFqHhSyi/UDQl+bJupiYGHgC
	 x3Gr94WjIs8RtNE4IQE4BJr62aetUB3SH+kfbnb2HcoJ2/u6LWaY+leMKhe1IqcGXiNjr
	 MUvyJG73vkle9VZea/RX7wc8H7B8GKMjHLJQC03udcqh1FWs4I0Ocnzr66vjnK8uXVYXZ
	 HcNDfASSk9RCDdVpm9TmOLMUZ222a7J6xx6UqeN/Ux+T91lPOdUTeO8lunrYjcfxgrDJR
	 keWFzKawedDzURbhzCdPcbXKRibCT9qMQiVb1I48p8I7IFdCgTQYcw5oyYG0O7MFBmA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=B8n4rni7;
	arc=none smtp.remote-ip=198.175.65.12
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F466606A32C;
	Tue, 17 Nov 2026 18:31:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8F466606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=B8n4rni7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1794940285; x=1826476285;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=+DcCKiIe2nzX1vzAuYRanN6Uu5mAD6Xed/X14o+5dn8=;
  b=B8n4rni7AKf7WoQRJkJfFsirg99xNJD+0EcgpYlTGthJX947pUTXch/S
   7kwpZv1v2Ruv4frXm1YwBx1/+/qd/40BKt4nZxNtV8W6xXtBpdRCW10MU
   ZpwLB78+4TAh+dkYW52W74z3WFCTRk97yDH52OFzTI6oj1OECaai527gS
   w+grfo4JiiqUW1vqQGN6UFmjxNcIlugB3hLbbTF++mUlAHk9GZMmyZ0Y2
   kCw5CXzvIrJTq+N4HuAwVOMLPWMduWtahrTRdv1PKnklMiOaQ8Xg84nlx
   bKnMXLs08DSpXzC7ZnYCIjTsJqkXB/thGZEI337gmx6AUSDmnSJH8KMEr
   Q==;
X-CSE-ConnectionGUID: GbtCGFuWTIWdWWoUnjIsZw==
X-CSE-MsgGUID: 8GannG2DQK2dPuskBUgP2w==
X-IronPort-AV: E=McAfee;i="6800,10657,11969"; a="3607158"
X-IronPort-AV: E=Sophos;i="6.27,218,1787036400"; 
   d="scan'208";a="3607158"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Nov 2026 10:30:38 -0800
X-CSE-ConnectionGUID: mkmjkbBYTWyv8oEidwmWAA==
X-CSE-MsgGUID: 8K9WKYjDQoeO/iOPhxmltQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,218,1787036400"; 
   d="scan'208";a="9774974"
Received: from chang-linux-3.sc.intel.com (HELO chang-linux-3) ([172.25.66.174])
  by orviesa003.jf.intel.com with ESMTP; 17 Nov 2026 10:30:39 -0800
From: "Chang S. Bae" <chang.seok.bae@intel.com>
To: seanjc@google.com,
	jmattson@google.com
Cc: pbonzini@redhat.com,
	kvm@vger.kernel.org,
	x86@kernel.org,
	linux-kernel@vger.kernel.org,
	zhao1.liu@intel.com,
	chang.seok.bae@intel.com
Subject: [PATCH v9 01/20] KVM: x86: Extend VCPU registers for EGPRs
Date: Tue, 17 Nov 2026 18:02:51 +0000
Message-ID: <20261117180310.921701-2-chang.seok.bae@intel.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261117180310.921701-1-chang.seok.bae@intel.com>
References: <20261117180310.921701-1-chang.seok.bae@intel.com>
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
guest fpstate, VCPU storage provides a more convenient and efficient
access path for KVM.

Suggested-by: Sean Christopherson <seanjc@google.com>
Signed-off-by: Chang S. Bae <chang.seok.bae@intel.com>
Link: https://lore.kernel.org/abL8SW5JS1aV5goa@google.com
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

