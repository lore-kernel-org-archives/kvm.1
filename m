Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com [209.85.215.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F7A223BD05
	for <kvm@vger.kernel.org>; Tue,  4 Aug 2026 21:59:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785880750; cv=none; b=U95f505C3d7EtzBnTHtcMM8CWs16kkgg8h7IiRcLsPc11eOCn5reSKs76z4pXFcKjGe/pDDPhxIawA4HqC5shCMyFBaf1vgvmSMGwjlN+ZYkL1NVIok4r7kdPCjjCnlWfkCiiJz4F6FsXFE+vbYatHzCDuBFi73mmIzppkH4RjE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785880750; c=relaxed/simple;
	bh=rzsm1Og1+Pro9WxLmsneo1BIFN8FVoLBc08QmBOsYPI=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=kKnjwj1eHkusce+Azv1l65JOtkR5W3KbLm2Aw8QG10c3TVlvY9mOgwifIMfdgGBRNXIC4ymC5Ap4pLRLL2L4/Az4mvA27JBegBJdAj2I9FgBIwfhnkRn6HLg81H1L24p6coE32EOGA5ozxSIyLsUo8AbjU0SGebt4n7JPhMo22Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=gbPwu/WJ; arc=none smtp.client-ip=209.85.215.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="gbPwu/WJ"
Received: by mail-pg1-f199.google.com with SMTP id 41be03b00d2f7-cb6cf425e86so251621a12.1
        for <kvm@vger.kernel.org>; Tue, 04 Aug 2026 14:59:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1785880748; x=1786485548; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Dhc7N1hQKet78fMxmoZ11biZ2HS+JiXgm3DEUzu8sT0=;
        b=gbPwu/WJroncOlA3k3yb7rFCo0IB81pMTChBk94ikKSzfNLRYpvdqORBT3Fu6YoCny
         bkRY+fONrNwQF1K9Wis0vUczIdxyMimg02i8Rt6gK43xMHM4O6lDo+WASlDrdOM510FB
         hgFOEFkFHCEfhu+lFBgeanXSDDErkfdoYsUe6T0K8YDP6910hTWB+U0iYO/PwLOptNFe
         2w2gjqRo1xpvawWsX1KoEr2OyILMpvMwW4Anh9m0eYUgZ2MEOWMNTrkU/STbVPg1sDEE
         W5ddEiOU9BquHurXkx4Gc0SDTUv8NUKd/lkbCRmI0b00J4A38PKCG7fiUG1GKc1/bbrJ
         r2Rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785880748; x=1786485548;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Dhc7N1hQKet78fMxmoZ11biZ2HS+JiXgm3DEUzu8sT0=;
        b=cV6MIyZddRRVFPXqfhj2xR2ga+hyA024tjWNv4GZxYF26QWUFAzaVUxvmzNt+v9+Ru
         /X09CUgYd3eOAAauCggybsx2cykyoeuZ++XN2sl251puiUnVM+H9S1OYZKSMjFrekh5W
         ywGxS/65oItFkp/wCMQL5CQkjjNHKCTzGWKwEt9iWl1rbP4kPuRj8k6mzTZ5hTMUEtaP
         zBUKO/ujP2XaGW32znakvIitTpa5nilAdzE42LydaShzSpzTKQ38Y4UABzgJogH+ytII
         i8bBUW3ebIVol0NZkS8oQYiyDLZ0IfAJzmsxp8be1r+eGU2LvaRJ4gVlh3CaGW1qPzR+
         EvwA==
X-Forwarded-Encrypted: i=1; AHgh+RqDbnk13XPbeIUNq7k4/jl5gZu991TPkbJ5907RMY05gU2Me3smtwpwFgW9ZYPMw37m/rU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwitDtMKaMeWrLqbufYM7Xrm4pHyroYEpwU3S6KOMaUnN25MKtM
	f3GvF11UzdorS+VHqSB4BeCaNXz5KoKPATW8vzYevigvsoZwmIpO+X289A/QJeKghMpomqZ/Nqj
	XL8PRjQ==
X-Received: from pgbdv13.prod.google.com ([2002:a05:6a02:446d:b0:c9a:3646:2398])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a21:998c:b0:3ba:cd5b:3dc8
 with SMTP id adf61e73a8af0-3cb8603af30mr1757125637.31.1785880747446; Tue, 04
 Aug 2026 14:59:07 -0700 (PDT)
Date: Tue, 4 Aug 2026 14:59:06 -0700
In-Reply-To: <anE4GtMa33nz7qdK@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <178552799129.2700794.10181439022561913222.b4-ty@google.com>
 <8b90851f38ef5b10cdcdc70e7543bd6b0b5e2773.camel@infradead.org> <anE4GtMa33nz7qdK@google.com>
Message-ID: <anJgqpOJGPjLAqYe@google.com>
Subject: Re: [PATCH v6 00/36] Cleaning up the KVM clock mess
From: Sean Christopherson <seanjc@google.com>
To: David Woodhouse <dwmw2@infradead.org>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Jonathan Corbet <corbet@lwn.net>, 
	Shuah Khan <skhan@linuxfoundation.org>, Thomas Gleixner <tglx@kernel.org>, 
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	"H. Peter Anvin" <hpa@zytor.com>, Vitaly Kuznetsov <vkuznets@redhat.com>, Juergen Gross <jgross@suse.com>, 
	Boris Ostrovsky <boris.ostrovsky@oracle.com>, Paul Durrant <paul@xen.org>, 
	Jonathan Cameron <jic23@kernel.org>, Sascha Bischoff <Sascha.Bischoff@arm.com>, 
	Marc Zyngier <maz@kernel.org>, Joey Gouly <joey.gouly@arm.com>, Jack Allister <jalliste@amazon.com>, 
	Dongli Zhang <dongli.zhang@oracle.com>, joe.jin@oracle.com, kvm@vger.kernel.org, 
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	xen-devel@lists.xenproject.org, linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"

On Mon, Aug 03, 2026, Sean Christopherson wrote:
> On Sat, Aug 01, 2026, David Woodhouse wrote:
> > On Fri, 2026-07-31 at 13:09 -0700, Sean Christopherson wrote:
> > > Applied patch 1 to kvm-x86 clocks.
> > >
> > > [01/36] KVM: x86/xen: Do not corrupt KVM clock in kvm_xen_shared_info_init()
> > >         https://github.com/kvm-x86/linux/commit/3d4b20b5a7df
> > 
> > Thanks. Could the clocks branch be based on something that includes the
> > timekeeping work from the timers-ptp-2026-06-13 merge (in v7.2-rc1)?
> 
> Yeah, I can rebase onto a 7.2-rcN.  Y'all are likely the only people that care
> about the above commit, so a late rebase isn't a big deal.
> 
> There's basically zero chance I'll get the entire series applied for 7.3, but
> "Use ktime_get_snapshot_id() for master clock" is at least in striking distance,
> so there's no reason not to allow for the possibility.

New hash:

[1/1] KVM: x86/xen: Do not corrupt KVM clock in kvm_xen_shared_info_init()
      https://github.com/kvm-x86/linux/commit/633d7652f80f
