Received: from mail-qk1-f176.google.com (mail-qk1-f176.google.com [209.85.222.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9128943F4AC
	for <kvm@vger.kernel.org>; Thu, 20 Aug 2026 12:26:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.222.176
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787228811; cv=pass; b=A9rOVrwu4c6vTG31tqSbhThp+ssu7wwMsp1Brb8Tj5ScRu7NqFR+E1RwkKVvz1O67jv9sRj5E7QBZGdtBCDPcx7Y6JLaANijAOSqJIce4kj7Ux4tndazL57innjd6+Qqar23eO9XBWcP0XaqqI02rrQhvvmuUDcDxqEmh6wKzP8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787228811; c=relaxed/simple;
	bh=IGs71nhOgGaVjpIG8DskqbqnZo+eShOgII8VvXDhzeY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hEie3xdfDxNG2qkqn1F0YCHewfjtgSzNFnwf6B00oKJW6MbBfilDjUMLy1ES6KLwdcDg+BCelLfAjkEDpiJXJhwbxTNQKehFfoZdBShRWti1Wdt8yws/GwA7TtRqZ+1JOjvXDkfwn4KRkvcHGM4ltl3lsMLSzNcVC77O4Kx2+JM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=n5hwfWIP; arc=pass smtp.client-ip=209.85.222.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="n5hwfWIP"
Received: by mail-qk1-f176.google.com with SMTP id af79cd13be357-92e54f8c051so120144785a.3
        for <kvm@vger.kernel.org>; Thu, 20 Aug 2026 05:26:49 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787228808; cv=none;
        d=google.com; s=arc-20260327;
        b=L3+HgEVLpaiwo+4Bi7AeALPZj4PWrCON2PrFQncIPATQMVE9+7XFvVO01pjYG9LIVz
         tKy1nng92xTrxZAfT6WecQSKYweNsMS2dRQvC9R5Yjee5sxX3PAOfiQXbnxxG5GGPvjG
         oWzop3ugDzgjyUfqQz/esLLO4Kwq5oqBH1Tr4VYrdwP/DSESxRae439d6t4nD7A7IbNH
         t0IuN8gtlbPwFukOKOzlA5h+IOZNQkz31zhe3bRnievuooxSbfuNz1ErNnSnZy/MpAE1
         qd5XI/qLUfgDODUw01L7kTa5MSu/+0b1qlLH7SfFoMQqsBhIMggAJSM7uZHwIuFlwfhL
         OEbg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=ngnJnixAtK4fZ8jMYvDkCA0g5N99ucaPAuQOZK7BSJU=;
        fh=l6PEW0+mHZ6jY0CJhozZrESJ/VwfoUuV8NxujAGKFbI=;
        b=YtdfRSL7PAWRTXFtbGWtRjFKZQO3h50m3FHhtmnDtL8KxjLjr9UDJyJZJfdJsE1ZDQ
         aid0UTMaDFmrhrnkQgMBTHb3dUuyJcMeU8w8INcGqy9CfUjUvAgtPHvS95QY8X7qcW6k
         2Ztq/zXxNxfAZRRSwMIeUsxy6fjaH3SdO8c9Dx+0j+liFKeu8OE0hCsFB6sS/jmX+JXw
         6FJiIFtqPmJrTEI4juPX0spD5qPkQ4R1CrATL+BUgxOvcInqpuJpBNn1AOmaEfe7eUAc
         uRY5OLgTrMKaujPw+LZee1kqbbxDuwLxlrUUY83ASrl4ta1t4WnTndTMRDYiUsVow36L
         9KAw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787228808; x=1787833608; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=ngnJnixAtK4fZ8jMYvDkCA0g5N99ucaPAuQOZK7BSJU=;
        b=n5hwfWIPnqF1ljShQcy5zoTE5GLPMvGnaEpSX5fb0bFKTYz8r1eMO9lzK8cRJwkNMM
         kwvSZj1LzdjgnaISVOSGsMY5lr3yA73GLej2msR0y0NQw/rW9weA/eY0jwTg71wpOC5P
         kIG/SFSOwz3olA/H4fLSs1gzX4N2cT/xytHrinYtCmG/NXOnQbt1LEAX/D9OqNIkyt+T
         Libb9QJlpBhlN7nOnFkSDKfut5WsBWtw1iOxaZ8wq9y7NNAUWgf9/MiQ+JlMS/aBEZJM
         NJLMot1DOyOkS0p86xCsyjZs8YLkHsAxUtndSlXagC99dhMD7hxvUwRq8wyTgjlEFgoL
         fJoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787228808; x=1787833608;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ngnJnixAtK4fZ8jMYvDkCA0g5N99ucaPAuQOZK7BSJU=;
        b=fuZnHtXitlHBPXokXSQanQtNiJAYxeX55ut3DBTlrShJhIWQKADZtmSNMKqhIDP98I
         PddEQlKEy5K3d/Tz8NAvtpWsQt4EMJigP4pTiHYGsnWjXjz4uXnAw88nEqPBEB1EF95w
         TleuvRVAQQ4EmZMYUgfKZjKnCeOfsNok3e5aO/AvngKx1T+K7DydRWxGYImyxzMPYXSn
         e715JHtx3lqsa2YXFgtgS4NQ+xRNvVp/gyGaIpYpKooo0thTcE5TsSmzQhRfD+54yY8o
         cXi4i0dTEbJDUhB6vTUJymKfCvSzN2BVDVgge3/Dlds+t7DEa1WN/JQZMjR2JfxXHayr
         1IwQ==
X-Forwarded-Encrypted: i=1; AHgh+RqvZBzWit/D/tiAEN7nZaQSgYTE6RqRnA+4oBaBNZ5z8+L5IPgsNvBcyNRcOA+tvYUKjt4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzGmPF3+cmmH+bHOvaPQsHbeNGTCqPF7VK7botmBdcRlnrhwURp
	FHaqeX+FX0WtTHdz75hb4yzaHBJC/VLti6Pd8wUDbORa0qQ5D7dVoMu4R8XqbCG7rUgmY4ic4rl
	+hzFXg/Ajq9age+aoEFIw4ks4LTaBGAM=
X-Gm-Gg: AR+sD124uVROvYI+c33LttqO134BmEuNOuuBlM4Yrvpn0nvnCjyMqgR0dVVdKCFjBL/
	+yjNViTfg+X03/jCABpGXAE7RsoTa667ZFHHfu6zlEBxVSZ/QlcdZYKnLnJIG+lk5YpoVw6ir0Z
	CdP5bgeOccB/MTLdA6iXgoSwegFj8n+b07nNF3N38mVbOmmY6Tu0hMKn8orXktDHIeAixG6Xls0
	4aE724lXb47hj5xo3mBgMdod9d34SkH6vSx5SFrntrhuB0natGd1SVzfPJfbqcl3H3p6n1RpQml
	b2AwuczdaTg1OhSAAFB4Hat5N2HBrTJe+rDT6PyOmMIw
X-Received: by 2002:a05:620a:44c9:b0:936:d9ad:67fe with SMTP id
 af79cd13be357-9371e2029f2mr1042764485a.3.1787228807799; Thu, 20 Aug 2026
 05:26:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260820080332.313933-1-physicalmtea@gmail.com>
 <20260820080332.313933-3-physicalmtea@gmail.com> <aobEwtvZ2WELwX15@sgarzare-redhat>
In-Reply-To: <aobEwtvZ2WELwX15@sgarzare-redhat>
From: Jia Jia <physicalmtea@gmail.com>
Date: Thu, 20 Aug 2026 20:26:10 +0800
X-Gm-Features: AcwNN1W9WrFqa6rrna4A1-P2dxuYVQJvqoSZIMHeqb-Fn4IWrxAmb7MsiC3ZMZI
Message-ID: <CAJwVaMLrp4+d_6cx9mHEMC+FoD3UUu-Z8QVDAm7Ekt7SrqjACg@mail.gmail.com>
Subject: Re: [PATCH v7 2/3] vhost/vsock: discard IOTLB when ACCESS_PLATFORM is cleared
To: Stefano Garzarella <sgarzare@redhat.com>
Cc: stefanha@redhat.com, mst@redhat.com, jasowangio@gmail.com, 
	eperezma@redhat.com, weiyj.lk@gmail.com, kvm@vger.kernel.org, 
	virtualization@lists.linux.dev, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

>
> On Thu, Aug 20, 2026 at 04:03:31PM +0800, Jia Jia wrote:
> >Clear the device IOTLB when userspace clears VIRTIO_F_ACCESS_PLATFORM.
> >Otherwise descriptor translation can continue to use mappings installed
> >before the feature change.
> >
> >The common helper invalidates cached vring access and applies the
> >transition even while a backend is attached. The backend remains attache=
d,
> >but userspace must configure the vring addresses for the new address mod=
e
> >after a successful live transition.
> >
> >Fixes: e13a6915a03f ("vhost/vsock: add IOTLB API support")
> >Suggested-by: Michael S. Tsirkin <mst@redhat.com>
> >Signed-off-by: Jia Jia <physicalmtea@gmail.com>
> >---
> > drivers/vhost/vsock.c | 4 +++-
> > 1 file changed, 3 insertions(+), 1 deletion(-)
> >
> >diff --git a/drivers/vhost/vsock.c b/drivers/vhost/vsock.c
> >index 9aaab6bb8061..e1e9d002d6ae 100644
> >--- a/drivers/vhost/vsock.c
> >+++ b/drivers/vhost/vsock.c
> >@@ -865,9 +865,11 @@ static int vhost_vsock_set_features(struct vhost_vs=
ock *vsock, u64 features)
> >               goto err;
> >       }
> >
> >-      if ((features & (1ULL << VIRTIO_F_ACCESS_PLATFORM))) {
> >+      if (features & (1ULL << VIRTIO_F_ACCESS_PLATFORM)) {
>
> Unrelated change...
>
> I think I've already pointed something like this in previous versions:
> for a patch that fixes a specific issue, these unrelated changes should
> be avoided. Please keep this in mind.
>
> Stefano

You're right, thanks for the reminder. That was my oversight=E2=80=94I shou=
ld
have cleaned it up more carefully. I'll remember that going forward.

>
> >               if (vhost_init_device_iotlb(&vsock->dev))
> >                       goto err;
> >+      } else {
> >+              vhost_clear_device_iotlb(&vsock->dev);
> >       }
> >
> >       vsock->seqpacket_allow =3D features & (1ULL << VIRTIO_VSOCK_F_SEQ=
PACKET);
> >--
> >2.34.1
> >
>
