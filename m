Received: from mail-dl1-f53.google.com (mail-dl1-f53.google.com [74.125.82.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 751A73002AB
	for <kvm@vger.kernel.org>; Thu, 28 May 2026 03:22:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779938575; cv=none; b=U1DN01Cde4UamAfVcK3Z0EeCcPmtwCW8tboLwzzH30PGTvhWOZXztaV+30cw4pvaOx0eeR14Mn0Bs33XtPbLqshao9d0Q6JTE4hMNZ/Ocr8O+lAwo7rFjUqlaMPwn2Z6FXi67hEq3bxrytcGBu90ZeZjpV2sDflacGS0kmwChh0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779938575; c=relaxed/simple;
	bh=1k577+1w5r9YRoVpypILqIfv/ZodMglY3KUFYU2Cz0o=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=BhHoTAbghUYGVYBmsar/BFgAMo/yqWDRhJ55EBdjij8TqB9ICVI8Jx2cMD1VBdwbWygrzG0XogIvuQXcOgSq/P4h0h153EaGNeGy0iTrmwNzb8C8SvJUGvX1lN20y65dtqe2X6/3/ku25lBukC1cMxyXmUVkpLIQGEbgurzizkQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=O5+WbTvg; arc=none smtp.client-ip=74.125.82.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O5+WbTvg"
Received: by mail-dl1-f53.google.com with SMTP id a92af1059eb24-133466cf955so32672101c88.0
        for <kvm@vger.kernel.org>; Wed, 27 May 2026 20:22:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779938574; x=1780543374; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mYRejrKAPEg0gypyudYE+J5U28eexbZuZvhZhYjI5Uw=;
        b=O5+WbTvg+kA/4BLNXtGkPlZGJogjUEt2yrtCquqzUHyNFnTJUaW18Lc1z2pB/dMaYQ
         s1vX/lvCqabRYI/lAEbaEbsL91o9RfH5b/D0+neoazppU6o4Z0L5Rr/wDfwHSK6Q07zo
         z0xYSKVdSlo8Pf/QXmE36pcS626AlXgyidAl+rSJYQ+l3o9B6EmYmZ5rxk2OUtRJRFo8
         8bgSBH5sbkLWBeWT3e5Z9jtW2V8KonhgvWEWJuE/Y98bFxyKdZj76WTCf07fUVoRVaQN
         8aTbXhJ4162uUikONbHVcvIeDMtr1kQlK05RFCCAmPi3hl9bM8L3FyMUXILEZ2G3em1I
         F7+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779938574; x=1780543374;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=mYRejrKAPEg0gypyudYE+J5U28eexbZuZvhZhYjI5Uw=;
        b=IlpuTz5dt3NBuhc+1sO699GaRVyitzLTI/hGYVnxzE9/8ZvKgZXPvZBx7n63tpkX5B
         pcoRycmqGY9JrXHgdXAogyhrV2o76fyElQTGAvC91vU0j1TP1JtYdyvApfNttuCgXQLn
         Amn2j1cKOnW4IyZO9eFcnXwUwa89oFECCISLpE6cMT3xcYdySLLjT6IXOaSqK42QRoxq
         K/WGO9NZaK7CR+rgWYFISeUhb+AFS3ZYjD3CNLuqmYp9Br407Wwv1EWv/5iyeS1TFzcx
         BfDHuZluRL/eFqjHc5etuSrZoQUmkTqziOF7j2G6iudJYJqqnbZS1iVHMlODrie1Yh/f
         J6HQ==
X-Forwarded-Encrypted: i=1; AFNElJ90MlJTGuteSBKp2W3mwOVqaFnVzZSoB9gQqfKUrmcThDEm41iZDQM53h6LI5Jiokj96us=@vger.kernel.org
X-Gm-Message-State: AOJu0YxQDkcaKUJBHNcSoD15mtZxJ/0/xueCbpO0pptQCUe6Ti2VS8G8
	H2wX9XYo0T1DPZhaflv16l6z5i4VSRSkxuLqYygSbDXiUzq7xunfvkzL
X-Gm-Gg: Acq92OGCCYWrKPloAe+YMB5iyYXR0WwJGM/PbsyRodo1Aou8JyMNE9wVZ8cMY1cp8PD
	XRvAfXp3UytDfOJaY4PkqJgqK250bsxRIKe0Cn3TI9qWErX8T9zyYnuEvnuHvjGVynmM0KzhFWu
	l5Qe9Ew2D22hcNEn24lmGgLfK5CCCUMhM/Yv/DR9T1m5LmbScNodBxSn+VV38lGOBm2O6cbWLSo
	3ii6LJ50ySxFylnZfnEjsccSsAa0fWgPPVRaIw9dNo1pvnXodMcYiYWGQOvrpm0V6ji+euNv6kg
	en5GPHShuriz5gzKQLtb0cU7XCpDjTuXtL/UNr22h5XKJRrkwSNcE5CCMNDYzGosAm0H2p5vNA8
	cG6CTJwhoIQJdsxKLvnSgU0j3CTIqlYS4ejXx5SBVAegpQJbWR8yzUecJgjsY1iSFHulIEiY44e
	sgu2S22kI3wkDSnxuAcBuVSV1xdlcEPxMN8QvXgv+zelwCklJxWve6eavNhHU=
X-Received: by 2002:a05:7022:fa0:b0:12d:ea4f:99de with SMTP id a92af1059eb24-1365f1c58cbmr8407366c88.0.1779938573546;
        Wed, 27 May 2026 20:22:53 -0700 (PDT)
Received: from ewan-server.tailb932da.ts.net ([154.26.185.247])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1366aa88c7esm11650007c88.10.2026.05.27.20.22.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 May 2026 20:22:53 -0700 (PDT)
From: Ewan Hai <ewandevelop@gmail.com>
To: seanjc@google.com,
	pbonzini@redhat.com,
	tglx@kernel.org,
	mingo@redhat.com,
	bp@alien8.de,
	dave.hansen@linux.intel.com,
	x86@kernel.org,
	hpa@zytor.com,
	kvm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: binbin.wu@linux.intel.com,
	ewanhai@zhaoxin.com,
	cobechen@zhaoxin.com,
	tonywwang@zhaoxin.com
Subject: [PATCH v2 4/5] KVM: x86: Expose Zhaoxin PHE2 CPUID feature
Date: Thu, 28 May 2026 11:22:33 +0800
Message-Id: <20260528032234.1322565-5-ewandevelop@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260528032234.1322565-1-ewandevelop@gmail.com>
References: <20260528032234.1322565-1-ewandevelop@gmail.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Advertise the Zhaoxin PadLock Hash Engine v2 to guests via CPUID
0xC0000001 EDX bits 25 (PHE2) and 26 (PHE2_EN). PHE2 extends the
PadLock hash family with SHA-384 and SHA-512 support per FIPS 180-3,
complementing the existing PHE feature (SHA-1 and SHA-256).

Two user-mode instructions are exposed, documented in the Zhaoxin
PadLock Instruction Reference, chapter 3 ("Hash Engine"):

  - REP XSHA384 (encoding F3 0F A6 D8, subsection 3.3)
  - REP XSHA512 (encoding F3 0F A6 E0, subsection 3.4)

Both consume software-padded 128-byte blocks (RCX = block count, RSI =
input, RDI = state) and produce hash output in the state buffer.

Both instructions are unprivileged (no CPL restriction) and available
in all CPU modes, with no associated MSR control. The PHE2 and PHE2_EN
bits are redundant by hardware design (set or cleared together) and
both serve purely as CPUID-level feature-presence reporting flags
requiring no KVM emulation. Both bits are advertised because different
software may probe either one when checking for PHE2 availability.

Signed-off-by: Ewan Hai <ewandevelop@gmail.com>
---
 arch/x86/include/asm/cpufeatures.h | 2 ++
 arch/x86/kvm/cpuid.c               | 2 ++
 2 files changed, 4 insertions(+)

diff --git a/arch/x86/include/asm/cpufeatures.h b/arch/x86/include/asm/cpufeatures.h
index e264758d58e2..3702d7a30ae6 100644
--- a/arch/x86/include/asm/cpufeatures.h
+++ b/arch/x86/include/asm/cpufeatures.h
@@ -152,6 +152,8 @@
 #define X86_FEATURE_PMM_EN		( 5*32+13) /* "pmm_en" PMM enabled */
 #define X86_FEATURE_RNG2		( 5*32+22) /* "rng2" RNG v2 */
 #define X86_FEATURE_RNG2_EN		( 5*32+23) /* "rng2_en" RNG2 enabled */
+#define X86_FEATURE_PHE2		( 5*32+25) /* "phe2" PadLock Hash Engine v2 */
+#define X86_FEATURE_PHE2_EN		( 5*32+26) /* "phe2_en" PHE2 enabled */
 
 /* More extended AMD flags: CPUID level 0x80000001, ECX, word 6 */
 #define X86_FEATURE_LAHF_LM		( 6*32+ 0) /* "lahf_lm" LAHF/SAHF in long mode */
diff --git a/arch/x86/kvm/cpuid.c b/arch/x86/kvm/cpuid.c
index 087c41341240..3fb81f7a6107 100644
--- a/arch/x86/kvm/cpuid.c
+++ b/arch/x86/kvm/cpuid.c
@@ -1288,6 +1288,8 @@ void kvm_initialize_cpu_caps(void)
 		F(PMM_EN),
 		F(RNG2),
 		F(RNG2_EN),
+		F(PHE2),
+		F(PHE2_EN),
 	);
 
 	/*
-- 
2.34.1

