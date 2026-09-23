Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com [209.85.210.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89F6B4756D2
	for <kvm@vger.kernel.org>; Wed, 23 Sep 2026 14:33:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790173997; cv=none; b=fNh7gBQS6OellufJ9Ar42x254c1DWdv0iyo2jC33wyp9UfzELDOvddhKT46vgdEmdywq0Q2BanUYLaV75Yi9aKScNtkFfC/wvk+w2xuav+UXxQ+yaZqtEuMDjtL18fxZE7U2curT84YuLfNNyYLQplhyalwgGHaDWOSGNoI+bqA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790173997; c=relaxed/simple;
	bh=9SziFnm+aShDkRNqNWK4TN1HFS1h14/qWjFuIX4GFYA=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=BsdZcSr6DQyQmn24p5oOaMYfQbT1G/p4CHg+y4dg8RImK2YvHetws8TebYbDdeYrEndyfKZ/WKIPRH4ecNv6MFGBd4tHAqM4xWMAInEYQRx1rbhnL+IF5lczA8r/HeljTWdcxxEICroLQQX4APE1DTcGI7PVm6RlOyLNpOh1s+E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=G4djl8C3; arc=none smtp.client-ip=209.85.210.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="G4djl8C3"
Received: by mail-pf1-f199.google.com with SMTP id d2e1a72fcca58-8623e5d4279so1562593b3a.1
        for <kvm@vger.kernel.org>; Wed, 23 Sep 2026 07:33:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790173996; x=1790778796; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=AX/aeWxWgB/GKGsHNXt+UF87Ro0pQpzXrq2csA576lg=;
        b=G4djl8C3qxRTsRmvPNo5MOrfBBswMKCGB6TDoGTiEKAlra62ktjDTE69fVMNHfDiRB
         6nwEsCtA47lYdmfdQC8e/d13TBE0tfs3znkzlWpxNNfwzchICxPfyhqaHKU87a9weD2J
         NRXNDMBr1teRUBUiubml1aNnXs93x+joWSp7oOxW7B0LqvvEAaYiklk2u7rWX7fgRy5U
         X9IWtepwDWlJe+kBfbHziUx4RFhKzQiSVXt2OVG57BQ9rXGa2EUTl5CnRiQWp82kEAyg
         o6FYT3jccLBqcl51Hb+ZvnlUj74dDlA1EgIRNsqpxwUzVIVXMfvuYFiPQ2cLWiu1/nBH
         n8Jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790173996; x=1790778796;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=AX/aeWxWgB/GKGsHNXt+UF87Ro0pQpzXrq2csA576lg=;
        b=jJog9CpwnjwXroxKQHpqXBF48FB4s0QTFbi2cEYppS37u4BLdL3S/V5m1HdgM2TgCM
         vbiNoO9Hgo899GwIXaoGjUW3HaW5q60cfIZ/aJ2EKU8K9CHJanzz12i0zC5J2hvUCI/W
         iF9WFBMFUjxGTc8JTwt/Pj3ibnbpIPupdmeleqHj5ix/x5jrMtCAqEqbvvc/d8Cx/P4B
         p+IQY47+F0YoB5D3QhqEUvhIjZ8uUeMRsWVKrOWIbRyIDYSSNnRd4xOzG1+ING/RMw8Y
         7f4udYlP1Na0hcY+G5TIZ5OJRyV/yHOv4PEsz5DSQfSEiysi/x7EG27xszPuWmDQlHWG
         uaJg==
X-Forwarded-Encrypted: i=1; AKwUvBzmgBQ1i5yglE29nR55aMs2wNvw+opw6HKeHyDmKMmAKaeS8BTSnkxQAF/4GgqSG4SiEIY=@vger.kernel.org
X-Gm-Message-State: AFuF++mV22w4jcP+L/qndEWu4V+E1gmFQPs5cIPWi0QiwfHsdx/53DHz
	9u4ViZrvAfFjOzU6eCQzSHuhK+CiIE8l1yWBVIQi+FgHUR+kU5s/ZQQilwdmfKIuSDDT8rVrLnz
	Kkl69Rg==
X-Received: from pfet15.prod.google.com ([2002:aa7:938f:0:b0:87b:94d4:77a2])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:3319:b0:87c:e44e:5683
 with SMTP id d2e1a72fcca58-87d1a4b357amr2446190b3a.23.1790173995748; Wed, 23
 Sep 2026 07:33:15 -0700 (PDT)
Date: Wed, 23 Sep 2026 07:33:15 -0700
In-Reply-To: <20260923085139.GV776954@noisy.programming.kicks-ass.net>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <179005108298.388919.4535333252892590932.stgit@devnote2>
 <179005110742.388919.1509641807739909065.stgit@devnote2> <20260923085139.GV776954@noisy.programming.kicks-ass.net>
Message-ID: <arPjK1-PVp_UqAsQ@google.com>
Subject: Re: [PATCH v17 02/13] perf/x86, KVM: Prevent host debug register leak
 into guest OS on NMI
From: Sean Christopherson <seanjc@google.com>
To: Peter Zijlstra <peterz@infradead.org>
Cc: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>, Steven Rostedt <rostedt@goodmis.org>, 
	Ingo Molnar <mingo@kernel.org>, Jinchao Wang <wangjinchao600@gmail.com>, 
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Thomas Gleixner <tglx@linutronix.de>, 
	Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, 
	"H . Peter Anvin" <hpa@zytor.com>, Alexander Shishkin <alexander.shishkin@linux.intel.com>, 
	Ian Rogers <irogers@google.com>, linux-kernel@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, x86@kernel.org, 
	Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"

On Wed, Sep 23, 2026, Peter Zijlstra wrote:
> On Tue, Sep 22, 2026 at 01:25:07PM +0900, Masami Hiramatsu (Google) wrote:
> > From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> > 
> > When KVM enters a guest OS, host hardware breakpoints are disabled
> > before running the guest. However, an NMI can occur while executing
> > in guest mode or during guest transition, where
> > arch_install_hw_breakpoint() can be invoked from NMI context.
> 
> How? AFAICT perf doesn't do that. arch_install_hw_breakpoint() is called
> through pmu::add() which is strictly IPI context.

I assume it's:

  kgdb_nmi_handler()
  |
  -> kgdb_nmicallin()
     |
     -> kgdb_cpu_enter()
        |
        -> arch_kgdb_ops.correct_hw_break()
           |
           -> kgdb_correct_hw_break()
              |
              -> arch_install_hw_breakpoint()
