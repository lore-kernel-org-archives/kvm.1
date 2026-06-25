Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14BD9332EC1
	for <kvm@vger.kernel.org>; Thu, 25 Jun 2026 22:04:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782425095; cv=none; b=DLEfDl0LXUFDXxRAgwD4qyBEc0Z7NUYjETL7GL4RaAIcE44lh4ZEW3reSeto715aQ+ZkMnNwurtxsDESY/2lh5svXHMmwLhDXchqHQKzeA1yO/imsN1+N956crqoBf9rcSnZXGxk+sjyXOEmAlcNvFmrIPklN3iPArUzTZHxDhI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782425095; c=relaxed/simple;
	bh=8BESrQDCjHZ0YmusWkTjLjSMkiBQRcYlGxblc7n/m3k=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=sAlCLHMi+ffX7C4csMwyx9b/JqA+7TIZ1CuyTaJdd3kG+6vkT3zqveaF542dYVeQdOoUs/tSGEmQpCdEwg+QqGRuRSANdUik1v7kPMlsdEDH0yKDCJIwM/5Zgiiu4ZeVjPqeuRQI6El54tzkqp4tMNBU76Zm1sJHKeomX5lX/Xs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=thGbcqr7; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="thGbcqr7"
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-36d97a4e08fso209087a91.0
        for <kvm@vger.kernel.org>; Thu, 25 Jun 2026 15:04:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1782425093; x=1783029893; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:reply-to:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2UBF/idddbMrq+IFa0zbe+agAYQwSJwIzSA2PYFkr2U=;
        b=thGbcqr7jq1hntzpKE+oYxyEU+J1eljcg0BJkFASfRTZ7jGmpBl7wqEomW3ZvOV1lt
         Or9pEViSIndGcNiD9bWZWpfGTYez/ujWun98oSfEQLR/OvS2NZ9S1Lbx9KbIVJR+TmTx
         aC4afLBfYNyL/KAcS37EMQx2+FXezWwkAU/7hdHMlgns4/ayw8K2eKzQYlVz9cb/lxO7
         GhxkLL2hKFFT+COCt2PQun/WdPxgepIwdwg8Km2NGT8okE92QoPAY8ymvtxcZBN9XGrE
         OUwwKFg6luZJIsEwhpppCDijCeOwDInTQzYUiXoRswIUDJLAFHVf7Oad+eJdHpIXwFoe
         oTtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782425093; x=1783029893;
        h=cc:to:from:subject:message-id:mime-version:date:reply-to
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2UBF/idddbMrq+IFa0zbe+agAYQwSJwIzSA2PYFkr2U=;
        b=mY4nCDd2R/G3p2sK372jngSt7RRcpZddSFIUkLrkJocuEG2gREpKwP/WYw5MBKbJJT
         6x4kvXtngIwj+S5N4uA//6P2cGHZLDm3BnoLEji0fZRj4GMG6w3siCdKrFc65oo/1BV4
         x2m4Gn4AnJ4bmZzTeb9FgUYBCEVikHqbe8Jyt1dRvawVFqX3sv63z+l8sPxXxE6cOiNn
         6lQArfYcwZ7+AHgDzD7dTDoQS1531/IMhoDcNgoyHW+pHmwvS/1+jUAKfjuuW2cutF1N
         QFjh1tWkcLlW6DEHBqftFag64dUItAhy6cru4ESNID5riDOwqYECrzS7aitWmhoh9g7w
         MZNA==
X-Gm-Message-State: AOJu0YyyHUOleNngesvnIR3N1hTVkis9U05J8EVVkAR2KePMCZKSe9uG
	9/eB0JWjIez5DUUOG0Btd6IIce1nIaMr+lk4Cbhy2DZdasMTnO7H1MNHPJrlaPGQgroDXMLehOT
	QxbJEKA==
X-Received: from pjk15.prod.google.com ([2002:a17:90b:558f:b0:37d:ec05:e035])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:17c2:b0:36d:633a:e7e5
 with SMTP id 98e67ed59e1d1-37df9f3821dmr4258262a91.3.1782425093073; Thu, 25
 Jun 2026 15:04:53 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Thu, 25 Jun 2026 15:04:41 -0700
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.55.0.rc0.799.gd6f94ed593-goog
Message-ID: <20260625220450.3354415-1-seanjc@google.com>
Subject: [PATCH 0/9] KVM: x86: Spring cleaning, part 2
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>, 
	Vitaly Kuznetsov <vkuznets@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Binbin Wu <binbin.wu@linux.intel.com>, Kai Huang <kai.huang@intel.com>
Content-Type: text/plain; charset="UTF-8"

A few more cleanups that I wasn't able to get out in time to catch kvm/next
(almost all of these are the result of code review feedback).  The main theme
is again trimming down x86's kvm_host.h.

Sean Christopherson (9):
  KVM: x86: Move the "APIC attention" macros from kvm_host.h => lapic.c
  KVM: x86/mmu: Annotate tdp_enabled as being read-mostly
  KVM: x86: Pluralize the macro guard name for msrs.h
  KVM: x86: Move CR and DR macro definitions from kvm_host.h => regs.h
  KVM: x86: Move KVM_GUESTDBG_VALID_MASK from kvm_host.h => x86.c
  KVM: x86: Add static asserts to document connection b/w TSS structs
    and macros
  KVM: x86: Move KVM's arbitrary task switch reason enums to x86.h
  KVM: x86: Move "struct kvm_apic_map" definition from kvm_host.h =>
    lapic.h
  KVM: x86: Move "struct kvm_vcpu_hv" and all children from kvm_host.h
    => hyperv.h

 arch/x86/include/asm/kvm_host.h | 192 +-------------------------------
 arch/x86/kvm/hyperv.h           |  90 +++++++++++++++
 arch/x86/kvm/lapic.c            |  10 ++
 arch/x86/kvm/lapic.h            |  33 ++++++
 arch/x86/kvm/mmu.h              |   6 +-
 arch/x86/kvm/mmu/mmu.c          |   2 +-
 arch/x86/kvm/msrs.h             |   4 +-
 arch/x86/kvm/regs.h             |  38 +++++++
 arch/x86/kvm/tss.h              |   7 ++
 arch/x86/kvm/x86.c              |   9 ++
 arch/x86/kvm/x86.h              |   6 +
 11 files changed, 203 insertions(+), 194 deletions(-)


base-commit: a204badd8432f93b7e862e7dac6db0fe3d65f370
-- 
2.55.0.rc0.799.gd6f94ed593-goog

