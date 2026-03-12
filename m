Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D38243B9D9B
	for <kvm@vger.kernel.org>; Thu, 12 Mar 2026 23:48:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773359308; cv=none; b=NVjSJVFA1NOmIDkrNwYOicS6usx9RHPeU/pv88joLmL9cB5RDpyvQA7PqOXCdvuC7+B1YLojb5I9DSPPa4KN28SP6866LjUFFnDqGqS4JyXxJD88QCrDMY1dspX3vjJfTsu1hJe5JDXW5faRd6bqNd349nIDe3AveniTIsez+Fs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773359308; c=relaxed/simple;
	bh=BVZni0nKYBD8XVLbMcdg8qbbgRnhsz/pBweNi42QxE0=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=AA5ZKtGLHhrtT6vMT+kXF/cIFAR7tQ6hSRNh2Z3KGKk13WA6HGfKutxxeP3qUEnqaGGLRBm4Yr+9+O7ZFYcTO0KKQi9tMw0OnXObbIcZlYy5vQ4730omRbV/UZCIY1LjUoWk8gkuLTwrWOeZG39ONqjL0CcngEh/p9DGGov7U2w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=hpAh2Qoi; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="hpAh2Qoi"
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-2aec89e1f05so5030675ad.2
        for <kvm@vger.kernel.org>; Thu, 12 Mar 2026 16:48:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1773359306; x=1773964106; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:reply-to:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kFSfb149BaH2NsTGWyytMOtjoNl/SjLtdXVYANARi8o=;
        b=hpAh2QoiFLQXCicYYu1n921d5t3xEMoXxdnaxpFH21m0eAcq2HmNxKvVFijmcRulfK
         vJrv5hsBC3jyz6hv6bJQltyQF2qPc+yPPx6G+y44dY2MwPHj3sxCR5v20TSZs66CalYf
         pDNaWnhMAmeyYzAGdTPVKSO/tbsxvG20lhG0Grk/CR53Qi+zWwc1D/tk4IOkGPuhkYG3
         I+40Wo6ZEY2K/TA+DcobcOyAgYYA+MV+ljqsrRbeVGHq6usX2djDP9wSyUUtXvA3xGMq
         2irIa+hQ4SIJj9EUeqJ3NZzWYkTy6BszkAVfKF3MW0OHTKG/vsgRSJsADxxntspSREgb
         YDUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773359306; x=1773964106;
        h=cc:to:from:subject:message-id:mime-version:date:reply-to
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kFSfb149BaH2NsTGWyytMOtjoNl/SjLtdXVYANARi8o=;
        b=K9RHVH7sWx2wES26w39x7LH7ft6nVhYJnAfE5dDzE0UPShDbmW3eApnP5GWymB++o1
         YXurTYmg9Mh+JZ3D5EdLxOyNfBRbIkSwj+xzrw0xNrVXgSxtSJnrdeB+5dTxNOe1fAWW
         3X3w8g13tdEdxKr/1e286xz+OfemSnOAiUWrRwvO9iqRZkY3BwpH6N901lv+GNyGyFbj
         3AV9kxTR4eyOQGHiGbcWD8DBGM3wjVoQXqCO3KXg6cjEEOF6ynI1E4In5SWBt8TdYmu1
         1O5Ue1HJD2sGZsLOUa8V5JrTUIvAiQEtcUXmUgJmZukQtbaOGtjlYmtmc6vk2sKlhieN
         j1EA==
X-Gm-Message-State: AOJu0YxpLYimyYrpwnLvd71t4ji42lgKGiCVRRu/vWWR/YjpESbFNJID
	5juGyXlGc3/x/yxqXRbkC2ZuaAsvgzpDuNet5E2GLEKCQHgsm2DNOrxjWoHB9cniePcuQR/j8AX
	3Ro46Ag==
X-Received: from plwh20.prod.google.com ([2002:a17:902:f7d4:b0:2ae:cad9:6741])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:37c6:b0:2ae:aca4:b163
 with SMTP id d9443c01a7336-2aeca941df4mr11372905ad.7.1773359306064; Thu, 12
 Mar 2026 16:48:26 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Thu, 12 Mar 2026 16:48:21 -0700
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.53.0.851.ga537e3e6e9-goog
Message-ID: <20260312234823.3120658-1-seanjc@google.com>
Subject: [PATCH v2 0/2] KVM: x86: Syzkaller nested_run_pending defense
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Yosry Ahmed <yosry@kernel.org>
Content-Type: text/plain; charset="UTF-8"

Stop playing a losing game of whack-a-mole with syzkaller over
nested_run_pending, and simply treat the flag as "untrusted" if userspace gains
control of the vCPU.  I.e. don't WARN if userspace _may_ have stuffed vCPU
state to force an impossible VM-Exit.

The signal:noise ratio for nested_run_pending WARNs when syzkaller is fuzzing
nVMX/nSVM is awful, and playing whack-a-mole with syzkaller is doing more harm
that good at this point.  While it's possible syzkaller could find an actual
KVM bug by stuffing vCPU state, if the _only_ symptom is the nested_run_pending
WARN, then in theory the bug should also be hittable by stuffing L2 state prior
to nested VM-Enter.

v2:
 - Put the state transition in kvm_x86_vcpu_pre_run(). [Yosry]
 - Add Yosry's review.

v1: https://lore.kernel.org/all/20260310224546.2582118-1-seanjc@google.com

Sean Christopherson (1):
  KVM: x86: Suppress WARNs on nested_run_pending after userspace exit

Yosry Ahmed (1):
  KVM: x86: Move nested_run_pending to kvm_vcpu_arch

 arch/x86/include/asm/kvm_host.h | 15 ++++++++++
 arch/x86/kvm/svm/nested.c       | 23 ++++++++-------
 arch/x86/kvm/svm/svm.c          | 16 +++++------
 arch/x86/kvm/svm/svm.h          |  4 ---
 arch/x86/kvm/vmx/nested.c       | 50 +++++++++++++++++----------------
 arch/x86/kvm/vmx/vmx.c          | 16 +++++------
 arch/x86/kvm/vmx/vmx.h          |  3 --
 arch/x86/kvm/x86.c              |  7 +++++
 arch/x86/kvm/x86.h              | 10 +++++++
 9 files changed, 87 insertions(+), 57 deletions(-)


base-commit: bfd7f4adc1230373c25e1b787a6f1ee407eb0656
-- 
2.53.0.851.ga537e3e6e9-goog

