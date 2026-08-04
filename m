Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com [209.85.215.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 621F537269A
	for <kvm@vger.kernel.org>; Tue,  4 Aug 2026 00:53:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785804829; cv=none; b=dCx2Q1OrbTsGMYo+3rcBT/17kEae/Xk9zmttYQgqXWJRy0NmljKxQVin7rDcZXiIOZTYpubkAn5fOdBYQK7w5FcdnAwdDhttIWmBBgROixoPHCMhAlMcxF5lgrlSUYJQarBgOMfR0IZgWQIm0f5HVSvb/NjezBioyEN0v8Iyz6A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785804829; c=relaxed/simple;
	bh=8J9B23WsicaadDjqSUzKsTyHJmyroFDR6rynfnEEbhk=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=RAKHJRmXQkkKR5Sn6zn60HU6GiRpwUC2yAIgJDK5X7SYkpfSYJ3R3NgehVvLqETk0WBXwrkmVBZdPSUt6JDph38X02y1wsAf4CBMAJqqV5gR8itCyeG86EM0MPMX/xeODGnTxIvNfW6AsW4ZQiKYLuo7SwztBNSSDByctU6qQgY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=EZjzp4DA; arc=none smtp.client-ip=209.85.215.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="EZjzp4DA"
Received: by mail-pg1-f197.google.com with SMTP id 41be03b00d2f7-cb835525b13so4991542a12.1
        for <kvm@vger.kernel.org>; Mon, 03 Aug 2026 17:53:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1785804828; x=1786409628; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=KFqZcLCrY5f3+v3uGjD/c1GxsX1WczytwYYei8eRc4I=;
        b=EZjzp4DAIhEio1y+iLW00DfS70zI/4N3d9rMd0pGjhkVnL7LA9MLwIruY1MIadknjD
         8NlEIYeSg7WmKMS9+4my8QUuaIXgfalnxczGo/vD/UjChRkezbzkvH8T/WQyVsna8laS
         R9V3XVROgm94vwhUlPRdiiRrudXAiJll0E8oW94/nSIc1TnTUOmhNUmZK+vYFvFf3Cvq
         FzPF7ECnE28eawIjqz9hmm6l3IA6PDA2cdjsdFRBHpCqwVJq1LtR2wmeoLFleLoCx9cy
         S5xGuD76Hb6O3yblV81H11NfCn+FDvnncnll+jOr0p6mCMwZc42rkx9pvMYv/CRFcQj2
         YXqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785804828; x=1786409628;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=KFqZcLCrY5f3+v3uGjD/c1GxsX1WczytwYYei8eRc4I=;
        b=Y1Hw/8kX4Yr1AAZ/moJJuYi3aunilKbB07N5R5kYENzSXzYpmX8I7/+oZo9O3MKO0W
         8DsksNiUuvBWVMdLRfVmEyKOmd8dQ6prnARDLplMHekDTaAjgQiWtItp4Wq23GGbH+Id
         vXIaeOqTmEIN+IWcwa5zNJEQxkOZ+G4XaYFFcx9vQJKiwBoNFL7NMsazuNuReWVOd9LI
         dZsiK1oYDeGIaAzXNHwxyTt1CiatxVL2zJxuZ8gwgVubXeMnmOwwcfe4HhNMaS6HQLAK
         sWy15o22duafz76ohv4dSh2zqhzw1lu6fSt8YS1FmEHCzE2o9Ra4fLSgcEYJvnMxcbmP
         Y1aw==
X-Forwarded-Encrypted: i=1; AHgh+RqiPIr9gnwyb2Kv22BGc2FHxypqrvpIaOD84R9WG2BRRruTc42vUhofzpDzrn8wBRfEqYA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz4SyICREFeHzlPdstCPnCFW7+6uPYNYAqUuLwU1LlPb9WfDr3F
	ZFIR7bwOuOLddUGq2yCOf0sH5WDkMYQkfu5WXU0lbtBN2FyQwuLTbQbUGv7ZrUXW0JZph2laT/R
	WGmUjUQ==
X-Received: from pgke23.prod.google.com ([2002:a63:f557:0:b0:c85:98b1:c613])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a21:3397:b0:3c3:a140:9392
 with SMTP id adf61e73a8af0-3c92a28f176mr12976405637.0.1785804827335; Mon, 03
 Aug 2026 17:53:47 -0700 (PDT)
Date: Mon, 3 Aug 2026 17:53:46 -0700
In-Reply-To: <8b90851f38ef5b10cdcdc70e7543bd6b0b5e2773.camel@infradead.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <178552799129.2700794.10181439022561913222.b4-ty@google.com> <8b90851f38ef5b10cdcdc70e7543bd6b0b5e2773.camel@infradead.org>
Message-ID: <anE4GtMa33nz7qdK@google.com>
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

On Sat, Aug 01, 2026, David Woodhouse wrote:
> On Fri, 2026-07-31 at 13:09 -0700, Sean Christopherson wrote:
> > Applied patch 1 to kvm-x86 clocks.
> >
> > [01/36] KVM: x86/xen: Do not corrupt KVM clock in kvm_xen_shared_info_init()
> >         https://github.com/kvm-x86/linux/commit/3d4b20b5a7df
> 
> Thanks. Could the clocks branch be based on something that includes the
> timekeeping work from the timers-ptp-2026-06-13 merge (in v7.2-rc1)?

Yeah, I can rebase onto a 7.2-rcN.  Y'all are likely the only people that care
about the above commit, so a late rebase isn't a big deal.

There's basically zero chance I'll get the entire series applied for 7.3, but
"Use ktime_get_snapshot_id() for master clock" is at least in striking distance,
so there's no reason not to allow for the possibility.

> The later parts of the series depend on ktime_get_snapshot_id() and the
> reworked struct system_time_snapshot from there. Your kvm-x86/next
> branch does have it; I'll keep my WIP kvmclock8 branch based on that
> for now as I address the other comments.
> 
> 
> *   2d6d57f889f3 Merge tag 'timers-ptp-2026-06-13' of tip
> |\
> | * bc484a509673 ptp: vmclock: Use hw_cycles from snapshot for precise TSC pairing
> | ...
> | * ca1ec8bfac8c timekeeping: Add clocksource read_snapshot() method and hw_cycles to snapshot
> | ...
> | * ef22786707e3 timekeeping: Use system_time_snapshot::systime/monoraw instead of ::real/raw
> | * eba302268a01 timekeeping: Provide ktime_get_snapshot_id()


