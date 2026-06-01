Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B899D3B9922
	for <kvm@vger.kernel.org>; Mon,  1 Jun 2026 14:15:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780323342; cv=none; b=oM8csiSibmC+10sHEdJ/dmOCur5UYqmWEaclpOjGj9/l3zoD12eqXRdTBAmuip/CEVK4mwUW7swu4FdEEOjO9nnPWqXGLsiVrxHMK3bqpXBGGuWDpPpnwrtQhLF+8sq09C8bHSrYKfjWRUl6wL25LEKfghfMSzC9gvpy5LkDo9s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780323342; c=relaxed/simple;
	bh=nJXF4s+DEVXbVOZZobK1ukBBtQjnHXLnjVrmFG8C7s0=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=GbgmIoko4Bs/G6EH50Wy8fpeGMLj+Uosdr6AJ8+94+OFBbuhqJqpZ/XRd56cuHPcYQevVi7sQqgSQyOEx7eQk9WhA5Y/J3HAyAr6TWoDoQM9V4aP5OTiG3a9QDssVxYZsM25sFQ9cScgC6S90jaJTelw3ZxpnGANnwGmafj0uwg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=t+qPPsZ5; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="t+qPPsZ5"
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-36d98b74447so1103576a91.2
        for <kvm@vger.kernel.org>; Mon, 01 Jun 2026 07:15:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780323340; x=1780928140; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=n50JlJPE/55hRNplF1JVi4aw/bueramiP42nDwOCCMI=;
        b=t+qPPsZ57owWfuBKUIEx62HXq6s97tZi8CBiiSz7Po9W+LzH92YdJgcXdIYNpxE8is
         2CQ8msiZJK5s396zUf1YVkYg3taW2jWDuXE84Vwf9o29Dr7ujeEnwDaw+F8U67D1Tsap
         cfOWitaomR2s/5d7tKsqh60izCH9A3p5YBjW7BQP7g3ml/dfwaTN0QlbE3aDNOEucV+X
         ldavjETJVdtRdLN4qmgqhrfaWGpauae5SnnYoU5KzTmYWSosKqDnZrKb+29fS7IBBOFo
         350WyZvnAlyc+nNTkTjdGAkRy4Gtial6ixnwGQtpS49wUoMSmtMztPH+620cgqIIzi8b
         XCIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780323340; x=1780928140;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=n50JlJPE/55hRNplF1JVi4aw/bueramiP42nDwOCCMI=;
        b=an+mMJR127wA5zNpLbqB89VxGHUN0uLC8F5e1ZbbvasFQkMh15Y35AxEq6SFvJLeLu
         skbZK42S+PScbWU/NosOlXwL75KKErPeP03DryzF8EBfUtV20PmBTrxqWufgNmq8YHB6
         5yOFhBkaU5obdVNiP3Ebs8Cs45kmP9IzNsuBL8cIUSiw7Hg7ctCAVThPdiYFx3SLJMfK
         u3ex3SNjZsGfzMWWOoX1pdmX4F+dDeATm992Avx+T6BgYRbaLsdx+O/YQtaDdYxdwfuP
         w+9j1PkBPclw2LSA+hHypGUe3PrPEPBhz1ltWMv0v8NMfK2bTA+Qg8IY9xaN2Ioa2LVy
         YN6A==
X-Forwarded-Encrypted: i=1; AFNElJ/r9Ma2HCekvqmMidLM2i/ABYmNV2cysnAsmJFVJ3T3lf3mgq2mkt9FhiWRiSWuBttuNEE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwYWS+vCNbOS8DOBPMfxosBvcNMzEVL1Dj533rhbnKfVSDTBIEd
	VZx9S7yZ7T595FffLPTuHBl/9gMJB/QUVFpZUJY4GZrmfiMmWysmzHDaaN8GvfmQbwCosOT5dHd
	B4mIuYA==
X-Received: from pgab135.prod.google.com ([2002:a63:348d:0:b0:c85:9c9a:ab50])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:57c7:b0:367:b8ad:f0e9
 with SMTP id 98e67ed59e1d1-36c501c723fmr9889546a91.16.1780323339681; Mon, 01
 Jun 2026 07:15:39 -0700 (PDT)
Date: Mon, 1 Jun 2026 07:15:37 -0700
In-Reply-To: <ahoyE72rGb1dPrSC@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260529222223.870923-1-seanjc@google.com> <20260529222223.870923-16-seanjc@google.com>
 <ahoyE72rGb1dPrSC@google.com>
Message-ID: <ah2UCaDJdfTwlMTU@google.com>
Subject: Re: [PATCH v3 15/40] KVM: x86: Move the bulk of register specific
 code from x86.c to regs.c
From: Sean Christopherson <seanjc@google.com>
To: Yosry Ahmed <yosry@kernel.org>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Vitaly Kuznetsov <vkuznets@redhat.com>, 
	David Woodhouse <dwmw2@infradead.org>, Paul Durrant <paul@xen.org>, kvm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Binbin Wu <binbin.wu@linux.intel.com>, 
	David Woodhouse <dwmw@amazon.co.uk>, Kai Huang <kai.huang@intel.com>
Content-Type: text/plain; charset="us-ascii"

On Sat, May 30, 2026, Yosry Ahmed wrote:
> On Fri, May 29, 2026 at 03:21:58PM -0700, Sean Christopherson wrote:
> > Introduce regs.c, and move the vast majority of register specific code out
> > of x86.c and into regs.c.  Deliberately leave behind MSR code (except for
> > EFER, which can hardly be called an MSR), as KVM's MSR support is complex
> > enough to warrant its own compilation unit, and doesn't have much in common
> > with the other register code.
> > 
> > No functional change intended.
> > 
> > Signed-off-by: Sean Christopherson <seanjc@google.com>
> 
> This is not just code movement. You're also renaming and introducing new
> helpers in the process, making the patch not so easy to review.
> 
> A wise mine once told me not to do this:
> https://lore.kernel.org/kvm/aYU87QeMg8_kTM-G@google.com/
> 
> I have been waiting a few months for this, so here goes:
> 
> Stop. Bundling. Things. Together.

Gooood.  Use your aggressive feelings, boy.  Let the hate flow through you!
