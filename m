Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF06D24EA90
	for <kvm@vger.kernel.org>; Fri, 12 Jun 2026 00:47:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781225281; cv=none; b=Or7jCiv3JVZDiurNGUOxav6YB/13DuaQQ9SIWFB3T/vE70TrrDqY/p70C6yJtm2QLwnSh+CnxQzpCn875DAWGqgAf0hY/F2shTx1/idT3jQynDBRQip/aUBt4CpsoANS2UILVhjzffU8diueMXLqwmyLnb/fvkQ/PYk1JoSqJ2A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781225281; c=relaxed/simple;
	bh=WXkiY6bv/kuwbwQK4fId+U4IQVGaomSoo4Ib7CXR/to=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=QmpuTyUuzfbzPj72Bcyx2d4bOcY0HRjJGiYfstZxeIO1J0/Ia864GoQ4+e1KvvdEWn58Zalmn73JelUAE058t61GSiOcNvq5cn5/t5DqA6WLIx/2wOTX6qA1adiuB1HzNPqgqjc3XdtZ6SsehcAXtHcJPrcKJIllyoT85w3XVU8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Tl4L+TqS; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Tl4L+TqS"
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-2c0d0516ad7so3965735ad.0
        for <kvm@vger.kernel.org>; Thu, 11 Jun 2026 17:47:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1781225279; x=1781830079; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=jI6NBpmA1o8AmWG6/9rG46dI7xMzLmXiZzWLZAYxfsA=;
        b=Tl4L+TqSkArAJCFTScr5LGWa/2QSllYhsJGZgFVmK1+0yzvprvspmGDUUxDhMQu7A8
         msjCBxvg9FyDNKYmAgv4yntvYWnaHanTCkIha6DQP7xkFqNXOKbKKjusyeJ/NQbzt1no
         pPZIgFRkhWKSJ/cZ0NK8jDXYIB43re8my0zuGB+Mfk9GDqMbGkaANp++qiMfVgRNGF4Z
         dm1Ahi4bfaMY3zdPBrP5at7hH3Ng0+aVKK1zuFqutz6G8PD5o/efFGtV+mo2SYf9MoDS
         QGZ1LVZUcSpbH9nDDFRVX0RsFD/EBBrh3m+dR61Q7cXDuu6AnJ4uhnWb0Jqrxx3XkXHH
         epUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781225279; x=1781830079;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jI6NBpmA1o8AmWG6/9rG46dI7xMzLmXiZzWLZAYxfsA=;
        b=OMcKVPcPuVFTTRsHchzb7g9IhfcdteWU4tPMHOxMRaH9nyZii95JWKUwZmKOuP6oPA
         NI58HTfXflh+P3woj/VXM6zAD/wYGdfpdmTb2JP8SI562SDmVgqM7q8iKOr899xHxswf
         NK3439RgJ7wMtRXs7ErFdLWlIvIq5PkX2MuqLfTh6pbXgbTXbAqJGR5MdpamtXJ/Eivu
         7K5PAwTHr8i/XxCooZKGqf0KWLg53DnjNjMa6D1WTxGuV4EgZ4hukN1T8Sv9QSNaN6a6
         0Q7OcDkwylsMMA7DY+O+NkDMlSt/wum51ZBTspzGiHwiGFH/svq8Jbu/0/tMqMy218fa
         TiaA==
X-Gm-Message-State: AOJu0YwutI1tvwbdgQZwENPk0Jcq1qfDah1fNMPmjY10MNKaj0ku26PW
	X5hbYfJayHwssq2jcOM7fqgNvCmNRrqU25U546RTRsLcbYzGskvvdo/Ac2XI1EZ7DGZSmM/P1XN
	dAAoJLA==
X-Received: from plrc9.prod.google.com ([2002:a17:902:aa49:b0:2b9:d494:f713])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:350c:b0:2c0:d99a:2fc
 with SMTP id d9443c01a7336-2c4106fdbf4mr7682505ad.2.1781225279003; Thu, 11
 Jun 2026 17:47:59 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Thu, 11 Jun 2026 17:47:46 -0700
In-Reply-To: <20260612004755.349925-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260612004755.349925-1-seanjc@google.com>
X-Mailer: git-send-email 2.54.0.1136.gdb2ca164c4-goog
Message-ID: <20260612004755.349925-2-seanjc@google.com>
Subject: [GIT PULL] KVM: x86: Generic changes for 7.2
From: Sean Christopherson <seanjc@google.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Sean Christopherson <seanjc@google.com>
Content-Type: text/plain; charset="UTF-8"

The following changes since commit b7fbe9a1bf9ee6c967ef77d366ca58c35fcf1887:

  Merge branch 'kvm-apx-prepare' into HEAD (2026-05-13 12:38:31 -0400)

are available in the Git repository at:

  https://github.com/kvm-x86/linux.git tags/kvm-x86-generic-7.2

for you to fetch changes up to 5804f58901af77ab507e199d31dfa263404e177c:

  call_once:: Fix typo in comment for call_once() (2026-05-26 12:28:32 -0700)

----------------------------------------------------------------
KVM generic changes for 7.2

 - Rename invalidate_begin() to invalidate_start() throughout KVM to follow
   the kernel's nomenclature, e.g. for mmu_notifiers.

 - Minor cleanups.

----------------------------------------------------------------
Jiun Jeong (1):
      call_once:: Fix typo in comment for call_once()

Peter Fang (1):
      KVM: Fix kvm_vcpu_map[_readonly]() function prototypes

Takahiro Itazuri (1):
      KVM: Rename invalidate_begin to invalidate_start for consistency

 arch/x86/kvm/mmu/mmu.c    |  2 +-
 include/linux/call_once.h |  2 +-
 include/linux/kvm_host.h  | 12 ++++++------
 virt/kvm/guest_memfd.c    | 14 +++++++-------
 virt/kvm/kvm_main.c       |  6 +++---
 5 files changed, 18 insertions(+), 18 deletions(-)
