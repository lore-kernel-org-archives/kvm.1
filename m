Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D16D32DCBE3
	for <kvm@vger.kernel.org>; Tue,  2 Jun 2026 08:23:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780388632; cv=none; b=XeHxILooGycflFmIBWe/fdx0ieNURymatgXrs6wMVn664AJ2Lj+jND6evd6kEZRw3g/pLstV9DMHPsmJ/tVft/K0tycZLSUMZIjpZjjj2ZBqdyRqJDlZFH8CCgMSN6uC1ALMPEMzs2bt5SmIlcRm3pFp7rSr7T80cRm3ApxGT1M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780388632; c=relaxed/simple;
	bh=JE/i4PI7L0h9y3u1kiQUkOY2mSU/MdfBnJplzJU0hzg=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=ku4WWY734GqSmtYem4fhjuiQHwTvsf8fzSKfVzNECLsiTQU15/Z9NOXExsS7nBQlr5oGyAUSHK2R83ak9gWW1OhUq8dYRSsaCOMhTnjEDfgcqJE6pZ3lHsvFTEv1MIumK8GDdTeYSh+itN8DN0Vg7HSqR4axBob7IZsm2oOJXPQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Rch8OcJL; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Rch8OcJL"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1780388629;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=JzEx/djjiKdSQ43hJspteLYFDK5pHtfMy3ITMuebRHU=;
	b=Rch8OcJLwZK7H/n1vekoZoPnIA7jvjFLszrySUiSkJA248fMHYBC+FXZbVi5v89WRJ1AxY
	7Zw+NOBGH21EYZQjVCqufY0GUqzjcUlBc3O/+7urtpKSgBsYdvEXGUXDa0zy/4+vued2h/
	+56wqutE8bvTaQuFK+Kk3GRFh8uiNEU=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-677-sU4JCvHpM2G4-w1R1dkwvw-1; Tue,
 02 Jun 2026 04:23:45 -0400
X-MC-Unique: sU4JCvHpM2G4-w1R1dkwvw-1
X-Mimecast-MFC-AGG-ID: sU4JCvHpM2G4-w1R1dkwvw_1780388623
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 4AA39195606C;
	Tue,  2 Jun 2026 08:23:43 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.44.22.2])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id E40461800352;
	Tue,  2 Jun 2026 08:23:42 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
	id 87D1721E6A01; Tue, 02 Jun 2026 10:23:40 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Michael Roth <michael.roth@amd.com>
Cc: <qemu-devel@nongnu.org>,  <kvm@vger.kernel.org>,  <pbonzini@redhat.com>,
  <berrange@redhat.com>,  <pankaj.gupta@amd.com>,
  <isaku.yamahata@intel.com>,  <xiaoyao.li@intel.com>,
  <chao.p.peng@linux.intel.com>,  <david@kernel.org>,
  <ashish.kalra@amd.com>,  <ackerleytng@google.com>
Subject: Re: [PATCH RFC 04/12] accel/kvm: Add CGS option to control in-place
 conversion support
In-Reply-To: <20260528000416.8161-5-michael.roth@amd.com> (Michael Roth's
	message of "Wed, 27 May 2026 19:03:29 -0500")
References: <20260528000416.8161-1-michael.roth@amd.com>
	<20260528000416.8161-5-michael.roth@amd.com>
Date: Tue, 02 Jun 2026 10:23:40 +0200
Message-ID: <87wlwh5p0z.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

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
> Signed-off-by: Michael Roth <michael.roth@amd.com>

[...]

> diff --git a/qapi/qom.json b/qapi/qom.json
> index 502fafeb15..037c078799 100644
> --- a/qapi/qom.json
> +++ b/qapi/qom.json
> @@ -1014,6 +1014,21 @@
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
> +#
> +# Since: 11.1
> +##
> +{ 'struct': 'ConfidentialGuestSupportProperties',
> +  'data': { '*convert-in-place': 'bool' } }
> +
>  ##
>  # @SevCommonProperties:
>  #
> @@ -1038,6 +1053,7 @@
>  # Since: 9.1
>  ##
>  { 'struct': 'SevCommonProperties',
> +  'base': 'ConfidentialGuestSupportProperties',
>    'data': { '*sev-device': 'str',
>              '*cbitpos': 'uint32',
>              'reduced-phys-bits': 'uint32',

Why use a base type instead of simply adding @convert-in-place to
SevCommonProperties?

