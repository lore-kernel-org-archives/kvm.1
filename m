Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 015EB333730
	for <kvm@vger.kernel.org>; Wed, 26 Aug 2026 21:53:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787781182; cv=none; b=G6EyOsrdhyg1XUmmDUQuzcxrcHjkHcLcjLBRvZHlGcWSaigMfmBdw5/z394lZBzckMzSSEJmvXDZpxdWUQzZyASj8T+0h0cYrEy7mNbrprmoT1MEdGa1ZHXwdedUsDT5L+wFtAUZ2H/AwgsWf4XLLXmendS+HkIitG0NuILz4ac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787781182; c=relaxed/simple;
	bh=bq2jxWAe7qBTX89QBOaVpXg7CVP0SDZeCsAvl4L9dio=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=MR0FBvOYH3dmRjyFAo/fmKT0oLAwkIF6YIUlX6gFuPCB36mbbtjfxTbLso9KAAeJC5OIhviCuZSode/9Xd5utlWeBLmUTHRRhDS6Ebkf4prAFzHCsulZHP5m+ioUII+o/D8bchv33WSAEB3KwczdMfYGhN7PaXkOrZwbvvECaHw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=BeC10+MB; arc=none smtp.client-ip=209.85.214.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="BeC10+MB"
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-2d52734fc41so29889885ad.1
        for <kvm@vger.kernel.org>; Wed, 26 Aug 2026 14:53:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1787781180; x=1788385980; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:mime-version:date
         :reply-to:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=hiEA3cghG/3WKW3wEvJyBXb7QBcUvHPUVDk4NRGPQ24=;
        b=BeC10+MBACahzUfbRHJMCa8VUH1aA0ZFgNCw0CoLpi/wOW0VVMsp5lvyD7Ot7LteQT
         +0QsDScO8FQ1oL1VsSOCjATBv32HBBF7N1bN8j3tQ5TrrE51BoVZtCwkTyF3IcjJBb3Y
         71nQ/F0yChrl4Ay8ddCkBvJd7C1Gr6+/xTK2q4ztY01JRvNcwT3BC8TDUBmO62H3Br3B
         dNIr2cdMxPoFZW1XtpfggOL2tLHP45U8mS6GnoFQWtFViYXyeBQr41H5iXAeAK13vBhZ
         W0BanlDeiH6SjTgEHXIMgXnkAp+JIPr2ZcqhL2n6F9olBNI52DC2CE2Lw3G2ZTCd2hD8
         E1iQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787781180; x=1788385980;
        h=content-type:cc:to:from:subject:message-id:mime-version:date
         :reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=hiEA3cghG/3WKW3wEvJyBXb7QBcUvHPUVDk4NRGPQ24=;
        b=sI2so8fuO4L3uPL/ZOzxxf4Nll/haZBR9SGUd9MTrTe+1AFW3pUaRI+komwN92U471
         SNyL8qDSLKTXIeFxuzk+rg0D90nA5UuhB7beuwQeL01yRNEQr8Qr4dQMRCZmSpp2Dw4q
         g7K3pLCTfLZD5ewakx2FRiqaVqLW9ofGdF5MhjRel4y0/zXN3pBhiGwwslTZMtMFJMj0
         UsBiu6pMweYLd+mTNcOm7R+VvdOkoawBhsTXZ5udE1TS3Jte8OrvvPbcn/X8ZQS3QJw0
         eWnK0WkUB9+uTJTdU3h/dtJq2lRFU2dbrVpnSngp6acFHkU+zuvGFc6Nxm1zAUJVQR8r
         8ltw==
X-Gm-Message-State: AFuF++mKJOWvJLhCGmHfS8ega3MbhQppDciRTU66+RrWJjlVUKNjqcbq
	0IqJP7P9hSZp85pBnALs9pUuPxIXdEwvYzmym5tbV2d0OxcG22sxbRKfO6UkS4ZLKtruPOUaQ6Y
	RtvacAQ==
X-Received: from plht13.prod.google.com ([2002:a17:903:2f0d:b0:2c0:a516:2c2])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:1104:b0:2ca:e19c:986
 with SMTP id d9443c01a7336-2d70795797fmr169299385ad.1.1787781180091; Wed, 26
 Aug 2026 14:53:00 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Wed, 26 Aug 2026 14:52:56 -0700
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.55.0.887.g758fc8c411-goog
Message-ID: <20260826215258.937210-1-seanjc@google.com>
Subject: [PATCH v2 0/2] KVM: VMX: Explicitly track TDX VMs' root level
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Rick Edgecombe <rick.p.edgecombe@intel.com>, Xiaoyao Li <xiaoyao.li@intel.com>, 
	Kai Huang <kai.huang@intel.com>, Yan Zhao <yan.y.zhao@intel.com>, 
	Binbin Wu <binbin.wu@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"

Fix a bug where a misbehaving (or niave?) userspace can configure guest CPUID
such that KVM will use the "wrong" root level for its mirror EPTs and trip the
KVM_BUG_ON() in tdx_load_mmu_pgd().

v2:
 - Rewrite the comment in kvm_mmu_get_tdp_level(). [Rick]
 - Check for kvm_has_mirrored_tdp() in kvm_mmu_get_tdp_level(), and yell if
   arch.mirror_root_level isn't also set. [Rick]
 - Separate the removal of TDX_SHARED_BIT_PWL_{4,5} from the bug fix. [Rick]
 - Fix a buring => buried typo. [Binbin]
 - Collect Tested/Reviewed-by. [Binbin, Rick, Yan] (I applied 'em only to
   patch 1, please  holler if that doesn't seem right).

v1: https://lore.kernel.org/all/20260814224509.2342760-1-seanjc@google.com

Sean Christopherson (2):
  KVM: VMX: Explicitly track TDX VMs' root level instead of guessing it
    from CPUID
  KVM: VMX: Drop TDX_SHARED_BIT_PWL_{4,5} and dedup related code

 arch/x86/include/asm/kvm_host.h |  1 +
 arch/x86/kvm/cpuid.c            | 14 --------------
 arch/x86/kvm/cpuid.h            |  1 -
 arch/x86/kvm/mmu/mmu.c          | 19 +++++++++++--------
 arch/x86/kvm/vmx/tdx.c          | 20 +++++++++++---------
 5 files changed, 23 insertions(+), 32 deletions(-)


base-commit: 76671054f9a1ff6abb976583cd8da37650acdc97
-- 
2.55.0.887.g758fc8c411-goog

