Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2144F4A4EE6;
	Fri, 11 Sep 2026 21:42:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789162943; cv=none; b=uvMcJ6bFU9YginvHXLD9MrVzYTlTtv3Cjl28mrnloR8+8RQEDNlespvaCbEcIGl4/BAOvwAxoo1cMkAqRyUvOQN08OZ7gGPkJ/LBegwktw9AKxem+nYKROWfo8WaLjJJN0o3UvTattZylScJbeH/yK01AYQK0UD0YhUjxjZ7jxM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789162943; c=relaxed/simple;
	bh=JX9TQ96K33ocxG2yk/VpQX5o1ho8/YkNayFOx7XyMt0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ysqpo1mxOguQ8HhcfcSjHudYnDivl7QRpBnxU0dpLsJLCVCROULr/rmDbm6s7rQZys4lcVS/kO2DfcciRI3dzzbzRJvRmzE+Ebfjm+tRlNxdyYLTeVpHyr3RtFHgaMQjT1l8vMALKAePmeENIolLo3qufWLeFsy60+oOKTI5cyQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=H3vFhdgt; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="H3vFhdgt"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1789162942; x=1820698942;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=JX9TQ96K33ocxG2yk/VpQX5o1ho8/YkNayFOx7XyMt0=;
  b=H3vFhdgtj3oh9XXHjlyfKLzqs1cuM18xlCg+OPrx0F4wJ3ctuvoJVRW8
   a+jj0KJ/uFMvR8agewLw68NN4yTnIDMmr1cncMC5EyCgpHrBwf+1AbLNZ
   d0AKYA7rkXVdSEe3zk5XypuAs4lYb3+VqmOFbbyyRfre4eH0j1XAwYwsa
   9ETh0I+ytlxUn1Refag5uLoumLfbbo8sMHLtyuqMzK9x1a93OBuBMSPW3
   Pr/mHE2+oP6BFDQZtPKZuEx8gJxJ9BK68mDiYvuGemih62aS9GjnMmXJS
   1emM+m/m252cW9Tb4h9r7oTJvj8uqGRB5AzO0WE6JAWnrwB/SMKTyAGAe
   g==;
X-CSE-ConnectionGUID: h3BYHSXLSrCE4zF5qJbg3Q==
X-CSE-MsgGUID: x7f0J7nuSeKxE+rHBJ0tKQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11902"; a="88572751"
X-IronPort-AV: E=Sophos;i="6.27,98,1787036400"; 
   d="scan'208";a="88572751"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Sep 2026 14:42:22 -0700
X-CSE-ConnectionGUID: 1hjsGIMNSk+Fe5+exDuX8A==
X-CSE-MsgGUID: j35rWwa9RpGbWIUPzK/5+w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,98,1787036400"; 
   d="scan'208";a="272004172"
Received: from sohilmeh.sc.intel.com ([172.25.103.65])
  by orviesa007.jf.intel.com with ESMTP; 11 Sep 2026 14:42:20 -0700
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
Subject: [PATCH v10 16/28] KVM: x86: Mark CR4.FRED as not reserved
Date: Fri, 11 Sep 2026 14:36:46 -0700
Message-ID: <20260911213659.2025974-17-sohil.mehta@intel.com>
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

The CR4.FRED bit, i.e., CR4[32], is no longer a reserved bit when
guest cpu cap has FRED, i.e.,
  1) All of FRED KVM support is in place.
  2) Guest enumerates FRED.

Otherwise it is still a reserved bit.

Signed-off-by: Xin Li (Intel) <xin@zytor.com>
Signed-off-by: Sohil Mehta <sohil.mehta@intel.com>
---
v10:
 - Check CR4.FRED against IA-32e mode in kvm_set_cr4() instead of
   __kvm_is_valid_cr4(), so that KVM_SET_SREGS no longer rejects a CR4
   and EFER pair that are loaded together (e.g., when restoring a FRED
   guest)
---
 arch/x86/kvm/regs.c | 7 +++++++
 arch/x86/kvm/regs.h | 4 +++-
 2 files changed, 10 insertions(+), 1 deletion(-)

diff --git a/arch/x86/kvm/regs.c b/arch/x86/kvm/regs.c
index 8f66438989e4..ba6c8856b4ff 100644
--- a/arch/x86/kvm/regs.c
+++ b/arch/x86/kvm/regs.c
@@ -429,6 +429,13 @@ int kvm_set_cr4(struct kvm_vcpu *vcpu, unsigned long cr4)
 			return 1;
 	}
 
+	/*
+	 * FRED can not be enabled when EFER.LMA=0.  Note, MOV to CR4 outside
+	 * 64-bit mode clears CR4[63:32] so only emulation can get here.
+	 */
+	if ((cr4 & X86_CR4_FRED) && !is_long_mode(vcpu))
+		return 1;
+
 	if ((cr4 & X86_CR4_CET) && !kvm_is_cr0_bit_set(vcpu, X86_CR0_WP))
 		return 1;
 
diff --git a/arch/x86/kvm/regs.h b/arch/x86/kvm/regs.h
index ef46918daf43..5db01693ad07 100644
--- a/arch/x86/kvm/regs.h
+++ b/arch/x86/kvm/regs.h
@@ -28,7 +28,7 @@ static_assert(!(KVM_POSSIBLE_CR0_GUEST_BITS & X86_CR0_PDPTR_BITS));
 			  | X86_CR4_OSXSAVE | X86_CR4_SMEP | X86_CR4_FSGSBASE \
 			  | X86_CR4_OSXMMEXCPT | X86_CR4_LA57 | X86_CR4_VMXE \
 			  | X86_CR4_SMAP | X86_CR4_PKE | X86_CR4_UMIP \
-			  | X86_CR4_LAM_SUP | X86_CR4_CET))
+			  | X86_CR4_LAM_SUP | X86_CR4_CET | X86_CR4_FRED))
 
 #define CR8_RESERVED_BITS (~(unsigned long)X86_CR8_TPR)
 
@@ -423,6 +423,8 @@ static inline bool __kvm_is_valid_cr4(struct kvm_vcpu *vcpu, unsigned long cr4)
 	if (!__cpu_has(__c, X86_FEATURE_SHSTK) &&       \
 	    !__cpu_has(__c, X86_FEATURE_IBT))           \
 		__reserved_bits |= X86_CR4_CET;         \
+	if (!__cpu_has(__c, X86_FEATURE_FRED))          \
+		__reserved_bits |= X86_CR4_FRED;        \
 	__reserved_bits;                                \
 })
 
-- 
2.43.0

