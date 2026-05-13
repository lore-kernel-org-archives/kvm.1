Received: from mail-dy1-f170.google.com (mail-dy1-f170.google.com [74.125.82.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5111E3E9C27
	for <kvm@vger.kernel.org>; Wed, 13 May 2026 09:36:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778665018; cv=none; b=kX7xJSWBRnxxI3ku+bbpwvFoLVVoX02ZqyCIB3Jp3Zbz53GtGm7v+WFJcnXHimgWB5Xhi8xnH1kTVqc39d0FGNVah8s6lpVOTFl/S8nSczzX7/GVGLG7iLIJfKB/sQwk/oKOOG/eFVzBdpizyzCl/wPloGfEkbaAKVSrIK4Mdtc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778665018; c=relaxed/simple;
	bh=msb6kSwfYjtLrK6yh4A/4jW6Efwpn03Z7DhCQJ9v1j8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=GIQXPJ2pcJolUaFn4UyA6ijvvKL3viawvzzD8dG6h4UUcBea+lsmMnTXKavyVuhVtFtjEZW5h/qJIFs2722/Lu5emOBxsmN91cfo/JRcoSIUxJxYOF2YqPoZn/Y2+YXKhIzOmHyZBzB0MtSmhkReD5SN9I1DVXPf0jLLJqtlqRU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mJF15GFs; arc=none smtp.client-ip=74.125.82.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mJF15GFs"
Received: by mail-dy1-f170.google.com with SMTP id 5a478bee46e88-2f03d6cf77bso7376558eec.0
        for <kvm@vger.kernel.org>; Wed, 13 May 2026 02:36:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778665015; x=1779269815; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Yuxzue6n4LxKbQsyok/03Qurt5Jav9jZzMMI1LVz9Kw=;
        b=mJF15GFsjYuSijZ+XJsWbgGd/MZH3IyCGS0HfmuzdD20DuQhJ+y3dzsa7ZcSGb0OuU
         r/sMmIhsqIFu/RvMMXTZRpHaZKLQG5rPZnc2mxDLAUaz4tqZvRGpauW0CbZDxir5QgLH
         XGdf0vF1L3phAhrJNNLFSpVfhwSyhStS2RPmxFHMnpo5P97bgyq7pqPSiQyliqWyFtbW
         J8zH3AMqoUfi9j/LTenNp3fzJx4Pih3wALS6tcPeJJ0cdBwCJNM90eUtuiW0DLC1I6ij
         6o/4qyZneRqZ1PKuPrG7lO9eUdsSEUY8OT4zrNEyUgbLcRfnJu3SmP+J0o4fyQO2tS7Y
         QTvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778665015; x=1779269815;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Yuxzue6n4LxKbQsyok/03Qurt5Jav9jZzMMI1LVz9Kw=;
        b=LAhXBNl7v1e3L7g7Hs9xr4zdsvOkzVNVXouUNGXcCIhJtaHcHvPEOcv6TamX0vW8ku
         tlKx91ALZ4PsanNdJqJ6ufLoxrtTMQmb4zU+BHtDOGSdl1LrInbJj7r1wzQdALgmLOxY
         DAQWRh7l5M1kJsQgGArJV3l3ze/3/JBFW2p3JDHgIhkiEnyz8lAB9IRSjhJykCoO4Ko9
         tMv6akAWO/eP8OVg2zykeZZLaomiRY6PNdL8FwolIkii08SYee4DNPCKJBtKIvyLVntb
         1akoCiPmhTCQqBjU9pER6K0CBBRw2aRXEShDk42bhNJg1Ql5HLwO0GIj4rx1BaEr+8dL
         igAg==
X-Forwarded-Encrypted: i=1; AFNElJ/+DWMHoR3pwr0kZrXTlX3iyVbtE88Ztvzif+OqqvxV2T1HrB1WkfZ3OaI8eWhwS3evLqI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw42HtstsRP3wIzRs7l5oD28yS/AJhZMN4IAeGq3Pf/t1M2Q1RT
	RWLQ1xamTtGcM4QcunsDrJzO8ebgprS1JvIGa1apegD2K+mXZEGS4xbf
X-Gm-Gg: Acq92OGRwYkeH66DuyZnfr34JHXSLQ/bORciuAgHJmx8lHvXIInUdfTJPQWyYpcRsZI
	nKVIbsTgn5tQQhej3tYYBK79oFM3ug2JwUAC6T2C9YhfB3gGeqkY1CR3xKj5hMhL1eNJlIgBcWz
	UgVEKBQ7/6jL+p2o2cJi6QNzNRUIiFWE/6pSM5yKS2i8ueKxUCMmboCdX1VWAzSSIbjmifVA37a
	wJHxcpqKQd5Qf4BXCu1eg1jX2k1WITAkROjAkVuH6ugMwi5AGFdax/YdnJW0rQy4KhOR+rJZCoQ
	UOMzuJ00JwG7a1eld2UxwkGg+x6lJ2MiOHzDUxPiG6eJNP7jH7dgqYr/Iu0x+23myjJxjZpQdFg
	3VU1CdXxmksrMUlJrsZSJ5QohWngktb667x1ehy8399L9FuPcfjCYgR1plnlyuo8xsfo0mfosWr
	+q5N+UtWcO11lT+19rlNA/+89LoE41SOkX6ThW5Z287NMDw64bs2s=
X-Received: by 2002:a05:693c:2d96:b0:2c1:7793:7bbb with SMTP id 5a478bee46e88-30119f60607mr1454106eec.27.1778665015458;
        Wed, 13 May 2026 02:36:55 -0700 (PDT)
Received: from ewan-server.zhaoxin.com ([154.26.185.247])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2f8859eb4b7sm22100439eec.2.2026.05.13.02.36.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 May 2026 02:36:55 -0700 (PDT)
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
Subject: [PATCH 5/5] KVM: x86: Expose Zhaoxin RSA CPUID feature
Date: Wed, 13 May 2026 17:36:33 +0800
Message-Id: <20260513093633.1608334-6-ewandevelop@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260513093633.1608334-1-ewandevelop@gmail.com>
References: <20260513093633.1608334-1-ewandevelop@gmail.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Advertise the Zhaoxin big-number arithmetic engine to guests via
CPUID 0xC0000001 EDX bits 27 (RSA) and 28 (RSA_EN). The RSA feature
provides two user-mode instructions for modular arithmetic on big
integers, documented in the Zhaoxin PadLock Instruction Reference,
chapter 4 ("Modular Multiplication and Exponentiation Engine"). Both
support operand sizes from 256 to 32768 bits (in 128-bit increments):

  - REP XMODEXP  (encoding F3 0F A6 F8, subsection 4.1) computes
    A^B mod M
  - REP MONTMUL2 (encoding F3 0F A6 F0, subsection 4.2) computes
    A*B mod M

REP MONTMUL2 is the long-mode replacement of legacy REP MONTMUL, which
is restricted to compatibility and 32-bit protected modes. These
primitives accelerate RSA and related public-key operations.

Both instructions are user-mode and available in all CPU modes, with no
associated MSR control. The RSA and RSA_EN bits are redundant by
hardware design (set or cleared together) and both serve purely as
CPUID-level feature-presence reporting flags requiring no KVM
emulation. Both bits are advertised because different software may
probe either one when checking for RSA availability.

Signed-off-by: Ewan Hai <ewandevelop@gmail.com>
---
 arch/x86/kvm/cpuid.c         | 2 ++
 arch/x86/kvm/reverse_cpuid.h | 2 ++
 2 files changed, 4 insertions(+)

diff --git a/arch/x86/kvm/cpuid.c b/arch/x86/kvm/cpuid.c
index 3fb81f7a6107..94ea9abae566 100644
--- a/arch/x86/kvm/cpuid.c
+++ b/arch/x86/kvm/cpuid.c
@@ -1290,6 +1290,8 @@ void kvm_initialize_cpu_caps(void)
 		F(RNG2_EN),
 		F(PHE2),
 		F(PHE2_EN),
+		F(RSA),
+		F(RSA_EN),
 	);
 
 	/*
diff --git a/arch/x86/kvm/reverse_cpuid.h b/arch/x86/kvm/reverse_cpuid.h
index f28300c2d5e0..0df96ff9515c 100644
--- a/arch/x86/kvm/reverse_cpuid.h
+++ b/arch/x86/kvm/reverse_cpuid.h
@@ -85,6 +85,8 @@
 #define X86_FEATURE_RNG2_EN		KVM_X86_FEATURE(CPUID_C000_0001_EDX, 23)
 #define X86_FEATURE_PHE2		KVM_X86_FEATURE(CPUID_C000_0001_EDX, 25)
 #define X86_FEATURE_PHE2_EN		KVM_X86_FEATURE(CPUID_C000_0001_EDX, 26)
+#define X86_FEATURE_RSA			KVM_X86_FEATURE(CPUID_C000_0001_EDX, 27)
+#define X86_FEATURE_RSA_EN		KVM_X86_FEATURE(CPUID_C000_0001_EDX, 28)
 
 struct cpuid_reg {
 	u32 function;
-- 
2.34.1

