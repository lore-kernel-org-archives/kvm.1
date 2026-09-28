Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7568045518D
	for <kvm@vger.kernel.org>; Mon, 28 Sep 2026 09:48:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790588937; cv=none; b=peVD0pi3TkAEQnRdik+vd0Ni1FeCGgjr3upHT8tSE5aTEl4B6SKYCsf70bP56UxU/kpDiRdo3JF9purcy9opkVRavVjFUgdNa9xRxsr1C5Zak0/20+N1mdPwK9aQgzRsQGexsEtT7jEnyInQsYo2dXDduxpAloVzDVqsdra60x8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790588937; c=relaxed/simple;
	bh=Slj2/L8Bs8X0FIIMKfZwAnNd1ulkBirZourhpMI5h2E=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=QIS3MFoIEmGoffPxaTX3Yz/SehEL8iU/sPqGWVDG1yzfvdaTsLzNi6x7eJAc0e86uaUIIZg3/INuAeq7xQNt6rtSrrWFQ0H84eNjnacBD7cFuIPyNlSEoXqnCb16G26vnsv9IwO6rNW3EscCtvX6Owk/F6xSWoTKYd0Xo4c9c/U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=fIXm6Rpv; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fIXm6Rpv"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1790588934;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=NvRimCA+X/OV7PuScqxQub75k2+5uCqVKpdgUYw7yg4=;
	b=fIXm6Rpv2i9b3OQPJWt59Z1r3FZgT5UgiHB8TwOY+4SVINYFy/H5NYfpY5rVXahfP0otAp
	Lk4w1n3GHLL0q+3mtp8niuQrTltHhM7+zYH+St0PmvC4281wjQLe93o3BhUsi4XeSNk2JJ
	w6B9TLOTX/HYl3+OjKmzwn2nRSNJjzM=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-240-9qpvrJKuNRGKoN3eNz_03A-1; Mon,
 28 Sep 2026 05:48:48 -0400
X-MC-Unique: 9qpvrJKuNRGKoN3eNz_03A-1
X-Mimecast-MFC-AGG-ID: 9qpvrJKuNRGKoN3eNz_03A_1790588926
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 307AE1955D5E;
	Mon, 28 Sep 2026 09:48:46 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.44.22.5])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 9889E1956087;
	Mon, 28 Sep 2026 09:48:45 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
	id 28E5121E6A04; Mon, 28 Sep 2026 11:48:43 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Yonggang Luo <luoyonggang@gmail.com>
Cc: qemu-devel@nongnu.org,  Richard Henderson
 <richard.henderson@linaro.org>,  Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?=
 <philmd@oss.qualcomm.com>,  Daniel P. =?utf-8?Q?Berrang=C3=A9?=
 <berrange@redhat.com>,
  "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,  Pierrick Bouvier
 <pierrick.bouvier@oss.qualcomm.com>,  Fabiano Rosas <farosas@suse.de>,
  Laurent Vivier <lvivier@redhat.com>,  Paolo Bonzini
 <pbonzini@redhat.com>,  Alistair Francis <alistair@alistair23.me>,  Peter
 Maydell <peter.maydell@linaro.org>,  =?utf-8?Q?Marc-Andr=C3=A9?= Lureau
 <marcandre.lureau@redhat.com>,  qemu-arm@nongnu.org,  kvm@vger.kernel.org
Subject: Re: [PATCH v4 07/55] tests/unit: add test-target-info
In-Reply-To: <CAE2XoE9_R13NsUWu-s12QA9RBJykR87TEMh3VmndNEXQsCkNtg@mail.gmail.com>
	(Yonggang Luo's message of "Mon, 28 Sep 2026 17:21:06 +0800")
References: <20260926070057.1234-1-luoyonggang@gmail.com>
	<20260926070057.1234-8-luoyonggang@gmail.com>
	<87zex1hhhj.fsf@pond.sub.org>
	<CAE2XoE9_R13NsUWu-s12QA9RBJykR87TEMh3VmndNEXQsCkNtg@mail.gmail.com>
Date: Mon, 28 Sep 2026 11:48:43 +0200
Message-ID: <87ik3phfk4.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

Yonggang Luo <luoyonggang@gmail.com> writes:

> On Mon, Sep 28, 2026 at 5:07=E2=80=AFPM Markus Armbruster <armbru@redhat.=
com> wrote:
>>
>> Yonggang Luo <luoyonggang@gmail.com> writes:
>>
>> > Collect each target-info-def.c object in target_info_def_objects,
>> > keyed by target dir. Link every value so constructors fill the
>> > list. Assert target_info() is not NULL and target_info_list() has
>> > one entry per linked object.
>> >
>> > Signed-off-by: Yonggang Luo <luoyonggang@gmail.com>
>>
>> Doesn't compile for me:

[...]

>> I have meson 1.8.5.
>>
>
> Hi, It's because I use a feature from meson 1.10.0, you can install meson
> 1.12.0 for it. and the remote branch I also fixed for KVM and got gitlab
> running. but for this series you need to install meson 1.12.x

Your series cannot be merged as is.  You have to make it work with the
minimum required version (1.6.0 as far as I can tell), or get that
version increased sufficiently.

