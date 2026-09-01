Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com [209.85.216.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89B67367B9C
	for <kvm@vger.kernel.org>; Tue,  1 Sep 2026 19:33:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788291240; cv=none; b=VNgZYAhn81XC0ZfTFYksIWSF3OWAYodzluy4Ad5stICL7s2cHSTujI2OMskAoGWV3G5QiiS6GwyAvQoBasJ6LAa3OA+oEUaoD6MZADs559fgBH1/B0cBXZERpimbyLJcoW1nZVTsnzz3ndCpunzEXjN6G3xVSH46ymyu3CTKVvA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788291240; c=relaxed/simple;
	bh=QZCoj1cVP7Hqv2C3oAs0XizEvyiKlG+bPfHrCm4CO/E=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=LlZKhsDWgnId8FXXoQi64WPLs+D6+neH0ANpF8/duZxF70NVp24LqwqS+r359r0cPYbZQO40ngY8hw992gmNCqTmbZKz5VAlr4l6GkrZ0qtychJaPC1VB6w7xU6zO4sxHz+zuJHRPEaQJFZfmUvY/mo5HKWETDrQGJzjVgvwQLU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=e8tmIMTy; arc=none smtp.client-ip=209.85.216.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="e8tmIMTy"
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-39906175917so253885a91.2
        for <kvm@vger.kernel.org>; Tue, 01 Sep 2026 12:33:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1788291238; x=1788896038; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=vcp2HqC1PIYDI/BW2a9G/QFQNxe/OVU+goHiKCv6lBU=;
        b=e8tmIMTy5n+PXwVMx7iz4kfOQw2n+BygsGi4uOHFmRBdFvM/pd7Dv4JvokWvm0TEaU
         91XrITgRvEYJsphtS2X/A7FOV11hdrt2/wH8U1yC1jqA29HxxAqdtVVyEmlVy+IMxXFp
         eQBE1OG+mDwDlCzeRB118YfN2pucvx1GDvllby6Gl8IyeawIhOH7A4ctu+giL3KHqGuG
         gc1aVcLuz2Ft9vpnmzWaimbGOjI59/+op5MqMS9d5K+7Wk+IoM9UkbW9+LKEmg56vc70
         yI3WJpWv8/poiTF9hBfAJzdwln3hs8QYcN/e37Bpghg+/CL7Qj08Cacyzlbzc9Oh58pa
         CA6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788291238; x=1788896038;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=vcp2HqC1PIYDI/BW2a9G/QFQNxe/OVU+goHiKCv6lBU=;
        b=OEg9XAv4GdSDxn3JnRkuV9JjLakOUPYmXoWpEU1UZy+dgtcJrPKglWmoArkMHGJ2Vz
         sf+wGuqBvA0J5SWLJfDjsUtul0JiZ/pYduMMCtpSCBgQFn4a0YaNeflA+gTA1MSIC7Tw
         PRy5OmS6GniWcb1Q13y9nbBq9m81WoSeL8U4g3ACFMjXXNc1NA7F5OyMV1HxEAmVGPs0
         vwkpufkIt+kmDSH1Fy6fMWQC2O0173QzobhTHHOz4kyO03Msk1JtSIohieFKkMZ5QaOy
         ZyjmEL9xw7mH7wQW/EHUMMjEYQ/zATGalJgqkoWu7q/oEPCRoq1/Ejey4tw6mPmY+wM3
         7/ug==
X-Forwarded-Encrypted: i=1; AKwUvByr8leWlXVozXOg/gKuUJ/Ouw6cRaJ2oN2C1yME1wmTJnTZClvCEQ+p1809if60UGyHq5c=@vger.kernel.org
X-Gm-Message-State: AFuF++l5dxR+37OZgow17BuEwK3QjWDNXGeAILdDM217Q0od/B+q0MJW
	OIwrYVaDzZogt8sYun7yLi+V2kj6Apr2hSU/gy5N1TtO8UGp/rCT69Nn3CyuGnM8aWI6YcxNO7e
	sRAYVWQ==
X-Received: from pjff15.prod.google.com ([2002:a17:90b:562f:b0:38e:77e2:3e70])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:17cd:b0:398:ba9e:75ff
 with SMTP id 98e67ed59e1d1-398ba9e7753mr31253638a91.21.1788291237665; Tue, 01
 Sep 2026 12:33:57 -0700 (PDT)
Date: Tue, 1 Sep 2026 12:33:50 -0700
In-Reply-To: <7eedeed241687f3b5f5953bf6717afd2bf5a58d2.camel@infradead.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260826214952.129BB1F000E9@smtp.kernel.org> <7eedeed241687f3b5f5953bf6717afd2bf5a58d2.camel@infradead.org>
Message-ID: <apconttxYicjmZSd@google.com>
Subject: Re: [PATCH v10 21/21] KVM: x86: Use kernel timekeeping snapshot to
 get walltime+TSC
From: Sean Christopherson <seanjc@google.com>
To: David Woodhouse <dwmw2@infradead.org>
Cc: pbonzini@redhat.com, Thomas Gleixner <tglx@linutronix.de>, kvm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, paul@xen.org, dongli.zhang@oracle.com, 
	sashiko-reviews@lists.linux.dev
Content-Type: text/plain; charset="us-ascii"

On Fri, Aug 28, 2026, David Woodhouse wrote:
> On Wed, 2026-08-26 at 21:49 +0000, sashiko-bot@kernel.org wrote:
> > [Severity: High]
> > Does removing KVM's local TSC clamping expose guests to mismatched time pairs?
> > 
> > When establishing the guest's PV clock, KVM provides a master clock
> > snapshot pairing a host TSC with a system time. The previous read_tsc()
> > logic explicitly clamped the TSC to cycle_last to maintain mathematical
> > consistency.
> 
> I think this is basically the same class of issue I brought up in
> https://lore.kernel.org/all/87v7beb7s3.ffs@fw13/ and Thomas said the
> right thing is just to ignore it?
>
> If the discrepancy was more than a few cycles, we shouldn't be in
> masterclock mode anyway, should we?

Agreed.  If a host CPU really has a TSC that is observably behind others, KVM
will mark the TSC unstable when loading a vCPU on that pCPU.

		s64 tsc_delta = !vcpu->arch.last_host_tsc ? 0 :
				rdtsc() - vcpu->arch.last_host_tsc;
		if (tsc_delta < 0)
			mark_tsc_unstable("KVM discovered backwards TSC");

And as Thomas pointed out, the discrepancy will show up at some point.  E.g. even
if the kernel provided a perfect pair, RDTSC from the guest would read a too-low
value since KVM has historically required identical offsets to use masterclock,
i.e. the guest would still be able to observe time going backwards if a vCPU did
__pvclock_clocksource_read() with a TSC that is behind the masterclock reference.
