Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C331E314A65
	for <kvm@vger.kernel.org>; Tue,  7 Jul 2026 22:43:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783464228; cv=none; b=C46hFyQYwbf1U/5TbEM3cbnlnxyA61DgcJJmXpmYBp7HXJUvz+sqVJxUT6XYQi5DauAPU5HSLw34Ef4ygu4NpB29NBCFoUMc8v1RQ3fFyzeZpGbWGbEQHwkn42SCPT2Gn8Pf+kTegv35Dmq4T9FhyzjoAHQ2onH05DtfwIE4QP4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783464228; c=relaxed/simple;
	bh=gcUzX4u6QQs4cFinTXiQFVvK8ryF5+fv2NVpLI0SAHs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sr3+77Yeok5aMdNw9IQV+qfC3KAbXyqucKp3GDHur5uaNfd1LaHR2F9dGWI+Zxt+YIpcK6ljrJ5RMRsNQea/LJz0hsMfX2zOIxDwQFjLRTGZsQV3C73w3Lv3L6TPSgYEzymdgFIlUMY46ydwBvb/BlMGirmD5IwH20AuYgTz90Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=jzo/WfiI; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="jzo/WfiI"
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-2c9b1edf2bdso1111435ad.1
        for <kvm@vger.kernel.org>; Tue, 07 Jul 2026 15:43:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1783464226; x=1784069026; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Xy1WYXDMPJXXkl+s8HBgu7HsPDMpRrDpEl9BRUa+Lhg=;
        b=jzo/WfiIpH+ZcTSqpOC0cqDFDF6wDunigcAFtJln2Dw0ysGnkyODukWTnCttFFl05v
         VCFvWP2l2i/DQiD/DhZNWyACKFs85esBItOlFtISquQfDaGmXeV5WalXhci1EIHtSlxH
         RX8xEvATJGlRHlHG458sdCa7soCPzwqdQ/PJ2lFLr4xrYaFWE+KxLZ1oRkmRUrZOrGwl
         rWLQV8PisNm2paGgQC2RY3gjluex6UDGdDkqDZS19iWnbiO8QCH7eWAxYeTXnAAkAXR+
         e9B8MvXb9wQva+neKU7Al/FZJ+vFpPGdqC8thjiPUg6xS0mTqDsJZJLL4B7JX7tA9peu
         SDdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783464226; x=1784069026;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Xy1WYXDMPJXXkl+s8HBgu7HsPDMpRrDpEl9BRUa+Lhg=;
        b=Gjyt9lXQvJBeiUYnuxCW5rhVgn/2X2Xc+pQ50n8z/aBJbe7tdjbzACzDQLaDDEVakz
         cDt822Yn3lShdso/mVOon0sXUfprloonSUaWg8xYE31Cu75Gd87MeHoyhhTDg4kmoSZB
         g+VVu8UPqPpet0CU1Cdd0+itqT9DGiYXX30hi/nq1ymCWJowligH//c9d7iETw/9s2XU
         tZ97zBCVkGwln/LYABMce7DMEeHTvkiwuDMoz0gg5spCQ0c0REvECYl/UvNY8IFjhhAC
         etS8JdTJiOuMmVmqb1NHBE4tn7nDvY0VFK5dPgtr6sgF9BaLja3KsC/t3TgY6blO6TJa
         A/Aw==
X-Forwarded-Encrypted: i=1; AHgh+RpAfVCsb+kqfJn+cQgcw63NkKIVu28swW2dp63tjHFDcTPNR5mIVrOQC86mCkDD6Cwj7Kw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzDPTfb3ev1F3U587szz1Q9MIPD7XQmWREa/Rc+BNa5Lf6M+vbD
	/V5OV0CG3deAJs2kFsC5CeFG9LWF5LBoQoI+ZewVOgZTOBFN+zCQCcAVx4A+0auFMek=
X-Gm-Gg: AfdE7cktwDkBRWJU54QZHeJuWIoHGhsdHOeW43L2AFT/b4QF212r5A+4MbVonNyK3ib
	//h8Vcj+R7l+8zryoTmcVs4rpkFoaTAAx3Mxu2EPDaZc0GWJW568d8sM5DFV3ZD25HB2nAOdO+J
	x6q3awFTliTmOWQg3jYktJp8TnglRwxzCo5GrfErMhWvGeCrlaBwfhurH0j3CWgrC4wzar+ZjCI
	5RfH18Mq1lgODYe1TioIorIagXdtmIlCda6uBJA6rMc2GKxNLabuHX1NiCkLrJfn8KPtrbSvArA
	G5X3ngZeOjdukMO3gJGG8DOcaUh1Lcz2ty4kAPT+ckmiZ4lAw39LvcJuT3OY6et4ZK/jx7YrQ0I
	6/DA95bT4yOCFpRVVLF+gKv+uAfqRsXL4hOVCDwL2AnbD4H5S9vySGp0BBXl+AS5ctXBuxc8uAv
	XTyJhI9GhcKRENQ9kxVQlJsph/g39eHTIGntaggUM=
X-Received: by 2002:a17:903:138b:b0:2ca:dd3c:dd0e with SMTP id d9443c01a7336-2ccbe7288d7mr42932815ad.2.1783464226177;
        Tue, 07 Jul 2026 15:43:46 -0700 (PDT)
Received: from p14s.cg.shawcable.net ([2604:3d09:148c:c800:46c8:dda7:40fa:8958])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ccc9d3bbaesm18183805ad.57.2026.07.07.15.43.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jul 2026 15:43:45 -0700 (PDT)
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
Subject: [RFC v1 18/25] hw/arm/virt: Reserve one bit of guest physical address for RME
Date: Tue,  7 Jul 2026 16:42:59 -0600
Message-ID: <20260707224306.1202330-19-mathieu.poirier@linaro.org>
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

When RME is enabled, the upper GPA bit is used to distinguish protected
from unprotected addresses. Reserve it when setting up the guest memory
map.

Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
---
 hw/arm/virt.c | 18 ++++++++++++++----
 1 file changed, 14 insertions(+), 4 deletions(-)

diff --git a/hw/arm/virt.c b/hw/arm/virt.c
index ac16290b442d..d98d8108c8d2 100644
--- a/hw/arm/virt.c
+++ b/hw/arm/virt.c
@@ -4053,14 +4053,24 @@ static int virt_kvm_type(MachineState *ms, const char *type_str)
     VirtMachineState *vms = VIRT_MACHINE(ms);
     int rme_vm_type = kvm_arm_rme_vm_type();
     int max_vm_pa_size, requested_pa_size;
+    int rme_reserve_bit = 0;
     bool fixed_ipa;
 
-    max_vm_pa_size = kvm_arm_get_max_vm_ipa_size(ms, &fixed_ipa);
+    if (rme_vm_type) {
+        /*
+         * With RME, the upper GPA bit differentiates Realm from NS memory.
+         * Reserve the upper bit to ensure that highmem devices will fit.
+         */
+        rme_reserve_bit = 1;
+    }
+
+    max_vm_pa_size = kvm_arm_get_max_vm_ipa_size(ms, &fixed_ipa) -
+                     rme_reserve_bit;
 
     /* we freeze the memory map to compute the highest gpa */
     virt_set_memmap(vms, max_vm_pa_size);
 
-    requested_pa_size = 64 - clz64(vms->highest_gpa);
+    requested_pa_size = 64 - clz64(vms->highest_gpa) + rme_reserve_bit;
 
     /*
      * KVM requires the IPA size to be at least 32 bits.
@@ -4069,11 +4079,11 @@ static int virt_kvm_type(MachineState *ms, const char *type_str)
         requested_pa_size = 32;
     }
 
-    if (requested_pa_size > max_vm_pa_size) {
+    if (requested_pa_size > max_vm_pa_size + rme_reserve_bit) {
         error_report("-m and ,maxmem option values "
                      "require an IPA range (%d bits) larger than "
                      "the one supported by the host (%d bits)",
-                     requested_pa_size, max_vm_pa_size);
+                     requested_pa_size, max_vm_pa_size + rme_reserve_bit);
         return -1;
     }
     /*
-- 
2.43.0

