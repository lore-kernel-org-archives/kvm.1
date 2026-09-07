Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D11235C6BF
	for <kvm@vger.kernel.org>; Mon,  7 Sep 2026 08:49:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788770958; cv=none; b=LKsmlDIqqrn1XeI9Qe7wjKdaYEO2buEJo2TV0z2FwnispPqSlieyBlATCpn3cvrYgGINdfPVpAAJQyd6eWahQyPDdmHJoqdZR6dmzPw7Nva37NDQt9bX0IWNyZgUQeQZ9QCEaqwAO84b9030qlPTTZHGpiP/aCzVbku1Ks0QyNk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788770958; c=relaxed/simple;
	bh=rWsK8wp1MOM3SdX6JBVeKKPDm4rND3tf5XsAR4O0i6o=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=WL3LSUlVeB8ZFsnrOeipb0nyKObDUZktHKMY2OI+N3fzG2S5SrQylMIFwzbWr4v148hRp2tX+aUepYF7lRBoJ4odJhFIqY8fmugByIytrbh8VzXSmn+Yk2GdrwcNxMEAteDwbyOTY0NyK91WSinKoBGm6AKerpmp7eKZwTKTwYQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Tr2onhc4; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Tr2onhc4"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1788770955;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Io0H1GJ/dw2mo8xfSai0hRK1W/6Yvbo/1iXfLNcM4Ew=;
	b=Tr2onhc4jWMWYUi/TSOA6GhbyEgJUxme3cnhVGyMwn4Oh8isnWK/8aUxPII5dKpveIiviJ
	kBKrcIT3wbwyc/wRBNoPUX7t5lqoOM8K4ixOtXl3hPKfwHaA+1lIU9bpUuls2wp9DblDZA
	zrcsieyvSHkVrzTWVVpJxmTRuUJfUhk=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-221-a78adVEqOB2guYjl-O9KQg-1; Mon,
 07 Sep 2026 04:49:14 -0400
X-MC-Unique: a78adVEqOB2guYjl-O9KQg-1
X-Mimecast-MFC-AGG-ID: a78adVEqOB2guYjl-O9KQg_1788770953
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 68BFF1956075;
	Mon,  7 Sep 2026 08:49:12 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.44.22.5])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id C503D18001CE;
	Mon,  7 Sep 2026 08:49:11 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
	id 5A6A221E6A04; Mon, 07 Sep 2026 10:49:09 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Mathieu Poirier <mathieu.poirier@linaro.org>
Cc: berrange@redhat.com,  kchamart@redhat.com,
  pierrick.bouvier@oss.qualcomm.com,  peter.maydell@linaro.org,
  mst@redhat.com,  cohuck@redhat.com,  pbonzini@redhat.com,
  eblake@redhat.com,  armbru@redhat.com,  lorenzo.pieralisi@linaro.org,
  gshan@redhat.com,  enju.kohei@fujitsu.com,  qemu-devel@nongnu.org,
  qemu-arm@nongnu.org,  kvm@vger.kernel.org
Subject: Re: [RFC v4 03/24] target/arm: Add confidential guest support
In-Reply-To: <20260903193611.1058589-4-mathieu.poirier@linaro.org> (Mathieu
	Poirier's message of "Thu, 3 Sep 2026 13:35:50 -0600")
References: <20260903193611.1058589-1-mathieu.poirier@linaro.org>
	<20260903193611.1058589-4-mathieu.poirier@linaro.org>
Date: Mon, 07 Sep 2026 10:49:09 +0200
Message-ID: <87wlsxxx8a.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

Mathieu Poirier <mathieu.poirier@linaro.org> writes:

> From: Jean-Philippe Brucker <jean-philippe@linaro.org>
>
> Add a new RmeGuest object, inheriting from ConfidentialGuestSupport, to
> support the Arm Realm Management Extension (RME). It is instantiated by
> passing on the command-line:
>
>   -M virt,confidential-guest-support=<id>
>   -object rme-guest,id=<id>
>
> This is only the skeleton. Support will be added in following patches.
>
> Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
> Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>

[...]

> diff --git a/qapi/qom.json b/qapi/qom.json
> index 776b13027fd8..52997c29a32d 100644
> --- a/qapi/qom.json
> +++ b/qapi/qom.json
> @@ -1288,6 +1288,17 @@
>    'data': { '*pretty': 'bool',
>              '*close-action': 'MonitorQMPCloseAction' } }
>  
> +##
> +# @RmeGuestProperties:
> +#
> +# Properties for rme-guest objects.
> +#
> +# Since: 11.1

11.2 now.

> +##
> +{ 'struct': 'RmeGuestProperties',
> +  'base': 'ConfidentialGuestSupportProperties',
> +  'data': {} }
> +
>  ##
>  # @ObjectType:
>  #
> @@ -1346,6 +1357,7 @@
>      { 'name': 'pr-manager-helper',
>        'if': 'CONFIG_LINUX' },
>      'qtest',
> +    'rme-guest',
>      'rng-builtin',
>      'rng-egd',
>      { 'name': 'rng-random',
> @@ -1427,6 +1439,7 @@
>        'pr-manager-helper':          { 'type': 'PrManagerHelperProperties',
>                                        'if': 'CONFIG_LINUX' },
>        'qtest':                      'QtestProperties',
> +      'rme-guest':                  'RmeGuestProperties',
>        'rng-builtin':                'RngProperties',
>        'rng-egd':                    'RngEgdProperties',
>        'rng-random':                 { 'type': 'RngRandomProperties',

With the Since: fixed
Acked-by: Markus Armbruster <armbru@redhat.com>

[...]

