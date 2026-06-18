Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 438BB3DE431;
	Thu, 18 Jun 2026 08:40:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781772013; cv=none; b=SXP9W2C8J0YlCkWRZJnvZqY+fkRy8LKwdeSkKGBx3woLXQ+aRK7SqRAs9j0BbSpDnSY4plrGEmRrTp9w2dVVdq9sdtrRgYH6XlretXqGnPxPhGhyi8Lwgztqp7LxwEh34CAJq8fHTFsH1+UHdWLTvW233OPceV+0+ycw71bVvSw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781772013; c=relaxed/simple;
	bh=Xa01T1gUjy2VL5pNRL4ZIoRm2jaAiGoaKWcWyUagBco=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=H5W93zoApGUgq3Xl84hb9/pBJ8fb+82xxa8v08b1sGAEY2fopZqBYiyk/llBGdz4Ij4KXHSwBsMkXmGBQFV+RaG7u1j3bD4hF+84/ArInY66FRTdCoZAxv0dHJHzOy8FsNMMGW6SOqnttpbehLZPH2t+6CVGAzLCG8Nmbw0eZjM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=F+BOxwCz; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="F+BOxwCz"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1781772012; x=1813308012;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Xa01T1gUjy2VL5pNRL4ZIoRm2jaAiGoaKWcWyUagBco=;
  b=F+BOxwCz4zU/jrmGFlpFNmcnxl5N1lwTWytrz0OmFS8Jg4oglVJc3L8/
   piNPJiE+K0BsTZtM3RiTgEBwe3fESwYPYZwpjYhxpY0FvVzUINiR5AvEe
   rfkk0G6h3FiLkxBtWjZwi2UCw2yBsL8H/UrM/llDXuB28wxt7D9/tvarb
   Ipjd9d7gx9OzB3ssUAHubyyge89DfBbIFjdUpAmg3aKUNEUHmN+Vi2u5+
   SGsZIMwSq6QeCHqOetbyJknEs5l9zD7q/Cm9QA8LyTx74NetsjAe6Ck4Z
   iJXAGR0D7U0/pofsJBN4vJJuL4wSEtH87QG79nXxpFzegYV9AO5o1lVaZ
   g==;
X-CSE-ConnectionGUID: GnFSMSV1Q2y4p959DxJawA==
X-CSE-MsgGUID: tV1mkunDTwCcn39UpqWcgA==
X-IronPort-AV: E=McAfee;i="6800,10657,11820"; a="81584837"
X-IronPort-AV: E=Sophos;i="6.24,211,1774335600"; 
   d="scan'208";a="81584837"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jun 2026 01:40:12 -0700
X-CSE-ConnectionGUID: iBrd/HamSsa+LC8GOUwUAg==
X-CSE-MsgGUID: bOL5VoRhRGGPoy/w2AUJbA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,211,1774335600"; 
   d="scan'208";a="248392494"
Received: from yilunxu-optiplex-7050.sh.intel.com ([10.239.159.165])
  by orviesa009.jf.intel.com with ESMTP; 18 Jun 2026 01:40:07 -0700
From: Xu Yilun <yilun.xu@linux.intel.com>
To: x86@kernel.org,
	kvm@vger.kernel.org,
	linux-coco@lists.linux.dev,
	linux-kernel@vger.kernel.org
Cc: djbw@kernel.org,
	kas@kernel.org,
	rick.p.edgecombe@intel.com,
	yilun.xu@linux.intel.com,
	yilun.xu@intel.com,
	xiaoyao.li@intel.com,
	sohil.mehta@intel.com,
	adrian.hunter@intel.com,
	kishen.maloor@intel.com,
	tony.lindgren@linux.intel.com,
	peter.fang@intel.com,
	baolu.lu@linux.intel.com,
	zhenzhong.duan@intel.com,
	dave.hansen@intel.com,
	dave.hansen@linux.intel.com,
	seanjc@google.com
Subject: [PATCH v2 15/17] KVM: TDX: Factor out userspace return path from tdx_get_quote()
Date: Thu, 18 Jun 2026 16:13:53 +0800
Message-Id: <20260618081355.3253581-16-yilun.xu@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260618081355.3253581-1-yilun.xu@linux.intel.com>
References: <20260618081355.3253581-1-yilun.xu@linux.intel.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Peter Fang <peter.fang@intel.com>

Separate the logic that returns the GetQuote TDVMCALL exit to userspace
so that tdx_get_quote() can be extended to support in-kernel Quote
generation.

No functional change intended.

Signed-off-by: Peter Fang <peter.fang@intel.com>
Signed-off-by: Xu Yilun <yilun.xu@linux.intel.com>
---
 arch/x86/kvm/vmx/tdx.c | 25 ++++++++++++++++---------
 1 file changed, 16 insertions(+), 9 deletions(-)

diff --git a/arch/x86/kvm/vmx/tdx.c b/arch/x86/kvm/vmx/tdx.c
index ed12805bbb44..9f7c39e0d4b5 100644
--- a/arch/x86/kvm/vmx/tdx.c
+++ b/arch/x86/kvm/vmx/tdx.c
@@ -1524,6 +1524,20 @@ static int tdx_complete_simple(struct kvm_vcpu *vcpu)
 	return 1;
 }
 
+static int tdx_get_quote_user(struct kvm_vcpu *vcpu, u64 gpa, u64 size)
+{
+	vcpu->run->exit_reason = KVM_EXIT_TDX;
+	vcpu->run->tdx.flags = 0;
+	vcpu->run->tdx.nr = TDVMCALL_GET_QUOTE;
+	vcpu->run->tdx.get_quote.ret = TDVMCALL_STATUS_SUBFUNC_UNSUPPORTED;
+	vcpu->run->tdx.get_quote.gpa = gpa;
+	vcpu->run->tdx.get_quote.size = size;
+
+	vcpu->arch.complete_userspace_io = tdx_complete_simple;
+
+	return 0;
+}
+
 static int tdx_get_quote(struct kvm_vcpu *vcpu)
 {
 	struct vcpu_tdx *tdx = to_tdx(vcpu);
@@ -1536,16 +1550,9 @@ static int tdx_get_quote(struct kvm_vcpu *vcpu)
 		return 1;
 	}
 
-	vcpu->run->exit_reason = KVM_EXIT_TDX;
-	vcpu->run->tdx.flags = 0;
-	vcpu->run->tdx.nr = TDVMCALL_GET_QUOTE;
-	vcpu->run->tdx.get_quote.ret = TDVMCALL_STATUS_SUBFUNC_UNSUPPORTED;
-	vcpu->run->tdx.get_quote.gpa = gpa & ~gfn_to_gpa(kvm_gfn_direct_bits(tdx->vcpu.kvm));
-	vcpu->run->tdx.get_quote.size = size;
-
-	vcpu->arch.complete_userspace_io = tdx_complete_simple;
+	gpa &= ~gfn_to_gpa(kvm_gfn_direct_bits(vcpu->kvm));
 
-	return 0;
+	return tdx_get_quote_user(vcpu, gpa, size);
 }
 
 static int tdx_setup_event_notify_interrupt(struct kvm_vcpu *vcpu)
-- 
2.25.1

