Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2925B353A77;
	Mon, 13 Jul 2026 18:10:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783966231; cv=none; b=oEf4tnQDr+8g+7zaqOezZQkD1E/fcgx47SjTT9kr4skpaJQHMYNxIPlduDYWBE3x74N/zSXAjnnULCgkcFPFN7OYgN9oSRJy0JwCoSlVcaAajNp/thEE+icSGuD7dEoayTsNXnAdrrVSCw70S2hnjQQBTgnX1WSGj0CQ/0z0mtw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783966231; c=relaxed/simple;
	bh=Cjai9FkO1FjM+YMoUuSQZX9ZAulIXaCjdQ/YsZnawmk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=b3FlNUZ62xbkN9jmi0uBeTwqiCqKLDsC+COvR8rY+TyG1Jku1za6z/B/Z75C8UaLXuntuZSjb4fRcxiKLgoM9ko4BLs+YI3o96Sg3oBxBXuSOtECaR2Otq7tqlecIdTPKLzjs4KNGTm+ZLgwHqOiwpQEDYe96OPwQ0WdYIiTIxU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KfmXRlEV; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KfmXRlEV"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A4CF71F00A3A;
	Mon, 13 Jul 2026 18:10:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783966229;
	bh=+Kj2nKKKZJOZw5AWs7XXDvbUgVFn+uMCRH9hohF5aZk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=KfmXRlEVladukTYfnu1UXvKc10wzqCyZvFOCvjMAscTfsY3pp9OzbK7oPinfQRc8M
	 DB1ahveOxbTrUenAMONeO68eXmbzvgb7cnTTXe/0iQd+5Jyzn/09WfWuhDEKc5WdQ2
	 FwZUpRExwYmpxY3ZVYgRIW71/6h5RoGxxnlMAIEqLeNh3uwe0Af2XKZGZILCViZNXx
	 SdhBgimXScyGAARHiM+Cm/6lyeAveQ1fcAoOST9Ut7omBzO3rz0ByMJQuwnfNj2XjC
	 5sflVHaWMxFox5LsYC+HjEo01C49GRvyixJzUgGNqe7RNxpKPWEdK4CPp8G1ZQbVv2
	 VpZtmvHH8/9Mg==
From: Yosry Ahmed <yosry@kernel.org>
To: Sean Christopherson <seanjc@google.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>,
	kvm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Yosry Ahmed <yosry@kernel.org>,
	Nikolay Borisov <nik.borisov@suse.com>
Subject: [PATCH v3 5/5] KVM: x86: Move supported EFER bits to kvm_caps
Date: Mon, 13 Jul 2026 18:10:20 +0000
Message-ID: <20260713181020.2735367-6-yosry@kernel.org>
X-Mailer: git-send-email 2.55.0.141.g00534a21ce-goog
In-Reply-To: <20260713181020.2735367-1-yosry@kernel.org>
References: <20260713181020.2735367-1-yosry@kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Supported EFER bits naturally fits into kvm_caps because it gets
recomputed during vendor initialization (e.g. to account for EFER.SVME
being allowed/disallowed based on nested being enabled/disabled). Move
efer_supported_bits into kvm_caps as supported_efer_bits (for naming
consistency).

As the bitmask is now globally visible as part of kvm_caps, there's
little use for helpers to enable/disable specific bits, so drop them and
open-code updates to kvm_caps.supported_efer_bits.

No functional change intended.

Suggested-by: Sean Christopherson <seanjc@google.com>
Reviewed-by: Nikolay Borisov <nik.borisov@suse.com>
Signed-off-by: Yosry Ahmed <yosry@kernel.org>
---
 arch/x86/include/asm/kvm_host.h |  2 ++
 arch/x86/kvm/msrs.c             | 19 ++-----------------
 arch/x86/kvm/msrs.h             |  2 --
 arch/x86/kvm/x86.c              | 15 ++++++++-------
 4 files changed, 12 insertions(+), 26 deletions(-)

diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_host.h
index 58f156ae31e75..80b92ed440fa1 100644
--- a/arch/x86/include/asm/kvm_host.h
+++ b/arch/x86/include/asm/kvm_host.h
@@ -274,6 +274,8 @@ struct kvm_caps {
 	u64 supported_xss;
 	u64 supported_perf_cap;
 
+	u64 supported_efer_bits;
+
 	u64 supported_quirks;
 	u64 inapplicable_quirks;
 };
diff --git a/arch/x86/kvm/msrs.c b/arch/x86/kvm/msrs.c
index 8e33b87b5e8f0..66fa7140d65d9 100644
--- a/arch/x86/kvm/msrs.c
+++ b/arch/x86/kvm/msrs.c
@@ -19,8 +19,6 @@ bool __read_mostly report_ignored_msrs = true;
 module_param(report_ignored_msrs, bool, 0644);
 EXPORT_SYMBOL_FOR_KVM_INTERNAL(report_ignored_msrs);
 
-static u64 __read_mostly efer_supported_bits;
-
 #define MAX_IO_MSRS 256
 
 struct msr_bitmap_range {
@@ -605,7 +603,7 @@ static bool __kvm_valid_efer(struct kvm_vcpu *vcpu, u64 efer)
 }
 bool kvm_valid_efer(struct kvm_vcpu *vcpu, u64 efer)
 {
-	if (efer & ~efer_supported_bits)
+	if (efer & ~kvm_caps.supported_efer_bits)
 		return false;
 
 	return __kvm_valid_efer(vcpu, efer);
@@ -618,7 +616,7 @@ static int set_efer(struct kvm_vcpu *vcpu, struct msr_data *msr_info)
 	u64 efer = msr_info->data;
 	int r;
 
-	if (efer & ~efer_supported_bits)
+	if (efer & ~kvm_caps.supported_efer_bits)
 		return 1;
 
 	if (!msr_info->host_initiated) {
@@ -649,19 +647,6 @@ static int set_efer(struct kvm_vcpu *vcpu, struct msr_data *msr_info)
 	return 0;
 }
 
-void kvm_init_efer_bits(void)
-{
-	/* Enable syscall by default because its emulated by KVM */
-	efer_supported_bits = (u64)EFER_SCE;
-}
-EXPORT_SYMBOL_FOR_KVM_INTERNAL(kvm_init_efer_bits);
-
-void kvm_enable_efer_bits(u64 mask)
-{
-	efer_supported_bits |= mask;
-}
-EXPORT_SYMBOL_FOR_KVM_INTERNAL(kvm_enable_efer_bits);
-
 bool kvm_msr_allowed(struct kvm_vcpu *vcpu, u32 index, u32 type)
 {
 	struct kvm_x86_msr_filter *msr_filter;
diff --git a/arch/x86/kvm/msrs.h b/arch/x86/kvm/msrs.h
index 1f772e1717588..7cc182a15b3b3 100644
--- a/arch/x86/kvm/msrs.h
+++ b/arch/x86/kvm/msrs.h
@@ -58,8 +58,6 @@ int kvm_get_set_one_reg(struct kvm_vcpu *vcpu, unsigned int ioctl,
 int kvm_get_reg_list(struct kvm_vcpu *vcpu,
 		     struct kvm_reg_list __user *user_list);
 
-void kvm_init_efer_bits(void);
-void kvm_enable_efer_bits(u64);
 bool kvm_valid_efer(struct kvm_vcpu *vcpu, u64 efer);
 int kvm_emulate_msr_read(struct kvm_vcpu *vcpu, u32 index, u64 *data);
 int kvm_emulate_msr_write(struct kvm_vcpu *vcpu, u32 index, u64 data);
diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index 83f608dad0605..a020b1cbb3f3e 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -6913,24 +6913,25 @@ EXPORT_SYMBOL_FOR_KVM_INTERNAL(kvm_setup_xss_caps);
 
 static void kvm_setup_efer_caps(void)
 {
-	kvm_init_efer_bits();
+	/* Enable syscall by default because its emulated by KVM */
+	kvm_caps.supported_efer_bits = (u64)EFER_SCE;
 
 	if (kvm_cpu_cap_has(X86_FEATURE_LM))
-		kvm_enable_efer_bits(EFER_LME | EFER_LMA);
+		kvm_caps.supported_efer_bits |= (EFER_LME | EFER_LMA);
 
 	if (kvm_cpu_cap_has(X86_FEATURE_NX))
-		kvm_enable_efer_bits(EFER_NX);
+		kvm_caps.supported_efer_bits |= EFER_NX;
 
 	if (kvm_cpu_cap_has(X86_FEATURE_FXSR_OPT))
-		kvm_enable_efer_bits(EFER_FFXSR);
+		kvm_caps.supported_efer_bits |= EFER_FFXSR;
 
 	if (kvm_cpu_cap_has(X86_FEATURE_AUTOIBRS))
-		kvm_enable_efer_bits(EFER_AUTOIBRS);
+		kvm_caps.supported_efer_bits |= EFER_AUTOIBRS;
 
 	if (kvm_cpu_cap_has(X86_FEATURE_SVM)) {
-		kvm_enable_efer_bits(EFER_SVME);
+		kvm_caps.supported_efer_bits |= EFER_SVME;
 		if (!boot_cpu_has(X86_FEATURE_EFER_LMSLE_MBZ))
-			kvm_enable_efer_bits(EFER_LMSLE);
+			kvm_caps.supported_efer_bits |= EFER_LMSLE;
 	}
 }
 
-- 
2.55.0.141.g00534a21ce-goog

