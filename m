Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DB323F5BEF
	for <kvm@vger.kernel.org>; Fri, 29 May 2026 22:28:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780093717; cv=none; b=PsZuTsJllyNTFem2eB7P7WvDnCrSkbpujc2unUbsZw0yvLGRPgsWVhRxs6VqqTGy8Lqmvoz/2dc8cupBRsWhk/akFqBbK4xWMrFe4JBeWN62rjN/KTp2Y8vMUerCDPQF2HupUDEt4frPNZOptqt79IkF1creJSPvaGV6UZFcB/Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780093717; c=relaxed/simple;
	bh=VbnVXTEYv+JqDUa0Q19zWIbV7AepmZ6eJ3qhtJI8NKI=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=K1mT7PkAO43wp38X/FKlsHzeAWVemUKcBBV6UGrIRqNkH2mEyPODJVCD+Hph+EmtvwE9Ix3bGANU8vVFOhuiKLYQqnMvFL+oVcS5S0XuI9FrHvyASaCYT7kS71vU+ZGlq1HFYChEZtz8qS7ihLzI20lcQyl5F1YnkkSXiJxYxD0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=iVL3nvCS; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="iVL3nvCS"
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-2bd04e4fe3dso118419555ad.3
        for <kvm@vger.kernel.org>; Fri, 29 May 2026 15:28:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780093716; x=1780698516; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=UyvYYju/kOsku7tj1RfdIRz11t6+0rPHfTSkECF0MAQ=;
        b=iVL3nvCSEezUDisXbRMsZa2U2Y+uihQlbBILe4QnPrVvVOUekxD0WK8cCppc9Zabiv
         ymltooy9VJv5OOoNdyBQS2E7ZmoDDwyFiTVPgtL2V17oljNj17kKWhSxgssEv2J13Z1h
         qTJOn0tkKoXtXSAzjBEuHJhvTkKRzb/v7D1DIHJh1n2CEW9v8HT342K/tb40TjVkvLRB
         lAAo3QhLP9XxTmRTo96Bx2ZA02Vn5QXOiKvl2d9Q1zxQ2Q0Au1V2azIVWV9PxlSDxQMl
         pwzxVEVjLdcp9nHmfIphFZPJzLgeGikS0iRelsTcTVUB4yvgPWBzwllyNF5AKgCZWgul
         i/og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780093716; x=1780698516;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UyvYYju/kOsku7tj1RfdIRz11t6+0rPHfTSkECF0MAQ=;
        b=qDj5EEQ4cz35f1uCecztRfcH1ugS0fpIBOyWm8p524WB9ohEAzWTpL4TFKBe27Txkf
         LUHXP2ygE6DAP3tquCbky5C/gZFrX0pywcpjQlTx7hXykHAoDBx+6pNtjV5Q4Lnv4FOu
         AYYywrIrAanQIL828KeIMvhV8e+2WbSpVfAq7y0ALVXBnCeA/CRSc4G+Ahubs43AQTL2
         S7qER3lhg7N1bVsOkGVaGFE7hcTG1CyOcA556ubhHshqmcqMbuvux6EORmj/W8YG9Mmq
         AD4KIcFD7TSKe60C89hz/RR/32Yo/9zV0m4PfvHJVvCTw05j+QUSo534iToIOmyOTiIc
         RKuA==
X-Forwarded-Encrypted: i=1; AFNElJ/I7hC/7a0S6TRrNQWr5cU2hfhdxJS9nT/+SWV2QBlBBc0tDpuhuLSD6yjpQCG2QHz3WP0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzfTvUyadN2zqwH2hiXceToMlkQnw8bfQ2AFKHlGzV2OJffQm4W
	3b3lm+c/6ld2P7UcCH3DkgP9AdnCJ/8mFZecUXQsKLbyj8HMqoTDxmfG502cmtA1Wp+4KNjDCCc
	dUOsmAA==
X-Received: from plgo6.prod.google.com ([2002:a17:902:d4c6:b0:2bd:55dc:a132])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:e54c:b0:2ba:4e84:966
 with SMTP id d9443c01a7336-2bf368ad611mr19077965ad.36.1780093715569; Fri, 29
 May 2026 15:28:35 -0700 (PDT)
Date: Fri, 29 May 2026 15:28:34 -0700
In-Reply-To: <709d9ca6-59bb-4f82-b48a-0aa67a4d6ba2@linux.dev>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260528-sev_snp_fixes-v1-1-d67a08151779@meta.com>
 <20260528235151.9E59E1F000E9@smtp.kernel.org> <709d9ca6-59bb-4f82-b48a-0aa67a4d6ba2@linux.dev>
Message-ID: <ahoTEgTSVcEmUMvM@google.com>
Subject: Re: [PATCH 1/2] KVM: SEV: Do not allow SEV-SNP VMs from intra-host migration
From: Sean Christopherson <seanjc@google.com>
To: Atish Patra <atish.patra@linux.dev>
Cc: sashiko-reviews@lists.linux.dev, kvm@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"

On Fri, May 29, 2026, Atish Patra wrote:
> > Because the mirror's vmsa_features is zero, KVM treats the mirror VM as a
> > standard SEV-ES VM (since ____sev_snp_guest() will evaluate to false).
> > 
> > When vCPUs are created for the mirror VM, KVM allocates standard SEV-ES
> > VMSAs and fails to perform SNP-specific initialization, such as registering
> > the VMSA pages in the RMP via SEV_CMD_SNP_LAUNCH_UPDATE.
> > 
> > When KVM executes VMRUN for the mirror VM's vCPU, the hardware evaluates an
> > ASID bound to SNP execution using an invalid, non-RMP-registered VMSA page.
> > Will this trigger an RMP #NPF (Nested Page Fault) on the host hypervisor,
> > leading to an unhandled hypervisor crash and denial of service?
> 
> Nice catch! I don't think it will lead to hypervisor crash though. As per my
> understanding, the fault on VMSA page would be sent to user space and just a
> VM instance will crash which is not that critical.

RMP #PFs on the VMSA will typically crash the host.  In this case, I would
expect VMRUN to fault, which would trigger the BUG_ON() in kvm_spurious_fault().
So assuming the "bad" VM can get far enough along to attempt VMRUN, this is
likely fatal.

> Having said that, we should close the gap for such mistakes from VMM side
> though by rejecting mirroring of sev-snp VMs. I will add a patch and update
> the migration kselftest as well for sanity checking.
> 
> > >   		ret = -EINVAL;
> > >   		goto out_unlock;
> > >   	}
