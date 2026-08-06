Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 861063B6C15
	for <kvm@vger.kernel.org>; Thu,  6 Aug 2026 13:53:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786024396; cv=none; b=ltVKdi9n8AfoLNWXBKnrR5si7okZc16OefyPHSUR2UZj36rAw8l1nDRrigLOpzDcCxChoRypfbkRHc+98tgG9Jbs/Gr0CngXiKaVcs8yOJiRC8RMzTAJUJ8U31psLfXPSeMteUxTNUMUCrFU7rxpedWQQy+yg3r/haQ4ietdxVw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786024396; c=relaxed/simple;
	bh=m2qiwyT0gBlgrPaEvfZGXkwH8PZ+oMXWE+y7LnPQMIc=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=l8J7k/Mk5IQhcKp4DaBL+JFVcbhk23brbE+cS67KFQNPMpa5RCtoKDZkPEuYAW/IxLmI4c+jboopCpIFb6mCmdUwMp9A+5cT4+ZYbwRg/aR8pT6L/kygv/g/AIpploGG+2e89RaRXrcsiLKIF32u088nYuJ2qQ4lSXyA/Z5BaDE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=d11aICYu; arc=none smtp.client-ip=209.85.214.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="d11aICYu"
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-2cacd6d37edso28533085ad.0
        for <kvm@vger.kernel.org>; Thu, 06 Aug 2026 06:53:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1786024394; x=1786629194; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=KurGLp5j0TRPb0GM1o+RkfUsTRyZPXyOf0pcclYokSw=;
        b=d11aICYu7WC3NMAQesLKIyF3pFUcsgX5lOPiMsGAGsrIIYHz0V1+gOXIwZ/X0waLvA
         f87YmyDWxFvRnj+f4OQ2OJC3E5GH+YkEOATcXe84KaKw8fGoDsvM48GDYOSPHe5AJod9
         +MZAI/m1Wjtb8deX3teBA2S1ezrZXZ1p31aH3yDokfNEiXF2jVudJ/3OXwx/bU5q4eBC
         aEIUZQiiJmft0gXdsblwvIav63zYdcilCdXryd8S4zBn8DrcI4iz7YDQMx/J8IJdrI+y
         tW6N18k6RsLV9zLS8p0RuLWa7chCxFOrvW8OO5mH5d4H5fkqeAGLcBfS/TYJrDsbAhY/
         ceAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786024394; x=1786629194;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=KurGLp5j0TRPb0GM1o+RkfUsTRyZPXyOf0pcclYokSw=;
        b=JxLeXi85VvmWtnwoHen10Vj//dfVUxYvO7NNrFfej3sMpSnlTmGFwGW9YinvVE66ib
         xj24pYzZK/+r/9GYwwCkkRlNeldjPJi3PYyCurU713NAYdfudxL9PuxVxc9c1a2lKYOy
         4tlUhTnMnOFXw9pPXnvqXxahXCuKRai2UP4SLxNcupE0OBZa8mKmIs4uTEXzHE92A2PO
         ihIoqPnQknilDDYPI01Nof4NXqWh+TSWy31iN5tt/mXXqe//6LzSNIOqKeum2Au+Z3JO
         oHdpyvn4S1wcvSarchQ4P82v4p5894Ut7IN0+E0IUS0I/SjNTh6M4mtFQLtXb30BHOOd
         6fRQ==
X-Forwarded-Encrypted: i=1; AHgh+Rr5BJ7Zct3PIezSELP45rWBrPMk/Gs81xrh5nBwLkvQ03znq1kLDOmuRnMF/wYXAV0XwX0=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywe8ioOwk1eKHiv+Zj9YzfZpuKXGUgK+50j/O1jJBMfNZuOc5CS
	7N9cM6ROlDmocX9Ao46IDoiJQsfWGVuIFCogVf+YO0zQJ65QAexe6AHgdVv26B6LdC5gbyqjNrP
	nRisKuQ==
X-Received: from plao6.prod.google.com ([2002:a17:903:3006:b0:2ca:da0a:7296])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:ebc5:b0:2cf:906c:7d1
 with SMTP id d9443c01a7336-2d0ca946776mr183858535ad.20.1786024393599; Thu, 06
 Aug 2026 06:53:13 -0700 (PDT)
Date: Thu, 6 Aug 2026 06:53:12 -0700
In-Reply-To: <anSMBpQJ8x-vXYy2@sgarzare-redhat>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260723153310.745855-1-andrey.drobyshev@virtuozzo.com> <anSMBpQJ8x-vXYy2@sgarzare-redhat>
Message-ID: <anSRyFTNGC-XcFM1@google.com>
Subject: Re: [PATCH] vhost: clear vq->worker under vq->mutex when freeing workers
From: Sean Christopherson <seanjc@google.com>
To: Stefano Garzarella <sgarzare@redhat.com>
Cc: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>, linux-kernel@vger.kernel.org, 
	kvm@vger.kernel.org, virtualization@lists.linux.dev, netdev@vger.kernel.org, 
	mst@redhat.com, stefanha@redhat.com, jasowangio@gmail.com, 
	eperezma@redhat.com
Content-Type: text/plain; charset="us-ascii"

On Thu, Aug 06, 2026, Stefano Garzarella wrote:
> On Thu, Jul 23, 2026 at 06:33:10PM +0300, Andrey Drobyshev wrote:
> > The effect is harmless in practice, as this only happens while the
> > owning process (and thus the whole device) is dying, but the lockless
> > write is inconsistent with the rest of the code.  Clear vq->worker under
> > vq->mutex, like everyone else, so that all writers of vq->worker follow
> > the same locking rule.
> > 
> > This issue was found by Sashiko AI review.
> 
> Can you share a link to the review?
> 
> I don't know if it's common or not, but having the link in the commit or
> after --- will help the reviewers.

+1.  FWIW, I've been using and encouraging the "standard" Reported-by+Closes, e.g.

    Reported-by: Sashiko Bot <sashiko-bot@kernel.org>
    Closes: https://lore.kernel.org/all/20260625212001.3B6561F000E9@smtp.kernel.org
