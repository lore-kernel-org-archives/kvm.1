Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B50793101A6
	for <kvm@vger.kernel.org>; Mon,  8 Jun 2026 15:52:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780933982; cv=none; b=oK3a0nBelGzfd2iVTnfOjO9ygTJgp1K/ZVIfQP2SSi8EQ+42o7XbuixC9iWR2ag7V/NFYlxnl7mxQIHfnoD8BIFzbF9cEUdxPIL7SDPPcUuMUOtw8ZQAOSKT0Hznc/ZkjzWnnt3F5n9od2jE5nRGFKtMW7ARytSNlFzM9cNU27c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780933982; c=relaxed/simple;
	bh=56Obr3ilAhtl2cWD3iUafGgsyWMvUy2ZtTlofiDa9zI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=VGFMDmdeRLNMOpzWjT9DXYzLu1fRMs+ls7djXg5vmx6Ovs2uLo7wAodnFRaOkIWBcWXqXay0zknDb/7yAP0QbW90s4aa8paOeMuev6Wr3EsDKXTwS3vR0OyPbHgY7J/9iCcCeboqM1E7YD0hFSkNOwsYCxgIFdPlHsy67LnjZYA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YWPu6+is; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YWPu6+is"
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-2c0c3315c5dso48505175ad.3
        for <kvm@vger.kernel.org>; Mon, 08 Jun 2026 08:52:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780933979; x=1781538779; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=EVMcV2amC0zCzG7WFGyPAc9k2b2Mh+czO6Q9ao0kqOA=;
        b=YWPu6+iszPcd5uJ+lf2TeRpux019k5um/RSxrOLFEFWgeYI7FwLUgkedkJHa/bCjdN
         zBsKGbw2QVsEkhsU6wzf7W7oJWAKTu0jJjdrJ8Bxj80RYg4VoczxSMEJrfljXBg2LqdT
         jmYM25SUy21os7Vm+MbznlPtP0BfDiyQeEUqmCIxT/aYrHThu1SgQ3rp2hGMu+ZuXm6y
         GkrrUoaM6iSDxRyTfovk4DvmawBpSDr07wE+egZXD3iznmw/LX38tuk40/NREfLnEpMt
         iQwZWE/MV8oCjecP1xBxrKJSgmq+Ogvd5KsBv1uYCQ05KK/j+AiWDyDDLPi0kM5bEgpN
         CpoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780933979; x=1781538779;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EVMcV2amC0zCzG7WFGyPAc9k2b2Mh+czO6Q9ao0kqOA=;
        b=m1ddBuHfVlVB/LLdnSCB85z8dI9f7NOJyrCgK0vbGaq5bjym3Q0VoxTjLHWRaEaywm
         nCr0+3OVru7fOqVTJqKjzrZQyp0laiLUu4NZ9ve8tniL63c3VUPRWriYJ4rSt850ingl
         LV+YfhyMIOAETtmfEKrm1Tjf/vsZCAIXxbi1SxXUEu8NzCgscPDGV211G9HOTVd0UUnC
         44PZRYSuycG6xb/gNXfhN34bQeSpLtFP5XYqrVWuwsImsj9hzkO684r58YYmlYNS3i49
         KVYIjW8ZzLj+Kys/TWpxbz1ZHT9So9038FX7MFTV+bJaTxKKJH2oi++hnVRmxJqqRIwn
         iW3w==
X-Forwarded-Encrypted: i=1; AFNElJ+LjZi/Zg7uer6Hx52GZgdb+NaKCnpa3iFH0OygrAL2frsHPpWurybAn70z6H/cE9Yn5oU=@vger.kernel.org
X-Gm-Message-State: AOJu0YyvSwHqB/6F09VMGnCR0ELDqYURGWp9gciEJ4VMX5LtF/hlTEeq
	nJ9YxAOvsFgU+oQbaw+vd7fCqsks0ZrhzgTJTrEw61AoqgOL72KaVnV4jTGnHA==
X-Gm-Gg: Acq92OHAAM9UH+H7A1tDjJ5FUMcblnbI86J+Bz9zT/te8Ncv2dytDC0PlouZWGu/xLL
	o44SCZxFLlYtrWC+lgqB8AdqJwkfyPS8OqGBaDNRXCSqDwo2CwqK3YiSmbYr5Q+My5d36VViTRu
	Bb+4ki4Yrzew5l6ml0cDUREOLn24lX09g2htQl8fo4Nsb/ceHqSAWNUonkSHxTD164itjbwTQPd
	dQnCeRd9gEvDgBBmImHLa66LJXanE7KXsrUeFA5vAU5d3t95lxrfkEG1ARgpFdogG1flG3WGvcL
	9XVuJWzDyGA5+6fXZjW4Aj3lmGG5CTVMb8YIhwbvapDkTDFnlsAoOoXry9aFY7oWxoL85OlHF7M
	5lzgW9WrLB8Kwnp+WtaXCDzb74Aq7be09n33iNNRlPo68g/sP/MK/LRvARqtNFUkNUf+6VRFe1o
	JXfodnxNtJWnkKKlnQCThr2APcGJwxB3SA6CIuaoni8hRergbEwWJUZ6zJsUqSTVve+mL1c4EPq
	48gHiEnm4Ygzs4Fkcr0/GUIOxEOAJTupsF+S0NL+A==
X-Received: by 2002:a17:902:ce92:b0:2c0:db23:4a4 with SMTP id d9443c01a7336-2c1e85d210amr175246605ad.36.1780933979031;
        Mon, 08 Jun 2026 08:52:59 -0700 (PDT)
Received: from LAPTOP-M4N25KQ5.tail73068d.ts.net (1-160-247-151.dynamic-ip.hinet.net. [1.160.247.151])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2c1664ad138sm192371645ad.82.2026.06.08.08.52.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Jun 2026 08:52:58 -0700 (PDT)
From: Sean Chang <seanwascoding@gmail.com>
To: Anup Patel <anup@brainfault.org>,
	Palmer Dabbelt <palmer@dabbelt.com>
Cc: Atish Patra <atish.patra@linux.dev>,
	Paul Walmsley <pjw@kernel.org>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Alexandre Ghiti <alex@ghiti.fr>,
	kvm@vger.kernel.org,
	kvm-riscv@lists.infradead.org,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Sean Chang <seanwascoding@gmail.com>
Subject: [PATCH v1] riscv: kvm: Use endian-specific __lelong for NACL shared memory
Date: Mon,  8 Jun 2026 23:52:52 +0800
Message-ID: <20260608155252.4292-1-seanwascoding@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When compiling with sparse enabled (C=2), bitwise type warnings are
triggered in the RISC-V KVM implementation. This occurs because the
user-space data unboxing macro '__get_user_asm' performs implicit
casting on restricted types without forcing the compiler's compliance.

Additionally, raw 'unsigned long *' pointers are used to access the
SBI NACL shared memory, whereas the RISC-V SBI specification mandates
that these structures must follow little-endian byte ordering.

Fix these by:
1. Adding a '__force' cast to '__get_user_asm()' to safely suppress
   implicit cast warnings during user-space data fetching.
2. Introducing the '__lelong' type macro, which dynamically resolves to
   '__le32' or '__le64' depending on XLEN, and replacing 'unsigned long *'
   with '__lelong *' to enforce proper compile-time endianness checks.

Signed-off-by: Sean Chang <seanwascoding@gmail.com>
---
 arch/riscv/include/asm/kvm_nacl.h | 14 ++++++++------
 arch/riscv/include/asm/uaccess.h  |  2 +-
 arch/riscv/kvm/nacl.c             |  2 +-
 3 files changed, 10 insertions(+), 8 deletions(-)

diff --git a/arch/riscv/include/asm/kvm_nacl.h b/arch/riscv/include/asm/kvm_nacl.h
index 4124d5e06a0f..f45407bcaa26 100644
--- a/arch/riscv/include/asm/kvm_nacl.h
+++ b/arch/riscv/include/asm/kvm_nacl.h
@@ -60,9 +60,11 @@ int kvm_riscv_nacl_init(void);
 #ifdef CONFIG_32BIT
 #define lelong_to_cpu(__x)	le32_to_cpu(__x)
 #define cpu_to_lelong(__x)	cpu_to_le32(__x)
+#define __lelong                __le32
 #else
 #define lelong_to_cpu(__x)	le64_to_cpu(__x)
 #define cpu_to_lelong(__x)	cpu_to_le64(__x)
+#define __lelong                __le64
 #endif
 
 #define nacl_shmem()							\
@@ -70,7 +72,7 @@ int kvm_riscv_nacl_init(void);
 
 #define nacl_scratch_read_long(__shmem, __offset)			\
 ({									\
-	unsigned long *__p = (__shmem) +				\
+	__lelong *__p = (__shmem) +					\
 			     SBI_NACL_SHMEM_SCRATCH_OFFSET +		\
 			     (__offset);				\
 	lelong_to_cpu(*__p);						\
@@ -78,7 +80,7 @@ int kvm_riscv_nacl_init(void);
 
 #define nacl_scratch_write_long(__shmem, __offset, __val)		\
 do {									\
-	unsigned long *__p = (__shmem) +				\
+	__lelong *__p = (__shmem) +					\
 			     SBI_NACL_SHMEM_SCRATCH_OFFSET +		\
 			     (__offset);				\
 	*__p = cpu_to_lelong(__val);					\
@@ -87,7 +89,7 @@ do {									\
 #define nacl_scratch_write_longs(__shmem, __offset, __array, __count)	\
 do {									\
 	unsigned int __i;						\
-	unsigned long *__p = (__shmem) +				\
+	__lelong *__p = (__shmem) +					\
 			     SBI_NACL_SHMEM_SCRATCH_OFFSET +		\
 			     (__offset);				\
 	for (__i = 0; __i < (__count); __i++)				\
@@ -168,7 +170,7 @@ __kvm_riscv_nacl_hfence(__shmem,					\
 
 #define nacl_csr_read(__shmem, __csr)					\
 ({									\
-	unsigned long *__a = (__shmem) + SBI_NACL_SHMEM_CSR_OFFSET;	\
+	__lelong *__a = (__shmem) + SBI_NACL_SHMEM_CSR_OFFSET;		\
 	lelong_to_cpu(__a[SBI_NACL_SHMEM_CSR_INDEX(__csr)]);		\
 })
 
@@ -176,7 +178,7 @@ __kvm_riscv_nacl_hfence(__shmem,					\
 do {									\
 	void *__s = (__shmem);						\
 	unsigned int __i = SBI_NACL_SHMEM_CSR_INDEX(__csr);		\
-	unsigned long *__a = (__s) + SBI_NACL_SHMEM_CSR_OFFSET;		\
+	__lelong *__a = (__s) + SBI_NACL_SHMEM_CSR_OFFSET;		\
 	u8 *__b = (__s) + SBI_NACL_SHMEM_DBITMAP_OFFSET;		\
 	__a[__i] = cpu_to_lelong(__val);				\
 	__b[__i >> 3] |= 1U << (__i & 0x7);				\
@@ -186,7 +188,7 @@ do {									\
 ({									\
 	void *__s = (__shmem);						\
 	unsigned int __i = SBI_NACL_SHMEM_CSR_INDEX(__csr);		\
-	unsigned long *__a = (__s) + SBI_NACL_SHMEM_CSR_OFFSET;		\
+	__lelong *__a = (__s) + SBI_NACL_SHMEM_CSR_OFFSET;		\
 	u8 *__b = (__s) + SBI_NACL_SHMEM_DBITMAP_OFFSET;		\
 	unsigned long __r = lelong_to_cpu(__a[__i]);			\
 	__a[__i] = cpu_to_lelong(__val);				\
diff --git a/arch/riscv/include/asm/uaccess.h b/arch/riscv/include/asm/uaccess.h
index 11c9886c3b70..5d4ec15584cf 100644
--- a/arch/riscv/include/asm/uaccess.h
+++ b/arch/riscv/include/asm/uaccess.h
@@ -112,7 +112,7 @@ do {								\
 		_ASM_EXTABLE_UACCESS_ERR(1b, %l2, %0)		\
 		: "=&r" (__tmp)					\
 		: "m" (*(ptr)) : : label);			\
-	(x) = (__typeof__(x))(unsigned long)__tmp;		\
+	(x) = (__force __typeof__(x))(unsigned long)__tmp;	\
 } while (0)
 #else /* !CONFIG_CC_HAS_ASM_GOTO_OUTPUT */
 #define __get_user_asm(insn, x, ptr, label)			\
diff --git a/arch/riscv/kvm/nacl.c b/arch/riscv/kvm/nacl.c
index 08a95ad9ada2..6f9f8963e9dd 100644
--- a/arch/riscv/kvm/nacl.c
+++ b/arch/riscv/kvm/nacl.c
@@ -20,7 +20,7 @@ void __kvm_riscv_nacl_hfence(void *shmem,
 			     unsigned long page_count)
 {
 	int i, ent = -1, try_count = 5;
-	unsigned long *entp;
+	__lelong *entp;
 
 again:
 	for (i = 0; i < SBI_NACL_SHMEM_HFENCE_ENTRY_MAX; i++) {
-- 
2.43.0

