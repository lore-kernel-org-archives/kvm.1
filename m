Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792494164;
	b=5fk6Vs3qIKyLrnQQbr4JVbtlH4yOxBs22iaWsMZifBfUE6NnaeZDQWl4g9fHSQaXvB1M
	 0fj/+ElGvsnVJse660XBrhgD85ITgmbozCCYpki4xD2PPZpEG7KWP5y/KHV78uiy2oni1
	 8mz0JsBaSZlbZhOT9KQRKPTg8e5ARLXgbuH061IdK7ZWos96p+uzV7qxZvrkcO2VMYOQ1
	 RpAX1AoasonDNH5OKjrA0x9nuis9ly51hJBu/C3tm2p0t1/pZqMybhBqivZjRzkxoAwa0
	 Mm1T4etnvgqXodWaa2nHOYDEihWioTpPsqj5PFSaPAwzLeMSUxkJvX8s1edwqE+z7JQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792494164;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=7zYB57edMlEZAvIfqpn2Qe1WGxwqe/dTSl4gWBa2p7A=;
	b=kRAwUvPOqvtUX6eYR48n+6fP+qqodKDySTpVXHwrGw8i0acVvkECgZ19d/Q6LCCNTwR2
	 qdfVcxHsuPAFvCkztHmgeb9aRp8dBPsix8hja8E2uwxIxPaN1mi9Gf9BY6q3pDezgK14P
	 Ee6+L35Y1tat3iP5k8rZ2qsUH1lbXPUwfcbV7pK9h0sRkjngrmJRABMGEZ3rqZIUmY48b
	 WLGJx7hUwJTaQcWbAcYAUMD0T6Rk7xTI89hpCOb7jhYzImb26rgIoyx11qAGbN+0GWnNB
	 N6AOgM3IPzkmyGxKcYz9+hZW1PzzJRw2M7HSk53VXlYIjx2qgcqqoqSTNRF+87u8sNQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=BD0QwQIH;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EEFC606A31B
	for <kvm@vger.kernel.org>; Tue, 20 Oct 2026 11:02:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=BD0QwQIH
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 316471F000C4;
	Tue, 20 Oct 2026 11:02:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792494163;
	bh=7zYB57edMlEZAvIfqpn2Qe1WGxwqe/dTSl4gWBa2p7A=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=BD0QwQIHT+pwFKbQSnpqFUvGg4/9pbiOjTqNh9V5xSsGWMdwbjbvIrQdPt9ayjkQb
	 HtkLCTgdlJk1+reSP9oucPMxCNj1iy8PXq+9U1Cbap1UJoFUtgcK1FqqoBB0iNvdRL
	 o6uJYi3KRhwmmY+JBCYXdMzXs78vNN1NCAkkB3j0oEuMdmbnQr97jPD4V8RsMw68uk
	 U/J4OvtJDIUoPaxbMs4mtamU6Cf5vLXw/33W/zaY0+3dVGVmCG8kTVptINHrKkdbv9
	 qt7nOJ2KaOX1ZVMqk79k4nHxBc5d151wEueDkJyxdVLqaBCSs+RIfsejb2Vd/eB3rn
	 S20IKCG4GWteQ==
Date: Tue, 20 Oct 2026 13:02:35 +0200
From: Lorenzo Pieralisi <lpieralisi@kernel.org>
To: Mathieu Poirier <mathieu.poirier@linaro.org>
Cc: Kohei Enju <enju.kohei@fujitsu.com>, gshan@redhat.com,
	michael.roth@amd.com, berrange@redhat.com, kchamart@redhat.com,
	pierrick.bouvier@oss.qualcomm.com, peter.maydell@linaro.org,
	mst@redhat.com, cohuck@redhat.com, pbonzini@redhat.com,
	eblake@redhat.com, armbru@redhat.com, lorenzo.pieralisi@linaro.org,
	qemu-devel@nongnu.org, qemu-arm@nongnu.org, kvm@vger.kernel.org
Subject: Re: [RFC v4 03/24] target/arm: Add confidential guest support
Message-ID: <atdKSwvu_uldqwlz@red-moon>
References: <20260903193611.1058589-1-mathieu.poirier@linaro.org>
 <20260903193611.1058589-4-mathieu.poirier@linaro.org>
 <dhrvydsmaw22xqx5d5i5s7fdyjxupz27yxp6trv2tesysp4npj@quvzrxjvfipz>
 <arI197vJkW75p50c@lpieralisi>
 <arSTQQ5uB6oR-vFe@FCCLS0092175.localdomain>
 <ataBkrIvULJXj4v6@p14s>
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
In-Reply-To: <ataBkrIvULJXj4v6@p14s>

On Mon, Oct 19, 2026 at 02:46:10PM -0600, Mathieu Poirier wrote:
> On Thu, Sep 24, 2026 at 12:12:35PM +0900, Kohei Enju wrote:
> > On 09/22 10:01, Lorenzo Pieralisi wrote:
> > > On Tue, Sep 15, 2026 at 04:27:21PM -0500, Michael Roth wrote:
> > > > On Thu, Sep 03, 2026 at 01:35:50PM -0600, Mathieu Poirier wrote:
> > > > > From: Jean-Philippe Brucker <jean-philippe@linaro.org>
> > > > > 
> > > > > Add a new RmeGuest object, inheriting from ConfidentialGuestSupport, to
> > > > > support the Arm Realm Management Extension (RME). It is instantiated by
> > > > > passing on the command-line:
> > > > > 
> > > > >   -M virt,confidential-guest-support=<id>
> > > > >   -object rme-guest,id=<id>
> > > > > 
> > > > > This is only the skeleton. Support will be added in following patches.
> > > > > 
> > > > > Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
> > > > > Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
> > > > > ---
> > > > >  docs/system/confidential-guest-support.rst |  1 +
> > > > >  qapi/qom.json                              | 13 +++++++
> > > > >  target/arm/kvm-rme.c                       | 42 ++++++++++++++++++++++
> > > > >  target/arm/meson.build                     |  5 ++-
> > > > >  4 files changed, 60 insertions(+), 1 deletion(-)
> > > > >  create mode 100644 target/arm/kvm-rme.c
> > > > > 
> > > > > diff --git a/docs/system/confidential-guest-support.rst b/docs/system/confidential-guest-support.rst
> > > > > index 562a7c3c2852..abb56923ad13 100644
> > > > > --- a/docs/system/confidential-guest-support.rst
> > > > > +++ b/docs/system/confidential-guest-support.rst
> > > > > @@ -42,5 +42,6 @@ Currently supported confidential guest mechanisms are:
> > > > >  * POWER Protected Execution Facility (PEF) (see :ref:`power-papr-protected-execution-facility-pef`)
> > > > >  * s390x Protected Virtualization (PV) (see :doc:`s390x/protvirt`)
> > > > >  * AWS Nitro Enclaves (see :doc:`nitro`)
> > > > > +* Arm Realm Management Extension (RME)
> > > > >  
> > > > >  Other mechanisms may be supported in future.
> > > > > diff --git a/qapi/qom.json b/qapi/qom.json
> > > > > index 776b13027fd8..52997c29a32d 100644
> > > > > --- a/qapi/qom.json
> > > > > +++ b/qapi/qom.json
> > > > > @@ -1288,6 +1288,17 @@
> > > > >    'data': { '*pretty': 'bool',
> > > > >              '*close-action': 'MonitorQMPCloseAction' } }
> > > > >  
> > > > > +##
> > > > > +# @RmeGuestProperties:
> > > > > +#
> > > > > +# Properties for rme-guest objects.
> > > > > +#
> > > > > +# Since: 11.1
> > > > > +##
> > > > > +{ 'struct': 'RmeGuestProperties',
> > > > > +  'base': 'ConfidentialGuestSupportProperties',
> > > > 
> > > > Just FYI, based on input from Markus I'm planning to drop this
> > > > ConfidentialGuestSupportProperties base type from my series
> > > > since it's probably only SNP/TDX that need to be able to switch
> > > > it on/off, whereas this series appears to use/require it from
> > > > the start.
> > > > 
> > > > I'm not exactly sure what it will look like for v3 yet, but if you
> > > > were based on v2 you'd instead probably just do the following in the
> > > > instance_init function for your rme-guest instance:
> > > > 
> > > >   cgs->allow_convert_in_place = true;
> > > >   cgs->convert_in_place = true;
> > > > 
> > > > rather than exposing it as a cmdline option.
> > > 
> > > Yep, it won't be an option for CCA Realms anyway since that will be
> > > the baseline.
> > 
> > IIUC, in-place conversion requires RAM backed by a shared/mappable
> > guest_memfd. If in-place conversion is always enabled for CCA Realms,
> > could QEMU also select the equivalent of
> > 
> >   -object memory-backend-guest-memfd,id=ram0,size=...,share=on
> > 
> > automatically for the default RAM, so that specifying the RAM size with
> > `-m` is sufficient?
> 
> Are you suggesting that on Arm, we completely get rid of 

Nit: obviously on Arm rme-guest configs.

>     -object memory-backend-guest-memfd,id=ram0,size=$(RAMSIZE),share=on

If that's what we want to make a default, I guess we ought to override
create_default_memdev for arm machines + rme-guest configs ?

Pros and cons ? I am not sure how well received is setting implicit defaults
for specific machine configs and what that really buys us eventually.

> or simply to get rid of "size=$(RAMSIZE)" in the above because it is redundant
> with "-m $(RAMSIZE)"?
> 
> Gavin and Michael, what is your take on that suggestion?

Yes please any feedback on this is welcome.

Thanks,
Lorenzo

> Thanks,
> Mathieu
> 
> > 
> > Thanks,
> > Kohei
> > 
> > > 
> > > Thanks,
> > > Lorenzo
> > > 
> > > > Thanks,
> > > > 
> > > > Mike
> > > > 
> > > > > +  'data': {} }
> > > > > +
> > > > >  ##
> > > > >  # @ObjectType:
> > > > >  #
> > > > > @@ -1346,6 +1357,7 @@
> > > > >      { 'name': 'pr-manager-helper',
> > > > >        'if': 'CONFIG_LINUX' },
> > > > >      'qtest',
> > > > > +    'rme-guest',
> > > > >      'rng-builtin',
> > > > >      'rng-egd',
> > > > >      { 'name': 'rng-random',
> > > > > @@ -1427,6 +1439,7 @@
> > > > >        'pr-manager-helper':          { 'type': 'PrManagerHelperProperties',
> > > > >                                        'if': 'CONFIG_LINUX' },
> > > > >        'qtest':                      'QtestProperties',
> > > > > +      'rme-guest':                  'RmeGuestProperties',
> > > > >        'rng-builtin':                'RngProperties',
> > > > >        'rng-egd':                    'RngEgdProperties',
> > > > >        'rng-random':                 { 'type': 'RngRandomProperties',
> > > > > diff --git a/target/arm/kvm-rme.c b/target/arm/kvm-rme.c
> > > > > new file mode 100644
> > > > > index 000000000000..42e1d1e7b859
> > > > > --- /dev/null
> > > > > +++ b/target/arm/kvm-rme.c
> > > > > @@ -0,0 +1,42 @@
> > > > > +/*
> > > > > + * QEMU Arm RME support
> > > > > + *
> > > > > + * SPDX-License-Identifier: GPL-2.0-or-later
> > > > > + *
> > > > > + * Copyright Linaro 2026
> > > > > + */
> > > > > +
> > > > > +#include "qemu/osdep.h"
> > > > > +
> > > > > +#include "hw/core/boards.h"
> > > > > +#include "hw/core/cpu.h"
> > > > > +#include "kvm_arm.h"
> > > > > +#include "migration/blocker.h"
> > > > > +#include "qapi/error.h"
> > > > > +#include "qom/object_interfaces.h"
> > > > > +#include "system/confidential-guest-support.h"
> > > > > +#include "system/kvm.h"
> > > > > +#include "system/runstate.h"
> > > > > +
> > > > > +#define TYPE_RME_GUEST "rme-guest"
> > > > > +OBJECT_DECLARE_SIMPLE_TYPE(RmeGuest, RME_GUEST)
> > > > > +
> > > > > +struct RmeGuest {
> > > > > +    ConfidentialGuestSupport parent_obj;
> > > > > +};
> > > > > +
> > > > > +OBJECT_DEFINE_SIMPLE_TYPE_WITH_INTERFACES(RmeGuest, rme_guest, RME_GUEST,
> > > > > +                                          CONFIDENTIAL_GUEST_SUPPORT,
> > > > > +                                          { TYPE_USER_CREATABLE }, { })
> > > > > +
> > > > > +static void rme_guest_class_init(ObjectClass *oc, const void *data)
> > > > > +{
> > > > > +}
> > > > > +
> > > > > +static void rme_guest_init(Object *obj)
> > > > > +{
> > > > > +}
> > > > > +
> > > > > +static void rme_guest_finalize(Object *obj)
> > > > > +{
> > > > > +}
> > > > > diff --git a/target/arm/meson.build b/target/arm/meson.build
> > > > > index 0369f96b4cc6..9d322a7aad28 100644
> > > > > --- a/target/arm/meson.build
> > > > > +++ b/target/arm/meson.build
> > > > > @@ -31,7 +31,10 @@ arm_common_user_system_ss.add(when: 'TARGET_AARCH64', if_true: files(
> > > > >  arm_common_system_ss.add(files(
> > > > >    'arm-qmp-cmds.c',
> > > > >  ))
> > > > > -arm_system_ss.add(when: 'CONFIG_KVM', if_true: files('hyp_gdbstub.c', 'kvm.c'))
> > > > > +arm_system_ss.add(when: 'CONFIG_KVM', if_true: files(
> > > > > +  'hyp_gdbstub.c',
> > > > > +  'kvm.c',
> > > > > +  'kvm-rme.c'))
> > > > >  arm_system_ss.add(when: 'CONFIG_HVF', if_true: files('hyp_gdbstub.c'))
> > > > >  
> > > > >  arm_user_ss.add(files('cpu.c'))
> > > > > -- 
> > > > > 2.43.0
> > > > > 
> > > > > 
