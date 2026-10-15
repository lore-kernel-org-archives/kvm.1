Received: from mail-dl1-f72.google.com (mail-dl1-f72.google.com [74.125.82.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40346550DAB
	for <kvm@vger.kernel.org>; Thu, 15 Oct 2026 16:03:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792080242; cv=none; b=m7K16UvH57Oxic/rSydXTrwhMMTguPvCt6huBtEuuYd9+ACU2j8EI6+WyZ/LDg3W/eth7gYGFNiGfdf8s4O0uqXsJ/JziiePbgy+rHVLlsnH4/2onoLLncyTgXyEqCET0gedxQlPe31WyY4/o/n0EEmber0lgazKIjCt0HPGFnI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792080242; c=relaxed/simple;
	bh=mAd1kLcSwnxVrxeygRYauPj5HV6MXJmqjlEl29oC1w8=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=gk9SDKXYzhB+3swHoK4DegPhxz6Z/EFLjy22NA3luvYfweU5AEV5M9VsfDvbsynvjEXa3O9uNLhERwXwzdgFgFO3nN8HdFHcsPj7FPBZh1In0GKDMLzVo3fzSGEnruFAd8Aq1ClQnIn80up6xf87eqRtTHDMc22/06gaQUEWRVw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aaltinay.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=BsVvl21j; arc=none smtp.client-ip=74.125.82.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aaltinay.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="BsVvl21j"
Received: by mail-dl1-f72.google.com with SMTP id a92af1059eb24-139b62317d0so20184559c88.0
        for <kvm@vger.kernel.org>; Thu, 15 Oct 2026 09:03:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1792080228; x=1792685028; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:mime-version:date:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=GVHgaIROVIh1dbKZNGZDp4okzaZe1g6+U8n1ziBMJQE=;
        b=BsVvl21jiC5EThQlnIM1aGqiHHgREW9A9DesK0JHIsp9nFhc7hCXmJnr21QFFDQDwL
         zf1B6PXw2Fk9l8wDU7gJzfLLIyB6mW67V0l2d0N7d+WqonPrD6bw4cBbkpJLWn0CUHIj
         coCOPSm9SoQe40ck3oc9vqAVqnoMaZfaFHmZ2Q1dRprstRQh6hxP/Ghv27W+i6OiXX0p
         CEx0VLCA/Z5Fh6yYXz6tyHfuTfiVy9pPpXqONTV9CQ9HMVQoXvC1VmxjHynM9WHWousb
         VEElcuRW7gytHvFt0V4am+0AJLv5YE4jSe+wNcp7H5fK5FyYFZBuDk+ONeCoIetj7JBa
         3uWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792080228; x=1792685028;
        h=content-type:cc:to:from:subject:message-id:mime-version:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=GVHgaIROVIh1dbKZNGZDp4okzaZe1g6+U8n1ziBMJQE=;
        b=VgQ8JCta64L9UiDPeJus4dUGS9qTQIkoQ4RIO3Ll/7Z1YJAtkEkcUH5csfylfveqS1
         xWB7Vx+s0LatERaPfuGcSdhcPYQf8ypbBTLWCYSc3h2nSyweyso6JPUhEpcGsMNwwaLO
         PF+7GkXnaHVQcHxxkNr/qBG7RJKr5/VJo/CAAUM3SJLqBzs6fP0L1dQyyKek4fcf1i+t
         Si7jP7H9wLqsMSa6zVFPhnl+bUJXDSCXGEt58v8tXn36BstYvqUodfpoA4qtPU0jTYlN
         dhzj79N/JG2HegViXRZXqP9Fit6yaQz+NnZ3cd9arcLuh9RldlA3VKIWpZA6OsRO6AkE
         14sg==
X-Forwarded-Encrypted: i=1; AKwUvBztM9W3YOCAE13FSMt5r+jJnlc233sZ8R4fo0pQYrWYHywZbFFv4hDR8S/1T2AWmnIsHoQ=@vger.kernel.org
X-Gm-Message-State: AFq9FYICHDyGOg73RG9iZDXpCyNbmTQITz1xeUeKcWWv3d9NuLxJZqcP
	XCZt9V0pRMWLM5x1n9Vaafmjo3B87GzC6XYRJGr+tDvkP2T0i/nlz39IgSy260BP+sMA33cNAKs
	19nmzlH0uySqF/w==
X-Received: from dli1-n2.prod.google.com ([2002:a05:7022:281:20b0:168:b4b9:d783])
 (user=aaltinay job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:7022:f681:b0:143:26eb:18ea with SMTP id a92af1059eb24-16a638513f3mr33314626c88.29.1792080227484;
 Thu, 15 Oct 2026 09:03:47 -0700 (PDT)
Date: Thu, 15 Oct 2026 16:03:40 +0000
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.56.0.385.gd3acb90ef8-goog
Message-ID: <20261015160346.181835-1-aaltinay@google.com>
Subject: [PATCH 6.18.y v2 0/6] KVM: x86: CPUID faulting fixes and AMD CPUID
 faulting virtualization
From: Anil Altinay <aaltinay@google.com>
To: stable@vger.kernel.org
Cc: Jim Mattson <jmattson@google.com>, Sean Christopherson <seanjc@google.com>, 
	Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org, 
	Anil Altinay <aaltinay@google.com>
Content-Type: text/plain; charset="UTF-8"

Please backport the following 6 upstream commits to the 6.18.y stable tree:

1. 690dc03859e7 ("KVM: x86: Ignore cpuid faulting in SMM") [v7.1-rc1]
2. cf7d65d1d6f5 ("KVM: x86: Consolidate CPUID fault handling for emulator and interception logic") [v7.2-rc1]
3. be7fd7c3e8bc ("KVM: x86: Prioritize CPUID faulting over CPUID VM-exits in nested VMX") [v7.2-rc1]
4. d1bc99885a59 ("KVM: x86: Remove supports_cpuid_fault() helper") [v7.2-rc1]
5. e93a93f11490 ("KVM: x86: Virtualize AMD CPUID faulting") [v7.2-rc1]
6. b16c2aca369d ("KVM: selftests: Update hwcr_msr_test for CPUID faulting bit") [v7.2-rc1]

Patches 1 and 3 fix bugs in KVM's CPUID faulting virtualization (Fixes:
db2336a80489 ("KVM: x86: virtualize cpuid faulting")), ensuring that
CPUID does not fault in SMM and that CPUID faulting takes precedence
over CPUID VM-exits in nested VMX. Patch 2 is a non-functional refactoring
prerequisite for patch 3.

Patches 4-6 extend KVM's CPUID faulting virtualization (already supported
by KVM on Intel CPUs and by 6.18 host kernels on AMD CPUs via 65f55a301766
("x86/CPU/AMD: Add CPUID faulting support")) to AMD guests via
CPUID.80000021H:EAX.CpuidUserDis[bit 17] and HWCR.CpuidUserDis[bit 35],
allowing guests and container runtimes that rely on arch_prctl(ARCH_SET_CPUID)
to work uniformly across Intel and AMD KVM hosts, along with the
corresponding KVM selftest update.

All patches cherry-pick cleanly to 6.18.y except for a minor context
conflict in patch 2 (arch/x86/include/asm/kvm_host.h) and a u64 vs.
uint64_t type adjustment in patch 6 (tools/testing/selftests/kvm/x86/hwcr_msr_test.c).

Changes in v2:
- Include KVM maintainers and kvm@vger.kernel.org on Cc across the series
  (omitted in v1 due to --suppress-cc=all).
- Link to v1: https://lore.kernel.org/stable/20261014212844.11997-1-aaltinay@google.com/

Jim Mattson (5):
  KVM: x86: Ignore cpuid faulting in SMM
  KVM: x86: Prioritize CPUID faulting over CPUID VM-exits in nested VMX
  KVM: x86: Remove supports_cpuid_fault() helper
  KVM: x86: Virtualize AMD CPUID faulting
  KVM: selftests: Update hwcr_msr_test for CPUID faulting bit

Sean Christopherson (1):
  KVM: x86: Consolidate CPUID fault handling for emulator and
    interception logic

 arch/x86/include/asm/kvm_host.h               |  1 -
 arch/x86/include/asm/msr-index.h              |  1 +
 arch/x86/kvm/cpuid.c                          |  6 ++-
 arch/x86/kvm/cpuid.h                          | 14 ++++---
 arch/x86/kvm/emulate.c                        |  6 +--
 arch/x86/kvm/kvm_emulate.h                    |  1 +
 arch/x86/kvm/vmx/nested.c                     |  2 +
 arch/x86/kvm/x86.c                            | 39 ++++++++++---------
 .../selftests/kvm/include/x86/processor.h     |  1 +
 .../testing/selftests/kvm/x86/hwcr_msr_test.c |  9 ++++-
 10 files changed, 46 insertions(+), 34 deletions(-)

-- 
2.56.0.385.gd3acb90ef8-goog

