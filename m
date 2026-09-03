Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9342B50C2B2
	for <kvm@vger.kernel.org>; Thu,  3 Sep 2026 19:36:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788464209; cv=none; b=AXIDQh5T6uWnkHN0L0UBOcOI6L+87WynEkhLy2atvO6zukUdnHIbsqV8+AivFWVKyr3HYX3cck1O0tBOmlG4wl1l1FN1xH3bKZLiNN0AjP/zDYHLMTAwzBaUfUJlXHAqSaKZdcp7/XntOW/nOsYsUeYoSkC9ZQ6IWvFNyRl/Ec4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788464209; c=relaxed/simple;
	bh=W4yBK5Y1F9xzsVAZdYBSgDqoHXS+UfCRZUsX2qeQAss=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CdTeb6xMnHebO8x0eD+PtKsdlzLrINLH36FkXK3d0QCEdtRL9PLVExZqI03KuEzpZxDri3OltD2wNfFiTGIeE6W0OOMHUpU8w1SJG9lIVem7Y39b8FUFJYSx0VsajpMuim+FmZoLmnuSEbZtocGLTIevm5cA9k9CaFZoT6oSvwI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=acI4zPtC; arc=none smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="acI4zPtC"
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-39927410578so272791a91.1
        for <kvm@vger.kernel.org>; Thu, 03 Sep 2026 12:36:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1788464186; x=1789068986; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=BW+koEYMGeh3Q0Il0QE3jfPQEhQaRsizJA+FKY6y1jw=;
        b=acI4zPtCQjw1nKJwUYHopw+Ps6cqM++oq33qK4AtS39q+sYVGxQ46DGVePmYxKequt
         d32aSymXbdTg6mEiuGDynu6KPA0hIVzi0KARiPA+oesyBY7r8yeIFBJ7r1lFiyKS/aie
         OkBb8V6QKqi02RSKx6qf8e9sZ6CU1JHvhCGfBSjrrD3D+CIUxHxQZMp7WLzsDNNwes/D
         zombfy7GRX4UnrnT4w4awKv7dqW0bpGKUyIWt1tu7wCvd11iWtAoFECJxunT/n4Qm2mt
         0Z+hufOn9UbmJN0CXNqeO60OJGXTvuX28fthR4GG9gy+uo+J2zEZWNfPmxwbTulLmYy1
         khnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788464186; x=1789068986;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=BW+koEYMGeh3Q0Il0QE3jfPQEhQaRsizJA+FKY6y1jw=;
        b=HYOo6lAy8vpSbUrPsW4v7AoOkAWzWqIXNIX/YLFVsCU3WpYiiCf+A6nlfvlstqunNK
         bEpKquySpxqdcG2VU08Gz1yCl2ut19/Egsn7mB4ke2/Fghqnwvokv1oE6WE6rOwuFHyk
         XMrgI0JB+POEx0ZH5SGy7VnkIcI3zhHv8lwd8Ahd4HLTpQ9i5qhSTbJ7i2C0FxKcc8Jt
         8qnbC+dw2pDTE0u50IgZGYADkWsunAHJHsvbCQRW6DstbYJzChWx3/ppyqEbU7WV1V47
         sPy9oMWfF+QsbXEltn/V/KCYT9KYXjbY9tEBtspSjcQHgABwKYv1A7o0QIOKTemBUJV0
         quhA==
X-Forwarded-Encrypted: i=1; AKwUvBx0aDHVIUyrg6iCwrxbem6pVxd4ftSpGqkL8YTKyp8al357IzCczjd+xIcpYf5qohUwmWE=@vger.kernel.org
X-Gm-Message-State: AFuF++mcTmJF04/SULR4LWZLZFxJ1OdvfPw1gR049CgPycBiGdJmuED9
	KAWJR5tC5htW6U6KdiG04Aw84ovL0BF8dWSU0jM0S+a5ZB4fSdyJMV7+bMvt0HQPKRs=
X-Gm-Gg: AYBFou3nuLNTSRn89Tvci6W/bjqK1bnukPckNjexcIHpFiZBvnG43Zq0GJgerBrxV5l
	pu2o+Tqf2Uv2+NE0tLdnMiY67Z0O2c3aQyVots7CEErTZKdPiNEJUL2kukrVUTTzKeLnJxVWaqW
	TE3LWk/ap8GKptCpta1nQAolhmTfbLq4U0ybRnQmw2CbZt3SbvTydDqxnL73fQCYbyvGk/5cOw2
	aYPS0OAtc9gGMK2a5Iop8jNL8NtrNaxKu/hwhtrcP2Nxd99MsCG6ZqT1GzZ9ZUnEgaqvY/plh7T
	jw4SxMg6OvSFWKlWuammKYRJU9jka7QORMTG4qk6+msdT1g93qmpPFyPsGRmaac14zY5lqtvg9G
	QoGtkXB560llwBV51srkOzxaf5dlXYN0Z8+RREIUCOe15X4ry1o8EheAUi4xDbhU6p7Bof5wN8k
	WUeaxPjlgoUl3mG6PLIyFV4WhwzJSFZX4t3bHBETZRz2YeW5SQdcPl9SLoGS7FCAXZuTdjj7jdP
	eiHuSAEhedL/Zs=
X-Received: by 2002:a17:90b:4c51:b0:38e:57a3:f218 with SMTP id 98e67ed59e1d1-39b26204e5bmr851072a91.13.1788464185768;
        Thu, 03 Sep 2026 12:36:25 -0700 (PDT)
Received: from p14s.cg.shawcable.net ([2604:3d09:148c:c800:40c0:ec33:6266:c275])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39b083e4fafsm6836951a91.1.2026.09.03.12.36.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Sep 2026 12:36:25 -0700 (PDT)
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
	lorenzo.pieralisi@linaro.org,
	gshan@redhat.com,
	enju.kohei@fujitsu.com
Cc: qemu-devel@nongnu.org,
	qemu-arm@nongnu.org,
	kvm@vger.kernel.org,
	mathieu.poirier@linaro.org
Subject: [RFC v4 07/24] target/arm/kvm: Create scratch Realm VM when requested
Date: Thu,  3 Sep 2026 13:35:54 -0600
Message-ID: <20260903193611.1058589-8-mathieu.poirier@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260903193611.1058589-1-mathieu.poirier@linaro.org>
References: <20260903193611.1058589-1-mathieu.poirier@linaro.org>
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
 target/arm/kvm.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/target/arm/kvm.c b/target/arm/kvm.c
index b4c6da1fb9f3..d86e66e056b9 100644
--- a/target/arm/kvm.c
+++ b/target/arm/kvm.c
@@ -108,7 +108,9 @@ bool kvm_arm_create_scratch_host_vcpu(int *fdarray,
                                       struct kvm_vcpu_init *init)
 {
     int ret = 0, kvmfd = -1, vmfd = -1, cpufd = -1;
+    MachineState *ms = MACHINE(qdev_get_machine());
     int max_vm_pa_size;
+    int vm_type;
 
     kvmfd = qemu_open_old("/dev/kvm", O_RDWR);
     if (kvmfd < 0) {
@@ -118,8 +120,10 @@ bool kvm_arm_create_scratch_host_vcpu(int *fdarray,
     if (max_vm_pa_size < 0) {
         max_vm_pa_size = 0;
     }
+
+    vm_type = (ms->cgs ? KVM_VM_TYPE_ARM_REALM : KVM_VM_TYPE_ARM_NORMAL);
     do {
-        vmfd = ioctl(kvmfd, KVM_CREATE_VM, max_vm_pa_size);
+        vmfd = ioctl(kvmfd, KVM_CREATE_VM, max_vm_pa_size | vm_type);
     } while (vmfd == -1 && errno == EINTR);
     if (vmfd < 0) {
         goto err;
-- 
2.43.0

