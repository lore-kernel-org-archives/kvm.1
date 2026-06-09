Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4D911E0E14
	for <kvm@vger.kernel.org>; Tue,  9 Jun 2026 00:31:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780965088; cv=none; b=WJktomxgA9d8xYSMXYEnzss3ypGkbx56l39c4TB3lIgVorXEm2IhmeOZym1i2aI1IzJU4f6rYcJHOTS1AODl7pl3N6WJEoJ9Tv+Dg5q5Pm5J39en75GYD/59XwzUt9p57u963MIkGcC6I78nnXeAyXznfWakmcXG6HHOEQMOThc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780965088; c=relaxed/simple;
	bh=yIJ6TQJxT7dONmA/83aONXNhkBdZrn6zCKFw130M9Q4=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=KYj9ep0UWFNAa2J8iYGNU/eDy9tC/k8bI22eY8gjesXNkmsJeC5fFJADHffqYrL5idyIOHCUg6XcSQwXpnF8dx08YqVNRtFSGnmvzhcfr2YGOxuVwvJZfjku/IuPFKojFBS/LlwM5wGKMfd5JWXyJYtqnZV2rlQMRiXEL+fuuU8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=leHyf0cd; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="leHyf0cd"
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-36d992fa39eso6029515a91.3
        for <kvm@vger.kernel.org>; Mon, 08 Jun 2026 17:31:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780965087; x=1781569887; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=p2pVFo4dJytLODVsSoHOHadkmK9decmDzlODrRei+YU=;
        b=leHyf0cdogosuxxRPjbyiB8XJyMDOjXYEh1zdkbpSjrn/myRf1p2V0bAWPZ3I46xAd
         HU8+F0GSG/0gImPb3sRwhzzgknD8mtFSt4HyG1kd22w+9iQa2GnQWCnU228N78WaxMJN
         Vc5D1xHt4WSYR33XTspNrBWZ0lNGlVBAAHlDPCZjFea8VfbL2KcjmvLFTvGHKW7Cc/Jo
         6svmRjNKIYkODQZpsJhnGnZVkSAr6zUCTmdUA1avO3qm3H7gOhhyiWp3wqvP42QUdkHR
         bLUSVPnNwYEoOaUjQBAkuV11UyMNWzwjOoBgEvpwo/BpVleCju/Ueijr8+SCbJ70vbAW
         0LTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780965087; x=1781569887;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=p2pVFo4dJytLODVsSoHOHadkmK9decmDzlODrRei+YU=;
        b=DL9I6I0CWCAAaWIemdmGwGS8lVlZC9m1iwvRdJSaU9hQQKnfZM+qJefQk8k3xjWmNt
         Kkjb2JWb8iSFkFtrFJNb8q6oSvVy7fChMzK2HlUcjID8TwopjhMkLE7YjnT8lOXEOORT
         IvPSV5D27GtNtz3dtaGkavXYtNNyYVppqOmVTOI/BEnXKFBG6rzXZPpw9beVaMX+1uyh
         pKhzoiOCNf6+UFz6Lh1LuRA20q9kd8dKK3KU+02E9HLJAh3befAAlCOaH+uoOPR93HAJ
         EhRkluGVXH/6AJ8xo36RD+b8Qh+BPWfk0s8jA7fnUJwvmrkM6YNOHAlAWScsCfgDrpJe
         DucA==
X-Forwarded-Encrypted: i=1; AFNElJ9o4l5rpYNRJGTrvRg5u9wADgECDi6XJvBk54/7SbAsp7UYQ+GHaq7igIpZ3ZIUXabxxV0=@vger.kernel.org
X-Gm-Message-State: AOJu0YyTqU99N3yXAKA3Ct8ujwgwDodHbHRahdN2gJ8n8vHev8H+Y+sJ
	Ag96SNwLa4+CyVQllAsm6R1ZikRp69DbdOxEbhz0i0lcak2jqWEU7xzBZSAdPLyFy2Ty+qPjoad
	3irxb+A==
X-Received: from pjbfh16.prod.google.com ([2002:a17:90b:350:b0:36b:c7cb:baf])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:58e7:b0:36b:936e:73c8
 with SMTP id 98e67ed59e1d1-370f0e4ad33mr20840879a91.19.1780965086844; Mon, 08
 Jun 2026 17:31:26 -0700 (PDT)
Date: Mon, 8 Jun 2026 17:31:26 -0700
In-Reply-To: <20260530070848.158521F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260529144435.704127-27-seanjc@google.com> <20260530070848.158521F00893@smtp.kernel.org>
Message-ID: <aide3ppnmB_suEab@google.com>
Subject: Re: [PATCH v4 26/47] x86/kvm: Don't disable kvmclock on BSP in syscore_suspend()
From: Sean Christopherson <seanjc@google.com>
To: sashiko-reviews@lists.linux.dev
Cc: linux-hyperv@vger.kernel.org, kvm@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"

On Sat, May 30, 2026, sashiko-bot@kernel.org wrote:
> > diff --git a/arch/x86/kernel/kvm.c b/arch/x86/kernel/kvm.c
> > index c81a24d0efdf6..fd1c417b4f9b9 100644
> > --- a/arch/x86/kernel/kvm.c
> > +++ b/arch/x86/kernel/kvm.c
> > @@ -460,7 +460,7 @@ static void __init sev_map_percpu_data(void)
> 
> [ ... ]
> 
> > -static void kvm_guest_cpu_offline(bool shutdown)
> > +static void kvm_guest_cpu_offline(enum kvm_guest_cpu_action action)
> >  {
> >  	kvm_disable_steal_time();
> >  	if (kvm_para_has_feature(KVM_FEATURE_PV_EOI))
> > @@ -468,9 +468,10 @@ static void kvm_guest_cpu_offline(bool shutdown)
> >  	if (kvm_para_has_feature(KVM_FEATURE_MIGRATION_CONTROL))
> >  		wrmsrq(MSR_KVM_MIGRATION_CONTROL, 0);
> 
> [Severity: High]
> This isn't a bug introduced by this patch, but I noticed that
> MSR_KVM_MIGRATION_CONTROL is cleared to 0 here during CPU offline and system
> suspend, but it does not appear to be re-enabled upon online/resume.
> 
> Since this patch introduces the kvm_guest_cpu_action enum to solve an
> identical state-machine issue for kvmclock, should we also use this action
> enum to ensure the migration control MSR isn't incorrectly cleared on
> suspend? Otherwise, wouldn't a single CPU hotplug event or a suspend/resume
> cycle permanently disable live migration for the entire VM?

Looks like.  That's someone else's future problem though.
