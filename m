Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.199
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793141361;
	b=43204MqfBCDZ3l0CcWBsgfbYhqFrFRnPwWytc+IUBGYzAAnmEuuq5aB+FimjQ+nBAyO/
	 eHJ9aT3WVEJ33TnA18QMqI1dihPnD8jUlKS6+BM6bvs9qg71fd3mCDtpMor9iDZuv2cUW
	 ItLA4oZRYyjzdJqeLN1kLt3AW1RdP/axRkLPopbnFrvGax5KLu8knQN+HvilNjbdnRojW
	 TorSW6PN+rL8X0Rsib5fWP7Pd1zmnm57bo1doFTLakOg79rcpNIBgB5+h/76QdZBVUbyV
	 7HL1JPDktbDhJMOzMtBYc2T03JI0tf4GlBX3sK+gZG2RB6EA5ANKstwZ3vzzOuCIbCw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793141361;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Received:Reply-To:Date:Mime-Version:X-Mailer:
	 Message-ID:Subject:From:To:Cc:Content-Type;
	bh=0siHLmY7jqw5ijMhn2w+ZHZaBh8kJXscofyY+4DEBpE=;
	b=X/jeT0thDf3nOAy9b2o29IU1UlsF5fVG+0JST4aDI2bKG5iSsSL1279xk+9vFFu7cyBo
	 3Y6+kMfJhfBJQrN8U/gD4mmzVaj8//NZaaP/Mi/ay8F1hbbnwrgYuC4E62bG287RnbTg2
	 61ihqIlGHu7xFIK9+41qfClisJg1iPHErZc80QvKVNq4eSlaIkoYhieXNSHA8+rPxYSJj
	 2ZqZLk7ESqWjTaUPddhw4pInTtgW14ry9g1OF+MQK4kWZO8ivq2qm2H1z4wnclxSNwcJG
	 RJGIpp27SvLshQpruuk/wMMclL4C6SDXYu8JFVy2ecEXL1c/5B9YWnxAE5HeXHtGKfg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=VZZV2ut1;
	arc=none smtp.remote-ip=209.85.214.199
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65F76606A31E
	for <kvm@vger.kernel.org>; Tue, 27 Oct 2026 22:49:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 65F76606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=VZZV2ut1
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-2e954d87b48so4504305ad.2
        for <kvm@vger.kernel.org>; Tue, 27 Oct 2026 15:49:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1793141360; x=1793746160; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:mime-version:date
         :reply-to:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=0siHLmY7jqw5ijMhn2w+ZHZaBh8kJXscofyY+4DEBpE=;
        b=VZZV2ut1CVciSEcV9+PNFaIetu+19iAElwLaOb8ab1I3FLxhslzz7Ltzkel+6wWzlt
         kusVKaJEPAMD1ehX8ZoYfNoU/86+XpSTWrx0aGp2XIiO5mxaQFK4GZwQ3VtuKM1yOjGc
         zRyPE3lFt07XfWAgU9aY883oBxLTH3L+aK6QeLcVadWOIIxTeStdIedew1vmQFwfO8HP
         oyzaZ4LfdgiGY/fZk+tO2FoUsq10A9H89M1MjHmRFJz6ag77KK0om5VTLPZAyw8UGXQJ
         1FR1Vt7rPJwxhfYCOjnbWirra6VQuBwZ/s6fvBMMsLykJdgyd7a6PkklJqSPQBFxpFCk
         iEGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793141360; x=1793746160;
        h=content-type:cc:to:from:subject:message-id:mime-version:date
         :reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=0siHLmY7jqw5ijMhn2w+ZHZaBh8kJXscofyY+4DEBpE=;
        b=028RvGk07dlHGYsG0KAAzL94wd1SX6CS8qeRrlsyqx5WB3HBUFDNXV6adRBxD3XvxB
         +NZqcUtGZHkmuZAoY/lMj9kn5Md0IO04CyJT8GNFSfcQjvZsom+qkLWay+wOX98EZykL
         mvMLdmeSlutR7FpC9cj2iunYWzpatLVJV3emeXyiKxVBazU3BJrHV1Hc91sjjNv1C4l4
         tlYiwEs2xVHlTz89+gPDxBqJdulp0fGTe9PGuRq/4DFTJ6eFcPPX9bydDfmNxAmD3GKW
         MpH/7MY1UzvOvfo9W5aXilZW6/GUM2IKKeI5+GmeFmWQEy7Y9J3CL/5IAz8kHK7iTRNx
         13wg==
X-Gm-Message-State: AFq9FYLmrRCAdr3BxSf486aV+E/DTqAuGRHhAbroqYqSachh+zHQymQC
	P72iqolzI7sQB0om/1MaXYPByrAWZZo4ZKoLOXtu6NUub6EzI4Efemo83RypwB1r3YGtcUfmjIv
	ZFartqw==
X-Received: from plhx12.prod.google.com ([2002:a17:903:2c0c:b0:2ea:829f:27a8])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:d541:b0:2e9:77c0:c7ab
 with SMTP id d9443c01a7336-2eb003c917amr7068955ad.29.1793141359612; Tue, 27
 Oct 2026 15:49:19 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Tue, 27 Oct 2026 15:49:08 -0700
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
X-Mailer: git-send-email 2.56.0.307.g5fe7bd680c-goog
Message-ID: <20261027224914.1574319-1-seanjc@google.com>
Subject: [PATCH v2 0/6] KVM: x86: More EFER.LMA vs. CR4.PAE fixes
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Sashiko Bot <sashiko-bot@kernel.org>
Content-Type: text/plain; charset="UTF-8"

Revert a change I made years ago to allow userspace to stuff EFER before
configuring guest CPUID, as configuring CPUID and feature MSRs before anything
else is now a hard requirement (though I suspect I was just a bit overzealous
at the time).  The biggest problem with that change, other than creating what
should be impossible state, is that it also bypassed this check:

	if (is_paging(vcpu) &&
	    (vcpu->arch.efer & EFER_LME) != (efer & EFER_LME))
		return 1;

which was kinda sorta intentional?  I assume the idea was that userspace could
stuff CR0 vs. EFER in any order.  Except that in doing so, userspace could get
impossible state in CR0+CR4+EFER (in the aggregate, not in any one individual
register).  KVM doesn't advertise MSR_EFER as an MSR that needs to be
saved/restored, and AFAICT no VMM manually does that, they all just use
KVM_{G,S}ET_SREGS{,2} (which is what we want).

So, hit the "I'm feeling lucky!" button and simply revert the misguided
commit.

Patch 2 plugs a hole where userspace can get at the "wants_to_run" logic in
svm_set_efer() via KVM_SYNC_X86_SREGS, which is "fine" for now, but would let
a misbehaving userspace trigger the KVM_BUG_ON() added in patch 3.

Patch 3 is more hardening.  Rather than pend a triple fault, which is flawed
because (a) KVM still yanks the vCPU out of L2 without going through a normal
nested VM-Exit and (b) there's a window where KVM can do stuff, e.g. init the
MMU, before the triple fault request is handled, immediately synthesize a #GP.
The only reason I didn't go with a #GP the first time around is that I didn't
want to bleed EFER_SVME information into the common set_efer(), KVM effectively
doesn't allow kvm_x86_call(set_efer)() to inject faults, and the vendor version
is used for many flows, whereas set_efer() is strictly used for WRMSR emulation.

Patch 4 is also more hardening, to try and detect+prevent EFER.LMA from going
stale.

Finally, update the EFER selftest to match the new #GP behavior.

v2:
 - Disallowing clearing SVME via KVM_SYNC_X86_SREGS if L2 is active. [Sashiko]

v1: https://lore.kernel.org/all/20261022223052.646891-1-seanjc@google.com

Sean Christopherson (6):
  Revert "KVM: x86: Skip EFER vs. guest CPUID checks for host-initiated
    writes"
  KVM: x86: Reject clearing EFER.SVME via KVM_SYNC_X86_SREGS if L2 is
    active
  KVM: nSVM: Synthesize #GP instead of SHUTDOWN if L2 attempts to clear
    EFER.SVME
  KVM: x86: Recompute EFER.LMA instead of inheriting the current value
    on EFER writes
  KVM: selftests: Update nSVM EFER test to expect #GP when clearing SVME
    in L2
  KVM: selftests: Expect failure when trying to set EFER that violates
    vCPU model

 arch/x86/kvm/msrs.c                           | 53 ++++++-----
 arch/x86/kvm/regs.c                           |  4 +
 arch/x86/kvm/svm/svm.c                        | 15 +--
 .../selftests/kvm/x86/svm_nested_efer_test.c  | 95 ++++++++++---------
 4 files changed, 92 insertions(+), 75 deletions(-)


base-commit: 7e60162b16f9da0d2fa83da5c1723b6853a0ac1d
-- 
2.56.0.307.g5fe7bd680c-goog

