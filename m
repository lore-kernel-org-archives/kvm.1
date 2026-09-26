Received: from mail-dy2-f42.google.com (mail-dy2-f42.google.com [74.125.229.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 948E8547063
	for <kvm@vger.kernel.org>; Sat, 26 Sep 2026 07:04:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.229.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790406270; cv=none; b=g7pW/TF/ljLZZ2726y5S/SJE1Alr9Z49QbopO+utlWBn1Dl/mXy4KdLrk3akdfu/tiQpsfrMIjzfkw/w+KkjPsSAR3jRmydyGy0aP4aI0QkQyn35MvRHIDtd+1ZYGl+1soZE5FV2UF7ntlAWurqiszv5KV7rlUtT44BOK5HkZSU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790406270; c=relaxed/simple;
	bh=Rf+YWt1EeNmx2dSLTuXKTkgKJYY3AaxRKQJEve/17u0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XClb5S9pRcLSQhqciX5Ao0ZyRR+M8o5ZBN1I9f+m3mi7sintSYU3YKTYRjUIB016ZpfwClKA6YqXedsjQkJs4pbJFhsxR76qQUua8kup23Ky1L8RTcBxyIwSxfuzVKlN86cgthkSQJxQRpb+hsornj44+6Rlh8+AiCr77fgU7Ec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Y7MliVpe; arc=none smtp.client-ip=74.125.229.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y7MliVpe"
Received: by mail-dy2-f42.google.com with SMTP id 5a478bee46e88-341f6327b95so909822eec.0
        for <kvm@vger.kernel.org>; Sat, 26 Sep 2026 00:04:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790406269; x=1791011069; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=VCuHWY6Hw+A4Xk8E6Eag+wxaYi6gJJVKssV/rB0uMSY=;
        b=Y7MliVpeQ9eGAOb4kGQ75teGjTfqmxJYMYlhXy4Jl7TIq3Sl8s8oSn/FwPQaM1HUFe
         0uu560m+MmzntBH29anh17wXHI2d/wKOkbNhoQLZPcGBo/DykKDPrGn5OJC1a9xC3G33
         D0dYSBcRxsGOppLWbSx49Icf6F+Dg3P7k3wjPoiqGIQuMTDSPPlrO4nYHXMRxaovE4gx
         MXclEdX5cvI3V9q7ftLB1mN2dqvl3VQ9GFtfoR8OtZQF/TAU9V+wufdiBZAOnWbas7qw
         afxeSJabZu6WS8zeiQP/XZ9MDNIkHYqPKQTJ9q9uR4k6xwTNbml0GKupp41S+ExsBCKi
         1luw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790406269; x=1791011069;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=VCuHWY6Hw+A4Xk8E6Eag+wxaYi6gJJVKssV/rB0uMSY=;
        b=TbrObBbCAEu/iZ4rgAAPSyud5lR8EPxfCiBVCOF1s/xVGFNue93NZj2ZPXgBgrYTnk
         Di8RqZ1xTZM1eDGMPSz9pGAsENYpQmLFWq3dEXQCmHhv2q/UETWWRclxYGFS6yGg4BDw
         NkAQ6DU3YWfguE0NbCqHuCprFwultxdQBVKekkhQigt0RtTfJZLFQ7yYphoYPldCDoKC
         1RNhvKbBxXTV+yz/5tYumPmdZojR+2un2E/So+uP8TsyGI+RXaJSvrux0MhzYG0xGKm0
         D6OAEscJjjReTB0PByM2ny9719b6alDafvGAisGz08HUHr7AmeEert/8kkz1I9oTeGKI
         nk1g==
X-Forwarded-Encrypted: i=1; AKwUvBxYv+Y1aVMMf77u2s5hmOxNRtpgP/OgQ8IA0aPyaVbkBpfTEdQ9wKIPJ3PTWRG3h6VgSG0=@vger.kernel.org
X-Gm-Message-State: AFuF++kEnMw+oPIBy1TTn4AEtVzbFIbd/iFJlqAbGyMozaEfxtKswF/Y
	Pvmr9/9KLBoUTKcMbOVoBhUWwxPup+BgFr7ZHEVz9KdJ+cynG9X9obwp
X-Gm-Gg: AYBFou3My1LuHTGwzoubDmxSSL7grMx3o9DuN2BCEnzTQ4az0wizTgFNwKtNcY2MXyR
	zjCadKVBS48Io4BocAPQSHZ57AxyiVha3qyDcP1xA/8XSTU1gAc9D7CFMo/Hb9VijWnnClysj2t
	Aa6c/u0TwXEGcj4E+XkuiCtE+iCML1t4AB/6vUoRBXGNyYUwvGigsNNlYTO74mLHR4E0vknZFES
	uRTNAb3dLGfijwdHJ2W4gjpJa2Ic7zHU0sgUki7ceyWlTHX187tv1F6RX75vSieiY/9WvPtmRZL
	Gy5DQtdAl31sebqga2W3EcAlb+sMnHKDJO/0jEj6f7DeSdUvaYdJhNuOZxFNF+JcQ/0qRJcRHYa
	AEIVu5Eb9edaTi4E1nfpUbGDwZl5U/417Gyf+s+Ph33U9D6HEVtxC/RGlRlPD51gFK38vVXMkC9
	k2f51pKJh6VdXNFTNpuoUQicxecNCezKzr2h+odZ64YI1N/S2Ghb+Bp8xZYmQhU0Du3NC92tfkw
	pdcZi4Z6DWsE4pFMdT9mPfpb2eldobZzGuDrPHfIQ==
X-Received: by 2002:a05:7300:d941:b0:328:3542:b73e with SMTP id 5a478bee46e88-342707b5de8mr1811320eec.15.1790406268100;
        Sat, 26 Sep 2026 00:04:28 -0700 (PDT)
Received: from WIN-BH9M8FJACR9 ([103.94.185.75])
        by smtp.googlemail.com with ESMTPSA id 5a478bee46e88-34145c166cfsm10615141eec.28.2026.09.26.00.04.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 26 Sep 2026 00:04:27 -0700 (PDT)
From: Yonggang Luo <luoyonggang@gmail.com>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
	=?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
	=?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
	"Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
	Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
	Fabiano Rosas <farosas@suse.de>,
	Laurent Vivier <lvivier@redhat.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Alistair Francis <alistair@alistair23.me>,
	Peter Maydell <peter.maydell@linaro.org>,
	=?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
	qemu-arm@nongnu.org,
	kvm@vger.kernel.org
Subject: [PATCH v4 52/55] hw/arm: set virt TypeInfo.is_available
Date: Sat, 26 Sep 2026 15:00:51 +0800
Message-ID: <20260926070057.1234-53-luoyonggang@gmail.com>
X-Mailer: git-send-email 2.52.0.windows.1
In-Reply-To: <20260926070057.1234-1-luoyonggang@gmail.com>
References: <20260926070057.1234-1-luoyonggang@gmail.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Set TypeInfo.is_available to target_is_base_arm on
DEFINE_VIRT_MACHINE_IMPL.

Signed-off-by: Yonggang Luo <luoyonggang@gmail.com>
---
 hw/arm/virt.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/hw/arm/virt.c b/hw/arm/virt.c
index 3eecf094bcc..a0a954ce693 100644
--- a/hw/arm/virt.c
+++ b/hw/arm/virt.c
@@ -132,6 +132,7 @@ static void arm_virt_compat_default_set(MachineClass *mc)
         .name = MACHINE_VER_TYPE_NAME("virt", __VA_ARGS__), \
         .parent = TYPE_VIRT_MACHINE, \
         .class_init = MACHINE_VER_SYM(class_init, virt, __VA_ARGS__), \
+        .is_available = target_is_base_arm, \
     }; \
     static void MACHINE_VER_SYM(register, virt, __VA_ARGS__)(void) \
     { \
-- 
2.52.0.windows.1

