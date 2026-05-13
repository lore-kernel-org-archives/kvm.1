Received: from mail-dl1-f45.google.com (mail-dl1-f45.google.com [74.125.82.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2171429830
	for <kvm@vger.kernel.org>; Wed, 13 May 2026 12:49:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778676544; cv=none; b=G3kTB0JOFX5GOHV3OmmCn7eik3N3BMqO/BsJsVti1QlYATF1SN9SrNaJN/wyxzB7zx5meOQuO+cgJK8DSnjHk0AG0ppaW/Go2mW5t0yQKqaV7yokOdWTI2yKwLUBlFVNWmzmSitOUJpB9zx+HEzC9BSiuDf7/ZjwncEfwb5XXS8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778676544; c=relaxed/simple;
	bh=wZJWjnqIbm8WDtqhSpFj+q2nylcM9L473xSd9G+0pUI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=tClY23W5CJ+Q8SYTXWL8nxUogHQH5zai+7L9FJzC+ykWbc9mCMzmWJjr1EcCR2vv+Cl/VDgcu+H9Tg3mpvNtLR9eWVsP760pC1UD+6EkOQBBp9sLT8lZSbyC5hAZITjV6Drw1RN4QAE1TZ2I6/GaZR4C2P5Tyf2dHq4nQX3PTiI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HQfilCM6; arc=none smtp.client-ip=74.125.82.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HQfilCM6"
Received: by mail-dl1-f45.google.com with SMTP id a92af1059eb24-133466cf955so884665c88.0
        for <kvm@vger.kernel.org>; Wed, 13 May 2026 05:49:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778676541; x=1779281341; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oMLcF3QpmorqUOiR9XBa4GuV1rXFYpYVsToIbq6Xxoo=;
        b=HQfilCM68J/eWCYUMA3s0j8nPkJkfeOn6Mnx7BvPDCIGc4/g8A0rYItyO5D75GJbbN
         9djdaKs5sFaIIkXSQZWTzRn2tPEMGArVhr2QWS5qNSOlD9lgei0dOTM39NejwJ0/S9Fq
         6hVdFOOgNFmmwOQz4WXTu56H2UNtUnf85s0PCzMsnl/wBoaTZ+wk4ceOhGQ5L0YIq0ez
         jKZwzlk92PTKVibTmIJkep0FBzk91Ub1Jy/A1UxjBspFI7ICuBMEDSj4Q8zmLzx0w2Jb
         2AINdRBgwdfr27713hIu2Ow9WQbUSAxa6DZtqTk3KI6GwPpozXc6N/LAZnvMK22lOiTz
         Cq/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778676541; x=1779281341;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=oMLcF3QpmorqUOiR9XBa4GuV1rXFYpYVsToIbq6Xxoo=;
        b=Ip7E2sSc+D9yA8Z1Yu3yPjfAufh5lARkwQLZMmIaBcH/nHI2SDCqmdlMCSlEGSYWak
         tC3HBnGkbP1Cb16VHZL75pjPms858aLKD8PdqEbtgDvTTeNoN0JDSwEWoYwiWo+cfsya
         UW5S2/Oz5B9M+rrwIJ3tPBw20Sb2qqiHDdRFLSxIp30lpe28fS8dYZTVDmgP1HVcV6Vq
         NoQiScJ/nqEmk3qCEx2sad21zpjjTSHN4zuPUD6SCqyBptn2inw31fv68yI0crIvb6Au
         l5wiQxa4g5wabCpCCmIFFgbZJpMOt4shovE/Dqq82DCs/IYpcdkCwaZhvzIf8Z0tAyQE
         wh/Q==
X-Forwarded-Encrypted: i=1; AFNElJ9ZpGnDu/d+iqppuKuyNxfbfnveKsvQRRNMZjYQp8JleHL5MPGHwe58HFxoeTYBijB3uyI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzu7Oey+tgc2ZZ2pAo25L7sP46qvvcmVr+oIuCtRPPq7NT67bB3
	lnMzs2nmDio4HBxeVmbKdmsobfPi7+Q0MIAyNWk12hTsC/0F0A2z79qf
X-Gm-Gg: Acq92OFOCicZl3YnKHnL/nQGcmKU5uwKxud5Z2AemzuI7HovUTfR/GFRU0lnF557bX0
	10fetEmQ01gzRMaQ3pkKv90Y7WL1sYIRrJhmYAkj/6IF+hR2wVYqs3dgPG0LmuBT7tFB0xteGky
	Pzl1cPLwhuuRHT6c3NQ0ZZx5J78grekvMzqG2ua8uGF7KZ5PM/sgWqsDCo48AwqFoWUlbKw/wdQ
	ayI5lEhj2IZPwEGdxpM5diHZevip4o6BBZcjcD2Z6Ke/aiesyLbLhdWMuEuwzQfUuZgaCIR0E0q
	mzn9g5SeehHL9tB8JzfuJwrf4q8i4oGiBaPYqWku/BxOpNy0jU0QrmpPPwpbdH+HmS5TMIR1YRB
	gRimOv1RT4AuL33b8eGQME3F+m9/n6TGBQVQK0jdwHDd4JupA5up1lNyiQUMw573AEI/fY0zLw4
	KMfGhIMTXFYXIYvex98kKlSE8ZVXhoFeFcrdF3HqrW
X-Received: by 2002:a05:7022:43:b0:128:d4be:7428 with SMTP id a92af1059eb24-13436781e9bmr2245229c88.19.1778676541014;
        Wed, 13 May 2026 05:49:01 -0700 (PDT)
Received: from ewan-server.zhaoxin.com ([154.26.185.247])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-134b4e153dbsm1066142c88.12.2026.05.13.05.48.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 May 2026 05:49:00 -0700 (PDT)
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
Cc: cobechen@zhaoxin.com,
	tonywwang@zhaoxin.com
Subject: [PATCH v1 3/5] KVM: x86: Expose Zhaoxin RNG2 CPUID feature
Date: Wed, 13 May 2026 20:48:44 +0800
Message-Id: <20260513124846.1622462-4-ewandevelop@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260513124846.1622462-1-ewandevelop@gmail.com>
References: <20260513124846.1622462-1-ewandevelop@gmail.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Advertise the Zhaoxin second-generation hardware RNG to guests via
CPUID 0xC0000001 EDX bits 22 (RNG2) and 23 (RNG2_EN).

RNG2 is exposed by the REP XRNG2 instruction (encoding F3 0F A7 F8),
documented in the Zhaoxin PadLock Instruction Reference, subsection 1.3
("REP XRNG2"). It produces random bytes from two on-die RNG sources
selectable via RAX bits[10:9] and an output mode (raw vs post-processed)
controlled by RDX bits[1:0], providing high-quality entropy intended
for cryptographic operations.

REP XRNG2 is user-mode and available in all CPU modes, with no
associated MSR control. The RNG2 and RNG2_EN bits are redundant by
hardware design (set or cleared together) and both serve purely as
CPUID-level feature-presence reporting flags requiring no KVM
emulation. Both bits are advertised because different software may
probe either one when checking for RNG2 availability.

Signed-off-by: Ewan Hai <ewandevelop@gmail.com>
---
 arch/x86/kvm/cpuid.c         | 2 ++
 arch/x86/kvm/reverse_cpuid.h | 2 ++
 2 files changed, 4 insertions(+)

diff --git a/arch/x86/kvm/cpuid.c b/arch/x86/kvm/cpuid.c
index 8aaa3f20670e..087c41341240 100644
--- a/arch/x86/kvm/cpuid.c
+++ b/arch/x86/kvm/cpuid.c
@@ -1286,6 +1286,8 @@ void kvm_initialize_cpu_caps(void)
 		F(PHE_EN),
 		F(PMM),
 		F(PMM_EN),
+		F(RNG2),
+		F(RNG2_EN),
 	);
 
 	/*
diff --git a/arch/x86/kvm/reverse_cpuid.h b/arch/x86/kvm/reverse_cpuid.h
index a1cd9116ef63..859ba43126d8 100644
--- a/arch/x86/kvm/reverse_cpuid.h
+++ b/arch/x86/kvm/reverse_cpuid.h
@@ -81,6 +81,8 @@
 #define X86_FEATURE_SM2_EN		KVM_X86_FEATURE(CPUID_C000_0001_EDX, 1)
 #define X86_FEATURE_CCS			KVM_X86_FEATURE(CPUID_C000_0001_EDX, 4)
 #define X86_FEATURE_CCS_EN		KVM_X86_FEATURE(CPUID_C000_0001_EDX, 5)
+#define X86_FEATURE_RNG2		KVM_X86_FEATURE(CPUID_C000_0001_EDX, 22)
+#define X86_FEATURE_RNG2_EN		KVM_X86_FEATURE(CPUID_C000_0001_EDX, 23)
 
 struct cpuid_reg {
 	u32 function;
-- 
2.34.1

