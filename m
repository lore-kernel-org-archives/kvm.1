Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AD752D061C
	for <kvm@vger.kernel.org>; Mon, 28 Sep 2026 11:48:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790596082; cv=none; b=A/q8IeBiOvUlkxvdznOQ4GX3d7iVSqnE46pcBoKxmTyXWICRUdp5MUOaauTu0KVfjzESEH2CplWiVRfDgxwFqb00hg6ehBrXBNNsfdxMW7uCSty9lIAh5OpbwxXFTHvFyM4/4TsOsIP8pZLJJcXG8b4sn1j8GACV7KgwQgH8Czs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790596082; c=relaxed/simple;
	bh=4Lr+ZWJIYnFoMUEklGu9RLSn5nQX9TBjjviN7WDLIYQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Ndey4cxYAHJrCiGR35UlilnK4y05NTWwovTr8d+yGHmd612TRHuHCIPr5D8Vaks3/yOxNEK8CM+FMxEAz4lwu0/vC3rwGI7QGHUh/gi+ksjioXNwBj8+2b16h7RbvYNV6pX4RfJDiZH+ehec7cQqe1tgBAJeOqI20CvaLIbDLwM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=b/2qFG3v; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="b/2qFG3v"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1790596080;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=UklCMeok/lRwwENuhgX7Blw7lwK8sUDFmGXUvT9wcyc=;
	b=b/2qFG3vLxsGjFe7kyJWH7MlyZrZYu8qDYFGZ5Ut+FO3AcrwX4YHuugqeThOande9AnbJp
	lvoNBD2SETXYoZzNVL55w4AbphAHRK/O6B8TmuEfTtooU3V0s9sbG0TpX1tYr2bT/XwY9H
	c6MHGtVpaKjTH4eGZI+ZuAOTeu7AKlY=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-492-J4yRTP5DMKyOeSX3gMLLJQ-1; Mon,
 28 Sep 2026 07:47:56 -0400
X-MC-Unique: J4yRTP5DMKyOeSX3gMLLJQ-1
X-Mimecast-MFC-AGG-ID: J4yRTP5DMKyOeSX3gMLLJQ_1790596074
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 6CD4E19541AE;
	Mon, 28 Sep 2026 11:47:54 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.44.22.5])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id E6F1730000E4;
	Mon, 28 Sep 2026 11:47:53 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
	id 9796221E6A04; Mon, 28 Sep 2026 13:47:51 +0200 (CEST)
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
In-Reply-To: <20260926070057.1234-42-luoyonggang@gmail.com> (Yonggang Luo's
	message of "Sat, 26 Sep 2026 15:00:40 +0800")
References: <20260926070057.1234-1-luoyonggang@gmail.com>
	<20260926070057.1234-42-luoyonggang@gmail.com>
Date: Mon, 28 Sep 2026 13:47:51 +0200
Message-ID: <87zex1fvh4.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

Yonggang Luo <luoyonggang@gmail.com> writes:

> Add a none target for when no TargetInfo is selected. It is last
> so existing SYS_EMU_TARGET_* values stay put, and it is not a
> qemu-system- executable name. target_is_none() and target_none()
> report that state.

Why does it matter that existing SYS_EMU_TARGET_* stay put?

> Signed-off-by: Yonggang Luo <luoyonggang@gmail.com>

[...]

> diff --git a/qapi/machine.json b/qapi/machine.json
> index b1be5608b61..6aaa2af709a 100644
> --- a/qapi/machine.json
> +++ b/qapi/machine.json
> @@ -22,6 +22,10 @@
>  # The individual target constants are not documented here, for the
>  # time being.
>  #
> +# @none: no TargetInfo selected.

Doc comments are reference documentation for users.  TargetInfo is an
internal thing.  Please rephrase in terms that make sense to users.

>                                    Not a qemu-system- executable name.

This barely makes sense.  I recommend to leave documenting the
qemu-system-T naming convention to the note below.

> +#     Last enumerator so existing SYS_EMU_TARGET_* values stay put.

Of no concern to users, therefore inappropriate for user documentation.

> +#     (since 11.2)
> +#
>  # @rx: since 5.0
>  #
>  # @avr: since 5.1
> @@ -30,9 +34,10 @@
>  #
>  # @hexagon: since 11.0
>  #
> -# .. note:: The resulting QMP strings can be appended to the
> -#    "qemu-system-" prefix to produce the corresponding QEMU
> -#    executable name.  This is true even for "qemu-system-x86_64".
> +# .. note:: Except for ``none``, the resulting QMP strings can be
> +#    appended to the "qemu-system-" prefix to produce the
> +#    corresponding QEMU executable name.  This is true even for
> +#    "qemu-system-x86_64".

Not this patch's concern: I don't understand what's so special about
x86_64.

>  #
>  # Since: 3.0
>  ##
> @@ -42,7 +47,7 @@
>               'mips64el', 'mipsel', 'or1k', 'ppc',
>               'ppc64', 'riscv32', 'riscv64', 'rx', 's390x', 'sh4',
>               'sh4eb', 'sparc', 'sparc64', 'tricore',
> -             'x86_64', 'xtensa', 'xtensaeb' ] }
> +             'x86_64', 'xtensa', 'xtensaeb', 'none' ] }
>  
>  ##
>  # @S390CpuState:

[...]

