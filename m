Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D815263F44
	for <kvm@vger.kernel.org>; Sat,  9 May 2026 13:10:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778332221; cv=none; b=O/YbAf9y9zpQSEDWFcWppfgvHM0tkfDlROFwMm3qVrcjnTzt5lujiqotCKXRvNOhMaB4jjUoWeuQBKZlKTItGiyUtRb3XngOEE2eDD+DDle4cc4iEd9eWvm7yKls0PurXDml6PQkC3Fw4nQgHPInzsEKgkzkCaP6IibZy5idmLk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778332221; c=relaxed/simple;
	bh=UM1YTVWKCXjwkowt3WjEd184ybys8RxDPu1C31uIsnA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=LFrFLTQ/pfhJ0g5/UAgHfmIg/YVRqJbmYUUoXs2arCUIUPe9tQHo+kwM7rSh2fYVNZkERJCGyaq0VYDSfd7pdomurUAU+lkmvoJRyOV+b0+8aJ6wYLdh0IVjTHBOWo25pTtsT8duyh5ZUHWz/6Plln21qrR8QuyucxxW+BAh7PU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=dfWW4Is3; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="dfWW4Is3"
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-836ed29d1e5so1245069b3a.2
        for <kvm@vger.kernel.org>; Sat, 09 May 2026 06:10:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1778332215; x=1778937015; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=A3NyDBs4ghD74Azq1zzFPGUm5QlcBDwy4o68+WiOzU4=;
        b=dfWW4Is3N28283+If5USHbp2VAQF9w7mBCsSBT2Umff6F2aCHFvxGTDkSrZN1Pz+0M
         +tkOG0Ap86At5w3aAKNYPPCM9BqSkQEcQY9HYx3U1JfF/wFltcyztP/nq81r0kVWoeM6
         DRACsP1SUD95x1z7/YbmVn+a8eOPtQbuLUYy4NtNelFZ9LmakqKmFdLOKZuclayRpeRj
         99O+pFvwomt6JZcMfciVJiPVxuGq1GzX/Nlxz4zbI94/R92B7PHTk7HQN1SLnbjyQz1q
         mHLuWKL41I6AQ05XsA7SLX4Tf3hYNeNvFTk9TdBUh1cwo/3juSBeEAtUdye071nfOeww
         XfRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778332215; x=1778937015;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=A3NyDBs4ghD74Azq1zzFPGUm5QlcBDwy4o68+WiOzU4=;
        b=hNamNX+V3RlHM3tlr1qi/0Jptk7Q9RrXERJ+rRQh+ah8UKlBtBBeAhoC6Ij0gzmw99
         3ohWDEugox7f3y+h37LetcSdBGOqzdu0Cj+NxXQhH5Hdhc+U8EzzmUBBmHzQgANf93Az
         KEfQggbyutb+NNSRSW3TK+10PrDTPTcT9Dvgh524uO3TpR2WswIFm714hb8Ttg4DEaaL
         NrpSYcYAymZxQYL8SsEvdcdcWIyt8yfIpJ5tQjilgyDHR23nWnuRPBAgNivbiZ0rSSOH
         Dbm2A88/P7hDwJJtC//LJUzZgQlOhlfEW8A5pZ5wjrvx6KPuYfMN8Ochvoklbj4RaAHO
         FlFA==
X-Forwarded-Encrypted: i=1; AFNElJ+hoUpsharJL/SDFMdvyLF2xxI8aXIL1N2UxOLO9AvRuCbEFP8avbHkVT+wL51L4nnGqPs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy0earw5Wg2cV+mFu1ADNl5Ie/Mkyykp6Tb9sLWdZl5C0M1IXJo
	h6LYKKZInTPxaF942kjddzTunjSnydySG70r4GOsAmKOpvZAIBlE6xP4hrk9GaIskDg=
X-Gm-Gg: Acq92OEfhxfCDi7r1QAUwH8GuLDI+dg0uU+57RHp/QkadkbG9wzlfOT55r64rlKaRMa
	OUAOPczL8+AXtkEJrF+dBO2mXNiNdUlarrpXRurJIXCV2TCh2GiCri8kFWBKNLcn+S86va563e0
	UOrS4SdctYzf12lq6mcI+5TWO6Kl+ZJNHD921qfZUSDeFFkUidh/e9nWTsmi1KNn/Y3kBO+AF08
	02Y4n2IuW1IM5m8pqbZq1z+24zzOVJUWUba92xbTMqJ/3a2jy7S4sANRFybGiBQhwDPzcPY8EBO
	KDDJmVN+WvIW6DmogGY64FzbO7t0cVlG8syVZHtFZTYylsRlQDa3Pnh5QuEjUFiDItdIDn+Dat+
	cdpJfQZZ8QGVLM+JnCufGb2NOprSJCaxDIeoXrL1eqUTgJ3KTf7BJYm+G5OF37RadpQ4PvdN09k
	MvzRidWweb8Eq6qWylY8ujTAgslQqfq4SnYuEdgWux/OyuxRPnDm2W6FfGxr0htQGalLY=
X-Received: by 2002:a05:6a00:2d0c:b0:82f:4f67:1ff6 with SMTP id d2e1a72fcca58-83a5b6c460fmr15827882b3a.4.1778332215217;
        Sat, 09 May 2026 06:10:15 -0700 (PDT)
Received: from FJ7FR2JRQ3.bytedance.net ([155.117.34.6])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-839679c86b3sm18552855b3a.28.2026.05.09.06.10.07
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sat, 09 May 2026 06:10:14 -0700 (PDT)
From: Zhanpeng Zhang <zhangzhanpeng.jasper@bytedance.com>
To: linux-riscv@lists.infradead.org
Cc: linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	kvm@vger.kernel.org,
	kvm-riscv@lists.infradead.org,
	Paul Walmsley <pjw@kernel.org>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Alexandre Ghiti <alex@ghiti.fr>,
	Conor Dooley <conor@kernel.org>,
	=?UTF-8?q?Cl=C3=A9ment=20L=C3=A9ger?= <cleger@rivosinc.com>,
	Himanshu Chauhan <himanshu@thechauhan.dev>,
	Will Deacon <will@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Atish Patra <atish.patra@linux.dev>,
	Anup Patel <anup@brainfault.org>,
	Shuah Khan <shuah@kernel.org>,
	Yunhui Cui <cuiyunhui@bytedance.com>,
	Zhu Yuan <yuanzhu@bytedance.com>,
	Zhanpeng Zhang <zhangzhanpeng.jasper@bytedance.com>
Subject: [PATCH v9 0/5] riscv: add SBI Supervisor Software Events support
Date: Sat,  9 May 2026 21:09:57 +0800
Message-ID: <cover.1778331862.git.zhangzhanpeng.jasper@bytedance.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit


This series continues Clément's SBI Supervisor Software Events (SSE)
Linux support. Most of the framework is still Clément's work; many
thanks to him for bringing the series this far. Clément reached out and
suggested that I could continue the upstream work, so I am picking up
the series from here.

SSE gives the SBI a firmware-to-S/HS-mode event delivery path that does
not depend on ordinary S-mode interrupt delivery. This is useful for
NMI-style platform events and for PMU overflow delivery through firmware.

This respin mainly fixes two issues:

  - KVM Context Corruption

    An SSE can interrupt HS-mode code around guest execution, run a
    synthetic SSE handler, and then complete back through firmware.  The
    handler episode must be transparent to Linux-owned trap and
    virtualization state.  This version folds the stvec and hstatus
    preservation into the Linux SSE entry wrapper, rather than relying on
    OpenSBI to keep extra hidden resume state. This follows the earlier
    discussion [1].

  - SSE Handler's SSTATUS Leakage

    With CONFIG_RISCV_PMU_SBI_SSE, perf can use the local PMU overflow
    SSE event instead of the ordinary PMU interrupt. This makes the PMU
    overflow handler a real hot path for SSE: workloads such as
    "perf top" can enter the SSE handler and completion paths at a high
    rate. The previous code did not preserve the interrupted
    sstatus.SIE/SPIE/SPP state separately from the synthetic handler
    trap-return state, so high-frequency PMU-SSE delivery could quickly
    expose the leakage. One observed failure mode was an "environment
    call from U-mode" panic. This series addresses that by making the
    SSE entry wrapper preserve the live sstatus state around the handler
    before completing the event.

The selftest has also been extended to cover the high-frequency PMU-SSE
patterns that exposed these bugs.  The new stress modes exercise repeated
handler entry and completion, SBI calls from a handler, PMU stop/start
activity, and re-injection.

How to test:

  Build a kernel with at least:

    CONFIG_RISCV_SBI_SSE=y
    CONFIG_RISCV_PMU_SBI=y
    CONFIG_RISCV_PMU_SBI_SSE=y

  Build the selftest module against that kernel and run the smoke test:

    ./run_sse_test.sh

  Then run the stress layers.  Use stress=1 to run them after the smoke
  test, or stress=2 to run only the stress layers:

    ./run_sse_test.sh stress={0,1,2}

Known limitations and follow-up work:

SSE is a relatively large extension which builds synthetic supervisor
contexts and then resumes the interrupted context through firmware. This
series fixes the issues found so far in that entry/completion path, but I
think it still needs more testing and review. There may still be corner
cases in the constructed handler context or in the state restored after
completion that this series does not cover yet.

The next planned area is virtualization support. Follow-up work is
expected to distinguish host and guest PMU-SSE samples, and to support
delivering SSE events to guests, i.e. the KVM-SSE work from earlier
revisions.

[1] https://lore.kernel.org/r/9290f53d-3545-4299-9781-c1c558f71158@rivosinc.com

---

Changes in v9:
  - Picked up Clément's v8 series and rebased it onto the current RISC-V
    for-next branch.
  - Fixed KVM Context Corruption by keeping stvec and hstatus stable across
    the synthetic SSE handler episode.
  - Fixed SSE Handler's SSTATUS Leakage, where interrupted
    sstatus.SIE/SPIE/SPP state could be confused with the handler
    trap-return state under high-frequency PMU-SSE delivery.
  - Extended the SSE selftest with stress={0,1,2} modes that cover repeated
    handler entry, SBI calls, PMU activity and re-injection, and fixed event
    registration and attribute-buffer lifetime corner cases.
  - Updated MAINTAINERS for the RISC-V SSE driver.

Previous versions:
  v8:
    https://lore.kernel.org/r/20251105082639.342973-1-cleger@rivosinc.com

Clément Léger (5):
  riscv: add SBI SSE extension definitions
  riscv: add support for SBI Supervisor Software Events extension
  drivers: firmware: add riscv SSE support
  perf: RISC-V: add support for SSE event
  selftests/riscv: add SSE test module

 MAINTAINERS                                   |  17 +
 arch/riscv/include/asm/asm.h                  |  14 +-
 arch/riscv/include/asm/sbi.h                  |  61 ++
 arch/riscv/include/asm/scs.h                  |   7 +
 arch/riscv/include/asm/sse.h                  |  47 ++
 arch/riscv/include/asm/switch_to.h            |  14 +
 arch/riscv/include/asm/thread_info.h          |   1 +
 arch/riscv/kernel/Makefile                    |   1 +
 arch/riscv/kernel/asm-offsets.c               |  14 +
 arch/riscv/kernel/sbi_sse.c                   | 162 ++++
 arch/riscv/kernel/sbi_sse_entry.S             | 187 +++++
 drivers/firmware/Kconfig                      |   1 +
 drivers/firmware/Makefile                     |   1 +
 drivers/firmware/riscv/Kconfig                |  15 +
 drivers/firmware/riscv/Makefile               |   3 +
 drivers/firmware/riscv/riscv_sbi_sse.c        | 694 ++++++++++++++++
 drivers/perf/Kconfig                          |  10 +
 drivers/perf/riscv_pmu.c                      |  23 +
 drivers/perf/riscv_pmu_sbi.c                  |  71 +-
 include/linux/perf/riscv_pmu.h                |   5 +
 include/linux/riscv_sbi_sse.h                 |  57 ++
 tools/testing/selftests/riscv/Makefile        |   2 +-
 tools/testing/selftests/riscv/sse/Makefile    |   5 +
 .../selftests/riscv/sse/module/Makefile       |  16 +
 .../riscv/sse/module/riscv_sse_test.c         | 769 ++++++++++++++++++
 .../selftests/riscv/sse/run_sse_test.sh       |  48 ++
 26 files changed, 2231 insertions(+), 14 deletions(-)
 create mode 100644 arch/riscv/include/asm/sse.h
 create mode 100644 arch/riscv/kernel/sbi_sse.c
 create mode 100644 arch/riscv/kernel/sbi_sse_entry.S
 create mode 100644 drivers/firmware/riscv/Kconfig
 create mode 100644 drivers/firmware/riscv/Makefile
 create mode 100644 drivers/firmware/riscv/riscv_sbi_sse.c
 create mode 100644 include/linux/riscv_sbi_sse.h
 create mode 100644 tools/testing/selftests/riscv/sse/Makefile
 create mode 100644 tools/testing/selftests/riscv/sse/module/Makefile
 create mode 100644 tools/testing/selftests/riscv/sse/module/riscv_sse_test.c
 create mode 100644 tools/testing/selftests/riscv/sse/run_sse_test.sh

-- 
2.50.1 (Apple Git-155)
