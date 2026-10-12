Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4243C4C14E5
	for <kvm@vger.kernel.org>; Mon, 12 Oct 2026 17:54:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791827697; cv=none; b=B7ZkB30mH0UttwIBUfe4BmEJrN4i9neplmhVR71n8RViiJoBzbBQgLeiKAyBqK3zJzWPn1JElVlEMzyTCuZAIH+CTflSly7WCh3a1dis03syxG0fHrZcSBXmx34vfh3aaGoKt4zzXwcd7e9E8WTZ2hFERldPQvPtATn57s0Wn0k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791827697; c=relaxed/simple;
	bh=FWRRxx6zY6F2irCAkFFw/Nvcl0T4Mr3IRI0IXDHJ8xU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=h2FyR6hSwnLYUUgm/lsgFthv+X/6eKhi5kzkt68v60UNl+MRdE0WzphtRHWBMkf2eXnGmGNNuHNXXQ+yKgM5ZdKH+2QCr4Ulud7gx6RtSTmJx5sDr1cc3eQIRE/m7ShnUbeefSzM2t8YptT094KjoNlw/QasTe0zBwXs62qyjug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WjPdSsRS; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WjPdSsRS"
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-4980fe6b3beso22188595e9.0
        for <kvm@vger.kernel.org>; Mon, 12 Oct 2026 10:54:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791827694; x=1792432494; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=7ypEpjY8mvLe8TMwZ/eo1EKEIbLHoE0Uzn9acxsMI+c=;
        b=WjPdSsRSyHim4avEYzpkQsvws+Uv5cXr7J/YEHXnv2O0XKrzc67wPDihDO0aWNKKSn
         hjxtTSLH5ohVwKYjTovM1g/Efvb1HWyRrqsxsfIXmhwosahwK/2RT8HEhhb63Bzp8MmB
         C/Ome8takmnbTnPAjog5lGYQxMWBVi6LdeI+D2tIIIjyO3rkR4wc6NcS1mPXfEOctAog
         +QEL48HFEwfiFB+a0OKd6k7yaL90Fkk7N3Q1+TDH4JAPoN6I4bqKQlzmwSWadeOMi4v4
         2cPMRqPDjk44Xr4qILrbdR9QevYXDBDovhAThEHd6Em8C3eGExsfotQ1OTl0EHA+AcWP
         CLbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791827694; x=1792432494;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=7ypEpjY8mvLe8TMwZ/eo1EKEIbLHoE0Uzn9acxsMI+c=;
        b=V6t0BrB8CfRILGRSvto5LF5s2UUFnb5Cdop9g23DBpllXFL1r5OvXE16NGqpJp51jR
         kcpOqIU1oKsb1+C9sy32ngcnPdl5szkazuILa07en+ncbtM6rg2++b5NRXrX57aFNZ6E
         l7PEmi8mVWdTYgyA43qOMsLAGtqI7IoHXg0jiEpyG7R9qXZrW+v2nhrlcxxTyZ+SF/A1
         ywMGuX2IMKIuqEUMQsd+kVhpAXKkYRornJH3aaMg/wbao8Fwt9UpaxWdzZtpyQxWGq0V
         1U8WsyAlpTbOZYNirRMLFSlqrHdakIQpnwCUXxLwkque1h/fZ8TNn6apW+cVtoJx+F9F
         ZeCg==
X-Forwarded-Encrypted: i=1; AKwUvBx0fYcFTZp2JMXtu4uKd4HvqxnWxqn6HU/TESAJSbYuqCWEiricygisUlFOzmSZ02B3QTs=@vger.kernel.org
X-Gm-Message-State: AFq9FYKDEdgYa+2cb2nRY2rCb36cSvF3A2pZO6QdgapREv98TXcPqauI
	O/ARoDXBTBPVcywnDFxfJeJgGrr9nCxpUnYcb4br2Rz7FY842COC5VR3
X-Gm-Gg: AYBFou1MiBvjObLesZXyZbdHVjyi+WNWaLnoc1jBCBKVDG6r9EZgTRMHDgDFfmt2kLH
	jmdbCADS9fITd5FElnpZgvfrS/Sa9Hj0as1qNGpPmLd7nsW+YOYqmFm+w3EnY+LT4hfTTLxB6O7
	A0rlEJMAh1IsbkZ0ugOrTci4KTKBkDXxswdFr5pX/c/Z5V/v4WLdEfmLrRq1ZgWs8wf3lxe1wik
	KdRgbyBZ/tGhufeIOAvA+0tfDpic/NXF+2j/F8IMkn8SPVyB+GspEnyUwsEPCGAvM56wrG0wUpD
	Ooe8jmaDyp04+eiv3L7txghkAtGTc+lvPyVB7Z/B1I2CffIiAnuD42xi3LsdUPyd+E3gmu57/FZ
	LwgykTb9Fp34+m7uXMYQX9eyE1HZod1gVn2sB0wtCdie+ylPbADwfk0AvWIne9+Z2iqDos2XKnl
	JMjYUNim3xEGCtUI+UPUWTJxIPi1hTIskpam97SOL5nEwpeUYA2TvFxX71qv2rOTervTyORBzHw
	HnScuPdTEPBeju+uWB4DWuooUKcSp8YajSGqZdKSYY45zIxaBp775ccaT7xUwmkuhGMT39L
X-Received: by 2002:a05:600d:644f:20b0:4a1:88da:800f with SMTP id 5b1f17b1804b1-4a18dcc1377mr159038565e9.9.1791827694338;
        Mon, 12 Oct 2026 10:54:54 -0700 (PDT)
Received: from voyt-laptop-dell ([2a00:fbc:ef3c:5801:aaab:bea6:6711:8153])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48de0bc7299sm518416f8f.53.2026.10.12.10.54.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Oct 2026 10:54:53 -0700 (PDT)
From: Dmitry Voytik <voytikd@gmail.com>
To: Kiryl Shutsemau <kas@kernel.org>,
	Chao Gao <chao.gao@intel.com>,
	Dave Hansen <dave.hansen@linux.intel.com>
Cc: linux-coco@lists.linux.dev,
	x86@kernel.org,
	kvm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Dmitry Voytik <voytikd@gmail.com>
Subject: [PATCH v2] coco/tdx-host: add Kconfig description
Date: Mon, 12 Oct 2026 19:53:48 +0200
Message-ID: <20261012175348.1256363-1-voytikd@gmail.com>
X-Mailer: git-send-email 2.56.0
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fix the issue when the driver always gets compiled as a module.
How to reproduce the issue:
	make mrproper
	make defconfig
	./scripts/config \
	  -e CMA \
	  -e ALLOC \
	  -e KVM \
	  -e KVM_INTEL \
	  -e KVM_INTEL_TDX \
	  -e INTEL_TDX_HOST \
	  -e TDX_HOST_SERVICES \
	  --refresh
	make olddefconfig
	make mod2yesconfig
	grep '=m$' .config

	returns only this driver as module:
	  CONFIG_TDX_HOST_SERVICES=m

Signed-off-by: Dmitry Voytik <voytikd@gmail.com>
---
v2:
 * changed per Kiryl's suggestion:
   https://lore.kernel.org/lkml/aszHlWi_aLIh8r9F@thinkstation/
v1:
 *https://lore.kernel.org/lkml/20261003223237.513456-1-voytikd@gmail.com/
---
---
 drivers/virt/coco/tdx-host/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/virt/coco/tdx-host/Kconfig b/drivers/virt/coco/tdx-host/Kconfig
index 57d0c01a4357..fe018e00822b 100644
--- a/drivers/virt/coco/tdx-host/Kconfig
+++ b/drivers/virt/coco/tdx-host/Kconfig
@@ -3,4 +3,4 @@ config TDX_HOST_SERVICES
 	depends on INTEL_TDX_HOST
 	select FW_LOADER
 	select FW_UPLOAD
-	default m
+	default KVM_INTEL
-- 
2.56.0

