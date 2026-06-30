Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79A613DE429
	for <kvm@vger.kernel.org>; Tue, 30 Jun 2026 17:22:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782840130; cv=none; b=nsOZtFTPm6ViGpEa2y082YATHzhJrAVCXjRZ/aDuJA6k5YqtRYE6PpdR78rIT2Q2m2Gy+PvJYWfkgJmLRdS+vhGU+etCim6cvkd58fx184Rjb8QTmlpkbkP1rKh7czE+ZmXZT1lFrMlL9yr+kjnhRFQcpKCLIvPufH7LbEDwJs0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782840130; c=relaxed/simple;
	bh=Guh0b0E/oshV7Eo9n9YJbc2xeAVSD7LwXtP/99970XI=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=rWUb22dwizaNA2bHo5cL/MKkjVNOdE1PFON0UpYTTFW3NG3hBqF2xsXiIY9kFEseIwbMrM8YDaiv709Qk6Yg1fUxMhkqYsmAKqfLKls0R/bl16Q9RjjBxorkhunMCuYBAOTaKmrJ0u+/csbmkMgUoutueXYoWeCgxfB6gan2t6Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=sZLqydp5; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="sZLqydp5"
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-847a225cd91so884379b3a.2
        for <kvm@vger.kernel.org>; Tue, 30 Jun 2026 10:22:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1782840128; x=1783444928; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:reply-to:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RNfVuu5IEUj4RxRR3iUFZkOMO70NS5abTKzIhEzo5lQ=;
        b=sZLqydp5cnA9aBBg3wLfgvlgf13ETHgUuOOMM+1AQyqFi3SG/dSDhcsvYRJirrnL9i
         JIFLERgoJ3tzy7Ho15WJ35nto/XTXQ1U4a6r+HNX1XNh5UtbXRSBetKaE+/1165EtITz
         wHzJGcB9TEU/h3/N9XTJfJ9Qvi5XRh6wIuWBoYQ58wC1ZWcpivLtKSlREvphvJHdgKbP
         JdXkJpF/LvUZNmSOAigsWu0yZ1WvHDXHSIOGATuGrUbWMGHAVpU29/9tIqfv4R29y4Yk
         pziTt+5/6fcAOBC0TCijRfW4JchQ+BjQGkKZ5uj7i1lP59Gitdf+kRdpq7Ewb5OfUoX/
         lG+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782840128; x=1783444928;
        h=cc:to:from:subject:message-id:mime-version:date:reply-to
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RNfVuu5IEUj4RxRR3iUFZkOMO70NS5abTKzIhEzo5lQ=;
        b=F4pAi0ZIloVTQ9d6o/EiaDIyp+N3BdbO32Wi6QVi/j6XoD+ovvrx1Hf1e5/4rrCn3F
         pD7p7ORXizO+scAVE2G/eOXsacuSrPLpVih0T24AhjCPQDM63P2iYUV1MKgb9C8eq3ax
         ARNekeiwRmxyxJYtJVwEPKXIsb3L85KGfBSyZLNRZbDLpWaDxNEHQx/+rC+USCdVlpXi
         IWQu0INKQNSoWn7NaMsqgwH8fClGwOM8gB8u5SvQmaZbmgCPlGQszoQVAQEEenc3s8jE
         xTpSQqq9KQk+3ZNxAsFvnofU9uW3WR0Db1YD0nix+JdAIHAR50caeU4EVPdJOZ89u8ss
         kevA==
X-Gm-Message-State: AOJu0Yxaf/FpSo2W80m7WVZImHQGLAcs/T2q3LBqp+SiZExdkNjimXUo
	JxGZUTbjaHBCMsFqS+xJV0hWymoz4S+j6juuttbv0HgoyVcUyLC0DXAi3JJvGb5ja5h4ayZMn6I
	D3I9MZQ==
X-Received: from pfbih2.prod.google.com ([2002:a05:6a00:8c02:b0:842:5241:cda4])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:1896:b0:845:ec1c:71ff
 with SMTP id d2e1a72fcca58-8479f26b1abmr4047285b3a.46.1782840127403; Tue, 30
 Jun 2026 10:22:07 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Tue, 30 Jun 2026 10:22:02 -0700
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.55.0.rc0.799.gd6f94ed593-goog
Message-ID: <20260630172204.279784-1-seanjc@google.com>
Subject: [PATCH 6.12.y 0/2] KVM: SEV: Backports for GHCB leak fix
From: Sean Christopherson <seanjc@google.com>
To: stable@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Sasha Levin <sashal@kernel.org>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Tom Lendacky <thomas.lendacky@amd.com>, Michael Roth <michael.roth@amd.com>, 
	Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>
Content-Type: text/plain; charset="UTF-8"

Backports for what are effectively patches 2/4 and 4/4 from this chunk of
commits (1/4 and 3/4 are already in 6.12.y).

  8618004d3e89 KVM: Don't WARN if memory is dirtied without a vCPU when the VM is dying
  08385c5e1814 KVM: SEV: Move sev_free_vcpu() down below sev_es_unmap_ghcb()
  f041dc80de4a KVM: SEV: Decouple the need to sync the GHCB SA from the need to free the SA
  db38bcb33110 KVM: SEV: Unmap and unpin the GHCB as needed on vCPU free

Cc: Jack Wang <jinpu.wang@ionos.com>

Sean Christopherson (2):
  KVM: SEV: Move sev_free_vcpu() down below sev_es_unmap_ghcb()
  KVM: SEV: Unmap and unpin the GHCB as needed on vCPU free

 arch/x86/kvm/svm/sev.c | 84 ++++++++++++++++++++++--------------------
 1 file changed, 45 insertions(+), 39 deletions(-)


base-commit: 0b8f247169e487eff2d4c2dd531bc43f7efda2cb
-- 
2.55.0.rc0.799.gd6f94ed593-goog

