Received: from mail-pf1-f201.google.com (mail-pf1-f201.google.com [209.85.210.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D7B626ED59
	for <kvm@vger.kernel.org>; Fri, 29 May 2026 22:51:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780095097; cv=none; b=tIJbM3TsIjjohwX72iuoCoirs/oGhyVak6PEXYomX+QiN1S+VVNlaP2OW0bjEs9rmcLxHy0nIsVBNaePl0VJ2v2ekSzYnrktkSBlHobCEaFL7KapC2eVuMsb9SJ6Z3ncpWpdOLgxA6RqeRBIbj2YEKWeFkrlDlA32QZC7bGLMcs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780095097; c=relaxed/simple;
	bh=o5k3wiR/tFpPi+8TA7HSAvIHTUUh4WD1oYB8yuSvX5U=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=FrEtcSs6Wy3sf6ceKwIaQ+B1NIPw32XHAsWoINuzy645qhp2yL+bMkKU5Dq4HzSiwKYtgyHumwmDCpE8MYAKcas3GgBc0Lh+teqNbGsK/5y4EghrhTTakPRJKWVIT7CVlezGEFrHn+0dKiz80hTPUuP3+yRgVazS/uF6JXVFc+o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Pll9khMJ; arc=none smtp.client-ip=209.85.210.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Pll9khMJ"
Received: by mail-pf1-f201.google.com with SMTP id d2e1a72fcca58-842211d6e48so580238b3a.0
        for <kvm@vger.kernel.org>; Fri, 29 May 2026 15:51:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780095096; x=1780699896; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=iDamTyASUWUv87s6Ugw+3o5D1xad/djiw+VyKIvP/1s=;
        b=Pll9khMJkH+LFinn20lwDxV5zvKf9MHxGCkrEJ4qvELN5SwxchA7PgDKuJXY/FSYlV
         fP7Hlez4pI1t7JaYe8FIhQS/XGaccXafs5wYTJ0Cxo2yAwd0uvcx00ZXyVnwe44L1CIG
         1ezaJZhddYVwxHr2rl0rmIcJAn66W6jw4bwnZnr4nn98x/gTwTZWAW04pqQbL0Fzn0ys
         8urmA/FxMn1ppUelRqAaNf6jrx4df7AL2xtCqojLSxJ0ThxEts1e8PjJHnsYCBrmPZZ1
         BSxSwCp3gaLsYwCE/naGbD+ztrCCPuIlPxJHrb1TVf8w5dXXiVwa/4TVvgVEgFdcQp8X
         oKig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780095096; x=1780699896;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=iDamTyASUWUv87s6Ugw+3o5D1xad/djiw+VyKIvP/1s=;
        b=b7hUCdYSkSFkX6zNEWPfikJo2StK9x0nDyeOGZC5aEE4kergxFDJlI4peMk23XLFEx
         r1m990bi6OZ0KSQoSA4knUKe34wAaQGDQjjdgF1b0SrFK9WAUScdBs4j8vMX/ufLQK5u
         1aDDndO65Ud1/S7QVfGGoNmygqbShjNe7mtjjFuPtYVhpEBAQuPtvJz/AL6/hfm0xZIB
         YAseXHMQkUwfs8dvn8GVbhAK6tm5T5Ej2oFk1FCcp996zEELbb5z/oobG2so2/+f+cRs
         0O3eM4pXjwZhegGmKCmgcUEEMX4SMAfw+Eb+CqG3zFPESI7dA3qqBidqTbs1reLZGX4r
         gFCw==
X-Forwarded-Encrypted: i=1; AFNElJ+j5yIEuE9/ihGdb+M7uJ9LJVkvyqyaXPOPoO1l+MWWVSq/tQmrBWl8XLfzRdHcJxDOkg4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yynapk3iGy3gEhBlQJ9M79F3JVJ2Z8y+h9E3ALete6sIn6hy+CM
	v0Su6rs3/+KgQh96UXvBK1W64TURZJUS3NbR5rctF545VmWvxqNM2RHB+0OpttKuZ/DoaNPRlHm
	hQfp3Eg==
X-Received: from pfhz14.prod.google.com ([2002:a05:6a00:240e:b0:82f:7242:4cb9])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:3e19:b0:82c:2555:b9b2
 with SMTP id d2e1a72fcca58-8422532a6ddmr1429112b3a.10.1780095095672; Fri, 29
 May 2026 15:51:35 -0700 (PDT)
Date: Fri, 29 May 2026 15:51:34 -0700
In-Reply-To: <20260525070154.495455-1-yanfei.xu@bytedance.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260525070154.495455-1-yanfei.xu@bytedance.com>
Message-ID: <ahoYdrs9dVzp6Ps6@google.com>
Subject: Re: [PATCH] KVM: Validate irqchip index for LoongArch and PowerPC
From: Sean Christopherson <seanjc@google.com>
To: Yanfei Xu <yanfei.xu@bytedance.com>
Cc: zhaotianrui@loongson.cn, maobibo@loongson.cn, chenhuacai@kernel.org, 
	maddy@linux.ibm.com, npiggin@gmail.com, sashiko-reviews@lists.linux.dev, 
	pbonzini@redhat.com, kvm@vger.kernel.org, loongarch@lists.linux.dev, 
	linuxppc-dev@lists.ozlabs.org, caixiangfeng@bytedance.com, 
	fangying.tommy@bytedance.com, isyanfei.xu@gmail.com, 
	Sashiko <sashiko-bot@kernel.org>
Content-Type: text/plain; charset="us-ascii"

On Mon, May 25, 2026, Yanfei Xu wrote:
> Sashiko reported that irqchip index is not validated for LoongArch and
> PowerPC. Add validation and reject out-of-range irqchip indexes to avoid
> indexing past the routing table's chip array.

Can you split this into two patches, and send a v2?  I suspect the reason no one
has picked this up is because it straddles two completely different (sub)subsystems.

That would also make it easier to get the fixes backported to stable trees.  PPC
has been around a lot longer than LoongArch, so I assume the PPC fix will need to
go further back in time.

Thanks!
