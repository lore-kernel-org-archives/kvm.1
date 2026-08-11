Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E362C2472B6;
	Tue, 11 Aug 2026 15:01:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786460519; cv=none; b=hMmGpPseJTYZqdieoYctYiBuBOCMQv3JeOskHIbiBWpVElKXVD++LFLbuVpl97B0fmMhxS0MeB9viq4dMnmsPfF3MO/8zUW9wWJ881cfgFMrWxXZEe0Wrfb7xRjjnctE/Z0kbOOzVNynZthlpUqGciFXBzaoodgPuDviI0+vWcw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786460519; c=relaxed/simple;
	bh=5UYS20zcl93ZD2GvJ7ph/fpF1Dtf3Q7qsIbwI3L6D54=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=O/X3fTQDyFYcYXnhT58qGwTmYnObVu4jHFOFzKSRYIZ1hZ2nAbGnVlkUIRnemzONKRHMTjckwSjdxvMLHDUcbrvmnrJLyFoqnE5p14481hqidp6rGV92ReOBOklDXjzTn9lRvxcLdIasZ8Eqsy9SyrK7ovc4MRFtqNFRxXhihQI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MJ9h2tj3; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MJ9h2tj3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B33EC1F000E9;
	Tue, 11 Aug 2026 15:01:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786460517;
	bh=ftk6Ob5ePi2NG4+2csEQu5wySUZgPfdaprbJPeK1WJM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=MJ9h2tj3g/fUBUHukKY9PqJ7Phm1sT71oEsJp6U1a6kRBd2IZ/39qxMaceNktm9hb
	 4CeC9k52d+jvQcHEAJOFRDHVgAo7R2OY5LhBFgvO5OGHUxFDfswQP0S266ajMhZhYY
	 3srq8rMdTdgdEEKoi+XWt4awhuIJwsV7lgAlblGBdm+BjQ2wcO52dTCLQRI5IIYx9h
	 T1V/SL7mYsLb1FrUxKBT0j3JzZ27EnPZgQuVQ05pnfmcUDQjO4s8Ahkyi68Pi4GAaw
	 wy6w4hOnPOA2IRuguPhkHZCuCdQ/Y812icVTYLviXr95MGCdA4CvM4peVjtdO4/tMS
	 TKGpwgD77TJCg==
Date: Tue, 11 Aug 2026 09:01:55 -0600
From: Tycho Andersen <tycho@kernel.org>
To: Yosry Ahmed <yosry@kernel.org>
Cc: Paolo Bonzini <pbonzini@redhat.com>, 
	Sean Christopherson <seanjc@google.com>, Linus Torvalds <torvalds@linux-foundation.org>, 
	"Kernel Mailing List, Linux" <linux-kernel@vger.kernel.org>, kvm <kvm@vger.kernel.org>, Borislav Petkov <bp@alien8.de>, 
	Tom Lendacky <thomas.lendacky@amd.com>
Subject: Re: [GIT PULL] KVM (mostly s390) fixes for Linux 7.2-rc7
Message-ID: <ans4ftkEaxuDXtBg@tycho.pizza>
References: <20260807135327.2629594-1-pbonzini@redhat.com>
 <anYQsMnpS2kpYoqA@google.com>
 <CABgObfak2WM10cj4eQ0DejFQPjsK1ftjS-y2Ygr_gcPs=KyChg@mail.gmail.com>
 <anZehP6yD66SRsNj@google.com>
 <CABgObfYqWf8WXNTZtz+W=CSK8yrGJhDruObp42LXkywhyK6=0Q@mail.gmail.com>
 <CAO9r8zP8=M9yx80SZhXXAThFbbH5wNRRnbZyy1tNF6A1JBy5FQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAO9r8zP8=M9yx80SZhXXAThFbbH5wNRRnbZyy1tNF6A1JBy5FQ@mail.gmail.com>

On Mon, Aug 10, 2026 at 02:30:12PM -0700, Yosry Ahmed wrote:
> On Fri, Aug 7, 2026 at 10:43 PM Paolo Bonzini <pbonzini@redhat.com> wrote:
> >
> > Il sab 8 ago 2026, 00:39 Sean Christopherson <seanjc@google.com> ha scritto:
> > > On Fri, Aug 07, 2026, Paolo Bonzini wrote:
> > > > I consider two weeks of wait, on a review that so far had been
> > > > exclusively about taste, to *be* an honest attempt to gather the next
> > > > round of feedback (which never came).
> > >
> > > Heh, and I was waiting for a response to Yosry's thread:
> > > https://lore.kernel.org/all/CAO9r8zODKgCcjTBK=P6BuXBBZRoOAFMeRJU8BmkWL-BCX2LoBw@mail.gmail.com
> >
> > Heh^2, "Pick your poison, I guess" was not really inviting a response.
> > Overall the sense of my reply to you (that is: there are two callers
> > so let's not overthink wrappers) applied just as much to his message;
> > and checking AMD vs. Intel in common code is a total no-no so I kept
> > the reply in one place.
> 
> Aside from the code itself, I was really hoping for a better
> understanding of the problem, and answers from AMD/Hyper-V folks if
> possible.
> 
> Basically:
> 
> (a) Is INVLPGA intended to be used with NPT enabled to flush GVA
> translations on behalf of the guest?
> 
> I assume the answer is yes, and something is broken. But if the answer
> is no, then we shouldn't be looking any further and the fix proposed
> by you/Sean is correct regardless.

I think the answer here is "no", but we would like to introduce a
slightly different fix.

In terms of my reproducing, I may have been doing it this whole time:
Alexander's ssh script for liveness checking was working, but the
uptimes of some of the VMs are different, suggesting that BSODs were
happening along with automatic reboots. I'll see if I can get windows
to stop doing that.

I'm also about to go out of office for a while (kid++), so adding
Boris and Tom to the thread.

Thanks,

Tycho
