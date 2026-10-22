Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.198
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792706143;
	b=Svp/t68ZvNlcmasiONhaohi77JP7Wp0+YozLrgPCiz/J99/kh0oMyUOFOYgXtNh89LWe
	 Eivv+/oAs7GC2bfHe9Ccf2KSXT6cxhUBb6C3ahaEMizHYtgDbMnQSCb3xnXopxvp3mY/f
	 h1tCRA3uJ3dTfzRKPpDV8Ca+xm+3RRYgAHmpjsOoAI6PoB87a0+9j1zCF122XWP8uscfn
	 v/bgra7pPgVISk1iDvo5IbdIlxyE4Xa17gmMLY7QdN8SmWaEgG/9lBVQkZb+i5ozCymTj
	 YlZCYhZUa3Yi9DwCOXSZmknRDzZuDXDRUX3iJhHYVXTVam84T1yseXANg079JPdyqYw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792706143;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Received:Reply-To:Date:Mime-Version:X-Mailer:
	 Message-ID:Subject:From:To:Cc:Content-Type;
	bh=tegwRz1xXzbYwgS4hypxT4VdLheASXK/igGbsP1RZ5A=;
	b=wZCurkp9JClUKgEvm7KiYcw8msyWU5oY4wRCV83Xx3zhzACdHeIseEkUox4Nb/e6O+l6
	 OBQaKVAI9cBjQskeNJeF+gBXg8koyfTNbv5OE94TvWnPDZfRjPIqe3DpEoEfPKIfJDZIA
	 Gf6LbbI53t7RHN+wTjSxBi+J/uPVtfsNIdZ/9a8NHUqm3GYBwjaE3U1eaYbuWOugLOY5+
	 y+jdWf8gjlm1Mje9vkaMg7YF8PJJz0oBuXrizj9f2eEqN9PXEJBtsUtDmDPnEXoPcyhyb
	 8fWdrAszkZkvEnfertIaDdz+LiQ10nmlVc9cL9/1foaOdLwmnZyrZpJl5C9B16E+jpg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=lR6z+Kp3;
	arc=none smtp.remote-ip=209.85.215.198
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com [209.85.215.198])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5947E606A31B
	for <kvm@vger.kernel.org>; Thu, 22 Oct 2026 21:55:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5947E606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=lR6z+Kp3
Received: by mail-pg1-f198.google.com with SMTP id 41be03b00d2f7-cd8b299b05fso240415a12.0
        for <kvm@vger.kernel.org>; Thu, 22 Oct 2026 14:55:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1792706143; x=1793310943; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:mime-version:date
         :reply-to:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=tegwRz1xXzbYwgS4hypxT4VdLheASXK/igGbsP1RZ5A=;
        b=lR6z+Kp3rzS2NaOU4iV1jSKT9ZgSXEq2HBMImvLfVYyvEjlPv3R4NVZG9gMYovvtu6
         Fn4bTBXzpfcGi6g7rr3I8GA2yggVGelObRxVNDo/JLZvaodNlnUi8J3SusZF9XLZfdUC
         Wgn+Xacpr0+0LgAcBYOaYDtRoqyjbNLjHpUm7zR+ldGByRNlr7EiGjJSXl422GCq1lZY
         fkV+NUkP0ZqqJkqVXGrTKWq+aTiLwTLpn28Yo1NDiNLYNGAoCSUwmJ2dch6X5Tt3fe66
         EdmYHwTEnQHYFUkFLWzxZAjmNv06g/V79UI8fe5bLoAduMFwXdRrwLe0waWv+J+UsbzP
         WNig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792706143; x=1793310943;
        h=content-type:cc:to:from:subject:message-id:mime-version:date
         :reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=tegwRz1xXzbYwgS4hypxT4VdLheASXK/igGbsP1RZ5A=;
        b=W4AaV2uFZzZ+a68UU/0fgSXI5dtSbwoFUrlkWs/KfN/T/x3+Stan6Vj7zDdkynb7/c
         3oHMHIGW1PMhPsPi64DzJJ2S+FzPFGLhcREIQvFFRAgjnP3/qYut+IJY8b6aMcKNndkn
         k/lziwRu5MgeIgGWlBBgCNoyNOwELLELc29ihquw67g1BqI/Q5OaRdvf+QlaxfRAkFTp
         A2zcdfVdd45M7/WcjboFhDC0j+ZfN/nLewypsZej3E6mc5k9LlAlMbt/RvbhN6qi0zI7
         GmgsiHhHSw4tVOWkN0FnOi1555cX7XMXzz4WhFYeqhPbHlYvUOAViZpNTq/uBUBmTANz
         759w==
X-Gm-Message-State: AFq9FYLHK2CboSWWrLRwax5M4W4FtwtKhvZZy06+Z/yTIgyST4vYl6+O
	szGcMyQGeadbhc7coEnMAQKrk5nOxdbFZey7Y6TwwsUmcnB3mZ3GekSVPXYbHVGPgTtsODbSm6P
	FIj62fw==
X-Received: from pjuv3.prod.google.com ([2002:a17:90a:d583:b0:3ac:6f46:2983])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:5743:b0:3ac:b145:8f4
 with SMTP id 98e67ed59e1d1-3adce811570mr139671a91.41.1792706142558; Thu, 22
 Oct 2026 14:55:42 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Thu, 22 Oct 2026 14:55:39 -0700
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
X-Mailer: git-send-email 2.56.0.257.gf7497c7d27-goog
Message-ID: <20261022215541.631694-1-seanjc@google.com>
Subject: [PATCH 0/2] KVM: x86: Convert all runtime WARNs to ONCE
From: Sean Christopherson <seanjc@google.com>
To: Vitaly Kuznetsov <vkuznets@redhat.com>, Sean Christopherson <seanjc@google.com>, 
	Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Stefan Teodorescu <fane@google.com>
Content-Type: text/plain; charset="UTF-8"

Convert all bare WARN() and WARN_ON() runtime usage, i.e. WARNs that aren't
strictly scoped to module init/exit, or similar, to ONCE() variants for what
should be fairly obvious reasons at this point.

Sean Christopherson (2):
  KVM: x86: Convert WARN_ON(preemptible()) to lockdep assertion
  KVM: x86: Convert all runtime WARNs to ONCE variants

 arch/x86/kvm/hyperv.c          |  2 +-
 arch/x86/kvm/i8254.c           |  2 +-
 arch/x86/kvm/irq.c             |  4 ++--
 arch/x86/kvm/lapic.c           | 17 ++++++++++-------
 arch/x86/kvm/mmu/tdp_mmu.c     |  2 +-
 arch/x86/kvm/msrs.c            |  2 +-
 arch/x86/kvm/svm/avic.c        |  2 +-
 arch/x86/kvm/svm/nested.c      | 12 ++++++------
 arch/x86/kvm/svm/sev.c         |  2 +-
 arch/x86/kvm/svm/svm.c         | 12 ++++++------
 arch/x86/kvm/vmx/nested.c      | 12 ++++++------
 arch/x86/kvm/vmx/posted_intr.c |  2 +-
 arch/x86/kvm/vmx/vmx.c         |  8 ++++----
 arch/x86/kvm/x86.c             | 18 +++++++++---------
 arch/x86/kvm/x86.h             |  2 +-
 15 files changed, 51 insertions(+), 48 deletions(-)


base-commit: 814607cd40df80d5727957adaa857e0feca43497
-- 
2.56.0.257.gf7497c7d27-goog

