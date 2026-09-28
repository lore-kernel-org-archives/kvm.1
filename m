Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E871A6DCE1
	for <kvm@vger.kernel.org>; Mon, 28 Sep 2026 12:23:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790598214; cv=none; b=Npx+7NmIyEEAaaDFExETmYJ6s/mR1zIp8nQ0yt8RP6o3eU92OtGpoMwloCMQ+VeGZXIAhP3BGHLlWiTcPn0yExZ7sAesHfKkwElhOHpHlR1CE0QXLtFje0lsm2dnY9jk5PpjZD6UvQiQWsCIYhSXdbNVUXv8Q3qCQjuDEWibtMA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790598214; c=relaxed/simple;
	bh=92oxsbk1gQPLOy7UF4eOZnpG+pUtRYbNaMC4xb7s364=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=MyRgmY7oy06BcSdyZpHk2TqK+YM36w+mZ17eET+ATFAZs8ZwYqaQEG2frPW3cM4fvtQSdApMWJrNTVSxGd6GemQc5RYqdX8ciSvXH/HvJvPW57AnpctvwDaBse8xzZwXrer6zuABE8IYM4IVmRdeAs21VQP8IOR/g2Ap8xfLY1M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=f4yqa7CQ; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="f4yqa7CQ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1790598211;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=kXgIVTB2IzRumv+Sh+U54waJwvhb8gGhS/ZAT5ZZ938=;
	b=f4yqa7CQr0PZzcnBVfMynb8liARxLnyFFch5sq8w5sTZuBqtkguvvcki83g/IqVC33MaEX
	eZSu/QrUqSZRggXWL1Q7PpyxCK+nn0au4N+3k9KI6SB+8LpPOaYb6Oq7xOI2pTeCbbCcDc
	vUfh6V/6rbUCzRwLDrdEic9UlggjxRA=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-303-9BPSgMAsPBWSqjeAUsSSJA-1; Mon,
 28 Sep 2026 08:23:27 -0400
X-MC-Unique: 9BPSgMAsPBWSqjeAUsSSJA-1
X-Mimecast-MFC-AGG-ID: 9BPSgMAsPBWSqjeAUsSSJA_1790598205
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 67B94195D03D;
	Mon, 28 Sep 2026 12:23:25 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.44.22.5])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id C7C1C180036E;
	Mon, 28 Sep 2026 12:23:24 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
	id 603B421E6A04; Mon, 28 Sep 2026 14:23:22 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Daniel P. =?utf-8?Q?Berrang=C3=A9?= <berrange@redhat.com>
Cc: Yonggang Luo <luoyonggang@gmail.com>,  qemu-devel@nongnu.org,  Richard
 Henderson <richard.henderson@linaro.org>,  Philippe =?utf-8?Q?Mathieu-Dau?=
 =?utf-8?Q?d=C3=A9?=
 <philmd@oss.qualcomm.com>,  "Edgar E. Iglesias"
 <edgar.iglesias@gmail.com>,  Pierrick Bouvier
 <pierrick.bouvier@oss.qualcomm.com>,  Fabiano Rosas <farosas@suse.de>,
  Laurent Vivier <lvivier@redhat.com>,  Paolo Bonzini
 <pbonzini@redhat.com>,  Alistair Francis <alistair@alistair23.me>,  Peter
 Maydell <peter.maydell@linaro.org>,  =?utf-8?Q?Marc-Andr=C3=A9?= Lureau
 <marcandre.lureau@redhat.com>,  qemu-arm@nongnu.org,  kvm@vger.kernel.org
Subject: Re: [PATCH v4 40/55] meson: link shared objects into qemu-system
In-Reply-To: <arpT2q5Rb0OmFE_e@redhat.com> ("Daniel P. =?utf-8?Q?Berrang?=
 =?utf-8?Q?=C3=A9=22's?= message of
	"Mon, 28 Sep 2026 12:47:38 +0100")
References: <20260926070057.1234-1-luoyonggang@gmail.com>
	<20260926070057.1234-41-luoyonggang@gmail.com>
	<8733uthabd.fsf@pond.sub.org> <arpT2q5Rb0OmFE_e@redhat.com>
Date: Mon, 28 Sep 2026 14:23:22 +0200
Message-ID: <87ecedfttx.fsf@pond.sub.org>
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

Daniel P. Berrang=C3=A9 <berrange@redhat.com> writes:

> On Mon, Sep 28, 2026 at 01:41:58PM +0200, Markus Armbruster wrote:
>> Yonggang Luo <luoyonggang@gmail.com> writes:
>>=20
>> > Extract common_ss, system_ss, and family-common objects into one
>> > qemu-system binary. Only arm, aarch64, microblaze-softmmu are
>> > listed; a new target must have arch_srcs equal to target_info_def
>> > only (target-info-def.c). Config headers stay in arch_genh.
>> >
>> > - Union non-TARGET_* keys with y taking precedence
>> > - Reject leftover arch_srcs on participating targets
>> > - Reject TARGET_* conditions on common_ss and system_ss
>> > - Link SDL, install the binary, and apply Darwin entitlements
>> >
>> > Adding a target that still has per-target sources fails meson, for
>> > example:
>> >
>> >   combined qemu-system leftover for :
>> >   expected:
>> >   target-info-def.c
>> >   arch_srcs:
>> >   target/microblaze/mmu.c
>> >   target/microblaze/machine.c
>> >   target-info-def.c
>> >
>> > Signed-off-by: Yonggang Luo <luoyonggang@gmail.com>
>>=20
>> Watch query-target lie:
>>=20
>>     $ qemu-system -S -nodefaults -display none -qmp stdio
>>     {"QMP": {"version": {"qemu": {"micro": 50, "minor": 1, "major": 11},=
 "package": "v11.1.0-1902-g88f617913a"}, "capabilities": ["oob"]}}
>>     qemu-system: warning: nic xlnx.xps-ethernetlite.0 has no peer
>>     {"execute": "qmp_capabilities", "arguments": {"enable": ["oob"]}}
>>     {"return": {}}
>>     {'execute': 'query-target'}
>> --> {"return": {"arch": "aarch64"}}
>>=20
>> Perhaps you can fix this by reordering patches.  If you can't,
>> deficiencies like this one need a prominent mention in the commit
>> message.
>
> What do you think the behaviour of 'query-target' ought to be in
> this scenario ?
>
> The 'none' machine has no associated target. Should we add a
> 'none' or 'unspecified' target to SysEmuTarget, or should we
> just declare that "query-target" will report an error if no
> target is activate.

Both solutions could work.  To have a preference, I'd have to think some
more.  Thinking costs extra!  ;)

For what it's worth, the next patch adds member "none" to SysEmuTarget.

> I'd probably lean towards the latter. Latter in this series
> is a new 'query-targets' command that can enumerate all
> available targets in 'qemu-system', so 'query-target' merely
> tells us which is active (if any). Perhaps 'query-targets'
> should in fact tell us that straightaway, such that we can
> declare 'query-target' to be obsolete (and even deprecate
> it)
>
> With regards,
> Daniel

