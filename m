Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com [209.85.216.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6783D43030E
	for <kvm@vger.kernel.org>; Mon, 27 Jul 2026 17:25:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785173140; cv=none; b=Ey4e+YvXyKTCq4gnswSgaDNYubJ5WL2Yt22aULs3wPbH6kBpDHAUsQ2LuEaimJTUC5U9B8eMEPNlNWfU46M+EGAW9Ayggv8Y7z/hj8t2bijrb7a0oeMH0jiErEPu/Xk8E7XRIW7wBhcFqh13OFHQlf7FQWND9BXRMBnnwBd56Os=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785173140; c=relaxed/simple;
	bh=YNik/2kAFKnD2XU6/6tGAxyI6N2IY7/nfpf7BnctEv8=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=YYlqcjoP2v/Iio2ej1KWWnXh4vZv8XIF/D2+680IHIXptDlF/60VFdpZbi2a97Gna3uuaz+7mHhI2OtpratBMtRk3r8LczNveU2yLtfO8MFcsdSspOwIxmdz6WyOAlfttDedd2FYFW8zJnA8M8AfPYGfsFwnhztTpsvbbUTAoKw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ILyGdY/V; arc=none smtp.client-ip=209.85.216.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ILyGdY/V"
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-38ec0f510a9so7431881a91.2
        for <kvm@vger.kernel.org>; Mon, 27 Jul 2026 10:25:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1785173131; x=1785777931; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=PpatV9FqL7ZNUKotJnKpSjIDLMSpQzbVaOxRBxvStwM=;
        b=ILyGdY/V127AABJT21rGnEMkgYvfJBeC7mvMAJpGPbYc9nXYgaqdpJkbuUpc/oAHn2
         Ex2cY6CHr2mp4oZWaQK7m6djFD/8fsJWtDyT3tChLBPZ7IHzV4kz1sM3bxl9jC1u10jZ
         5s6JxYUcE/eHWlQ29e9vTqfs+y6wUtali2ttcnTpeCLSdKTJOfkAMvlv1/244J4UZGTW
         OcY4pRGo6UlKjUx64vJXoqdRBgW/C327T7f6RhisQtAFz38XKo8blIp/MmZc9AoH3Z8Z
         4iwoHN6TWxxc2iRDBcGrTv+IBv1eTGfd4/2hkXLxWgSlgQwgAeHe4ShQHfFtNr2FD/uO
         5sRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785173131; x=1785777931;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=PpatV9FqL7ZNUKotJnKpSjIDLMSpQzbVaOxRBxvStwM=;
        b=Q/J05Cjrwale9XbVbrqGQ6WVyvOzcWSMF5ximrCz7Fpqvqz9W8HIozttuqZwYRwzJz
         3cacONVlYsB5THjLtmhfnFd/Sib6zKiGuxTQ4fRpLK4QiRjvgQBvGwnGX28RFDqVWbPv
         PamqzL1ut/0HMOnI7D0m19HCEpke/UJjlIgq0xPH3PFZ4ZC5Gzs2CKe1HJSb+ltJYrp2
         vrSA5FzbVdsFVcd56EKeiRFyJoehvN/8htGig8LAmUmUz5CqsZgxMQcwI8J4mGxnAgTE
         KMmMwy98/4vf4CkZl6s9OvlFAuIGU80mUvm+NWG6Lz1AyWYezy2D1DOqlnb9ol42q2eg
         tU7Q==
X-Forwarded-Encrypted: i=1; AHgh+Ro+P3EHVX3vfvXnwY5a+XtL1V5AG64rMmfAQolB8q7uu4qEUKart6SvetDxixKcl1Ti6Oc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzY9dB8tfdBEPvlg8xgvcgZW4hdgM9ZSbXHrgAM9ZnXAxaAMCXw
	zZNDpVxcJUk9V1BTLpNweMUO5lwYAMbObwumuo5V6cpu0MeLXsUff1qHIbOiB8HQ9O7bE9kZfhm
	q3T0u4Q==
X-Received: from pjbqx13.prod.google.com ([2002:a17:90b:3e4d:b0:383:7b51:b1cd])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:3904:b0:38e:6f90:eabd
 with SMTP id 98e67ed59e1d1-38f293cf251mr8744135a91.5.1785173130813; Mon, 27
 Jul 2026 10:25:30 -0700 (PDT)
Date: Mon, 27 Jul 2026 10:25:30 -0700
In-Reply-To: <CAO9qdTH7LCO-N9brn95fq49muA5Ud=kixJUYC4pwDJ9eL-qE7A@mail.gmail.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260520111325.693807-1-aha310510@gmail.com> <aj2hi-NcqUUCaoQF@google.com>
 <CAO9qdTH7LCO-N9brn95fq49muA5Ud=kixJUYC4pwDJ9eL-qE7A@mail.gmail.com>
Message-ID: <ameUih-zuAoR_pnC@google.com>
Subject: Re: [PATCH] KVM: pfncache: track HVA invalidations for HVA-based caches
From: Sean Christopherson <seanjc@google.com>
To: Jeongjun Park <aha310510@gmail.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, David Woodhouse <dwmw@amazon.co.uk>, 
	Paul Durrant <pdurrant@amazon.com>, kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzbot+0948c82180d475ad24e2@syzkaller.appspotmail.com
Content-Type: text/plain; charset="us-ascii"

On Mon, Jul 27, 2026, Jeongjun Park wrote:
> Hi,
> 
> Sean Christopherson <seanjc@google.com> wrote:
> >
> > On Wed, May 20, 2026, Jeongjun Park wrote:
> > > HVA-based gfn_to_pfn caches are not necessarily backed by a KVM memslot.
> > > When an MMU notifier invalidation targets such an HVA, KVM's global
> [....]
> > >
> > > Reported-by: syzbot+0948c82180d475ad24e2@syzkaller.appspotmail.com
> > > Closes: https://lore.kernel.org/all/6a0c5f2c.a00a0220.2c7954.0000.GAE@google.com
> >
> > Given that there's no reproducer, how did you test this?
> >
> 
> For some unknown reason, repro was not generated in syzbot, so I analyzed
> the KASAN logs separately to predict a sequence similar to the race
> sequence you suggested, and then wrote the repro code myself to test it.

Can you provide the reproducer?  That would be super helpful for reviewing and
iterating on this fix, and probably as a regression test for future changes as
well.

Thanks!
