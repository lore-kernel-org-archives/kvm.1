Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91AD43AA4EA
	for <kvm@vger.kernel.org>; Fri, 20 Mar 2026 12:40:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774010436; cv=none; b=EkTXEShYXIw2S3kUdiN6oDzzoF70BEoGpwBe031R/lT4b30NDYK/hJRAyfrPJmiFYMx7pPHLmv2aNXjpDpCkcbhJoe/fxuswg8Ow9Sb+EYW0cEg6hQoe4yGwcI5zSckjlgCklFRwpWCnHAIm2iEDa6lZ0eqtL1/fFz8E8xikQVo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774010436; c=relaxed/simple;
	bh=Lr1O2roT7t23vFGzaWJss6cbbH3ZLB75+4gXk7bXxCo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bjaZN7QtAoffnVHkPjBaLZLAzVKLNpMBlXFrWepItFD4BqVydwYftJLKIuXgPu0fwmMN9e1KcHGUD4V8aRLxMTo59CznJ7rpE7ZLTdsfSKcHeg0Rcyzl8oBnUVQeWhBPuLasTXv1Ids4IacpCZbrgV1v9NNAb7peGohWKXGE4hM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=KrvBXIUP; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KrvBXIUP"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1774010428;
	h=from:from:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=kTzG1yv3excY4zze3zwMzYBPgaiXOZZaI4t073SIAwM=;
	b=KrvBXIUPE0G22ui2OAXV5FyVmTTMcKxhds5zkX1rXzd7YCyxhrQSwhL0RNojdt5Fk9naGX
	iEaXts5BsXfh3Mi5ADO4bQMKo1CYwCFU//QZbJOXwzrm+D34yPTTfSWMDkUUFqkAk1bvkh
	sa9k909JD6VNEhcHqWN2WDDbBRh4QLI=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-418-B0B35TqaNtyNCdsnjMBL9g-1; Fri,
 20 Mar 2026 08:40:25 -0400
X-MC-Unique: B0B35TqaNtyNCdsnjMBL9g-1
X-Mimecast-MFC-AGG-ID: B0B35TqaNtyNCdsnjMBL9g_1774010424
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 1B4F81956089;
	Fri, 20 Mar 2026 12:40:24 +0000 (UTC)
Received: from redhat.com (unknown [10.44.33.255])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 1FC951955D84;
	Fri, 20 Mar 2026 12:40:18 +0000 (UTC)
Date: Fri, 20 Mar 2026 12:40:12 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Markus Armbruster <armbru@redhat.com>
Cc: Tommaso Califano <califano.tommaso@gmail.com>, qemu-devel@nongnu.org,
	kvm@vger.kernel.org, Eduardo Habkost <eduardo@habkost.net>,
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
Message-ID: <ab1ALDdqxwSWxPOx@redhat.com>
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
References: <20260317113840.33017-1-califano.tommaso@gmail.com>
 <20260317113840.33017-2-califano.tommaso@gmail.com>
 <abw3HqBJqEWiY7GP@redhat.com>
 <87eclfj66v.fsf@pond.sub.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87eclfj66v.fsf@pond.sub.org>
User-Agent: Mutt/2.2.14 (2025-02-20)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

On Fri, Mar 20, 2026 at 08:44:40AM +0100, Markus Armbruster wrote:
> Daniel P. Berrangé <berrange@redhat.com> writes:
> 
> > On Tue, Mar 17, 2026 at 12:38:36PM +0100, Tommaso Califano wrote:
> >> With this change it is possible to run a VM with the SEV CPUID active
> >> adding:
> >> 
> >>     -accel tcg \
> >>     -object sev-emulated,id=sev0,cbitpos=47,reduced-phys-bits=1 \
> >>     -machine memory-encryption=sev0
> >
> > snip
> >
> >> diff --git a/qapi/qom.json b/qapi/qom.json
> >> index c653248f85..35cda819ec 100644
> >> --- a/qapi/qom.json
> >> +++ b/qapi/qom.json
> >> @@ -1057,6 +1057,19 @@
> >>              '*handle': 'uint32',
> >>              '*legacy-vm-type': 'OnOffAuto' } }
> >>  
> >> +##
> >> +# @SevEmulatedProperties:
> >> +#
> >> +# Properties for sev-emulated objects.
> >> +# This object functionally emulates AMD SEV hardware via TCG, so
> >> +# it does not require real hardware to run.
> >> +#
> >> +# Since: 10.1.0
> >> +##
> >> +{ 'struct': 'SevEmulatedProperties',
> >> +  'base': 'SevGuestProperties',
> >> +  'data': {}}
> >
> > This is deriving 'sev-emulated' from 'sev-guest' which means it
> > supports all the properties that 'sev-guest' does, which for
> > the record is:
> 
> Uh, I somehow misread the base as SevCommonProperties!  Had I read
> correctly, I would've had similar questions.

Even SevCommonProperties has stuff that's irrelevant for
emulation that I mentioned.

With regards,
Daniel
-- 
|: https://berrange.com       ~~        https://hachyderm.io/@berrange :|
|: https://libvirt.org          ~~          https://entangle-photo.org :|
|: https://pixelfed.art/berrange   ~~    https://fstop138.berrange.com :|

