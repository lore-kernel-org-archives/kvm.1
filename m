Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.50
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793311801;
	b=xRAPvaqYd3Y9VnREtT/yqFDJXCLmunjzpAMbN/eNf7tqdU0NT4aHPLvXyuJN8qfDwYbu
	 IDh4OYc4AXiozPNQde5xLxTaQqBdR23YEtz0mb+TR7hznaIiZQTgB1z/J1tAmGtA+sBKX
	 yb+1u1Yp6Ac1yVJENHEol4TBAaGG5yhq2zr4ILXJIChyD9CPKHAEuWnvYWsqIMKsTDtEQ
	 Q2g7BgtfknThwL5tKMSi/hcDhEw3PpCUYZYZkmhEkW+XymI+mXwb0GjrIDZnID5KUtG0P
	 aiPds1s86DR08gBi+3fqNvG8ITLPzPMmyuwOcVN4HY5bcR6e8BlrDOXTIiQ1KPeowHA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793311801;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=iWxGzUiL9af49cd3f3h7Wfqs2xiIj0zeQzBJaUAAk5Y=;
	b=xCj1xvrAli5UElPNp2+2/FwprjvwTFJfi95mUtbCo8cO95NkelAJMFL9zMadUNafrj5q
	 O9XrRC1etnQNS7d/ZNVFN4L+seSrcsgsfsIBAQDYHV1mogPDUyegPXSJA+UNkJuP2ZLZ3
	 Dou60CXiMnU/COyVcX1Bgg1xu1sgg1GgvNP5bERHOk5TeViQcG1J5B7R7A9KLkIeiKSif
	 QqC9SLQK29PwzTpqKQW+6BYW1ybHEK67xVicW6sXKc88bGJkVBNjOtGr/8MkkNXVtaVD5
	 iTo2jcFGDWpDhuRR4ig4ifhedybYpWkNUzJl/aJ2jWJ34bhLOl9XEsYFZMBgpWUVfEg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linaro.org;
	spf=pass smtp.mailfrom=linaro.org;
	dkim=pass header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=mddmqQ5a;
	arc=none smtp.remote-ip=209.85.216.50
Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3410B606A31A
	for <kvm@vger.kernel.org>; Thu, 29 Oct 2026 22:10:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3410B606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=mddmqQ5a
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-3ac77270fbfso27299a91.2
        for <kvm@vger.kernel.org>; Thu, 29 Oct 2026 15:10:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1793311800; x=1793916600; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=iWxGzUiL9af49cd3f3h7Wfqs2xiIj0zeQzBJaUAAk5Y=;
        b=mddmqQ5asrqC75L2zJNZFe5fz5XeT2N8DEMnqSuNwkziiDfeVA2PrAGWABMnvhABCf
         wFOqh+0rVIy/mxQz9KED65v1HOGFm/VPtRw//1o3epTmov//qBVAC1HMtCih1Z7hOfLh
         wZmQTYXMkjGKtwLAyyUIgTobU8f97Nt1GO64zKmjau0Nq0Zi7tXgJxYU2xduOuSJNE/v
         ts2gJVDs7ikvDNkGM4k41Gin5XcY7e/WVZHcTC3TadwkqveCaMB8bWVYMhEhY22sbKlZ
         ygvb9YDEuUO3SIVZJj0xs2c5o599IW6doKG9sprptiekQjA2VMmNvZy0ngVLi01Eykr4
         Bxcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793311800; x=1793916600;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=iWxGzUiL9af49cd3f3h7Wfqs2xiIj0zeQzBJaUAAk5Y=;
        b=reU+28lgeTVpgzrXsg7xXrbbCg8vVM2c1bSf/e2V9OOdZJ3KghCmO2vH7qJLaxSq2g
         EM//3LIVAeCd5k1/rNTrewsfRT+grqVc8hyzlyc9nRlG6BJz6gc5ha1l0jqD+9nAi4t6
         uyNHAiyTy46tYChdnyOtMQF8tKi/m5JIYdj6ZlhSQbU7ySJvwIwZZQyZsUOcx/FLJ/ge
         OXHuMpv5wTG6bIXXNqU39zSLrMQKQ3nq6G/4nHGeFvBGyRE7DKC4enRFrjyYeKQsa9Yh
         LHH5mSwLYRj9cZ9AwBNt87Pza3iDxfC/XMsPZRzjnnlC4H3k7tIYK2UjsN5ZVCVLQhCy
         1mcA==
X-Forwarded-Encrypted: i=1; AKwUvByfqP4gfhRFUvYrSkhNlQl+AOWPjdk2xX4aoSlQYo9G2EQ1uAqmvAUumyhqhZFYJsniDH8=@vger.kernel.org
X-Gm-Message-State: AFq9FYKk2yVQDOe/Jx5MCm2yEyGwDf8D1Y6RX4cfx5kXAyrpoHN56zit
	EOyhatS09MBbFVsciW69I8mVR22qjIyVJt0JDeDtStlZLNf+Gb+zRfuKys9OnLNXMlE=
X-Gm-Gg: AYBFou2bSU1SfafgZT+VUac1Qhpd3Yzn1HS5crkslimNsJGibnyq53o9uOArz1q4Ppj
	liVIFdKYlOE2qQVeJA4Z4XBwFjdqaHKFi4niGqT50GyMrT7kaRdjve2OwTPJdCWMokEC04ucw/6
	f8DzHowQ1oU99ud32CFnDoXLT4YSpptuiFxQ9SE5bC2qD06jfjR2GBaOmH4Zmv2/74VtO6EC52U
	ljNWbJAW2uMg1Cn7uGu1DkGnlvqAROlYSa1C9GpcjApsWznFgmdzR7G1YiGYvd5vzbPfJP6lAt+
	G1Eih/CoMjzzqil83z4bZRVQ7r06GQ5ZCn8BdH/UPw+jZg7Txe9ei0dOS/0yzsERa7Ni0dK7SVe
	bShgzKL6giWIO+pnUTtJhPekdly187X1psCRDSB+/rdTLhetqupXSiTjUvsZVAdLRmxDyBPwDX1
	Ni2VRT0IuusBa+BkK0LbxA5uccIbnRQashp85ndzOP/PjiHueiTnmhSUELRsDja+u37mF+Wdokr
	DxbjhjwOZ/ZJ9vx8J+L416GtldbwbUrpurrRZf3NuQtLBtqYyswwIeCJnsG85mDYsbKv+rCUcBt
	hu5egg0WnJiocCC8R+zIAdjttasjAf5j
X-Received: by 2002:a17:90b:5847:b0:3ac:17c:6e89 with SMTP id 98e67ed59e1d1-3ae89773f17mr244310a91.19.1793311800386;
        Thu, 29 Oct 2026 15:10:00 -0700 (PDT)
Received: from p14s ([2604:3d09:148c:c800:97b0:7603:db48:102e])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ae85f662basm344514a91.1.2026.10.29.15.09.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Oct 2026 15:09:59 -0700 (PDT)
Date: Thu, 29 Oct 2026 16:09:57 -0600
From: Mathieu Poirier <mathieu.poirier@linaro.org>
To: Kohei Enju <enju.kohei@fujitsu.com>
Cc: Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Gavin Shan <gshan@redhat.com>, michael.roth@amd.com,
	berrange@redhat.com, kchamart@redhat.com,
	pierrick.bouvier@oss.qualcomm.com, peter.maydell@linaro.org,
	mst@redhat.com, cohuck@redhat.com, pbonzini@redhat.com,
	eblake@redhat.com, armbru@redhat.com, lorenzo.pieralisi@linaro.org,
	qemu-devel@nongnu.org, qemu-arm@nongnu.org, kvm@vger.kernel.org
Subject: Re: [RFC v4 03/24] target/arm: Add confidential guest support
Message-ID: <auPENXGj6cVN1lSt@p14s>
References: <20260903193611.1058589-1-mathieu.poirier@linaro.org>
 <20260903193611.1058589-4-mathieu.poirier@linaro.org>
 <dhrvydsmaw22xqx5d5i5s7fdyjxupz27yxp6trv2tesysp4npj@quvzrxjvfipz>
 <arI197vJkW75p50c@lpieralisi>
 <arSTQQ5uB6oR-vFe@FCCLS0092175.localdomain>
 <ataBkrIvULJXj4v6@p14s>
 <784dfea3-24cb-4e70-ab46-b96b4b9a1831@redhat.com>
 <at-Wkw7a3Tn3Oh3M@red-moon>
 <auF8rstVcvsDUO6C@FCCLS0092175.localdomain>
 <auO3OKQGWiqtTcWU@p14s>
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
In-Reply-To: <auO3OKQGWiqtTcWU@p14s>

On Thu, Oct 29, 2026 at 03:14:32PM -0600, Mathieu Poirier wrote:
> On Wed, Oct 28, 2026 at 01:51:29PM +0900, Kohei Enju wrote:
> > On 10/26 19:06, Lorenzo Pieralisi wrote:
> > > On Wed, Oct 21, 2026 at 11:42:14PM +1000, Gavin Shan wrote:
> > > > On 10/20/26 6:46 AM, Mathieu Poirier wrote:
> > > > > On Thu, Sep 24, 2026 at 12:12:35PM +0900, Kohei Enju wrote:
> > > > > > On 09/22 10:01, Lorenzo Pieralisi wrote:
> > > > > > > On Tue, Sep 15, 2026 at 04:27:21PM -0500, Michael Roth wrote:
> > > > > > > > On Thu, Sep 03, 2026 at 01:35:50PM -0600, Mathieu Poirier wrote:
> > > > > > > > > From: Jean-Philippe Brucker <jean-philippe@linaro.org>
> > > > > > > > > 
> > > > > > > > > Add a new RmeGuest object, inheriting from ConfidentialGuestSupport, to
> > > > > > > > > support the Arm Realm Management Extension (RME). It is instantiated by
> > > > > > > > > passing on the command-line:
> > > > > > > > > 
> > > > > > > > >    -M virt,confidential-guest-support=<id>
> > > > > > > > >    -object rme-guest,id=<id>
> > > > > > > > > 
> > > > > > > > > This is only the skeleton. Support will be added in following patches.
> > > > > > > > > 
> > > > > > > > > Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
> > > > > > > > > Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
> > > > > > > > > ---
> > > > > > > > >   docs/system/confidential-guest-support.rst |  1 +
> > > > > > > > >   qapi/qom.json                              | 13 +++++++
> > > > > > > > >   target/arm/kvm-rme.c                       | 42 ++++++++++++++++++++++
> > > > > > > > >   target/arm/meson.build                     |  5 ++-
> > > > > > > > >   4 files changed, 60 insertions(+), 1 deletion(-)
> > > > > > > > >   create mode 100644 target/arm/kvm-rme.c
> > > > > > > > > 
> > > > > > > > > diff --git a/docs/system/confidential-guest-support.rst b/docs/system/confidential-guest-support.rst
> > > > > > > > > index 562a7c3c2852..abb56923ad13 100644
> > > > > > > > > --- a/docs/system/confidential-guest-support.rst
> > > > > > > > > +++ b/docs/system/confidential-guest-support.rst
> > > > > > > > > @@ -42,5 +42,6 @@ Currently supported confidential guest mechanisms are:
> > > > > > > > >   * POWER Protected Execution Facility (PEF) (see :ref:`power-papr-protected-execution-facility-pef`)
> > > > > > > > >   * s390x Protected Virtualization (PV) (see :doc:`s390x/protvirt`)
> > > > > > > > >   * AWS Nitro Enclaves (see :doc:`nitro`)
> > > > > > > > > +* Arm Realm Management Extension (RME)
> > > > > > > > >   Other mechanisms may be supported in future.
> > > > > > > > > diff --git a/qapi/qom.json b/qapi/qom.json
> > > > > > > > > index 776b13027fd8..52997c29a32d 100644
> > > > > > > > > --- a/qapi/qom.json
> > > > > > > > > +++ b/qapi/qom.json
> > > > > > > > > @@ -1288,6 +1288,17 @@
> > > > > > > > >     'data': { '*pretty': 'bool',
> > > > > > > > >               '*close-action': 'MonitorQMPCloseAction' } }
> > > > > > > > > +##
> > > > > > > > > +# @RmeGuestProperties:
> > > > > > > > > +#
> > > > > > > > > +# Properties for rme-guest objects.
> > > > > > > > > +#
> > > > > > > > > +# Since: 11.1
> > > > > > > > > +##
> > > > > > > > > +{ 'struct': 'RmeGuestProperties',
> > > > > > > > > +  'base': 'ConfidentialGuestSupportProperties',
> > > > > > > > 
> > > > > > > > Just FYI, based on input from Markus I'm planning to drop this
> > > > > > > > ConfidentialGuestSupportProperties base type from my series
> > > > > > > > since it's probably only SNP/TDX that need to be able to switch
> > > > > > > > it on/off, whereas this series appears to use/require it from
> > > > > > > > the start.
> > > > > > > > 
> > > > > > > > I'm not exactly sure what it will look like for v3 yet, but if you
> > > > > > > > were based on v2 you'd instead probably just do the following in the
> > > > > > > > instance_init function for your rme-guest instance:
> > > > > > > > 
> > > > > > > >    cgs->allow_convert_in_place = true;
> > > > > > > >    cgs->convert_in_place = true;
> > > > > > > > 
> > > > > > > > rather than exposing it as a cmdline option.
> > > > > > > 
> > > > > > > Yep, it won't be an option for CCA Realms anyway since that will be
> > > > > > > the baseline.
> > > > > > 
> > > > > > IIUC, in-place conversion requires RAM backed by a shared/mappable
> > > > > > guest_memfd. If in-place conversion is always enabled for CCA Realms,
> > > > > > could QEMU also select the equivalent of
> > > > > > 
> > > > > >    -object memory-backend-guest-memfd,id=ram0,size=...,share=on
> > > > > > 
> > > > > > automatically for the default RAM, so that specifying the RAM size with
> > > > > > `-m` is sufficient?
> > > > > 
> > > > > Are you suggesting that on Arm, we completely get rid of
> > > > > 
> > > > >      -object memory-backend-guest-memfd,id=ram0,size=$(RAMSIZE),share=on
> > > > > 
> > > > > or simply to get rid of "size=$(RAMSIZE)" in the above because it is redundant
> > > > > with "-m $(RAMSIZE)"?
> > > > > 
> > > > > Gavin and Michael, what is your take on that suggestion?
> > > > > 
> > > > 
> > > > I don't think that's what Kohei meant. He actually suggested the memory backend
> > > > shall be pinned to memory-backend-guest-memfd and its in-place conversion shall
> > > > be enabled when the memory backend isn't explicitly specified by users through
> > > > "-object memory-backend-xxxx". For this inexplicit case, where the memory backend
> > > > is determined by '-mem-path', the memory backend is either TYPE_MEMORY_BACKEND_FILE
> > > > or TYPE_MEMORY_BACKEND_RAM. Please refer to create_default_memdev().
> > > > 
> > > > I think Kohei's suggestion makes sense. Besides, I think '-mem-path' should be
> > > > disallowed for CCA Realms as TYPE_MEMORY_BACKEND_FILE isn't what we want.
> > > 
> > > Kohei, what were you suggesting then please ? I think TYPE_MEMORY_BACKEND_FILE
> > > would not pass the checks required by Michael's v3 [0] on CCA - I will test this
> > > and report back but the only backend allowed, rightly, is memfd,share=on, so it
> > > _is_ disallowed.
> > 
> > Sorry for the late response.
> > 
> > To clarify, I meant the latter: when rme-guest is selected and the user
> > has not explicitly provided a memory backend, QEMU could automatically
> > create the default RAM as a shared guest-memfd backend.
> > 
> > In other words, rather than only rejecting the default file/RAM backend,
> > the Realm configuration could select the equivalent of
> > 
> >   -object memory-backend-guest-memfd,id=<default-ram-id>,size=<RAMSIZE>,share=on
> > 
> > by default. Explicitly specified memory backends would still need to be
> > validated against the Realm requirements.
> > 
> > My intention was that, if in-place conversion is the baseline for CCA
> > Realms, `-m <size>` should be sufficient for the common Realm case,
> > while preserving an explicit memory-backend option for users who need to
> > control it.
> 
> Many thanks for the clarification, it is very helpful.  I will look into
> implementing something along those lines for V6 and we can reconsider how to
> move forward at that time.  

And then I read Michael's comment again, and again and again...

> 
> Thanks,
> Mathieu
> 
> > 
> > That said, I do not have a strong preference for deciding the default
> > `-m` behavior at this stage. If it is premature to make that decision
> > before the memory-backend and conversion interfaces have settled, I am
> > happy to keep the explicit guest-memfd backend requirement for now and
> > revisit the default behavior later.
> > 

For the time being I will hold back on moving forward with this request.  Let's
revisit at some point in the future.

> > Thanks,
> > Kohei
> > 
> > > 
> > > Lorenzo
> > > 
> > > [0] https://lore.kernel.org/kvm/20261007134323.1606088-1-michael.roth@amd.com/
> > > 
> > > > Thanks,
> > > > Gavin
> > > > 
> > > > > Thanks,
> > > > > Mathieu
> > > > > 
> > > > > > 
> > > > > > Thanks,
> > > > > > Kohei
> > > > > > 
> > > > > > > 
> > > > > > > Thanks,
> > > > > > > Lorenzo
> > > > > > > 
> > > > > > > > Thanks,
> > > > > > > > 
> > > > > > > > Mike
> > > > > > > > 
> > > > > > > > > +  'data': {} }
> > > > > > > > > +
> > > > > > > > >   ##
> > > > > > > > >   # @ObjectType:
> > > > > > > > >   #
> > > > > > > > > @@ -1346,6 +1357,7 @@
> > > > > > > > >       { 'name': 'pr-manager-helper',
> > > > > > > > >         'if': 'CONFIG_LINUX' },
> > > > > > > > >       'qtest',
> > > > > > > > > +    'rme-guest',
> > > > > > > > >       'rng-builtin',
> > > > > > > > >       'rng-egd',
> > > > > > > > >       { 'name': 'rng-random',
> > > > > > > > > @@ -1427,6 +1439,7 @@
> > > > > > > > >         'pr-manager-helper':          { 'type': 'PrManagerHelperProperties',
> > > > > > > > >                                         'if': 'CONFIG_LINUX' },
> > > > > > > > >         'qtest':                      'QtestProperties',
> > > > > > > > > +      'rme-guest':                  'RmeGuestProperties',
> > > > > > > > >         'rng-builtin':                'RngProperties',
> > > > > > > > >         'rng-egd':                    'RngEgdProperties',
> > > > > > > > >         'rng-random':                 { 'type': 'RngRandomProperties',
> > > > > > > > > diff --git a/target/arm/kvm-rme.c b/target/arm/kvm-rme.c
> > > > > > > > > new file mode 100644
> > > > > > > > > index 000000000000..42e1d1e7b859
> > > > > > > > > --- /dev/null
> > > > > > > > > +++ b/target/arm/kvm-rme.c
> > > > > > > > > @@ -0,0 +1,42 @@
> > > > > > > > > +/*
> > > > > > > > > + * QEMU Arm RME support
> > > > > > > > > + *
> > > > > > > > > + * SPDX-License-Identifier: GPL-2.0-or-later
> > > > > > > > > + *
> > > > > > > > > + * Copyright Linaro 2026
> > > > > > > > > + */
> > > > > > > > > +
> > > > > > > > > +#include "qemu/osdep.h"
> > > > > > > > > +
> > > > > > > > > +#include "hw/core/boards.h"
> > > > > > > > > +#include "hw/core/cpu.h"
> > > > > > > > > +#include "kvm_arm.h"
> > > > > > > > > +#include "migration/blocker.h"
> > > > > > > > > +#include "qapi/error.h"
> > > > > > > > > +#include "qom/object_interfaces.h"
> > > > > > > > > +#include "system/confidential-guest-support.h"
> > > > > > > > > +#include "system/kvm.h"
> > > > > > > > > +#include "system/runstate.h"
> > > > > > > > > +
> > > > > > > > > +#define TYPE_RME_GUEST "rme-guest"
> > > > > > > > > +OBJECT_DECLARE_SIMPLE_TYPE(RmeGuest, RME_GUEST)
> > > > > > > > > +
> > > > > > > > > +struct RmeGuest {
> > > > > > > > > +    ConfidentialGuestSupport parent_obj;
> > > > > > > > > +};
> > > > > > > > > +
> > > > > > > > > +OBJECT_DEFINE_SIMPLE_TYPE_WITH_INTERFACES(RmeGuest, rme_guest, RME_GUEST,
> > > > > > > > > +                                          CONFIDENTIAL_GUEST_SUPPORT,
> > > > > > > > > +                                          { TYPE_USER_CREATABLE }, { })
> > > > > > > > > +
> > > > > > > > > +static void rme_guest_class_init(ObjectClass *oc, const void *data)
> > > > > > > > > +{
> > > > > > > > > +}
> > > > > > > > > +
> > > > > > > > > +static void rme_guest_init(Object *obj)
> > > > > > > > > +{
> > > > > > > > > +}
> > > > > > > > > +
> > > > > > > > > +static void rme_guest_finalize(Object *obj)
> > > > > > > > > +{
> > > > > > > > > +}
> > > > > > > > > diff --git a/target/arm/meson.build b/target/arm/meson.build
> > > > > > > > > index 0369f96b4cc6..9d322a7aad28 100644
> > > > > > > > > --- a/target/arm/meson.build
> > > > > > > > > +++ b/target/arm/meson.build
> > > > > > > > > @@ -31,7 +31,10 @@ arm_common_user_system_ss.add(when: 'TARGET_AARCH64', if_true: files(
> > > > > > > > >   arm_common_system_ss.add(files(
> > > > > > > > >     'arm-qmp-cmds.c',
> > > > > > > > >   ))
> > > > > > > > > -arm_system_ss.add(when: 'CONFIG_KVM', if_true: files('hyp_gdbstub.c', 'kvm.c'))
> > > > > > > > > +arm_system_ss.add(when: 'CONFIG_KVM', if_true: files(
> > > > > > > > > +  'hyp_gdbstub.c',
> > > > > > > > > +  'kvm.c',
> > > > > > > > > +  'kvm-rme.c'))
> > > > > > > > >   arm_system_ss.add(when: 'CONFIG_HVF', if_true: files('hyp_gdbstub.c'))
> > > > > > > > >   arm_user_ss.add(files('cpu.c'))
> > > > > > > > > -- 
> > > > > > > > > 2.43.0
> > > > > > > > > 
> > > > > > > > > 
> > > > > 
> > > > 
