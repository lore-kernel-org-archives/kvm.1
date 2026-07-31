Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6AF1426689
	for <kvm@vger.kernel.org>; Fri, 31 Jul 2026 17:43:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=170.10.129.124
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785519815; cv=pass; b=kShudq9lDDX2k4M6AC4fmSpt1W1AWOeaz5UZ+VjBGWw+nK3qolZBwBShCoNzHZHio31DAzGPoWBtGfBqX2/UlAq4cmtf97JATDEaRRuEyXV76OOH9eUnxOu/vaIO13fe1L12mjEK5HjorNlVqwZNr92XZkO58OoiynU5qMukCOM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785519815; c=relaxed/simple;
	bh=qfxA8W9DxzrKOx4BfI2xBeWxyWPVUC0TjGif2lNCUNc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sUE1A/WODtToPinRCcrzoUS3mUHVKh/PH8tdH9oFHz3d+ltiImGb1n4WiXZFHnr/1rxOeaNy5ape8fEviDR7giaSTC3N8q1F4KIMc004Pf6z+tVmnVKEYrcUneGZdmIFsXDxPcuT+airfjaQd0rV7WChB9ojelGUGjhfMTl+dM0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=UQvLzUv7; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=iia42/56; arc=pass smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UQvLzUv7";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="iia42/56"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1785519812;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1UShLu2XAyp0HMfPRBtJeGRma6VyLOwcTOhhY/6Zp8s=;
	b=UQvLzUv7WUfhwbRv4oYsRGJyE7u8t1gzunqJOvYYq3HNSISzLoRAor9zwxmXooS/wKx12c
	SK43pGMlT9UeKPb+m0fwkqjoHc/xJ/zQDxzCO5dma51X7UDQjfAC2i5HGXGfnECV1ELLIq
	tumg7iTss0qWNMI9ovD+4W14+MWZ/ng=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-711-Z6Vkq2AiNRKBdC-hKhBv8Q-1; Fri, 31 Jul 2026 13:43:28 -0400
X-MC-Unique: Z6Vkq2AiNRKBdC-hKhBv8Q-1
X-Mimecast-MFC-AGG-ID: Z6Vkq2AiNRKBdC-hKhBv8Q_1785519807
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-47f7039fa59so1219434f8f.1
        for <kvm@vger.kernel.org>; Fri, 31 Jul 2026 10:43:28 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785519807; cv=none;
        d=google.com; s=arc-20260327;
        b=f7N2OMeeBt8MOxNrgYEOhcKLLxbE72DxYcaYx6xq8jWGxwsIHImpzPZ9TPJA4WqbOi
         9ps/poiJvQ5+ghFWRuB7FmIeUwAT3TDKn5+p5z/yLsGCYA/VZHA7KKMFZWgoHeKNQGjU
         ipvQJpfPngEW8PClQEMO9/ljSfRqqwr041Zx3/gap+ktNb/fuMI7Rs0F+j+CB5ThSFmS
         bmfqpE8oird76lIOV6tdrdNIAZnIvnPf98P1xwjG11GiOFlRnLucgtyW+/GxZTArQUmu
         kFP/kcH3cCvTJJqPYcCJvbBbMsDkh7QxqkNjPqnkN4HbW/hzRrXzmijdJkmqL2Mq7n8H
         qdsQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=1UShLu2XAyp0HMfPRBtJeGRma6VyLOwcTOhhY/6Zp8s=;
        fh=RmF0Lk/RY5VIpy9CUW8DbnIRIRwUft+du5AkBjJt8GA=;
        b=rONdux3PI4kkPOEhXaz+xTwgBXlB5tvGfcwDbrHPbKFDi8O+VC2fO4esxVP7IC5Bu3
         PhT7NbKqppb5A0Wpvf+IDwJxlfGPqqyi4rMXjBnmTbM+bof95fghhyrolDyQbULfE29r
         jovOSG6WRMVK3+hYlYFlN4cWz71rzZRl1ezEEuq1R2xKce6jtWwjU/gt/sxGTQPWNNyI
         xj2WE+iuaBtTPRT84ZqOXyefGHZT1Qigt4RpYBF5UvfdVZxfMpt2QyeO7AXVY+PU+7TJ
         4U7DustIRSFT27Pxttdvj7poD0/JvkHKu8xdj3iJ1N+it6kjJH2VEUsj4ewdOaHGfaMI
         xSMg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1785519807; x=1786124607; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=1UShLu2XAyp0HMfPRBtJeGRma6VyLOwcTOhhY/6Zp8s=;
        b=iia42/56lxuHA1FD41g4OedFvqBsR/Gm+6UIOJPyP2jPviBVMb/li/DoyV9VqyT/GM
         ROp1/iIkTb6ojFnQfXkalxUKFLVlfycEXOgchpsiP5wrvt8tehA2qSQndHjC2lAcBveT
         GsclUTf9GW87ZBQq9qXtvzpRQm4eIFvkuCCTkRb15CnQlQNTVVWS6Ra4fmV2zWM7Gu3V
         IEHITf6vj9Lscj3948kuyoOZPEtmkrq8oAsKIctW9hdVq5ge58MI+GPEACWjF+bM4bQB
         KI1YseXSowhwYnyhKavIKa6ShRyTV4SuKGuWaCpjCXpWRUHz/QwCjSF67yjT8l4w+5St
         f9Qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785519807; x=1786124607;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=1UShLu2XAyp0HMfPRBtJeGRma6VyLOwcTOhhY/6Zp8s=;
        b=Q5AuJeCA+RyxO92Gxo90EteMsb4f8JiOrRYQzbqbw3ls8/6hML+5S/rCTIzJsSyZy5
         PcL+GFLXZrKy/vd1dKFIlK2qh2LWKg5+RBb5gLWhxtrVXjfwwnJRGAG+Lg/TDg7Kseo1
         l/dCgVA2QIcrqAS2SyAfkRBIUaQVeAl6cpX+vXk6PwEEojfRiDK7V42rqjvfN4P7Iz/w
         ME2laIzE9ESLX9j1xjv+JR5a8p69QukdOXtD1N49vx2NbOBRjOoove0TdTmkZ34nAgmr
         qBaFTA6XcI1CLTXreIXfXl0aVUuRCCROBUma9q1AnE79eyAzouYNfMI4R8j+3BwFpmJ1
         Y3kA==
X-Forwarded-Encrypted: i=1; AHgh+RpTc/iqSO3zSUHPcqlGeMzmbiDzlzOlZj7YvSwlCGtCmkMh+yjawr8fHJovAnYcXR0JX5s=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzdh3Se3+HraH2UmLjKBvwMehwRANQTuyKtwaWMINJY2c7D52jw
	vsM/h5oPYpC2flNfPOmIQ94lPU56b7qBG5sCWDqswVU9CzuM/Nk+gXCK2uvCNWYrrfbaZZRJAYc
	WO8FdchvgvHelJkY0JgDPLCXoY9o6hzwTPiH9EC+/cBExe29/zXFraBwZyfsc5P2giC07Wfrv/U
	pM8FJjYtBdRGOb8xbgDIkGfg5cQZbv
X-Gm-Gg: AR+sD11D3n/u83lHSzjmJKj86NAOLYWGlUCk4mKqGnbif+akHW8faAiFTDcnW95XcEV
	UUKV5rcP9rXcsyehhHyNZfrEMYCTGgNJKXcrMMSXTXrDw5f3s0B67L67jWZEFlC9XRDgC+NxblC
	CO3HcT48kH9QQSnBqyHrEzlPLlTPB2k612Zrsr2C2mcOqiv6xs/k/lNyw1lTfPChQ77t0Gu+upD
	UL4tgvfXpIpum8A5AU1RkatAJQqWtZJZu+des4yMNSClxnZSGcsKEGbDuw=
X-Received: by 2002:a5d:5d88:0:b0:47f:6f89:7dae with SMTP id ffacd0b85a97d-47fd72bbbeemr1145919f8f.6.1785519807040;
        Fri, 31 Jul 2026 10:43:27 -0700 (PDT)
X-Received: by 2002:a5d:5d88:0:b0:47f:6f89:7dae with SMTP id
 ffacd0b85a97d-47fd72bbbeemr1145886f8f.6.1785519806754; Fri, 31 Jul 2026
 10:43:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260731173842.2649391-1-seanjc@google.com> <20260731173842.2649391-6-seanjc@google.com>
In-Reply-To: <20260731173842.2649391-6-seanjc@google.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Fri, 31 Jul 2026 19:43:09 +0200
X-Gm-Features: AUfX_mzJqqj1K0RQEKlb3hZ1wbhgZziil1qXt8sSQ6_a7U8w4N8jpz5bT5Q3XFc
Message-ID: <CABgObfYzNme4UNqaxCKYKMj0ZCKswUizX93QEn2zR2dSzi8wcw@mail.gmail.com>
Subject: Re: [PATCH v2 5/5] MAINTAINERS: Add myself (Sean) as a reviewer in
 the main KVM entry
To: Sean Christopherson <seanjc@google.com>
Cc: David Hildenbrand <david@kernel.org>, kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Yosry Ahmed <yosry@kernel.org>, Ackerley Tng <ackerleytng@google.com>, Marc Zyngier <maz@kernel.org>, 
	Oliver Upton <oupton@kernel.org>, Tianrui Zhao <zhaotianrui@loongson.cn>, 
	Bibo Mao <maobibo@loongson.cn>, Huacai Chen <chenhuacai@kernel.org>, 
	Anup Patel <anup@brainfault.org>, Christian Borntraeger <borntraeger@linux.ibm.com>, 
	Janosch Frank <frankja@linux.ibm.com>, Claudio Imbrenda <imbrenda@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 31, 2026 at 7:39=E2=80=AFPM Sean Christopherson <seanjc@google.=
com> wrote:
>
> Add myself as a reviewer for overall KVM, as I have been helping shepherd
> a decent chunk of the virt/kvm commits into the kernel over the last few
> years, and I expect to continue doing so.  Of the 270 non-merge commits
> that have been made to virt/kvm since v6.6, I have committed 127 (~47%)
> and Paolo has committed 117 (~43.3%), with all but 5 of the remaining 26
> coming from non-KVM folks, e.g. from treewide changes.
>
> Note, this intended to purely be an efficiency and quality of life
> improvement, for both contributors and myself.  There is no implied right
> of succession or anything of the sort.

Acked-by: Paolo Bonzini <pbonzini@redhat.com>

Paolo

