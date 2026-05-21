Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BBB22D8376
	for <kvm@vger.kernel.org>; Thu, 21 May 2026 21:01:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779397299; cv=none; b=O6eI+BskG0dCWEQqqFSuYYnK1Pb6PwaVR+J7kKhYk3l6w3fpc+wlwcWOJrHG7QiZTFYUYoKMeuGvcKDHV8ev3RJU8haAmPaec2ot+1euA6dclCibJDHW43hxQeINHo5tzesrhhRhdaZ4Qc3QRqUxZ7wnT7CN8pkS1K5XKanv0dg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779397299; c=relaxed/simple;
	bh=UTNkbHY7Wjr/dyzbQ6GvUNv1NaEz32luLYEXfy53m6g=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=lCtrfSV2MfEI5inZbwmpDRcqlSQtBSKDUDAXyo5jijwgsf9qPJqsXQdj2tR2W/TEn7CGD3giWDQTzJaB2rjSL//7LBA1m9j3GBKXHSzONybU6fPahPCBOlxfjOF+Z866mUtDzgXEsP+JCf+hKClLzTxC98LxBbP/C+ehBrgmx00=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=wfVAlRkM; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="wfVAlRkM"
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-2b4530a90fdso116845595ad.1
        for <kvm@vger.kernel.org>; Thu, 21 May 2026 14:01:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1779397297; x=1780002097; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=iN4mR6FXbVUwqAWLl+PlqYFyvLBNkg9d4d7Akdf1bJQ=;
        b=wfVAlRkMMi++w6FbMd9oQljMwwaCBGt5owpEcCpEAV12tm/S4r2s2ncFxE458a//lw
         DRQNaNbiUAQNoPxk4gjcsj016JT+E+YH+PSye3fkZiwXwnrPoThhO9qym2JJ/C/5i46q
         xWWgSB1APUG6v0nZC/n09TLf87WbTDNxdPw+icitr6KyD1NXRTaNVdeE3BjTBl4vMmDo
         OW+khRn9a6iSxok1m6hbqBiU1WcDxtv73H1ma4qMpcYJ5OQSajIbGIGXWTbYjs3EXl8E
         Ql3SIKQTnTe4mZS7aemLCXkUK6klGNz8bn0f2vq+FpMmuwC5Ly2n4ipfAc8KCaIr5E2G
         to4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779397297; x=1780002097;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=iN4mR6FXbVUwqAWLl+PlqYFyvLBNkg9d4d7Akdf1bJQ=;
        b=TaE6xKfMks66sA7r7keGCaVCUt4TgbStGQ0KU9dLoMj0UvIy/snH78xs944a1Ki7j+
         ao1bO5QP8FFlg0BPROutRSjO1+szQmJSYRwALaw/cbzOlx2zyOsmeMdxDTJU4Ms+iv5f
         48FdL0g58LkeaqNroc8NiymacvmDAEbwVY5868ZqU7YuW1G/LUL1pL+WcTAVl6Y6zXSO
         puHk4sHtz0sZGL4iNgOxiwpeJlSBOGb04FnrKO/TRNJMw+HA1lhiwPUs8ziOJ4H2hTwy
         VDdsEdMUNoAdQdqKt+YaRP1gaFq07Bqi9R5+mwnL3tLSsYBOYrQCyxAvpd0d6+KY0xtg
         mplA==
X-Gm-Message-State: AOJu0Yxau4flSUMjPnKSx5S+YjWIAc9gREFc+uoP0kLlX5Pa7qvNHWQT
	p0UwQTkEc3rpGe8SVlC+UD11pM9xt29Ej4x5MBJpYnPAMt2IkdJtEhffkRWGKfArBdte1OiSWHQ
	5PmDsTQ==
X-Received: from plge10.prod.google.com ([2002:a17:902:cf4a:b0:2bd:40d4:e407])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:e84c:b0:2ba:4ad9:70f6
 with SMTP id d9443c01a7336-2beb06aa272mr6036375ad.31.1779397296608; Thu, 21
 May 2026 14:01:36 -0700 (PDT)
Date: Thu, 21 May 2026 14:01:35 -0700
In-Reply-To: <c54fd01b-fe22-4c9c-8d5f-5b317de07a40@oracle.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260515191942.1892718-1-seanjc@google.com> <20260515191942.1892718-38-seanjc@google.com>
 <c54fd01b-fe22-4c9c-8d5f-5b317de07a40@oracle.com>
Message-ID: <ag9yryEe0A7_AZCT@google.com>
Subject: Re: [PATCH v3 37/41] x86/kvmclock: Use TSC for sched_clock if it's
 constant and non-stop
From: Sean Christopherson <seanjc@google.com>
To: Dongli Zhang <dongli.zhang@oracle.com>
Cc: kvm@vger.kernel.org, Rick Edgecombe <rick.p.edgecombe@intel.com>, 
	Vitaly Kuznetsov <vkuznets@redhat.com>, 
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, 
	Boris Ostrovsky <boris.ostrovsky@oracle.com>, Stephen Boyd <sboyd@kernel.org>, x86@kernel.org, 
	linux-coco@lists.linux.dev, linux-hyperv@vger.kernel.org, 
	virtualization@lists.linux.dev, linux-kernel@vger.kernel.org, 
	xen-devel@lists.xenproject.org, Kiryl Shutsemau <kas@kernel.org>, 
	Paolo Bonzini <pbonzini@redhat.com>, "K. Y. Srinivasan" <kys@microsoft.com>, 
	Haiyang Zhang <haiyangz@microsoft.com>, Wei Liu <wei.liu@kernel.org>, 
	Dexuan Cui <decui@microsoft.com>, Long Li <longli@microsoft.com>, 
	Ajay Kaher <ajay.kaher@broadcom.com>, Alexey Makhalov <alexey.makhalov@broadcom.com>, 
	Jan Kiszka <jan.kiszka@siemens.com>, Dave Hansen <dave.hansen@linux.intel.com>, 
	Andy Lutomirski <luto@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Juergen Gross <jgross@suse.com>, 
	Daniel Lezcano <daniel.lezcano@kernel.org>, Thomas Gleixner <tglx@kernel.org>, 
	John Stultz <jstultz@google.com>, Michael Kelley <mhklinux@outlook.com>, 
	Tom Lendacky <thomas.lendacky@amd.com>, Nikunj A Dadhania <nikunj@amd.com>, 
	Thomas Gleixner <tglx@linutronix.de>, David Woodhouse <dwmw@amazon.co.uk>
Content-Type: text/plain; charset="us-ascii"

On Thu, May 21, 2026, Dongli Zhang wrote:
> On 2026-05-15 12:19 PM, Sean Christopherson wrote:
> > Prefer the TSC over kvmclock for sched_clock if the TSC is constant,
> > nonstop, and not marked unstable via command line.  I.e. use the same
> > criteria as tweaking the clocksource rating so that TSC is preferred over
> > kvmclock.  Per the below comment from native_sched_clock(), sched_clock
> > is more tolerant of slop than clocksource; using TSC for clocksource but
> > not sched_clock makes little to no sense, especially now that KVM CoCo
> > guests with a trusted TSC use TSC, not kvmclock.
> > 
> >         /*
> >          * Fall back to jiffies if there's no TSC available:
> >          * ( But note that we still use it if the TSC is marked
> >          *   unstable. We do this because unlike Time Of Day,
> >          *   the scheduler clock tolerates small errors and it's
> >          *   very important for it to be as fast as the platform
> >          *   can achieve it. )
> >          */
> > 
> > The only advantage of using kvmclock is that doing so allows for early
> > and common detection of PVCLOCK_GUEST_STOPPED, but that code has been
> > broken for over two years with nary a complaint, i.e. it can't be
> > _that_ valuable.  And as above, certain types of KVM guests are losing
> > the functionality regardless, i.e. acknowledging PVCLOCK_GUEST_STOPPED
> > needs to be decoupled from sched_clock() no matter what.
> 
> Has it been broken for two years because of pvclock_clocksource_read_nowd()?

Yep.  Because pvclock_clocksource_read_nowd() ignores PVCLOCK_GUEST_STOPPED, the
flag only ever gets recognized when the kernel reads WALL_CLOCK, which AFAICT
only happens at initial boot, and during suspend and resume.
