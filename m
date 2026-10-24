Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=162.62.57.87
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792825706;
	b=jg5bzVvzDJZI3LSOcdrQGsZoWmN4RiJFTcVWNCNMZwCCmpJhARmTUPmLnfKQoeG9GTIR
	 Vid719mfMt64As938i/7XDzTMOhNbhHs3OqSQLYs74fi74LlaA9i043La/xkvCBeu++PH
	 BX4sF5qw0E6wgPpFzzaquZ/MxFH9I5xmCWLSdvuZZ8CPDCHabPz+C2sUoGzxJfgj8Yk+T
	 NaTF4p0n3x/y2QB/hAIR32PhMXV3VXUEb6XQB32KL1+PUQt4lhzmxPhAL7RZXLi8+NoHE
	 ru0yis5zSnlMMjJFmgS8Col5XVR0fYWQZdRmlpHHw+421u/wQYay9/9OTQwhV80DdvQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792825706;
	h=DMARC-Filter:DKIM-Signature:Received:X-QQ-mid:Message-ID:
	 X-QQ-XMAILINFO:X-QQ-XMRINFO:From:To:Cc:Subject:Date:X-OQ-MSGID:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=HaKV5z1CC65RoYQfVwIuT9ZMwfPMgYntm6NNjyPnPlk=;
	b=W7q8usxG+PIo/ugnqliITq1B/3i5zcMbjW9H956FLsvCp3TKtQQUO3m8+jbKfPxDkTPj
	 DCKSLLoAC26PhHy8dpxlKV3M/0xX/m2mlyQwxH+1CV3ylb1iZG0wniFcMXbzKpBA3KJBp
	 v3V2SDrsJ/4yswvZ1JWf3ZdJIz0I6lHbLn+txqHj+qqaqIEWhAMRkPGCKb3kDUEO0Wfm5
	 CfeEyW7h56j5+7EqGkgvyBBpQ/oLdKjce/ogz+qI1xPcwVKAlzXr3yzTRjWUIFEcJWNEz
	 LiFm1NFRTtvmRiQMvImsZvrd1vzAo6v4Kt9lBYRIiPjHpToZI0KdXlhiqwYhU5Q1hfQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=qq.com;
	spf=pass smtp.mailfrom=qq.com;
	dkim=pass header.d=qq.com header.i=@qq.com header.a=rsa-sha256 header.s=s201512 header.b=AkhBJzsX;
	arc=none smtp.remote-ip=162.62.57.87
Received: from out162-62-57-87.mail.qq.com (out162-62-57-87.mail.qq.com [162.62.57.87])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58D0C606A31B;
	Sat, 24 Oct 2026 07:08:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 58D0C606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=qq.com header.i=@qq.com header.a=rsa-sha256 header.s=s201512 header.b=AkhBJzsX
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1792825699; bh=HaKV5z1CC65RoYQfVwIuT9ZMwfPMgYntm6NNjyPnPlk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=AkhBJzsXqmBR/6lWpRO5s8CSw1T8bZrGePf2wbxAY3kuPj+0lnSY45QRlbxq/nvIA
	 nNm5OyTFtDjmWd4U35ZIDUSKaEDnpHpyaaa8Z4/mekEuUsZ8ovavJ52cCl9MKtTR5G
	 gRL9VRL77IaV82fjYZIkkKJ6STAf/sjwaAoNjuEo=
Received: from [172.18.4.77] ([61.136.26.103])
	by newxmesmtplogicsvrszc43-0.qq.com (NewEsmtp) with SMTP
	id 2112D00F; Sat, 24 Oct 2026 15:08:17 +0800
X-QQ-mid: xmsmtpt1792825697tn3vr965b
Message-ID: <tencent_567CCAA268528DBF6F46AC9D4A4D21A3DE09@qq.com>
X-QQ-XMAILINFO: OATpkVjS499uk4xrax/RoKV623LYcoWqyUfVnetaSspuluEO1c/YE3jYfL3VDQ
	 MKd5QfUDrWOD6hNSJqiY+ZmkICbCcaht09QVzHCeS9oMZ2Qf/DrVr/oZvnZpEj8PK2LzNX5PiC89
	 7rB2DHfStDdCoB8qY1YzTGvtA0U3kJgubOrVMmgzfqGly6l/XiQ0ne4PW2vmHcM01Q8Ss3l+oYkZ
	 B4OREiaG8JHSXL+ZRMY/i1KmlHbmR/+qtJUSqlV4LUt4Jk8YGevWNkBtb241VKfXGU7orZJS2fjm
	 wDYUniG50EC1M+dl1kTCe8ReUfIUUDl4PkuaHcm/wtJtlXB16guezC3KSIx2vy09V068cRX8+9kj
	 nrnWC594eG19PbviWIR+hlG3ZefkCXAaKY26YxZRVa5Llbjrl+/4MoI+ku1B+lHDf1nxSf+GuX6S
	 /yeNnH+bBQNOOk/eiP1URgHYuCf4P+kmQftQhlO6RDAFL+7k6RtaNrTNfm94mRRBhhmpw4YRAAf9
	 dAPbkSpoSDuiMnNrGD5VD9IIzzKCheGdE9URPaHlMXixVKQf53qhBtAZ/NDY815gzblPTkg6HJ8s
	 TZlvkg1LgxWhYGZLAA/TbKjvx2g8riHyaY0+GiwCWWlzTBDtK6eIxPquJSfXwNxgjl8BX0tYO7Sm
	 uuFiciGrPCujnq1+38FcuHjEkGpHQ6U4+7ogs6iV92pRZ3emg7GZRp/fQWSvjG2Htrq1mr9vp8XY
	 9eCU4lQh8aLncWLnoO5+Gwm3oXZyVcd3zGj72pS5NIhjLnJKFhQAa5TS0NsVwou359IrYliZSwRV
	 oJzIotzuBHxuW17bBVQJnQl5pNsvodi3rmhK/DTgdPmpZeM8MYbS5yhnGfQjMEK4tpd0ZPz7cIm3
	 SyMmIf/43t51GaDY1RlOivsfcjr8BSitnMSyN6dhs9d6pWG2gy7sSCAOIoerbnQDKgq6gTjiJn+E
	 QM85uXBx0ZUshFfmpcol8mDSmAMakjBvH373Eadc4ZBppk1Fx88lSoG2YNb+A0YTJrLvZOeVCsq6
	 FLePdHjMGWwLAMGH4W7+5pC3SVuK/5x/tPOHLQXKGwuE2n5/dyQcIIxrjNEb3D0EZh0rzocgQF4Q
	 85PWu6Jpdt15YQJL4ayR2m3vtK3g==
X-QQ-XMRINFO: MSVp+SPm3vtSI1QTLgDHQqIV1w2oNKDqfg==
From: Guikun Yang <yangguikun19@qq.com>
To: Michael S. Tsirkin <mst@redhat.com>
Cc: kvm@vger.kernel.org, virtualization@lists.linux.dev, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] vhost/net: initialize the whole negotiated RX vnet header
Date: Sat, 24 Oct 2026 15:08:15 +0800
X-OQ-MSGID: <20261024150815.36216-vhost-yangguikun19@qq.com>
In-Reply-To: <20261023080824-mutt-send-email-mst@kernel.org>
References: <tencent_803981983647D9F9444561A4227F138C600A@qq.com> <20261023080824-mutt-send-email-mst@kernel.org> <20261024101101.71420-vhost-yangguikun19@qq.com>
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Sat, Oct 24, 2026 at 02:45:39AM -0400, Michael S. Tsirkin wrote:
> Ah, no IFF_VNET_HDR *with* vhost. That's a weird combination.
>
> Apologies. TUN_VNET_TNL_SIZE is an internal macro that header size
> is set it. TUNSETVNETHDRSZ is what I meant.
>
> I have in mind simply disabling this combo: vhost + !IFF_VNET_HDR)
>
> I'll research a bit whether anything anywhere could reasonably
> use it.
>
> Can you reproduce any problem *with* IFF_VNET_HDR?

Yes.  I added IFF_VNET_HDR + TUNSETVNETHDRSZ(24) to the repro
(in addition to VHOST_SET_FEATURES_ARRAY with the tunnel GSO bits
and VHOST_NET_F_VIRTIO_NET_HDR):

	tap ifindex = 20482
	TUNSETVNETHDRSZ(24) ok
	tap attached to RX vq

	--- RX buffer first 32 bytes (initially all 0xAA) ---
	hdr: aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa
	     aa aa aa aa aa aa aa aa 00 00 00 00 00 00 00 00

The entire 24-byte vnet header area is stale 0xAA fill — including
offsets 0..9 where vhost is supposed to write the virtio_net_hdr.
The payload (from the host) starts at offset 24.

So the uninitialized vnet header is observable in both configurations:
with and without IFF_VNET_HDR on the tun device.

Note that with IFF_VNET_HDR enabled, the RX buffer is also corrupted
in a different way: the tun device prepends its own 24-byte vnet
header to the data it sends to vhost, and handle_rx() with
sock_hlen = 0 does not skip it.  So even if the virtio_net_hdr
were properly written, the payload delivered to the guest would
be shifted by 24 bytes.

Best,
Guikun Yang

