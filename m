Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA9AF503BC5
	for <kvm@vger.kernel.org>; Thu,  3 Sep 2026 19:36:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788464223; cv=none; b=SxRAeKku2kGbfMbtpyG2NG2SsDhgobv8Cj9HIQgMOpz5NV1zVCoy7W9DMk1YnbpncIxGL/EYKAHr54lHwEshO/woFvI9MxzcywuYQT+8pN15hSwLlkvMa0g3imjx3lOQUH+StrYjRdLDqkRIp73VmAnL+s02qsbLtrHtDjwGUoA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788464223; c=relaxed/simple;
	bh=VvYf+UaS+ESqe1L7/c/mAuVasIvcu83bLN47UbJ/oXY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZAdLXeyGHr8qbTuTwI194BdYaF59oT57BzxDAOO0moP0tnR771E9OLTYXQ/Ymd7xwWng3nwt5CShBXWI6PRuqb1+47oGarSJXUJJo2YgTgYHKnmJxSOkufIv1LO+bbIb+3lkFigwVpo1TEGIeJVc3qj1ZDL/KT7sphdSAsQDTto=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=zLJV9sAZ; arc=none smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="zLJV9sAZ"
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-38511175ad3so161406a91.2
        for <kvm@vger.kernel.org>; Thu, 03 Sep 2026 12:36:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1788464207; x=1789069007; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=1L228YeDnliJno5IJsBCLMujCzUwIWC4F+2ZyI1byow=;
        b=zLJV9sAZ0k4nJi5z9SJA3zgyFWbujuRQr5ZRoGctUz7reXRmK5nig5yucPVvPhHAVJ
         w9Z6asiFqNXWBMqk86j2CQC+ySRFs4RJaCdJfMqW5MTNQYKs/GMVe2kZmudZoECmM9Br
         7tEngXcwNjHaijkk98m0jaVbhP8aHQQrP7aJPikOBP94IMj+ctUViKynxE5hUvGEX0Vf
         FtJYrNnSgFXq3kFx+E1rXraqwczZNNX65LkIVa4fpSI85iFX+IKnDLTG9mgtrQdpYQpO
         U849pj3BEO2WxgB60a+w6js1psg0vXEn+gjnNxenSUCQXBII5Cg7v8r1YBTDgXvMoseM
         tjJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788464207; x=1789069007;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=1L228YeDnliJno5IJsBCLMujCzUwIWC4F+2ZyI1byow=;
        b=ETY4b0DoSGw7Nqj+lcxBR+Rf3ITRiC7ndWgs90NMvbgQD88NN3BT20XOgFq6/RjC1b
         KN8DJFnPIlPKFOLtTOpqZjYh853UkD6h8m1nlAWM13ndgdGhArqaR6f+LgtUuRRInKpk
         6OHMFkaGj75iV59L8jJf/O5sfs+c+Y9ipdzfnZmGFuRwB8YwI20i99vk6bK6A7O6icaO
         HO0WXp0EEFw8xtw2cPabLSo0/ICrQg4ac/qR4PAdmaQUOo1fsylc4JtHE/jRvVulvmlM
         l/9vci7XtrQcYtijMmbP4HX7oEQqwfkiFDhVv9kTtgVOnOd+Ga72wkwQLYb7TS92n7ka
         OpRg==
X-Forwarded-Encrypted: i=1; AKwUvBwP+h6VUt2pZ5whG9N+J6FczbVxBSqZuCF1eh+FYB03I0cQAvL1zWrJRN8bgvuVXaDAhzs=@vger.kernel.org
X-Gm-Message-State: AFuF++kkSkM+hfGdNmNnx7ooJLvx1nxZsODrjDrdlJ9ZX8QZ8Jp7zxrk
	EjqiE/yZucR7XFWjaapTdyovcMoOpNjXw9leoTPsHaEXOAVudfdglsBL0f+Oq08+NsM=
X-Gm-Gg: AYBFou2fE3Uy5CnBwrVZubznNjaJ3setHC0OEV1cudGYemGkMbN5b5khLZ5XULCoAWe
	gGbMbmlBX6Ovh0sr8SUVloDpvTwu+tUgA689BxUu8PrQ84+NPWbNWEBQ8cKwZ42rUO5WqGLdUq9
	iZnZfX7r1qGrZbjpJWB8ehbfcTsCgF6Go3nFaL3ecE/60OgyaVywLSdYzY7dGhc4o+gfwGl6eMO
	auMatuG0BMuuaTm+zeU76UmVE5g0rG5Z5UQa/xhoySlyNFALcEowwCTIHu4D05Kfe0c8qW18kSN
	7a47BuN5pbcdbR5GYD9jBntMnIILfNASm9x1ExQ0DmalrbcF5U9QAXjWvsDJRkZyzkkKZgACamo
	MqIE5/Jp59bx/qYWmtpAIU9T2DCtaSeZCFRR/yHxCuGigJ9i3J9GL4PN4qz206tDPCqHkuaIGd7
	l4qvd9fgq2RRxOYHnhYTdoTLLsuy5bKSVkQRjkz4QlRaH7kMx5LNXKDn1IX4SQcponBAYpojd6d
	d7cWzTk42Ltaj5ayqDSiYgbvzQ=
X-Received: by 2002:a17:90b:4fcb:b0:381:a766:efcb with SMTP id 98e67ed59e1d1-39b26100e5dmr1338301a91.4.1788464207294;
        Thu, 03 Sep 2026 12:36:47 -0700 (PDT)
Received: from p14s.cg.shawcable.net ([2604:3d09:148c:c800:40c0:ec33:6266:c275])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39b083e4fafsm6836951a91.1.2026.09.03.12.36.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Sep 2026 12:36:46 -0700 (PDT)
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
Subject: [RFC v4 19/24] hw/arm/virt: Move virt_flash_create() to machvirt_init()
Date: Thu,  3 Sep 2026 13:36:06 -0600
Message-ID: <20260903193611.1058589-20-mathieu.poirier@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260903193611.1058589-1-mathieu.poirier@linaro.org>
References: <20260903193611.1058589-1-mathieu.poirier@linaro.org>
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
index 329c881eb91a..f3ece746916a 100644
--- a/hw/arm/virt.c
+++ b/hw/arm/virt.c
@@ -2911,6 +2911,8 @@ static void machvirt_init(MachineState *machine)
     unsigned int smp_cpus = machine->smp.cpus;
     unsigned int max_cpus = machine->smp.max_cpus;
 
+    virt_flash_create(vms);
+
     possible_cpus = mc->possible_cpu_arch_ids(machine);
 
     /*
@@ -4435,8 +4437,6 @@ static void virt_instance_init(Object *obj)
 
     vms->virtio_transports = NUM_VIRTIO_TRANSPORTS;
 
-    virt_flash_create(vms);
-
     vms->oem_id = g_strndup(ACPI_BUILD_APPNAME6, 6);
     vms->oem_table_id = g_strndup(ACPI_BUILD_APPNAME8, 8);
     cxl_machine_init(obj, &vms->cxl_devices_state);
-- 
2.43.0

