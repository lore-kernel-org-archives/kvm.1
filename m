Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9361493D44;
	Mon, 21 Sep 2026 12:27:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789993644; cv=none; b=clWITUbGGME5jf18EPo7ekMck0OhIVP4xM28JHdG3idstb8nT1ORhuWnpQpoRuDHvOdEeyWoNvpWZu6M9RvnjHtseH6eCmAFWotjMO4fhjH+t75/KCyU+QciSdcH0hZGI+W5dddtcU/zn1LH33xYHsoRb6wAD7XQ4cjViZnIFBA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789993644; c=relaxed/simple;
	bh=SjDao1yNks/V61Ir0suTkP7GRJSrFYDBucpEXbNO0nA=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=F3Qe5L/8E9ZLfGdFQTZrmGGUm437kw1RAYoEQHtdNvnTUsbJwg54oUUufYGK9kRtlFbTHDp9xoKS/RTIKJAoUxBGHAC6dkrMpepGdV0N5D7DlmJ9Va8LU2booIyljc/iW8oX75N6/TYO2qA5j/67o8kGTXgobTgzpQ0a+6V+OFg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gWbfEfo8; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gWbfEfo8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ADC701F000FF;
	Mon, 21 Sep 2026 12:27:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789993642;
	bh=u3kpT48+EAjuEBOYW9Un4dFvspIcpqydYwj1Scn9tqY=;
	h=From:Subject:Date:To:Cc;
	b=gWbfEfo8+iZGckv2O6ms2ErMihHJC39wCp36OIo9ypFslxaoOPH9SjskVsGQ5PHQ0
	 VLLiKZEafOXRBjdpUKBaeFGoBJEPfKtU+0RI/QI3/PdC17D11z0+Uom0leM/isd2AN
	 aibgohAuEvnOKVYIkY3vMei0iKOD+KzTCgKwIwKZT4sf4ceTpJ7QBco1cxaFZFbUtB
	 /p9vS5++0wqgE72ezmjq/rAv6Wl5GS1CoqFUBztUc587DFSrb2bw6cnrH9vdtlkgJc
	 ZlbE+L+SbcchctcRjgKQDr3oFwT9U/PqHig1gGeAzLbrEfqih6W9S4eVzKXy/PABnC
	 RZNAnEdnGhVZw==
From: "GUO Ren (XuanTie)" <guoren@kernel.org>
Subject: [PATCH RFC v4 0/4] RISC-V: Add PARAVIRT_SPINLOCKS support
Date: Mon, 21 Sep 2026 12:27:00 +0000
Message-Id: <20260921-pvqspinlock-v4-0-409a22aed6ef@kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAJQisWoC/zWMyw6CMBBFf4XM2pJpeSiuTEz8ALfGBZQBKtjiF
 IgJ4d8Fjctzc8+ZwRMb8nAMZmCajDfOrhDvAtBNbmsSplwZFKoUMyVFP718b2zndCv2UV6iroo
 4KSSsRs9Umfe3doPr5Qz33+jH4kF62DrbrWL3FEPDlP/TiVQoESOMZZhmCR6kkKIeHZM9tcSWu
 tBxDcvyAUHIQhywAAAA
X-Change-ID: 20260921-pvqspinlock-73ad0cfb45b1
To: Anup Patel <anup@brainfault.org>, Atish Patra <atish.patra@linux.dev>, 
 Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>, 
 Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>, 
 Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>, 
 Randy Dunlap <rdunlap@infradead.org>, 
 Fangyu Yu <fangyu.yu@linux.alibaba.com>, 
 CHEN Jiankang <yubin.cjk@alibaba-inc.com>
Cc: kvm@vger.kernel.org, kvm-riscv@lists.infradead.org, 
 linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org, 
 linux-doc@vger.kernel.org, Leonardo Bras <leobras@redhat.com>, 
 "GUO Ren (XuanTie)" <guoren@kernel.org>
X-Mailer: b4 0.16.0

Paravirtualized spinlocks allow an unfair qspinlock to replace the
ticket-lock or native fair qspinlock implementation with something
virtualization-friendly, for example, halting the virtual CPU rather
than spinning.

You can observe the paravirt qspinlock behavior with the pv_kick and
pv_wait tracepoints under /sys/kernel/debug/tracing/:

  # echo 1 > /sys/kernel/debug/tracing/events/paravirt/enable
  # cat /sys/kernel/debug/tracing/trace
            TASK-PID     CPU#  |||||  TIMESTAMP  FUNCTION
               | |         |   |||||     |         |
             sh-100     [001] d..2.    28.312294: pv_wait: cpu 1 out of wfi
         <idle>-0       [000] d.h4.    28.322030: pv_kick: cpu 0 kick target cpu 1

This series is split from [1]. The newest discussion is at [2].

[1]: https://lore.kernel.org/linux-riscv/20231225125847.2778638-1-guoren@kernel.org/
[2]: https://lists.riscv.org/g/tech-prs/message/1211

Changelog:
v4:
 - Rebase onto v7.3-rc4.
 - Normalize the author identity to "GUO Ren (XuanTie)".
 - Minor commit log cleanups (fix line-wrap artifacts and typos).

v3:
https://lore.kernel.org/linux-riscv/20251201003041.695081-1-guoren@kernel.org/
 - Rebase on linux-6.18-rc7.
 - Simplify nopvspin usage.

v2:
https://lore.kernel.org/linux-riscv/20241227011011.2331381-1-guoren@kernel.org/
 - Add RFC tag.
 - Using new SBI_EXT_PVLOCK ID.
 - Add virt_spin_lock support.
 - Add nopvspin support.

v1:
https://lore.kernel.org/linux-riscv/20241222033917.1754495-1-guoren@kernel.org/

GUO Ren (XuanTie) (5):
  RISC-V: Add PARAVIRT_SPINLOCKS support
  RISC-V: paravirt: Add pvqspinlock KVM backend
  RISC-V: paravirt: Add pvqspinlock frontend
  RISC-V: paravirt: pvqspinlock: Add trace point for pv_kick/wait
  RISC-V: paravirt: Support nopvspin to disable PARAVIRT_SPINLOCKS

 .../admin-guide/kernel-parameters.txt         |  2 +-
 arch/riscv/Kconfig                            | 12 +++
 arch/riscv/include/asm/Kbuild                 |  1 -
 arch/riscv/include/asm/kvm_vcpu_sbi.h         |  1 +
 arch/riscv/include/asm/qspinlock.h            | 57 +++++++++++++
 arch/riscv/include/asm/qspinlock_paravirt.h   | 26 ++++++
 arch/riscv/include/asm/sbi.h                  |  5 ++
 arch/riscv/include/uapi/asm/kvm.h             |  1 +
 arch/riscv/kernel/Makefile                    |  2 +
 arch/riscv/kernel/qspinlock_paravirt.c        | 82 +++++++++++++++++++
 arch/riscv/kernel/setup.c                     |  5 ++
 .../kernel/trace_events_filter_paravirt.h     | 58 +++++++++++++
 arch/riscv/kvm/Makefile                       |  1 +
 arch/riscv/kvm/vcpu_sbi.c                     |  4 +
 arch/riscv/kvm/vcpu_sbi_pvlock.c              | 54 ++++++++++++
 15 files changed, 309 insertions(+), 2 deletions(-)
 create mode 100644 arch/riscv/include/asm/qspinlock.h
 create mode 100644 arch/riscv/include/asm/qspinlock_paravirt.h
 create mode 100644 arch/riscv/kernel/qspinlock_paravirt.c
 create mode 100644 arch/riscv/kernel/trace_events_filter_paravirt.h
 create mode 100644 arch/riscv/kvm/vcpu_sbi_pvlock.c

--
2.43.1

---
GUO Ren (XuanTie) (4):
      RISC-V: paravirt: Add pvqspinlock KVM backend
      RISC-V: paravirt: Add pvqspinlock frontend
      RISC-V: paravirt: pvqspinlock: Add trace point for pv_kick/wait
      RISC-V: paravirt: Support nopvspin to disable PARAVIRT_SPINLOCKS

 Documentation/admin-guide/kernel-parameters.txt  |  2 +-
 arch/riscv/Kconfig                               | 12 ++++
 arch/riscv/include/asm/Kbuild                    |  1 -
 arch/riscv/include/asm/kvm_vcpu_sbi.h            |  1 +
 arch/riscv/include/asm/qspinlock.h               | 57 ++++++++++++++++
 arch/riscv/include/asm/qspinlock_paravirt.h      | 26 ++++++++
 arch/riscv/include/asm/sbi.h                     |  5 ++
 arch/riscv/include/uapi/asm/kvm.h                |  1 +
 arch/riscv/kernel/Makefile                       |  2 +
 arch/riscv/kernel/qspinlock_paravirt.c           | 82 ++++++++++++++++++++++++
 arch/riscv/kernel/setup.c                        |  5 ++
 arch/riscv/kernel/trace_events_filter_paravirt.h | 58 +++++++++++++++++
 arch/riscv/kvm/Makefile                          |  1 +
 arch/riscv/kvm/vcpu_sbi.c                        |  4 ++
 arch/riscv/kvm/vcpu_sbi_pvlock.c                 | 54 ++++++++++++++++
 15 files changed, 309 insertions(+), 2 deletions(-)
---
base-commit: 93f51579e7df248780214094418f205253383cc5
change-id: 20260921-pvqspinlock-73ad0cfb45b1

Best regards,
--  
GUO Ren (XuanTie) <guoren@kernel.org>

