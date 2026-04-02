Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9F7429B78F
	for <kvm@vger.kernel.org>; Thu,  2 Apr 2026 22:23:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775168597; cv=none; b=BPlhG0f+wz6+t7pyS3w53w2dvlIefXfSTiix50PgIXCX97T0d1hSdI5sUNqttDJkPOzViSdXm+QqPkuVAoWQzCtB6RuG63PLxSocpNsbRNhywqs9cAJMuMsHbatlH8qVOqpDWhUYNikXOky1SbUI++PCwfQM6hNVCoeKjRP8oJI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775168597; c=relaxed/simple;
	bh=NTwFdoG2LXLVbEjzrgUHpb7V/55TIG6J1/dw1GMmvCw=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=EVSb2N2Lo9FRsk5E2akd0L2RXrcAbaIFpXyTif9MTKYaYYMWP9dNKB2KIcKvjcOsW+jkFEeCbcZWg3zMI3xl9zchgVnujmv9vHTG50dH22yBQjqMDbEM77uNzYdSPoceVG9kAWh7V5NKt7b0Saqr+i8UFn5zM6e+ryTDIESBAxY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=j9KXa3vl; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="j9KXa3vl"
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-82c83bd48afso834869b3a.3
        for <kvm@vger.kernel.org>; Thu, 02 Apr 2026 15:23:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1775168595; x=1775773395; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=c1tFd2YWULWQ0nKOAfJH4m9pKG3Qe9WX5xKtp0LwQ5Y=;
        b=j9KXa3vlFNh1FW3zUta7jrZHzxjwnh0raCBO/o+poG+JksK4QYjuCMNs9zISxBHC8w
         O21RLt6gRt66EFBz0pavn66jduaoaJVxzuohxBTw2F+zJOKARINxzRfpk/qEvDQBzx+9
         9Rqrz/iIs6uSwveiFkgenEmpHf0u9QW+ft7WMwjgd4G7qGP66A5zijzmpLZrJCNBc+pM
         KQigmhIMwwgzqIX0DrsvxNjMBo5nAz2wv1KVkUR6JayeszdUangTVF+Hx37XXCUBk7pH
         8ppKbziA+C5M0Tnqrrb+/UyDMB6EvnsZcJ5nwy44+qmPRicewSlY0gUu8gMoZZ+9R/T3
         EDHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775168595; x=1775773395;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=c1tFd2YWULWQ0nKOAfJH4m9pKG3Qe9WX5xKtp0LwQ5Y=;
        b=IkasQnwfE6x+I3l4dwvMKwAByB6Mz3phM/m6mjpgTQnzsTzFByLOFl9AkS/VRm0YP1
         RYVHglFBKDkwUTaNfDs/pve/69iGaWEyBE00TGH2FqILkcU+V6GXg/CknkYp20K4OgkH
         /BQpSVAm0f+eqSpOND9G4+0rrXr50dk0FuM29XBXesJdvjq2fLXJAv/ZipkeXIC/XTV7
         Y5YhKhetM5VxPi/GzvjUH0ayr7lIbuG1H+Mx72zKXMEfb3HoUusBRJZf95iRBENEOYpK
         lxir9mh9cuFNqa8PN2loVoYMzVxvfqya9VQ1CfrPO0x/Vwn8fxEdSVt5floYyEHbVQb2
         Da7A==
X-Forwarded-Encrypted: i=1; AJvYcCVTStmPVIXKSKwcHgnBmJNZTwio65ctnAvBM67MlgfcD+0Rp8RSO9rNPbNWnfuuT06Qu8E=@vger.kernel.org
X-Gm-Message-State: AOJu0YwT0PiDKWOHxriqnrs2gIfreWXhsC7VG3c96np3wwn5dvhh03FI
	Bl8d9nwA05alntPgtAPdHwwtmHJ3dMZ/n5YFSCLogm4BdDm2/bWwHxuaJ0BDmNC/re6/DddiL4z
	ORl2LPw==
X-Received: from pfbea27.prod.google.com ([2002:a05:6a00:4c1b:b0:82c:ec3c:f2d0])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:f88:b0:829:803e:6798
 with SMTP id d2e1a72fcca58-82d0dbea543mr625141b3a.56.1775168595062; Thu, 02
 Apr 2026 15:23:15 -0700 (PDT)
Date: Thu, 2 Apr 2026 15:23:13 -0700
In-Reply-To: <20260402064209.8ba7wrBI@linutronix.de>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260329131543.91733-1-shaikhkamal2012@gmail.com>
 <20260330101814.7fa1e31e@gandalf.local.home> <bb7b66ad99097c5326196b61d644cff255e30394.camel@amazon.co.uk>
 <ac08V4TaM2yh9SY1@google.com> <20260402064209.8ba7wrBI@linutronix.de>
Message-ID: <ac7sUQZ0AQIMFDnL@google.com>
Subject: Re: [PATCH] KVM: x86/xen: Fix sleeping lock in hard IRQ context on PREEMPT_RT
From: Sean Christopherson <seanjc@google.com>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: David Woodhouse <dwmw@amazon.co.uk>, "rostedt@goodmis.org" <rostedt@goodmis.org>, 
	"shaikhkamal2012@gmail.com" <shaikhkamal2012@gmail.com>, 
	"syzbot+919877893c9d28162dc2@syzkaller.appspotmail.com" <syzbot+919877893c9d28162dc2@syzkaller.appspotmail.com>, 
	"me@brighamcampbell.com" <me@brighamcampbell.com>, 
	"linux-rt-devel@lists.linux.dev" <linux-rt-devel@lists.linux.dev>, "hpa@zytor.com" <hpa@zytor.com>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "paul@xen.org" <paul@xen.org>, 
	"kvm@vger.kernel.org" <kvm@vger.kernel.org>, 
	"skhan@linuxfoundation.org" <skhan@linuxfoundation.org>
Content-Type: text/plain; charset="us-ascii"

On Thu, Apr 02, 2026, Sebastian Andrzej Siewior wrote:
> On 2026-04-01 08:40:07 [-0700], Sean Christopherson wrote:
> > Re-reading through the thread where you proposed using trylock, and through
> > commit bbe17c625d68 ("KVM: x86/xen: Fix potential deadlock in kvm_xen_update_runstate_guest()"),
> > I think I agree with using trylock for "fast" paths.
> 
> Has bbe17c625d68 been applied for PREEMPT_RT reasons?

Ya, I think it was to suppress a PREEMPT_RT-only splat:

https://lore.kernel.org/all/20240227115648.3104-8-dwmw2@infradead.org
