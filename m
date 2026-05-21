Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com [209.85.215.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CADE426EA6
	for <kvm@vger.kernel.org>; Thu, 21 May 2026 20:35:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779395757; cv=none; b=RBI6IPnw/EkQERNTTaY6w+AgdvPhJXNKzq8eBoY50G7UgVGYnH1U3XvweZ0ni86YZQIGiDioMigsxHCJLwEZka4ytsvunIm72X/DL6PKbspAGgbkZh1CMaxJzhQW1I1+ygI29Nt/zR8Qm0uXuIQXyUsXmMdv3IBZhnlJs89mfQQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779395757; c=relaxed/simple;
	bh=ipWhDnS3c8Of+slJErBTF5Vqt6ODkaCbWe9MFVov0zI=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=MKI7T64V9elgeTCv0WHFjpAsucX+DH2CXNbkYpFhGz1BOeH2H9umhNjRgKxmW+Y6dT35ED3YWgK8WAUJhaNCepa6wC0fM/9Zth5H5LUdPzQ1NNATYYgxDDb5FPnRiVACcOm4EH+MImWBZwaCxblBalpOhbOKIuaEm8fe3qsOrnw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=UYpxBcWh; arc=none smtp.client-ip=209.85.215.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="UYpxBcWh"
Received: by mail-pg1-f201.google.com with SMTP id 41be03b00d2f7-c82ac893940so3218039a12.1
        for <kvm@vger.kernel.org>; Thu, 21 May 2026 13:35:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1779395754; x=1780000554; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ipWhDnS3c8Of+slJErBTF5Vqt6ODkaCbWe9MFVov0zI=;
        b=UYpxBcWhQ1GLHsXNqJo6KM8ByYjzTA3ylvmkshJs4Z1N83lqUj5kDuNrDU5va2VUX1
         FcAFN8D136WHs4lTAOhuqN8AMkVyYNvy2ruSoZGhrjf9KBT4UCVzPGO7+eFHXMSKAFle
         Km34N8coFDUxb7YezBr7BE7Edjw6l+OHrrUmrcohqpft1oaXObObcEqlD54yIUqNON1Y
         ZBWUonDcueBay43F/c6Ro+24dKw2fy4d/mn3FYLa57A4ODCf5d2+Kny7i6EFt9kfFmoU
         zbt5l0N6LysGW8aj+tQXwyoZjL7be9/ykZG2zUk/HnHbXU18OfsJRA7eUHAeJg4KWt0z
         HbdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779395754; x=1780000554;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=ipWhDnS3c8Of+slJErBTF5Vqt6ODkaCbWe9MFVov0zI=;
        b=c+wFPXqPXGOpwdyei0qYWzgSJf3S5sHE6AZZ4SyIGqWhPjboh0f0cchZX2gtCttg5t
         Tx16OGyKH2YzntK45RXEzGXqJKRcg2wpwz35Ffr8hxUCsL/ipam70iyG2b7pRjfKrQSs
         sqXhJvaJagsY4ANASmSMjuOrKidS/FFkSKbl2l8nMMrHCWBe7H89LdPu4cn+fk/P+tG9
         dwrOqB+ju8qmUN224FZNmSBGb0bAJxdSUJgeujeDxhLqaq0ihXTtNvb7PCEyQrj+sj4T
         zPy7PrgghEg5/lylb1MtpLS2/wyfnmAww03BYqVr/iNuic0FFWapPsZ0amdeq7E9mpTO
         3xnw==
X-Forwarded-Encrypted: i=1; AFNElJ9op7xH3SqbLk+q4x7rpUQF887Kb8QE/USZyWrhf+qwGTrwKgnYVs/yTgRjQO6n8Tn6/kg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxfCQ/BYoPmCcQGApM2bsqmjipnT5AMeUZVt11KHRC0qewU0Y+5
	syFtnoppTI9xj3XNNOXIghlGovpFvtB5Ft79TXcgRYrkBhaawVPi0M2XURm2pRsUIQfs+evfeZC
	CCcWQWQ==
X-Received: from pglv7.prod.google.com ([2002:a63:1507:0:b0:c80:192c:51ff])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a20:d491:b0:3b2:8677:813e
 with SMTP id adf61e73a8af0-3b328ec5909mr476744637.42.1779395753857; Thu, 21
 May 2026 13:35:53 -0700 (PDT)
Date: Thu, 21 May 2026 13:35:53 -0700
In-Reply-To: <13d79ba1e0450068c9573ccd8deb3ec007aea8d6.camel@infradead.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260515191942.1892718-1-seanjc@google.com> <20260515191942.1892718-30-seanjc@google.com>
 <13d79ba1e0450068c9573ccd8deb3ec007aea8d6.camel@infradead.org>
Message-ID: <ag9sqdLCAqJwaaE-@google.com>
Subject: Re: [PATCH v3 29/41] x86/paravirt: Plumb a return code into __paravirt_set_sched_clock()
From: Sean Christopherson <seanjc@google.com>
To: David Woodhouse <dwmw2@infradead.org>
Cc: Kiryl Shutsemau <kas@kernel.org>, Paolo Bonzini <pbonzini@redhat.com>, 
	"K. Y. Srinivasan" <kys@microsoft.com>, Haiyang Zhang <haiyangz@microsoft.com>, Wei Liu <wei.liu@kernel.org>, 
	Dexuan Cui <decui@microsoft.com>, Long Li <longli@microsoft.com>, 
	Ajay Kaher <ajay.kaher@broadcom.com>, Alexey Makhalov <alexey.makhalov@broadcom.com>, 
	Jan Kiszka <jan.kiszka@siemens.com>, Dave Hansen <dave.hansen@linux.intel.com>, 
	Andy Lutomirski <luto@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Juergen Gross <jgross@suse.com>, 
	Daniel Lezcano <daniel.lezcano@kernel.org>, Thomas Gleixner <tglx@kernel.org>, 
	John Stultz <jstultz@google.com>, Rick Edgecombe <rick.p.edgecombe@intel.com>, 
	Vitaly Kuznetsov <vkuznets@redhat.com>, 
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, 
	Boris Ostrovsky <boris.ostrovsky@oracle.com>, Stephen Boyd <sboyd@kernel.org>, x86@kernel.org, 
	linux-coco@lists.linux.dev, kvm@vger.kernel.org, linux-hyperv@vger.kernel.org, 
	virtualization@lists.linux.dev, linux-kernel@vger.kernel.org, 
	xen-devel@lists.xenproject.org, Michael Kelley <mhklinux@outlook.com>, 
	Tom Lendacky <thomas.lendacky@amd.com>, Nikunj A Dadhania <nikunj@amd.com>, 
	Thomas Gleixner <tglx@linutronix.de>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Thu, May 21, 2026, David Woodhouse wrote:
> On Fri, 2026-05-15 at 12:19 -0700, Sean Christopherson wrote:
> > Add a return code to __paravirt_set_sched_clock() so that the kernel ca=
n
> > reject attempts to use a PV sched_clock without breaking the caller.=C2=
=A0 E.g.
> > when running as a CoCo VM with a secure TSC, using a PV clock is genera=
lly
> > undesirable.
> >=20
> > Note, kvmclock is the only PV clock that does anything "extra" beyond
> > simply registering itself as sched_clock, i.e. is the only caller that
> > needs to check the new return value.
> >=20
> > Signed-off-by: Sean Christopherson <seanjc@google.com>
>=20
> Oooh... can we use this to reject the kvmclock when we have a stable
> and reliable TSC even for non-CoCo guests?

Yes, but I would much rather "fix" kvmclock to not even attempt to register=
 itself
as the sched_clock (which this series does).
