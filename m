Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12D6C72618;
	Sat, 30 May 2026 00:45:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780101905; cv=none; b=Vf6HmOsv/tYT42GXVXX9GpqIEu6yQ4/cqeInebfcBRlw/RcbwhJQTCsJ+PfTbYrQin/JA0ti+LIi/fVQAYucWe+Q85KGrOD0EyHHqTcFSNLwQAznUY9wzY2qrsz5Nf9ukfpi0GCKaHhp8ci2p9DgB4KDWMwmWLT8/yUIxM7xjaE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780101905; c=relaxed/simple;
	bh=NStGXsUSMa6GMa/+5q3eUvECe1pz6RpqI5MwE08jpaU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DbyNLQv8+61BXsj0CKdUsLKQdhJ7WKnUqydt7EhWsw2ndG5fHExQlf2qRUe20orSbyBF7CsP2pOe+APQBWN/HcSt/t6+Boau47at5UtZn2Iaa+nYGAODmJwbzVLEQKhUwfT+ZzmctqL+LjnSu0+4ggvoUA0V3rPm27+hiqYkWOo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SQFH+QQj; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SQFH+QQj"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4A0661F00893;
	Sat, 30 May 2026 00:45:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780101904;
	bh=k0vFxp5Vw1VHhrmToVRt66MX6kez97aQOnALUkQ4jNc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=SQFH+QQj5FQdsuC9qIbw2srKTfu1Ylgq8kE9sadAh+MA7ECsEE/YtT/0VN3AWlFFU
	 JaT6V2mAw0mU0xJYQH1aCvVWH7d5ar27iyLbdQfJAugHngScanWk9HuXDuww8Hkenl
	 /kZG7F6AAhwMfrbp0bjjYO59aXF9lkIC4PwoQ32zz1fUHmeXxOwA/c9ErYsX6c5zOg
	 hTSw2CZ9BZ/ca4uIuqaWpAawWPUJ47pM2C40r29iySnpxESxKOpz8HxgHB3M83Ct9z
	 RFGy9cPWCnOxcFLYO7wGTEVn0H3/R+V8xAb7/ztO9r/TppOAXKwpRx50z/kpcxAJ3p
	 6Q1t8vbT4Xv0w==
Date: Sat, 30 May 2026 00:45:03 +0000
From: Yosry Ahmed <yosry@kernel.org>
To: Sean Christopherson <seanjc@google.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, 
	Vitaly Kuznetsov <vkuznets@redhat.com>, David Woodhouse <dwmw2@infradead.org>, 
	Paul Durrant <paul@xen.org>, kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Binbin Wu <binbin.wu@linux.intel.com>, David Woodhouse <dwmw@amazon.co.uk>, 
	Kai Huang <kai.huang@intel.com>
Subject: Re: [PATCH v3 14/40] KVM: x86: Move async #PF helpers to x86.h (as
 inlines)
Message-ID: <ahoy8xmCiKrx6JKl@google.com>
References: <20260529222223.870923-1-seanjc@google.com>
 <20260529222223.870923-15-seanjc@google.com>
 <ahow9ka9VEwQbKOV@google.com>
 <ahox3g0KFRo1orXF@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ahox3g0KFRo1orXF@google.com>

On Fri, May 29, 2026 at 05:39:58PM -0700, Sean Christopherson wrote:
> On Sat, May 30, 2026, Yosry Ahmed wrote:
> > On Fri, May 29, 2026 at 03:21:57PM -0700, Sean Christopherson wrote:
> > > Move kvm_pv_async_pf_enabled() and kvm_async_pf_hash_reset() to x86.h in
> > > anticipation of extracting the majority of register and MSR specific code
> > > out of x86.c.
> > 
> > Not sure how these things are relevant?
> 
> Oh, I should have explained that.  The PV async #PF stuff is controlled via MSR,
> so kvm_async_pf_hash_reset() will also be called from msrs.c.  And there are fun
> CR0.PG interactions that need to be handled, so kvm_pv_async_pf_enabled() will
> be called from regs.c.
> 
> But they also need to be called from x86.c where the core PV async #PF support
> lives.

Makes sense.

With the changelog updated:

Reviewed-by: Yosry Ahmed <yosry@kernel.org>
