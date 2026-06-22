Received: from mail-wm1-f74.google.com (mail-wm1-f74.google.com [209.85.128.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6792933F584
	for <kvm@vger.kernel.org>; Mon, 22 Jun 2026 18:49:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782154145; cv=none; b=DhuuX56h+di36uUiZohmRPq6vHiJIg35H2kQ2Gxv6yTiSG/DKP5WVXCIMIkmnlrvBDW9RRp3kN/nkzkiNhDLM38q4RPVal1+0bVLn4fpXKJG5nd4E3IVPL9yXWjCebJA/eNWPuxS/y0hSv77rU+QT1/0rjeB8Hf80g9dpfcBJlQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782154145; c=relaxed/simple;
	bh=DIjLzbnkRJ/pEuBgYb3z2HOVtgcinNlZvsdJq/Cs5OY=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=TRmUN02C/P/wLAdpXcwktsLW8bqTkDbSPMcEFf4dKzTmTkm/QLZa54+FzPOqmoIQRDDKYLHHm+20SVXkBpPtZ8CE4gx++nrwjTnmqpLDPOQRWxEvFH75BzPoWSQ4+Rj7cKbcZwWl5JURU/ri3NBEMQ2HsA98W/SCjZrMlkZsgic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--tarunsahu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=W0e2ekRr; arc=none smtp.client-ip=209.85.128.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--tarunsahu.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="W0e2ekRr"
Received: by mail-wm1-f74.google.com with SMTP id 5b1f17b1804b1-49221de4ed4so30527575e9.0
        for <kvm@vger.kernel.org>; Mon, 22 Jun 2026 11:49:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1782154141; x=1782758941; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=OEWwFi6TggeUgPIb5O1s/aY8eVgW9dSMubR6vHRGBr0=;
        b=W0e2ekRrwJxi0Xb5VaP5CAjCcgPLqZwKTkBd2/qYqZ7JjbhH/EW/M7ryasr1Uqaj4I
         TIzGIW+8qLLdxkwZfpdq5CNYnMzTP3yB4HtkWpiAn9Bkt6Rl5yRjUp6YJcM9QPqRFrp5
         kwQ8PTJ22hHI70ol1GijCnlPHw5bPb25GI9gXTuVb+345yFNjQokT8nvuRqcmq72Y6Dm
         +biy1vFWJopfzCOfhmjxIv09IMKT2p7xXgnZCDuv5MKJrda3Kj19MHFSh0tb3WpowIfD
         3qpwSvhB97GUxPW6suSXffJZ8/qY4KBR2hcXsoKaIaSxNt2BJ19nICVk98GPpIb1xu+r
         EVUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782154141; x=1782758941;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=OEWwFi6TggeUgPIb5O1s/aY8eVgW9dSMubR6vHRGBr0=;
        b=RtzNM4jdPILXbK6qtG4/CECCgF8Jj63WStGI6E/Of0O5uErvD2kZqGUhHUN2vhjupg
         2Ik2fPVreDECni7MksRxeXr8j/i3BMjTGx4KGUgxLDxYI+2/eZlccAnpku9qbckfLw9i
         rDEmQM1XRVZqoCfjdgg8Xxh94z2ZpL6VwcE77ACN7Cw8y+WknK+Slcjknu9PbhuPqFh1
         U3q6WZXw85ZcZr0WidS5QeZcVw5e0SMAhA8zq0LQDLdS402nV4aN2neXx2/JlJWABFcv
         AIbcXDDeJZTFAE2nH42LgfWWDjrhUcO0nkzKqSTzAurh2Xoimq6xWkZwJfk9QEIfMkAP
         qLFw==
X-Gm-Message-State: AOJu0YwnEYzMYlkuqTYemVaE05P2MkVIbP4JXkM2hpzd0h7H4GtCPido
	+SkuRcWyLIGrSDrSlpCF0qrxI7/YTDjo+56sd3tiJqMNM6jyHU3LMaN3KE/VtbKKb6P2Z/nYom3
	9iA8F7Y4CB23sWP1RwQ==
X-Received: from wmnj21.prod.google.com ([2002:a05:600c:755:b0:492:4a9f:3d5a])
 (user=tarunsahu job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:c059:10b0:490:bb45:79da with SMTP id 5b1f17b1804b1-49240e427f0mr195668185e9.13.1782154140754;
 Mon, 22 Jun 2026 11:49:00 -0700 (PDT)
Date: Mon, 22 Jun 2026 18:48:42 +0000
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.55.0.rc0.786.g65d90a0328-goog
Message-ID: <20260622184851.2309827-1-tarunsahu@google.com>
Subject: [PATCH v3 0/9] liveupdate: kvm: guest_memfd preservation
From: Tarun Sahu <tarunsahu@google.com>
To: Jonathan Corbet <corbet@lwn.net>, Mike Rapoport <rppt@kernel.org>, Paolo Bonzini <pbonzini@redhat.com>, 
	Alexander Graf <graf@amazon.com>, Shuah Khan <skhan@linuxfoundation.org>, 
	Pratyush Yadav <pratyush@kernel.org>, Tarun Sahu <tarunsahu@google.com>, 
	Pasha Tatashin <pasha.tatashin@soleen.com>
Cc: kvm@vger.kernel.org, linux-mm@kvack.org, kexec@lists.infradead.org, 
	linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hello,
This is Non-RFC patch series for guest_memfd preservation. After
having multiple discussion across hypervisor liveupdate meeting,
guest_memfd bi-weekly meeting, the design for the basic support of
guest_memfd preservation is final. This series is going to include
guest_memfd which are fully shared and does not support private mem
and backed by PAGE_SIZE pages.

Steps to test:
1. Compile Kernel with CONFIG_LIVEUPDATE_GUEST_MEMFD=y
2. boot kernel with command line: kho=on liveupdate=on
3. run the following kselftest
	$ .selftests/kvm/guest_memfd_preservation_test --stage 1
	$ <kexec> --reuse-cmdline
	$ .selftests/kvm/guest_memfd_preservation_test --stage 2

NOTE: Assert the following:
	$ ls /dev/liveupdate
	$ ls /dev/kvm
	$ dmesg | grep liveupdate # (should have kvm_vm_luo &&
		# guest_memfd_luo handler registered)

The changes are rebased on:
	kvm/next + liveupdate/next (merge) + [3] + [4] + [5]
	Where,
	[3]: luo: conversion of serialized_data to KHOSER_PTR
	[4]: luo: APIs to retrieve file internally from session
	[5]: selftests: liveupdate sefltests library
Here is the github repo:
	https://github.com/tar-unix/linux/tree/gmem-pre

V3 <- RFC V2 [2]
1. Finalize the design
2. resolve sashiko reported bugs
3. Use of KHOSER_PTR instead of raw serialized_data as per [3]

RFC V2 [2] <- RFC V1 [1]
1. Removed mem_attr_array as it is not needed for fully-shared
2. Removed pre-faulted condition
3. Added vm_type preservation for ARM64.
4. Removed liveupdate_get_file_incoming api patch as it is sent
   separately [4] by Samiullah.

[1] https://lore.kernel.org/all/cover.1779080766.git.tarunsahu@google.com/
[2] https://lore.kernel.org/all/c054ba0fb2639932bbe354420d3f4f84cce84905.1780676742.git.tarunsahu@google.com/
[3] https://lore.kernel.org/all/20260622111215.4157974-1-tarunsahu@google.com/
[4] https://lore.kernel.org/all/20260613012521.835490-1-skhawaja@google.com/
[5] https://lore.kernel.org/all/20260612214512.464146-1-vipinsh@google.com/

Tarun Sahu (9):
  liveupdate: Add LIVEUPDATE_GUEST_MEMFD config option
  kvm: Prepare core VM structs and helpers for LUO support
  kvm: kvm_luo: Allow kvm preservation with LUO
  kvm: guest_memfd: Move internal definitions and helper to new header
  kvm: guest_memfd: Add support for freezing and unfreezing mappings
  kvm: guest_memfd_luo: add support for guest_memfd preservation
  docs: add documentation for guest_memfd preservation via LUO
  selftests: kvm: Split ____vm_create() to expose init helpers
  selftests: kvm: Add guest_memfd_preservation_test

 Documentation/core-api/liveupdate.rst         |   1 +
 Documentation/liveupdate/vmm.rst              | 107 ++++
 MAINTAINERS                                   |  14 +
 include/linux/kho/abi/kvm.h                   | 106 ++++
 include/linux/kvm_host.h                      |  14 +
 kernel/liveupdate/Kconfig                     |  15 +
 tools/testing/selftests/kvm/Makefile.kvm      |   6 +-
 .../kvm/guest_memfd_preservation_test.c       | 236 +++++++++
 .../testing/selftests/kvm/include/kvm_util.h  |   2 +
 tools/testing/selftests/kvm/lib/kvm_util.c    |  26 +-
 virt/kvm/Makefile.kvm                         |   1 +
 virt/kvm/guest_memfd.c                        | 185 +++++--
 virt/kvm/guest_memfd.h                        |  44 ++
 virt/kvm/guest_memfd_luo.c                    | 497 ++++++++++++++++++
 virt/kvm/kvm_luo.c                            | 195 +++++++
 virt/kvm/kvm_main.c                           |  94 +++-
 virt/kvm/kvm_mm.h                             |  15 +
 17 files changed, 1477 insertions(+), 81 deletions(-)
 create mode 100644 Documentation/liveupdate/vmm.rst
 create mode 100644 include/linux/kho/abi/kvm.h
 create mode 100644 tools/testing/selftests/kvm/guest_memfd_preservation_test.c
 create mode 100644 virt/kvm/guest_memfd.h
 create mode 100644 virt/kvm/guest_memfd_luo.c
 create mode 100644 virt/kvm/kvm_luo.c

-- 
2.55.0.rc0.786.g65d90a0328-goog

