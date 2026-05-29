Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DB5BC15C
	for <kvm@vger.kernel.org>; Fri, 29 May 2026 00:00:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780012815; cv=none; b=jDHvJMP9Q2OxlWpWwaJS42/IqbMheINyOeBMNq2flnZ3R7JjKywaJczDdCt1w5f6fGF+ED8Zn6mXQXqxd4T7ZPvXNiFo315MykS+MwD8bNRA8NKCXS4/UojJTMq+FJh4fhHHEik7pxR52KmznqX7q/UIRM4+elbWApC2zR52+sA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780012815; c=relaxed/simple;
	bh=rWoV7qik2IaqXzW+Cacx3cyJNWCC+SkOmfRtlPGa9Tg=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=A+Rt2SVBtqBWQ8iHC4NDwot2AsjRb9NvdX0e2KTn2qswrwBFtW55UqexljDlOT3/JtnwesXUwoBVVcIhIpC2QJZD9R6k00FHlnZ5gAerihHqOGi7N5ndM/7HBkoRuFSuqj/RhfJI74qD7ZpB9I7Oim0GluV7n5fwF5TFGXWLSiU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=aUx3r4IF; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="aUx3r4IF"
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-368f2d76b04so12523446a91.3
        for <kvm@vger.kernel.org>; Thu, 28 May 2026 17:00:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780012813; x=1780617613; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=0Rqo3eHgOAhV5jRPM5nRvROo1lqtOnvL3is+j05HUFk=;
        b=aUx3r4IFDBewEIxZQwF1SP6ZHwt9A0CTNdorGMBqwGmSiN6P256Jm9zU+/6WGGn0Mf
         vE3EjnpAC405ot6Rsufwxu0rmhd3yJ/MixkOBVK78O1zyTs8YmcRN3W0EOt0W4bQ7ypE
         A3Fmq0jVVSS/vhuzhwYtSGK1akr2gESj9uOy+AWgGdjV1QF2CQTH9CrqYVtZac1zwfKY
         3jvZDqdaG2ow9lWW+gVspCvc0ppsDWK8oH5foPkvouHWyJm5Q7GSUT3Y9Z1XjZC7cbg+
         fS5CWzwq7DWx7GhQV+JX6rIUUxZHIhWwxeUo3vIQe/aQJjMtT4iUeRq1U0Ru3Ie/xtcH
         gVQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780012813; x=1780617613;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0Rqo3eHgOAhV5jRPM5nRvROo1lqtOnvL3is+j05HUFk=;
        b=rlibheWL4gKkPoimOY7RabekFAAi3dlSlswwPJCFjkD+2p/pdV+p/yM6XVtLppQEIS
         saMjhcKWa4/RTkYf3U57FSas2ank0sFfEGAhZuPb/JRAg3497ggwsgAs5Ezv5fj+Jbog
         ZCmQ7JnbRyz4Slh4tb2SUj8hyysEIs8oXYyEfQzkYI+wSz+F6r38m3L4I3U+P55tgFPN
         iI6AKdBg6X2I6wN0V5GWQC4K9Kxo8jACu2+0XnmoRgFFnTHEUMAAe4JmhplNKb+CnQme
         xMiUaY0JRKzErahCkYoRpdJU11LQv8Nq3EmVrRSuAT8UYH6y0wbqbHSlDLtwHLA6va2l
         YGHw==
X-Forwarded-Encrypted: i=1; AFNElJ82sH9EVzkwYSnoc0XnkHv6pZkSF5LtPH5K8SKEa9PiMXLjChpBwk+Uu4StxJnvX5RPqMs=@vger.kernel.org
X-Gm-Message-State: AOJu0YyfoUl8PHsdJC7J/XZZC5vJ7nLr8eJB7FFTVr9dbHzEfprZGJSJ
	rU2oH8WXw81cgMw9mDM2SpadeBOM3JpsAuFPc8/kj4b8VHdfnddc59/sCBWtbChB1daG8oyzZKk
	4HHvRjQ==
X-Received: from pgbg32.prod.google.com ([2002:a63:5220:0:b0:c76:3f60:53ff])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a20:3d96:b0:3a2:f14a:4277
 with SMTP id adf61e73a8af0-3b411e1090dmr259151637.32.1780012813048; Thu, 28
 May 2026 17:00:13 -0700 (PDT)
Date: Thu, 28 May 2026 17:00:12 -0700
In-Reply-To: <CAKSQd8VrNC5F_7c8SCsuJHe1oFMJBCZc97Ez3ZAUfabUay8ZzA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <CAKSQd8VrNC5F_7c8SCsuJHe1oFMJBCZc97Ez3ZAUfabUay8ZzA@mail.gmail.com>
Message-ID: <ahjXDGrBcOGDq8kZ@google.com>
Subject: Re: [PATCH v3 3/4] KVM: x86: Virtualize AMD CPUID faulting
From: Sean Christopherson <seanjc@google.com>
To: Christian Ludloff <ludloff@gmail.com>
Cc: Jim Mattson <jmattson@google.com>, David Kaplan <David.Kaplan@amd.com>, 
	"pbonzini@redhat.com" <pbonzini@redhat.com>, "tglx@kernel.org" <tglx@kernel.org>, 
	"mingo@redhat.com" <mingo@redhat.com>, "bp@alien8.de" <bp@alien8.de>, 
	"dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>, "x86@kernel.org" <x86@kernel.org>, 
	"hpa@zytor.com" <hpa@zytor.com>, "shuah@kernel.org" <shuah@kernel.org>, 
	"kvm@vger.kernel.org" <kvm@vger.kernel.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, linux-kselftest@vger.kernel.org, 
	"ctpence@google.com" <ctpence@google.com>
Content-Type: text/plain; charset="us-ascii"

On Thu, May 28, 2026, Christian Ludloff wrote:
> > It appears it was a deliberate decision, due in part to the fact that the
> > traditional flow of checking CPL exceptions before intercepts typically
> > applies to using instructions in an illegal way, but the user is not doing
> > anything illegal here by executing CPUID which is normally a legal
> > instruction at CPL3.
> >
> > That said, clearly the behavior is different now between the vendors,
> > however at this point the feedback I got is that our architects want to
> > stick with the existing behavior unless there is a strong reason that it is
> > a problem for SW.
> 
> What is a HV expected to do for such a CPUID guest exit?

Emulate hardware behavior.  The only question we had was whether the observed
hardware behavior (VM-Exit takes precedence over #GP) was AMD's architectural
behavior.

