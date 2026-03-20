Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5BA4374160
	for <kvm@vger.kernel.org>; Fri, 20 Mar 2026 12:39:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774010394; cv=none; b=OMuNc0blFot+KH1uWK3BciCVBnp9UVKqtlYqhswthP/m2HST68RDcYcBtcRrLgIKBiOGcddIEJUQ/iKw8WyQcTOS5u0AWkrOIeERYHVTRRsBKtBm105aqnIXuHCERH+WluloG/W0lqYfdCZOFdyXu8aaHNLZTHaH3DUxmj5/opY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774010394; c=relaxed/simple;
	bh=ENYxOj6N7l7dQtnMpnOYPAunFUGPECnXAayXQx6kqW0=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=K5ftgLbOjogsRdTtsa+n8J8dnernQyZ7+j8l/UFvrTVQNw2BJppWiW1DreQCWHCJyKwPv7K2kB7iWDDCzOqal8hZTt9b7/J07mCyQn71x4gY9p9Py9dPX6u5s3EwsRT4jjtzHe5iVjod8Mav9+tUi8pn3HhD0ad9Tlu9/03UaQs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=BPsrXiVk; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BPsrXiVk"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1774010386;
	h=from:from:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ZBB5vm/1XcC107sWhupG4It1ndTaYPAgfGYZjS+9vfg=;
	b=BPsrXiVkQeFndM/15da3YW8Wur0IHJDrCX9Y3lyeRo3hc92Znz0TFCJT4aJWysUbie0BjJ
	0o5boqrmmGHTEl7MKjS13WdB9jepdw2BRtZ48sAtfzGUzLvKTlLXtGzezr8qINRjuMSrlS
	BrTHctWlHv/U5xLypRTJ48eEkdz694k=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-183-WrGKrPSwN6CB-YyJN06gfA-1; Fri,
 20 Mar 2026 08:39:43 -0400
X-MC-Unique: WrGKrPSwN6CB-YyJN06gfA-1
X-Mimecast-MFC-AGG-ID: WrGKrPSwN6CB-YyJN06gfA_1774010382
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id E0D0618005B2;
	Fri, 20 Mar 2026 12:39:41 +0000 (UTC)
Received: from redhat.com (unknown [10.44.33.255])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 03A0F180075B;
	Fri, 20 Mar 2026 12:39:35 +0000 (UTC)
Date: Fri, 20 Mar 2026 12:39:32 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Tommaso Califano <califano.tommaso@gmail.com>, qemu-devel@nongnu.org,
	kvm@vger.kernel.org, Eduardo Habkost <eduardo@habkost.net>,
	Markus Armbruster <armbru@redhat.com>,
	Zhao Liu <zhao1.liu@intel.com>,
	Marcelo Tosatti <mtosatti@redhat.com>,
	Eric Blake <eblake@redhat.com>,
	Oliver Steffen <osteffen@redhat.com>,
	Stefano Garzarella <sgarzare@redhat.com>,
	Giuseppe Lettieri <giuseppe.lettieri@unipi.it>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Luigi Leonardi <leonardi@redhat.com>,
	Richard Henderson <richard.henderson@linaro.org>
Subject: Re: [PATCH 1/5] i386/sev: Add sev-emulated QOM object with TCG
 support
Message-ID: <ab1ABNvEOlIc2WCU@redhat.com>
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
References: <20260317113840.33017-1-califano.tommaso@gmail.com>
 <20260317113840.33017-2-califano.tommaso@gmail.com>
 <abw3HqBJqEWiY7GP@redhat.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <abw3HqBJqEWiY7GP@redhat.com>
User-Agent: Mutt/2.2.14 (2025-02-20)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

On Thu, Mar 19, 2026 at 05:49:18PM +0000, Daniel P. Berrangé wrote:
> On Tue, Mar 17, 2026 at 12:38:36PM +0100, Tommaso Califano wrote:
> > With this change it is possible to run a VM with the SEV CPUID active
> > adding:
> > 
> >     -accel tcg \
> >     -object sev-emulated,id=sev0,cbitpos=47,reduced-phys-bits=1 \
> >     -machine memory-encryption=sev0
> 
> snip
> 
> > diff --git a/qapi/qom.json b/qapi/qom.json
> > index c653248f85..35cda819ec 100644
> > --- a/qapi/qom.json
> > +++ b/qapi/qom.json
> > @@ -1057,6 +1057,19 @@
> >              '*handle': 'uint32',
> >              '*legacy-vm-type': 'OnOffAuto' } }
> >  
> > +##
> > +# @SevEmulatedProperties:
> > +#
> > +# Properties for sev-emulated objects.
> > +# This object functionally emulates AMD SEV hardware via TCG, so
> > +# it does not require real hardware to run.
> > +#
> > +# Since: 10.1.0
> > +##
> > +{ 'struct': 'SevEmulatedProperties',
> > +  'base': 'SevGuestProperties',
> > +  'data': {}}
> 
> This is deriving 'sev-emulated' from 'sev-guest' which means it
> supports all the properties that 'sev-guest' does, which for
> the record is:
> 
>  sev-guest options:
>   dh-cert-file=<string>  - guest owners DH certificate (encoded with base64)
>   kernel-hashes=<bool>   - add kernel hashes to guest firmware for measured Linux boot
>   legacy-vm-type=<OnOffAuto> - use legacy VM type to maintain measurement compatibility with older QEMU or kernel versions.
>   session-file=<string>  - guest owners session parameters (encoded with base64)
>   sev-device=<string>    - SEV device to use

Sigh, I was mislead by  '-object sev-guest,help' omitting
information about anything that is not a class property.
So there is also

  - cbitpos=<int>
  - reduced-phys-bits=<int>
  - handle=<int>
  - policy=<int>

> 
> 
> Of those properties
> 
>  * dh-cert-file + session-file are traditionally used
>    as a means to transfer the TIK+TEK to the SEV firmware,
>    with wrapping to protect them from the hypervisor.
> 
>    These can't be used with sev-emulated, as implemented,
>    since they require a key derivation  from the PDH, a
>    concept which IIUC is not implemented in this series.
> 
>    Instead, in a later patch 'tik' and 'tek' properties
>    are added to 'sev-emulated', and to pass the TIK+TEK
>    in clear text.
> 
>  * sev-device + legacy-vm-type - these are only relevant
>    to the KVM integration, so not applicable for emulation
> 
>  * kernel-hashes - would be relevant if formally emulating
>    LAUNCH_UPDATE_DATA for attestation, but IIUC, this is
>    not done/used by this series
>   
> 
> IOW, we're deriving from 'sev-guest' but AFAICT none of
> its properties are relevant to the emulation. The
> dh-cert-file and session-file could potentially be
> relevant if implementing the PDH concept and key
> derivation, but that's not done, instead the tik/tek
> are passed explicitly.
> 
> What is the value we get from this sev-guest -> sev-emulated
> inheritance ?  My gut feeling is that this perhaps isn't
> the right way to be modelling things unless there's a plan
> for future work that would benefit from them.
> 
> Another question related to modelling is whether there is
> an intention to support SEV-SNP at a later date, would that
> imply a sev-snp-emulated object type too ? If so, would it
> inherit from sev-emulated or from sev-snp-guest ?
> 
> > +
> >  ##
> >  # @SevSnpGuestProperties:
> >  #
> > @@ -1241,6 +1254,7 @@
> >      { 'name': 'secret_keyring',
> >        'if': 'CONFIG_SECRET_KEYRING' },
> >      'sev-guest',
> > +    'sev-emulated',
> >      'sev-snp-guest',
> >      'thread-context',
> >      's390-pv-guest',
> > @@ -1318,6 +1332,7 @@
> >        'secret_keyring':             { 'type': 'SecretKeyringProperties',
> >                                        'if': 'CONFIG_SECRET_KEYRING' },
> >        'sev-guest':                  'SevGuestProperties',
> > +      'sev-emulated':               'SevEmulatedProperties',
> >        'sev-snp-guest':              'SevSnpGuestProperties',
> >        'tdx-guest':                  'TdxGuestProperties',
> >        'thread-context':             'ThreadContextProperties',
> > diff --git a/target/i386/sev.c b/target/i386/sev.c
> > index 9dde972c11..2502e860e2 100644
> > --- a/target/i386/sev.c
> > +++ b/target/i386/sev.c
> > @@ -51,6 +51,7 @@
> >  
> >  OBJECT_DECLARE_TYPE(SevCommonState, SevCommonStateClass, SEV_COMMON)
> >  OBJECT_DECLARE_TYPE(SevGuestState, SevCommonStateClass, SEV_GUEST)
> > +OBJECT_DECLARE_TYPE(SevEmulatedState, SevCommonStateClass, SEV_EMULATED)
> >  OBJECT_DECLARE_TYPE(SevSnpGuestState, SevCommonStateClass, SEV_SNP_GUEST)
> >  
> >  /* hard code sha256 digest size */
> > @@ -177,6 +178,21 @@ struct SevGuestState {
> >      OnOffAuto legacy_vm_type;
> >  };
> >  
> > +/**
> > + * SevEmulatedState:
> > + *
> > + * The SevEmulatedState object is used for creating and managing a SEV emulated
> > + * guest.
> > + *
> > + * # $QEMU \
> > + *         -object sev-emulated,id=sev0 \
> > + *         -machine ...,memory-encryption=sev0
> > + */
> > +
> > +typedef struct SevEmulatedState {
> > +    SevGuestState parent_obj;
> > +} SevEmulatedState;
> > +
> >  struct SevSnpGuestState {
> >      SevCommonState parent_obj;
> >  
> > @@ -2936,6 +2952,46 @@ sev_guest_instance_init(Object *obj)
> >      sev_guest->legacy_vm_type = ON_OFF_AUTO_AUTO;
> >  }
> >  
> > +static int sev_emulated_init(ConfidentialGuestSupport *cgs, Error **errp)
> > +{
> > +    SevCommonState *sev_common = SEV_COMMON(cgs);
> > +
> > +    /*
> > +     * The cbitpos value will be placed in bit positions 5:0 of the EBX
> > +     * register of CPUID 0x8000001F. We need to verify the range as the
> > +     * comparison with the host cbitpos is missing.
> > +     */
> > +    if (sev_common->cbitpos < 32 ||
> > +        sev_common->cbitpos > 63) {
> > +        error_setg(errp, "%s: cbitpos check failed, requested '%d',"
> > +                   "the firmware requires >=32",
> > +                   __func__, sev_common->cbitpos);
> > +        return -1;
> > +    }
> > +
> > +    /*
> > +     * The reduced-phys-bits value will be placed in bit positions 11:6 of
> > +     * the EBX register of CPUID 0x8000001F, so verify the supplied value
> > +     * is in the range of 1 to 63.
> > +     */
> > +    if (sev_common->reduced_phys_bits < 1 ||
> > +        sev_common->reduced_phys_bits > 63) {
> > +        error_setg(errp, "%s: reduced_phys_bits check failed,"
> > +                   " it should be in the range of 1 to 63, requested '%d'",
> > +                   __func__, sev_common->reduced_phys_bits);
> > +        return -1;
> > +    }
> > +    cgs->ready = true;
> > +    return 0;
> > +}
> > +
> > +static void sev_emulated_class_init(ObjectClass *oc, const void *data)
> > +{
> > +    ConfidentialGuestSupportClass *klass = CONFIDENTIAL_GUEST_SUPPORT_CLASS(oc);
> > +    /* Override the sev-common method that uses kvm */
> > +    klass->kvm_init = sev_emulated_init;
> > +}
> > +
> >  /* guest info specific sev/sev-es */
> >  static const TypeInfo sev_guest_info = {
> >      .parent = TYPE_SEV_COMMON,
> > @@ -2945,6 +3001,14 @@ static const TypeInfo sev_guest_info = {
> >      .class_init = sev_guest_class_init,
> >  };
> >  
> > +/* emulated sev */
> > +static const TypeInfo sev_emulated_info = {
> > +    .parent = TYPE_SEV_GUEST,
> > +    .name = TYPE_SEV_EMULATED,
> > +    .instance_size = sizeof(SevEmulatedState),
> > +    .class_init = sev_emulated_class_init
> > +};
> > +
> >  static void
> >  sev_snp_guest_get_policy(Object *obj, Visitor *v, const char *name,
> >                           void *opaque, Error **errp)
> > @@ -3207,6 +3271,7 @@ static void
> >  sev_register_types(void)
> >  {
> >      type_register_static(&sev_common_info);
> > +    type_register_static(&sev_emulated_info);
> >      type_register_static(&sev_guest_info);
> >      type_register_static(&sev_snp_guest_info);
> >  }
> > diff --git a/target/i386/sev.h b/target/i386/sev.h
> > index 4358df40e4..839656e2be 100644
> > --- a/target/i386/sev.h
> > +++ b/target/i386/sev.h
> > @@ -33,6 +33,7 @@ bool sev_snp_enabled(void);
> >  #if !defined(CONFIG_USER_ONLY)
> >  
> >  #define TYPE_SEV_COMMON "sev-common"
> > +#define TYPE_SEV_EMULATED "sev-emulated"
> >  #define TYPE_SEV_GUEST "sev-guest"
> >  #define TYPE_SEV_SNP_GUEST "sev-snp-guest"
> >  
> > -- 
> > 2.53.0
> > 
> 
> With regards,
> Daniel
> -- 
> |: https://berrange.com       ~~        https://hachyderm.io/@berrange :|
> |: https://libvirt.org          ~~          https://entangle-photo.org :|
> |: https://pixelfed.art/berrange   ~~    https://fstop138.berrange.com :|
> 
> 

With regards,
Daniel
-- 
|: https://berrange.com       ~~        https://hachyderm.io/@berrange :|
|: https://libvirt.org          ~~          https://entangle-photo.org :|
|: https://pixelfed.art/berrange   ~~    https://fstop138.berrange.com :|

