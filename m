Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3032392819
	for <kvm@vger.kernel.org>; Tue,  7 Apr 2026 07:19:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=170.10.129.124
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775546344; cv=pass; b=TduZf2MdqdDYeJmiFVhvjZ/QeY51hybYqi7yYvCghqFuFapB08RPI2RUSfiDoMDBFTOQjdMl76/hXgYeC+5C6ZTWcCsabNaI8dmwmDZECSMUjP0uhPj3ETGohj/sRiWM/BSijkY5seRl04ppiqEV2RT7iFxe2ixfgZdauqKx+fA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775546344; c=relaxed/simple;
	bh=oK66n8s+O/hYsgxUx+3OljUGmEFfW+ZrHSNTkfOI6FU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=p6Hwsag2k2oRSGd80PlQwSxNKE7kA3xXN04/s/lZ887z8UqR3DN33aiEFYYU2paK+7CavHiYJlxUJ3sUCFoaw/MiYIaR0/sfZDuxZJDKQvmECdPndPov+O1dboRCeocqjxuTTBKinkxW4WcE83fg27HQ39ay5ZfdSib6PR38fHk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Dl9vcHIG; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=lECfIS/M; arc=pass smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Dl9vcHIG";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="lECfIS/M"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1775546341;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=mljjuQYWVEJA5/gTJORfrhvkCXmvQyM1a+kpTpApJBc=;
	b=Dl9vcHIG6n+QrdwTRZXC7VhefDxz543zg5MDRYqzSxXb3gaZrQ3/CAHDcJpVHqyvijTJ6n
	T8KoEfqVX9r57OPRbOaPE5FjfrC0iw3M0jfJt9tn7ivvSM6TzybKN2/qH8Y4tuKS2nunBg
	Vmsm/sTboY9UDz+S8C1BtQqsW85kQqs=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-131-oN6b5BG2PR-wAkPj8Cb5Ug-1; Tue, 07 Apr 2026 03:18:58 -0400
X-MC-Unique: oN6b5BG2PR-wAkPj8Cb5Ug-1
X-Mimecast-MFC-AGG-ID: oN6b5BG2PR-wAkPj8Cb5Ug_1775546337
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-43b99add7f3so3086997f8f.1
        for <kvm@vger.kernel.org>; Tue, 07 Apr 2026 00:18:58 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775546337; cv=none;
        d=google.com; s=arc-20240605;
        b=KMzraGz9W07rLx6fjJ98rcRqqUY2ijN3wJu+dOSIyWdp+gcCMhcBX68lsWJTUof8rl
         mUpshl+pvQADq8fLoI5Zsv9ZiIih/oD4NHrkZB0s3ms5xGBw174W6s/iwZnIJwQGfGLn
         NxEJN0apiMAspu4id4Pdva42WT0EbFbHXuLX/L90zxWyBMyr8XVqWP51XN5JtbScOEsK
         1SHPxEzlU6PJ+q/Z4oGjPACjnvNXtuVS0g0n57NizyiNM29BXYQOfyZbDvbgn8NWlDQ/
         cAu1X/vqpu7mig99q4oyRZZ22bGAa0JdtmcV5q9KxAHL0hsXmWwm/BHe5LC2UWAhJ4YY
         reLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=mljjuQYWVEJA5/gTJORfrhvkCXmvQyM1a+kpTpApJBc=;
        fh=rdml2KXfc3oh/+on+3AHZkUTCMNC31mY8pftAilO+CA=;
        b=AVpqxgLpwm+NRQLTIZbJSGOMoyvTkhRLQCz/gt0jUD6VDyjbIVluUdrZ9QxBCW5ixR
         WBn3wX5/2Yz4XRjdTMF6G1wWxQKxewkYZU2HP4zxW3JpaCiQ1hQ+GgeDvGGiuTU+fPPy
         LIvPy7Zw9O2ZyefCG3fqSPbIHLbA3Svu2IsSLLbYYzc9tDGRK9zR6erfk7prPGj2TFbQ
         X7mY71GC5eMP5YIsYvbZM2t4AgszioWDN7KmihyfQwhOUKafXFNsUgwW/DJIRqvAFnss
         eTVQRZtxIbF8G6faQ0kdOLsuj7y4irZkFdVUuU508N3zlO64tFeOPrbEBjlDZXHe6NXN
         Qb+g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1775546337; x=1776151137; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=mljjuQYWVEJA5/gTJORfrhvkCXmvQyM1a+kpTpApJBc=;
        b=lECfIS/M+PVECnFb49X7hnCWEjvlJDCTAnyQjFZ+ffD7lxPup/D0usb5Js6ffM52Et
         ljwU/dSMP4hIjqio5chOtD/2bxBPUOjNYZexmA91lSacHT0csGKNbLx0bGXAuIERNd/V
         7uacCqqAXxiFWdWSwrKpp1uSs/mye8cDxBMm45vrBqUfw9vSWsnwHSaxDM0p7P7RH2XX
         R69d/AwOI2PBlWFkrMfzhqJatDtS7tsuKNJQ+5pqBHsFwfKo+udP52PzfzdSaFWA6n3r
         noWpZR73mbOa2YOy5Du57XKDAqNU3mf1ZFm1uoL69KaswI+a8OFec5eYwbRmVRKTY820
         oOCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775546337; x=1776151137;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mljjuQYWVEJA5/gTJORfrhvkCXmvQyM1a+kpTpApJBc=;
        b=Cx9X4fWgz+87tnMVbYtw70tTyoTzJwhvWONHfY/3sOLDHNpm1nRfdIN/mg0bjblwxx
         COhcjh8TZ5zo4rO5MFVraIZihBIzWwOaFQHyvNwxgpdTqsfQQml7m7Ih14lR/e0+DkBC
         nV8MisYFTjSnvRqshVIs1wFzrETYUib5T19AUL8Tvtx1roxJmrn52Xy6MJfOfNe6x9Bk
         KpDD7SnAecBjdEcsoyEhPcAtATVNm2udpZls1B37OozL7jab3s6UqIBAImQ98JF/hd9Z
         kIjFzz20EyxRPYcYwCEShYzXAajrFlGfJwMR22YWFZjR/UOJN8O2ho265EPYIAb6lPvo
         LEpw==
X-Forwarded-Encrypted: i=1; AJvYcCVH2XvwK6ZDmu4BPsNv4jrh5fXts0TeoVkfnh3aPiBih/1XVS4jfA7Un4xOAYkQDK/S1tk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy+PVFN9ErH96SkBYdl092lZBxBySXeDmH6fYpq21pf3/JPfKGs
	fOyOFRh4aWnQf6G2vC6vJZdgNXxXPqqK4SiMhEpQhBrCZ1QmUi8ok3yopHPupW6R3+dXKTSmnii
	cYphcv3AUrcGgvxrCwY9YkRjXSlYxcx0xDFhNYB9IDoiHM2jTMbzeeZy61jOMeoW/FQ64WWOigB
	ybf5d+pTlixtstCWBG38f3D78bEQC6
X-Gm-Gg: AeBDies9BEHbIBN4xxvFbxdmzNprGoGkf13hdxkVwexCVEqLghGGmm9mbfnIVMsct+K
	bLlG6ZArqu+7qKVAECuw0o7bUF2IwtTPF/1a8lISFeai5I+cvDOSKGCmBGr6UnxBzJ0cni2eqGa
	ZRuTneBwhDFMP9BRBLZ5bVangiaHqD5vbEI6kg7aW/IY1c36vp1dMshZxNRun5kJKqSB5zddjyu
	YxChBsOI89/TjESfuP54fj92fZpuQLkYcjLJXzoVbbNhPzHZCsbtBryHVfStUG++8yNJIzYQ5yV
	N52x
X-Received: by 2002:a05:6000:2886:b0:43c:fc5c:aa08 with SMTP id ffacd0b85a97d-43d28f95b8emr23587392f8f.8.1775546337105;
        Tue, 07 Apr 2026 00:18:57 -0700 (PDT)
X-Received: by 2002:a05:6000:2886:b0:43c:fc5c:aa08 with SMTP id
 ffacd0b85a97d-43d28f95b8emr23587346f8f.8.1775546336701; Tue, 07 Apr 2026
 00:18:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260311003346.2626238-1-seanjc@google.com> <7ec084f8-812e-42f2-8470-e416fa7ee848@redhat.com>
 <ac75iuf9gHIhvm9u@google.com> <88e9d7f0-35b8-4559-9f4d-c7daf1af6012@redhat.com>
 <aea176c8-35de-4042-bf98-e42ce05f93fb@intel.com> <CABgObfY05NU8DS82jkwpF89_p1nR7VJ30HBq_xaMg_u+-j=0Cw@mail.gmail.com>
 <adPRA4ZhnvbaXSn0@google.com> <CABgObfbLm3FR4f_nv5EyYJx4jwfeBaVgTLhr7P++hmhCP98e3Q@mail.gmail.com>
 <adQs4LQgy3mS2t89@google.com>
In-Reply-To: <adQs4LQgy3mS2t89@google.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Tue, 7 Apr 2026 09:18:43 +0200
X-Gm-Features: AQROBzBFAoXmOuQaya9SW3dphnVY0dfdZmgdgdkvSsxEIlf_53nmfMraq_tgj-4
Message-ID: <CABgObfaFqrSENS=_eNgkyxebqL1vFauNqG3XAgZm0EHfkbQ_gw@mail.gmail.com>
Subject: Re: [PATCH 0/7] KVM: x86: APX reg prep work
To: Sean Christopherson <seanjc@google.com>
Cc: "Chang S. Bae" <chang.seok.bae@intel.com>, Kiryl Shutsemau <kas@kernel.org>, kvm <kvm@vger.kernel.org>, 
	"the arch/x86 maintainers" <x86@kernel.org>, linux-coco@lists.linux.dev, 
	"Kernel Mailing List, Linux" <linux-kernel@vger.kernel.org>, Andrew Cooper <andrew.cooper3@citrix.com>
Content-Type: text/plain; charset="UTF-8"

Il mar 7 apr 2026, 00:00 Sean Christopherson <seanjc@google.com> ha scritto:
>
> > > .  So unless I'm missing something (or hardware is flawed and lets the
> > > guest speculative consume R16-R31, which would be sad), it's perfectly safe to
> > > run the guest with host state in R16-R31.
> > >
> > > That would avoid pointlessly context switching 16 registers when APX is not being
> > > used by the guest, and would avoid having to write XCR0 in the fastpath.
> >
> > For now yes, but once/if the kernel starts using the registers there's
> > no way out of writing XCR0 for APX-disabled guests in the fast path.
>
> Why's that?  So long as KVM uses vcpu->arch.regs[R16-R31] as the source of truth
> when emulating anything, there's no danger of taking a #UD in the host due to
> accessing R16-R31 with XCR0.APX=0.

Yes I agree with that. But the unavoidable part is the XSETBV because
only the assembly code can run with XCR0.APX=0. As soon as you go back
to C, including during the fast path, you have to ensure XCR0.APX=1
again if the kernel is compiled with -mapxf.

For now, I agree that early_xcr0 isn't needed and you can run all the
time with XCR0.APX=0.

Paolo

