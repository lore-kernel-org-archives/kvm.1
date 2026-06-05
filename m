Received: from angie.orcam.me.uk (angie.orcam.me.uk [78.133.224.34])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 227D0368299;
	Fri,  5 Jun 2026 23:04:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.133.224.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780700667; cv=none; b=mBCCWewrEfIhIo46jsAajnAUxn4btQvr+z4BLXdhqbXXcFkF74gy3qn6PHxzabycwR/LdjYS/0Yfj3q8zy3wqugm8llP9YxYlR5Mxc9X9Wc1m7jX3ga2m2FPBvgpI+I0Huvpy90myZ4b7VYHVErf/2AEBLkILOpZDjb3r59tfy0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780700667; c=relaxed/simple;
	bh=UUB4vq6c/nDM/H+Ctv0mUmW0sQKjbCPOanC4wNGfgbw=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=DWChgVZVs+8Cn2W//c9orH6ihGZs0CGi+L8IeWTcYv93xeQD1Gmfv/wFVKIRshY4SqULtY9L4wF5t53VwB5YeDiqq9tzcUPQf8iK9YRAquNDP62HX2wCEFy3qwqB40YMH9/a+jixnP8GLfjOpuENDdOKhhokh4Vmoc4FKx8v0Oc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=orcam.me.uk; spf=none smtp.mailfrom=orcam.me.uk; arc=none smtp.client-ip=78.133.224.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=orcam.me.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=orcam.me.uk
Received: by angie.orcam.me.uk (Postfix, from userid 500)
	id 3547A92009E; Sat,  6 Jun 2026 01:04:23 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by angie.orcam.me.uk (Postfix) with ESMTP id 2FF6692009C;
	Sat,  6 Jun 2026 00:04:23 +0100 (BST)
Date: Sat, 6 Jun 2026 00:04:23 +0100 (BST)
From: "Maciej W. Rozycki" <macro@orcam.me.uk>
To: Christian Ludloff <ludloff@gmail.com>
cc: Sean Christopherson <seanjc@google.com>, 
    Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org, 
    linux-kernel@vger.kernel.org, 
    =?UTF-8?Q?Carlos_L=C3=B3pez?= <clopez@suse.de>, 
    Andrew Cooper <andrew.cooper3@citrix.com>
Subject: Re: Re: [PATCH v2 2/6] KVM: x86: Prioritize DR7.GD #DB over #GP due
 to illegal DR6/7 value
In-Reply-To: <CAKSQd8VbXJ8pX_igweSAKv8qmP5vOpybaoTn5fuyFf_cXNyo8g@mail.gmail.com>
Message-ID: <alpine.DEB.2.21.2606052147450.22659@angie.orcam.me.uk>
References: <CAKSQd8VbXJ8pX_igweSAKv8qmP5vOpybaoTn5fuyFf_cXNyo8g@mail.gmail.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT

On Fri, 5 Jun 2026, Christian Ludloff wrote:

> See https://www.sandpile.org/x86/debug.htm for
> a 22 year old writeup, which – thanks to a bunch
> of poking by Andy – finally got published. Back in
> the old days, #DB implementations... well, let me
> put it this way... they left a lot to be desired.

 Thanks for the pointer.

 FWIW of x86 architecture specimens I only used 64-bit Intel Atom CPUs 
with JTAG debug hardware and the implementation seemed reasonable enough.

 Debug register access emulation via DR7.GD was a must in the debug stub 
as otherwise you wouldn't get through POST to get the DRAM controller set 
up for the system to become usable without the BIOS poking at the DRx 
state and clobbering it in the course, which it was eager to do and 
intefere with the debugger state.  IIRC discarding writes and supplying 
reasonable fixed values for reads was good enough to make the BIOS happy.

 I couldn't be bothered to expose descriptor register state through the 
stub as we only cared about simple bare metal software that used a flat 
memory model.  For the same reason I have no idea if things such as traps 
on a TSS switch did anything useful.

 One could control the system via GDB otherwise right from the reset 
vector, just as with other embedded CPU architectures implementing the 
JTAG debug stuff; individual CPU cores were exposed as execution threads 
in GDB, suitably for debugging e.g. an SMP OS kernel.  I didn't get to 
running Linux under GDB in this setup though (I did with another CPU 
architecture).

  Maciej
