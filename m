Received: from mail-pg1-f202.google.com (mail-pg1-f202.google.com [209.85.215.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08F0F4D8DA9
	for <kvm@vger.kernel.org>; Wed,  3 Jun 2026 22:34:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780526065; cv=none; b=P4fys7KyzL6GlBmgVeMPW8odC3O12FcUYIrAj6loICLGkWLe87tN++vh6XzBPBHpYMq7mQ7IBokW7xEQgYti/FmOsk4K8jepEltcRmOSjWgUCI0rvblA2z5NAiDod+CbCOqn63FYsNkKYQQm9bhCCyLeWZUbsEI1wcm6pZXAbso=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780526065; c=relaxed/simple;
	bh=UJMdaPk05/JurNRVA1+sx4rHnxgp8BaU2QW/eKkUZQI=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=homd+hS0tzHAwezfK0BOK16CHh3WeyokhaEw6SNt6tUJED3JvE5lnzAZdp5IJ95kLD7/z9QFXxjKoNGSYXw9CUMQhmo2eO5K+fL2DZTtbwub8NT24upwIc1CQnGgF776jNvSRqXsYJF1x8cCdcZaVZyApUsMPSDfkfjYZoFfZw4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=POvCDRNh; arc=none smtp.client-ip=209.85.215.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="POvCDRNh"
Received: by mail-pg1-f202.google.com with SMTP id 41be03b00d2f7-c8584e80bfcso24965a12.3
        for <kvm@vger.kernel.org>; Wed, 03 Jun 2026 15:34:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780526061; x=1781130861; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:reply-to:from:to:cc
         :subject:date:message-id:reply-to;
        bh=30kD1jPAUiuVtuobInSriK5ab2qtGGgy4byvobLmmHE=;
        b=POvCDRNhWlJ/VTOf8b1hIstmdRdv0pmBk9QkiGGRsgOhST0fF8h8ovSLRBhoZ4bMSy
         z1Ma6EK9Ph+a2EILNroEBFTqJFwsWzWn107/dAEp4yC7+E9rzohm1pf0N3TPuMVDiPjF
         0D2WXQiuhfOVL5QkkiSG33wm3/GXA8eNOWBtsKIBem+zY9yhYBa/a3IvnnhcvNF3TmCo
         iFmhQdSR7UKqQsLYpwmxpAQiUFVui5vfflQrcvFC9idQAdYssMwad3TkL0VKxbDaPuUu
         jleWOqK1FMa2BO2QdAPv0+F81Jmd4jytQMqAl4/q7yXv44+XtJ4+2+BLJo8lgKugHQi7
         NP2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780526061; x=1781130861;
        h=cc:to:from:subject:message-id:mime-version:date:reply-to
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=30kD1jPAUiuVtuobInSriK5ab2qtGGgy4byvobLmmHE=;
        b=DUYCnZg+L+ikMFZemxzMuLFi8T+CJArqwoLpeH1j75t4woEvvaelo5eWODlu8lHUwJ
         ACbj3v32/Dyr6WoaWLlYoFxHHnj0PU43AR58OWEx82MKZSb6KxW7GnPsb+4O1fCUZ+GX
         6Izt3skJwgkt62P2hNPFKtW3ytRK8wKaZLXGP8xZXIT//TpIG9Zd/dk9JFn2uYZCig6l
         woy3CPL1+pdDslWLj/ah/W40B5w56jSJ19dF1dplxVylbXaM3TbUtmrnh8Lbey+2wLTW
         IgOtlABCWmB6kYV4rYxmaxKY31uTz9QzkpWSwjP0wlvz2vYhxQyKdAOzJJxuAEkkS7Tk
         FviQ==
X-Gm-Message-State: AOJu0YyDvy4WY7HrWPUhSQBPXovY7CCW8TdEFyKrR6GPdpxbHJw0ynes
	nIMPCfpxJBi6SfgcNUNhJQmcvHfZawEggdlaSRYjwpvfbgpgoITaK0ulUqTyQnUwH4Aj1RcwAAX
	o1eah2g==
X-Received: from pgvc19.prod.google.com ([2002:a65:6193:0:b0:c85:9c9a:ab5b])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a21:1fc5:b0:3b4:65ad:b417
 with SMTP id adf61e73a8af0-3b4977c1efamr5848069637.45.1780526060695; Wed, 03
 Jun 2026 15:34:20 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Wed,  3 Jun 2026 15:34:16 -0700
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.54.0.1032.g2f8565e1d1-goog
Message-ID: <20260603223418.1720035-1-seanjc@google.com>
Subject: [PATCH 0/2] KVM: nVMX: Fix ept=n bugs where KVM runs L2 with guest CR3
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Jim Mattson <jmattson@google.com>
Content-Type: text/plain; charset="UTF-8"

Fix two bugs where KVM can run L2 with a guest-controlled CR3.  The underlying
flaw dates back to commit f087a02941fe ("KVM: nVMX: Stash L1's CR3 in
vmcs01.GUEST_CR3 on nested entry w/o EPT").  Past me claimed:

  Smashing vmcs01.GUEST_CR3 is safe because nested VM-Exits, and the unwind,
  reset KVM's MMU, i.e. vmcs01.GUEST_CR3 is guaranteed to be overwritten with
  a shadow CR3 prior to re-entering L1.

which was and is true, _if_ a nested VM-Exit or the unwind is reached.  If KVM
fails directly, vmcs01.GUEST_CR3 will be left pointing at L1's actual CR3, i.e.
KVM will run with legacy shadow paging a guest-controlled CR3, which is... not
good.

Note, the vTPR fix will cause KVM-Unit-Test's TPR Threshold test to fail when
run with warn_on_missed_cc=1:

  FAIL: Use TPR shadow enabled: virtual-APIC address = 8000000: vmlaunch succeeds
  FAIL: Use TPR shadow enabled: virtual-APIC address = 10000000: vmlaunch succeeds
  ...
  FAIL: Use TPR shadow enabled: virtual-APIC address = ffffffffff000: vmlaunch succeeds

due to KVM actually accessing the virtual APIC page.  Given that I'm pretty
sure I'm the only person that runs with warn_on_missed_cc=1, and that IMO this
is firmly a test bug (e.g. on bare metal I'm pretty sure there's guarantee
VMLAUNCH will succeed), I don't see any reason to try and make it "work" in
KVM.  I might try to figure out a way to make the KUT testcase play nice, but
for now I'll just ignore the failures in my test runs.

Sean Christopherson (2):
  KVM: nVMX: Move vTPR vs. TPR Threshold consistency check into "normal"
    checks
  KVM: nVMX: Don't use vmcs01.GUEST_CR3 to snapshot L1's CR3 when EPT is
    disabled

 arch/x86/kvm/vmx/nested.c | 86 ++++++++++++++++-----------------------
 arch/x86/kvm/vmx/vmx.h    |  7 ++++
 2 files changed, 43 insertions(+), 50 deletions(-)


base-commit: d4bfaa66fa171089b9b9fb2dc17af9245f2b9b34
-- 
2.54.0.1032.g2f8565e1d1-goog

