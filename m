Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1C297260F
	for <kvm@vger.kernel.org>; Wed,  8 Apr 2026 16:34:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775666044; cv=none; b=OUeygyrtSbNGvPPQQJxMPmHsf19ofJpzKfc3lLG4k9o9htJJh+ph6T2CsmJptVwlm/gwCtUVh1x3PV6rZek97qtTWC6QmxroNBBMyTkjk6U/Ibb9trk7g6pv4D/RGrLG250kIAIMvzhCCbx2V6kFHUuvnM/Boh0zNzsrxYi9ivM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775666044; c=relaxed/simple;
	bh=vzY/tSccfUbpoIfIZ8q9iKRIGKC2EBwbVZfImdNkwfg=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=cz6hetevfTGSalCenTSIm/BKBR9qXwnVtxdwl01hZis9xIwBLXJrQpD1sKs1gLxejj/6dBu2909vaZ1T4BqrRgrsLgG6fd6jwl85oSsWfVzcXKl1fkOsQhZQ2YYYlcf0kTD5iPAhBEWl52gCkJy1uIq9sDby/N7foiSiSi8/Lcg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=YNbTRLhM; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="YNbTRLhM"
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-82a6c70f1f8so4229343b3a.0
        for <kvm@vger.kernel.org>; Wed, 08 Apr 2026 09:34:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1775666041; x=1776270841; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=jRZXONeJDxUiLh0aG70nVlhtcf1yGjwZiaYa9FOO/1Y=;
        b=YNbTRLhMZICWFhkyNgHz4XJh+VUJpOK5CZnMroeJws2utNbzPVbWWNhdeWPDuOFJpJ
         iNxhNk72K0fiAgbkD0ZYjBWvl/EgmXIKvIu0LIwLG8IDi3ofGlT00AoCmaxTuSerAHYE
         S1w0+SjRosRzBGRULK88eOwBXZNq/FQ8fsnE3jmMlC7iOIDtXnZ+rHJvdR+3INtVviJZ
         Rp3mbSDCbCOXZlwtl2cLBlUwy5NoKf5Tzj14DNJkkd/+FJI74ANY/lr7BAY1noV4140t
         JcaSA4KxxF6ZOpjIYkn3cM+BvUf43I4Pd1Ws5t6ifDqORXpzxkv0YQk4gbRFnf1w+dgp
         0vmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775666041; x=1776270841;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jRZXONeJDxUiLh0aG70nVlhtcf1yGjwZiaYa9FOO/1Y=;
        b=kGnlNHwjMmtSRxX0tEzlyBk+IGdQRDX+SjHOOwxSwJfhzS/iGp/3/9uBmEdn0fjoUF
         gRCe2PkV42qJf+r8S+RzdKGRqaqZilBr81LLpbP9EZmoHmO++ZYRvsChXsYSa4Pf5NAd
         NuJoSGrVp/lxIk69Ic5uuXGvnGXAEs8dBObPnpuN+A6n68ccMKclJ9X5yIFGW+8j9Z83
         5JyeA19VHkVe2XIBEc//T9E4rLwlzjPWcNZ4XEmX2pw9Z/WXXJTlgoDb6WeaNNV4r2ls
         jxgDwWlwF/F8MCN5T0aLN5OywrBvQMu92gBUzU0xMSQuGyy7fLqawlG604aW03np9C4p
         i8Uw==
X-Forwarded-Encrypted: i=1; AJvYcCV7m1mVF+XImdiTU2g5BkChUSzpi91JpAOVXEx1celepu4l4ue7vY19913mYpWm2/p5uvk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxNI6HMwEOPtiKyrWfLPyFkiepHa5vloBmLox4KOq5XVIou8qIN
	obWXjWJ0Hnc3Rh9YkJmndw/AEvCsBEbP/ZdQqu4BBvFP7I06WyRYdI/j86+xXSz9/rFjAafjepN
	7dNYG+Q==
X-Received: from pgbcx10.prod.google.com ([2002:a05:6a02:220a:b0:c73:faf2:f827])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a20:7346:b0:39f:a052:39a1
 with SMTP id adf61e73a8af0-39fa05241b8mr7282329637.26.1775666041092; Wed, 08
 Apr 2026 09:34:01 -0700 (PDT)
Date: Wed, 8 Apr 2026 09:33:59 -0700
In-Reply-To: <20260408153650.34484-1-ohyunwoods663@gmail.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <202604081418.sean.christopherson@intel.com> <20260408153650.34484-1-ohyunwoods663@gmail.com>
Message-ID: <adaDd65SA_W9LUUT@google.com>
Subject: Re: [BUG] KVM: NULL pointer dereference in kvm_tdp_mmu_map under
 memory pressure
From: Sean Christopherson <seanjc@google.com>
To: punixcorn <ohyunwoods663@gmail.com>
Cc: pbonzini@redhat.com, kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"

On Wed, Apr 08, 2026, punixcorn wrote:
> Hi Sean,
> 
> I attempted to trigger your debug patch via fault injection (zeroing
> page_private on the allocated sp before it's linked), but the resulting
> logs aren't meaningful -- every captured entry shows spte =
> 8000000000000000, a non-present SPTE, which doesn't reflect the real
> crash scenario where the SPTE is present but page_private returns 0.
> So I'm not sending those.

Ya, I wouldn't expect synthetic injection to help root cause this.  
 
> Natural reproduction is rare and I haven't caught it yet with your patch
> applied.

How rare is rare?  Are we talking hours of runtime?  Days?

> Given that, what would you recommend as a next step?

If it's not too onerous, keep trying to reproduce with that initial debug patch.
If the time to repro is several hours (or more), I can try to provide a more
elaborate debug patch.

> Would lockdep, KASAN, or RCU debugging (CONFIG_PROVE_RCU) be worth enabling
> to catch the violation when it happens naturally?

Hmm, of those, KASAN has the best chance of being useful.  Thought it might make
reproducing the bug even more difficult.

> Environment:
> - CPU: 13th Gen Intel(R) Core(TM) i5-13420H (12) @ 4.60 GHz
> - RAM: 16GB (15Gi usable, 16Gi swap)
> - OS: Arch Linux
> - Kernel: 6.19.10-dirty #1 SMP PREEMPT_DYNAMIC Wed Apr 8 06:08:08 GMT 2026 x86_64
> - /proc/cpuinfo: https://pastebin.com/pwvNYsCu
> - .config: https://pastebin.com/z4fVZENs
> 
> The crash occurs while running an Android emulator (QEMU) under host
> memory pressure.
> 
> Signed-off-by: punixcorn <ohyunwoods663@gmail.com>
