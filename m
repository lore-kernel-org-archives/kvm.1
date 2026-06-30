Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79E32342CB2;
	Tue, 30 Jun 2026 23:47:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782863246; cv=none; b=Xuy/+UYm+8KUVeA5K5//WE5ISr2CnNAb6Qt5hCje/ev/0emXWKvT1tUJ+7JYzctSgEJIgOsYGLRj/c2JhdPAoyG9NePtQtXfTNuz16zmSxqLl1IY2RqVSaPRUwQTDAVs65g0j0rAQlzvZ9HVaLYPgAnfIjKa/7qKJu34H3mzLHw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782863246; c=relaxed/simple;
	bh=WPWtWyi1KlhA5RLYUFmao/qcW951H8RNSYU/PTNML+4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lDWqiGsJKm7Zw7bQ/ghR+gfOd2lkD9x/vZvDXWVKuO8RNpIhaqvjrMpqwAF3hotPJxPzVe4+QpBC6EV6N5pwCNCtLCGUX9lv6Z1NEW6uyfnyEXd8lfA+TA+i0DmcrtEC4sP8P7i4nFVp4MHhzqTU8OYVJ+Gzjo67KlxhyJf/2SI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FVWEZP8w; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FVWEZP8w"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 33F791F000E9;
	Tue, 30 Jun 2026 23:47:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782863244;
	bh=wP3CBH4nOsAlcEXYO58yrJ52Q+JehZDvRQruKDLqVrE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=FVWEZP8wxQMRv6J/VZLuAHkCclU5pgzcvmik7WhfpZK1TLlpaZvohBfHb2gxy2mME
	 safbrB9Iq7k8eJ4ZkLOMf3KeD+q2b3FTYIOeN/GNqZTfg3aNtkYazl42zCvy+94R2o
	 MF2eGgUDtcZHMtSLIL7gTRGHYpzMVxqUS0BvFPp/tzoxx6M0JkBFseyrLJi/xJHK9o
	 OQjmSJnp2ol8EgEiKEMp8TmFA9t6aqsjtp3ffmCL69d903UG8JOBMtJFQAmzHA+mkG
	 MBzl8bFWfCWwrCqfHtesR6xjVSQnJgUeBiqvm4uuM0HhDFt6WDDc51QisVUR+A4A54
	 5+trylSyu7pGQ==
From: Yosry Ahmed <yosry@kernel.org>
To: Sean Christopherson <seanjc@google.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>,
	kvm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Yosry Ahmed <yosry@kernel.org>
Subject: [PATCH 7/7] KVM: selftests: Extend set_sregs test to cover EFER
Date: Tue, 30 Jun 2026 23:47:15 +0000
Message-ID: <20260630234716.3039031-8-yosry@kernel.org>
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

Extend the set_sregs test to cover various bits in EFER. Update
TEST_INVALID_CR_BIT() to operate on EFER as well as CRx (and rename it
accordingly). Add test cases to check that EFER bits are disallowed
without the relevant CPUID enablement.

Assisted-by: Gemini:unknown-version
Signed-off-by: Yosry Ahmed <yosry@kernel.org>
---
 .../selftests/kvm/include/x86/processor.h     |  2 +
 .../selftests/kvm/x86/set_sregs_test.c        | 83 ++++++++++++++-----
 2 files changed, 64 insertions(+), 21 deletions(-)

diff --git a/tools/testing/selftests/kvm/include/x86/processor.h b/tools/testing/selftests/kvm/include/x86/processor.h
index 7d3a27bc0d842..b161174ece453 100644
--- a/tools/testing/selftests/kvm/include/x86/processor.h
+++ b/tools/testing/selftests/kvm/include/x86/processor.h
@@ -208,6 +208,7 @@ struct kvm_x86_cpu_feature {
 #define	X86_FEATURE_PERFCTR_NB		KVM_X86_CPU_FEATURE(0x80000001, 0, ECX, 24)
 #define	X86_FEATURE_PERFCTR_LLC		KVM_X86_CPU_FEATURE(0x80000001, 0, ECX, 28)
 #define	X86_FEATURE_NX			KVM_X86_CPU_FEATURE(0x80000001, 0, EDX, 20)
+#define	X86_FEATURE_FXSR_OPT		KVM_X86_CPU_FEATURE(0x80000001, 0, EDX, 25)
 #define	X86_FEATURE_GBPAGES		KVM_X86_CPU_FEATURE(0x80000001, 0, EDX, 26)
 #define	X86_FEATURE_RDTSCP		KVM_X86_CPU_FEATURE(0x80000001, 0, EDX, 27)
 #define	X86_FEATURE_LM			KVM_X86_CPU_FEATURE(0x80000001, 0, EDX, 29)
@@ -226,6 +227,7 @@ struct kvm_x86_cpu_feature {
 #define X86_FEATURE_SEV			KVM_X86_CPU_FEATURE(0x8000001F, 0, EAX, 1)
 #define X86_FEATURE_SEV_ES		KVM_X86_CPU_FEATURE(0x8000001F, 0, EAX, 3)
 #define X86_FEATURE_SEV_SNP		KVM_X86_CPU_FEATURE(0x8000001F, 0, EAX, 4)
+#define	X86_FEATURE_AUTOIBRS		KVM_X86_CPU_FEATURE(0x80000021, 0, EAX, 8)
 #define	X86_FEATURE_GP_ON_USER_CPUID	KVM_X86_CPU_FEATURE(0x80000021, 0, EAX, 17)
 #define	X86_FEATURE_PERFMON_V2		KVM_X86_CPU_FEATURE(0x80000022, 0, EAX, 0)
 #define	X86_FEATURE_LBR_PMC_FREEZE	KVM_X86_CPU_FEATURE(0x80000022, 0, EAX, 2)
diff --git a/tools/testing/selftests/kvm/x86/set_sregs_test.c b/tools/testing/selftests/kvm/x86/set_sregs_test.c
index 8e654cc9ab168..562afab378d11 100644
--- a/tools/testing/selftests/kvm/x86/set_sregs_test.c
+++ b/tools/testing/selftests/kvm/x86/set_sregs_test.c
@@ -21,20 +21,20 @@
 #include "kvm_util.h"
 #include "processor.h"
 
-#define TEST_INVALID_CR_BIT(vcpu, cr, orig, bit)				\
+#define TEST_INVALID_SREG_BIT(vcpu, reg, orig, bit)				\
 do {										\
 	struct kvm_sregs new;							\
 	int rc;									\
 										\
 	/* Skip the sub-test, the feature/bit is supported. */			\
-	if (orig.cr & bit)							\
+	if (orig.reg & bit)							\
 		break;								\
 										\
-	memcpy(&new, &orig, sizeof(sregs));					\
-	new.cr |= bit;								\
+	memcpy(&new, &orig, sizeof(new));					\
+	new.reg |= bit;								\
 										\
 	rc = _vcpu_sregs_set(vcpu, &new);					\
-	TEST_ASSERT(rc, "KVM allowed invalid " #cr " bit (0x%lx)", bit);	\
+	TEST_ASSERT(rc, "KVM allowed invalid " #reg " bit (0x%llx)", (unsigned long long)bit); \
 										\
 	/* Sanity check that KVM didn't change anything. */			\
 	vcpu_sregs_get(vcpu, &new);						\
@@ -46,6 +46,8 @@ do {										\
 				X86_CR4_MCE | X86_CR4_PGE | X86_CR4_PCE |	\
 				X86_CR4_OSFXSR | X86_CR4_OSXMMEXCPT)
 
+#define KVM_ALWAYS_ALLOWED_EFER EFER_SCE
+
 static u64 calc_supported_cr4_feature_bits(void)
 {
 	u64 cr4 = KVM_ALWAYS_ALLOWED_CR4;
@@ -74,6 +76,24 @@ static u64 calc_supported_cr4_feature_bits(void)
 	return cr4;
 }
 
+static u64 calc_supported_efer_feature_bits(void)
+{
+	u64 efer = KVM_ALWAYS_ALLOWED_EFER;
+
+	if (kvm_cpu_has(X86_FEATURE_LM))
+		efer |= (EFER_LME | EFER_LMA);
+	if (kvm_cpu_has(X86_FEATURE_NX))
+		efer |= EFER_NX;
+	if (kvm_cpu_has(X86_FEATURE_SVM))
+		efer |= EFER_SVME;
+	if (kvm_cpu_has(X86_FEATURE_FXSR_OPT))
+		efer |= EFER_FFXSR;
+	if (kvm_cpu_has(X86_FEATURE_AUTOIBRS))
+		efer |= EFER_AUTOIBRS;
+
+	return efer;
+}
+
 static void test_cr_bits(struct kvm_vcpu *vcpu, u64 cr4)
 {
 	struct kvm_sregs sregs;
@@ -96,26 +116,45 @@ static void test_cr_bits(struct kvm_vcpu *vcpu, u64 cr4)
 		    (sregs.cr4 & X86_CR4_PKE) ? "set" : "clear");
 
 	vcpu_sregs_get(vcpu, &sregs);
-	TEST_ASSERT(sregs.cr4 == cr4, "sregs.CR4 (0x%llx) != CR4 (0x%lx)",
-		    sregs.cr4, cr4);
-
-	TEST_INVALID_CR_BIT(vcpu, cr4, sregs, X86_CR4_UMIP);
-	TEST_INVALID_CR_BIT(vcpu, cr4, sregs, X86_CR4_LA57);
-	TEST_INVALID_CR_BIT(vcpu, cr4, sregs, X86_CR4_VMXE);
-	TEST_INVALID_CR_BIT(vcpu, cr4, sregs, X86_CR4_SMXE);
-	TEST_INVALID_CR_BIT(vcpu, cr4, sregs, X86_CR4_FSGSBASE);
-	TEST_INVALID_CR_BIT(vcpu, cr4, sregs, X86_CR4_PCIDE);
-	TEST_INVALID_CR_BIT(vcpu, cr4, sregs, X86_CR4_OSXSAVE);
-	TEST_INVALID_CR_BIT(vcpu, cr4, sregs, X86_CR4_SMEP);
-	TEST_INVALID_CR_BIT(vcpu, cr4, sregs, X86_CR4_SMAP);
-	TEST_INVALID_CR_BIT(vcpu, cr4, sregs, X86_CR4_PKE);
+	TEST_ASSERT_EQ(sregs.cr4, cr4);
+
+	TEST_INVALID_SREG_BIT(vcpu, cr4, sregs, X86_CR4_UMIP);
+	TEST_INVALID_SREG_BIT(vcpu, cr4, sregs, X86_CR4_LA57);
+	TEST_INVALID_SREG_BIT(vcpu, cr4, sregs, X86_CR4_VMXE);
+	TEST_INVALID_SREG_BIT(vcpu, cr4, sregs, X86_CR4_SMXE);
+	TEST_INVALID_SREG_BIT(vcpu, cr4, sregs, X86_CR4_FSGSBASE);
+	TEST_INVALID_SREG_BIT(vcpu, cr4, sregs, X86_CR4_PCIDE);
+	TEST_INVALID_SREG_BIT(vcpu, cr4, sregs, X86_CR4_OSXSAVE);
+	TEST_INVALID_SREG_BIT(vcpu, cr4, sregs, X86_CR4_SMEP);
+	TEST_INVALID_SREG_BIT(vcpu, cr4, sregs, X86_CR4_SMAP);
+	TEST_INVALID_SREG_BIT(vcpu, cr4, sregs, X86_CR4_PKE);
 
 	for (i = 32; i < 64; i++)
-		TEST_INVALID_CR_BIT(vcpu, cr0, sregs, BIT(i));
+		TEST_INVALID_SREG_BIT(vcpu, cr0, sregs, BIT(i));
 
 	/* NW without CD is illegal, as is PG without PE. */
-	TEST_INVALID_CR_BIT(vcpu, cr0, sregs, X86_CR0_NW);
-	TEST_INVALID_CR_BIT(vcpu, cr0, sregs, X86_CR0_PG);
+	TEST_INVALID_SREG_BIT(vcpu, cr0, sregs, X86_CR0_NW);
+	TEST_INVALID_SREG_BIT(vcpu, cr0, sregs, X86_CR0_PG);
+}
+
+static void test_efer_bits(struct kvm_vcpu *vcpu, u64 efer)
+{
+	struct kvm_sregs sregs;
+	int rc;
+
+	vcpu_sregs_get(vcpu, &sregs);
+	sregs.efer |= efer;
+	rc = _vcpu_sregs_set(vcpu, &sregs);
+	TEST_ASSERT(!rc, "Failed to set supported EFER bits (0x%llx)", sregs.efer);
+
+	vcpu_sregs_get(vcpu, &sregs);
+	TEST_ASSERT_EQ(sregs.efer, efer);
+
+	TEST_INVALID_SREG_BIT(vcpu, efer, sregs, EFER_LME);
+	TEST_INVALID_SREG_BIT(vcpu, efer, sregs, EFER_NX);
+	TEST_INVALID_SREG_BIT(vcpu, efer, sregs, EFER_SVME);
+	TEST_INVALID_SREG_BIT(vcpu, efer, sregs, EFER_FFXSR);
+	TEST_INVALID_SREG_BIT(vcpu, efer, sregs, EFER_AUTOIBRS);
 }
 
 int main(int argc, char *argv[])
@@ -132,6 +171,7 @@ int main(int argc, char *argv[])
 	 */
 	vm = vm_create_barebones();
 	vcpu = __vm_vcpu_add(vm, 0);
+	test_efer_bits(vcpu, KVM_ALWAYS_ALLOWED_EFER);
 	test_cr_bits(vcpu, KVM_ALWAYS_ALLOWED_CR4);
 	kvm_vm_free(vm);
 
@@ -151,6 +191,7 @@ int main(int argc, char *argv[])
 		    sregs.apic_base);
 
 	test_cr_bits(vcpu, calc_supported_cr4_feature_bits());
+	test_efer_bits(vcpu, calc_supported_efer_feature_bits());
 
 	kvm_vm_free(vm);
 
-- 
2.55.0.rc0.799.gd6f94ed593-goog

