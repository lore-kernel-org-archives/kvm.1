Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=176.119.200.168
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793809103;
	b=CZg/x6U4gtUGEk2abtnDHIZTUqGtAZbUfKknxsvPR64EtZOwNj7KSxZm6bGunGIhGk2P
	 pHbZ2+EsCTgyPL7CQqmz+CxatoIj8A55wEb8kISEWDZIXHFSfzgWpOJnd4LVr1yvnxkVy
	 GQu4usY3ZDrF0GzIvXw/Q3dVwAEN6TQDkGByziJCr0l7txm3sA0oYcnf3iJ1+qFCT9NNT
	 JSRGA74V/ZX5CZ5d/gI8ji3MfUYNVWvMdDgEF1/5tVCHqmwgX72zoKnrl34Wr/wWBLKXa
	 XWggmMWh4eQwdLViuTrOP6CFGnRmutg0f4xhzA6Vqm76fOSnkh9dtH1CQuCrFeUZxOg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793809103;
	h=DMARC-Filter:DKIM-Signature:Date:Subject:In-Reply-To:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:From:To:Cc:Message-ID:
	 References:X-SimpleLogin-Type:X-SimpleLogin-EmailLog-ID:
	 X-SimpleLogin-Want-Signing;
	bh=/rQmXVkHiDzs2uGaSf1glcnE9dLrPSRCk+lZ+qfQqGw=;
	b=FwND+xvhtdmotYm2nX9FhO5ztyFfQWwzrBSUAYz6gltfdYFsNvfOMLlfja4Pzc4b6Y1+
	 eb50MZCz2TNi653nt8e0Yd5kNqHkvWW7v4TC0zGdA5ZJfNVNO5OWoLaxCGIfMu1E0KVW0
	 /1XIwLMs/QKh24MnGY7hvbfZH0tUBox+jRI5spkrEMEfyZKO4ZbKA2W3tGapg2Kaxg8jc
	 rsXrHid9w3ECshTLtm+aPgjQ1Nfx1Jakz8i6EmGYj7LJBFYOsG+MaXNKN8dbEHvZFM5cf
	 gisMhrAZMVgBA/y5YlI0uJoH+RNfvLfjPGMUctyzYhZ8z1FUwPY6vIRogsV67f+k49w==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=eldare.de;
	spf=pass smtp.mailfrom=eldare.de;
	dkim=pass header.d=eldare.de header.i=@eldare.de header.a=rsa-sha256 header.s=dkim header.b=ghdJBJRf;
	arc=pass header.oldest-pass=0 smtp.remote-ip=176.119.200.168
Received: from mail-200168.simplelogin.co (mail-200168.simplelogin.co [176.119.200.168])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F85960A3819
	for <kvm@vger.kernel.org>; Wed,  4 Nov 2026 16:18:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4F85960A3819
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=eldare.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=eldare.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=eldare.de header.i=@eldare.de header.a=rsa-sha256 header.s=dkim header.b=ghdJBJRf
ARC-Seal: i=1; a=rsa-sha256; d=simplelogin.co; s=arc-20230626; t=1793809094;
	cv=none; b=1VP9iYRylYINIHbs5+9vtCtaKYXesSDZf+YOeP7G34ILUP+hV6lGEEQxgklL0dprshA/tE9TnzFyjVyQbxLnW4n7iuUe3VRdAh2TtuMDR4jHHrMArh2EsDtY2Fx6AAYSV2c8oZQ3dbYaIAF9lBIw2AuhE0VFT/NsVEgbX07Oc9ymlNOBJACpiXTaeuYKBqh63JT8ZHQU1kMiHJf0yyvNEWgxh5a4QODWuUInIcZMfbYd4BSeohEpAfwmtMMfnauWh/tx7PVQ5c8k+riggPSE19nja76cc2EMvTDCVEXiwujcifYdV6xDLBnuRVvnz96GzrfOnCfm/wEmsW7wIhOuMg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=simplelogin.co; s=arc-20230626;
	t=1793809094; c=relaxed/simple;
	bh=/rQmXVkHiDzs2uGaSf1glcnE9dLrPSRCk+lZ+qfQqGw=;
	h=Date:Subject:In-Reply-To:From:To:Cc:References; b=gPlSu2IixwxcUI0fEK1skmYEq7uWoFQWmx0iWwiJvfMAGADwOXC12FeBrVF8UWptpF9S7lH36mAbGSy1wXzRn49KWCW5dq3C26lWf7AJy/gZPLGpAFRrB4ESwYavDBDwQuo5fWvFyN5QBIsfinTaniiykckgrxPFYQltjzvdKD6Xc9hBXvYDdhlvh1j3SO4E3lo5ICxwMKrvGTByy2lPHS4jMWpOT+rzCnRYyuhtf40PgjlkGYqlAF49yQEfEaO04PRrHJo0Udd9ph2YNpzLjAmmu5i8Itfjs4xPt7xiJ2Up3H8RYz2J2bb2GjBG0n9fBhTVGt6IMapJi9CLr8cx5w==
ARC-Authentication-Results: i=1; mail.protonmail.ch
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=eldare.de; s=dkim;
	t=1793809094;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/rQmXVkHiDzs2uGaSf1glcnE9dLrPSRCk+lZ+qfQqGw=;
	b=ghdJBJRfdCNCd2H10dVINfqaQm6plnB//autMdrWqV2R8z8BlVgcuweshPuqlRAb7YdNXz
	VyzDhXqWvFS5SRKwkj846kQiGncv4WGD5Tl2MQgQCyfPx8XjuAKZT8o13qM7RdAoKmnt2D
	hJrW2lUwJKbnicxFvbgoQ8FGlPTcbhA=
Date: Wed, 04 Nov 2026 16:18:06 +0000
Subject: Re: [PATCH net v2] vsock/virtio: clear vqs[] to avoid a UAF on a
 failed PM restore
In-Reply-To: <20261030101918-mutt-send-email-mst@kernel.org>
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From: jrmmhm.kernel@eldare.de
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Stefano Garzarella <sgarzare@redhat.com>,Stefan Hajnoczi
 <stefanha@redhat.com>,Bobby Eshleman <bobbyeshleman@meta.com>,Jason Wang
 <jasowangio@gmail.com>,=?utf-8?q?Eugenio_P=C3=A9rez?=
 <eperezma@redhat.com>,Xuan Zhuo <xuanzhuo@linux.alibaba.com>,"David S.
 Miller" <davem@davemloft.net>,Eric Dumazet <edumazet@kernel.org>,Jakub
 Kicinski <kuba@kernel.org>,Paolo Abeni <pabeni@redhat.com>,Simon Horman
 <horms@kernel.org>,virtualization@lists.linux.dev,kvm@vger.kernel.org,netdev@vger.kernel.org,linux-kernel@vger.kernel.org,stable@vger.kernel.org
Message-ID: <179380909424.8.665274581449917096.1746194870@eldare.de>
References: <20261028-vsock-restore-uaf-send-v2-1-675aad6da714@eldare.de>
 <auSZtMqcTz3r1nRk@sgarzare-redhat>
 <20261030101918-mutt-send-email-mst@kernel.org>
X-SimpleLogin-Type: Reply
X-SimpleLogin-EmailLog-ID: 1746194893
X-SimpleLogin-Want-Signing: yes

On Fri, Oct 30, 2026 at 10:21:09AM -0400, Michael S. Tsirkin wrote:
> On Fri, Oct 30, 2026 at 02:51:26PM +0100, Stefano Garzarella wrote:
> > Do we really need to write in a commit message that checkpatch.pl --str=
ict
> > is clean?

No, v3 will drop it.

> Yea please write it yourself and make it concise. My eyes glazed over
> in the 1st paragraph.

Point taken. v3 will have a commit message shorter than the diff.

> > This is already in the commit description, no?

Yes, v3 will have it in the commit message only.

> > I guess this issue could be spread around virtio drivers, so would be n=
ice
> > to add common API in the virtio core to be used in all of them.

Agreed, that would be a good follow-up; this patch stays the minimal fix.

Thanks for the reviews,
Jerome

