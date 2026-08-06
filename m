Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com [209.85.210.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11B4A3A8741
	for <kvm@vger.kernel.org>; Thu,  6 Aug 2026 01:14:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785978857; cv=none; b=cNwRWBFEGjEN+ADvw8RD6aye6jZxFIGisB6XQmZ2QkUgLHacb4mPqRZHwEjstqm1Fi2V5/kbbtu5jl2Jvzj/NzOsUlkJ1N5/vf+P49QyaSarjdQl5wC0kHqoEGCZ8yBvAo5AlELWB74tugs7XqccVfXRNgoAjY+q7e37tukGZP8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785978857; c=relaxed/simple;
	bh=FnURd9znNvpM1kqH7h6q11jvcJIcgM8HdPz6ZSRX88c=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=idtsJ/O110XntkuUiqUqbU0XHpM/CEo4l9OpubhRQ+AuPBlqYecLDOd6yXZj7v7GhA7duThmfjLVJmFPPSPJrtO5uTLAUOp8FTYP1xfZzpEuS6CQ/ot2QeNEV7VH0ehERENpsa4eNnDSZmvyis70igpCgj62SqobTEAXYOgk0fY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=sYOyrgWI; arc=none smtp.client-ip=209.85.210.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="sYOyrgWI"
Received: by mail-pf1-f197.google.com with SMTP id d2e1a72fcca58-84e1da97175so2207049b3a.0
        for <kvm@vger.kernel.org>; Wed, 05 Aug 2026 18:14:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1785978855; x=1786583655; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=EllBK4pohN2CB4+9rC08wwxbJTVXkdymq5nTAYfElqk=;
        b=sYOyrgWI4BzQCdEdgFFdQmu1RfpPiH9XKuSID1VkZA+l1jy26IbG3vugDJA3y4Q2sc
         2qPrEx3Z6P8Dha4wVJRMskaNIXTzizNoXidkt/mfpvZyJ8aA8eSNpoQBnEbzwtcy5nXh
         sTV9csqek50hQ1edjx17Yh1d9scI9toINbKo4n5aSq9TS1FGSMEX1VotLIaLonCEXXJe
         Wq6iF1N5qHwfQUieIMkqPjd2oEIKlWFXBilINxqMHBfOEKefURlbpjDed4cwkS5yqMGh
         CmTKoXci2ukkQP4l2wrdwklnvBXHjM3rh8y3bvvbVWFPDf7vyXvIZq19oa7B/Ujldv8v
         kZ1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785978855; x=1786583655;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=EllBK4pohN2CB4+9rC08wwxbJTVXkdymq5nTAYfElqk=;
        b=Ob+XrGsftXUtNxuPmox1ypYD/ttinK2HQk8XFNvnfUag46LrBGL8PhO16+yFStl6tK
         cIbPWYswA2e/6FtEJQ6uOe5VG4+cW3n2X+s7Ez+e7C2NHgSI2Pi46A76Nbnl7OrPGOtw
         jw2bR+UmnB8A4z7fneuxx/gc3XBiRoAyfVdUk9pu5yrW5OtoZIauLuCqCXQJspoMwC7v
         qxrz8gtZtOTqkB2YL/ZiUE29/VXBCeBX3QrIxnPMWzdeAmbJ1c6amPn0LAhv9JesKVts
         sLyA4SuMsKepgJcRGXx35hD/q+DC4adwj4hUH0oqlmBA0TxSOLtTSWg16Kk6gi1VIZmU
         HptQ==
X-Forwarded-Encrypted: i=1; AHgh+RpPFa5YINCz+iUAYcdfThdrIQMXNhadUXiCKTYvHuxaLyJ4UcsbssvstlG9rw9EQQ5w+1M=@vger.kernel.org
X-Gm-Message-State: AOJu0YzI8Z6G3R+FYoU2A5sNnaqImcEGOxUhGvS94CE+SSTT1yCVAxUs
	Ly8f0rWh92RWnkCJUbb6LZWJtRJYx02TjrJJyHLfKUcGyaNdV+GLkviKtGgeoiJEWdDPKRNs9/L
	Fw7zJyg==
X-Received: from pfbi27-n2.prod.google.com ([2002:a05:6a00:a51b:20b0:84e:99ac:46cc])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:c93:b0:84a:29a7:f650
 with SMTP id d2e1a72fcca58-84f2de6ab12mr11213223b3a.0.1785978855213; Wed, 05
 Aug 2026 18:14:15 -0700 (PDT)
Date: Wed, 5 Aug 2026 18:14:14 -0700
In-Reply-To: <CAEvNRgGDhcu2LUqhwVtGJSUo4uXQHrGOYRDaM2qzPTO4LX=jKQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260728121138.1103610-1-tarunsahu@google.com>
 <20260728121138.1103610-4-tarunsahu@google.com> <20260728122655.17C791F00A3A@smtp.kernel.org>
 <CAEvNRgGDhcu2LUqhwVtGJSUo4uXQHrGOYRDaM2qzPTO4LX=jKQ@mail.gmail.com>
Message-ID: <anPf5lLNZ5OtwXor@google.com>
Subject: Re: [PATCH v4 03/11] KVM: Export kvm_uevent_notify_vm_create()
From: Sean Christopherson <seanjc@google.com>
To: Ackerley Tng <ackerleytng@google.com>
Cc: sashiko-reviews@lists.linux.dev, Tarun Sahu <tarunsahu@google.com>, 
	kvm@vger.kernel.org, kvmarm@lists.linux.dev, Oliver Upton <oupton@kernel.org>, 
	Marc Zyngier <maz@kernel.org>
Content-Type: text/plain; charset="us-ascii"

On Thu, Jul 30, 2026, Ackerley Tng wrote:
> sashiko-bot@kernel.org writes:
> > --- Patch [3]: [PATCH v4 03/11] KVM: Export kvm_uevent_notify_vm_create() ---
> > commit 5e642ea16f0d267e622a352de60bfe397ecf79df
> > Author: Tarun Sahu <tarunsahu@google.com>
> >
> > KVM: Export kvm_uevent_notify_vm_create()
> >
> > This commit exposes the kvm_uevent_notify_vm_create function to allow
> > triggering KVM event notifications during VM creation.
> >
> > [ ... ]
> >
> >> diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
> >> --- a/virt/kvm/kvm_main.c
> >> +++ b/virt/kvm/kvm_main.c
> >> @@ -6348,6 +6348,11 @@ static void kvm_uevent_notify_change(unsigned int type, struct kvm *kvm)
> >>  	kfree(env);
> >>  }
> >>
> >> +void kvm_uevent_notify_vm_create(struct kvm *kvm)
> >> +{
> >> +	kvm_uevent_notify_change(KVM_EVENT_CREATE_VM, kvm);
> >> +}
> >
> > [Severity: Low]
> > The commit message mentions exporting this function, but is it missing an
> > EXPORT_SYMBOL_GPL or EXPORT_SYMBOL_FOR_KVM_INTERNAL declaration?
> >
> > Without the macro, won't dynamically loaded architecture-specific modules
> > like kvm-intel.ko hit undefined symbol linking errors when they try to
> > call it?
> 
> I'm not 100% sure about the use of EXPORT_SYMBOL... here but usually I
> compile kvm as a module to try and catch these types of linking
> issues. Maybe Sean will have a better method/explanation for this.

The issue is the shortlog, not the code.  The intent is to make the function
globally visible, not to truly export it (the eventual usage is code that's
linked into kvm.ko, i.e. doesn't need an export).
