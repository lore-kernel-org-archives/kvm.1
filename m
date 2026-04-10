Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F34B1DE8BF
	for <kvm@vger.kernel.org>; Fri, 10 Apr 2026 17:19:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775841581; cv=none; b=ZX2LCsFrnaCyoyQqggdDtcIgubORfCTE0PABLcHWqQK3hfsi1AexyIb/OAwQQfMgHz44iRhBHat0vQF2byhAmS2YwKRJ8/Yn/av43q+n9NPmBpA/Q8ljNA6BcKSwt+c/Yl/RwnSngRuu/NhEPxRYkbqfVcr2oJZM0DrRwtORmoQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775841581; c=relaxed/simple;
	bh=XkQw7K5htpWH1fddaUGY3qrXKXjPpUdxKs9w6Che+Nk=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=tb77O4iZNHsUrdmFsgmCfG9EdHqqmJvXXPMvU/L5rAr64VA5kjoPuFkOpPKYWHEA6hNFC4/CsqIr8XYnso05FuqR3cmGEsQQqIJpkMhU7Hmus2FOdT9b6+L03iDL+XDwaw2Yk3a2wFr4FK0ONYPuRnA4UnnWQceXd27ama3VZmk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=MTlByGfL; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="MTlByGfL"
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-82c4664f75fso1695745b3a.3
        for <kvm@vger.kernel.org>; Fri, 10 Apr 2026 10:19:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1775841579; x=1776446379; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=XLxlE13jEDOdQZGu/7G7JsC/KT4/xAMBF+3XiLWg5ZU=;
        b=MTlByGfLedKf9EVpO2WALIrTleOCfo26d06e/MDnHDba37VV7gM18Fh9zXVunlF5Yi
         zC8LdlpkX2llPyL8ooGOEqEZydoImLA0zgFaWy98xEXr5dT0nRDxEAfQpEIoZXq2SYm+
         nAoaeyKPlydQsbdXmYNB7KBJtZ8rVzoyy1bqYyyJpHPQcvGSh/f/4sXTq3bIjNStUt4m
         TaTjZH8N29G9+HX737EzGpeLL68Abs0ev9LGTKzAWP4aUtsI4TC0L7E5a+T5GvyMQyxy
         tb/reBG4B748WJNuRKLu+TF+usI+kRunbQolibPoHe1saTR5okLJKJimSKPMFRibKvlD
         k3hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775841579; x=1776446379;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XLxlE13jEDOdQZGu/7G7JsC/KT4/xAMBF+3XiLWg5ZU=;
        b=TZqkEriCZmlpCT5K/Ru1O9DX7GX3+14W3h3RkZiXTaZXicU6vFlNZz8lktlg8sQso0
         IJVanborgu2IT1MAHcZzc3ew2vF8u0YCRLnoSGDc+kVo5hBozg+/08Mg+amBJxaympwK
         avsz/HCs/TpZkoFY4zPezjZAWmIPyDepQzMArAmTHhJ8I+sz9Ns81RkjWlU52dXmkcdQ
         eqCYpBO5E1iFqiKpsH2l2hHgj5jfpkb8y4TUw5v0rNMWJmRg1ao//GHyLAkgRDya9bDV
         +NO0eHhFjmxbHAk5aukZ8WZVd+POEd50CK4nE5bqFxN+OAIdsA5N08VX/GRA2BEGiuUb
         W3xA==
X-Forwarded-Encrypted: i=1; AJvYcCVyTrXlmw1W4VmCfk3W8Ez3e0yY+h6H/YXSVIg84zzVMbu+ZOgT5s9wwtHgOf3hBDf5Y/c=@vger.kernel.org
X-Gm-Message-State: AOJu0YywtvXCF0tgI4MIv/jWkMmsrHoXg8lgJ4yiiEUpchD9/ZhaaEEG
	oqKYI7P0kGm9IyxInkqLqiDzF9Z/+OKYhw86zMFewpwDs3JKTIiLO0/e7W0KvK1Nq+Sbgio3ZLg
	o+ZN5eQ==
X-Received: from pfqn30.prod.google.com ([2002:aa7:985e:0:b0:829:700a:a1d2])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:8c13:b0:82c:26a4:df02
 with SMTP id d2e1a72fcca58-82f0c25353fmr5052775b3a.42.1775841579316; Fri, 10
 Apr 2026 10:19:39 -0700 (PDT)
Date: Fri, 10 Apr 2026 10:19:37 -0700
In-Reply-To: <adkqDG_2UouUjDFD@blrnaveerao1>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260409222449.2013847-1-seanjc@google.com> <20260409222449.2013847-4-seanjc@google.com>
 <adkqDG_2UouUjDFD@blrnaveerao1>
Message-ID: <adkxKVIFnOyG3umd@google.com>
Subject: Re: [PATCH 3/3] KVM: SVM: Only disable x2AVIC WRMSR interception for
 MSRs that are accelerated
From: Sean Christopherson <seanjc@google.com>
To: Naveen N Rao <naveen@kernel.org>
Cc: Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"

On Fri, Apr 10, 2026, Naveen N Rao wrote:
> On Thu, Apr 09, 2026 at 03:24:49PM -0700, Sean Christopherson wrote:
> > When x2AVIC is enabled, disable WRMSR interception only for MSRs that are
> > actually accelerated by hardware.  Disabling interception for MSRs that
> > aren't accelerated is functionally "fine", but very suboptimal as many
> > accesses generate AVIC_UNACCELERATED_ACCESS fault #VMEXITs, which requires
> > KVM to decode the instruction to figure out what the guest was trying to
> > access.
> 
> Not sure I follow: as far as I can see, most writes are actually trapped 
> except for MSRs that are supposed to be RO?

Yeah, that's what I was trying to say by "only for MSRs that are actually
accelerated by hardware".  Oh, but that's bad verbiage, because trap-like
#VMEXITs are also due to lack of acceleration, it's specifically "software is
being stupid" that triggers fault-like exits.
