Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.52
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794442653;
	b=5OS5yjUmYbNotuHi7/BwsDkJAVUbdbevLHBfLDjb86ZpJOqPbl5oZqDsJuLZq+8UJyDs
	 k4RYM3jx+6ggOdoDCcR8BEq0zhf7yYLjBTVTi1yIHU5TattNvLIPwTsyOd772nFlViplw
	 T7MFE1CHeasCDVB9lv5aPQ6Sro7dh2UDRxTsvKE49OZBHNNWXDx6htAOPWC0FwpqzLZdl
	 l2Y0C/Uvi86TAUptHzHoxy65kaDdlL+EH42ANBDR0M/q7ESd9BMeVuo8QsQbisI5YoIQW
	 t26W9x1JviwZJ/7wqZvlTsYMKhcm4MhwuEcQLhcYIcx8rRBpI5JWUK6xhmpXh53iizg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794442653;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=gmUxuFr1Scrtzy9jq6/XBAc+K/Jb1cYhpFQ7OvuHQow=;
	b=NdP6Noqn43LsmVQKnU69FNIy3TIB7PmcBHewmR6g/SgVDnQGWl2EzPZ4UW7fZmXOZwrP
	 UrrGfJW+EZCLEgG4652trVzdPVfFGtGXoGWMgom4s4QhHlLtpnaGM+RnF+L+B/KUt5Tcz
	 XjEYwoz3JthVJ30ipU3qwjB/KCwGvDPAoACgcHYsPlu52FoRdWZRGc2WCWFwfKIRKNnml
	 rM8RgW4xn78VcJMe1gKmjxf63jWmsbAZ2l917UF/voHHwAP53jYCYp5UoQcOZwy6IYR3y
	 UqgDpnA0ls0KtQ0rS3cnnswLYs+CrrCdxJM6T6ro3LJBViGcInW+5GPczhVDO+RMKcQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=QY+9H4KB;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.52
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFCF7606A327
	for <kvm@vger.kernel.org>; Thu, 12 Nov 2026 00:17:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CFCF7606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=QY+9H4KB
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-6b571a45a2aso2675a12.0
        for <kvm@vger.kernel.org>; Wed, 11 Nov 2026 16:17:32 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794442651; cv=none;
        d=google.com; s=arc-20260327;
        b=Oz2tUlK2crTeClHSkMDFca8qv4OPms7cRI2AzaOFr5D2Old2A/OK/fNvPye6Eh63+L
         QC1gPU77A/4vyvfwbn5aa5avVkEMMvCznejnJGokrc6m/M51GrKe389HzUHMMeRRcFNl
         /wtfsicNwOA1nCCD6UsJLpeQkheOdGlfuUQBL8hyusXHLgH9BDPwqV23MNrhG2lN1Jkt
         sy0ZSON1dniCSnsBQpgAhPH9zCtTfCwf8mhalMtbyv2/EXzKQFzv9tIyPwj1ecS7cR4v
         Efffv7o1w9APBwyl0VekFbjWlkdoe1+hun3lxdjdYHse3LWz9GGOdD7m0EbGTWrj5dW2
         j1ZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=gmUxuFr1Scrtzy9jq6/XBAc+K/Jb1cYhpFQ7OvuHQow=;
        fh=AV336XGFGbT2cCe/IfFhlUKcFpEz79/ZqF8DXTk3Xwk=;
        b=cgOv17ACa0xmvmKOZyhbxYaUODPfppt1IkHftXQmU1hKtY863actlLkUbWwE7ZfPUz
         ztUGzGGA7JCmSccbckAyexCREvQvG9CeOM44Eeuf9UFuv0DPEXnnk4yabFvlao7HDtL1
         YAhaDICCFEiyHlCkENVinnrEnB52cZ3wrsQ8X4NwHnaWOMb1CEnZdoVyV5LfoiD8YTrS
         pnqWKADNdZIKhNF7aO/EZElUPyhkrv/PPjNfOArIW+GC4iHi6hnwf2islxjK/cTjkqQ7
         CKWFS50J+Z84SnZoOYC6cS6UalFpEPyK7MAihF7x4TnW30hCPztk8ZecnzLtUjoH836J
         d4mg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1794442651; x=1795047451; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=gmUxuFr1Scrtzy9jq6/XBAc+K/Jb1cYhpFQ7OvuHQow=;
        b=QY+9H4KBVMuRH6WseMYE10z/E6oHDTOxh8WTDUyV9c1OJB/L2GOFHpJ8jTAfTPyNx4
         fnThIGMHJGQSj6hOU/X43MCGlvQdkiO64U45kfZ9SUWdV/nIBHN2yM8WjPL3ie/cE5CL
         KfH81hSPqG3FwvK/mbyH0AKy8wh/batRMthVd52IT8+bfnWhQT7GUqM9nWa5zuL3ThA2
         vyuaQMrfbHHFgxJvYpIprSsfvOxsGEFsy1XtwHw+8+fLUvC75LYsDziB7kDmd1lIZhDM
         bd44g2vlfdilYjpd0y6qdWk/rMix5Y9GFOEv1PHFlj/tkpTWdZ1OlzmijfV4pNIibtQj
         5FwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794442651; x=1795047451;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=gmUxuFr1Scrtzy9jq6/XBAc+K/Jb1cYhpFQ7OvuHQow=;
        b=ePSyJ+I70LzitYUIKefxV1lOZ/Sk8LqeBzgbO4LuslQLEOLm1vDVy3rx6oVqpCE+vq
         sQAWkGscexBSP32/m/46RQ1ff7/bxDBPYhZVrPrWZw4TI0GRk15uWAo3Aj3eHrG/yC5Y
         2uF39xLoTJOtKQlDkpsmB6QYLz4ifjsmqod5ZgCAdfcbbjHC29AvEqvSQD6OTPbPy+dR
         HSAfpiwT21zLiyXcr1Lb/joutgVkB8h8n0ZiTmkou+miYnbu9GJpqND/QW36DTsxXbCS
         4PMUUyoRKnAZca6GPlpMkfl18fb7OPt/XpOJVepxtap8zPIrlKUhAcExWlTgHUy/ucSK
         15yg==
X-Forwarded-Encrypted: i=1; AL+hErFTMlkWbMMbGTQf6dx8ng9WSjqF5Qas6YGXG0XzvB1waIkOkTEOOPNse0753UnNnTYExCY=@vger.kernel.org
X-Gm-Message-State: APuU4Z97cLLMZ/PQIgYUiTdCSkqWXx454eCrkVELyLKXLv1VihuboZwE
	LtcKJeAYgLlWJeBTlN/DvAziCt30vpDwpOXWS4KVjYIZvJv2Ns2OGjISJXpzIkUGHJ5Z8CcFuYl
	FOTLGt9mFp9apwcrjx+zKJ+Dv4eOubP6Y1CEgu/1D
X-Gm-Gg: AYBFou0PvsrUMi5GiCBcfNLldkV0mDB5O2gwPacoVQF5Ag5NLB547HRWURrFlpJIp61
	j+Ob2JKE5KWr5YnfxNexjdPCcIgHVkCbsvafp70shTHhS1AGydilU+Hvm/WsWKb7eKZ8sCBrgbr
	O4jGIlMyyjReqYapQdXSHDZd/uGpeCjeoQWCrxWcMS0SQBNxmXdf9rPSViutSUfXFjfqOg6CH3Q
	XXIXo7ic7OXBMdanfoPBnP1r4HkXkzzxl3zkC5xNQpNq7UxOZ5fINk39uE3YBHmjiLxjGP3MppS
	UVG0PSbminf9MSdvJYW16ouvlV7qh7kukGkMRREIsXE39Ed8MCNZBPbn0VqfA+XbnF961vaFi9P
	knbv74o0is6DEIYPz1GsiwB+5Kp5tN46qR5ksJq5JmFGOX795y0NcVcwhoN7HtpuW4gVNzj94
X-Received: by 2002:a05:6402:327:b0:6b1:bce6:1220 with SMTP id
 4fb4d7f45d1cf-6b7a2a18aa4mr17979a12.12.1794442650687; Wed, 11 Nov 2026
 16:17:30 -0800 (PST)
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <cover.1794374897.git.zack.rusin@broadcom.com> <80b2f51ddabc3824b83da48fc0def984cf808965.1794374897.git.zack.rusin@broadcom.com>
In-Reply-To: <80b2f51ddabc3824b83da48fc0def984cf808965.1794374897.git.zack.rusin@broadcom.com>
From: Jim Mattson <jmattson@google.com>
Date: Wed, 11 Nov 2026 16:17:17 -0800
X-Gm-Features: AclHuK_V43cL9OcDFeVKDhORDjmYSlCIZPO3f49bHRt-Tpt3bJyQNBhejjxGgLw
Message-ID: <CALMp9eQvP6hdxJ2-X5bhZHfaM5JCsvVJe07OkzTnnQhq73mW4w@mail.gmail.com>
Subject: Re: [PATCH v3 05/12] KVM: x86: Add a unified VMware capability
To: Zack Rusin <zack.rusin@broadcom.com>
Cc: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org, 
	Doug Covelli <doug.covelli@broadcom.com>, Thomas Gleixner <tglx@kernel.org>, 
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	"H. Peter Anvin" <hpa@zytor.com>, Jonathan Corbet <corbet@lwn.net>, Randy Dunlap <rdunlap@infradead.org>, 
	Shuah Khan <shuah@kernel.org>, Vitaly Kuznetsov <vkuznets@redhat.com>, 
	David Woodhouse <dwmw2@infradead.org>, Paul Durrant <paul@xen.org>, Xin Li <xin@zytor.com>, 
	Francesco Lavra <flavra@baylibre.com>, =?UTF-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@ventanamicro.com>, 
	linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	bcm-kernel-feedback-list@broadcom.com, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 10, 2026 at 10:05=E2=80=AFPM Zack Rusin <zack.rusin@broadcom.co=
m> wrote:
>
> Add KVM_CAP_X86_VMWARE, a VM capability that takes a mask of VMware
> interfaces to enable, with KVM_VMWARE_ENABLE_BACKDOOR enabling the
> I/O-port and pseudo-PMC backdoor.  KVM_CHECK_EXTENSION returns the
> supported flags.  Track the flags per VM, and keep
> enable_vmware_backdoor as the initial value of the backdoor flag.
>
> The module parameter enables the backdoor for every VM on the host,
> whichever VMM created it.  A per-VM flag lets VMMs enable it only where
> it is wanted, and the module parameter keeps existing VMMs working.
>
> Use one capability, so that the hypercall and nested-backdoor flags
> added next share its validation and rules.  Accept flags only before
> the first vCPU is created, because vCPU setup configures #GP and RDPMC
> interception from them, and don't allow clearing them.  Limit the flags
> to bits 0-30, as KVM_CHECK_EXTENSION returns an int.
>
> Enabling the backdoor for an SEV guest still doesn't bypass the guest's
> I/O permissions: KVM doesn't intercept #GP for SEV guests.
>
> Suggested-by: Paolo Bonzini <pbonzini@redhat.com>
> Suggested-by: Sean Christopherson <seanjc@google.com>
> Link: https://lore.kernel.org/r/c60b32a3-e699-4a8c-8d52-09b34c4d5269@redh=
at.com
> Link: https://lore.kernel.org/r/aAjrOgsooR4RYIJr@google.com
> Link: https://lore.kernel.org/r/aAkgV3ja9NbDsrju@google.com
> Link: https://lore.kernel.org/r/aIEkrc7Mdf2ia1Mm@google.com
> Signed-off-by: Zack Rusin <zack.rusin@broadcom.com>
 Reviewed-by: Jim Mattson <jmattson@google.com>
