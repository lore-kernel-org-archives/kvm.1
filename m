Received: from mail-pg1-f202.google.com (mail-pg1-f202.google.com [209.85.215.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E6903C13FD
	for <kvm@vger.kernel.org>; Fri,  5 Jun 2026 20:32:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780691554; cv=none; b=RMCF/NNSuG8DdsaJphioblVEYjEOjzfw9ulLx7OW8FXxB2WOrANHH2ePm8HOhWhfIiMUo31gqai+2aJPA7oLtxLGEOjtu2tp3O9aLuHmVC6H6/Qa1URLal6gCIHmeXxSJWhH9ULQp7RfQBcP7F1SI3Z2N/gaklO1Unj8jj7OpbU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780691554; c=relaxed/simple;
	bh=xBeTeNgOMhbVCxDyTV9Ycy9P1eFTWTr4AHqZNcVLI4Y=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=e15BrLXm6HeQA8Jn80hOXsJ4M8v40Bc7UgKpNnctKs/bMiGNFOe7H4ZilelNejcecxMKwuWlsEjhjM886kpk3POOjsvltZasNpgFqgKwwB6CYuTiZH3cRVBddaUkL/JB+G36DJe5BxL0CJ/0TIGu5fsuTjoq4arSUNLrFuuwWIo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=TXq7zZyD; arc=none smtp.client-ip=209.85.215.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="TXq7zZyD"
Received: by mail-pg1-f202.google.com with SMTP id 41be03b00d2f7-c8604fbe71eso2212996a12.3
        for <kvm@vger.kernel.org>; Fri, 05 Jun 2026 13:32:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780691543; x=1781296343; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=6/Jk6A1lSCRKf4bHG005bLI05hHS5HnTN0oBfxEaA1s=;
        b=TXq7zZyDo+r58s7tCNnsuzOokk2o7B2m6eU/zo1rxTTr8MB23rMhCAkit/WEoLfyiN
         5J56iMeSzmCTSAfG21SmKfdofk8TNwDoRGkT0YRUMX5960Zh6F4hZxHKWFIG1awH2/c6
         KGC3PjBWZ/RC91iBXIOt3RdTUimxNhfntL0dfkGKnEGyL+3+dIDAJcBIIop/TcQKptSy
         ndtPxGkZt/DhZhQROM/CJjtjiVf3h195jO4ijn2/5yiJTtBsP7ylQlXx6KGG0AKTsSB0
         8pcfxdgH5J/aOo9x7pNg8ADKip95+iGxHnjItQfmZH+wmgNassgHeElNR3lWkmR8k5xT
         wuZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780691543; x=1781296343;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6/Jk6A1lSCRKf4bHG005bLI05hHS5HnTN0oBfxEaA1s=;
        b=sc73edMftO4EgIv4ODigng8+7ZlGjt1Me7Knh327FT0aNZAETxGpsf6ahkn/2/3wru
         KUChz0lqp+GkG3bCY9z5tAXjC0R2fCjQbL/TaywLZKvdxqql34okInyNvqlOU+RkykQD
         zdRIDjGAxuY6PJusvChw8+hNaRcNx8xmCDz5UrjIBgrlIE8UFKOFHPDi7/c0JjzN1ynk
         g7YYkmIds3tPInv2Md2CGa1IYcHSsz1jvdgC3PBv4Sw+Jmz6EWW9byRi3ymfC7jsuEj8
         n3XD9RB4EHOu4pUVOfCNtjb7sa979+68ye04gpM/XqsIto3c0y4xBbadGYeQk3kATimz
         9gWQ==
X-Forwarded-Encrypted: i=1; AFNElJ978nqRZlzjYYvsIJxwr7cw0sUlmeUweowVPIO0mnUgKmWe7/UQKobWcc/YuHrr49sRsuo=@vger.kernel.org
X-Gm-Message-State: AOJu0YzeU11qLFchl7NuDvaJD8M26X2s+uiEIX50RXwK+zGQCvK2J16o
	lcI7hweEOk2eFtBuTLsvh2v6BNZ0KEb1jpVY8kJRFegJt69ueW4o9NGJwMllBh254BpN+SW2Uy5
	ccUNSNw==
X-Received: from pgct17.prod.google.com ([2002:a05:6a02:5291:b0:c82:7a7f:9bf6])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a20:6a20:b0:3ab:2fa:756c
 with SMTP id adf61e73a8af0-3b4cccfdd57mr6432481637.1.1780691542593; Fri, 05
 Jun 2026 13:32:22 -0700 (PDT)
Date: Fri, 5 Jun 2026 13:32:21 -0700
In-Reply-To: <0dbe94ba88bc2c9de04233cb72964fec762e228e.camel@intel.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260529222223.870923-1-seanjc@google.com> <20260529222223.870923-35-seanjc@google.com>
 <0dbe94ba88bc2c9de04233cb72964fec762e228e.camel@intel.com>
Message-ID: <aiMyVbi8at8ZJKOS@google.com>
Subject: Re: [PATCH v3 34/40] KVM: x86: Move misc "VALID MASK" defines from
 kvm_host.h => x86.c
From: Sean Christopherson <seanjc@google.com>
To: Kai Huang <kai.huang@intel.com>
Cc: "pbonzini@redhat.com" <pbonzini@redhat.com>, "vkuznets@redhat.com" <vkuznets@redhat.com>, 
	"dwmw2@infradead.org" <dwmw2@infradead.org>, "paul@xen.org" <paul@xen.org>, 
	"kvm@vger.kernel.org" <kvm@vger.kernel.org>, "dwmw@amazon.co.uk" <dwmw@amazon.co.uk>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "yosry@kernel.org" <yosry@kernel.org>, 
	"binbin.wu@linux.intel.com" <binbin.wu@linux.intel.com>
Content-Type: text/plain; charset="us-ascii"

On Fri, Jun 05, 2026, Kai Huang wrote:
> On Fri, 2026-05-29 at 15:22 -0700, Sean Christopherson wrote:
> > Move a variety of "VALID MASK" defines, e.g. that capture which flags in
> > a given ioctl are supported by KVM, from kvm_host.h to x86.c.  The set of
> > valid flags/bits is very much a KVM-internal detail, as the hardcoded
> > defines are often massaged at runtime, i.e. *directly* using the macros
> > outside of KVM x86 would be actively dangerous.
> 
> I am bit confused about what do you mean by "hardcoded defines are ofen 
> massaged at runtime".  Do you mean the supported flags can be changed at runtime
> via ioctl?  But if we are talking about ioctl, then the flags must be part of
> uABI, which shouldn't change?

Not by ioctl, but by KVM's setup code.  Is this more clear?

  Move a variety of "VALID MASK" defines, e.g. that capture which flags in
  a given ioctl are supported by KVM, from kvm_host.h to x86.c.  The set of
  valid flags/bits is very much a KVM-internal detail, as the values from the
  hardcoded #defines are often captured and massaged by KVM's setup code, i.e.
  *directly* using the macros outside of KVM x86 would be actively dangerous.
