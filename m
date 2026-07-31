Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2896C37C93C
	for <kvm@vger.kernel.org>; Fri, 31 Jul 2026 20:10:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785528654; cv=none; b=mjg7LUeUaBG2yNOSzz+MvY761xhhwgxiRzZj4M58jWxq2z/o/AxQJ4B0kJVPfFE/ww3yTWnGKn/RahtMAuW389kYphNiWs9RNoFphCSG7P1qtRJvboDsytx+gzwvruarsS2qB2bkHdvLpTUv+ffHZ4To3POpVNjNyub0qcWgjdk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785528654; c=relaxed/simple;
	bh=jdWnRBQZnQ/1Sy1arrKMUHmP4OErzjFaktmqo5gc1Z8=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=SmP3M5zWTR9barHfcp7Yc2snxR+E/W+PI/8IXULNwHX00byXTkKJP+DWzNgBXOBAiNcJwT3pynMSra2956+JhrjOvce3OSCo0YpuYRbh2vDQaH1hA6h4JYsqEw2ni89Jne6+yZqrex6pAfRKCotBtSehMHDdr548YAXS3Nskjpw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=U57UQQ1Q; arc=none smtp.client-ip=209.85.214.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="U57UQQ1Q"
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-2cc6dd43737so28966025ad.2
        for <kvm@vger.kernel.org>; Fri, 31 Jul 2026 13:10:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1785528652; x=1786133452; darn=vger.kernel.org;
        h=content-type:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=NmCt/18MnUiRpIlOmqew0hdoZfhOOmKT0dTA3T4pinE=;
        b=U57UQQ1QRQhxtXgwRSxfSs8wUJ9SIU7EJxS31DtT2hBZlpjE6VHCoSlR2SbBxfwL9J
         3EHwLQBQIUlKnOQFk8X+57jH8n6dprGZpq//Ri0k42Zcg/2YrO75c4C+eGW+FF/3a+vN
         JvSI+H+nsXQsh8viXjWBep1nwsOwRsmCBIXu7kCk/ooWNYfTjJAO3/1zJP3HUjjJhQuM
         eghHxR2ZCpipL7dzLZbTmtbnRM1CM0WnPrZU4/SisZ/Fy19d1hk/wMv/HvTSeUHSFrBg
         vaagCE8BNZwUsd9g7i17wKOPLWzQ7Ko63oI82MfWiFOCKVbutn3oeJXW/3S7hhS0eRaN
         vr0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785528652; x=1786133452;
        h=content-type:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=NmCt/18MnUiRpIlOmqew0hdoZfhOOmKT0dTA3T4pinE=;
        b=gC93FAEuL2nf7Ab1nsXqAs/KPe+nNRNEfAsNSSRA8/2W96e2ua75OeA5xt3Up/1kAA
         rtMHJ8JtI7C+a6aJJedncnwUJo5igOB620bhxxSLNJflMQ4xJx74M5eQgZW/YrqtfdU7
         Tgo+MD1NNoyOQAt3bmg6ItZhs5ZfrXSzLAMvfOPj+PtRdmsYCixzeCmBY1N1/Ow1h4pr
         sd9jWKSQRFirV+fh0GHPTI+kNJWgLVeyVQzfhP9pcf1O1NfVOTDxMBGQaACcCgcfHbfP
         nAnNv6rq0Rd4F3IAgTxfFLTSX+jE5OmNdHAXKa4TOhic7VYCgvW24bw4bpaiAmFEbg0L
         hqCA==
X-Forwarded-Encrypted: i=1; AHgh+RqPvALlzRFDSTkZ4PTJFKPJwVdN1aJeWduo1jRRH6IiKrbrNSCjBkUgwIlOpIwr8688vng=@vger.kernel.org
X-Gm-Message-State: AOJu0YzJsaej5SzJ4U0Kwg6s3ouJFa1uuDr3tDfSfi7asLNgXhbKhaEx
	v+aXLClgWpFQkSMX+J2PDVT3Nx7BUx4d9/N1j1GZyq1etd2A9tcM5hkWMf857ynI1OAqMzFudfR
	ITaFhUA==
X-Received: from plpw6.prod.google.com ([2002:a17:902:9a86:b0:2ca:c162:e758])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:d489:b0:2ca:2753:f3cc
 with SMTP id d9443c01a7336-2d052446846mr11317725ad.33.1785528652220; Fri, 31
 Jul 2026 13:10:52 -0700 (PDT)
Date: Fri, 31 Jul 2026 13:09:56 -0700
In-Reply-To: <20260715120341.2661873-1-twiederh@redhat.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260715120341.2661873-1-twiederh@redhat.com>
X-Mailer: git-send-email 2.55.0.508.g3f0d502094-goog
Message-ID: <178552836940.2711882.15266092080222812337.b4-ty@google.com>
Subject: Re: [PATCH] KVM: x86: Replace delivery mode TODO with WARN_ON_ONCE
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>, 
	Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	"H. Peter Anvin" <hpa@zytor.com>, kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Tim Wiederhake <twiederh@redhat.com>
Content-Type: text/plain; charset="utf-8"

On Wed, 15 Jul 2026 14:03:40 +0200, Tim Wiederhake wrote:
> The default case in __apic_accept_irq() has carried a printk("TODO:
> unsupported delivery mode") since the original LAPIC emulation was
> introduced in commit 97222cc83163 ("KVM: Emulate local APIC in
> kernel").
> 
> The switch now handles all eight delivery modes defined by the x86
> architecture and is always constrained to the three-bit field
> defined by the architecture: Either by masking with APIC_MODE_MASK,
> by three-bit bitfield widths in the IOAPIC and MSI structs, or by
> using APIC_DM_* constants directly.
> 
> [...]

Applied to kvm-x86 misc, thanks!

[1/1] KVM: x86: Replace delivery mode TODO with WARN_ON_ONCE
      https://github.com/kvm-x86/linux/commit/0c5fb7bc6177

--
https://github.com/kvm-x86/linux/tree/next
