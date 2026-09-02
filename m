Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27A8F36AB57;
	Wed,  2 Sep 2026 02:44:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788317092; cv=none; b=LwVIx7pkh1SVIRzrdesUdCJ9C5EhjJ8UlGhut2qaWDMbNrDhLzela+P9R5fEZDUyV7Z6yhxg6HJgD1JoPekfK0ZmM53uIW+dZ9u1MPJ9ylYG/ufRmdxhwrk3XoOx/jVve0tUZn9QhG6egZIFlmSdGeU9gzLA2v7E22kCPqepP6E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788317092; c=relaxed/simple;
	bh=RL65f7EDKUEQ9XSJAqafHAlJTrE7XGsp69kEVatuzKg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=D5K/tSrJe99X/uK8rN1APCGcA7/7gL5LCcZ/e3v/dedUKgiX2UsMeuU6q2nb9cpj9lyojJn9q08gO6hcR4d75m0OxJnnwrmzUk2mUKoLl8QYW0TIxeWWOvWsx1UVnpfsWQXqFsF46jrF8cy60tOZpiMwwdklEyMrypnwCZ4SW8o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=VfwO+II2; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="VfwO+II2"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1788317090; x=1819853090;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=RL65f7EDKUEQ9XSJAqafHAlJTrE7XGsp69kEVatuzKg=;
  b=VfwO+II2k+FVB6p7yU02pt+l1n+el5IleMZINuNkOqgUtcBBC5R9E8kW
   uo9q58fY7CGagWdSYgui4/BcPtK1l3TRb/QGxTK+8RF02A1Mt0MLULyb5
   dKWfWQYayPm3Qdskr8gLkgvfFSKIDoWtp6zWHvaob7/t6g9Dzf7KbFq8s
   2lCmS41b+2JYJ+TYWtj6HImSxmxlTzHID65QxnOV45qo2ZvvU+iNTVvMe
   mvfA8gNV8xb2RR8tGU1IqYHvjFaU9w6bu3kNjMCL0xp97LYs+OZdYt5wF
   LFwG8UyJzxkEskjufLCck1lNZalIqKClQY3Wt6hrtNNTVoio4kvaQmAPM
   Q==;
X-CSE-ConnectionGUID: b5hbsW8lTQmMNlIMuTqB6w==
X-CSE-MsgGUID: FhffEgzGSmOfA79ucdHCKQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11893"; a="106282918"
X-IronPort-AV: E=Sophos;i="6.25,257,1779174000"; 
   d="scan'208";a="106282918"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Sep 2026 19:44:50 -0700
X-CSE-ConnectionGUID: TZE3D6LEQGascRUytYvFpA==
X-CSE-MsgGUID: S9aCXJf7Qx+05et6m7N+mQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,257,1779174000"; 
   d="scan'208";a="272775507"
Received: from chang-linux-3.sc.intel.com (HELO chang-linux-3) ([172.25.66.174])
  by orviesa003.jf.intel.com with ESMTP; 01 Sep 2026 19:44:50 -0700
From: "Chang S. Bae" <chang.seok.bae@intel.com>
To: pbonzini@redhat.com,
	seanjc@google.com
Cc: kvm@vger.kernel.org,
	x86@kernel.org,
	linux-kernel@vger.kernel.org,
	chang.seok.bae@intel.com
Subject: [PATCH v7 07/20] KVM: VMX: Refactor register index retrieval from exit qualification
Date: Wed,  2 Sep 2026 02:17:51 +0000
Message-ID: <20260902021804.718676-8-chang.seok.bae@intel.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260902021804.718676-1-chang.seok.bae@intel.com>
References: <20260902021804.718676-1-chang.seok.bae@intel.com>
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
 arch/x86/include/asm/vmx.h | 1 -
 arch/x86/kvm/vmx/nested.c  | 2 +-
 arch/x86/kvm/vmx/vmx.c     | 4 ++--
 arch/x86/kvm/vmx/vmx.h     | 5 +++++
 4 files changed, 8 insertions(+), 4 deletions(-)

diff --git a/arch/x86/include/asm/vmx.h b/arch/x86/include/asm/vmx.h
index 68835ad9af71..f98e40df5004 100644
--- a/arch/x86/include/asm/vmx.h
+++ b/arch/x86/include/asm/vmx.h
@@ -455,7 +455,6 @@ enum vmcs_field {
 #define DEBUG_REG_ACCESS_TYPE           0x10    /* 4, direction of access */
 #define TYPE_MOV_TO_DR                  (0 << 4)
 #define TYPE_MOV_FROM_DR                (1 << 4)
-#define DEBUG_REG_ACCESS_REG(eq)        (((eq) >> 8) & 0xf) /* 11:8, general purpose reg. */
 
 
 /*
diff --git a/arch/x86/kvm/vmx/nested.c b/arch/x86/kvm/vmx/nested.c
index f05ac3c9aa12..7229934c38bb 100644
--- a/arch/x86/kvm/vmx/nested.c
+++ b/arch/x86/kvm/vmx/nested.c
@@ -6358,7 +6358,7 @@ static bool nested_vmx_exit_handled_cr(struct kvm_vcpu *vcpu,
 
 	switch ((exit_qualification >> 4) & 3) {
 	case 0: /* mov to cr */
-		reg = (exit_qualification >> 8) & 15;
+		reg = vmx_get_exit_qual_reg(exit_qualification);
 		val = kvm_register_read(vcpu, reg);
 		switch (cr) {
 		case 0:
diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
index bd8505d69420..ee975a1ae42f 100644
--- a/arch/x86/kvm/vmx/vmx.c
+++ b/arch/x86/kvm/vmx/vmx.c
@@ -5698,7 +5698,7 @@ static int handle_cr(struct kvm_vcpu *vcpu)
 
 	exit_qualification = vmx_get_exit_qual(vcpu);
 	cr = exit_qualification & 15;
-	reg = (exit_qualification >> 8) & 15;
+	reg = vmx_get_exit_qual_reg(exit_qualification);
 	switch ((exit_qualification >> 4) & 3) {
 	case 0: /* mov to cr */
 		val = kvm_register_read(vcpu, reg);
@@ -5816,7 +5816,7 @@ static int handle_dr(struct kvm_vcpu *vcpu)
 		return 1;
 	}
 
-	reg = DEBUG_REG_ACCESS_REG(exit_qualification);
+	reg = vmx_get_exit_qual_reg(exit_qualification);
 	if (exit_qualification & TYPE_MOV_FROM_DR) {
 		kvm_register_write(vcpu, reg, kvm_get_dr(vcpu, dr));
 		err = 0;
diff --git a/arch/x86/kvm/vmx/vmx.h b/arch/x86/kvm/vmx/vmx.h
index 92eed58f48ad..863b08478544 100644
--- a/arch/x86/kvm/vmx/vmx.h
+++ b/arch/x86/kvm/vmx/vmx.h
@@ -330,6 +330,11 @@ static __always_inline unsigned long vmx_get_exit_qual(struct kvm_vcpu *vcpu)
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

