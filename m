Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.175.65.12
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794940325;
	b=kldCMYO7oJfkzV3pq2Jo6dyxFfU81DR1wzAdS1tSY8aTaKvZ+ohWhz4YlNvsvU8Y2oZy
	 f0jAZ0PwTqfgF11naXPEHpQnP2XRaho6+mMXwIf3l1JRyRWy3PyQGP7/bz1RSAtB2EBBC
	 UySvcp7j3wmojqQcAEFqs1WZo86OR5z3JcGvQbYznaWUnaDaPrir3Swdr0OQfJ+MFlpaL
	 B8KwrKW+4vh4QqD/jz1CZTxr4/bB7MtelxlQKtlP0+l1skA/fPc6j8vHhLttTvejHkgg5
	 kj3Hv7lfIkboY/yzF7bfPvyilWiBqK10Q8T0lS4yFgQBD2rq7vtTPGzj6H1ju1cHUxw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794940325;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=xfNb5UM3L2NvlH69ME4RHwaknOXMZVHE/aU+WrXiHvw=;
	b=OuZFdPQYBmYwCvbQhS6pOTRBRqFEZqElOal4L42T5tZCQySweYu5I/iJm67dRJkrPYnW
	 IYXRiroIkbJWeLOu8Ibx7ky0Co40hEVi8laN09ZgZQueBjowz8OR5WQRsAbu5Pwt/D356
	 anH5DEqwRZU89xmmgMcKrq4Zy45GJL4z424V0w8C6S5yh0wGL+0HJMLAZ+6keW3Jyz48y
	 RoFJZ89QZjR7C2haAGJnglyKJwpLatvhVymy4YNcVcq3/Hlqs8OPRPC0a0+sFa99y+/CC
	 89Pge/14FF9DMj2Xby4hIzprDa4BM1WEcYZFTPZ/jZ+za2p7xsJ9ud99pYgEf8iIlPg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=PKWlppsS;
	arc=none smtp.remote-ip=198.175.65.12
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C002660A2612;
	Tue, 17 Nov 2026 18:32:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C002660A2612
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=PKWlppsS
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1794940325; x=1826476325;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=hRYmbUZRafMOqS3M8J+52d+4USzQ4y+3X/r0fXjH6m8=;
  b=PKWlppsSkjLtps4YxPicMk5PANK93QyF2ZvkPh1kKd1Qy8M1u4QV1PDO
   DBcYCjQx7ZUt+GKflQKqAu76dD9pMxJPlQXQQ3CScLbJpYbrbeci1yyFU
   OEXBMtEgyXZNYW0Mw1rbjst4zOiF525UIqaebTWVodBd5z0bSmpssIZnp
   E+QUUYwdgXkknRWxqlTLH4GHfEUv5rijItZLyMPM35msbJnCqDql1ibqz
   No1Y573DDizzuoEND3ohpvbDknFnYGWWiCs1PRy2k9G1kYgVvrk6Z7niC
   IbxvlHg5S7vCGPUois4TrlVVzCQlJA3/Ytr7kNvEYwy+LQWHl3mkVOvQp
   A==;
X-CSE-ConnectionGUID: LB19/rE3RvOLOji8xZRaLg==
X-CSE-MsgGUID: /xDAk4foRCqYXO0BuE8LJQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11969"; a="3607282"
X-IronPort-AV: E=Sophos;i="6.27,218,1787036400"; 
   d="scan'208";a="3607282"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Nov 2026 10:30:51 -0800
X-CSE-ConnectionGUID: bM8RQdVoT++imIzQGKc5ZA==
X-CSE-MsgGUID: 0Y05uDhPSr+0uVznMctfcA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,218,1787036400"; 
   d="scan'208";a="9775047"
Received: from chang-linux-3.sc.intel.com (HELO chang-linux-3) ([172.25.66.174])
  by orviesa003.jf.intel.com with ESMTP; 17 Nov 2026 10:30:51 -0800
From: "Chang S. Bae" <chang.seok.bae@intel.com>
To: seanjc@google.com,
	jmattson@google.com
Cc: pbonzini@redhat.com,
	kvm@vger.kernel.org,
	x86@kernel.org,
	linux-kernel@vger.kernel.org,
	zhao1.liu@intel.com,
	chang.seok.bae@intel.com
Subject: [PATCH v9 08/20] KVM: VMX: Refactor register index retrieval from exit qualification
Date: Tue, 17 Nov 2026 18:02:58 +0000
Message-ID: <20261117180310.921701-9-chang.seok.bae@intel.com>
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

Introduce a helper to extract the register index from the VMX exit
qualification field.

In addition to the VMX instruction information field, exit qualification
also encodes a register index. This field will expand into the previously
reserved bit for extended register IDs. This refactoring will simplify
the extended register handling without code duplication.

No functional change intended.

Tested-by: Zhao Liu <zhao1.liu@intel.com>
Signed-off-by: Chang S. Bae <chang.seok.bae@intel.com>
Reviewed-by: Jim Mattson <jmattson@google.com>
---
V8 -> V9: Rebased on 7.4-rc1
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
index e6d77508dede..032c8988d50c 100644
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

