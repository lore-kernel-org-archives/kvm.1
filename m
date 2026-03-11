Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 314C9363C79
	for <kvm@vger.kernel.org>; Wed, 11 Mar 2026 00:33:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773189235; cv=none; b=GMUEzJGvBTAsSq51Wcz52FTcH9r4tGKaksVChP+hgZMDRzk4TTWVYfIke7FqqdWLWHEdkXJeszwNFcQ9aOBFCqyFJrH3XDafBEY9qPCBlJlwFu16ELuIyYlbPA6Tq4vgmGMf9rX3CezshG0yO+Xs/CP9MnGRI53zlLFgiHeMWMc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773189235; c=relaxed/simple;
	bh=pkeFz4pHI1qOD1pZsBkP4yqTDQt6pCmcAwnlYpu37+c=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=a9fOk1jeijFpSKLS8AlfuzXJwO2KVoSv2pghQjTg4LVSXakLzNcQAo5Vr/4DhDEJ6IadEWHxzxIxUrwDOXMsOobzHOSY9Xy6IwEGBIHKM72k36O0fKPbQ2patv8ZDwBHHzInCtgorkAjGQ4E5M4Wnb35JzWfadKvmCFsrMyjlV8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=wGcITFs1; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="wGcITFs1"
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-829aa961449so1846861b3a.1
        for <kvm@vger.kernel.org>; Tue, 10 Mar 2026 17:33:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1773189233; x=1773794033; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:reply-to:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Y8ZVaqYViHeyZ+pNLWaCA3L4wzmUu/H59FOP4fIvB28=;
        b=wGcITFs1X6yM+QWMZ6m7aEfsgZU+4AraMPtW8kjWyVImp4bMG7jOTe/utWSsdEKTDQ
         0xoyA80JkZPFDG636xloK6p/I356amUSOAlyf9NfbAUdZgPQWDvi38Lj0JQe42+JKmcu
         O0C53FmFP04TriQKq3YCVSFDEXAKdpBvkkVVdrRf5HR5yIEgzWLvpvEu7bfzlmR5DMNw
         DEQF1KUBPwIHVgOWwJ6wZpxyX70qjJoih+w+SJ5nTrdNVxRVEbEOAZCZpwjRjq27p9K8
         DQcgHExEa+/1ZUEnaBsc2hlYlzkLfMFCl9H88nHWN1fHYSfT/ydJSvHrjWjgAdOWPaNN
         d3Kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773189233; x=1773794033;
        h=cc:to:from:subject:message-id:mime-version:date:reply-to
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Y8ZVaqYViHeyZ+pNLWaCA3L4wzmUu/H59FOP4fIvB28=;
        b=D5bDBb4yEzL3ncMB8n5C02OfnpEztHYx6dBL5DhTwyR3LvuDYm2ATkDfcvyQ9Lrt4y
         xfmbZUxt1wKf5Q+7q6CdUlL7NjRr+mN6oGllI51DK+eqD3Qf6sZLDSEyn8yxx2VH5g3W
         ORmtQcPvbnjjbuXg9fnRnbnGeNe29ivwDs0GZbRPVfJHS4SEPugcGU4P8LjYWF+ldnY3
         Wm5h8wLRB3rUVOI7WZd9MpkpjWW0j2I6E69wsDDAOIq646e4gEkV6Z44M6G+A0ThPC46
         X55WwvfdTgqOgetc7uUxYkFPqmra+J0+A4d54M4+F88/3DjBHgJ7vW2vN2L/3aQkFpzm
         gn5g==
X-Gm-Message-State: AOJu0Yyx8ef2PhJyVO+cYpeoZ6CneO7lIL6ybzKzXMw1V4UwQUXZcmfP
	mPbHRgpcYAs6z6j4Rxa32CkqexBottOpHhNrwgPPeQjEcff2VNvIHXFq3eY8gG82d/QtipIKPd6
	rxqNAZQ==
X-Received: from pfbde20.prod.google.com ([2002:a05:6a00:4694:b0:829:9167:6d5b])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:8017:b0:829:8c23:f70e
 with SMTP id d2e1a72fcca58-829f70ac57amr636536b3a.45.1773189233364; Tue, 10
 Mar 2026 17:33:53 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Tue, 10 Mar 2026 17:33:39 -0700
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.53.0.473.g4a7958ca14-goog
Message-ID: <20260311003346.2626238-1-seanjc@google.com>
Subject: [PATCH 0/7] KVM: x86: APX reg prep work
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>, 
	Kiryl Shutsemau <kas@kernel.org>
Cc: kvm@vger.kernel.org, x86@kernel.org, linux-coco@lists.linux.dev, 
	linux-kernel@vger.kernel.org, "Chang S . Bae" <chang.seok.bae@intel.com>
Content-Type: text/plain; charset="UTF-8"

Clean up KVM's register tracking and storage in preparation for landing APX,
which expands the maximum number of GPRs from 16 to 32.

This is kinda sorta an RFC, as there are some very opinionated changes.  I.e.
if you dislike something, please speak up.

My thought is to treat R16-R31 as much like other GPRs as possible (though
maybe we don't need to expand regs[] as sketched out in the last patch?).

Sean Christopherson (7):
  KVM: x86: Add dedicated storage for guest RIP
  KVM: x86: Drop the "EX" part of "EXREG" to avoid collision with APX
  KVM: nVMX: Do a bitwise-AND of regs_avail when switching active VMCS
  KVM: x86: Add wrapper APIs to reset dirty/available register masks
  KVM: x86: Track available/dirty register masks as "unsigned long"
    values
  KVM: x86: Use a proper bitmap for tracking available/dirty registers
  *** DO NOT MERGE *** KVM: x86: Pretend that APX is supported on 64-bit
    kernels

 arch/x86/include/asm/kvm_host.h | 53 +++++++++++++++++++--------
 arch/x86/kvm/kvm_cache_regs.h   | 64 +++++++++++++++++++++++----------
 arch/x86/kvm/svm/sev.c          |  2 +-
 arch/x86/kvm/svm/svm.c          | 16 ++++-----
 arch/x86/kvm/svm/svm.h          |  2 +-
 arch/x86/kvm/vmx/nested.c       | 10 +++---
 arch/x86/kvm/vmx/tdx.c          | 36 +++++++++----------
 arch/x86/kvm/vmx/vmx.c          | 52 +++++++++++++--------------
 arch/x86/kvm/vmx/vmx.h          | 24 ++++++-------
 arch/x86/kvm/x86.c              | 20 +++++------
 10 files changed, 166 insertions(+), 113 deletions(-)


base-commit: 5128b972fb2801ad9aca54d990a75611ab5283a9
-- 
2.53.0.473.g4a7958ca14-goog

