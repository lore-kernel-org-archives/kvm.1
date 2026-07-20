Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D5BC44CF39;
	Mon, 20 Jul 2026 17:46:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784569583; cv=none; b=nsWmhVsUhaKxot8D1oHlOixAvwH0mC+PRu8Ry1NE2gZJNsborbqLpIcBffcHbszOknKT2uySaWdSXjurEbiOP7mfzU36/mewd69vBnrbGi2+EnpRhvtP76YcwPJ1Doe2NXBQ43eEiTDneAIxvRFqvk8YtUWu+PmgMol46kyf4M4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784569583; c=relaxed/simple;
	bh=PJ85R0g/sdegGOHOO6FWQPR+l4Q3s6OMsmAFNqmBfTA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SpKgYHE1M81LsTZaX4FK/aROCTLvEtHEz3FI5GsugXX1WA/2BtioblMXCnSinOIe1kRFSdScDePMKy/tjIx6W1YyZJhJ3uJkDzl6Fi3VjPUpf60rCdkp05Em6ANyUQA2MdRGxMyZ2cyLFVYJHJDU8P/Z7qNlWOxBxVyARLac1SA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=e6AYzKzB; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="e6AYzKzB"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1784569580; x=1816105580;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=PJ85R0g/sdegGOHOO6FWQPR+l4Q3s6OMsmAFNqmBfTA=;
  b=e6AYzKzBY0el80G4eSov5Wrnmb04RQguIwPARqFLiaYHJYnzBmlnroG2
   rVqvG6W6IxFrmjd/q1oEs5vH0GEvDanWc0eBQoZq7tiB7SlZ1w9LxtaZY
   pCQyjABwIK8owfFIMbQ/rvOAMG6gV6oEY6nkGjfu6/DqoTH3qEwMjDXGa
   FpKYjU3nF2m++eUefgZuteV8Yd2GoSEBmP3dLyLBhMpxt9oKuSqgtAblz
   tsYIEToP6F3OqmzXvLQhasKooBtVTtelJVCBIQ7CmwQ80MyzXwsqOHbKJ
   xDxMMw8DLjfiWawRuexN0yq1lP1wSCepBJigC+VK+xLNGYYZ7Ix5V6hQI
   A==;
X-CSE-ConnectionGUID: IzNlSV2zTOyFkzTYeAGoQQ==
X-CSE-MsgGUID: DXWPoYsbSry9y2EKW+IrAQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11852"; a="72691661"
X-IronPort-AV: E=Sophos;i="6.25,175,1779174000"; 
   d="scan'208";a="72691661"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jul 2026 10:46:03 -0700
X-CSE-ConnectionGUID: OdvC4JmQT46PjYmO68BW8Q==
X-CSE-MsgGUID: L9QO2YeARdqhRX2lnjCf7A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,175,1779174000"; 
   d="scan'208";a="257575357"
Received: from chang-linux-3.sc.intel.com (HELO chang-linux-3) ([172.25.66.174])
  by orviesa007.jf.intel.com with ESMTP; 20 Jul 2026 10:46:02 -0700
From: "Chang S. Bae" <chang.seok.bae@intel.com>
To: pbonzini@redhat.com,
	seanjc@google.com
Cc: kvm@vger.kernel.org,
	x86@kernel.org,
	linux-kernel@vger.kernel.org,
	chang.seok.bae@intel.com
Subject: [PATCH v5 07/20] KVM: VMX: Refactor register index retrieval from exit qualification
Date: Mon, 20 Jul 2026 17:19:36 +0000
Message-ID: <20260720171949.498680-8-chang.seok.bae@intel.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260720171949.498680-1-chang.seok.bae@intel.com>
References: <20260720171949.498680-1-chang.seok.bae@intel.com>
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

