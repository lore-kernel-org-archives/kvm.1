Received: from mail-pj2-f38.google.com (mail-pj2-f38.google.com [74.125.227.166])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19513414410
	for <kvm@vger.kernel.org>; Fri,  2 Oct 2026 20:20:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.166
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790972457; cv=none; b=cACJfMAk4bd7TjXZpU3f3hlwlTmj4qHCkAZFxXr+qdf3b/M7vsAT3o0lcn9duZQYZ1ITjJ7QPswqfdzCTK+ddYtK7URbNu6Fo6ou/QmqfVXadForniQ9i7lXEaErnncOLZhmMkdDiMu0VNuAae0n7NTaECa6lrj4qLHSJmEGqFI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790972457; c=relaxed/simple;
	bh=HaxxaabPaf+gUAkaE6l/WvBQsX41sco57uSwiCiJWcc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qREY/+Jr3/oc/dH2heSu+e1tngfdlgxx/GbVZjIetTja+14/U6mOQQK9LMuansBpYuV6wURGgqPpzo3luZImDRZpH5KYS0rBNDswV1ZYTBMWv9Cs7Q66uEpENK+dZ46vVKraguCDEC7W0Hjt8wcakxL7KovL7zgAvTS3l1usTjs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Lfnsgcsk; arc=none smtp.client-ip=74.125.227.166
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Lfnsgcsk"
Received: by mail-pj2-f38.google.com with SMTP id d9443c01a7336-2e2db9f927cso22118005ad.1
        for <kvm@vger.kernel.org>; Fri, 02 Oct 2026 13:20:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1790972455; x=1791577255; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=xGwa4+kYIpnF7nSKCoYuD6ZjnEJjyPrjCuP1EkufKsg=;
        b=LfnsgcskLdVxruObX1JQLgXMVnwiexqauP9EkRnDsoOHXlV5RCke2ewJDGX6jPVjUu
         3n9tLAYBWMDN/FAUru/Dy9sXEVLjkZEC+gfkyL/JAUZ+SF7SJeq5Vx7NE7KT8kMqOWap
         zEvZR/ufBF+DYBp5cGHhDYQXpTQEVq/URMVRZDNPQg6Mn74Kpowr87JMmpSbnfOECadN
         I134w3wKGRAMyUmF//hYy682CiPCHEWnoMzDNR45sgv8kQxvBya62urgR6HjK/T2g9aE
         GcvoZvtw76Eje5ZPOxT59gKMyR1c/FWoGOeOIrjADbpdePhjQcPjQ3G7T8FJ90OQHmup
         yX4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790972455; x=1791577255;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=xGwa4+kYIpnF7nSKCoYuD6ZjnEJjyPrjCuP1EkufKsg=;
        b=r5+MfAdlSr+Ykn2wPKCPi08+O2iTr98FVzJc26/oCmPhkmXAvmIKn2rDAeZMy1Zr02
         phJrS81uUP9gN3holonoxBbTzaJz59BzFmFfY+51Lma/ADJBq4WpvsGUaM5xJMnbGDY0
         PeHruNB9rljr+4l9QViSXpiSD5stsxc5TXk4FdNxPHn9qqHnt2OreCFMEEdJYJ0jdlNC
         36+FIBa8IbBpUBRIZDRdMFToKHvyqaqVQmMpMNfScr8dO+gbO87RMpOPVhS8/6PxGxuZ
         3ZwbCRbeyiXQoPH69OSDeAtCgIOVanqvBeTeBxh0JnK2MHCgd/CdnqI4EBh0wtzQRvIh
         8+Iw==
X-Forwarded-Encrypted: i=1; AKwUvBwZ8dFlfPAbtnZLB4eM9SUfuDb3Yz6s02GRieMmhSVslL8Wg+7H+u0PWACkfUxllJ7QTgM=@vger.kernel.org
X-Gm-Message-State: AFq9FYJiuQqHXJMe1KVFjbHwIyEy+tsqrrV/UqcReW1qXbg3mzVDWbDH
	YlaxkdsyxuRnTompy0TvBnc8JJdcFseX3lubklHH5EVQLQRgnZ8VVXoPux315+MJDCU=
X-Gm-Gg: AYBFou3vB30Seiyx2mOn8y6skfRJeRsolONeHZiTxs2gOJCJwd+Uz3yAGmchYTAQxZB
	JVPPSfmpCQ+yRZnsLVl/mPWt5VURiGdN292QTu6Qjk+5ktUm1fv6H8eJaN4eoKX37pCDfNPZl+q
	Bp9FtoVNVljcJ12+Dn/81xk2QsvLFWyHqhKaAsLe4nOtQK6Xddhi8BHlhHVZgOma7jeMGgRXBDD
	UL1gr242jReYb360lla7ulMLBjUj6kdDbgbp+/+PF17LYV4g23wKSgtZaHn5en5fcePj7dAmX5u
	viLth7KPUuXmMqsoynbyexiYwUxQeUmdiLnw8b7sgfVDiLxwlSeVrDeLGdtxCBo76XDPQZCENef
	savlj+IcfQ1ERZX9V0LboQ3QysVT5H8IdyDD6grDW9waSel97TUr2rrEsTKFC62IXiLEMdAXzM2
	T9LzEPT8cEZuA5J164Yl3/2cC3yBRWm/98E6dkAwfd4NKI4LcU2rbC62ZjB36Rc4SJBuMN7kB1C
	USQlB8VYuEHDo2RftGhKUODniRPtXXjvEE=
X-Received: by 2002:a17:903:18e:b0:2e3:1bb4:6113 with SMTP id d9443c01a7336-2e49b648c41mr40464145ad.26.1790972455139;
        Fri, 02 Oct 2026 13:20:55 -0700 (PDT)
Received: from p14s.cg.shawcable.net ([2604:3d09:148c:c800:61ac:e744:6559:a357])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2e49f6a99acsm12399415ad.34.2026.10.02.13.20.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Oct 2026 13:20:54 -0700 (PDT)
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
	gshan@redhat.com
Cc: qemu-devel@nongnu.org,
	qemu-arm@nongnu.org,
	kvm@vger.kernel.org
Subject: [RFC v5 14/22] hw/arm/virt: Embed Realm VM type with IPA address space
Date: Fri,  2 Oct 2026 14:20:18 -0600
Message-ID: <20261002202026.1204110-15-mathieu.poirier@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261002202026.1204110-1-mathieu.poirier@linaro.org>
References: <20261002202026.1204110-1-mathieu.poirier@linaro.org>
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
index 5ab4bb23ef2d..cdfb71ce97d3 100644
--- a/hw/arm/virt.c
+++ b/hw/arm/virt.c
@@ -96,6 +96,8 @@
 #include "qemu/guest-random.h"
 #include "hw/watchdog/sbsa_gwdt.h"
 
+#include <linux/kvm.h>
+
 static GlobalProperty arm_virt_compat_defaults[] = {
     { TYPE_VIRTIO_IOMMU_PCI, "aw-bits", "48" },
 };
@@ -4047,9 +4049,12 @@ static int virt_kvm_type(MachineState *ms, const char *type_str)
     VirtMachineState *vms = VIRT_MACHINE(ms);
     int max_vm_pa_size, requested_pa_size;
     bool fixed_ipa;
+    int vm_type;
 
     max_vm_pa_size = kvm_arm_get_max_vm_ipa_size(ms, &fixed_ipa);
 
+    vm_type = (ms->cgs ? KVM_VM_TYPE_ARM_REALM : KVM_VM_TYPE_ARM_NORMAL);
+
     /* we freeze the memory map to compute the highest gpa */
     virt_set_memmap(vms, max_vm_pa_size);
 
@@ -4074,7 +4079,11 @@ static int virt_kvm_type(MachineState *ms, const char *type_str)
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

