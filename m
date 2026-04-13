Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com [209.85.215.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F981355F44
	for <kvm@vger.kernel.org>; Mon, 13 Apr 2026 20:46:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776113198; cv=none; b=UdvdY1UITHbu5Wh+3W7FrJPAePclw+UUtPbG0yxoLx2BMqxitpWCuCUFMzKNIsdYozi3+MhaAmgcIO6FSxU0UeQzCPtLNbJITfRU2PayYGUejMFEGEIqf6ag5GeQbE52DktXX+q1e31Od6sqQ1a0GSiG4hpE2jKpsKtBWZN1Boc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776113198; c=relaxed/simple;
	bh=uprHKwXObO+AE6bDi/TNr7PFtVJVYS3qu7Pa4B009Uk=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=l7x7Tr36mv0UvtfFGYpaZhMz2sol/9Gz3D6LZW3iAjJKbOlta0R7hLvbg7xBRFSjsAsrRw1QOz/0z25LO4RoB3Q0vmdNsGCo0ilGm9Oj12I+qJmU+1tRRnru0gMYDwhVq7OsF8Z894S9kWmeRNXssWNXyjBB1VtFl5Ga7Ple9fg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jingzhangos.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=AYm92YZp; arc=none smtp.client-ip=209.85.215.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jingzhangos.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="AYm92YZp"
Received: by mail-pg1-f201.google.com with SMTP id 41be03b00d2f7-c76c6280732so5459933a12.0
        for <kvm@vger.kernel.org>; Mon, 13 Apr 2026 13:46:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1776113196; x=1776717996; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=I7eiz8y/l7lCP2hNqNsnkSrKMhwpC7fnrESdccwzjeo=;
        b=AYm92YZprp0peNBd1evXYeYVvBplp/092zxzexTdziwIcGAUH/WzmSz6/j+mlmPxUO
         XqmMJsef86uCS0RkvIhfzOPrJuESq7dpVROgME0NAQwuEHHuj/GbZY+kvF8Jz1L0RFfS
         wXZNJ6a0FU/GxT41nGx7fsWS/WwmGOtXhfHF2J3HDI14IqEw1ULmb+0CXM3l+GMDsBGK
         9yhHyhdDqA/1ZMRsMk+Qo7O+hA3vX+nhYaOE1DoCsfeHDAZfX1ogFhWzz38vIGCVPXfc
         khkE1Wh9bKzrbxb8p9c5yft/SXy2DOf3FgREMQYeLq2pCvrt+LzXS1VgrijleXEDjEoR
         QYSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776113196; x=1776717996;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=I7eiz8y/l7lCP2hNqNsnkSrKMhwpC7fnrESdccwzjeo=;
        b=bK0g7Xd77MaxhkTbb/6b13yI0weRbBz9D9K4/fiB0GkqDki/cGDwgvdGQ2bja7dZR1
         ihpuNLfTltTgWVv/GthEBJcrlcn2tIK6q1xVPo/+qQAQGA5TcocAxEW6naE+R2i0VaP/
         KWXo2h9wK+O18mg8XQL0/FLIM1QXelmwZpbni/IaY2IJOK5oiLrx7hMEIMQ8bWlAHker
         eUz3f+GwSoewYThbUZO8LdsxRnp1ya+GnBFq4o5zs8WZctfuJIzg7TpcOw3ylca2pATu
         njWQCcU+ZDHInTWW0Tps5o5ZUCxL//6zwUS1eco3yg10aL+/Xkq5gqXYAJtMZNucxhmw
         iYNQ==
X-Gm-Message-State: AOJu0Yxrf1Kbhpe8TUUhwnyhIb6RmdcE8igvN+xESnLn2TJrwUp5ESi0
	p4ZTOiyhTyRFjjMFJ0/9SWLsbZ9QQiKiujZ+DSv8y6aNc3j25tFMx0MxVOZOyMqMtbuzUQh4oAO
	rz7GVcTrvmjmU0LL+Lmwwl5zJ70xRmQDCbNfQvApEUbVRyUwC0eXtL7IgmkPkD8zSbdvI5PziNR
	jqQ0u5vlXihH3UA5r8aBNnwQ8UR7oFNaOjqxJYeyYfwEOFJlqFMsUUHoTSujo=
X-Received: from pfbfb22.prod.google.com ([2002:a05:6a00:2d96:b0:827:1713:6de8])
 (user=jingzhangos job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a00:1a8e:b0:82f:3828:a00a with SMTP id d2e1a72fcca58-82f3828b18dmr6883092b3a.41.1776113195294;
 Mon, 13 Apr 2026 13:46:35 -0700 (PDT)
Date: Mon, 13 Apr 2026 13:46:23 -0700
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.54.0.rc0.605.g598a273b03-goog
Message-ID: <20260413204630.1149038-1-jingzhangos@google.com>
Subject: [kvm-unit-tests PATCH v2 0/7] arm64: Add Stage-2 MMU and Nested Guest Framework
From: Jing Zhang <jingzhangos@google.com>
To: KVM <kvm@vger.kernel.org>, KVMARM <kvmarm@lists.linux.dev>, 
	Marc Zyngier <maz@kernel.org>, Joey Gouly <joey.gouly@arm.com>, 
	Wei-Lin Chang <weilin.chang@arm.com>, Yao Yuan <yaoyuan@linux.alibaba.com>
Cc: Oliver Upton <oliver.upton@linux.dev>, Andrew Jones <andrew.jones@linux.dev>, 
	Alexandru Elisei <alexandru.elisei@arm.com>, Mingwei Zhang <mizhang@google.com>, 
	Raghavendra Rao Ananta <rananta@google.com>, Colton Lewis <coltonlewis@google.com>, 
	Jing Zhang <jingzhangos@google.com>
Content-Type: text/plain; charset="UTF-8"

This patch series introduces a lightweight infrastructure for managing ARM64
Stage-2 translation tables and executing nested guests. These components are
essential for testing advanced virtualization features such as nested
virtualization (NV) and GICv4 direct interrupt injection.

The series provides a generic Stage-2 MMU library supporting multiple
translation granules (4K, 16K, 64K) and dynamic page table management.
Building on this, it adds a guest execution framework that handles guest
lifecycle management, context switching and guest exit routing. A new test
case for Stage-2 MMU demand paging to verify fault handling.

Please note that this is a very preliminary implementation intended as a
startup baseline for future work in virtualization testing. Users should be
aware that because this is an early-stage baseline, some portions of the code
may just happen to work in its current state. There might be critical
architectural elements or edge-case handling missing that will need to be
addressed as the framework matures.

---

* v1 -> v2
  - Used generated `struct guest` offset instead of hardcoding.
  - Cleaned up register definitions.
  - Refined EL1/EL2 exception vector tables.
  - Split monolithic patches into a series of granular commits.
  - Addressed other review feedbacks.

[1] https://lore.kernel.org/kvmarm/20260316224349.2360482-1-jingzhangos@google.com/

---

Jing Zhang (7):
  lib: arm64: Generalize ESR exception class definitions for EL2 support
  lib: arm64: Add stage2 page table management library
  lib: arm64: Generalize exception vector definitions for EL2 support
  lib: arm64: Add foundational guest execution framework
  lib: arm64: Add support for guest exit exception handling
  lib: arm64: Add guest-internal exception handling (EL1)
  arm64: Add Stage-2 MMU demand paging test

 arm/Makefile.arm64         |   4 +
 arm/debug.c                |   6 +-
 arm/gic.c                  |   2 +-
 arm/micro-bench.c          |   4 +-
 arm/mte.c                  |   6 +-
 arm/pl031.c                |   2 +-
 arm/pmu.c                  |   2 +-
 arm/psci.c                 |   2 +-
 arm/selftest.c             |   6 +-
 arm/stage2-mmu-test.c      | 107 ++++++++++
 arm/timer.c                |   6 +-
 lib/arm64/asm-offsets.c    |  15 ++
 lib/arm64/asm/esr.h        |   5 +-
 lib/arm64/asm/guest.h      |  91 +++++++++
 lib/arm64/asm/processor.h  |  32 +--
 lib/arm64/asm/stage2_mmu.h |  70 +++++++
 lib/arm64/asm/sysreg.h     |   7 +
 lib/arm64/guest.c          | 158 +++++++++++++++
 lib/arm64/guest_arch.S     | 248 +++++++++++++++++++++++
 lib/arm64/processor.c      |  18 +-
 lib/arm64/stage2_mmu.c     | 403 +++++++++++++++++++++++++++++++++++++
 21 files changed, 1149 insertions(+), 45 deletions(-)
 create mode 100644 arm/stage2-mmu-test.c
 create mode 100644 lib/arm64/asm/guest.h
 create mode 100644 lib/arm64/asm/stage2_mmu.h
 create mode 100644 lib/arm64/guest.c
 create mode 100644 lib/arm64/guest_arch.S
 create mode 100644 lib/arm64/stage2_mmu.c


base-commit: 86e53277ac80dabb04f4fa5fa6a6cc7649392bdc
-- 
2.53.0.1213.gd9a14994de-goog

