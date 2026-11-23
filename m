Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.175.65.15
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795457885;
	b=N9wU9t3+eVaL8mgMv1AIIP6XvAdzSlXa7huhnWcda169/UC2gIz7VIYyttU4/b/N7Vob
	 TocFHnYSDDLrvX4Z4XE8ghLUbbGoByS89H7w9fxWe4TBEYA6cTe2Xj3krV3PrGUhBI/sO
	 VUzuoOZZ/Vh13B+hDapHbZqrAbeCBQXlvFqaWsvaeatIzCXd5XSoOWGAnRUsYfYP+CGUn
	 jXQIwZaWZLDoResJj/pbhIB8cXBgOi47ogtqvJktPzoNELNk2oT+1zakrRCalWFqSxFZm
	 nSymULAnFFwaS/RxfZOpGD8nZivCceK4uo6tywN82Mxg75gh2LfdjXNE4SBDO7o49LQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795457885;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=0TgDBSXpayGyCgjpf21JsFwt3uClnKu/La7ucTj3rMs=;
	b=NisgcdwiJEsVQmHal7vIJbRJSO6Bs/IPmVqbuDXmU0BRgLMUhdOp7q2neokPEIehJhme
	 BCcx3AisNZNL1/uh6WhKez5CTEgHyv6ZeDN0+0eVKB7jpiXvBGTZTTE/KYBI2DPGSzRXV
	 ZHfHKHa+/cZZTL3cnelpUe5Ho+Sm2q8/rtDmLDNdAv2x+JTyLCHlW36jXTZ7dCE43P5AL
	 OBms1a8B/DXNvcYJZDaOFLJJR2SrF+Tbg+6HuG7tagq38n5KR/NbcqZcCle05Bq35qw1S
	 GPE/qDIkxq022/ScBFyJjWfL6JcM+TyNdtJc/67t9oD15VABihRcaB2nzTST8Wub8qg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b="DIKld/EN";
	arc=none smtp.remote-ip=198.175.65.15
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24ED360A2637;
	Mon, 23 Nov 2026 18:18:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 24ED360A2637
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=DIKld/EN
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1795457885; x=1826993885;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=XRDYEuSyxNBUVIXVsTpgbxFpiBYR4+zxqdTyaPHl66E=;
  b=DIKld/ENI4qvIare/MwzX5Gi84H0YQqo34W3VVplwi+mb9f1ElwFvixE
   dnq2zaYkdjK3HMcdbA/nUMxPlCFD2BY5NEyZIWG8bBORM0rxaKkLgkHvs
   4xRQZL2Tk1QfVQ79hypnFurrZihr/JIKZwePuDKLjxctZFhGL8dwTEoik
   c2s5K+8O6U4Dbjbs1rp4gCPZ9RlVvU9EK/pn0SfarxjM+8oSUJdywQf9z
   w3TnwbykHUu2lRJCs58k45ZnW1xxQmIwjBGKVwtGkHyIzWqO+Lfn/cWkO
   2vsXGQsJN7qttu6c42l2uRaqBXSZrhclw/R40j/66A8IWTLwOeueDuadm
   A==;
X-CSE-ConnectionGUID: i4gcdhuSQ3WjP01ZobOHoA==
X-CSE-MsgGUID: ekEmPtjET6qBCB9jWgruww==
X-IronPort-AV: E=McAfee;i="6800,10657,11975"; a="4288815"
X-IronPort-AV: E=Sophos;i="6.27,229,1787036400"; 
   d="scan'208";a="4288815"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Nov 2026 10:05:17 -0800
X-CSE-ConnectionGUID: dJhiiBWySYGg6DBmqL8tUw==
X-CSE-MsgGUID: 7YYHezQyTj2t82kgSqpOzw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,229,1787036400"; 
   d="scan'208";a="11241117"
Received: from chang-linux-3.sc.intel.com (HELO chang-linux-3) ([172.25.66.174])
  by orviesa004.jf.intel.com with ESMTP; 23 Nov 2026 10:05:17 -0800
From: "Chang S. Bae" <chang.seok.bae@intel.com>
To: seanjc@google.com,
	jmattson@google.com
Cc: pbonzini@redhat.com,
	kvm@vger.kernel.org,
	x86@kernel.org,
	linux-kernel@vger.kernel.org,
	zhao1.liu@intel.com,
	chang.seok.bae@intel.com
Subject: [PATCH v10 08/20] KVM: VMX: Refactor register index retrieval from exit qualification
Date: Mon, 23 Nov 2026 17:37:20 +0000
Message-ID: <20261123173732.1072124-9-chang.seok.bae@intel.com>
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

Introduce a helper to extract the register index from the VMX exit
qualification field.

In addition to the VMX instruction information field, exit qualification
also encodes a register index. This field will expand into the previously
reserved bit for extended register IDs. This refactoring will simplify
the extended register handling without code duplication.

No functional change intended.

Signed-off-by: Chang S. Bae <chang.seok.bae@intel.com>
Tested-by: Zhao Liu <zhao1.liu@intel.com>
Reviewed-by: Jim Mattson <jmattson@google.com>
---
 arch/x86/include/asm/vmx.h | 1 -
 arch/x86/kvm/vmx/common.h  | 5 +++++
 arch/x86/kvm/vmx/nested.c  | 2 +-
 arch/x86/kvm/vmx/vmx.c     | 4 ++--
 4 files changed, 8 insertions(+), 4 deletions(-)

diff --git a/arch/x86/include/asm/vmx.h b/arch/x86/include/asm/vmx.h
index def6d3a6d154..3c5019da4b71 100644
--- a/arch/x86/include/asm/vmx.h
+++ b/arch/x86/include/asm/vmx.h
@@ -463,7 +463,6 @@ enum vmcs_field {
 #define DEBUG_REG_ACCESS_TYPE           0x10    /* 4, direction of access */
 #define TYPE_MOV_TO_DR                  (0 << 4)
 #define TYPE_MOV_FROM_DR                (1 << 4)
-#define DEBUG_REG_ACCESS_REG(eq)        (((eq) >> 8) & 0xf) /* 11:8, general purpose reg. */
 
 
 /*
diff --git a/arch/x86/kvm/vmx/common.h b/arch/x86/kvm/vmx/common.h
index b2905335a2d2..30b0aa9560d5 100644
--- a/arch/x86/kvm/vmx/common.h
+++ b/arch/x86/kvm/vmx/common.h
@@ -110,6 +110,11 @@ static __always_inline unsigned long vt_get_exit_qual(struct kvm_vcpu *vcpu)
 	return vt->exit_qualification;
 }
 
+static __always_inline int vt_get_exit_qual_reg(unsigned long exit_qualification)
+{
+	return (exit_qualification >> 8) & 0xf;
+}
+
 static __always_inline u32 vt_get_intr_info(struct kvm_vcpu *vcpu)
 {
 	struct vcpu_vt *vt = to_vt(vcpu);
diff --git a/arch/x86/kvm/vmx/nested.c b/arch/x86/kvm/vmx/nested.c
index da73ed81d99c..aebdad142d67 100644
--- a/arch/x86/kvm/vmx/nested.c
+++ b/arch/x86/kvm/vmx/nested.c
@@ -6346,7 +6346,7 @@ static bool nested_vmx_exit_handled_cr(struct kvm_vcpu *vcpu,
 
 	switch ((exit_qualification >> 4) & 3) {
 	case 0: /* mov to cr */
-		reg = (exit_qualification >> 8) & 15;
+		reg = vt_get_exit_qual_reg(exit_qualification);
 		val = kvm_register_read(vcpu, reg);
 		switch (cr) {
 		case 0:
diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
index d53f6e63de50..87a84157a51a 100644
--- a/arch/x86/kvm/vmx/vmx.c
+++ b/arch/x86/kvm/vmx/vmx.c
@@ -5698,7 +5698,7 @@ static int handle_cr(struct kvm_vcpu *vcpu)
 
 	exit_qualification = vt_get_exit_qual(vcpu);
 	cr = exit_qualification & 15;
-	reg = (exit_qualification >> 8) & 15;
+	reg = vt_get_exit_qual_reg(exit_qualification);
 	switch ((exit_qualification >> 4) & 3) {
 	case 0: /* mov to cr */
 		val = kvm_register_read(vcpu, reg);
@@ -5817,7 +5817,7 @@ static int handle_dr(struct kvm_vcpu *vcpu)
 		return 1;
 	}
 
-	reg = DEBUG_REG_ACCESS_REG(exit_qualification);
+	reg = vt_get_exit_qual_reg(exit_qualification);
 	if (exit_qualification & TYPE_MOV_FROM_DR) {
 		kvm_register_write(vcpu, reg, kvm_get_dr(vcpu, dr));
 		err = 0;
-- 
2.53.0

