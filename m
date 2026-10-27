Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.200
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793140242;
	b=0UywXYWCpcuQk8J/DqWtl53XIN4H/Mmz3/hyBxYrfTE6TNQ3SGTDzkIP3gnLgDiHZhpm
	 0qoZVxWoKO2k/NM2Orp7bTyKnYQJn+o12g8hSxCD4361/nwfGVUYK/nvWpJfd7C3GKbBa
	 1PLLN0E8QIWz6iyBvjtL2UXz7qZfu7W+kj/fFHQuJ+qHRtpJef3ohuMa9yYN+AxZQ58DG
	 AgRpUQiVY5fi/Chhw4Gu8NfiwN+xUpQJXFFCZPJ8x4iJjihMIAQffdRtwHL3rjRxaAZkm
	 RjNRlM8C4/UhD+pnWtWoDTMalQry8Seu9zImFz7ZSP2xlfELyKnnjtJvt7O5uoM17ng==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793140242;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Received:Reply-To:Date:Mime-Version:X-Mailer:
	 Message-ID:Subject:From:To:Cc:Content-Type;
	bh=T1tgnVjlE87FNHg73Z1vtF92TtTUQ4flw2mkfx4tQv4=;
	b=Gcx8f1fakG3M0QmXaYmEQWykZcGasSyqX6w39OIg2Q6klf37/zUv/MV1QYgO5TesLrMU
	 9E8/ACjab+pQ9CmarqpXj7IJFVLD8l33IagKYhjMTPla8ZF8nlkiAUa0/eTVwA43vEhDQ
	 aRgz8qBR/LxlsUGqftSIk8/Efm66rBqecUpaIsm8Ye5pJkAxi5dB8QuNrjnogpLIDCxbg
	 lnlEE29o/SP/Q/V9SFsATIgbrlg5sNK1US0eDLU4jOzvZ/VZfDUgKiv3ajuBwFQOwui20
	 +BkiqEWq++aKdVZWerO2RDQlzCNNF1VaibEjZHr9982wp2GOL8l8MMG/UfETBSgSIHw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=YPmfm4mK;
	arc=none smtp.remote-ip=209.85.210.200
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com [209.85.210.200])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BFF7606A322
	for <kvm@vger.kernel.org>; Tue, 27 Oct 2026 22:30:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3BFF7606A322
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=YPmfm4mK
Received: by mail-pf1-f200.google.com with SMTP id d2e1a72fcca58-89e6ddd4554so239863b3a.3
        for <kvm@vger.kernel.org>; Tue, 27 Oct 2026 15:30:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1793140241; x=1793745041; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:mime-version:date
         :reply-to:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=T1tgnVjlE87FNHg73Z1vtF92TtTUQ4flw2mkfx4tQv4=;
        b=YPmfm4mKa2hkqpLu5vcyPPJSgCxAT77KK/LzK3iFxSVZziHXDQAVTlVylRJx0qSRF3
         lCLeB4KfbAlNS6PZ/doNT4dAB2aC6UhTVOMN7ZPoFCZMxSedt4bzlVYrQ1RRu9wSfxOF
         MhkEbzxmURmiecELA6i+DsAIyvR6C2J2CbYqJtzmHTmPLHqOeksvdptz1X8ebCF3wzW7
         xzDLlHXCtVPzv9T/R6ik7ZsCLC0Oh2VSao5C8+XWmn6ksUqWHAVIdIXbRsFTEsH3xEfV
         XypvuL0Xs/O6M310hStJpNyNKTGkOGEHQxc/QQOVIufi1Fk+pBkJzZP5e4+JY8zvpjtd
         H9wA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793140241; x=1793745041;
        h=content-type:cc:to:from:subject:message-id:mime-version:date
         :reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=T1tgnVjlE87FNHg73Z1vtF92TtTUQ4flw2mkfx4tQv4=;
        b=mk0pX8hXYj7ngP9GeeAcNFggsE//bo3NAO0oQ1eEhKPfAlVNMtXVR78CjK1X9UBSd0
         MwIqrnEkXsaF+ALp1ashmqnrOfp7FJ8KGB2Qoe4n+aylQyHildO5/dvjQR67f84n1pki
         5GV5wGgpuwvmBXjPIBsFXKYGjgfkpF7o36skPa/pqx2O2pAtSkHQtn0kx3uK+FpRWqUH
         5mw7Wzv84K+TtHHzx7pMMHtk06GMDgnjQLZqMKSoXSjIGSpWK+izMDZWXrXIAgGJsA+n
         Mae7CXBh0zlQ4EgsbdnRTl0w8ARBTZLakLWygPPecv1R0uxH8NEdTaPXvFBmbEDeM1Ha
         v/yw==
X-Gm-Message-State: AFq9FYLG6nbz6O/cu9r8WbNnaXkHlpQ942mVc0Y0iuZpq62BbmlV7Vdj
	OfR+ANeIrvrxQGmWRcmM28CwZqTcFZjifSBlzLzK5qLUgjiZJxgrAgPpu8jiL/F6jgdVAVRoCpd
	aWWshiQ==
X-Received: from pfaf7.prod.google.com ([2002:a05:6a00:a117:b0:89e:bd5e:725d])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a20:6a0c:b0:3dd:d729:c62c
 with SMTP id adf61e73a8af0-3e9023a34c7mr439304637.54.1793140241314; Tue, 27
 Oct 2026 15:30:41 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Tue, 27 Oct 2026 15:30:35 -0700
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
Message-ID: <20261027223038.1566931-1-seanjc@google.com>
Subject: [PATCH v3 0/3] KVM: x86: Drop deferred updates of EOI bitmaps
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Sashiko Bot <sashiko-bot@kernel.org>, 
	Amirmohammad Eftekhar <amirmohammad.eftekhar@cispa.de>
Content-Type: text/plain; charset="UTF-8"

Stop deferring EOI bitmap updates.  As pointed out by Amirmohammad, I missed
this one when removing all the other cases where KVM defers an update until
vmcs01 is active.

Patch 1 fixes a pre-existing bug Sashiko pointed out where KVM doesn't update
the EOI bitmaps if APICv is temporarily inhibited.

v3: Add the aforementioned patch 1. [Sashiko]

v2: https://lore.kernel.org/all/20261022022813.303978-1-seanjc@google.com

v1: https://lore.kernel.org/all/20261017093016.32348-2-amirmohammad.eftekhar@cispa.de

Sean Christopherson (3):
  KVM: VMX: Update EOI bitmaps even if APICv is (temporarily) inhibited
  KVM: x86: Switch to vmcs01 to update EOI exiting bitmap on-demand if
    L2 is active
  KVM: x86: Consolidate invocations of kvm_x86_ops.load_eoi_exitmap()

 arch/x86/include/asm/kvm_host.h |  3 +--
 arch/x86/kvm/regs.h             |  6 ------
 arch/x86/kvm/vmx/vmx.c          |  4 +++-
 arch/x86/kvm/x86.c              | 27 +++++++--------------------
 4 files changed, 11 insertions(+), 29 deletions(-)


base-commit: 7e60162b16f9da0d2fa83da5c1723b6853a0ac1d
-- 
2.56.0.307.g5fe7bd680c-goog

