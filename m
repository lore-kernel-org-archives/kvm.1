Received: from mail-dl1-f48.google.com (mail-dl1-f48.google.com [74.125.82.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68D61241695
	for <kvm@vger.kernel.org>; Tue,  6 Oct 2026 10:29:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791282585; cv=none; b=XGtctkV8HHjXxKue1AC/mzdIoTO3UOfnpvSPTRyewoT4nKyhHVtIUbiFpBaxFcHRlPERGMqawuOsw/B8VebZFFUpL3saggmsUrmCJds+lWgbjI2TIqY1vlvtV8mI/tR5J4EVkFsxNPPCZc8amrgsH3Xul9ap/30DKksrN/QrAMc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791282585; c=relaxed/simple;
	bh=ksFLCcuv6cLlI8/Pp3Sn4sZLXXzFXHsqqr3tWb5XSsU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=EnWkHT+A9Mr9Hhz8COcRu0aH47Ct9ikHCND4SEj8zH7M5xtTeINQ9cJSMIJqfg1mQ4/jdFkL6dACoebkfsnbH9jESqhP6XCA3oX5ueKNspliOYS8JZz4+CRmL87VcKobU2H+YFaNTyeQEmc6y5MWLzYV/BIGZfloCt2novJzI9w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gmxvxY6z; arc=none smtp.client-ip=74.125.82.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gmxvxY6z"
Received: by mail-dl1-f48.google.com with SMTP id a92af1059eb24-15354aa70e8so6940353c88.1
        for <kvm@vger.kernel.org>; Tue, 06 Oct 2026 03:29:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791282583; x=1791887383; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=05GXKUT/YWkG/6TjV8sM9LD7ngJ6Vk2E269NPbqlb5Q=;
        b=gmxvxY6zTBgu/Chs60AJUff7f2ci+ppxzx6+2ner5jxnFrEnaMRuDkxsD/xkF57Zf2
         2k/thaUR51BmnvuOnh2WUcXc/itd0+weTP0FIyDhwHooTnwTKKE9iL7lRPLBWMty/6Cv
         bQYMiiINuF8ZYNr78D5aZ8kfZkJCG9siqqRPc1fuH5e272FfmKvG4qfmZvYz51WMZ7E9
         mwQc/k2HuYrWZeP/f00t2RtnjLGNXrky1G5631P5vsWQ6sv4xMDI4TLMaZ36YGStRLOd
         p8z/LfX28G1p2d+C3597NcRUJhGeUFUcGHCp649o+V3BRR+21d3Av7S3OAA1OQsM/Ku6
         /oWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791282583; x=1791887383;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=05GXKUT/YWkG/6TjV8sM9LD7ngJ6Vk2E269NPbqlb5Q=;
        b=PoNsDn8c6kvh2Y9MEFJfNwjNF3BlRNZwWrs//KratFg3kOLrD/NTbcm/lezgxGZUQT
         TynbJnw0dr/yE2Bw4evBL0rK3l98BZ23LspStlb1MmHctQFWM2c5ZKbWTiqkSpccGup+
         XMWZgigBVjzwDpuXpuRbYwqoMltxBcz62pHPO75x004IjA+uqceuxeU7+w6nuZ0wNfJF
         tSpAhQzaTR8RH1I18cyys3ODxe9HT1LM1VLLcT4ujD27ET8J564xKC3DnTKZjuFh8SVn
         2TV6jlp/9u4BxOu2YuRsKzIclq/qHmg/OJObjuE8pgWFNDYcjDIwqimU3vC2MukoqM+g
         P1WA==
X-Gm-Message-State: AFuF++kfbK3wXREObzbb4VqPKkPbHKutaMQE+S91JUj7WS3s9FsOAiVs
	WoDkbX5Y5tsMmH/hkxEBV0uyPLlHaM5MpcCqhX9FrnU09NcHVNzqtOwxrTS6WxBw
X-Gm-Gg: AYBFou0ISKhYDOtVSuBts0bRvFdt8twChcoXu1CX9EKzfmiS8Ezp1/HhgqDe6I8Rnsg
	llNE+d9PokJHCv0dd2oEoDFML7+oQ2Jf3sArfubIWuhEh4iKM45HmZinyG4MpPdp67FhqGxGRVj
	xoVXpP2gXObQa65Bldl2V8busMcxsCE84Sx4m17kvBGQ8lr3yVFge7rE+HIqXJ/m2O4clRYOGzI
	aRK/Qt36L8Rw3Qvsw3mUJJbjp0ZlJkO1gIcmwAx1snkHIXG//Rw8LJP9DnR/+EZDcQCZNQvw5Rq
	lXmmjtf3c3l3TryUPpgwgz9EuIzlF+4Fe++LDE1ahLSu0wcDduONE/2C3RNYZQfovt7KRJA158h
	CRqEduz0xAaU7/lYpIJfEJY8xW/a6gUSPml8vUA+GpZ1248ftsGPIwxuSyqiasBThpOZtNpzsTE
	/ORVdGDppeZND6tghDm6fLDIbO4eZAb7xZL4Z9GSr8hhdJeTrEE3IhYd2PV6/SmIemxHr9REefw
	71ircecBjlePfA9Sb/AEsDLbjC+GfVSzYHJhOtD9I+8c4Je/6FLVbnu5l3O
X-Received: by 2002:a05:7022:5f07:b0:14e:906f:9c8e with SMTP id a92af1059eb24-151c3a9ebf3mr12917648c88.20.1791282583240;
        Tue, 06 Oct 2026 03:29:43 -0700 (PDT)
Received: from pve-server.rlab ([49.205.216.49])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-351469fa189sm7443970eec.6.2026.10.06.03.29.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Oct 2026 03:29:42 -0700 (PDT)
From: "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
To: kvm@vger.kernel.org,
	Sean Christopherson <seanjc@google.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>,
	linuxppc-dev@lists.ozlabs.org,
	Michael Ellerman <mpe@ellerman.id.au>,
	Christophe Leroy <chleroy@kernel.org>,
	Anushree Mathur <anushree.mathur@linux.ibm.com>,
	Venkat Rao Bagalkote <venkat88@linux.ibm.com>,
	Harsh Prateek Bora <harshpb@linux.ibm.com>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Shrikanth Hegde <sshegde@linux.ibm.com>,
	linux-kernel@vger.kernel.org,
	"Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
Subject: [PATCH v7 0/8] KVM: selftests: add powerpc support
Date: Tue,  6 Oct 2026 15:58:34 +0530
Message-Id: <cover.1791280439.git.ritesh.list@gmail.com>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Patch v5 -> v7:
================
(Suggestions from Sean):
1. Added kvm_is_ppc_pseries_lpar() helper in kvm_util.h to avoid sprinkling
   multiple #ifdef __powerpc64__ checks.
2. Enable all tests via TEST_GEN_PROGS_COMMON for powerpc
3. Enable hardware_disable_test and skip when running on powerpc pseries LPAR
   (nested).
4. Re-arranged the fixes in appropriate order.

This is based off v2 of Sean PPC pre-enablement series [1].
[1]: https://lore.kernel.org/kvm/20260902164123.2546762-1-seanjc@google.com/

Patch v4 -> v5:
==============
- Fixed the issues reported by Anushree while running on kvm on powervm
  (nested).
- Fixed memslot_perf_test on powerpc.

PATCH v3 -> PATCH v4:
==================
- Rebased on top of Sean's new page allocator patch series v2 [1]
  This allowed to drop and patch-2 since it will now come from Sean's
  v2.
- Addressed review comments from Sean - squashed patches 6-10 in patch-1 of
  this.
- Dropped patch-5 to print vcpu_id when KVM_CREATE_VCPU ioctl fails.
- Added additional patch-3 to this series to allow dirty_log_test to run on all
  big-endian machines.

[1]: https://lore.kernel.org/kvm/20260902164123.2546762-1-seanjc@google.com/
[v3]: https://lore.kernel.org/linuxppc-dev/2d2c46be7f051c7f1c645afaec67f57067d37a81.1781093720.git.ritesh.list@gmail.com/

Testing updates:
================
I have done some fair amount of testing of the selftests both on real HW and
using various combinations on qemu (powernv+LE (default), pseries+cap-nested-hv,
pseries+cap-nested-papr, powernv+BE). There were few powerpc kvm kernel fixes
which were identified as part of this work. I will send those patches separately
as those anyway needs to go in separately.

<pasted snippet of cover letter from previous versions>
=======================================================

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


Nicholas Piggin (1):
  KVM: PPC: selftests: add support for powerpc

Ritesh Harjani (IBM) (7):
  KVM: selftests: Don't limit LE dirty-bitmap bitops to s390x
  KVM: selftests: Move memslot_perf_test off the 256M ELF load address
  KVM: selftests: Skip the max vCPU ID test when KVM_CAP_PPC_SMT is set
  KVM: selftests: Add helper for checking if running on powerpc pseries LPAR
  KVM: selftests: Skip kvm_create_max_vcpus on powerpc pseries LPAR
  KVM: selftests: Only warn for idle-page checks on powerpc pseries LPAR
  KVM: selftests: Skip hardware_disable_test on powerpc pseries LPAR

 MAINTAINERS                                   |   2 +
 tools/testing/selftests/kvm/Makefile          |   2 +-
 tools/testing/selftests/kvm/Makefile.kvm      |   9 +
 .../selftests/kvm/access_tracking_perf_test.c |  10 +
 tools/testing/selftests/kvm/dirty_log_test.c  |  12 +-
 .../selftests/kvm/hardware_disable_test.c     |   3 +
 .../testing/selftests/kvm/include/kvm_util.h  |  26 +
 .../selftests/kvm/include/powerpc/hcall.h     |  17 +
 .../kvm/include/powerpc/kvm_util_arch.h       |  22 +
 .../selftests/kvm/include/powerpc/ppc_asm.h   |  32 ++
 .../selftests/kvm/include/powerpc/processor.h |  39 ++
 .../selftests/kvm/include/powerpc/ucall.h     |  21 +
 .../selftests/kvm/kvm_create_max_vcpus.c      |  14 +-
 tools/testing/selftests/kvm/lib/guest_modes.c |  20 +-
 tools/testing/selftests/kvm/lib/kvm_util.c    |   8 +
 .../selftests/kvm/lib/powerpc/handlers.S      |  93 ++++
 .../testing/selftests/kvm/lib/powerpc/hcall.c |  45 ++
 .../selftests/kvm/lib/powerpc/processor.c     | 512 ++++++++++++++++++
 .../testing/selftests/kvm/lib/powerpc/ucall.c |  22 +
 .../testing/selftests/kvm/memslot_perf_test.c |   2 +-
 20 files changed, 898 insertions(+), 13 deletions(-)
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

