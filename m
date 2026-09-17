Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E36EE4E3244
	for <kvm@vger.kernel.org>; Thu, 17 Sep 2026 19:36:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789673787; cv=none; b=Bk3Z5c+9CLXWAOeu6w4A66CGtIv2dtRDXCWRsSF55paVwT3Il8K4qrL1cDxaKqSXvzoDhPoskuusvGiYnvvIiRqEsIiwu9KzFACo2WmrWB6BipXWVWFxz4wvy/4rTqP4Oe++4WK6+abnHgVhyRm5e2+25rRzX1pON+7IMkCDpyA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789673787; c=relaxed/simple;
	bh=y06n3eOW6+Hxo8JDqnYn3jmEOtkB+UXISokzHImXY2M=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Mb+Nl3VOUlqvl8oUfs39qFaZrCbcr3r9VAAN7Ql7jnzUKlIPk14cBXE+UV/LJM9P7UvNGumjGhTH3Hh9+FKwmWcdyWzfx79PRKpRW8AqciYv3py/Hla/LsOyQYf45VPFqNBvGJI1pfwEjF5vvULnPxHgRWSSR6p316KmVwY3cBg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=kYFarkfP; arc=none smtp.client-ip=209.85.214.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="kYFarkfP"
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-2cec4226c70so141445ad.1
        for <kvm@vger.kernel.org>; Thu, 17 Sep 2026 12:36:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1789673784; x=1790278584; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=tExGA9HoTEuIemSrYQEJIOlGYkpT8qx+sw3JSJqDwqs=;
        b=kYFarkfP5ibfInGp/xtNyYrCZib5lSO+FU/qGz+yZequSFPc6Nj8GrfYi7MdzFiHYt
         8+SkwerFK6hQ0Dmnj3WRlZ2hHjUcAw4IUR5MOv8YW3p2kQqAyQM9prw07wkPZxb0/EUg
         a6MhqNyWe8obQ5+f6kXgJH/ij8LmaiJq3Rw3g4ppAkult4XCetgvgAsW3ooNrOEHUDi/
         qMLL4gTD8j/fMAhg9NrOFL8kWwilJ7nd1pF/AFSCG61IhLG1/vjVMLonm0vuWO7f4VmN
         aDhG7EEdX2u+/vg1gogijAA4ROc7O3ngnarrndpgvomHUpirqSEKxaps6sSwVgzUou2w
         7nng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789673784; x=1790278584;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=tExGA9HoTEuIemSrYQEJIOlGYkpT8qx+sw3JSJqDwqs=;
        b=hKRgQlsoRiR0XAwj/jXFgkuHIrz/vqLWXyK/S0lIfOJpoMRfgFfRtI7MCZhxkT8DvV
         NrQuSjuBm89pWP/XZZmTHXHtMIIokCfl5LEHICyC9V76lH/FpsIB/p4lEjV41+5utdl9
         1kiqRYqGBSg4825hDdts2bDTCKiXs3HJacRy5MWP9SbQ8Pv8YE1lTCXGy8vgslQ6bNSO
         p3QmCwpacc+prg6CtH+2F0n8PcYFC6TypjMZM/Hgm6sRXEUw7Fqoku7WdnyvzLbX4N9J
         XPuzjeR6BWiB01o/ItyPCgC0RUWypwGrFT8nsOJPHB7y/ge86mHF8HmnIM0y95IZsgB/
         9+vw==
X-Gm-Message-State: AFuF++l4sDVq97JZWvQpsMiylKq/NtTxfTuS1gNPgJfG7lDM+3tXz83Z
	C3ybQlw2l4d3+8g/uAMS+r3X9YsuVJ5G7BPQigkl1h0wNTVZQG7d46ISSQ0mHEyI2/dXAuGLB7H
	mvXsgPw==
X-Received: from ploz8.prod.google.com ([2002:a17:902:8f88:b0:2dd:86da:afaf])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:d2cc:b0:2dd:ad73:c982
 with SMTP id d9443c01a7336-2ddb1ba0faamr3395105ad.26.1789673783742; Thu, 17
 Sep 2026 12:36:23 -0700 (PDT)
Date: Thu, 17 Sep 2026 12:36:23 -0700
In-Reply-To: <20260917172651.3322899-1-jmcrey@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260917172651.3322899-1-jmcrey@google.com>
Message-ID: <aqxBNxlhV8WbFxo7@google.com>
Subject: Re: [kvm-unit-tests PATCH] x86/msr: Disable PMU for MSR tests
From: Sean Christopherson <seanjc@google.com>
To: Jeremiah McReynolds <jmcrey@google.com>
Cc: kvm@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"

On Thu, Sep 17, 2026, Jeremiah McReynolds wrote:
> QEMUv11 introduced a check when PMU is enabled to ensure that the
> virtualized CPU is the same as the underlying host CPU[1]. The MSR test
> always runs under GenuineIntel with the max CPU model, so PMU is
> implicitly enabled. However, when run on AMD, this new check in QEMU
> causes the test to fail with the log: "host doesn't support requested
> feature: vPMU".
> 
> Explicitly disable PMU on the MSR test to avoid this failure.
> 
> [1]: https://gitlab.com/qemu-project/qemu/-/commit/4c7f05232cd1db5db114d36be2b210d24f1b9ad3
> 
> Signed-off-by: Jeremiah McReynolds <jmcrey@google.com>
> ---
>  x86/unittests.cfg | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/x86/unittests.cfg b/x86/unittests.cfg
> index ae731a93..06fe92f9 100644
> --- a/x86/unittests.cfg
> +++ b/x86/unittests.cfg
> @@ -174,9 +174,10 @@ arch = x86_64
>  # Use GenuineIntel to ensure SYSENTER MSRs are fully preserved, and to test
>  # SVM emulation of Intel CPU behavior.  Use the max CPU model so that 64-bit
>  # support follows the host kernel.  Running a 32-bit guest on a 64-bit host
> -# will fail due to shortcomings in KVM.
> +# will fail due to shortcomings in KVM.  The max CPU model turns on PMU, but
> +# Intel PMU registers cannot be virtualized on AMD, so turn it off.
>  file = msr.flat
> -qemu_params = -cpu max,vendor=GenuineIntel
> +qemu_params = -cpu max,vendor=GenuineIntel,pmu=off

I double checked that "pmu" has existed for a while; it goes back all the way to
QEMU v1.6.0, so we should be good on that front.

>  
>  [msr64]
>  # Same as above, but with a minimal 64-bit CPU model to validate cases where an
> -- 
> 2.55.0.1082.g2b9226bbc0-goog
> 
