Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=170.10.129.124
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792429016;
	b=H4NQD2MJ5+qtyp8+gHz682ZOpU9JkJ1KgYcHYJ/CpeNF/VRJLvzaNbDcExGeh3BXWQJJ
	 UizKxhdmkLhFTTs6lOOvlWaqIFHZRZU5QCqOyboJvoI+ZWGA+PoSTmVrmwcVFXxdJ/6Wl
	 L7920YL3zCdre/5CkwdcJxMXdvHEbYHfdmKuIZhWwuS+lh1sHqxsl3RZt2YfMcHqtr0fO
	 gK2u3T46gBgpD4zvnMM9ztfvIU8f9odvVjp3xfwcPypvfBSLswdcL1aAv+6zPo7MTHI+Y
	 0sujiUFl/sRt7XIqTfmfin0guVausNdywmOOGFl+hBgDhV7hrt7xfsbnz/2uVYRGyKw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792429016;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:MIME-Version:References:In-Reply-To:From:Date:
	 X-Gm-Features:Message-ID:Subject:To:Cc:Content-Type;
	bh=93Mxke0ognMkCH1OvgVhoO05LeJUA+eXnVQ+rwQWPck=;
	b=CJoVwOIFyPeFPHXzMhRXAfxk9fAKCkANd50eaXX0rspcKJdr7LqxJ+1rEDjR0m4IbhY7
	 wip7FhxZBu231uCkok/wh6brD0w6TG/DCrcUPXXOSprsr0txqFyHqUQmdM5No+BmFHDFH
	 CNCZ1owBZc01yL+qkXWIcvsVeR7VxPOFsGLShuVY/MFTeWwYd1JbYwZWNihjre2jvdyK2
	 t1AHEVeT0aB5iORRuKbWamRojln/PBaAwwBvWpmhsqcs0e8IWuYnb4Sgzz3NGk8RotQZ2
	 X119ae2UaXLhxAZGhxnCrTmV2jyVivFd8/PW2JzqPeUxGf4z9yNshn2/iirlCVBSqDQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=gLnnaa9J;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b="nS3/gBNz";
	arc=pass header.oldest-pass=0 smtp.remote-ip=170.10.129.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D3BE606A31C
	for <kvm@vger.kernel.org>; Mon, 19 Oct 2026 16:56:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3D3BE606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=gLnnaa9J;
	dkim=pass (2048-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=nS3/gBNz
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1792429015;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=93Mxke0ognMkCH1OvgVhoO05LeJUA+eXnVQ+rwQWPck=;
	b=gLnnaa9JWYqEn44JVTPM5DO9ax4Bhw1s6mGajEX/SEA9HMHghHUqVADF4UIowZu7wvORmS
	jtxKAN3dlYo2OJXZBAknGz+ag3P+c4piJIqrTk3IwSRT9mfPDEQ+5Z9uN2WAteqw/abU3x
	IV7XVYTBnYdTXvjFb+2ijEUmHAJKky8=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-553-y-oX09KpMjikGRKhNMoLCw-1; Mon, 19 Oct 2026 16:56:54 +0000
X-MC-Unique: y-oX09KpMjikGRKhNMoLCw-1
X-Mimecast-MFC-AGG-ID: y-oX09KpMjikGRKhNMoLCw_1792429013
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-48c46582442so1509525f8f.0
        for <kvm@vger.kernel.org>; Mon, 19 Oct 2026 09:56:53 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792429013; cv=none;
        d=google.com; s=arc-20260327;
        b=aDy+dwYHeNLs1nFgke5JwNBMPsuZ3W77ji59KrH/UKUO7PnczxaCfjsFF8bOw/x+yf
         NtpjS2LSa1IEjqltI3zkQUFSKv3bKl3TuR2mFDzAdgrJS21oNZxKXGIFyahOE4GiZxzo
         VkR/WaqiqKDMoyumeU0n7nRX5dzBJlkq1KyfocA7mqxbUJDg59/5ZOArxkoED41NDlja
         2v0xZyn0kXpHOsNmGSaMm9N8Mf+SbGApRdYmy2tBHkWuSKQE9LC1yJjtNkyTb5ecI1cn
         J37h3yI4xaHkFNxOGzVWPmabwA5pgGf3/0+72mp9hqXYdxRYCkxW0TZPdLUwDwqDwAsS
         PdoA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=93Mxke0ognMkCH1OvgVhoO05LeJUA+eXnVQ+rwQWPck=;
        fh=2+6GT+wr2qOXu9XiL3ouFhStXmu9Xj7QzW21OA/9DZk=;
        b=RkR7WZroaPlplrlNAlyJCCoNzcK0jO3Su5k6mSA2rVrqQwrkI90I0KKv6xBqJUCwAC
         D1sPgyQ6rl2m8S+h9OSZZIm0YIY0gB4aQU4JxO3LxCRrYLIUnnv/H4IJAe1LkIaOe+J0
         IxBlV+eEZlytQsk7piMbpEHhRJwUhHvsYUsbEPDKGJWEzV5Un/Hndx7pShvXgejrW8t5
         znvb1z5XTZMSlbH45rB0OR3arZ+VmK9Si0hbwvPvm820OI/5iuIT/ESESQAuFnnqWf/6
         B25UcMrE7C0n3je6mlh+406NMnoTC3upx2DNEJQe9cf1kITtsKpfVN40V2pDk7mREgvc
         rrJA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1792429013; x=1793033813; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=93Mxke0ognMkCH1OvgVhoO05LeJUA+eXnVQ+rwQWPck=;
        b=nS3/gBNz/RIAybVsK7bkfz4Ls04SCNuJsPimvndGNvLIClFkqx/dmDXjWY+LQsRoMZ
         7S5JLY2LcUBvArEat11T7YPk2iLgNs20ZcplURpldCgIR/2cFYkwKunfOcHDcBT0++t7
         7tzzQFqyqGiLh9KDSsM9r0vN9cv3FW5/NJPvGzPZ/HYSNrWyK6FgnPpbL+WqrVxEJnjl
         usQ2SwSDfR47kS6PT2O9Zjsw59Z1Wqj0VCjMBPCcG8A/DTh+uNjdzvLfbP6aFevPVdRf
         PUMWGttmC8fsgaHVJkGDQ36KXxgBV6HhFpkC4/qHSqHuSq9iyB0XyOmLerSjwIWZ1ZAN
         Te5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792429013; x=1793033813;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=93Mxke0ognMkCH1OvgVhoO05LeJUA+eXnVQ+rwQWPck=;
        b=qkiOYCSPTYFf8P6IDHWlflceaaxYX+OTQ0uRIJMS68jcjhDPQ/seZzgneMAjaEJ6RA
         Yqe5QeumVp7SWGjjrQx/6veIvcxdK2VV3QTcC0KEe721Gd7+RNcyU/tqJAYvwean9++p
         BI7bq7cVyylKpCrP1yez10fsP5i76QVOj80j7taAiI6LXTYIBIQJDEAfQ6wBzv1JzK6L
         kZ8QTQNFeXbzSSPlamoYwkP3R56kgEY86fYVQexyDK9Ruk4rTAxlxxOccdpG+mMVzweU
         gvW5yF0XGrXCTGUuNFVRVkvfdCggunr1ABmRG2Ahjjzuji/XEVkQZhnrIikm9CD+enrz
         +scw==
X-Forwarded-Encrypted: i=1; AKwUvByQ/JfSZ+Srh0Tlrne79/lxOJEWJEsgJPyigaueIW3N1sfGaKkPw4dInHfT17I4eM7RcaU=@vger.kernel.org
X-Gm-Message-State: AFq9FYJZR0iKZOrVekJ+lyr9PEXO0yP+0Cxk4F0ml2JvccdETyN8DlJF
	o09rjF8QjjH+diu1P3248/9Kirk11uuk5ibR8jqi1dmUNSH7vwm59p5EI6yj1N87168D9Jf8aDu
	9OpaosXqdMg7OGy6Ila0X83Ms56GBqVv2u/h87Iha/eQ0rfmN4TgZA0CfEhhbb7PaAW1pMfqO0s
	rjb5cZoQGyQTyLxU3NvSkZ/UUrYmJ0
X-Gm-Gg: AYBFou1UUoVxN2YPeGTP39EbeGfC+slxjMXKf3zDdFSy7nX5JaR3/GhPx+D/kj2BFl9
	JWbqXGXRE7KE3Z1wxBNNUua601Z3W+vV7oFjg0lZj7Ot2hwow58juPyZ3VlxG2hHUszCEJZIpzo
	4GJ8StMgZGV9Uspomlo8ElPIoEvKIy4h2LLVtp4UmYrvHIR/7BCcOASb9WoG+5id7YT7wGVZ06N
	3rETKRJooetSQA0o8D2ZSGgaXyaUwRuc9HfCMaq21RCYVNUpDXtmTLwftL1kA==
X-Received: by 2002:adf:ffc3:0:b0:48d:f3a4:a6aa with SMTP id ffacd0b85a97d-48e07bc36e1mr12549496f8f.35.1792429012739;
        Mon, 19 Oct 2026 09:56:52 -0700 (PDT)
X-Received: by 2002:adf:ffc3:0:b0:48d:f3a4:a6aa with SMTP id
 ffacd0b85a97d-48e07bc36e1mr12549457f8f.35.1792429012350; Mon, 19 Oct 2026
 09:56:52 -0700 (PDT)
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <atZJV1B79VsZoy8u@sirena.co.uk>
In-Reply-To: <atZJV1B79VsZoy8u@sirena.co.uk>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Mon, 19 Oct 2026 18:56:39 +0200
X-Gm-Features: AclHuK8vumiua5SMjMCvMOThl3efjoSr2L_M6TnDtZ77TgU9w18ADr4xGbKM-sQ
Message-ID: <CABgObfYRYCrOj-rHDaDd3LSFMSd0ug-YoB2pD7jDA8ZgMR0sCA@mail.gmail.com>
Subject: Re: linux-next: manual merge of the kvm-arm tree with the kvm tree
To: Mark Brown <broonie@kernel.org>
Cc: Oliver Upton <oupton@kernel.org>, Marc Zyngier <maz@kernel.org>, KVM <kvm@vger.kernel.org>, 
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, 
	Linux Next Mailing List <linux-next@vger.kernel.org>, Suzuki K Poulose <suzuki.poulose@arm.com>
Content-Type: text/plain; charset="UTF-8"

Il lun 19 ott 2026, 18:46 Mark Brown <broonie@kernel.org> ha scritto:
>
> Hi all,
>
> Today's linux-next merge of the kvm-arm tree got a conflict in:
>
>   arch/arm64/kvm/mmu.c
>
> between commit:
>
>   dd0bc00e3e920 ("Merge branch kvm-arm64/cca-7.4 into kvmarm-master/next")
>
> from the kvm tree and commits:
>
>   b44a8c32f0116 ("KVM: arm64: Abstract out memory abort handling")
>   892c8a0bcc8e3 ("Merge branch kvm-arm64/cca-7.4 into kvmarm-master/next")
>
> from the kvm-arm tree.

Hi Marc/Oliver, is this something that will be fixed on your side by rebasing?

Paolo

