Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com [209.85.215.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E72644CAEC
	for <kvm@vger.kernel.org>; Wed, 27 May 2026 17:44:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779903845; cv=none; b=UEDSBGBgErxDLJnVziM+E9HpI5kMbjDeUwq1bS9hHt+JEDkr3cYRf7cKfp0KRDj4YSYvea1RCoiRY+D+deJTZGY/1h7u6+vT5xFw7JAfmMeb1jbir3lPoosMW5SyCeeTbiMENGfUq0IaBHubasK+hn6Oi8Xn9whGvMo/gSyM7wI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779903845; c=relaxed/simple;
	bh=jpmgNIdJkprLJymLsq3oZ+rMXRm7TzPF16ImzVaxq3w=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=hfFKXegyEAUYH41qeMRUY1uJf3GVXx7XzTEoLoCtixCdHMX5vdsVKe+w7FbL8sDqjP1RF4Y1Nj08x8g+DwCjgj5CBnyl47RRwBjPIY/NjcV1SdhRyKqaf62uAFFWh+LKSg2rOeQipUh2Q3+zGUFxO0Tx77IaTI1WnFG8sLq64PE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jmattson.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=iNixskB8; arc=none smtp.client-ip=209.85.215.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jmattson.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="iNixskB8"
Received: by mail-pg1-f201.google.com with SMTP id 41be03b00d2f7-c8525f0807aso7147638a12.3
        for <kvm@vger.kernel.org>; Wed, 27 May 2026 10:44:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1779903842; x=1780508642; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=oig6AEstrs1nnDsGojI66cnVWbXifAj5Zj7sL3iLLWc=;
        b=iNixskB8fuwf7O5f7msomm9XD/u8g5Eakz39ZM7eEnvSJHAsVD+Vb5uq4/UZz0lV2B
         BKEc48HHnUBw4dlBoMRUjR9xgEk3Q/uv7KPlXLgLMJ4l4pQwQwGk6ESADMDZit2f4nuQ
         7M96M/UG065okr7JK/TmAeUsJRIVBEsr/P5j1NbcjxzHM+obfd3NM1w06LhshuKJV0e1
         jRUPVFqx00M8ul74TDIvDPFxgv1jz+CsEvHK4oMgqV42ra4G+ctJQzFd6knoL5o2P6s0
         UaJkdeSKW0xALjAMuWP6cclJTuHCVANFl/lpFkK1072UvJktL4lDiLPfe5Vc1yAcMmN6
         WiTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779903842; x=1780508642;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=oig6AEstrs1nnDsGojI66cnVWbXifAj5Zj7sL3iLLWc=;
        b=Egk3YQG5/zqQ2p62h2QsWOgLSn7QGa5QPsd6vkgZuP3jljT7s/9RfLsqbnu88TTzE2
         nt7Fx/4b3/AsUqZI6mPfCGMxBk3QLh/K8n3/VyQvLEqRhQCaQM3P6OZCg51mzQHOYlLM
         YFffr95/aGpEKUiMf+ljfH3IzdtMqE3ZHO4NE2iKCJDJNLWHVXDj6L/GhZYWsVgMKAPb
         RxhnC/uom7/NYykDTLZQsNWTulz+2Z2JFo5jLh4yrFvl8cSrmKtzpRxOxDez4IkDXSTl
         I7T44Gx3FIpgIHi/dEOO6LuyXRpc1B7Zcj/TP3Fbkxy6/bMWCUnT1e6BgRsdNuekCphA
         xftw==
X-Forwarded-Encrypted: i=1; AFNElJ8zGX0CizHWpdMwZ9UQwKUlN030zcbHCyksW6l5jWBKKUarp+qO+UzHCGhkNoDBCAG5UNk=@vger.kernel.org
X-Gm-Message-State: AOJu0YyKVvBM6eK2WpX6A2mHJ67I9nphgbiMZOqssAQ/ghH2SIQ6sLIJ
	9Z7uwjwIHjqZ9ifu1Vs5NGRBh8u6VrsviD71U2R7BgMRsigBAo9WRGJT1ms1DF5tdP5z4aud05p
	lxfe+swF2O68HWA==
X-Received: from pfbcz7.prod.google.com ([2002:aa7:9307:0:b0:835:687a:d19d])
 (user=jmattson job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a21:a06:b0:3b2:8685:1473 with SMTP id adf61e73a8af0-3b328c4cbc5mr25140090637.7.1779903841608;
 Wed, 27 May 2026 10:44:01 -0700 (PDT)
Date: Wed, 27 May 2026 10:43:42 -0700
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.54.0.794.g4f17f83d09-goog
Message-ID: <20260527174347.2356165-1-jmattson@google.com>
Subject: [PATCH v4 0/5] KVM: x86: Virtualize AMD's "disable CPUID in usermode"
From: Jim Mattson <jmattson@google.com>
To: seanjc@google.com, pbonzini@redhat.com, tglx@kernel.org, mingo@redhat.com, 
	bp@alien8.de, dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com, 
	shuah@kernel.org, kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, ctpence@google.com, David.Kaplan@amd.com, 
	binbin.wu@linux.intel.com
Cc: Jim Mattson <jmattson@google.com>
Content-Type: text/plain; charset="UTF-8"

AMD's "disable CPUID in usermode" feature is analogous to Intel's "CPUID
faulting" feature, but it is advertised and activated differently.  The AMD
feature is advertised via CPUID.80000021H:EAX.CpuidUserDis[bit 17] and
activated by setting HWCR.CpuidUserDis[bit 35].

Add virtualization support for the AMD feature.

v3 -> v4:
 * Fix typo in commit message for patch 1 [Binbin]
 * Fix #GP/CPUID VM-exit precedence in nested VMX [Sashiko]
 * Add EXPORT_STATIC_CALL_GPL(kvm_x86_get_cpl)

v1: https://lore.kernel.org/kvm/20260402223108.650572-1-jmattson@google.com/
v2: https://lore.kernel.org/kvm/20260508170714.489136-1-jmattson@google.com/
v3: https://lore.kernel.org/kvm/20260513224608.1859737-1-jmattson@google.com/

Jim Mattson (4):
  KVM: x86: Prioritize CPUID faulting over CPUID VM-exits in nested VMX
  KVM: x86: Remove supports_cpuid_fault() helper
  KVM: x86: Virtualize AMD CPUID faulting
  KVM: selftests: Update hwcr_msr_test for CPUID faulting bit

Sean Christopherson (1):
  KVM: x86: Consolidate CPUID fault handling for emulator and
    interception logic

 arch/x86/include/asm/kvm_host.h               |  1 -
 arch/x86/include/asm/msr-index.h              |  1 +
 arch/x86/kvm/cpuid.c                          |  7 ++--
 arch/x86/kvm/cpuid.h                          | 14 ++++---
 arch/x86/kvm/emulate.c                        |  6 +--
 arch/x86/kvm/kvm_emulate.h                    |  1 +
 arch/x86/kvm/vmx/nested.c                     |  2 +
 arch/x86/kvm/x86.c                            | 39 ++++++++++---------
 .../selftests/kvm/include/x86/processor.h     |  1 +
 .../testing/selftests/kvm/x86/hwcr_msr_test.c |  9 ++++-
 10 files changed, 46 insertions(+), 35 deletions(-)

-- 
2.54.0.794.g4f17f83d09-goog

