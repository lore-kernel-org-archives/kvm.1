Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793111801;
	b=opDHoXFdLPsBvtFISvhLRIfWEGyuzbzmmHJHhKcle0/lAO8CbMI0q/XOCLlMuxuCzTPl
	 jJqDtxebPO9MlxVSQL7iBJY4q3OqrjX58gEYEUYkqaWeAQAAPR8OA2XkIGna5CN5VonEB
	 sj8WPG5W3Za0r02shgTyVOmGgnE3GM9XNrQo6xzP8vYgUF4DmgTtwhrQfS1r3DGLgGOwt
	 ucXIX6cAmP4UtGrFXlDx0PR5Oz45q8lFfD3RvBTslWJEtCUg/InhIs3LfqZNOrzUrmY2m
	 /a9vKSKPDalvOPH6lspNE+1EW6z/BtoHOivll470BBZCKc5j954UeTVKZSXUcfff3ig==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793111801;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=JGMA7ndsKLYu7/BJrUVeYn2MGUZmeguc8oPK59FGqss=;
	b=nl0fNxynhrHVxtrHC1FL1XM82XxjBeOGtuRxpY30I5+RZAfJhi9DXcdfgAX9bzD98RGT
	 tRdFHfiPUsYB9lYtHv1uBPkGwnIsS8QH2dxhgFkY89EZGsnBWz5rF+rFMNfvZ4Rq4f5DX
	 I70W/Z1MnzWe10tVXq+ElJYxk/AeQ05N+aJl7l6FpNQvw0Td1exQmayMIyYWFM5/ISZXZ
	 Lcs5c4lHMhgRgytr5cgdSKXfIoqqMHma3mNXfwZ3RMjCxGbn4Jwi0+QaQS5eAbLSr3KGE
	 s9324QarqVOnBJRLWu1AGWWUr/S+PJZVj4JN4MRSCRw9GvD7BXeiUB9BQUKPbce4Zdw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=NyP8Lr2z;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABD0F606A321
	for <kvm@vger.kernel.org>; Tue, 27 Oct 2026 14:36:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=NyP8Lr2z
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5D2271F01825;
	Tue, 27 Oct 2026 14:36:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793111800;
	bh=JGMA7ndsKLYu7/BJrUVeYn2MGUZmeguc8oPK59FGqss=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=NyP8Lr2ztB0qXFIVfWxs4i77kAyWViEEcm5U7CxheXbwwXWc6N1V+LbxaMrBCd7oI
	 svTHzmjfzQRFMIq1d0vfm3lpUyO+rE0GECYadHCCGcNZCcGfKbzvgW0qVZc6iXFE7y
	 OtSh1opavp2ge3SmbNs+rTCgS0vGOJmi2WF45yBv/jCE+WHwaCznSsdf4QtBu3I3cP
	 kQYurdb2zE11TN19zvy1BEJ360p6LiMUwzSxL6+htFFgwsgCljLZB0aW+1WX1qnD8J
	 DF+3kvJp1jsH1p4IP7yCCTezYZvmFAee32hJvr8ofeYl9nurSmEJWcmKmuwJE3eGgO
	 INErjl8v/jwKA==
Date: Tue, 27 Oct 2026 15:36:33 +0100
From: Lorenzo Pieralisi <lpieralisi@kernel.org>
To: Michael Roth <michael.roth@amd.com>
Cc: Mathieu Poirier <mathieu.poirier@linaro.org>,
	Kohei Enju <enju.kohei@fujitsu.com>, gshan@redhat.com,
	berrange@redhat.com, kchamart@redhat.com,
	pierrick.bouvier@oss.qualcomm.com, peter.maydell@linaro.org,
	mst@redhat.com, cohuck@redhat.com, pbonzini@redhat.com,
	eblake@redhat.com, armbru@redhat.com, lorenzo.pieralisi@linaro.org,
	qemu-devel@nongnu.org, qemu-arm@nongnu.org, kvm@vger.kernel.org
Subject: Re: [RFC v4 03/24] target/arm: Add confidential guest support
Message-ID: <auC28TE3QWlU0Pcm@red-moon>
References: <20260903193611.1058589-1-mathieu.poirier@linaro.org>
 <20260903193611.1058589-4-mathieu.poirier@linaro.org>
 <dhrvydsmaw22xqx5d5i5s7fdyjxupz27yxp6trv2tesysp4npj@quvzrxjvfipz>
 <arI197vJkW75p50c@lpieralisi>
 <arSTQQ5uB6oR-vFe@FCCLS0092175.localdomain>
 <ataBkrIvULJXj4v6@p14s>
 <atdKSwvu_uldqwlz@red-moon>
 <atekhR1Wz03nUCHB@p14s>
 <fgmu2cuxx2n2cuxqeotas2iu43jk7aou3hldhw4757x4jyv6np@snsceczzajcy>
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
In-Reply-To: <fgmu2cuxx2n2cuxqeotas2iu43jk7aou3hldhw4757x4jyv6np@snsceczzajcy>

On Tue, Oct 20, 2026 at 01:12:45PM -0500, Michael Roth wrote:
> On Tue, Oct 20, 2026 at 11:27:33AM -0600, Mathieu Poirier wrote:
> > On Tue, Oct 20, 2026 at 01:02:35PM +0200, Lorenzo Pieralisi wrote:
> > > On Mon, Oct 19, 2026 at 02:46:10PM -0600, Mathieu Poirier wrote:
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
> > > > > > > >   -M virt,confidential-guest-support=<id>
> > > > > > > >   -object rme-guest,id=<id>
> > > > > > > > 
> > > > > > > > This is only the skeleton. Support will be added in following patches.
> > > > > > > > 
> > > > > > > > Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
> > > > > > > > Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
> > > > > > > > ---
> > > > > > > >  docs/system/confidential-guest-support.rst |  1 +
> > > > > > > >  qapi/qom.json                              | 13 +++++++
> > > > > > > >  target/arm/kvm-rme.c                       | 42 ++++++++++++++++++++++
> > > > > > > >  target/arm/meson.build                     |  5 ++-
> > > > > > > >  4 files changed, 60 insertions(+), 1 deletion(-)
> > > > > > > >  create mode 100644 target/arm/kvm-rme.c
> > > > > > > > 
> > > > > > > > diff --git a/docs/system/confidential-guest-support.rst b/docs/system/confidential-guest-support.rst
> > > > > > > > index 562a7c3c2852..abb56923ad13 100644
> > > > > > > > --- a/docs/system/confidential-guest-support.rst
> > > > > > > > +++ b/docs/system/confidential-guest-support.rst
> > > > > > > > @@ -42,5 +42,6 @@ Currently supported confidential guest mechanisms are:
> > > > > > > >  * POWER Protected Execution Facility (PEF) (see :ref:`power-papr-protected-execution-facility-pef`)
> > > > > > > >  * s390x Protected Virtualization (PV) (see :doc:`s390x/protvirt`)
> > > > > > > >  * AWS Nitro Enclaves (see :doc:`nitro`)
> > > > > > > > +* Arm Realm Management Extension (RME)
> > > > > > > >  
> > > > > > > >  Other mechanisms may be supported in future.
> > > > > > > > diff --git a/qapi/qom.json b/qapi/qom.json
> > > > > > > > index 776b13027fd8..52997c29a32d 100644
> > > > > > > > --- a/qapi/qom.json
> > > > > > > > +++ b/qapi/qom.json
> > > > > > > > @@ -1288,6 +1288,17 @@
> > > > > > > >    'data': { '*pretty': 'bool',
> > > > > > > >              '*close-action': 'MonitorQMPCloseAction' } }
> > > > > > > >  
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
> > > > > > >   cgs->allow_convert_in_place = true;
> > > > > > >   cgs->convert_in_place = true;
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
> > > > >   -object memory-backend-guest-memfd,id=ram0,size=...,share=on
> > > > > 
> > > > > automatically for the default RAM, so that specifying the RAM size with
> > > > > `-m` is sufficient?
> > > > 
> > > > Are you suggesting that on Arm, we completely get rid of 
> > > 
> > > Nit: obviously on Arm rme-guest configs.
> > 
> > Indeed.
> > 
> > > 
> > > >     -object memory-backend-guest-memfd,id=ram0,size=$(RAMSIZE),share=on
> > > 
> > > If that's what we want to make a default, I guess we ought to override
> > > create_default_memdev for arm machines + rme-guest configs ?
> > > 
> > > Pros and cons ? I am not sure how well received is setting implicit defaults
> > > for specific machine configs and what that really buys us eventually.
> > 
> > I agree, this entails a fair amount of changes for cosmetic gains only.
> 
> I think it will also add some uneccessary confusion. For instance, based
> on Paolo's feedback[1], we will likely not expose any sort of option to

I think that [1] is:

https://lore.kernel.org/kvm/866179b6-8303-4c30-aa59-005fa4554362@redhat.com

for completeness.

> switch between in-place/out-of-place conversion for SNP/TDX, but instead
> just use whatever mode the KVM module was actually configured to use.
> 
> For in-place conversion, it actually doesn't seem too bad to hook into
> create_default_memdev to have it default to memory-backend-memfd.
> However, currently, it used backend-file/backend-ram depending on other

"it used" - can I ask what "it" refers to please ?

> options, and those options are applicable to out-of-place conversion as
> well where e.g. maybe the user wants to use file-backed hugetlb memory
> for their shared memory. So we wouldn't want to change the behavior for
> out-of-place.

So, here you are saying that basically a sensible default for out-of-place
might not work for convert-in-place and therefore it does not make much
sense to have a default that does/doesn't work depending on how KVM is
configured.

> But then, for in-place, if we default to a different backend then stuff
> like mem-path=... parameters for out-of-place invocations will then
> become silently ignored, or we will need to generate an error for those,
> which works against the idea of having a common cmdline that "just
> works" for in-place/out-of-place.

Yes that makes sense.

> If we (users, management/libvirt, etc.) consolidate around specifying the
> memfd backend for confidential VMs, then we can have a "default" that is
> more consistent between in-place vs. out-of-place, which i think is more
> beneficial than trying to consolidate around a syntacticly simpler
> cmdline that might not behave as expected when switching between
> older/newer kernels which may or may not have in-place support.

Can you elaborate on this Michael please ? In particular in relation to a more
consistent "default" for in-place/out-of-place, are you referring to defining
a -object memfd option that works for both in-place and out-of-place ? Isn't
that the case already with your latest v3 (and the VMM detecting the KVM
underlying config ie in-place vs out-of-place) ?

> So, a longwinded "I agree" from me as well.
> 
> Thanks,
> 
> Mike

Thanks,
Lorenzo

> > 
> > > 
> > > > or simply to get rid of "size=$(RAMSIZE)" in the above because it is redundant
> > > > with "-m $(RAMSIZE)"?
> > > > 
> > > > Gavin and Michael, what is your take on that suggestion?
> > > 
> > > Yes please any feedback on this is welcome.
> > > 
> > > Thanks,
> > > Lorenzo
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
> > > > > > > >  ##
> > > > > > > >  # @ObjectType:
> > > > > > > >  #
> > > > > > > > @@ -1346,6 +1357,7 @@
> > > > > > > >      { 'name': 'pr-manager-helper',
> > > > > > > >        'if': 'CONFIG_LINUX' },
> > > > > > > >      'qtest',
> > > > > > > > +    'rme-guest',
> > > > > > > >      'rng-builtin',
> > > > > > > >      'rng-egd',
> > > > > > > >      { 'name': 'rng-random',
> > > > > > > > @@ -1427,6 +1439,7 @@
> > > > > > > >        'pr-manager-helper':          { 'type': 'PrManagerHelperProperties',
> > > > > > > >                                        'if': 'CONFIG_LINUX' },
> > > > > > > >        'qtest':                      'QtestProperties',
> > > > > > > > +      'rme-guest':                  'RmeGuestProperties',
> > > > > > > >        'rng-builtin':                'RngProperties',
> > > > > > > >        'rng-egd':                    'RngEgdProperties',
> > > > > > > >        'rng-random':                 { 'type': 'RngRandomProperties',
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
> > > > > > > >  arm_common_system_ss.add(files(
> > > > > > > >    'arm-qmp-cmds.c',
> > > > > > > >  ))
> > > > > > > > -arm_system_ss.add(when: 'CONFIG_KVM', if_true: files('hyp_gdbstub.c', 'kvm.c'))
> > > > > > > > +arm_system_ss.add(when: 'CONFIG_KVM', if_true: files(
> > > > > > > > +  'hyp_gdbstub.c',
> > > > > > > > +  'kvm.c',
> > > > > > > > +  'kvm-rme.c'))
> > > > > > > >  arm_system_ss.add(when: 'CONFIG_HVF', if_true: files('hyp_gdbstub.c'))
> > > > > > > >  
> > > > > > > >  arm_user_ss.add(files('cpu.c'))
> > > > > > > > -- 
> > > > > > > > 2.43.0
> > > > > > > > 
> > > > > > > > 
