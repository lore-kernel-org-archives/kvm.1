Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6556D372B4F
	for <kvm@vger.kernel.org>; Wed, 10 Jun 2026 19:20:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781119235; cv=none; b=QsKXLD+Y2aWME5Ax7+ZYs53caLOHs8xCFetrW6XKZ6Z4jYfMWxjw7k5+HH/PquegSkTvb/O8+rg+c/YFPlBciskRbR/1r5S/zgJ40lBThHyrKcAr6i3VwGOczFXCMVH34H7jjbOwMQ6WGy/pnFiJeAtV87THiafmcOFNhC88qkE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781119235; c=relaxed/simple;
	bh=ibXY4lUk2DRCYZ1FGiZekl7s7+d7c+g3KmcX+nfztQM=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Cuo4DhhRLtheqiKC2XhfGWhXEHIMImYUo3km8IVKczEx7Egm3DNOVvHAK5TXDRXRsf3fwktDmh2IJxOSYaSYJsoWuonDTrzO/3g2AzpeQG2zquPZjsMGf1WbjYJufmkaU9mkh/0IVnQVOyTDxvdP6HCQnUvn8c175C7xijAEG/I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=gw1kaFK7; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="gw1kaFK7"
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-36d98b6f019so7060879a91.2
        for <kvm@vger.kernel.org>; Wed, 10 Jun 2026 12:20:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1781119234; x=1781724034; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=rXbhmrrYImUQv4H/dhcmoVKM/0EEFpXQX6uTvjIXuTw=;
        b=gw1kaFK7KMu6aN1Jtgz4zHsI1E/J1SARM9tHW/Ich/ie3OE/TeCOUd+dQh/iItaeY4
         1FozcsVsR56nF7WMnPl04ELDTeP4POanj+XwrPyP7x8f24AGW+kizFLX0vfih6LBLsi0
         ta6K5erDeZg6VqUo+4eTdTB7ZL8TZCNP7U7wz8D8JICabG7fSRhwsLyTcqkyHkk99Vq3
         3L9KovuRXPe9t7nMHERajyFyMjhzGFwuIXVhdT8sht5slBx9/d3BFGD48W06pxNji8Fv
         +aLezLFLntyXESSVcEDSISCJGMTmMsBiPTJ/jVXAGye67d4UdX7eyXazhVn4Tu/iwhQA
         VRog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781119234; x=1781724034;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rXbhmrrYImUQv4H/dhcmoVKM/0EEFpXQX6uTvjIXuTw=;
        b=htasLXfoWUB8ziTYPfQCZjyMZFMjBJzP58xoljcVOjCHQ+5ELur+LD6vBctGop4mPX
         +v0uEgLfgf4jUYMfS/A5AsAXnNI7++Q+ieuLkT0KbOWSsRqFrke12s2eNZu2I+OIfuGd
         pBEylg07nbVtdFfA0qC2bjPOUJLvOF0T/Kowaw2x4ggCyt6js4or9k+ftoz3AcoD8Vve
         yr+S2boCHQo2hkkq6tchGAWlG3hF1pPeW5TICw8QO14phtKa7dwbAeNcx8XAPMqSI39Q
         oxHocHiSv5o4pVw9FRX8kV1Fx7+kujuYPyHcxzXh/0E8aO8vgo2O7sftkvDD25D7vJhh
         8hSw==
X-Gm-Message-State: AOJu0Yx7M82qMS24EAgDm/4KPC0RDd0eCGddfEW5gHHGnK2LTuuvnbmX
	GFCsHvsY8lgJJaiFIOIA3VDxayxjE/xajYc6UxvPvAy7/ti9uLePaaqXCt1UKmhwtYACIM1IG0I
	+58ix1Q==
X-Received: from pjyt18.prod.google.com ([2002:a17:90a:e512:b0:36a:8554:a396])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:5747:b0:368:3d3e:efa6
 with SMTP id 98e67ed59e1d1-375212a2eebmr9794823a91.20.1781119233493; Wed, 10
 Jun 2026 12:20:33 -0700 (PDT)
Date: Wed, 10 Jun 2026 12:20:32 -0700
In-Reply-To: <20260610010658.1E0501F00898@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260610005338.2967132-10-seanjc@google.com> <20260610010658.1E0501F00898@smtp.kernel.org>
Message-ID: <aim5AGJwj6tlkigX@google.com>
Subject: Re: [PATCH v6 09/18] KVM: selftests: Verify interrupts are received
 when IRQ affinity changes in IRQ test
From: Sean Christopherson <seanjc@google.com>
To: sashiko-reviews@lists.linux.dev
Cc: kvm@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"

On Wed, Jun 10, 2026, sashiko-bot@kernel.org wrote:
> > @@ -192,7 +198,12 @@ int main(int argc, char **argv)
> >  		printf("Using device %s MSI-X[%d] (IRQ-%u)\n", device_bdf, msix,
> >  		       irq);
> >  	} else {
> > +		TEST_ASSERT(!irq_affinity,
> > +			    "Setting IRQ affinity (-a) requires a backing device (-d)");
> > +
> >  		eventfd = kvm_new_eventfd();
> > +		irq = -1;
> > +		irq_cpu = -1;
> >  	}
> 
> [Severity: Low]
> Is irq_cpu used uninitialized here when the test is run with -d but without -a?
> 
> When a backing device is specified (-d), the code enters the if (device_bdf)
> block and irq_cpu remains uninitialized. If a vCPU times out waiting for an
> interrupt, the TEST_ASSERT macro evaluates and passes the uninitialized
> irq_cpu to the variadic format string, printing garbage values.

Gah, I meant to initialize it to -1 (hence the signed %d instead of %u).
