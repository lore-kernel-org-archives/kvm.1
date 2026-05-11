Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BD83313527
	for <kvm@vger.kernel.org>; Mon, 11 May 2026 15:26:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778513207; cv=none; b=PEdTED+F0tv8BjUc5QYlUOLWAyrSOeGb0CgJHqkroS4nIK7fCSwyy1CFfGro1I0qi2IJxwy3IZM6d8SPxgu7OizZvW0D2/he8fh2u+C2/QaySN0uPPa58sjhqnlvKXuigcWj87I52Al6dSB2JpyZ8rXg6fyV1UZCSzF03muQa4U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778513207; c=relaxed/simple;
	bh=EVGQBFnCbsVY8vbHyNkqosEcwobSxzxO9GYSmsZfAEs=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=TlMWfIkrdvFs9P6OfmqCu8Mcs8d/PP7Sa3RoCK19ggt/pQ8tsgOi568jYG8lMiuFs4eimH+DqXkVXq69ainMAh/TuU9oYUh1DlJQRwZRviNbL3lwPqosTL6K5vnZkgk3AW09FowWTJN2SQiX5vZt7p7eTBPMu69yGzV9JwWjk+M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=fyno1bjy; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="fyno1bjy"
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-367bb9caa54so2966766a91.2
        for <kvm@vger.kernel.org>; Mon, 11 May 2026 08:26:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1778513206; x=1779118006; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=IQeOfCyHnrflTOE6yggnDxqOQUwTa+dStzfI6q5y8Gg=;
        b=fyno1bjyWgZiiMN9NLjBM3SBkIsp/TBEfqJogxwbi2H+h/dEKD/snpubkZCj3v0GaU
         EpJLsBlbPJ6zvMkSAP3BZqmphBj0E8eHYMEbNTyn1lr39PuETyzMbqNRIMyeBATpgQ5P
         tIlZDT5ZY5peqtDEOlyz/euGOk3JNO4IO5lliADEMziBQT0RO825EMZ2ACgIzEHk4AwX
         jdL5eP/l6aedjcBa/skQJ7S2snNPh+bkWV5bvsV5uudyZMriJnI1cyO6IlRRkNeRowAy
         hj32Gttg3fs0gR7KEw629YVnZIBocDz6RCaKBHHKKIzKbtns6C2/kirQnU96Fj/0vtgI
         dZRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778513206; x=1779118006;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=IQeOfCyHnrflTOE6yggnDxqOQUwTa+dStzfI6q5y8Gg=;
        b=ruEaTr00uGtbJ3bFP6z4YghCJoadVg/oqn5Tu7ckhve7ZgIgCnLViNkiu3TVYIwb/+
         g8Yq6Qv4wv8eFEOEf6JM4dFttb8PDOvsbFoUZ3zwsL3rnxvUToFMIaCn8rCfIkmUxOq9
         Qvo2aO1dr1hb7cSvyuhlNJ0kTRm7pP9uy2vFo8sIr/oBIaCLG9YmtEqoOQyXIRKB+2mh
         az1O3o3MlHKH4XLGI/GzFD2TJqDoedxJAcjJg0Std/LL/2S/jt2eevu0SlNk+rFED1nM
         UQpet/iByHSGHh6f3oB9EIMlbf+xv3jOOWK+Xl1SoHjhEkVEtMNBcPF5WbVJ1+GxYSH0
         Gpww==
X-Gm-Message-State: AOJu0Yw7xv8PcuUHk1Ar3/G66ozYs1hZeAy/lngdZ+i4bb4XET9V8Hw0
	9Md5rCCWTSliVQSJ63CYFeF8CFeVlaYLBbosuYUGAGtNMpDMjqsCryX5Gw5VydFGg4hm+3Nckdl
	IP6/yLg==
X-Received: from pjbfz8.prod.google.com ([2002:a17:90b:248:b0:367:e13b:f33])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:4b02:b0:366:3df3:fe45
 with SMTP id 98e67ed59e1d1-367d49bbdc0mr10422061a91.19.1778513205663; Mon, 11
 May 2026 08:26:45 -0700 (PDT)
Date: Mon, 11 May 2026 08:26:44 -0700
In-Reply-To: <agH0itaqWpc90adG@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <cover.1766066076.git.houwenlong.hwl@antgroup.com>
 <9b859ab6a6b59e5ccfdac741459117996fe2da6e.1766066076.git.houwenlong.hwl@antgroup.com>
 <agH0itaqWpc90adG@google.com>
Message-ID: <agH1NMIENm0CIN9t@google.com>
Subject: Re: [PATCH v2 2/9] KVM: x86: Set guest DR6 by kvm_queue_exception_p()
 in instruction emulation
From: Sean Christopherson <seanjc@google.com>
To: Hou Wenlong <houwenlong.hwl@antgroup.com>
Cc: kvm@vger.kernel.org, Lai Jiangshan <jiangshan.ljs@antgroup.com>, 
	Paolo Bonzini <pbonzini@redhat.com>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, 
	Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	"H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"

On Mon, May 11, 2026, Sean Christopherson wrote:
> On Thu, Dec 18, 2025, Hou Wenlong wrote:
> > diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
> > index ab298bfa7d9f..f33ce947633e 100644
> > --- a/arch/x86/kvm/x86.c
> > +++ b/arch/x86/kvm/x86.c
> > @@ -8925,7 +8925,9 @@ static void inject_emulated_exception(struct kvm_vcpu *vcpu)
> >  {
> >  	struct x86_exception *ex = &vcpu->arch.emulate_ctxt->exception;
> >  
> > -	if (ex->vector == PF_VECTOR)
> > +	if (ex->vector == DB_VECTOR)
> > +		kvm_queue_exception_e(vcpu, DB_VECTOR, ex->dr6);
> 
> This should be kvm_queue_exception_p().  I also think pivoting on DB_VECTOR is
> the wrong approach. 

Gah, never mind, didn't look at the next patch.
