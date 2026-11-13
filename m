Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.72
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794577844;
	b=yFSATRlnPrn2/LJ6+CdLH4lcGfQa1CeDImREDHQv5CDA3iVa5P5UKW/drpkGJN3mV7n/
	 bILlpRwQF4kkA4i/WOIo3RYFrvMlR/739q8+nGrMkyOXKSG5OU7wZbI21tQEFpeHCR3Ei
	 7LixK5PaW6v8iC+w9jarcKhuRqoNEhikIRgQdNFbgc1Wroq0Cshn+kz8PO3RWn0c27pl1
	 6GNCi8MYmuQaV+lU0CSBxWyoB1K6lMn44QGGrfkU8YGoVkBlWW7Irt5wlbihsz20ExVL7
	 iNVp+iz+ktMQ1K5WnPm1zEoq64OULzG2MG+5dwDSrcpcw5+3kB3t8sAMHyhebPITOhg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794577844;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Received:Date:In-Reply-To:Mime-Version:
	 References:X-Mailer:Message-ID:Subject:From:To:Cc:Content-Type;
	bh=7KC/jzhA6RLmbmW13sveH0g3SUGHoHCdp6LEjm+AauA=;
	b=avOzh/o/K4C72bIfV6OURwgwkccO/BNmpmDCSRyoavqltbwW2wH0VCrYCXy+AWuLY2Tq
	 iaEVKSr2lrVic/yiJ1ZiUth4OH0GMcAFU4UvykRyfOhcWUELFrbw4MF2Mofu9H3E/KtgK
	 xXu3IEWJYtVGAhxeDbvNnoetv7kLD4wRxvruDbsM/fiZXPKxMOIqyex2sbll9/qOQH7qA
	 BZvwpiQH0YCYJhd+3QHYjgUkKHBRq54TSlt54ba6cOf6T6puZRG1VKtOyyUP9fUan09Au
	 AVhZgzVbThCM7gJT0F4ZcgXnpEWHG0V1gykGJcFHyBxoMK/eMqH3UGazZ9qv87gnZ/Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=LK9865A7;
	arc=none smtp.remote-ip=209.85.216.72
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com [209.85.216.72])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86188606A33E
	for <kvm@vger.kernel.org>; Fri, 13 Nov 2026 13:50:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 86188606A33E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=LK9865A7
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-3b18741aaf8so1578373a91.2
        for <kvm@vger.kernel.org>; Fri, 13 Nov 2026 05:50:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1794577844; x=1795182644; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=7KC/jzhA6RLmbmW13sveH0g3SUGHoHCdp6LEjm+AauA=;
        b=LK9865A7WHNj6wG6aHXKfytG49uKqrrIecj/DM0KFF2BEoXB6jQtAKHJV9J4U6GLPD
         GJQKs/hQyDFPXvc2Al65XEQ8rXHPcyBAGhtT2/0Wr7u23UB1pPAVz9DIiXva0Pihxa7u
         4VB8Yarc6Zo3/bMMPYuuwzlbEJ+qaKrpb4tOCReQOUX10chiYIO0BpobYF335pkq5V0o
         VoWjM83ZJQx9E6trhgacw6QXaGeJbTXx5IH7gDjrX4ryiafYeGyCtU3klbVsW/4KlHsz
         Hf1UaQUhZzzbKM9J/hstYCzEZy4wiv6qdaZAcDU0WuUCrGHoAIZOvk3bE+tsxBrBFTw9
         kRUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794577844; x=1795182644;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=7KC/jzhA6RLmbmW13sveH0g3SUGHoHCdp6LEjm+AauA=;
        b=Tl1XrjE6HVaQW8XkGHivw955/nRwRN/zrjZfBywKottOkYmvWfPdhQ/xDlmEhkRNuH
         IrPG4r2XwYGPaMV0EBflFzxKZUhg9K+bshQydwO8Syy4jWCSqbxEgmojcph0bPij0LxG
         et0RtQN95BVJzVbAXc+M16HqfNmQI2YZvVI/wX8JaHSvGz+vyGh+wpD0L910TnHHF+T+
         rDGuFKIbjncdqY/vnLO4IvInbuqgQVILGHas6A/CB9Db/KvMF12qI/ZPa4OdVv30Yymz
         LxkWl/bfV2AGOYonVEAqpHgUCSz/r5sEPs/RenCnyUzKISE/dEJZZhf6+L0vPshQK0AI
         5NpA==
X-Gm-Message-State: APuU4Z+NNI4JWyNeiwe7NJzueM/52RtMA1G85mDeDwoUhh5Zy6bjUIEZ
	IVdobqArz6WjYccz2PVurjReIxRLIjZGuGgB5R3R/HZh9vn04ko2718RBom9gHFsPLMMTsJL6c0
	UQg0Gfg==
X-Received: from pjbse4.prod.google.com ([2002:a17:90b:5184:b0:3ad:c8d8:70c3])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90a:e7c6:b0:3ac:d79f:8229
 with SMTP id 98e67ed59e1d1-3b1b0d55ce6mr2419927a91.61.1794577843489; Fri, 13
 Nov 2026 05:50:43 -0800 (PST)
Date: Fri, 13 Nov 2026 05:47:00 -0800
In-Reply-To: <20261030212721.2606393-1-seanjc@google.com>
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <20261030212721.2606393-1-seanjc@google.com>
X-Mailer: git-send-email 2.56.1.703.gf848ed807c-goog
Message-ID: <179441820022.80329.1253216692880356989.b4-ty@b4>
Subject: Re: [PATCH v3 0/7] KVM: x86: More EFER.LMA vs. CR4.PAE fixes
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Sashiko Bot <sashiko-bot@kernel.org>
Content-Type: text/plain; charset="utf-8"

On Fri, 30 Oct 2026 14:27:14 -0700, Sean Christopherson wrote:
> Revert a change I made years ago to allow userspace to stuff EFER before
> configuring guest CPUID, as configuring CPUID and feature MSRs before anything
> else is now a hard requirement (though I suspect I was just a bit overzealous
> at the time).  The biggest problem with that change, other than creating what
> should be impossible state, is that it also bypassed this check:
> 
> 	if (is_paging(vcpu) &&
> 	    (vcpu->arch.efer & EFER_LME) != (efer & EFER_LME))
> 		return 1;
> 
> [...]

Applied to kvm-x86 misc, thanks!

[1/7] Revert "KVM: x86: Skip EFER vs. guest CPUID checks for host-initiated writes"
      https://github.com/kvm-x86/linux/commit/be2456d2d8c4
[2/7] KVM: x86: Treat EFER.LMA, not EFER.LMA, as an EFER MMU role bit
      https://github.com/kvm-x86/linux/commit/1db15faf1f4b
[3/7] KVM: x86: Reject clearing EFER.SVME via KVM_SYNC_X86_SREGS if L2 is active
      https://github.com/kvm-x86/linux/commit/d164d4e9fb35
[4/7] KVM: nSVM: Synthesize #GP instead of SHUTDOWN if L2 attempts to clear EFER.SVME
      https://github.com/kvm-x86/linux/commit/bc45c91a154c
[5/7] KVM: x86: Recompute EFER.LMA instead of inheriting the current value on EFER writes
      https://github.com/kvm-x86/linux/commit/a9ec87610ccf
[6/7] KVM: selftests: Update nSVM EFER test to expect #GP when clearing SVME in L2
      https://github.com/kvm-x86/linux/commit/1c7d26871fac
[7/7] KVM: selftests: Expect failure when trying to set EFER that violates vCPU model
      https://github.com/kvm-x86/linux/commit/e0160d1e1d42

--
https://github.com/kvm-x86/linux/tree/next
