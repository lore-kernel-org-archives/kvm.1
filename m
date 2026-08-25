Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B92B13E4C95
	for <kvm@vger.kernel.org>; Tue, 25 Aug 2026 22:01:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787695303; cv=none; b=rHUzDOPmx/puCWqX9FFirqDiOeB+BwE30qW8wxTcllTSJ2ox+nEJgiCBoea9wPitBNj4vky9RgKnaxHS4OBPOKLl2SZU/xra/f5698r1GlhVXfQyZvgr7LHnlMzo+FvF0j8TQ7G/Ja+ACzloHxqcmUtKMmqpJs3wm5WAM9a5/jU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787695303; c=relaxed/simple;
	bh=lnE0ol7zzduIfkhgrVH1+ZDBg8ITbgqNd7dls8x7dZQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=J5zhyYsGr84NMGyb5Mc/27qApZri9oj4p4jtO3e7cpJpTmn3418Fyszkg8L7kTDBvguYcfleqaAMGcqx1wjQBSpD86o2gtrGB47as9KSqJ7qHgD1HjwizeYcVWpZLVAsd9pQdKiJD0I16NEKCjwu+L9k+LUqgfR3BLi8hNgLaQM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=G07Fgv6M; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="G07Fgv6M"
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-38ec1402b05so419388a91.2
        for <kvm@vger.kernel.org>; Tue, 25 Aug 2026 15:01:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1787695301; x=1788300101; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=gAVb9PuAUV6dKtPBz+8ymqKUXnXtU+Fo4PlEUvBAFS4=;
        b=G07Fgv6MdE24BoxGflg/0zuz4udYd4a+cgC+QHH8JwWHRY+WZwU2v4pd9ONVEbvYqS
         3UnSMNR5oaN8eSS3VMAm6k+dYDR17FmTnFRuCLZ8r53w8Vj7r9Lg52PKh3iTQuVU0hKN
         ZTe9ldHPAES3XrLFo00rDaa+iEAd2VwLiitkgvissu4xvM4wdvt61gW5WgQQ7rUD6O9s
         IFBSwpwOOhZ/Jw9uILxuqKoK7I0KOqvGBct76Wtra3pyLSTHYzo8bsP4SAN0tHnmvMA3
         zjNRzTIktN3tJUPNp+hFib8+SLDxA7JqXZKudBw+zVVOg3mk0CrlJX/oAy1sdAEiKkTP
         gNjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787695301; x=1788300101;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=gAVb9PuAUV6dKtPBz+8ymqKUXnXtU+Fo4PlEUvBAFS4=;
        b=bJBm4qzZhR5fBlgGooClf2c6OzXGgm/FGjt/EbKdgbSmyuXkVd3JnoPhMLRCw8P9d9
         POQ1hP3Ovdc1dfaYGUVGbO/A/XSEG8h3IfNSP4oqnTUP1/HZiutl+LrVaCbDTnAjAfco
         I1p6bx6aPJXTNoFzcElPB87oK87T/V9qBMm9ncK1kdcL6MFGTy1IbRtS2Ga7znVoHUNO
         LqLQcn0ZtKiBXepDDh6m69ZNRnoWb5UO17UZmXMZWu9MbnlOvEgIlzoDdQ+RQFLJhDXN
         RrfRY6dG6UEPOdYrZVeouh7UxfuUhEz+AU5j4P1HFGxEWqb+KrW/d00V2AlyKq7/7t4X
         ljnA==
X-Forwarded-Encrypted: i=1; AHgh+RpwrhOG9iqqprxLQt2ik+WGFGE49URhfkNs48GIqQThrS+jVmrJQ65kOWIVitQn6syKo4k=@vger.kernel.org
X-Gm-Message-State: AFuF++lqda9B6yL9z13Zj/oBSmPKhO1NYrrxLqPDcVVb0MN8dCdBZOxV
	R4tmoPsC0D15obnQP6dFWE3zzYQsAAtdQxnYG7gqzuRJUEI3j7oygfC7R6JfxPie9yE=
X-Gm-Gg: AR+sD12wFxOVvdm84Nll4jWKpt5CIrAnzRTGb3f+0isaCnleMXCJbEAO+KCmswaHiZ5
	ESUxNNKi2cpv1YI5dJCL5w8sygPELtS3ZD+zxXkQCcN00caWgK1TFr2TLm5H1xUUKnLeIspHjPf
	KkmiTxJO8sDk/ZquWs3xMGdlhZXtzwLPvfqHltUpwowHJlcWS5lI2e+E66Tb43Td74xQ1E8trbx
	+pwDgztPkApXs9vTskIM+rJD2RZtWD2BI0trcSngbTk5iilOaIX+j+KOel/g3wnhnIIwYykCwgQ
	gECMKJ6bB56HbzdYoqtEWGvaPyYhfnfCUFaDo7/wal2xf3a2WmUI6dIUild58wMpm9DcFpLC5+p
	o++5AjO+tqAmAXfDzv/5D93wJF/GLn1oNrRcuhAzZ73SG5k0jismFAFyZgCdbf/pC4yAI/6Xddx
	BSCMaMx1bo+xMVRlIjhwr8q5tyw+tAEAf0Y3BR1pZLgSIjkaUq5a1PcH8/PRm1/hY/TRm3vRePD
	724KoT6zwVh7x8=
X-Received: by 2002:a17:90b:4a8d:b0:381:28e0:6259 with SMTP id 98e67ed59e1d1-3966d412ab2mr4045321a91.9.1787695300878;
        Tue, 25 Aug 2026 15:01:40 -0700 (PDT)
Received: from p14s.cg.shawcable.net ([2604:3d09:148c:c800:a37a:292f:1363:c0af])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3965d119724sm3090120a91.2.2026.08.25.15.01.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Aug 2026 15:01:40 -0700 (PDT)
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
Subject: [RFC v3 17/24] hw/arm/virt: Reserve one bit of guest physical address for RME
Date: Tue, 25 Aug 2026 16:00:54 -0600
Message-ID: <20260825220101.3443954-18-mathieu.poirier@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260825220101.3443954-1-mathieu.poirier@linaro.org>
References: <20260825220101.3443954-1-mathieu.poirier@linaro.org>
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
 hw/arm/virt.c | 20 +++++++++++++++-----
 1 file changed, 15 insertions(+), 5 deletions(-)

diff --git a/hw/arm/virt.c b/hw/arm/virt.c
index fe195d145676..2132e6595baf 100644
--- a/hw/arm/virt.c
+++ b/hw/arm/virt.c
@@ -3972,17 +3972,27 @@ static int virt_kvm_type(MachineState *ms, const char *type_str)
 {
     VirtMachineState *vms = VIRT_MACHINE(ms);
     int max_vm_pa_size, requested_pa_size;
+    int rme_reserve_bit = 0;
     bool fixed_ipa;
     int vm_type;
 
-    max_vm_pa_size = kvm_arm_get_max_vm_ipa_size(ms, &fixed_ipa);
-
     vm_type = (ms->cgs ? KVM_VM_TYPE_ARM_REALM : KVM_VM_TYPE_ARM_NORMAL);
 
+    if (vm_type) {
+        /*
+         * With RME, the upper GPA bit differentiates Realm from NS memory.
+         * Reserve the upper bit to ensure that highmem devices will fit.
+         */
+        rme_reserve_bit = 1;
+    }
+
+    max_vm_pa_size = kvm_arm_get_max_vm_ipa_size(ms, &fixed_ipa) -
+                     rme_reserve_bit;
+
     /* we freeze the memory map to compute the highest gpa */
     virt_set_memmap(vms, max_vm_pa_size);
 
-    requested_pa_size = 64 - clz64(vms->highest_gpa);
+    requested_pa_size = 64 - clz64(vms->highest_gpa) + rme_reserve_bit;
 
     /*
      * KVM requires the IPA size to be at least 32 bits.
@@ -3991,11 +4001,11 @@ static int virt_kvm_type(MachineState *ms, const char *type_str)
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

