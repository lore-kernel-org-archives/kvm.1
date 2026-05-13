Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFCD7423A61
	for <kvm@vger.kernel.org>; Wed, 13 May 2026 12:48:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778676510; cv=none; b=vGNLubyIkBpCiicS2oL/b/lUYBpImFMDuf6j0fMYQXpfwGzJZkRXJa51FwQwmu5F0HKow027jUz80C+bHkOS85iiQp69v1xR1VvLKQH1FSbAu68RFnHf9unw+2npVVcF0hqAzVM3r2GlMIG390cXCBhmGsnn8elwzWVZ6UJdZYU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778676510; c=relaxed/simple;
	bh=+GsX+CdK0ydxnGXslSMT5BS3MNBH9LFYKOpievZvUwc=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=IZhR6SPzzwyrtd2ld0VZWvOOQXHF7CYrhhTQ9xxk+oSlXGHA7/qOcanJBj9BqvPdyCvw1pE+i9WnnElygU/WcCpqZuQ6MAzRgR5MzDKlv845B072ViFCx/DZ6J+brjojrB3aLRjvitZC2PFASvZIQLz9zPNU6NBTuPagVlIul0k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=mnej4WuZ; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="mnej4WuZ"
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-83544d05c5aso3674046b3a.2
        for <kvm@vger.kernel.org>; Wed, 13 May 2026 05:48:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1778676508; x=1779281308; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=+5eHMVfb/Er3xuFGOIw7f+q4SdOyV+C6CS8hVi39b+g=;
        b=mnej4WuZcLYu2spTIG5qsYwOGpRrFVWUh1G6pwOf2Mx5QM6vOMiV6D30zRyvyQEdfq
         PmxYTNYJRFI5MvXCCvaQ4eQx1ZYsdyPJW2Y/X1NN/Jzf5q0SLrhvqB2sgUAoBAVoVIr8
         fBx9mmJ/FdusAKWtzQmEWYCb9txBI9RwHIO8TMLJCHfzBCj1ffWFXKqM4Z613nojbOl1
         V1NbzgsMF8zmpmkph2/+n+uQGeicHvVjPt24LoGDs0URNtZrRasEtNLbm0Ul+yDxJqH/
         lc7yY4iIL1Ru0STc+UcnNdS3NukWypz3OdoHdRzBNkmDYUIz2P9UYbDZNeyM9celjfnV
         RwBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778676508; x=1779281308;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+5eHMVfb/Er3xuFGOIw7f+q4SdOyV+C6CS8hVi39b+g=;
        b=BffvE3LxiOU4N8QIQaEVLXy5LWx6yuNo5FmAFaiDKjuYsLzQXssVNJJVNeDfMxftYH
         Qfkxsb8DQmemXvT1V969GCRgPJGYGOZz/D5eriYav+7k1O8cV13FOnTRxl/ZCRGoqWRD
         p0pzhrtOyQKMd6UmvOInzTZKM+2I5YV6RA2joCBuVx9u7U4HTtVcwMzplMt4tH6vCPQP
         qRbK7Gh6JPVPxUrYzeVclYGfVJePU1XLl0/884Gkk3rdTgZoLQ6Z8wuSDEig66xeY9js
         WpjL/e6Y/IzOFsqH2pRNcwAb78NV7eRSpAB4P7rGk+Y5zWlvq42o3a+2IdhtiHKaFASb
         IjiA==
X-Forwarded-Encrypted: i=1; AFNElJ9NJqQH+smReAlB0Z6X7b9wBEX0DuMu6zIyE3U7P7Cys2YgsTelodbLfjObELXvObSSf0o=@vger.kernel.org
X-Gm-Message-State: AOJu0Yygi5eDeivECNolVr6QuTuC4hnf1EJ/xy3UZiddTZuXE6neL7N3
	hmr0ZD5OHMlT84+7HzFua9B+zD27RJeQ0ywBHlnF0bpVliHm6YyeNRIR1fyTk7IKsdfP2FvbpHp
	FvvCLQw==
X-Received: from pfnn24.prod.google.com ([2002:a05:6a00:2b98:b0:835:4568:a5a0])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:aa7:8887:0:b0:837:b5b6:1b97
 with SMTP id d2e1a72fcca58-83f03fcc53amr3291170b3a.12.1778676507889; Wed, 13
 May 2026 05:48:27 -0700 (PDT)
Date: Wed, 13 May 2026 05:48:27 -0700
In-Reply-To: <B8D6B43E-4C3D-4E1F-BD07-5632E1BBECEA@zytor.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260428125632.129770-1-kas@kernel.org> <20260428125632.129770-3-kas@kernel.org>
 <bf92ebbf-8d70-406a-aea1-c11ca576de90@intel.com> <B8D6B43E-4C3D-4E1F-BD07-5632E1BBECEA@zytor.com>
Message-ID: <agRzBsoQG2C0sHxe@google.com>
Subject: Re: [PATCH v2 2/2] x86/tdx: Fix zero-extension for 32-bit port I/O
From: Sean Christopherson <seanjc@google.com>
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: Dave Hansen <dave.hansen@intel.com>, "Kiryl Shutsemau (Meta)" <kas@kernel.org>, 
	Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	Rick Edgecombe <rick.p.edgecombe@intel.com>, 
	Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>, 
	Kai Huang <kai.huang@intel.com>, Borys Tsyrulnikov <tsyrulnikov.borys@gmail.com>, 
	linux-kernel@vger.kernel.org, linux-coco@lists.linux.dev, kvm@vger.kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"

On Tue, May 12, 2026, H. Peter Anvin wrote:
> On May 12, 2026 6:14:13 PM PDT, Dave Hansen <dave.hansen@intel.com> wrote:
> >On 4/28/26 05:56, Kiryl Shutsemau (Meta) wrote:
> >> +	if (size == 4)
> >> +		regs->ax = 0;
> >> +	else
> >> +		regs->ax &= ~mask;
> >
> >I haven't thought about this _that_ much, but this feels wrong. Why is
> >is 4 so special cased?
> >
> >Also, what _are_ the limits on the registers that 'in' can be used on?
> >
> >RAX - n/a, no 64-bit I/O
> >EAX - size=4
> >AX  - size=2
> >AH  - n/a no encoding for inb
> >AL  - size=1
> >
> >I'd find this much easier to grasp if there was a nice table of what the
> >registers, sizes, and masks ended up being usable. As usual, x86 is
> >"fun" here.
> 
> Because zero extension only applies to dwords.
> 
> x86-64 has three subregisters per GPR:

Aren't there four?  The fourth being 31:0, which is the one that is zero-extended
and so "clobbers" 63:32.

> Bits 7-0
> Bits 15-8
> Bits 63-16

I assume you mean 15:0?  63:16 isn't addressable.  And these are the ones that
aren't zero-extended, i.e. don't "clobber" other bits.
