Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C773252BE24
	for <kvm@vger.kernel.org>; Tue, 22 Sep 2026 08:02:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790064139; cv=none; b=UJ998N3wSuZuWsK2WrvxrmWg1/IXPUPKLPbgEB4Rgz5ALX8FRh8tGueq5a4gFsuRLc6oHU17klm/D486PLw2ajGdSe6l4wf7Di7RKXr1i2t+XZP1StGvBqiIGf1y77QUa3+oacvOyQN8QxOVxvMyKpcr2j2JH9fbW0ggXqQi+Rw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790064139; c=relaxed/simple;
	bh=wkKAcio3Y55EeiEbM3WCtnsWodS4VAIQrf3BT29nRiE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eRAwb3CWRWR7dIdxIL2rBzzAIyXsREl6HINVftilO02LoikK5kkaa4w2PpJbUaUOgbGOwTP7EvrY4ZSIiYAfGLZvMHg9C60E94V2mYL2/M+/vCTl1SQ4Bb21nNUKbgh7zSiZDbHhgiwK8MNWCv7fo+i4+AgEG7Kig7GQTfVAO6w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SBtbkT96; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SBtbkT96"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 95C931F00893;
	Tue, 22 Sep 2026 08:02:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790064125;
	bh=90yoPo0e8nZJPx2vt6mPG2SJAIwo1F2IUw8Vwwr2glo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=SBtbkT96sQEIr9U8s3KpVjZusgnwOcci8SF8triD9a2TQD2FNJ1K6/vx7O7q4Dv7k
	 q4goMKO+EI8jnJBLU+HyhIg7q9sGkBsHKD6u3cYonQWGuuWk9J+4jgYAhXlevgroj2
	 g4TlUyNxdRJtdooU3Vz8EBkNdWRoNxmLG0AE32UF+hAyS/xqo1duVX4MV29QbE9Ikc
	 F8f0m+Grmdn/E+C15DNnTNN5r8e5DHhUnLqyZ2WkjVJOa0eWeXvTOWhBI6mDO/Zo5T
	 SMV9B8Ga2h4IpZdChPLx0QB0GA6OsFhbpKWJMtmKJ0cmQY/Eh1GcHonHFQVrIl3Z08
	 22f7sonZyZp5w==
Date: Tue, 22 Sep 2026 10:01:59 +0200
From: Lorenzo Pieralisi <lpieralisi@kernel.org>
To: Michael Roth <michael.roth@amd.com>
Cc: Mathieu Poirier <mathieu.poirier@linaro.org>, berrange@redhat.com,
	kchamart@redhat.com, pierrick.bouvier@oss.qualcomm.com,
	peter.maydell@linaro.org, mst@redhat.com, cohuck@redhat.com,
	pbonzini@redhat.com, eblake@redhat.com, armbru@redhat.com,
	lorenzo.pieralisi@linaro.org, gshan@redhat.com,
	enju.kohei@fujitsu.com, qemu-devel@nongnu.org, qemu-arm@nongnu.org,
	kvm@vger.kernel.org
Subject: Re: [RFC v4 03/24] target/arm: Add confidential guest support
Message-ID: <arI197vJkW75p50c@lpieralisi>
References: <20260903193611.1058589-1-mathieu.poirier@linaro.org>
 <20260903193611.1058589-4-mathieu.poirier@linaro.org>
 <dhrvydsmaw22xqx5d5i5s7fdyjxupz27yxp6trv2tesysp4npj@quvzrxjvfipz>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <dhrvydsmaw22xqx5d5i5s7fdyjxupz27yxp6trv2tesysp4npj@quvzrxjvfipz>

On Tue, Sep 15, 2026 at 04:27:21PM -0500, Michael Roth wrote:
> On Thu, Sep 03, 2026 at 01:35:50PM -0600, Mathieu Poirier wrote:
> > From: Jean-Philippe Brucker <jean-philippe@linaro.org>
> > 
> > Add a new RmeGuest object, inheriting from ConfidentialGuestSupport, to
> > support the Arm Realm Management Extension (RME). It is instantiated by
> > passing on the command-line:
> > 
> >   -M virt,confidential-guest-support=<id>
> >   -object rme-guest,id=<id>
> > 
> > This is only the skeleton. Support will be added in following patches.
> > 
> > Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
> > Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
> > ---
> >  docs/system/confidential-guest-support.rst |  1 +
> >  qapi/qom.json                              | 13 +++++++
> >  target/arm/kvm-rme.c                       | 42 ++++++++++++++++++++++
> >  target/arm/meson.build                     |  5 ++-
> >  4 files changed, 60 insertions(+), 1 deletion(-)
> >  create mode 100644 target/arm/kvm-rme.c
> > 
> > diff --git a/docs/system/confidential-guest-support.rst b/docs/system/confidential-guest-support.rst
> > index 562a7c3c2852..abb56923ad13 100644
> > --- a/docs/system/confidential-guest-support.rst
> > +++ b/docs/system/confidential-guest-support.rst
> > @@ -42,5 +42,6 @@ Currently supported confidential guest mechanisms are:
> >  * POWER Protected Execution Facility (PEF) (see :ref:`power-papr-protected-execution-facility-pef`)
> >  * s390x Protected Virtualization (PV) (see :doc:`s390x/protvirt`)
> >  * AWS Nitro Enclaves (see :doc:`nitro`)
> > +* Arm Realm Management Extension (RME)
> >  
> >  Other mechanisms may be supported in future.
> > diff --git a/qapi/qom.json b/qapi/qom.json
> > index 776b13027fd8..52997c29a32d 100644
> > --- a/qapi/qom.json
> > +++ b/qapi/qom.json
> > @@ -1288,6 +1288,17 @@
> >    'data': { '*pretty': 'bool',
> >              '*close-action': 'MonitorQMPCloseAction' } }
> >  
> > +##
> > +# @RmeGuestProperties:
> > +#
> > +# Properties for rme-guest objects.
> > +#
> > +# Since: 11.1
> > +##
> > +{ 'struct': 'RmeGuestProperties',
> > +  'base': 'ConfidentialGuestSupportProperties',
> 
> Just FYI, based on input from Markus I'm planning to drop this
> ConfidentialGuestSupportProperties base type from my series
> since it's probably only SNP/TDX that need to be able to switch
> it on/off, whereas this series appears to use/require it from
> the start.
> 
> I'm not exactly sure what it will look like for v3 yet, but if you
> were based on v2 you'd instead probably just do the following in the
> instance_init function for your rme-guest instance:
> 
>   cgs->allow_convert_in_place = true;
>   cgs->convert_in_place = true;
> 
> rather than exposing it as a cmdline option.

Yep, it won't be an option for CCA Realms anyway since that will be
the baseline.

Thanks,
Lorenzo

> Thanks,
> 
> Mike
> 
> > +  'data': {} }
> > +
> >  ##
> >  # @ObjectType:
> >  #
> > @@ -1346,6 +1357,7 @@
> >      { 'name': 'pr-manager-helper',
> >        'if': 'CONFIG_LINUX' },
> >      'qtest',
> > +    'rme-guest',
> >      'rng-builtin',
> >      'rng-egd',
> >      { 'name': 'rng-random',
> > @@ -1427,6 +1439,7 @@
> >        'pr-manager-helper':          { 'type': 'PrManagerHelperProperties',
> >                                        'if': 'CONFIG_LINUX' },
> >        'qtest':                      'QtestProperties',
> > +      'rme-guest':                  'RmeGuestProperties',
> >        'rng-builtin':                'RngProperties',
> >        'rng-egd':                    'RngEgdProperties',
> >        'rng-random':                 { 'type': 'RngRandomProperties',
> > diff --git a/target/arm/kvm-rme.c b/target/arm/kvm-rme.c
> > new file mode 100644
> > index 000000000000..42e1d1e7b859
> > --- /dev/null
> > +++ b/target/arm/kvm-rme.c
> > @@ -0,0 +1,42 @@
> > +/*
> > + * QEMU Arm RME support
> > + *
> > + * SPDX-License-Identifier: GPL-2.0-or-later
> > + *
> > + * Copyright Linaro 2026
> > + */
> > +
> > +#include "qemu/osdep.h"
> > +
> > +#include "hw/core/boards.h"
> > +#include "hw/core/cpu.h"
> > +#include "kvm_arm.h"
> > +#include "migration/blocker.h"
> > +#include "qapi/error.h"
> > +#include "qom/object_interfaces.h"
> > +#include "system/confidential-guest-support.h"
> > +#include "system/kvm.h"
> > +#include "system/runstate.h"
> > +
> > +#define TYPE_RME_GUEST "rme-guest"
> > +OBJECT_DECLARE_SIMPLE_TYPE(RmeGuest, RME_GUEST)
> > +
> > +struct RmeGuest {
> > +    ConfidentialGuestSupport parent_obj;
> > +};
> > +
> > +OBJECT_DEFINE_SIMPLE_TYPE_WITH_INTERFACES(RmeGuest, rme_guest, RME_GUEST,
> > +                                          CONFIDENTIAL_GUEST_SUPPORT,
> > +                                          { TYPE_USER_CREATABLE }, { })
> > +
> > +static void rme_guest_class_init(ObjectClass *oc, const void *data)
> > +{
> > +}
> > +
> > +static void rme_guest_init(Object *obj)
> > +{
> > +}
> > +
> > +static void rme_guest_finalize(Object *obj)
> > +{
> > +}
> > diff --git a/target/arm/meson.build b/target/arm/meson.build
> > index 0369f96b4cc6..9d322a7aad28 100644
> > --- a/target/arm/meson.build
> > +++ b/target/arm/meson.build
> > @@ -31,7 +31,10 @@ arm_common_user_system_ss.add(when: 'TARGET_AARCH64', if_true: files(
> >  arm_common_system_ss.add(files(
> >    'arm-qmp-cmds.c',
> >  ))
> > -arm_system_ss.add(when: 'CONFIG_KVM', if_true: files('hyp_gdbstub.c', 'kvm.c'))
> > +arm_system_ss.add(when: 'CONFIG_KVM', if_true: files(
> > +  'hyp_gdbstub.c',
> > +  'kvm.c',
> > +  'kvm-rme.c'))
> >  arm_system_ss.add(when: 'CONFIG_HVF', if_true: files('hyp_gdbstub.c'))
> >  
> >  arm_user_ss.add(files('cpu.c'))
> > -- 
> > 2.43.0
> > 
> > 
