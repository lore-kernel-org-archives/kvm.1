Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.160.182
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793144827;
	b=wgHqdSYoSs3POXcNVqJEQaeCjsoFAe2yQQGiozXF4DmNxZ/4u1OW/sZr8tin0P1TnIYM
	 0YJvJiXZnnsF+sbqI2z4+CvrD83PYuohzk3NjEPEPirSlMNznlsRo9LMSMC9IbBDqerI9
	 YfZZRqTy7xwSKzdKbDhFhKRAXmAt94UR2zvRE4xIGjW7mbNK7FbS4gwU91P/QlBCzYvFx
	 mWC7gUaiBekbSKBpkd6WdRW27k/2UywwsnomNHAIMahukeaq9OPkHYdMFseNSRi8+bnDt
	 n2pYBvb3Q8NJwFBiZeqS0ALjgpgWjTEZCLUA6wGapZVHsbIVSdb7CK3ZlJPYL6mPRIw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793144827;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Received:Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=0jobZ6lKMJLYxxTCc8I8rfjGuzkz6VIrJqfxqZy7dVw=;
	b=qCXs6Vti1e9Lo9D6FGdSkZMfTHkug6qHhQNDXaWpB+NZomZhjSiEAJyKx3uFOR1py+ER
	 9MAT2LlEFJI/NBo61Cz+E+oIKHuPp18kYA+688fnschIk06JXs2SZsZdVpBcHfDbmMP4s
	 hhhdkChloTz706qYn2kM7T+Riph3bjn2A/jlutadbG4HZhd7h7JtRYpG6s+dnNT5/wezA
	 BKIddDYYnJaFW9Ypaah9ARnunsenRw/9Xvxag1v+Ks2UoYcGSqYeXLl49vr6wMUTcyx/E
	 jerOJbPfnFwL9MamrcIbbWlzYo1EtHL4r7gvCYttGa5VeQ9Q3pt79qUupy6ThgyfCGg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=ziepe.ca;
	spf=pass smtp.mailfrom=ziepe.ca;
	dkim=pass header.d=ziepe.ca header.i=@ziepe.ca header.a=rsa-sha256 header.s=google header.b=MAMauGjc;
	arc=none smtp.remote-ip=209.85.160.182
Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 359FA606A31D
	for <kvm@vger.kernel.org>; Tue, 27 Oct 2026 23:47:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 359FA606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=ziepe.ca header.i=@ziepe.ca header.a=rsa-sha256 header.s=google header.b=MAMauGjc
Received: by mail-qt1-f182.google.com with SMTP id d75a77b69052e-5365f9a04c5so7103411cf.1
        for <kvm@vger.kernel.org>; Tue, 27 Oct 2026 16:47:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1793144821; x=1793749621; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=0jobZ6lKMJLYxxTCc8I8rfjGuzkz6VIrJqfxqZy7dVw=;
        b=MAMauGjcQC5I4fdPuZtoQnkUL42Ja4RAOKAONT1AHTrTUlXxWwqX6qYADXfsEAR3/j
         hUis6BLTdqxH9lpDGbebIZ+F0qhK+3Gw5A5H3+z2NBgRxi4MH2CtjOQEt/4ZNf155hzB
         oTs4TdzanpcZpR/2BlKJXYZ5ayq9dCJ9KnWTYXDxPIGzp3UbV1x+jJ+RSlif0GRL/dJH
         j0OePIYXBil1ld6ZPKFMsFzi6F38i35BXCm6Zqet5zyQslJePMeaHITZMn+3CDTRQJk4
         QD6tYVzQJvCV1jaXUHg5KQO0GvIXtoG0gYWydzGqJE616loH3WeEVB2M4YGyBB7u1Jus
         n4fA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793144821; x=1793749621;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=0jobZ6lKMJLYxxTCc8I8rfjGuzkz6VIrJqfxqZy7dVw=;
        b=vKBLXshcVirDSYuAQbZ1mQLC58/ReOOhv34Oe6TaKuj0kt9hZ3SKSI+qd5r3FWa8gP
         Xu9ObQlN2psMmgX556oCn+zVg7qY3nTbshSiXR5hHUEv8GXpPNh/QADRNpt4riTQiMIh
         SaIPYN/3l5ehhY8SUTV0bYeZW0paFn8ET6ltQ0atFdc5VbG1iQvW/nfSedCEfa0VPVoc
         GFgb4N6o8quLWRBYhS8GIiq1V1B3fppVBHuqy8Z6iIXM33XIeAAWZTR8rbS6d6sxfIlT
         KFaNyZ3Idw8gvqxKahmfPq6E1BbDwgCJi+sXvkoovfnN3bLiT2NbEbA9vNzKXmUfevSX
         O/OQ==
X-Forwarded-Encrypted: i=1; AKwUvBwPV7T98vviiD1raaB/pDWluKmr+8OrD7t2YD83HsVzBtAyd76AB8oSnHwdkOBznxUR//8=@vger.kernel.org
X-Gm-Message-State: AFq9FYKrDHyjUqErtg70NoXOztm+NfZr/lxJcZymsZeha1FIxJbZBuak
	GCVtZGIxbDDTqiYwdaXoVMBGUBOnz+IvE1pA7G6QUj7oSpq6RC4YNVOuRJ3DBWwHaZ0=
X-Gm-Gg: AYBFou0HIkSuQL6EenmEGwSC++jrbjJA4KRSINlghLLuSDoHQL5ABkGT+SJ/4hTn+5m
	fhmwoDeNIIGb8sQQEZMKnw07x3aCaJ1sPj+lPBqd7burIpKu2RENX0C8AxLYHLto7+AShsd0oj/
	Pb2NFN15oHZBBxSb5jE2wZi4mCUBOyfQlBFeEIfqZSVLy3VVUE5seB5+r7rMkrl/LUuy6KXBt3w
	k1LgQvQE7a2z3NAfMox6GhN/rr5K0nhDA4UuXN2LomSONEUlzxQiqmIkGHT1c1IIe+vKwue823B
	3guXzRQnJFR6fK2SUBfIy3uERmY/mtmRJhYDEBWepppJRMNAkwnhoojZARKrZbzVB+YGBHA+Qxq
	9WeirJe686APswJomg7F6nAMXQWbbDKUZFI5Tv4G1DoTOL7OMP/rQq1lFZDU7ooJkBRGJQttUrH
	hiRfTOSvVAgwobuJHMffhUrm48ZGEs2D+M2xae49kOlfKSr4/0hWdodGTCdBM2fuKsetv6PzifF
	nLyVIrF7A5njvdA1fHKb65sU2b7xbZ9c9DUJqkp/nqWrsUlxRZu6l7TSV9cnAiGjkQn3Q5u6rYI
	x2b2xfCAvopgi0cHbLWrI3DqsYyPgs6AsX/g/M/dmHzZcZqUJEaedSjMic0+1O6XpFsRm+TYI/Z
	/OS9FJGPVcKY=
X-Received: by 2002:a05:622a:342:b0:532:8ed7:534 with SMTP id d75a77b69052e-53fcb7f9e76mr15856551cf.37.1793144820933;
        Tue, 27 Oct 2026 16:47:00 -0700 (PDT)
Received: from ziepe.ca (hlfxns010zw-159-2-239-150.pppoe-dynamic.high-speed.ns.bellaliant.net. [159.2.239.150])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-91c47a69129sm114200426d6.4.2026.10.27.16.47.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Oct 2026 16:47:00 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1xLqsc-0000000BHke-3ly0;
	Tue, 27 Oct 2026 20:46:58 -0300
Date: Tue, 27 Oct 2026 20:46:58 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Dave Jiang <dave.jiang@intel.com>
Cc: Jiri Pirko <jiri@resnulli.us>, linux-coco@lists.linux.dev,
	linux-kernel@vger.kernel.org, linux-api@vger.kernel.org,
	x86@kernel.org, kvm@vger.kernel.org, linux-doc@vger.kernel.org,
	david.quigley@intel.com, lukas@wunner.de, ksinyuk@kernel.org,
	rodrigo.vivi@intel.com, cedric.xing@intel.com, sameo@meta.com,
	drdeeglaze@gmail.com, James.Bottomley@hansenpartnership.com,
	aik@amd.com, jpiotrowski@nvidia.com, qinkun@google.com,
	pgonda@google.com, jic23@kernel.org, alistair.francis@wdc.com,
	ankita@nvidia.com, suzuki.poulose@arm.com, kas@kernel.org,
	rick.p.edgecombe@intel.com, elena.reshetova@intel.com,
	dave.hansen@linux.intel.com,
	sathyanarayanan.kuppuswamy@linux.intel.com, peter.fang@intel.com
Subject: Re: [PATCH RFC 00/20] attestation: Add a common subsystem and TDX
 support
Message-ID: <20261027234658.GL1685504@ziepe.ca>
References: <20261015145053.3664509-1-jiri@resnulli.us>
 <592d643f-e97d-4de8-9a87-e47d57dc8457@intel.com>
 <20261027193629.GK1685504@ziepe.ca>
 <5f33aeed-a20d-4881-9ccf-a69bc308d348@intel.com>
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
In-Reply-To: <5f33aeed-a20d-4881-9ccf-a69bc308d348@intel.com>

On Tue, Oct 27, 2026 at 04:09:19PM -0700, Dave Jiang wrote:

> There are two issues for TDX Connect. One, the device info is collected at
> SPDM connect (TDH.SPDM.CONNECT), not at lock. TDH.TDI.BIND only returns the
> interface report. So the measurements a TD sees at lock can be from well
> before the lock. To get measurements taken after the bind, the TD has to
> ask the VMM for a recollection with its own nonce.

IMHO measurements taken before lock must never be made visible through
this interface, it defeats the security property of evidence within
the locked session. I would expect the guest kernel TDX driver to
prevent this.
 
> Second, a device may take a runtime firmware update of equal or higher SVN
> while its TDIs stay locked, unless the lock sets NO_FW_UPDATE. The
> TD isn't

Sure, any of the live update things are not really relevant, the
evidence can change asynchronously and without notification, so we can
just ignore the issue. If the guest opts into live update then it can
only rely on things like min svn.

> > I'm a bit puzzled by this optional challenge concept, I haven't tried
> > to read SPDM spec yet, but it really has a way to omit the challenge
> > from the reply? It doesn't just replace it with 0 or something?
> 
> SPDM puts the requester's nonce in the GET_MEASUREMENTS request, and only when
> the request asks for a signature. The MEASUREMENTS response always carries the
> responder's own nonce, and the signature covers the request too. An unsigned
> request has no nonce and gets an unsigned response.

Returning an unsigned collection seems like an interesting use case,
but why would you want to do that in the first place?

> The empty challenge in my provider means something else though: don't
> recollect, return the evidence collected earlier. So it's less "omit the
> nonce" and more "no new collection". Maybe that's better as an explicit flag
> than an empty challenge?

I'm not sure 'no new collection' is an especially useful thing. Since
the kernel won't be validating the signature you still need to pass
the expected nonce from the prior collection back to userspace so it
can check it.

Is there some specific use case for this?

> >> 6. tdx_attestation_test's discovery_and_construction_fields expects an
> >>    inheritance chain of 4, but the TDX family inherits ctlv-attestation
> >>    directly, which gives 3. In a real TDX guest it fails with
> >>    "Expected 4 (4) == ctlv_chain_len(self->dev) (3)".
> > 
> > I would have naively guessed this should inherent from some SPDM family?
> 
> The TDX family is the TD's own attestation (TD report, Quote and RTMRs), with
> no device or SPDM in it. In wip_attestation_all_1 it inherits ctlv-attestation
> directly, so I think the test's 4 is what's stale. Jiri would know for sure.

I think TDX report/quote/rtmrs should be a different familiy from TDX device
assignment SPDM. They are completely different things.

Jason
