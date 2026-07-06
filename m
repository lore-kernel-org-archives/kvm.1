Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0418D33987F
	for <kvm@vger.kernel.org>; Mon,  6 Jul 2026 22:26:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783376803; cv=none; b=Fart3Rlj2lBW6xvB4GXS4VpMAMJ6WUhYVpx1/DqpXXHKOpUuDsQVKOuCUk8SEzxnyzslePt79YA2I9pt9bUqBmyvqdzO3fl8m8cDm1Ex3tlOGh+w18bBaZBB86GulDdSsJH1dbnGNumG2aythe3e1gspbbo+LKq9fAPNY/+b/PU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783376803; c=relaxed/simple;
	bh=+R4p6JYaAQk34SihddHBt5q1X1BltnnjxHiwtGFkb54=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=moWn34LZHaCT9olvTJjS/3JKmRGcX6QXeU4/uAP10JXR2L8eOXy6+JybiQVvox63qqDeoaYB8YQWgzRumfz+TLYSvw/LIlpM+tqGMH155LBoLawvZ7qPs3l4Hy1RIiPIuKQvzgreUAQ5RRcDoh5i2qCaETCnqEmI54dD8H/giew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=l21JsQxd; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="l21JsQxd"
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-2cc640dfde3so31160625ad.1
        for <kvm@vger.kernel.org>; Mon, 06 Jul 2026 15:26:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1783376798; x=1783981598; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=iTdEeqt5dniWvRZdgsQjtLTU+Q/kgyseFFQbEQhBHOk=;
        b=l21JsQxdPhQZVkwzkQTQQwEHVUz39LsKw5fExXEK+zKGRbvDeFuQfQ/UeWNCjGF0yG
         oZctV4FnOK7yVG6zdedoZXK6Qr9anIvjPWESfNEaBS9G73wLgIRotL73VowJpMEwhzXx
         MlHC53v3PjemRt5UZGt3y4CL6jcgt5ONnP1C9mAEj7V6kzHmcwFluSnYO2xbI5Ym1hV9
         os6MsrKO/EQAxTGtmybeHPlqmfLX/MFBP+X7nAaFGy7eEzLtV72nbzBtHs7AMgHcZQgI
         gDIlS88isd93V7sqSJPEeru5MhiATdZ2LX7i7JVSSbQRQ8ziODe48Eb/MGZRqGt5UXyd
         Va+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783376798; x=1783981598;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=iTdEeqt5dniWvRZdgsQjtLTU+Q/kgyseFFQbEQhBHOk=;
        b=RJ6lPAwATRGUafxqkqoFKETLr+01iNZwtMZ3Y6Daqo1HQHhxwuH157QK5GgmewVyi5
         4uR3v8mZbHEwJkQPTYQpRp0MnNZYCmuH1ApIGl2GOZ1xPHoKD9R+Fd8krOTISXd26WGq
         lXLxofR/YQcLknrj871lDdJylPAXKI3j80JdW/deAqus1wzpO0XsJ+Sax0oszWIVttv3
         kO6D+yW8ATZzEtusiPr/uzehWJg5vRxX3SWPI/I264+gkWT9ODQ7pYxGn22GYTotz9yE
         3+HSRvog9uAc5z696/iT28moWJvkdwdqiDQ1HlHOSXWqG3x4P5XU3QMvsCs9p0NJAkvK
         Pl8Q==
X-Forwarded-Encrypted: i=1; AHgh+Rq2iyahxpZOfTRsHRUBGAknfwsCThnInoDHzCrUb6ptC6EoS9/twGC+kNIq/Ty3lraDY9Y=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywcm+tin8iaJsa2X27GwBSSYDG2P7C0G8jv307NqKp5W8K6Sr2N
	WJoO0+DhnpoDSXyuuKqgZ0GU/EiOEYzB2ICJRVs/UVcc881t0eiML3Io5SVWgDMfmWAEsY4f2jp
	fH18hJg==
X-Received: from plfh17.prod.google.com ([2002:a17:902:f551:b0:2ca:feb:2a99])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:37c7:b0:2ca:e0ff:ea9e
 with SMTP id d9443c01a7336-2ccbf056c33mr28013285ad.30.1783376797783; Mon, 06
 Jul 2026 15:26:37 -0700 (PDT)
Date: Mon, 6 Jul 2026 15:26:37 -0700
In-Reply-To: <20260706092021.3625908-2-twiederh@redhat.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260706092021.3625908-2-twiederh@redhat.com>
Message-ID: <akwrncCjosItvAeO@google.com>
Subject: Re: [PATCH 0/4] KVM: x86: Document and enforce APIC base memory hole
From: Sean Christopherson <seanjc@google.com>
To: Tim Wiederhake <twiederh@redhat.com>
Cc: Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, 
	"H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>, Jonathan Corbet <corbet@lwn.net>, kvm@vger.kernel.org, 
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Paolo Bonzini <pbonzini@redhat.com>, Shuah Khan <skhan@linuxfoundation.org>, 
	Thomas Gleixner <tglx@kernel.org>, x86@kernel.org
Content-Type: text/plain; charset="us-ascii"

On Mon, Jul 06, 2026, Tim Wiederhake wrote:
> When an in-kernel irqchip is enabled on x86, KVM installs a private
> memory slot at the default APIC base address (0xfee00000) during vcpu
> creation.  If user space has already mapped a memory region covering
> that address, vcpu creation fails with -EEXIST.  The same happens in
> reverse: mapping memory over the APIC base after vcpu creation also
> fails with -EEXIST.
> 
> None of this is documented, and the error is reported far from where
> the actual conflict is introduced.  A VMM developer hitting this has
> to trace through KVM internals to understand what went wrong.
> 
> This series documents the two undocumented constraints (irqchip before
> vcpu, APIC base memory hole) and adds early checks so the error is
> reported at the ioctl that actually violates the constraint.
> 
> Patches 1-2 are documentation only.  Patches 3-4 add early validation
> that turns a confusing -EEXIST at vcpu creation into an explicit error
> at the point where the conflict is introduced.

I'm 100% in favor of documenting the behavior, but I'm not exactly excited about
the enforcement.  It's not needed for KVM's safety, and while I appreciate that
such a goof would be somewhat annoying to debug, I have a hard time believing it's
a common failure.  I.e. I'm not convinced carrying the code is worth the marginal
benefits it provides.
