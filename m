Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0477D344D9D
	for <kvm@vger.kernel.org>; Fri, 20 Mar 2026 07:44:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773992694; cv=none; b=o5OHgV9ydnxZyGmWl0WgYp2D9bFk5OcBeGEMBje6WdkcyoEHRqFMy0ma9A2+C3RygC9vEwbwTnfPrv01CVVHI6Zx34LGDG0W+QjCRDLhegxHPQ+TCj2oG2YnO8VxTtYP2lkRSF40aNxtLKjwsoxJuOE2WALeZVe3goaFbzH28LY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773992694; c=relaxed/simple;
	bh=y2yhuiY2YrgK+dYBGuwzcIkM0v+qq+4z/ejARY3CWGY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=rFWB+I282q1s0vKocN+jlA/BvGLmIQVv7PpH83KK3Oxm0pnvS3YUKpGiOkG/iwIS3dCicaBbS/yagAcCLGrf6mWxV+ZcvFkH1htFd0Ir6SWHcfdut5jO1stF3GaI66Rf9Ix4hHcFb7O63SOsS+nDTZyN4ZI0NGgIcnauE29diLc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=HQe7NDDV; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HQe7NDDV"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1773992690;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Jv2/esUQQEmiRQBGlvt4rWoAfxCaO8P4pmkEQibkse4=;
	b=HQe7NDDVW5SZdobdda7vQ9Hodo0XqG/OZswfGf5OzdfXgbyPNXIDHzKMqzBXMG56s3xlps
	WTZ3jNU3ZfG/h9Hxaq8rAMXQt2WgSWvANERGXkak5LJ7GamSZUA1i5vIbyISZ75ItHQY6f
	YMyofo75IWv1PlHR16ksJQQEQyIL/LM=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-164-Wf9-RJBGNNa2pY34fh7WmQ-1; Fri,
 20 Mar 2026 03:44:45 -0400
X-MC-Unique: Wf9-RJBGNNa2pY34fh7WmQ-1
X-Mimecast-MFC-AGG-ID: Wf9-RJBGNNa2pY34fh7WmQ_1773992684
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 497071800359;
	Fri, 20 Mar 2026 07:44:43 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.45.242.6])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 86E8D1800766;
	Fri, 20 Mar 2026 07:44:42 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
	id 1EED221E6937; Fri, 20 Mar 2026 08:44:40 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: Daniel P. =?utf-8?Q?Berrang=C3=A9?= <berrange@redhat.com>
Cc: Tommaso Califano <califano.tommaso@gmail.com>,  qemu-devel@nongnu.org,
  kvm@vger.kernel.org,  Eduardo Habkost <eduardo@habkost.net>,  Zhao Liu
 <zhao1.liu@intel.com>,  Marcelo Tosatti <mtosatti@redhat.com>,  Eric Blake
 <eblake@redhat.com>,  Oliver Steffen <osteffen@redhat.com>,  Stefano
 Garzarella <sgarzare@redhat.com>,  Giuseppe Lettieri
 <giuseppe.lettieri@unipi.it>,  Paolo Bonzini <pbonzini@redhat.com>,  Luigi
 Leonardi <leonardi@redhat.com>,  Richard Henderson
 <richard.henderson@linaro.org>
Subject: Re: [PATCH 1/5] i386/sev: Add sev-emulated QOM object with TCG support
In-Reply-To: <abw3HqBJqEWiY7GP@redhat.com> ("Daniel P. =?utf-8?Q?Berrang?=
 =?utf-8?Q?=C3=A9=22's?= message of
	"Thu, 19 Mar 2026 17:49:18 +0000")
References: <20260317113840.33017-1-califano.tommaso@gmail.com>
	<20260317113840.33017-2-califano.tommaso@gmail.com>
	<abw3HqBJqEWiY7GP@redhat.com>
Date: Fri, 20 Mar 2026 08:44:40 +0100
Message-ID: <87eclfj66v.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

Daniel P. Berrang=C3=A9 <berrange@redhat.com> writes:

> On Tue, Mar 17, 2026 at 12:38:36PM +0100, Tommaso Califano wrote:
>> With this change it is possible to run a VM with the SEV CPUID active
>> adding:
>>=20
>>     -accel tcg \
>>     -object sev-emulated,id=3Dsev0,cbitpos=3D47,reduced-phys-bits=3D1 \
>>     -machine memory-encryption=3Dsev0
>
> snip
>
>> diff --git a/qapi/qom.json b/qapi/qom.json
>> index c653248f85..35cda819ec 100644
>> --- a/qapi/qom.json
>> +++ b/qapi/qom.json
>> @@ -1057,6 +1057,19 @@
>>              '*handle': 'uint32',
>>              '*legacy-vm-type': 'OnOffAuto' } }
>>=20=20
>> +##
>> +# @SevEmulatedProperties:
>> +#
>> +# Properties for sev-emulated objects.
>> +# This object functionally emulates AMD SEV hardware via TCG, so
>> +# it does not require real hardware to run.
>> +#
>> +# Since: 10.1.0
>> +##
>> +{ 'struct': 'SevEmulatedProperties',
>> +  'base': 'SevGuestProperties',
>> +  'data': {}}
>
> This is deriving 'sev-emulated' from 'sev-guest' which means it
> supports all the properties that 'sev-guest' does, which for
> the record is:

Uh, I somehow misread the base as SevCommonProperties!  Had I read
correctly, I would've had similar questions.

