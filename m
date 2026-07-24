Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 824E629AB05
	for <kvm@vger.kernel.org>; Fri, 24 Jul 2026 17:34:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784914468; cv=none; b=OfHa0i8J4Zxu667aF31MBPCNssvHRQlGhH2feMkb58/7Qqk9prvpL2uGI5XhCtJOKMvErj+3jgWC819yqCvHQ7eFaplVmoH1e9DaxFpbe7oMz0pp4HQ9GOeIB51DAZf6HwTYzQhbOFiMJ4NwGSygsov2X0laA45vdE2mEiwIK9w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784914468; c=relaxed/simple;
	bh=Tttx+GfGd7bzQIHLrqeohaZPjOr0yLAMIQMVWIGp5BE=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=hceBndnjjuEGUQ4PvcKmZ5IzgMp8kGc6JsEPnLR0rinDUqfdzU2q9QFo6m3tQy5stSJFd8+exkietZ7lEIxbdDzIPBlZeS+K6hsTvjyp2yZd9aDoZTnJftJNF3HCDrj7WAOEMx4hYKL/j14IBNi9pl8CQw1GNuEjO8UqCbtUAcM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=qpPvEXOW; arc=none smtp.client-ip=209.85.214.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="qpPvEXOW"
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-2ccbb61893fso13929535ad.0
        for <kvm@vger.kernel.org>; Fri, 24 Jul 2026 10:34:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1784914467; x=1785519267; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:mime-version:date
         :reply-to:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=hTYhN6rGaAVoioSpjICR0A/T+42KOSJuXY48zbzHypU=;
        b=qpPvEXOWpIgSZPstfy35mg2Kelh8Rw8J/xGPq0vstA6TZoD6eEX0vchLki2zR06RHO
         fWWrhkmlMalx/sp/GNUttfifMkDJlM0MAUDAL1FXvlvc1xtyyMAP6UwRXLEPE2jm+qR9
         lwwl841SRDfaKvvSKlatcGt81NiN3t6AJyvXaAJGJ1qqvP0J2x5nLqKZhDvHM9KNJXzh
         TTRYWlOl0qCCSjim4EAg0iuIoG9fyrNxEsgTC5PaVaPtPvYbFGbH+ZoTYXcM2Nl0fFIQ
         XywlE+yTnFr+rK1J/Mi3qXlxI6jQJb0O8U4KlBFS6KOnTTyT5xmJnEK+qvwWeFny6QYR
         /3aQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784914467; x=1785519267;
        h=content-type:cc:to:from:subject:message-id:mime-version:date
         :reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=hTYhN6rGaAVoioSpjICR0A/T+42KOSJuXY48zbzHypU=;
        b=Ny9HZYfDOQLt2NCK4+dFVtqA47nTYsqNMROMJ4nHaME9As/5QquOQeN4rNIQv5oLta
         lR65960HyK6n/086VTnYRRWVFfeg0tHGNTaz74t4NsVsCVUt4e2RW3FE1dA52TScHZ1D
         dpDRJuMn1n+DDSQB7a+vNEuRaIaFcjKU40UP6ox/11MEfQuedeyFGpebMjf2zD9y325B
         UInWZBqzbsd/n+iJMY1+hHPehAq4+YapN46ZutqczAIw8XVRS58LfdKjMCXzzlw9ETli
         PxOQmCGRRDEhaqzREOt4zy5hGzTV9HFxwgrZERvT75aNyRxC9TUT8frLcANb6a0JFxtY
         mGWA==
X-Gm-Message-State: AOJu0YwaUMeAdxDBmRlbrQ2F8XjST7BC9uBSfmZ3yOel5N/bJGi8R3de
	61iPyrssHoaXRdpMLAzOBa+APzm9YAyVwdB+TWqoKAl0upJwaiThN9GwKanFhqeb0F+yus/DZ4/
	9ysk7SA==
X-Received: from pllb9.prod.google.com ([2002:a17:902:e949:b0:2ca:d246:c7c8])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:1aeb:b0:2ca:53e9:1277
 with SMTP id d9443c01a7336-2cfa6a43e63mr90982215ad.1.1784914466539; Fri, 24
 Jul 2026 10:34:26 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Fri, 24 Jul 2026 10:34:23 -0700
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.55.0.229.g6434b31f56-goog
Message-ID: <20260724173425.278753-1-seanjc@google.com>
Subject: [PATCH v3 0/2] KVM: x86: Suppress false positives on "lost" IRQs
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzbot+dd769db18693736eee89@syzkaller.appspotmail.com, 
	Sashiko Bot <sashiko-bot@kernel.org>
Content-Type: text/plain; charset="UTF-8"

Don't WARN on "lost" IRQs if the VM has an in-kernel PIC or Xen emulation is
enabled, as vPIC and Xen emulation have guest-controllable and/or VM-wide IRQs
that can legitimately be consumed/deasserted without holding the vCPU's mutex.

v3:
 - Add a helper to weed out the problematic cases.
 - WARN in the "else" path so that there's only a single conditional branch
   in the happy path.
 - Exempt Xen. [Sashiko]

v2:
 - https://lore.kernel.org/all/86078441-92eb-4461-b823-7d3539ac5859@mail.kernel.org
 - Restrict the warning exemption to the in-kernel PIC case.
 - Remove the pr_err_ratelimited() logging.
 - Preserve the WARN_ON_ONCE() for non-PIC interrupt sources.

v1: https://lore.kernel.org/all/345e9d6c-d7d9-4bab-adb3-d6a7bd27599f@mail.kernel.org

Sean Christopherson (2):
  KVM: x86: Don't WARN if IRQ disappears because it was cleared from the
    PIC
  KVM: x86: Don't WARN if IRQ disappears when Xen emulation is enabled.

 arch/x86/kvm/irq.h        | 20 ++++++++++++++++++++
 arch/x86/kvm/vmx/nested.c |  4 +++-
 arch/x86/kvm/x86.c        |  4 +++-
 3 files changed, 26 insertions(+), 2 deletions(-)


base-commit: a204badd8432f93b7e862e7dac6db0fe3d65f370
-- 
2.55.0.229.g6434b31f56-goog

