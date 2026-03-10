Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E59F13A16A7
	for <kvm@vger.kernel.org>; Tue, 10 Mar 2026 21:58:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773179887; cv=none; b=nmZPk++494H/FMbaCnjVJByDagtoe0fontATvI8Nxb+81nwY2sQr5KhLQ2n8SP+F7dK3BpuwuQmkZr6/U4MbThPNVjIDHgTeoVmeaWElj8sRiyoJhe7EQsKL/rDlIeEZpsU1Q5nTL2W7xd+w0aYFW0tSNr2VHxE1NOoZ2krIp50=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773179887; c=relaxed/simple;
	bh=6VBax01qyTAyH6JAF2HuiQAt2NHW5Wag+j85vR83tyY=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=K2RkLq3vO/RJx+KUBhsEXwzg+pYmyAd5nlwyq8npFhGx6tvC76bHmpUEqkkPkj+cdEHa3mNa5/WYarpRBlPUcgZh2/ouQKuNuIe7nbA76+50cg4GbkQKoqpBlu4LHlMuE2gmNg3nTOrecj9/l3CVGhjWcwHiaxEcf02Xx/GJ60E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=RjvvOAc2; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="RjvvOAc2"
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-2ae4e9577ceso489130125ad.1
        for <kvm@vger.kernel.org>; Tue, 10 Mar 2026 14:58:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1773179885; x=1773784685; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=Hh+Vk8kGrPVa84zdlcR6fKM19wz5rw/1JPiPgJmSb7c=;
        b=RjvvOAc2qsigfW/A9UqZYcGCxE9/9CdvUISI1GnXkFcOB2gqP6/xBoyR2TdDknsNmq
         isGg3yeqq0vMgSg5LHYV2UXnnn2pLps3nnHv+JEcW429LqufnQLzanAyV/8qdelZQZMc
         MjtC4OcPAh/L09pFMEfPMM6wFTpvGJFkAWnt265TmxXN9rid1bxN4xHxDp7bmNOJvBXm
         VXxQD0qCme8JkxP+sQlwOpyS/05cdMkw18zmHmLRnZXNoA3rsElS2Cm+cZeRkVtjBFtz
         XHUrTG8AhGW++Mwe2eJYp5juug3sG/QwZTBbRsevx7zfc0heCAIv2OrzGFosSarymbmA
         p2UA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773179885; x=1773784685;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Hh+Vk8kGrPVa84zdlcR6fKM19wz5rw/1JPiPgJmSb7c=;
        b=jV6zudXEG/VhJIGywrCfFUNLBfPIVY4mcrguQaBdwVZhMgNuIXvx/YQayhmZMMyMiE
         CC51QpGloW/uoVRX7ebjGpVN9kf1UMoL1YuK9dVkizKPFKcmyatqyRTGUMIZk/GZRkXY
         o+tXGxotqSc8KjIoyN9GaIdQt3doUbFh5nrGzq4i23BTlVVQcuKj6v+adOjw4L403nDx
         KV78jiVUn9uazik5Pj+QQzJwemoLKDgx+oyqaahg2x75sWMrj66us+/G/dU96cqcSUJl
         QRkbF/xCChE0gG4sl7bt+wMzG/49faxdD2fXEtynDXtRk4kMZmA4DIyaVHWC3CNmbSXQ
         Gutg==
X-Forwarded-Encrypted: i=1; AJvYcCUHIlBd6hLu+w4BYMyGUKpz+pSQaFdVIPUqW9j2bFGZhmryfTx+cYU9lVnl3zENm5Q6UvI=@vger.kernel.org
X-Gm-Message-State: AOJu0YydQ0EqeEKFmVAaQ0HUXIcXZb4nCdvZbAhF6ldZ5tEe7s0lhL/U
	T92MOjbkAJkkwNoaFwqv+paLNp8N9ANgauabdVZA0n5EwIBHMhiVvMyc4A/1FN4AS6+Z/Z020+L
	UglTiIw==
X-Received: from plblg8.prod.google.com ([2002:a17:902:fb88:b0:2ae:47dc:d8aa])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:f602:b0:2ad:9ded:f29
 with SMTP id d9443c01a7336-2aeae85b830mr2879985ad.33.1773179884887; Tue, 10
 Mar 2026 14:58:04 -0700 (PDT)
Date: Tue, 10 Mar 2026 21:58:03 +0000
In-Reply-To: <23ec6b06-96b9-42aa-937a-908b2ce73a69@amd.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260203190711.458413-1-seanjc@google.com> <20260203190711.458413-3-seanjc@google.com>
 <19935696-36cf-411b-af90-aabe6a98d7e7@amd.com> <abBSPkKmMiFCfKek@google.com>
 <947bf241-d149-4933-874a-de96aeb73dff@amd.com> <abBYiODdL4405KbB@blrnaveerao1>
 <debf1c3f-f0aa-4b9d-ba35-feed87aa899e@amd.com> <abBkgY9W4_PD1uef@google.com> <23ec6b06-96b9-42aa-937a-908b2ce73a69@amd.com>
Message-ID: <abCT69PvxOo9ERu2@google.com>
Subject: Re: [PATCH 2/2] KVM: SVM: Set/clear CR8 write interception when AVIC
 is (de)activated
From: Sean Christopherson <seanjc@google.com>
To: Tom Lendacky <thomas.lendacky@amd.com>
Cc: Naveen N Rao <naveen@kernel.org>, Srikanth Aithal <sraithal@amd.com>, 
	Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Jim Mattson <jmattson@google.com>, "Maciej S . Szmigiero" <maciej.szmigiero@oracle.com>
Content-Type: text/plain; charset="us-ascii"

On Tue, Mar 10, 2026, Tom Lendacky wrote:
> On 3/10/26 13:35, Sean Christopherson wrote:
> > On Tue, Mar 10, 2026, Tom Lendacky wrote:
> >> I'm just saying that the unconditional trap for CR8_WRITE isn't flawed
> >> for SEV-ES+ because AVIC can't work with SEV, so there isn't any time
> >> that CR8 writes shouldn't be trapped.
> > 
> > Yeah, I forgot that (obviously).
> > 
> > But sync_cr8_to_lapic() is very broken, no?  INTERCEPT_CR8_WRITE will never be
> > set, and svm->vmcb->control.int_ctl will become stale as soon as the VMSA is
> > live, and so in all likelihood KVM is crushing CR8 to zero for SEV-ES guests.
> 
> I don't think so. V_TPR is written on #VMEXIT even for SEV-ES+ guests,
> and since it is a trap, CR8 is set and so V_TPR should have that value.
> That would imply sync_cr8_to_lapic() should do the right thing.

But isn't svm->vmcb->control.int_ctl stale?  Oh.  "control", not "save".  /facepalm

Ah, and I assume Secure AVIC hides vTPR from the host?  Or at least prevents the
host from setting it?

> After attempting to verify this behavior it turns out that writes to CR8
> (and CR2) are, in fact, not trapped, but the APM was not updated with
> this information (I'll send a patch to remove that code). KVM's CR8
> value is, however, synced with the proper value through
> sync_cr8_to_lapic() because V_TPR in the VMCB is updated on #VMEXIT.

Oh.  Huh.  So doesn't that mean that supporting Windows (or any other guest that
uses TPR to mask interrupts) as an SEV-ES guest is practically impossible?  Because
while KVM can observe and manipulate guest CR8, KVM won't be able to precisely
detect when TPR drops below a pending IRQ.
