Received: from mail-pg1-f202.google.com (mail-pg1-f202.google.com [209.85.215.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BC55371068
	for <kvm@vger.kernel.org>; Thu, 25 Jun 2026 22:36:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782426986; cv=none; b=Fcl2CWyOmhaT+LOLRE6agPyABjTS1c1Jm5pQl/TOmWyv6hAxuPL2P5awzkqktPnFM5zeq74+xqGohIZ+yItnbhUNEdKpozTArUEExg2sKGtZeY6xhMezm34SYwOsv9CXnpf5tLBI47+mSrHmYvyzHDiC31XnO2vOTu55mj+tX04=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782426986; c=relaxed/simple;
	bh=5nG2XUOYuDpiBR+eICqANAtfrT4atv3CJGP4IiwWT38=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=KX/cnITy87OBtN9toFRCwX6/Ey7pdsX8tkGeh966aQoUWa3sK2nbp/tudK6L/v81tXDLHtKhsLbAxNeL5p/Ho3o0kuCTeBv/GqMX6ZYaYCYpX86q/C8RyPiDNhTqmqcH7CW2ivVHUixKy9PGl1kqrsb6hhcef5X4AflNBFcVQfs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=jo+MzTGt; arc=none smtp.client-ip=209.85.215.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="jo+MzTGt"
Received: by mail-pg1-f202.google.com with SMTP id 41be03b00d2f7-c891ed872ddso170935a12.2
        for <kvm@vger.kernel.org>; Thu, 25 Jun 2026 15:36:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1782426984; x=1783031784; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:reply-to:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iUHnM3WkSpmD1Lwz4Juph4tt5gMwM0tIpsydVwTDLmk=;
        b=jo+MzTGtl3BtENuCYXfsq/VJzXTH8SKu7/cYpGPZu+L51NJQd+rJYC8eEa5j/PfLUd
         fXlTcSGWt9x1W+DmHaYpjTNcBtw3MczyVGOV2b37cFM1Nf2TytgbY+tEBurVr3a4U4d/
         5q+GDmLKn8tAwgReiKAqfsFUZKJGNEv04mvoMjPFlroSpRndplyXGzOP3S89Zs4qE5p5
         4HaVZb02vXelWjVJZ3ph8DaM5P1uYwK264TYYBxz4yRslN267/4xEw9eVYpfmUrVtUWL
         VqmFSPhECmck+BIFKG7b0tUYjraWbWQb0LjViCwAk/wSGOS+AlKSRFO7qF65ieUs4xE0
         NHUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782426984; x=1783031784;
        h=cc:to:from:subject:message-id:mime-version:date:reply-to
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=iUHnM3WkSpmD1Lwz4Juph4tt5gMwM0tIpsydVwTDLmk=;
        b=G6zUJAh6gTuV2F3uSUHHvR4QYgAJsnRtbvLwPgjrM9OUn7uMsetGAm3vcb1OHo1EDJ
         8DBsuhL2c4JWg+OpUM4IJLx6iyTn8hxO+KNUGCTna108IYhUyrJVG8v3ECBsWIH6eZwn
         fTFZ9hNN+2Y1kzp9AOKPDyq86bZ5dDO29AHQ9o8y03sGF5Qqc3UzeWnKc73jgyibKE7J
         8R3RgL1+WFku752iPGEi40l9coMpAZRvKJ00pd/ToyBoQQ+ldnqkgC82n8IrIuX2exCF
         XMZ0REVVHUN0v4GIPispoK1HgA6Ncl2k1emfqgzyBZxD57bLHfxiU62RUoiNiTiT+Kim
         EjNw==
X-Gm-Message-State: AOJu0Yxq1WmxZvtz1Gedwj6qjoXAsfhEmZNBKh5CfgyihVSif89MZFKo
	jE+HkHXX8fGGorRL7xS28y17u5cw7z8BD8YL2CWRpmXu2bwUKQzbRGJzQpNU1EY9sLfmvcU0zo4
	mXNLyoQ==
X-Received: from pfcf1.prod.google.com ([2002:a05:6a00:2381:b0:845:4210:eae4])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:14c1:b0:842:3841:fdba
 with SMTP id d2e1a72fcca58-845b39b09a6mr4993851b3a.6.1782426984256; Thu, 25
 Jun 2026 15:36:24 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Thu, 25 Jun 2026 15:36:13 -0700
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.55.0.rc0.799.gd6f94ed593-goog
Message-ID: <20260625223623.3376478-1-seanjc@google.com>
Subject: [PATCH v3 00/10] KVM: x86/hyperv: Fix racy usage of vcpu->arch.hyperv
From: Sean Christopherson <seanjc@google.com>
To: Vitaly Kuznetsov <vkuznets@redhat.com>, Sean Christopherson <seanjc@google.com>, 
	Paolo Bonzini <pbonzini@redhat.com>, David Woodhouse <dwmw2@infradead.org>, Paul Durrant <paul@xen.org>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzbot+5b32c49cd8f005e65654@syzkaller.appspotmail.com, 
	syzbot+5d2b94b77112148d1744@syzkaller.appspotmail.com
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

v3:
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

Sean Christopherson (10):
  KVM: x86/hyperv: Get target FIFO in hv_tlb_flush_enqueue(), not caller
  KVM: x86/hyperv: Check for NULL vCPU Hyper-V object in
    kvm_hv_get_tlb_flush_fifo()
  KVM: x86/hyperv: Ensure vCPU's Hyper-V object is initialized on
    cross-vCPU accesses
  KVM: x86/xen: Punt singleshot timer hcalls to userspace if Xen vCPU ID
    isn't set
  KVM: x86/xen: Consolidate checks on Xen vCPU ID for singleshot timer
    hypercalls
  KVM: Initialize a vCPU's index to '-1' while it's being created
  KVM: Move nVMX's lockdep logic for vcpu->mutex to a common helper
  KVM: x86: Treat a vCPU as unreachable if its index is invalid
  KVM: x86/hyperv: Assert vCPU's mutex is held in to_hv_vcpu()
  KVM: x86/hyperv: Use {READ,WRITE}_ONCE for cross-task synic->active
    accesses

 arch/x86/kvm/hyperv.c     | 64 +++++++++++++++++++++------------------
 arch/x86/kvm/hyperv.h     | 27 ++++++++++++++---
 arch/x86/kvm/vmx/nested.h |  6 ++--
 arch/x86/kvm/xen.c        | 20 ++++++------
 include/linux/kvm_host.h  |  7 +++++
 virt/kvm/kvm_main.c       | 11 ++++++-
 6 files changed, 86 insertions(+), 49 deletions(-)


base-commit: a204badd8432f93b7e862e7dac6db0fe3d65f370
-- 
2.55.0.rc0.799.gd6f94ed593-goog

