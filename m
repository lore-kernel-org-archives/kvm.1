Received: from mail-pg1-f202.google.com (mail-pg1-f202.google.com [209.85.215.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BDCC175A7D
	for <kvm@vger.kernel.org>; Tue, 10 Mar 2026 01:23:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773105822; cv=none; b=Loo8yXuHQtl/vF1dKzPDf/aJQuGlvRJu/ZISKnpPKSqjRiKOtnMtPKJgebpshRxLCFo2fvrpEb74ctjtGu8pKr9bsRKTd9G2RMwBkwlBPujoyoNsojiyhfI3lMeAeuAuiKGRZxJlME9SFHbA8GxXiXde8wpI/cvk+TrlIgNnU1g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773105822; c=relaxed/simple;
	bh=Ikq9su4tNDDYRWV/1O357FdADGVw/FOYEt38D0zW5mw=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=NhuHCxFYchnd9Lx7Io3XVAVM9i1Lk/+MnaZJSP05MHovvl2R2u/Xfb8q9/FihEzoCXIbb2JSqnHvrhxnl+TJqCY5tJuDLwgbWUJYrz5ZTMffJnsLCWDmDfAxCR4b0a6qnefDimHgkPikjX9IrUt1IHEO8leBpAVid0BrkAh98J8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=t7L3rb8k; arc=none smtp.client-ip=209.85.215.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="t7L3rb8k"
Received: by mail-pg1-f202.google.com with SMTP id 41be03b00d2f7-c73a4983fc0so1602011a12.3
        for <kvm@vger.kernel.org>; Mon, 09 Mar 2026 18:23:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1773105821; x=1773710621; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=Cs+GOxICcXwU8t1ZQYHwvaCjjXXjM0HQUD44iKLKJtE=;
        b=t7L3rb8kVgFIoc/oM9i95G46I8B0LNvQFP55o0KOpl6FnanTOjyf+bjEkb82RdAxHz
         agYogGNUGaNiPJ2pmiNsZG+iaP7epGdseRptD7nxE6VRazA888zlpOESihUuRWGN8oZY
         ZiAjXfHaR83supg4QPy/CV0WkiwV0up/pNVefeLStR+rS2mh4DWuoWHFcZYkTURSiLah
         +txwUKj/M39gDJzjsPpDhnPaGaoFWLPiHsyanf23dCGEfol2Agr3ygeKeNn5JEp+Oek5
         JvhUixpSr9MckH2x5WiFFG6HC1Mds+Abf9juQMuU6BBUzFKZ2xUOjGxGx+vw0YiDCDUx
         YqCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773105821; x=1773710621;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Cs+GOxICcXwU8t1ZQYHwvaCjjXXjM0HQUD44iKLKJtE=;
        b=ZCIbWArwPO1m1BqCcBY4+TCJUtkHvBVErtVnI+ufBxBLJWQksGadYVybZJ59CKq7EN
         UQ5Gc7uLf+gdZGzSH1tg9+c3YmOqWCKHQJHPNBJDwihp7mRlyZhzYbNNSxy7F8HmKUcV
         0wE+gvFu794gd/5QJeogG2o0wLmYyo/O1aWQI4Ek/JDWj8dREPUXyjEfVA6B5Vxoj7Pj
         9h6Wpx90bxskYH8i5gofKMS7wFNRBu4UVuk6WS5dj85vsKXEXo0zbdlpD32Ce3Gq8E1I
         hy8hm5+FXqKdnRqzeXlA7k4WNWW2ZVwkabBHpw9yimasUQes0/fG7L9y+EuY/Onz/U3h
         X68g==
X-Forwarded-Encrypted: i=1; AJvYcCWZy1dtfGW9JJMstgVbbGcXkJBTrj4u3of6Wo/YGMq6CbgJINSp2I36EBqIdNTEV8rLh6k=@vger.kernel.org
X-Gm-Message-State: AOJu0YxHjIAmgrwcYxvtXSZkT/T3kW/2mgG5WmvJbUBy0W3wQpu/k3/y
	JaZ5W9giQM7Lcl+Xo57CrYfUbAEXyMIpliML1xC3oMvuAjw1vNFDKNca6LNw8via1dvTbMUXCdQ
	8el+WQQ==
X-Received: from pgbdr21.prod.google.com ([2002:a05:6a02:fd5:b0:c6e:28c3:dd5c])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a20:d045:b0:398:7e66:3c1c
 with SMTP id adf61e73a8af0-3987e663e94mr8704894637.66.1773105820767; Mon, 09
 Mar 2026 18:23:40 -0700 (PDT)
Date: Mon, 9 Mar 2026 18:23:39 -0700
In-Reply-To: <b5b9efce-9205-4282-acc2-380d348c4f50@intel.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260112235408.168200-1-chang.seok.bae@intel.com>
 <20260112235408.168200-2-chang.seok.bae@intel.com> <aajd6Fa8gHz6lW78@google.com>
 <b5b9efce-9205-4282-acc2-380d348c4f50@intel.com>
Message-ID: <aa9ym-SWeOdTrz0O@google.com>
Subject: Re: [PATCH v2 01/16] KVM: x86: Rename register accessors to be GPR-specific
From: Sean Christopherson <seanjc@google.com>
To: "Chang S. Bae" <chang.seok.bae@intel.com>
Cc: pbonzini@redhat.com, kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	chao.gao@intel.com
Content-Type: text/plain; charset="us-ascii"

On Fri, Mar 06, 2026, Chang S. Bae wrote:
> On 3/4/2026 5:35 PM, Sean Christopherson wrote:
> > On Mon, Jan 12, 2026, Chang S. Bae wrote:
> > > Refactor the VCPU register state accessors to make them explicitly
> > > GPR-only.
> > 
> > I like "register" though.
> 
> Yeah, agree that it is more general.
> 
> > 
> > > The existing register accessors operate on the cached VCPU register
> > > state. That cache holds GPRs and RIP. RIP has its own interface already.
> > 
> > Isn't it possible that e.g. get_vmx_mem_address() will do kvm_register_read()
> > for a RIP-relative address?

Answering my own question: no, this isn't possible, specifically because RIP can't
be addressed via "normal" methods (as Chang points out below, KVM's index of 16
is completely arbitrary).

Instead, for RIP relative addressing, the full "offset" gets reported via
EXIT_QUALIFICATION.

> One could RIP isn't a pure GPR, but it's also not something entirely different either.
> 
> The 'reg' argument has historically matched the index of the register cache
> array, vcpu::arch::regs[]. When extending the accessors to support EGPRs, it
> looked smooth to keep using it as a register ID, since that wires up cleanly
> with VMX instruction info and emulator sites. But then reg=16 immediately
> conflicts with RIP.
> 
> Separating accessors for RIP and GPRs was an option. Yes, the usages are
> very close and EGPRs are strictly not *legacy* GPRs.
> 
> Then, another option would be adjust RIP numbering. For example, use
> something like VCPU_REGS_RIP=32 for the accessor, while keeping a separate
> value like __VCPU_REGS_RIP=16 for the reg cache index. But there are many
> sites directly referencing regs[] and the change looked rather ugly -- two
> numberings for RIP alone.

Oh, yikes, I didn't even see that this series is playing games with the register
indices.

Whatever we do, the changelog asbolutely needs to call out the real motiviation.
Because nothing in here screams "KVM's APX implementation depends on this and
things will break horribly if kvm_gpr_read() is called with VCPU_REGS_RIP".

  The existing register accessors operate on the cached VCPU register
  state. That cache holds GPRs and RIP. RIP has its own interface already.
  This renaming clarifies GPR access only.

I'll try to come back to this tomorrow with more complete thoughts and hopefully
an idea or two on where to go, but I am most definitely against the current
implementation drops the safeguards provided by kvm_register_{read,write}_raw().
E.g. passing in VCPU_REGS_RIP to kvm_gpr_read() will compile just fine, but will
read the wrong register on APX capable hardware.

There's still kinda sorta some protection there as kvm_read_egpr() will WARN on
!APX hardware, but the hole scheme is kludgy at best.
