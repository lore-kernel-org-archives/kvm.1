Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D3C6392C58;
	Tue, 24 Mar 2026 03:29:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774322970; cv=none; b=A7rQ+6vLwFjAn9/Qv2zzokF0TPbCLO0savDJuigEiptjulMJQ1H2UOrT1fN4c3LGSPs+ZnTKXp1DftrkVQleIBZRP08rN7h3RJ87ifURfHOIkVsQP3JjWaKb6Xf4XhGYjCS+jFP3AHVAPufwMcYea3LQ6Uv4cS5U2Kn/zNEFWQI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774322970; c=relaxed/simple;
	bh=F/ykkKns6NNyKvft309PK2OZhRcBJlrLik/OnRi9LrY=;
	h=From:To:Cc:Subject:Date:Message-Id; b=F0adFAWvVGVjmy2hJBgKpCJHV8wDie3s0wsSBT4ql0nPWZTbRZYwwHCdGSgGTbsZZLx2su9Lyqj+hK2YkHcBxz/A6nK4n1fiA9kG6DNan9al7wkyYt3LxzDLP/953urGYTtaAZ51x6cpaWX1ftzrvpR0GtzovYhUzEeXLwyaoCE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=Dggr3sN8; arc=none smtp.client-ip=220.197.31.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="Dggr3sN8"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id; bh=GCZkkAjdYYXgGrK
	0aAmcVM9Jseq5fVzknEnkfmjI9aU=; b=Dggr3sN8jID7/g3pX/sVh+TDDm8By2+
	UQAhAVb/vhrzga04rDt5WkL6zC2JIXlieRGfu1zdEEQI6Ep5KD+Xxz7MFo62NmH+
	GTr2vjYnwYzwNik1z+YTORhePO7aUD5D4VAgsYkGyrUdMKN0qIr6MOFrzhioMqPK
	vao+O1krMTJc=
Received: from VM-0-4-centos.localdomain (unknown [])
	by gzga-smtp-mtada-g1-4 (Coremail) with SMTP id _____wBXXqqxBMJpwHRWBA--.14479S2;
	Tue, 24 Mar 2026 11:27:46 +0800 (CST)
From: 18341265598@163.com
To: Sean Christopherson <seanjc@google.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Thomas Gleixner <tglx@kernel.org>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H. Peter Anvin" <hpa@zytor.com>
Cc: kvm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	wei xiaoqiong <weixq1@chinatelecom.cn>,
	Huaitong Han <hanht2@chinatelecom.cn>,
	"zhaoge.zhang" <zhangzg12@chinatelecom.cn>
Subject: [PATCH] vmx/nested: Set the SGX feature flag only when hardware supported.
Date: Tue, 24 Mar 2026 11:27:40 +0800
Message-Id: <1774322860-25106-1-git-send-email-18341265598@163.com>
X-Mailer: git-send-email 1.8.3.1
X-CM-TRANSID:_____wBXXqqxBMJpwHRWBA--.14479S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxWw1UZw4DWw1xKr1DZw4xJFb_yoW5GF47pF
	W7Krn5Jrs5WryrAasxAa18Xr4av3Z5Gryxur1Uu34DX3ZFgwn7Jr4xt34fJ345X3yFv34S
	vF4jqry5uwnxJaUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07jOID7UUUUU=
X-CM-SenderInfo: jpryjkyrswkkmzybiqqrwthudrp/xtbC5hM4NGnCBLMPlwAA39
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

From: "zhaoge.zhang" <zhangzg12@chinatelecom.cn>

If the hardware does not support the SGX feature and we set the
corresponding flag, when the L1 hypervisor enables the corresponding
feature in VMCS12, the VM entry will fail.

Reported-by: wei xiaoqiong <weixq1@chinatelecom.cn>
Signed-off-by: zhaoge.zhang <zhangzg12@chinatelecom.cn>
Reviewed-by: Huaitong Han <hanht2@chinatelecom.cn>
---
 arch/x86/kvm/vmx/nested.c |  2 +-
 arch/x86/kvm/vmx/vmx.c    | 11 -----------
 arch/x86/kvm/vmx/vmx.h    | 11 +++++++++++
 3 files changed, 12 insertions(+), 12 deletions(-)

diff --git a/arch/x86/kvm/vmx/nested.c b/arch/x86/kvm/vmx/nested.c
index 937aeb4..396ac07 100644
--- a/arch/x86/kvm/vmx/nested.c
+++ b/arch/x86/kvm/vmx/nested.c
@@ -7278,7 +7278,7 @@ static void nested_vmx_setup_secondary_ctls(u32 ept_caps,
 		msrs->secondary_ctls_high |=
 			SECONDARY_EXEC_VIRTUALIZE_APIC_ACCESSES;
 
-	if (enable_sgx)
+	if (enable_sgx && cpu_has_sgx())
 		msrs->secondary_ctls_high |= SECONDARY_EXEC_ENCLS_EXITING;
 }
 
diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
index 8b24e68..e06e62e 100644
--- a/arch/x86/kvm/vmx/vmx.c
+++ b/arch/x86/kvm/vmx/vmx.c
@@ -2673,17 +2673,6 @@ void vmx_cache_reg(struct kvm_vcpu *vcpu, enum kvm_reg reg)
 	}
 }
 
-/*
- * There is no X86_FEATURE for SGX yet, but anyway we need to query CPUID
- * directly instead of going through cpu_has(), to ensure KVM is trapping
- * ENCLS whenever it's supported in hardware.  It does not matter whether
- * the host OS supports or has enabled SGX.
- */
-static bool cpu_has_sgx(void)
-{
-	return cpuid_eax(0) >= 0x12 && (cpuid_eax(0x12) & BIT(0));
-}
-
 static int adjust_vmx_controls(u32 ctl_min, u32 ctl_opt, u32 msr, u32 *result)
 {
 	u32 vmx_msr_low, vmx_msr_high;
diff --git a/arch/x86/kvm/vmx/vmx.h b/arch/x86/kvm/vmx/vmx.h
index 70bfe81..3e9114b 100644
--- a/arch/x86/kvm/vmx/vmx.h
+++ b/arch/x86/kvm/vmx/vmx.h
@@ -338,6 +338,17 @@ static __always_inline u32 vmx_get_intr_info(struct kvm_vcpu *vcpu)
 	return vt->exit_intr_info;
 }
 
+/*
+ * There is no X86_FEATURE for SGX yet, but anyway we need to query CPUID
+ * directly instead of going through cpu_has(), to ensure KVM is trapping
+ * ENCLS whenever it's supported in hardware.  It does not matter whether
+ * the host OS supports or has enabled SGX.
+ */
+static bool cpu_has_sgx(void)
+{
+	return cpuid_eax(0) >= 0x12 && (cpuid_eax(0x12) & BIT(0));
+}
+
 void vmx_vcpu_load_vmcs(struct kvm_vcpu *vcpu, int cpu);
 int allocate_vpid(void);
 void free_vpid(int vpid);
-- 
1.8.3.1

