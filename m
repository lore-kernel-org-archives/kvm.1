Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCA192367D3
	for <kvm@vger.kernel.org>; Mon, 28 Sep 2026 12:24:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790598293; cv=none; b=AQ5ftipEnUDuCL8MZDJyRJxLtkSbh9p58I4f3L4HEM8cfTx70LrVQr7n3QmGbV1lhZ6JaSICoUBE2f4FZjlkq+ucVpDVogrqvuSQ4uzFHR/z6sYdXKJdbsgXQ8lusaxUnuT/bMEEx285G1/vbVUKHfo+4z8Us0tR5biYnaq7eVw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790598293; c=relaxed/simple;
	bh=7hyZ7fnSNHVRZVVwx+LyGciMfqFO6w/JgUeyEW9h8hw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=jp8E6DOLZ2IoyWqhLsn82/mh2oGto64xuziq641s7pIATxd/tAIFmWmg7VN/u8sDsXvgM9JK7Yxo9tMO/saja8WGDu7hINysk19+F/j1RrSArGNEOChjY1DSKbsJQtaCOg4Tp1x3k2POStbKsluEvuApbhJ3PJPuDZKIctLd9XI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=dBN2uiqf; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dBN2uiqf"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1790598290;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2FsFxrxE0VDB4+lMi6G4e3TwSLJX9eBKn7hK66HXT7g=;
	b=dBN2uiqfzL+PY4tW95SFkLusOs279G78INDzo+Qk/Zl++9c42YJkuegvdu3N9izDWz4D7Y
	T4qgKFAxH0O8x1QjEVIHQXRKZHlK6r/T4tvaN1pEhkcS8kG0fUAIco6AKp9hPZpFmLPE/Q
	cD4UwPTaq6x5QrNO6G6hPzB1R+cp/uM=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-616-3D5cFf0cOIeAbWTMSjsOWg-1; Mon,
 28 Sep 2026 08:24:49 -0400
X-MC-Unique: 3D5cFf0cOIeAbWTMSjsOWg-1
X-Mimecast-MFC-AGG-ID: 3D5cFf0cOIeAbWTMSjsOWg_1790598287
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 14D1B19541B7;
	Mon, 28 Sep 2026 12:24:47 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.44.22.5])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 865091800370;
	Mon, 28 Sep 2026 12:24:46 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
	id 3559521E6A04; Mon, 28 Sep 2026 14:24:44 +0200 (CEST)
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
Subject: Re: [PATCH v4 41/55] target-info: add SysEmuTarget none
In-Reply-To: <CAE2XoE88wDu5dYzqVd4gvwNV=bf8qcztLos0xx3iMFnWB+=Nvw@mail.gmail.com>
	(Yonggang Luo's message of "Mon, 28 Sep 2026 20:20:46 +0800")
References: <20260926070057.1234-1-luoyonggang@gmail.com>
	<20260926070057.1234-42-luoyonggang@gmail.com>
	<87zex1fvh4.fsf@pond.sub.org>
	<CAE2XoE_QozVhBix251nyUQkFMi6p_4idGXpVOT0LSP7VYK8ddw@mail.gmail.com>
	<87ik3pfu2x.fsf@pond.sub.org>
	<CAE2XoE88wDu5dYzqVd4gvwNV=bf8qcztLos0xx3iMFnWB+=Nvw@mail.gmail.com>
Date: Mon, 28 Sep 2026 14:24:43 +0200
Message-ID: <875wzpftro.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

Yonggang Luo <luoyonggang@gmail.com> writes:

> On Mon, Sep 28, 2026 at 8:18=E2=80=AFPM Markus Armbruster <armbru@redhat.=
com> wrote:
>>
>> Yonggang Luo <luoyonggang@gmail.com> writes:
>>
>> > On Mon, Sep 28, 2026 at 7:48=E2=80=AFPM Markus Armbruster <armbru@redh=
at.com>
> wrote:
>> >>
>> >> Yonggang Luo <luoyonggang@gmail.com> writes:
>> >>
>> >> > Add a none target for when no TargetInfo is selected. It is last
>> >> > so existing SYS_EMU_TARGET_* values stay put, and it is not a
>> >> > qemu-system- executable name. target_is_none() and target_none()
>> >> > report that state.
>> >>
>> >> Why does it matter that existing SYS_EMU_TARGET_* stay put?
>> >
>> > We need a state that not a real CPU target is selected( I called it
> none),
>> > then we can use it to list all targets. for example, do query-targets.
>> > query-machines(all machines for all targets).
>> > Any better ways to handle it would be appreciated, I am not choosing to
> set
>> > it to NULL because
>> > that would cause too much NULL-check error, as the pre-existing code
>> > presume there is always a
>> > CPU target present.
>>
>> Doesn't answer my question, so let me try again :)
>>
>> In your commit message, you explain "it is last so existing
>> SYS_EMU_TARGET_* values stay put".  They do, but why is that useful?
>
> Just to keep the pre-existing enum value not changed, yeap, not that usef=
ul.
> I'll drop this misleading comment. Another choice is keep none
> as the first enum value, so it's always "0", maybe that's better?

I think it is, because similar "none" are first elsewhere.

