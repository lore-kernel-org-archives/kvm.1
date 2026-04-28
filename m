Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26CF6351C04;
	Tue, 28 Apr 2026 05:26:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777353992; cv=none; b=hnoEp31UqL5XVIK/ZeiQ/2NEw8BV1L0zsuVEfKMtF8u22nXhGA/VoJHqpSsK/7uYvmMFLO7u/f4Vc7jMiNMX6bf7JMafx5aPHucBSyMZXGLSUiuJ0LK54q4I63QLbf5u1Ru3+sXlqfSorH8p+A041WiwIs+6iElKbCFQy04p9t8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777353992; c=relaxed/simple;
	bh=slAxert0QA+yvbOpC/NSth3jMh3A/D/5AhrvVCNudRE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mO5fewEqGUcdYboe70bVI//Pr4kk8MI2ctIH4mF4EtpsZUo2758seoEDxM4aXa++dHzHVsXuQGfPiQA2Ycd3XDeE4OoX/BQje7XRbeh/H618eRJrmVZRL84mGOjjktXT6efkQIZ0CNkUDTbs32Cm/w+ffLdBX8y6v2JVH93q31w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=n2dX0qSb; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="n2dX0qSb"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1777353986; x=1808889986;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=slAxert0QA+yvbOpC/NSth3jMh3A/D/5AhrvVCNudRE=;
  b=n2dX0qSbRL8jJoXn5theA8ytc8+vq7iyyw8FyA6qjsZ1yplZKqgevect
   ySPktxzdty6ovypNSQrXwZHOPb3MlZfJx39ag71PEmNE4w8ADkvG1ioov
   0PUrqXrWXHawOu5cuub4VsK6mMq6HX7/suwq/kA//aoTIjuFkT1uhT+2Q
   Sc6dJQHKuZ8AnMbdXgC0Nnffyw/j9Qye/nM/P81Q67uB34FDiSeqDEuHj
   iIsB7FUCN6junuFr5SomcLrgfNDtWM0vZmOgulm26Oey5HibIHVs/APl4
   g7bs35pWimFpuT0lu2hibPHbhPkLNZHiyuM1L2zUzeKcwo516nGqYqvif
   g==;
X-CSE-ConnectionGUID: qW0YIraDS4CsUHOh7Dnsrg==
X-CSE-MsgGUID: h660bbUMS3KiG67xoZZFpw==
X-IronPort-AV: E=McAfee;i="6800,10657,11769"; a="78131707"
X-IronPort-AV: E=Sophos;i="6.23,203,1770624000"; 
   d="scan'208";a="78131707"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Apr 2026 22:26:25 -0700
X-CSE-ConnectionGUID: 22yeQt4NSr6u66tYuRhVXQ==
X-CSE-MsgGUID: 6Xp8jEpoTdm2xOZgCReo/w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,203,1770624000"; 
   d="scan'208";a="234130196"
Received: from chang-linux-3.sc.intel.com (HELO chang-linux-3) ([172.25.66.106])
  by orviesa007.jf.intel.com with ESMTP; 27 Apr 2026 22:26:25 -0700
From: "Chang S. Bae" <chang.seok.bae@intel.com>
To: pbonzini@redhat.com,
	seanjc@google.com
Cc: kvm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	chao.gao@intel.com,
	chang.seok.bae@intel.com
Subject: [PATCH v3 09/20] KVM: VMX: Refactor register index retrieval from exit qualification
Date: Tue, 28 Apr 2026 05:01:00 +0000
Message-ID: <20260428050111.39323-10-chang.seok.bae@intel.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260428050111.39323-1-chang.seok.bae@intel.com>
References: <20260428050111.39323-1-chang.seok.bae@intel.com>
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
V2 -> V3: s/GPR/register (Sean)
---
 arch/x86/kvm/vmx/nested.c | 2 +-
 arch/x86/kvm/vmx/vmx.c    | 2 +-
 arch/x86/kvm/vmx/vmx.h    | 5 +++++
 3 files changed, 7 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kvm/vmx/nested.c b/arch/x86/kvm/vmx/nested.c
index 6fa8f2a46202..a1ecde280ecc 100644
--- a/arch/x86/kvm/vmx/nested.c
+++ b/arch/x86/kvm/vmx/nested.c
@@ -6332,7 +6332,7 @@ static bool nested_vmx_exit_handled_cr(struct kvm_vcpu *vcpu,
 
 	switch ((exit_qualification >> 4) & 3) {
 	case 0: /* mov to cr */
-		reg = (exit_qualification >> 8) & 15;
+		reg = vmx_get_exit_qual_reg(vcpu);
 		val = kvm_register_read(vcpu, reg);
 		switch (cr) {
 		case 0:
diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
index c7b3c1916b09..081d2ad6a8b2 100644
--- a/arch/x86/kvm/vmx/vmx.c
+++ b/arch/x86/kvm/vmx/vmx.c
@@ -5653,7 +5653,7 @@ static int handle_cr(struct kvm_vcpu *vcpu)
 
 	exit_qualification = vmx_get_exit_qual(vcpu);
 	cr = exit_qualification & 15;
-	reg = (exit_qualification >> 8) & 15;
+	reg = vmx_get_exit_qual_reg(vcpu);
 	switch ((exit_qualification >> 4) & 3) {
 	case 0: /* mov to cr */
 		val = kvm_register_read(vcpu, reg);
diff --git a/arch/x86/kvm/vmx/vmx.h b/arch/x86/kvm/vmx/vmx.h
index 272bf250200b..4d29d32fa87c 100644
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

