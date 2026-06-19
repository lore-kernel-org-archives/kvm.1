Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 946D038F928
	for <kvm@vger.kernel.org>; Fri, 19 Jun 2026 13:05:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781874342; cv=none; b=HUHTo1NNGxACY1LG/PuFP/hEyQHmBH07+gDdfnhF/gBEpVLAtBhNwmX3u615276azh0CJdc6HjyWumAdgznkGmPSfZ+MtlO2fHEegHAhCO2HTIilS75Mebtv9IZEJlLp+xq34qAgsz6e4fpQq1vD3Y2u2PNM98qYECzfRJTWO58=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781874342; c=relaxed/simple;
	bh=XTCxLyTZsxhrEV0S8gDPdhI/GUDaEHxf5DJT/ZzNObI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=quFKInsdhl80/Wl3zzlQgaM5rL1FrwEfAZWJN3Wlk7tO4tm5CO+0nIPODFUM6QBpo3SDaI7w7dRPt0MbhJRhIZQhJfs9Al7HaqiVqPumwEJVK21HGlTVoKuY12uACi7NhJCDBqLdXTOCo1p41YT4eTMH/S8iCCeH6maa5SLLjO4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=KWBhQveK; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="KWBhQveK"
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-4626fdc829aso1606421f8f.3
        for <kvm@vger.kernel.org>; Fri, 19 Jun 2026 06:05:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1781874339; x=1782479139; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=T72NDyunHLyFV4aqpIGKGdQkRXR7DefmzidasatP8oI=;
        b=KWBhQveK3/yygfmxsqzJuglqMZzwdaIE7bzT3eq/A8uXhh6ncoKNZUrUe/ctfwLixN
         UVEvYwpp0rRJF4uEeMpZ/BkvTmVA9MbxY0VXvtkud3K2MCfeFcLziRu8r1xzc3ZEJ+p9
         DlBDGIPFr4yQe95c+yAN8UBujdmQhJC/dB6bQS3w9FqPAymzJeAq0SBMxJxsB35u6aZa
         YxAkOgCbcXAvlElPYXS/qjPHLN+TOcMZX/NaMXNcjHJFBx5IZeOTj7UnyU+XF756j/q1
         Badxq1jR/guM3ui4vbvSCwZ0vD2ZNfHMfyRGHyjs8SzcC35h2hPLMa9WdfkgrQo04JEN
         PYvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781874339; x=1782479139;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=T72NDyunHLyFV4aqpIGKGdQkRXR7DefmzidasatP8oI=;
        b=TCeAs3mV/dnYtm6ypPOSii7cAzO8UejObj+o4UmFu3qnldhD6WZhMtJNL/oMEdFsjz
         MJmf6+nL5z2FRXA61kQtE6k1J21eMMsSNpsfcQNV47ZMbARl7numQ43RJO5HrccPW55N
         sp2oQS4DbK8PExJdNmSDcRgkbM0qctkGfyWPZ5ETKWGaiPdX9k3jNhltOYbgcfZoWgjx
         KrAcxElpGSX31YIc22F2bBBY1/5eUTF5UtZLiLMmJOW8zOwzZCTApM3IgT9EUL0m8oZc
         aVzUp6rbk7LlyR/dIhDn91wdUdNKwZxsgBXn5zBCvB/ntPD2x8haGo+Ym6O00NMO1P4R
         ppwg==
X-Forwarded-Encrypted: i=1; AFNElJ/HPOJ2D7xVrGfqZPKGEzS3pw+ri71fhnb9OuAlo+Y2Gjl6Qp9G7Ei/fL6v3mAeln+Q0do=@vger.kernel.org
X-Gm-Message-State: AOJu0YykxaYu9wWrlvpC6324NHyrc+Iw/4rafJj/1nqWrRN1Z/HaWXfq
	z2/dFXH4MLb99RAH9ImnzWexKU5pm8nrCXbl3i6HqZ+06D/hNnj5KrJoL2TKgWbxE60=
X-Gm-Gg: AfdE7clZdwAUsGvjHl0+0vTr06gNzU4TaMIzBKuYX8FaeGFxp89LDUEQWzGpBTIDZvu
	9OVjErFurxxVLsLp1EHFA1R+L91j1ObHMtwjCiC44/g6793vZwYbhyjno2QT63F/K3QfsvSZK9m
	HZg+Pjkn6KRXbIUwuBBQ0SYb03AMednDH7w7AQxu/ECs+xf9EelU160sKhBVcTaDIUmsmsKzvJ0
	5X526Ftlc0zOgvlm7DO/3QEsCOPl1gHe8Qt52p+HxsJ8qfatRsRfjSOG6O3TBy1or6nBez0bE4Q
	FAch6hbO27bdAQb7yCes6Byv3dSb+zFTC+f7wB/Vz/L/4V2xo0FlN9Hzq1/ZBI0iT1gnTOE4A+N
	SBraCL5WxXEuJcMrwL928KB+0O8yT0Rk6AG1PTWOEEXzDNaogC500wzPH17u6Pv+j42xRSW6hta
	pEaoP50baARO8D
X-Received: by 2002:a5d:5d87:0:b0:45e:f381:cd85 with SMTP id ffacd0b85a97d-4656f4704b5mr3865725f8f.20.1781874338894;
        Fri, 19 Jun 2026 06:05:38 -0700 (PDT)
Received: from draig.lan ([185.124.0.195])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-46508a04b55sm8170000f8f.5.2026.06.19.06.05.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Jun 2026 06:05:38 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
	by draig.lan (Postfix) with ESMTP id 5C3E15F814;
	Fri, 19 Jun 2026 14:05:37 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Alexander Graf <agraf@csgraf.de>,
	Mohamed Mediouni <mohamed@unpredictable.fr>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Pedro Barbuda <pbarbuda@microsoft.com>,
	Jamin Lin <jamin_lin@aspeedtech.com>,
	Steven Lee <steven_lee@aspeedtech.com>,
	Andrew Jeffery <andrew@codeconstruct.com.au>,
	Joel Stanley <joel@jms.id.au>,
	qemu-arm@nongnu.org,
	Troy Lee <leetroy@gmail.com>,
	=?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
	Kane Chen <kane_chen@aspeedtech.com>,
	Tyrone Ting <kfting@nuvoton.com>,
	Peter Maydell <peter.maydell@linaro.org>,
	kvm@vger.kernel.org,
	Hao Wu <wuhaotsh@google.com>,
	=?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
	qemu-stable@nongnu.org,
	Arnd Bergmann <arnd@arndb.de>,
	=?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
Subject: [PATCH v8 1/7] hw/arm: use cortex-a9 mpcore base for CBAR on npcm7xx machines
Date: Fri, 19 Jun 2026 14:05:30 +0100
Message-ID: <20260619130537.820184-2-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260619130537.820184-1-alex.bennee@linaro.org>
References: <20260619130537.820184-1-alex.bennee@linaro.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

CBAR is an IMPDEF register and according to the A9 TRM [1]:

  In Cortex-A9 MPCore implementations, the base address is reset to
  PERIPHBASE[31:13] so that software can determine the location of the
  private memory region [2].

If it doesn't we will confuse the Linux kernel as it probes the system
SCU registers [3] and erroneously assumes the system is a buggy Aegis SOC
and nerf the emission of SEV instructions, deadlocking any WFE's in
the kernel (or QEMU smpboot code).

[1] https://developer.arm.com/documentation/ddi0388/i/system-control/register-descriptions/configuration-base-address-register
[2] https://developer.arm.com/documentation/ddi0407/g/Introduction/Private-Memory-Region
[3] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/arch/arm/kernel/head.S?h=v7.1#n550

Fixes: 2d8f048c25ab ("hw/arm: Add NPCM730 and NPCM750 SoC models")
Cc: qemu-stable@nongnu.org
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Suggested-by: Arnd Bergmann <arnd@arndb.de>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>

---
v2
  - rewrote commit message for clarity, added links
  - used arnd's arndb.de address
---
 hw/arm/npcm7xx.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/arm/npcm7xx.c b/hw/arm/npcm7xx.c
index c2bbcd89dbc..c27f149c04a 100644
--- a/hw/arm/npcm7xx.c
+++ b/hw/arm/npcm7xx.c
@@ -492,7 +492,7 @@ static void npcm7xx_realize(DeviceState *dev, Error **errp)
     /* CPUs */
     for (i = 0; i < nc->num_cpus; i++) {
         object_property_set_int(OBJECT(&s->cpu[i]), "reset-cbar",
-                                NPCM7XX_GIC_CPU_IF_ADDR, &error_abort);
+                                NPCM7XX_CPUP_BA, &error_abort);
         object_property_set_bool(OBJECT(&s->cpu[i]), "reset-hivecs", true,
                                  &error_abort);
 
-- 
2.47.3

