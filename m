Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FB233DD874
	for <kvm@vger.kernel.org>; Mon,  6 Jul 2026 23:22:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783380124; cv=none; b=FungRqyf5Exw/h8SCiXsyXky21tbuNytJ2/hOLmV4YCMNe4u4tTgaFxqoGOidumKE/EPOfFAaHQXPyRV5/S2XyTNZabsqpgKBYib18tDCKPJsMXv8IaapbALh9VkeaRA4ht8cIjyamNujoCkkJ2/1oMCHGvY6tCT8afynqHfhbg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783380124; c=relaxed/simple;
	bh=5tTJzFCz090WEshickhyWZBU+H17ZnKRtGBALiNloLs=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=fJzK6mAtxPEYnpZaiUPOWZu9xekAl9uFo7FN+Q/upqMBshw4q4Tu4fCNJjyDVPfBEEiZPihddaSwzZ1Z2OQ9FuTKLWOOajJHpFDSOxUEOhhCxCIT2LUl57ch/h7tYZoYsVz8yT4cLnm1BaPHwKs1kkyiGcgG0n2PyEsNXcOUt8o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Q3ji1pM3; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Q3ji1pM3"
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-845ea8fd3easo8320898b3a.0
        for <kvm@vger.kernel.org>; Mon, 06 Jul 2026 16:22:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1783380121; x=1783984921; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=MkGzf5Ltjdp17l7lz9dFJNCiKSFQqbXrN82DhhAxuS4=;
        b=Q3ji1pM3TEx9qTs8lyrmnbPXJ5AuzBP1mkFHj1juU45RaVB6um1ykpX5nJ5DpI5bjf
         7wA83gh1nHeEme4R27MlyAmAfV2M+rhJhgKZVQvqGuOeXaxjOKsNkM8vULO0LClZ8lTE
         jw+EIY1VlIRca4U89BC9R6Nem7nvEwJ161GD69bwGebls3csshtJXaCl9nSwCum8jlIn
         nbOtVfqk1en9AbcZAxuSzJZS7Dsef/m5WPvrryhHYS/0wmiegjF2Y4gn+XCzDwX3mYAV
         Xor8fh2vakqcLoR4l4yrhan/3Fet165oK4WOuu4Ip5aWWPxmSWlvzCBjsxHXhp9Ibv/M
         qRow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783380121; x=1783984921;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=MkGzf5Ltjdp17l7lz9dFJNCiKSFQqbXrN82DhhAxuS4=;
        b=r90XuUfafFXvyCO/QOWdfJSj22Za9iwG3NGrUhv9alwAKiLnsWmEcF/ICeX2n9R3P5
         SFr4yETY6GhFgj064IMsP99GqBiyYEJzvX2bPDTgyNoCRoJ5EEW/lSSTV+OQAu5HQUxc
         Z6IR88EyPsx7HRCG+nl4LnmstKw1wCEi2MtP+7UxZL9cyDCU5HmkDLkouzeHlxd9oiHN
         Zyz4+WXKq1HcmWoZhxFk7cULQeW77l+RaWUTNa4T5CRl3hK6l41IuItIZS2laRRd/Q4e
         wmhQjymCfH1ErhYoii+HAsLjH9E0LE7h5Lw9wBEp1rNfUMetIjdVUO1w7qiK760u1TFQ
         bq0w==
X-Forwarded-Encrypted: i=1; AHgh+Rql3hLbzwBfAUPeQTnKL63W2w8DQrNhjQ7rqlgekru9I6l8Zji+bSMq9ekP6HrMhXUY448=@vger.kernel.org
X-Gm-Message-State: AOJu0YyZSF/t3xOPN0bL/JLcsK2UMZ0OAlFKYo/f9byCxgapnLmJo5eD
	/fyV8XJ38neOLVxLmIDtw9BMvezN7vVfJOEjGgl1TH5ZwIaiudXuSIpXaFU8cLPNLP24tHFc/X3
	zDZg/YQ==
X-Received: from pfx50.prod.google.com ([2002:a05:6a00:a472:b0:846:f544:63be])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:94f3:b0:845:d284:9e11
 with SMTP id d2e1a72fcca58-84826e38a3bmr2549381b3a.56.1783380120822; Mon, 06
 Jul 2026 16:22:00 -0700 (PDT)
Date: Mon, 6 Jul 2026 16:22:00 -0700
In-Reply-To: <20260706092021.3625908-3-twiederh@redhat.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260706092021.3625908-2-twiederh@redhat.com> <20260706092021.3625908-3-twiederh@redhat.com>
Message-ID: <akw4mH99FGquorxC@google.com>
Subject: Re: [PATCH 1/4] KVM: x86: Document that KVM_CREATE_IRQCHIP must
 precede vcpu creation
From: Sean Christopherson <seanjc@google.com>
To: Tim Wiederhake <twiederh@redhat.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Jonathan Corbet <corbet@lwn.net>, 
	Shuah Khan <skhan@linuxfoundation.org>, kvm@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"

On Mon, Jul 06, 2026, Tim Wiederhake wrote:
> The kernel rejects KVM_CREATE_IRQCHIP with -EINVAL if any vcpus have
> already been created, but the API documentation does not mention this
> requirement.  Add a note.
> 
> Signed-off-by: Tim Wiederhake <twiederh@redhat.com>
> ---
>  Documentation/virt/kvm/api.rst | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/virt/kvm/api.rst b/Documentation/virt/kvm/api.rst
> index 52bbbb553ce1..ec5bf99ff8b8 100644
> --- a/Documentation/virt/kvm/api.rst
> +++ b/Documentation/virt/kvm/api.rst
> @@ -856,7 +856,8 @@ Writes the floating point state to the vcpu.
>  Creates an interrupt controller model in the kernel.
>  On x86, creates a virtual ioapic, a virtual PIC (two PICs, nested), and sets up
>  future vcpus to have a local APIC.  IRQ routing for GSIs 0-15 is set to both
> -PIC and IOAPIC; GSI 16-23 only go to the IOAPIC.
> +PIC and IOAPIC; GSI 16-23 only go to the IOAPIC.  This ioctl must be called
> +before creating any vcpus.

I would say instead "This ioctl can only be called before creating any vCPUs",
because a reasonable reading of "must be called before" is that userpace must
*always* call KVM_CREATE_IRQCHIP before creating vCPUs.

>  On arm64, a GICv2 is created. Any other GIC versions require the usage of
>  KVM_CREATE_DEVICE, which also supports creating a GICv2.  Using
>  KVM_CREATE_DEVICE is preferred over KVM_CREATE_IRQCHIP for GICv2.
> -- 
> 2.52.0
> 
