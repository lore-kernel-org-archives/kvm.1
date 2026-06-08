Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1AF73BB699
	for <kvm@vger.kernel.org>; Mon,  8 Jun 2026 10:40:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780915263; cv=none; b=UK3p9ai/3MYrESBhITbWoc7FkwTYIZjBcf3xWdSnfQrV/CviGQ4pn011v+K+l+NAaueosF0rZtFSnwO75sg7dH5lZorBvrT9ZvJMb/Q08fbNgMMN0YNn59wjwBhQPTbCDBoJwT5en/0ctFThwPYyZ8G/NK7S6E24RDPgl1qZDJQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780915263; c=relaxed/simple;
	bh=JD9fUQVci+81lqibSrxXM9acH+oug0NqjH+343KEOSo=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=J41DH/i1rX3X1x8ZD8glvVeC6rdRh5Zwsp2607A71OeMx5/3s7/Mg7SFRzk96AYASuoMv1moMwh1Lq+wWTxCo/lgcGkgKmgRoeF4vwY2qGSFl5jqMbyVMpsIgFUkeH3fCIGw13Xxeax7ESRTE/pyv4D9aSvBespTDQHtv29fLvk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Ms0l32XM; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Ms0l32XM"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1780915257;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 resent-to:resent-from:resent-message-id:in-reply-to:in-reply-to:
	 references:references; bh=KlDnfxYYPLOvgN18u8kIO2tpUHCLrwNedDslwD8Ss8c=;
	b=Ms0l32XMt6IQnYquzp0ishDF0It39YXuINkBRYseI034N8czGwZcAkjIAm6pP7MlVuanE5
	CmjYNqFqSQ/TWTNXZG3JrY8+n0SOLQm6QbpcqGZbKbyUbN7wuK3z1Psp7J33nh30w9jJQs
	1S9XLhDzC1ootSh/tVY3QYimkPsqOi8=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-652-IbCLl7wwMnikwVmcOSXs6w-1; Mon,
 08 Jun 2026 06:40:56 -0400
X-MC-Unique: IbCLl7wwMnikwVmcOSXs6w-1
X-Mimecast-MFC-AGG-ID: IbCLl7wwMnikwVmcOSXs6w_1780915255
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 214D1195608D;
	Mon,  8 Jun 2026 10:40:55 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.44.22.28])
	by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 65DA3765;
	Mon,  8 Jun 2026 10:40:54 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
	id 0405D21E6A01; Mon, 08 Jun 2026 12:40:52 +0200 (CEST)
Resent-To: ashish.kalra@amd.com, michael.roth@amd.com, pankaj.gupta@amd.com,
 ackerleytng@google.com, isaku.yamahata@intel.com, xiaoyao.li@intel.com,
 david@kernel.org, chao.p.peng@linux.intel.com, qemu-devel@nongnu.org,
 kvm@vger.kernel.org
Resent-From: Markus Armbruster <armbru@redhat.com>
Resent-Date: Mon, 08 Jun 2026 12:40:51 +0200
Resent-Message-ID: <87qzmhiabw.fsf@pond.sub.org>
From: Markus Armbruster <armbru@redhat.com>
To: Michael Roth <michael.roth@amd.com>
Cc: <qemu-devel@nongnu.org>,  <kvm@vger.kernel.org>,  <pbonzini@redhat.com>,
  <berrange@redhat.com>,  <pankaj.gupta@amd.com>,
  <isaku.yamahata@intel.com>,  <xiaoyao.li@intel.com>,
  <chao.p.peng@linux.intel.com>,  <david@kernel.org>,
  <ashish.kalra@amd.com>,  <ackerleytng@google.com>
Subject: Re: [PATCH RFC 04/12] accel/kvm: Add CGS option to control in-place
 conversion support
In-Reply-To: <bhawvkft4dhs6aq7jcajyf2zqk2fo6rta37jwit45l3z2txmh2@3yav2up5cthy>
	(Michael Roth's message of "Wed, 3 Jun 2026 01:39:26 -0500")
References: <20260528000416.8161-1-michael.roth@amd.com>
	<20260528000416.8161-5-michael.roth@amd.com>
	<87wlwh5p0z.fsf@pond.sub.org>
	<bhawvkft4dhs6aq7jcajyf2zqk2fo6rta37jwit45l3z2txmh2@3yav2up5cthy>
Date: Mon, 08 Jun 2026 10:15:41 +0200
Message-ID: <87zf15la6q.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.6 on 10.30.177.95

Michael Roth <michael.roth@amd.com> writes:

> On Tue, Jun 02, 2026 at 10:23:40AM +0200, Markus Armbruster wrote:
>> Michael Roth <michael.roth@amd.com> writes:
>> 
>> > For confidential guests, guest_memfd is currently used only for private
>> > guest memory, and normal guest memory comes from the configured memory
>> > backend just as it does for a non-confidential guest. It is now possible
>> > to use the same physical memory to back a particular GPA regardless of
>> > whether it is in a shared or private state. This avoids the need to
>> > rely on discarding memory between shared/private conversions (to avoid
>> > doubled memory usage), and is intended to be the primary mode of using
>> > guest_memfd for confidential guests moving forward, and future features
>> > like hugepage support will likely require it.
>> >
>> > Add an option to enable this support. Since ConfidentialGuestSupport is
>> > already used to track some guest_memfd-related functionality (e.g.
>> > whether it is required for the configured machine), similarly introduce
>> > this option as a property of ConfidentialGuestSupport.
>> >
>> > Also add the KVM-specific checks to enable this support, but leave the
>> > option disabled until other required changes are implemented for
>> > CGS variants that intend to make use of KVM's in-place conversion
>> > support.
>> >
>> > Signed-off-by: Michael Roth <michael.roth@amd.com>
>> 
>> [...]
>> 
>> > diff --git a/qapi/qom.json b/qapi/qom.json
>> > index 502fafeb15..037c078799 100644
>> > --- a/qapi/qom.json
>> > +++ b/qapi/qom.json
>> > @@ -1014,6 +1014,21 @@
>> >    'if': 'CONFIG_IGVM',
>> >    'data': { 'file': 'str' } }
>> >  
>> > +##
>> > +# @ConfidentialGuestSupportProperties:
>> > +#
>> > +# Properties for ConfidentialGuestSupport base class.
>> > +#
>> > +# @convert-in-place: If true, the same physical pages are reused
>> > +#     when memory is converted between shared and private states.
>> > +#     If false (default), separate allocations are used depending
>> > +#     on whether the page is private or shared.
>> > +#
>> > +# Since: 11.1
>> > +##
>> > +{ 'struct': 'ConfidentialGuestSupportProperties',
>> > +  'data': { '*convert-in-place': 'bool' } }
>> > +
>> >  ##
>> >  # @SevCommonProperties:
>> >  #
>> > @@ -1038,6 +1053,7 @@
>> >  # Since: 9.1
>> >  ##
>> >  { 'struct': 'SevCommonProperties',
>> > +  'base': 'ConfidentialGuestSupportProperties',
>> >    'data': { '*sev-device': 'str',
>> >              '*cbitpos': 'uint32',
>> >              'reduced-phys-bits': 'uint32',
>> 
>> Why use a base type instead of simply adding @convert-in-place to
>> SevCommonProperties?
>> 
>
> My thinking was that TDX and other implementations would similarly enable
> this through their CGS implementation, so I went ahead and carved out a
> set of common properties that ConfidentialGuestSupport implementations
> could use the same ,convert-in-place=true option (or set it by default
> for newer implementations)

How confident are we in future reuse by TDX and others?

If there are doubts, refactoring for reuse when reuse happens would be
smarter.  The refactoring would be a bit of churn, but not all that
much.

If it's something like "pretty much inevitable", preparing the reuse now
saves us that churn, and makes sense.

Judgement call, i.e. you decide.

> It is sort of tied to the 'allow_convert_in_place' flag that is part of
> the common ConfidentialGuestSupport object struct, so the property
> handling is sort of tied to the common ConfidentialGuestSupport base
> class as well rather than something implementation-specific.

Valid point.  Not sure how much weight to assign to it, though.

> Not sure if there are better ways to handle all that though.

Work your rationale into the commit message, please.

