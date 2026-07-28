Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0B6D4734D0
	for <kvm@vger.kernel.org>; Tue, 28 Jul 2026 19:27:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785266838; cv=none; b=EEcAlriGmkonHk6ruTKyoSsdFrypQFgbutH48yyQkiupGS1oM5+NJHUzZcsBSFaks0BP0E8TlDnAkc14EYOECYoDzENOvWDflTIPuInHsk5I2ZsrTUSWSJFnIncAp5CRvJE1wL7AUftpozkVWrCrHx2sOzgylonAjWryk8rb4uU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785266838; c=relaxed/simple;
	bh=li3J+wyqCe3BxbGd6NVB4OaZgs2C6qphjMlPpe2K8eU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DrWRazWT1umDpItAMuUUcNus9QhywCdwfsb7KBEQl3TIsgx27jS3zROsFg31fv/4fcaN5yXZa//6sV0uOU2kkT/QdD9q69H2Kt3gYxrTvOA2C8NFiZ9MtIpbuntl1EWXJA1nO694MeYF3N3mfwQGC/K52s6qms8BcfHrpurRrhA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=FjP4e6b7; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="FjP4e6b7"
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-384930ca5e2so146657a91.3
        for <kvm@vger.kernel.org>; Tue, 28 Jul 2026 12:27:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1785266837; x=1785871637; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=k1OKTxouEu3ExdbBGp8MAamXpMFfZiX+8/wuyJN0otc=;
        b=FjP4e6b7efk17zkSbf83x1rwSl+r/bEJJTrwbEC0PKXfYrEaZJxO92zI5hWHG1BrgI
         X80hc+S07TRMp5kBIyIoJ1XtHgOqHkRbCtHgpqENBYc1nnh83sMFehMSza8CoLCUd57m
         0vd/i4NrlexeuGY+KLyY8pGSZTEGf3RpfzlG7fDipF2G+FMyNVWQIHXKsrNXESCDiTSw
         jt8hM67YyEaqP9h9pHHArB1g8WikWN1368QH6B4+Akp9iZ0X4Qn7m6QuchEV1PpuXlwf
         elPnRviY6HWEQxPLzxnRwfJ06zmGPjNZ09UcQEoWjrTEicJL/LCPznu4ae059VF7ex7B
         YmMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785266837; x=1785871637;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=k1OKTxouEu3ExdbBGp8MAamXpMFfZiX+8/wuyJN0otc=;
        b=VsrTUHl/Xy91PDyM9OMbZTCd2K8yJLDdW7r8fBoRNxxmKlGYXZkTFm0MEhYwta7EWn
         fVKnB1VywuxeFyLUNqhW4pHUbeRCPv3+s8iL4wwjmBZ/2VB9E5zy4daKBa1xaZimA+/F
         AkClk5EfruyQZzWCy5LdMEroGpclehcWWkVzC+cKlJJw/vs8RgLIXRdibrEnSEq2uFd1
         m/ueDzIGfPAzkZLETmsysmyx08RY0VWF2LqMufcVMEoC4jyzLGTgtcooppkQq0i6Gw8J
         2VWEXL8g9WSGa/qpYnfq1ogPm+r1WemXTvRzjFgSNZnKLFgpMhs2hP5FarKQwer7kxoX
         My2Q==
X-Forwarded-Encrypted: i=1; AHgh+Rqi6gJm39A2MmSifXkMMOUr9S3Pp3FK7YTgLHM+0ggC6thXT+gST/WiqXuetj0qNVcqsaE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwBGLpVKB7Qye744onFvRXt47g4K6r9RFNGshdCDpbCT/eiPElR
	0KHP7IED794c5NBMgkbrXtaYbYK7UiDlH92HpG5Zg+8BpQFRj/0K0YFkNoGigkKGMYE=
X-Gm-Gg: AR+sD106LWxBGT0FBE8Szt91i0nQuXgViCLLcUQun0+sVlYCgGc4ITHA9yGPqsoT4gd
	jFojhRQ1SQLQrxomuhA1zIIQ3lQR2MxuOlIWkMIlSKFWNnt0hGS9WE4MytlKYOEFv12gJ4c/zn+
	OTHGOM/QEWpDhnjj4G2R8C9Xa+Dw7zqJJBiMR2sipWbjFA1Hg2pVmO/8bdcycnIpz2a4bX2eNso
	fBuVy6SFxKoOhulbU2VK0GOAOjou7/CEu1GAYJS5/CW43ZDtlA7LNbjQDxax11KKbDB1cq5LTF9
	Mz2MOvaOikyQJRSZIm0gklkFrWfwO2Mt5fEhUowYpzGBDBvWFuJFS6wLEGBYT/SZwlSyAKBQ9MQ
	KIkXjurY3mjUanUE7WY/rzGx2ZwVaagSKBCgOo7HydLn59XLbzN2p67Div9R3Nbfv+mKSopDxlj
	P2h7X4975i3I4u5/IEyiSwklEdgyjd
X-Received: by 2002:a17:90b:57cd:b0:38f:23d6:b4a9 with SMTP id 98e67ed59e1d1-38f6a518021mr4060765a91.21.1785266836872;
        Tue, 28 Jul 2026 12:27:16 -0700 (PDT)
Received: from p14s.cg.shawcable.net ([2604:3d09:148c:c800:b9d1:87c9:a085:86c9])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-38f7f1353fdsm372650a91.8.2026.07.28.12.27.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Jul 2026 12:27:16 -0700 (PDT)
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
Subject: [RFC v2 19/24] hw/arm/virt: Move virt_flash_create() to machvirt_init()
Date: Tue, 28 Jul 2026 13:26:25 -0600
Message-ID: <20260728192630.240375-20-mathieu.poirier@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260728192630.240375-1-mathieu.poirier@linaro.org>
References: <20260728192630.240375-1-mathieu.poirier@linaro.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Jean-Philippe Brucker <jean-philippe@linaro.org>

For confidential VMs we'll want to skip flash device creation.
Unfortunately, in virt_instance_init() the machine->cgs member has not
yet been initialized, so we cannot check whether confidential guest is
enabled. Move virt_flash_create() to machvirt_init(), where we can
access the machine->cgs member.

Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
---
 hw/arm/virt.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/hw/arm/virt.c b/hw/arm/virt.c
index 65ed8573f8b1..74fe21712d4f 100644
--- a/hw/arm/virt.c
+++ b/hw/arm/virt.c
@@ -2911,6 +2911,8 @@ static void machvirt_init(MachineState *machine)
     unsigned int smp_cpus = machine->smp.cpus;
     unsigned int max_cpus = machine->smp.max_cpus;
 
+    virt_flash_create(vms);
+
     possible_cpus = mc->possible_cpu_arch_ids(machine);
 
     /*
@@ -4433,8 +4435,6 @@ static void virt_instance_init(Object *obj)
 
     vms->virtio_transports = NUM_VIRTIO_TRANSPORTS;
 
-    virt_flash_create(vms);
-
     vms->oem_id = g_strndup(ACPI_BUILD_APPNAME6, 6);
     vms->oem_table_id = g_strndup(ACPI_BUILD_APPNAME8, 8);
     cxl_machine_init(obj, &vms->cxl_devices_state);
-- 
2.43.0

