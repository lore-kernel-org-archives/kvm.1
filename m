Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50A3125228D
	for <kvm@vger.kernel.org>; Wed, 24 Jun 2026 10:30:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782297054; cv=none; b=jZ/DB0u67cL5/e7+0oSMXFDLIkWePKZ3p5VcRlP9Dg3MeFMmwOQmh5lUMgJfPXaoAIQMXOeQqtjHF+j82QuDnhM8fd63otEQlZ8z6oDfcHa6ncAZzcCWLgadsm5+K40k2P11arNaKXFx26A9dwFCIDbDW68a2+UPQ9DMG//Pb/s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782297054; c=relaxed/simple;
	bh=XTCxLyTZsxhrEV0S8gDPdhI/GUDaEHxf5DJT/ZzNObI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YLpGPAI6ln1+NTGxDESplwGwbVnATxuV3d+TjL02J3G5hForJzy6/H20jkai158DFaAdcJCHqO9OBq76RljM/fOC7+01wNOy+tqRzQ8o9eIusMP+Z6AEvpocs3tqd0M6kZYcxdH7KIrzrgNZeWlPe98aBeJHBFWn56DOgJE6OT8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=FGDPUSb7; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="FGDPUSb7"
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-490c0c92cffso6125765e9.2
        for <kvm@vger.kernel.org>; Wed, 24 Jun 2026 03:30:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1782297052; x=1782901852; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=T72NDyunHLyFV4aqpIGKGdQkRXR7DefmzidasatP8oI=;
        b=FGDPUSb7Rt9HabhbDnrD0egF8OxcBdzEaZatnFuMHn2hZE3Uy3hpQkR7kxuKqLCJHq
         cvkwik2qfiAHK+MdHLKHjN4wPJ+tPnivxFsEEx3tq2sW6ECJQS40c9SFSvMxY1nJSVVh
         YMDNYEpTdJ9xX7z1sexPoYJSGnbBflzlVmnW/GfcOWlVCvQ/Hs6/+VcMxeDVUPqKuIWL
         F8OVT/QvxFeJOIDW1YL+EngC1wwwHLipR2ZcbHu5PpB2gKsCsweQ/LBzlSXoRcHQgZnq
         P68x1rFfNVQxTkENovpMCFHiidl4BhLPON6/HO5DW6SxCJjw1aNp9ZCp56IWpeYJv4GT
         Nvbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782297052; x=1782901852;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=T72NDyunHLyFV4aqpIGKGdQkRXR7DefmzidasatP8oI=;
        b=LXAQwq61DXYY4pN1AnmEwe8NACqskNqX7F1FQ4f0Q72J4OJze2ESEipv8MgnEuEElA
         /8WmCC0ZqXB2Gd/RzXcMB5rkPxrrDta20IqRXpJ5EVhEMWRQBLLUftmLR7WEFCuRZNtU
         Rpdths/r5I/SDhulx5sf9r+j+8DxOAgZcMgGV0uhLxVxIjzNOwZhJetjSpOr+doCpQLV
         4gfjtcAk8aPvOL6swpsRlJggWoMRloKCEq4vL2M72YLWV+ReHfWLHvGGw2Ngmv0RAOd4
         KKa5542rCNKECRmKmOtir7wNdRrv3PPV7zoM5X7HL/gmHK7Q5U6NMEcdu9qqOmolQTip
         Sk5g==
X-Gm-Message-State: AOJu0YzjgXPYrnfLfhEeG+ZpRtRTpNDSeEYsvVwLrU3hco5zeZZsB1lO
	EEuMtSCMb6cRMe4igfmydd23zY5G7UvNE/QSzP6R1/q9nucawr40ntZ8I5HXtS64tUo=
X-Gm-Gg: AfdE7clvU+h3TiDWt+BSQB9+mC0poJlEIQ1bXnJN15SSTriu6IveLUsVNCxE1KUvJkq
	4QeVR0XJM/26e545P9Tr650vIKmFlrrk6H4fLyA+AkDKz3k2LuUCNmjo0+kgWH7CfARkLxdnBcn
	ry4/fVKrhRUIVb+Qm74DLurA5ZQ0CT647l5G06bQMLGx+YFZz92mMAIgNAjTbtpky3Zn+I+rZW6
	to3PbYprHO/Ax1c9dl6KWcdC7pzmOgMkU2LPF7OwtgXq9t36yLyiK5sCHntAHroYedcmaWe9gut
	tzHJ772y908Szpx1sZSsOQfnABfkoQTRGc/FvaOPb76kTTw2HfJDPRdVr/9dwyezLWeS1aelUJS
	xO1hAWcshSSynrm5sFDPFPHss0O5+Jp9h3GKyJQVwWgshYv9qhVF4F3YpXvKoFzQoLXImlfUlkf
	6GvlPjVix/9+iR
X-Received: by 2002:a05:600d:4453:10b0:490:c2a3:3303 with SMTP id 5b1f17b1804b1-4926088046dmr26636395e9.34.1782297051526;
        Wed, 24 Jun 2026 03:30:51 -0700 (PDT)
Received: from draig.lan ([185.124.0.195])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-46c1ee01c6csm5921884f8f.14.2026.06.24.03.30.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Jun 2026 03:30:50 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
	by draig.lan (Postfix) with ESMTP id C91325F845;
	Wed, 24 Jun 2026 11:30:49 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: kvm@vger.kernel.org,
	Troy Lee <leetroy@gmail.com>,
	Peter Maydell <peter.maydell@linaro.org>,
	Hao Wu <wuhaotsh@google.com>,
	Kane Chen <kane_chen@aspeedtech.com>,
	Mohamed Mediouni <mohamed@unpredictable.fr>,
	Steven Lee <steven_lee@aspeedtech.com>,
	Joel Stanley <joel@jms.id.au>,
	Jamin Lin <jamin_lin@aspeedtech.com>,
	Pedro Barbuda <pbarbuda@microsoft.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Tyrone Ting <kfting@nuvoton.com>,
	Andrew Jeffery <andrew@codeconstruct.com.au>,
	qemu-arm@nongnu.org,
	Alexander Graf <agraf@csgraf.de>,
	=?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
	=?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
	qemu-stable@nongnu.org,
	Arnd Bergmann <arnd@arndb.de>,
	=?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
Subject: [PATCH v9 1/7] hw/arm: use cortex-a9 mpcore base for CBAR on npcm7xx machines
Date: Wed, 24 Jun 2026 11:30:43 +0100
Message-ID: <20260624103049.884930-2-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260624103049.884930-1-alex.bennee@linaro.org>
References: <20260624103049.884930-1-alex.bennee@linaro.org>
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

