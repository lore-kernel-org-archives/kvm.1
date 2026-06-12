Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BC1D39656D
	for <kvm@vger.kernel.org>; Fri, 12 Jun 2026 23:06:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781305587; cv=none; b=oCi9V4asR8OtgfXjpNHoxmCmeTpOC2FyNybam54Hczejj/nyDwCE0A7ZIY3yYl5r/t+jWAGGWC2Og9Vqd1mkOGEMEu5PniAzes4XQteDyx92a6CCdBbv8Tp15eWYqyqU1j6RjHEzHJvqTrbu5zJHk0zf0Kaevk3KhkQ2RN5Cuqk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781305587; c=relaxed/simple;
	bh=uFCxRDAU9GwUX6wzciKQ/GF318M3oH+qcGm4MSBbzio=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=KOas4y5xVw37iYDs3LIFQk6kYgWi8Knw+EZaAuOScS3Io2kc3FlZiVtLQfT71Lt0Sz2r5BUWF7P8v6NGn22tEded7Qo1BPN7pT9LazqIlyhPOit5R1u2Ozc5xhUXoR6w+S10fdc4Xxxvx7eDhCbkhWnrhYC6jfljxw79PLrWGWo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=B98rbjyP; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="B98rbjyP"
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-2c0a99db8dfso14625925ad.3
        for <kvm@vger.kernel.org>; Fri, 12 Jun 2026 16:06:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1781305585; x=1781910385; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:reply-to:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eCKL+Fp2i3Z3+mzvPK7vseC1644928z96Ms+24R1vAI=;
        b=B98rbjyPQsUwmVdcT5OZGHnGBtfOl6LU5LBDcg9+wLHd2Zb+Zop9QXV1r67eqTQJhV
         QDMC48AsXIkR1tz5zm5bKeVC5CGTC6nEyQ/KSoPT6Vp8ZeS5aZ7btkvdPxXjzRJXHTu9
         CPfLWVDPsorZoJJ646pYqQuEA2eSlaGspjUHhTflUrRSkuV8TGVMwQ4Lru96fut0guOL
         WVe3h5vzxZFhLX++7jCybW6dJpjeChquAyZcZLJ62bjzjPKlQ64zMKcj1iq4HZEIaCnH
         vp/R0ZxQRklsL7ZeGhEf40/Cd1h2z34RrHVDQs6JkM5DakMWIlaZzbZ//kmFONlsHTWt
         k5LQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781305585; x=1781910385;
        h=cc:to:from:subject:message-id:mime-version:date:reply-to
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=eCKL+Fp2i3Z3+mzvPK7vseC1644928z96Ms+24R1vAI=;
        b=IsV82uFAsw1/ZawGhZUEYwMyhoBSD/mpqgrAPRjwQCwhFJVXvC+imN+ANpB1JWNty8
         kyd1as8HBzvf/6Y1wycO2xwPzei6uhbQ0B0qyuS26jsSATObBrnuPLQMajpwbIo1wz01
         o6rR8Nk+bdU36lvshSzDCytUpM+ompC15cavbT8LG7l8YVpF3iu+Jox5t4LDj4M0lW0v
         CwBI3EMrp6aKUOqT66/Xyh3m0X3FHV8WInz6CKvgSqi3mBmKuga5WgrqvmzLK4ENuUhC
         wls/vKNSOZJ/s1eNHsnWqeYMd4MXqNIQmExMZu3glOoj2XqBEDh8nxB6wnhcH9vNOVwv
         347A==
X-Gm-Message-State: AOJu0Yy5LHWEKaWsTKB4HPSyVXE75geEkvLXJA3AtU4WGD97ZGLv1FAo
	DAX+5ehGchWmqERmAgGHLh2xG2588oNnfz/xmK5lFkwvVtclhfwaY3Jl/P5SYT2pMUMwu0Ro6sc
	xiJ8LxQ==
X-Received: from plbjx11.prod.google.com ([2002:a17:903:138b:b0:2bf:243c:fd7])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:2f86:b0:2c0:cb0e:ac3a
 with SMTP id d9443c01a7336-2c4134ec5d1mr51947015ad.23.1781305585257; Fri, 12
 Jun 2026 16:06:25 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Fri, 12 Jun 2026 16:06:14 -0700
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.54.0.1136.gdb2ca164c4-goog
Message-ID: <20260612230622.687665-1-seanjc@google.com>
Subject: [PATCH v2 0/8] KVM: x86/hyperv: Fix racy usage of vcpu->arch.hyperv
From: Sean Christopherson <seanjc@google.com>
To: Vitaly Kuznetsov <vkuznets@redhat.com>, Sean Christopherson <seanjc@google.com>, 
	Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzbot+5b32c49cd8f005e65654@syzkaller.appspotmail.com
Content-Type: text/plain; charset="UTF-8"

Fix a bug found by syzkaller (on a Google-internal kernel) where KVM consumes
a vCPU's HyperV structure before it's fully initialized, by concurrently
triggering PV TLB flushes (queues flushes into a vCPU's FIFO without holding
the vCPU's mutex) on a vCPU that is in the process of activating HyperV.

Harden against similar bugs by asserting the vcpu->mutex is held when using
the "normal" to_hv_vcpu(), same as we did for get_vmcs12() and
get_shadow_vmcs12() (also in response to cross-task races).  To avoid false
positives when creating a vCPU, initialize vcpu_idx to -1, and treat the vCPU
as unreachable (other than the caller, obviously) if its index is -1.

v2:
 - Init vcpu->vcpu_idx to -1, use that as a canary to detect the vCPU is
   unreachable, and allow accessing Hyper-V state if the vCPU is otherwise
   unreachable. [syzbot]

v1: https://lore.kernel.org/all/20260423140833.439512-1-seanjc@google.com

Sean Christopherson (8):
  KVM: x86/hyperv: Get target FIFO in hv_tlb_flush_enqueue(), not caller
  KVM: x86/hyperv: Check for NULL vCPU Hyper-V object in
    kvm_hv_get_tlb_flush_fifo()
  KVM: x86/hyperv: Ensure vCPU's Hyper-V object is initialized on
    cross-vCPU accesses
  KVM: Initialize a vCPU's index to '-1' while it's being created
  KVM: Move nVMX's lockdep logic for vcpu->mutex to a common helper
  KVM: x86: Treat a vCPU as unreachable if its index is invalid
  KVM: x86/hyperv: Assert vCPU's mutex is held in to_hv_vcpu()
  KVM: x86/hyperv: Use {READ,WRITE}_ONCE for cross-task synic->active
    accesses

 arch/x86/kvm/hyperv.c     | 64 +++++++++++++++++++++------------------
 arch/x86/kvm/hyperv.h     | 25 +++++++++++++--
 arch/x86/kvm/vmx/nested.h |  6 ++--
 include/linux/kvm_host.h  |  7 +++++
 virt/kvm/kvm_main.c       |  2 ++
 5 files changed, 67 insertions(+), 37 deletions(-)


base-commit: c1f7303302927f9cbf4efedf70f0512cde168c65
-- 
2.54.0.1136.gdb2ca164c4-goog

