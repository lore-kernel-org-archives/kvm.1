Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B166837CD2A
	for <kvm@vger.kernel.org>; Thu, 26 Mar 2026 14:50:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774536649; cv=none; b=rhMeJz2Bh1111iknxUh+Ndh5Gg0H+f3hIOKk+DshjtTS1vq92mKXCQoTmn+OS6k/bnHne8WrU3xPDwkaCEcjXYCrK++5mMdqO5DtG0+GlqD4BiUw520HJgLmPU9qFGnnhVtKoN/GJd3QiPVPNYDijcqmsnWiQGMXytDSCJJIZ9U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774536649; c=relaxed/simple;
	bh=B6x1oVQ2ZTO/sKxLTE4y5V75vM6cwWpSVR6ElMqrqhc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OfjBY/el+Eyaan/1CYMYxJJ5eq1vC8FYPtUH3t7oI0sUClf0XAzltM2W4t9oVVMjum8KXPXiebeoYXQCaa7CTgiM0htHHw23NU1i29gR869slkaucl61vbTheF64g1OSr4517OsvaMI96dBfFdQF8eL4nJmKJtqTycDCfty9/Fc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Ij+9N1+W; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Ij+9N1+W"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1774536646;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=EhDFO6kbI5M1fGtaWVOwCsjF7xvLkzHuEI6cCnOHwKM=;
	b=Ij+9N1+WkMh9Wi38HPls0gxy5TfW2Y2CC9q8Qh8xcgP57T5WL3mVGzKEN0paeN/QOs3FrW
	FypGNSIos3PReR0NWfvJBlA7vmWZeUhBfmCiaog7aI7iEIHM2jdw8jYv3iu57dOpa/ztbv
	rmmwtrzE/EpgRd7OEjSQsp1xvL2Mteo=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-65-zJg0sEPONWSzjH9VLPOl9Q-1; Thu,
 26 Mar 2026 10:50:41 -0400
X-MC-Unique: zJg0sEPONWSzjH9VLPOl9Q-1
X-Mimecast-MFC-AGG-ID: zJg0sEPONWSzjH9VLPOl9Q_1774536640
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 13985180060F;
	Thu, 26 Mar 2026 14:50:40 +0000 (UTC)
Received: from virtlab701.virt.lab.eng.bos.redhat.com (virtlab701.virt.eng.rdu2.dc.redhat.com [10.6.68.74])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 112DB180036E;
	Thu, 26 Mar 2026 14:50:38 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: kvm@vger.kernel.org
Cc: Jon Kohler <jon@nutanix.com>,
	Nikunj A Dadhania <nikunj@amd.com>,
	Amit Shah <amit.shah@amd.com>,
	Sean Christopherson <seanjc@google.com>
Subject: [PATCH kvm-unit-tests 3/9] svm: add basic GMET tests
Date: Thu, 26 Mar 2026 10:50:29 -0400
Message-ID: <20260326145035.119519-4-pbonzini@redhat.com>
In-Reply-To: <20260326145035.119519-1-pbonzini@redhat.com>
References: <20260326145035.119519-1-pbonzini@redhat.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

These cover three basic scenarios of running successfully,
failing due to NX=1 and failing due to U/S=1.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 Makefile            |  2 +-
 lib/x86/processor.h |  1 +
 x86/svm.c           | 17 ++++++++++
 x86/svm.h           |  1 +
 x86/svm_npt.c       | 83 +++++++++++++++++++++++++++++++++++++++++++--
 5 files changed, 101 insertions(+), 3 deletions(-)

diff --git a/Makefile b/Makefile
index 0ce0813b..403fd495 100644
--- a/Makefile
+++ b/Makefile
@@ -93,7 +93,7 @@ COMMON_CFLAGS += $(wunused_but_set_parameter)
 CFLAGS += $(COMMON_CFLAGS)
 CFLAGS += $(wmissing_parameter_type)
 CFLAGS += $(wold_style_declaration)
-CFLAGS += -Woverride-init -Wmissing-prototypes -Wstrict-prototypes
+CFLAGS += -Wmissing-prototypes -Wstrict-prototypes
 
 # Evaluate and add late cflags last -- they may depend on previous flags
 LATE_CFLAGS := $(LATE_CFLAGS)
diff --git a/lib/x86/processor.h b/lib/x86/processor.h
index 42dd2d2a..32ce08e2 100644
--- a/lib/x86/processor.h
+++ b/lib/x86/processor.h
@@ -377,6 +377,7 @@ struct x86_cpu_feature {
 #define X86_FEATURE_PAUSEFILTER		X86_CPU_FEATURE(0x8000000A, 0, EDX, 10)
 #define X86_FEATURE_PFTHRESHOLD		X86_CPU_FEATURE(0x8000000A, 0, EDX, 12)
 #define X86_FEATURE_VGIF		X86_CPU_FEATURE(0x8000000A, 0, EDX, 16)
+#define X86_FEATURE_GMET		X86_CPU_FEATURE(0x8000000A, 0, EDX, 17)
 #define X86_FEATURE_VNMI		X86_CPU_FEATURE(0x8000000A, 0, EDX, 25)
 #define X86_FEATURE_SME			X86_CPU_FEATURE(0x8000001F, 0, EAX,  0)
 #define X86_FEATURE_SEV			X86_CPU_FEATURE(0x8000001F, 0, EAX,  1)
diff --git a/x86/svm.c b/x86/svm.c
index 58cbf0a5..a85da905 100644
--- a/x86/svm.c
+++ b/x86/svm.c
@@ -43,6 +43,23 @@ u64 *npt_get_pml4e(void)
 	return pml4e;
 }
 
+void npt_prepare_gmet_pte(bool user)
+{
+	extern u8 start;
+	u64 address = (u64)&start & ~(1 << 21);
+	u64 mask = user ? PT_USER_MASK : 0;
+	u64 *pte;
+	int i;
+
+
+	/* flip the U bit on the 2 MiB region where the code is loaded.
+	 * the U bit is only used for execution, therefore page table accesses ignore it
+	 */
+	pte = npt_get_pte(address);
+	for (i = 0; i < 512; i++)
+		pte[i] = (pte[i] & ~PT_USER_MASK) | mask;
+}
+
 bool smp_supported(void)
 {
 	return cpu_count() > 1;
diff --git a/x86/svm.h b/x86/svm.h
index 947206bb..c5695b37 100644
--- a/x86/svm.h
+++ b/x86/svm.h
@@ -418,6 +418,7 @@ u64 *npt_get_pte(u64 address);
 u64 *npt_get_pde(u64 address);
 u64 *npt_get_pdpe(u64 address);
 u64 *npt_get_pml4e(void);
+void npt_prepare_gmet_pte(bool user);
 bool smp_supported(void);
 bool default_supported(void);
 bool fep_supported(void);
diff --git a/x86/svm_npt.c b/x86/svm_npt.c
index bd5e8f35..75d9c2c9 100644
--- a/x86/svm_npt.c
+++ b/x86/svm_npt.c
@@ -87,6 +87,79 @@ static bool npt_us_check(struct svm_test *test)
 	    && (vmcb->control.exit_info_1 == 0x100000005ULL);
 }
 
+static bool npt_gmet_supported(void)
+{
+	return npt_supported() && this_cpu_has(X86_FEATURE_GMET);
+}
+
+static void npt_gmet_null_prepare(struct svm_test *test)
+{
+	/* set U=0 - no failure */
+	npt_prepare_gmet_pte(false);
+	vmcb->control.nested_ctl |= SVM_NESTED_GMET;
+}
+
+static bool npt_gmet_null_check(struct svm_test *test)
+{
+	/* reset U=1 */
+	npt_prepare_gmet_pte(true);
+	vmcb->control.nested_ctl &= ~SVM_NESTED_GMET;
+        return vmcb->control.exit_code == SVM_EXIT_VMMCALL;
+}
+
+static void npt_gmet_nx_prepare(struct svm_test *test)
+{
+	u64 *pte = npt_get_pte((u64) null_test);
+
+	/* set U=0 - failure will be from NX */
+	npt_prepare_gmet_pte(false);
+	*pte |= PT64_NX_MASK;
+	vmcb->control.nested_ctl |= SVM_NESTED_GMET;
+
+	test->scratch = rdmsr(MSR_EFER);
+	wrmsr(MSR_EFER, test->scratch | EFER_NX);
+}
+
+static bool npt_gmet_nx_check(struct svm_test *test)
+{
+	u64 *pte = npt_get_pte((u64) null_test);
+
+	/* reset U=1, NX=0 */
+	npt_prepare_gmet_pte(true);
+	*pte &= ~PT64_NX_MASK;
+	vmcb->control.nested_ctl &= ~SVM_NESTED_GMET;
+
+	wrmsr(MSR_EFER, test->scratch);
+
+	/* errata 1218 - the U bit in the page fault error code may be incorrect */
+	return (vmcb->control.exit_code == SVM_EXIT_NPF)
+	    && ((vmcb->control.exit_info_1 & ~PFERR_USER_MASK) == 0x100000011ULL);
+}
+
+static void npt_gmet_us_prepare(struct svm_test *test)
+{
+	u64 *pte = npt_get_pte((u64) null_test);
+
+	npt_prepare_gmet_pte(false);
+	*pte |= PT_USER_MASK;
+	vmcb->control.nested_ctl |= SVM_NESTED_GMET;
+
+	test->scratch = rdmsr(MSR_EFER);
+	wrmsr(MSR_EFER, test->scratch | EFER_NX);
+}
+
+static bool npt_gmet_us_check(struct svm_test *test)
+{
+	npt_prepare_gmet_pte(true);
+	vmcb->control.nested_ctl &= ~SVM_NESTED_GMET;
+
+	wrmsr(MSR_EFER, test->scratch);
+
+	/* errata 1218 - the U bit in the page fault error code may be incorrect */
+	return (vmcb->control.exit_code == SVM_EXIT_NPF)
+	    && ((vmcb->control.exit_info_1 & ~PFERR_USER_MASK) == 0x100000011ULL);
+}
+
 static void npt_rw_prepare(struct svm_test *test)
 {
 
@@ -380,9 +453,9 @@ skip_pte_test:
 	vmcb->save.cr4 = sg_cr4;
 }
 
-#define NPT_V1_TEST(name, prepare, guest_code, check)				\
+#define NPT_V1_TEST(name, prepare, guest_code, check, more...)				\
 	{ #name, npt_supported, prepare, default_prepare_gif_clear, guest_code,	\
-	  default_finished, check }
+	  default_finished, check, more }
 
 #define NPT_V2_TEST(name) { #name, .v2 = name }
 
@@ -390,6 +463,12 @@ static struct svm_test npt_tests[] = {
 	NPT_V1_TEST(npt_nx, npt_nx_prepare, null_test, npt_nx_check),
 	NPT_V1_TEST(npt_np, npt_np_prepare, npt_np_test, npt_np_check),
 	NPT_V1_TEST(npt_us, npt_us_prepare, npt_us_test, npt_us_check),
+	NPT_V1_TEST(npt_gmet_null, npt_gmet_null_prepare, null_test, npt_gmet_null_check,
+		.supported = npt_gmet_supported),
+	NPT_V1_TEST(npt_gmet_nx, npt_gmet_nx_prepare, null_test, npt_gmet_nx_check,
+		.supported = npt_gmet_supported),
+	NPT_V1_TEST(npt_gmet_us, npt_gmet_us_prepare, null_test, npt_gmet_us_check,
+		.supported = npt_gmet_supported),
 	NPT_V1_TEST(npt_rw, npt_rw_prepare, npt_rw_test, npt_rw_check),
 	NPT_V1_TEST(npt_rw_pfwalk, npt_rw_pfwalk_prepare, null_test, npt_rw_pfwalk_check),
 	NPT_V1_TEST(npt_l1mmio, npt_l1mmio_prepare, npt_l1mmio_test, npt_l1mmio_check),
-- 
2.52.0


