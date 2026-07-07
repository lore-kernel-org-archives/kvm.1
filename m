Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35455480951
	for <kvm@vger.kernel.org>; Tue,  7 Jul 2026 22:43:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783464231; cv=none; b=Bng1T8nrC6Mgc1+fnvpJ0gRWBpzfGiau8tYINPJYFBxh0UxS8ru+6Hou+cEBChCxt8T1cEkc0ZMMQLuFxIS/PIrd4iDruO3ia7zqNplqJNLCbP9fIEElwe9XK1egMgxE3uszYAll2007vrRkilJ8NlY8DNdCxRqEGc0HTWnp1pg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783464231; c=relaxed/simple;
	bh=a/vZ797JI4rAyeEzkvpaEb48i/AfGb4XWZXngkqY2XI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LbBE232RW3L8CWN8hkaQWMiU8yi278U9/ZYnik4Wl3kPA/hM/m8whm5AppsRx5r1nQgbwcuuxzQqgxN59krYHWsSBmqlzvmrN5jwHs9qII1sW9pf89OTGj6aZjPzD72gwrMfzwCPCfj0LXKOBJ33E/ztUornp7TBOQXVMB9KQco=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=VMrhOc4N; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="VMrhOc4N"
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-2ca7aaa4b85so829875ad.3
        for <kvm@vger.kernel.org>; Tue, 07 Jul 2026 15:43:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1783464229; x=1784069029; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=O86QJm1XxClMyzD31RebPc3Pom31UHvgzzbgIM9gz34=;
        b=VMrhOc4NUK3FQmz2Suzy7YSJLEg/47XFXKPt7Evz5YNQy4ahk6AzEj4FewokV2Q7xm
         /35Ii/WbvufSSMvdkTMvZDT5dN9R+8g9p6RO1YDesBeaC5nt6/PSuV7h1usJZm4QQzCt
         RnfUjdO01gm4+lUdNssNzcIXRQjP7a/g04dSKKYCqws8aDNnkhHDgvG7NjpJl2pYpy+P
         b3+6fjSrVkhLS5EjQS1LAsqLB+xBLyAdkg+NrkKuh+BognU3qkTEe0HicWxUBxx7IdMl
         I6RKpNl3nd+1btUFCEqsN7bMyml4TuOKmvg9/kckwaDYZ6YuSmGUpA4yM2SM5LZFgMZw
         e8sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783464229; x=1784069029;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=O86QJm1XxClMyzD31RebPc3Pom31UHvgzzbgIM9gz34=;
        b=iDGx6/CCn1Fqyq59BLH7YozjMRVU68oX3qVfRNcdvi12O0+GEIOOGNOLVKQYZ9orC4
         apPxM+NmXFdf/dP4VjQqRcBVL8XZ32yYiL34WdDD+rwJHFpp6pngiXtAa5hQL6tjdQOz
         mO+9N8DCrCK2i5P1+YydarCRPe5oKscwJGJIBOJMzwfJ87Iz3zOB26S+imiKgRcEVXVM
         lD5T/SjkFUbRo2UAvD/8Ohw7XUJaDM36wvwVgoC6PfaYvdSTECOza7/95fyzcvgRXPST
         4V5Aryq3BEB8Rl/odkGnMeqC20RjMHqt6GDn5MK+hYrJiPjHux7NfClroK/rVqkNjlvV
         VxbQ==
X-Forwarded-Encrypted: i=1; AHgh+RpSej2PjaJs+LaBR1vlH3i/BcgoqiXhP+NRF/8TgTrdahlECtCjCHWKW4akWErrM9wlqYw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw5EdMBrsGCcDYcKxloP/DZdrTbZKTmgZQUPi7xjnSH4FnTeQOj
	A/mXY+VRWC9TXzthT7qC72IfQPRZhIU4y9xe+WNojGyyoRc+FcV1C0SPqjrTwWlKwSQ=
X-Gm-Gg: AfdE7cnbPFlSI9hrQ//VwH9KZ3g+BtvzyOYw6jvcJC8JBqqr6aEz3/RC179wp813uyi
	wcVyTPr1lDJ+8jwNazVXiupfXc0JrYDUSn6uiWb8rl/5b/h+Kcn4wjoW0nHDLQPvxAdG0GFt0CA
	xXDtej4CnoGkbOlBa4oTbfLnxupq5VEeFCTZ6VhJ/KyIdlMIz7HOVdAbc3IQKHdOp2AVxQW77Bm
	QS0fido+i/AD7TLoxl9GvLqpuTI4UyFT5ZVGNrNGeMHtVyrNL7r/XCxODvnSWzuMdF7Du4E8uio
	Dn87o3R9Kajja1XZHypfamViJf9cThQjRtjZvnIwzDU45MiXOs2BLO1wPDo4J98vfeDLjFB/YJd
	0+ATnAJqcyLjsxKJYOepKsyLZ9cB3gKm/DGkBrCKG82XOsE/Q24uuOw0tSz1892bBvr/IXdO8j4
	AI8oFIFEo8TrxqNVfLFbnHvrOr/e0pUh9Dr3BUq2E=
X-Received: by 2002:a17:902:f789:b0:2ca:281:27f9 with SMTP id d9443c01a7336-2ccbed22936mr61406255ad.27.1783464229346;
        Tue, 07 Jul 2026 15:43:49 -0700 (PDT)
Received: from p14s.cg.shawcable.net ([2604:3d09:148c:c800:46c8:dda7:40fa:8958])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ccc9d3bbaesm18183805ad.57.2026.07.07.15.43.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jul 2026 15:43:48 -0700 (PDT)
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
Subject: [RFC v1 20/25] hw/arm/virt: Move virt_flash_create() to machvirt_init()
Date: Tue,  7 Jul 2026 16:43:01 -0600
Message-ID: <20260707224306.1202330-21-mathieu.poirier@linaro.org>
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

For confidential VMs we'll want to skip flash device creation.
Unfortunately, in virt_instance_init() the machine->cgs member has not
yet been initialized, so we cannot check whether confidential guest is
enabled. Move virt_flash_create() to machvirt_init(), where we can
access the machine->cgs member.

Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
---
 hw/arm/virt.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/hw/arm/virt.c b/hw/arm/virt.c
index 0f104447e008..2e8e29244284 100644
--- a/hw/arm/virt.c
+++ b/hw/arm/virt.c
@@ -2909,6 +2909,8 @@ static void machvirt_init(MachineState *machine)
     unsigned int smp_cpus = machine->smp.cpus;
     unsigned int max_cpus = machine->smp.max_cpus;
 
+    virt_flash_create(vms);
+
     possible_cpus = mc->possible_cpu_arch_ids(machine);
 
     /*
@@ -4429,8 +4431,6 @@ static void virt_instance_init(Object *obj)
 
     vms->virtio_transports = NUM_VIRTIO_TRANSPORTS;
 
-    virt_flash_create(vms);
-
     vms->oem_id = g_strndup(ACPI_BUILD_APPNAME6, 6);
     vms->oem_table_id = g_strndup(ACPI_BUILD_APPNAME8, 8);
     cxl_machine_init(obj, &vms->cxl_devices_state);
-- 
2.43.0

