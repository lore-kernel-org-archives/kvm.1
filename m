Received: from mail-dl1-f51.google.com (mail-dl1-f51.google.com [74.125.82.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A60E030E82B
	for <kvm@vger.kernel.org>; Thu, 28 May 2026 03:22:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779938566; cv=none; b=FgimQOKjE/qlVX4z4C4yV6fhtVmhxEb7GjLkn+IiBn7w/sHm4iXRBKV4JBpNQIxMclANivOx0KzcJ5/BZj4pxTV7zaLJbkmAEymHwmKvWz+3xj5pdFMVeFCVgL1yflHkuGXw/ZSuHzEivVCvha8GawIfWtbDc4yUsQ8rZ9Lx1+Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779938566; c=relaxed/simple;
	bh=OVkYg2LwRBc+md8NfIOjyJx2HVPlAWaFleOj1m6Zids=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=SPCR4nphdiWcMDwqHito1tg2eZ1bHu9BJxfAG51zjuRrISJ+UKEORJdcQZu4Nl1zlWH2q9bBT7oEfX8e8+hGxOVg/I6H5WwcCwkdeuFgzAkoMJjoL3IKeR5GrH9eOM8P3NpTo0l38dpY8KO0lDgpzzbMZbp65MFZ0U8yEB3LQRU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZDLh9IcN; arc=none smtp.client-ip=74.125.82.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZDLh9IcN"
Received: by mail-dl1-f51.google.com with SMTP id a92af1059eb24-1363e78746eso8379223c88.1
        for <kvm@vger.kernel.org>; Wed, 27 May 2026 20:22:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779938564; x=1780543364; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yvcljGfx6QiYG5/DvoKGj+F6+hoiC/dtA0HwV2U//Hk=;
        b=ZDLh9IcNZ05l64gzouxFOwtEVH7Y8P51E/WYEPqQ1TVQVmjzVptYnBPpu6NxrtwluW
         e13QXROPaZelZ0MlS8pzApnH9q6ihEAZVP8fGqfiM0UJcABGRwPyZH0ovfhHMNBuDOrW
         X40cbZp3Osuc6lOIf47e3G6gH2EYWfYRMHTeRjhv1mC35cnea7RGJcOWy6jKO/6aWJu7
         2rUxGVEWirddiaX4J+m7wC+z9ZP2bHXy21SNkpXCUS7WTFhmMmZSQpJswvCyO+noMdhJ
         Z+iiyfNdxoRPf+BWMBsnAYIHCSJj5vmpiBEDCbKap+1cpMTxnwM4zfNQsyc+dRZk8U/n
         3m+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779938564; x=1780543364;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=yvcljGfx6QiYG5/DvoKGj+F6+hoiC/dtA0HwV2U//Hk=;
        b=B92SlwG416k7Uvqt/O16vjjfDO5fU71ARzlk5WQegFA0htUdiaFx8Fzx8eaqxSqHbs
         PgVMKK6+L15t4x5axGBIaNfv6U1rrSwREVDubYctQMLnx+UAN+RgshEipKfssdaq3iic
         KbQ7Q/P/fQHa642nJkJEAfPrXkaIo5iTkuBp0jgWG3BxW/kza4V1Rcx18xCWWS1fTASx
         cA4HfjZFpsIzvDhukAkvvTdHxjcUWamSFnYLitvS1C1ufxi/DFprS48nr1oqPDZC6eL/
         q1GR9U4E94ZWaLtyTR1wHoU7253IdCiSHfHo0ph4hWvkdoSGZMCEj18EzAjQDKqk4Qss
         MIMw==
X-Forwarded-Encrypted: i=1; AFNElJ+vTNaCk30HOH7j4ndKS06Yp2kxR5VyUb1X1/TnZbfh0m101+os5HumdDYGVWuKT6ehuyg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwaIPLpFAM/hBMl8A8tmvDiAT2P8HtUfinXZvNNh67yr1jeGP9J
	uN2PGVD2329d6Ge9LXL+VeGdQ0KwmUOFwuuVoQo9q648vJEmhbP4RrlX
X-Gm-Gg: Acq92OH5r/vXvVeYwjES50kLBkwNZbE7oQW0+Bgc62Q6SFXlhgKA94B4CO65ur5v9gy
	ro8uAYsD5dvxZGjj7Y2MdQo1KNLoxhVZAIOJqbNFntnZwbwrzjq1HGUt9MF1/ugp4UMZmqxNbTv
	6C9/z6EFZW3wDhFwfN3UM//pafP/UsUi3POPx5HO5+3ehoOM6BJ5t1nRlvvcnhQ0CweiECzukG9
	2KEKTjU3nwAIwzrJ9muy2sBLRrIFnlliAagWZcgE/Wgr6eUTd/msiwrJ7/6vLxQWpUq5M+9qGkV
	PzFQU2ah3Hh78KpaxP6+s2Q2MxTwZB7EckPZ85ah9edt/jGRBMw6TCFSvATPpqFMUMuxGALBhKT
	++19A5Fa7TZElmvNinQ/5wPK4i69g0SGiG0pS32btHNT+oQgH2QfaaDeANptvmfgPL7JGhBHpjJ
	e57cZv2jsYI8oBLh+o2+2B307I0u3LM80tGldFMIEUjDBdxHX9GIDocvhNPRA=
X-Received: by 2002:a05:7022:502:b0:136:b67e:93e6 with SMTP id a92af1059eb24-136b67e9748mr6449840c88.37.1779938563720;
        Wed, 27 May 2026 20:22:43 -0700 (PDT)
Received: from ewan-server.tailb932da.ts.net ([154.26.185.247])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1366aa88c7esm11650007c88.10.2026.05.27.20.22.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 May 2026 20:22:43 -0700 (PDT)
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
Subject: [PATCH v2 1/5] KVM: x86: Expose Zhaoxin SM2 CPUID feature
Date: Thu, 28 May 2026 11:22:30 +0800
Message-Id: <20260528032234.1322565-2-ewandevelop@gmail.com>
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

Advertise the Zhaoxin SM2 instruction support to guests via CPUID
0xC0000001 EDX bits 0 (SM2) and 1 (SM2_EN).

The SM2 instruction (encoding F2 0F A6 C0) implements the SM2
elliptic-curve public-key cryptography algorithm specified in
GM/T 0003-2012; the hardware-level behavior is documented in the
Zhaoxin GMI Instruction Set Reference, chapter 1 ("SM2"). The
instruction multiplexes its sub-functions on the RDX[5:0] control
word: encryption (subsection 1.1), decryption (1.2), signing (1.3),
signature verification (1.4), the three key-exchange sub-operations
of section 1.5 (1.5.1 SM2 key-pair generation, which the spec also
uses for the initiator's ephemeral key; 1.5.2 responder shared-key
derivation; 1.5.3 initiator shared-key derivation), and two
preprocess steps for identity and message hashing (1.6.1 and 1.6.2).

The instruction is unprivileged (no CPL restriction) and available
in all CPU modes, with no associated MSR control. The SM2 and SM2_EN
bits are redundant by hardware design (set or cleared together) and
both serve purely as CPUID-level feature-presence reporting flags
requiring no KVM emulation. Both bits are advertised because
different software may probe either one when checking for SM2
availability.

Signed-off-by: Ewan Hai <ewandevelop@gmail.com>
---
 arch/x86/include/asm/cpufeatures.h | 2 ++
 arch/x86/kvm/cpuid.c               | 2 ++
 2 files changed, 4 insertions(+)

diff --git a/arch/x86/include/asm/cpufeatures.h b/arch/x86/include/asm/cpufeatures.h
index 1d506e5d6f46..20b33413189c 100644
--- a/arch/x86/include/asm/cpufeatures.h
+++ b/arch/x86/include/asm/cpufeatures.h
@@ -136,6 +136,8 @@
 #define X86_FEATURE_HYPERVISOR		( 4*32+31) /* "hypervisor" Running on a hypervisor */
 
 /* VIA/Cyrix/Centaur-defined CPU features, CPUID level 0xC0000001, word 5 */
+#define X86_FEATURE_SM2			( 5*32+ 0) /* "sm2" SM2 algorithm */
+#define X86_FEATURE_SM2_EN		( 5*32+ 1) /* "sm2_en" SM2 enabled */
 #define X86_FEATURE_XSTORE		( 5*32+ 2) /* "rng" RNG present (xstore) */
 #define X86_FEATURE_XSTORE_EN		( 5*32+ 3) /* "rng_en" RNG enabled */
 #define X86_FEATURE_XCRYPT		( 5*32+ 6) /* "ace" on-CPU crypto (xcrypt) */
diff --git a/arch/x86/kvm/cpuid.c b/arch/x86/kvm/cpuid.c
index e69156b54cff..1eb4b88aaa80 100644
--- a/arch/x86/kvm/cpuid.c
+++ b/arch/x86/kvm/cpuid.c
@@ -1272,6 +1272,8 @@ void kvm_initialize_cpu_caps(void)
 		kvm_cpu_cap_set(X86_FEATURE_NULL_SEL_CLR_BASE);
 
 	kvm_cpu_cap_init(CPUID_C000_0001_EDX,
+		F(SM2),
+		F(SM2_EN),
 		F(XSTORE),
 		F(XSTORE_EN),
 		F(XCRYPT),
-- 
2.34.1

