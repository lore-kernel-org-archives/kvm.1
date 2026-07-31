Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com [209.85.210.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87547377A9A
	for <kvm@vger.kernel.org>; Fri, 31 Jul 2026 20:11:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785528681; cv=none; b=E1yPdJvZ31cuBiohpxIS4EA/cCfDL0XM/biO25/UCwjVikUvml4h5qAftbVCXt3T+5HToiBn03KFo3jaYrMvYb9bPaDI0uUqJM/+2HMWqNospZxhRQehVRrIFlIFXP49WmT/YD57GuzHyR86bRxHCEV+cdFE7ci8p6Rl7cXkgKo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785528681; c=relaxed/simple;
	bh=ikujtm3HHHpDvNGxFy14i5cscXGSwML1OnPpO6fPqW4=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=eQzyR/ElOKqVX1+tw26OUNkaTj/dgfaCdMhGIglMSKJq2Aj4hkqK+9+lDGGf5TExto3Wzh3cvMujbJtJ0HiHQsNTKzhObqTQQsZoL12yarGgRhManG3MOgFDqBcEhbeHTO0zgk0Tdn4pSxJkOtT7WrlwfItRlPqhxnWThp9GNRs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=lfXvpHw9; arc=none smtp.client-ip=209.85.210.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="lfXvpHw9"
Received: by mail-pf1-f199.google.com with SMTP id d2e1a72fcca58-84a251c2e3eso3028646b3a.1
        for <kvm@vger.kernel.org>; Fri, 31 Jul 2026 13:11:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1785528680; x=1786133480; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=1jQzFcpqBSYYCtWlVzLC7o6CID0+BkEtgiFKx+1cRaM=;
        b=lfXvpHw9p4QyyRV9IVEs5MOhzf2qnpbrjQpIOAcb9w1lgc8IkRpQahCbL8d1qArC7L
         5MuNvOF+A82Q5C6+xJh6htMsvsb0cDOfojSbsQyk+5Oz2bjyl3tiMEX2Nhsgdum4LfKi
         2Cu113w3t1TRZ4PVQo/XT/Yq4sM/rCdKkCg/09J4E+6wdiDHiIXuCKOMSjm9nclGWMu6
         C1QEFhcNOwKcphtZIF5T6p5XBKcr97UtUJULcupasmj1vDvBWvIfzeQtcLFkdm1xh7wd
         0ulFyUlbezPuaVTwlL/tt80X7rJhTx5aVJAC6s2fg3k301x9kGmv08GMeo8D7uI0ase7
         Ho+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785528680; x=1786133480;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=1jQzFcpqBSYYCtWlVzLC7o6CID0+BkEtgiFKx+1cRaM=;
        b=JNdYg+eN+E37J4FijXD62r0NW2rOC9n2qbFFE3LJItAmXwCZ38XQJRF4gerZLTfAie
         80sSgeKC4eNag2BQAvmXrWm3UlyvHKu20j49x71Qq9aptu666fuf2ebNwoFk+UGE+YOe
         FpQYDcC54h+aF7KYM8IAaJc2uberi/VTsr19JpHoYV3GWRadSoR6YRVmv0Yuaeq06ZQw
         NCkMibisPQ+ldhGYITpE/EmYy0mraYuYwRHLGZNlHSewx9MyiMb9xFVMI8cW0+JnsNv4
         HawaE1c/JfiBwnh7ypHXuNFc81C6QG1/96ECFfFIorYo91XWuXOiep+siGVsUNxosiKS
         bdOw==
X-Forwarded-Encrypted: i=1; AHgh+RrpAGVpddz/qmvfq9GXUEiaC3btjTCyWjoGM0SF5L0QJyjQv+9PfstH/D4pqGqfe1/ByFE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzGlGvsucnyRkCEFKB9aPV5NBvt3OfKMG+2ehugEHxqCMwRAvAN
	hxRlGxf3EOSHV8BBH5Ew4pyfghO0K6XdM+GABTFfsi3dg2IO1CA0XBukr7xpG7H8mZ3v9Qm6lci
	pDfkqfQ==
X-Received: from pfbkr4.prod.google.com ([2002:a05:6a00:4b44:b0:847:80c0:ec04])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:3393:b0:84c:241e:9070
 with SMTP id d2e1a72fcca58-84ee486ed75mr804821b3a.17.1785528679754; Fri, 31
 Jul 2026 13:11:19 -0700 (PDT)
Date: Fri, 31 Jul 2026 13:10:03 -0700
In-Reply-To: <20260720-rmap-age-elided-submit-v2-1-668973030d47@phil.gs>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260720-rmap-age-elided-submit-v2-1-668973030d47@phil.gs>
X-Mailer: git-send-email 2.55.0.508.g3f0d502094-goog
Message-ID: <178552831477.2708818.5845774682019110498.b4-ty@google.com>
Subject: Re: [PATCH v2] KVM: x86/mmu: Consume the locked rmap value in the
 lockless rmap walk
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>, 
	Phil Rosenthal <phil@phil.gs>
Cc: James Houghton <jthoughton@google.com>, kvm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="utf-8"

On Mon, 20 Jul 2026 13:45:49 -0400, Phil Rosenthal wrote:
> __kvm_rmap_lock() deliberately elides the rmap lock when it observes an
> empty rmap.  In that case kvm_rmap_lock_readonly() also re-enables
> preemption and returns zero, so the caller holds neither the rmap lock
> nor a preemption reference.  The elision documents the invariant it
> relies on:
> 
> 	 * Elide the lock if the rmap is empty, as lockless walkers (read-only
> 	 * mode) don't need to (and can't) walk an empty rmap, nor can they add
> 	 * entries to the rmap.  I.e. the only paths that process empty rmaps
> 	 * do so while holding mmu_lock for write, and are mutually exclusive.
> 
> [...]

Applied to kvm-x86 mmu, thanks!

[1/1] KVM: x86/mmu: Consume the locked rmap value in the lockless rmap walk
      https://github.com/kvm-x86/linux/commit/e428f9779a43

--
https://github.com/kvm-x86/linux/tree/next
