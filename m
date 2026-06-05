Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9414B1DFF0;
	Fri,  5 Jun 2026 11:43:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780659782; cv=none; b=WYACXjkC4FPBXVz2e00FBxIOMkBt8p7wLzyLev8Jcw1Um1bQdbbhVn5hT6zk1ciXPXFyFasKzPfGHOAv76Y44iQv+QtnU2wXWrdU4hbYNfF5A066BaUm0j+66a57e7zDEM4oLvsVHw7hFmyXPSHsP2+tNmJn6+fCBb30sOJ+lQY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780659782; c=relaxed/simple;
	bh=vfXXqLlOtJN8aZcbY5EAxkL5IWkZ7JVgfcav9z4SLU4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uPpqjGrXfn17Y3xqk/16vwNwhxBJMsisNcaGeO36sc5ksriSfrAms4rif8aoYaHL9w2kZYUdu0ytoAhTVd99JIM/FGEbz4uX0I5oGWD1X6xL9r9fTekemdCkDHOYT/dnmlh8Qe6LtKC47OLeWyWbulAMH01qL2NmuRH3JO9ReIU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JMC21LFK; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JMC21LFK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9162B1F00898;
	Fri,  5 Jun 2026 11:43:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780659781;
	bh=UvHXc8Wa99igeIl7xckPhI70Cop5FhBGDIa6jmltA4g=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=JMC21LFKDA1kPlweR0clo954/ecOI5AU9OS9Zp07y3eR91V1xOl8O6J5r3seIzpRU
	 ZGndTfupFYhckhpPW0to+Izj1rzvohHlzVRe+Ew0QwUNAUTZbXc1W1TjaHM8ug1/0J
	 f5icpYSDKct/0/MNLgtK+uCSYMPbFsiN3MHxXQSDTRl/lHE1bT7iuYpE++MQzwCHE+
	 nXYhbhFoN/pYVgVEoxLV5yWirylWZ6zn0bRr7d1Q9Z2Mmot5pjdb6ozaSeOVmSYfJZ
	 0tlMK4JZjrEENpZdbKEH18Sn/WRBkH2/o12am0effAE1ufKvlcKfazl83erZ8HLFQo
	 Sd5Brrgu74WSA==
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfauth.phl.internal (Postfix) with ESMTP id A5B16F4007E;
	Fri,  5 Jun 2026 07:42:59 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-05.internal (MEProxy); Fri, 05 Jun 2026 07:42:59 -0400
X-ME-Sender: <xms:Q7YiagGo4p1mC9UkkVMbbzreAkrAzX0Cvz1bY3igE4JC9BJ09WshfA>
    <xme:Q7YiaraxMuvzRQMRiK9r85BuT2JtizvmiAn7Z-C8feXKnzsIpl2e8eSU6N_3KmuU4
    a1KWqC0vpJmiHJXGf4f3wBLy7BAMl1dW05_hLoSKtYg16yi9OMpvnc>
X-ME-Received: <xmr:Q7YiaoQ03NAB-nX6EMWSpLVuokzrLP1jZ3dcbrGUsEAP6VyJ_pIUs8JGWbwzew>
X-ME-Proxy-Cause: dmFkZTFYaIvxv9MP+iw0KsftJJWaFrp5VUjXabHoGf57vb2raD7+CO9Kp337Bre/hKBoAK
    9IO/oXQejZtUBc2brjuFlQ4eTz6ohV5VY3IyFbCZl5laikyvbqiUnR0DIJEjq/7qfrFmS9
    KkSKe2NHawg5KaGREDOHaStqlk3hw9Wddz5brumMPPgS0g5DcCsX9Ay2osLqaNLq5py/ib
    s/mLxh+NqzybNG41UqbojayVEHkL7mySQTTIOfS+WzFElTpWWcy14u5vmuiOt+AlaYLPQm
    xRMtTWF2kevkwye8RZm17o7WSC3MHDeHxQkDtei5bGD3keIPOXIkhIpgZffYLuaGdI5ae6
    V/0nc/4ps2b8RU+qff2+EF1Jq6EZkXzd51RI/1MhCfAC34KfYaZKTaeabwgmxC/Y5qSPVQ
    Ja2vXI9tPDFsa4XRPzXt9YvQBkaBhPc0OXasZaAb6Fe069yaJlNv1xwAC7Z7Xr2KI5H/EU
    aaHMQZc/+m3WwhYc0TRtt2B4zSk8oznh8yiAwDbs3HLvUTQRp7W6NCDiDHqWbq2fWxFpqd
    5DPc0vyXqVq4EknQgyYzjTnp1U3LfT1QJWC5WyZoFw4AhksjVRarENAifITjHSfQKgQ5AI
    wrGxTUsJ3YPwqaeFRh4R24yc6carEM8iUOrHP+NQZzFlcvh33Rb9itatbU5w
X-ME-Proxy: <xmx:Q7YianBodlK9I_FscX7uFhfmBzN2f0k0z4MMrB3gmEdt6HaaLUPdLw>
    <xmx:Q7Yiai51kYAdfaI8HBCAvuWs_2mK4-l39rZmY7vNqKn5RX0MX1WdEA>
    <xmx:Q7YiavA6wiqYkIysquuVFuPGZO2GYYoUUC9vL6xnnBqV77sXIjrYlA>
    <xmx:Q7Yiau5JJ0_T8rOH5OCoGaLrs_VzPk87rSdzL49CDz7SrwgTrBu5Cg>
    <xmx:Q7YiajvNsJrn3ZWwPQTsrmbq05jobKiz1J7aPkGi1jpQ5fovWvLdX_3k>
Feedback-ID: i10464835:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 5 Jun 2026 07:42:57 -0400 (EDT)
Date: Fri, 5 Jun 2026 12:42:52 +0100
From: Kiryl Shutsemau <kas@kernel.org>
To: Chao Gao <chao.gao@intel.com>
Cc: "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>, 
	"kvm@vger.kernel.org" <kvm@vger.kernel.org>, "linux-coco@lists.linux.dev" <linux-coco@lists.linux.dev>, 
	"Huang, Kai" <kai.huang@intel.com>, "Hansen, Dave" <dave.hansen@intel.com>, 
	"Zhao, Yan Y" <yan.y.zhao@intel.com>, "seanjc@google.com" <seanjc@google.com>, 
	"mingo@redhat.com" <mingo@redhat.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
	"pbonzini@redhat.com" <pbonzini@redhat.com>, "nik.borisov@suse.com" <nik.borisov@suse.com>, 
	"linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>, "hpa@zytor.com" <hpa@zytor.com>, 
	"tglx@kernel.org" <tglx@kernel.org>, "Annapurve, Vishal" <vannapurve@google.com>, 
	"bp@alien8.de" <bp@alien8.de>, 
	"kirill.shutemov@linux.intel.com" <kirill.shutemov@linux.intel.com>, "x86@kernel.org" <x86@kernel.org>
Subject: Re: [PATCH v6 06/11] x86/virt/tdx: Optimize tdx_pamt_get/put()
Message-ID: <aiK1_q8beMcIEiwO@thinkstation>
References: <20260526023515.288829-1-rick.p.edgecombe@intel.com>
 <20260526023515.288829-7-rick.p.edgecombe@intel.com>
 <ahVghgNAe4JrmlQH@intel.com>
 <fe08f03a22acfe758cd97f7c2880deeafbc5fe58.camel@intel.com>
 <aiGq7XjmMrsqdBY5@thinkstation>
 <aiJhScChLZkH44eB@intel.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aiJhScChLZkH44eB@intel.com>

On Fri, Jun 05, 2026 at 01:40:25PM +0800, Chao Gao wrote:
> On Thu, Jun 04, 2026 at 05:59:02PM +0100, Kiryl Shutsemau wrote:
> >On Tue, May 26, 2026 at 04:42:24PM +0000, Edgecombe, Rick P wrote:
> >> On Tue, 2026-05-26 at 16:57 +0800, Chao Gao wrote:
> >> > > -	scoped_guard(spinlock, &pamt_lock) {
> >> > 
> >> > This converts the scoped_guard() added by the previous patch to
> >> > explicit lock/unlock and goto. It would reduce code churn if the
> >> > previous patch used that form directly.
> >> 
> >> Yea, it's a good point. I actually debated doing it, but decided not to because
> >> the scoped version is cleaner for the non-optimized version. But for
> >> reviewability, never doing the scoped version is probably better.
> >
> >I don't see a reason why we can't keep the scoped_guard() on get side.
> 
> One additional reason to drop scoped_guard() is that it mixes cleanup helpers
> with goto, which is discouraged. See [*]
> 
>  :Lastly, given that the benefit of cleanup helpers is removal of “goto”, and
>  :that the “goto” statement can jump between scopes, the expectation is that
>  :usage of “goto” and cleanup helpers is never mixed in the same function.

Fair enough.

But it can also be address if we free the PAMT page array with the guard
too :P

-- 
  Kiryl Shutsemau / Kirill A. Shutemov
