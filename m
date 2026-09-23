Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49B1649AA48
	for <kvm@vger.kernel.org>; Wed, 23 Sep 2026 15:28:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790177333; cv=none; b=XvjRmB4ZGpKTIL9XIuV175OcKAfSycJoDnxe1xg0QQf6KXinmSG07QdA1skf8LhdIqUeYhwgyacvDPDB3IunOTE3SWEmFYbksSAGiVLLZt3XTBS+Two5ccJdjL0e81pb720Wbcw0stKjFH3If3yDp5H9UoL+Ctad0gLst65PGww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790177333; c=relaxed/simple;
	bh=dwSYJ2AvO5Gx873R19R5kywo6fBcLTcuPMkb5vEl6KQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nq0goTlOUCV6avapw2pXXhMriI5WPf7T+b2Qptl+1PxJKkHkBZt/34ojVPDPi0t3EWbOJpAJLidHbbPsm/WRtFZtl0rj36zC7+Ym+yalnGE70dm1y8/0DAP68NvudyWBbB0hbnreS1y+2MAVDcuinmNlyARBa6WSVCQmiilzfGE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=emt7Nk//; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="emt7Nk//"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DF7741F000FF;
	Wed, 23 Sep 2026 15:28:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790177326;
	bh=xWi+OqwCZfD7+DuS6d5A9ZOvKWrI1GDbMxsuaweXNMA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=emt7Nk//V1Zs8cg1K1dDwhwXwgl6tQ/yJ0VN5ZLraIQ/qWs88Mi8N1QaLw9VMFuSn
	 kfmd2Yz+/3AJVA3/74VvHtNSvgoezRWrG4Yhpd8K+erqixpnoHYt1tw4KMkFXyaeTh
	 o4aoqVLFQ2Rei/3mbXUCgY3cWhOpaUuO93H1XQMXgCIFXsHtjrQyjDQhiQQaD/fbgr
	 DZ21PpsnQKu8sQT8wpDnGqCj8gBeTFWO/hf2v0wK1Lxz9+SwLxBS2Qv1Ya2AYqc7qo
	 Eo6ZNMbwdwarX30FlsrvYnWeo8lIeiuUk/cPwiThfs5+TIQTU7X87x0YJtAD4Z/LpI
	 xJYH4PqNn0cTA==
Date: Wed, 23 Sep 2026 10:28:38 -0500
From: "Serge Hallyn (AMD)" <sergeh@kernel.org>
To: Artem Bityutskiy <dedekind1@gmail.com>
Cc: Peter Xu <peterx@redhat.com>,
	Tony Lindgren <tony.lindgren@linux.intel.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Sean Christopherson <seanjc@google.com>,
	Fabiano Rosas <farosas@suse.de>, Jon Grimm <Jon.Grimm@amd.com>,
	Pankaj Gupta <pankaj.gupta@amd.com>,
	Tom Lendacky <thomas.lendacky@amd.com>,
	Marc Zyngier <maz@kernel.org>,
	Oliver Upton <oliver.upton@linux.dev>,
	Steven Price <steven.price@arm.com>,
	Anup Patel <anup@brainfault.org>, Samuel Ortiz <sameo@rivosinc.com>,
	Jakub =?utf-8?B?UsWvxb5pxI1rYQ==?= <jakub.ruzicka@matfyz.cz>,
	=?iso-8859-1?Q?J=F6rg_R=F6del?= <joro@8bytes.org>,
	Vishal Annapurve <vannapurve@google.com>,
	Elena Reshetova <elena.reshetova@intel.com>,
	Kai Huang <kai.huang@intel.com>,
	Kishen Maloor <kishen.maloor@intel.com>,
	Mika Westerberg <mika.westerberg@linux.intel.com>,
	Peter Fang <peter.fang@intel.com>,
	Rick Edgecombe <rick.p.edgecombe@intel.com>,
	Xiaoyao Li <xiaoyao.li@intel.com>,
	Xu Yilun <yilun.xu@linux.intel.com>, kvm@vger.kernel.org
Subject: Re: [RFC PATCH v2 0/4] Add KVM API for confidential guest live
 migration
Message-ID: <arPwJs3xFEBmFt4j@shallyn-amd>
References: <20260831071304.762939-1-tony.lindgren@linux.intel.com>
 <d78207fcc5936b5822b708238d862b0e10f9f5c3.camel@gmail.com>
 <aqxbMGLwvtT8zkEb@zhexu-thinkpadt14gen5.rmtcaon.csb>
 <84bf61e0e810859ed735dc92ab94167727c2e560.camel@gmail.com>
 <aq1ehHk7OUYaGCe5@zhexu-thinkpadt14gen5.rmtcaon.csb>
 <f2889dd6e44333b2a5bbd4bd32a4557c3b50a3cc.camel@gmail.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f2889dd6e44333b2a5bbd4bd32a4557c3b50a3cc.camel@gmail.com>

On Tue, Sep 22, 2026 at 11:09:42AM +0300, Artem Bityutskiy wrote:
> Hi Peter,
...
> > Said that, we'll need to be careful then in case of migration fallbacks at
> > the final stage. Nowadays, I believe QEMU can still fallback to source side
> > at a very, very late stage after all things applied.  If I'm not mistaken,
> > the final handshake is done at migration_incoming_state_destroy() ->
> > migrate_send_rp_shut() telling source to be gone.
> 
> Right. In traditional pre-copy VM migration model, the fallback is possible
> at any point before the destination VM starts running and modifying its
> state.
> 
> The same is true for TDX, but with more complexity and limitations.
> 
> We have 2 points:
> 1. Before the source has exported the start token - fallback is similar to
>    traditional VM migration - just abort the migration on source and
>    continue running the source TD, and just destroy the destination TD.
> 2. After the source has exported the start token - fallback is still
>    possible, but more complex - it requires the destination to first
>    generate the abort token, which should be delivered to the source and
>    consumed there. There are seamcalls for both generating and consuming the
>    abort token. The token basically makes sure the destination cannot run,
>    and the source can run again - same "only one of the TDs can run at a
>    time" security rule that we discussed earlier.
> 
> Now, the limitation here is that if the abort is because the network
> connectivity is lost, the abort token cannot be delivered. Then I'd guess
> migration should stop, without destroying the source and the destination,
> and the token should be delivered later manually, QEMU could even provide an
> infrastructure / commands for that.
> 
> Would be very helpful to learn the abort protocol the other CoCo vendors
> offer - is it similar to TDX or not?

Yup, that sounds very similar to the expected SEV-SNP late abort semantics,

-serge
