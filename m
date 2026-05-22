Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F41B36F433;
	Fri, 22 May 2026 04:05:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779422753; cv=none; b=NN+/DfQYHOBpGlZlb1MQD5oqLPlh55mp6LM3/zucQSrQkW/vOMDAkN71soC9xHACcA9NP9ufqjPOg5rldPqHc6oY1GnKqluXNRVfcL155CtbHQWbhot8xlaZnZAatKyINSgEQbwCCfTw8cGMP5++gnirVJtfUB97+19rAb3hO0A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779422753; c=relaxed/simple;
	bh=bYIW/dXAcCY3Mtrycdf2Daqs+vYLOCWFpgtg9fDgkdk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=prz9QjyjKo+jnP3v7bdbCBsyiDEHTDAGXEWucYThOJBSQOfIEbJNRL/he59FUVMrHaOZPyMog3951MVPgoOah8eIsULpZdezca8UvGZ3UZUhQrooChW4FLzxi1dwfNyjMw/hmBCUSJTJ2TwSuOiW7QsP4kEJY3FkrLhePE0Pu0U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=fM5GD6li; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fM5GD6li"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1779422753; x=1810958753;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=bYIW/dXAcCY3Mtrycdf2Daqs+vYLOCWFpgtg9fDgkdk=;
  b=fM5GD6lihDILkXB6GpyoGQSf3GWAGgmJLobKcl/y2eSVulBgUwQfj/7t
   S+TjSvxEaLl+hZpfElvuB3aNiJuIkbA1pKG9ad8kTdGPI75x8tE4jTOym
   2H2lpcoNfA/YNmxkN/CI4j3a3T/iRWEzeVv05PHPyGS5IteeNJKn3V13p
   viaugIAoHup8srd3iFc6eWOM9egpZ+ZY2EnQc1iJNk6G6yJftu4DexZFT
   0Hhix5TzNGZ7UyjnUDwVb3tZogrhsl+16lf2MKNTk1/b6mfJf0pCH0rvW
   JN/aNOUxysKxLhf9XGBDSmBFhjHVcU7cgP4BGWM4+ijS0IUc7z0wh0B/N
   A==;
X-CSE-ConnectionGUID: SWmFP1+0QsC7w3bTAQlLrw==
X-CSE-MsgGUID: K1+q5G8WSXmiitivhtgCJg==
X-IronPort-AV: E=McAfee;i="6800,10657,11793"; a="80528912"
X-IronPort-AV: E=Sophos;i="6.24,161,1774335600"; 
   d="scan'208";a="80528912"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 May 2026 21:05:52 -0700
X-CSE-ConnectionGUID: 4PaC6CtpT+GuQzFBrdSJHQ==
X-CSE-MsgGUID: P7z+ufonTvGYuWgkcskn0w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,161,1774335600"; 
   d="scan'208";a="239757903"
Received: from yilunxu-optiplex-7050.sh.intel.com ([10.239.159.165])
  by orviesa006.jf.intel.com with ESMTP; 21 May 2026 21:05:48 -0700
From: Xu Yilun <yilun.xu@linux.intel.com>
To: kas@kernel.org,
	djbw@kernel.org,
	rick.p.edgecombe@intel.com,
	x86@kernel.org,
	peter.fang@intel.com
Cc: linux-coco@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	kvm@vger.kernel.org,
	sohil.mehta@intel.com,
	yilun.xu@intel.com,
	yilun.xu@linux.intel.com,
	baolu.lu@linux.intel.com,
	zhenzhong.duan@intel.com,
	xiaoyao.li@intel.com
Subject: [RFC PATCH 11/15] KVM: TDX: Factor out userspace return path from tdx_get_quote()
Date: Fri, 22 May 2026 11:41:24 +0800
Message-Id: <20260522034128.3144354-12-yilun.xu@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260522034128.3144354-1-yilun.xu@linux.intel.com>
References: <20260522034128.3144354-1-yilun.xu@linux.intel.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Peter Fang <peter.fang@intel.com>

Separate the logic that returns GetQuote to userspace so that
tdx_get_quote() can be extended to support in-kernel quote generation.

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

