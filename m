Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D63962F0C48
	for <kvm@vger.kernel.org>; Mon, 17 Aug 2026 14:37:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786977455; cv=none; b=FISKn76jka6nowVlrzGGqMtOMsfcNC/iKeK59SX5q5WnIcqrzwN9rcDAj7TabR4uhyEKuYVreB+ajPxw/tS6YxZI4WYHNcSfhe6imUzXlsBiA40kLsbZHV7KM4CtNfXR9dCvlQ5D8L9x0iiiRq7u5CkBGY3Zq76JM8f+pZKK9ho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786977455; c=relaxed/simple;
	bh=lerb0gKuqV7hyiHwD7tAixcPyrYjaXEE+RDGLUvUXEo=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=fU5LCLJyPH/HWkXuL65X32Ey/8CQOUv56FgVfILeCbqjYRwWWEsA474I+qRejC7qtzaN0262Hu3TRSdPpA3qso8itZsdlDotD4ly8CqL1Y/nF76RHjVHrIkqPCKcX6KKHd6+RxoWn1JyxCfZnWNtg2av5OMqqEb8h0rqpZaTS6s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ts+1GB3A; arc=none smtp.client-ip=209.85.214.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ts+1GB3A"
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-2ccd1958e8fso55598285ad.2
        for <kvm@vger.kernel.org>; Mon, 17 Aug 2026 07:37:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1786977451; x=1787582251; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=xbnAp7y/AgCt9+7CBSjoILDuat4y2Kbyd9OVnJGDiZs=;
        b=ts+1GB3AGdgTNHtaG3eA7hS1Dy7WztPkLYICC+LAGAIhZAIWlkhcVYSptrESkFnBQR
         aJVlcIdgRkFxM5f82E1Vq0PU9ceXSOtWn7NxQdN9Fvg9dnV1eZx1gFUDhSrfVKZIxviE
         5tHEQCX8jnAv/PSg1grT3rb3CbiMVQOlXJtiTONQMT3W7XJhW6/1037x8REPOFtOknqR
         IVu4P5c/BvAy984Ureu8X/GxP//iEei384gFFSsH4/oimp6MtM9WQrJoFW66e2NmR3Bv
         LvAXjdZxXnMy7j+GZC0Cch8+DmOWf1+oZlZvxQ+gMmNmMTJ3+KHLVcOd+LNjbtI/GFux
         xcdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786977451; x=1787582251;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=xbnAp7y/AgCt9+7CBSjoILDuat4y2Kbyd9OVnJGDiZs=;
        b=dry69OVaWYNgRBFRbDE9QaLoZg8gsw6f/BfCOJfuOjG1oJ0y+5Q2Dx7/XmgIFppi4n
         0vthTR6m4W0tzTtScrL/6+F1WEwd2i6E5581u3K+Vn/v+8At6Ea2WUkp7CTg1gzHdmHG
         Ad0v4nf+8dKJOK7ic11/7Xhs5A941vkwxlGi0bmc19jruam2J5McuVfd2NqwY1cVFTc3
         eNBx7X2bZKA/anhVZdLj/NueCaL7kD/MWUTWUzSO7m6hmBnmcL+NQRoblNFX95LtmwXZ
         Ljavkg9XAVyjZ/trVX9RXDXCpSmE1AIWQJbpCZ9Mw/80hVppYU7szaYPCx9TG5SV29vg
         WrhQ==
X-Forwarded-Encrypted: i=1; AHgh+RoItE2ZSD3CfcOdnhHOcAh1WGQUfno4dsrpdlIVTQVpLVgmeRPkRBJsWX4mlCnb/Aynces=@vger.kernel.org
X-Gm-Message-State: AOJu0YzBEsron80UWQdhpCMkjQwmWFOqB714yL9+3m9PwjRp9XzMqXyb
	z2Oc9T2k8zxqzGjeFRLsu2IRZ8liYFW+B+jZNZjm4snhcDCqD80hO4rSlv1b5zQL4KLgrV/ry7R
	GkUWD+Q==
X-Received: from plbmo3.prod.google.com ([2002:a17:903:a83:b0:2c7:702a:36a4])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:b0b:b0:2cf:9347:f445
 with SMTP id d9443c01a7336-2d3b0c7ae46mr283430775ad.10.1786977451095; Mon, 17
 Aug 2026 07:37:31 -0700 (PDT)
Date: Mon, 17 Aug 2026 07:37:30 -0700
In-Reply-To: <2vxzqzjz1x5f.fsf@kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260728121138.1103610-1-tarunsahu@google.com>
 <20260728121138.1103610-6-tarunsahu@google.com> <anphyjFv3FhF61iB@google.com>
 <2vxzpkzo51wg.fsf@kernel.org> <anssOQFNZ2LfihbU@google.com>
 <2vxzik5f311e.fsf@kernel.org> <anyObKiZIhfok5mk@google.com> <2vxzqzjz1x5f.fsf@kernel.org>
Message-ID: <aoMcqp0gr06YXAPU@google.com>
Subject: Re: [PATCH v4 05/11] KVM: LUO: Support VM preservation across live updates
From: Sean Christopherson <seanjc@google.com>
To: Pratyush Yadav <pratyush@kernel.org>
Cc: Tarun Sahu <tarunsahu@google.com>, ackerleytng@google.com, fuad.tabba@linux.dev, 
	Andrew Morton <akpm@linux-foundation.org>, dmatlack@google.com, 
	Shuah Khan <skhan@linuxfoundation.org>, Jonathan Corbet <corbet@lwn.net>, david@redhat.com, 
	Pasha Tatashin <pasha.tatashin@soleen.com>, sagis@google.com, 
	Paolo Bonzini <pbonzini@redhat.com>, Mike Rapoport <rppt@kernel.org>, Alexander Graf <graf@amazon.com>, 
	linux-kselftest@vger.kernel.org, andre.przywara@arm.com, michael.roth@amd.com, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, will@kernel.org, 
	vannapurve@google.com, maz@kernel.org, fvdl@google.com, kvm@vger.kernel.org, 
	oliver.upton@linux.dev, kvmarm@lists.linux.dev, alexandru.elisei@arm.com, 
	skhawaja@google.com, aneesh.kumar@kernel.org, linux-doc@vger.kernel.org, 
	David Hildenbrand <david@kernel.org>, yan.y.zhao@intel.com, kexec@lists.infradead.org, 
	suzuki.poulose@arm.com
Content-Type: text/plain; charset="us-ascii"

On Sat, Aug 15, 2026, Pratyush Yadav wrote:
> On Wed, Aug 12 2026, Sean Christopherson wrote:
> > On Wed, Aug 12, 2026, Pratyush Yadav wrote:
> >> This is ABI between kernels. It needs to be stable-ish so you can move
> >> from one kernel version to another. At the same time, unlike userspace
> >> ABI, it can change.
> >
> > Uh, yeah, so KVM has been managing such immutable ABI for practically its entire
> > existence.  KVM's save/restore uAPI has exactly what you're describing: serialization
> > ABI that needs to be backwards and forwards compatible between different kernels
> > in order to support both upgrade and rollback scenarios via live migration.
> 
> I think there is a slight difference between KVM's save/resture uAPI and
> live update's ABI. With KVM's uAPI, you need to maintain strict
> backwards compatibility because userspace reads what you output. So if
> you change the layout, userspace will interpret it wrong and might
> break.
> 
> With live update, the ABI never gets to userspace. It is used to talk
> between kernels directly. So if you do break that, your userspace keeps
> working fine, you just might not be able to live update to the
> incompatible kernel.
> 
> So with live update, we don't need to keep backwards compatibility in
> the ABI forever. Of course, it is good to minimize changes, but we have
> more freedom to change it.

Ah.  So this is the heart of the disconnect.  I very strongly disagree with the
statement that live update doesn't need to support backwards compatibility.  I
can totally believe that the folks working on live update are ok breaking backwards
compatibility because their use cases are "fine" with such breakage.  And I can
also believe live update as an upstream kernel feature being developed by those
same folks is also ok with breaking backwards compatibility.

But with my upstream KVM maintainer hat on, I am not ok with that.  I did not agree
to support a world where KVM is allowed to break backwards compatibility, so long
as it's done "carefully" or whatever.  If y'all want to deal with the resulting
complexity, that's fine by me, but you'll be doing it without KVM.

I totally understand that exploratory work and initial development is best done
in private and/or in a small working groups.  But decisions that will significantly
impact multiple subsystems need to be made *with* those subystems.  I mean,
obviously it's possible to make a decision in a small group and then "publish"
the result later, but then as is happening here, the community and subsystem
maintainers like me may refuse to play ball if they disagree.

To be very clear, for any KVM live update support that doesn't guarantee backwards
compatibility (allowing that bugs happen), a very firm:

NAK
