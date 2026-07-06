Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C0E9434E2D
	for <kvm@vger.kernel.org>; Mon,  6 Jul 2026 22:26:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783376815; cv=none; b=NdJw429bfZnwTtiAXYapwzUbgEp89mvd09F9gfFAoUkg15cWVx7+TeIPmvM2ik1bYQicbSSNTTQxOquQOBgsGItgC1IqpM1zXiZlc3CWct8UB11rQbWg2v9oFZZ8xYk8o+497qGM2me0umGTX9dG3FdIdeuEZV3/g+cvmaDjrs0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783376815; c=relaxed/simple;
	bh=uT4QDVdOjCcaU39WrLhXPDiRU4uMK9+UDDLgXkn2LQo=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=FfkNUxpQOhRssR4QGB6fbFijGai5nOdysfi3RvVHq+pfLJsFpLa+EezTBihBOnuZmuHBHMrdQDBBfw6ppvhNioa9VCxT2W/V4S2qXoeXH92SAZtiIzYsRz9agXrrhwe8SlNRuBi+T4hdtuUkvNNn1gPDtuMrnF+yJZR8ag0eUTk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=hJZhQ4+R; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="hJZhQ4+R"
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-2cc6dd43737so51184565ad.2
        for <kvm@vger.kernel.org>; Mon, 06 Jul 2026 15:26:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1783376812; x=1783981612; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=wJCpc8BzZr2s/adrZrnFsb3LPXSuLc1ySnbVabaHnns=;
        b=hJZhQ4+RVVx5y7WlVGoKMXrAy0w4f+LKxVP7We4w+k8kKH57NJ1GHIOZ+wLYnCPPPk
         pcua/DgqOKKgsCmclq2zCIdpTIuR2W3AnvRTA6Id+q5+h95fcK0+Qf4wmc182/8nGv9G
         PbUwkJGPnd/24H6kujIkgKINGS+X6Okrs9S3jZ6SziYBj2OFtNfPPsSufulApJdlGd8U
         DYtXvjpik9veoU4BNYBLp0M5YOgW1c3DE3thqyFVzV+IJiiMGpQmTSJbpeyjOhaceFpI
         LzhcrDYydZMeB8I4niApEjGBiYgLcwF2jbD9lEpTjORc0zgxI1uxfKxzw8UOKJlfj5/v
         mcXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783376812; x=1783981612;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wJCpc8BzZr2s/adrZrnFsb3LPXSuLc1ySnbVabaHnns=;
        b=nfMJH1JIQfILin7dGsFURY5Jc21Ewu8YTDPGVYFuXSWKwt571yf82zqIEQ83AaiPcE
         xcFSXwPobpZnbDK4DlWppWFjj+yPGMmN1Xb2T2o/DuyKsxEHBThRrGtZcshGgGYvt41I
         8t2uc4k0IwU+glNuBiGYx66u4joeYdbcF6bh4Rtod9ASouGEdciSFdyR2Oq/dhv9U/V/
         AMN3HHpHMf1yblIv+adqSNm69Y/7nfCOZqe4fHw3XocKuUDU1oxlSeuTNVB5eLNjlOyG
         Xze/GIFsDYL/nT819CktBpAjmzrndGdCEntd1scx39Dd8kv9TvoICHKAEkpo/6nb+LBZ
         8pJQ==
X-Forwarded-Encrypted: i=1; AHgh+RrQVixi0cSJQr6ZD90JJcX4X8SoLwzTjnqvL71oiLPVlp76Ii+1V+szfa5sZIq5NRHJ1cw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyhs0qEpKvE1gbksHe9cOojVqJBeOPzXZDDE0Mm30CW8cLn6v31
	RZcIgERAKZZ9+ag3qL2HwTFhErFZnsVGguE262zEtoJZZiWUdsatjBUUaPHDBlobfc7wva1UCpU
	YehinMA==
X-Received: from plbiy8.prod.google.com ([2002:a17:903:1308:b0:2c1:220c:ccc1])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:38cf:b0:2ca:6eca:492f
 with SMTP id d9443c01a7336-2ccbeb13b46mr26453985ad.14.1783376811535; Mon, 06
 Jul 2026 15:26:51 -0700 (PDT)
Date: Mon, 6 Jul 2026 15:26:50 -0700
In-Reply-To: <20260706094037.104AA1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260706092021.3625908-2-twiederh@redhat.com> <20260706092021.3625908-5-twiederh@redhat.com>
 <20260706094037.104AA1F000E9@smtp.kernel.org>
Message-ID: <akwrqg9Y5FPevRqU@google.com>
Subject: Re: [PATCH 3/4] KVM: x86: Reject KVM_CREATE_IRQCHIP if APIC base is
 already mapped
From: Sean Christopherson <seanjc@google.com>
To: sashiko-reviews@lists.linux.dev
Cc: Tim Wiederhake <twiederh@redhat.com>, kvm@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"

On Mon, Jul 06, 2026, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> - [High] Calling `gfn_to_memslot()` in `KVM_CREATE_IRQCHIP` without holding the SRCU read lock (`kvm->srcu`) or the memslots update lock (`kvm->slots_lock`) leads to a Use-After-Free and triggers a lockdep warning.
> --
> 
> commit 69e98e42c78858b7858a1956e233c569faf47ae1
> Author: Tim Wiederhake <twiederh@redhat.com>
> 
> KVM: x86: Reject KVM_CREATE_IRQCHIP if APIC base is already mapped
> 
> User space must not map guest memory that covers the default APIC base
> address when using an in-kernel irqchip. This commit adds an explicit
> check to KVM_CREATE_IRQCHIP so the conflict is reported at the point
> where the constraint takes effect.
> 
> > diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
> > --- a/arch/x86/kvm/x86.c
> > +++ b/arch/x86/kvm/x86.c
> [ ... ]
> > @@ -4413,6 +4413,10 @@ int kvm_arch_vm_ioctl(struct file *filp, unsigned int ioctl, unsigned long arg)
> >  		if (kvm->created_vcpus)
> >  			goto create_irqchip_unlock;
> >  
> > +		r = -EEXIST;
> > +		if (gfn_to_memslot(kvm, gpa_to_gfn(APIC_DEFAULT_PHYS_BASE)))

kvm_is_gpa_in_memslot() is what you want.
