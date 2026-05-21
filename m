Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D518253B58
	for <kvm@vger.kernel.org>; Thu, 21 May 2026 14:05:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779372326; cv=none; b=VzoRAdcnXfTqqsUbP0yYwBP2NUIHHRbYH0bQMHu7Pc9FGzZlJazsGLtvGqq46tnVT2z6oYGg0Ky6PUwhFaj5QSt9pdR0JyJk6WckRNANlN6vWYMTrZ0Kv6C3r22uasKWb2cWy1M5XYRFtYcc1A9Eb1zrop2Un1bKgofOrV1C7kk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779372326; c=relaxed/simple;
	bh=q9Tl5AYJ085meaGtFUxpktlCvg/f8XFGu3Iqx2vjeXI=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=BonJ/2plTp6KeoT0kHa5uvcuXYNZEqB0+cR7xQVcqaQFxEsSvbYkg74bJgRPW7lvmKN9/xXza29BQHhwXNFcHy/Bzh5w7u8aoYJ0/F8VSskFDGCIVfvfOjQdrOHnRZl7ai/c1Y6JpBaH6/dkqHINEy7ycaEPcwjtBeTaEQL7oP0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=m6ZVKFla; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="m6ZVKFla"
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-82f6b984b3aso3034471b3a.3
        for <kvm@vger.kernel.org>; Thu, 21 May 2026 07:05:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1779372325; x=1779977125; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=u6C5MKrDo426BqZHb1v61q+91K7aOO+L3dGvEZUQPo8=;
        b=m6ZVKFlab1RvPP5Wz8bcixwP0MVXGtJVuhtyCHO71Amzq7FDkGqvwsua0S4QbVobp2
         +ltgy8EadpSMQSXmN/Cz+b/QETjwkC4t9SzLm3LWoBNdMq3eYKe4GkaegCfdmNYa6zFY
         6xA6TWnp/HO0+pBvGVc7g/RuJeU7Us9zVBJgn8mW3LHDeYgyK9EbK9GMMTUoIaN+SHX8
         k+Dr6PzIAoQpHhv8m3+xjtKuYel88xJomF1zot6KmgmgLMmH9MORqP1x3uJ18hw53yp/
         RC93J/SakiUs8iLmHjTHh9wddQ/5EtSKWdY8nZ4O9wuVEDOljIEMv40UXv29Yve6JTfJ
         tqog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779372325; x=1779977125;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=u6C5MKrDo426BqZHb1v61q+91K7aOO+L3dGvEZUQPo8=;
        b=ZjAK0nXq/SH9LyRLj5BpAGiOIVp2RAvxDn85WugeFsaYZbpG8OIujMSdJHDe+I9grP
         johHbNKfQVKlPfY8QwiFjgcwm0Lby0UUoaahFD3UMZLHdQ8L3MK/9x9Vgn+wTRSL0Zi/
         55AiJonlDuSJDdX/MENwGMFaRz/yCjrBPkLiF21rZGkfDfG4+rxLpq7K1Cn+8xvqg0HF
         rk2s0OIX25OJypeyB9/GnTAIRpBk3103eBB3Eec5tKz1nsT/HKVKvOvi0cds0H8wCIxE
         g5/kw1iOwrpLDP6H2XdWCDomC82Rr2s0BH8MenlFdBuDxYV/OIHQL/nV2PGk4dD/xN+Y
         whMg==
X-Forwarded-Encrypted: i=1; AFNElJ9G8sAAqEThz/k/pOXb1735dfx3Oyg3WFZuMVsfDpt70DSiwF+Q1iHm8NPVQGmFbLJ/GPU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz37+wi5y/z+ZO1g6+lVPVn+tMIdCW8EoHLDx2D6Folf1Ly9kJd
	ZascvmFvCGBpckbqo94X1XFSq54TRtOVEAFHPrNZjF9McMj95ATaTBBCSP8f1shNc/SlYTuMtCW
	7jXa6KA==
X-Received: from pfblu7.prod.google.com ([2002:a05:6a00:7487:b0:82f:24a1:2b5a])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:4407:b0:838:3404:c2b1
 with SMTP id d2e1a72fcca58-8414acdebbfmr3433531b3a.18.1779372324565; Thu, 21
 May 2026 07:05:24 -0700 (PDT)
Date: Thu, 21 May 2026 07:05:23 -0700
In-Reply-To: <tencent_2A66410581309346060C5BDC8CD108053005@qq.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <tencent_2A66410581309346060C5BDC8CD108053005@qq.com>
Message-ID: <ag8RI8fX1w7jx4sA@google.com>
Subject: Re: [PATCH] KVM: x86: Add tracepoint for vCPU wait/yield paths
From: Sean Christopherson <seanjc@google.com>
To: zhanghao <76824143@qq.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"

On Thu, May 21, 2026, zhanghao wrote:
> >From 0c8d4428390a1238a956f713c1ddced18eac83da Mon Sep 17 00:00:00 2001
> From: Hao Zhang <zhanghao1@kylinos.cn>
> Date: Thu, 21 May 2026 16:30:37 +0800
> 
> Add a KVM x86 tracepoint that reports when a vCPU reaches selected
> wait/yield handling paths in KVM.

Why?
