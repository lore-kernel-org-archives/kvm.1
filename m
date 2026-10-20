Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.46
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792517257;
	b=JEJlfW0Ga8McZZlqzmZpQW67TosqSweIqCUZ2E0UqQqoR9KYBPQRo+w92rTPK4uV+hRv
	 MUTMozwqnmohccLXgxNlT/hlYxhDcJV3tq8wW++Iiy+boIRndVXbGzzhexfDTCKV0zjyO
	 vpb4MYxvZG5D7bYUQ5tsI5ZY8SLdWnOnJ7V2bKrcslIAk4xfIt9aaMXnzmuFUs5iQv7Yu
	 xaApbd+bJfAPN8kjAOhnqr17aKfpg63Pr3mrteFO6deAH+n+w3tpNw3P9rGETma4iyARn
	 NAW41Nk9yeFEFQ5hp85EbgJkycfNjBep9tgr2BIzKEHPGqmqWsjHoV9QrgcUCb+Ul+A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792517257;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=TIuVvUMuRAYl/dxcnqP8vb2VgWML544JX9D0im23wI4=;
	b=nyeJdiDluW9NBqqB4+AnPRSlKv6mEF06Nm/YhvEQjzLvajjd5sp8P/5c2H+GEL25cTys
	 CVIREsNEPXZaSBkkk/mLKp4dC2EWntiDDBid8SyU7oHIDfrDuGND9htafi6rjpzqwJBow
	 YLYUHxZHJRPj730Cddthj2aFDp72QsXQoow8eXc499qBqId4Zo4XpQhLfrZZiDIriGN3O
	 SIIvHHCMQ4goO9XwKaYzokuhMaeUIYSzTqyOq977QChbkqx/0uV0Y47bpvDYU+6H3Qzn5
	 vyJsIYlKeRIkjathBiPSxfAAHCGWTEBEoLwPQ/fzgO6Ggote26z6fy4/5+u1GKUF7Lg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linaro.org;
	spf=pass smtp.mailfrom=linaro.org;
	dkim=pass header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=fkZApnKi;
	arc=none smtp.remote-ip=209.85.216.46
Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07EB0606A327
	for <kvm@vger.kernel.org>; Tue, 20 Oct 2026 17:27:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 07EB0606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=fkZApnKi
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-3acc96a256dso2271459a91.3
        for <kvm@vger.kernel.org>; Tue, 20 Oct 2026 10:27:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1792517256; x=1793122056; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=TIuVvUMuRAYl/dxcnqP8vb2VgWML544JX9D0im23wI4=;
        b=fkZApnKi2bKmmOXkY4E6jzVoSuuvbpOiGnvA2lc9LWsGT2V31mRGKSIJzT9cikI4V4
         310k1YlXSBxqa7FnS7F96Rkm0OZ6E3Um21dsvgtw4Szq4ZU1NUCSB4Iy7fq424SclGAq
         38scFxh/zrxfJj3EHE7fXaBZ7/P4617wyTvD7v63KvPYiTzN5I2FK5/l60kg2PXBtsPz
         nXLOnc+fhH0Vlm4EnjFM+fElC4WKE4HaWzJ5wVSbGR16CfoNJYFs06YBqutX8KEM1uYK
         ZbMl8INgh3IYRDIzHRZ9wj5Hkcl3ONJ+Dk9LpgAjdNMGnWa7v2sy0Rr5a5D6un5zVeKe
         ANvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792517256; x=1793122056;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=TIuVvUMuRAYl/dxcnqP8vb2VgWML544JX9D0im23wI4=;
        b=hR0UOGstu9LRWYH45aKB6H//bu4wsBtenfiVZvFA7xKyIUHcn7hmcB0gwwqzX+UO86
         RP+Acrcvfu8GXxzYBnrXnEf2atCjL4fPgrYjvTT9gqzqpDSg0Lw0uNZBVIMdnElilBMp
         gUyOIE2ZH6O6bEaqZ8GyrWdKTfIdOLN6avpfwsvdlvuT5THQw8ByMf2qt+j6kw5PHvw8
         EoNL5/uLbYQ95nKnwKUGZybK843HaL/rJq+Wwrm78rEy4YrvhxLva8xJZamuqQ5i7232
         WHgQouwp0kJtCf1Zk800hSUjkX+63Zf7sPtk9N7XgwIWpS5PVOlG9z1xKTMXXEsuTjhT
         QLtA==
X-Forwarded-Encrypted: i=1; AKwUvByAjpPVz9llKAzSu4WZfXP7Boy8iX8B3G2NlAm/b7btf7wfkdH+sDJtqo6K17tu7O2QNl4=@vger.kernel.org
X-Gm-Message-State: AFq9FYLpCmsdGJiQSFa2RkoaBw9hOYXrYHD00XfbRUmO3+GcES66f2eE
	OPJ8+NqoIVRASUlp0GXToI+ktOgNQ8q0S6KGB006wygjRu0JX6sYTqNHwynfvO6oQRU=
X-Gm-Gg: AYBFou1gMX8hA+PBqD4E4j4nQ4ge52DZ718aXIhMWy1yDxSuhCrRnJOTdFpHVzP7rC/
	f0veEAh5L4xV5mKJTA90ergEGcqyTnMedTuSX+GJgXWBTcy1YUQ0utDqrPjaXXigvOvCB89zFwb
	K3ebCo4FBJuC+U2jPAWO9BRDbDOrLpwrtH//A37YIuAMNJoD8edGcFAPtfSmVCqTIytwh8PNyRY
	zcoyeH2f86rNep7MoejkkDE+1oO8WkNz7f3j48k7+TzXJVzAB/6LWZjrnR21BxoZo1eXcpac45t
	Sac1tyJbauvoxrQvLH7G3nX1RR7lLXJapktuoKIGI/dylgxB3jOEECa67jXGsDSxYJGfwWAmqfM
	fQvfryOdU27YqCW4X2rUuhmgEXF8fUWd4ISKxpoiSa5qHP3Zrzr2hNBizrPnsHc8Rbxy4zhLTR2
	svWrfaQKYlByDDN1+PZ639gWgY8g3lMxFoVRJfS4WZ8RgR63qP8BIg7AYZ5GcuGER2efqIj6g4v
	g==
X-Received: by 2002:a17:90b:3b86:b0:3ab:2737:3396 with SMTP id 98e67ed59e1d1-3acef5f1d2dmr10291676a91.65.1792517256200;
        Tue, 20 Oct 2026 10:27:36 -0700 (PDT)
Received: from p14s ([2604:3d09:148c:c800:1567:1f94:7104:b613])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ad80303567sm467989a91.14.2026.10.20.10.27.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Oct 2026 10:27:35 -0700 (PDT)
Date: Tue, 20 Oct 2026 11:27:33 -0600
From: Mathieu Poirier <mathieu.poirier@linaro.org>
To: Lorenzo Pieralisi <lpieralisi@kernel.org>
Cc: Kohei Enju <enju.kohei@fujitsu.com>, gshan@redhat.com,
	michael.roth@amd.com, berrange@redhat.com, kchamart@redhat.com,
	pierrick.bouvier@oss.qualcomm.com, peter.maydell@linaro.org,
	mst@redhat.com, cohuck@redhat.com, pbonzini@redhat.com,
	eblake@redhat.com, armbru@redhat.com, lorenzo.pieralisi@linaro.org,
	qemu-devel@nongnu.org, qemu-arm@nongnu.org, kvm@vger.kernel.org
Subject: Re: [RFC v4 03/24] target/arm: Add confidential guest support
Message-ID: <atekhR1Wz03nUCHB@p14s>
References: <20260903193611.1058589-1-mathieu.poirier@linaro.org>
 <20260903193611.1058589-4-mathieu.poirier@linaro.org>
 <dhrvydsmaw22xqx5d5i5s7fdyjxupz27yxp6trv2tesysp4npj@quvzrxjvfipz>
 <arI197vJkW75p50c@lpieralisi>
 <arSTQQ5uB6oR-vFe@FCCLS0092175.localdomain>
 <ataBkrIvULJXj4v6@p14s>
 <atdKSwvu_uldqwlz@red-moon>
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
In-Reply-To: <atdKSwvu_uldqwlz@red-moon>

On Tue, Oct 20, 2026 at 01:02:35PM +0200, Lorenzo Pieralisi wrote:
> On Mon, Oct 19, 2026 at 02:46:10PM -0600, Mathieu Poirier wrote:
> > On Thu, Sep 24, 2026 at 12:12:35PM +0900, Kohei Enju wrote:
> > > On 09/22 10:01, Lorenzo Pieralisi wrote:
> > > > On Tue, Sep 15, 2026 at 04:27:21PM -0500, Michael Roth wrote:
> > > > > On Thu, Sep 03, 2026 at 01:35:50PM -0600, Mathieu Poirier wrote:
> > > > > > From: Jean-Philippe Brucker <jean-philippe@linaro.org>
> > > > > > 
> > > > > > Add a new RmeGuest object, inheriting from ConfidentialGuestSupport, to
> > > > > > support the Arm Realm Management Extension (RME). It is instantiated by
> > > > > > passing on the command-line:
> > > > > > 
> > > > > >   -M virt,confidential-guest-support=<id>
> > > > > >   -object rme-guest,id=<id>
> > > > > > 
> > > > > > This is only the skeleton. Support will be added in following patches.
> > > > > > 
> > > > > > Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
> > > > > > Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
> > > > > > ---
> > > > > >  docs/system/confidential-guest-support.rst |  1 +
> > > > > >  qapi/qom.json                              | 13 +++++++
> > > > > >  target/arm/kvm-rme.c                       | 42 ++++++++++++++++++++++
> > > > > >  target/arm/meson.build                     |  5 ++-
> > > > > >  4 files changed, 60 insertions(+), 1 deletion(-)
> > > > > >  create mode 100644 target/arm/kvm-rme.c
> > > > > > 
> > > > > > diff --git a/docs/system/confidential-guest-support.rst b/docs/system/confidential-guest-support.rst
> > > > > > index 562a7c3c2852..abb56923ad13 100644
> > > > > > --- a/docs/system/confidential-guest-support.rst
> > > > > > +++ b/docs/system/confidential-guest-support.rst
> > > > > > @@ -42,5 +42,6 @@ Currently supported confidential guest mechanisms are:
> > > > > >  * POWER Protected Execution Facility (PEF) (see :ref:`power-papr-protected-execution-facility-pef`)
> > > > > >  * s390x Protected Virtualization (PV) (see :doc:`s390x/protvirt`)
> > > > > >  * AWS Nitro Enclaves (see :doc:`nitro`)
> > > > > > +* Arm Realm Management Extension (RME)
> > > > > >  
> > > > > >  Other mechanisms may be supported in future.
> > > > > > diff --git a/qapi/qom.json b/qapi/qom.json
> > > > > > index 776b13027fd8..52997c29a32d 100644
> > > > > > --- a/qapi/qom.json
> > > > > > +++ b/qapi/qom.json
> > > > > > @@ -1288,6 +1288,17 @@
> > > > > >    'data': { '*pretty': 'bool',
> > > > > >              '*close-action': 'MonitorQMPCloseAction' } }
> > > > > >  
> > > > > > +##
> > > > > > +# @RmeGuestProperties:
> > > > > > +#
> > > > > > +# Properties for rme-guest objects.
> > > > > > +#
> > > > > > +# Since: 11.1
> > > > > > +##
> > > > > > +{ 'struct': 'RmeGuestProperties',
> > > > > > +  'base': 'ConfidentialGuestSupportProperties',
> > > > > 
> > > > > Just FYI, based on input from Markus I'm planning to drop this
> > > > > ConfidentialGuestSupportProperties base type from my series
> > > > > since it's probably only SNP/TDX that need to be able to switch
> > > > > it on/off, whereas this series appears to use/require it from
> > > > > the start.
> > > > > 
> > > > > I'm not exactly sure what it will look like for v3 yet, but if you
> > > > > were based on v2 you'd instead probably just do the following in the
> > > > > instance_init function for your rme-guest instance:
> > > > > 
> > > > >   cgs->allow_convert_in_place = true;
> > > > >   cgs->convert_in_place = true;
> > > > > 
> > > > > rather than exposing it as a cmdline option.
> > > > 
> > > > Yep, it won't be an option for CCA Realms anyway since that will be
> > > > the baseline.
> > > 
> > > IIUC, in-place conversion requires RAM backed by a shared/mappable
> > > guest_memfd. If in-place conversion is always enabled for CCA Realms,
> > > could QEMU also select the equivalent of
> > > 
> > >   -object memory-backend-guest-memfd,id=ram0,size=...,share=on
> > > 
> > > automatically for the default RAM, so that specifying the RAM size with
> > > `-m` is sufficient?
> > 
> > Are you suggesting that on Arm, we completely get rid of 
> 
> Nit: obviously on Arm rme-guest configs.

Indeed.

> 
> >     -object memory-backend-guest-memfd,id=ram0,size=$(RAMSIZE),share=on
> 
> If that's what we want to make a default, I guess we ought to override
> create_default_memdev for arm machines + rme-guest configs ?
> 
> Pros and cons ? I am not sure how well received is setting implicit defaults
> for specific machine configs and what that really buys us eventually.

I agree, this entails a fair amount of changes for cosmetic gains only.

> 
> > or simply to get rid of "size=$(RAMSIZE)" in the above because it is redundant
> > with "-m $(RAMSIZE)"?
> > 
> > Gavin and Michael, what is your take on that suggestion?
> 
> Yes please any feedback on this is welcome.
> 
> Thanks,
> Lorenzo
> 
> > Thanks,
> > Mathieu
> > 
> > > 
> > > Thanks,
> > > Kohei
> > > 
> > > > 
> > > > Thanks,
> > > > Lorenzo
> > > > 
> > > > > Thanks,
> > > > > 
> > > > > Mike
> > > > > 
> > > > > > +  'data': {} }
> > > > > > +
> > > > > >  ##
> > > > > >  # @ObjectType:
> > > > > >  #
> > > > > > @@ -1346,6 +1357,7 @@
> > > > > >      { 'name': 'pr-manager-helper',
> > > > > >        'if': 'CONFIG_LINUX' },
> > > > > >      'qtest',
> > > > > > +    'rme-guest',
> > > > > >      'rng-builtin',
> > > > > >      'rng-egd',
> > > > > >      { 'name': 'rng-random',
> > > > > > @@ -1427,6 +1439,7 @@
> > > > > >        'pr-manager-helper':          { 'type': 'PrManagerHelperProperties',
> > > > > >                                        'if': 'CONFIG_LINUX' },
> > > > > >        'qtest':                      'QtestProperties',
> > > > > > +      'rme-guest':                  'RmeGuestProperties',
> > > > > >        'rng-builtin':                'RngProperties',
> > > > > >        'rng-egd':                    'RngEgdProperties',
> > > > > >        'rng-random':                 { 'type': 'RngRandomProperties',
> > > > > > diff --git a/target/arm/kvm-rme.c b/target/arm/kvm-rme.c
> > > > > > new file mode 100644
> > > > > > index 000000000000..42e1d1e7b859
> > > > > > --- /dev/null
> > > > > > +++ b/target/arm/kvm-rme.c
> > > > > > @@ -0,0 +1,42 @@
> > > > > > +/*
> > > > > > + * QEMU Arm RME support
> > > > > > + *
> > > > > > + * SPDX-License-Identifier: GPL-2.0-or-later
> > > > > > + *
> > > > > > + * Copyright Linaro 2026
> > > > > > + */
> > > > > > +
> > > > > > +#include "qemu/osdep.h"
> > > > > > +
> > > > > > +#include "hw/core/boards.h"
> > > > > > +#include "hw/core/cpu.h"
> > > > > > +#include "kvm_arm.h"
> > > > > > +#include "migration/blocker.h"
> > > > > > +#include "qapi/error.h"
> > > > > > +#include "qom/object_interfaces.h"
> > > > > > +#include "system/confidential-guest-support.h"
> > > > > > +#include "system/kvm.h"
> > > > > > +#include "system/runstate.h"
> > > > > > +
> > > > > > +#define TYPE_RME_GUEST "rme-guest"
> > > > > > +OBJECT_DECLARE_SIMPLE_TYPE(RmeGuest, RME_GUEST)
> > > > > > +
> > > > > > +struct RmeGuest {
> > > > > > +    ConfidentialGuestSupport parent_obj;
> > > > > > +};
> > > > > > +
> > > > > > +OBJECT_DEFINE_SIMPLE_TYPE_WITH_INTERFACES(RmeGuest, rme_guest, RME_GUEST,
> > > > > > +                                          CONFIDENTIAL_GUEST_SUPPORT,
> > > > > > +                                          { TYPE_USER_CREATABLE }, { })
> > > > > > +
> > > > > > +static void rme_guest_class_init(ObjectClass *oc, const void *data)
> > > > > > +{
> > > > > > +}
> > > > > > +
> > > > > > +static void rme_guest_init(Object *obj)
> > > > > > +{
> > > > > > +}
> > > > > > +
> > > > > > +static void rme_guest_finalize(Object *obj)
> > > > > > +{
> > > > > > +}
> > > > > > diff --git a/target/arm/meson.build b/target/arm/meson.build
> > > > > > index 0369f96b4cc6..9d322a7aad28 100644
> > > > > > --- a/target/arm/meson.build
> > > > > > +++ b/target/arm/meson.build
> > > > > > @@ -31,7 +31,10 @@ arm_common_user_system_ss.add(when: 'TARGET_AARCH64', if_true: files(
> > > > > >  arm_common_system_ss.add(files(
> > > > > >    'arm-qmp-cmds.c',
> > > > > >  ))
> > > > > > -arm_system_ss.add(when: 'CONFIG_KVM', if_true: files('hyp_gdbstub.c', 'kvm.c'))
> > > > > > +arm_system_ss.add(when: 'CONFIG_KVM', if_true: files(
> > > > > > +  'hyp_gdbstub.c',
> > > > > > +  'kvm.c',
> > > > > > +  'kvm-rme.c'))
> > > > > >  arm_system_ss.add(when: 'CONFIG_HVF', if_true: files('hyp_gdbstub.c'))
> > > > > >  
> > > > > >  arm_user_ss.add(files('cpu.c'))
> > > > > > -- 
> > > > > > 2.43.0
> > > > > > 
> > > > > > 
