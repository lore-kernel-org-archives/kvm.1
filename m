Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33E0B3BA25F
	for <kvm@vger.kernel.org>; Mon, 28 Sep 2026 12:18:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790597890; cv=none; b=NzjjVLIG8QhH6P4g2oWgHKaKKfML+C/zMPI6FeHlsSwdoIiMAsOSmJzRbmYtK0fPXC4S6Ux4wqNtpC2/9AegHLYJ/Z61ZozIqKzO6GIZJB1LfW5K5Ebkg2I8dN14W3ctuB8R58bvaGqTYO0CUdfP6O/GYL1xQWLjj6cZFEGsmrg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790597890; c=relaxed/simple;
	bh=7a/ZwxqpgpSURpx8pWPKUPmkSNgZFHqHbbgPY0JCXDc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=LWZe1C1mWXiXwusbVdLqXf7ioO1DjVVOxpH/lA0/1q2mTf5kfjf1k9oHmXqla7Lc+XMMaYW5fTrixvKsBkNMLNtL6S/qOfOaRHuWi2dqTFXf5e8MklmMJkHTnSbYzi6fat+bVHqBwrGy8lrJ4a1LTlD2bhiuhsJk14VJRiuFFEo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Fx71W83C; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Fx71W83C"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1790597888;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0/vrLJXlrs9bLYKtYtporGPrELgOtVfcRvQQzCv5liU=;
	b=Fx71W83CqBz+/njKLKoiyViTF0ckPSP3FExlVMXYR1Z8NuLHiZEpEphyG2srMNlinsI5ZD
	Ra8LfVufRS9g/IFY2XQWims1aCfUaKgTvs7VnqcVOIwCU27xzT/zR5cGDrjfl3AbB26GU2
	dPs/m8FOq698Nel4rRp723Yj59WCOBI=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-312-XybCGkfKMwW9YHVF8Lnt6Q-1; Mon,
 28 Sep 2026 08:18:03 -0400
X-MC-Unique: XybCGkfKMwW9YHVF8Lnt6Q-1
X-Mimecast-MFC-AGG-ID: XybCGkfKMwW9YHVF8Lnt6Q_1790597881
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 2BC361955D4D;
	Mon, 28 Sep 2026 12:18:01 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.44.22.5])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 92796180036E;
	Mon, 28 Sep 2026 12:18:00 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
	id 27E7421E6A04; Mon, 28 Sep 2026 14:17:58 +0200 (CEST)
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
In-Reply-To: <CAE2XoE_QozVhBix251nyUQkFMi6p_4idGXpVOT0LSP7VYK8ddw@mail.gmail.com>
	(Yonggang Luo's message of "Mon, 28 Sep 2026 20:04:59 +0800")
References: <20260926070057.1234-1-luoyonggang@gmail.com>
	<20260926070057.1234-42-luoyonggang@gmail.com>
	<87zex1fvh4.fsf@pond.sub.org>
	<CAE2XoE_QozVhBix251nyUQkFMi6p_4idGXpVOT0LSP7VYK8ddw@mail.gmail.com>
Date: Mon, 28 Sep 2026 14:17:58 +0200
Message-ID: <87ik3pfu2x.fsf@pond.sub.org>
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

> On Mon, Sep 28, 2026 at 7:48=E2=80=AFPM Markus Armbruster <armbru@redhat.=
com> wrote:
>>
>> Yonggang Luo <luoyonggang@gmail.com> writes:
>>
>> > Add a none target for when no TargetInfo is selected. It is last
>> > so existing SYS_EMU_TARGET_* values stay put, and it is not a
>> > qemu-system- executable name. target_is_none() and target_none()
>> > report that state.
>>
>> Why does it matter that existing SYS_EMU_TARGET_* stay put?
>
> We need a state that not a real CPU target is selected( I called it none),
> then we can use it to list all targets. for example, do query-targets.
> query-machines(all machines for all targets).
> Any better ways to handle it would be appreciated, I am not choosing to s=
et
> it to NULL because
> that would cause too much NULL-check error, as the pre-existing code
> presume there is always a
> CPU target present.

Doesn't answer my question, so let me try again :)

In your commit message, you explain "it is last so existing
SYS_EMU_TARGET_* values stay put".  They do, but why is that useful?

