Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 402FE34041D;
	Tue, 30 Jun 2026 23:47:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782863245; cv=none; b=qpkF+V/m8fWeAmO1MN2WlKbMrjWVFRhMzfFsn7Ttzpo1wzuPQvgqcuwq7a8iR7vJZqsF/cLwsE4xnl8ZvFHUsb4lPncN4qlHcdPuNQP3M8XezH8VMLXdw+tWI5YLjl1107XxUfrErecziPPHlv4klLXNhkzdZoaqQ06zJgPgUMw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782863245; c=relaxed/simple;
	bh=PYfB3wSjtjDU2oXMMDAu/PwFQI5CpsFCFQogNKos7us=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IzzJOClVaFrd9TOaPQvUfKW65YMQ8xZSfX4uaxZ4t2F5TNjV1rdFUcJAX888vgN0kmdeWaumweLk5b4+Jd5vtIb76xtSeh6w8wog5M6fPCnmDir9x/UwTEjujxBCZI9e1ta1zPj/9qVPcbrYSCSItlmZMQ1xd0zyy+wyxK2dEcA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=n5GQZ2hQ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="n5GQZ2hQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D23EA1F00A3D;
	Tue, 30 Jun 2026 23:47:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782863244;
	bh=49xMMH5eMX61JjqrKRdjPwbYGkyudJjbKu5sxTd8hg0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=n5GQZ2hQ3zyWpJx9HTbwTmNIbctq5izyZ8WfBix1BN21F5oEYBYcmLamNzU6GcOnS
	 jyz0piIQfscznAjeb052pnidBDZSrPQD+FOhsCQnRK5PMf1KhsuZ1YnddpEI/dmRou
	 //GwKksUjl0i6BkDucgp1gJVCC3m+FStk6azIkv7PPZf0AKg5II3fjIiZroJRQMlQ/
	 bPjg0CjpF/ETDrFxXUUWM0EN8EW/NJexSaii3x7cyOJN0o5aJI9lxxMfWa29lMgNnF
	 LEJFVTlWB/HWKsNpPlbRcabO5EJW6jYdjgc4i9dRYVEP6rm4MffV6IfBDM3F49yj8m
	 p9JbDAwlbAheQ==
From: Yosry Ahmed <yosry@kernel.org>
To: Sean Christopherson <seanjc@google.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>,
	kvm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Yosry Ahmed <yosry@kernel.org>
Subject: [PATCH 6/7] KVM: x86: Move supported EFER bits to kvm_caps
Date: Tue, 30 Jun 2026 23:47:14 +0000
Message-ID: <20260630234716.3039031-7-yosry@kernel.org>
X-Mailer: git-send-email 2.55.0.rc0.799.gd6f94ed593-goog
In-Reply-To: <20260630234716.3039031-1-yosry@kernel.org>
References: <20260630234716.3039031-1-yosry@kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Supported EFER bits naturally fits into kvm_caps because it needs to be
recomputed during vendor init (e.g. to account for EFER.SVME being
allowed/disallowed based on nested being enabled/disabled).

Move efer_supported_bits into kvm_caps as supported_efer_bits (for
naming consistency), and reinitialize it at the beginning of
kvm_setup_efer_caps(), removing the need to clear unsupported bits in
vendor code (e.g. EFER.SVME).

As the bitmask is now globally visible as part of kvm_caps, there's
little use for helpers to enable/disable specific bits, so drop them and
open-code updates to kvm_caps.supported_efer_bits.

No functional change intended.

Suggested-by: Sean Christopherson <seanjc@google.com>
Signed-off-by: Yosry Ahmed <yosry@kernel.org>
---
 arch/x86/include/asm/kvm_host.h |  2 ++
 arch/x86/kvm/msrs.c             | 19 ++-----------------
 arch/x86/kvm/svm/svm.c          |  7 ++-----
 arch/x86/kvm/x86.c              | 11 +++++++----
 4 files changed, 13 insertions(+), 26 deletions(-)

diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_host.h
index 0efd93f961df4..40be39fea39b9 100644
--- a/arch/x86/include/asm/kvm_host.h
+++ b/arch/x86/include/asm/kvm_host.h
@@ -329,6 +329,8 @@ struct kvm_caps {
 	u64 supported_xss;
 	u64 supported_perf_cap;
 
+	u64 supported_efer_bits;
+
 	u64 supported_quirks;
 	u64 inapplicable_quirks;
 };
diff --git a/arch/x86/kvm/msrs.c b/arch/x86/kvm/msrs.c
index b9a16a27f6c23..a39c73088f1fb 100644
--- a/arch/x86/kvm/msrs.c
+++ b/arch/x86/kvm/msrs.c
@@ -19,9 +19,6 @@ bool __read_mostly report_ignored_msrs = true;
 module_param(report_ignored_msrs, bool, 0644);
 EXPORT_SYMBOL_FOR_KVM_INTERNAL(report_ignored_msrs);
 
-/* Enable syscall by default because its emulated by KVM */
-static u64 __read_mostly efer_supported_bits = ((u64)EFER_SCE);
-
 #define MAX_IO_MSRS 256
 
 struct msr_bitmap_range {
@@ -606,7 +603,7 @@ static bool __kvm_valid_efer(struct kvm_vcpu *vcpu, u64 efer)
 }
 bool kvm_valid_efer(struct kvm_vcpu *vcpu, u64 efer)
 {
-	if (!(efer & efer_supported_bits))
+	if (!(efer & kvm_caps.supported_efer_bits))
 		return false;
 
 	return __kvm_valid_efer(vcpu, efer);
@@ -619,7 +616,7 @@ static int set_efer(struct kvm_vcpu *vcpu, struct msr_data *msr_info)
 	u64 efer = msr_info->data;
 	int r;
 
-	if (!(efer & efer_supported_bits))
+	if (!(efer & kvm_caps.supported_efer_bits))
 		return 1;
 
 	if (!msr_info->host_initiated) {
@@ -650,18 +647,6 @@ static int set_efer(struct kvm_vcpu *vcpu, struct msr_data *msr_info)
 	return 0;
 }
 
-void kvm_enable_efer_bits(u64 mask)
-{
-	efer_supported_bits |= mask;
-}
-EXPORT_SYMBOL_FOR_KVM_INTERNAL(kvm_enable_efer_bits);
-
-void kvm_disable_efer_bits(u64 mask)
-{
-	efer_supported_bits &= ~mask;
-}
-EXPORT_SYMBOL_FOR_KVM_INTERNAL(kvm_disable_efer_bits);
-
 bool kvm_msr_allowed(struct kvm_vcpu *vcpu, u32 index, u32 type)
 {
 	struct kvm_x86_msr_filter *msr_filter;
diff --git a/arch/x86/kvm/svm/svm.c b/arch/x86/kvm/svm/svm.c
index 747f1e31a3622..e755f43f4376e 100644
--- a/arch/x86/kvm/svm/svm.c
+++ b/arch/x86/kvm/svm/svm.c
@@ -277,12 +277,9 @@ int svm_set_efer(struct kvm_vcpu *vcpu, u64 efer)
 static void svm_setup_efer_caps(void)
 {
 	if (nested) {
-		kvm_enable_efer_bits(EFER_SVME);
+		kvm_caps.supported_efer_bits |= EFER_SVME;
 		if (!boot_cpu_has(X86_FEATURE_EFER_LMSLE_MBZ))
-			kvm_enable_efer_bits(EFER_LMSLE);
-	} else {
-		kvm_disable_efer_bits(EFER_SVME);
-		kvm_disable_efer_bits(EFER_LMSLE);
+			kvm_caps.supported_efer_bits |= EFER_LMSLE;
 	}
 }
 
diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index a297a77469b38..5cedaa8409f8d 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -6892,17 +6892,20 @@ EXPORT_SYMBOL_FOR_KVM_INTERNAL(kvm_setup_xss_caps);
 
 static void kvm_setup_efer_caps(void)
 {
+	/* Enable syscall by default because its emulated by KVM */
+	kvm_caps.supported_efer_bits = (u64)EFER_SCE;
+
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
 
 	kvm_x86_call(setup_efer_caps)();
 }
-- 
2.55.0.rc0.799.gd6f94ed593-goog

