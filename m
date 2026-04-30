Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 631601B7910
	for <kvm@vger.kernel.org>; Thu, 30 Apr 2026 19:17:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777576625; cv=none; b=h+xT7F9mveJouxG6iPeW+r2fb/qXEgFHegxroH7BC9zr6LGaAq1ys9bgWTCrEvepsKr8ezSq1hTcCPIE/li3jBUE2+scqQqm4ezZRyQ6kHUp2VUumpM9lbJUgr9wXXaaxMb88vcOXtw8xHHb/u1E/j9kV61vxHA9Vfu/YcfjnwU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777576625; c=relaxed/simple;
	bh=Zjq4yilAZmVneITUrrrHIxDDi3FDuhUxq//ZK1Ib6KA=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=pJTCcOM3zcS89vyg1p6uKQ01rBT8ixpe/k5IfusH+O3oH8zA3938McfyesM4OFM50a4qWBcy4RtPt1CMWhZ5iwnP9w029HBEc9WP5L+Uu0Q5WvDLIsYO7yF8wTDC95RafREMKijFFz0f0DueId39SZVbRx4NBtExhxATCOWL/Oo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=cTi50ADu; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="cTi50ADu"
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-362d9dd9a49so1433606a91.0
        for <kvm@vger.kernel.org>; Thu, 30 Apr 2026 12:17:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1777576623; x=1778181423; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=C2YBsxQr+wJvP0XyhnNXzQEpvw+D0bLjYdQQ+G39oxA=;
        b=cTi50ADuIw8KLbTX85QiB4S0/Nc2jMEGb0I2XCOJjwFyO3NbvijtnNPClH43e5mYpz
         RvVvabcqb8LXq722pUDC9SCCDx0S9wkXTSrzW3jxeYcwmZ8kIP/gSWQOfM1CIrPAhJQl
         R9+IsrPHVnWt3yphcZagHn7skSIc8f7P0gC1b3sgwmfGRj+yPx7f33I1lwuHVpIkwkVL
         E/pp6kThOwt4xVEOjlHtI5LkAUnCtCwv9BI800x+2QMOw6oZKHg4xui2IYpP01gpbX8R
         +49+WMBzEdokF5Z/TlVFp2A79HNLGXYuu3dbaP96QAU2CBtNAjs1X+4T6x38qDdMeuYb
         x/9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777576623; x=1778181423;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=C2YBsxQr+wJvP0XyhnNXzQEpvw+D0bLjYdQQ+G39oxA=;
        b=pNjTUP+PebaveIlVBfl89/gc2zS99tJlJhj1lIKgeLu8w2qUUOdXe3+WhmduW6QvIX
         f/hIoeKsCmnu5Yu3WPORGZCURLwLwvF8b/6iL4ZUeJfjuBiwlVeEOfNyWgq0pckwiFcm
         O79Gk5VjtJzzgbgJtBwbH2McDdzVIV90EVacmrUXBwKoXMUzn43JBnOdxrk+dyM+TJmn
         WQycDhQpK/4vaDMfBjOMmfvzI62EJY+pYUw+N2NV+58mz51qJO+GpJpWnl1a0h5EC1Xy
         /VR4jDHTPB/LMPXYvxQbkui/tQT39HQA4FRbaQxoWo4XzUzKLqrdjTyYKqq22Kpl0L+8
         UZPw==
X-Forwarded-Encrypted: i=1; AFNElJ/aPlXbda24ZKJtnE6m2XfC3zIlNwgFx+IVz7nvcMxOivAlaO8jqh3OLfBYJJSJHlHfVB0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw/01BCMFjIJbqzi3mSKDdAlA2oZSv1xB7qb58XZ8KxDvxsq6s+
	BjZLvvHCdGfsI3UIdxhF/BAXekD76+RLdLO4AKaQV9xpHqCuWryRzTX6owtuC8WrVFNpbIE+DW+
	Dvd1zNg==
X-Received: from pjnh3.prod.google.com ([2002:a17:90a:8303:b0:35f:be31:1a85])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90a:c885:b0:35e:30bc:96ed
 with SMTP id 98e67ed59e1d1-364c2f8f8aemr4490567a91.10.1777576622670; Thu, 30
 Apr 2026 12:17:02 -0700 (PDT)
Date: Thu, 30 Apr 2026 12:17:01 -0700
In-Reply-To: <7b4dc292-a2e2-4d42-9e4a-bb1fe37a9013@redhat.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260430150747.76749-1-pbonzini@redhat.com> <7b4dc292-a2e2-4d42-9e4a-bb1fe37a9013@redhat.com>
Message-ID: <afOqrUcq6Hi7DuaA@google.com>
Subject: Re: [PATCH v5 00/28] KVM: combined patchset for MBEC/GMET support
From: Sean Christopherson <seanjc@google.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: linux-kernel@vger.kernel.org, kvm@vger.kernel.org, d.riley@proxmox.com, 
	jon@nutanix.com
Content-Type: text/plain; charset="us-ascii"

On Thu, Apr 30, 2026, Paolo Bonzini wrote:
> On 4/30/26 17:07, Paolo Bonzini wrote:
> > I will once more send you to v3 (https://lore.kernel.org/kvm/20260408154217.458420-1-pbonzini@redhat.com/)
> > for the description of the series.
> > 
> > v4 incorrectly rebased onto 7.1 KVM and broke the case where L1 disables
> > NPT.  On top of that I made a few final touches on the patch split, and
> > opted to use the XU bit unconditionally in the MMU even if MBEC is disabled.
> > This is more consistent with the idea of reducing as much as possible
> > the differences between mbec=0 and mbec=1 modes.
> 
> I placed this also at branch kvm-mbec of
> https://git.kernel.org/pub/scm/virt/kvm/kvm.git.

A decent number of nits, but nothing that truly necessitates a respin or rewriting
of history.  I don't have a strong preference between doing fixups versus cleanups
on top.
