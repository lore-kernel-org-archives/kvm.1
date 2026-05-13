Received: from mail-dl1-f48.google.com (mail-dl1-f48.google.com [74.125.82.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00EE4428820
	for <kvm@vger.kernel.org>; Wed, 13 May 2026 12:48:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778676541; cv=none; b=Mx/8UjbncdFi1/TfVQeZTVmSYoewZ4mxXPRFG86Oxq9ecP4RxdI0AygyKaSDTWD9vRyfldydaaRr/v+KW05qos8E3SdQ5darOHeGK+/meB80nhsrXfgV3RzD6rMIlXLuYy++lkremuIQCksV2iW23/ywSUEBbiFm5xqSVDy9iNs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778676541; c=relaxed/simple;
	bh=WrAyTmwYSRYTeMp0wl4NRx12Jro3naVKJVOSJpgIEYI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=QiWFE8GXFRmXLSIa6u/E3Zxu9H0dSh/fJnj64xqxW58e6u2I2FrssQreNxyhjRkFDLBdIVFunL7aR6TzU4qpNlwIpqyVH/WMY/WBNoQRegGfdVi8kGwoM4qWv2XLbZmdrDDrJITJRftgv3RCW2uhCUjmxLjyPLsoGGgrLHmL/0U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IcWzAMNO; arc=none smtp.client-ip=74.125.82.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IcWzAMNO"
Received: by mail-dl1-f48.google.com with SMTP id a92af1059eb24-1332772f6b3so4555991c88.1
        for <kvm@vger.kernel.org>; Wed, 13 May 2026 05:48:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778676538; x=1779281338; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ERPLFt1DzdQWZj46mxvIXYh6fAkpMfWFMGg+XUXEJ+0=;
        b=IcWzAMNO8hg0Qr60DK2Ni1pWk24y90JParLWGrXyXLb/RV/hPcQbPvkx7SvdMGQCau
         SbDfHwHZTlrjpxlb4RNacBXsjxo1TmFFpXaUVnhFhKG6OM3hIiq1xhPmRXTgXhEnvKaY
         Zt7Gak4IGYjoexWMqyz84nz8C7Y1uXhLlM3m+FjHHgB6qxsz32eIRtZ6joYjODOGnHN8
         W3xiJdPC/vf9fHUx/VHveRI1OFRVnqsgWTGN2J7qncpkgXq/svyiOdLHu5ez5pqJYX4d
         S5D/JsoVtamiHS3rNdRqTnmDqnpGx0bEpLVgu3fM6h3TXdiLPtQ4OHKhcKuPpTeTREFy
         KJ3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778676538; x=1779281338;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ERPLFt1DzdQWZj46mxvIXYh6fAkpMfWFMGg+XUXEJ+0=;
        b=dc0QnZ1Qh2YPs+L5H/0JI6lim8U+NrQF5GGlpZCHon1QwOb3TVM/MdPUQy+BlXPl31
         wRmJO942cNuYJqPb3z9tUGdtnhVEgWUT/xhZ/vEqLFaeHSDUxGmEypNKilf2Z8EC26y5
         H09C0/kuJuOaI/Zwcl+JUamEqq8NucniI/izod+LTtmTLxzxQHkXYU8cPS+0dhtgiaaT
         lOgV6iEMSxblGIyfW4ZIDb6zTfnKUtFwdqL3SxVvQuSXe+qPQ5d9Zt/7hq6yD1IvoFz1
         sP81xg4JCcFa66uB1ziGcb6RK+Bc36ZTZBTngCPNe4pJnNIrKCHoScUH4Gb+onWJIO68
         Y9kQ==
X-Forwarded-Encrypted: i=1; AFNElJ9oapDh/l1le9p+ejko4zdt28ziQxi2SPl4AuIRKtypm148Cuf/IQPtskPPewHYJOHe8Fc=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywil+j7l9dzrpQvF0tlzXU8yQlC9b4goc+EtcCEjw5k5RkxUWML
	sfFoANYN9W9VhMvoBWNUZZDL2w47mLR5pQWt6wN8dUkPzLAHRjShySML
X-Gm-Gg: Acq92OEzi0mKS9xlSWCURmUhAHrrPbUfXjRKAa2+yrGyQ8DC7xf/Zz3kYc2HtTx2CYE
	qEMKH6ANDSnCZ92LtIDdsshrVnNlhTnC0ksVyZ5JjvXjIMhYBT+z/xkOp3dnH2G88CUiE+XSCJV
	PODTMrMqJWQC5TQciNzwsPg1283aqzcHcOgHkOY5Hpo5KExQYKOAm66CjFSAnFXh+e8qqynvOMR
	pyF2W4fiZOs258MydDr4FYBnzrhBuz0JGaII2z0ZF9Psh0kuS8KUyRwCPQyeZaH8b2czs9QIPzz
	mgTZEG1zPmS4X4Wi3JdRs+/b4V+wtuDl1kWogtzmq245hzFIiy1zdDZ4GBs91qGVNRzkeDgqqcN
	sMdCm102loiVTaNY4zkKtoKVVa+LX+SwjaQCpiLkpWRy3rW385GcKtGELPYnRG15zykslWAAfKS
	DlCwJYt6ia8iKserW4kUQWszEyrzaf1bPkeNS+keLGhTehWHV5bjQ=
X-Received: by 2002:a05:7022:f008:b0:130:c9cc:3383 with SMTP id a92af1059eb24-1344054de55mr1661638c88.43.1778676538017;
        Wed, 13 May 2026 05:48:58 -0700 (PDT)
Received: from ewan-server.zhaoxin.com ([154.26.185.247])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-134b4e153dbsm1066142c88.12.2026.05.13.05.48.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 May 2026 05:48:57 -0700 (PDT)
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
Subject: [PATCH v1 2/5] KVM: x86: Expose Zhaoxin CCS (SM3 + SM4) CPUID feature
Date: Wed, 13 May 2026 20:48:43 +0800
Message-Id: <20260513124846.1622462-3-ewandevelop@gmail.com>
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

Advertise the Zhaoxin CCS (Chinese Cryptography Standard) feature to
guests via CPUID 0xC0000001 EDX bits 4 (CCS) and 5 (CCS_EN). CCS groups
two user-mode instructions for Chinese national cryptographic
primitives, documented in the Zhaoxin GMI Instruction Set Reference,
chapter 2 ("CCS instruction group"):

  - SM3 (encoding F3 0F A6 E8, subsection 2.1) implements the SM3 hash
    algorithm specified in GM/T 0004-2012. It supports two modes
    selected by RAX: auto-padding stream mode (RAX=0) and pre-padded
    block mode (RAX=-1).

  - SM4 (encoding F3 0F A7 F0, subsection 2.2) implements the SM4 block
    cipher specified in GM/T 0002-2012, supporting ECB / CBC / CFB /
    OFB / CTR modes via a control word in RAX, and CBC-MAC / CFB-MAC
    when RAX bit[11] is set.

Both instructions are user-mode and available in all CPU modes, with no
associated MSR control. The CCS and CCS_EN bits are redundant by
hardware design (set or cleared together) and both serve purely as
CPUID-level feature-presence reporting flags requiring no KVM
emulation. Both bits are advertised because different software may
probe either one when checking for CCS availability.

Signed-off-by: Ewan Hai <ewandevelop@gmail.com>
---
 arch/x86/kvm/cpuid.c         | 2 ++
 arch/x86/kvm/reverse_cpuid.h | 2 ++
 2 files changed, 4 insertions(+)

diff --git a/arch/x86/kvm/cpuid.c b/arch/x86/kvm/cpuid.c
index 1eb4b88aaa80..8aaa3f20670e 100644
--- a/arch/x86/kvm/cpuid.c
+++ b/arch/x86/kvm/cpuid.c
@@ -1276,6 +1276,8 @@ void kvm_initialize_cpu_caps(void)
 		F(SM2_EN),
 		F(XSTORE),
 		F(XSTORE_EN),
+		F(CCS),
+		F(CCS_EN),
 		F(XCRYPT),
 		F(XCRYPT_EN),
 		F(ACE2),
diff --git a/arch/x86/kvm/reverse_cpuid.h b/arch/x86/kvm/reverse_cpuid.h
index 7b55110cc046..a1cd9116ef63 100644
--- a/arch/x86/kvm/reverse_cpuid.h
+++ b/arch/x86/kvm/reverse_cpuid.h
@@ -79,6 +79,8 @@
 /* Zhaoxin/Centaur sub-features, CPUID level 0xC0000001 (EDX) */
 #define X86_FEATURE_SM2			KVM_X86_FEATURE(CPUID_C000_0001_EDX, 0)
 #define X86_FEATURE_SM2_EN		KVM_X86_FEATURE(CPUID_C000_0001_EDX, 1)
+#define X86_FEATURE_CCS			KVM_X86_FEATURE(CPUID_C000_0001_EDX, 4)
+#define X86_FEATURE_CCS_EN		KVM_X86_FEATURE(CPUID_C000_0001_EDX, 5)
 
 struct cpuid_reg {
 	u32 function;
-- 
2.34.1

