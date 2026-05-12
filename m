Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBB73314B63;
	Tue, 12 May 2026 01:40:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778550029; cv=none; b=tpKYdsigYBFeOEHkBcq9crV9I2w/ZmOxQGkIyb4HL8zMZpjaWPxWgPr91kDk/jPz/HmUXKfvvI75T64kwvh+izT2XMV+BDH76qWC8wGOJvVZfmKzApVAJzqJIT6fDJKNxCihIAtrjJrD/gm4IJhv/Loll+jE4cFXsSFejC5qtRo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778550029; c=relaxed/simple;
	bh=Bjyb8i8QCZsaf45fBSvmcMkyl9IEGZBeGxkiqG4yDgk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=crSt0QsGrgDPcCgaMilLYZnyMxQ5o3/Qrss6p65t3Luh9nDfQRNnN+IhxqBLvoU3IwGTZ/tOCRhYeggBCLG2P0b1EYNvnsHMeUzevW1/+n+VjfkSr6Vhm+oIwva4uhhZivQDQTk8nqBxTij6D3caLSEpfqa3XbvDO9+oL2rDgUw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=aHiu73Is; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="aHiu73Is"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1778550028; x=1810086028;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Bjyb8i8QCZsaf45fBSvmcMkyl9IEGZBeGxkiqG4yDgk=;
  b=aHiu73Is0/aQgV6xw0wlVdGXh9GCQvyOfN4AbvugzjTcAfuYECygbm7N
   cNg8RwL1eEZZClP78Zy5wOCa72Hzpxw0itZF5gWgwy1C93IpBXYQfbARQ
   1lKNxSUKnwXEsqodNQKQUodbt1qN5rqvNB2fNfq9Kw6HSbUdGU6n4yWxq
   UuoPcxTk6DlJ0ATl7GllWvD2uzIC/CuxWFj3ofgtHwlds6v2HMcSOcQwy
   2Yxk2b+h3nmpFIPSA/7vG2Wt++hFlKPFhM3hvjyzWo2m/vGZSLxDozyD8
   ONpwmN4nJulxQ317toqKtE31sq6CdHsR72vg7y2WvYVMkgMYxkdFv/BvI
   g==;
X-CSE-ConnectionGUID: 5qifv9q/RSSZ3qRn3EWDTQ==
X-CSE-MsgGUID: jTDJflVcS/K5q9o5mwYxhw==
X-IronPort-AV: E=McAfee;i="6800,10657,11783"; a="83322148"
X-IronPort-AV: E=Sophos;i="6.23,230,1770624000"; 
   d="scan'208";a="83322148"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 May 2026 18:40:26 -0700
X-CSE-ConnectionGUID: Wdl5SmkTTGOyaUa4Gh/kEw==
X-CSE-MsgGUID: JIKtxrFqQoyeOan+M8dUDw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,230,1770624000"; 
   d="scan'208";a="234572789"
Received: from chang-linux-3.sc.intel.com (HELO chang-linux-3) ([172.25.66.106])
  by fmviesa007.fm.intel.com with ESMTP; 11 May 2026 18:40:25 -0700
From: "Chang S. Bae" <chang.seok.bae@intel.com>
To: pbonzini@redhat.com,
	seanjc@google.com
Cc: kvm@vger.kernel.org,
	x86@kernel.org,
	linux-kernel@vger.kernel.org,
	chao.gao@intel.com,
	chang.seok.bae@intel.com
Subject: [PATCH v4 10/21] KVM: VMX: Refactor register index retrieval from exit qualification
Date: Tue, 12 May 2026 01:14:51 +0000
Message-ID: <20260512011502.53072-11-chang.seok.bae@intel.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260512011502.53072-1-chang.seok.bae@intel.com>
References: <20260512011502.53072-1-chang.seok.bae@intel.com>
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

Since the VMCS exit qualification is cached in VCPU state, the helper can
reference it efficiently via vmx_get_exit_qual().

No functional change intended.

Signed-off-by: Chang S. Bae <chang.seok.bae@intel.com>
---
 arch/x86/kvm/vmx/nested.c | 2 +-
 arch/x86/kvm/vmx/vmx.c    | 2 +-
 arch/x86/kvm/vmx/vmx.h    | 5 +++++
 3 files changed, 7 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kvm/vmx/nested.c b/arch/x86/kvm/vmx/nested.c
index bf2fe6a034aa..cc804a843e76 100644
--- a/arch/x86/kvm/vmx/nested.c
+++ b/arch/x86/kvm/vmx/nested.c
@@ -6345,7 +6345,7 @@ static bool nested_vmx_exit_handled_cr(struct kvm_vcpu *vcpu,
 
 	switch ((exit_qualification >> 4) & 3) {
 	case 0: /* mov to cr */
-		reg = (exit_qualification >> 8) & 15;
+		reg = vmx_get_exit_qual_reg(vcpu);
 		val = kvm_register_read(vcpu, reg);
 		switch (cr) {
 		case 0:
diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
index 10724b7fd405..f13d56bc32d1 100644
--- a/arch/x86/kvm/vmx/vmx.c
+++ b/arch/x86/kvm/vmx/vmx.c
@@ -5670,7 +5670,7 @@ static int handle_cr(struct kvm_vcpu *vcpu)
 
 	exit_qualification = vmx_get_exit_qual(vcpu);
 	cr = exit_qualification & 15;
-	reg = (exit_qualification >> 8) & 15;
+	reg = vmx_get_exit_qual_reg(vcpu);
 	switch ((exit_qualification >> 4) & 3) {
 	case 0: /* mov to cr */
 		val = kvm_register_read(vcpu, reg);
diff --git a/arch/x86/kvm/vmx/vmx.h b/arch/x86/kvm/vmx/vmx.h
index 345b10d28231..f71ae8d2c338 100644
--- a/arch/x86/kvm/vmx/vmx.h
+++ b/arch/x86/kvm/vmx/vmx.h
@@ -323,6 +323,11 @@ static __always_inline unsigned long vmx_get_exit_qual(struct kvm_vcpu *vcpu)
 	return vt->exit_qualification;
 }
 
+static inline int vmx_get_exit_qual_reg(struct kvm_vcpu *vcpu)
+{
+	return (vmx_get_exit_qual(vcpu) >> 8) & 0xf;
+}
+
 static __always_inline u32 vmx_get_intr_info(struct kvm_vcpu *vcpu)
 {
 	struct vcpu_vt *vt = to_vt(vcpu);
-- 
2.51.0

