Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4609F3FFFA7
	for <kvm@vger.kernel.org>; Wed, 12 Aug 2026 21:32:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786570331; cv=none; b=HWkAylmOwl1nZVSShGVNQsCD/AI/Xjbb4+mhJsCLwBAxkPT9LfPKwWl8pm7Tlvddj78yXBbQ6VwZM+wCikQYh4E+Hsfp1/eFGbqVOvlnn+z5tBHvHVu0kwsbwDIKB5xAphuBZkkN81oNc3cm2P1KqpqasAH/ISqwB9efsJBOSv0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786570331; c=relaxed/simple;
	bh=aFOxGhVzQic/FWI3xEtk8IbkE7UM2PKarHE98jdy0rY=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=kGD4put0cLI/z//b+pQoGRJM8zAkY0wxgOyfQLP8qUp1KJzFYdC1psxDBRcqaO6attqRiED5L07FebzY9mdatiXpNez21zq9/Ynv9WwmpeHQTqRza4UkqwkelEwzOVQEpmwPAGMT7D4WqFLEDGAKJyTBcgxBAap9r6awWK1WZTA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=dbFKvAef; arc=none smtp.client-ip=209.85.214.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="dbFKvAef"
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-2d001671a54so1719835ad.2
        for <kvm@vger.kernel.org>; Wed, 12 Aug 2026 14:32:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1786570329; x=1787175129; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:reply-to:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=c1vp8DF5tocEb4EaUT/LG0aScCVX78MBlVWsKRXci4A=;
        b=dbFKvAefstHHV6nk93aJ0IOzUCuiRqivix5w1LTFH8PVmCHZpr2HFkl+7fHvdwhUYv
         2wCvUeCadxwNhfVZPFk1TQ8QFZ6mYfWz74f1O+59u8u2a/SK3vto3Fuy1SoR25oVWHur
         yVmySl/XXj1q/7VNY783F5W5WgTJ2Tr02R8kRcq33JsU+1T8Ap8Exn7NCRG9cKSr0iH6
         X5tJpaSh15ajPU1YSxT+eXCb5xFHCdgYiMPYR1vSyAUSCZWgRtyQEooQO25bVq3BpZB3
         GDCvp9X6I30xW7AucpzStfyiKLhJlM+EED2ImMk/yhuuPpVDPRYOPvph+JGqkQa3xgva
         acEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786570329; x=1787175129;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:reply-to:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=c1vp8DF5tocEb4EaUT/LG0aScCVX78MBlVWsKRXci4A=;
        b=GhZLllabKT051gTIgTDEgu5VhcfaRDa4qHftbdJddo51grze/hPli299C5I1+OsYXY
         0w33VQaBAP4xJwdcTpC0uY8Kj53amGSVnQMDR9SHsY6/y+adKbh5nEcbsuNFVN2juvhN
         eLoCWk7noKqO1UDcK6DT1Pt1Phk7psBY8i/ODV5ojLDDlyldKyFrbo4SY1QNGV2hfdYY
         q4dC08xaVaZ/w+QLte7kyDEha/Js+dgxKCLD9kBCBUAkA9EuqtQeS0ljc9J6MCX/pg4W
         QvI/LSqjqG8hc7EvWMkEkJx1Z2jwmCfLMgd7v9k1sN981PmaDnGqd3WZ+xkIaTgt4tiK
         Ve2A==
X-Gm-Message-State: AOJu0YxVBco1SqSGnOwYAUJnVSGJgJBM1Rr0pXvMrJiaGSfcnE1eU7PY
	f9f3uFaQYIp9NFMkD1CtBo0L3w3dFeYxJjhEtwItSTqxZxZFmzfPdYrBHcRhDgGqtUU7QG5waBi
	pcTvqVQ==
X-Received: from plbki16.prod.google.com ([2002:a17:903:690:b0:2d0:f9b3:3acb])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:1a43:b0:2d0:cc92:f7a7
 with SMTP id d9443c01a7336-2d37e852f06mr11917405ad.13.1786570329303; Wed, 12
 Aug 2026 14:32:09 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Wed, 12 Aug 2026 14:31:56 -0700
In-Reply-To: <20260812213206.1564354-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260812213206.1564354-1-seanjc@google.com>
X-Mailer: git-send-email 2.55.0.691.gc56d675ccc-goog
Message-ID: <20260812213206.1564354-2-seanjc@google.com>
Subject: [GIT PULL] KVM: x86: Xen clock/timekeeping changes for 7.3
From: Sean Christopherson <seanjc@google.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Sean Christopherson <seanjc@google.com>
Content-Type: text/plain; charset="UTF-8"

Three small Xen-specific changes.  I was hoping to include a much larger pile
of kvmclock and timekeeping changes from David, hence the "clocks" name.
Another 21 patches _this_ close to making the 7.3 cut, and there's another 25
coming on top of those.

While kvmclock is on your mind (or at least, close to being on your mind), can
you weigh on on the KVM_SET_CLOCK_GUEST discussion[*]?  I hopefully, finally
understand the code well enough to be comfortable merging the code, but your
input on the uAPI would be super helpful.  Thanks!

[*] https://lore.kernel.org/all/ants4VjfAiblaWsl@google.com

The following changes since commit 8cdeaa50eae8dad34885515f62559ee83e7e8dda:

  Linux 7.2-rc2 (2026-07-05 14:44:06 -1000)

are available in the Git repository at:

  https://github.com/kvm-x86/linux.git tags/kvm-x86-clocks-7.3

for you to fetch changes up to 7d3bd21e457bd091beb982553fcf32fd9ee5929f:

  KVM: x86: Remove runtime Xen TSC frequency CPUID update (2026-08-07 09:11:56 -0700)

----------------------------------------------------------------
KVM x86 PV clocks and timekeeping related changes for 7.3

 - Remove a defunct masterclock update from kvm_xen_shared_info_init() that
   could result in corrupting kvmclock, for a lose definition or "corrupting",
   due to triggering an unnecessary switch to/from masterclock mode.

 - Skip Xen runstate time updates if time has effectively gone backwards, so
   that the guest doesn't report 100% steal time for a very, very long time.

 - Drop KVM's runtime updates of the Xen PV timing CPUID leaf, as KVM was
   updating the wrong sub-leaf, and upstream KVM will soon provide all the
   information needed by userspace to populate the CPUID field itself.

----------------------------------------------------------------
David Woodhouse (3):
      KVM: x86/xen: Do not corrupt KVM clock in kvm_xen_shared_info_init()
      KVM: x86/xen: Prevent runstate times from becoming negative
      KVM: x86: Remove runtime Xen TSC frequency CPUID update

 arch/x86/kvm/cpuid.c | 16 ----------------
 arch/x86/kvm/xen.c   | 30 ++++++++++++++++++++++--------
 arch/x86/kvm/xen.h   | 13 -------------
 3 files changed, 22 insertions(+), 37 deletions(-)
