Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com [209.85.215.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1AF32F30
	for <kvm@vger.kernel.org>; Thu,  6 Aug 2026 21:40:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786052454; cv=none; b=QuqS0D8gNUXeLqIJxrmrc8aKUS+29WL9PWq/iOIsqoSwM1JA0brsbCnGuDub+a6P5ZbJwpwhkmLlF6V31cMoBMugdoJ265ZKIJnYOxjMQ0Y37u50mu3AHAVflubcgaFYdDBAe+3wCwofsTSR1HRcIi+b7tt5tylV0y9VA2ksxDA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786052454; c=relaxed/simple;
	bh=hFfi9/bzTOqYAhxg+1zYLl5maIOwlrj2/PpypICuvFg=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=bsKVitSzdETf4CnaZhNTsqkOvmASeA3MFmicICEYa2QF4GdEN3jIo7g4lh5pIVGxPn9W/7uVesvPHmcrCoxpE/m14VSjjl1hGk80oldM3xQ6iC45utD1eGs1I6s3UQOD7nPDv0HUXOB4VrxSptmdEVpjE/KWEGZ1hLUPQEmWLAY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=abq2wvml; arc=none smtp.client-ip=209.85.215.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="abq2wvml"
Received: by mail-pg1-f200.google.com with SMTP id 41be03b00d2f7-cab041eced3so3906270a12.1
        for <kvm@vger.kernel.org>; Thu, 06 Aug 2026 14:40:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1786052452; x=1786657252; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:mime-version:date
         :reply-to:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=PfoPzMaHkjyJ8jnjMVEPWQUdjZWdrZ6ypP+L9ed5rgs=;
        b=abq2wvmly5K4cS7euBMNqeY1fB+naVr+eVbp501ccqmqr1D2yQ1S1BX0x67bs9gwyx
         bJPDmPf6gPzd0zcaYvrT5mOOSx7HHtKfFCT14K+nhTEN1QoQxYFu9VoE8njgrxzsE38Z
         V7g1cTXqF6z+3GZW8xLV+obzk5OCiWyEdGCqv/IF2Lki1m2P8FmBS24q7RXyO5+nhFLb
         ZErAhj+CQPvm2ogy5KU7l8mpCqb44Dk0Dqva/RdDqZQpKhB8PqgJ6eukOFlZ3ZHI7OcX
         UX0kwMf4TceP8sTiERtwOKsX4K+t0MN2wA1Cxdx2O+GhCC1xShU3JcO1FE8ol+8RZTNW
         /NUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786052452; x=1786657252;
        h=content-type:cc:to:from:subject:message-id:mime-version:date
         :reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=PfoPzMaHkjyJ8jnjMVEPWQUdjZWdrZ6ypP+L9ed5rgs=;
        b=QpmZvT00ZollBnV2zYiYb6OAexmhOzV7o0VzdNBUSoMXvQTExy0noIlHbYrDYmoFsa
         r+Dz7S2dCW/Q8mREqtaASoUOiVbXH0w/Tcs9Vzb+/tGtkOrPi5nimlF8feCho0gqOU4m
         13mW+DF8LwpEnAuv0LTmaHZqrqcGNQKAXak0C6u4sF7VVQ3G9BzlbQzHBELNnOdp4cFC
         LUCRxZkd2SnpLizVhJeKAzbEt58YuXPIR5rpk6H+KWVgoJ6gTXw0wTUuPCUg/gfvybEG
         +CsMWlr+nzVrPGBkB1qgqGQBkAU3yaG0bj3UYLelt/LDmysvz+s5d46DM9hQwOojri/w
         6k+w==
X-Gm-Message-State: AOJu0YzOXHCymsS4BMSlNK5ccSkM+i6yd9sS4oS+dmoBQx2r3f8HjZzV
	EyZ99VMlp2+ZtE2Kx6obSrbd8kwaQ116+Jgy5phOqV/q1slpe2yea0Ekl9IR4/OWy73PxlBQvMg
	o0gTMvw==
X-Received: from pgge20.prod.google.com ([2002:a63:db14:0:b0:c88:dea2:d511])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a21:3204:b0:3c3:834e:89b9
 with SMTP id adf61e73a8af0-3cb85e7370emr21993111637.17.1786052451785; Thu, 06
 Aug 2026 14:40:51 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Thu,  6 Aug 2026 14:40:46 -0700
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.55.0.679.g6767b8d81c-goog
Message-ID: <20260806214050.78058-1-seanjc@google.com>
Subject: [PATCH 0/4] KVM: x86/mmu: Fix pre-fault and map private loops
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Kai Huang <kai.huang@intel.com>, Yan Zhao <yan.y.zhao@intel.com>, 
	Rick Edgecombe <rick.p.edgecombe@intel.com>, Sashiko Bot <sashiko-bot@kernel.org>
Content-Type: text/plain; charset="UTF-8"

Fix a bug in the pre-fault path where KVM fails to reload an invalidated
MMU root, which puts the KVM_PRE_FAULT_MEMORY task into an infinite loop
(although it's breakable, so not fatal to the host).  My best guess is that
the test started failing once PREEMPT_LAZY was enabled by default.

Then harden the similar "map private PFN" to also guard against unexpected
root invalidations, because Sashiko keeps pointing out that it's theoretically
possible for that code to end up in the same type of infinite loop.

Sean Christopherson (4):
  KVM: x86/mmu: Reload MMU on *every* page pre-fault attempt/iteration
  KVM: x86/mmu: Harden "map private PFN" against unexpected root
    invalidation
  KVM: x86/mmu: Top-up memory caches when retrying "map private PFN"
  KVM: x86/mmu: Add sanity check to detect stale page faults in "map
    private PFN"

 arch/x86/kvm/mmu/mmu.c | 45 +++++++++++++++++++++++++++---------------
 1 file changed, 29 insertions(+), 16 deletions(-)


base-commit: a806d364ef288a6443a1337820ea8410a7ccc6b3
-- 
2.55.0.679.g6767b8d81c-goog

