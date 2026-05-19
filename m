Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com [209.85.215.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1D1B3ED3BF
	for <kvm@vger.kernel.org>; Tue, 19 May 2026 14:06:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779199565; cv=none; b=mnyJwH97tS77Pboto+DB/UcLi4AxeTdyO9H0OOrrs+Pc/dNdH4r8YGNmflFWNiHA6rF1+AnpkVED6njaN+hyEoR9daeScYnurlg7jaIwiEnfcvZNElgJ1NX1ig3fNb75Jfi3NJIYuHv9va6Myyocsy6kTIntSdtLzem2I2fBy1c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779199565; c=relaxed/simple;
	bh=Vouc/DLGFtKiSrIKweTDQniGyepB6TRIvkrrmx8nKs0=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=mqZUVEogbDL6v5q6zJ7KscclOY1QSkTBneT7rvLu5SI38m6vZ3pqFMvjjZY8fjVRsEn0UAu3ff6Nompzbbez5wYhC48gNAjm5LM5l/t3CZM/FfcKotPRd0K5mJLtM41RhIJBm9K0VtOwKfN6lRfya2Y1irfLyT14FaP9WacvPyU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Gez3qvCM; arc=none smtp.client-ip=209.85.215.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Gez3qvCM"
Received: by mail-pg1-f201.google.com with SMTP id 41be03b00d2f7-c828b1b7fddso1966573a12.3
        for <kvm@vger.kernel.org>; Tue, 19 May 2026 07:06:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1779199561; x=1779804361; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=SfwPXEVbmYJOleN4kDRjEcF5M8Qcc5hKCW2J/XJ8nc8=;
        b=Gez3qvCM2KFnNfxQJxH06B1yPUiTJ5wMtOB1Zi5KOBnT7VSLFUNknzKvySzlm9d2iG
         +p3yAeM2G0ANn2+BPfFH5t2S1lH3fbtH8sgKP/GtjPCT8GYejxm7bLZfm33l8/R26DnG
         5BUdPBNtFyRLslMgy2klfwzEos1dfntjYnRhdEc+5bykguCyrOp5MT3P3C0LzQ9fbQ8p
         jsKI2rdqh7wOI443BgE0UXFJuJ2tHhZ4AxK89tinDsCY1kMQAdhrxDUfZKOfH7xGAdhM
         OMWKjyFY1xQCbg5foahD4/Jn8WooQZRg+ZgqON1Eo+qfVeZEw5BJ5+d+GP8ryMaA/Ddi
         Y8rQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779199561; x=1779804361;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SfwPXEVbmYJOleN4kDRjEcF5M8Qcc5hKCW2J/XJ8nc8=;
        b=K4Lh4xshK2gpAywLICjYVmeno8q/y3CJ7e7P2vqzvBbV6bTtn/dSr6dBH53UVw1Luf
         4AyGQZ9hu3ZIkf9mOw2W1LIak5/Bt27ycoAQ3lwS+FfR4oj9+7dcXTuccxk7uFaeuSPs
         HxLnEWX1IOSrtHLHHWAmcvvOTIfhRo5yqNJ+6VTxeTwIlXu50JFqrW1rgwDjOswTGAxp
         zajZahgYky1peAuYY2S5MF+WuGq9n+X+/rR0vcZAYKRbhYdm79b6GioooFia+ZdNKtMp
         pZWvOHd7pIi2yQIdpKKBhZ5WvkEcPDS4MN30e3IiL36VhSBes2hO+VO5MjlGW9A1+u2Y
         AQxA==
X-Forwarded-Encrypted: i=1; AFNElJ9tCZy3AtofOVw7npuu+pMO9Z8Itl0DZFffK3GkqISQArYz9ClUfdroX2sRdbXTCzzXcU0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwH/wyKu7NOCLLu8IGUzePo1A84vlPXHFLmdijF3l+fDnd+LSAM
	p+Om6gX5eqo+clcioPdnDbh07s8szFIDP6GB0LOm9iNyx+kJ4FpDnN8ZRYgJkAIDWGIWBgDdwX9
	rtJlA+A==
X-Received: from pgbbw30.prod.google.com ([2002:a05:6a02:49e:b0:c80:2541:2de8])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a20:9151:b0:3a3:a5cd:560d
 with SMTP id adf61e73a8af0-3b22e7c65ffmr19983378637.9.1779199561253; Tue, 19
 May 2026 07:06:01 -0700 (PDT)
Date: Tue, 19 May 2026 07:06:00 -0700
In-Reply-To: <agcrLnljmHrXm7T5@blrnaveerao1>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260514213115.1637082-1-seanjc@google.com> <20260514213115.1637082-3-seanjc@google.com>
 <agcrLnljmHrXm7T5@blrnaveerao1>
Message-ID: <agxuSBE4kMAjcUe4@google.com>
Subject: Re: [PATCH v3 2/3] KVM: SVM: Disable x2AVIC RDMSR interception for
 MSRs KVM actually supports
From: Sean Christopherson <seanjc@google.com>
To: Naveen N Rao <naveen@kernel.org>
Cc: Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"

On Fri, May 15, 2026, Naveen N Rao wrote:
> On Thu, May 14, 2026 at 02:31:14PM -0700, Sean Christopherson wrote:
> > When toggling x2AVIC on/off, use KVM's curated mask of x2APIC MSRs that
> > can/should be passed through to the guest (or not) when 2AVIC is enabled.
> > Using the effective list provided by the local APIC emulation fixes
> > multiple (classes of) bugs, as the existing hand-coded list of MSRs is
> > wrong on multiple fronts:
> > 
> >  - ARBPRI isn't supported by x2APIC, but its unaccelerated AVIC intercept
> >    is fault-like; disabling interception is nonsensical and suboptimal as
> >    the access generates a #VMEXIT that requires decoding the instruction.
> 
> Nit: unless you decided against incorporating the changes we discussed 
> in v2, please update this part while applying.

Gah, I just spaced it.  I'll reword to:

 - ARBPRI isn't supported by KVM, isn't accelerated by AVIC (for read or
   write), and its #VMEXIT is fault-like, i.e. requires decoding the
   instruction.  Disabling interception is nonsensical and suboptimal.
