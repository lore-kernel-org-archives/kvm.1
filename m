Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D702A33D6ED
	for <kvm@vger.kernel.org>; Wed,  9 Sep 2026 06:20:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788934847; cv=none; b=Tco6kw0kz1v0W2PGJWDkfN7IEIHmZfgHPz6ReXnMwVbtHT4aSYyb28xSy3xZbJ+R6sbkDsQfm2+Co22EOb3ezAUFOT1tUEJSt0WLwId8s1Wuny5gkUX/rk+lAfTDexcci+o+QTp8GmlKMIMQzE40SHJRrzZ0HxuT4RTAu8nEWns=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788934847; c=relaxed/simple;
	bh=KgAH5DFo1fynH3JhTed3whC3C2h490xYMaD/jxMaETI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=riDqkQ4SChdoOYztGs9iqN+rDaPcdLelNix6OztaQDG5Dve+yNWaE4ixHNwi4Qlb7gfWWEE/PIlo1epCtch/HqoxwfzOHrAzWRdFrprrogoUHdezO+cBCi6DfUhJAEksCmToXpSgzed9jx+sykI3TD7AlCL35ADtB/gBQdorIIU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=hU2YWRgL; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hU2YWRgL"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1788934842;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=y6r5aoobcqd9F4eMSuFquKXONNVH+X/rcsYMSKawr+0=;
	b=hU2YWRgL+2txJnKZEHuzJdMKC/U8y2MRfd0BfNNoPGFOhnHpdF/aWV/cUAQysMrTVKC6x1
	8gFcEdVee6M9BoJX1WuaToKlhUmu+PSwAd2L7y3sFgZx0PQpTIxEUmcXuvhb97oa1k3xs0
	2t6rBL8FMSUuXJEdssKut+1QDP0eTh8=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-679-tooLIFfbOJCgtj55566jAA-1; Wed,
 09 Sep 2026 02:20:41 -0400
X-MC-Unique: tooLIFfbOJCgtj55566jAA-1
X-Mimecast-MFC-AGG-ID: tooLIFfbOJCgtj55566jAA_1788934839
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id B9AB81955DDD;
	Wed,  9 Sep 2026 06:20:39 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.44.22.5])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id DB8B0195608C;
	Wed,  9 Sep 2026 06:20:38 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
	id 7FEA121E6A04; Wed, 09 Sep 2026 08:20:36 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Michael Roth <michael.roth@amd.com>
Cc: <qemu-devel@nongnu.org>,  <kvm@vger.kernel.org>,  <pbonzini@redhat.com>,
  <berrange@redhat.com>,  <pankaj.gupta@amd.com>,
  <isaku.yamahata@intel.com>,  <xiaoyao.li@intel.com>,
  <chao.p.peng@linux.intel.com>,  <david@kernel.org>,
  <ashish.kalra@amd.com>,  <ackerleytng@google.com>,
  <lpieralisi@kernel.org>
Subject: Re: [PATCH v2 07/19] accel/kvm: Add CGS option to control in-place
 conversion support
In-Reply-To: <20260908205236.838281-8-michael.roth@amd.com> (Michael Roth's
	message of "Tue, 8 Sep 2026 15:48:27 -0500")
References: <20260908205236.838281-1-michael.roth@amd.com>
	<20260908205236.838281-8-michael.roth@amd.com>
Date: Wed, 09 Sep 2026 08:20:36 +0200
Message-ID: <878q5bosi3.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

Michael Roth <michael.roth@amd.com> writes:

> For confidential guests, guest_memfd is currently used only for private
> guest memory, and normal guest memory comes from the configured memory
> backend just as it does for a non-confidential guest. It is now possible
> to use the same physical memory to back a particular GPA regardless of
> whether it is in a shared or private state. This avoids the need to
> rely on discarding memory between shared/private conversions (to avoid
> doubled memory usage), and is intended to be the primary mode of using
> guest_memfd for confidential guests moving forward, and future features
> like hugepage support will likely require it.
>
> Add an option to enable this support. Since ConfidentialGuestSupport is
> already used to track some guest_memfd-related functionality (e.g.
> whether it is required for the configured machine), similarly introduce
> this option as a property of ConfidentialGuestSupport.
>
> Also add the KVM-specific checks to enable this support, but leave the
> option disabled until other required changes are implemented for
> CGS variants that intend to make use of KVM's in-place conversion
> support.
>
> While technically the convert-in-place option could be introduced as an
> SEV-specific option, it is a given that TDX will also be introducing
> in-place conversion support based on the same guest_memfd kernel
> infrastructure, so introduce it via a new
> ConfidentialGuestSupportProperties base class that other confidential VM
> implementations can utilized for common options.
>
> Signed-off-by: Michael Roth <michael.roth@amd.com>

[...]

> diff --git a/qapi/qom.json b/qapi/qom.json
> index 909add4299..20d6fefb04 100644
> --- a/qapi/qom.json
> +++ b/qapi/qom.json
> @@ -1005,6 +1005,21 @@
>    'if': 'CONFIG_IGVM',
>    'data': { 'file': 'str' } }
>  
> +##
> +# @ConfidentialGuestSupportProperties:
> +#
> +# Properties for ConfidentialGuestSupport base class.
> +#
> +# @convert-in-place: If true, the same physical pages are reused
> +#     when memory is converted between shared and private states.
> +#     If false (default), separate allocations are used depending
> +#     on whether the page is private or shared.

Any guidance on when to enable @convert-in-place?

> +#
> +# Since: 11.2
> +##
> +{ 'struct': 'ConfidentialGuestSupportProperties',
> +  'data': { '*convert-in-place': 'bool' } }
> +
>  ##
>  # @SevCommonProperties:
>  #
> @@ -1033,6 +1048,7 @@
>  # Since: 9.1
>  ##
>  { 'struct': 'SevCommonProperties',
> +  'base': 'ConfidentialGuestSupportProperties',
>    'data': { '*sev-device': 'str',
>              '*cbitpos': 'uint32',
>              'reduced-phys-bits': 'uint32',

Can you explain why you put @convert-in-place into a new base type
instead of right here?

