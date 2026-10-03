Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5D4D39FCBC
	for <kvm@vger.kernel.org>; Sat,  3 Oct 2026 22:33:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791066812; cv=none; b=OSU5ZPhiu3590tiEqVjgL8P2JENvry7hn6OxdiyZ8D4Di7JLlSVWqaZqdG8QlM1j45/gH/QXfk7FehsLo9dokl7s7TCsIgaGMBe9NKyM6E0PSLQCtU8rUQtLhF4+CbPradu5SqfQI7+KqLCkbZ3jqfRtiIuesw6dfTdbCiiBB2c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791066812; c=relaxed/simple;
	bh=B+AzlxaEDOIbUR2XgxY3SS/3ebqvCC16gLh4COnivCk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=XffGa2COkYtYM7fzftUr3Tf+8ey6CVtz67eAp6vhTvI6oV02TJwTxdKIwozI9vmWaru0i/cidwjOk8Kg8sOKirR3S2ta8cJMeG2Gd9bF0a3VqjjaSoNn40i350GNgiiFjHK65rqMdGhh4gWpMS4S6/hHuoNvrHwu1/WPD+bLU20=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=L5Tq+hTy; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="L5Tq+hTy"
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-48b0ef9c76eso508607f8f.0
        for <kvm@vger.kernel.org>; Sat, 03 Oct 2026 15:33:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791066809; x=1791671609; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=KOWsHQRSHb+0OiLgXs2lkzN27RX1yq7wkT9nw+eMr9Q=;
        b=L5Tq+hTyDUHAbG3iCzWGTJ04AAPYTVT183bVZoJKQwBF0CjwhxFxJF7z1mVOX1+TaH
         tAh5oZ2xPNzdbvL5AwlCzc1m6vG6p9YDLpzfwROilKB70T0oaNVRqIy8COGOcbbVbayg
         /S0SKhFLsSL75i3T51/W2yujcifGgFGrPbJighRHpdtxaNBesL/creeOf4tfhHMHQ1h1
         4yy5Fa2Kb8zOjWxH8ItKtv+m5lQmC65v6f5GUFZk/Mp/0CNbTUv4LWXX5p+k/69pAHIo
         6bXL10Yr2+wVWs7bvt8+iAPRPWjgRtOKnoG4cOdnBBk7pc4GNtBQxEDA2TZtn9eXgP8b
         pA8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791066809; x=1791671609;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=KOWsHQRSHb+0OiLgXs2lkzN27RX1yq7wkT9nw+eMr9Q=;
        b=sVZq93Y7gfm2KotI554XfNxqokrb7snmrVzpci/ZbYBKciixtLZKcfJr9jSX+Nl3KT
         Aj9vjWTBoJVhUe9esa/ZzuCVJxlvumajxeTDTs3tJxP0kvEQCVaK/UAxt98By41I5Woh
         ZsmOZI5qm36OAujsTEFh/H05nbSTd99dRW2S5Dsk5lZwgyJqgl59s7FvqXCxrVeWjIBa
         8GyGTRgJvQpX9gall9otnStX3CliGbempUIVjCf+L+vftd1Q8GVkNwptqlfRqHyQ+G74
         MAYOluy6dXqce/kndtC8LkJ8ZH4L5TQfOziHQYdh97GmuWyyDXPI3aT2d3vEfzsnNVEz
         9c9g==
X-Forwarded-Encrypted: i=1; AKwUvBytSzKZaONaE/t67IBftB9DYTzGOGftERK7cgN/kVVFWqcTw5rt+3f9+gq2PdZDLsoEwlA=@vger.kernel.org
X-Gm-Message-State: AFq9FYLgGotHVMheqtfH6mZg3Ifk3X3zFg/5S5Mghpzsq+xgOjBN7V+J
	tcfdmmzFc9JMLgv0IrzxcEWArJr7+PjCzXEP/vYDS2kOBIRA/R6xQdK/
X-Gm-Gg: AYBFou0lIuohdD27IQ10sEbSC4RoFP569SD7mtdby3WWukGLaK+qzi9nGQIvOI0mq+a
	2xuo5rsvxbribsmkVw5Bt+Dnk/KwmYhPhS9pky/29tbXv/Z5RsG/d64QIZH07zxrP/P36BKD3l2
	/kabx3VCkScxI5N+ckfUlprJtD5tMyQC2zqiO/r5lCQ9NJVdrucYS9gNphItIh5tzSXO0PvT5E7
	JgXjdKStf86EEd7fuV/Pfk+n82g49nVVb+FFBndiq1x0nDDMNFmFVbby5mPadSlEY0SbE6zl/ib
	KxNVY3nOYbZNaKtelhj0jxB19uMadCU8bw49Iyn7IZHs4MKAW+wlsJPhzyPG351lGXDwloXShPB
	s6blZGz2bYeb6GpUIX25XvzTMtBBQaF/BlvpT+muFMywHAADCEo9pqInYdfNEwr0t1GDsSmk3e8
	1yd9Fcu/K8qdPdZj+FaFZlwG0XAHRn+Ld/5usx7wPh/V/tQ/EWCgYWhaUqqKcfC5/+Aqn5mouM3
	s9dMK0N/l3dla1C/WpisX82tOc5jyPzT2zqF/Hq3E/+9GTCiWibplnmVPj0BNMS9wNc2pc5XA==
X-Received: by 2002:a5d:5f91:0:b0:486:f907:ebec with SMTP id ffacd0b85a97d-48c47fe4ee6mr5052425f8f.31.1791066808651;
        Sat, 03 Oct 2026 15:33:28 -0700 (PDT)
Received: from voyt-laptop-dell.fritz.box ([2001:9e8:bd7a:9200:44fb:d9e0:fc9a:51c9])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48c5270569fsm1886371f8f.5.2026.10.03.15.33.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 03 Oct 2026 15:33:28 -0700 (PDT)
From: Dmitry Voytik <voytikd@gmail.com>
To: Kiryl Shutsemau <kas@kernel.org>,
	Chao Gao <chao.gao@intel.com>,
	Dave Hansen <dave.hansen@linux.intel.com>
Cc: linux-coco@lists.linux.dev,
	x86@kernel.org,
	kvm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Dmitry Voytik <voytikd@gmail.com>
Subject: [PATCH] coco/tdx-host: add Kconfig description
Date: Sun,  4 Oct 2026 00:32:37 +0200
Message-ID: <20261003223237.513456-1-voytikd@gmail.com>
X-Mailer: git-send-email 2.55.0
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

"make menuconfig" doesn't let switch from =m to =y either.

Signed-off-by: Dmitry Voytik <voytikd@gmail.com>
---
 drivers/virt/coco/tdx-host/Kconfig | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/virt/coco/tdx-host/Kconfig b/drivers/virt/coco/tdx-host/Kconfig
index 57d0c01a4357..5a13ec6f51e8 100644
--- a/drivers/virt/coco/tdx-host/Kconfig
+++ b/drivers/virt/coco/tdx-host/Kconfig
@@ -1,6 +1,10 @@
 config TDX_HOST_SERVICES
-	tristate
+	tristate "TDX host user interface driver"
 	depends on INTEL_TDX_HOST
 	select FW_LOADER
 	select FW_UPLOAD
 	default m
+	help
+	  See INTEL_TDX_HOST for details.
+
+	  If unsure, say N.
-- 
2.55.0

