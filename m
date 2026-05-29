Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com [209.85.215.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E0C13FBB5E
	for <kvm@vger.kernel.org>; Fri, 29 May 2026 16:03:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780070617; cv=none; b=UcwecMwKcjT+DuTCWMTWKzWBRZ9p99LqYYA69s8ULoNH2DKYuu4MR0GGbHRppF1fHMfyBy8vt812e8PCZ0EDJaa11q3dMkkHF85nO8TnUDNPBSi4fFJdiK0YQzP/oksyLhgDFOmQKfOadDrGGD7tJz7R5sPJTsFI3H8yAzGLW+8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780070617; c=relaxed/simple;
	bh=6d5LulykDyLGlqdQh2sTZHxzedzP0VBXOfM+PvIRTCk=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=APYJp/BS90CLcAEZiS6U3JO0GbmiTpb97/FoHrY7TNGJ9/Wo9y2M8S6gRhBWLuDptHyethSg3yoOPoIY6pxDkRxBRUMlkhK+A7gLe5IwJLT3t/wcmceEr3O/gbWCqH5oz9ACqH358vnA376zMcFfXZCV+H+JDrmqs5gObywXImM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=TUZJo0mY; arc=none smtp.client-ip=209.85.215.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="TUZJo0mY"
Received: by mail-pg1-f201.google.com with SMTP id 41be03b00d2f7-c828acf7c1dso18818773a12.3
        for <kvm@vger.kernel.org>; Fri, 29 May 2026 09:03:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780070613; x=1780675413; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=SRgj+NiWNA8j47mtoKyieH4MDPslA/seIovbV5Jv8Jg=;
        b=TUZJo0mYHE45lm1bmc1+Y7sLJcvqiF3lCh1gAkQrt3LQvRr3LYa6MCro3SRj+ljrBk
         pvq0+aSXMwIhpiuhqZOH89RICfBXZ/F/by7qQybvn8iF2PXvA1iySYsK6kf4sSUs3Td3
         qV+VHb07lOqQyF26gqkcH8ZnWazatY0K5chAfmEWMJ2LzRuDZEPwQ2Hz1ev6MGaeqUyz
         RE+vXAKuG2RcZI8UrHs7iSVpEX5xh11oKbgoBhuEjavaF8+lRVR/9NuNudQrJLMMLHiQ
         31T6Q7fyW30KL+5Un75lWXGgSBWq56Akj+BWcoySIIiQWfLhEfd6j0mDu4JaJs/0jRMs
         F3mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780070613; x=1780675413;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SRgj+NiWNA8j47mtoKyieH4MDPslA/seIovbV5Jv8Jg=;
        b=izQXj4lT2m1/Dc/4NVfWCoBCyrdlKhZnpacUYNoTIk3yErU415pxVD1KAd0339Kcz+
         Vyk//lOfZBQ1v8UhKiaFgmE325Q9BYXS1MlaoHtE421/Q71NE+ac1VW0aCyptEMzfD9X
         QPKR1WLkqLNn654wFXMy+1/RkH10ktzwyGg1ZPK/e1weR/06B8qP2EH32vMBZvbJVO36
         zSMXS+bVVP1/yP6X2Q26QExdWvpGNso8VHVFr5oV73ohXNqIjYfMYG8Ic2HaEnvQO0TT
         Qc9tkseBM2OuPHacC1/6s8OjlKguaM0hl2gCOxR+B7iUXEToH6XzuCjxA4xq/Fx5bUXe
         O81A==
X-Forwarded-Encrypted: i=1; AFNElJ9MvWJ1aKVgGYdcWKRQ5+O7vknCFISwSpJD0dWeZYOXHf74yBs+lkS1CLYL6hX7ZFf9YD4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzdHw/DkfEo2+LyCEFwy5Ka/PoOQq96p1XITIicaqeXk8Hzkz4d
	OoKfdTVAhfo5NnJKYpQLwe8rPtyucI1IhlQJrR0ezAqOz8box+Rxff07Pb5HR7T/tCKR7/C7tvd
	P5OCtXw==
X-Received: from pghl22.prod.google.com ([2002:a63:f316:0:b0:c82:7df9:8c1d])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a20:c793:b0:39c:126c:93b4
 with SMTP id adf61e73a8af0-3b411c68bf8mr4412239637.9.1780070613299; Fri, 29
 May 2026 09:03:33 -0700 (PDT)
Date: Fri, 29 May 2026 09:03:32 -0700
In-Reply-To: <7987e722-4ee3-4d6c-a4b7-369cfd272dac@intel.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260528071712.1407929-1-xiaoyao.li@intel.com>
 <ahg8i_Zv9TRk-UzE@google.com> <7987e722-4ee3-4d6c-a4b7-369cfd272dac@intel.com>
Message-ID: <ahm41KHG7IdPjnGj@google.com>
Subject: Re: [kvm-unit-tests PATCH] x86/run: Use separate "-accel" option to
 configure the accelerator
From: Sean Christopherson <seanjc@google.com>
To: Xiaoyao Li <xiaoyao.li@intel.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"

On Fri, May 29, 2026, Xiaoyao Li wrote:
> On 5/28/2026 9:00 PM, Sean Christopherson wrote:
> > On Thu, May 28, 2026, Xiaoyao Li wrote:
> > > When configuring accelerator via machine's "accel" property, it cannot
> > > pass additional ACCEL_PROPS. For example, it hits following error when
> > > configuring KVM with "notify-vmexit":
> > > 
> > >    # ACCEL="kvm,notify-vmexit=internal-error" ./x86-run x86/apic.c
> > >    #   qemu-system-x86_64: Property 'pc-i440fx-11.1-machine.notify-vmexit' not found
> > > 
> > > Switch to use separate "-accel" option to configure the accelerator.
> > > 
> > > Signed-off-by: Xiaoyao Li <xiaoyao.li@intel.com>
> > > ---
> > >   x86/run | 2 +-
> > >   1 file changed, 1 insertion(+), 1 deletion(-)
> > > 
> > > diff --git a/x86/run b/x86/run
> > > index dd38f14c871f..a68d469dd1b8 100755
> > > --- a/x86/run
> > > +++ b/x86/run
> > > @@ -43,7 +43,7 @@ fi
> > >   pit="-global kvm-pit.lost_tick_policy=discard"
> > >   command="${qemu} --no-reboot -nodefaults $pit $pc_testdev -display none -serial stdio $pci_testdev"
> > > -command+=" -machine accel=$ACCEL$ACCEL_PROPS"
> > > +command+=" -accel $ACCEL$ACCEL_PROPS"
> > 
> > This breaks my setup for specifying kernel_irqchip=split.
> > 
> >    qemu: -accel kvm,kernel_irqchip=split: Property 'kvm-accel.kernel_irqchip' not found
> 
> If you switch "kernel_irqchip" to "kernel-irqchip", it should work again.

Oh, nice.  Yep, that works for me.
