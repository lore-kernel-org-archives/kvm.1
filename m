Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EADB73C3448
	for <kvm@vger.kernel.org>; Tue,  7 Jul 2026 22:43:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783464206; cv=none; b=QwPfyoqdZQBaL8tqvW5HvmrsU+aIC9mWbV9Eo4Xcu6fhLaHenQvDv7BGHbTJDl0Vb8eTFcHSGPSiqekSw/rYUuxLVPI6WQPjTeKHEj8HyzCfuDNICPPZDCnpt0aa3jPy5xj2Yin8ce9jxP/hzHG3pFZ2/Np8+K4qdF7E4XlRASw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783464206; c=relaxed/simple;
	bh=ze/Z/Rwx84GmpDON8dZpmovEA4mg6lhn75oKyL1WE0Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bViPlKaUat4gsRTSfpomEKlvotqsPdY1ZgoojehiiATXvbbHFZctDyGmUPY51/zo/RqNTv9HNwLBuWOrp2IhWmLItCvb+iFmHC23WW0bqmvaxh26THrx+ADWdBzLLpB4L5MuWfO1N7148FxOm4jGy1BwG6dBAO7rp+6GLYu1sUc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=kln0PDtE; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="kln0PDtE"
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-2cace91f112so824075ad.0
        for <kvm@vger.kernel.org>; Tue, 07 Jul 2026 15:43:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1783464204; x=1784069004; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=lBJ/QDAyECFxsw9vQUS2oMzovvSIiQI/RHhlqrlamsA=;
        b=kln0PDtEyfYVakD1LjNhbG0NrLp/fCWDxTI8/T+1g+9BANwB1W0UHQlJshtD4OE7b8
         XszM4j4jvSm8GRItGMhsGlqU0XwdCvKGDzTX5nTATaBAUlwSGDKnZOzDRJ3s7wYnGjVD
         50zXhlwbpkIn/li/U3yJ3PXnJVbDOoIhDbEHdZaonT2zYikqqEBhZWytM02FQ0CkKzN4
         yL0IINxuNKvMHNuDROgUXnFs2SB9UpDAh3Cq41HB9Dy71O6QIqNPaZnCAEOCfSJkOSxy
         KulLejmOg80ZR++bnDmnThMF++A4C2ZJD9mHQM6UAhxH1GQ7KaU7YLxxzYICEqQCAWWc
         I5jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783464204; x=1784069004;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=lBJ/QDAyECFxsw9vQUS2oMzovvSIiQI/RHhlqrlamsA=;
        b=N0mNY/myDr0K+UIPNAFI+FwHpYXSih5IdLH9nhVSOztdJyyE6+ymZGwk+t93rUcZiv
         oAemOWuiMSOwMaqTA66qBm5qaLaFLvylz/9BNJ6PCl5Q9wf+hSNH69cg9/NU0A3Nyz3v
         LYxKinus1uvIwuG2b7R6qqWdbWpga0XqQAFQZC2FuP2E8u8RUNG2Z5TfALJm/GClQ4WZ
         QGEqPqG2UIQ9iEIEE4mu/t9gnkP/7lCf0hW7bofqUq1KpsK8HucD9H8pT7DaibEI09N7
         FbD3H3pX5H6g5CakXHxwKgiWfqU7D+IedZ/xdp0rIc0sh4EFJ1S2HQK8jjlRP9muvT8b
         Vp6Q==
X-Forwarded-Encrypted: i=1; AHgh+RqrU36GZr9Bz7U95I85eS8LCYRoFy8KBWLsWtFcinyoBA9GZF2nns5UoUiwwJjln96IqAA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwVQHIrpDt91lJAdNFOe4i4rHqefFR+OEZgnMbAufTbIEo04ZCL
	mAVc31RbTOVtbHUUySMAT8Tv/yq19xgBo4hi3eG/qDipEmQ7lzW6usMhpzOQgDjcjeQ=
X-Gm-Gg: AfdE7cl3MRLE8dX3tZi+SvTkHCfLfSu1NgzyrBbjE7QzsmaC0M4J7zwwrL99BhiofxO
	isClZ2lrO52me1FVsBfYNnHPNJYQU9dPsXwTW+P2ALkqD71Jzbsd/FigfLxp4/dIRFljyVXLcpW
	PWriLnbzt8Srqu5FjPXTm9uI7TqTqSZ3b14dL1eD1W4Et8o0ZUxVxzEhldwP5ikugxv8woNebUq
	IOdyo+ApS/uNPwiDG0tKXKghioS3bnkSaCCTSwSGyuWjoOn+Biah5R3cfVrzs8KcAKnCbhBJUm2
	iYrjyaMaB5hDdcwQrIgeVI56RybNwMuyYP11fIzTDF1DgSInFJ6wJnHHqNf4b/KosPMV8f1E6ke
	7WVwQzCvZCzlPC9QfnTtb7HIeURLDzNvLdrWMN2abCbcmsZl+KUZ14yrdL6ysJzsXyekHFLGtx+
	ZiM8j0RhkN+iI09avLrmcYmgG+KrkUiu82SbzG+4A=
X-Received: by 2002:a17:903:1a0f:b0:2c9:97a7:b1eb with SMTP id d9443c01a7336-2ccbf06aea0mr62459205ad.42.1783464204248;
        Tue, 07 Jul 2026 15:43:24 -0700 (PDT)
Received: from p14s.cg.shawcable.net ([2604:3d09:148c:c800:46c8:dda7:40fa:8958])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ccc9d3bbaesm18183805ad.57.2026.07.07.15.43.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jul 2026 15:43:23 -0700 (PDT)
From: Mathieu Poirier <mathieu.poirier@linaro.org>
To: berrange@redhat.com,
	kchamart@redhat.com,
	pierrick.bouvier@oss.qualcomm.com,
	peter.maydell@linaro.org,
	mst@redhat.com,
	cohuck@redhat.com,
	pbonzini@redhat.com,
	eblake@redhat.com,
	armbru@redhat.com,
	jpb@kernel.org,
	lorenzo.pieralisi@linaro.org
Cc: qemu-devel@nongnu.org,
	qemu-arm@nongnu.org,
	kvm@vger.kernel.org
Subject: [RFC v1 07/25] target/arm/kvm: Create scratch Realm VM when requested
Date: Tue,  7 Jul 2026 16:42:48 -0600
Message-ID: <20260707224306.1202330-8-mathieu.poirier@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260707224306.1202330-1-mathieu.poirier@linaro.org>
References: <20260707224306.1202330-1-mathieu.poirier@linaro.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jean-Philippe Brucker <jean-philippe@linaro.org>

When a Realm is requested, create a scratch Realm VM by setting bit 8
of the argument given to the KVM_CREATE_VM ioctl().  Bit 7-0 are reserved
for the guest PA size.

Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
---
 target/arm/kvm-rme.c  | 8 ++++++++
 target/arm/kvm-stub.c | 5 +++++
 target/arm/kvm.c      | 4 +++-
 target/arm/kvm_arm.h  | 8 ++++++++
 4 files changed, 24 insertions(+), 1 deletion(-)

diff --git a/target/arm/kvm-rme.c b/target/arm/kvm-rme.c
index 90c1d30ba24c..f763d5ed6199 100644
--- a/target/arm/kvm-rme.c
+++ b/target/arm/kvm-rme.c
@@ -99,3 +99,11 @@ void kvm_arm_rme_vcpu_init(ARMCPU *cpu)
 
     cpu->kvm_rme = true;
 }
+
+int kvm_arm_rme_vm_type(void)
+{
+    if (rme_guest) {
+        return KVM_VM_TYPE_ARM_REALM;
+    }
+    return 0;
+}
diff --git a/target/arm/kvm-stub.c b/target/arm/kvm-stub.c
index 4ab6f08637d1..6d52f172c5df 100644
--- a/target/arm/kvm-stub.c
+++ b/target/arm/kvm-stub.c
@@ -129,3 +129,8 @@ void kvm_arm_rme_vcpu_init(ARMCPU *cpu)
 {
     g_assert_not_reached();
 }
+
+int kvm_arm_rme_vm_type(void)
+{
+    g_assert_not_reached();
+}
diff --git a/target/arm/kvm.c b/target/arm/kvm.c
index 4c212ed0c337..6aa1cd04e484 100644
--- a/target/arm/kvm.c
+++ b/target/arm/kvm.c
@@ -108,6 +108,7 @@ bool kvm_arm_create_scratch_host_vcpu(int *fdarray,
 {
     int ret = 0, kvmfd = -1, vmfd = -1, cpufd = -1;
     int max_vm_pa_size;
+    int vm_type;
 
     kvmfd = qemu_open_old("/dev/kvm", O_RDWR);
     if (kvmfd < 0) {
@@ -117,8 +118,9 @@ bool kvm_arm_create_scratch_host_vcpu(int *fdarray,
     if (max_vm_pa_size < 0) {
         max_vm_pa_size = 0;
     }
+    vm_type = kvm_arm_rme_vm_type();
     do {
-        vmfd = ioctl(kvmfd, KVM_CREATE_VM, max_vm_pa_size);
+        vmfd = ioctl(kvmfd, KVM_CREATE_VM, max_vm_pa_size | vm_type);
     } while (vmfd == -1 && errno == EINTR);
     if (vmfd < 0) {
         goto err;
diff --git a/target/arm/kvm_arm.h b/target/arm/kvm_arm.h
index 12ed1eee18b4..65ec1b970606 100644
--- a/target/arm/kvm_arm.h
+++ b/target/arm/kvm_arm.h
@@ -259,4 +259,12 @@ int kvm_arm_rme_init(MachineState *ms, KVMState *s);
  */
 void kvm_arm_rme_vcpu_init(ARMCPU *cpu);
 
+/**
+ * kvm_arm_rme_vm_type
+ * @ms: the machine state
+ *
+ * Returns the Realm KVM VM type if the user requested a Realm, 0 otherwise.
+ */
+int kvm_arm_rme_vm_type(void);
+
 #endif
-- 
2.43.0

