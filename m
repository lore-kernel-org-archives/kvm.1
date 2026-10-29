Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.175
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793308478;
	b=aI8zHeWpuo+KhMDoks6fPQsdlcn5bg0HxqGRkGzII8BR/hJ0rKOSL9z/Pj8L7H3L0DoM
	 2gZ96wbJTCJ1ppVgL4LcPgVBzruYFHClyyTemCXpa9gKsXooDmjgXx8/EbjkU45zN2Xvl
	 qr6OOx9U66gMivo+uRUohMMfAuDHE6qcnKpSE9q4xPs4bCpLK+eQWVxtl3nHMwxFVkYFO
	 aL7LZaeIZakDgQYjcPCXRJ7fxaCqxk/D4S8WZvzri8yrvik4tYZXEyuHTmc6gec2S5WBB
	 xDSiafPU1Q8WoTp1M8xKcMEpxAnOb/Yp2g/Fpc6nOTyCrEM6BPeIjQ8lxshpuRTjG/Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793308478;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=/C2hxVyYb+Xpn5/5k51lLA2L8eIYoVycs+0Rffv6qHI=;
	b=ASLVm4he2/reqb4uAdHn6eeXSfGx3HqdywaqxL860tOerqaJx58OGgZOL/JIxYbQVsuY
	 IlBBGm0uwjCekMJzk7u+AwlVC6Bc+miTtQWbdZI/UCWnnsb2D3nlAd3QinCbcThl4yYin
	 TlcyyGVSy/M73FS88t9wQ0AoyHu7DelLducRDy/yz7RwccC6eoPJ21A08JjovKjurTBWj
	 tGwNuz3Qyb9BGxiO6GY10g1Djv7iJ4ZpaQb8Vaoki9FjnsnImugmETtQICYk8eLipWKyI
	 vFu4VOYvsdZpK7P2jw1x7RoXf8Ec0VECGwPZbZqe8RAk0xRpLVbYRlhyqqbkq/SHlXA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linaro.org;
	spf=pass smtp.mailfrom=linaro.org;
	dkim=pass header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=IBC7UWuE;
	arc=none smtp.remote-ip=209.85.210.175
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C461F606A31C
	for <kvm@vger.kernel.org>; Thu, 29 Oct 2026 21:14:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C461F606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=IBC7UWuE
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-8a07078200fso1390105b3a.2
        for <kvm@vger.kernel.org>; Thu, 29 Oct 2026 14:14:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1793308477; x=1793913277; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=/C2hxVyYb+Xpn5/5k51lLA2L8eIYoVycs+0Rffv6qHI=;
        b=IBC7UWuE6Lvhln0AtB/ylGoPl0dl/+6mraTKZECoE6p072xNks+MsdIX6mc6WcT4jC
         eHfmpRB5LHNJrr+r1uVZfi/7pDtH/AX1UzoPuaL9DHkq0vR4h+hRApQojnWSGG6WZkU0
         rqx6FlY3ZVOVKaMujbmN3oieBLi+ZCrPUb1GdXdM4WuH+60NAS/IKyz7HyQSrkO6dzhU
         DyZ9xS2Dt0P9ijm5NnBvLDd/NVHVIeLiVcNGCuZkKZJcKU7MZ9B3sbsikaoQdqJKt4Lc
         PdJd1Ho4/jrcSMRw1VGpU6HNHP2oLQqlt6GXYursXTpHuGHSYd0tNS1Q6eonGjm+ortf
         xBDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793308477; x=1793913277;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=/C2hxVyYb+Xpn5/5k51lLA2L8eIYoVycs+0Rffv6qHI=;
        b=elTezeYLhP3tMlWFUKwCFWtwYLfvZNhTOLD6LJ/RXKoFnfVEEzC2msdf323WR5glZV
         JaIxF7F4OyYcQqDGeuH/MWxt8MdsV/HTmqD4VIJNFZOt7Gv6vzl4r6pLoQggzIF7GXnW
         OCbtnXSWsW0sT2OESctNT4eboq2BJ8Pj/vPz1LBKterzj9JpHNdoY1HSXCuSToJ/4Gir
         hF9skaML1+2JiifyDBwtGgbdpy2lcp3u2s+w1fFZjWneoFrHQr9Dvct+3RyCL8InsYp0
         Bp7Mqlscvyvd3RbOoxymSIRRzLpjiMwO5rmKCaSrSO00LjfMNDtWdaQVfo+eQwXPW4is
         B99A==
X-Forwarded-Encrypted: i=1; AKwUvBzkdhNnoBO2jX9EQfrZ7Ol9VpcPu+1oiHkIJ9rjxCAwVNSdlWRcusGv74opcYyVBsJIQV8=@vger.kernel.org
X-Gm-Message-State: AFq9FYJbn7gwWK5v5iWrCTlMFhoftKIw9pLtbniTrykcug4ZStwX0ZiE
	2AZLvr6jMrby6lOZayGJ1nK4PKj2hs/B9X1upN1owIyh1D4Ir3ffMHsg9Wny3iO6WgxivD8bfN4
	ge8o2
X-Gm-Gg: AYBFou0dVvByCOb01GMofDCc9L7tZNkWdD7TZt5JC+zUr1DMgXSzheWg995DF04Hork
	ZLyu3BJCN7SdFl5zgT3dD0IrUy7SVRx6Uo8lO6zxI8/2854hOh68+B170dMz1bK9dvq2J4ZGdto
	bmUiAnqR/qYXLTvOriGtGtWqUweVN7hrM9OhxvqiXUebYLlK2uPPkhHQWf6G4G41d5XXOGDA8WR
	W6K7UEdtDE2t8M7VKfeX8uldLbdyiQ1SuY2Zr0lpzkm05iEE6CpjEfXqRdER128aJW8nY6KWNLm
	1AVr3F6zQCJF9S/zVEecVE9exsvl2WPQt/UGdD1/9t5rKs0YuymUoPujPUT5WomIBz+kSe13JL5
	tnL+tt1aq02W7RUiqDhafQc40Nv0b7Lz0Xeo77O8m2Qr/NeDiP3FT9hEIeo7x7JNSuYXB6+wqWF
	9bAqQ6YJqJBxeY+Bfldj3smH49d+vTpSfrArkbjYJ47UyNotjXiGf/9d36EGxFd1adV4YiUzUjF
	fj9MKBHABQ2K71+urzeUluEj0E8odWQKuxc9pHzYWec3BChWtk1DwzjwB4NEeGlwr2qx0khcthj
	NrH5jOWXPiSpSZuYaJhH+DAOS4DhEqMG
X-Received: by 2002:a05:6a00:10d1:b0:874:32d1:d3d8 with SMTP id d2e1a72fcca58-8a9bea671d0mr253355b3a.21.1793308476502;
        Thu, 29 Oct 2026 14:14:36 -0700 (PDT)
Received: from p14s ([2604:3d09:148c:c800:97b0:7603:db48:102e])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8a98901aec6sm284640b3a.26.2026.10.29.14.14.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Oct 2026 14:14:35 -0700 (PDT)
Date: Thu, 29 Oct 2026 15:14:32 -0600
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
Message-ID: <auO3OKQGWiqtTcWU@p14s>
References: <20260903193611.1058589-1-mathieu.poirier@linaro.org>
 <20260903193611.1058589-4-mathieu.poirier@linaro.org>
 <dhrvydsmaw22xqx5d5i5s7fdyjxupz27yxp6trv2tesysp4npj@quvzrxjvfipz>
 <arI197vJkW75p50c@lpieralisi>
 <arSTQQ5uB6oR-vFe@FCCLS0092175.localdomain>
 <ataBkrIvULJXj4v6@p14s>
 <784dfea3-24cb-4e70-ab46-b96b4b9a1831@redhat.com>
 <at-Wkw7a3Tn3Oh3M@red-moon>
 <auF8rstVcvsDUO6C@FCCLS0092175.localdomain>
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
In-Reply-To: <auF8rstVcvsDUO6C@FCCLS0092175.localdomain>

On Wed, Oct 28, 2026 at 01:51:29PM +0900, Kohei Enju wrote:
> On 10/26 19:06, Lorenzo Pieralisi wrote:
> > On Wed, Oct 21, 2026 at 11:42:14PM +1000, Gavin Shan wrote:
> > > On 10/20/26 6:46 AM, Mathieu Poirier wrote:
> > > > On Thu, Sep 24, 2026 at 12:12:35PM +0900, Kohei Enju wrote:
> > > > > On 09/22 10:01, Lorenzo Pieralisi wrote:
> > > > > > On Tue, Sep 15, 2026 at 04:27:21PM -0500, Michael Roth wrote:
> > > > > > > On Thu, Sep 03, 2026 at 01:35:50PM -0600, Mathieu Poirier wrote:
> > > > > > > > From: Jean-Philippe Brucker <jean-philippe@linaro.org>
> > > > > > > > 
> > > > > > > > Add a new RmeGuest object, inheriting from ConfidentialGuestSupport, to
> > > > > > > > support the Arm Realm Management Extension (RME). It is instantiated by
> > > > > > > > passing on the command-line:
> > > > > > > > 
> > > > > > > >    -M virt,confidential-guest-support=<id>
> > > > > > > >    -object rme-guest,id=<id>
> > > > > > > > 
> > > > > > > > This is only the skeleton. Support will be added in following patches.
> > > > > > > > 
> > > > > > > > Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
> > > > > > > > Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
> > > > > > > > ---
> > > > > > > >   docs/system/confidential-guest-support.rst |  1 +
> > > > > > > >   qapi/qom.json                              | 13 +++++++
> > > > > > > >   target/arm/kvm-rme.c                       | 42 ++++++++++++++++++++++
> > > > > > > >   target/arm/meson.build                     |  5 ++-
> > > > > > > >   4 files changed, 60 insertions(+), 1 deletion(-)
> > > > > > > >   create mode 100644 target/arm/kvm-rme.c
> > > > > > > > 
> > > > > > > > diff --git a/docs/system/confidential-guest-support.rst b/docs/system/confidential-guest-support.rst
> > > > > > > > index 562a7c3c2852..abb56923ad13 100644
> > > > > > > > --- a/docs/system/confidential-guest-support.rst
> > > > > > > > +++ b/docs/system/confidential-guest-support.rst
> > > > > > > > @@ -42,5 +42,6 @@ Currently supported confidential guest mechanisms are:
> > > > > > > >   * POWER Protected Execution Facility (PEF) (see :ref:`power-papr-protected-execution-facility-pef`)
> > > > > > > >   * s390x Protected Virtualization (PV) (see :doc:`s390x/protvirt`)
> > > > > > > >   * AWS Nitro Enclaves (see :doc:`nitro`)
> > > > > > > > +* Arm Realm Management Extension (RME)
> > > > > > > >   Other mechanisms may be supported in future.
> > > > > > > > diff --git a/qapi/qom.json b/qapi/qom.json
> > > > > > > > index 776b13027fd8..52997c29a32d 100644
> > > > > > > > --- a/qapi/qom.json
> > > > > > > > +++ b/qapi/qom.json
> > > > > > > > @@ -1288,6 +1288,17 @@
> > > > > > > >     'data': { '*pretty': 'bool',
> > > > > > > >               '*close-action': 'MonitorQMPCloseAction' } }
> > > > > > > > +##
> > > > > > > > +# @RmeGuestProperties:
> > > > > > > > +#
> > > > > > > > +# Properties for rme-guest objects.
> > > > > > > > +#
> > > > > > > > +# Since: 11.1
> > > > > > > > +##
> > > > > > > > +{ 'struct': 'RmeGuestProperties',
> > > > > > > > +  'base': 'ConfidentialGuestSupportProperties',
> > > > > > > 
> > > > > > > Just FYI, based on input from Markus I'm planning to drop this
> > > > > > > ConfidentialGuestSupportProperties base type from my series
> > > > > > > since it's probably only SNP/TDX that need to be able to switch
> > > > > > > it on/off, whereas this series appears to use/require it from
> > > > > > > the start.
> > > > > > > 
> > > > > > > I'm not exactly sure what it will look like for v3 yet, but if you
> > > > > > > were based on v2 you'd instead probably just do the following in the
> > > > > > > instance_init function for your rme-guest instance:
> > > > > > > 
> > > > > > >    cgs->allow_convert_in_place = true;
> > > > > > >    cgs->convert_in_place = true;
> > > > > > > 
> > > > > > > rather than exposing it as a cmdline option.
> > > > > > 
> > > > > > Yep, it won't be an option for CCA Realms anyway since that will be
> > > > > > the baseline.
> > > > > 
> > > > > IIUC, in-place conversion requires RAM backed by a shared/mappable
> > > > > guest_memfd. If in-place conversion is always enabled for CCA Realms,
> > > > > could QEMU also select the equivalent of
> > > > > 
> > > > >    -object memory-backend-guest-memfd,id=ram0,size=...,share=on
> > > > > 
> > > > > automatically for the default RAM, so that specifying the RAM size with
> > > > > `-m` is sufficient?
> > > > 
> > > > Are you suggesting that on Arm, we completely get rid of
> > > > 
> > > >      -object memory-backend-guest-memfd,id=ram0,size=$(RAMSIZE),share=on
> > > > 
> > > > or simply to get rid of "size=$(RAMSIZE)" in the above because it is redundant
> > > > with "-m $(RAMSIZE)"?
> > > > 
> > > > Gavin and Michael, what is your take on that suggestion?
> > > > 
> > > 
> > > I don't think that's what Kohei meant. He actually suggested the memory backend
> > > shall be pinned to memory-backend-guest-memfd and its in-place conversion shall
> > > be enabled when the memory backend isn't explicitly specified by users through
> > > "-object memory-backend-xxxx". For this inexplicit case, where the memory backend
> > > is determined by '-mem-path', the memory backend is either TYPE_MEMORY_BACKEND_FILE
> > > or TYPE_MEMORY_BACKEND_RAM. Please refer to create_default_memdev().
> > > 
> > > I think Kohei's suggestion makes sense. Besides, I think '-mem-path' should be
> > > disallowed for CCA Realms as TYPE_MEMORY_BACKEND_FILE isn't what we want.
> > 
> > Kohei, what were you suggesting then please ? I think TYPE_MEMORY_BACKEND_FILE
> > would not pass the checks required by Michael's v3 [0] on CCA - I will test this
> > and report back but the only backend allowed, rightly, is memfd,share=on, so it
> > _is_ disallowed.
> 
> Sorry for the late response.
> 
> To clarify, I meant the latter: when rme-guest is selected and the user
> has not explicitly provided a memory backend, QEMU could automatically
> create the default RAM as a shared guest-memfd backend.
> 
> In other words, rather than only rejecting the default file/RAM backend,
> the Realm configuration could select the equivalent of
> 
>   -object memory-backend-guest-memfd,id=<default-ram-id>,size=<RAMSIZE>,share=on
> 
> by default. Explicitly specified memory backends would still need to be
> validated against the Realm requirements.
> 
> My intention was that, if in-place conversion is the baseline for CCA
> Realms, `-m <size>` should be sufficient for the common Realm case,
> while preserving an explicit memory-backend option for users who need to
> control it.

Many thanks for the clarification, it is very helpful.  I will look into
implementing something along those lines for V6 and we can reconsider how to
move forward at that time.  

Thanks,
Mathieu

> 
> That said, I do not have a strong preference for deciding the default
> `-m` behavior at this stage. If it is premature to make that decision
> before the memory-backend and conversion interfaces have settled, I am
> happy to keep the explicit guest-memfd backend requirement for now and
> revisit the default behavior later.
> 
> Thanks,
> Kohei
> 
> > 
> > Lorenzo
> > 
> > [0] https://lore.kernel.org/kvm/20261007134323.1606088-1-michael.roth@amd.com/
> > 
> > > Thanks,
> > > Gavin
> > > 
> > > > Thanks,
> > > > Mathieu
> > > > 
> > > > > 
> > > > > Thanks,
> > > > > Kohei
> > > > > 
> > > > > > 
> > > > > > Thanks,
> > > > > > Lorenzo
> > > > > > 
> > > > > > > Thanks,
> > > > > > > 
> > > > > > > Mike
> > > > > > > 
> > > > > > > > +  'data': {} }
> > > > > > > > +
> > > > > > > >   ##
> > > > > > > >   # @ObjectType:
> > > > > > > >   #
> > > > > > > > @@ -1346,6 +1357,7 @@
> > > > > > > >       { 'name': 'pr-manager-helper',
> > > > > > > >         'if': 'CONFIG_LINUX' },
> > > > > > > >       'qtest',
> > > > > > > > +    'rme-guest',
> > > > > > > >       'rng-builtin',
> > > > > > > >       'rng-egd',
> > > > > > > >       { 'name': 'rng-random',
> > > > > > > > @@ -1427,6 +1439,7 @@
> > > > > > > >         'pr-manager-helper':          { 'type': 'PrManagerHelperProperties',
> > > > > > > >                                         'if': 'CONFIG_LINUX' },
> > > > > > > >         'qtest':                      'QtestProperties',
> > > > > > > > +      'rme-guest':                  'RmeGuestProperties',
> > > > > > > >         'rng-builtin':                'RngProperties',
> > > > > > > >         'rng-egd':                    'RngEgdProperties',
> > > > > > > >         'rng-random':                 { 'type': 'RngRandomProperties',
> > > > > > > > diff --git a/target/arm/kvm-rme.c b/target/arm/kvm-rme.c
> > > > > > > > new file mode 100644
> > > > > > > > index 000000000000..42e1d1e7b859
> > > > > > > > --- /dev/null
> > > > > > > > +++ b/target/arm/kvm-rme.c
> > > > > > > > @@ -0,0 +1,42 @@
> > > > > > > > +/*
> > > > > > > > + * QEMU Arm RME support
> > > > > > > > + *
> > > > > > > > + * SPDX-License-Identifier: GPL-2.0-or-later
> > > > > > > > + *
> > > > > > > > + * Copyright Linaro 2026
> > > > > > > > + */
> > > > > > > > +
> > > > > > > > +#include "qemu/osdep.h"
> > > > > > > > +
> > > > > > > > +#include "hw/core/boards.h"
> > > > > > > > +#include "hw/core/cpu.h"
> > > > > > > > +#include "kvm_arm.h"
> > > > > > > > +#include "migration/blocker.h"
> > > > > > > > +#include "qapi/error.h"
> > > > > > > > +#include "qom/object_interfaces.h"
> > > > > > > > +#include "system/confidential-guest-support.h"
> > > > > > > > +#include "system/kvm.h"
> > > > > > > > +#include "system/runstate.h"
> > > > > > > > +
> > > > > > > > +#define TYPE_RME_GUEST "rme-guest"
> > > > > > > > +OBJECT_DECLARE_SIMPLE_TYPE(RmeGuest, RME_GUEST)
> > > > > > > > +
> > > > > > > > +struct RmeGuest {
> > > > > > > > +    ConfidentialGuestSupport parent_obj;
> > > > > > > > +};
> > > > > > > > +
> > > > > > > > +OBJECT_DEFINE_SIMPLE_TYPE_WITH_INTERFACES(RmeGuest, rme_guest, RME_GUEST,
> > > > > > > > +                                          CONFIDENTIAL_GUEST_SUPPORT,
> > > > > > > > +                                          { TYPE_USER_CREATABLE }, { })
> > > > > > > > +
> > > > > > > > +static void rme_guest_class_init(ObjectClass *oc, const void *data)
> > > > > > > > +{
> > > > > > > > +}
> > > > > > > > +
> > > > > > > > +static void rme_guest_init(Object *obj)
> > > > > > > > +{
> > > > > > > > +}
> > > > > > > > +
> > > > > > > > +static void rme_guest_finalize(Object *obj)
> > > > > > > > +{
> > > > > > > > +}
> > > > > > > > diff --git a/target/arm/meson.build b/target/arm/meson.build
> > > > > > > > index 0369f96b4cc6..9d322a7aad28 100644
> > > > > > > > --- a/target/arm/meson.build
> > > > > > > > +++ b/target/arm/meson.build
> > > > > > > > @@ -31,7 +31,10 @@ arm_common_user_system_ss.add(when: 'TARGET_AARCH64', if_true: files(
> > > > > > > >   arm_common_system_ss.add(files(
> > > > > > > >     'arm-qmp-cmds.c',
> > > > > > > >   ))
> > > > > > > > -arm_system_ss.add(when: 'CONFIG_KVM', if_true: files('hyp_gdbstub.c', 'kvm.c'))
> > > > > > > > +arm_system_ss.add(when: 'CONFIG_KVM', if_true: files(
> > > > > > > > +  'hyp_gdbstub.c',
> > > > > > > > +  'kvm.c',
> > > > > > > > +  'kvm-rme.c'))
> > > > > > > >   arm_system_ss.add(when: 'CONFIG_HVF', if_true: files('hyp_gdbstub.c'))
> > > > > > > >   arm_user_ss.add(files('cpu.c'))
> > > > > > > > -- 
> > > > > > > > 2.43.0
> > > > > > > > 
> > > > > > > > 
> > > > 
> > > 
