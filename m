Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32E7D3B19C0
	for <kvm@vger.kernel.org>; Wed, 25 Mar 2026 10:30:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=170.10.129.124
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774434615; cv=pass; b=tjTVY4UZcP5eNdBUOK2btJRsXcic9j/XnweOCfc0OwhweOuHWvo5Xg5m3GZQlVF0wDu0omi77n47oeNsALANG5pdUhKjJ4G96Oopct0HSxu1mldvj/v3jWTmEyBzDrkSFk0sPJX1Rz9vaNZePpSDrkSf/YJPCyreTWYRoTfQjQY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774434615; c=relaxed/simple;
	bh=/K5iqj5J8A8j5wcmdQiIufBmU70hAoQ2waLIeUNzh0k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Vkj9TgMicIIhXinni2FMJXpEAdhHOAGC8wta0jmCgxOmOpOcFul0QzF7mi/PFMeW+mLIDLTj7mpDjgRRWsipvMKwRCTCIPz0bTC/jT/LBf8g9vFWb4MsCQzAmT+Orha3Z8M/HDsiOzi0jRCw1FHbzxGId0OoDuPtk9kcov7qNYI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=GbMbuNul; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=P/FW5e87; arc=pass smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GbMbuNul";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="P/FW5e87"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1774434611;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/K5iqj5J8A8j5wcmdQiIufBmU70hAoQ2waLIeUNzh0k=;
	b=GbMbuNulZ2DMXP7jYJIPBY4f3nKpPNNTzlxq9jAxb3TCZXSXiE4aDQxMRhg+YgPkmLLLJk
	csRszK4EFs1OD0vAMcI6GPA355nWW11Hdf/fEvV+w19py4SdQfjZMWUj2dMaL4yS8CjBgl
	rsOnW7gXs0qJ72qnvpy/LQrnW0uDSK8=
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-331-bfhFf6QfNROyB984sel2bw-1; Wed, 25 Mar 2026 06:30:09 -0400
X-MC-Unique: bfhFf6QfNROyB984sel2bw-1
X-Mimecast-MFC-AGG-ID: bfhFf6QfNROyB984sel2bw_1774434608
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-35641c14663so8374389a91.2
        for <kvm@vger.kernel.org>; Wed, 25 Mar 2026 03:30:09 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774434608; cv=none;
        d=google.com; s=arc-20240605;
        b=CBFmXs0mnTxNmJr9LBovkdb0dPMVA1sKNXbLbV0riPPd2WLsjNJVLTMMhdIwknJ1jQ
         Z5uZvoZVfvLCn5EN/mno1zazYqxeAh73IBvslC4zmk1t4EIRvx80jNbjZQ4eF3y8wMDw
         xHbIhWhve+2jqVduvzmnLQSyR0QN21z4vWWM1M/BGzO7SjGEjMxLcvzSuhY30vkxwuTI
         TXAdeExMjhgAKhv1gckFC/ZXwiEhksMakD2+oQzDunk9LQXXBZnWiy9tbE8LN5b2Fjsf
         VMRz9MC/sw6YzVRYCkgQVag6nG0jjrHhKw/x33o2ym1/EjVSk9ooixMQeY1UwX9WBQ8d
         V1/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=/K5iqj5J8A8j5wcmdQiIufBmU70hAoQ2waLIeUNzh0k=;
        fh=Q2RHMWFF2sbB4PihXxYSBqE3AR9nxIKmxRQ0pC2X6oY=;
        b=BwqOSknPIeK5P2HQMfvivyIttrm8NAPj6fOubnZRD38qspvQeZirul5kQl5HzU+fnf
         s4B1nm20Jypxfa3NBW6OCCmzFBSAIGGpNQoy8okwm0XOxNImONuWbLtj/gyqFTQhQcAn
         Qn/5eGqTdwBxcW8HYoOMw0+oL5/VJSPqASj2T5cRyhpk4BeKNoNQABhYjIWdJek4TZjM
         x8NXQjZ5x/VAtNwZBgLuI/f2pO2BkI6dHhrKjRcETH32rpA05uTAY9vJ/bzkl+SSRypF
         v0Qiv/dX/WJAAKsjzGnyRDFercr/kAi4YCXAaQA06q4SfsyjPwKYNZPYjCLm8HYTxB4M
         H0ug==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1774434608; x=1775039408; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/K5iqj5J8A8j5wcmdQiIufBmU70hAoQ2waLIeUNzh0k=;
        b=P/FW5e878DV53HgU+ob9jexpu6vTYc6d4RWmhS7HD6u4fYLiL68bPv9wKv3cnLeLeE
         4Ms3oLw35EDqpVh3Hl34cL8ImDa1YYVtCH/kg9bfHXdlynmZw8tEbCXN1NH6LnUzWRrd
         UDxnldioS6DzF8M+PorP40mE8Go4Szf6XdWU9BWGIlzy7K5EmFQWM0kgzlyXMjIqh6Wd
         kzQuJLJmU9BcOes8nd6pioL218opiR09lAjsdcGA8qqVaBijz8pmlriNK8f9vrPNOmwK
         794plhGfQludVnyvqo2WZPO0lILqQYLPO+GxcIopbHbgEs5PFc4yzoRtTQ9w+D4z8MAa
         qOlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774434608; x=1775039408;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=/K5iqj5J8A8j5wcmdQiIufBmU70hAoQ2waLIeUNzh0k=;
        b=jHYAcRKh26+4aq/omZjZzIfF+etCbGnXU5Iz3r80Mw9pFisjw9hCRhL0ErMwSRXM6A
         uUvQs3XvGHGEipDjpKDwdlj0pyeA5gZ6AWGFt0A6XRU6xCIGr2++dJ7QInH27BS6z7wJ
         kwQOkf7+LxqDMyhmeYwq80KH8ZUsuUqYRRITLP8iKp9TNIG6Q2PmblNXJkJ2uS6JHthy
         vA4rAjtIYL0OdT4bujDJkdHIXMowzgUimlUUoSFu/TUhw8Uik6Lo6YHY0er+fCH2u6rc
         qy5paG1fbO6rH1qa8/6dtgM3rvySgLNLHK8iwvhT0kJktIw6qX3+XWgtfD2zC50pLnjK
         v98g==
X-Forwarded-Encrypted: i=1; AJvYcCURmiuD70wAp6iWRxs68Mb5sSbbX53IAMTYXBgocpK9/x2WUuJuCfcWNkpTV6HWGJlNs+4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzAT9buUpNp6NtGzDwMkDKTkdDglbUJYUN7iFRQ7H9aHSxwJS5P
	+vxcSDjyo2R1R1vReqr0hL+9nVshSO6UG4nFP2U6/QCmAaMXhYua9zND8dQdN00LEtlN7pA16Tq
	uNY0SgVbz7iSpAhXtsbJ/wlPxXWMM/HvVJTSZSjNkX57xpvsVp07Qhu5KcRYuHlO0puYmBhjqoN
	8THTjL068BqoJlCi3nyFItqWHEMndO
X-Gm-Gg: ATEYQzyFbrp+rDZvFbP0Q/nWaJIVH1XYeN1FcKG1agdR42cUJoq5jufL4tPB9OQYKDO
	0B0rMQ4OywPY+2epTw+EwHtWwXc3odY0k7hJ217ZI9QvMKRrQHoNmO1eXxOf/vEXZBZTgQa4FeJ
	1EJl2AGi2Jn25uwplLlL4jeNkpxkmrZGByVqA1Je8+Sn+r8muZcCccItnzeyYLa3FcnRZT1yfDp
	CT6BuIsx9gs8r2bj5XjXMQNdsJoeOc/ftLe10nCn6/RivNHsXSsLoIpt6aFfQjBbm+zznUSU7K0
	6KcYpN3B8plfYujBHn04gh0=
X-Received: by 2002:a05:6a20:728a:b0:398:7ffe:472f with SMTP id adf61e73a8af0-39c4abb1a20mr3399652637.2.1774434608274;
        Wed, 25 Mar 2026 03:30:08 -0700 (PDT)
X-Received: by 2002:a05:6a20:728a:b0:398:7ffe:472f with SMTP id
 adf61e73a8af0-39c4abb1a20mr3399621637.2.1774434607795; Wed, 25 Mar 2026
 03:30:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260324-tdx-hotplug-fixes-v1-0-8f29f2c17278@redhat.com>
 <20260324-tdx-hotplug-fixes-v1-2-8f29f2c17278@redhat.com> <56190adc345148396ba6b3e52672e662145f7dc7.camel@intel.com>
In-Reply-To: <56190adc345148396ba6b3e52672e662145f7dc7.camel@intel.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Date: Wed, 25 Mar 2026 14:29:56 +0400
X-Gm-Features: AaiRm50voWV5PH3kvip0CwHf2r5p2rX7ohXoogSeVkiXyqdnWEryejEwneqFxjo
Message-ID: <CAMxuvaytU-pM+rviUbNGWMhvbAYutwvaSXW_O=sn+QfOzF35Xw@mail.gmail.com>
Subject: Re: [PATCH 2/2] x86/tdx: Accept hotplugged memory before online
To: "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
Cc: "bp@alien8.de" <bp@alien8.de>, "kas@kernel.org" <kas@kernel.org>, "hpa@zytor.com" <hpa@zytor.com>, 
	"mingo@redhat.com" <mingo@redhat.com>, "x86@kernel.org" <x86@kernel.org>, "tglx@kernel.org" <tglx@kernel.org>, 
	"dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>, "Qiang, Chenyi" <chenyi.qiang@intel.com>, 
	"kvm@vger.kernel.org" <kvm@vger.kernel.org>, 
	"linux-coco@lists.linux.dev" <linux-coco@lists.linux.dev>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "Bonzini, Paolo" <pbonzini@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi

On Wed, Mar 25, 2026 at 2:04=E2=80=AFAM Edgecombe, Rick P
<rick.p.edgecombe@intel.com> wrote:
>
> On Tue, 2026-03-24 at 19:21 +0400, Marc-Andr=C3=A9 Lureau wrote:
> > In TDX guests, hotplugged memory (e.g., via virtio-mem) is never
> > accepted before use. The first access triggers a fatal "SEPT entry in
> > PENDING state" EPT violation and KVM terminates the guest.
> >
> > Fix this by registering a MEM_GOING_ONLINE memory hotplug notifier that
> > calls tdx_accept_memory() for the range being onlined.
> >
> > The notifier returns NOTIFY_BAD on acceptance failure, preventing the
> > memory from going online.
>
> Does this depend on patch 1 somehow?

Yes, if I plug, unplug and plug again I get this without PATCH 1:
[root@rhel10-server ~]# [ 5707.392231] virtio_mem virtio5: plugged
size: 0x80000000
[ 5707.395583] virtio_mem virtio5: requested size: 0x0

[root@rhel10-server ~]# [ 5714.648501] virtio_mem virtio5: plugged
size: 0x2e00000
[ 5714.651808] virtio_mem virtio5: requested size: 0x80000000
[ 5714.676296] tdx: Failed to accept memory [0x108000000, 0x110000000)
[ 5714.683980] tdx: Failed to accept memory [0x110000000, 0x118000000)
[ 5714.686997] tdx: Failed to accept memory [0x140000000, 0x148000000)
[ 5714.689989] tdx: Failed to accept memory [0x128000000, 0x130000000)
[ 5714.694981] tdx: Failed to accept memory [0x148000000, 0x150000000)
[ 5714.704064] tdx: Failed to accept memory [0x138000000, 0x140000000)
[ 5714.710144] tdx: Failed to accept memory [0x118000000, 0x120000000)
[ 5714.722532] tdx: Failed to accept memory [0x130000000, 0x138000000)

My understanding is that QEMU should eventually unplug the memory and
PUNCH_HOLE then KVM should TDH.MEM.PAGE.REMOVE, but that doesn't seem
to happen. Is this strictly required? According to the specification,
it may not be.

