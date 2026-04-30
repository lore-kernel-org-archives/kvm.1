Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4303778F2B
	for <kvm@vger.kernel.org>; Thu, 30 Apr 2026 19:15:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777576526; cv=none; b=VrzH/qm90e4Rqp4LCx0QuFEAnOY7l+siSX8f+VJgrABycMFLdyFvMeMxPLD9ntaY4B+AkkwyJ9tUhJcMxqZAjiPau0wJdJQXFnS8UbpH1QKT7RUmlMje/fwYtRj6VXjvaVxkqZ2UFHAi0TPNzaiBH4H4ybytyueECYJMS2FQ/9w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777576526; c=relaxed/simple;
	bh=FbZ8JY4vkB/g4EkhwiLQyQdLjI9SxbCuqSiyAn+OTRU=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=KM6rpwCtUcSI6WZO5+e4C68aLpOAAcjfm69RwWdHQsJuPsqoN7YFLC0KqGHWW78YcJR/pyebnaRAVV7bfVMhomcARxvl0/VhzwhZCQnn0HjFIMG3cnTR6TiR1H2cjPQN9xuLB4dlJ+Cm1e6ukHAz30FMAlvoPg8f8b/ZGXit4Eg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=bb2wKfPz; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="bb2wKfPz"
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-35dacc40f92so1458052a91.2
        for <kvm@vger.kernel.org>; Thu, 30 Apr 2026 12:15:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1777576525; x=1778181325; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=SXDXedaU03TnLOUix9s6bxIfN8luyN0PBAfQF263Hn8=;
        b=bb2wKfPzmrPl7JGlGMjKxHkNBedlv1Qq07yIXDnpslznyJlomTEv4/xTjQtszlJVGW
         J1F78wZopdZ7ZzW//MaHbhCW99Fdl0rVPfdyB/cN2F5e8djVp0R1pgH3odzRXjUQJ2JK
         CyUBSbExn0kClIsjNBVHR9ywtVZzzld0lphWn+jgCBkoaxgZv0qa099oT8Hclm64VfvN
         YYw/A12Ksoe0MuEGz2pMs83ciy21zAkMoVt/vbUQAg1PaEg3b1nxsQak7tV11N5Wb/EI
         JDVVizLseyoZVDYd8Lj/44p1EmfnLNG45fsXWbuvyLmwRGp7hVZKfMRU/3Fvqn//4XLf
         HbTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777576525; x=1778181325;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SXDXedaU03TnLOUix9s6bxIfN8luyN0PBAfQF263Hn8=;
        b=OxyvYeQo7e4XB4tMQLv0PjtnQGzIhy6CJaknxm5qAvkVnQdJicfGVPndwzEsF9L2dZ
         ob90YCSl92rk/IHF+LwZ0UJR7hnuK1Ra9HOAVCUtyZJbab4EWBkEKgy54YGlXJT7Mp8a
         MlM7kEBMLvI+GcMVAEAZe69iOutwtNaNV41SyZVRROlttTeKETTIdl+GBu4zakXtofaI
         XvV0scjPuJZTehaIbY3pmwHNf3EnLpYvw5MirepLn3pz1GUr/cu6xhkl6vq/0lkbsn08
         JsAF20ZouBKwRUuzMh1dkahm5gj0vtuF4GpPFoJUv/0nJOpnAT4aNh4efFBtQZF01WGX
         rOug==
X-Forwarded-Encrypted: i=1; AFNElJ+VyNv00l0s/zN++B69tU5L1kT2xsN0rLUhDh00orGf5U4D/yPMZErLqdfOzQeudcifyO4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz09ZPWya3vR5mHFJRxcwLJiuygUOny60gZzF1Mdo3956I+5sC6
	vTbIxALXvG7PicYVB02OeJlnQ2IhqM1puYOugZ+75GSmrBEezgA7j8afHe8MonXolIDfqPyPsl4
	LTb7N7g==
X-Received: from pjjj8.prod.google.com ([2002:a17:90a:608:b0:364:df06:9c9e])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:48c1:b0:35e:5051:fb18
 with SMTP id 98e67ed59e1d1-364c310ccc6mr4176327a91.26.1777576524527; Thu, 30
 Apr 2026 12:15:24 -0700 (PDT)
Date: Thu, 30 Apr 2026 12:15:22 -0700
In-Reply-To: <20260430150747.76749-27-pbonzini@redhat.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260430150747.76749-1-pbonzini@redhat.com> <20260430150747.76749-27-pbonzini@redhat.com>
Message-ID: <afOqSkJnemK1B0PE@google.com>
Subject: Re: [PATCH 26/28] KVM: SVM: enable GMET and set it in MMU role
From: Sean Christopherson <seanjc@google.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: linux-kernel@vger.kernel.org, kvm@vger.kernel.org, d.riley@proxmox.com, 
	jon@nutanix.com
Content-Type: text/plain; charset="us-ascii"

On Thu, Apr 30, 2026, Paolo Bonzini wrote:
> diff --git a/arch/x86/kvm/svm/svm.c b/arch/x86/kvm/svm/svm.c
> index e7fdd7a9c280..3895d8794366 100644
> --- a/arch/x86/kvm/svm/svm.c
> +++ b/arch/x86/kvm/svm/svm.c
> @@ -138,6 +138,9 @@ module_param(pause_filter_count_max, ushort, 0444);
>  bool __ro_after_init npt_enabled = true;
>  module_param_named(npt, npt_enabled, bool, 0444);
>  
> +bool gmet_enabled = true;

This really should be hardcoded false, with no module param, until "enable GMET
for guests".  Otherwise stopping here means KVM is over-reporting support.

I think the same goes for MBEC.  IIUC, KVM doesn't fully support MBEC until
"KVM: nVMX: advertise MBEC to nested guests".
