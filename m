Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.219.52
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792500924;
	b=VIxUEIRHNhYM8vXsLDIYjH04GtjBC8S0KZ1LhAv2f+fIqJ8r3irK9zo/Jfbhi+efv4mP
	 E/FxVVU65lZpCh8VPPoAmx8jkvw6cdFj93mu30OKZ7aAc2GvPBmaV4oovq5EGHXMXqe1h
	 pUvmXvd1gar1CrZeNP92Ds74Bo1qOiZ4vdYx5yqf6WV2O/MhmdYgzjxytpWmAib7hMgFx
	 9Qkw14MQcKmOtz3LEdi8O/ejD7QvD3IlTXdrkD8fHVuIKz1Z2VYAKFP3kkF3IKzb8u7pl
	 PxtEkOWhZ8IdxljL5Lq0kgbHuBZVAz+/S1RqBeBKtfqePgXKenjbUrKNX42T4/CRzyQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792500924;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Received:Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=XQOUTOVFh8JzZI9kzVmkfR5g5tplHfGAGARfyUUcUvk=;
	b=vEOTK+mY3KAiRJG29qTeRyMrSk+e+kUubjjaXGksECw9sjFd+SRwW5+OBij8M0FXR5Pc
	 s/PDjP2Q80zsxjwhNVj12ZeiCj0YR3Aj4Lj2tr8tLwdGTkSLBgR/bwDSYS+PENQNiSPgM
	 X8VI5wzTGu5NRnc8yox1Dn/tPiWDKHNjDQL3r+ZB94o7SIk70j7rg37gpkpPxnc6tgFP5
	 +zBX+sq0QbIme7nsFylBjud9mEvmx0KA7u8ury9cwc4F/+uqOtiZmoauOPBx734jwVlVP
	 AjpAdbXDoW8zDvF2ioEh+bTqJ6VzvbieIWfX8dPyhwe2GpGrufrLlbUilsR7Y1jYlKQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=ziepe.ca;
	spf=pass smtp.mailfrom=ziepe.ca;
	dkim=pass header.d=ziepe.ca header.i=@ziepe.ca header.a=rsa-sha256 header.s=google header.b="Ip/eppT6";
	arc=none smtp.remote-ip=209.85.219.52
Received: from mail-qv1-f52.google.com (mail-qv1-f52.google.com [209.85.219.52])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BB1C606A320
	for <kvm@vger.kernel.org>; Tue, 20 Oct 2026 12:55:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0BB1C606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=ziepe.ca header.i=@ziepe.ca header.a=rsa-sha256 header.s=google header.b=Ip/eppT6
Received: by mail-qv1-f52.google.com with SMTP id 6a1803df08f44-917ad52d7b6so35335806d6.2
        for <kvm@vger.kernel.org>; Tue, 20 Oct 2026 05:55:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1792500923; x=1793105723; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=XQOUTOVFh8JzZI9kzVmkfR5g5tplHfGAGARfyUUcUvk=;
        b=Ip/eppT6lIOeHIgd9ePC/agK6WRPZ0LvrXW2qIgtRclhuB4uCSmSrxlrJG++jx7x8Q
         GxRJ9aVKNiguohDmkJur58tjsyvXwHpL80A1HqiszhOvfukAvzQCVsNG48fczWZCjyuK
         99WHOIHNNv7xPeXFebwW7pSdNeiVuHiGnXCtBOZIkocrPApbJQ/crl1qxsKkg8sB7DwS
         +GmVdzy8lDjOrzMnLBUthRpSfV2LciwfmcjKgTvhRyAvhVXo4wGnBkqCMLS6VTDKsFKf
         4jQx3eRIduJnj35kxC0dEzhiB7AZKjLl1y/cXPEpKJEm1g109Nh1dhx63WFjunhwttRT
         D9Ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792500923; x=1793105723;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=XQOUTOVFh8JzZI9kzVmkfR5g5tplHfGAGARfyUUcUvk=;
        b=cSQlWoR0oS8g2i7q8KFCXySwf/g2adpcGhBoYFGv9EysZHIxCJKVvcx4NlSonxJsOj
         NIx/nicY0WZYu0VgibDzyye9fGUZlqWh5oU+xhA+2RXTlIzNzgw/WGISb+ru1keYtwzz
         q1BPP4cCli8ELaLIrtbuNoGOr+rxWn3YAfDVWaGp4KJImdWJNwiBISb1VXywrHvUOImV
         4LwR80kTg7whCKNYlSgEgBT7QmQIupq2NE3s2B94wrARjTzSeGUoH96Py4ogA+mQxYVO
         5uYg8tKqBF5WVXwYF+N6h+8X3uuRgvBN6oVIx8WTzBlImGiaw0kNa8wQ1FwFB/Q+VreJ
         wKaQ==
X-Forwarded-Encrypted: i=1; AKwUvBzP488Mf6NX58g2wQo/B9QZylliaipXRxDTQZm7AibHWgEsCbIYCb7Jl54oVpQpp17dieQ=@vger.kernel.org
X-Gm-Message-State: AFq9FYKgX9qNDZ3lj24hvx2JbTKH5RXkZoD48/nFf8JaE9hEYeFnuA/a
	OLhseYCkvxj3mtK/Wu5rDdJKJ1By5MQ08phyw6q9C8nK2x7fJri0Lyn5FNuz1aGSSZ8=
X-Gm-Gg: AYBFou120t8luEv4WPq0UOfJBuAbE/fsa67vArUxfSyi8Pva8UgyXrMBA8JwrFa5jy8
	vQkW0bCWy+BSSmew7x5Ygvt+SgRmXst+rM+4DxT4XoBKbrcjOWe6dNmPxShtBRjnnWjRlRWX5IS
	KHkKlN+88kXIO8zWhm8WdtOCNub4g70vUDHUX6Ur8d+XC/ftc2jgxIvB1zAllc4OA8lctZGO1ch
	RpOg6PDECsHQZZq4xCmk6l1Z+LhRk4pAdSKXm647sz1jcofPO2Km1eO1pOrCkr89ioAcQfAXQeE
	XcHf7xAdNdxKCIjpHxPrMLqcsljJ/CPPtd96gN/49cpJJp9CDGkeGryFLVNH1wMnfe+ruQv6iwG
	1WtqT75WsyAI6niPVkYfVy604PmN1osNngV6+tBjx+5OzCLPiLE3RSkLcrtqBsesC2g6REUe2Gz
	0wzDiovTyzpjxq5fR6PmH6zyTHcmjAAgb2g+AYT4fzUvBdTcPKYAkTVQXe6ulIx3jekBnOizopj
	rz7vAOh1+rPpfYSHWZ+gWfHacnY47YmuHk9yy6UKVJGBkd/S2gqabnK
X-Received: by 2002:a05:6214:626:b0:917:8752:8214 with SMTP id 6a1803df08f44-91bdec2e198mr180120836d6.1.1792500921889;
        Tue, 20 Oct 2026 05:55:21 -0700 (PDT)
Received: from ziepe.ca (hlfxns010zw-159-2-239-150.pppoe-dynamic.high-speed.ns.bellaliant.net. [159.2.239.150])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-91c03da5b4asm26796476d6.0.2026.10.20.05.55.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Oct 2026 05:55:21 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1xJ9NA-0000000CTFP-3VJ7;
	Tue, 20 Oct 2026 09:55:20 -0300
Date: Tue, 20 Oct 2026 09:55:20 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Jiri Pirko <jiri@resnulli.us>
Cc: linux-coco@lists.linux.dev, linux-kernel@vger.kernel.org,
	linux-api@vger.kernel.org, x86@kernel.org, kvm@vger.kernel.org,
	linux-doc@vger.kernel.org, david.quigley@intel.com, lukas@wunner.de,
	ksinyuk@kernel.org, rodrigo.vivi@intel.com, cedric.xing@intel.com,
	sameo@meta.com, drdeeglaze@gmail.com,
	James.Bottomley@hansenpartnership.com, aik@amd.com,
	jpiotrowski@nvidia.com, qinkun@google.com, pgonda@google.com,
	jic23@kernel.org, alistair.francis@wdc.com, ankita@nvidia.com,
	suzuki.poulose@arm.com, kas@kernel.org, rick.p.edgecombe@intel.com,
	elena.reshetova@intel.com, dave.hansen@linux.intel.com,
	sathyanarayanan.kuppuswamy@linux.intel.com, peter.fang@intel.com
Subject: Re: [PATCH RFC 03/20] ctlv: Add the root family specification and
 generated files
Message-ID: <20261020125520.GN14213@ziepe.ca>
References: <20261015145053.3664509-1-jiri@resnulli.us>
 <20261015145053.3664509-4-jiri@resnulli.us>
 <179245258505.58760.6060356114682279013.b4-review@b4>
 <atdeH3nA_gkLwPLM@FV6GYCPJ69>
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
In-Reply-To: <atdeH3nA_gkLwPLM@FV6GYCPJ69>

On Tue, Oct 20, 2026 at 02:28:55PM +0200, Jiri Pirko wrote:
> Tue, Oct 20, 2026 at 01:29:45AM +0200, jgg@nvidia.com wrote:
> >> [ ... 238 lines skipped ... ]
> >> --- /dev/null
> >> +++ b/Documentation/ctlv/families.yaml
> >> @@ -0,0 +1,13 @@
> >> +# SPDX-License-Identifier: ((GPL-2.0 WITH Linux-syscall-note) OR BSD-3-Clause)
> >> +%YAML 1.2
> >> +---
> >> +# Append-only registry of CTLV family names, indexed by family ID: the entry at
> >> +# index N has family ID N, up to 65535. The root family owns ID 0 and heads the
> >> +# list, and every other entry comes after the entry of the family it inherits.
> >> +# An entry may be marked deprecated, but never reordered, removed, renamed or
> >> +# reused, its position being its wire identity. Every entry must have a
> >> +# specification in specs/<name>.yaml, and is added by the change that adds the
> >> +# implementation. Fixtures under tools/ctlv/tests/ are not registered.
> >> +
> >> +families:
> >> +  - ctlv
> >
> >I see where you are coming from with this, but it is going to be
> >problematic from a global kernel perspective. Given CTLV is imagined
> >as a general tool for any subsystem we cannot control the tree that
> >things merge through. It will not be like netdev where there is one
> >authoritative tree with a linear history.
> >
> >So if Bob and Jane maintainers both add their own subsystems by the
> >time it gets to Linus the IDs will get scrambled, and bisection will
> >be lost. 
> >
> >Either changes to this file must be strictly done in a single tree
> >with shared branches (which is going to be a bit hard process wise)
> >
> >Or we need to put the ID #s here and have some simple process to
> >coordinate them during the development process. Since new families are
> >probably rare it shouldn't be a big deal
> 
> Exactly. Collision is not very likely. Explicit ID or implicit, scramble
> would still happen. And in that case it is resolvable.

I think because of process if it is kept like this we will have to
merge 'dead code' to reserve spots for people doing new work..

But at a minimum this comment above needs a big fat warning not to
change this file without consulting with XYZ to coordinate merging.

Jason
