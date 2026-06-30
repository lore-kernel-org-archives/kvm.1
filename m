Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAD23330666
	for <kvm@vger.kernel.org>; Tue, 30 Jun 2026 22:56:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782860183; cv=none; b=NuZPsk5ueVwUHYccj21MZYj7JfNa/syZHFlN1+ETMfCh+djcTiW+BQ9wCQDsVUfFsvsHZKWfYPGnC3Suas1vZi2htMvgLLqn5YN58/12zFTSB0y8101FePaHUpvqy019cqCkQP2wySzPnvSWA58N/xGICAdhOqUYeo4nYVuE6GA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782860183; c=relaxed/simple;
	bh=3dhF5axIHLIcizyRVThB1cZi5vVwf0DhLX9waRkeqeE=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=K4szjqUanHJhTLLdmHWPsTuPDxJsXxVtxX2ZFObLbaDV9wtV8Xt2zksMEHMy4YerSAC/KgdUo0s37CQn1O7BlmfRzUqtVszj91lI2CeAdPGW1+cc7SW6fo7gVuWqj1FIbbArr1cZZ9pcW5IFLgcTq+y93UuiRnzpWgQHwBQH4eU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=gnHxXMVt; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="gnHxXMVt"
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-2c8018f11fbso501085ad.3
        for <kvm@vger.kernel.org>; Tue, 30 Jun 2026 15:56:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1782860181; x=1783464981; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:reply-to:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oo/mz7t7LEgPncAnu7YVYVMXyarcgIYYjWbUGGA1Ors=;
        b=gnHxXMVt5jlv+u8+AAwdEJZMPP3ydw/mYd8oulHqrh627f0hhpJAeBsGHxaDET92Op
         JcVA7LAKk9kvwldKJVk8NLW9Lal/1lVBwTpmdBd+/1eSoJAsm4b4JPkboIN1/pqUim98
         b48ZXAkl27lzWocQqb7x7ThUUk4ZV2sEAcXzwCKONNToH/J2fVT5cg/X7PFIXxFo+alP
         UU2B1ywKWGHQIxLmIHyccnsFFQGzLcsXeE0Z2t9VxWkL++MmhWQJ0lg7u9JQ8B8U/xHG
         ejqd5/N+LW2ynVoCljU2/QFA0Oasnm1bWUqzstdFgvLL2v1t2+OGaZVdLgv3clBEDh91
         hq4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782860181; x=1783464981;
        h=cc:to:from:subject:message-id:mime-version:date:reply-to
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=oo/mz7t7LEgPncAnu7YVYVMXyarcgIYYjWbUGGA1Ors=;
        b=ljGWnIB95u2StQlZgqpmCauFpMYj4sS/o2RD+J2mXrnWdKO8vRjGF184dXhAm8725x
         60u4BlHyk0iRs2FFcstUGP0bOd/jQFpDOrorideUaIYghMS0Qn6jMhJZfMJ1v/dKF7MP
         P8U2nYTNzrAWxuX6RXrCWJDkwZjtB4dwneER9KGIA3lEXptEywh3rsqAUmq/FKkQabcD
         +nTczJd0zKsvo083nWyxBF8cD5TtFiTZZRUUab9TP2bXAtvl8cBFzY14MJELXeOZZU+X
         tynjiBsg8PY5caHym4EaITh4pvWzZ3LPMDN3LfaIHAd/PAGUffG0jTLWw7jBfOgIru9I
         16ig==
X-Gm-Message-State: AOJu0Yxv+xbjVLTz/wJW+wafiZuUcobMj03hO7+lhRP4C0VNQvPxjJ8u
	ML2mL4Jwj9u66+hTEoeVutxdiX6wS/J8cO8p2/pPryQvbKoXCYpKF/+RXMew8fx6Zv1X4t+6el6
	jLEOgpg==
X-Received: from plbmw14.prod.google.com ([2002:a17:902:ff8e:b0:2c7:fe56:b07c])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:d549:b0:2c9:e5e6:8621
 with SMTP id d9443c01a7336-2ca2e718688mr47137755ad.25.1782860180717; Tue, 30
 Jun 2026 15:56:20 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Tue, 30 Jun 2026 15:56:07 -0700
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.55.0.rc0.799.gd6f94ed593-goog
Message-ID: <20260630225619.511632-1-seanjc@google.com>
Subject: [PATCH v4 00/11] KVM: x86/hyperv: Fix racy usage of vcpu->arch.hyperv
From: Sean Christopherson <seanjc@google.com>
To: Vitaly Kuznetsov <vkuznets@redhat.com>, Sean Christopherson <seanjc@google.com>, 
	Paolo Bonzini <pbonzini@redhat.com>, David Woodhouse <dwmw2@infradead.org>, Paul Durrant <paul@xen.org>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzbot+5b32c49cd8f005e65654@syzkaller.appspotmail.com, 
	syzbot+5d2b94b77112148d1744@syzkaller.appspotmail.com, 
	David Woodhouse <dwmw@amazon.co.uk>
Content-Type: text/plain; charset="UTF-8"

Fix a bug found by syzkaller (originally on a Google-internal kernel, but now
on upstream as well) where KVM consumes a vCPU's HyperV structure before it's
fully initialized, by concurrently triggering PV TLB flushes (queues flushes
into a vCPU's FIFO without holding the vCPU's mutex) on a vCPU that is in the
process of activating HyperV.

Harden against similar bugs by asserting the vcpu->mutex is held when using
the "normal" to_hv_vcpu(), same as we did for get_vmcs12() and
get_shadow_vmcs12() (also in response to cross-task races).  To avoid false
positives when creating a vCPU, initialize vcpu_idx to -1, and treat the vCPU
as unreachable (other than the caller, obviously) if its index is -1.

v4:
 - Route non-timer hypercalls at the very beginning of kvm_xen_hcall_vcpu_op()
   so that KVM doesn't unintentionally resume the guest on bad input (which
   might not even be bad since KVM would misinterpet the input). [Sashiko]
 - Suck less at unwinding on failure, i.e. invalidate the vcpu_idx on any
   failure during vCPU creation. [Sashiko, syzbot]
 - Reference U32_MAX, not -1u. [David]
 - Add a compile-time assert to ensure XEN_VCPU_ID_INVALID can't collide with
   KVM's range of legal values.

v3:
 - https://lore.kernel.org/all/20260625223623.3376478-1-seanjc@google.com
 - Reset vcpu_idx back to -1 if adding the vCPU to the xarray fails. [syzbot]
 - Use the safe accessor in kvm_hv_has_stimer_pending(). [sashiko]
 - Explicitly initialize vcpu->arch.xen.vcpu_id to XEN_VCPU_ID_INVALID, and
   punt singleshot timer hypercalls to userspace if the vCPU ID hasn't been
   set. [sashiko, David]

v2:
 - https://lore.kernel.org/all/20260612230622.687665-1-seanjc@google.com
 - Init vcpu->vcpu_idx to -1, use that as a canary to detect the vCPU is
   unreachable, and allow accessing Hyper-V state if the vCPU is otherwise
   unreachable. [syzbot]

v1: https://lore.kernel.org/all/20260423140833.439512-1-seanjc@google.com

Sean Christopherson (11):
  KVM: x86/hyperv: Get target FIFO in hv_tlb_flush_enqueue(), not caller
  KVM: x86/hyperv: Check for NULL vCPU Hyper-V object in
    kvm_hv_get_tlb_flush_fifo()
  KVM: x86/hyperv: Ensure vCPU's Hyper-V object is initialized on
    cross-vCPU accesses
  KVM: x86/xen: Always route non-singleshot-timer vCPU hypercalls to
    userspace
  KVM: x86/xen: Consolidate checks on Xen vCPU ID for singleshot timer
    hypercalls
  KVM: x86/xen: Punt singleshot timer hcalls to userspace if Xen vCPU ID
    isn't set
  KVM: Initialize a vCPU's index to '-1' while it's being created
  KVM: Move nVMX's lockdep logic for vcpu->mutex to a common helper
  KVM: x86: Treat a vCPU as unreachable if its index is invalid
  KVM: x86/hyperv: Assert vCPU's mutex is held in to_hv_vcpu()
  KVM: x86/hyperv: Use {READ,WRITE}_ONCE for cross-task synic->active
    accesses

 arch/x86/kvm/hyperv.c     | 64 +++++++++++++++++++++------------------
 arch/x86/kvm/hyperv.h     | 27 ++++++++++++++---
 arch/x86/kvm/vmx/nested.h |  6 ++--
 arch/x86/kvm/xen.c        | 43 +++++++++++++++-----------
 include/linux/kvm_host.h  |  7 +++++
 virt/kvm/kvm_main.c       |  8 +++++
 6 files changed, 99 insertions(+), 56 deletions(-)


base-commit: a204badd8432f93b7e862e7dac6db0fe3d65f370
-- 
2.55.0.rc0.799.gd6f94ed593-goog

