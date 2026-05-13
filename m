Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA27F3815F5
	for <kvm@vger.kernel.org>; Wed, 13 May 2026 22:46:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778712392; cv=none; b=D6ImFj8iPqC59fvjtW055t/cyt+ijPQ6rR/v36uVwJ9YGMe9i2U50PHq6/NSze/J+J/cbqLDLum6pObSTs2TaqZyjDzsbobqW3xd04SVziMnDrmksDb0FvECpf/8feZX+YjSE0hgqITg+H8DsIL8f2FUmKPlabMUYv2OyMH51wo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778712392; c=relaxed/simple;
	bh=aq4bZkfDOJXUhHtVAMC3HMWwgntUQMuX8yFZe3odma8=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=cIDe3Tv9Iq8cUr2eOZUbE5959Wa/qou+VM58RyeZpARyxh6Q6WlQbSbqSIIGUM+R8Cg5p6WaWiG5JYBPwIrHy3Kxd4peU/SKe33a8jUNQETesGquTf74E+ZlhydYrDmWEvfVZI+xG0fXpZBEE03L0v7hSCdP5b6+X+2doNCOPzQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jmattson.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=K5JJqr9C; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jmattson.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="K5JJqr9C"
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-83ef22f8e8bso1655836b3a.0
        for <kvm@vger.kernel.org>; Wed, 13 May 2026 15:46:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1778712390; x=1779317190; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=hxLfTvvBNHeawdiBrhJ+K19F/tzrjkAgQ9+vj0jFxWc=;
        b=K5JJqr9C8w6NKS/i+WwSG7ULUYPM8EaiFEcw5FryFrUeB+l19lMrdduXcCoW/KZuSE
         wwa4r54Y0CzstqZcgGUpc/C8fi/CXMvsh08ZxY0HSuaQCoS99znyBC6zdTaVQ2i3JtYe
         m9tlwjGSe7qyDOZj5Mu9cN3u1JlABEuYQaJUWUpHKVjl6CZfENePVVE+zWQHY+jfcC/3
         /U3ATYaMj95iQGLXHVSjg+SkyMJomYvUEVfmOct7l+YEoDQhksYprXr0smVQ3b0d+ZOQ
         xzsoXkuFCRLcDYn696lFFXgUgXPj+0jHDAuJ4nlqTRH+2OI83bKf5ekPNqml2YFd/9sx
         EnDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778712390; x=1779317190;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=hxLfTvvBNHeawdiBrhJ+K19F/tzrjkAgQ9+vj0jFxWc=;
        b=h7ouPFeMdvNLs8PlKNjqfQl8krU8mmUaeyY0qhM1gYPfdWFYudwhy5dEam6EB+zben
         272KRDN0Z1boDus/7d8awGuxT88bBmQdP+/sXsJA/JbPZpmHW1UjPXDsuaBSLNibJ69X
         NXb00URF5PTqcHEEvnwxf/EVDIDku+9eH9nzLZvhFGA3QSk6SwXuFUsg7rFL5O66l/Fv
         6wmnGaj8jVGLl3fZvnNhryKJoLndMdZY0AsXbr5NGDV05aSwheRRZyHoH1tAQ/XG516+
         YYuvaq/snBl/CNSZoEKNfjDu7MLkMNorHS0LRR+a5LbGj9pbKELXBJzytbKPR9FA8V+y
         BCLA==
X-Forwarded-Encrypted: i=1; AFNElJ9UeK2WUOY8cOlOyFAJyMvdWKNsaOdwEQQnV2mYOb4WvcPqGv1R9BOO4FnvOESqDMz9iUg=@vger.kernel.org
X-Gm-Message-State: AOJu0YyEkiMJaX/yf4BixZlHOgR9u2338lv9p8oMFS3hr36amuzv8ecR
	z7lRBtnwGGr6w5WnwZrkSorH9c1hAzqwheb2ZC2noesEpS1jqshsdZa7wtVxYGehtg9UNlEH9Jz
	FGTVqNoWm/KVKRw==
X-Received: from pfoi11.prod.google.com ([2002:aa7:87cb:0:b0:835:425b:d4d8])
 (user=jmattson job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a00:3018:b0:82a:190b:2225 with SMTP id d2e1a72fcca58-83f058b9442mr4828994b3a.31.1778712389970;
 Wed, 13 May 2026 15:46:29 -0700 (PDT)
Date: Wed, 13 May 2026 15:46:03 -0700
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.54.0.631.ge1b05301d1-goog
Message-ID: <20260513224608.1859737-1-jmattson@google.com>
Subject: [PATCH v3 0/4] KVM: x86: Virtualize AMD's "disable CPUID in usermode"
From: Jim Mattson <jmattson@google.com>
To: seanjc@google.com, pbonzini@redhat.com, tglx@kernel.org, mingo@redhat.com, 
	bp@alien8.de, dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com, 
	shuah@kernel.org, kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, ctpence@google.com
Cc: Jim Mattson <jmattson@google.com>
Content-Type: text/plain; charset="UTF-8"

AMD's "disable CPUID in usermode" feature is analogous to Intel's "CPUID
faulting" feature, but it is advertised and activated differently.  The AMD
feature is advertised via CPUID.80000021H:EAX.CpuidUserDis[bit 17] and
activated by setting HWCR.CpuidUserDis[bit 35].

Add virtualization support for the AMD feature.

v2 -> v3:
* Logic consolidation between emulator and CPUID VM-exit handler [Sean]
* Define MSR_K7_HWCR_CPUID_USER_DIS
* Keep u64 in the selftest (oops)
* Fixe the selftest failre on Intel hosts

v1: https://lore.kernel.org/kvm/20260402223108.650572-1-jmattson@google.com/
v2: https://lore.kernel.org/kvm/20260508170714.489136-1-jmattson@google.com/

Jim Mattson (3):
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
 arch/x86/kvm/x86.c                            | 38 +++++++++----------
 .../selftests/kvm/include/x86/processor.h     |  1 +
 .../testing/selftests/kvm/x86/hwcr_msr_test.c |  9 ++++-
 9 files changed, 43 insertions(+), 35 deletions(-)


base-commit: 85f871f6ba46f20d7fbc0b016b4db648c33220dd
-- 
2.54.0.631.ge1b05301d1-goog

