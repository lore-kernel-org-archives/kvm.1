Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A5CA347506
	for <kvm@vger.kernel.org>; Fri, 29 May 2026 15:10:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780067431; cv=none; b=cB8APrUm7u7HCfHsHJ3Kpm6AT18PRb+VAULn7W7GJsUwDRNB9i4NFK5No/3IAJ8rU5v23HQ4VrLYqqh2m0k6+iWPoKtQgGlWmajGcFvO55zZqWsDdemYj3pNKXYB1vAn5DIvj3nwlMIAiTwcQJekWLr2Ig6vsmgASInu9iV8Gbs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780067431; c=relaxed/simple;
	bh=V/hxOsVp4piMpArHe7ioxetvdl4y0PTvTNEBx/lxH1A=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=l/SAlr0vVc3kcRn7TGFNBpJdGzOs1y+PLDC61H2JnkBu4hqJ5aAuXEcqW5vBKLUfSpG6tCozdp+vn/pwq1P4v+vGr/0l75amnnYpePoKyIlEsqr4z0q/1bHr1Bzyfpu66BmV53074JU8Tg+Xj9wcs2NsNLe9X/Z3uvcveqkGCcM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=S1BF00MA; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="S1BF00MA"
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-2bd6cc53fd6so146281335ad.3
        for <kvm@vger.kernel.org>; Fri, 29 May 2026 08:10:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780067430; x=1780672230; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Q3KwUKexhBMnhxMu/5zzl7QcY3Y917Dhb3kMyW4ALaw=;
        b=S1BF00MAfBUTQf7qcsd6AMFOb+PrVfa6HVL6abPpR7ZjsyvYMoNZ87O5gRi5HO9nVL
         bjk8cqO1pvRxknbE6XjkmzDHSnk1EBu1JSdm+APVspJPSBf000PEZaIwgJMmkz6WQVJm
         0G+QAPLNwauQO9cguQ44LVL/qNonf7oEMO0FidDlVFn6RTDqg+3ZYrPyuzOXErkt/X3f
         tGml/NH6JwpcBfUZaLTu/+GcduB+6f1e8omP1znV7RXgCkrsq0x0C4fVUcPcu4dw4inV
         O8jGW7Ev/MVQHXRwAW2nln/A9HgbtvYs6bts9Ztmzt2cZBmK9ey9Iq2jKUUvyIxlbEYT
         1ctg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780067430; x=1780672230;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Q3KwUKexhBMnhxMu/5zzl7QcY3Y917Dhb3kMyW4ALaw=;
        b=QbBj3Dh10G6d02bab2E9VOt1ZmU/ZvpAw1f+zleJe9XUZCDvnkMDJ3SFIP6XgzGZX1
         RqxWx4VwxriNp653y+3QJCZ73TxOX6btipAA21vNmvw7/BvsFHyAtm+kPaSw075DyQIe
         A1yQjyWMDo5kD+W44/D8pMIqjhhJN7VqV8fovb0r/DVSliMMkPK7dbGanow+3zeQNtZS
         0yM3A3qzGsjEOQAYHcEl0kVJpuwHALqVcQMMNcE0JSEpP5NxzvJEMKqFAkb7jFCA3SL3
         sHo2wiFkMVeXUNtZslMutpGxscB53AiLUxx/b4BNbz0pt8Rx/izVhZ4LX37kT9dCJusB
         aj9g==
X-Forwarded-Encrypted: i=1; AFNElJ8ezX/l2vTh2srm3vgpNXQCHIPpaNdmUPSuDQrokNTC9iKcAc9lUrNXRt9ZASZy63aOaqY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy1oEwtFmg6tNFH8kmsUBMsr+/mnBh18XnjggEWZJEORIWFGMkb
	JddaNmPawXQNXlNGLf+ba4jwLOMBoDCAHjwjGcSyo4AbGP3zXUaJPwT3L93HLwPohZxLzuehX6W
	pbXoEfg==
X-Received: from plpo14.prod.google.com ([2002:a17:903:3e0e:b0:2bf:19e3:ff16])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:1b64:b0:2b7:aa20:3c61
 with SMTP id d9443c01a7336-2bf36858f5bmr2472455ad.33.1780067429457; Fri, 29
 May 2026 08:10:29 -0700 (PDT)
Date: Fri, 29 May 2026 08:10:28 -0700
In-Reply-To: <20260529144435.704127-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260529144435.704127-1-seanjc@google.com>
Message-ID: <ahmsZA8mHj9CPnd2@google.com>
Subject: Re: [PATCH v4 00/47] x86: Try to wrangle PV clocks vs. TSC
From: Sean Christopherson <seanjc@google.com>
To: Paolo Bonzini <pbonzini@redhat.com>, Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, 
	Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	Kiryl Shutsemau <kas@kernel.org>, "K. Y. Srinivasan" <kys@microsoft.com>, 
	Haiyang Zhang <haiyangz@microsoft.com>, Wei Liu <wei.liu@kernel.org>, 
	Dexuan Cui <decui@microsoft.com>, Long Li <longli@microsoft.com>, 
	Ajay Kaher <ajay.kaher@broadcom.com>, Alexey Makhalov <alexey.makhalov@broadcom.com>, 
	Jan Kiszka <jan.kiszka@siemens.com>, Andy Lutomirski <luto@kernel.org>, 
	Peter Zijlstra <peterz@infradead.org>, Juergen Gross <jgross@suse.com>, 
	Daniel Lezcano <daniel.lezcano@kernel.org>, John Stultz <jstultz@google.com>, 
	"H. Peter Anvin" <hpa@zytor.com>, Rick Edgecombe <rick.p.edgecombe@intel.com>, 
	Vitaly Kuznetsov <vkuznets@redhat.com>, 
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, 
	Boris Ostrovsky <boris.ostrovsky@oracle.com>, Stephen Boyd <sboyd@kernel.org>, kvm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-coco@lists.linux.dev, 
	linux-hyperv@vger.kernel.org, virtualization@lists.linux.dev, 
	xen-devel@lists.xenproject.org, David Woodhouse <dwmw@amazon.co.uk>, 
	Tom Lendacky <thomas.lendacky@amd.com>, Nikunj A Dadhania <nikunj@amd.com>, 
	David Woodhouse <dwmw2@infradead.org>, Michael Kelley <mhklinux@outlook.com>, 
	Thomas Gleixner <tglx@linutronix.de>
Content-Type: text/plain; charset="us-ascii"

On Fri, May 29, 2026, Sean Christopherson wrote:
> Well, the number of patches in the series is going in the wrong direction,
> but I'm much happier with this version, which eschews the x86_platform
> overrides entirely in favor of a fixed sequence for selecting the TSC/CPU
> frequency "routine".

FYI, our internal mail server flamed out after sending patch 26 in the initial
go.  I'm pretty sure I managed to get the rest sent without screwing up the
threading.  Holler if something is wonky and I'll RESEND the whole pile if necessary.
