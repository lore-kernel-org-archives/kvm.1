Received: from mail-dl1-f54.google.com (mail-dl1-f54.google.com [74.125.82.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7244B3C457C
	for <kvm@vger.kernel.org>; Thu, 19 Mar 2026 14:44:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773931477; cv=pass; b=lGe/o11ZVB61T0lkH13QMjCg2ACUPHfG2u9ARsA34cxc0TqDTlwLolnRqnfBm7UQn5+MOAIweBFp9GFJvFwCZ+LLnbWgGIoTZG3O0m2hMgBmjY7qU+rTRbML6mG78PC5J5FMkMmmKwcR9+b/n7tF3uNv991B1basLyhkoZSmv2E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773931477; c=relaxed/simple;
	bh=8b9ZwyvLXRmwpeT69oCDgmE+fJuLOI7fXrUN+Qmc6TA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JN/VAExyaod4w2w+OcaEJvRxxKITC2BBjZkNDk91XBE+W0UgcZoFpFFC7XULV7QjWbS+eRCvFlbTS/r10yVBttKFoyLWm9fO2oKZ2DKLIJq4irwl/NFuYSxMbP+i7HUHgCCx7XBQIZbxYScPxwTOHPSh7Q3J08SpzbIYG7Hqk/g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=H/Sy9DxC; arc=pass smtp.client-ip=74.125.82.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="H/Sy9DxC"
Received: by mail-dl1-f54.google.com with SMTP id a92af1059eb24-128e8ac3330so391088c88.0
        for <kvm@vger.kernel.org>; Thu, 19 Mar 2026 07:44:34 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773931473; cv=none;
        d=google.com; s=arc-20240605;
        b=DclRKtNmCry1wtKZH3lf1Tb04yUq1n5Q0ZkS5FsrdhvcmZOuhlZepYPedoNt3AL+tL
         mtVC9NvCPi2TunTYYhZyui5hKm3YWeKvnYlc5xQbQKshXY/7xINYt6fcjHks1ax7a9RY
         sxKYx9XyVSciHyzN0AocgOVqTsVi2xP93AgeSEbAkFSPLepWGdOdtvltgfOdM79RizC0
         1j1RP1AHLsygSegZyYCA4uCdaH4sMqxL5lXxcmFgRxa3APgVzrmHPC7yc7rQn4p7BNEv
         n8AvXYGyvEMHu0rS+BlYtTAPIeBRWTZJfBAQEyRwTpLu5hlNnx/hGWGHvZV3+cWFNA4r
         q46Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=b3gY60wubddiSLHv7WMYwGdsjiOuDFNerYxeic49W5Y=;
        fh=ycnT+sJVFbB2AFZPu34XDavVykVSN989RJfukieKv7I=;
        b=FrmQSEZzt06SzbOpm5qeKsSTg+x3UR0hELwCrnSDhNWjdAgNQoYiDksH+A6pCrBvrE
         S68RMgnb9YaXqZawbnPlRrO2X+KAZR12UdGYF1EZ5SUyfWzHTWnDXghuLRyxDkyFxo1U
         HRJLCNDdrU8vYZZzj3/MhVXPejs836cYe3DpOtbj3o7n/wW6hu7wzVqCDA+9AyEnIRZQ
         BctzeTlMZmjqKB9Vn/aEfBqaJBAsuBR6POrxhLs2Q43igTSDf8otahlBp2b/OW+BTsf+
         vjwP3PrbhH0Ed7C1z3BTbcO/C8qHw49KtwCCtL1f1YhhdpgLM0L1SOpcJOLWPhHP/x6N
         aH+A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1773931473; x=1774536273; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=b3gY60wubddiSLHv7WMYwGdsjiOuDFNerYxeic49W5Y=;
        b=H/Sy9DxC3YlhaAsM8ZqjDI4tbzZvQdHf++GCVgYUl3ci/v9OxLiwEGzCQBzqyTWf5U
         PI4NZNo31l89hl9Lbh7jTBHWyXOLammjfUbUEYVv9Y03EjtlB7HKGWg+eNgfvgiem3R3
         1FCfTHhhEh2HYFVRBgwVTBjp3gceVvmMk04lkuHA3HAsv/8IsxbQpDHzyUI2C7/T+JuB
         NQnH9xlfpSGiz8/PiO30m8IAWmVIGYvYPdwlvFbfRr5KIs/EaMtODOcrkTpJXOYnC0Sc
         iILmUbSieB3XG0YPQgUIhkeTJ1YrNA7pM5wR39N1QG9Z03NNdjhYl+Fgl2t/bGBm0MSY
         H+sQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773931473; x=1774536273;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=b3gY60wubddiSLHv7WMYwGdsjiOuDFNerYxeic49W5Y=;
        b=saGmAHKvWy2LL7HcY2wm2oDph1dEGOECY4fuUTqP0oFLEOf6WqVSEvBKIZzoHf3WTV
         p0NkodkokrgSJN5fEVGik2ypP99bMkcHCMItP9xUovsjSWRQL/BrkMxx7i8l4BcZA7qk
         AlwYXn4QECFZLybHDTsckc8QwcBImJ5mwVZx/ImBMyVqdf4PPQu8sXv5CxQ+O/hpxN/4
         xN+0aOWaY0NYuFJg3AuM+exBaBG+Dsdet0hRri6TKr6JQlJCmng+akY7iskx15bfXLyp
         54suG6yrT5RghT9N6MFSvH5+owjqyyOMXEgSdZhtJkHdJ5TI6QYIQq2fwX5UJjMpLqyW
         MsgA==
X-Forwarded-Encrypted: i=1; AJvYcCXidve33e5wn7ZiWV1HBYDkXN9/BGdCwdhe1K9wx1UM9P+L9zuzbdX7A8R/rXD3LC1nhJM=@vger.kernel.org
X-Gm-Message-State: AOJu0YybZkzxySv3lbI6syymu+ULjLJsprrXwqdvQ4lqXSROHg4/1kBs
	aVZQgOTc1prau4uIXzcns+VNvA/RVWKDyYTnYjt5wlgjEZ9wwbQoDC9lXPROoSyAullDHHiHSvM
	wtXVG2myib8WMXltnVp9kijDA6mPXsFdoj237Q12k
X-Gm-Gg: ATEYQzx4dc3/RIMn6cWCnhqlGlR1/Dd2SKvY0BV4kRWk+fCHaVKAsDIUMbfVjCG97Hf
	keCozF0p3ywvzzLdAU2ZhMcOJCNRzus01Jw5yGYivr4vd/RcewrFsoECe0wbcG0WRmFLoOT2iEv
	7cRf41Di5c0s8as1k6pZmbByJB9IQzEzTQQ2UpX4uiagTAzsR4JwQ/pAgTVc64Hi3gJQoWosypV
	juvm6YQvTdgHHY0l46ul7X0qy5YCMkhOm3w5HoGN5A0E1X+rQlyRUiB2jsSTjYN1oi15iMavYAo
	x4m/4XcBxVFPeNPKzWRxJ0X7ci9dR2akMSXU3bc=
X-Received: by 2002:a05:7022:fa5:b0:11b:b622:cad9 with SMTP id
 a92af1059eb24-129a712ea7emr3764594c88.21.1773931472943; Thu, 19 Mar 2026
 07:44:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260223215118.2154194-1-bvanassche@acm.org> <20260223215118.2154194-2-bvanassche@acm.org>
 <aZ3r5_P74tUJm2oF@google.com> <7a22294b-1150-4c55-a95a-ea918cfb9b76@acm.org>
 <aaCHS5ZRuW-QJkK7@google.com> <CANpmjNPKkFxg0gLu+n+PaGgkq0AQ70DdHi69D3iEwGFO-r-yiw@mail.gmail.com>
 <e3946223-4543-4a76-a328-9c6865e95192@acm.org> <abs1w28YCs8Qj71w@elver.google.com>
In-Reply-To: <abs1w28YCs8Qj71w@elver.google.com>
From: Marco Elver <elver@google.com>
Date: Thu, 19 Mar 2026 15:43:55 +0100
X-Gm-Features: AaiRm50J8voGFIr3HknpYIlwHkcmfStUxmRsOLlXZZJ4Ip9QdSH-Su6itHyXwgw
Message-ID: <CANpmjNMeS2h6NFCX5C72Z=y0tKdFMb0jof20J6QuJDDB4_TRag@mail.gmail.com>
Subject: Re: [PATCH 01/62] kvm: Make pi_enable_wakeup_handler() easier to analyze
To: Bart Van Assche <bvanassche@acm.org>
Cc: Sean Christopherson <seanjc@google.com>, Peter Zijlstra <peterz@infradead.org>, 
	Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>, Boqun Feng <boqun@kernel.org>, 
	Waiman Long <longman@redhat.com>, linux-kernel@vger.kernel.org, 
	Christoph Hellwig <hch@lst.de>, Steven Rostedt <rostedt@goodmis.org>, 
	Nick Desaulniers <ndesaulniers@google.com>, Nathan Chancellor <nathan@kernel.org>, Kees Cook <kees@kernel.org>, 
	Jann Horn <jannh@google.com>, Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Thu, 19 Mar 2026 at 00:31, Marco Elver <elver@google.com> wrote:
>
> On Thu, Feb 26, 2026 at 04:19PM -0800, Bart Van Assche wrote:
> > On 2/26/26 12:13 PM, Marco Elver wrote:
> > > The goal of RELOC_HIDE is to make the optimizer be less aggressive.
> > > But the Thread Safety Analysis's alias analysis happens during
> > > semantic analysis and is completely detached from the optimizer, and
> > > we could potentially construct an expression that (a) lets Thread
> > > Safety Analysis figure out that __ptr is an alias to ptr, while (b)
> > > still hiding it from the optimizer. But I think we're sufficiently
> > > scared of breaking (b) that I'm not sure if this is feasible in a
> > > clean enough way that won't have other side-effects (e.g. worse
> > > codegen).
> >
> > Does the thread-safety alias analyzer assume that function calls with
> > identical inputs produce identical outputs? If so, how about changing
> > RELOC_HIDE() from a macro into an inline function? Would that be
> > sufficient to make the thread-safety checker recognize identical
> > per_cpu() expressions as identical without affecting the behavior of the
> > optimizer?
>
> The below works:
[...]
> That preserves original RELOC_HIDE intent (hide likely out-of-bounds
> pointer calculation via unsigned long cast) - GCC has its own version of
> RELOC_HIDE, so this seems to be exclusively for Clang.  For codegen, the
> temporary variable was just optimized away, so I'm not sure what benefit
> that indirection had at all. So all in all that should be equivalent to
> before, and looks a lot cleaner.
>
> The reason it works for Thread Safety Analysis is that TSA's alias
> analysis strips away inner casts when resolving pointer aliases. Whereas
> if there was an intermediate non-pointer (here: ulong) variable, it
> stops.
>
> Unless there are concerns, I'll send that as a patch.

This should make the KVM code work as-is:
https://lore.kernel.org/all/20260319135245.1420780-1-elver@google.com/
