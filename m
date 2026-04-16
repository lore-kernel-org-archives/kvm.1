Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03C8D286AC
	for <kvm@vger.kernel.org>; Thu, 16 Apr 2026 00:31:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776299493; cv=none; b=ndWugRdo0XxjAQWM8iPuw5oqxcuiWRWbcGJ9N9FXqGGy05pdoV0nNIMLDCX8C5vEatmx3EADoEF+lcL7EIPKUTE/76PpVVGuG19jf01vLwIKXfcR8fjlRTHcLPE2ONRVkN+lssLL++675Fz23QVNcdgHUKX5Fg7yR6CeeeJqmO8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776299493; c=relaxed/simple;
	bh=IvOg9GYktEF/5/EJg4wjsPAg6BQSmYGdlvgvZ16chJ4=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=ITE8MKFzLvzgxqUmR1OdteqPXXzW/xnilmz9gZg8ji7RV7Kj6O/fzb2VtiGalOij6OCHuifgnCknvLIF4+GwgrT9vNaux0AJeg01vdmSeGtauaWiZKXFNpZpZnfFBc7J7x0Kdqe1kHgeqRCwJcj9Ax5zoaikgwS4vxC1FioTCxQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=BccHER85; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="BccHER85"
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-3594620fe97so19470838a91.1
        for <kvm@vger.kernel.org>; Wed, 15 Apr 2026 17:31:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1776299491; x=1776904291; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=HYei+ZT/wKyXqut2Nf35hAKF2yfzxuNDbm1r8pWJmmI=;
        b=BccHER85eperPH18yyOFVc7upiXKiQiC/2BdmIKJowvho6v+aaoqWItWQAnt99GUjY
         NBlYEUv7cN1L7hYoonpnupCWskUK9pRSC96XoV5xkgG55uBeKHBzxVWu2GqH1UbebyyK
         aoNaS9Rzwpqk4TorjR74Alvx8/luT9QUgINhQhTgG5wF7NGTth+5JO2f+CIDCh597MOX
         7OPlKiT2zhE5Uw004mx6ds3nzch7HYRHML2xvjhzEAoBMqluqKuxCHU+kNl/zeFUEM0G
         VobBDm7+4343/2ohD1Wyt7qyW8x2VSlYcajKvivBMwl4yYY8e6CiYHkBiM20C3PHVc6A
         COew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776299491; x=1776904291;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HYei+ZT/wKyXqut2Nf35hAKF2yfzxuNDbm1r8pWJmmI=;
        b=UPCF/xlG2ygJ9AaggUK9JV07qaHbde4pL/EhvTOYdW3j/tmxLWhdCfjst2I5v/Cgxs
         DyJIyXpzx0vIfJtU5LaP6HYiufFBAnQZ6wj5Ua7KE5hP57H4Y+IBC8Lm01CGKEl12lyT
         R+V3MOVuN7dTAFxhdFbQcHN7uWN3h1jGOvS1fN0NyoYQrjXNTwXQUEm1XdBErH+LsXy5
         WcvKkDGkBjRxDmjbn9H0v22Aus+U8vMeC6z9snzITT9vn4dN5+l0lfdDm/iG/eS3z8zI
         KGorUFSxItnVaQ7CKx5CU7uq3dQjP/EZVxPOO9UiOA3quHccmwkd5a/d/4llnhFOHM7+
         O0+w==
X-Forwarded-Encrypted: i=1; AFNElJ+sZEG1WSxpTjL9sHIgnblebvtAH7sP8Tv0zhgxfG85VA68APMG73h+RLUYaUhn7JHiEVs=@vger.kernel.org
X-Gm-Message-State: AOJu0YzgevPFYFUl/5/weF54d4MQQSn6IIrcU64oEzg/XNqxsXKDTiCz
	GApRcPSVN3ybxRJiO1Rw1zFJEYy2RHozCPIHJLRZXMiULBWbXlxpSlP0ShRgSlZOiIfIDCjQvpV
	zet1UDg==
X-Received: from pjbcp15.prod.google.com ([2002:a17:90a:fb8f:b0:35f:b110:52c3])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:3b49:b0:35b:ea35:c3ce
 with SMTP id 98e67ed59e1d1-35e42867ce0mr23466571a91.27.1776299491256; Wed, 15
 Apr 2026 17:31:31 -0700 (PDT)
Date: Wed, 15 Apr 2026 17:31:29 -0700
In-Reply-To: <69d977c0b367a_6c31a10021@djbw-dev.notmuch>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260407180107.1603697-1-pbonzini@redhat.com> <20260407180107.1603697-2-pbonzini@redhat.com>
 <adf29Rn7q9Db0hxc@google.com> <CABgObfZQ8kcdfiaUyGi6AcZErJztEmcdTcLwo946qtXfUwDM4g@mail.gmail.com>
 <adkFk3ZN4HJtpLA3@google.com> <69d977c0b367a_6c31a10021@djbw-dev.notmuch>
Message-ID: <aeAt4b-QvpcwtRwQ@google.com>
Subject: Re: [PATCH 1/3] VFIO: take reference to the KVM module
From: Sean Christopherson <seanjc@google.com>
To: Dan Williams <djbw@kernel.org>
Cc: "Kernel Mailing List, Linux" <linux-kernel@vger.kernel.org>, kvm <kvm@vger.kernel.org>, 
	Steffen Eiden <seiden@linux.ibm.com>, Alex Williamson <alex.williamson@nvidia.com>, 
	yilun.xu@linux.intel.com
Content-Type: text/plain; charset="us-ascii"

On Fri, Apr 10, 2026, Dan Williams wrote:
> Sean Christopherson wrote:
> > +Dan
> 
> +Yilun
> 
> [..]
> > I added Dan because the PCI TSM stuff is picking up "struct kvm *kvm" references,
> > and I want to head that off too, i.e. have it use the file approach instead of
> > whatever it plans on doing (can't tell from the code, because there are no users).
> 
> The PCI TSM *reference* for 'struct kvm *' will be inherited from
> vfio/iommufd. However, the TSM driver needs some context to manipulate

I assume/hope it just need to read "struct kvm" state though?

> the VM. For example, TDX effectively needs:
> 
>     to_kvm_tdx(kvm)->td.tdr_page
> 
> ...for operations like TDH.TDI.CREATE that sets up the context for the
> privately assigned device.
> 
> It could follow the example of arch/x86/kvm/mmu/page_track.c and do:
> 
>     kvm_tdx_tdi_create(struct file *kvm, ...)
> 
> ...and use file_to_kvm() for that limited helper that does not need to expose
> 'struct kvm_tdx' outside of arch/x86/.

Any idea how many assets do you anticipate needing?  E.g. is it just the TDR
page, or will TSM need a whole pile of information?
