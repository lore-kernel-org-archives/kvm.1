Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18DA61684BE
	for <kvm@vger.kernel.org>; Wed, 22 Apr 2026 06:55:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776840955; cv=none; b=SvVpa/95EfWi1aEWpBO7DhLTzPExZK8BTaDjeATnImjM8z8E0JHvB79xCtU+6DwDIku5ml8VfjXuXBLRIlySsq0VUp/hY9qVEVxvJl95lrOanJxsItI6m52oR7MGlCy1zEvEIomzS7OmnpBq96i1i+FN4gXX2tRs9JiTwvdwZB8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776840955; c=relaxed/simple;
	bh=2DemsOezg/z3DkZS5H1dvBnCGi3HrYdAoFz5trCrzaM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=itjDZrq/h7TxFExdvNxayklJl7q8RDZQyqs8wb/yBtPh4p2zRPJ//eojXlPhMkEILAwFUTnZKsvFaGs7Y8TDktJt4grVfSE+owdpLQkfaMcArt8PX57Ff59JKnYWnPMP/USn2mogK0GIF/7kdlNQ2AdbJonQSygaGgrltsVBmPw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=pKSUvDwu; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="pKSUvDwu"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=wxqAo6OR7qeLNWMF1zi73AWo6MmC+rCHLnjlPsmqr4I=; b=pKSUvDwuNB44J7t+qn0y48uWwF
	Wy7qdHh3hGyQBiPgbax11KhxHAnJ6Mk5WuECelZZBruwNtg5Lsq6pfZ6hNJ4rmcmdcHN5VnhfA2ms
	sEUxAUx9Q/ykyjqeSG9KQlagSj+MX8FoG4MbprMK1qSOSznPNhLCRxl9rWrPeOqYydoqe9Ct6kYOQ
	zjvdnXxKYNigzEtPe7jFHcmKWjbolXF0sAKa0Euc/mrbwnskuIp93FN/0IZskzFKYrwfplxxFj1I1
	YKs0A11KuoRh4equfkSbobk+JrrbVmUbjZpwMhwyrP/QoUkuwPWGmBLgcXoZ+E7OjDd6xrhm9r8rK
	nzX1F3iw==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wFRUu-0000000BLb9-0ib5;
	Wed, 22 Apr 2026 06:55:44 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id A64AA3008E2; Wed, 22 Apr 2026 08:55:42 +0200 (CEST)
Date: Wed, 22 Apr 2026 08:55:42 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Sean Christopherson <seanjc@google.com>
Cc: Thomas Gleixner <tglx@kernel.org>, Jim Mattson <jmattson@google.com>,
	Binbin Wu <binbin.wu@linux.intel.com>,
	Vishal L Verma <vishal.l.verma@intel.com>,
	"kvm@vger.kernel.org" <kvm@vger.kernel.org>,
	Rick P Edgecombe <rick.p.edgecombe@intel.com>,
	Binbin Wu <binbin.wu@intel.com>, "x86@kernel.org" <x86@kernel.org>,
	Paolo Bonzini <bonzini@redhat.com>
Subject: Re: CPU Lockups in KVM with deferred hrtimer rearming
Message-ID: <20260422065542.GN3126523@noisy.programming.kicks-ass.net>
References: <20260421113407.GE3102924@noisy.programming.kicks-ass.net>
 <20260421114940.GJ3126523@noisy.programming.kicks-ass.net>
 <87cxzsb5n0.ffs@tglx>
 <CALMp9eTeqE4u6ioepVeowRkcNs63DYZTg8og8em12u4FsVWNfw@mail.gmail.com>
 <878qagb20x.ffs@tglx>
 <aefIJR_FcEeP-fcS@google.com>
 <20260421200620.GK3126523@noisy.programming.kicks-ass.net>
 <aefktNLiS3ur10yD@google.com>
 <20260421210201.GM3126523@noisy.programming.kicks-ass.net>
 <aefvVjTtx22EzMkR@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aefvVjTtx22EzMkR@google.com>

On Tue, Apr 21, 2026 at 02:42:46PM -0700, Sean Christopherson wrote:
> On Tue, Apr 21, 2026, Peter Zijlstra wrote:
> > On Tue, Apr 21, 2026 at 08:57:24PM +0000, Sean Christopherson wrote:
> > > This as delta? (I had typed this all up before Peter posted a new verison, so
> > > dammit I'm sending it!)
> > 
> > :-)
> > 
> > I'll go stare at it in the morning, I'm about to go crash out.
> 
> New delta against your effective v2, builds all of my configs (which isn't _that_
> many, but I think they cover most of the weirder ways to include KVM (or not)).
> 
> I'll start testing the full thing to try and get early signal on the health.

Oh, re-reading commit 28d11e4548b7, I think this wrecks NMIs. The patch
will also use the FRED NMI path and that's not good when running IDT.

I'll go fix that and stick in a few more comments to clarify this magic.
