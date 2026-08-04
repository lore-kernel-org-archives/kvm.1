Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com [209.85.210.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52867456289
	for <kvm@vger.kernel.org>; Tue,  4 Aug 2026 13:11:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785849109; cv=none; b=H3PSR7lw3J8CQfXh04rWBSru8NoeiSXKl23c+Mn4SMxeVBUb1bKoW/rW85Fa4ANNT91yvUa6xItPIRcin9JtRryKh9fw2dWPDYQ0/WjZ/uCybKjJC9wRxrkWgVbmtM/hx3MLl2ou+NR6tZJCKdHcZSoCiUXCkk6VVoZtT02nrJM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785849109; c=relaxed/simple;
	bh=YrEinkZPRNd5kBxtrP/1PM2Vd+ATpjBAdqFtz3OHGGc=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Gn4ZTA8cclOKAyqyhE+nEr43GT9Df6u0PeYIey14/O/IFayZbIECgO1n4S6s1vt5NUrQwyLe94YirqRI39/bnmExIhAWyFxuy+wyInWxKvv7LGDuzC+o3neoQXBRytVP0b54S1CoQsqyqqbJdR8cL1qB/Xua/0MwF13e+53QAoQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=LIQ8PfqD; arc=none smtp.client-ip=209.85.210.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="LIQ8PfqD"
Received: by mail-pf1-f198.google.com with SMTP id d2e1a72fcca58-8484f26852dso5244977b3a.1
        for <kvm@vger.kernel.org>; Tue, 04 Aug 2026 06:11:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1785849105; x=1786453905; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:from:subject
         :message-id:references:mime-version:in-reply-to:date:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=Vbom+WG9P/kNUgNXoWJw3EAsCkR73fS0OX5/NQKix3Y=;
        b=LIQ8PfqDOUqAydbxWyA5nYSOnTozimX0qYvDk81TS4BB043SxKHDv+QjI5BtHsXC28
         EIdUeUl+xtWETdCaXT8drypKVFbz4D+W8phKItuw3RrhptVyvOqWtWwRPo2sPw68NcmQ
         dZO4IJe0h1Xbd9AHhmRIMlRpm+SMZ6Qp/ig15J3PA3aHjnhcivzNb9ENecBmP/Z7O4yE
         h5ijUF+L4J6QHXXAu9ZZMpp+hv39/8/qyoMlOwaXxK3YTIUCaCmmOje0UWAGRgbtzyHz
         6tCz/tg88ORpqnv9uLS/B/iDQmxF4/pOyaiaD8xJ6PeRQgK8kLsryWsVl9pbPElKP799
         IPkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785849105; x=1786453905;
        h=content-transfer-encoding:content-type:cc:to:from:subject
         :message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Vbom+WG9P/kNUgNXoWJw3EAsCkR73fS0OX5/NQKix3Y=;
        b=WSH+8vbcZUufCX9M1nyCB6FaWTinpZii5uu9hq9YX1Bod7jJPvbBvuCfzRgVU43ppn
         hL0ipPnLn+VRyhI6hGzBi/ufdTJHQs+dgbHbopD1zD8L8nsCxX64aWVbr5J9PLfrZgdC
         /ZPuPV0E0UP7pdwOHMhziUY6vWJuvsi29W0MWSqwDaMRB3WkXeWHDhTFUfw7Rnl7FYpG
         BSe1SVANo4HY2/kxFk8y4ymQLO//RO5wtpGNa2yUs4SEIwJOeDuY8CS2tGIiOLD0Qvbn
         z/6GRG0ipOR5BRWofR5d6xvnITE4Eg0RKP5Qso8H+1aO1t9zoApR3v/CTu7VKBJqCFPp
         y3Hw==
X-Forwarded-Encrypted: i=1; AHgh+Rql6JzOyr3urdngJKimYs4b3NZcudxfMwz96ykE0xE04etiV/Tm/0WF+lKH1YZnzIrOvZM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxieoKxWfrGMsSh/6qO5WK6SY5AfGXeCgxrTGUtl3cFCmjxWqma
	A4Y6wpI9AuxmPIhg/j2ZJMlsS2aurTj/eQT+wY1LD9WkL7VENilKKZPZjj+R8USEGKLoCD+cBa7
	OpJnRGg==
X-Received: from pfst41.prod.google.com ([2002:aa7:8fa9:0:b0:845:b9e9:fcd1])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:2887:b0:84e:52d0:69cb
 with SMTP id d2e1a72fcca58-84ee4988987mr13320715b3a.75.1785849104917; Tue, 04
 Aug 2026 06:11:44 -0700 (PDT)
Date: Tue, 4 Aug 2026 06:11:43 -0700
In-Reply-To: <CABgObfYZvs6rZKSk_Ym=L-vxLHY6WLoo2dL3NneabbUqvZxaDQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260731175834.1121005-1-pbonzini@redhat.com> <amztmWhHXUR4zBv1@google.com>
 <CABgObfZ5sPgfJz-_reACs5WkjRRkdNuinfY+nSrdHvG5xSiKUA@mail.gmail.com>
 <anCZoc65i2xXNQgO@google.com> <46663836-fd97-4328-8c7d-5efeeb222ce6@redhat.com>
 <anEYxL8kf0O889S2@google.com> <CABgObfYZvs6rZKSk_Ym=L-vxLHY6WLoo2dL3NneabbUqvZxaDQ@mail.gmail.com>
Message-ID: <anHlD0E0RhIub00d@google.com>
Subject: Re: [PATCH] kvm: apply VM_READ/VM_WRITE checks to all VMA types
From: Sean Christopherson <seanjc@google.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 04, 2026, Paolo Bonzini wrote:
> On Tue, Aug 4, 2026 at 12:40=E2=80=AFAM Sean Christopherson <seanjc@googl=
e.com> wrote:
> > > > But the issue Sashiko reported is just saying that KVM sometimes do=
es what I'm
> > > > saying KVM should do all the time: return -EFAULT.  Or did I misund=
erstand that
> > > > one too? :-)
> > >
> > > Yes, that's correct.  My point is I'd rather not introduce other chan=
ges to
> > > the !VM_WRITE case in stable releases.
> >
> > Yeah, agreed.  But what I don't understand is why this would be sent to=
 stable@
> > in the first place.
>=20
> Because the patch
> https://lore.kernel.org/kvm/20260731160514.1101989-1-pbonzini@redhat.com/=
T/
> needs to be sent to stable@, and this one fixes a problem in that
> other patch. So this one needs to come first.

Oooh, that makes sense.  Thanks for being patient.
