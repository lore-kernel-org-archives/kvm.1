Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E7523B47E0
	for <kvm@vger.kernel.org>; Tue, 10 Mar 2026 22:40:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773182448; cv=none; b=s/iuxRuoLgRWRg6zLLOgDsPOwJEV/YXeBW2yIA4fbM49bREXiU5rK14ywc74Tpz1ZnL+bebAKFHxrJ6uE0oeHoo/o2sDSXaqzTgy2MH4ctw1svgjg7esdSipWVMTesQ/2voeJA5oSANnBKUSmIrxZwQai762nqYyUxCXlkSMV4M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773182448; c=relaxed/simple;
	bh=QlagcG569iyDW36sOowUIidoIUFncYMFxFhPg9u2FMQ=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=KlW5rTXq+28kzP2VGSpdcc7ZXHbqoCeq42pLcOaasPVEFMH8044AAY4DLw6iPn69zNHLjbhPmL9z1s1MyL35tBl0Oj4tkJ/xuUldjuhLcphkt9V2GAD7wtJHfnz7e8u1UHtwBz8bkrGAp+Jymti1YOo5I7GAkONhdH25NMhxI28=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=G/BdD7WU; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="G/BdD7WU"
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-35845fcf0f5so430740a91.0
        for <kvm@vger.kernel.org>; Tue, 10 Mar 2026 15:40:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1773182446; x=1773787246; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=pPEOn0JI7dMVt6GUZj8Zs0LKFqW84f4XjO+buWlc6Sw=;
        b=G/BdD7WU2nuam2nzpEvElNRq4oYmicX5vUiLlR2hyd7aSo1JKNeVHWB22NVBRSinu9
         /EPu6c/uZ3CzVXCrBn2VTNfqbPChxk3N7RmogXy/23CAqGqwuXvk+qX2ZI7iWPb76ubZ
         y8uehynxs8Iuu7Q5pzy3n++U4n4cLyXSR1HbnRP8Z5pE4dxnnhDCiyQ67v3/7wUfrY1u
         WGMGgSk1xSpFebTG56ESJHWghZBXYzcREq1Zh6QPAcYgc9WRI6akxcKo1AiAinzRFkMQ
         hv1fwFV5dSllB7ACZJO8BqPtu4svRcnnIunNV3bwvEqu6NHR0l3+6fPPPdaV4hWSWYK0
         gyqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773182446; x=1773787246;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pPEOn0JI7dMVt6GUZj8Zs0LKFqW84f4XjO+buWlc6Sw=;
        b=ExVAeuznmi0bJAgLWFFZ9jxCB2//UF6bjq6Uu7WH8uCB7U9TORQ57M4r9XpeFbCLhK
         0E+bRN9sIQO8VQcyOD+uZeULvPG1Arrb/0RdjqeGKXjWVQ87OnWc+st/1rjxNAy5Jq75
         BXjXAzJsi98aO0O4fWTRbdOpzhmAN9maAW9z4Y3kmS2TCkmB1NIaOUgjHLkWdBEPhSHG
         uKnv6E2TzQ7fI7E0zpghU1pyLxezfIhcbn/AbGYHn9lk7snjPEBYNS1Oy4PTyjkx3N6m
         LyCT2wEYS/PRMAeVxRUs8piJ5G+c5cwTeq8BSmSKIjX6pkp2n9uaCRN4pQ3xZPCt20Q7
         I6xg==
X-Forwarded-Encrypted: i=1; AJvYcCVqbfTKsLiGdy8c2MZCkUA9uX48KuWvkqz8P4RKBxobp6wccNWpmu7uUt6PhzQS3AKuSa8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yymj8wBcrohXX0Tnga9ftmbAC8K6bEGQfZ8cPrXAl1cm9Hd/L/I
	mu5vMe4SJPEESQIwAi2wCRHQc+BW32KnMEI2otE0+u7r6jZxJdqeuHEXseLsICBwDgGj4lVSpxs
	W2sDrCQ==
X-Received: from pjbiq4.prod.google.com ([2002:a17:90a:fb44:b0:359:92db:6c34])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:2e52:b0:359:f5f4:7740
 with SMTP id 98e67ed59e1d1-35a02830179mr243315a91.17.1773182446399; Tue, 10
 Mar 2026 15:40:46 -0700 (PDT)
Date: Tue, 10 Mar 2026 15:40:44 -0700
In-Reply-To: <dc6809fb-ef44-4fce-b98a-bd80edf7d64e@amd.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260203190711.458413-3-seanjc@google.com> <19935696-36cf-411b-af90-aabe6a98d7e7@amd.com>
 <abBSPkKmMiFCfKek@google.com> <947bf241-d149-4933-874a-de96aeb73dff@amd.com>
 <abBYiODdL4405KbB@blrnaveerao1> <debf1c3f-f0aa-4b9d-ba35-feed87aa899e@amd.com>
 <abBkgY9W4_PD1uef@google.com> <23ec6b06-96b9-42aa-937a-908b2ce73a69@amd.com>
 <abCT69PvxOo9ERu2@google.com> <dc6809fb-ef44-4fce-b98a-bd80edf7d64e@amd.com>
Message-ID: <abCd7FfaG_UvVz6m@google.com>
Subject: Re: [PATCH 2/2] KVM: SVM: Set/clear CR8 write interception when AVIC
 is (de)activated
From: Sean Christopherson <seanjc@google.com>
To: Tom Lendacky <thomas.lendacky@amd.com>
Cc: Naveen N Rao <naveen@kernel.org>, Srikanth Aithal <sraithal@amd.com>, 
	Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Jim Mattson <jmattson@google.com>, "Maciej S . Szmigiero" <maciej.szmigiero@oracle.com>
Content-Type: text/plain; charset="us-ascii"

On Tue, Mar 10, 2026, Tom Lendacky wrote:
> On 3/10/26 16:58, Sean Christopherson wrote:
> > On Tue, Mar 10, 2026, Tom Lendacky wrote:
> >> On 3/10/26 13:35, Sean Christopherson wrote:
> >>> On Tue, Mar 10, 2026, Tom Lendacky wrote:
> >>>> I'm just saying that the unconditional trap for CR8_WRITE isn't flawed
> >>>> for SEV-ES+ because AVIC can't work with SEV, so there isn't any time
> >>>> that CR8 writes shouldn't be trapped.
> >>>
> >>> Yeah, I forgot that (obviously).
> >>>
> >>> But sync_cr8_to_lapic() is very broken, no?  INTERCEPT_CR8_WRITE will never be
> >>> set, and svm->vmcb->control.int_ctl will become stale as soon as the VMSA is
> >>> live, and so in all likelihood KVM is crushing CR8 to zero for SEV-ES guests.
> >>
> >> I don't think so. V_TPR is written on #VMEXIT even for SEV-ES+ guests,
> >> and since it is a trap, CR8 is set and so V_TPR should have that value.
> >> That would imply sync_cr8_to_lapic() should do the right thing.
> > 
> > But isn't svm->vmcb->control.int_ctl stale?  Oh.  "control", not "save".  /facepalm
> > 
> > Ah, and I assume Secure AVIC hides vTPR from the host?  Or at least prevents the
> > host from setting it?
> 
> Secure AVIC will prevent the host from setting it since the backing page
> lives in guest memory and is encrypted/private.

What about vmcb->control.int_ctl though?  IIUC, that's the source of truth for
the effective vTPR, not the value in the virtual APIC page.

> >> After attempting to verify this behavior it turns out that writes to CR8
> >> (and CR2) are, in fact, not trapped, but the APM was not updated with
> >> this information (I'll send a patch to remove that code). KVM's CR8
> >> value is, however, synced with the proper value through
> >> sync_cr8_to_lapic() because V_TPR in the VMCB is updated on #VMEXIT.
> > 
> > Oh.  Huh.  So doesn't that mean that supporting Windows (or any other guest that
> > uses TPR to mask interrupts) as an SEV-ES guest is practically impossible?  Because
> > while KVM can observe and manipulate guest CR8, KVM won't be able to precisely
> > detect when TPR drops below a pending IRQ.
> 
> Could we do something with virtual interrupt support? Today KVM uses the
> virtual interrupt control to detect when an IRQ window opens. We could
> do something similar by setting up the virtual interrupt priority,
> V_INTR_PRIO, at the level of the current TPR/CR8 level. When the TPR
> drops, that would trigger a #VMEXIT and allow the pending IRQ to be
> injected. Thoughts?

Uh, yes, that would work?  I was thinking we couldn't model the priority, but
obviously that's not true.

FWIW, my preference would be to not add support unless someone asks for it :-)
