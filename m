Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com [209.85.210.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D516052D2CC
	for <kvm@vger.kernel.org>; Fri, 18 Sep 2026 21:39:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789767599; cv=none; b=g5vs6CcwyST2S+4ShDL7riP4UPdvvb7rvrRWKwYTfjrJ/tpeA56g0MXv08MeZwCplOxsHhA2CGw6KJPBTeyxPb020V4jOjHOJ2EtyNw4ON8vngs0nFy10WJv2vdC8PcA5KOSWVr0BmZ3yfopPTOLLiWIKmv6vcqPKsBhanat7BM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789767599; c=relaxed/simple;
	bh=WDOpZXIVt9pQyPqTZpP0iCkjC1msyyjE54/nCw/Nx+Q=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=BWTXqWH5cVBk6lZlAdh3oMCyNunzAj/2Vh+ZbKFqfJ5TWy+vXNDjlR9k/daWzLgXkSkMlXSmUlo4KBdHdLCtlIVzP2j4gy9T9eQNVKGhzJ6Um+2OVkG9NWF9sxoHvXUvkE9Gwn3LA1dlTR0XDwPbfDqTj87TXj6ZZ+aC3fGC2D8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=J+5kGlVN; arc=none smtp.client-ip=209.85.210.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="J+5kGlVN"
Received: by mail-pf1-f197.google.com with SMTP id d2e1a72fcca58-8623e5d4279so1847271b3a.1
        for <kvm@vger.kernel.org>; Fri, 18 Sep 2026 14:39:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1789767597; x=1790372397; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ZpQvTiCC5r8A/xyV/xvlxFgR0EjKycnB6uPqtIumT4U=;
        b=J+5kGlVNnPw8UdeIxNUKqIKEEF+oj/ke5ZpZCJs8BFS4VUpDFq6AgovNTLK7dd86RP
         OQhiKSi+0INL7w82hu1x7GEwNqnI6IWEJQt8Vm775MzZr33weiLTOHVbPJisma1vM/i1
         4Bz/+V3YgENHpTK3JlRjRpPIgzXJy/0tH6C8iW4wKmX7DVv8/aTO6m/cIgrODGjWZuBf
         jis+XLYyxJ+uGfxiRhyyi0C/9f3eULira0TzYbqbAgaIW/AJUs/i2NeW1HE90mkVOgOr
         9wCGWSObeWtWkcan+NvUGWFCREQnuWSTjVY8rIJSTjH1fCQkrqE6ptbwQ7QOH3gohR4E
         u0Pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789767597; x=1790372397;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ZpQvTiCC5r8A/xyV/xvlxFgR0EjKycnB6uPqtIumT4U=;
        b=zQtqTngCU4CdMlCKAJ5s5h1KI+Xauy3hWxylv8Iih+zLDa8IOALnVeUuB6VCndV+hn
         QBYLNu0vRDs4yC177tisX3eHKPM/HVPnRkP0aVwS/acuH1f26tGdeIvW+CKNbluLNK9M
         3rO28pQY7dveBrornnA6zMU2zLXRDQ69hKyXSFbhBKf1CNkIUvEw7be3sXNoJzGfIypu
         ALMRan1B67puO+HN3y7o7wr40j4LhaHl9wVYOZa13MuWc3tHNRY0wE4MDvSSw0QqZVSF
         CsCuv8kl13gFXRczVcHj7+7gWL80YAqm9SQU2yKe+x7wOg8xlXClu5kXAZ9g2yss+HqX
         J4Ww==
X-Forwarded-Encrypted: i=1; AKwUvBxy4sD+A0nFw0Dx2/t85YI1trL9CrZjo1L/87Gp5nty80ydKHvKNckowm/PTyFq8aRDatA=@vger.kernel.org
X-Gm-Message-State: AFuF++lo4IboaFccTLqqAu2N8R/GO0gdMcF+oah2zMplVtyqqwMLh7sV
	1kiPTi/UcMJVshUfKS3KN0kox15wM1eDLWWGRfncylHlSZDcw2nFEJ9aIyE+Vgzdh59yPfv2N/e
	+ZCcudQ==
X-Received: from pfbgq53.prod.google.com ([2002:a05:6a00:3bf5:b0:862:f6b8:73f3])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:3e1a:b0:857:7337:5db4
 with SMTP id d2e1a72fcca58-874dd9f1d44mr6950013b3a.18.1789767596925; Fri, 18
 Sep 2026 14:39:56 -0700 (PDT)
Date: Fri, 18 Sep 2026 14:39:56 -0700
In-Reply-To: <aq2ZCFXMDnUWwCuY@dev-dsk-absandze-1c-663c31a8.eu-west-1.amazon.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260918160006.61816-1-absandze@amazon.de> <aq1j0aUKpr15AiqS@google.com>
 <aq2ZCFXMDnUWwCuY@dev-dsk-absandze-1c-663c31a8.eu-west-1.amazon.com>
Message-ID: <aq2vrDkgfPGeJ-wD@google.com>
Subject: Re: [PATCH] KVM: x86/pmu: Don't retry a counter whose config was rejected
From: Sean Christopherson <seanjc@google.com>
To: Luka Absandze <absandze@amazon.de>
Cc: "pbonzini@redhat.com" <pbonzini@redhat.com>, "sandipan.das@amd.com" <sandipan.das@amd.com>, 
	"tglx@kernel.org" <tglx@kernel.org>, "mingo@redhat.com" <mingo@redhat.com>, "bp@alien8.de" <bp@alien8.de>, 
	"dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>, "x86@kernel.org" <x86@kernel.org>, 
	"hpa@zytor.com" <hpa@zytor.com>, "dwmw2@infradead.org" <dwmw2@infradead.org>, 
	"kvm@vger.kernel.org" <kvm@vger.kernel.org>, 
	"linux-perf-users@vger.kernel.org" <linux-perf-users@vger.kernel.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"

On Fri, Sep 18, 2026, Luka Absandze wrote:
> On 2026-09-18 09:16, Sean Christopherson wrote:
> > Hmm, would it instead make more sense to explicitly check for -EBUSY?  -EINVAL
> > isn't the only fatal error code.
> > 
> > diff --git a/arch/x86/kvm/pmu.c b/arch/x86/kvm/pmu.c
> > index a7d60c8785cd..5296ee8f32af 100644
> > --- a/arch/x86/kvm/pmu.c
> > +++ b/arch/x86/kvm/pmu.c
> > @@ -681,7 +681,7 @@ void kvm_pmu_handle_event(struct kvm_vcpu *vcpu)
> >                  * PMU refresh.  Don't make a new request as doing so can stall
> >                  * the guest if reprogramming repeatedly fails.
> >                  */
> > -               if (reprogram_counter(pmc))
> > +               if (reprogram_counter(pmc) == -EBUSY)
> >                         set_bit(pmc->idx, pmu->reprogram_pmi);
> >         }
> > 
> > Though I guess one could argue -ENOMEM is also transient?
> 
> I had contemplated this, but could not convince myself at a glance that
> perf and KVM agreed on what constituted a transient error.
> I have now concluded I was seeing ghosts :)
> 
> > E.g. this? (completely untested)
> > [diff]
> 
> Tested against the fault described in the linked patch and selftests on
> AMD Zen 3 (although I don't think there's much coverage in this regard).
> 
> If no other objections, would you be fine with taking the diff you
> provided into the tree or would you prefer a v2?

Go ahead and send a v2, I want to see what Sashiko thinks.
