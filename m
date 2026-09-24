Received: from esa2.hc1455-7.c3s2.iphmx.com (esa2.hc1455-7.c3s2.iphmx.com [207.54.90.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB4013D5236
	for <kvm@vger.kernel.org>; Thu, 24 Sep 2026 03:13:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=207.54.90.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790219641; cv=none; b=lXGdFuMFKV41i8JruA2ikkO735s3HGF1CF49oRSF0JDVPTbWTfBgpuIVRQ5ulMHd6IGVXXq+J5ngK3cTQQAdFhd14RyFqUzFrbamsRBBF4tBXMJAbY6lUpQE3lqOnGPcDt7pPsCUciYDAiheVWAvdRkY9m7GBUFQttijpB3p/+w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790219641; c=relaxed/simple;
	bh=3fA2nLZao8YUtLBPuNp2s2tyUKhzmCckynxw3Oi3vnQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HV7LjTZkL7vJpZ+Qn5VFUfKTpj/02L6YIkFLJ/Rdlo71PR9PcEO+ILiazYgjAJ58/9KRZDkdRqiV/tlh2YvI7wqX1S5hvBVm3LAVIbD5SrhZI2OPF9g1083S9NoB6E01FeIL4n9833QOW4BtVloUFdM0a9bYIz+Wsey5XrnL8Zc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fujitsu.com; spf=pass smtp.mailfrom=fujitsu.com; dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b=YF7yV1kR; arc=none smtp.client-ip=207.54.90.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b="YF7yV1kR"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj2;
  t=1790219640; x=1821755640;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=3fA2nLZao8YUtLBPuNp2s2tyUKhzmCckynxw3Oi3vnQ=;
  b=YF7yV1kRFHs7saqTubZpSzQNhhwFLNXe5fjNyUn6+fozDu4H5PUVyro2
   U5c9R8HiCEScB+3nsFx2a7m7qr3iqD9PKa1QQndlYqUxDj24vgndwdPhU
   3HrPIDBr4CiqkNRVcqPlVc5q9pIDxwqnf76o2YlwnnXJ8bbHcVbM2cC9J
   cQPTKrTUGavh6puO1P0OTRlemjonhZ8zECiiKWBcyD+LtZcmorEes7B0d
   4pexGXK4p88by7t27l1YbRY3YUvs4bQdzPu3sEtTdbWfchmlf0ftoxHpv
   ICcKdciDXAkrRG/aMbs6WE/RiI7v/taaUdJvOKnfVm1P0CiFx/zkRcUac
   g==;
X-CSE-ConnectionGUID: 5BzMf//yS9iwauFPcv+TTg==
X-CSE-MsgGUID: fZQSpzH0RH+9lFhdYHGfQg==
X-IronPort-AV: E=McAfee;i="6800,10657,11914"; a="255943141"
X-IronPort-AV: E=Sophos;i="6.27,119,1786978800"; 
   d="scan'208";a="255943141"
Received: from gmgwuk01.global.fujitsu.com ([172.187.114.235])
  by esa2.hc1455-7.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Sep 2026 12:12:49 +0900
Received: from az2uksmgm3.o.css.fujitsu.com (unknown [10.151.22.200])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by gmgwuk01.global.fujitsu.com (Postfix) with ESMTPS id B0800820720
	for <kvm@vger.kernel.org>; Thu, 24 Sep 2026 03:12:48 +0000 (UTC)
Received: from az2nlsmom3.fujitsu.com (unknown [10.150.26.199])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by az2uksmgm3.o.css.fujitsu.com (Postfix) with ESMTPS id 621E7C01183
	for <kvm@vger.kernel.org>; Thu, 24 Sep 2026 03:12:48 +0000 (UTC)
Received: from FCCLS0092175.localdomain (unknown [10.8.215.48])
	by az2nlsmom3.fujitsu.com (Postfix) with SMTP id 2C4451017332;
	Thu, 24 Sep 2026 03:12:41 +0000 (UTC)
Date: Thu, 24 Sep 2026 12:12:35 +0900
From: Kohei Enju <enju.kohei@fujitsu.com>
To: Lorenzo Pieralisi <lpieralisi@kernel.org>
Cc: Michael Roth <michael.roth@amd.com>, 
	Mathieu Poirier <mathieu.poirier@linaro.org>, berrange@redhat.com, kchamart@redhat.com, 
	pierrick.bouvier@oss.qualcomm.com, peter.maydell@linaro.org, mst@redhat.com, cohuck@redhat.com, 
	pbonzini@redhat.com, eblake@redhat.com, armbru@redhat.com, 
	lorenzo.pieralisi@linaro.org, gshan@redhat.com, qemu-devel@nongnu.org, qemu-arm@nongnu.org, 
	kvm@vger.kernel.org
Subject: Re: [RFC v4 03/24] target/arm: Add confidential guest support
Message-ID: <arSTQQ5uB6oR-vFe@FCCLS0092175.localdomain>
References: <20260903193611.1058589-1-mathieu.poirier@linaro.org>
 <20260903193611.1058589-4-mathieu.poirier@linaro.org>
 <dhrvydsmaw22xqx5d5i5s7fdyjxupz27yxp6trv2tesysp4npj@quvzrxjvfipz>
 <arI197vJkW75p50c@lpieralisi>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <arI197vJkW75p50c@lpieralisi>

On 09/22 10:01, Lorenzo Pieralisi wrote:
> On Tue, Sep 15, 2026 at 04:27:21PM -0500, Michael Roth wrote:
> > On Thu, Sep 03, 2026 at 01:35:50PM -0600, Mathieu Poirier wrote:
> > > From: Jean-Philippe Brucker <jean-philippe@linaro.org>
> > > 
> > > Add a new RmeGuest object, inheriting from ConfidentialGuestSupport, to
> > > support the Arm Realm Management Extension (RME). It is instantiated by
> > > passing on the command-line:
> > > 
> > >   -M virt,confidential-guest-support=<id>
> > >   -object rme-guest,id=<id>
> > > 
> > > This is only the skeleton. Support will be added in following patches.
> > > 
> > > Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
> > > Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
> > > ---
> > >  docs/system/confidential-guest-support.rst |  1 +
> > >  qapi/qom.json                              | 13 +++++++
> > >  target/arm/kvm-rme.c                       | 42 ++++++++++++++++++++++
> > >  target/arm/meson.build                     |  5 ++-
> > >  4 files changed, 60 insertions(+), 1 deletion(-)
> > >  create mode 100644 target/arm/kvm-rme.c
> > > 
> > > diff --git a/docs/system/confidential-guest-support.rst b/docs/system/confidential-guest-support.rst
> > > index 562a7c3c2852..abb56923ad13 100644
> > > --- a/docs/system/confidential-guest-support.rst
> > > +++ b/docs/system/confidential-guest-support.rst
> > > @@ -42,5 +42,6 @@ Currently supported confidential guest mechanisms are:
> > >  * POWER Protected Execution Facility (PEF) (see :ref:`power-papr-protected-execution-facility-pef`)
> > >  * s390x Protected Virtualization (PV) (see :doc:`s390x/protvirt`)
> > >  * AWS Nitro Enclaves (see :doc:`nitro`)
> > > +* Arm Realm Management Extension (RME)
> > >  
> > >  Other mechanisms may be supported in future.
> > > diff --git a/qapi/qom.json b/qapi/qom.json
> > > index 776b13027fd8..52997c29a32d 100644
> > > --- a/qapi/qom.json
> > > +++ b/qapi/qom.json
> > > @@ -1288,6 +1288,17 @@
> > >    'data': { '*pretty': 'bool',
> > >              '*close-action': 'MonitorQMPCloseAction' } }
> > >  
> > > +##
> > > +# @RmeGuestProperties:
> > > +#
> > > +# Properties for rme-guest objects.
> > > +#
> > > +# Since: 11.1
> > > +##
> > > +{ 'struct': 'RmeGuestProperties',
> > > +  'base': 'ConfidentialGuestSupportProperties',
> > 
> > Just FYI, based on input from Markus I'm planning to drop this
> > ConfidentialGuestSupportProperties base type from my series
> > since it's probably only SNP/TDX that need to be able to switch
> > it on/off, whereas this series appears to use/require it from
> > the start.
> > 
> > I'm not exactly sure what it will look like for v3 yet, but if you
> > were based on v2 you'd instead probably just do the following in the
> > instance_init function for your rme-guest instance:
> > 
> >   cgs->allow_convert_in_place = true;
> >   cgs->convert_in_place = true;
> > 
> > rather than exposing it as a cmdline option.
> 
> Yep, it won't be an option for CCA Realms anyway since that will be
> the baseline.

IIUC, in-place conversion requires RAM backed by a shared/mappable
guest_memfd. If in-place conversion is always enabled for CCA Realms,
could QEMU also select the equivalent of

  -object memory-backend-guest-memfd,id=ram0,size=...,share=on

automatically for the default RAM, so that specifying the RAM size with
`-m` is sufficient?

Thanks,
Kohei

> 
> Thanks,
> Lorenzo
> 
> > Thanks,
> > 
> > Mike
> > 
> > > +  'data': {} }
> > > +
> > >  ##
> > >  # @ObjectType:
> > >  #
> > > @@ -1346,6 +1357,7 @@
> > >      { 'name': 'pr-manager-helper',
> > >        'if': 'CONFIG_LINUX' },
> > >      'qtest',
> > > +    'rme-guest',
> > >      'rng-builtin',
> > >      'rng-egd',
> > >      { 'name': 'rng-random',
> > > @@ -1427,6 +1439,7 @@
> > >        'pr-manager-helper':          { 'type': 'PrManagerHelperProperties',
> > >                                        'if': 'CONFIG_LINUX' },
> > >        'qtest':                      'QtestProperties',
> > > +      'rme-guest':                  'RmeGuestProperties',
> > >        'rng-builtin':                'RngProperties',
> > >        'rng-egd':                    'RngEgdProperties',
> > >        'rng-random':                 { 'type': 'RngRandomProperties',
> > > diff --git a/target/arm/kvm-rme.c b/target/arm/kvm-rme.c
> > > new file mode 100644
> > > index 000000000000..42e1d1e7b859
> > > --- /dev/null
> > > +++ b/target/arm/kvm-rme.c
> > > @@ -0,0 +1,42 @@
> > > +/*
> > > + * QEMU Arm RME support
> > > + *
> > > + * SPDX-License-Identifier: GPL-2.0-or-later
> > > + *
> > > + * Copyright Linaro 2026
> > > + */
> > > +
> > > +#include "qemu/osdep.h"
> > > +
> > > +#include "hw/core/boards.h"
> > > +#include "hw/core/cpu.h"
> > > +#include "kvm_arm.h"
> > > +#include "migration/blocker.h"
> > > +#include "qapi/error.h"
> > > +#include "qom/object_interfaces.h"
> > > +#include "system/confidential-guest-support.h"
> > > +#include "system/kvm.h"
> > > +#include "system/runstate.h"
> > > +
> > > +#define TYPE_RME_GUEST "rme-guest"
> > > +OBJECT_DECLARE_SIMPLE_TYPE(RmeGuest, RME_GUEST)
> > > +
> > > +struct RmeGuest {
> > > +    ConfidentialGuestSupport parent_obj;
> > > +};
> > > +
> > > +OBJECT_DEFINE_SIMPLE_TYPE_WITH_INTERFACES(RmeGuest, rme_guest, RME_GUEST,
> > > +                                          CONFIDENTIAL_GUEST_SUPPORT,
> > > +                                          { TYPE_USER_CREATABLE }, { })
> > > +
> > > +static void rme_guest_class_init(ObjectClass *oc, const void *data)
> > > +{
> > > +}
> > > +
> > > +static void rme_guest_init(Object *obj)
> > > +{
> > > +}
> > > +
> > > +static void rme_guest_finalize(Object *obj)
> > > +{
> > > +}
> > > diff --git a/target/arm/meson.build b/target/arm/meson.build
> > > index 0369f96b4cc6..9d322a7aad28 100644
> > > --- a/target/arm/meson.build
> > > +++ b/target/arm/meson.build
> > > @@ -31,7 +31,10 @@ arm_common_user_system_ss.add(when: 'TARGET_AARCH64', if_true: files(
> > >  arm_common_system_ss.add(files(
> > >    'arm-qmp-cmds.c',
> > >  ))
> > > -arm_system_ss.add(when: 'CONFIG_KVM', if_true: files('hyp_gdbstub.c', 'kvm.c'))
> > > +arm_system_ss.add(when: 'CONFIG_KVM', if_true: files(
> > > +  'hyp_gdbstub.c',
> > > +  'kvm.c',
> > > +  'kvm-rme.c'))
> > >  arm_system_ss.add(when: 'CONFIG_HVF', if_true: files('hyp_gdbstub.c'))
> > >  
> > >  arm_user_ss.add(files('cpu.c'))
> > > -- 
> > > 2.43.0
> > > 
> > > 
