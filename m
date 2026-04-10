Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com [209.85.215.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AFCD3939A2
	for <kvm@vger.kernel.org>; Fri, 10 Apr 2026 23:58:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775865527; cv=none; b=sTUHdYCFq6v92xJ5R/iislm+lpy5s6NPl90JH3hTh40AWz1K3i9KWzqyFAD4Zw45T/zSOS/AGc/CIMv2vXyrQc4Lmmce4093HzogySaqrLOQ7yFJnhEPBYf0BBDkjbuqM+xXD9Tv07/Xyivzt9x/kTIH2bLU1uXuePMXso23vSU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775865527; c=relaxed/simple;
	bh=OAjJXOD9e9ZCrBOE/1IAIYsawrgalTMmndxT6VPcqaI=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=jxhEC+/zKxg7nxmi3xW0AbtymwRQp59UKtHtOMlMkysATgocPHSLE4y258hkp5Khc1Z54A+62//EQzkLaD0+JRBVntnt15S+rUjCOb3Rrb/yxzE3ELH2w02hm86X3J/nRvAwGWWNSHoGyAiv4siqcZ2e8qW56ITM+VU/GZO0OHg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ON2v/yDz; arc=none smtp.client-ip=209.85.215.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ON2v/yDz"
Received: by mail-pg1-f201.google.com with SMTP id 41be03b00d2f7-b62da7602a0so1783671a12.2
        for <kvm@vger.kernel.org>; Fri, 10 Apr 2026 16:58:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1775865525; x=1776470325; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=213w54WPItuluzf2zJbkbNPQu8IYxwh/wCXaJ4qlVE8=;
        b=ON2v/yDzBCoEKjSF6VuhnBFU5wU8Hg4VAEvF6qLQmkVZhJomSkl1O8DlhK/QK4cvWw
         JfffFOEviBVu9uL+/qlPWhPdO81Hi4tSG28XrltB75eISo3M7f0zL7BlJVJ2SrRYmS+n
         w6/ITHz1uyhGqSnQP62PteT+H23pIGuAkqwl3T9licfP1XpzoeGeQq96qzF4tzo2VGU0
         rs3V2i5mrcTbGbzf3EjeeCMunSszYnYEM2SsIGexXUhEXcOk/Sv9wI8hmtWK5ByJCRJZ
         TS0sy/mv+1ybRq3EP1Q343WKlludO4LQq+pV+UdzMMqUjv2Fren1oEyc3wDKLP6jnBaL
         iYDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775865525; x=1776470325;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=213w54WPItuluzf2zJbkbNPQu8IYxwh/wCXaJ4qlVE8=;
        b=LY/m0YnujGq/FZLHGFsLLNTfzhJJV4arMnNDkTVjETdv2RZecIpcqOZ/13U10Qf9CP
         /LG2opwbo70ORL49IvAu9CwGPvbz9ETwvNlhcNQfWQRBF9VwZdAfgGfilA9Pu3TxiRpN
         phIEJ4FIvaycHsnSxWz5wDHdQoBBK9n/izlPzFgbktVSDvmxvPLBwZSZTvTLnTtrwsbG
         2PxdspI3CGFRZZFr6FJBfLaMmUrKwlPxyD1M7yqdUkQJMPS27SdTIOaVBtPmEBxIY15u
         vUsfdisFofM5wSaU2zx4ySlEpsvZOIX2+ZtSFA7wn3bI0eOhG2+zQbDjTnZWZ9R9sDI+
         /pcA==
X-Gm-Message-State: AOJu0YzNxcxzyWAw8kyCay7EK8dSFg/Dmat7Ru2hK3rb6Ap/788eXYPo
	ZwERkw3HnnEsA07O9ZaDi0YpW5bhatPp163LxhRHQ1Xr3enXUyeaIXVVVqwVvnH42dnbfqk6DVX
	Quj6cpw==
X-Received: from pgct9.prod.google.com ([2002:a05:6a02:5289:b0:c73:fc44:8ba7])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a20:e292:b0:39f:216:f400
 with SMTP id adf61e73a8af0-39fe3cd7666mr6101142637.14.1775865524420; Fri, 10
 Apr 2026 16:58:44 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Fri, 10 Apr 2026 16:58:23 -0700
In-Reply-To: <20260410235832.2312342-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260410235832.2312342-1-seanjc@google.com>
X-Mailer: git-send-email 2.53.0.1213.gd9a14994de-goog
Message-ID: <20260410235832.2312342-5-seanjc@google.com>
Subject: [GIT PULL] KVM: x86: Emulated MMIO changes for 7.1
From: Sean Christopherson <seanjc@google.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Sean Christopherson <seanjc@google.com>
Content-Type: text/plain; charset="UTF-8"

Emulated MMIO changes to fix a use-after-free (kernel stack) bug, and do a
spring cleaning of the code (though it could certainly use even more cleaning).

The following changes since commit 11439c4635edd669ae435eec308f4ab8a0804808:

  Linux 7.0-rc2 (2026-03-01 15:39:31 -0800)

are available in the Git repository at:

  https://github.com/kvm-x86/linux.git tags/kvm-x86-mmio-7.1

for you to fetch changes up to e2138c4a5be1e50d75281136bdc3e709cb07ec5e:

  KVM: x86: Add helpers to prepare kvm_run for userspace MMIO exit (2026-03-02 16:06:49 -0800)

----------------------------------------------------------------
KVM x86 emulated MMIO changes for 7.1

Copy single-chunk MMIO write values into a persistent (per-fragment) field to
fix use-after-free stack bugs due to KVM dereferencing a stack pointer after an
exit to userspace.

Clean up and comment the emulated MMIO code to try to make it easier to
maintain (not necessarily "easy", but "easier").

----------------------------------------------------------------
Sean Christopherson (14):
      KVM: x86: Use scratch field in MMIO fragment to hold small write values
      KVM: x86: Open code handling of completed MMIO reads in emulator_read_write()
      KVM: x86: Trace unsatisfied MMIO reads on a per-page basis
      KVM: x86: Use local MMIO fragment variable to clean up emulator_read_write()
      KVM: x86: Open code read vs. write userspace MMIO exits in emulator_read_write()
      KVM: x86: Move MMIO write tracing into vcpu_mmio_write()
      KVM: x86: Harden SEV-ES MMIO against on-stack use-after-free
      KVM: x86: Dedup kvm_sev_es_mmio_{read,write}()
      KVM: x86: Consolidate SEV-ES MMIO emulation into a single public API
      KVM: x86: Bury emulator read/write ops in emulator_{read,write}_emulated()
      KVM: x86: Fold emulator_write_phys() into write_emulate()
      KVM: x86: Rename .read_write_emulate() to .read_write_guest()
      KVM: x86: Don't panic the kernel if completing userspace I/O / MMIO goes sideways
      KVM: x86: Add helpers to prepare kvm_run for userspace MMIO exit

 arch/x86/include/asm/kvm_host.h |   3 -
 arch/x86/kvm/emulate.c          |  13 ++
 arch/x86/kvm/svm/sev.c          |  20 +--
 arch/x86/kvm/vmx/tdx.c          |  14 +-
 arch/x86/kvm/x86.c              | 287 ++++++++++++++++++----------------------
 arch/x86/kvm/x86.h              |  32 ++++-
 include/linux/kvm_host.h        |   3 +-
 7 files changed, 180 insertions(+), 192 deletions(-)
