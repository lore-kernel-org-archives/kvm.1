Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AE6F476692
	for <kvm@vger.kernel.org>; Fri,  7 Aug 2026 12:13:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786104816; cv=none; b=J7wf40czaiVn16/cnhCfNEgim+dfqrAAlB5bHrtbz9UtKmacrX1hQpGg4YftD7txSTAJtxT5vcumv0wfNkAcWTUq4qigtMAKpUx0gzWHMP9fJVyTd8s4PXu5AJJDcdqzsR89s4Pyb0+7mOShFb/y5H7MBEkKEe1nu39HWTF1nMs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786104816; c=relaxed/simple;
	bh=4r96qpMJsNweRuHbWhrMwI6A+/kGgFiPkndPA4GSebI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=TWZFHczVUqDBNJP3+l4u18sxQTXkdGlHncaURKqZStY2Cj0kiBzZ1tgRFVyuSo/COK7tMPG2CbdSeVBgYkOHGluGARlE61qVyhAG2kvCzoHEg0Tnkg8epbCfS+rISAENYl0UZcIfiuXPvzJpPKl3A5HN9k9G5ItubfdF665QY/k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=A0LdVsBX; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A0LdVsBX"
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-38e347638adso3700140a91.0
        for <kvm@vger.kernel.org>; Fri, 07 Aug 2026 05:13:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786104798; x=1786709598; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=/pFfoKxUGeYDD+KaCR3NP+7Oo42dFdA9+7ZCaeGWARI=;
        b=A0LdVsBX2mmkLqPjEzB1/cTCDDU0+DZZ0Rt5Lsz7sIP7O8Otu+x9Ga+FYe1eJihymR
         lTqQ9WnnyS3LBOgAD7ZfK7UCCueEMN313+uMxBBkVeEvNHeFyd0IV2rgBtQgQAHlTCwI
         aXLXCK0+cpWNiSzrl1X881kx23QKZmtBINxxrGFVAZu9q0AjCXaAEPVb+w+3sucTccQd
         nZCZyEiCrCy2MNlewrW+i6YeANQh4rZkocr9LtGTkD0acA62LPLkqLUh0e7juruXB7Gi
         UQn0AE7fTmAU5W2cMHyqkpNAnbq6sp2U++6BbE91gySlhLUkLhts9OVYOvvoRAUh8w4y
         GXKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786104798; x=1786709598;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=/pFfoKxUGeYDD+KaCR3NP+7Oo42dFdA9+7ZCaeGWARI=;
        b=MXIApm19/vtWGKriCckBHBXZwzk7sd+yLlDsTwd7SW3ixT85DQ/kKEWOnsAqqNRlXN
         VqArSaXUr2v0q893cWLhV6xDqdAEM3VNdaVp/Lb8j5aVYwSigk8nnu8/zvHQxxxx1CRP
         8KAMJOGOsX30O14w7BztsBZzoeDgh4RBJ1eRRjlp4gKhiz7tTR9mt2eErYgFE7oTu8sl
         0dBKBy6M/odgXwVriWr1dkoQfvUvtwZdfnK23eNg6NWVWi4O11RjgOcjeZcSxdnPuWG4
         dvQGyRuNJ1OFN8fbSTvj/72yqMNqC4udWjasMyLTtTVZEzI4nJfW4LmAWaDu2MpOELCu
         YN1g==
X-Gm-Message-State: AOJu0YwMjAOxwPQqtQ51ProRfOxD2QzGqPJzhdW+93GRfcWEF2kbbTwl
	z1qxdJhJzOHg5CeCYvPbwj7oBBymOcXuemSjWNkKdpNYpSyiNhcG6NKENTy29RF2
X-Gm-Gg: AR+sD12M7syUP4IPIQjVxY2ZwaTS1yXqUVG8VlzRF7LbNO6sam9kNVWM1aaJcXz/8+2
	5A16NRCmVaYJYq8zl/NnxNRo8lSQsukS65ahNlEEGkb1VVOZFxcusNDvgyMO3P/cGBNIRZL9EQ3
	n+4kd5+FKF1TwgI7IEdTBh6tqKpHfU4m4CcY+kL/X7sAekynNiZTwj6+TZ3COEg0+EaSeFrfugU
	QFkmraNmU0tcE+5+Pi2KGhX5EEutCPktLL9VBrQOd18pXSBKsd5bQYEkJifSY0N6v9YB/TWvKkN
	5AOF+QyUeCapWgL6tQaGMjZqLChgfiZvpfZWeS5dUV1UoE8uLULbdVhhAyfDnaSgvBK3EqfYL9N
	8VVVXGz/4aZlUt7ZYtRVVOMXzG9gDyfhg0isdugK2oA4Q09QcqUjT764GEFqc5MTQXy0iGPXB3r
	pf1Pj/wZce8gV2ynP9V0E1Aa0T1eu9aUKcVul00CJAR5Nzve5Dp/g1hjRILDTcHOUKlnn3ajTIt
	2cqZCLSknk=
X-Received: by 2002:a17:90b:3847:b0:38e:b400:a860 with SMTP id 98e67ed59e1d1-3903c5a7285mr20060925a91.13.1786104798131;
        Fri, 07 Aug 2026 05:13:18 -0700 (PDT)
Received: from volcano9f8e-host.amd.com ([165.204.217.251])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-315bebde2e6sm6839102eec.21.2026.08.07.05.13.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Aug 2026 05:13:17 -0700 (PDT)
From: Hemanth Selam <hemanth.selam@gmail.com>
To: Sean Christopherson <seanjc@google.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Shuah Khan <shuah@kernel.org>
Cc: kvm@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] KVM: selftests: SEV: Sanity check the launch measurement
Date: Fri,  7 Aug 2026 17:43:08 +0530
Message-ID: <20260807121308.1885737-1-hemanth.selam@gmail.com>
X-Mailer: git-send-email 2.43.7
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

test_sev() launches the guest but discards the measurement returned by
KVM_SEV_LAUNCH_MEASURE, with a TODO to validate it.  A full
attestation-style validation isn't possible from the selftest because
userspace does not possess the transport keys the PSP uses to derive the
measurement, so the expected value cannot be recomputed here.

Capture the measurement for SEV and SEV-ES guests and sanity check it:
assert that the firmware reports the blob length defined by the SEV API
specification, and that both the measurement and the nonce are non-zero.
Describe the blob layout with a struct so the buffer and field sizes are
derived from a single definition instead of open-coded magic numbers.
SNP does not return a measurement through this path, so it is skipped.

  # ./sev_smoke_test; echo "exit=$?"
  Random seed: 0x6b8b4567
  exit=0

  # ./sev_init2_tests; echo "exit=$?"
  Random seed: 0x6b8b4567
  exit=0

  # ./sev_migrate_tests; echo "exit=$?"
  Random seed: 0x6b8b4567
  exit=0

Signed-off-by: Hemanth Selam <hemanth.selam@gmail.com>
---
 tools/testing/selftests/kvm/include/x86/sev.h | 12 +++++++
 tools/testing/selftests/kvm/lib/x86/sev.c     | 11 +++++--
 .../selftests/kvm/x86/sev_smoke_test.c        | 33 +++++++++++++++++--
 3 files changed, 52 insertions(+), 4 deletions(-)

diff --git a/tools/testing/selftests/kvm/include/x86/sev.h b/tools/testing/selftests/kvm/include/x86/sev.h
index dec383e59a47..b29bf3aa0682 100644
--- a/tools/testing/selftests/kvm/include/x86/sev.h
+++ b/tools/testing/selftests/kvm/include/x86/sev.h
@@ -31,6 +31,18 @@ enum sev_guest_state {
 
 #define GHCB_MSR_TERM_REQ	0x100
 
+/*
+ * Layout of the blob returned by KVM_SEV_LAUNCH_MEASURE, per the SEV API
+ * specification, section 6.5.2: a measurement (HMAC-SHA256) followed by the
+ * nonce used to derive it.  Deriving the buffer and field sizes from this
+ * struct keeps callers layout-agnostic; only this definition needs to change
+ * if the measurement ABI is ever extended.
+ */
+struct sev_launch_measure_blob {
+	u8 measurement[32];
+	u8 mnonce[16];
+};
+
 static inline bool is_sev_snp_vm(struct kvm_vm *vm)
 {
 	return vm->type == KVM_X86_SNP_VM;
diff --git a/tools/testing/selftests/kvm/lib/x86/sev.c b/tools/testing/selftests/kvm/lib/x86/sev.c
index 93f916903461..4bfb97a0364f 100644
--- a/tools/testing/selftests/kvm/lib/x86/sev.c
+++ b/tools/testing/selftests/kvm/lib/x86/sev.c
@@ -108,10 +108,17 @@ void sev_vm_launch_measure(struct kvm_vm *vm, u8 *measurement)
 	struct kvm_sev_launch_measure launch_measure;
 	struct kvm_sev_guest_status guest_status;
 
-	launch_measure.len = 256;
+	launch_measure.len = sizeof(struct sev_launch_measure_blob);
 	launch_measure.uaddr = (__u64)measurement;
 	vm_sev_ioctl(vm, KVM_SEV_LAUNCH_MEASURE, &launch_measure);
 
+	/*
+	 * '.len' is an in/out field; the firmware reports back the actual size
+	 * of the measurement blob, which must match the layout described by
+	 * struct sev_launch_measure_blob.
+	 */
+	TEST_ASSERT_EQ(launch_measure.len, sizeof(struct sev_launch_measure_blob));
+
 	vm_sev_ioctl(vm, KVM_SEV_GUEST_STATUS, &guest_status);
 	TEST_ASSERT_EQ(guest_status.state, SEV_GUEST_STATE_LAUNCH_SECRET);
 }
@@ -191,7 +198,7 @@ void vm_sev_launch(struct kvm_vm *vm, u64 policy, u8 *measurement)
 	sev_vm_launch(vm, policy);
 
 	if (!measurement)
-		measurement = alloca(256);
+		measurement = alloca(sizeof(struct sev_launch_measure_blob));
 
 	sev_vm_launch_measure(vm, measurement);
 
diff --git a/tools/testing/selftests/kvm/x86/sev_smoke_test.c b/tools/testing/selftests/kvm/x86/sev_smoke_test.c
index bf27b6187afa..51adf7a1e1b6 100644
--- a/tools/testing/selftests/kvm/x86/sev_smoke_test.c
+++ b/tools/testing/selftests/kvm/x86/sev_smoke_test.c
@@ -150,16 +150,45 @@ static void test_sync_vmsa(u32 type, u64 policy)
 	kvm_vm_free(vm);
 }
 
+static bool is_range_nonzero(const u8 *buf, size_t len)
+{
+	size_t i;
+
+	for (i = 0; i < len; i++)
+		if (buf[i])
+			return true;
+
+	return false;
+}
+
 static void test_sev(void *guest_code, u32 type, u64 policy)
 {
+	struct sev_launch_measure_blob blob;
 	struct kvm_vcpu *vcpu;
 	struct kvm_vm *vm;
 	struct ucall uc;
 
 	vm = vm_sev_create_with_one_vcpu(type, guest_code, &vcpu);
 
-	/* TODO: Validate the measurement is as expected. */
-	vm_sev_launch(vm, policy, NULL);
+	/*
+	 * Capture and sanity check the launch measurement.  A full
+	 * attestation-style validation (recomputing the expected value) isn't
+	 * possible here as userspace does not possess the transport keys the
+	 * PSP uses to derive the measurement.  At minimum, the firmware must
+	 * hand back a non-zero measurement and a non-zero nonce (the blob
+	 * length is validated by vm_sev_launch()).  SNP does not return a
+	 * measurement through this path, so skip it.
+	 */
+	if (is_sev_snp_vm(vm)) {
+		vm_sev_launch(vm, policy, NULL);
+	} else {
+		memset(&blob, 0, sizeof(blob));
+		vm_sev_launch(vm, policy, (u8 *)&blob);
+		TEST_ASSERT(is_range_nonzero(blob.measurement, sizeof(blob.measurement)),
+			    "SEV launch measurement is unexpectedly all zeros");
+		TEST_ASSERT(is_range_nonzero(blob.mnonce, sizeof(blob.mnonce)),
+			    "SEV launch measurement nonce is unexpectedly all zeros");
+	}
 
 	for (;;) {
 		vcpu_run(vcpu);
-- 
2.43.7

