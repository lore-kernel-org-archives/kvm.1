Received: from mail-dy2-f42.google.com (mail-dy2-f42.google.com [74.125.229.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA4C73A4508
	for <kvm@vger.kernel.org>; Sat, 26 Sep 2026 07:03:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.229.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790406198; cv=none; b=ou1CGnYhp44IoirLuYI09e2vtawyGlHHZcQgp6SUKHWHEw6FZsi0XHGejz9BmrxmlYCZR0NxLTJjt5ulHMdQLJzskgZJ33RzAKyAcxVwdV3/S+rIsGpJQUdvbltImDHbUie0tOHOHQ9og8Y8ererUaQHkYxiSGpW7UxsAlvLJng=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790406198; c=relaxed/simple;
	bh=24X60m9KUAm4ni/CgGGE+H9y4tlPvg7ZxoocemLXhv0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BYwS2qCIdVVVOTPf3aCMySZTW5kFeqXkt4G9P7vsqzHJmp9tgHTgCjUacvtRnX+8APaDe/2FPBu0zjXfHryERw3+mDawoNmG8vO7bytha0//R/TjM7WJhQY+AE4nabVR7RoaGTQKNQiPisWeFG2VG7gQ+F/PiD9HDKnPrG2fjU0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PkD6GLXY; arc=none smtp.client-ip=74.125.229.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PkD6GLXY"
Received: by mail-dy2-f42.google.com with SMTP id 5a478bee46e88-341d0522b4dso1977919eec.1
        for <kvm@vger.kernel.org>; Sat, 26 Sep 2026 00:03:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790406195; x=1791010995; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=jzZaAkkKnBmPcCjdhFCa0BO5hawVQDowSY7mBjvBRFI=;
        b=PkD6GLXYPLdvzNeOXtr2zVO6pO9OMe64bhAK2wEEV02I8KCMfA5TaWos3XnzIEDqA7
         jw8j8ptZXHCiCLgfNfLwyNTAcBY2zq4npHTWiOjisyooYCVkYEv56cDH1JF4nVUBeuL6
         SaTYQ2uB9V1+WsNdIVpJ6ynHQHIQnCv3jay4Pfq4s6T+cP0DxVkzeBRPTAqT6LOtFOdi
         DwoE576LOcKXCcydmDoQ3ewkxBq2lZ+CW6zPi9ocJyrfDq1pF91KaoB3zNjQskXLvHs6
         gEFidQeDFsZ9ZRo3XoqepgheBHrHhPxNlEnaJni6RC4z16D+0UZFRc4yLVVt7JnZfW8f
         PDWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790406195; x=1791010995;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=jzZaAkkKnBmPcCjdhFCa0BO5hawVQDowSY7mBjvBRFI=;
        b=hcIscFz+2EoDmlvZ8kiWhPhRsbML37+rF89OT7v9oYjIMpnZB9QWSIRip+nV9QsNMJ
         h/Vx3AYaXNqobAHCUsjIy3bMX7u+Y0guMUsP9gg4ylN8TrDp5B71dMzYU8cqUSAH9Dgp
         N6Jn1orkhtVPj7hvhkYaza1j+sWajeSVeyQnTkYeB+2MuMBs8hzTvxC002YaRKxAyuho
         B7LX3/1vIY7oZYCkUKcK8Y1SlCT47g3XDzGVw2Ci7JE/57QG/jikv+dNR73lNWM/ySNs
         TzhyYPCiZT+kP7eWKKZ3D/h9SE71Iq7TGo/TjRGM6OCj/TRCeEHF9MRb0EtCbGaFaKVu
         b68w==
X-Forwarded-Encrypted: i=1; AKwUvBx0jRW8b7T9VISd4Hm9RisBS21Pwo0kLYeCMcCo0qpixe0TjwiHM3AEiPYOQAKiTrV0Nh8=@vger.kernel.org
X-Gm-Message-State: AFuF++lcYRocUr9clzPHBsLJOMFxbzYrPfMVIDopIHvcLMbSH54nfcUl
	NtcMbYg5zSv+57+iCSmCyscPH4u/5n5GiFTojKfdQJJ7nMJ3BlQoFE9G
X-Gm-Gg: AYBFou32mJvunQ373m+AGqgvz8hXqnzr2Dm/Vmo6JEYHcjsm7snblLRml+SRJ4GX2zP
	1p/olA1fwE1JYvtXxtHkb/3rMcN7QU3PEbgfdJ93oBI5VZmUW7XchdMxhHVBn8AYLI+mQQOLRcC
	uh3+N7EeBhNQX+VlY/XYxEpiVXJfB9VPyvXwaB8m72pXr41aFB9eARlvGCgiywexnFTx6qYpOoB
	FNxLLNCJlVD6qJigqrgDx1SrbvBPNgCnott2/OUYTqT67go5xU/t4A6FYC6PMSb4PNQsFLrc+pX
	TnihLJ/zEse+dsa9VOmBoEyo+wkYaPPIKBTZXdtjbLdsIVha9J9TwfWuLAzjkMGZRx03YSPkI4H
	0aspF6eLeWXTNn2EsHgNIBY0Hkynl+78UeJ/y5yX+QRODs7JoOmounratYQC2QTgdEbUEipDi33
	ARtMIsVSnqr/qLwH/5wkQJpUS1Ruw0RrSjjR/6K3MWhjl6xW41/8zMk2R86aBt82ZbpF4GWDESL
	RA/jXxmddyds/Rz9eM30vNoAnKJlW0=
X-Received: by 2002:a05:7300:6810:b0:334:2bee:348e with SMTP id 5a478bee46e88-3427236f2bbmr2301957eec.22.1790406195371;
        Sat, 26 Sep 2026 00:03:15 -0700 (PDT)
Received: from WIN-BH9M8FJACR9 ([103.94.185.75])
        by smtp.googlemail.com with ESMTPSA id 5a478bee46e88-34145c166cfsm10615141eec.28.2026.09.26.00.03.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 26 Sep 2026 00:03:14 -0700 (PDT)
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
Subject: [PATCH v4 33/55] target/arm: fix A64 guest address width at 64
Date: Sat, 26 Sep 2026 15:00:32 +0800
Message-ID: <20260926070057.1234-34-luoyonggang@gmail.com>
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

Define TCG_ADDRESS_BITS 64 in translate-a64.h so A64 qemu_ld and
qemu_st take a 64-bit address, matching TCG_ADDRESS_BITS 32 in
translate.c.

Signed-off-by: Yonggang Luo <luoyonggang@gmail.com>
---
 target/arm/tcg/translate-a64.h | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/target/arm/tcg/translate-a64.h b/target/arm/tcg/translate-a64.h
index 35f8d4f82e3..d4265de9dcb 100644
--- a/target/arm/tcg/translate-a64.h
+++ b/target/arm/tcg/translate-a64.h
@@ -18,6 +18,9 @@
 #ifndef TARGET_ARM_TRANSLATE_A64_H
 #define TARGET_ARM_TRANSLATE_A64_H
 
+/* A64 qemu_ld/st addresses are always 64-bit. Set before tcg-op.h. */
+#define TCG_ADDRESS_BITS 64
+
 TCGv_i64 cpu_reg(DisasContext *s, int reg);
 TCGv_i64 cpu_reg_sp(DisasContext *s, int reg);
 TCGv_i64 read_cpu_reg(DisasContext *s, int reg, int sf);
-- 
2.52.0.windows.1

