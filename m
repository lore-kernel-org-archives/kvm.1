Received: from mail-dl1-f54.google.com (mail-dl1-f54.google.com [74.125.82.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF1E0423A89
	for <kvm@vger.kernel.org>; Wed, 13 May 2026 12:48:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778676537; cv=none; b=WtuiWHgBpRTPfazM/wXqG2wowI6XKgKwKi2wcQqR25Qe1xpxEi3/SdwDnYIDji0OCdTYxYvmwzsvq8FNv8Tc35l9tIK43amzb1lOWUTR5lybnA57tsXSKX+O1yp7hYPSBl7vkrHhYj4DGslJ8y7PslbPLwIh3bQvdlXa3h0zH3Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778676537; c=relaxed/simple;
	bh=At1gf0Mua3N4YYtHisgY0h9wtx8xtKox/CUCEWQanfk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=h4r8BbTwLuDW2imchqfxdeMshsuXuOfJq+PNCfOp6787+P6nYmLQdCx8xrBBZG7gYOvA73dsRCCStIOOxNFTqxNg34P9CrpvFT5ITpeCklQGh0K/mGJQc8Jv42tPJxKfMEhbJRYn95c85TYVDezAUMVqMYdqe6SwtIGSWG912l4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=P4dhLRlB; arc=none smtp.client-ip=74.125.82.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P4dhLRlB"
Received: by mail-dl1-f54.google.com with SMTP id a92af1059eb24-12c88e5f4aeso3902939c88.0
        for <kvm@vger.kernel.org>; Wed, 13 May 2026 05:48:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778676535; x=1779281335; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7R9QlZtKzGZ9Srh0EOuGXWhWVZA7AopSSa5Bhm29kr0=;
        b=P4dhLRlBXY0yvNw/Xywjzd8ZgI03EidLtCMa1oJUtpk8pP2mfDPAixmAZqskOtIbCO
         p0hL8quhOLvZHtV9/6KGdPPNyGh/KERiRKdWDyFGxvclXnaMF5miK5dqwQJjWaEoF316
         hO7NEreHvKs6qfDbWx2Bpw9V8Y9+2nzWApK7v/hMiZDpfWRxLCa1/qlXo9qy9dneJFcF
         WJKkGcCfo56PhtkaMKLYKHV1fBRxQkbcuobOCuypFprOTbyYI0i5QIuko5AiQeqgUF1k
         X7q9aoRqREmJooFEtMTLz6bXok6HCFHKZq2GLnqIO+ZBLHu4lTz4y7flCKDU/4SwKDVx
         rPNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778676535; x=1779281335;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=7R9QlZtKzGZ9Srh0EOuGXWhWVZA7AopSSa5Bhm29kr0=;
        b=hp3C1qRAsYhN4LQNsmAwWPKymmJq7SMOcAjkAviRhVrcTW/kk0qfB0bNv52rpWj/Q6
         qSmDt8FELXoBxCtFdQt3juyYAvs0qt63edPWzAkRQpeABUm+OKL/mzfxe0SXbVXlxOv/
         4UgiPUY4mYIY4dHddv6zaSpBjwdBZxKiIW031EX1XZ30kDflpeD3Yes8kwbpsraVvh8I
         KKtVCUfNinBe6X9thHVyE48RS/VoASLmgyNopTjTGgCd3blITFDhkrObsK4qmmtD0U59
         kQ1OKiUi8JVNSkEhjZe8WX+rdhKFs+IYuoLy7vXGp5t3squrduIWEWNdf8fTxMPapMRG
         J2Dw==
X-Forwarded-Encrypted: i=1; AFNElJ8hDttw/9czFX84IhKR1P+48sUwGqTkKJxmBCzM7NuXvVcHS2ONoGQHu6oSUhM0Y9hiI3I=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy4EAvobJAYD3SZgRmnjaSIXz4kcPE7rhiwx+lu9n8kRvYtQN0c
	lNGHarukqMAa1qmiMO7ZVDW4h9p4jCi9PN5IQdlnvf5FctS4TXBer0do
X-Gm-Gg: Acq92OGqf+c4Ztac9pqEWcH69m3u2iySCU+UgbcKruPTKLLU0a4pQ/qOaq0T1aqq+EO
	XOQ0o67mArTv//lA7qn/+cVS/FgsWefdY7xFRNJw7MLcq9RyuUnqffn9JuwMj4wUqk8pJWBK7S4
	3rM2jygPphuXaF8NZKg2Izb7DgjSXwItHBgWfXXTEydViCblcKwURTB4Bx1r+Wz0w69sRTAyKxZ
	7AAWJB0U6QRqwXdzgXFv+nW0Nm0keY9EnEX8HwssUTe9iurZfPWDohWKFBBn+6Q6N9n98b3w8mD
	AFgU0/AJMZC0npkZkNqhy9+zqoQgPs/nEn5aRpabv2/MCLNfnp2FP+3mwS64EPr4iWPS6Ei6eQb
	93q3dOmXOykR/Fw1Iub9tmLBtxAYxCViBd/dL+IRo+M5jy0U/FeHbO/8U0DCF+fZ2Pi/6qOMAOu
	4e4Hgl5a8GlQoXgB1Ku6IbiyQI9C22cHTrOgHvSZXM
X-Received: by 2002:a05:7022:6894:b0:12e:57fd:ca2 with SMTP id a92af1059eb24-1341e7be18bmr1775851c88.3.1778676534984;
        Wed, 13 May 2026 05:48:54 -0700 (PDT)
Received: from ewan-server.zhaoxin.com ([154.26.185.247])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-134b4e153dbsm1066142c88.12.2026.05.13.05.48.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 May 2026 05:48:54 -0700 (PDT)
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
Subject: [PATCH v1 1/5] KVM: x86: Expose Zhaoxin SM2 CPUID feature
Date: Wed, 13 May 2026 20:48:42 +0800
Message-Id: <20260513124846.1622462-2-ewandevelop@gmail.com>
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

The instruction is user-mode and available in all CPU modes, with no
associated MSR control. The SM2 and SM2_EN bits are redundant by
hardware design (set or cleared together) and both serve purely as
CPUID-level feature-presence reporting flags requiring no KVM
emulation. Both bits are advertised because different software may
probe either one when checking for SM2 availability.

Signed-off-by: Ewan Hai <ewandevelop@gmail.com>
---
 arch/x86/kvm/cpuid.c         | 2 ++
 arch/x86/kvm/reverse_cpuid.h | 4 ++++
 2 files changed, 6 insertions(+)

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
diff --git a/arch/x86/kvm/reverse_cpuid.h b/arch/x86/kvm/reverse_cpuid.h
index 657f5f743ed9..7b55110cc046 100644
--- a/arch/x86/kvm/reverse_cpuid.h
+++ b/arch/x86/kvm/reverse_cpuid.h
@@ -76,6 +76,10 @@
 #define KVM_X86_FEATURE_TSA_SQ_NO	KVM_X86_FEATURE(CPUID_8000_0021_ECX, 1)
 #define KVM_X86_FEATURE_TSA_L1_NO	KVM_X86_FEATURE(CPUID_8000_0021_ECX, 2)
 
+/* Zhaoxin/Centaur sub-features, CPUID level 0xC0000001 (EDX) */
+#define X86_FEATURE_SM2			KVM_X86_FEATURE(CPUID_C000_0001_EDX, 0)
+#define X86_FEATURE_SM2_EN		KVM_X86_FEATURE(CPUID_C000_0001_EDX, 1)
+
 struct cpuid_reg {
 	u32 function;
 	u32 index;
-- 
2.34.1

