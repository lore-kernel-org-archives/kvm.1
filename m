Received: from mail-pj2-f13.google.com (mail-pj2-f13.google.com [74.125.227.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD0F251CF44
	for <kvm@vger.kernel.org>; Wed, 30 Sep 2026 21:28:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790803701; cv=none; b=mbpWHlkv1w9cN6UNwUsB1UzJApTHWE6vq7rPytPHzvyyhHKSZiVLhzFDhuSx2RUQaaVapzcZJaYNQTbf9ZduKhiLgWBOvfYbxoMkz6hNeFLNSaYoHfTF8wYe4MgqMzPxDmdv7OoD6P+McCpPv/paYQLvdx1JTDvFnlW/XQo5Qdk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790803701; c=relaxed/simple;
	bh=ugLZ1mG5fZZcEqz1CTKokpImGYFfit8FsjYOdp9dUKo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nblPzJ3IMiK3jPB4Rmp8z3BCKXfJVVExrUo65a7ZQ77ccHdI/9+cAsVs2k1r4zRbAANFqhPaUf7Cr5Xaes1Yxnj0T7ClDx4U3AUGXNn92Jc3B9SkSXWrfW2EivwlPC6TV+qiGsh9Fj9tj8V76bdDumsUTBOFT8f82cu8UgbmdK4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=BDIvJnCL; arc=none smtp.client-ip=74.125.227.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="BDIvJnCL"
Received: by mail-pj2-f13.google.com with SMTP id 98e67ed59e1d1-396ccd66bb4so2701837a91.1
        for <kvm@vger.kernel.org>; Wed, 30 Sep 2026 14:28:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1790803699; x=1791408499; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=MwEzyUNOr27ZMDBP+RFezFt1qNZElj+swSdeoVzKmfw=;
        b=BDIvJnCLKygD8WeSYgduXME7SCT4kGeW9Puw88WqUFKlw64TAJ80sx/AoYnDTvJEJK
         77ujcXSfHsTDGXUMhZSIeot0XD6rRBCouR7Sc2XZnxnfZbnT+uSeVzLWjfMNIZEY0o6p
         jSPXyXKK+tR0lDlvQpBWDJ3c005VI28oGnbosgiUv1ZE6s9t9etxw60kVddK8ovvjKQ1
         DG6gp+6MLSQKmBSBou7nzHk5gBt1g6Ok9/kv8/6HMgFg4igsKH3pTnRmvqDaMnGi0mtb
         aQeNeCUho/pm4FhWni53OWxL4cLxQ/jWWeH78+z6/CaO0HDQ9dptFRJiA2Rx/dQdf0Td
         4UvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790803699; x=1791408499;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=MwEzyUNOr27ZMDBP+RFezFt1qNZElj+swSdeoVzKmfw=;
        b=VHiSRJJjKTGvJviV1qk+yhAPzKPza1kcLgG1EVZ1W/+RSi7him2XAdLB7FsYIZhKDf
         pTL6FcvPY0B9fr6fGtAfkfeWYMUr2n2vbtxcivZeMbmWhDpE0D4t+LGBGXdYLLyHTwG2
         ta4dxOVAD3C53orreqy/Sj4FC4afVECcSBBBdDlNyse7nwvDJPSZXEahq84P0jToCUbG
         38+jutOt6bVML0bB/9e0K/asilqeB/mL4qMuhSDA9SpNU9YIA5dGjk5Au7KDd9QUx5nd
         cos/AeqXTtPZY3NbxxBTnUHfN0w4QvT47BbA0KHW93GFQtAHCC4jtJEMKmoUvgb0TrRp
         E8CA==
X-Forwarded-Encrypted: i=1; AKwUvByLb95XhM9ITz/SdThfYJwb4osimmg3PbOoobVdV4LUj7e1Cw2krkoUeuPJTfp4UNs4JPc=@vger.kernel.org
X-Gm-Message-State: AFq9FYLV83Mg8uY08X7KlSAt4fBNt/p0acMiOzo3VQDg9/LNn+rpSl0X
	uuWhngcAt+og+H1H/bp8lIA4OX1mvq/TyHzGa6WuTc406tnh+gBRWDTwAL3HDIHK3x/ruPmI5q0
	BH1Uc
X-Gm-Gg: AYBFou1fpEhD1olwZiGyyllNALGW9bkUO9t7IYwPt4Vj0doz0hSzgRsCCLVcXWZQWHA
	Jq8W9W7qyg/ucNxW4TqBNHhcnDra1clmecTI4WNQZu3af7WC5czCq0f/MdnLpuzHScvbo8DmhE8
	4mxlpWHWCNxxoTkjozsaZ4gOVVRlpHsTg1SECBDyJGteBkWdClQZJvv/qkOykJ23cxdnIO9YQgM
	aozUc607XMCeXoS9zSj03KKu3eRlAwgPfk3KEClJUWey2TKiLSu+9AD4Z0ofDnHJ8TwCimrCDNc
	hSIoakOi8rOEAtec0hc5XpWULNknc9hbPVFuxXzgwIMRkJ6ts8N4KxJQiB48uIW0Mz3tu9XvbVD
	JierHMKSdcGVvaPbIPJOketDsLCfoGPG2YgmGiOIymgKqHOE9MUh99fgymYs7piqkvc74Qs6Vf7
	69LoO2yT53f4I2aAUSsHRxH/vRIowhiYbY6AxL4wS0uNTx66TCYP5mbyOGDIJk//KYNOAWiUTj
X-Received: by 2002:a17:90b:2681:b0:3a0:9640:8028 with SMTP id 98e67ed59e1d1-3a4f931c875mr254245a91.59.1790803698766;
        Wed, 30 Sep 2026 14:28:18 -0700 (PDT)
Received: from p14s ([2604:3d09:148c:c800:f5b4:4d0e:70d:9fba])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2e306c3cb2csm192855ad.83.2026.09.30.14.28.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Sep 2026 14:28:18 -0700 (PDT)
Date: Wed, 30 Sep 2026 15:28:14 -0600
From: Mathieu Poirier <mathieu.poirier@linaro.org>
To: Kohei Enju <enju.kohei@fujitsu.com>
Cc: Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Michael Roth <michael.roth@amd.com>, berrange@redhat.com,
	kchamart@redhat.com, pierrick.bouvier@oss.qualcomm.com,
	peter.maydell@linaro.org, mst@redhat.com, cohuck@redhat.com,
	pbonzini@redhat.com, eblake@redhat.com, armbru@redhat.com,
	lorenzo.pieralisi@linaro.org, gshan@redhat.com,
	qemu-devel@nongnu.org, qemu-arm@nongnu.org, kvm@vger.kernel.org
Subject: Re: [RFC v4 03/24] target/arm: Add confidential guest support
Message-ID: <ar1-7iyCq8Re3htU@p14s>
References: <20260903193611.1058589-1-mathieu.poirier@linaro.org>
 <20260903193611.1058589-4-mathieu.poirier@linaro.org>
 <dhrvydsmaw22xqx5d5i5s7fdyjxupz27yxp6trv2tesysp4npj@quvzrxjvfipz>
 <arI197vJkW75p50c@lpieralisi>
 <arSTQQ5uB6oR-vFe@FCCLS0092175.localdomain>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
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
>

I'm almost done crafting a new revision that will be based on V20 of the KVM
patchset.  I will look into your request for the revision after this one.
 
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
