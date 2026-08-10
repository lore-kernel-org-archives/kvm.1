Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E8983793D2;
	Mon, 10 Aug 2026 13:56:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786370182; cv=none; b=geWiDYZWvSktl2kxsTP0nl8SHRVFCDiva/lgytVpU6FzF/y+gDAjC4YLnDLn3mYqgvu7Y01xfPVkaS59hCr/ghkREpxsuw6FgSxaXx0hh4TkY2eT+EiqY/EtuPRAy6xWhu7yo0aj5nzfqFh0OvtBsi1MC1Oct1j5175KC8g7I6I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786370182; c=relaxed/simple;
	bh=tBXwjgJXC+quTA8Y14STgASDf4bqxjAQIR/FKTvH26I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=caQSg61Vx/ZXEvlrdADZ1b45hgUvgDpg4j01mhGdU335RJmC1lPypLn8l2CDHn07wwrUYzm0LvuB83B0jYDsLxAE+PBPjXrsFXjdCftrpfh4wW8ZDptDb70NI9PoZ3uS4jt7EmmE8U+G9fEbYhG5avh4OBX4BCi+UTzt3hzD3c4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IlkPreeR; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IlkPreeR"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2FC6F1F000E9;
	Mon, 10 Aug 2026 13:56:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786370181;
	bh=rwBqUt+0pqUHxje+pwhg3ebKPyZAbZ2zQhGAhKy5q0Q=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=IlkPreeRCMTNENqEq6+b2IoFcSETbjr5fx90WPSZkDrLSrHbHD2bHF/6jJ9P4Atso
	 o2QUNjMlra6OpojApLalPc40z3zRtlDWB5ywFFWY/FjoBZgc/Lc7V46Ls7pzX8eALL
	 zfjic0a0IzfA/caQYyCAE42lvWJLMB7uME+UY58fioDRC+Dw2PVpqTbzvGK0iDx4m2
	 00msl31uUVZhVSoBBRbmE4c/evB3eY6AAazMEjliRD+xX35CPcjGbZRxR+jNsMVQr8
	 7DTi9IAIkse6nt3eFIaxo0UnbywCAdUvcb9UFzD3MZobGqOPYom9Ta7x3fQCBjOtwK
	 O8EtVkIynIjOw==
Date: Mon, 10 Aug 2026 07:56:18 -0600
From: Tycho Andersen <tycho@kernel.org>
To: Sean Christopherson <seanjc@google.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, torvalds@linux-foundation.org, 
	linux-kernel@vger.kernel.org, kvm@vger.kernel.org, Yosry Ahmed <yosry@kernel.org>
Subject: Re: [GIT PULL] KVM (mostly s390) fixes for Linux 7.2-rc7
Message-ID: <annX2lP-5cCgRJBe@tycho.pizza>
References: <20260807135327.2629594-1-pbonzini@redhat.com>
 <anYQsMnpS2kpYoqA@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <anYQsMnpS2kpYoqA@google.com>

On Fri, Aug 07, 2026 at 10:06:56AM -0700, Sean Christopherson wrote:
> +Yosry
> 
> On Fri, Aug 07, 2026, Paolo Bonzini wrote:
> > - disable use of INVLPGA when NPT is enabled, because it doesn't seem
> >   to flush TLBs correctly
> 
> ...
> 
> > Paolo Bonzini (3):
> >       KVM: SVM: make svm_flush_tlb_gva do a full asid flush if NPT enabled
> 
> Why did this get rushed in?  There was quite a bit of discussion, both on the
> code itself[1][2] and on the assessment that this appears to be hardware issue[3].
> IMO, neither of those discussions was resolved enough to merge the patch as-is.

I have tried Pretty Hard to reproduce this and not been successful. I
asked Alexander offlist for his disk image last week to try with that,
but haven't received a response yet.

We would definitely like a reproducer and to look into exactly what's
going on here.

Thanks,

Tycho
