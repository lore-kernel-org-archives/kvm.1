Received: from mail-dy2-f42.google.com (mail-dy2-f42.google.com [74.125.229.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A40B35733E
	for <kvm@vger.kernel.org>; Sat, 26 Sep 2026 07:04:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.229.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790406254; cv=none; b=byxfZOXQ/MzDeYlosPVLEfr4sM0ud7D68ROydtcSK4y1D8iNtBds+VSHm0ONAWENCRKQhuYcxV87yLwlPvn0ithrxMyPuakpAfBif8mgKkv0xWA+mwUHmop1KMvthks54dFqs7aczAV6rHXVYFSNnN3GfR8naSHHmL1lZUBz674=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790406254; c=relaxed/simple;
	bh=4NsAlWW20qJc3i7/GABMe+VycNcIJkue9j7oV/BVQjA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sCLZP/tl+LOvq4pZyXBNSyUyQKfjsqMUIXSFg6FStcY9I9tuZTq01r6UDdneTmvf4AZ9p9IT4/+jJrzBD3278HsF7tUSPxEA59fPGFmHeQT1dEbex6MvFR1VGjsGdd8PFiE77f5c+AZyRmQ4X+//beiE6SDLVL36frBrOipg9nE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RTu9j1vG; arc=none smtp.client-ip=74.125.229.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RTu9j1vG"
Received: by mail-dy2-f42.google.com with SMTP id 5a478bee46e88-342568a5b54so547904eec.2
        for <kvm@vger.kernel.org>; Sat, 26 Sep 2026 00:04:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790406253; x=1791011053; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=+A6CkIwPfSE+JT/uIHV8BW74dusgH/Hp+auhmSJ5o/0=;
        b=RTu9j1vGLLmiXpjPzZRbEJbVLmK/4Oi33h6gD0e5cahMXRQGGxkBDvaLMbmUADoplL
         qUn9Ck0r8mB2Twicqn1ZZSFfjXBhsX0tSbzKWcU2hk6Nxpo0lG/ExDUFGwctynpIIXM2
         kx/8wyD5YnIfTX5MbkWyERp5ZAGWm6F/G2HR7hDO9ao+0p8Zaj9S6/dI7UF7VP+LU8AN
         1B3awfiE8ehqU98mIC2FZncvds4sy0LjZ+r1dvHvncz208NyxwAFxI6m3Fr5S/QuXjBb
         65tytNWcIHvoz54oW7Htvj7zhbUl+V3LpRt5TlPTs0iB4TZ6pHhrEEPmvDM9g07ZedsP
         hO5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790406253; x=1791011053;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=+A6CkIwPfSE+JT/uIHV8BW74dusgH/Hp+auhmSJ5o/0=;
        b=NJ2GyuaAyxs+fFIMI9UnDhiTge+zInFh2tTyec2EelUFG0jtkOzrKhvI/BPH8epfit
         okKMPyZIoaySQvzwDtgbCAcylNOHwJ7Jlr+KKI86+S7BQPg5FJy0kKkXxl2Gy9gor8a/
         Nck04RjccF3YEScMibBn54eQmeOxS6N0jxJ012grHtzQMjnzPm+u6LWfltF2VEZrcXNH
         KixgxI8vKlhFnyA8axtzTUSYN/x3E43pz6V3ajFd/JHyG+UXOLjfBjqZbbEDKRrC3no2
         ILfWv+TN8toJksgfBAXaagMmajwfnPEbiHGwLESXe2TMRZsZjrjewxX/o+9IBH2LrTxU
         Xjsw==
X-Forwarded-Encrypted: i=1; AKwUvByRz+G5aL58Xm60g0FFieBrnQwL1HAFpe+pqwpjTZaQCvIA6wa90rLO60I7jbv7RSOhsnA=@vger.kernel.org
X-Gm-Message-State: AFuF++mFkRq/VJV/izuC/oSeRgJd2DDr5P1/Xtmb/coxrYIyVPLwooct
	xV862NyvRd0cq2kCJwkuhbvlYvEW/VWTdl2mTW3w/5S2ODeK5uz/7W/O
X-Gm-Gg: AYBFou0S5MEtj9TnhvIc/THXmM1xcdWXPvU4JuYYhY+/G/qRuuqd9FAYkaVWgGjLadm
	fj8D3AccY8IzJZZAkCVPilBy3Iqi782R8wHs2KTld1I4nWvNLZb7Z+ek4KbMjHTZjamkmQ2LEX2
	iTvMMj1AAaNsoWa+7Rg9HPCgt8KhjxVQe0Qd+stV2oL9vhCOO0eedKEhKpDQGjHimewWNQTUzT8
	m8Ijt3cfqtNQZGdBCH81UPDqpXAK11S8/tNlZ1HWoxKg45nRLo2ZTWlK1YeqRZ1duJBk1lxhJIB
	jwh/PJPvv+hg81AP9S42+1yc4Q30G2AsFgt6dSKNw/J2i5YXVwl4Gn2O0atMUjwb6XIVftDvIYa
	u6ubC39+sVkjUreaJKB64naD5Lmds3pg6D8x2FJkK/LXMCkE0ySILsqoIIxr++NjBNzdnowI5J6
	6Gos9JEy1uB7aA2h/zY0mXOpzz2JqIED/gLWrHEKgmHpxVbc8qkuF1VWtskaSj/lPX6x4paFViy
	m9o7PyUh+6shXp6784BCwvwmyDFYLl/i8KOKUbOjw==
X-Received: by 2002:a05:7300:a987:b0:33c:1f00:358 with SMTP id 5a478bee46e88-34270ac690bmr2902731eec.17.1790406252918;
        Sat, 26 Sep 2026 00:04:12 -0700 (PDT)
Received: from WIN-BH9M8FJACR9 ([103.94.185.75])
        by smtp.googlemail.com with ESMTPSA id 5a478bee46e88-34145c166cfsm10615141eec.28.2026.09.26.00.04.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 26 Sep 2026 00:04:12 -0700 (PDT)
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
Subject: [PATCH v4 48/55] hw/microblaze: set petalogix-s3adsp1800 TypeInfo.is_available
Date: Sat, 26 Sep 2026 15:00:47 +0800
Message-ID: <20260926070057.1234-49-luoyonggang@gmail.com>
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

Set TypeInfo.is_available on the petalogix-s3adsp1800 leaf to
target_is_microblaze.

Signed-off-by: Yonggang Luo <luoyonggang@gmail.com>
---
 hw/microblaze/petalogix_s3adsp1800_mmu.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/hw/microblaze/petalogix_s3adsp1800_mmu.c b/hw/microblaze/petalogix_s3adsp1800_mmu.c
index c5f64319009..a1f41b10348 100644
--- a/hw/microblaze/petalogix_s3adsp1800_mmu.c
+++ b/hw/microblaze/petalogix_s3adsp1800_mmu.c
@@ -189,6 +189,7 @@ static const TypeInfo petalogix_s3adsp1800_machine_types[] = {
         .name           = TYPE_PETALOGIX_S3ADSP1800_MACHINE,
         .parent         = TYPE_MACHINE,
         .class_init     = petalogix_s3adsp1800_machine_class_init,
+        .is_available   = target_is_microblaze,
         .instance_size  = sizeof(S3Adsp1800MachineState),
     },
 };
-- 
2.52.0.windows.1

