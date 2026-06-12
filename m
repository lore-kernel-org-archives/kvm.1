Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B99B5335555
	for <kvm@vger.kernel.org>; Fri, 12 Jun 2026 00:48:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781225294; cv=none; b=ITaXF9pMRqiYZuRNeDMWFVKRZie1H6KioyrMBLXt9TxY4iWoT5mAL9n0qkNbN6E9moQx2JgtWqMTljoo0fpPIpQAe4wKGnZQrIKAZi4SGsCKg1rCI/tFXPQEFlVfdp8mezXYaLMlkPDTHWJPtHyGVoFEkwir40hQkx2yuAdHclQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781225294; c=relaxed/simple;
	bh=LmEuq0fo9dwuGk7UaJJP2saDIBamRz3n0xwRuoCEdhw=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=YpqjSNPijZr2m4U/1wfz9/ysv54gDdXgK28qWdcp0quNatFTwHHyCzijAVMO9j4ZMuJMSZ4J1k2OZEZVyoVvEQqz9jn+tIjNFwnB34MVqVegu3dZTXQ1tDnCdlYPC0VHJGQLYHdttk0xsFmTOka+mC6QD+ywEci7MzEvmHM56W8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=pL+XuVp+; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="pL+XuVp+"
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-36d985df4cfso577975a91.1
        for <kvm@vger.kernel.org>; Thu, 11 Jun 2026 17:48:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1781225293; x=1781830093; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=UdboP5KYTVCuR2pYJU4gYUTro20s/8ztkF7ptYaFdXQ=;
        b=pL+XuVp+jwE/nc416BM07AxVh6Q5qQ225bj1JSoxHGe7O5oOA3+VvpmEUsqvDqx7zx
         gP5gWrbH4yhGTBwFqfNYYkI/o4j4tnU4A43WgvoolHubwB4X0yrmXY+bM7l/N4Xq86J1
         FfuATg2fi69LHB4amynVqjlX069M3xbbNmuMPPOhNfFR+ApFSGLL1mjGIYBrwLzj4HmF
         tNXWrXWVwCzLGbVwF3C7Xssbt/24tq/ndnF6dQFa2kTlgv794zqzFOrxOAnzKW4sBOz7
         gN1xbshpW8DRCa6Q61eCotofstIUZOQUCfyyFfcRIl5zTD2xbOMTWvbhyBRjP8l9jOkl
         4HRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781225293; x=1781830093;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UdboP5KYTVCuR2pYJU4gYUTro20s/8ztkF7ptYaFdXQ=;
        b=MvQMSpG2ieZov3o0TbmHRzWCBdryJkCXAb3LAL6n6MsfxP5e/XjuMzroLSWWylWwSn
         J6XbteYX3OCuLp9kj68C8E6LrMeK9XgWjAEVaeWyP/hyTox0rWR7mfoA/mhXtF8cyb06
         lE+Tq7eqPZg9IS3mIyZFYkHmO/YqoAM6wqUKR+jfYg4dhroPBp424qRLvZg2klaDKSdL
         dHFpDv370tXZ6ZWg43JKnVAfKt/2t+4LP08HHMkaXhjEZ22SXEKgQfz22w4JRVPbDhLA
         tJfDx5TggPL1juwBxNL+VaTX0lfTRQFLCveQX79tHe4/EkzfVBpPICVK2cjm4VtiRjvh
         MjQw==
X-Gm-Message-State: AOJu0YwYSKpEsCFZI/5egtT1cwTr8c7dSXfl/g8Lv5eOPYQiS3vbtW5q
	Ky+gA9ClXM/WeokMLyq5KOEWpohedOzkQHrkOTlqcdleA2JfRZ7qW91aJZyQayPz8bqGycQBnDW
	yyM9V3A==
X-Received: from plblv16.prod.google.com ([2002:a17:903:2a90:b0:2c0:bd65:1a98])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:2b50:b0:369:223a:cb60
 with SMTP id 98e67ed59e1d1-37a01e2fbf7mr690236a91.8.1781225293032; Thu, 11
 Jun 2026 17:48:13 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Thu, 11 Jun 2026 17:47:54 -0700
In-Reply-To: <20260612004755.349925-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260612004755.349925-1-seanjc@google.com>
X-Mailer: git-send-email 2.54.0.1136.gdb2ca164c4-goog
Message-ID: <20260612004755.349925-10-seanjc@google.com>
Subject: [GIT PULL] KVM: x86: VMX changes for 7.2
From: Sean Christopherson <seanjc@google.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Sean Christopherson <seanjc@google.com>
Content-Type: text/plain; charset="UTF-8"

The following changes since commit b7fbe9a1bf9ee6c967ef77d366ca58c35fcf1887:

  Merge branch 'kvm-apx-prepare' into HEAD (2026-05-13 12:38:31 -0400)

are available in the Git repository at:

  https://github.com/kvm-x86/linux.git tags/kvm-x86-vmx-7.2

for you to fetch changes up to ca674df13b195eb6d124ab059799d4e03fa40624:

  KVM: VMX: Handle bad values on proxied writes to LBR MSRs (2026-05-27 16:41:51 -0700)

----------------------------------------------------------------
KVM VMX changes for 7.2

 - Fix a largely benign bug where KVM TDX would incorrectly state it could
   emulate several x2APIC MSRs.

 - Use the "safe" WRMSR API when proxying LBR MSR writes as the to-be-written
   value is guest controlled and completely unvalidated.

----------------------------------------------------------------
Rick Edgecombe (1):
      KVM: TDX: Fix x2APIC MSR handling in tdx_has_emulated_msr()

Xuanqing Shi (1):
      KVM: VMX: Handle bad values on proxied writes to LBR MSRs

 arch/x86/kvm/vmx/pmu_intel.c |  6 ++++--
 arch/x86/kvm/vmx/tdx.c       | 38 ++++++++++++++++++++++----------------
 2 files changed, 26 insertions(+), 18 deletions(-)
