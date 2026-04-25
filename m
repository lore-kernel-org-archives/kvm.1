Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E7DE330D4C
	for <kvm@vger.kernel.org>; Sat, 25 Apr 2026 02:51:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=63.228.1.57
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777085522; cv=none; b=cW72ZGUkStnNAwhyA7yAFUfeYVeIPGRoN4bmxJCPHEigK+7DUC8yaR3TNdCb7mFyyh2+ie81qIS7EWWjfIEkF3VlTpg3ADG0Og2vVXNoJzSXzAyPEIFJQ/7g6MKDUB5B7o8aRibfBxTze6NSg1PFKrhA5yV9cc+Q4wxs8BiXbZg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777085522; c=relaxed/simple;
	bh=J8pGFFyrBzsD13gebiHVE1DZVj1tib7xVWpf/iUj/Ds=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kj0UQjSrFbIahQmC9l4X32mk/oWYP17jeTlPwol6UCky/bJjiZ94nDYoaC+hTREQKzwzMoxzF6yyWOoMgxMUyOs/jTYxplvJlMciTXj3dDfsrG9QQjq00DaGdX3wnjib+7Y35MR3cZ51lGvDKSe6s/KhErbdqdNEZFgk/UAxj7o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.crashing.org; spf=pass smtp.mailfrom=kernel.crashing.org; arc=none smtp.client-ip=63.228.1.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.crashing.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.crashing.org
Received: from gate.crashing.org (localhost [127.0.0.1])
	by gate.crashing.org (8.18.1/8.18.1/Debian-2) with ESMTP id 63P2ok5R315434;
	Fri, 24 Apr 2026 21:50:46 -0500
Received: (from segher@localhost)
	by gate.crashing.org (8.18.1/8.18.1/Submit) id 63P2oiZh315433;
	Fri, 24 Apr 2026 21:50:44 -0500
X-Authentication-Warning: gate.crashing.org: segher set sender to segher@kernel.crashing.org using -f
Date: Fri, 24 Apr 2026 21:50:44 -0500
From: Segher Boessenkool <segher@kernel.crashing.org>
To: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Cc: Christian Zigotzky <chzigotzky@xenosoft.de>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>, kvm@vger.kernel.org,
        "debian-powerpc@lists.debian.org" <debian-powerpc@lists.debian.org>,
        "R.T.Dickinson" <rtd2@xtra.co.nz>, hypexed@yahoo.com.au,
        mad skateman <madskateman@gmail.com>,
        Christian Zigotzky <info@xenosoft.de>
Subject: Re: KVM-PR no longer works when compiled with new GCC compilers
Message-ID: <aewsBF4zLRE7ZMuc@gate>
References: <cfd779d6-9440-46b2-9ed5-752f1ae6b5d1@xenosoft.de>
 <588ada6c-bcc4-e93b-1beb-4f7f859e3d5c@xenosoft.de>
 <eee732904c2a7ccce9b496b05f988a36d8a9883e.camel@physik.fu-berlin.de>
 <5da12382-5424-4bd9-981f-359e4dc1fa67@xenosoft.de>
 <a584b7a1-fc25-a475-099a-634159b6ffe8@xenosoft.de>
 <d9ad0cd6fa640f23c396778bce2aa322e40e7e88.camel@physik.fu-berlin.de>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <d9ad0cd6fa640f23c396778bce2aa322e40e7e88.camel@physik.fu-berlin.de>

On Fri, Apr 24, 2026 at 05:48:37PM +0200, John Paul Adrian Glaubitz wrote:
> On Fri, 2026-04-24 at 16:47 +0200, Christian Zigotzky wrote:
> > I compiled it with "mtune=power4" today but without any success.
> > 
> > Error messages:
> > 
> > [  800.274759] Couldn't emulate instruction 0x00000000 (op 0 xop 0)
> > [  800.274767] kvmppc_exit_pr_progint: emulation at 100 failed (00000000)
> 
> What exactly are you running inside the KVM? 0x00000000 doesn't seem like
> a valid instruction and a quick Google research reveals that this triggers
> a SIGLL trap.

By definition anything with primary op 0 (the first six bits 0) is
invalid.  It isn't super unusual to (accidentally) try to execute a zero
as an instruction ;-)


Segher
