Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.48
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795447990;
	b=mmDKuZMrbnLpeicFZUoSLGcs5K5SeKfOW0HQ4+7r14SA4Rds1y0FzPdx4vfQxTFgJY+y
	 1tkPrfwoV3DmMl2yURmT3RWEdUaNfxDBIUApCv/wozuX9dcgSS/AKIsoFg/Kn23jqOsq2
	 OTNT9aNjmJ5WHqKsS82O/iWZp4QivJINdiS7Ye0p6wiISvx2gDsM5LGy/WPFYGM5luWZV
	 Y84i6kBnq2YpbMSGgYCbCk1c7uGphQeRqzdEFm+bopTbXw23fJICUM1WP4BHQb/2coMyv
	 yvJkuZgpLC6H5ysMNLOKAixuoSAAW+ZnX4PWRKSCC0pkZFKiaNWuyClu1Gb+2vion6w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795447990;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=RlVCfj055wxtGOJ7XrWntay3DNbbVGK7kyws0BxxA/w=;
	b=yNXjUmZpcJVlG9sJnVEYgPHNoCF0+13m79kX7MLqIiu+V/6J8wxyInvxO1NWONdRp/YQ
	 vzVVfWYRAOzx8K0UEFpbglBesXCd+uDfRutYkvMM68vYfKLQXWa9A37TK/7GYsXpmke0P
	 fe+oqD0L8j31GvSeBJ2fZL0yitnXMRUYHJvGmhS34JF2FQ6dSo0u3yObFu0aOaXyzrNfB
	 K6RGT0BSiOjZPv89JD5bGmqN+JMtw9qNcJwyJBHaHbCB1n1KNjXnfaAMwjkZYVfjPDQjF
	 4rip2W4/fXFEf6FCyvFBl6lMfsN6N1ZNquUGRuuhcnSLbblsmLqOt8pqsmgqt1U65/g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=asu.edu;
	spf=pass smtp.mailfrom=asu.edu;
	dkim=pass header.d=asu.edu header.i=@asu.edu header.a=rsa-sha256 header.s=google header.b=sArKsinY;
	arc=none smtp.remote-ip=74.125.82.48
Received: from mail-dl1-f48.google.com (mail-dl1-f48.google.com [74.125.82.48])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C5D1606A332
	for <kvm@vger.kernel.org>; Mon, 23 Nov 2026 15:33:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2C5D1606A332
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=asu.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=asu.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=asu.edu header.i=@asu.edu header.a=rsa-sha256 header.s=google header.b=sArKsinY
Received: by mail-dl1-f48.google.com with SMTP id a92af1059eb24-1b546061d58so7588785c88.1
        for <kvm@vger.kernel.org>; Mon, 23 Nov 2026 07:33:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=asu.edu; s=google; t=1795447988; x=1796052788; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=RlVCfj055wxtGOJ7XrWntay3DNbbVGK7kyws0BxxA/w=;
        b=sArKsinYuLT9SmCqJEFA9DprCuAhOxBVa7CEEKp/WYrG8LI15qRMnJXaROKFhpPX/p
         2HfTk0PkDWdA7dEnK4qj8CrBm9HcfV2dOZ/3Qff9qTH/pOhKXd3r19OHQasEojzAy9Ze
         rC18n/63UtFL/7lqO3BcGceM7yz8RE/1IeHHhzFC7RuaPVbzmDF1YwUfu1SbYoFjEEC5
         r99fI4sZUwWCSmWKBKE20Pd3pVimPUWfasdImlegsTPNMoS0HtFlD//p0zhXURh9vRej
         HMthQlle88IEoT7fKtjEgzvyCRPBaXpddnOe7KYRzko7CkPXbdLGs3RZEpCjmK6K51cG
         q2Aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795447988; x=1796052788;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=RlVCfj055wxtGOJ7XrWntay3DNbbVGK7kyws0BxxA/w=;
        b=ygN6xdacKnSolo9jy2kB+R7wGAJV0qPrEMJeFzMVucSeaDoSnfjC3KR8Vtk9HZbVYl
         b1FKAN2Lmuuj+djM6g/J3qIThcwYTwQcxn99q7+pd2oRYAl37cvvED/zeby056nuKqPZ
         ZdlGer/gri30ecxjWtHb4dGdBJig78QYivbghKm+bapTVKuux04Co1sbtrI2XS8ATlrS
         3k0+7vHM0GL2Vc1B39Xo8kR+H9ZPf1etF+8mPwVwEM+RRnTlgMlNqXP7xNkS0gkhwVKC
         7EyGXTUFJ9eqQ2Sy4k80KIUiPpIaCB97lE2ZOwT5adQfS8i58ggy5bSLhruDeZcNG6Su
         84Lg==
X-Forwarded-Encrypted: i=1; AL+hErFiBG1FzdcjF2bE9kX6Dwfb7Xt1cJssQsRUYPTtfFuRG4xiThahHnPcrzEBASyTKMIgNbo=@vger.kernel.org
X-Gm-Message-State: APuU4Z/N5xfh9yLY8UNpm6JoeRkqO1SekjhxpkrmVo3nTi0bvJZdlcz4
	wqfDo06UpyZz1sr2ExcF8yh9X7Ze1jLOG6kz2nrrgBRTJmoibWPo2lEWezl15vShMA==
X-Gm-Gg: AZFdTZedGNTgkQlXvElt0m/f/2gt2IDpcOk2oPIQ48SqSK7TOD1gqFTdAkM2OdDnaxl
	Na2eBFiMGbPiRX/lGUJ4ag33dUFiz1t20qlc3802eXBxRjbDRF0PpAdR/efZZYRgjGBr71UDIIv
	UsGMtgwlZGR7Cw/IkJ/b5ryohqMW+dqWXZorfZ8VELj3mGYOfNIHkgRnR8xy2XUHatGzVXi4VPd
	icdbf3U1Xi3R4+amhapgVusWRW+ob4iQaD+BhJhP9urc82yAQ/wUroltUjEkq2NhUIjDA5rTSa0
	xROXqm8aUWjBZjOBezpuE/8k9fADKctvYcG3/upJPV3Cdb3lURjkH6sWHsH7CvmKlNwft5h9Z78
	Z7M4h/tqeROvODJ10zZZann4hGu+7rdYhu+166bTmjQYHsLPO7b1PZ+UPeDfQ5/jelsg5FrUKck
	JRKkD4R3wm1rNhspLRVRn0v3XIfbtf8ylzQ0Ccx8KdukfItWkrWDVcXp/soEgreWPy3dbwspbu6
	u4bteDLUfcFNPa3lUYMqrzW3dVbe1CaQvUlg2XtbtqyTI1ZBUYeAC01nPQ0fkc2Br3x0u9xH/G3
	iSpAIYDUm1I65OKZwF2GgiQC1CNjf++Oq6FPjCtDeg==
X-Received: by 2002:a05:7301:e0cd:b0:375:dbeb:b363 with SMTP id 5a478bee46e88-38570f221dcmr12904822eec.28.1795447988314;
        Mon, 23 Nov 2026 07:33:08 -0800 (PST)
Received: from localhost.localdomain ([2600:8800:1e00:25f0:3391:10c3:1717:1522])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-385672ce402sm34601237eec.16.2026.11.23.07.33.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Nov 2026 07:33:07 -0800 (PST)
From: Siddharth Mishra <smish149@asu.edu>
To: Paolo Bonzini <pbonzini@redhat.com>,
	Sean Christopherson <seanjc@google.com>
Cc: Shuah Khan <shuah@kernel.org>,
	Peter Xu <peterx@redhat.com>,
	James Houghton <jthoughton@google.com>,
	David Woodhouse <dwmw2@infradead.org>,
	kvm@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Siddharth Mishra <smish149@asu.edu>
Subject: [PATCH 0/2] KVM: Fix lost dirty ring entries when a vCPU is preempted
Date: Mon, 23 Nov 2026 08:32:36 -0700
Message-ID: <20261123153238.1036972-1-smish149@asu.edu>
X-Mailer: git-send-email 2.54.0
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

A push to a vCPU's dirty ring can be interrupted by another push to the
same ring when the vCPU task is preempted, which leaves one entry
unwritten and makes userspace stop harvesting the ring.  Patch 1 fixes
kvm_dirty_ring_push(), patch 2 adds a regression test.

Found while fuzzing. An AI tool helped with the analysis and the patches.

The series is independent of James' series that changes the same
function, and applies with or without it:
https://lore.kernel.org/all/20261117212913.3634487-1-jthoughton@google.com/

Tested on Intel with PML, in a nested VM on mainline at
commit 4843f6873f7c ("Merge tag 'sysctl-7.04-fixes-rc4' of
git://git.kernel.org/pub/scm/linux/kernel/git/sysctl/sysctl") and on the
v7.2.8 host:
- Patch 2 fails within seconds without patch 1 (11 of 12 runs), and
  passes with it (0 failures in 15 runs).
- All x86 and common KVM selftests, with PREEMPT, DEBUG_PREEMPT,
  DEBUG_ATOMIC_SLEEP, PROVE_LOCKING, PROVE_RCU, DEBUG_PAGEALLOC,
  SLUB_DEBUG, DEBUG_OBJECTS_RCU_HEAD, KVM_SMM and KVM_XEN: the same
  results with and without the series.  hardware_disable_test fails and
  xen_shinfo_test triggers a lockdep "Invalid wait context" report in
  kvm_xen_set_evtchn_fast() on both.
- The dirty logging tests with kvm_intel.pml=0: the same results with and
  without the series.
- Builds with W=1: KVM_INTEL=m KVM_AMD=m KVM_WERROR=y, SMP=n,
  allnoconfig, gcc allmodconfig and allyesconfig, clang allmodconfig, and
  clang for arm64, riscv and loongarch.
- KVM-unit-tests (a2891d9) for x86 in the same nested VM: the same
  results with and without the series.  vmx_apicv_test times out and
  vmx reports "Guest didn't run to completion" and a too high RDTSC to
  VM-exit delta on both.
- sparse (84ec065) with C=2 on arch/x86/kvm/: no reports in
  virt/kvm/dirty_ring.c.

Not tested: AMD, the Xen runstate path.

Siddharth Mishra (2):
  KVM: Disable preemption while pushing to the dirty ring
  KVM: selftests: Test dirty ring pushes from vCPU preemption

 tools/testing/selftests/kvm/Makefile.kvm      |   1 +
 .../kvm/x86/dirty_ring_steal_time_test.c      | 146 ++++++++++++++++++
 virt/kvm/dirty_ring.c                         |   2 +
 3 files changed, 149 insertions(+)
 create mode 100644 tools/testing/selftests/kvm/x86/dirty_ring_steal_time_test.c


base-commit: 7475ea8b58616b33c04afb976cf0fbaad9dd63fb
-- 
2.54.0

