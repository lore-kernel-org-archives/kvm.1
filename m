Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 735E93644A0
	for <kvm@vger.kernel.org>; Mon, 23 Mar 2026 07:53:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=170.10.133.124
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774252432; cv=pass; b=pevH4k9q149t3mR+Bd4eemUO5zpSQFjUvgU3cMZt6MUvIy+SsNy8HukZSbgSHEM1VnVfHpVhnLTrb+Bl95YfeAo98UmoguZh9YwLBk9xGI0kI+lZgVggrOoxR38ykK4PAwEUwoHGGPv4xaJ3eXdurwybTcb0S2sZMt70Sv9+drY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774252432; c=relaxed/simple;
	bh=ZyPnZQkWGjsr4fVqWZicnEtV8egGF1NxpaFkdjbB1rE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=skxUj42BSfYBdReAjAZpUdsR20gfR6E05LzIqN6u6R6Yv8mvcumM6fGcr9Q45D04ZV9jNTqOlRU1+ic9UVs+eRkUDLxbs3WB4m5ODMvOdZnZ742IVjbiHQ62N3foWeUu4tHRJnAAI3iJk2DpCiL9spUmrRjU9LajOAbYs2q2x2o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=UtYCimR2; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=cq5pZdvf; arc=pass smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UtYCimR2";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="cq5pZdvf"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1774252429;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ZyPnZQkWGjsr4fVqWZicnEtV8egGF1NxpaFkdjbB1rE=;
	b=UtYCimR2EDRI4URcABe+18mhr4dmy805xkPe5WqjnWwrB5ilBIOIPAsT8rWU6nnDlJMIe0
	UIXRDbKSlQvFSoYdcYbR+Dr4knxqqUD0h822WE1BMlwAk4EFkQQMawwn094w+nF4opQA1o
	pKYPPwW7MeFdk4JMFXE6vDAIUK5fuYs=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-532-C5cr8zcSNii1ET3HaFnAzA-1; Mon, 23 Mar 2026 03:53:46 -0400
X-MC-Unique: C5cr8zcSNii1ET3HaFnAzA-1
X-Mimecast-MFC-AGG-ID: C5cr8zcSNii1ET3HaFnAzA_1774252425
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-43b41d45be4so3610402f8f.0
        for <kvm@vger.kernel.org>; Mon, 23 Mar 2026 00:53:46 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774252425; cv=none;
        d=google.com; s=arc-20240605;
        b=KdkMhp50txJ8UodGUDDv3PQwSi0EK7Fjq10uppZ0FNMjCOVolXLrzxJDdLiHRGySzz
         CpgUKS3UlvWlqlJ6f53NP9s6OnfZotcHy9b9XP7uP4qbBu1Y3zH0mWoGUqzLq6hy1rAt
         QBrAsl59ZsiEMBhweA0uMZW1Ep1PmucS4REDoIYY3quwJDrloroX4S4ZfSszBBeryHTD
         sEQOJ917ld9vctAtlLf0BtjdqEKKC5/HM6nztI0scGpZhbbF7alKCfVWsU1FCvVqdbA3
         KTnFrPACCnqVKRv7PCtK2nb0eZ3nYjr1wHdCynkdP39O1ew5EV7Qy9eFNlwdgy2/a/Mv
         OxNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=ZyPnZQkWGjsr4fVqWZicnEtV8egGF1NxpaFkdjbB1rE=;
        fh=Aokfq+y5tx47TFIqDdTYLs3uJmMHSNFgNE2h11rs0Do=;
        b=Z122YeZEFL93fR8UtJDuUl9BcxTkWY/YZdubmQnCjCdcaolHu8FAR2K6Fk/I3+zIFs
         hert2Fmbx0qm/7dnAQVgpWlM41D3UAdoJfqCNgLZgU3wZfW4KhMoae7qNWLUFN34MBcB
         /ZCMQPSdAySHZZX+HUFRlmqd2V0F4cjfJcJq9nsOFIGtreppazvrBsYyU2anuj6vuQmv
         185WE8gFtkUgHAEnnILPJXuWfFdjpayCKfxiGGilZsq5jceKa7Kfj+G+FUBusuyMWlF8
         PjkIWvsUF5bsRXCQHHUVLdB/8egUDfvZQyzwcihuGQnSryxF/L6iTdgYKCFiyW7a5KTH
         2WJQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1774252425; x=1774857225; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=ZyPnZQkWGjsr4fVqWZicnEtV8egGF1NxpaFkdjbB1rE=;
        b=cq5pZdvfmQAzpbDMxZdnFFbl2EBhMbNbAFHSGDwDSIUwgg2Gj0aNs9GRe793Q/jvDD
         1ryVHliv0nS1B0PfFibaeum1bd9p382I5Dnkm/+kLxHBIe8X8F+lGAndLnkeeoDow7ZT
         DUKWSPyAQhLQBnQzM0AiMEtgReN1UKc6ZOMV7x/ftlS/zv9IlBfROsXz9IQ+xVp7FyCq
         rDyplIT6pq2xIJHRtdLu++HdxpxQOGATbDK95grbqf1RnKAqXN0OW1yuXu7FPKRHoXNF
         Vr1/0Lu1w3+eIXh4ExMHjzdk6kjCypu/aFnxNpL4BXJNA+a3VkKLB8Gq9X3UAroj9atp
         AY6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774252425; x=1774857225;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZyPnZQkWGjsr4fVqWZicnEtV8egGF1NxpaFkdjbB1rE=;
        b=gKJ+K9n78JHYTR3KoLRz8bsMXblr7c9uZEcOw8v8DuFUF+SeWiNxv8lxRdeJ/DDznU
         WHOc+B6utABH8XZBvACvJKOp75YzTY7ggAcvQZ65OKmmHUySgFQUQK3w7fAwEOJUUXq3
         fj1EasUVGNEg22kpU0GC9P1ztUMN8YmTlYtTSN6fcdapbLR7gdp6c29VdL+WlFPNBC03
         OZFg6BPJL2+xG7HsegA3or2AgWNsCxWqag3PIt99swAwdY6kSLhd22NlAfiMuqKcVaYf
         WXKL/wop58QIjL+zr0AUakykC8mJEnmk0seBhkyTxNHOQtdfC8yDDUEG3K0nz1py3ZlJ
         k0kw==
X-Forwarded-Encrypted: i=1; AJvYcCWkCn1/Z8ekjbOmrCl/rhR1EaBWD1XyeBLAN5y1sH1Oke9fog/8waWpSfnv9kfMQtbST58=@vger.kernel.org
X-Gm-Message-State: AOJu0YzucjPK/SGTj/vQAPavpOIvXuh5aliaSK2w1bqadX49TG88/WNK
	xQB71MJIWLm8GxKgkrEwQtyjbb1xbil5ZNoorJElWEcjIAnemlcwgakY0v9WszrIhDv3v3n7bk3
	Wg7RXOP2ZRrW9S2lM4Zn9P0x9Zr8Skm7hMuErprPkV9ps5qJGJeUCxJ74UTyME25P7eGUQUSemy
	70sQZMGPd22TmRA25HN4C7/TaKqbL1
X-Gm-Gg: ATEYQzz4zfoAlfZGAnAgGRNrbi/Sg08G350TYNuO/wykFN9f+DzFaaUfZPgdWf+WWup
	8PLNnBjdig/XvxCdefT2bVBQkC92cOw1SW7NSPK1Sx2wsUFUVwO2eBvukauRHUnDudCiA4rzRNx
	UobCj764AsViCak609+QOZEmDN1VCIKr2Dz51ipHgQba/hyUjBlTMFcoibG8rCbw8PS2pY4ra06
	ResMr3XKUcytAuQ2nAiL7Fo7BVFz0qrveE8POVj9kg9kH2dYG3HE0Xq8anklIpe0JLL7f3KmXJV
	L/yW
X-Received: by 2002:a5d:5e83:0:b0:43b:4166:b855 with SMTP id ffacd0b85a97d-43b57723457mr23557138f8f.14.1774252425488;
        Mon, 23 Mar 2026 00:53:45 -0700 (PDT)
X-Received: by 2002:a5d:5e83:0:b0:43b:4166:b855 with SMTP id
 ffacd0b85a97d-43b57723457mr23557113f8f.14.1774252425082; Mon, 23 Mar 2026
 00:53:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260321000931.1947084-1-pbonzini@redhat.com> <20260321000931.1947084-19-pbonzini@redhat.com>
 <20260321115826.GCab6H4lNYIih_g0B0@fat_crate.local> <CABgObfbGxJYO0iXvkduFR=q=gyoF819pwkgJSke7SLr+6zCVZg@mail.gmail.com>
 <20260321154219.GEab68W-ln67dqTB5x@fat_crate.local>
In-Reply-To: <20260321154219.GEab68W-ln67dqTB5x@fat_crate.local>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Mon, 23 Mar 2026 08:53:32 +0100
X-Gm-Features: AQROBzB3RJ1xXhK6-ToBkRLjZBBDsSzBWR-5VUMLD3Ty58qEBRyQYPBJx3CHEd0
Message-ID: <CABgObfYHtUJtw4pykQ=cw3aJrc_KneG92GgG0dyaXhhKw4qHSQ@mail.gmail.com>
Subject: Re: [PATCH 18/22] KVM: SVM: add GMET bit definitions
To: Borislav Petkov <bp@alien8.de>
Cc: "Kernel Mailing List, Linux" <linux-kernel@vger.kernel.org>, kvm <kvm@vger.kernel.org>, 
	Jon Kohler <jon@nutanix.com>, Marcelo Tosatti <mtosatti@redhat.com>, 
	Nikunj A Dadhania <nikunj@amd.com>, Amit Shah <amit.shah@amd.com>, 
	Sean Christopherson <seanjc@google.com>
Content-Type: text/plain; charset="UTF-8"

Il sab 21 mar 2026, 16:42 Borislav Petkov <bp@alien8.de> ha scritto:
>
> On Sat, Mar 21, 2026 at 02:51:47PM +0100, Paolo Bonzini wrote:
> > I prefer to be consistent with all the other ones in word 15.
>
> Sorry, no, /proc/cpuinfo is an ABI.

I am not sure what you mean by ABI in this context, maybe "there are
rules for whether to add stuff to cpuinfo.rst"? If so, GMET matches
what cpuinfo.rst says:

* the kernel knows about the feature enough to have an X86_FEATURE bit
* the kernel supports it and is currently making it available to userspace
* the hardware supports it.

The bullet that applies here is the second from the above list: 1)
this series makes the feature available for userspace and guests to
use it, 2) that requires explicit support, it's not just a bunch of
new instructions.

I agree that not all word 15 features should be added to
/proc/cpuinfo, if that's what you meant by referencing cpuinfo.rst.
For example these days something like AVIC would not be added to
/proc/cpuinfo because it's transparent to userspace and guests.

Paolo

