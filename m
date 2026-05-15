Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 427713B9D91
	for <kvm@vger.kernel.org>; Fri, 15 May 2026 16:04:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778861078; cv=none; b=ne1O9M09DPaIsTXtgWEapAtmOcFLhg+Ge4Tws+Wi8euMwUIc3wim9LAssqoS6Df8+bvYpnOSXA546d+/pHcYcFGx9VbqCJ2DSlX4smkm9tNKNcy9YNT3Q712E+KuZoyx+xsmLNV1EiVz4lHU+TWRxSasnwcsAyuNBUjY5Rh5IME=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778861078; c=relaxed/simple;
	bh=XuTrRDvrnk8Ldg/oQtb12wfpR2eLMMfOCt8Up/BW7MU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=jjV2H6XALCbY6fNvOLKE7mDgoYUqRY/WOs7ZW5uaoUl/pfssK/nTG5Q5ye8iauz6q1OGeMNtQf91a1OQN/Zebm7vJHNQz1KloD6EH7prb4An0kG2uyQuEOGQjPhAy4t27CEOg3/Yz3ENCLPtNSawdf/wDOtxTeYKJhDX4y+kPzg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LDN/wzT9; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LDN/wzT9"
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-83659d38e38so4098368b3a.1
        for <kvm@vger.kernel.org>; Fri, 15 May 2026 09:04:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778861076; x=1779465876; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=/qI88RwCNnWnFb4fjGmxbgcnIrnRtogWwTEfP7LNxqs=;
        b=LDN/wzT9hkBt86psm09v+qhZdhk/0I2kmGlzqN9bQfP+tX8eTc+2wNIUIytd/Ph7ei
         254CZHyvHOLu1uEG4kFarisXfSm6y2lmyOEAw35W5OG0v2EuA7YHPqGstSmqTqqrCEIb
         BhnGqR2I1fMzXSSTmJbVKXRATGmhS/R2hqH2br8Lb2SVkWA4hoQaa5Lw2P1c7qjfZMXu
         2E9tfhwoZcUYEv+qvdh1e9YDda4M6ggyVGCrU9tVQbfSWJqz9mLA+i2XM6nnHtOnY4UP
         CFfvE0Wq5YscCL6zeFq0DWeIvaGDHVeTqCSLMlBsJvpjVY+BDE/L0qq/QEVe7csW+weL
         dFkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778861076; x=1779465876;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/qI88RwCNnWnFb4fjGmxbgcnIrnRtogWwTEfP7LNxqs=;
        b=EDZEJQf221mSYZ/tFc2duTEV3LLe2hEcMOEffrEuFH8KZ0ZKfAGgovv8RebSDsl3uv
         H4E4JADwNa+drS1kOAc1uTr3AMMVscbXrlGPma9yjmyw4HwyjkEmZJ1IzZzYIKW8UdFa
         ohfC71ECGtyr08tgJ9qDYtBfOALfVJVlbUQl0TxLf9MFOeQznbdv8c5Kn6ZRzf67K/94
         k9gSkfQDadSg2th8CaL8lGvG5/N95+O+rrx5t0lBtb4kdkA34nwr5Agkz8heV5JGqNAG
         niywnH9XS6fYSlbYyin1b9RcthfyUmVkwromjlDU2OaD3vE8miODO5QUHojsF7IjHAOl
         9NHA==
X-Gm-Message-State: AOJu0YxbjDrkJvCIq9ofuMmujkUnW1q2C0yHpu7WBUSy/PC2SnLXBMHn
	vEYuM4AJXa5WS+F1XwFXDumLOK4T0lrcc4riWFUAsUn9D4aaEBLHu3WLIWQ2KKf8
X-Gm-Gg: Acq92OEcss68HI8boBJKojEVgDWGgfo/tfko7wGq0YlnzabdTKzY9U7AF36QjsvBQvb
	gwyLH5vCjMhtrBxQyjDpqCUsEy3cKGw9v+mPsVJ/jIABNtplY/jQJTNNd9QQLvI4NHqcXfUBU4h
	2tpftE70uAcX/6BTZDhy0ROkOXSw7nWYPGcamGuTJC0gAMTEVeWXHscr+g36Bld1nQ+SqXk75Ko
	RKPXYl5+9nMeWacBmXWzhplyAI58SlJG+TXifBnvRk08u5jrwgoefSWf5PiYFuqSSLMNax2+M7Q
	GknYpiJBviP8mbhoyDON6tHlOGMczQ1qdWFpcFsSC+kRBQOo1nejALsjDVA2kx71ysIar7Ax1n7
	yhEklmpM9vyDkIAc/Rmb6Pwx7zFLxEDvbORkUf7NXSyhSiMhYWySOjokFIt0ViNPurOmCV2Lkxc
	f+19MsdwAdz1UcNCxW08uAXpwTtukBiui+48Y9o5AzwdVRzczG5U7nRHq+ZP8jgoQ=
X-Received: by 2002:a05:6a00:cd4:b0:82f:b0:28f0 with SMTP id d2e1a72fcca58-83f33cbc0fcmr5625295b3a.34.1778861075925;
        Fri, 15 May 2026 09:04:35 -0700 (PDT)
Received: from localhost.localdomain ([171.76.86.174])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-83f19c7c74fsm7920262b3a.49.2026.05.15.09.04.32
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 15 May 2026 09:04:35 -0700 (PDT)
From: "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
To: kvm@vger.kernel.org
Cc: linuxppc-dev@lists.ozlabs.org,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Harsh Prateek Bora <harshpb@linux.ibm.com>,
	Christophe Leroy <chleroy@kernel.org>,
	Venkat Rao Bagalkote <venkat88@linux.ibm.com>,
	Nicholas Piggin <npiggin@gmail.com>,
	linux-kernel@vger.kernel.org,
	"Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
Subject: [RFC 0/4] KVM: selftests: add powerpc support
Date: Fri, 15 May 2026 21:34:19 +0530
Message-ID: <cover.1778857539.git.ritesh.list@gmail.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi All,

This series primarly adds KVM selftests support for powerpc (64-bit, BookS,
radix MMU).

This patch series is originally Nick's work. I have mainly only rebased it on
the latest upstream tree. Since the rebase required few changes to all four
patches, I have dropped the earlier Acked-by from Michael Ellerman.

Since the last series was posted three years ago [1], I am resetting the
version to RFC and posting an early version (few tests still pending) for
getting any early review comments. BTW, I ran this on P9 (PowerNV) with radix
and haven't found any regressions so far. 

Note that I am planning to run this selftests with different configurations as
well on PowerPC and will share the test results soon. This rebase was done as
part of a larger effort to improve the selftests infrastructure for Linux on
PowerPC tree. Thanks to Harsh and Maddy for their help on this.
 
[1]: https://lore.kernel.org/all/20231120122920.293076-1-npiggin@gmail.com/

Nicholas Piggin (4):
  KVM: selftests: Move pgd_created check into virt_pgd_alloc
  KVM: selftests: Add aligned guest physical page allocator
  KVM: PPC: selftests: add support for powerpc
  KVM: PPC: selftests: powerpc enable kvm_create_max_vcpus test

 MAINTAINERS                                   |   2 +
 tools/testing/selftests/kvm/Makefile          |   2 +-
 tools/testing/selftests/kvm/Makefile.kvm      |  10 +
 .../testing/selftests/kvm/include/kvm_util.h  |  34 +-
 .../selftests/kvm/include/powerpc/hcall.h     |  17 +
 .../kvm/include/powerpc/kvm_util_arch.h       |  22 +
 .../selftests/kvm/include/powerpc/ppc_asm.h   |  32 ++
 .../selftests/kvm/include/powerpc/processor.h |  38 ++
 .../selftests/kvm/include/powerpc/ucall.h     |  21 +
 .../selftests/kvm/kvm_create_max_vcpus.c      |   9 +
 .../selftests/kvm/lib/arm64/processor.c       |   4 -
 tools/testing/selftests/kvm/lib/guest_modes.c |  20 +-
 tools/testing/selftests/kvm/lib/kvm_util.c    |  41 +-
 .../selftests/kvm/lib/loongarch/processor.c   |   4 -
 .../selftests/kvm/lib/powerpc/handlers.S      |  93 ++++
 .../testing/selftests/kvm/lib/powerpc/hcall.c |  45 ++
 .../selftests/kvm/lib/powerpc/processor.c     | 481 ++++++++++++++++++
 .../testing/selftests/kvm/lib/powerpc/ucall.c |  22 +
 .../selftests/kvm/lib/riscv/processor.c       |   4 -
 .../selftests/kvm/lib/s390/processor.c        |   4 -
 .../testing/selftests/kvm/lib/x86/processor.c |   9 +-
 21 files changed, 869 insertions(+), 45 deletions(-)
 create mode 100644 tools/testing/selftests/kvm/include/powerpc/hcall.h
 create mode 100644 tools/testing/selftests/kvm/include/powerpc/kvm_util_arch.h
 create mode 100644 tools/testing/selftests/kvm/include/powerpc/ppc_asm.h
 create mode 100644 tools/testing/selftests/kvm/include/powerpc/processor.h
 create mode 100644 tools/testing/selftests/kvm/include/powerpc/ucall.h
 create mode 100644 tools/testing/selftests/kvm/lib/powerpc/handlers.S
 create mode 100644 tools/testing/selftests/kvm/lib/powerpc/hcall.c
 create mode 100644 tools/testing/selftests/kvm/lib/powerpc/processor.c
 create mode 100644 tools/testing/selftests/kvm/lib/powerpc/ucall.c

--
2.39.5

