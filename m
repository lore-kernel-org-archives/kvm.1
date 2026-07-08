Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24BC83E3153;
	Wed,  8 Jul 2026 06:34:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783492501; cv=none; b=lWildI8jeF60OPQ32dsEKNXZrsKbCCyMgm0hnyWq45apc9+2/pH/P/sHErQSm3JWK1nz4VCbLLnH5cvPWRfp8ZegVQvxPW3hCfXkGTn+61x5S/+/d1N+i5yMA0lerbK9v7ywWr0sZ87uCdrlWPnfZXHwdJjBAyIZKKeEHqEh8yk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783492501; c=relaxed/simple;
	bh=8fej24dPZj9m+33GlDH6VOlvNiAO8/62TO5s4mIfR2k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OkMJgdbt1o9ghloYivMDNkA8szj3e10tlIEl4nUQWqQN6W2BzdqZ9WxAoBuvd7dSfJcnKIinKnF0MsQJ2R93oa1EvxWpSZjzAJ17ClN447YeFl2pruvvTvOkfhFVxzuNTskQatp+H5zEBfxrs7gGQ0PksotkV4Tuoeb1bSTrO5M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fVrVGGdf; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fVrVGGdf"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 900141F000E9;
	Wed,  8 Jul 2026 06:34:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783492498;
	bh=LnvZrTgF6ZjxBqmSAiVMNWgMuCxFplCsDheJcAuIiFM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=fVrVGGdfK/CTnHa9WCV5bjqtSJR61Ut7s8pjoF2bohsmYZVz9aVxz04p3GlTfCX0y
	 R/KN69dL8XpoW0TsgrIfvfB9vyv1g37sktkcLwihJyRwCWiINTbTyZKiQiityhscAi
	 hBxAflVawhQp68+O+ZewglqEjgbHZOSbhpE2PkRc6W1yW0eTi3fN0+2UHvlasMo3cb
	 +xuR4/ALqjGFqNEMbVYp/flAo8ngx55mOkeqCgFN14A8iScVNxWHb++iv1PyggGHh5
	 LZmK0V3lAfqIzXbKP/i2dzT8QtsbNqtAnkBHkL+oDhMH2TTfOVHSPC3je0vM1F3yXT
	 WLKK5pb9ztR1Q==
From: "Naveen N Rao (AMD)" <naveen@kernel.org>
To: Sean Christopherson <seanjc@google.com>,
	Borislav Petkov <bp@alien8.de>
Cc: <kvm@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Nikunj A Dadhania <nikunj@amd.com>,
	Tom Lendacky <thomas.lendacky@amd.com>,
	Neeraj Upadhyay <neeraj.upadhyay@amd.com>,
	Tianyu Lan <tiala@microsoft.com>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Thomas Gleixner <tglx@kernel.org>
Subject: [RFC PATCH v3 03/27] x86/kvm: Disable PV_SEND_IPI if Secure AVIC is enabled
Date: Wed,  8 Jul 2026 12:02:01 +0530
Message-ID: <730334f9cc320ca738402183c8b8555242a84ba3.1783490022.git.naveen@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <cover.1783490022.git.naveen@kernel.org>
References: <cover.1783490022.git.naveen@kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In Secure AVIC mode, Linux does not allow IPIs to be injected as the
hypervisor is untrusted. This is achieved by not setting the IPI vector
in SAVIC_ALLOWED_IRR in the Secure AVIC guest APIC Backing page. Due to
this, PV_SEND_IPI cannot work since it needs KVM to be able to inject
IPIs into the guest. Disable the same.

On a related note, PV_EOI does not need to be disabled since the
behavior is exactly the same as AVIC: though it is advertised, KVM never
"enables" it since APICv is always enabled for Secure AVIC SEV-SNP
guests.

Fixes: c4074ab87f34 ("x86/apic: Enable Secure AVIC in the control MSR")
Signed-off-by: Naveen N Rao (AMD) <naveen@kernel.org>
---
 arch/x86/kernel/kvm.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/x86/kernel/kvm.c b/arch/x86/kernel/kvm.c
index 29226d112029..e2dad507f2a4 100644
--- a/arch/x86/kernel/kvm.c
+++ b/arch/x86/kernel/kvm.c
@@ -495,7 +495,8 @@ static bool pv_tlb_flush_supported(void)
 static bool pv_ipi_supported(void)
 {
 	return (kvm_para_has_feature(KVM_FEATURE_PV_SEND_IPI) &&
-	       (num_possible_cpus() != 1));
+		(num_possible_cpus() != 1) &&
+		!cc_platform_has(CC_ATTR_SNP_SECURE_AVIC));
 }
 
 static bool pv_sched_yield_supported(void)
-- 
2.54.0

