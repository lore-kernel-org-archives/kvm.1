Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8D39347BB5
	for <kvm@vger.kernel.org>; Sat, 23 May 2026 11:14:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779534891; cv=none; b=tTvvZVAC6PJe/z5+LDw5HkqP65HeHIhu/OXpbxVJOeKFtCZ3byQU7Mt20fH/A2YrVlhzVKXkNz7ZO3SZFVw8ERW43/ZPOQSXLbmwCprWDHpPuxG3ehVbpMtykaz93ofMFyFuFVc/ckPcUi4cwMG4ook/d+Vxey5MXNNXBH872oA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779534891; c=relaxed/simple;
	bh=PR3aUgrOUSwgsoRPWMaQivlgNWHw0bj7T8P7AJwNGPA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=OeBH85cY800TweQ04pwciWcMmeXzMWDytlNNSFqxcsMY2cDe64UPebyLLVwUZXmxpgJQe5UopjzUQGW29S5LePAX2m97FfRW9jCT6hHL4jqXbV7CR1uhMdQv+moPGTPkmc1NmmIsJcg6yoHpxzXDC/N51/BoyAuSsKb2cRFtfDw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Lq9RcE90; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Lq9RcE90"
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-82f8b60e485so3453813b3a.0
        for <kvm@vger.kernel.org>; Sat, 23 May 2026 04:14:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779534888; x=1780139688; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=NaXtD7iMykhT9quBtXIhBa6cc/VFPDrkai+sBLm7a98=;
        b=Lq9RcE901T1IP3NFCfvxX6RQZTZ+wVIj93gQfPOtl7WotSWvn5MWDnZ+KVpZTvz8V3
         aZwY4cCJ9sRGqoApvFGoec9ExssAasSRmMLACC9I4NIMISkE9cY2oDWvauhN6nLwdnhi
         l+epePr3Ic7Dq80HEZXjt4mjuxmSHcJ5Th74Cicl/5Z//wSEV7lQ6LJtTo6gXARsC/rS
         xNh6Oqlzhfv6MeUeN28N1TOQ9/J9edUuve/ArKctNUTxSfKdDI2xvi91NKvI6OwQuDcW
         imB1OgZXoUM5jmvPlJEqCiITCY/Df/rHUB0QN9oLSxdYGe9fulQby5/lURcLDcnhohvp
         c6rA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779534888; x=1780139688;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NaXtD7iMykhT9quBtXIhBa6cc/VFPDrkai+sBLm7a98=;
        b=HzJUAcE2Ximyvmdt/nMMs0RFdbsGHX8jT3UHo8XXLmNMx6+y8EQEH0E/RBt+n+9GQr
         V9AK1DsNhjsVst7n5vxnAYG6F80aHmusvxdduU9MvnS9tLbmHyLrLjl5QIKopE2JkIhM
         9P0hxuwSdEnV2/sPR9qrt1n5fl1rVPUCETBk5WIy16/JaJDIaeCZG/LJQLQCBfvilvcK
         LMpAlocYbU/P/ZXVnVtDv3hB++tcqVzMno885XHMp/amNakJz0i7iLCnRBNdDz3JTEZN
         sBS/uxYmVp53SvJxtyINDqle1vdunQbOkf2dxUByPaA7q/b4SXIoQuLG5aXJwLrRQ75s
         VzRQ==
X-Gm-Message-State: AOJu0YwoDoKGfZ4sCyGZPBSNUR1bJPJuMgRzKc373D5fBOmNMvoUErtn
	WE7HyrjIgioQL71ogq34aNGGsreI6hdbaELPbblEmwJ3bXawZPxkNsftX2mG3A==
X-Gm-Gg: Acq92OHROGf4n0YeCG8NnMalvKxnBiWtk77ORr4v2reCWNZqFU+d7A6/Ctpf76Z0HQ3
	sELbOJptrKg9BW3rdbGotahxKxXAIwmMguFppiof9rqJlp/UqBc7fVv2KR/xW87jPDiuNH2P4HM
	wxhEDSqjUFbeyKUrEDDNkls+oShFMPYIAcx1qnwYoFTdukoFyW/uWfGlgWp9u/d7LTR6as/2RHE
	n0mQq38/P+HJc5bQJcl4k7uk4vdLgWwpb3kVIVueAWu3pVhnhb1HmfF+bRxxXTQVrDGgCIK8v17
	mVnuVS5PyiCnrTk5/ktF7N+NxN1WCJw6jAPFeWnLDJrWgAB3yPSmDd0Mt3LT4TVCcg6ugKHgr1R
	CAFCqgIRQrkQ1xWJkE5MoyFIAvJbTLyzGHsdd0EF5Ze73szhLi+l5/P/gedaZFsrCUwK7cwmoSJ
	+NUMhH+BVzJvOVw3IUljet8SkXkyCT20XlVQx02vBSUQQNCAMOiw==
X-Received: by 2002:a05:6a00:1312:b0:83e:eeab:aff8 with SMTP id d2e1a72fcca58-8415f306c6bmr7193042b3a.25.1779534887953;
        Sat, 23 May 2026 04:14:47 -0700 (PDT)
Received: from Mac.ibm.com ([49.205.216.49])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84164ac9c77sm5249140b3a.2.2026.05.23.04.14.42
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sat, 23 May 2026 04:14:47 -0700 (PDT)
From: "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
To: kvm@vger.kernel.org
Cc: linuxppc-dev@lists.ozlabs.org,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Harsh Prateek Bora <harshpb@linux.ibm.com>,
	Christophe Leroy <chleroy@kernel.org>,
	Venkat Rao Bagalkote <venkat88@linux.ibm.com>,
	Nicholas Piggin <npiggin@gmail.com>,
	Misbah Anjum N <misanjum@linux.ibm.com>,
	Anushree Mathur <anushree.mathur@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	linux-kernel@vger.kernel.org,
	"Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
Subject: [RFC v2 0/5] KVM: selftests: add powerpc support
Date: Sat, 23 May 2026 16:44:19 +0530
Message-ID: <cover.1779524962.git.ritesh.list@gmail.com>
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
the latest upstream tree. Since the rebase required few changes to all the four
patches (Patch 1-4), I have dropped the earlier Acked-by from Michael Ellerman.

Since the last series was posted three years ago [1], I am resetting the version
to RFC. This rebase was done as part of a larger effort to improve the selftests
infrastructure for Linux on PowerPC tree. Thanks to Harsh and Maddy for their
help on this.


Testing Updates:
================
1. Tested this on PowerNV P9 with Radix mode. (all selftests passes)
2. Tested this on LPAR (KVM on PowerVM) case. (all selftests except-1 passes).
   The failed testcase (kvm_create_max_vcpus) is because H_GUEST_CREATE_VCPU
   (PAPR HCALL) only supports vcpu_ids 0-2047 i.e. max 2048 vcpus.
   However, kernel always returns NR_CPUS for the KVM_CAP_MAX_VCPUS extension.
   So if the LPAR kernel is built using NR_CPUS=8192, then kvm_create_max_vcpus
   can fail in __vm_vcpu_add(). This failure needs to be handled seperately,
   mostly as fix in kernel.
3. Tested these selftests changes inside x86 kvm guest  - no new failures seen.


RFC v1 -> RFC v2
================
(mostly Sashiko review comments)
1. Fixed x86's stage-2 mmu handling in patch-1 - commit msg has more description
2. Added "cc" into the clobber list for hcalls in patch-3
3. Fixed the size calculation in kvm_arch_vm_post_create in patch-3 for
   allocating 2 pages for 4K pagesize
4. Added patch-5 which prints vcpu_id in case of an error

[RFCv1]: https://lore.kernel.org/linuxppc-dev/cover.1778857539.git.ritesh.list@gmail.com/
[1]: https://lore.kernel.org/all/20231120122920.293076-1-npiggin@gmail.com/

Nicholas Piggin (4):
  KVM: selftests: Move pgd_created check into virt_pgd_alloc
  KVM: selftests: Add aligned guest physical page allocator
  KVM: PPC: selftests: add support for powerpc
  KVM: PPC: selftests: powerpc enable kvm_create_max_vcpus test

Ritesh Harjani (IBM) (1):
  KVM: selftests: Print the vcpu_id when KVM_CREATE_VCPU ioctl fails

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
 tools/testing/selftests/kvm/lib/kvm_util.c    |  44 +-
 .../selftests/kvm/lib/loongarch/processor.c   |   4 -
 .../selftests/kvm/lib/powerpc/handlers.S      |  93 ++++
 .../testing/selftests/kvm/lib/powerpc/hcall.c |  45 ++
 .../selftests/kvm/lib/powerpc/processor.c     | 484 ++++++++++++++++++
 .../testing/selftests/kvm/lib/powerpc/ucall.c |  22 +
 .../selftests/kvm/lib/riscv/processor.c       |   4 -
 .../selftests/kvm/lib/s390/processor.c        |   4 -
 20 files changed, 872 insertions(+), 39 deletions(-)
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

