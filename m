Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A84C3002DF
	for <kvm@vger.kernel.org>; Tue, 21 Apr 2026 17:20:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776792029; cv=pass; b=c/RLjizWvWM0u/boq5Qpa1+YMuU1q03A8t76S0nVsozS8k7asFBv3hlCzIvLczf1UEfWy4AvKiRVcMm4IJSiGSU4RdoFfIj2HTKboFyWkICqu0Nqu/he0nhI/U1EFAFHmfCsV/cgoEj56hCP5Hqjw54AzJbp/h6T0CwGuCDLxuc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776792029; c=relaxed/simple;
	bh=ztgSSy7Cs6Rr8SEvYUTe4Zy5MGydGcauqGPTVot5BFM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Oq6mDQiJGus6Hy3iNt7gT7ZLHrRcRFOnDoC+LI9Nw0EAuy3jARqB7KWuH7rwaW8JxsYsiqNtd4U+h/7ZfOIz/7ndYJoZCM+vMg8G7KWKbQLNVZAEbqtanwqFQrfhdOaP2agFrnwnnSZO27Ly4Tyw1vPWdiHxsTWBJveKaBt1/70=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=oJ+pT/r1; arc=pass smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="oJ+pT/r1"
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-66ba6d3dab3so28816a12.0
        for <kvm@vger.kernel.org>; Tue, 21 Apr 2026 10:20:26 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776792024; cv=none;
        d=google.com; s=arc-20240605;
        b=glB2AtpUDz8x5dExYR+4H+i+t7GlVC/8HkW8htKHbpsZEePY5ki6p2nwJRagpEywDR
         CyODLPdfKPIh6s0cc3Rxx1DVEoESEBXpbPG8BeR3VZwFgnEkv8zenIVUnINkygVMibFI
         jyZxNLdCzelHzqmn/u/yBU2bf852vuOJAtuwshK4BaYHwii9lVbs0gXNlwj1imAP6xt/
         +iG9U8yEpoTY/U6lWxYiGMaHGA/AwiPSVCcgqg0vBEIpfA2vFA+Mfi37GILiuwPpM7UK
         b0oeshii6+P3RminhOX4aKTRDPGJkFNpjRyh+gWh+lYHPzHCraNLRiSsGN8bCB16KJBk
         n0eg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=ztgSSy7Cs6Rr8SEvYUTe4Zy5MGydGcauqGPTVot5BFM=;
        fh=rM6WoL2SyBBKrMu1Rtt4HxTjxLOzNn/QEk+os/OcC5U=;
        b=MfCN0ZeLpC7iYH/pnG+9P95rb17sc1GnrCNdBHDLLa9Bdd19chD1H004i+fVRhp0Ze
         dK50f9yf5/FkwkvxzZLlZRfbQWs2zLAWaqUMJI3NlaC2xBCEHr//OyAdLpr7Ua/Mx4Sj
         ypAkZ3JJAKz3KSPJdNbAXCM3KOLvvUI0Br3JziyLjhhfJqI7ZlMRUuM50iKcf0/H1L+p
         PyS595YqBoHTdGE47gyR1a54tfKYUKmk9Lmxh1rTvER67nsHkmQTau02087wRQ0Ph8Z9
         ntCgMh/+sq2++/gxiLxD7IEQSD9xUeXG7Al1lzpqba1tuftph+VqHmJWiWj3RrXM2HnD
         8R4Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1776792024; x=1777396824; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ztgSSy7Cs6Rr8SEvYUTe4Zy5MGydGcauqGPTVot5BFM=;
        b=oJ+pT/r1/hr8+0uzcJwH0XOycBO152CZtV3/q3VGxVXddG/vJb2A+zoy09CgvbzzPL
         fRO/nyBJrjw5JSHLZLQBfb4gaekTtrbqgeZUf0mFRLhVKI5CCHTjxhyKkO3Usny2+XRQ
         zeZT7UyL53NiGR4LxJzFJZrWzzI+h4xiXCPcFsTll9yGhGlrN/PCg8c2eTV8rGLGnJ8L
         vAisgBJm44wLV6atifnSVFGSObmsUhzdXqRshh2Ydzk5/ys0Qr/Hw2Jxd6phWcUWbn8j
         E/ws21BOwEfKSUFdTci8RzK60nZp8ujUxqDJJkSoN5eUJv8hHvCpl38fnVt7MDC2rLK7
         yPSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776792024; x=1777396824;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ztgSSy7Cs6Rr8SEvYUTe4Zy5MGydGcauqGPTVot5BFM=;
        b=B+Y4w2dcfTErXo8dJehhZWJgYQ02iDu7qXwRC7OUeQebRy1lUaIEnzU2TsRcxQlu/Q
         MzQG5i/RODuN1sdwIWyJ4jmgwIfq8iutIt7noEju/pkGwnNzXCx14ownTDy2fP9JG0C4
         GBQwFZmQFMopo4SJHs/n6n+Nnt/yHaGfHMa+HaOQAnaBtnfrjT8/8DxRlf942POIaim8
         lQhD6EO1mX5CwrOFxG4akT21X9hsZA6lLXXWul/X82QqnWbepoUuE2MvQdYblIu/57Vq
         t0C6nTzMq6uXIuKBnbiBiFkFwu/CwWnYBf/+XZZelgaN5+dLPtfmwJ7HlkckDEFgguBW
         lUdA==
X-Forwarded-Encrypted: i=1; AFNElJ/FtSTQluFvGcJqRuquI0DEjpXOy7fV7Hy/JKbSGAlJEvYlAeT8o+HlR3t9BCLbjFHjGqs=@vger.kernel.org
X-Gm-Message-State: AOJu0YyVq9xd/O3BC1Z90EnTRd8B3S1ckltIFaAo8OuYkm4gPTfGe+wm
	HcrcGI6ZJy4bBml3EbUVdfcEvGGZb4KRVINSgmRLV5d9P9QujoMXBh3BrPM74WCD9Vbxdh0DWqi
	z5/vx2/UsgbXt0yo92GcQ6eyLArDH2jDWYermQrDQ
X-Gm-Gg: AeBDieuTyPkLLCBErh1EihKVMInqHVHm1/kLLt1Lp4t8+q/G8OiBmCiVvGUlT3KJ3Mi
	y6mlNE2tVbR9ZtrK2cdR+u0bC/OagfCtsj55nQ+fAr9a4vWZ33SsVqjsBTijyL37dD6uRybeRVQ
	NFmXG+F79Xuzz51h/Jo2zpK/enWTN5ae7q02N73wjkfGAiioA33w4gJmW6QvNMSTIoROVVWXQYu
	oqogTT8BKbPGISt+i1Jxzg0tAKmE3WAO9H8E0YagE8eQ8P+CW2u37u+EdhbhZ1BG0Tj4iyZXN+7
	ayHL17dVwzCN00wcOIj+G6zuhXxT
X-Received: by 2002:a05:6402:a20d:20b0:671:79cd:151c with SMTP id
 4fb4d7f45d1cf-6744071e4cdmr168551a12.6.1776792023942; Tue, 21 Apr 2026
 10:20:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <70cd3e97fbb796e2eb2ff8cd4b7614ada05a5f24.camel@intel.com>
 <87mryxekxy.ffs@tglx> <770ae152-c3fd-4068-8462-23064de02238@linux.intel.com>
 <87eck8daot.ffs@tglx> <20260421111858.GH3126523@noisy.programming.kicks-ass.net>
 <20260421113212.GI3126523@noisy.programming.kicks-ass.net>
 <20260421113407.GE3102924@noisy.programming.kicks-ass.net>
 <20260421114940.GJ3126523@noisy.programming.kicks-ass.net> <87cxzsb5n0.ffs@tglx>
In-Reply-To: <87cxzsb5n0.ffs@tglx>
From: Jim Mattson <jmattson@google.com>
Date: Tue, 21 Apr 2026 10:20:11 -0700
X-Gm-Features: AQROBzD1muN-aefrmgrDuBd1eFrFDm_UFEgJp_IpmJ-nmHCZyVJQZAE5o6FyZyg
Message-ID: <CALMp9eTeqE4u6ioepVeowRkcNs63DYZTg8og8em12u4FsVWNfw@mail.gmail.com>
Subject: Re: CPU Lockups in KVM with deferred hrtimer rearming
To: Thomas Gleixner <tglx@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>, Binbin Wu <binbin.wu@linux.intel.com>, 
	"Verma, Vishal L" <vishal.l.verma@intel.com>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>, 
	"Edgecombe, Rick P" <rick.p.edgecombe@intel.com>, "Wu, Binbin" <binbin.wu@intel.com>, 
	"x86@kernel.org" <x86@kernel.org>, Sean Christopherson <seanjc@google.com>, Paolo Bonzini <bonzini@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

.

On Tue, Apr 21, 2026 at 10:14=E2=80=AFAM Thomas Gleixner <tglx@kernel.org> =
wrote:
>
> On Tue, Apr 21 2026 at 13:49, Peter Zijlstra wrote:
> > On Tue, Apr 21, 2026 at 01:34:07PM +0200, Peter Zijlstra wrote:
> >> > > > KVM invokes regular interrupts with pt_regs which have interrupt=
s
> >> > > > disabled. That's correct from the KVM point of view, but complet=
ely
> >> > > > violates the obviously correct expectations of the interrupt ent=
ry/exit
> >> > > > code.
> >> > >
> >> > > Mooo :-(
> >>
> >> Also, is this a x86/KVM 'special' or is this true for all arch/KVM tha=
t
> >> use GENERIC_ENTRY?
> >
> > Should we not make asm_fred_entry_from_kvm()/VMX_DO_EVENT_IRQOFF fix IF
> > on the fake frame instead? We know it will enable IRQs after doing
> > handle_exit_irqoff() in vcpu_enter_guest().
>
> Doesn't work :)
>
> > SVM does not seem affected with this particular insanity.
>
> Looks like. It will take the interrupt after local_irq_enable().

FWIW, VMX should work just like SVM if we clear VM_EXIT_ACK_INTR_ON_EXIT.
