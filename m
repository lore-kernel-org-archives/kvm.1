Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DB383D4117;
	Mon,  6 Jul 2026 19:54:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783367686; cv=none; b=bHjBvKnvWtwD/zkTlj4wVWXJg5P714m5+M8DW/FCyuftpoF81IC5FPak8BQd3Ngthb/mUDukPX/RcgKgzc9GfPnug6U/+eoS+fFPlK3n52EYMnjeu1YMVSeVkf3jipljXTifs95rwzEjf982z6qLG6HZc54iDahS/Ju5MqF5AZg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783367686; c=relaxed/simple;
	bh=DRRCQZ3YE6A2T1qoGUE0gO9O9EZnP5hzhhQy6nFttyw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FLyjghl9yG8gXSyDAlISL15RjEbOQuV2XBRVLLQz+xbYAwYsiIZYehztZmP5Ur22IErtQJr1uUwYZVZ/bw/xlegsmURsoDcY6F5oaaJaO1mMJizjLHv6EMWpyvcVpTxszwl0rCIHSIYXoThQzMMnyhPIRsczAMnF7hzm8bUPCc8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=G+hphaWk; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="G+hphaWk"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AA78A1F00A3A;
	Mon,  6 Jul 2026 19:54:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783367684;
	bh=G33BwdrNFRS3RzFtEtTmtKu06Do14OXWlIvsZAoGJW4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=G+hphaWkznW0TmqpuZAxEmFTPRSDzViJ+4rJ8UwQZt7GdwyqUlZwpA8qZ+oLgOULX
	 W58fSmPlfYIqIrMh0nAl6XYKoAldETR7NRwIR6rOPXfR1aodYV8vnP1CQ39P/Pj1II
	 8X0LZIWikC5es1MCDXlucnkRbEkc73nvTUSBGib4kBcLbzc852BfHmg5Qp6BMK7hpz
	 F6Fo3L5bvSHIjEJNH7TYvj1pd/EFyf0TZifai9wrRzmN39jEjoD+DZXK9KEn+bqd+I
	 YZsrrewM1P3M8DwSf9rZe6RIA6y2vEP06Ern7VdoUHsmeCq5jI6uonO9jZk2sce/kY
	 Is+aE9CoL3TYw==
From: Yosry Ahmed <yosry@kernel.org>
To: Sean Christopherson <seanjc@google.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>,
	kvm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Yosry Ahmed <yosry@kernel.org>
Subject: [PATCH v2 6/7] KVM: x86: Move supported EFER bits to kvm_caps
Date: Mon,  6 Jul 2026 19:54:12 +0000
Message-ID: <20260706195413.1966458-7-yosry@kernel.org>
X-Mailer: git-send-email 2.55.0.rc2.803.g1fd1e6609c-goog
In-Reply-To: <20260706195413.1966458-1-yosry@kernel.org>
References: <20260706195413.1966458-1-yosry@kernel.org>
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
index 10669c5418da3..66fa7140d65d9 100644
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
-	if (efer & ~efer_supported_bits)
+	if (efer & ~kvm_caps.supported_efer_bits)
 		return false;
 
 	return __kvm_valid_efer(vcpu, efer);
@@ -619,7 +616,7 @@ static int set_efer(struct kvm_vcpu *vcpu, struct msr_data *msr_info)
 	u64 efer = msr_info->data;
 	int r;
 
-	if (efer & ~efer_supported_bits)
+	if (efer & ~kvm_caps.supported_efer_bits)
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
2.55.0.rc2.803.g1fd1e6609c-goog

