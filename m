Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.169
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794263502;
	b=47fcDmdUXxt2xBJm7mwwW9TwtS197L1KvFq+xkMTvf/6eGFYzkAah8Gj9PBTdtZZjHKw
	 CPspmlJsP9nphOEqn4dFOndZj/2AfVFLwGX2fS47gDsc94vypJGPi8wm9ceqzvkTCSp2v
	 5UEhuqUeXs4cY/r9W9oAO0mGhzod5lrElY1fHT/IkgTJwGc4I5QINhFJtIY4uKuC+QY8C
	 cNK8Z0NLB4zbcF8GpPu5rgOqZK0ExE/GNyKM5GdxOw+jUccrbgk4xG+4JZPjLI8W63SbK
	 4JGvRkyKTrPXhprgi1syitbqyjXugwrVi2v9IQtV10kGSJNU46b40siYPXkIfOM8q3w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794263502;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=Gfp51PLlf67b5A5in6MUJzCYhyc5cgtldNZyxdvH6Ec=;
	b=sXb+D188uG84GWQaSkz2a4432wt2O4KtnPcTY+Hm2Qin/KTHXdd62nx0xbzOLQGnlt4t
	 yp88b+4DGNdgmdlDHdkB+EbehV2ycSV8Udmlrc5xIpTlYcuSwRjcNhm+y/6MHKe0u7rxZ
	 w7cRI4qcbVMgS6Vg4zPq7nIs/N1jsyNZtAl2PIvBinovyqC6gfgBTCZPSVnCGa2Y5dGx/
	 wlKycOyzr2tKc/uuEXrFx7JrugyW/b3fQxunNLc2jUaW1XCCJur00FfPdTErVBNq53FhD
	 EaWFcQIradlT4mIiDApjuATgJuB6YBz7iEjbMxMKJTjLMX5fM1k/ydgVioh4eyKP7hQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linaro.org;
	spf=pass smtp.mailfrom=linaro.org;
	dkim=pass header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=h49GjNHI;
	arc=none smtp.remote-ip=209.85.210.169
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 818E5606A333
	for <kvm@vger.kernel.org>; Mon,  9 Nov 2026 22:31:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 818E5606A333
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=h49GjNHI
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-8a9f9473029so1101638b3a.2
        for <kvm@vger.kernel.org>; Mon, 09 Nov 2026 14:31:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1794263501; x=1794868301; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Gfp51PLlf67b5A5in6MUJzCYhyc5cgtldNZyxdvH6Ec=;
        b=h49GjNHI0QDFHiy7B/hFFHYWaBQEfZPVhGi8EzUiNKcHtXKGPc+3PZaeA4UjM/Szzx
         q9vKFK/68KJUOM3cLZvJOTMh5xGakCTnI+6wR5MNg3eyzQ6EpmdTODf9vxpWf632PHSz
         7NvhH5IqbyH/+61KWPQ3jKTjDkq5uITqzwxiZ8ArDvdPXHZTchflhvIWbWh67WdwhzXW
         FQVeqM4vKBfP7gbkXAJ8F26KMW5USwELSosD1ecDb8qDOPVWbBztXIhPqeEKQPOF3DSq
         2E0LDtErchVnNGSU1YH5vqVzdpmOau76oAwCyc2MzT7YDcWuLtMeySp1H7eoiVW9psFH
         e+Cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794263501; x=1794868301;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Gfp51PLlf67b5A5in6MUJzCYhyc5cgtldNZyxdvH6Ec=;
        b=0Iy91Izg1UfI2U/oZfrnuSDqtiYyVjqfOck9xH55X79yjjPKmtCvudF1G5LUblmg6J
         KDSGGz7L6VAn0wXoGqeMejNkw1wmVKq8GKB14e3xZ3NvyiqQTkV2WKSL9xIRUzooLLBv
         kIPWwQtNFIuyw029IQifPd0lcQ64Zs5q4ucoweOe1uM8UxzyOD3yn3IZ2z+nrCnWooo7
         j718kMd2oxBmqOdNBUCjfTfrF4fzDnSigDcHNI5so1omrRtvlGoDOpPCdSYimigqkyGn
         n1/OPunBSCAZ0YBmtaunGJLgKlHYJBUhzYHtQXObb1edKEXVHs0noBNsS0SgVhN7ED/P
         /Tpw==
X-Forwarded-Encrypted: i=1; AL+hErHVOQnkpcIJBnHV2vHuPa6oAXdSB9T+60KhIlqSvwU7LuUvIS4p8DBS+7IJUoMR290BGfw=@vger.kernel.org
X-Gm-Message-State: APuU4Z9g5039La19WoumgSCHg/20P3wb6Thn1t32Ae9dpXySaGH7IxKU
	Aty3U2jos76XDiMCiNi0Roop0zLR2Jg5IRKpEAyE7YzNE9d7ojaFcGCBDOgHdreIG6U=
X-Gm-Gg: AYBFou3NkINuAauUODisMGUSG/MPpYB2OnkcBkJ4QcKeY0ZqEIaaItZ4eOCNdusndsh
	px1VCLDrMuSMC4enEnleBbAXIqggLlo6sRzaErhVGMLBgDPBpGuz9scGZZS6VYjZRd9sO+tOaY7
	WggTyxHnRpy7BeoL+mr3vHWVs4a8O6yUA7VwVgxOFTVpdjMLjFhBjkr7Nq01kUhHcx0g6kAcFYT
	yA3gf8WhT7GZFbrO2nfyWopOxzGVUCynW2TufJH7jSxUgg+8FMl/drBXe2uvLmvLtJRjr8q21YF
	RbVqvlJ1UARnN7pIb5Lg1QIDdlUIyM8su7cJBmSMYGIVeF8S9RZlAjJtJ0FGcxD0tY6c0qq7IRc
	5ushRHkMVQqEETQaAk/LDrjj7SdbmG0qe1xqVre0gGryLt1Haq5HjoAqRGozlDDyi7EdAIaAUW4
	XkrtB9k0kWiie174MfDknCwbzqlhsj6U+yGp9/A9GOAuzugpm4LzIvJd/uyo32/3DEmVSi+A024
	0l6cmYwR58Lz/goE7OS6Y8F5d6drrrWWCHs/eCzR/nQxXGIZsvPeMoh8fq727LyfE0IbjTxyFTB
	UuHLIJY7ZoOcq3IdMi3catNhPRrKI3HBQ/z4fCCBuE9d7C3JGqoWWQ==
X-Received: by 2002:a05:6a00:951c:b0:8b5:f313:9f40 with SMTP id d2e1a72fcca58-8ba87e0a5cfmr993721b3a.49.1794263500868;
        Mon, 09 Nov 2026 14:31:40 -0800 (PST)
Received: from p14s.cg.shawcable.net ([2604:3d09:148c:c800:54d7:1b5:4356:16fb])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8baa506bca4sm165830b3a.0.2026.11.09.14.31.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Nov 2026 14:31:40 -0800 (PST)
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
	enju.kohei@fujitsu.com,
	lorenzo.pieralisi@linaro.org,
	gshan@redhat.com,
	michael.roth@amd.com
Cc: qemu-devel@nongnu.org,
	qemu-arm@nongnu.org,
	kvm@vger.kernel.org
Subject: [PATCH v6 15/23] hw/arm/virt: Embed Realm VM type with IPA address space
Date: Mon,  9 Nov 2026 16:31:02 -0600
Message-ID: <20261109223110.1619504-16-mathieu.poirier@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261109223110.1619504-1-mathieu.poirier@linaro.org>
References: <20261109223110.1619504-1-mathieu.poirier@linaro.org>
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jean-Philippe Brucker <jean-philippe@linaro.org>

Set the Ream VM bit in the IPA address space size when needed.

Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
---
 hw/arm/virt.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/hw/arm/virt.c b/hw/arm/virt.c
index 0ed6df4b9b9e..349257f53f2d 100644
--- a/hw/arm/virt.c
+++ b/hw/arm/virt.c
@@ -95,6 +95,8 @@
 #include "qemu/guest-random.h"
 #include "hw/watchdog/sbsa_gwdt.h"
 
+#include <linux/kvm.h>
+
 static GlobalProperty arm_virt_compat_defaults[] = {
     { TYPE_VIRTIO_IOMMU_PCI, "aw-bits", "48" },
 };
@@ -4058,6 +4060,7 @@ virt_machine_get_hotplug_handler(MachineState *machine, DeviceState *dev)
 static int virt_kvm_type(MachineState *ms, const char *type_str)
 {
     VirtMachineState *vms = VIRT_MACHINE(ms);
+    int vm_type = ms->cgs ? KVM_VM_TYPE_ARM_REALM : KVM_VM_TYPE_ARM_NORMAL;
     int max_vm_pa_size, requested_pa_size;
     bool fixed_ipa;
 
@@ -4087,7 +4090,11 @@ static int virt_kvm_type(MachineState *ms, const char *type_str)
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
2.53.0

