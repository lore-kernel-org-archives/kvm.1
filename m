Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82BAF2FF147
	for <kvm@vger.kernel.org>; Fri, 12 Jun 2026 23:01:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781305278; cv=none; b=ReiPtL2NAMbmnuts2rlnbd9lgC1JisKKqTsoY1ijcVskNq+jk8Db20Rg61aRKIR7RiH+OpxaMLxEKA/1k1kMyPiFX36IjDquyENjRyQAMq9VHwmhNUMc7oip4oMjSzxWEELZK3NJo2royKe+uexpLpCU+3n+WVztaVHZscMgaMQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781305278; c=relaxed/simple;
	bh=5T3lFHzG4vHWWZUkIh/IujOLCVxo/GayI1T5Pa4LwYk=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=hEloRKWLI2dW9ZNtkgk1zGWHRIL66T1vs+pJ5gMhFD9Ygqh48xKcAWdbNY3Hs7qpTrev0ZcDzRZliCd059BOGaGsrJ3uZvB+Dmpx62YYMggEnapVZ2rf800IeCwobsQyX3lkzErdnkTs3rHDnpti0OWsyrkRZ2BFgM32NdH0uxw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=p88wkZ9d; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="p88wkZ9d"
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-84240b58211so1068032b3a.1
        for <kvm@vger.kernel.org>; Fri, 12 Jun 2026 16:01:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1781305277; x=1781910077; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id
         :mime-version:date:reply-to:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1J7obFawRf3HSMfap2O0RxTpizypIrwgc7yPCSjiETc=;
        b=p88wkZ9d2ele2MizXMRlMEGJXBO4HdSLdrCVtVHv3YsUtJV+27X57pNh4meijrECx0
         K1BbGFjjh+OmEeXynwKEJJg4GZn/1R2Bi2/RrmnO5C1Lq+oK+STOjM+9YPhPB9WK9ypx
         YMfTPEBmbh/gXRhbFrlH2nLyvRkxS3GPHiyqghppHe8UEtmkTwI/gIXk+QSKjgUKyqo7
         Qsl5R+R3goJCbjLle22lFO9jovbazfYoLdYyeD4SW+4u40sqpp3Bq7qLH8RHpQA686AV
         9gQm01GCr8S3RLDvC4E2yz8eLilB55B7mzun/0Y3rfUnpbrLgPPwV4DFvYt9aaj3yeij
         25rQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781305277; x=1781910077;
        h=content-transfer-encoding:cc:to:from:subject:message-id
         :mime-version:date:reply-to:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=1J7obFawRf3HSMfap2O0RxTpizypIrwgc7yPCSjiETc=;
        b=Dq/eRgU3I8b9J4j9kLOfj/Jh0hpdNTtoR4yN/2r+D4vFG0FJ4kTJ+OKHSmwgvAlQQv
         uwtYrHX1E8Yn2hrYsnHzorZZR2zBCcbq6633DO93JE/rj3uTnLY70XT+w5fpsDgFmSnZ
         8sD03iFz9ZT3J3oy8tDavx0j+pfTUg/hh9Vhi3XPfisFsRY5T+4pLK4NOPl6dc7tLbWA
         pkJZmizUvtaP3yIFVDg8/RF6HLe5zLW8yteze3+1WIpoGyHt103Ns6EDoQ0mWgXsHSoS
         lvRbIT+XQcKYUTaz+D0kqb6HxrL7/eVRYpDZKqpy2UrEh4Kt9zANjqchEiM906FcoIB8
         m69w==
X-Gm-Message-State: AOJu0YzJpZVjYcpKz5Je9tYf2gsRYA3QP5RPhtQ386LqiTgJbuITmVpm
	YvevzvSsw9ydo8FA5rvREMf9UHxjU3YMqSFgFytQYJFlVxLnWAmdayo/OaVQc1b1+fEGfywZRpd
	U9+J1Lg==
X-Received: from pgwb7.prod.google.com ([2002:a65:6687:0:b0:c79:39f0:12f2])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a21:6d8f:b0:3b4:6cae:4a51
 with SMTP id adf61e73a8af0-3b783b5ffdcmr5394175637.11.1781305276624; Fri, 12
 Jun 2026 16:01:16 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Fri, 12 Jun 2026 16:01:05 -0700
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.54.0.1136.gdb2ca164c4-goog
Message-ID: <20260612230113.684301-1-seanjc@google.com>
Subject: [PATCH v3 0/8] KVM: x86: Fix emulated MOV DR{4,5} #GP bugs
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	"=?UTF-8?q?Carlos=20L=C3=B3pez?=" <clopez@suse.de>, "Maciej W . Rozycki" <macro@orcam.me.uk>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Carlos' fix for a bug where KVM fails to signal #GP on emulated MOV DR to
DR4 or DR5, plus a pile of follow-up fixes priority goofs (#UD versus #GP,
#GP vs #DB, and #GP versus #VMEXIT on SVM).  The rest are opportunistic
cleanups.

v3:
 - Fix a #UD vs #GP due to CPL>0 bug.
 - Prioritize DR7.GD=3D1 #DB over CPL>0 #GP on Intel.

v2: https://lore.kernel.org/all/20260603230718.1733483-1-seanjc@google.com

v1: https://lore.kernel.org/all/20260601133320.91479-2-clopez@suse.de

Carlos L=C3=B3pez (1):
  KVM: x86: Treat any non-zero return from set_dr() as a faulting
    condition

Sean Christopherson (7):
  KVM: x86: Prioritize DR7.GD #DB over #GP due to illegal DR6/7 value
  KVM: x86: Manually check DR4/5 write values to fix SVM intercept
    priority
  KVM: x86: Prioritize #UD on MOV DR over #GP due to non-zero CPL
  KVM: VMX: Prioritize DR7.GD=3D1 #DB over CPL>0 #GP on Intel
  KVM: x86: Use kvm_dr{6,7}_valid() to check DR{4,5,6,7} write values in
    emulator
  KVM: x86: WARN if MOV DR emulation hits a "too late" #GP
  KVM: x86: Read CR4.DE in emulator if and only if accessing DR4 or DR5

 arch/x86/kvm/emulate.c | 49 +++++++++++++++++++++++++++++++-----------
 arch/x86/kvm/vmx/vmx.c |  6 +++---
 2 files changed, 40 insertions(+), 15 deletions(-)


base-commit: c1f7303302927f9cbf4efedf70f0512cde168c65
--=20
2.54.0.1136.gdb2ca164c4-goog

