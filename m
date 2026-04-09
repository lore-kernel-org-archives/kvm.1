Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com [209.85.215.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A09D63A451E
	for <kvm@vger.kernel.org>; Thu,  9 Apr 2026 23:56:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775778988; cv=none; b=Gyb7wA6I4Tftu9KyUWxtYBwxHwBO5AzwiBTN83g/y0uhsLojIvDBAxL4pcrQqMrW40CRWmHGqx//hkSS8CJx/J8wXZXGg4U4lmcqf8ejVO+0l6P1qPpKsC1IIRq9nBBj9szUUTUwtK6Tk/eqFZWa16G7XHp0fCfP5QEIOD55LWM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775778988; c=relaxed/simple;
	bh=2lhBG9TY+4ojK6dgAOdtY9DGnJugZWv6r6JqkD7Ezu0=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=jDEN3if/egVvdMbzTxLoftAyhHe1CfYU/fDJ1Zb8jFwnkmjd1+gfzjo/8eq9EkQ1MiewqAFd1Cv8I/+L5wFXKVjOk9AiOzN9IwQzvj34PF/Q/kt4q7vpVrJsOQM2N9IYcHvpgck+xPD4kRfu2Iy9n82rEbGCX+43tMtap+3wmgs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=DVs1gFfB; arc=none smtp.client-ip=209.85.215.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="DVs1gFfB"
Received: by mail-pg1-f201.google.com with SMTP id 41be03b00d2f7-c76c6280732so1773018a12.0
        for <kvm@vger.kernel.org>; Thu, 09 Apr 2026 16:56:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1775778987; x=1776383787; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:reply-to:from:to:cc
         :subject:date:message-id:reply-to;
        bh=K+kaNqjhmte9OZJSBtFJ9eO5ct5zR5+r5+O4DtRVzTE=;
        b=DVs1gFfBNH58opws1Gq/g0qX0YRCcKq308mJ97igb/n8LM8jUn+tSjRafpqJUXraFj
         p7UdU0udSlpfxqBzojJUWCU98BNsdoJsdWuwb2N7M27N74Ap29oR48lcmWINUMeOsknO
         I3SBzjjeKOR29urBDJC/PUfHhvJdltSFJEg2XJOIluByjTz6rAzXEKSP5ZBsE3hTwXYy
         ZsFJQiV6FyFTseLIBxwo8NyBMopbVkRzguiRJAGmUOM2O3ZfuJHmNmBD1nRXUzHS4Jnv
         xAGokifG+TvI2gnDelfhIVnjECY6UuvrVIwNkaiqmPCFLvW+YdqOX9UKPP9xvXdM48Vm
         Q2mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775778987; x=1776383787;
        h=cc:to:from:subject:message-id:mime-version:date:reply-to
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=K+kaNqjhmte9OZJSBtFJ9eO5ct5zR5+r5+O4DtRVzTE=;
        b=d5KsHrPS7SQWDDDAPUV5/RYq3Ly5znsKIgD3RhK8vdyXDBj/sreVkbYEXgtaRvASx2
         /4+Dtk/plH3KUm+PRDYnwp8gy8Uq0BCCLBqMIV9V3pWllKXZpi2dmp3w3ru9CWu7JTVD
         cdoLe7t8wSkEKpNB2T3DhBwwcCeJY+tRh++eFp61lV3K+RTa8bknydfBzFPb6DTlzdtD
         qlhKvVMs+ge2khsy9h+p2WGHMO/8Bq/vLmMbZxZqMGk0th6CyQlkCmATStmBmJtBUNHX
         kHm8HbfFxxfrL0N5sLhSP2HEu+M2wO0EH8sFP9QOKNu0KA1fClYoOZj9yqequyoq8ULn
         fVjA==
X-Gm-Message-State: AOJu0YzlYFmr3PSLzAupiK7Qmh/7ADeZr73keZHnClh/7oISYttdH86q
	QMEzG/+oUMBiH78riA4+iGuUd7whAqtXPqIoWRIF1w3D0cZXe5MHyX4UZb+riBjKyvFpBQzjNx3
	oYXinwA==
X-Received: from pgbfp6.prod.google.com ([2002:a05:6a02:2ce6:b0:c76:a6b1:ed23])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a20:914a:b0:395:ccae:d494
 with SMTP id adf61e73a8af0-39fe3d88146mr967624637.20.1775778986744; Thu, 09
 Apr 2026 16:56:26 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Thu,  9 Apr 2026 16:56:11 -0700
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.53.0.1213.gd9a14994de-goog
Message-ID: <20260409235622.2052730-1-seanjc@google.com>
Subject: [PATCH 00/11] KVM: x86: Clean up kvm_<reg>_{read,write}() mess
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>, 
	Vitaly Kuznetsov <vkuznets@redhat.com>, David Woodhouse <dwmw2@infradead.org>, Paul Durrant <paul@xen.org>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Yosry Ahmed <yosry@kernel.org>
Content-Type: text/plain; charset="UTF-8"

Add proper, explicit "raw" versions of kvm_<reg>_{read,write}(), along
with "e" versions (for hardcoded 32-bit accesses), and convert the
existing kvm_<reg>_{read,write}() APIs into mode-aware variants.

This was prompted by commit 435741a4e766 ("KVM: SVM: Properly check RAX
on #GP intercept of SVM instructions"), where using kvm_rax_read() to
get EAX/RAX would have (*very* surprisingly) been wrong as it's actually
a "raw" variant that doesn't truncate accesses when the guest is in 32-bit
mode.

Aside from my dislike of inconsistent APIs, I really want to avoid carrying
code that's subtly relying on using kvm_register_read(...) when accessing a
hardcoded register.

Fix a handful of minor warts along the way.

Sean Christopherson (11):
  KVM: SVM: Truncate INVLPGA address in compatibility mode
  KVM: x86/xen: Bug the VM if 32-bit KVM observes a 64-bit mode
    hypercall
  KVM: x86/xen: Don't truncate RAX when handling hypercall from
    protected guest
  KVM: VMX: Read 32-bit GPR values for ENCLS instructions outside of
    64-bit mode
  KVM: x86: Trace hypercall register *after* truncating values for
    32-bit
  KVM: x86: Move kvm_<reg>_{read,write}() definitions to x86.h
  KVM: x86: Add mode-aware versions of kvm_<reg>_{read,write}() helpers
  KVM: x86: Drop non-raw kvm_<reg>_write() helpers
  KVM: nSVM: Use kvm_rax_read() now that it's mode-aware
  Revert "KVM: VMX: Read 32-bit GPR values for ENCLS instructions
    outside of 64-bit mode"
  KVM: x86: Harden is_64_bit_hypercall() against bugs on 32-bit kernels

 arch/x86/kvm/cpuid.c          |  12 ++--
 arch/x86/kvm/hyperv.c         |  24 +++----
 arch/x86/kvm/hyperv.h         |   4 +-
 arch/x86/kvm/kvm_cache_regs.h |  34 ---------
 arch/x86/kvm/svm/nested.c     |   8 +--
 arch/x86/kvm/svm/svm.c        |  17 ++---
 arch/x86/kvm/vmx/nested.c     |   8 +--
 arch/x86/kvm/vmx/sgx.c        |   4 +-
 arch/x86/kvm/vmx/tdx.c        |  18 ++---
 arch/x86/kvm/x86.c            | 125 +++++++++++++++++-----------------
 arch/x86/kvm/x86.h            |  69 +++++++++++++++++--
 arch/x86/kvm/xen.c            |  39 ++++++-----
 12 files changed, 193 insertions(+), 169 deletions(-)


base-commit: b89df297a47e641581ee67793592e5c6ae0428f4
-- 
2.53.0.1213.gd9a14994de-goog

