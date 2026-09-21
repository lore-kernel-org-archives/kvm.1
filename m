Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com [209.85.216.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59A173D903C
	for <kvm@vger.kernel.org>; Mon, 21 Sep 2026 14:07:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789999625; cv=none; b=H7peiFAgWvIrnxLuRyUBVKuwSH9aLsnzr722jnkzDg/ge18/nqYI1FT+M/wDdknf1S4p3bPRIyveWURExctfcy2fTY7i0U13TzqoWWXOUhqbM9oj8IEe11WBguCxPizxyiNZpA7aFeGNGJ9WiHv+jR05JscA0UUkBZ08lI9MHD4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789999625; c=relaxed/simple;
	bh=4FcMiyOr8OPxtSjpSLiPSozoHGd1Js2MFl2iRYuYwRw=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Jtt/k3fsXqUZtBeiqxpEPG2tWHHa3AEHhPxF9CI7SOnJ/ZjvTMpbdleBeYfVsTu6XQsZe7n93MVNVw6TPl6zjMq4/3RHWpMsVAHbQHVvJbZQxJ+VH+iIHVVvq5fCzOuyd/5uYReIh1zdXa6pVdXy+aGpd9d8htxaq7hs3wgOcjY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=JoiiYjsE; arc=none smtp.client-ip=209.85.216.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="JoiiYjsE"
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-39de1f85cb2so3821799a91.0
        for <kvm@vger.kernel.org>; Mon, 21 Sep 2026 07:07:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1789999624; x=1790604424; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=3+kxUElgm+ZfMM9aqTH6DJ1cXpFwb4T1UbDL65Aqg/A=;
        b=JoiiYjsEyIQJi+RI/QReUys0iRYwtN6KLUuIF9b6BATT/BS3PAaQqICu9ZozU8Ow7c
         cxviO28BEfLd7BstJdpGXNG6xpoIaozuIQTyf7XquaRIm3OMhfqCVxfEpe7OdJN7Gjlo
         WQD1lyCem9rkBkI6JaAzTWTx4clYlUDbzR6gVyFrrPqUKoJNnYqrc4jp8A+lWWp0mhtA
         4fuyD3YT70tdO8AcCw6ENrZGu+CfGw93oYUe9ADira/T1Mj0yH6H/LferwKM34ubUztm
         TmMsfEyLCaCTHGZs6l9xJ/kPNDGJZeTkSvLATNSuLo28zxMKA7YSBJjxR1ScKVgEYaPO
         wlXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789999624; x=1790604424;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=3+kxUElgm+ZfMM9aqTH6DJ1cXpFwb4T1UbDL65Aqg/A=;
        b=ODm+klKljgRlAbExCNuEKerqrbpyxqPYsg0ZMSqxXTR9KqwdT4oiUaLO19ho+78Vgm
         S9RAgMMNGHs5XUQHet68IwlXGekr6ox+149vV2oER+E4TC3hkqX8M2cHPheEfvint2mP
         xOFk39tCzLeqwl7ytnk0dTcJW2DDnREK6LTuGx7pRgUoDvN90O3MGOJvCu2ogwJYj960
         EueL9sM3NDQMcmInmKLyITPx8A+QJHbENeM7V9kOniuDEZZg2f2bpzPcECj62j2zhz6m
         QLDSkNpDpa0fbDaCiZHiVaZMn5xp5mvMFqj8J03584DvUGyvcSFa/83sZIA5C5hZIvgY
         YIYA==
X-Gm-Message-State: AFuF++kfr6oyyc3pRwDhlPEzOPCLXmDvq4eUteBEEe8De5F0s1MuhyvH
	HVD6+ra7JhNKXbHkg34ONoIg3CAYDVlsTYA9dU09EhcRzkTcowZzBaL5aLt4ZcsyqAuO8eUAEaY
	OvgrAQQ==
X-Received: from pjbsg15.prod.google.com ([2002:a17:90b:520f:b0:39d:94c4:375f])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:4ac7:b0:39e:252:ae4d
 with SMTP id 98e67ed59e1d1-39e54f9d387mr15517055a91.17.1789999623550; Mon, 21
 Sep 2026 07:07:03 -0700 (PDT)
Date: Mon, 21 Sep 2026 07:05:26 -0700
In-Reply-To: <20260826164214.756512-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260826164214.756512-1-seanjc@google.com>
X-Mailer: git-send-email 2.55.0.1082.g2b9226bbc0-goog
Message-ID: <178999899502.746042.13434207152687268434.b4-ty@google.com>
Subject: Re: [PATCH v2 0/4] KVM: x86/mmu: Fix pre-fault and map private loops
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Rick Edgecombe <rick.p.edgecombe@intel.com>, Kai Huang <kai.huang@intel.com>, 
	Yan Zhao <yan.y.zhao@intel.com>, Sashiko Bot <sashiko-bot@kernel.org>
Content-Type: text/plain; charset="utf-8"

On Wed, 26 Aug 2026 09:42:10 -0700, Sean Christopherson wrote:
> Fix a bug in the pre-fault path where KVM fails to reload an invalidated
> MMU root, which puts the KVM_PRE_FAULT_MEMORY task into an infinite loop
> (although it's breakable, so not fatal to the host).  My best guess is that
> the test started failing once PREEMPT_LAZY was enabled by default.  Note,
> the bug is *really* easy to repro with a to-be-proposed patch to have KVM
> do auto-pre-faulting[*], i.e. prefetch surrounding pages on fault.
> 
> [...]

Applied to kvm-x86 mmu, thanks!

[1/4] KVM: x86/mmu: Reload MMU on *every* page pre-fault attempt/iteration
      https://github.com/kvm-x86/linux/commit/355323a4dc94
[2/4] KVM: x86/mmu: Harden "map private PFN" against unexpected root invalidation
      https://github.com/kvm-x86/linux/commit/698b8c88e159
[3/4] KVM: x86/mmu: Top-up memory caches when retrying "map private PFN"
      https://github.com/kvm-x86/linux/commit/6415d9c4ee19
[4/4] KVM: x86/mmu: Add sanity check to detect stale page faults in "map private PFN"
      https://github.com/kvm-x86/linux/commit/f7a3be227619

--
https://github.com/kvm-x86/linux/tree/next
