Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 586FE451988
	for <kvm@vger.kernel.org>; Tue, 18 Aug 2026 11:29:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787052567; cv=none; b=cuPThXr83sIny2GSxTC0LuR1CFiTCalq616c3fLKXFrSQhnOkskQJh64KMonVxS2ChXAbIz0YzP/3LAo5r5U7Iv3KzpYtUYuulyBqEoXojO/t2DrhyUUxj30criHSFxdDjQNv5jPexT9c5XnQI7Zovga5lPttht+9xpmZDt6gLo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787052567; c=relaxed/simple;
	bh=IsTo1e1DGjsQsFENkKwvjFrz1btNflZZXlAX3fSz3fQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=o09Bph7WrvSkk+XykRhp5Snr1eiU/F/ERQIlqRPJXJP/0IwOA5c/T70XkQXCSzLInFgKPf8thjw+wTPEV6vWMMh5qrUachwwlm/EoqW5GjL2VF1SfwJ0cA78i0gft7OD/mF6yqZxLswbifTYaZ386ANmzwkDpyq2tJy1J6b7Pr4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=W4MwOUAA; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="W4MwOUAA"
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-38ec1402b05so3600660a91.2
        for <kvm@vger.kernel.org>; Tue, 18 Aug 2026 04:29:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787052566; x=1787657366; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=A8znoO+3TjuD1sNEQAmiSPsrdX02VVlhlMJTSCrbk9Q=;
        b=W4MwOUAAS69HgNXPd22yr79mPq7li0sbM2SsmAj4csYHhQkrloUSRlXt+TIUwtBW4F
         cJZsqKR7F5kQIED/FRVrToLrByxI7JNx1wKP1NXAFXCTwO/x2nlb993Uha/1yMl4Ngep
         mehzgNjsZSqYI7zu6E/3MSrC8Agvk1lM+5J6+BjlsZ5M4DJNudNg7cB2vxXAkOwkQBNh
         K4sgB6la+wSCBZ1WnwB2tmjjk87lx2hVPCdOMtddN0gpaGf7ENFoUy2tF2WvGd1T0CXN
         IXyGJgQ9XOsN3S1DNdvkV5uCl5Gk3K5pfsbsKecHSlEo6n4ynOZuDMFjjYzK3UNh+5o1
         yKLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787052566; x=1787657366;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=A8znoO+3TjuD1sNEQAmiSPsrdX02VVlhlMJTSCrbk9Q=;
        b=QmUklU9w8UUnewQH++wW0kL6kVSq2BS2iQ10cx7M2t+Fn9ATAgut1fQN0cyGjWpX17
         T4MG7xA4/yMiO5GymThpekOfs/WUbJWdnXgJyFm2KHoWpu1n+guVczR5TzmlEw9O2rKs
         RtUYfj5t2WR/tGDMr2M9oiPi95VPY4fX76NESYu6ijC8nX6VlNPmgE1iUegM7KM0KZGd
         0DKGvgPkKYIYb1AS19Z/PKsPK7Uj7z1agR/TnaDwOuRU+VAl58IlEHjWjV4gExPEbBpe
         qVs9OjM6jBPr2JT3VH42m0V0r1c5xPQQHwizQZudXAJPC8LmTxBEvnyiCaTwPdjAagyd
         Yivw==
X-Forwarded-Encrypted: i=1; AHgh+RoRuEnms0ZOq5rYDOLF+wRWEaENMaqDtmgA5FZElVPViS3+B4gM5sa4fAmCtxfX9i1bdew=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx/dJmCoPOi257ajt7r5h7+ohBGW2FRjCPTBff7GXwifFnJQCCi
	GGL3JKxSwZupLsQe4RxphP4EYwH6/T8lXIXLDC31mTN4u8+10VmAJ0v/
X-Gm-Gg: AR+sD13/D9v2jxqa+HjS8zO1kUcMn4sMP1NNn6/yz+EpHjD69QBWA8s8rXrIIPjAWDb
	RD7/wIYJCGZZrLTIbHPqz+TStQWltI9PzWIuREoD+8GddVA+vyNMm0lj00qzlegH2HaYoYqHXRa
	UCnJh0uVQBaNwwg8HsGqtSYUbqY/zlovN73/lAt+f6xcXC39zktCioAurnPwSXEWKffoi5AjrBP
	UtQPQOMpWjHvVY2XMsm+GYxXLOG5+CPxXZB6T5wx5mLcI/TaB1rqDAJGsSKkn8DrQFOYm52NEVU
	/3JGHtbGdntriablkS1amBCVLuNHFNALK0ITSUpmgWuJCylL4cB/rzXjKPNiuKTWt+fk4EUbHcS
	vQ70HrW1rYlOuSsXOl45RUwGFF1jGub5lI31grSQmFGo34DmECBV3XZtOb5l7/bceC/0hlVVcq8
	tsVzzhmip/Pe1/QejKGwn7AnrEYxz6fKYpVv3RhXzBSpULUwW2zmo3NfdysKLK4PH+zM0opvOvl
	weI4A==
X-Received: by 2002:a17:90a:38e1:b0:395:5f66:15f1 with SMTP id 98e67ed59e1d1-3955f6616c5mr6100098a91.17.1787052565657;
        Tue, 18 Aug 2026 04:29:25 -0700 (PDT)
Received: from LIKEXU-MC4 ([43.132.141.24])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39531e31a9dsm8423420a91.4.2026.08.18.04.29.23
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 18 Aug 2026 04:29:25 -0700 (PDT)
From: Like Xu <like.xu.linux@gmail.com>
X-Google-Original-From: Like Xu <likexu@tencent.com>
To: Marc Zyngier <maz@kernel.org>,
	Oliver Upton <oupton@kernel.org>
Cc: jiaqiyan@google.com,
	kvmarm@lists.linux.dev,
	Paolo Bonzini <pbonzini@redhat.com>,
	kvm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/3] KVM: selftests: arm64: Make sea_to_user skip cleanly
Date: Tue, 18 Aug 2026 19:29:17 +0800
Message-ID: <20260818112920.26252-1-likexu@tencent.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series hardens the arm64 sea_to_user selftest so that it reports a
clean skip on hosts that cannot actually run it, instead of aborting or
silently passing.

The test drives a real recoverable memory UER through APEI EINJ and
expects the guest to consume the poison and exit to userspace with
KVM_EXIT_ARM_SEA. That relies on host and firmware support that is not
present everywhere, and each unmet dependency is now turned into a skip:

  - EINJ injection is driven directly through debugfs, and an unusable
    EINJ (not built, no firmware support, or not running as root) is
    classified from errno and skipped rather than mishandled.
  - Guest memory is backed by 1GB hugepages; with an empty pool the test
    now skips up front instead of failing an mmap() with -ENOMEM.
  - Some firmware only arms EINJ poison as part of the trigger step that
    notrigger=1 skips, so nothing consumable is left for the guest to
    read. That case is detected and skipped rather than reported as a
    spurious KVM_EXIT_MMIO failure.

Tested on an arm64 host with CONFIG_ACPI_APEI_EINJ: on a platform whose
firmware places no consumable poison under notrigger=1 the test now
skips cleanly, and the earlier -ENOMEM and abort paths are gone.

v1 [1] was a single patch doing only the 1GB hugepage check. Following
Marc's review [2], it is expanded into a series that also fixes the EINJ
handling the test depends on.

Test Results:

  Case 1 (echo 0 > /sys/kernel/mm/hugepages/hugepages-1048576kB/nr_hugepages): 

  # timeout set to 120
  # selftests: kvm: sea_to_user
  # Random seed: 0x6b8b4567
  # 1..0 # SKIP - Requirement not met: get_free_hugepages(backing_page_size) >= VM_MEM_SIZE
  ok 1 selftests: kvm: sea_to_user # SKIP
  # 1 skipped test(s) detected.  Consider enabling relevant config options to improve coverage.
  # Totals: pass:0 fail:0 xfail:0 xpass:0 skip:1 error:0

  Case 2 (rmmod einj):

  # selftests: kvm: sea_to_user
  # Random seed: 0x6b8b4567
  # # Mapped 0x40000 pages: gva=0x80000000 to gpa=0xff80000000
  # # Before EINJect: data=0xbaadcafe
  # # EINJ_GVA=0x81234bad, einj_gpa=0xff81234bad, einj_hva=0xffff41234bad, einj_hpa=0x42c1234bad
  # 1..0 # SKIP need CONFIG_ACPI_APEI_EINJ and firmware EINJ support
  ok 1 selftests: kvm: sea_to_user # SKIP
  # 1 skipped test(s) detected.  Consider enabling relevant config options to improve coverage.
  # Totals: pass:0 fail:0 xfail:0 xpass:0 skip:1 error:0

  Case 3 (modprobe einj):

  # selftests: kvm: sea_to_user
  # Random seed: 0x6b8b4567
  # # Mapped 0x40000 pages: gva=0x80000000 to gpa=0xff80000000
  # # Before EINJect: data=0xbaadcafe
  # # EINJ_GVA=0x81234bad, einj_gpa=0xff81234bad, einj_hva=0xffff41234bad, einj_hpa=0x42c1234bad
  # # 0x10 > /sys/kernel/debug/apei/einj/error_type - done
  # # 0x2 > /sys/kernel/debug/apei/einj/flags - done
  # # 0x42c1234bad > /sys/kernel/debug/apei/einj/param1 - done
  # # 0xffffffffffffffff > /sys/kernel/debug/apei/einj/param2 - done
  # # 0x1 > /sys/kernel/debug/apei/einj/notrigger - done
  # # 0x1 > /sys/kernel/debug/apei/einj/error_inject - done
  # # Memory UER EINJected
  # # SIGBUS (7) received, dumping siginfo...
  # # si_signo=7, si_errno=0, si_code=128, si_addr=(nil)
  # not ok 1 Exit with signal unhandled
  ok 1 selftests: kvm: sea_to_user
  # Totals: pass:1 fail:0 xfail:0 xpass:0 skip:0 error:0

Changes since v1:
  - New patch 1: drive EINJ injection directly through debugfs with
    open()/write() instead of access()+popen(). Classify the open()
    errno so an unprivileged run skips as "requires root" instead of
    falsely reporting missing firmware EINJ, and report a genuine write
    failure instead of the ambiguous "Failed... Success (0)".
  - New patch 3: detect when notrigger=1 leaves no consumable poison and
    skip cleanly, instead of exiting with a confusing KVM_EXIT_MMIO.
  - Patch 2 is the original v1 change, unchanged.

Not yet addressed from [2]: dropping the hard 1GB-hugepage and 4kB
base-page requirements. Suggestions on an acceptable backing scheme are
welcome.

[1] https://lore.kernel.org/kvm/20260817080759.25601-1-likexu@tencent.com/
[2] https://lore.kernel.org/all/86y0le9cvz.wl-maz@kernel.org/

Like Xu (3):
  KVM: selftests: arm64: Fix EINJ handling in sea_to_user
  KVM: selftests: arm64: Skip sea_to_user without 1GB hugepages
  KVM: selftests: arm64: Skip sea_to_user when EINJ places no poison

 .../testing/selftests/kvm/arm64/sea_to_user.c | 75 +++++++++++++++----
 .../testing/selftests/kvm/include/test_util.h |  1 +
 tools/testing/selftests/kvm/lib/test_util.c   | 15 ++++
 3 files changed, 77 insertions(+), 14 deletions(-)

-- 
2.50.1 (Apple Git-155)

