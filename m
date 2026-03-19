Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6917F34402B
	for <kvm@vger.kernel.org>; Thu, 19 Mar 2026 12:33:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773923617; cv=none; b=P1mxby36bNJ/vPz2h3W/R+xSY02KkulaCnrMkA5cqFmifxW/1GBCzMXHVLcvOV/ttDqGP+c4bYFk5wYHoHjwJYFqCUrJ2niWgjVxE2OlrQ6kePstPhR4QfNFLKCFJm4GMQWVRqK/B2RDXRiMrRKdHcMo86C1aLTvWor4YxlKW7I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773923617; c=relaxed/simple;
	bh=v6EBWt0avTGMquo/JuuxhhR3SOC2sUVhlZ/RenkXuRA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=DtkEha4BUBGH1iJjGGwSuVWtaPw63v+UBthdc2dfN08nkIPbxwWgqHsfUxXAoAu6SPTyjYM51jIR4TpTLPQM/2EGNaAGD5+892AJsijU4wBpM288HjCNl5Cm6RmQ26qqfxvzOkPeaYK9d9v9liANEv4cFAu1vxHIsEuZpqwmYBs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=e1jQxkzZ; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="e1jQxkzZ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1773923615;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=/yNIp548Llnl62sPTYtl03/gbLoOnbLZqtjletpNZEw=;
	b=e1jQxkzZFOL1PjTJW69nETQ6ImTpnGe4Rja06CRgMxWs1u3Hijz7WFqLMKaL60UYqIQOMd
	NRkpiYxOnFNDU0izA+X0iD9C5G9qXNaawQ6btHUlypRFW77DMw8sYA43zQHVP0bVgQk4RV
	Z9xLPDH+r/rGJQSxe1hy/3wYlvE7Xr0=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-54-4nMTlIClOhOy2SVYni1NwQ-1; Thu,
 19 Mar 2026 08:33:32 -0400
X-MC-Unique: 4nMTlIClOhOy2SVYni1NwQ-1
X-Mimecast-MFC-AGG-ID: 4nMTlIClOhOy2SVYni1NwQ_1773923610
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 473F919560B4;
	Thu, 19 Mar 2026 12:33:30 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.45.242.6])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id B9AAF180035F;
	Thu, 19 Mar 2026 12:33:29 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
	id 60E2F21E6937; Thu, 19 Mar 2026 13:33:27 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: Tommaso Califano <califano.tommaso@gmail.com>
Cc: qemu-devel@nongnu.org,  kvm@vger.kernel.org,  Eduardo Habkost
 <eduardo@habkost.net>,  Markus Armbruster <armbru@redhat.com>,  Zhao Liu
 <zhao1.liu@intel.com>,  Daniel P. =?utf-8?Q?Berrang=C3=A9?=
 <berrange@redhat.com>,  Marcelo
 Tosatti <mtosatti@redhat.com>,  Eric Blake <eblake@redhat.com>,  Oliver
 Steffen <osteffen@redhat.com>,  Stefano Garzarella <sgarzare@redhat.com>,
  Giuseppe Lettieri <giuseppe.lettieri@unipi.it>,  Paolo Bonzini
 <pbonzini@redhat.com>,  Luigi Leonardi <leonardi@redhat.com>,  Richard
 Henderson <richard.henderson@linaro.org>
Subject: Re: [PATCH 4/5] i386/sev: Add launch measurement emulation and TIK
 property
In-Reply-To: <20260317113840.33017-5-califano.tommaso@gmail.com> (Tommaso
	Califano's message of "Tue, 17 Mar 2026 12:38:39 +0100")
References: <20260317113840.33017-1-califano.tommaso@gmail.com>
	<20260317113840.33017-5-califano.tommaso@gmail.com>
Date: Thu, 19 Mar 2026 13:33:27 +0100
Message-ID: <87pl50vw14.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

Tommaso Califano <califano.tommaso@gmail.com> writes:

> The next step for completing the SEV launch emulation is to implement the
> "query-sev-launch-measure" feature, responsible for returning the
> measurement. In this case the measurement will be computed in QEMU.
>
> Implement sev_emulated_launch_get_measure() to emulate the LAUNCH_MEASURE
> command per AMD SEV API spec section 6.5.1. It generates a random 16-byte
> mnonce, computes the launch digest as SHA-256 over ld_data, then derives
> the measurement via HMAC-SHA256
> (TIK;0x04|| API version || build ID || policy || launch digest || mnonce).
> The base64-encoded result (32-byte HMAC + 16-byte mnonce) populates
> "query-sev-launch-measure" data, advancing state to LAUNCH_SECRET for
> secret injection.
>
> The TIK is supplied via 16-byte binary file specified in new
> SevEmulatedProperty "tik" path; absent this, keys default to zeroed.
> Example QEMU arguments with the key passed:
>
> 	-cpu "EPYC-Milan" \
> 	-accel tcg \
> 	-object sev-emulated,id=sev0,cbitpos=47,reduced-phys-bits=1,\
> 					tik=/path/to/tik.bin \
> 	-machine memory-encryption=sev0
>
> Signed-off-by: Tommaso Califano <califano.tommaso@gmail.com>
> ---
>  qapi/qom.json     |   3 +-
>  target/i386/sev.c | 155 ++++++++++++++++++++++++++++++++++++++++++++++
>  2 files changed, 157 insertions(+), 1 deletion(-)
>
> diff --git a/qapi/qom.json b/qapi/qom.json
> index 35cda819ec..affb5024b5 100644
> --- a/qapi/qom.json
> +++ b/qapi/qom.json
> @@ -1064,11 +1064,12 @@
>  # This object functionally emulates AMD SEV hardware via TCG, so
>  # it does not require real hardware to run.
>  #
> +# @tik: binary file of the SEV TIK (default: all 0).

Is this a file name?

Blank line here, please.

>  # Since: 10.1.0
>  ##
>  { 'struct': 'SevEmulatedProperties',
>    'base': 'SevGuestProperties',
> -  'data': {}}
> +  'data': {'*tik': 'str'}}
>  
>  ##
>  # @SevSnpGuestProperties:

[...]

