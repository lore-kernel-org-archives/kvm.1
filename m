Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B4293ACA77
	for <kvm@vger.kernel.org>; Wed, 25 Feb 2026 13:59:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772027949; cv=none; b=RSNvsO5wR2p7JJteYLOfNzMvpr//pJOByxO3KzCPRUFUnfe7dPdKvcwGbmnFHVmSpLIBZgafIt5+1qva0NgwzyVw5dYhyeApnUuYcafeMHFHnjYVXUWiNtfNVVMOAajd6mofU3jxuFgUlKyvDlHEc8EkS9aO4Cub6vqedwbIDxs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772027949; c=relaxed/simple;
	bh=kUnsSf6fs3cOu9pmGJrE9E1cjS39vhoQ4IC7090/cMA=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=HRyGSGi0K9fJ7WLLN9qnFgwEvMCZ8GKQLt3XtL09TFSTGlOh3lHulYhc2va5L/GAkbZ7M2pEZlfAE8PQYbB0Pd5+Azq+Ma+sDt2KgjFLaT671RfYS9546t0zK9CrcQf9aUWAu+GXprFB2tQgVM3uUAt2JGsWER9poOsxa7wHylE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=xLyVAlTg; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="xLyVAlTg"
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-2a944e6336eso415585525ad.0
        for <kvm@vger.kernel.org>; Wed, 25 Feb 2026 05:59:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1772027948; x=1772632748; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=nDEZNV3YXPdpDxBVV0b0e6H2LhU4cBUkmu8+IMpXwGY=;
        b=xLyVAlTgkkPrG1L6mBw2ysPXzQi/V2MW1GTTL/94hL7h8V/owtDZHdyeMLb8By9MGo
         Dg9GLs6cwx/ViQi5++JkqWPZ0qdCmW4U9lU6BVG9Hi6xxuygRntBugPb1kdvTIuIXA7p
         xay16Sd6SLYWWeiuc++tYNNHR3Ksc1gb7p0r3SAgWGHtKyvGIbJAmHzGhuiCv8bre5qL
         qXvPyA7j4Bbbyx/n+za80tJUy31mIDGN5e6dFeM+sIYDBbhJXSJSjPDtsZJZzcz04r6U
         H4tcRtXCg9/Hdgp3xyret3daOC6qrzjQgh8BGUDaL+vQG/YT9tu2m9CuWnKvVt5JqEAP
         31tQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772027948; x=1772632748;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nDEZNV3YXPdpDxBVV0b0e6H2LhU4cBUkmu8+IMpXwGY=;
        b=Jvqf5u9xOumIGUJ/aQ4ZzDAWrLTvuhYHXPst3879uwZ4ziD1FccJmYgB8XB89XbtPa
         ScyDPidZLJqYK327C94qsf9saJbzvF8GdfXGmmNcGuNav/w9ePeMdABGdLGdys18Z+yc
         RNSTEc6c5C4utGhNZi9DE5WX5GIgpWu5dvpQ+TiFiv2a3Buy2/w86bAiMI+CsrK1lRae
         Np/PSBxABsztvmBY8NIFJkHkyK1UciukL3WzRnYwdgXy1NSUyfB87TGg+xfaqLk4/SOk
         QubMbOn2dPUvJ0cMabVG1KKpy+Ubud9rSB5nRp+xxM7Ugqzy6/9Xaukj0p1VXvw5kDTw
         c73g==
X-Forwarded-Encrypted: i=1; AJvYcCUnToBPxWwN6Zz4xXzEdnbmbdpxVf7KP9N+DuPU+TDu74Na3eMwMs5bxMuHq/whpjt9qMs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz6GHQ+fGSwYhyEA9BrKoC2rIUEehOvdov2RuSr01uUxvrCRwLI
	VwIEPWgWec4ESWCrhEWR/0bW1Fu1Qqk1FxL9FcReEMXB9BYVR24zmK64FMfVFCYlw3IjELZMJDk
	Acpl1yg==
X-Received: from plgz12.prod.google.com ([2002:a17:903:18c:b0:2ad:ae4d:4a00])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:ec8d:b0:2a9:48ce:b5f5
 with SMTP id d9443c01a7336-2ad7455eceamr134638165ad.51.1772027947782; Wed, 25
 Feb 2026 05:59:07 -0800 (PST)
Date: Wed, 25 Feb 2026 05:59:05 -0800
In-Reply-To: <66336533-8bee-4219-9936-3163c7ce06bb@linux.intel.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260223214336.722463-1-changyuanl@google.com>
 <213d614fe73e183a230c8f4e0c8fa1cc3d45df39.camel@intel.com>
 <fd3b58fd-a450-471a-89a3-541c3f88c874@linux.intel.com> <aZ3LxD5XMepnU8jh@google.com>
 <66336533-8bee-4219-9936-3163c7ce06bb@linux.intel.com>
Message-ID: <aZ8AKZQ4L5n7wVMT@google.com>
Subject: Re: [PATCH] KVM: TDX: Set SIGNIFCANT_INDEX flag for supported CPUIDs
From: Sean Christopherson <seanjc@google.com>
To: Binbin Wu <binbin.wu@linux.intel.com>
Cc: Rick P Edgecombe <rick.p.edgecombe@intel.com>, Xiaoyao Li <xiaoyao.li@intel.com>, 
	"changyuanl@google.com" <changyuanl@google.com>, "pbonzini@redhat.com" <pbonzini@redhat.com>, 
	Binbin Wu <binbin.wu@intel.com>, Isaku Yamahata <isaku.yamahata@intel.com>, 
	"bp@alien8.de" <bp@alien8.de>, "x86@kernel.org" <x86@kernel.org>, "kas@kernel.org" <kas@kernel.org>, 
	"hpa@zytor.com" <hpa@zytor.com>, "mingo@redhat.com" <mingo@redhat.com>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
	"dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>, "tglx@kernel.org" <tglx@kernel.org>, 
	"kvm@vger.kernel.org" <kvm@vger.kernel.org>, 
	"linux-coco@lists.linux.dev" <linux-coco@lists.linux.dev>
Content-Type: text/plain; charset="us-ascii"

On Wed, Feb 25, 2026, Binbin Wu wrote:
> Do we need to consider the panic_on_warn case? I guess the option will not be
> enabled in a production environment?

Nope.  That's even explicitly called out in Documentation/process/coding-style.rst:

  Do not worry about panic_on_warn users
  **************************************
  
  A few more words about panic_on_warn: Remember that ``panic_on_warn`` is an
  available kernel option, and that many users set this option. This is why
  there is a "Do not WARN lightly" writeup, above. However, the existence of
  panic_on_warn users is not a valid reason to avoid the judicious use
  WARN*(). That is because, whoever enables panic_on_warn has explicitly
  asked the kernel to crash if a WARN*() fires, and such users must be
  prepared to deal with the consequences of a system that is somewhat more
  likely to crash.
