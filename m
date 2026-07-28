Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 077A24734CF
	for <kvm@vger.kernel.org>; Tue, 28 Jul 2026 19:27:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785266831; cv=none; b=uPYVenVwVKYHH3bQpyE9/8LA+xKBmF4u9cdEsdHMelcgX9GfX9ufwzskccblhct8lXvPH85Y7Gm7Q4ZsaC7YBksp/ou1U+OQGIJQREtczBer2AgAIWsfokSHd9vl7KF6BuyUPNCf6NiWRrMSH0tdSidtbS9G3YTZu52822XUuqo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785266831; c=relaxed/simple;
	bh=NFop+L0ckqbio0tieTCSeA16WC4jOKIBgeE1SdDQadc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=h9G+lFMGJUHGdlPNjUaI4J2DiyH7JRltnnvreRcwzeE5vJvL4dNAj0kTYZN8rtgPj1BtWayy5/xHbFhPEONDvStG8xcrk3DfHAoYpL+BBw/Y8x7OiTDzjNgT9eXzzaJkJXO3ciOggQw0wtMkkuJacxOe7EH6px6klUEi1B47bvM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=pUD9Dl04; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="pUD9Dl04"
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-383cb94f742so241168a91.3
        for <kvm@vger.kernel.org>; Tue, 28 Jul 2026 12:27:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1785266829; x=1785871629; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=O97834IMZHMJj8CNpJQMqMEGxl2bcDXLGwhFx5nEj0E=;
        b=pUD9Dl04QoekONgDSazKqCGtxbJ0qFs6ZEuNkkssH80HsNKANeUk1hEjQp9+bRMJep
         1yo/vw+z4PhKgZHrKlgPIynPNTHY8Slfk5q6GkCU80vI+qfYMoRsYJlKHEpvtbF5WX5H
         Rnoali0hGIuhvpskZDhw1XHI/YJuoW2EkTi80Ix+UJJObcCtkXEp/QOdJHOT+6AwO1Ed
         0l1TUh+Yv2ZAQ+q8larRzy5shrNGbvtypIiGOqSvHZj8XClD1kTyF+CAo+Z5UG/Cv7WZ
         Q2Jv2XOPsYPDkbVQ6UUOHiBsMt3UgRpDuAI/UGDjuM30tBB3wt8sEQG3N0jtDyRdMpAS
         NsUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785266829; x=1785871629;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=O97834IMZHMJj8CNpJQMqMEGxl2bcDXLGwhFx5nEj0E=;
        b=QDLLyvAe3RFijODWeDfjIr2tXzpA/dTio7Y7rqqGQJQkaV7NmHIpQ2SIJ77gIaxkTN
         +VNrC4WHMAI8uGwx1fMGZqroGNy7VUpHVGgXtwrfTujfIbNN/9wA4zgWunBSNCZLGL86
         NTyN+2ZiKEkjhdihvPr4M6dJLP6kPJJF9ZFCOFR4bPvFT/ZKwzu11UIhKMiHMIugicnV
         eqfIfKu7n567XpggA/BNVVbrYAj8yKKOjzNHRLqx7eb9WeIEZDgyfgHz6EUArwQElz3r
         U7MdexZImF6xpET0L0VzkrUFcALCo1d1AIjBYUmRiw32XCGKgN1Z6yotEfVjy7WvH8Lb
         2Dkw==
X-Forwarded-Encrypted: i=1; AHgh+Rr9H365SP7DIKLqEATgUh6iv36mlJL6xajNfaSRbJfMrV7kgQQQ/qIedqTZCjKL4wiJl0M=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyx30XY7fX2sLj13yXAEpJ4duoSbNjrZpWKqkiFE/QovP1X7k7R
	PlMtRt8Y1a6W5Mk/8RzEJdesxjq0gqaf/TbgO6smOOUjlps6kfZK4E4XgH+pcLxSJyY=
X-Gm-Gg: AR+sD115IFTSoKT/VK918ibC8EgpCveo+sjyTneeuQOge4jL1szJ6FIiF9d3++G4+jk
	0QbH0JRlSslmDGXJEDpI5xt6TdOEak1wBT3HyLEF+ug/upCPqgrfyj9OErnwukcJzO6D3kbN1h5
	fVNyfyH04thES5jttvGtGIsRNIVOJmCr6JYqgEFCpdJJKV0hpSZIrDzPWej+q1UycJXS7g9yGE6
	xsdVpiAHfcPOmlj0FoT+G4VlyqAOCPUZTVFfH630258HSMdp5s7wxUn6xb8pMnke+QSF6bIcIg9
	OjCUQfbDK4g2e4Ts0VV4KnxmWpc9KP46IPmpuiAvCwooaEd7andex8QWlyy1Q6Rlw4fbwcgYKQ5
	EGXhbKvBlJy/gvhSYjTpFOcD4ElI0jaHJpAl60KPiobxl6Bt6i/GdG/71tBC8QLi49yp0t6EtpT
	doK/H+OA2ckkM2ZASIjs4iHeYAT7PK
X-Received: by 2002:a17:90b:4483:b0:38e:584f:2515 with SMTP id 98e67ed59e1d1-38f6a465c40mr3652686a91.37.1785266829178;
        Tue, 28 Jul 2026 12:27:09 -0700 (PDT)
Received: from p14s.cg.shawcable.net ([2604:3d09:148c:c800:b9d1:87c9:a085:86c9])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-38f7f1353fdsm372650a91.8.2026.07.28.12.27.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Jul 2026 12:27:08 -0700 (PDT)
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
	gshan@redhat.com
Cc: qemu-devel@nongnu.org,
	qemu-arm@nongnu.org,
	kvm@vger.kernel.org
Subject: [RFC v2 16/24] hw/arm/virt: Embed Realm VM type with IPA address space
Date: Tue, 28 Jul 2026 13:26:22 -0600
Message-ID: <20260728192630.240375-17-mathieu.poirier@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260728192630.240375-1-mathieu.poirier@linaro.org>
References: <20260728192630.240375-1-mathieu.poirier@linaro.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jean-Philippe Brucker <jean-philippe@linaro.org>

Set the Ream VM bit in the IPA address space size when needed.

Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
---
 hw/arm/virt.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/hw/arm/virt.c b/hw/arm/virt.c
index 27bed9755320..9123f46fae4a 100644
--- a/hw/arm/virt.c
+++ b/hw/arm/virt.c
@@ -97,6 +97,8 @@
 #include "qemu/guest-random.h"
 #include "hw/watchdog/sbsa_gwdt.h"
 
+#include <linux/kvm.h>
+
 static GlobalProperty arm_virt_compat_defaults[] = {
     { TYPE_VIRTIO_IOMMU_PCI, "aw-bits", "48" },
 };
@@ -4053,9 +4055,12 @@ static int virt_kvm_type(MachineState *ms, const char *type_str)
     VirtMachineState *vms = VIRT_MACHINE(ms);
     int max_vm_pa_size, requested_pa_size;
     bool fixed_ipa;
+    int vm_type;
 
     max_vm_pa_size = kvm_arm_get_max_vm_ipa_size(ms, &fixed_ipa);
 
+    vm_type = (ms->cgs ? KVM_VM_TYPE_ARM_REALM : KVM_VM_TYPE_ARM_NORMAL);
+
     /* we freeze the memory map to compute the highest gpa */
     virt_set_memmap(vms, max_vm_pa_size);
 
@@ -4080,7 +4085,11 @@ static int virt_kvm_type(MachineState *ms, const char *type_str)
      * the implicit legacy 40b IPA setting, in which case the kvm_type
      * must be 0.
      */
-    return fixed_ipa ? 0 : requested_pa_size;
+    if (fixed_ipa) {
+        return 0;
+    }
+
+    return requested_pa_size | vm_type;
 }
 
 static int virt_get_physical_address_range(MachineState *ms,
-- 
2.43.0

