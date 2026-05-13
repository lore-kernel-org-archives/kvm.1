Received: from mail-dl1-f43.google.com (mail-dl1-f43.google.com [74.125.82.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFD0442EED9
	for <kvm@vger.kernel.org>; Wed, 13 May 2026 12:49:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778676549; cv=none; b=OKtbus9Mc/e+8MfDdiI4XwwikE88WBZy3DXdQ4Uwtzfv/xtf2N5LSshlZOyxcdo8uiBvDxpxqjhiuBqGmx1+gKx9sEtJhVI3enOE1+CYkdTafdA2eCo8hxjiacSAayXzCWwzigfIwOMkXsZucMirrRUWk7+Uj5H10OjxDVxX6WM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778676549; c=relaxed/simple;
	bh=msb6kSwfYjtLrK6yh4A/4jW6Efwpn03Z7DhCQJ9v1j8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=qNuV8NVN6So0mJabyZstt4/OuvylSMF+nDoCbvKGrK16+GACc3sFw9GPRf5tdP6u2Z8rJgjPIgHLav1Y2dN1AKOqcoDUlnorf46HP2mfwvQ+tYJf67/dYPkZA0atAygl75taDDakPZti9jcxA/TRX8V7CkpywVLWjFFCJfa4hqY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Uo9s1RH1; arc=none smtp.client-ip=74.125.82.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Uo9s1RH1"
Received: by mail-dl1-f43.google.com with SMTP id a92af1059eb24-132c338a537so2695956c88.0
        for <kvm@vger.kernel.org>; Wed, 13 May 2026 05:49:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778676547; x=1779281347; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Yuxzue6n4LxKbQsyok/03Qurt5Jav9jZzMMI1LVz9Kw=;
        b=Uo9s1RH1Xd9WvH2CrmzbqCt9I7sYNknx7zujdeOkKh6i90STCYPqXZl5al2mp+FEs5
         VHS2lZlbKEC4FAYQTzIzvd0vUxtPNMjJupvF/mWsZKpgtEf3VSWk3hTnwAhUFBcdXr79
         7DxezbONgQxnWTZ3ORYWJirkMutiuzNMECOFLJdlndaRcoCzNNEeVEuSNLLxz5F/fEtF
         tE8RbhjFcR9ihd411xUk74D5725ga8yLPG9UNJy4R9sCI+rmEepz1SMu1dDM/wuK1pv/
         QQBgnUz7AsadUD8Xkqj/6JPzi8nUy5FQsjy1dQ/NFQZlVdlV+BP/yEqQVWi/Oi6QGZC1
         K6LA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778676547; x=1779281347;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Yuxzue6n4LxKbQsyok/03Qurt5Jav9jZzMMI1LVz9Kw=;
        b=coMCJPUFAhpskg7FZ1vb/y575vQMBAVTohzIhfJO5ShD3sC7dnpUDJswShahE3c07w
         O5NKfGiirXW0P/hu+q+sSAT8K0wOtSVa65KaN0TY8A8AC6vvGYqgJTmw5St1JIhMGpUK
         TYFXKNFDuMzXpGTxdnYdNoXSStJKH3LXZzShUsMoaYxHRvxzo4mNy3HcpLZgAn9QfN1D
         bvG5hhs4d5SsmWyS94c4dwmEQWFnjFHfK69XcMQsf+0nRqWMtAptfYq4xoEXtD4pAbo6
         X08OdppNZd0dGqE5cRykP4N++x0mrP3xOK7J113V+fWTZHQitVPHAjg1L26CVfkoGCOP
         bUaw==
X-Forwarded-Encrypted: i=1; AFNElJ8NuzMCYIM53jTZQoj4fQzIJUKqNpDhaF7tZgWSSdl8JqvWKAVN8embe4PCc1JVTTEGCOU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz8xLJNlhzcQl4TLNf11cjmtKkZsQToB+igBwpYwFLUmUpssjNP
	wYCAD6ZWLH/ljW1bDmbyaUVppBFpzf0h4EIBnhEIbedxLQ/ezKc9kdIg
X-Gm-Gg: Acq92OEsvHMjpcVSmhBNu6pDcbktkNqzGiFVxziT1Txjtrw3YeT0NuwYBmRekS+BB5J
	5YGq0Ktnph7pU2/ZBZTKm+gIVRQeussbk+1pU7PXPjsLblP+58W3XxYVU3wV9wTVAmCBxiY/XoN
	q05SXm0Q28emBazxuwaPeECbcgR/sqlsTtwU5ZbH8C4Uj/lTbKVgzTScmPUh7xu0dff1O9m8797
	81zCLfskoBSOEDIayMCzN0iSqqxsHqYvHLPADZ761ubxjwhamzmSToOZVjyB+RwT5f579W/jMYX
	lOa9F88AM9OzZ2sI/6cD7QdC4uSMhNEUOF4X45DwJY3knaVM536wpYzRvdCsHgTVmUwEv9CEVJc
	uOo400X0CffLqlVedhWk2ZsydzkrgiU/ZwvhwJrjToHd98ew5X5CBZaWFEb/1cRy2bfTAD1axrJ
	/XN89bZAW1NGzihhmD7O+45bqsafMkGa/7ptskH2Fn
X-Received: by 2002:a05:701b:2303:b0:134:74a6:7db1 with SMTP id a92af1059eb24-13474a67ecdmr911411c88.20.1778676546790;
        Wed, 13 May 2026 05:49:06 -0700 (PDT)
Received: from ewan-server.zhaoxin.com ([154.26.185.247])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-134b4e153dbsm1066142c88.12.2026.05.13.05.49.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 May 2026 05:49:06 -0700 (PDT)
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
Subject: [PATCH v1 5/5] KVM: x86: Expose Zhaoxin RSA CPUID feature
Date: Wed, 13 May 2026 20:48:46 +0800
Message-Id: <20260513124846.1622462-6-ewandevelop@gmail.com>
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

