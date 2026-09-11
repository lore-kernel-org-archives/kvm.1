Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C1B0486428;
	Fri, 11 Sep 2026 21:41:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789162892; cv=none; b=AaIuY1o9UCGIS7BAHoHyY+UVqzeXSGO9sO6b811RXmknh3jo5DbB9u/b/Bp214iMx7rxFTOF/BdH76DMMJUd7PuOyRRdJlFstuJiBLKWY2KP8C4rYkMmAjsoXnoEkPujErgMNyjrFd+gVvawzvZnLBOt+DmIWfzx/LWYdIFGUAA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789162892; c=relaxed/simple;
	bh=VH/Hb30LkkF1uNVw/5tny50cxjDCIA7BZaPXPxi93dU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QYpyQM/k7fDgqCRggS9Gp7a5vzXWb6OXw8Y0uLPTfDVrDgWsm1xQIAWmqDprPcu9KSMMonyUJFmBFiquc05b0L+Zb4tmYelKJ16LkPEr3rSPZols4Uj9M/ceQqy0g2O9PV14SVJmzQ+6W30od7mFD3Juu9zkR5l6OpolL0DnqnQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=SZzwkR2B; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="SZzwkR2B"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1789162891; x=1820698891;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=VH/Hb30LkkF1uNVw/5tny50cxjDCIA7BZaPXPxi93dU=;
  b=SZzwkR2BglRyvwiUcUXeX6Erd2p4i8oFWPkQtRnaHPYsnFY9pSC1Xvxe
   c10ECTnEUNgBBqOVG518RUwK7Mu3KCc3mD6PI5Nyv00gvq8v95O16Fn3Q
   S47WjsrhwAxWUFJuHr4DyTZXSHMmLZ7bIUjjfIYlPGj8Bkroj/+hHkTew
   L/qvagE96jxAPqDxhSUc1D2CBUtXiXhReOCCuA73ggw+YVqxO7loRotuA
   AP1nXI1vVWM8CGXjxjGzrsVPYha2YvjcXyDQK0s9BwL+ODh4lO7XlINxr
   Mjqq/ZnAsko9qFZijZu3/IxOUusEdjeE09t/IxrOifG0k8UxTx3pm6I1C
   Q==;
X-CSE-ConnectionGUID: zbV+qPWzTmiJBgLQRFTHng==
X-CSE-MsgGUID: Rih6FkkVRBiKoiu1xnhA5A==
X-IronPort-AV: E=McAfee;i="6800,10657,11902"; a="88572611"
X-IronPort-AV: E=Sophos;i="6.27,98,1787036400"; 
   d="scan'208";a="88572611"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Sep 2026 14:41:30 -0700
X-CSE-ConnectionGUID: HH6JC9v4QHOFKi0L69m4Aw==
X-CSE-MsgGUID: WdAjvVEkRDSJu1yi7kuTTQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,98,1787036400"; 
   d="scan'208";a="272004078"
Received: from sohilmeh.sc.intel.com ([172.25.103.65])
  by orviesa007.jf.intel.com with ESMTP; 11 Sep 2026 14:41:29 -0700
From: Sohil Mehta <sohil.mehta@intel.com>
To: kvm@vger.kernel.org,
	x86@kernel.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
	Sean Christopherson <seanjc@google.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Thomas Gleixner <tglx@kernel.org>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H . Peter Anvin" <hpa@zytor.com>,
	Xin Li <xin@zytor.com>,
	Andy Lutomirski <luto@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Andrew Cooper <andrew.cooper3@citrix.com>,
	Tom Lendacky <thomas.lendacky@amd.com>,
	Nikunj A Dadhania <nikunj@amd.com>,
	Shivansh Dhiman <shivansh.dhiman@amd.com>,
	David Woodhouse <dwmw@amazon.co.uk>,
	Chao Gao <chao.gao@intel.com>,
	Binbin Wu <binbin.wu@linux.intel.com>,
	Sohil Mehta <sohil.mehta@intel.com>,
	Zhao Liu <zhao1.liu@intel.com>,
	Yosry Ahmed <yosry@kernel.org>,
	David Matlack <dmatlack@google.com>,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: [PATCH v10 11/28] KVM: x86: Add a helper to detect if FRED is enabled for a vCPU
Date: Fri, 11 Sep 2026 14:36:41 -0700
Message-ID: <20260911213659.2025974-12-sohil.mehta@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260911213659.2025974-1-sohil.mehta@intel.com>
References: <20260911213659.2025974-1-sohil.mehta@intel.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: "Xin Li (Intel)" <xin@zytor.com>

Add is_fred_enabled() to detect if FRED is enabled on a vCPU.

Signed-off-by: Xin Li (Intel) <xin@zytor.com>
[ Sean: removed the "kvm_" prefix from the function name ]
Signed-off-by: Sean Christopherson <seanjc@google.com>
Signed-off-by: Sohil Mehta <sohil.mehta@intel.com>
Tested-by: Shan Kang <shan.kang@intel.com>
Tested-by: Xuelian Guo <xuelian.guo@intel.com>
Reviewed-by: Chao Gao <chao.gao@intel.com>
---
v10:
 - Add back the change log (Binbin Wu and Sean).
---
 arch/x86/kvm/regs.h | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/arch/x86/kvm/regs.h b/arch/x86/kvm/regs.h
index 447f0ec3e63e..4e641a6c20f9 100644
--- a/arch/x86/kvm/regs.h
+++ b/arch/x86/kvm/regs.h
@@ -364,6 +364,21 @@ static __always_inline bool kvm_is_cr4_bit_set(struct kvm_vcpu *vcpu,
 	return !!kvm_read_cr4_bits(vcpu, cr4_bit);
 }
 
+/*
+ * It's enough to check just CR4.FRED (X86_CR4_FRED) to tell if
+ * a vCPU is running with FRED enabled, because:
+ * 1) CR4.FRED can be set to 1 only _after_ IA32_EFER.LMA = 1.
+ * 2) To leave IA-32e mode, CR4.FRED must be cleared first.
+ */
+static inline bool is_fred_enabled(struct kvm_vcpu *vcpu)
+{
+#ifdef CONFIG_X86_64
+	return kvm_is_cr4_bit_set(vcpu, X86_CR4_FRED);
+#else
+	return false;
+#endif
+}
+
 static inline ulong kvm_read_cr3(struct kvm_vcpu *vcpu)
 {
 	if (!kvm_register_is_available(vcpu, VCPU_REG_CR3))
-- 
2.43.0

