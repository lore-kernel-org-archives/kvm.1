Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793037978;
	b=piGjQOC0BfkGACmWRBO8SxFo6yDI6ihWM59nX1tR19vW4H8edObs+UDoyWg2yDfB7d6v
	 bC90ZEZsfndNjCJAhQiwzcH6d5BWJQzgfpatibQNjEvuW8cHG/3G6JMv99ZA8qG4KojHs
	 0VMIMVj4E1YigXN6K3amlILsGLyy1xYn4VHUg4XlfbJrj3HrWxzECWJ8dEkULhJjM/HeO
	 13EDOj/aSw1PTPoBrWFqG2F1SNfNJjpLYscDUa9xNLifx4c/Zlgok0aMh9fj79Ga6FY9L
	 uLacLNVcOpUE781wN6AhGLM270uMCqCmO5aRhyARD3siLE+BC9KzuGab9jHO/xaIPHQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793037978;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=LBGkaPhdObxNrBE0ZUjTzcErftmqVe54UYoLQPkRoU0=;
	b=QW+ks/o43fuXnNNDYE0Xf58ilPf9mYvxt4lXVgoOQgOV776JLOiGD9JaNAL5zKhhQoVx
	 5ZFLoImDS4BuIBdB1FEN8TM6rrCKv5ElxUM70Nv30VSjqBkaR8NwCOI2tn5+7iqfjsgye
	 szL5JjdaEahdC4sntwt3WDeC+3XgKl0IxuODQh7yuAvUws5Az5XnIQblTFujCXceNh5W5
	 GwDedBST6RwG8j3pO17/tYMNA9EXqsdjZckXIIixomB5fnr2k4+E1R0/E1hmVHI6ayrGE
	 5vYi/kVxUIGgSkPrP8qlY7711IgHWCF7VttNdB8DFXEtjeLbh2hLNUARQMFHWPzwvSg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=LnkBAUFJ;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 426A0606A31D
	for <kvm@vger.kernel.org>; Mon, 26 Oct 2026 18:06:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=LnkBAUFJ
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D3BE41F01829;
	Mon, 26 Oct 2026 18:06:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793037977;
	bh=LBGkaPhdObxNrBE0ZUjTzcErftmqVe54UYoLQPkRoU0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=LnkBAUFJzx0ftPRaHYoA4hvz6JhpktkLdn94GbW0jrVld94QtQ8jZP/A/RaRLwOSD
	 oYmYdGxy9o8MevqQZRK4gr8/H6PvhmX8aClAukUWY/zBEt9ZHxhdVJWi5pwQ9xz5+3
	 ADW3acRgq5bxH9INtkyPR0XSsqu2aINjC3fLSHuoUa5DwtsHR9iTrznmjK1IQAQh/K
	 4ry9GelvYv5YNpo/zXtcg4kB7ez3qIrRkad9AgsqY0tSK/6M4kF3JLfp9HN54HP4zh
	 xqjWtsw2Rey1nYFbnlsVwYnNd/Wnbap/owYnqXwX7m08by9OgnMHj4GZqAmIyg/PIa
	 jj+sdVZ8fuHDA==
Date: Mon, 26 Oct 2026 19:06:11 +0100
From: Lorenzo Pieralisi <lpieralisi@kernel.org>
To: Gavin Shan <gshan@redhat.com>
Cc: Mathieu Poirier <mathieu.poirier@linaro.org>,
	Kohei Enju <enju.kohei@fujitsu.com>, michael.roth@amd.com,
	berrange@redhat.com, kchamart@redhat.com,
	pierrick.bouvier@oss.qualcomm.com, peter.maydell@linaro.org,
	mst@redhat.com, cohuck@redhat.com, pbonzini@redhat.com,
	eblake@redhat.com, armbru@redhat.com, lorenzo.pieralisi@linaro.org,
	qemu-devel@nongnu.org, qemu-arm@nongnu.org, kvm@vger.kernel.org
Subject: Re: [RFC v4 03/24] target/arm: Add confidential guest support
Message-ID: <at-Wkw7a3Tn3Oh3M@red-moon>
References: <20260903193611.1058589-1-mathieu.poirier@linaro.org>
 <20260903193611.1058589-4-mathieu.poirier@linaro.org>
 <dhrvydsmaw22xqx5d5i5s7fdyjxupz27yxp6trv2tesysp4npj@quvzrxjvfipz>
 <arI197vJkW75p50c@lpieralisi>
 <arSTQQ5uB6oR-vFe@FCCLS0092175.localdomain>
 <ataBkrIvULJXj4v6@p14s>
 <784dfea3-24cb-4e70-ab46-b96b4b9a1831@redhat.com>
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
In-Reply-To: <784dfea3-24cb-4e70-ab46-b96b4b9a1831@redhat.com>

On Wed, Oct 21, 2026 at 11:42:14PM +1000, Gavin Shan wrote:
> On 10/20/26 6:46 AM, Mathieu Poirier wrote:
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
> > > > > >    -M virt,confidential-guest-support=<id>
> > > > > >    -object rme-guest,id=<id>
> > > > > > 
> > > > > > This is only the skeleton. Support will be added in following patches.
> > > > > > 
> > > > > > Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
> > > > > > Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
> > > > > > ---
> > > > > >   docs/system/confidential-guest-support.rst |  1 +
> > > > > >   qapi/qom.json                              | 13 +++++++
> > > > > >   target/arm/kvm-rme.c                       | 42 ++++++++++++++++++++++
> > > > > >   target/arm/meson.build                     |  5 ++-
> > > > > >   4 files changed, 60 insertions(+), 1 deletion(-)
> > > > > >   create mode 100644 target/arm/kvm-rme.c
> > > > > > 
> > > > > > diff --git a/docs/system/confidential-guest-support.rst b/docs/system/confidential-guest-support.rst
> > > > > > index 562a7c3c2852..abb56923ad13 100644
> > > > > > --- a/docs/system/confidential-guest-support.rst
> > > > > > +++ b/docs/system/confidential-guest-support.rst
> > > > > > @@ -42,5 +42,6 @@ Currently supported confidential guest mechanisms are:
> > > > > >   * POWER Protected Execution Facility (PEF) (see :ref:`power-papr-protected-execution-facility-pef`)
> > > > > >   * s390x Protected Virtualization (PV) (see :doc:`s390x/protvirt`)
> > > > > >   * AWS Nitro Enclaves (see :doc:`nitro`)
> > > > > > +* Arm Realm Management Extension (RME)
> > > > > >   Other mechanisms may be supported in future.
> > > > > > diff --git a/qapi/qom.json b/qapi/qom.json
> > > > > > index 776b13027fd8..52997c29a32d 100644
> > > > > > --- a/qapi/qom.json
> > > > > > +++ b/qapi/qom.json
> > > > > > @@ -1288,6 +1288,17 @@
> > > > > >     'data': { '*pretty': 'bool',
> > > > > >               '*close-action': 'MonitorQMPCloseAction' } }
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
> > > > >    cgs->allow_convert_in_place = true;
> > > > >    cgs->convert_in_place = true;
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
> > >    -object memory-backend-guest-memfd,id=ram0,size=...,share=on
> > > 
> > > automatically for the default RAM, so that specifying the RAM size with
> > > `-m` is sufficient?
> > 
> > Are you suggesting that on Arm, we completely get rid of
> > 
> >      -object memory-backend-guest-memfd,id=ram0,size=$(RAMSIZE),share=on
> > 
> > or simply to get rid of "size=$(RAMSIZE)" in the above because it is redundant
> > with "-m $(RAMSIZE)"?
> > 
> > Gavin and Michael, what is your take on that suggestion?
> > 
> 
> I don't think that's what Kohei meant. He actually suggested the memory backend
> shall be pinned to memory-backend-guest-memfd and its in-place conversion shall
> be enabled when the memory backend isn't explicitly specified by users through
> "-object memory-backend-xxxx". For this inexplicit case, where the memory backend
> is determined by '-mem-path', the memory backend is either TYPE_MEMORY_BACKEND_FILE
> or TYPE_MEMORY_BACKEND_RAM. Please refer to create_default_memdev().
> 
> I think Kohei's suggestion makes sense. Besides, I think '-mem-path' should be
> disallowed for CCA Realms as TYPE_MEMORY_BACKEND_FILE isn't what we want.

Kohei, what were you suggesting then please ? I think TYPE_MEMORY_BACKEND_FILE
would not pass the checks required by Michael's v3 [0] on CCA - I will test this
and report back but the only backend allowed, rightly, is memfd,share=on, so it
_is_ disallowed.

Lorenzo

[0] https://lore.kernel.org/kvm/20261007134323.1606088-1-michael.roth@amd.com/

> Thanks,
> Gavin
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
> > > > > >   ##
> > > > > >   # @ObjectType:
> > > > > >   #
> > > > > > @@ -1346,6 +1357,7 @@
> > > > > >       { 'name': 'pr-manager-helper',
> > > > > >         'if': 'CONFIG_LINUX' },
> > > > > >       'qtest',
> > > > > > +    'rme-guest',
> > > > > >       'rng-builtin',
> > > > > >       'rng-egd',
> > > > > >       { 'name': 'rng-random',
> > > > > > @@ -1427,6 +1439,7 @@
> > > > > >         'pr-manager-helper':          { 'type': 'PrManagerHelperProperties',
> > > > > >                                         'if': 'CONFIG_LINUX' },
> > > > > >         'qtest':                      'QtestProperties',
> > > > > > +      'rme-guest':                  'RmeGuestProperties',
> > > > > >         'rng-builtin':                'RngProperties',
> > > > > >         'rng-egd':                    'RngEgdProperties',
> > > > > >         'rng-random':                 { 'type': 'RngRandomProperties',
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
> > > > > >   arm_common_system_ss.add(files(
> > > > > >     'arm-qmp-cmds.c',
> > > > > >   ))
> > > > > > -arm_system_ss.add(when: 'CONFIG_KVM', if_true: files('hyp_gdbstub.c', 'kvm.c'))
> > > > > > +arm_system_ss.add(when: 'CONFIG_KVM', if_true: files(
> > > > > > +  'hyp_gdbstub.c',
> > > > > > +  'kvm.c',
> > > > > > +  'kvm-rme.c'))
> > > > > >   arm_system_ss.add(when: 'CONFIG_HVF', if_true: files('hyp_gdbstub.c'))
> > > > > >   arm_user_ss.add(files('cpu.c'))
> > > > > > -- 
> > > > > > 2.43.0
> > > > > > 
> > > > > > 
> > 
> 
