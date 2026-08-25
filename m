Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3834426ED46
	for <kvm@vger.kernel.org>; Tue, 25 Aug 2026 22:01:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787695306; cv=none; b=FUPwNBbdWaiH3ADdkbMdMI45SqI3JG4tZe4dQkQgegh2wdAOHJ7DBE3x+ANkl+tgmNJWh3bKY0k9T57GjoRxAm0o8j/3IHTH1LZCglUvXaerQ8LhM4ganT518k42dyna+OqzbuHIN6ahGKWYvs+x4OG4FP6ve0AV3XJgN7xhrx8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787695306; c=relaxed/simple;
	bh=PjjWwANDRnJQDw0SQEuL/KneGFUfjeyG8wMDPr1xkcc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gKlDAl9XNN9Q+67HdU9Pc/G9TEAu+yPtMxHc7KulWuVWHDndPiGPkkDQi5VlYMbS2jKioXvfT36atbmtBk1hneJDXE7KeRmA/e5a+SpiqQGv4Zr9Sz3a0T2tmJomcFlKmJgIR+8duWA/vaAIL4BNBHerlwMrbfHVz+inbYmSNY8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=HGqHEZn9; arc=none smtp.client-ip=209.85.215.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="HGqHEZn9"
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-cbedbaba5fdso204903a12.0
        for <kvm@vger.kernel.org>; Tue, 25 Aug 2026 15:01:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1787695304; x=1788300104; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=dhCTcoxWo5P8En8U5WBnLltAvsdfRdW+zmKjCvPnEtU=;
        b=HGqHEZn9cH939WzOmBklMcDrnkhIX7R3wY4iHkDfdGThGSYG9/Jmc3WoytR30H7EMB
         q6VaCFJnHg5SfyDqDVnHm7RxmsH0U0p3xG8tuiRqH0ez5wyqKtxTadPr9poIPKQjBIct
         yL6+Q/CcDwU34kiuTjxkbZbxUyHQNVWNVHoR6Y/RL5SAUUqOnRVO2lkcm9P/LaYokEyD
         uuClEBNU8z6q+yi9yTC9Eorx77uD/uLOWBreEDdTu6VRpXGOE7le/JNkA36I5XMrhh9p
         tHMnlcl2RSVdDvf7QZR8py96cYAK2cJmVOVVvxTHHSA+aQnaxnh+txny3apjFZc4a4I9
         Hrgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787695304; x=1788300104;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=dhCTcoxWo5P8En8U5WBnLltAvsdfRdW+zmKjCvPnEtU=;
        b=JKNsIA45idu4WBpYstW/R3uKYg52lxxMZTq6Tus4mfwWYvxFd5a4smieQMOk5MiQ7P
         8BEMdCcOpX3x9BcaTZfib2ge/v1YYKw4J/1C4VrLMR0RBuWO0fPJ7v5PgqmGBm8myEyI
         RGipH28vq54S7ZXYWYE0qa0QpRRIHucmgXpF9sMlMh2DALliv5qzTmnd+JNpXU5A5WrV
         DmgRtC2Ga/U/ay/Yivpwe+ze1U/WnGDKCBoYhFukMqyPjXpEdcaq2NAg3/PqnL/QsygN
         17XKTy2OfmzDRNsiyqL0eakdZxe8uGKvyUKDgLAnKJypV5yHYfRVE89PITeqH6DoBgnu
         cFqQ==
X-Forwarded-Encrypted: i=1; AHgh+RrC8nPkWWIyGXAccBB8vb/JnS+LPmchCyr+6aoeAw/wKNiOxLyA+lXGTc9AEElh7IBJQBI=@vger.kernel.org
X-Gm-Message-State: AFuF++m9pO64AsbTv0ZFCAjN+8MWraA76L/dLTVEpkPS8EVJp5HKkql9
	Emf1OOKDMCWO/3Yi7K0LUoNroiVZZVMgCDzi1dYUwmz8uSLble1qEqmD/4hqpcF7NaU=
X-Gm-Gg: AR+sD13hW49DHAl8Xe21JwNb3G3oRs31dj10IKeNnDAdLOwcAS6h33FijvLAkTZ4huc
	QS3LXpSbYJFmFFQesi+T8IOdaI5oa7anGqCM9zPzEhrAleqfad7PHrqOxFpn6RO78sb87n65ZSb
	JjmzUSEq2f0EfGU7za3jlisgqZg8jI864ZtuYR/YVfXRjsXNqaVsnu2x3NAyJsWz0icYboHrcsd
	Wp/7/HC95/08bE8hXMWxfsCu+sVK8bd3gJP0g8diUUwuDtIqzda2FUBiJrlsuFsR+Sr52qRCkK/
	A4s3NmY2xVsk3r2G6dbq4ZrH4oGTyZ1SnuvhKUnQbyuvEFFUUzuL7KRPSqMf3GmR7F3AWvMYPZw
	dspzEIahEztVMLVb4jhWpD60QKM9wBGUzbiLtkvREEJbtq4XI/SYDR7CN//xOf0ErK96EZPso+g
	SACYxEDweHjgHHqi5VjkxuzxarFUa9H1fyAY4+R2YqGoMPIlixTSbjrb6ZrHWJu74X9wedBzn3a
	7kBMsUk1PhY3/Q=
X-Received: by 2002:a17:90b:1d47:b0:38f:aab1:5148 with SMTP id 98e67ed59e1d1-3966d8ab6e3mr4143621a91.13.1787695304520;
        Tue, 25 Aug 2026 15:01:44 -0700 (PDT)
Received: from p14s.cg.shawcable.net ([2604:3d09:148c:c800:a37a:292f:1363:c0af])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3965d119724sm3090120a91.2.2026.08.25.15.01.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Aug 2026 15:01:43 -0700 (PDT)
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
Subject: [RFC v3 19/24] hw/arm/virt: Move virt_flash_create() to machvirt_init()
Date: Tue, 25 Aug 2026 16:00:56 -0600
Message-ID: <20260825220101.3443954-20-mathieu.poirier@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260825220101.3443954-1-mathieu.poirier@linaro.org>
References: <20260825220101.3443954-1-mathieu.poirier@linaro.org>
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
index c300224f19e7..966577d6a66f 100644
--- a/hw/arm/virt.c
+++ b/hw/arm/virt.c
@@ -2861,6 +2861,8 @@ static void machvirt_init(MachineState *machine)
     unsigned int smp_cpus = machine->smp.cpus;
     unsigned int max_cpus = machine->smp.max_cpus;
 
+    virt_flash_create(vms);
+
     possible_cpus = mc->possible_cpu_arch_ids(machine);
 
     /*
@@ -4350,8 +4352,6 @@ static void virt_instance_init(Object *obj)
 
     vms->virtio_transports = NUM_VIRTIO_TRANSPORTS;
 
-    virt_flash_create(vms);
-
     vms->oem_id = g_strndup(ACPI_BUILD_APPNAME6, 6);
     vms->oem_table_id = g_strndup(ACPI_BUILD_APPNAME8, 8);
     cxl_machine_init(obj, &vms->cxl_devices_state);
-- 
2.43.0

