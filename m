Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.219.53
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794316278;
	b=Z+41Sf94vlGmoDB4U5A9YHgLClg3TKYo96LVxhey7YMTxawFju9vkNjnjAOZIVHNqzPw
	 c0IVhj8QaoASwOqf4GXVENAFanoRBeeW0Q8HBcjpGRVResq0OEuv93xMTsFQeIbHCwBV1
	 oGRynV4uNI0kOcyjLszYnyCWdtcJysPbjZ+lqqjfThThWMiW69w7VQwRXIU4RT5tdCpt8
	 jGBbN3Pd982ZbwzbU+9+sKl/tNzS5DCVc2G59Tjrz40eWzUTHkrz09EpsTdSKHsAWh6aP
	 Q826stF0y67nXQKK+NvqrRxGmOqVxlwJeG0T7HgNm26hYqSBPVDkoIX2Q84j0zAKzBw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794316278;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Received:Date:From:To:
	 Cc:Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To;
	bh=hv46jG8uHZHn78TEQV5LM7K76EVF6QARAJT1M8iUKJw=;
	b=iSz2MY8r6pTZ2ZiUGXPo2UELCO0JkiyLXXrf2EH/jnX/3mbkGN6QOEH+aP8K8FYuPatq
	 jhqGuppSuob4y6q1pNRJXoGhnCpDxamLUlawOxlASs7l+XxcW4tvRO4lyK9wR2lXN9mcF
	 oYocPwi3YBGvWRRV4+Y3jD7PJ/NjozW7G9b+B2nJPxDBExtgNmeu4iAHIay9O73f3dyFG
	 EwXU8z6BDuxX3hl4MLp77rPpwW5AvWfSXCCbTopuVdCUxR46xf2x1f0CmxgVAYmyjQc6H
	 aaEn+6AGkgfkeoPyoazGvlHybB2Q7/QB6C3aouOhBi7OH1bgcGal+oScDKLvkJsBFWA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=ziepe.ca;
	spf=pass smtp.mailfrom=ziepe.ca;
	dkim=pass header.d=ziepe.ca header.i=@ziepe.ca header.a=rsa-sha256 header.s=google header.b=e4PFNw24;
	arc=none smtp.remote-ip=209.85.219.53
Received: from mail-qv1-f53.google.com (mail-qv1-f53.google.com [209.85.219.53])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 131A5606A779
	for <kvm@vger.kernel.org>; Tue, 10 Nov 2026 13:11:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 131A5606A779
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=ziepe.ca header.i=@ziepe.ca header.a=rsa-sha256 header.s=google header.b=e4PFNw24
Received: by mail-qv1-f53.google.com with SMTP id 6a1803df08f44-91ea3f6a506so16685846d6.0
        for <kvm@vger.kernel.org>; Tue, 10 Nov 2026 05:11:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1794316276; x=1794921076; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=hv46jG8uHZHn78TEQV5LM7K76EVF6QARAJT1M8iUKJw=;
        b=e4PFNw24vmEx9e6XM/cUzCvRERvJabuTvhno9Gz/JzeZWoLyAEqlwt+PiN7PsREzDe
         nbBIpkI6JTuornnBm7/42NrL/w4IdXPpgJMXAMUPCFd7jbdDVIEmKh/jdZ+I+dzViXSB
         H2p2NQNLx9ne0cV1aFkGD5AsPCtzbh2oXhKE+mtPHEk6ablNOVM/G42JAjOhvFRRvEdt
         SknBoahXSauvPineguU97Ohz82cWAZt6yPRa0ML5YUk7kVUMnIDJn8DUcWsiXLLwSwNl
         eFseGz8JV2OEeli+2NBdOH9OYZhu03xI/lkGEnFQ2GC/c8NKeMa66k6Yl0PwfnR2fGbK
         Y+Qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794316276; x=1794921076;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=hv46jG8uHZHn78TEQV5LM7K76EVF6QARAJT1M8iUKJw=;
        b=o5wa9tPbjLWuXuFwsu7DEqbEDBUtGZOKOtXpuxE/W+wQ1bGrE+4q3GDhHNP4vqJRIe
         mddrEEGzT4ikkuf6nr2M8qfVZ4xyes3xRs0sC/oaOJhp3SuaUS35brUdqryq5g3rAe+A
         DPPUHxrAwTEKYZLx7To+n7Nd+LgUV5DGZttVCfyM/WJRKjHb+v7n8L9L9lKeiU+HWs5b
         jAyvJWlPn2HzKz6+vwbjg/L1/xPdll25WoxLbbRq7L4b0c1CUI3dnEW+lX4/suX5rpjF
         bLSRG2r5bLJo0U5n+iXQGgnP9vaKOjZfHyPxtafFVXT3MMsXthjiBfm6s76AtEB9WVT2
         0bFQ==
X-Gm-Message-State: APuU4Z+I2kwbyDu/6PjJ5oCGI5tKVVO+mR5ztman2W1aFxT6pJeGYOgj
	vNC7ZMBWXjlsBU2J1sqNRSwkHDX6icHfDiYUl/8yPR3ZlDRlK0LYSu++i7qUAg0QXuo=
X-Gm-Gg: AYBFou0qDD7B3H5h37Fb1x2SpTC7g1EjhYNPeHFfUjCvq5Mm2bDGchuCwM7dLCCaKsm
	wTrZbXGVXU1Zf/x8bGeSBHp//tyHT77nZpxIofhkhymZl3cLpMwz6qQiLA+3giQGTGqVXPdZ1nF
	R0VTnFRXnEovsvhOxyWmjbnMw/Pqre0j2eiylV9/I5Qo5g1LBboCusmOkYnOfHHD/NANPNTybmk
	Agw6nsJJblXu7FQ+h4UKZZv7oXwVJht6GlyjrSkWH7r6jHG9rxsGXdf0l7PQlBWEF49Pp8fqNg1
	cDKAr4Ph/gKUsQEc8DkzPhPvKzpQqHnYnHqnRHz9mVCU96SSdBXuBxhvwM3t3RqVBOkYP+VA0IX
	4xkAeicWkLvnxheuPVZLxw6cQ12IZdcJ4/pamf6X2nJss8sCnAKrX60RlRaVBoyrkbxo1sD4pMF
	03QaIVcZmtobbxP+SQBskHeYzubsxBH7zfoywUyLg5fovSzl6Ib/K9n300YWlEQk2R8geiJE20v
	6t4ACUtogP5exVnL1DFzqLpbJ06wm1Jq6nD+68V7qhDgKi/T3/5mCDthUf4G+CbYpiDLJcqUOxn
	JFZ3XFZMmdHDOkNRGWzSQxaxIrq2dZ3m3xJMkWEHyayM8PDV9YkscWmhulCPIgJvtZPpiKGY0yf
	H5DEHUuR9hL0=
X-Received: by 2002:ad4:5cc4:0:b0:91e:96f8:f369 with SMTP id 6a1803df08f44-91eef913f53mr42602176d6.36.1794316275746;
        Tue, 10 Nov 2026 05:11:15 -0800 (PST)
Received: from ziepe.ca (hlfxns010zw-159-2-239-150.pppoe-dynamic.high-speed.ns.bellaliant.net. [159.2.239.150])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-91ef052360asm20821916d6.38.2026.11.10.05.11.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Nov 2026 05:11:15 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1xQld4-00000005faP-2KGJ;
	Tue, 10 Nov 2026 09:11:14 -0400
Date: Tue, 10 Nov 2026 09:11:14 -0400
From: Jason Gunthorpe <jgg@ziepe.ca>
To: "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
Cc: "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
	"linux-coco@lists.linux.dev" <linux-coco@lists.linux.dev>,
	"drdeeglaze@gmail.com" <drdeeglaze@gmail.com>,
	"James.Bottomley@hansenpartnership.com" <James.Bottomley@hansenpartnership.com>,
	"aik@amd.com" <aik@amd.com>,
	"dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
	"Xing, Cedric" <cedric.xing@intel.com>,
	"alistair.francis@wdc.com" <alistair.francis@wdc.com>,
	"linux-api@vger.kernel.org" <linux-api@vger.kernel.org>,
	"Reshetova, Elena" <elena.reshetova@intel.com>,
	"kas@kernel.org" <kas@kernel.org>,
	"ankita@nvidia.com" <ankita@nvidia.com>,
	"jiri@resnulli.us" <jiri@resnulli.us>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"Jiang, Dave" <dave.jiang@intel.com>,
	"Quigley, David" <david.quigley@intel.com>,
	"linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
	"x86@kernel.org" <x86@kernel.org>,
	"jpiotrowski@nvidia.com" <jpiotrowski@nvidia.com>,
	"suzuki.poulose@arm.com" <suzuki.poulose@arm.com>,
	"lukas@wunner.de" <lukas@wunner.de>,
	"Vivi, Rodrigo" <rodrigo.vivi@intel.com>,
	"Fang, Peter" <peter.fang@intel.com>,
	"jic23@kernel.org" <jic23@kernel.org>,
	"ksinyuk@kernel.org" <ksinyuk@kernel.org>,
	"sameo@meta.com" <sameo@meta.com>,
	"sathyanarayanan.kuppuswamy@linux.intel.com" <sathyanarayanan.kuppuswamy@linux.intel.com>,
	"qinkun@google.com" <qinkun@google.com>,
	"pgonda@google.com" <pgonda@google.com>
Subject: Re: [PATCH RFC 20/20] attestation: Add the TDX family implementation
Message-ID: <20261110131114.GV663069@ziepe.ca>
References: <20261023141218.GD3977851@ziepe.ca>
 <343e4a12f2fdbb4e9a19c4afe49cf2b8908d6739.camel@intel.com>
 <20261023220030.GM3977851@ziepe.ca>
 <7843a833723e3aad40f8fc4de3a83f5a5059280f.camel@intel.com>
 <20261103005851.GH3889730@ziepe.ca>
 <au5LCE1jau0yDo5S@intel.com>
 <20261109171236.GP663069@ziepe.ca>
 <cbef9bda9241ffe98652172edb67fab3eb1c35ee.camel@intel.com>
 <20261109234252.GR663069@ziepe.ca>
 <4c75b369b68c98c5c35e296895b6935342dc7dc1.camel@intel.com>
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4c75b369b68c98c5c35e296895b6935342dc7dc1.camel@intel.com>

On Tue, Nov 10, 2026 at 01:30:16AM +0000, Edgecombe, Rick P wrote:
> On Mon, 2026-11-09 at 19:42 -0400, Jason Gunthorpe wrote:
> > > So we have this SGX based quote format that is fixed because it already
> > > exists
> > > in the wild. Going forward we are moving to DICE, but that is a standard
> > > format.
> > > So also somewhat fixed. I guess the question is: is there some combo of bits
> > > in
> > > each blob we could check that could deterministically distinguish between
> > > the
> > > two? To do this we would need to analyze the quote formats.
> > 
> > You guys really didn't make it discoverable when you added DICE? :( :(
> 
> Like influence the DICE spec to interop with legacy SGX based attestation? I'm
> out of my depth to try to say how possible that is.

No, I mean just have the SGX firmware tell the OS if it produced a
DICE or legacy blob :(

> I'm also under the impression that the quote was not designed for local
> processing in the guest. But rather remote attestation which, usually involves a
> helper service that processes the quote. I've never been clear on why that was
> desired. But it probably is part of the reason attestation doesn't fit this use
> case perfectly.

Even the remote helper needs to tell the two cases apart so it can
parse them

Again if you expected the user to pre-tell the helper that this is a
legacy vs DICE VM then that's exactly the bad user experiance I want
to avoid.

> > > If there isn't, I'm not sure what we could do at this point. There is a
> > > library
> > > Intel publishes (right Peter?) that can verify the quotes. I'd guess it must
> > > have some way to distinguish between the two. Can you check how it does it
> > > Peter?
> > 
> > See this is exactly what I'm talking about, I don't want to repeatedly
> > get into this situation down the road over the next decade.
> 
> I'm not sure if I'm missing something. New incompatible standards seem pretty
> normal? Sometimes there is a container to specify which type of blob, and
> sometimes it is just discoverable by clues in the bits.

Yes, completely normal. The thing that generates the data should have
an unambiguous contract with the OS on what kind of data it will
generate.

If you want to change it, thats fine, but the OS participates in the
change and is aware of it.

> I think the thing that is a bit dicey (no pun) with this, is that there is kind
> of a backwards compatibility adjacent change for systems giving the new DICE
> quotes. This came up in in both discussions with Dave/x86 and Sean/KVM. The
> reason why it was considered grumble-ok in the end, was because the full
> verification depends on updates to the library for each new platform due to
> needing to be aware of new keys. So to actually attest even SGX quotes on a new
> platform, library updates are needed to whatever tool or service is being used.
> Since the library needs to be updated in any case, it can also understand the
> new formats without any impact to the user.

I don't know what you guys have done here. There are IETF standards
for all of this and well defined container formats. Sure to parse
every bit of the token you might need a new library, but you should at
least be able to get a signature verified and parse the generic
information reliably.

If your plan is TDX releases are ABI incompatible with the verifiers,
then thats a horrible plan and *much* worse than what ARM is doing,
for instance.

But it sounds like your library can somehow parse the blob and figure
it out, so maybe it is just a matter of describing how that works.

> But this didn't take into account this generic API, local quote processing use
> case. Which is kind of a surprise and I'm actually still not 100% clear on how
> it will be used.

It is not local quote processing. This is labeling data properly so a
verifier is possible without the user having to manually and directly
inform the system what versions of Intel CPUs and TDX modules it
should expect to have.

> I think we would have to circle back with everyone that pushed for the host
> controlled quote type. Let's see if the library can distinguish them already
> too. This attestctl tool... is that something that could consume a library like
> this? Or something that would have a no dependency implementation?

I would hope for no dependency, the idea would be to provide
references for anyone wanting to make verifier software, and a tool
for the admin that wants to debug/understand their systems..

As well as a point to have a strict injection of sanity into what
people are doing so we don't get repeated ABI breaking instances in
future.

Jason
