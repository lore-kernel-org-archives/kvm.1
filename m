Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com [209.85.210.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CF47403B1A
	for <kvm@vger.kernel.org>; Wed, 12 Aug 2026 21:32:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786570334; cv=none; b=a1Io1FuK5SrHsjnsPiI+mMQKntTEVLnyeWXKljA+NtmeoZow/FUOOyo1PdaldkdpETFXGQTklwB9HnmUu4inRTWlcaCkm0G4OD80PjFOh28NRxjd1kmZ5tW+YD2PF1r+LwixT2fuz+5R4P6ymGeFpqlXuebOXoB4ArC/O6J9dj4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786570334; c=relaxed/simple;
	bh=vH42Pip6yAwemluINMec8IxpQu0j3dQULGEC5Oyah0E=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=D9Rqx/kHbNVXGgqqOvb4DV75Z7ccnJqbgVk+A9FTDotA3q817g3RR7AmiPksynjTWAmnRX2TJAuejESIBLQzSAumemp9xC+oLEUcwqPM2uf0eHQy3n5m6vFVseivDygaQztBA7QEef1EjcRxltNbwt7VBIEZApuonqKxtXuCsdU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=dxI83zqP; arc=none smtp.client-ip=209.85.210.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="dxI83zqP"
Received: by mail-pf1-f197.google.com with SMTP id d2e1a72fcca58-84e1da97175so70419b3a.0
        for <kvm@vger.kernel.org>; Wed, 12 Aug 2026 14:32:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1786570332; x=1787175132; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:reply-to:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=lS5dYJ1KUEgthzakfjc+HD1tkYed587QlN0KmyiINhY=;
        b=dxI83zqPynlfX1M3e2HNmBH8gn2m1tHs5hi9CDV7BMXRECjUVia6y/s4Szqh7HaqOc
         tg77kg+WwH+gVFwNeXKA0oFOiOWjAI16maEOLjPen+v9VyvXKk1/lfeOJncEEzC0Jf1i
         VXA20Cdv3VHW9SGdg3ng7hMhIpzXuUMwViHkEeA9m8SmpTCNkJMKHymmdGHLoHLW6YTK
         dxpmgjM5P9RIYJVflI79FvZcU/SBfv6xGlUmzZ2E/2qzInp+VWF9oiOunjhlA22UCxzH
         RvUm+xiFStwZFeHuOVrDnYJKka8wJAsX+qljzE0zL+fTTFO3HMY+P3lV05OXqQXy5LVd
         kV9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786570332; x=1787175132;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:reply-to:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=lS5dYJ1KUEgthzakfjc+HD1tkYed587QlN0KmyiINhY=;
        b=G/JhWnFmX9zeIdrkex0mgTNbP9ulHsJ+jQDN2NrBmBe8Ez6qIzSqmvhbPRW+RzUI/2
         I16sejfFQBNw0mdJC981bXeGZCRdxQonlBiSQAdoc8nRnUosJsFMe8S2fOnV6BR0/Bx6
         jHcgplSNJ19TAM7AoTjKjp9urRk1KSEdFGt0lxRGMb4ePkyNEwRn1aVTTSpS3sQ6/IfI
         G79CP+fygErx6Qtse959PdbK06uS6EWWBQLEBAkQ/nRRWIUmRbkTDgqQR/mFQj94qNCd
         mLQHGhqdC/9kCwzxnEEBsjUacQwjVF5WMNcrfhrXZhNY/cDAlo+XuaCU6umy+j4VjEn6
         DUtw==
X-Gm-Message-State: AOJu0YzqjRKwG8eT9j5gdEmuICCXp0TchkjQVAYS+x75eaiJA9Fp5eLZ
	eW8oPb3RA2zeGuJxUe9Wfa8OYcub4e0DDWx25i0zp3yAkNmj4wGI742a9Yswu9Hny9kqyzNvCvY
	ZkO60IA==
X-Received: from pfmy3.prod.google.com ([2002:aa7:8043:0:b0:847:9be8:84d5])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:b93:b0:84f:a170:4f5b
 with SMTP id d2e1a72fcca58-84fc6ce8e92mr814546b3a.8.1786570331536; Wed, 12
 Aug 2026 14:32:11 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Wed, 12 Aug 2026 14:31:58 -0700
In-Reply-To: <20260812213206.1564354-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260812213206.1564354-1-seanjc@google.com>
X-Mailer: git-send-email 2.55.0.691.gc56d675ccc-goog
Message-ID: <20260812213206.1564354-4-seanjc@google.com>
Subject: [GIT PULL] KVM: Generic and documentation updates for 7.3
From: Sean Christopherson <seanjc@google.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Sean Christopherson <seanjc@google.com>
Content-Type: text/plain; charset="UTF-8"

So the subject is a bit of a lie, as three of the five patches are x86 specific.
But two are common documentation updates, and the third has a hard dependency on
a common KVM change that might be questionable.

The potentially controversial change is to add a per-VM bitmap to track which
vCPU IDs have been "claimed", so that arch code doesn't have to guard against
duplicate vCPU IDs during kvm_arch_vcpu_create() and kvm_arch_vcpu_destroy().
The part that's a little less than awesome is that the bitmap is effectively
wasted memory once the VM has reached steady state.  But, AFAICT, it shouldn't
be a meaningful amount of memory in practice.

The alternative solution we came up with was to use another xarray so that the
tracking entry could be deleted once a vCPU is fully realized.  The consensus
was that the complexity of the xarray approach wasn't justified, even though
the added complexity is relatively small.

The following changes since commit a204badd8432f93b7e862e7dac6db0fe3d65f370:

  Merge branch 'kvm-chainsaw' into HEAD (2026-06-25 11:32:09 +0200)

are available in the Git repository at:

  https://github.com/kvm-x86/linux.git tags/kvm-x86-generic-7.3

for you to fetch changes up to b41f2ca6c06011c36b75f5d53aa17c05ed90be21:

  KVM: VMX: Fix stale PID-pointer table entry left after vCPU free (2026-07-31 15:13:31 -0700)

----------------------------------------------------------------
KVM arch-neutral and documentation changes for 7.3

 - Remove kvm_debugfs_dir if kvm_init() fails after creating KVM's debugfs.

 - Document some of the "fun" gotchas with the APIC base when creating IRQCHIPs
   on x86.

 - Add a per-VM bitmap to track which vCPU IDs have been "claimed" but for
   which the vCPU isn't yet online, and use the bitmap to reject duplicate IDs
   before calling into arch code.  This allows arch code to consume vcpu_id
   without having to worry about cross-vCPU clobbering (at least s390 and x86
   have had related bugs).

 - Zero a vCPU's entry in VMX's Posted Interrupt Descriptor table used for IPI
   virtualization when the vCPU is freed to fix a use-after-free where hardware
   will write to a freed vCPU's PID.

----------------------------------------------------------------
Dmytro Maluka (2):
      KVM: Check for duplicate vcpu_id as early as possible
      KVM: VMX: Fix stale PID-pointer table entry left after vCPU free

Tim Wiederhake (2):
      KVM: x86: Document that KVM_CREATE_IRQCHIP must precede vCPU creation
      KVM: x86: Document APIC base address constraint for in-kernel irqchip

leixiang (1):
      KVM: Remove kvm_debugfs_dir on kvm_init() error paths

 Documentation/virt/kvm/api.rst | 15 ++++++++++++++-
 arch/x86/kvm/vmx/vmx.c         |  3 +++
 include/linux/kvm_host.h       |  1 +
 virt/kvm/kvm_main.c            | 10 +++++++++-
 4 files changed, 27 insertions(+), 2 deletions(-)
