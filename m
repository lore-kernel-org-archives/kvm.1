Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC0382BB17
	for <kvm@vger.kernel.org>; Tue, 21 Apr 2026 23:37:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=170.10.133.124
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776814665; cv=pass; b=CnOU8sxV6x3fKekanOmOsnG5aG/gEz3FWFJU38oyrSW28ASQbZYQ8utsAF09gLGn2na8PaqV2OXZuRoJr3HwfKisd489+4wS5CivwgJFzLeMntwYMXVCQPWtgLmegzuHEY4RmGeelvP0TKHOFVkQ271uKyjJ0PhwvwiRRljkHLo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776814665; c=relaxed/simple;
	bh=QqL4L8CqBzFbWrISm/25U93SIZWfMOzQQTFcE9fwmq4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dm4Ffpsdw5+3Al9f37r29DPyJM/7L3XkrZuR2VeKAP9nfP1eRfZj8uijzihDwOAYZS9ZqzaWR92xAz+O2pp2goGzY/yHhWktI40anUdoBEtLJgJNg0vjFcwzWrxNHnE/gifRTNrFh8wvWTmC5uwhB8Ds1anMhQg1SghF5oMCW/8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=GYcldAtl; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=b1ae+XYI; arc=pass smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GYcldAtl";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="b1ae+XYI"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1776814663;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=QqL4L8CqBzFbWrISm/25U93SIZWfMOzQQTFcE9fwmq4=;
	b=GYcldAtluQa98SxQvarkt0QtBG335PfNzGaMt+yqgaT4dJQXHYduUfz0lf4NAl88yGYWZ9
	ewCl3pEczeTvNkjNzPI9Gw5aDXVonuOjdtb2qW9FHfh0LCkiJUXvts8exc3F7wZDMRHIbH
	lGGAs0U9YmvzHN7OnH874IApAmfahdg=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-12-uT1qr9J8NhSzQk0Aighrgg-1; Tue, 21 Apr 2026 19:37:41 -0400
X-MC-Unique: uT1qr9J8NhSzQk0Aighrgg-1
X-Mimecast-MFC-AGG-ID: uT1qr9J8NhSzQk0Aighrgg_1776814661
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-440d12a472eso2332849f8f.3
        for <kvm@vger.kernel.org>; Tue, 21 Apr 2026 16:37:41 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776814659; cv=none;
        d=google.com; s=arc-20240605;
        b=bIoTsu4sPqSjC6xCDbL51RhKIYKdfyFliPtRfBBYoRVn08Q/6MQiHMafWqlxZQeqeh
         15HXvFVheAWrTwNX9HCelV7FEzGYkmXIFVNNn2FL8yDHd1DN29ViOmf6aZ70kwDanQPf
         scFBjKWe/cRAshyzU03yTQfTQf+kj2Hu0171v4pg1CCJSkEf+1OlEHB29GdcSJoztpMI
         qH0E6Ow7l4cSeEvyxvG/TTEyGGj2A8OQEcNomzW1BRUsUaOCb4Lq/a224ttPGmUYrtpJ
         pmUauRzIakmpJj5msO6wtSkZx2KmLgQ2hkZdHFKdUFCiGQBoj/V4Brw9vXYbTO2zSZH9
         YfnQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=QqL4L8CqBzFbWrISm/25U93SIZWfMOzQQTFcE9fwmq4=;
        fh=AVJvamDDfBoEykVm8mCjaUtB5S6OYxbawuwFnRadgqk=;
        b=eQELqXouccyTfYTGq14u5QH7cFBKDovAQj/IWA8+6Ny/rDVQA74TXLhKgVWgpTpJVO
         H6v9XJDdpdfthse+sohtB5BoudVY63eGNpcr2Ha+H++8FLodMrCKhc2kPuUhWff7kJ0R
         IHo7+y7aXJubGbwWz0BF+6rh211LG7tiIcIV4KRvvCpZkbzWaDc5J8BJ2zvc68lQUFsn
         yJXewAmTdGY0SJeO8XXDheFM7qU/qqNDzB64S6YFMqkEZ29lI8Zj3UudQYuDeZjN0krJ
         dbJSOvQPHDnTO/uWP/2MImjE8vye7u7Fc3rs+TgiHDDF9UPHzvKjlw1WzsnTBIz9JRn+
         nimg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1776814659; x=1777419459; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QqL4L8CqBzFbWrISm/25U93SIZWfMOzQQTFcE9fwmq4=;
        b=b1ae+XYISXkS6xMVKXDJkRJnj/1tn6KJFTbaovgzIM/baDaRFBKDLx4UgBFVkWgvtt
         HHiwpGBJj2ZTigCMhURzX0F5S7Lw3N+ZxXJh2ZHI8VdkaQIM/Jc3Xx66ZDHLCiTsL7QY
         DSekxg9Ug/0307Boanz9ZHvpsbETAAanDkuOIaVyV/fs8S73JNTKWfBz0eLG1/dnn2Sy
         XzSQZfb7GP1v568ruvgx9Jop0Ax+XFCXNJW1qUeIIBnsN0NJDWBh5QuuVZ2V2A7qSDeE
         6Wmvay8iwXlVDzdydNyPyXPz6H1ioGniZN7M+LeuMOlGTQJY0X3iTVWh2yJHjDxipRcj
         rI6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776814659; x=1777419459;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=QqL4L8CqBzFbWrISm/25U93SIZWfMOzQQTFcE9fwmq4=;
        b=NczwrQhb35D8hWQyGVJREW7/8ykGGbsY55SlFJm/tLwChJgGmJIF/NKfUcJ/6ZVGbd
         npfdw3+9u4mLXd6e1HrQEosgnfUP95wZo9dQrbg82ndhWW4jmESfiPblSjW0dLqiOoEY
         4a7FZW9tbpA3mCJOWPNgTe6fYGaTVNfu6zLbaE6IcUX7RDnRn5Ak+4TxbKtk720ORn7Y
         J0AiMEkoG983G9MySb3Rij72kc7CB2UVhgIXg3Z/H/zXQDheQr0WnIY1CwR74oRcLH9R
         jbbLhhIer3G0c7hFMzk50yi2nJCH1UiD1lu2nh0Oyds1PxoXD+4u0rnjFSp3Kew7VT2+
         zQTw==
X-Forwarded-Encrypted: i=1; AFNElJ9sSb4hAU80Fj8DYNugDH0f1E/7FxART3EyUE3IwouHPfu7yitfWzBtBBWyfi4N4cYA1qw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwYw3l+Vn+th7wKahJby+IMkIy/+yeE4kAEvTh4LIJHqhpFHRAP
	hfmT0BsNQuLOxRYXlok7jFW+vYBI8WewWHssAtZ+T1aixRiK52/q5WvPcUT3DcaxcOorInfStRB
	j6nxStLCiu3AyVslMscVQzYZh98L4+bDzJu8RUJJjjO/2Q00iGGSjuzC/YbDkaZDeZbegtMAOhc
	zPGmiDE2B8Ing7+6HmfQHt3249Hpw8NCFNam+8O2w=
X-Gm-Gg: AeBDievPg8qvzqFkqjqhbCSQOAMzo+rivl19lUHWuiIxM3E5jhhbUQynUxGLUuLvDAM
	45rG72xnCosKek6CcV6xn9qn5ZTK0J0lNQ0WgqGf3+F18m6MAeqLMRhQBtrZMeSP34c8icC2MO2
	b4hS8uWKSkjVrx7f0Nx+dYHk/NhJc39tfM61Lttkbb9mBWZuBuVpnjuEu22FOlnyEtwmY/UJWyP
	h8nAt3i9ZYiSmPLkUjckc9rLPDN8Xy4fYpCW+Dgk4DfmryqB2IHTeQie85eZrOiSzcaC44TQFEK
	5GAaNSyl34nE1nQD
X-Received: by 2002:a5d:5f82:0:b0:43d:7d6f:f540 with SMTP id ffacd0b85a97d-43fe3e237d3mr32229073f8f.45.1776814659430;
        Tue, 21 Apr 2026 16:37:39 -0700 (PDT)
X-Received: by 2002:a5d:5f82:0:b0:43d:7d6f:f540 with SMTP id
 ffacd0b85a97d-43fe3e237d3mr32229051f8f.45.1776814659009; Tue, 21 Apr 2026
 16:37:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <87mryxekxy.ffs@tglx> <770ae152-c3fd-4068-8462-23064de02238@linux.intel.com>
 <87eck8daot.ffs@tglx> <20260421111858.GH3126523@noisy.programming.kicks-ass.net>
 <20260421113212.GI3126523@noisy.programming.kicks-ass.net>
 <20260421113407.GE3102924@noisy.programming.kicks-ass.net>
 <20260421114940.GJ3126523@noisy.programming.kicks-ass.net>
 <87cxzsb5n0.ffs@tglx> <CALMp9eTeqE4u6ioepVeowRkcNs63DYZTg8og8em12u4FsVWNfw@mail.gmail.com>
 <878qagb20x.ffs@tglx> <aefIJR_FcEeP-fcS@google.com> <CABgObfaNaDYCo_rkkwAnFzKYYe9G9wnz1+yiv0H73CbtE8AXpw@mail.gmail.com>
 <87tst49bgt.ffs@tglx> <CABgObfb7Yy5Q3E2Boy_H4a0F3GodDOr1Z_Sw0BzdfvOmagcRnA@mail.gmail.com>
 <CALMp9eRyqC4bEqVL22x-F77fBbsBLv4HgTOyGfBOz_a=qk+Gog@mail.gmail.com>
In-Reply-To: <CALMp9eRyqC4bEqVL22x-F77fBbsBLv4HgTOyGfBOz_a=qk+Gog@mail.gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Wed, 22 Apr 2026 00:37:27 +0100
X-Gm-Features: AQROBzBXrc6_i2pprSAki5vLl-q8ZeihihyOEJ9WG0CQNo4Fgypmh4d0Wss6HR0
Message-ID: <CABgObfY+eXEtPoYSKRcKfvPpAcgT6Fiha-9g=XRCGAGAvs2CzQ@mail.gmail.com>
Subject: Re: CPU Lockups in KVM with deferred hrtimer rearming
To: Jim Mattson <jmattson@google.com>
Cc: Thomas Gleixner <tglx@kernel.org>, Sean Christopherson <seanjc@google.com>, 
	Peter Zijlstra <peterz@infradead.org>, Binbin Wu <binbin.wu@linux.intel.com>, 
	Vishal L Verma <vishal.l.verma@intel.com>, kvm <kvm@vger.kernel.org>, 
	Rick P Edgecombe <rick.p.edgecombe@intel.com>, Binbin Wu <binbin.wu@intel.com>, 
	"the arch/x86 maintainers" <x86@kernel.org>, Paolo Bonzini <bonzini@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 22, 2026 at 12:34=E2=80=AFAM Jim Mattson <jmattson@google.com> =
wrote:
>
> On Tue, Apr 21, 2026 at 4:16=E2=80=AFPM Paolo Bonzini <pbonzini@redhat.co=
m> wrote:
> > ...
> > There were two different steps. Posted interrupt support on the CPU
> > was introduced in Ivy Bridge. Posted interrupt support on the IOMMU in
> > Broadwell (and added to KVM with commit efc644048ecd, "KVM: x86:
> > Update IRTE for posted-interrupts", 2015-10-01). New virt features
> > used to come on the "tock" instead of the "tick").
>
> Nit: I believe posted interrupts were only introduced in the higher
> end Ivy Town parts, but I could be wrong. :)

Yes, they were fused out in Xeon E3 and below. I was only referring to
the processor generation ("v2" in the CPUID model id) - never heard
about "Town" until now.

Paolo

