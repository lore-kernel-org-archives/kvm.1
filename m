Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE43737E2ED
	for <kvm@vger.kernel.org>; Thu, 21 May 2026 19:50:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779393022; cv=none; b=RkGEc1FP6VkwAdl4lb9GBQMpbX9veEN184JjvzMJ7gKggt8ONoF6IicZMG1I+ar7IgILFXAeWE10cozfOSqHvIjiGLEtjvmefdwrAfn4WPjFvMpchkbQ3v5yyduGvi3UE+SYynuvtRe95VM7moKHuB5AtpdaboPQJFji41gYLlQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779393022; c=relaxed/simple;
	bh=/ZbKkyAcvYBKPuByGAh4nYWXs6N0pRg+Qq7OeLqdbwI=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=gYCLgScPMaCNSMuQ7mH3VUCnjyrgc1wrUCXtbYgId/A/65WX8cJPSb1PnWUep3RdNcHGmnAl6Ci9flOVVjIkR0reD0+HZ5fJu+EmaDKAjoJas+F+DyD23qsrFRe0pO6OuPLnicHWz1JQEQt6QZwqCL/c9YLm1ZQWubM0cLigf88=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Y0CLxCOf; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Y0CLxCOf"
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-365e70c39d0so6147648a91.0
        for <kvm@vger.kernel.org>; Thu, 21 May 2026 12:50:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1779393021; x=1779997821; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=mOnAqTD8HITcgpQA91zBiWYGSq+ljWzNcs3GofrtSBE=;
        b=Y0CLxCOf3JQ4i6AZSOj2TGnck+kmd8FEHukWai1Pj41NrwC+M+vN2T5Khn3LOTT1U/
         TcJMICjINv1CzbQZbLVBR4+mRJqUap1cOE8xPZpRNYR53m8U3VXmxD02L28BKI2th8Z5
         xXBFwZ0+maQL9R4lAC9fZWppqyItE1HipYvmtHtW3arM2E5HjNbSUysY5ofo9ghxy0CD
         TT/URmXozH73Pxz9pn46+vSz+U8lUfOFNzyOCIrWatTfr7fIQjfvzPXz2prz+AZ5ClZu
         icKA2PXJTLaZPCW23RqzCIOhjcxN6Pnar2863bOYdaJmA0ua/QkHGatGwkpHLfSFglNn
         qGOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779393021; x=1779997821;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mOnAqTD8HITcgpQA91zBiWYGSq+ljWzNcs3GofrtSBE=;
        b=mqj7wNL2rVgsRPE2rx9YM3cSezbyDgZ6GcM8bhgysea44FtCIschcZyd1j+5MGk3Gt
         6zqFJ7n/2SFBYDQnziSgvwePwgOfrqUlIK9DkRme9hMq0Q2wBkNrY9wu1TLch7SCANHd
         /yGUkCPWR0UYsrezLJpUbpmvbK++6JIKj3p41wi/x4NLHccmcF3cdK+rSgk3geEahqFi
         qqjBqqYyiJoclNi5OCtGG7XMyU14jxO13e1XTKIxTKOWHQiksFBfCxNAWzU0QMG76Ck7
         2ZaTa9zFJim4iRGSXStgyHeMUHVE0juiYyY7sjGD3Byexun1EX+tbktPjLRPwexWiUl3
         /hPA==
X-Forwarded-Encrypted: i=1; AFNElJ+eqCyTa827JhS38++/jQAbDHU5jsow07OGsGDyzX71CHnuOah/pbB4bsB1VXq+UbuY2pI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzfadpw4YqbrACtdv+nzFayp5sWn2kXiphhanjm1OPKjx7WHNM1
	DuSJSGk6sLXbjiQEZT9AUrJFiULLwSFccGWBZCqkdMSGsjI3KUisGnIhAhYHzN5pBQ/l8Yio5d9
	Ffnnzew==
X-Received: from pge19.prod.google.com ([2002:a05:6a02:2d13:b0:c79:8315:4734])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:3f4f:b0:366:132:fda3
 with SMTP id 98e67ed59e1d1-36a67475eddmr666973a91.11.1779393020915; Thu, 21
 May 2026 12:50:20 -0700 (PDT)
Date: Thu, 21 May 2026 12:50:19 -0700
In-Reply-To: <ag9fbbWzOO0r777I@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260511150648.685374-1-pbonzini@redhat.com> <20260511150648.685374-18-pbonzini@redhat.com>
 <CAO9r8zMeg1ta0hL4panuB3D-10PmkwHL+9XKv_0NVjcpq0oJMg@mail.gmail.com>
 <CABgObfZ+TXrw7UpMt2DQUYb6Gwr-+vHy8E3iNbP8WB2z=+1ZTw@mail.gmail.com> <ag9fbbWzOO0r777I@google.com>
Message-ID: <ag9h-77TTo7zEMG-@google.com>
Subject: Re: [PATCH 17/22] KVM: x86/mmu: pull struct kvm_pagewalk out of
 struct kvm_mmu
From: Sean Christopherson <seanjc@google.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: Yosry Ahmed <yosry@kernel.org>, 
	"Kernel Mailing List, Linux" <linux-kernel@vger.kernel.org>, kvm <kvm@vger.kernel.org>, 
	Jon Kohler <jon@nutanix.com>, Marcelo Tosatti <mtosatti@redhat.com>
Content-Type: text/plain; charset="us-ascii"

On Thu, May 21, 2026, Sean Christopherson wrote:
> On Tue, May 19, 2026, Paolo Bonzini wrote:
> > Il mer 13 mag 2026, 23:36 Yosry Ahmed <yosry@kernel.org> ha scritto:
> > guest_mmu is not L2 MMU if L1 does not use two-dimensional paging, so
> > l1_mmu and l2_mmu does not cut it entirely. And root_mmu can be either
> > GVA->HPA or GPA->HPA, therefore applying the idea above (e.g., gpa_mmu
> > and ngpa_mmu) would not work well.
> > 
> > I suppose guest_mmu could be ngpa_mmu or shadow_tdp_mmu, but another
> > possibility/refactoring would be to adjust the code and call the two
> > MMUs direct_mmu and shadow_mmu. I haven't looked into what this means
> > for the code but it would definitely make for the clearest naming.
> 
> I'm not a fan of "direct".  Even if we deal with the CR0.PG=0 case, there's still
> the direct shadow pages wrinkle.
> 
> I do like the idea of reworking the code so that there's an MMU for non-nested TDP
> and a shadow MMU for everything else.  Given that the only thing standing in our
> way of having tdp_mmu and shadow_mmu is the existence of TDP support in the shadow
> MMU, what if we finally drop that?  Then we can have tdp_mmu, which is literally
> the TDP MMU, and shadow_mmu.

And then I remembered the TDP MMU is 64-bit only.  But, I saw you posted 32-bit
nested tests for KUT.  Maybe this could be the motivation to invest more in that
test coverage, and be the juicy carrot that we need to finally kill off 32-bit
KVM x86?
