Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.129.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795374851;
	b=cHomxu3T8Ny3hSa+O5IJTioe/i1UTOuoN8ZsDCxrb70DDbiZMJsWELB9+eSbw1wwJ8T3
	 nspFMDGmSLusf7sFJklniPe9ZwQmTSj4qbYi9SiBQDczz0b/xOLXjdm29iiGIIcUBC1Pu
	 xrJKQ2JaTQGmJlEfPEcUacqodMvGVKyIVphzR3jF7oJTaOkl0CxwVg+qbhf0wsGSAun0b
	 4Nr3M2WJkg9qMQmHoCN1Fyw82gsV4p9HM+12ASYduPkTvnjjzc/UF1LU1DA+fL5DVfH3q
	 XmgYlxYOuYYRJwPSPTWsKg+jT7n45WJCotWoP8RLwcj3SWJXv113tO4oskrX02Jg9Hw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795374851;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=SPoTViWJGHL7QSLz+I0tDgbdnIX9thSbIOpbmEgxuw8=;
	b=UOxrt3iwc6Uswcdm6CcrDmrXFffHwvQGFGUEVYhKEv4JutcwVkNOdfWXelhsNiPrkzqw
	 9xYsSlYeFt1hOb9PgTPzdwXqNO/U8bG5rDpZnVO9UXTGnCTNDQP2lFYLgcmOPZ+2FQFXf
	 8peigEN6Gr4aQ6asS4vQ6pOTR3MLbpeXoJfVvfMTU5sYLseGNzEH46OUPvEHs2e/mrLgS
	 ijzbZFOJDHmLqBoexCc41UP9RduyYHgunSK1AsQ+C7UFmC4xQdIFVXG5LNb+yBolxo3v9
	 pFZPK9JVS01eJEpVC6WEq1QzXLNaHRxOLoBOmiaY+C50/rXDpDedE5G7lCuQesuxxPw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=ZpAwrYuL;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=I+9gw4J3;
	arc=none smtp.remote-ip=170.10.129.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A0C9606A320
	for <kvm@vger.kernel.org>; Sun, 22 Nov 2026 19:14:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5A0C9606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=ZpAwrYuL;
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=I+9gw4J3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1795374850;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=SPoTViWJGHL7QSLz+I0tDgbdnIX9thSbIOpbmEgxuw8=;
	b=ZpAwrYuLf5EdLloLxtncynvxdkf3IrcU3uWbIR/1vn8nDClXS68XwwZqoZEaHb4EEWypM7
	if1l767wKwZ72NATFFD+S78SrI6tfnWhXMGf6KGmtG31XeFcBx1KlJPtHHT/yLha4LI1b3
	bO8IaXfLRF2/9MoTLpg/x08hhJSGBzw=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-211-_eqn8H_gP3KRW8gBuly_vA-1; Sun, 22 Nov 2026 19:14:08 +0000
X-MC-Unique: _eqn8H_gP3KRW8gBuly_vA-1
X-Mimecast-MFC-AGG-ID: _eqn8H_gP3KRW8gBuly_vA_1795374847
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-48e0af48c18so1574892f8f.2
        for <kvm@vger.kernel.org>; Sun, 22 Nov 2026 11:14:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1795374847; x=1795979647; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=SPoTViWJGHL7QSLz+I0tDgbdnIX9thSbIOpbmEgxuw8=;
        b=I+9gw4J3CXiFaFKNO8WIQqKcUIlUxmMmLmeqeDzziAmXvCXmDmgPzFJrv1qGn61o9i
         Lr3kEFiyPxYYT8ELEJS2aIroU6GwFekZNB7ohrLW5gm97gAwuRUbv0cNOZtkdNjHtO9+
         P2MyFgopF4CcvZij8UHwjiiicla7IY2Pr6o2anJI+75rTB6OJPfQlIFQCKA0PWmHPN04
         3qQy0rnJRuECatkNhiUkUEWO48rl5O8aNwbGNRr5NpqaMTlizV0rZipvIs8odH/R1le/
         ZWNM0BdgolBZ5KBFI2ImmGtSGSCALIH9dX+t2tmX8p33ZpQngxHj6NZlnuDEQT2drhLO
         2EkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795374847; x=1795979647;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=SPoTViWJGHL7QSLz+I0tDgbdnIX9thSbIOpbmEgxuw8=;
        b=JrQr3iUU01jK16z9wrfeGDQ6UKhsedv1pDrFZ+/mMe1xJjn4Lup+sdaMoQZshTD1uz
         GatesEqIjSiaDZxAxfOMfNtJY2evHnLAasn++9vOZlVl86h9XtZ8nMfQ71IS0RNRWQaS
         kmTt4kjT28zGj7zYmHLmV9pIoUwVdB+o6bzUyuuHpQjX/6cmxZpihVSU4d4oGeMIvv28
         KsYWWPWXDgjwgdyirE7qRB4IUfDowfIrKuj28WXk9Gu+//5vRUa8YeAArpdGmDk572AQ
         /fUm2ab6Pc8niD08QPjsrc1kPUKRd/MjrbZx6FSN1xAmhM2zhnY8MKPPO9eDkWU/7Kpb
         0f9g==
X-Forwarded-Encrypted: i=1; AL+hErEMAw+Ee+qPzDqZD6yWp6R3QSn78jxwa1h7mUEkYDp//IWSHhSuRsjpvABKTUfVZdprSsQ=@vger.kernel.org
X-Gm-Message-State: APuU4Z/Kwcc/eZSze+Qzvl3svhgYdy0G03VvL0C4jP43vHD1jzKhzC3I
	y7ZdG3FmjWMidZvQ25OwEP1v3q7ACEPg95fpzqqSOpa19JDJvdWBl4515hjCAo3f02fW2DuAjES
	AYW70oQ1KuDsMVZoDCXad7joDQARiKgWELURekKRNO8Me3CsYszljIA==
X-Gm-Gg: AZFdTZfQq6mjatHyfuR/AsPUpDIekNcJ+eZhGD78geLeFO9Hz8iPI+jS7VR/f9qQfda
	Fgky66cKaBzwxK3FUqSoPjJplj3LDPktLxQ38KA2IoZWd+sFiPk58rYxyIZsGA+Q/LINn9d3QMm
	9krU05zmBGhTgQJOUbDQnSaRKJ+LAH36jDY8gSjcSAv112pyJDO7TxEclJ8WG06cP8QXV63lCPP
	o5pH0KsScLomrbjcmzPlmmwbEe6MroetWx1U6NXYvpMwZqg2mCVebDDeuG0VP8hWSZpV/psFUdJ
	XxkiT+OGBons458nHf4sgGU6PL3eIc37RyGf3Z9XgRnp6XqEovEYELw+IeViD8iVkfRFY7Q+uZP
	JCoQMdWPeY99c93qex2s/i7GuxWe20DLEoT8WMoNE
X-Received: by 2002:a05:600c:3b8c:b0:4b7:6c16:7b43 with SMTP id 5b1f17b1804b1-4bb8881d019mr195708845e9.10.1795374847338;
        Sun, 22 Nov 2026 11:14:07 -0800 (PST)
X-Received: by 2002:a05:600c:3b8c:b0:4b7:6c16:7b43 with SMTP id 5b1f17b1804b1-4bb8881d019mr195708385e9.10.1795374846810;
        Sun, 22 Nov 2026 11:14:06 -0800 (PST)
Received: from redhat.com ([2a0d:6fc0:1524:9e00:c39b:a740:e7:3fcf])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb90660cb4sm198874085e9.2.2026.11.22.11.14.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Nov 2026 11:14:06 -0800 (PST)
Date: Sun, 22 Nov 2026 14:14:03 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Hengyu Liang <hengyul@cs.unc.edu>
Cc: Jason Wang <jasowangio@gmail.com>,
	Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
	Paolo Abeni <pabeni@redhat.com>, kvm@vger.kernel.org,
	virtualization@lists.linux.dev, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] vhost/net: bound the count of VHOST_SET_FEATURES_ARRAY
Message-ID: <20261122134901-mutt-send-email-mst@kernel.org>
References: <20261122092235-mutt-send-email-mst@kernel.org>
 <20261122143829.2674252-1-hengyul@cs.unc.edu>
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261122143829.2674252-1-hengyul@cs.unc.edu>

On Sun, Nov 22, 2026 at 09:38:29AM -0500, Hengyu Liang wrote:
> On Sun, Nov 22, 2026 at 09:25:37AM -0500, Michael S. Tsirkin wrote:
> > this is followed by:
> >
> >                 virtio_features_zero(all_features);
> >                 argp += sizeof(u64);
> >                 copied = min(count, (u64)VIRTIO_FEATURES_U64S);
> >                 if (copy_from_user(all_features, argp, copied * sizeof(u64)))
> >                         return -EFAULT;
> >
> > copies at most 8 bytes.
> >
> >
> > did you test that this patch actually helps anything?
> 
> That first copy is bounded, yes. The unbounded part is the loop right
> after it, which is outside the diff context:
> 
> 		for (i = copied; i < count; ++i) {
> 			if (copy_from_user(&features, featurep + 1 + i,
> 					   sizeof(features)))
> 				return -EFAULT;
> 			if (features)
> 				return -EOPNOTSUPP;
> 		}

I see. So all it is doing is checking that these features
are > 0 and erroring out.
Let's just not do it - we don't have to.


> It reads one u64 per iteration up to the count from user space. With
> count = U64_MAX and a large zero-filled mapping, it only stops at the
> first unreadable address.
> 
> Yes, I tested it, on the vhost tree at 44293796526f (KASAN + lockdep),
> count = U64_MAX:
> 
>   1 GiB zero-filled mapping:
>     without the patch: EFAULT after 27.4 s
>     with the patch:    E2BIG at once
> 
>   2 GiB mapping, SIGKILL sent 1 s into the ioctl:
>     without the patch: the process is reaped 46.7 s after the kill
>     with the patch:    the ioctl has already returned
> 
> I have a small reproducer (a few lines of C). Since I found this with
> the help of an LLM, Documentation/process/security-bugs.rst asks me to
> treat it as public and not post the reproducer to a public list, so I
> have not included it here. I am happy to send it to you off-list if it
> would help.
> 
> Thanks,
> Hengyu

