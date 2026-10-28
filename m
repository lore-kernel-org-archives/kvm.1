Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=139.138.37.100
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793163105;
	b=ttYelv7o5f9+Dx/0tlgYvarrXI5bv9W/RxrHnzq/k9gzCvlh4g7TSpiI607MSepc/0rO
	 QChD6GlRMBrh2Mex7HA5FvRB1j/n5M41wxKGUXUAl7C/m2QIv6YlamFrvVGM6pCmoTZfv
	 NGn5g+yfA3i7AgIiI+96mHEteuarKY25plj74mR2dIjoOlCK1fv91FT+EIITeiT97UcBX
	 bgyqo7UefcJ9a8G12XLOAwnoOXRD6kP1AqLQucGuScULJ8AI3MbUSgi7ryOKHyWDSFRF5
	 6Rf5oSYcOh5GZVoK2eBtd37O8JzV8m3L1r743SQTNZmoUH8ad7ZLYv4jK4DOTsr1bTA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793163105;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:Received:Received:Received:Date:
	 From:To:Cc:Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To;
	bh=cB3kgbMCdJ3/96t9GcxgtKuwzmPOAVnNl2VYw6yYmyc=;
	b=sXOiIHwsYc8noaU5QNX7pf0nt/I9xJEJzfP/licCpxd3kJNKQZrq5oZ+RZ/CYJI0DRXs
	 YKD7jaqb8uwRQw5oHwmiP+vrequo6jVT9GQ6OZ2HozBudvbhgDIeki0A4+ggjsyBZafV6
	 VApVYWFemox1mZcDWq+t3Xsf6e0biChYSSDsEL1hAMlvExUTq+F5//P1E9SC+ZDAdUX6m
	 Pc2iPyeRImBK5PxlMSiM7LWI1GEY+OZ4/sRUlLjNnWUurh2XwT9+TQq32XXF7K+loFWJL
	 dE9VyVnSuQDvGwM9dELK2JZAhEi0VvhtGGBW2nuWH8kboPRre0xaRY4kxYR71eKob6g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=fujitsu.com;
	spf=pass smtp.mailfrom=fujitsu.com;
	dkim=pass header.d=fujitsu.com header.i=@fujitsu.com header.a=rsa-sha256 header.s=fj2 header.b=O6FZJV4J;
	arc=none smtp.remote-ip=139.138.37.100
Received: from esa12.hc1455-7.c3s2.iphmx.com (esa12.hc1455-7.c3s2.iphmx.com [139.138.37.100])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D206606A31A
	for <kvm@vger.kernel.org>; Wed, 28 Oct 2026 04:51:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6D206606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=fujitsu.com header.i=@fujitsu.com header.a=rsa-sha256 header.s=fj2 header.b=O6FZJV4J
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj2;
  t=1793163104; x=1824699104;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=vEQHe4OQbDaVWWPIT41fh0Pgui+NyNm61DH2obcWQ/k=;
  b=O6FZJV4JEN2sR+gZ2b94VN/19WQzGKnx37YQHvLG40F6i6Gh8lbv+nXZ
   Kuqcz4TZJzcTC+cucC+oJS+Gr0fCWuykQO/b9adqRBb7AsVg+9+eMOv7V
   cwq0uDpnXdkEJKaJdnvMyzt0r0ABIpFZfHaMCETe5gJIhI633wGiKpKIm
   7OuM7wRQMyoMpSpctbplAdP5dMFN/2/w3RYwyEJjvRMMakI0CieW9ZwRX
   dOEhkK0VM+nkKCfaQOjIuOwDFy6OLlMioQquyyy+KTbkPBFC+sQPaxvxu
   ZgMB+SPOVh5RTt5xxs3wpy4BJUvEejKBS9BsUmxq0bm1+2ICA2LESIyfp
   g==;
X-CSE-ConnectionGUID: FFtQA4PZRlCM9GerVz6wVA==
X-CSE-MsgGUID: PNEwnOdqSPyV9BZ/IIY/Cw==
X-IronPort-AV: E=McAfee;i="6800,10657,11948"; a="237444916"
X-IronPort-AV: E=Sophos;i="6.27,182,1786978800"; 
   d="scan'208";a="237444916"
Received: from gmgwuk01.global.fujitsu.com ([172.187.114.235])
  by esa12.hc1455-7.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Oct 2026 13:51:37 +0900
Received: from az2uksmgm4.o.css.fujitsu.com (unknown [10.151.22.201])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by gmgwuk01.global.fujitsu.com (Postfix) with ESMTPS id 66291C006DB
	for <kvm@vger.kernel.org>; Wed, 28 Oct 2026 04:51:37 +0000 (UTC)
Received: from az2uksmom2.o.css.fujitsu.com (unknown [10.151.22.203])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by az2uksmgm4.o.css.fujitsu.com (Postfix) with ESMTPS id 1D16414003F8
	for <kvm@vger.kernel.org>; Wed, 28 Oct 2026 04:51:37 +0000 (UTC)
Received: from FCCLS0092175.localdomain (unknown [10.8.69.152])
	by az2uksmom2.o.css.fujitsu.com (Postfix) with SMTP id ACAD814002FE;
	Wed, 28 Oct 2026 04:51:30 +0000 (UTC)
Date: Wed, 28 Oct 2026 13:51:29 +0900
From: Kohei Enju <enju.kohei@fujitsu.com>
To: Lorenzo Pieralisi <lpieralisi@kernel.org>
Cc: Gavin Shan <gshan@redhat.com>, 
	Mathieu Poirier <mathieu.poirier@linaro.org>, michael.roth@amd.com, berrange@redhat.com, kchamart@redhat.com, 
	pierrick.bouvier@oss.qualcomm.com, peter.maydell@linaro.org, mst@redhat.com, cohuck@redhat.com, 
	pbonzini@redhat.com, eblake@redhat.com, armbru@redhat.com, 
	lorenzo.pieralisi@linaro.org, qemu-devel@nongnu.org, qemu-arm@nongnu.org, kvm@vger.kernel.org
Subject: Re: [RFC v4 03/24] target/arm: Add confidential guest support
Message-ID: <auF8rstVcvsDUO6C@FCCLS0092175.localdomain>
References: <20260903193611.1058589-1-mathieu.poirier@linaro.org>
 <20260903193611.1058589-4-mathieu.poirier@linaro.org>
 <dhrvydsmaw22xqx5d5i5s7fdyjxupz27yxp6trv2tesysp4npj@quvzrxjvfipz>
 <arI197vJkW75p50c@lpieralisi>
 <arSTQQ5uB6oR-vFe@FCCLS0092175.localdomain>
 <ataBkrIvULJXj4v6@p14s>
 <784dfea3-24cb-4e70-ab46-b96b4b9a1831@redhat.com>
 <at-Wkw7a3Tn3Oh3M@red-moon>
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <at-Wkw7a3Tn3Oh3M@red-moon>

On 10/26 19:06, Lorenzo Pieralisi wrote:
> On Wed, Oct 21, 2026 at 11:42:14PM +1000, Gavin Shan wrote:
> > On 10/20/26 6:46 AM, Mathieu Poirier wrote:
> > > On Thu, Sep 24, 2026 at 12:12:35PM +0900, Kohei Enju wrote:
> > > > On 09/22 10:01, Lorenzo Pieralisi wrote:
> > > > > On Tue, Sep 15, 2026 at 04:27:21PM -0500, Michael Roth wrote:
> > > > > > On Thu, Sep 03, 2026 at 01:35:50PM -0600, Mathieu Poirier wrote:
> > > > > > > From: Jean-Philippe Brucker <jean-philippe@linaro.org>
> > > > > > > 
> > > > > > > Add a new RmeGuest object, inheriting from ConfidentialGuestSupport, to
> > > > > > > support the Arm Realm Management Extension (RME). It is instantiated by
> > > > > > > passing on the command-line:
> > > > > > > 
> > > > > > >    -M virt,confidential-guest-support=<id>
> > > > > > >    -object rme-guest,id=<id>
> > > > > > > 
> > > > > > > This is only the skeleton. Support will be added in following patches.
> > > > > > > 
> > > > > > > Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
> > > > > > > Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
> > > > > > > ---
> > > > > > >   docs/system/confidential-guest-support.rst |  1 +
> > > > > > >   qapi/qom.json                              | 13 +++++++
> > > > > > >   target/arm/kvm-rme.c                       | 42 ++++++++++++++++++++++
> > > > > > >   target/arm/meson.build                     |  5 ++-
> > > > > > >   4 files changed, 60 insertions(+), 1 deletion(-)
> > > > > > >   create mode 100644 target/arm/kvm-rme.c
> > > > > > > 
> > > > > > > diff --git a/docs/system/confidential-guest-support.rst b/docs/system/confidential-guest-support.rst
> > > > > > > index 562a7c3c2852..abb56923ad13 100644
> > > > > > > --- a/docs/system/confidential-guest-support.rst
> > > > > > > +++ b/docs/system/confidential-guest-support.rst
> > > > > > > @@ -42,5 +42,6 @@ Currently supported confidential guest mechanisms are:
> > > > > > >   * POWER Protected Execution Facility (PEF) (see :ref:`power-papr-protected-execution-facility-pef`)
> > > > > > >   * s390x Protected Virtualization (PV) (see :doc:`s390x/protvirt`)
> > > > > > >   * AWS Nitro Enclaves (see :doc:`nitro`)
> > > > > > > +* Arm Realm Management Extension (RME)
> > > > > > >   Other mechanisms may be supported in future.
> > > > > > > diff --git a/qapi/qom.json b/qapi/qom.json
> > > > > > > index 776b13027fd8..52997c29a32d 100644
> > > > > > > --- a/qapi/qom.json
> > > > > > > +++ b/qapi/qom.json
> > > > > > > @@ -1288,6 +1288,17 @@
> > > > > > >     'data': { '*pretty': 'bool',
> > > > > > >               '*close-action': 'MonitorQMPCloseAction' } }
> > > > > > > +##
> > > > > > > +# @RmeGuestProperties:
> > > > > > > +#
> > > > > > > +# Properties for rme-guest objects.
> > > > > > > +#
> > > > > > > +# Since: 11.1
> > > > > > > +##
> > > > > > > +{ 'struct': 'RmeGuestProperties',
> > > > > > > +  'base': 'ConfidentialGuestSupportProperties',
> > > > > > 
> > > > > > Just FYI, based on input from Markus I'm planning to drop this
> > > > > > ConfidentialGuestSupportProperties base type from my series
> > > > > > since it's probably only SNP/TDX that need to be able to switch
> > > > > > it on/off, whereas this series appears to use/require it from
> > > > > > the start.
> > > > > > 
> > > > > > I'm not exactly sure what it will look like for v3 yet, but if you
> > > > > > were based on v2 you'd instead probably just do the following in the
> > > > > > instance_init function for your rme-guest instance:
> > > > > > 
> > > > > >    cgs->allow_convert_in_place = true;
> > > > > >    cgs->convert_in_place = true;
> > > > > > 
> > > > > > rather than exposing it as a cmdline option.
> > > > > 
> > > > > Yep, it won't be an option for CCA Realms anyway since that will be
> > > > > the baseline.
> > > > 
> > > > IIUC, in-place conversion requires RAM backed by a shared/mappable
> > > > guest_memfd. If in-place conversion is always enabled for CCA Realms,
> > > > could QEMU also select the equivalent of
> > > > 
> > > >    -object memory-backend-guest-memfd,id=ram0,size=...,share=on
> > > > 
> > > > automatically for the default RAM, so that specifying the RAM size with
> > > > `-m` is sufficient?
> > > 
> > > Are you suggesting that on Arm, we completely get rid of
> > > 
> > >      -object memory-backend-guest-memfd,id=ram0,size=$(RAMSIZE),share=on
> > > 
> > > or simply to get rid of "size=$(RAMSIZE)" in the above because it is redundant
> > > with "-m $(RAMSIZE)"?
> > > 
> > > Gavin and Michael, what is your take on that suggestion?
> > > 
> > 
> > I don't think that's what Kohei meant. He actually suggested the memory backend
> > shall be pinned to memory-backend-guest-memfd and its in-place conversion shall
> > be enabled when the memory backend isn't explicitly specified by users through
> > "-object memory-backend-xxxx". For this inexplicit case, where the memory backend
> > is determined by '-mem-path', the memory backend is either TYPE_MEMORY_BACKEND_FILE
> > or TYPE_MEMORY_BACKEND_RAM. Please refer to create_default_memdev().
> > 
> > I think Kohei's suggestion makes sense. Besides, I think '-mem-path' should be
> > disallowed for CCA Realms as TYPE_MEMORY_BACKEND_FILE isn't what we want.
> 
> Kohei, what were you suggesting then please ? I think TYPE_MEMORY_BACKEND_FILE
> would not pass the checks required by Michael's v3 [0] on CCA - I will test this
> and report back but the only backend allowed, rightly, is memfd,share=on, so it
> _is_ disallowed.

Sorry for the late response.

To clarify, I meant the latter: when rme-guest is selected and the user
has not explicitly provided a memory backend, QEMU could automatically
create the default RAM as a shared guest-memfd backend.

In other words, rather than only rejecting the default file/RAM backend,
the Realm configuration could select the equivalent of

  -object memory-backend-guest-memfd,id=<default-ram-id>,size=<RAMSIZE>,share=on

by default. Explicitly specified memory backends would still need to be
validated against the Realm requirements.

My intention was that, if in-place conversion is the baseline for CCA
Realms, `-m <size>` should be sufficient for the common Realm case,
while preserving an explicit memory-backend option for users who need to
control it.

That said, I do not have a strong preference for deciding the default
`-m` behavior at this stage. If it is premature to make that decision
before the memory-backend and conversion interfaces have settled, I am
happy to keep the explicit guest-memfd backend requirement for now and
revisit the default behavior later.

Thanks,
Kohei

> 
> Lorenzo
> 
> [0] https://lore.kernel.org/kvm/20261007134323.1606088-1-michael.roth@amd.com/
> 
> > Thanks,
> > Gavin
> > 
> > > Thanks,
> > > Mathieu
> > > 
> > > > 
> > > > Thanks,
> > > > Kohei
> > > > 
> > > > > 
> > > > > Thanks,
> > > > > Lorenzo
> > > > > 
> > > > > > Thanks,
> > > > > > 
> > > > > > Mike
> > > > > > 
> > > > > > > +  'data': {} }
> > > > > > > +
> > > > > > >   ##
> > > > > > >   # @ObjectType:
> > > > > > >   #
> > > > > > > @@ -1346,6 +1357,7 @@
> > > > > > >       { 'name': 'pr-manager-helper',
> > > > > > >         'if': 'CONFIG_LINUX' },
> > > > > > >       'qtest',
> > > > > > > +    'rme-guest',
> > > > > > >       'rng-builtin',
> > > > > > >       'rng-egd',
> > > > > > >       { 'name': 'rng-random',
> > > > > > > @@ -1427,6 +1439,7 @@
> > > > > > >         'pr-manager-helper':          { 'type': 'PrManagerHelperProperties',
> > > > > > >                                         'if': 'CONFIG_LINUX' },
> > > > > > >         'qtest':                      'QtestProperties',
> > > > > > > +      'rme-guest':                  'RmeGuestProperties',
> > > > > > >         'rng-builtin':                'RngProperties',
> > > > > > >         'rng-egd':                    'RngEgdProperties',
> > > > > > >         'rng-random':                 { 'type': 'RngRandomProperties',
> > > > > > > diff --git a/target/arm/kvm-rme.c b/target/arm/kvm-rme.c
> > > > > > > new file mode 100644
> > > > > > > index 000000000000..42e1d1e7b859
> > > > > > > --- /dev/null
> > > > > > > +++ b/target/arm/kvm-rme.c
> > > > > > > @@ -0,0 +1,42 @@
> > > > > > > +/*
> > > > > > > + * QEMU Arm RME support
> > > > > > > + *
> > > > > > > + * SPDX-License-Identifier: GPL-2.0-or-later
> > > > > > > + *
> > > > > > > + * Copyright Linaro 2026
> > > > > > > + */
> > > > > > > +
> > > > > > > +#include "qemu/osdep.h"
> > > > > > > +
> > > > > > > +#include "hw/core/boards.h"
> > > > > > > +#include "hw/core/cpu.h"
> > > > > > > +#include "kvm_arm.h"
> > > > > > > +#include "migration/blocker.h"
> > > > > > > +#include "qapi/error.h"
> > > > > > > +#include "qom/object_interfaces.h"
> > > > > > > +#include "system/confidential-guest-support.h"
> > > > > > > +#include "system/kvm.h"
> > > > > > > +#include "system/runstate.h"
> > > > > > > +
> > > > > > > +#define TYPE_RME_GUEST "rme-guest"
> > > > > > > +OBJECT_DECLARE_SIMPLE_TYPE(RmeGuest, RME_GUEST)
> > > > > > > +
> > > > > > > +struct RmeGuest {
> > > > > > > +    ConfidentialGuestSupport parent_obj;
> > > > > > > +};
> > > > > > > +
> > > > > > > +OBJECT_DEFINE_SIMPLE_TYPE_WITH_INTERFACES(RmeGuest, rme_guest, RME_GUEST,
> > > > > > > +                                          CONFIDENTIAL_GUEST_SUPPORT,
> > > > > > > +                                          { TYPE_USER_CREATABLE }, { })
> > > > > > > +
> > > > > > > +static void rme_guest_class_init(ObjectClass *oc, const void *data)
> > > > > > > +{
> > > > > > > +}
> > > > > > > +
> > > > > > > +static void rme_guest_init(Object *obj)
> > > > > > > +{
> > > > > > > +}
> > > > > > > +
> > > > > > > +static void rme_guest_finalize(Object *obj)
> > > > > > > +{
> > > > > > > +}
> > > > > > > diff --git a/target/arm/meson.build b/target/arm/meson.build
> > > > > > > index 0369f96b4cc6..9d322a7aad28 100644
> > > > > > > --- a/target/arm/meson.build
> > > > > > > +++ b/target/arm/meson.build
> > > > > > > @@ -31,7 +31,10 @@ arm_common_user_system_ss.add(when: 'TARGET_AARCH64', if_true: files(
> > > > > > >   arm_common_system_ss.add(files(
> > > > > > >     'arm-qmp-cmds.c',
> > > > > > >   ))
> > > > > > > -arm_system_ss.add(when: 'CONFIG_KVM', if_true: files('hyp_gdbstub.c', 'kvm.c'))
> > > > > > > +arm_system_ss.add(when: 'CONFIG_KVM', if_true: files(
> > > > > > > +  'hyp_gdbstub.c',
> > > > > > > +  'kvm.c',
> > > > > > > +  'kvm-rme.c'))
> > > > > > >   arm_system_ss.add(when: 'CONFIG_HVF', if_true: files('hyp_gdbstub.c'))
> > > > > > >   arm_user_ss.add(files('cpu.c'))
> > > > > > > -- 
> > > > > > > 2.43.0
> > > > > > > 
> > > > > > > 
> > > 
> > 
