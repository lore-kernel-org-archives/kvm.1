Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com [209.85.215.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDB86483814
	for <kvm@vger.kernel.org>; Fri, 24 Jul 2026 23:49:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784936960; cv=none; b=BNa7eFe4WBIA9WWLnFqJNk2XgXHA2f0eSENRXWlQxNyipqAGRqxGwiLAQOUJuMtw1MDB4OB7q/R787HPq0bieXBCW8xDOD37wjT8TMg2RVXQqkjUtRI0w8xPpIiOrc67ldL24Sgsf8dqj9s2UmttMxur8PYT+EgFh5Aw46vYs1c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784936960; c=relaxed/simple;
	bh=IdwZWB6D9EbW/qGwYC6OPc6GerjDkiCl9vzMPSS7dsY=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=W31t7c8wSlEGoT8FOivGlM6FGZHkRkaVMwoZRR2lLqQ382dhq6vDEa5bm3ITEfjHjR4GbB+yBamQoBOBIQ4mfz6fkV1Ill6DNdUGSPthwscfr2I3NS3v7n4BuYXryUgRqWvnsiSm2K7PwDppAq3TTTEw+VM/MW6wCgrFiO4V6cA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jmattson.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=sJEDc9Gh; arc=none smtp.client-ip=209.85.215.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jmattson.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="sJEDc9Gh"
Received: by mail-pg1-f198.google.com with SMTP id 41be03b00d2f7-cb48f41343aso1510205a12.1
        for <kvm@vger.kernel.org>; Fri, 24 Jul 2026 16:49:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1784936958; x=1785541758; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:mime-version:date:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=EjL28thvLNtHuXd2Pl7A3qpghg/JpvmdaMF09U2TbPc=;
        b=sJEDc9Gh/1Y+7jOlu9T33J756kXWg0cvS8R+L9f5A3bcXvaW1h+5BiN4SD2H0T5BTO
         yCqJOsW21okTuUhgk2HtX/8EHH+2poXIl86nrBjJ9H79lJXjkNWYLJm4AjpzSKcvAlQt
         52D3cr9gCfJ8ETIt8a+yXORA/63Kb3E6R7C9KFJSSszgauqZpDnAqLyKlSB/ESqPTX/B
         qtTsclTmGtaPejunPfEldNXPEdFSBWkd17Y8kiJzDaSdZAYS0fxBaddE7natblHKCpeM
         FLU/g0KHT7A42B/EJFgsBvG8GuvCfP75RuO9mbnTbHDWyoDj80KCxTwfLnrPCVJPjrAf
         jHJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784936958; x=1785541758;
        h=content-type:cc:to:from:subject:message-id:mime-version:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=EjL28thvLNtHuXd2Pl7A3qpghg/JpvmdaMF09U2TbPc=;
        b=IWksxVkY7/LjqREydJ+NSL2LyJM49SlDqlSyScrV3aRcoKRQI0ffWFBG9fkO2Pmzb2
         diOWG2CUlMFuLpuxsGgs2TbLBa3TkpzizQWw75/zickJsfw9kaMZf87S2oQnB+DaqezQ
         NvIBJpzOQxHpRVQ/fLaKrWYJOTe/ZL9cqkQbq73tnZ1KxOv7umEBrFht+EzxSelIs4DH
         5DhIFKyv2eD/RFV8GVb8T2Tdt4Ns0qWZJwgdcwXiC2f8BWs+JKkAfyxhoIiYewA1BqGm
         mZO2wgXS4pHbSbsumYwmr06X7sGnVFfAX+iJB5oohtuVvBfztuTB446tQEfW4WgBrDjc
         Bf2g==
X-Forwarded-Encrypted: i=1; AHgh+RpEjME48DyMmSGt0MWNrej1eRWMqFcPfiiSDJKRpJdlsbsQPvjW0bbqt0J60n+TT5PPGvQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzwq9R6XgFXDAksW5U7DAvpVwJh1wyj/PbHUsEP8HEoMyI65ood
	KYH2sbxnVn3z7bG+rzHUIJPFesfkOaFmm6+5+mZp6UIsE1uBoGxNVSmmJjVNHOwc03KD4CzShCe
	tWbsmVoOrvXSW5A==
X-Received: from pjj6.prod.google.com ([2002:a17:90b:5546:b0:37d:8595:7a08])
 (user=jmattson job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:90b:1d82:b0:387:d5bd:622f with SMTP id 98e67ed59e1d1-38f2aacbd57mr214218a91.18.1784936957643;
 Fri, 24 Jul 2026 16:49:17 -0700 (PDT)
Date: Fri, 24 Jul 2026 16:49:12 -0700
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.55.0.229.g6434b31f56-goog
Message-ID: <20260724234914.987987-1-jmattson@google.com>
Subject: [PATCH v5 0/2] Compute safe bound for VMX preemption timer
From: Jim Mattson <jmattson@google.com>
To: seanjc@google.com, pbonzini@redhat.com
Cc: chao.gao@intel.com, kvm@vger.kernel.org, Jim Mattson <jmattson@google.com>
Content-Type: text/plain; charset="UTF-8"

Due to a widespread Intel erratum (e.g. EMR158), programming the VMX
preemption timer with certain large values may cause the timer to expire
earlier than expected. The recommended workaround is to cap the timer value
to strictly less than 2^25 * CPUID.15H:EBX[31:0] / CPUID.15H:EAX[31:0].

v4 -> v5:
 - Include Sean's preparatory patch burying VMX preemption timer code under
   CONFIG_X86_64=y [Sean]
 - Replace div_u64() with direct division (/)

v4: https://lore.kernel.org/all/20260722143024.3938899-1-jmattson@google.com/
v3: https://lore.kernel.org/all/20260722040311.3369898-1-jmattson@google.com/
v2: https://lore.kernel.org/all/20260720231639.1592848-1-jmattson@google.com/
v1: https://lore.kernel.org/all/20260720205230.1457146-1-jmattson@google.com/

Jim Mattson (1):
  KVM: VMX: Cap VMX preemption timer to work around Intel erratum

Sean Christopherson (1):
  KVM: VMX: Bury all of the VMX preemption timer code under
    CONFIG_X86_64=y

 arch/x86/kvm/vmx/vmx.c | 152 ++++++++++++++++++++++++++---------------
 1 file changed, 96 insertions(+), 56 deletions(-)

-- 
2.55.0.229.g6434b31f56-goog

