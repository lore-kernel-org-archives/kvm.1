Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.170
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792442776;
	b=BC7fpLDeKHsnO3nyR64momhV+ssiwHR2xaND7aRqINlVTE6J6BVGI1KaTfpzOyteBp8w
	 vWAvMQcCX3PV9jIN9Vj48Gjs6Yqtj2ylHOET3Bd+4FVSoRyjSdxAa4/6Hj3lWgNVzm/Td
	 KQou9akjgKAFI2bCXpLx9YOsyxC+dOZFqzXh7iatXcVQ+GQ38tVzBsW94t2lwAbAn99/U
	 VxdRBopsc3owO2v0SqrkGPv6+MFZuVbePIRDyqG4QfpYKXzDp8GEwyhibM0ou709qax/B
	 C4rjFkkXzkCKYQ68/86B5C5uFh5dpJaXwwHvnFPWVvYeN142SymI55Ftr8/oqXbXhrw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792442776;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=+cmecehZeDnyFMhm4HGeZeN/t9Uyu8M4slmgu4/aZVg=;
	b=VaFZZUmI9EJX9ooVVRdwKv2CGU2qG6hOuz5YwJlUVhhS+xOO0RBI6o8PPBbvVZc5t52T
	 q1i9uDerSapBUaHKoewbqW/0zFZgHSGpC98kLLt52t7E0ECOfzPykkcEPICNOTGzvbGsK
	 0T6KPssYlUA9NI/Y8vAbIp3PAN9CrQR7wof664tkDqgUeeUEj6eCh9NUeg5Puy9gv2OvU
	 QAKDeF31+5JaQSArJ8H24l4VJPU/zzfUkEt1zrhuJ3rlhB3iKL3wJPi2utdE5rhpgpzUL
	 p3a73QDqQbentKX4aRzjyJWB0ZIdPemQVLmziRfaoRwYYtzA+D549wxIG2iNhV4MlrA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linaro.org;
	spf=pass smtp.mailfrom=linaro.org;
	dkim=pass header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=vg4gwais;
	arc=none smtp.remote-ip=209.85.214.170
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48EA6606A31A
	for <kvm@vger.kernel.org>; Mon, 19 Oct 2026 20:46:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 48EA6606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=vg4gwais
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-2e915887d9dso13862645ad.1
        for <kvm@vger.kernel.org>; Mon, 19 Oct 2026 13:46:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1792442775; x=1793047575; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=+cmecehZeDnyFMhm4HGeZeN/t9Uyu8M4slmgu4/aZVg=;
        b=vg4gwais17TIiwkbMoz8atGLEQnxdvtB0CSgJHC+VCCMzBmjQuqQPy+tpcNkKRyPzZ
         QbLLaJcPOduMp0GnuxtqzhLA9fdB/6jGXix1Twc5+6hlb2SKP20VLl2fgUREYwhwLHxO
         uYZLvPdMH9Ouirf5StbVSlkn6KIdhL401FCNqssi1XjO0Sbu1B1DvL68A3QAJapRSwo5
         dmeVAfPriuFvmO5HWmgFrqQstWc0QRoSmXsRWV7P7UW6ym0N8wSA5xX6DE+AqLEatkam
         UhgUC0lNz/ZwG5znA0d3WVYGQNfRCw05o58fQrOE0UBFLKN4hpdMv6HARNNRyQ5afULv
         MI6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792442775; x=1793047575;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=+cmecehZeDnyFMhm4HGeZeN/t9Uyu8M4slmgu4/aZVg=;
        b=Fi3RNMv3OwdBhEYDILZtwHf3wb4hmLE9b12NbMVdXQSjIUnaSEvqWV7f0LuOca5IsP
         3hdVj8QHboye5J0Gxf5yG1JCDeMhoWoNW8YHNMqbR6/wnJTk9TVN9tnsLbT8XCUapz69
         HrME3zg6LmFI0mnwyf13EpKqufHRyE73WoQUPKqeJ3TVBhbW5Ua9oMvOcYWesbsmS6Ym
         L9JXZFY7xyffvcSo+47WB535sayDFwL3Y3yH10+ZC5fnlNAJ1K/FXCG+VlG0EcbpA8bk
         n9O1c4dvyUUA3teJ75sWUVOXQ80sGVlOp0w5k9vZZ41HEwCZ9O2SnkagR7tSyFfVmgip
         Ezlg==
X-Forwarded-Encrypted: i=1; AKwUvBwfdprwEFqxcpcZ0z/a/7iA3kQce2jKS7ATtH2P2j0YVy2HOrKjguHgD6xs+h1f3o7kfhk=@vger.kernel.org
X-Gm-Message-State: AFq9FYIt7v9nArAw58VedliX8qXGOs32JuGk3tKDm7a14IHgpTAR19WY
	DZAl3qUkwpIhofMuWAxTMyLKk9ITDGEpDMRRvQgBVlVa5XJMR26HqCuNmbGT9ikcHtg=
X-Gm-Gg: AYBFou3Rfe+wXYGnc30g3Zg33eW8bXFihTjZg3MI6tfoLX4/zbCvG3c19x5Qa4iFHPA
	5yCzuXiFVguMt+H4Hvk3QKzGxGvJhfcxsSyA63RbzE0qDfz0BzgbJLynnInnklhlpksoFWovOjf
	B5Zabgrom8nND8sbo7KnO8ghCK00oJVDf92O1N2tUcA2Hs6bcPbSFk/nZduv5gRCVFT9J3wir8V
	77qvXYgz3UpDacuEPEnwy+jIKftWRSiwez4+pqapgVgzOsT8AIhZ4eGbkGftEQPVK9TAk8+pE5V
	HLQZBC8rFZ24LbPkmzr7Wh29C5HPRAXiQUH+oNnp1w2FwYwTBK1q5ZnMihdy0/FLwv0EPxKxHsJ
	5ozMXIFCODpIuGzyJRu4ig9mK1gIalZEhBf+LzpfaDN+jxf/cYs9aJkUe9FOt79ahtw3BCn6N3w
	IosxwEYuNJBLxh7ALDOeaAYyyPLBQxAGo1wpXHYUTjMCt4EQCdBAgw2bHMj37VjkEBGDfgdWAQ9
	Mr9HyEw3S6dHV6uJs0PByFyG/KnE9LV50wFxVo97WkOYyBWrxI7gGOjDpo=
X-Received: by 2002:a17:902:ebc6:b0:2dd:c053:82f1 with SMTP id d9443c01a7336-2e9a69f292amr71216945ad.40.1792442775447;
        Mon, 19 Oct 2026 13:46:15 -0700 (PDT)
Received: from p14s ([2604:3d09:148c:c800:5410:6440:73bf:119f])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ea1517e4a3sm5328535ad.59.2026.10.19.13.46.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Oct 2026 13:46:14 -0700 (PDT)
Date: Mon, 19 Oct 2026 14:46:10 -0600
From: Mathieu Poirier <mathieu.poirier@linaro.org>
To: Kohei Enju <enju.kohei@fujitsu.com>, gshan@redhat.com,
	michael.roth@amd.com
Cc: Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Michael Roth <michael.roth@amd.com>, berrange@redhat.com,
	kchamart@redhat.com, pierrick.bouvier@oss.qualcomm.com,
	peter.maydell@linaro.org, mst@redhat.com, cohuck@redhat.com,
	pbonzini@redhat.com, eblake@redhat.com, armbru@redhat.com,
	lorenzo.pieralisi@linaro.org, gshan@redhat.com,
	qemu-devel@nongnu.org, qemu-arm@nongnu.org, kvm@vger.kernel.org
Subject: Re: [RFC v4 03/24] target/arm: Add confidential guest support
Message-ID: <ataBkrIvULJXj4v6@p14s>
References: <20260903193611.1058589-1-mathieu.poirier@linaro.org>
 <20260903193611.1058589-4-mathieu.poirier@linaro.org>
 <dhrvydsmaw22xqx5d5i5s7fdyjxupz27yxp6trv2tesysp4npj@quvzrxjvfipz>
 <arI197vJkW75p50c@lpieralisi>
 <arSTQQ5uB6oR-vFe@FCCLS0092175.localdomain>
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
In-Reply-To: <arSTQQ5uB6oR-vFe@FCCLS0092175.localdomain>

On Thu, Sep 24, 2026 at 12:12:35PM +0900, Kohei Enju wrote:
> On 09/22 10:01, Lorenzo Pieralisi wrote:
> > On Tue, Sep 15, 2026 at 04:27:21PM -0500, Michael Roth wrote:
> > > On Thu, Sep 03, 2026 at 01:35:50PM -0600, Mathieu Poirier wrote:
> > > > From: Jean-Philippe Brucker <jean-philippe@linaro.org>
> > > > 
> > > > Add a new RmeGuest object, inheriting from ConfidentialGuestSupport, to
> > > > support the Arm Realm Management Extension (RME). It is instantiated by
> > > > passing on the command-line:
> > > > 
> > > >   -M virt,confidential-guest-support=<id>
> > > >   -object rme-guest,id=<id>
> > > > 
> > > > This is only the skeleton. Support will be added in following patches.
> > > > 
> > > > Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
> > > > Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
> > > > ---
> > > >  docs/system/confidential-guest-support.rst |  1 +
> > > >  qapi/qom.json                              | 13 +++++++
> > > >  target/arm/kvm-rme.c                       | 42 ++++++++++++++++++++++
> > > >  target/arm/meson.build                     |  5 ++-
> > > >  4 files changed, 60 insertions(+), 1 deletion(-)
> > > >  create mode 100644 target/arm/kvm-rme.c
> > > > 
> > > > diff --git a/docs/system/confidential-guest-support.rst b/docs/system/confidential-guest-support.rst
> > > > index 562a7c3c2852..abb56923ad13 100644
> > > > --- a/docs/system/confidential-guest-support.rst
> > > > +++ b/docs/system/confidential-guest-support.rst
> > > > @@ -42,5 +42,6 @@ Currently supported confidential guest mechanisms are:
> > > >  * POWER Protected Execution Facility (PEF) (see :ref:`power-papr-protected-execution-facility-pef`)
> > > >  * s390x Protected Virtualization (PV) (see :doc:`s390x/protvirt`)
> > > >  * AWS Nitro Enclaves (see :doc:`nitro`)
> > > > +* Arm Realm Management Extension (RME)
> > > >  
> > > >  Other mechanisms may be supported in future.
> > > > diff --git a/qapi/qom.json b/qapi/qom.json
> > > > index 776b13027fd8..52997c29a32d 100644
> > > > --- a/qapi/qom.json
> > > > +++ b/qapi/qom.json
> > > > @@ -1288,6 +1288,17 @@
> > > >    'data': { '*pretty': 'bool',
> > > >              '*close-action': 'MonitorQMPCloseAction' } }
> > > >  
> > > > +##
> > > > +# @RmeGuestProperties:
> > > > +#
> > > > +# Properties for rme-guest objects.
> > > > +#
> > > > +# Since: 11.1
> > > > +##
> > > > +{ 'struct': 'RmeGuestProperties',
> > > > +  'base': 'ConfidentialGuestSupportProperties',
> > > 
> > > Just FYI, based on input from Markus I'm planning to drop this
> > > ConfidentialGuestSupportProperties base type from my series
> > > since it's probably only SNP/TDX that need to be able to switch
> > > it on/off, whereas this series appears to use/require it from
> > > the start.
> > > 
> > > I'm not exactly sure what it will look like for v3 yet, but if you
> > > were based on v2 you'd instead probably just do the following in the
> > > instance_init function for your rme-guest instance:
> > > 
> > >   cgs->allow_convert_in_place = true;
> > >   cgs->convert_in_place = true;
> > > 
> > > rather than exposing it as a cmdline option.
> > 
> > Yep, it won't be an option for CCA Realms anyway since that will be
> > the baseline.
> 
> IIUC, in-place conversion requires RAM backed by a shared/mappable
> guest_memfd. If in-place conversion is always enabled for CCA Realms,
> could QEMU also select the equivalent of
> 
>   -object memory-backend-guest-memfd,id=ram0,size=...,share=on
> 
> automatically for the default RAM, so that specifying the RAM size with
> `-m` is sufficient?

Are you suggesting that on Arm, we completely get rid of 

    -object memory-backend-guest-memfd,id=ram0,size=$(RAMSIZE),share=on

or simply to get rid of "size=$(RAMSIZE)" in the above because it is redundant
with "-m $(RAMSIZE)"?

Gavin and Michael, what is your take on that suggestion?

Thanks,
Mathieu

> 
> Thanks,
> Kohei
> 
> > 
> > Thanks,
> > Lorenzo
> > 
> > > Thanks,
> > > 
> > > Mike
> > > 
> > > > +  'data': {} }
> > > > +
> > > >  ##
> > > >  # @ObjectType:
> > > >  #
> > > > @@ -1346,6 +1357,7 @@
> > > >      { 'name': 'pr-manager-helper',
> > > >        'if': 'CONFIG_LINUX' },
> > > >      'qtest',
> > > > +    'rme-guest',
> > > >      'rng-builtin',
> > > >      'rng-egd',
> > > >      { 'name': 'rng-random',
> > > > @@ -1427,6 +1439,7 @@
> > > >        'pr-manager-helper':          { 'type': 'PrManagerHelperProperties',
> > > >                                        'if': 'CONFIG_LINUX' },
> > > >        'qtest':                      'QtestProperties',
> > > > +      'rme-guest':                  'RmeGuestProperties',
> > > >        'rng-builtin':                'RngProperties',
> > > >        'rng-egd':                    'RngEgdProperties',
> > > >        'rng-random':                 { 'type': 'RngRandomProperties',
> > > > diff --git a/target/arm/kvm-rme.c b/target/arm/kvm-rme.c
> > > > new file mode 100644
> > > > index 000000000000..42e1d1e7b859
> > > > --- /dev/null
> > > > +++ b/target/arm/kvm-rme.c
> > > > @@ -0,0 +1,42 @@
> > > > +/*
> > > > + * QEMU Arm RME support
> > > > + *
> > > > + * SPDX-License-Identifier: GPL-2.0-or-later
> > > > + *
> > > > + * Copyright Linaro 2026
> > > > + */
> > > > +
> > > > +#include "qemu/osdep.h"
> > > > +
> > > > +#include "hw/core/boards.h"
> > > > +#include "hw/core/cpu.h"
> > > > +#include "kvm_arm.h"
> > > > +#include "migration/blocker.h"
> > > > +#include "qapi/error.h"
> > > > +#include "qom/object_interfaces.h"
> > > > +#include "system/confidential-guest-support.h"
> > > > +#include "system/kvm.h"
> > > > +#include "system/runstate.h"
> > > > +
> > > > +#define TYPE_RME_GUEST "rme-guest"
> > > > +OBJECT_DECLARE_SIMPLE_TYPE(RmeGuest, RME_GUEST)
> > > > +
> > > > +struct RmeGuest {
> > > > +    ConfidentialGuestSupport parent_obj;
> > > > +};
> > > > +
> > > > +OBJECT_DEFINE_SIMPLE_TYPE_WITH_INTERFACES(RmeGuest, rme_guest, RME_GUEST,
> > > > +                                          CONFIDENTIAL_GUEST_SUPPORT,
> > > > +                                          { TYPE_USER_CREATABLE }, { })
> > > > +
> > > > +static void rme_guest_class_init(ObjectClass *oc, const void *data)
> > > > +{
> > > > +}
> > > > +
> > > > +static void rme_guest_init(Object *obj)
> > > > +{
> > > > +}
> > > > +
> > > > +static void rme_guest_finalize(Object *obj)
> > > > +{
> > > > +}
> > > > diff --git a/target/arm/meson.build b/target/arm/meson.build
> > > > index 0369f96b4cc6..9d322a7aad28 100644
> > > > --- a/target/arm/meson.build
> > > > +++ b/target/arm/meson.build
> > > > @@ -31,7 +31,10 @@ arm_common_user_system_ss.add(when: 'TARGET_AARCH64', if_true: files(
> > > >  arm_common_system_ss.add(files(
> > > >    'arm-qmp-cmds.c',
> > > >  ))
> > > > -arm_system_ss.add(when: 'CONFIG_KVM', if_true: files('hyp_gdbstub.c', 'kvm.c'))
> > > > +arm_system_ss.add(when: 'CONFIG_KVM', if_true: files(
> > > > +  'hyp_gdbstub.c',
> > > > +  'kvm.c',
> > > > +  'kvm-rme.c'))
> > > >  arm_system_ss.add(when: 'CONFIG_HVF', if_true: files('hyp_gdbstub.c'))
> > > >  
> > > >  arm_user_ss.add(files('cpu.c'))
> > > > -- 
> > > > 2.43.0
> > > > 
> > > > 
