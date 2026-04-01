Received: from mail-pj1-f68.google.com (mail-pj1-f68.google.com [209.85.216.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFD4B29992B
	for <kvm@vger.kernel.org>; Wed,  1 Apr 2026 04:20:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.68
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775017244; cv=none; b=ROCzpEZJcucN07SmHJMFrge30F1XUih98MS21QixJt8Q2kTIOQnUuGJ5fdYL36T9+xu4y45Il6944lna7FYZx8kevmUTRUoEeoQT/6IvuyuDHkOOsZ0RH3hE8lvgI1TsXYRfrdhzgbI3VC0ZKF41BSkHVUrDVROU8WsR31Xykzc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775017244; c=relaxed/simple;
	bh=iul0ORc5WkJzmYSZyEUMQmJXz8rz/B/d2S2hDnsyDR4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Xb5zU0qnFcDAq9mkSkRM73vdnLc4jBdxW7zcg+Le+uSF9U3aYlahtAgu/LNdjNhZa7r8HN+UKg8v8ANtZ9IiF+GxAu2f+rrOEb8ggP5hNo7f73e25ITL1IleuzkgWMSTgEScvBRbU9VBGpseAoP9QdIu2ak/kTgwl3DN+SNV3XU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IwZd4b5v; arc=none smtp.client-ip=209.85.216.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IwZd4b5v"
Received: by mail-pj1-f68.google.com with SMTP id 98e67ed59e1d1-35da9692ec3so2441036a91.1
        for <kvm@vger.kernel.org>; Tue, 31 Mar 2026 21:20:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775017242; x=1775622042; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3uDZswhDJ/hxJs+0/mHbY7SSEst1HKgaUPB1y87khfI=;
        b=IwZd4b5vFmS3JMvQ8SyqgHS3ZDEnJllpLTowj8PiULeNBclOPPQkJxFTCKrjLYizzT
         m9Ms6J+XPdZESnA3iQ7BWfgvdw4cmsKtH5BmtMNphSKQUaJHrIFZExYWCLM/+vs5AP8c
         cLuTPqcKZeRE6Newq0pbsJ/6NIExWGf7ky7bZhnqjQf3ATgQwc7NJPObvztyoFPeZjTH
         1MC2BurwBZP2+SSOHKporLhon3FJTMDTYUtZCeoLssRtawnVMTsmlaXFLYeKg0DkqCLN
         Hb9Rizejw/fdA8aerXZqmhgubbqVfgM588Bzcn106NnKqTKtnwp/fPopyAhVe4seoPAH
         JQYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775017242; x=1775622042;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=3uDZswhDJ/hxJs+0/mHbY7SSEst1HKgaUPB1y87khfI=;
        b=cyb4DwaurM7kd2CrJOdqCr/msVcQhfW+f6tctWmgMZZTEMRtsJsrL84ip1wyPi9/tg
         pN/G2Tpab5QgvkaQhEqcvdU8y91AXcQyqRd5BTf30Rd0xt/UVdeKyO7bQ+gRm2A1V26l
         j/UCEabOoju/1zsnyIDUdsqwISF6YMmTCfi95DDsS3JTFnc12vDo+UWGhfFIig+uf0gO
         b53kS2A7Gb7glG3dQyqTPw9X4VYlcnXCunduLYbK0flxhhTHDjSZ+8IVCo+cJ0kshE+N
         US70ndI1O539faaD1qTtEoxBtSxFNZleaR1ceBD2Low/ase7YHEUWrYBnhKFIeb5cBg3
         nKWw==
X-Gm-Message-State: AOJu0YxtC6hAhtsPh0YZh+nQBL7YhJxJfzfG7bIT5mAOEKGTWLX6thS8
	odsCU7wRgK/BoWS1N8Zm5XgOk3jWfmihvwrnej8H1ZVliv25kPpvU63gxzuFHTsOkmHHiJ1U
X-Gm-Gg: ATEYQzxeIfWwzyC9j+RZtSkJTNQKdbhBgWw9c9gZ5AerJp58R3dS7BHlROrHNh1pFhM
	2liDWldWsB1kQK8DkfBhCme9CYIXXNUteVdHjDW7c9b0qfza+seOvAUZp42gKERA3J+DsVzBxE+
	TZzCuzMZCmF7aAEYxL88bStibjvtm8m479q+SHKd8U/YQ2C5jHmiU9xm49c4qqghpmWT05uruam
	W5l1Xwmy9GTfKrlgpiF4ZN9st92E0XV5zlkGE/7zLA5z40JYV8l5VkXyklzfCYJSVRmELLVlCsH
	a3eyliyHmKPF8bzHqUGYjEbIwpp1uvhPrHB0BdBSKXc+K9jMVWwiNM6PyIgGyUbFr8pwyPyFEUk
	b5T0JfajHTuNfvUB6C+WREuXny2KGHF8pKWAg9RJFXibd5c+SLgaGmgpihu2KveVbGy8Bwl85DD
	2eIqBPFE+HHqz+5/KxVsUGxPattVqeYuJN6P1OiBuEs8qm37+wP5raqU7CFIEQ4OGM
X-Received: by 2002:a05:6a20:2595:b0:39c:2da3:8d7e with SMTP id adf61e73a8af0-39ef76c1a88mr1931809637.36.1775017241861;
        Tue, 31 Mar 2026 21:20:41 -0700 (PDT)
Received: from tmp.n4j8V6uPUy (n058152022035.netvigator.com. [58.152.22.35])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c76b9c20473sm2379783a12.24.2026.03.31.21.20.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Mar 2026 21:20:41 -0700 (PDT)
From: vince <liuwf0302@gmail.com>
To: kvm@vger.kernel.org
Cc: ryan.roberts@arm.com,
	will@kernel.org,
	julien.thierry.kdev@gmail.com,
	vince <liuwf0302@gmail.com>
Subject: [PATCH v3 0/3] Add GDB remote debug stub for x86 and arm64
Date: Wed,  1 Apr 2026 12:20:31 +0800
Message-Id: <20260401042034.755639-1-liuwf0302@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <177457996500.86179.14991222733583648054@gmail.com>
References: <177457996500.86179.14991222733583648054@gmail.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series adds a GDB Remote Serial Protocol (RSP) stub to kvmtool,
enabling source-level debugging of guest kernels via `gdb target remote`.

Supported features:
 - Software breakpoints (INT3 / BRK #0) with guest memory read/write
 - Hardware breakpoints via DR7 (x86) / KVM_SET_GUEST_DEBUG (arm64)
 - Single-step via RFLAGS.TF (x86) / PSTATE.SS (arm64)
 - General-purpose and system register access
 - ARM64 virtual-to-physical address translation (TTBR1 page-table walk)
 - I-cache coherency after SW breakpoint patching (arm64)

Usage:
  lkvm run --gdb 1234 --gdb-wait ...
  (gdb) target remote :1234

Changes in v3:
 - x86/gdb.c: Fix all C89 violations (mixed declarations, for-init)
 - x86/gdb.c: Add empty kvm_gdb__arch_sync_guest_insn() (x86 coherent)
 - gdb.c: Fix wrong PHYS_OFFSET comment (0x40000000 -> 0x80000000)
 - gdb.c: Fix C89 violations in arm64_sw_walk_ttbr1()
 - gdb.c: Fix gdb_disable_debug() to issue KVM_SET_GUEST_DEBUG(control=0)
 - gdb.c: Add 'M' packet payload length validation
 - gdb.c: Refactor gdb_write_guest_mem() to pass sync_icache flag
 - arm/aarch64/gdb.c: Remove unused macros (BRK0_INSN, ESR_EC_*)
 - arm/aarch64/gdb.c: Fix uninitialized pc in kvm_gdb__arch_reinject_sw_bp()
 - All files: Replace non-ASCII Unicode characters with ASCII equivalents
 - Drop gdb-stub-security-notes.md and gdb-stub-test-spec.md from the series

vince (3):
  x86: Add GDB stub and step-debug support
  arm64: Add GDB stub and step-debug support
  arm64: Sync guest instruction patches for GDB breakpoints

 Makefile                       |   13 +-
 README                         |   29 +
 arm/aarch64/gdb.c              |  753 +++++++++++
 builtin-run.c                  |   13 +-
 docs/gdb-stub-architecture.md  |  142 ++
 gdb.c                          | 2225 ++++++++++++++++++++++++++++++++
 include/kvm/gdb.h              |  148 +++
 include/kvm/kvm-config.h       |    2 +
 kvm-cpu.c                      |    9 +-
 term.c                         |   18 +-
 tests/Makefile                 |    4 +
 tests/boot/Makefile            |   10 +-
 tests/gdb/Makefile             |    8 +
 tests/gdb/test-x86-gdb-stub.py |  178 +++
 x86/gdb.c                      |  582 +++++++++
 15 files changed, 4122 insertions(+), 12 deletions(-)
 create mode 100644 arm/aarch64/gdb.c
 create mode 100644 docs/gdb-stub-architecture.md
 create mode 100644 gdb.c
 create mode 100644 include/kvm/gdb.h
 create mode 100644 tests/gdb/Makefile
 create mode 100644 tests/gdb/test-x86-gdb-stub.py
 create mode 100644 x86/gdb.c

-- 
2.34.1


