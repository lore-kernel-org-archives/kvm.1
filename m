Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BA133C76A2;
	Wed, 29 Jul 2026 19:43:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785354225; cv=none; b=QYP38vB8KIJQMVQlRedaNIh9egoqpi4kV2cmi4l9PxucXg/fm+sqUXfkJ49j+isomBsYfvdjEsC7I343oNC/qIEyCtXWNoqLTBNNxtd+beR42hz6xn31XRQ8KdvzFKo6brsom8w0qKm9zbFnSYJICdWcDzrn5wbPj4awkWyJI4I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785354225; c=relaxed/simple;
	bh=PJ85R0g/sdegGOHOO6FWQPR+l4Q3s6OMsmAFNqmBfTA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RBhTh+FOX7j7iwz2WvefjVzhYbd/TVKhEbxA3nk8ZFMp6TqZRfFA9NwFJ78ZIBzC3fdcuxVlimG74Uusisq8EurtUi4/udWo2Tarf3/EXMKf55pWZKSUpGOe2AaWTdFIrOvs5vlxFwmofyzmA6oJuStKoO6SwnQXDBEpLjDhevE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=eBbF0yGr; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="eBbF0yGr"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1785354216; x=1816890216;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=PJ85R0g/sdegGOHOO6FWQPR+l4Q3s6OMsmAFNqmBfTA=;
  b=eBbF0yGrnY8GauzDAEUI48yRjcShEBy992MXwCcGPYAo/EZ37Fg1ChoY
   jm6w1l22pp9cVYGZOVAKwrCrWA076LcA9C8mu8ugYDgo1L5k+gICqzny3
   tOpuitxfZo74mtB/0kdFixzZTVvBPNaHzG8tMl1B3w3kD4yJ0MPgy6AXx
   GgG/O6UBuqBysYL3evQ6ta15dILP4aaVqTS4l58AeC0wtLuC7tGI6QIqh
   T6LwYj8uCmppMQfXjlRxAyvYkPsRfLi2SzPbd8bO9SchHMPY/8Q4ddhuY
   wtFxOervzlmXfGkfHzl+nepGt8DSfbjgJNwjOB8K7goijx1nIIaI9TQEs
   Q==;
X-CSE-ConnectionGUID: eFUpNFQXRPy+pEvBAkMApQ==
X-CSE-MsgGUID: XZp0sxj3SReKr8B+gcbVbQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11859"; a="103508267"
X-IronPort-AV: E=Sophos;i="6.25,193,1779174000"; 
   d="scan'208";a="103508267"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jul 2026 12:43:23 -0700
X-CSE-ConnectionGUID: D6BOjJsWTSqkM6tHCaiCpQ==
X-CSE-MsgGUID: 2Op0XJ5GSVqJXIHi/lR/Jw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,193,1779174000"; 
   d="scan'208";a="256769240"
Received: from chang-linux-3.sc.intel.com (HELO chang-linux-3) ([172.25.66.174])
  by fmviesa007.fm.intel.com with ESMTP; 29 Jul 2026 12:43:23 -0700
From: "Chang S. Bae" <chang.seok.bae@intel.com>
To: pbonzini@redhat.com,
	seanjc@google.com
Cc: kvm@vger.kernel.org,
	x86@kernel.org,
	linux-kernel@vger.kernel.org,
	chang.seok.bae@intel.com
Subject: [PATCH v6 07/20] KVM: VMX: Refactor register index retrieval from exit qualification
Date: Wed, 29 Jul 2026 19:16:43 +0000
Message-ID: <20260729191656.598771-8-chang.seok.bae@intel.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260729191656.598771-1-chang.seok.bae@intel.com>
References: <20260729191656.598771-1-chang.seok.bae@intel.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Introduce a helper to extract the register index from the VMX exit
qualification field.

In addition to the VMX instruction information field, exit qualification
also encodes a register index. This field will expand into the previously
reserved bit for extended register IDs. This refactoring will simplify
the extended register handling without code duplication.

No functional change intended.

Signed-off-by: Chang S. Bae <chang.seok.bae@intel.com>
---
V4 -> V5: Switch the argument and convert DEBUG_REG_ACCESS_REG() (review bot [*])

[*]: locally running Sashiko with gemini-3.1-pro-preview
---
 arch/x86/include/asm/vmx.h | 1 -
 arch/x86/kvm/vmx/nested.c  | 2 +-
 arch/x86/kvm/vmx/vmx.c     | 4 ++--
 arch/x86/kvm/vmx/vmx.h     | 5 +++++
 4 files changed, 8 insertions(+), 4 deletions(-)

diff --git a/arch/x86/include/asm/vmx.h b/arch/x86/include/asm/vmx.h
index 30cf48e1c390..5645a84f4fbc 100644
--- a/arch/x86/include/asm/vmx.h
+++ b/arch/x86/include/asm/vmx.h
@@ -454,7 +454,6 @@ enum vmcs_field {
 #define DEBUG_REG_ACCESS_TYPE           0x10    /* 4, direction of access */
 #define TYPE_MOV_TO_DR                  (0 << 4)
 #define TYPE_MOV_FROM_DR                (1 << 4)
-#define DEBUG_REG_ACCESS_REG(eq)        (((eq) >> 8) & 0xf) /* 11:8, general purpose reg. */
 
 
 /*
diff --git a/arch/x86/kvm/vmx/nested.c b/arch/x86/kvm/vmx/nested.c
index fdec041e95c7..8e0523e40477 100644
--- a/arch/x86/kvm/vmx/nested.c
+++ b/arch/x86/kvm/vmx/nested.c
@@ -6351,7 +6351,7 @@ static bool nested_vmx_exit_handled_cr(struct kvm_vcpu *vcpu,
 
 	switch ((exit_qualification >> 4) & 3) {
 	case 0: /* mov to cr */
-		reg = (exit_qualification >> 8) & 15;
+		reg = vmx_get_exit_qual_reg(exit_qualification);
 		val = kvm_register_read(vcpu, reg);
 		switch (cr) {
 		case 0:
diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
index c49bc6fabae3..e7f968e66bfd 100644
--- a/arch/x86/kvm/vmx/vmx.c
+++ b/arch/x86/kvm/vmx/vmx.c
@@ -5692,7 +5692,7 @@ static int handle_cr(struct kvm_vcpu *vcpu)
 
 	exit_qualification = vmx_get_exit_qual(vcpu);
 	cr = exit_qualification & 15;
-	reg = (exit_qualification >> 8) & 15;
+	reg = vmx_get_exit_qual_reg(exit_qualification);
 	switch ((exit_qualification >> 4) & 3) {
 	case 0: /* mov to cr */
 		val = kvm_register_read(vcpu, reg);
@@ -5810,7 +5810,7 @@ static int handle_dr(struct kvm_vcpu *vcpu)
 		return 1;
 	}
 
-	reg = DEBUG_REG_ACCESS_REG(exit_qualification);
+	reg = vmx_get_exit_qual_reg(exit_qualification);
 	if (exit_qualification & TYPE_MOV_FROM_DR) {
 		kvm_register_write(vcpu, reg, kvm_get_dr(vcpu, dr));
 		err = 0;
diff --git a/arch/x86/kvm/vmx/vmx.h b/arch/x86/kvm/vmx/vmx.h
index acb4d7ac8b0a..f3b0ec7ccb03 100644
--- a/arch/x86/kvm/vmx/vmx.h
+++ b/arch/x86/kvm/vmx/vmx.h
@@ -323,6 +323,11 @@ static __always_inline unsigned long vmx_get_exit_qual(struct kvm_vcpu *vcpu)
 	return vt->exit_qualification;
 }
 
+static inline int vmx_get_exit_qual_reg(unsigned long exit_qualification)
+{
+	return (exit_qualification >> 8) & 0xf;
+}
+
 static __always_inline u32 vmx_get_intr_info(struct kvm_vcpu *vcpu)
 {
 	struct vcpu_vt *vt = to_vt(vcpu);
-- 
2.53.0

