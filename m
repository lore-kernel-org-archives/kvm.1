Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F052A4B0CBB
	for <kvm@vger.kernel.org>; Mon, 28 Sep 2026 11:42:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790595727; cv=none; b=r35g3z622yZ7eQ+90uI35RKmnT9iyMwMVgtdUctWyKGu/ZpNhW3D6weXdTbr2NXg3NA3yoYm8GUE/gPSlfT3YrOn5ln1IksOYGG/HzvYFmcXS0zKC+YYdnaFQuzqksGWhuEzW8FogRpQcly2i3l6lwCUg70PI7gJKfe2ySQEgsw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790595727; c=relaxed/simple;
	bh=P6J/EP7VFLOKqQSF+adpfxg8iC9jlFvQ5yBm7RQ87BI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=dqQ/C+3Nzt/TN8dZ9hyVmngH73qjn/LwPRTfjS0GfPCQ/apSwyM5r81+MfXMiTEZcDE2dxvkHKhFGRS2trbWQIHVtgGsmOEObDzgsZ3f+lf3iC03n9rIB2iw05OXrqdyIIMLu98kZ+giEArUDTWW8NNmLXmcfBw4rDACj1dUpPE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Uduu33X4; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Uduu33X4"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1790595724;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=lT/7dUd3Ns3Hv2bavTQFNjVEdK3MCpIQuBS+9fK13UY=;
	b=Uduu33X4i8dx0RyT1uz/Z4ShPacNftaXvBROu8rF9zf05DfduIwaxq30U1VjFMvCsWEWEm
	uRBvpnU0Fbhg9/ihgK3pyuyFhOcq+pPwS0JebYYzoYxCbvpT4U97NUiAzdjD3r2mX7Kezn
	xNAC8L6BplZBCuHxXRWYRxtT3sGEOi0=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-272-lQ4Kth-gPn6aKFylciYdQQ-1; Mon,
 28 Sep 2026 07:42:03 -0400
X-MC-Unique: lQ4Kth-gPn6aKFylciYdQQ-1
X-Mimecast-MFC-AGG-ID: lQ4Kth-gPn6aKFylciYdQQ_1790595721
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 548BC195607C;
	Mon, 28 Sep 2026 11:42:01 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.44.22.5])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 95EA81800345;
	Mon, 28 Sep 2026 11:42:00 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
	id 362E721E6A04; Mon, 28 Sep 2026 13:41:58 +0200 (CEST)
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
Subject: Re: [PATCH v4 40/55] meson: link shared objects into qemu-system
In-Reply-To: <20260926070057.1234-41-luoyonggang@gmail.com> (Yonggang Luo's
	message of "Sat, 26 Sep 2026 15:00:39 +0800")
References: <20260926070057.1234-1-luoyonggang@gmail.com>
	<20260926070057.1234-41-luoyonggang@gmail.com>
Date: Mon, 28 Sep 2026 13:41:58 +0200
Message-ID: <8733uthabd.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

Yonggang Luo <luoyonggang@gmail.com> writes:

> Extract common_ss, system_ss, and family-common objects into one
> qemu-system binary. Only arm, aarch64, microblaze-softmmu are
> listed; a new target must have arch_srcs equal to target_info_def
> only (target-info-def.c). Config headers stay in arch_genh.
>
> - Union non-TARGET_* keys with y taking precedence
> - Reject leftover arch_srcs on participating targets
> - Reject TARGET_* conditions on common_ss and system_ss
> - Link SDL, install the binary, and apply Darwin entitlements
>
> Adding a target that still has per-target sources fails meson, for
> example:
>
>   combined qemu-system leftover for :
>   expected:
>   target-info-def.c
>   arch_srcs:
>   target/microblaze/mmu.c
>   target/microblaze/machine.c
>   target-info-def.c
>
> Signed-off-by: Yonggang Luo <luoyonggang@gmail.com>

Watch query-target lie:

    $ qemu-system -S -nodefaults -display none -qmp stdio
    {"QMP": {"version": {"qemu": {"micro": 50, "minor": 1, "major": 11}, "package": "v11.1.0-1902-g88f617913a"}, "capabilities": ["oob"]}}
    qemu-system: warning: nic xlnx.xps-ethernetlite.0 has no peer
    {"execute": "qmp_capabilities", "arguments": {"enable": ["oob"]}}
    {"return": {}}
    {'execute': 'query-target'}
--> {"return": {"arch": "aarch64"}}

Perhaps you can fix this by reordering patches.  If you can't,
deficiencies like this one need a prominent mention in the commit
message.

