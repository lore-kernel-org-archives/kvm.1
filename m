Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE001377EB9
	for <kvm@vger.kernel.org>; Wed,  8 Jul 2026 03:36:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783481783; cv=none; b=U2+hI3QY1ZnhdyBH35lHS6rSYshaLKTMWs41m1czLbLr5v4PCeadPzQfrKsG2SyWKmjfldGsQOrme12DZLbvSyDclCHFRIjP2/MWo+Xo842NufN7H/scntlrm8/Av98KxY1OLnuA4pVtq7hCS1cfnLDGsKJ0dN8E7Bx5J2xSpRM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783481783; c=relaxed/simple;
	bh=j+4xd4UFPYMx31RI3oZhzKH55RnIh5Q4blgoRCeJwgw=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=I4AleWxe8i9fz46sv3UGPWBH3ScL/uEsWrXanXMX9m1TzOOo/s2dxLiDbz7iwvUX2GSaxhxmfCqHWPKo3q5Acp71No3CU2nN28HiL0vCFD01BvBHbJvvwYlrSh+ws+DrCzhDEMNJEm0hzJplffNN/M2nEgzdZVw6ackYgATplsA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=rGsXCwUa; arc=none smtp.client-ip=209.85.215.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rGsXCwUa"
Received: by mail-pg1-f182.google.com with SMTP id 41be03b00d2f7-c9d1fc053e0so140029a12.1
        for <kvm@vger.kernel.org>; Tue, 07 Jul 2026 20:36:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783481779; x=1784086579; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=CvczDvHK6doetNfCiPotMmHZg7w7Gu6Nh6hG9FaOUNw=;
        b=rGsXCwUaFc3GQ/AO89+VIaUcdNRBjvi+xzfgPE1mPga8Gm4pUnonzo6AtCcSensqdu
         cSqZ7Nizc6G73BtGDDgXFLVn3k0Z9QbiyqstDlKBRBaLL/S3u3G1mkuqsq+Mgk10bI9Q
         URy+2w5Z/wtqO2hY7YOjI3vZIzihSR8oNCjR2vx5yeemOW6HLeW251I/ieDRPfLqSiFQ
         AcDfH9Oc6SP3pK0wcjq9h/LBYJR9bPXmYr/aNzOQb79MKQb9r00qFC7M0f1+VyvCXHJe
         I43aJ/tHJyAKZKEHbsuhXn/BieQjQGyzrm7Palqyh2FNgrldSxTN5tSA6kzIqD9XdlE+
         cynw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783481779; x=1784086579;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=CvczDvHK6doetNfCiPotMmHZg7w7Gu6Nh6hG9FaOUNw=;
        b=YZuAhhWcyWGxbbbK/gwzLE6/TqX7WskW2FDa8ziNLsaR4ciQ9ti9Fjrb74hYQkxpTT
         Q0j8p3liGYebhEJFdRvv1zx9oCCndTs6wHsCpy2NZbQCydlY3INgSm0MjpU8oy2ZwqSM
         ERq0BxjMPhMD85dwj8VckV8RZHZVImbum5Oe/rc5eJGB4D/0GUme9z3IS+eQrU8mGt6g
         WZTOnyrYyuv4c/o6Rag8onuU/dTPx8iG3DQ0qFY3A1CceXuWb6jAdSW25ICU04vgxE3B
         olpCISl2IC2fIUoaIrMkPSSTEzJ+vpj4JDWF62vKXxSMtawxYsi9E3TfeFzw9KzLBj0y
         AsoA==
X-Forwarded-Encrypted: i=1; AHgh+RpbfDsR8TK9zDcmnHXG0y+EQvt/9M10YKiQobrQeE7z9Fb/VgI5LopE17P84vK6KS05tIo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz/fxs/ETQXWTnExZ/yKXtZ2vLYSss+lxGTI1A5se6b32Vmysfh
	ed2gGrYil8XUsQtqO70heU6kYR5gNHvh2OGIT6PdjjjnJ6q1KqtfanYY
X-Gm-Gg: AfdE7clh84LY4rmYgV4PwrH7ihym4HsxTp7qRLyUOesqb//dJvB/aku9dC2XHLOTrZf
	LBokc+SCB8HAU7g9ZFiIvZklEJ3x2EHRJ79myeaBPFg+EZNbvyv8JB+d4KteQzO66+mEFbyb6f6
	MV13c/gi3lyEujY0eiYbs7GVZ2tREsxCj5hYIaI3vFHQ9zk70u5iuhjgsMjobfecUkE9Wk/JdUg
	7WNIFXVwtZdHeyloTjKjej2LIAhrmzUL4QC0PzmIW4aTCQYweE6FOluSdL0nL5mY4Zp+eIwhZDF
	G7cXX6HMR47LX37D/x4ksWpNtQjWQq/L1WCJ8n3kV3A8WJFB/Dcy522Op4LPIgpev2dgPFCcwWS
	lbTrJIcMS6GJ47itzXjaBmBQWdPKFXJUVZEY3lrmXJPrPWqXYqz2Sa6ps7ItNxufQieVS0ywU4/
	tw4NM1xzrwjLUjrGKj8kR+l30XaUSEdILKsQBXRVA=
X-Received: by 2002:a05:6a21:400d:b0:3c0:9c1b:d0b5 with SMTP id adf61e73a8af0-3c0bd2ab6e9mr593638637.64.1783481779487;
        Tue, 07 Jul 2026 20:36:19 -0700 (PDT)
Received: from [10.0.0.65] ([2601:647:6700:64d0::94ac])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-31174accae5sm21092850eec.29.2026.07.07.20.36.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jul 2026 20:36:18 -0700 (PDT)
From: Charlie Jenkins <thecharlesjenkins@gmail.com>
Subject: [PATCH v3 00/17] riscv: Generate riscv instruction functions
Date: Tue, 07 Jul 2026 20:34:23 -0700
Message-Id: <20260707-riscv_insn_table-v3-0-3f8e5f75ba97@gmail.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/23NSwqDMBCA4atI1k3JS2O76j1KkaijDmhSEgkt4
 t0b7aKFFmbzD8w3CwngEQI5ZwvxEDGgsynkISPNYGwPFNvURDBRMM4V9RiaWKENtppNPQKVpTr
 ladqulSSd3T10+NjJ6y31gGF2/rl/iHzbvjHF9C8WOWU0V7XSsjActL70k8Hx2LiJbFgUH6AQ/
 A8gEqA7VnIGIIRW38C6ri/RvYl08QAAAA==
X-Change-ID: 20260114-riscv_insn_table-38495495dfd3
To: Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>, 
 Nam Cao <namcao@linutronix.de>, Alexandre Ghiti <alex@ghiti.fr>, 
 Anup Patel <anup@brainfault.org>, Atish Patra <atish.patra@linux.dev>, 
 Conor Dooley <conor@kernel.org>, Paolo Bonzini <pbonzini@redhat.com>, 
 Andrew Morton <akpm@linux-foundation.org>, Shuah Khan <shuah@kernel.org>, 
 =?utf-8?q?Radim_Kr=C4=8Dm=C3=A1=C5=99?= <radim.krcmar@oss.qualcomm.com>, 
 Jesse Taube <jtaubepe@redhat.com>
Cc: linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org, 
 kvm@vger.kernel.org, kvm-riscv@lists.infradead.org, 
 linux-kselftest@vger.kernel.org, 
 Charlie Jenkins <thecharlesjenkins@gmail.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1783481777; l=5854;
 i=thecharlesjenkins@gmail.com; s=20260605; h=from:subject:message-id;
 bh=j+4xd4UFPYMx31RI3oZhzKH55RnIh5Q4blgoRCeJwgw=;
 b=74eWphOVMu50WOZqGrtcoyw4AkgM3MK/BcaxvTUNxBiKAeL2V+Dwf1fwKvxtcqNIRQUDzq+pX
 UPNo3RbM/isDYKuYo8hYptrVM53U/y987iMR9BJFZ9OW4w9uDqv1I4a
X-Developer-Key: i=thecharlesjenkins@gmail.com; a=ed25519;
 pk=ajnnRQ98PIdwKp4HeMkq9U32okYbnh6Zb4G3o5XXvkg=

There is a lot of code that is manually manipulating riscv instructions.
Constructing these headers for new instructions is time consuming and
error prone.

The first patch in this series introduces the instruction definition
table along with a script that runs at compile time to create all of the
associated instruction manipulation functions. The remaining patches
migrate all of the manual instruction code to use these generated
functions.

The instruction definition table is generated from the
riscv-unified-db[1], an open source RVI project for instruction
specifications. I got this table generation merged into
riscv-unified-db, that PR can be accessed on github [2].

After a format update PR is merged [3], I will link the commit hash of
the generated instructions.

A lot of the validation for these changes is from running all possible
32-bit or 16-bit integers through these functions to see that any given
instruction will produce to expected result. I give more detail on the
test cases in the notes of the first couple of patches.

For the KVM patches, I also introduce two test cases to ensure that the
instruction manipulation is working as expected.

[1] https://github.com/riscv/riscv-unified-db
[2] https://github.com/riscv/riscv-unified-db/pull/1780
[3] https://github.com/riscv/riscv-unified-db/pull/1869

Signed-off-by: Charlie Jenkins <thecharlesjenkins@gmail.com>
---
Changes in v3:
- A lot of Sashiko suggestions
- Introduced new patch "riscv: Maintain epc on misaligned emulation
  error" that will help with error handling
- Use CONFIG_32BIT/CONFIG_64BIT instaed of __riscv_xlen for generated
  instructions
- Link to v2: https://patch.msgid.link/20260621-riscv_insn_table-v2-0-7f0810ee2274@gmail.com

Changes in v2:
- rebased on v7.1
- I dropped the patch fixing the mmio bug in kvm because in the
  meantime that bug has been fixed in a different patch
- Calls to panic() for instructions not support on current hardware have
  been changed into BUG_ON()
- Fixed incorrect handling of branches in simulate_*()
- Added CONFIG_RISCV_KPROBES_SIMULATE_KUNIT for more detailed
  simulate_*() testing
- Updated insn.tbl based on new merged in changes to riscv-unified-db
- Link to v1: https://lore.kernel.org/r/20260407-riscv_insn_table-v1-0-54b4736a1e77@gmail.com

---
Charlie Jenkins (17):
      riscv: Introduce instruction table generation
      riscv: alternatives: Use generated instruction headers for patching code
      riscv: kgdb: Use generated instruction headers
      riscv: Add kprobes instruction simulation KUnit
      riscv: kprobes: Use generated instruction headers
      riscv: cfi: Use generated instruction headers
      riscv: Maintain epc on misaligned emulation error
      riscv: Use generated instruction headers for misaligned loads/stores
      riscv: kvm: Use generated instruction headers for csr code
      KVM: device: Add test device
      KVM: riscv: selftests: Add mmio test
      riscv: kvm: Use generated instruction headers for mmio emulation
      riscv: kvm: Add emulated test csr
      KVM: riscv: selftests: Add csr emulation test
      riscv: kvm: Use generated instruction headers for csr emulation
      riscv: kexec: Use generated instruction headers for kexec relocations
      riscv: Remove unused instruction headers

 arch/riscv/Kconfig.debug                           |    1 +
 arch/riscv/Makefile                                |    3 +
 arch/riscv/include/asm/Kbuild                      |    1 +
 arch/riscv/include/asm/insn.h                      |  563 +-------
 arch/riscv/include/asm/kvm_host.h                  |   10 +
 arch/riscv/include/asm/kvm_vcpu_insn.h             |    5 +-
 arch/riscv/include/asm/kvm_vcpu_test_csr.h         |   15 +
 arch/riscv/kernel/alternative.c                    |   23 +-
 arch/riscv/kernel/cfi.c                            |    6 +-
 arch/riscv/kernel/kgdb.c                           |  102 +-
 arch/riscv/kernel/machine_kexec_file.c             |   55 +-
 arch/riscv/kernel/probes/decode-insn.c             |    7 +-
 arch/riscv/kernel/probes/simulate-insn.c           |  253 ++--
 arch/riscv/kernel/probes/simulate-insn.h           |    7 +-
 arch/riscv/kernel/tests/Kconfig.debug              |   13 +
 arch/riscv/kernel/tests/kprobes/Makefile           |    2 +
 .../kernel/tests/kprobes/test-kprobes-simulate.c   |  250 ++++
 arch/riscv/kernel/tests/kprobes/test-kprobes.h     |    6 +
 arch/riscv/kernel/traps_misaligned.c               |  209 ++-
 arch/riscv/kvm/Kconfig.debug                       |   16 +
 arch/riscv/kvm/Makefile                            |    1 +
 arch/riscv/kvm/vcpu_insn.c                         |  264 ++--
 arch/riscv/kvm/vcpu_test_csr.c                     |   21 +
 arch/riscv/tools/Makefile                          |   22 +
 arch/riscv/tools/insn.tbl                          | 1392 ++++++++++++++++++++
 arch/riscv/tools/insn_tbl.sh                       |  258 ++++
 include/uapi/linux/kvm.h                           |    2 +
 lib/Kconfig.debug                                  |    6 +
 tools/testing/selftests/kvm/Makefile.kvm           |    2 +
 tools/testing/selftests/kvm/riscv/csr_test.c       |  133 ++
 tools/testing/selftests/kvm/riscv/mmio_test.c      |  189 +++
 virt/kvm/Kconfig.debug                             |   16 +
 virt/kvm/Makefile.kvm                              |    1 +
 virt/kvm/kvm_main.c                                |    8 +
 virt/kvm/mmio_test.c                               |  103 ++
 virt/kvm/mmio_test.h                               |   18 +
 36 files changed, 2951 insertions(+), 1032 deletions(-)
---
base-commit: 8cd9520d35a6c38db6567e97dd93b1f11f185dc6
change-id: 20260114-riscv_insn_table-38495495dfd3

Best regards,
--  
- Charlie

