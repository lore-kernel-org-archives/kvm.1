Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F31064C4F47;
	Fri, 11 Sep 2026 21:42:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789162969; cv=none; b=XQxcvan92I/1sL3bTYr5WECd4+x7BpcwpyiLhwuvQG7vA3dpeNYB0SRzc0tfePMR8yh9G4lQh5BVvNT7ewEXjhonJ4TxRFA8sl0kIUDQXiF9k5zxV1saXIRhB3xKxNhS3/X5UI7Xo/HRh4/FwzW1cPOtYpiVnFfmWmAdqyGsow0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789162969; c=relaxed/simple;
	bh=BRECzFPPA04jMAm7WoR+5OiKCg4q6yf1+9bP69Dv8S0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tbSHgkMwoGI+8RPsMhEXipK10irz2UkAdMV1Efta1bqGgBH7Jkdh43p93XiHA2et4MqCz0/C1jMvkycYJfTyk4fZMstylwZKDZXSf2CAnfZLjmeF00zQOkGGAGyTCEcOUukoZjlY6tQQJho0XCwQqs2ZJ1fBpzab/62kCY+jlAQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=b6GopY7K; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="b6GopY7K"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1789162968; x=1820698968;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=BRECzFPPA04jMAm7WoR+5OiKCg4q6yf1+9bP69Dv8S0=;
  b=b6GopY7KZg9clBfYIYy50+81s1Q/28z/5C/1tMbiqHN3/p3XbRIJZJo2
   eB8eMBA/2qVhXLLL3qmIEp3gUAf7CDFpPusd33U3q5uhAI0jq/1xBvxFP
   oSHkd/0jXiSpmNYDnhZMM+4Hf+oM7KCnlCmy+YaXgm6vSszL3ukYH8doZ
   9z5Ug1QfMviWW3qiYPXenI53p1kuumCwdwQXxpJg41CU65q90vNfA3/23
   ylbVnouDtQ2LfQ1NcJ/xDWzrdajo5fwDEnogOIigvwFhyzFnmhcm1KhwS
   ULoVAmeaKKFJiCDsI21Nq3qRcxfurnbJ8rjkmQOeRde3NEK74nhhJxXYO
   w==;
X-CSE-ConnectionGUID: CFd9Nll+T9yLW8XeNkIFKw==
X-CSE-MsgGUID: 6dzU6dcUTAWExcVq6F1JtA==
X-IronPort-AV: E=McAfee;i="6800,10657,11902"; a="88572798"
X-IronPort-AV: E=Sophos;i="6.27,98,1787036400"; 
   d="scan'208";a="88572798"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Sep 2026 14:42:47 -0700
X-CSE-ConnectionGUID: WtVZvhDGSfmpm4h+wgPt8g==
X-CSE-MsgGUID: KUt5WrARQJu/ryBALRO0Qg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,98,1787036400"; 
   d="scan'208";a="272004213"
Received: from sohilmeh.sc.intel.com ([172.25.103.65])
  by orviesa007.jf.intel.com with ESMTP; 11 Sep 2026 14:42:46 -0700
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
Subject: [PATCH v10 19/28] KVM: x86: Advertise support for FRED
Date: Fri, 11 Sep 2026 14:36:49 -0700
Message-ID: <20260911213659.2025974-20-sohil.mehta@intel.com>
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

Advertise support for FRED to userspace after changes required to enable
FRED in a KVM guest are in place.

Signed-off-by: Xin Li (Intel) <xin@zytor.com>
Signed-off-by: Sohil Mehta <sohil.mehta@intel.com>
Reviewed-by: Chao Gao <chao.gao@intel.com>
---
v10:
 - kvm_cpu_cap_clear(X86_FEATURE_FRED) in svm_set_cpu_caps() (Chao).
---
 arch/x86/kvm/cpuid.c   | 1 +
 arch/x86/kvm/svm/svm.c | 3 +++
 2 files changed, 4 insertions(+)

diff --git a/arch/x86/kvm/cpuid.c b/arch/x86/kvm/cpuid.c
index ddb022cb203a..5682bacdfd32 100644
--- a/arch/x86/kvm/cpuid.c
+++ b/arch/x86/kvm/cpuid.c
@@ -1034,6 +1034,7 @@ void kvm_initialize_cpu_caps(void)
 		F(FSRS),
 		F(FSRC),
 		F(WRMSRNS),
+		X86_64_F(FRED),
 		X86_64_F(LKGS),
 		F(AMX_FP16),
 		F(AVX_IFMA),
diff --git a/arch/x86/kvm/svm/svm.c b/arch/x86/kvm/svm/svm.c
index f254a5ff570d..dd19c7b4e904 100644
--- a/arch/x86/kvm/svm/svm.c
+++ b/arch/x86/kvm/svm/svm.c
@@ -5518,6 +5518,9 @@ static __init void svm_set_cpu_caps(void)
 
 	kvm_cpu_cap_clear(X86_FEATURE_IBT);
 
+	/* SVM FRED virtualization not implemented yet */
+	kvm_cpu_cap_clear(X86_FEATURE_FRED);
+
 	/* CPUID 0x80000001 and 0x8000000A (SVM features) */
 	if (nested) {
 		kvm_cpu_cap_set(X86_FEATURE_SVM);
-- 
2.43.0

