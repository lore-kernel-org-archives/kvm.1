Received: from mail-dy1-f182.google.com (mail-dy1-f182.google.com [74.125.82.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDC1A47C116
	for <kvm@vger.kernel.org>; Tue, 22 Sep 2026 18:29:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790101757; cv=none; b=MukIesRvaSkS7qxrytstYIiu7T5T6CmdfH1MSGIiHZ35PPzkWVcKcgyIsnvQhjK4zj/6AR+4hDLkAkvzP7BhhhwDkiIaYqdsd/jzFZr/KiEjui1Mu/eVHou12PP+48/+OFpKwBl0q+A0uDvluxHrhjCN8VFNEan3lVh2z+nOrn0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790101757; c=relaxed/simple;
	bh=aFAuN6Oq4Zw4ipPVDHTfDM24/NOJlJiRcfxatgz4T+8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=bpyJm/uydz6niMK4r2ogCjuaqzwEC5IMO5X//fRtEbL+TpPiGXIMPJwb0WmOG9hZwCQKa2FL1M5xyZq0n4NZ56bcmL/pyGQMtfQevQNS5nOHiwG1FNadOdrrR70b71Khj0neJaLzvAUjViHzs8z7f1kLTWWRswPOJx4uZBI4Sh0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HTyc4tA0; arc=none smtp.client-ip=74.125.82.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HTyc4tA0"
Received: by mail-dy1-f182.google.com with SMTP id 5a478bee46e88-3115c4451c8so69051eec.1
        for <kvm@vger.kernel.org>; Tue, 22 Sep 2026 11:29:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790101755; x=1790706555; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=boc46Sj1HOU4tKyVBAaYU0tHsUhuDqMurhOITlCOjEQ=;
        b=HTyc4tA05qQlWJCA+Mr9M1LLGWpjMvFDTfNtt728sKf9BiJz2L+QQg4V4lXQ7o2AYs
         ntxzHAMk4uX/PHP2fHkeVYq8YdUi1pPnimTPyYKJGb83rcuVPaG2Dn3s9LUyBCAdMZOb
         nAg67JoNYnD4Oxu82/3skMt0uB/HW1LJHDAJVLF6Ayg4ciASKbxEylsxOreeWXf7Hbk1
         Bgp264cnKhZwpHqdBAGukrmnty3PsSEI2BJng0Lz1gfDl4HKnRjTG3LWCX5WhexehgUU
         uxEDASNTk6GdLbZgukuymXqyjBUcNUYwAwKKQHnw+2tJjFAaFW7jwxEerqn8zwRzl8HF
         uFeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790101755; x=1790706555;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=boc46Sj1HOU4tKyVBAaYU0tHsUhuDqMurhOITlCOjEQ=;
        b=d87O2biTG281ytSXNlsY65CPrrNuEzKJ7zJNQ+9eX6jOZ+cnfCTslHsnywGheX+6QU
         ReH51up2jWvAmC8Tt2gpcOQHxkWUpFUm+2J1hCIxrjrh4ww/PHRo3JfiUclteOMo8o8A
         iHqXCrlUk9fPD57/ro1AO5uIevC5YrGetZix4NfSXYlGHkBnvLB1RrcJKjfgq3ryxarv
         cuIlM080GAlt24dScK5l/8AQToX7zzonyxzh/utVhm1pCoBP9AQHdZ0WobsTx3aC+wF5
         R10QPwh8zgjlVW9ZTrVb6GH7DhtsE0tOGHEOHmei6j5+vXHLzd00+m5XhGpIKQ4MsR1K
         XrVw==
X-Gm-Message-State: AFuF++nr60aNR806aa/wCJdbwVauU5lE9Kg93XqDtl2RWZhXPjtcikiz
	7M1LaDGfW8I+UQDt5pX6++qVyaBbNm7hYKgskGEEB+zQzkYGozdqpMvuzF1QpA==
X-Gm-Gg: AYBFou0muDQ1xccoHlWX48Ne/MgWHuDKfQZpyXw3zj4E+ocJQSbYOPnDDULzi73Y/3b
	pa7k5+b7Z7IXicNvKz0RdJRR04r5nNlHoEBUUEgCA7POYggA6oyoCZIdj6559pnJfdEksSFAk1s
	3cG75QGjUDBbOdkNIh4xmmHrXBCEHSZBCambquH75v88nA2gy9QFOP64sFNZ3o37kFpg4PIkk3o
	ZRELVl9GXrohVTIK4SMQ3vO4gWOKsYwzXbVL5RLXtTUgRXHUo4PYFYs7y5A73o1RDzODQ0IDAaa
	DX+Am5Mct3bySnY9pPgeC4c1ok87sQwGjCVc2hVNeCDVZys51MxrTKc42U3ZwG7B2iIwwrsK2u9
	cWCEF9c81by2dggTBj+7TnwJZHS75+xeihpWFSDBl2W5SNETPOwLrCvm36ZSe8iJm56TW35wost
	9+ab053ofbSSMeWZqYOy6d017DpOlaZ+BWfF+IQ2n6CLEbQIJGYQPUmhnBmjhOmf3ENdOESQ0Oi
	7hBXR3co2o3cVr2aomSnXQHMKwpcIFPBU/g+bQY19Djy9n+5zE8mQcQO3F8
X-Received: by 2002:a05:693c:8201:b0:332:946c:477a with SMTP id 5a478bee46e88-33e5ca9fe0cmr241891eec.16.1790101753804;
        Tue, 22 Sep 2026 11:29:13 -0700 (PDT)
Received: from pve-server.rlab ([49.205.216.49])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-33e939fdabcsm154315eec.3.2026.09.22.11.29.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Sep 2026 11:29:12 -0700 (PDT)
From: "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
To: kvm@vger.kernel.org
Cc: Sean Christopherson <seanjc@google.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
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
Subject: [PATCH v5 0/9] KVM: selftests: add powerpc support
Date: Tue, 22 Sep 2026 23:58:44 +0530
Message-Id: <cover.1790101179.git.ritesh.list@gmail.com>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

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

Ritesh Harjani (IBM) (8):
  KVM: selftests: Enable kvm_create_max_vcpus test for powerpc
  KVM: selftests: Don't limit LE dirty-bitmap bitops to s390x
  KVM: selftests: Split out a KVM_CREATE_VCPU helper that can fail
  KVM: selftests: Make kvm_create_max_vcpus tolerate ENOMEM
  KVM: selftests: Limit the number of VM creates in hardware_disable_test
  KVM: PPC: selftests: Make nested case on pseries LPARs as resource constrained
  KVM: PPC: selftests: Skip idle-page check when running nested on pseries LPAR
  KVM: selftests: Move memslot_perf_test off the 256M ELF load address

 MAINTAINERS                                   |   2 +
 tools/testing/selftests/kvm/Makefile          |   2 +-
 tools/testing/selftests/kvm/Makefile.kvm      |  10 +
 .../selftests/kvm/access_tracking_perf_test.c |  11 +
 tools/testing/selftests/kvm/dirty_log_test.c  |  12 +-
 .../selftests/kvm/hardware_disable_test.c     |   7 +-
 .../testing/selftests/kvm/include/kvm_util.h  |  13 +
 .../selftests/kvm/include/powerpc/hcall.h     |  17 +
 .../kvm/include/powerpc/kvm_util_arch.h       |  22 +
 .../selftests/kvm/include/powerpc/ppc_asm.h   |  32 ++
 .../selftests/kvm/include/powerpc/processor.h |  46 ++
 .../selftests/kvm/include/powerpc/ucall.h     |  21 +
 .../selftests/kvm/kvm_create_max_vcpus.c      |  29 +-
 tools/testing/selftests/kvm/lib/guest_modes.c |  20 +-
 tools/testing/selftests/kvm/lib/kvm_util.c    |  39 +-
 .../selftests/kvm/lib/powerpc/handlers.S      |  93 ++++
 .../testing/selftests/kvm/lib/powerpc/hcall.c |  45 ++
 .../selftests/kvm/lib/powerpc/processor.c     | 522 ++++++++++++++++++
 .../testing/selftests/kvm/lib/powerpc/ucall.c |  22 +
 .../testing/selftests/kvm/memslot_perf_test.c |   2 +-
 20 files changed, 942 insertions(+), 25 deletions(-)
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

