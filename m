Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C23F941931C
	for <kvm@vger.kernel.org>; Tue,  9 Jun 2026 16:32:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781022749; cv=none; b=IFBbIfB7Ofp0Dk7VtN6bf5AU9vKjAFCyz+qwg2dhErEd+gCvtmeuKGnA7UD7YUX/ZWHOpHdCpo3vCTm4o4z9Jum3BvE5dJ2dO7ETZpWtx7AqCgnwhv2PBe4UaW4Ukh4Ac2z4fBlhDe4rD8MOt6B6AP/9uKi1XrVkdX6G9fbEaTs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781022749; c=relaxed/simple;
	bh=SNCgZCNQ4+mVzcSRw+SrX0oxuV8b2cqgc4DGUoDCJLY=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=HBds7rKp+0/PGccRe8avV26PQZ1zg+r9U8zh8zW9hGHM6efxcSkvbZN1FQeyz9DLG0D/2pp4a8m9zhrh6pPli/RYaCa6WFiqysg5GKjxpTRI+jIIYiR2inpHnqboPFPp7Pa7TB0kgiqjnM1KjTJx37LY8b0TspNrmOcO6JoaSOI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=qKGrw33z; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="qKGrw33z"
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-2bf08c2a24bso55113085ad.2
        for <kvm@vger.kernel.org>; Tue, 09 Jun 2026 09:32:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1781022748; x=1781627548; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=2evv2a8uJS2PibYv6ZP4hxfC0Uan119ZPWkGwEPt04U=;
        b=qKGrw33z6H9gE20KpOTQAAqhLmUJshj+jxU9An74+5wy3QGOleRf5YXNm0jrGELdME
         ICWukgZ+AatnF8mabnkUNB6dybOwJtzlD3Qw4cutIlt0kpWbCU1yWfPOQhrgW9r8Yuje
         NRCqZtIV5GzuWwQV35nfAM2n1Frp3xlvaAKjYI+vgvp5fHUFL+nLWCFvDbF8OtoBZIpP
         ie8qCq69IFDnzWR9LArRR7H/kpnTVa3o98/7tgqlleL7KR8NXAwfBk8/lO7JXc/QTFSJ
         k3l6h/q3h0rGsYdyDYyaNolUkw5CYTGiLoAiPlSWSMIAppWgWDtpI0O+pCN5SKzLC0SI
         krHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781022748; x=1781627548;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2evv2a8uJS2PibYv6ZP4hxfC0Uan119ZPWkGwEPt04U=;
        b=C51zwxUEwBqt7E/OPCc8Fqv4p+WGOsC6b79vNRLVNj2BLOe+u8a65eATgieJ+j8rsG
         MCyk6MrW5mqveiiTJXtPNUoDWi4P9Vhmrbkl0Re2Z7FGh7EviD+kzChR5RDmViY0KLUn
         r6buwTzbIBiSVuD6TvPur385JJmIl1EycD2B5hHB+Lfc5t7INAraGiCUW44NmZIHEw9B
         69vz1N3baaeEpUAJ4m8NwNqQedAEbk+hJMAo054igSOTaM4meoSgvRYYAcAO4oi7KlNi
         P26hKZ2hSMTEmFsPxJgX2zkJ5oGwT8vW6q+ThVdNwKZG8nnJklnObzNnyi0cHdA9fs3l
         /Osg==
X-Gm-Message-State: AOJu0YypX/kjHbbx9mp8F31k/4jzeLMMGcbhTvz9qW3p5SRntD7SMk+T
	wv4JQJLl9p3uZ1S4BlluGhUO9wmYlpuaU/g2K7iZYx2NnVc41UNNyO3DpjHirTd81qtvJ9VJSZa
	2R314hQ==
X-Received: from plbjb7.prod.google.com ([2002:a17:903:2587:b0:2b0:c9c5:109b])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:cecc:b0:2c2:9254:4c22
 with SMTP id d9443c01a7336-2c2a1c66cbcmr47271625ad.17.1781022747989; Tue, 09
 Jun 2026 09:32:27 -0700 (PDT)
Date: Tue,  9 Jun 2026 09:31:37 -0700
In-Reply-To: <20260605174611.2222504-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260605174611.2222504-1-seanjc@google.com>
X-Mailer: git-send-email 2.54.0.1099.g489fc7bff1-goog
Message-ID: <178102229103.2735402.4439696190213714484.b4-ty@google.com>
Subject: Re: [PATCH 0/2] KVM: x86/mmu: Plug an unsync shadow page leak
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Yosry Ahmed <yosry@kernel.org>, Jim Mattson <jmattson@google.com>, 
	James Houghton <jthoughton@google.com>
Content-Type: text/plain; charset="utf-8"

On Fri, 05 Jun 2026 10:46:09 -0700, Sean Christopherson wrote:
> Recursively zap orphaned nested TDP shadow pages on emulated writes, not just
> when the parent is being fully zapped, to plug an unsync shadow page leak if
> the L1 hypervisor zaps bottom-up instead of top-down, as KVM's TDP MMU has
> done since commit 8ca983631f3c ("KVM: x86/mmu: Zap invalidated TDP MMU roots
> at 4KiB granularity").
> 
> Gory details in patch 1.  Patch 2 adds a stat that, very thankfully, we more
> or less have in our internal kernels, and without which, diagnosing the bug
> would have been much more difficult.
> 
> [...]

Applied patch 1 to kvm-x86 mmu.  I'll send a v2 for the stat, targeted at 7.3
(I want to give folks more time to weigh in on adding a new stat).

[1/2] KVM: x86/mmu: Recursively zap orphaned nested TDP shadow pages on emulated writes
      https://github.com/kvm-x86/linux/commit/69397c92de77

--
https://github.com/kvm-x86/linux/tree/next
