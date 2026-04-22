Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F6DF30B53F
	for <kvm@vger.kernel.org>; Wed, 22 Apr 2026 02:07:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.175
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776823631; cv=pass; b=QI04xU894hmfr2GbXuieMFy3RONabC+zIzjtVjTZTOQLNG9kmp0QXPH/iwmd0bFN/z/24B+f/rGfEgCZJFWK8pInpDR69zpMNIkYSM00foYmz/8A1Jn0dT7snAeG+7MPl7+CvBD15aIu9QcWCEyqODAYYfO0RpX4gXzmIWdWH2A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776823631; c=relaxed/simple;
	bh=WWpj8K5tVkivvOPzV8h13mA6RDX/L7gtRkhm/3EcP2M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TajZ2JpVvnzZk2bbk2O2oP1YRhk2QY8hu2Og5WGytB0xE6s5OnhzIMX3muxcjXn05cifLvmb3IxvSZ5hNczWW3KQ5ukMnxC15A+2T3tSPYyilYEPS3sSGjR2PieM9jbpJjmNRgYTE+newhaJUYNRf9wzfRJYhKqNuC/w1v9oogU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bsI4wzsk; arc=pass smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bsI4wzsk"
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-2aae4816912so31206195ad.2
        for <kvm@vger.kernel.org>; Tue, 21 Apr 2026 19:07:10 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776823629; cv=none;
        d=google.com; s=arc-20240605;
        b=Ai67RlncSg1dsY4B6+w3ClO9ohQ6ctYBZmy0cpnm39t3hub/2tTSuk3DgiIBAageZH
         ETDJWwmBKfWOcaegCKMqk+cCnvspt+kQPsx5IdWgiv2cw+7OlsERgc/eOyhUjueTRT4G
         p2TSI8fR9EZh++nvB/UMz98t3L2Yf+5AAKtZ40TgzwRBcp71YOHvVYTPd+LUF2JOxvtd
         inrJDcgLNeoSra/DoQa0N3SFoCIKQj/v/eHAS2gCy1AxDI5qrTbP5R3kf+SoZe8Z2mTO
         D7bQa7MaoBbq2ijnYwHy3ay1V3mSA54NPrNMfu7Rb4lbrzlbSC6CwMP/aHiSbinpoenS
         a9+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=WWpj8K5tVkivvOPzV8h13mA6RDX/L7gtRkhm/3EcP2M=;
        fh=JxAOLV2ZMWUR5a3Lz4TKSLx8y0keUgAqlu0xUZOcmaI=;
        b=Z4y1C9Sr2THf6kdYc4cmtCVh/8O4kB33iVi1+W7oAhYgj6n4Fp0Yhdc/lMfkJoZSab
         wMyqtTUOuFr06xBZNVgw9gnK3VTMk5gtTalIBl5a2o/8vT5yvtVS4zel88jmVtDuDJzD
         cgzEJUh34pPeOikIDn4yZYvw+g43BYHFxXSlPEmtEdfTenaDNklUn8yNdC8L9DfkvXa6
         4W7Cla27tAfqlfZpKCBf+LEaytw9thZFsRcNwLboKnW/q8txgIrgsC1TEi7n4f8MCHu2
         gIkx/A1gdySdMud9hwXmK6N9hcfVRpAwij+Crj2uEWCzueuElsbaU6c9sYw5RTmZEdPQ
         p1dA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776823629; x=1777428429; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WWpj8K5tVkivvOPzV8h13mA6RDX/L7gtRkhm/3EcP2M=;
        b=bsI4wzskIx9Awqy/uTIxK4p9hcR5ObfCleuLTJYfqhe2o+RE4iUzEMi8TwzzSgrf0q
         xGzC/yAPLIQyxduvgmwrU7nJ7jy2GUqd0dsc4qz4MqUzGC6jZNF/aAoMs/56y4G4V14f
         ZSq5YPd1SdGlPAHBWMVxWuwswLA/2fqRuq6aMbul0jQ3kbRTrSTviTKxdMU/gtXmuOpd
         hp+X0SCUO6EsoV5QGG3tiASyqHnQWoF4Y9PKmXu/sLeazPCP9d+B6+q8jWp4arfGnsg3
         bHI3y02070bMTwXy/quWagPQcIbXCym5/SVCIyNr8wssyNzxL28jz0K9LfbBEUEVY+HP
         X/Vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776823629; x=1777428429;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=WWpj8K5tVkivvOPzV8h13mA6RDX/L7gtRkhm/3EcP2M=;
        b=WklqdRBsaDnuU17gT9LX/Ho/b0Ei5TdqfpCQPTRXf8T4kSS9taz1O/8Q3YDZnzKOb/
         2Tk+zlOXgmNuHi5xWWoRGshF88LK8uSTylVbxfr20kxALbtZBp0ZxmlzhMaaA/kZKUxz
         fQ1qPyE7Ck9rU+VWvkPwgRto2jOm3Rn2NIYgyKQnQguhWM0mwd9BPSSRO4L7PP7q9IuJ
         zrlvy26QuE5tYQMNEL6a37071r4vYEhHg9KHtIp4eAPpn59nesfo08/WeIkMMe+uTwKZ
         dFlNlehGjv4Yjrntk/d6GpC2hsQNmJpV6TgvQkJxPik/PvGVFvtNJihhLoa3uDQA2Urf
         hIRQ==
X-Gm-Message-State: AOJu0YxJiHVXcd13UTHFXsENDS+/TU6/oETdXHTX4jEuxkjfNVpju88c
	KTxR/1yChR1zf0w2CdDFRf0VC0Q6Q4T209MncZ+Y/ntxRRaIzTYFHXoB//ni41dufFtxm9Hz8/F
	40hkbAW5t/5mPevMKohsGk0IwIherM1g=
X-Gm-Gg: AeBDiesn3UROMMzP3VQmiCAeJ4KVz432o+i4sB5Nu8Q7IHRwyNm/9ymdIO58H06vWrW
	GgtlipoAHObXDIvoldFv4eoKx3mR7yz/TY1z+qNltyO3aXqxgTxHCXnRI6juDQ7mXTlI7rdQQyC
	4wFyo5SLe/IRxKZB5DUZtT3fcVTY2Yj09vSsaCW33LGuNpcSLzznJtMe5pMcdMFSh91I787gFqR
	NyRtfz8JqqliUZd51Ol+ChbkFaX2a8Twnzj/Hrk5rXioOq8nMkAW9r458VLnVW0dkqMnt8Tgpww
	eG7bEwDk8JyMrTXC9QU=
X-Received: by 2002:a17:902:7585:b0:2b4:656b:aeb0 with SMTP id
 d9443c01a7336-2b5f9f61d74mr129202335ad.35.1776823629391; Tue, 21 Apr 2026
 19:07:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAPHJ_VJGTsRDc7_Kv0oDObuDX2pJ0evcAvH-mnD_RYMX536+mw@mail.gmail.com>
 <e48748ff-0fcd-4561-9958-124dd853e70a@kernel.org> <PS1PPF7E1D7501FEA2B54606827E0DE1805AB2D2@PS1PPF7E1D7501F.apcprd02.prod.outlook.com>
 <CAPHJ_VKsVzyYzZ5ZnBkNbYLEMXDYL5x+7jfyUxhcwT1j4zPXOw@mail.gmail.com>
In-Reply-To: <CAPHJ_VKsVzyYzZ5ZnBkNbYLEMXDYL5x+7jfyUxhcwT1j4zPXOw@mail.gmail.com>
From: Zw Tang <shicenci@gmail.com>
Date: Wed, 22 Apr 2026 10:06:58 +0800
X-Gm-Features: AQROBzCiAonjo35s67_JoyIpUPtqTCm3_6UwO3hAdG0USmTimwNrRapE995lvK0
Message-ID: <CAPHJ_V+L92DxzEB=4+Tj+C8MNBW7LM35xWYXAoLhHqU5p2nxfg@mail.gmail.com>
Subject: Re: [BUG] WARNING in workingset_activation triggered by KVM page
 fault path on Linux 7.0.0-08391-g1d51b370a0f8
To: "David Hildenbrand (Arm)" <david@kernel.org>, "linux-mm@kvack.org" <linux-mm@kvack.org>, 
	"akpm@linux-foundation.org" <akpm@linux-foundation.org>, "hannes@cmpxchg.org" <hannes@cmpxchg.org>
Cc: "kvm@vger.kernel.org" <kvm@vger.kernel.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "pbonzini@redhat.com" <pbonzini@redhat.com>, 
	"seanjc@google.com" <seanjc@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi David,

Thanks for pointing this out.

You are right. The commit id I sent was incorrect. I mistakenly used the
git describe-style suffix g1d51b370a0f8, but the actual git commit is:

1d51b370a0f8f642f4fc84c795fbedac0fcdbbd2

The short commit id is:

1d51b370a0f8

Sorry for the confusion.

I am also re-checking whether the kernel image was built from a clean tree
and whether there were any local modifications when the crash was reproduce=
d,
so that the reported source line numbers match the exact build.

Thanks.

Zw Tang <shicenci@gmail.com> =E4=BA=8E2026=E5=B9=B44=E6=9C=8822=E6=97=A5=E5=
=91=A8=E4=B8=89 10:06=E5=86=99=E9=81=93=EF=BC=9A
>
>
> ________________________________
> =E5=8F=91=E4=BB=B6=E4=BA=BA: Tang Zw <shicenci@gmail.com>
> =E5=8F=91=E9=80=81=E6=97=B6=E9=97=B4: 2026=E5=B9=B44=E6=9C=8822=E6=97=A5 =
10:03
> =E6=94=B6=E4=BB=B6=E4=BA=BA: David Hildenbrand (Arm) <david@kernel.org>; =
linux-mm@kvack.org <linux-mm@kvack.org>; akpm@linux-foundation.org <akpm@li=
nux-foundation.org>; hannes@cmpxchg.org <hannes@cmpxchg.org>
> =E6=8A=84=E9=80=81: kvm@vger.kernel.org <kvm@vger.kernel.org>; linux-kern=
el@vger.kernel.org <linux-kernel@vger.kernel.org>; pbonzini@redhat.com <pbo=
nzini@redhat.com>; seanjc@google.com <seanjc@google.com>
> =E4=B8=BB=E9=A2=98: =E5=9B=9E=E5=A4=8D: [BUG] WARNING in workingset_activ=
ation triggered by KVM page fault path on Linux 7.0.0-08391-g1d51b370a0f8
>
> Hi David,
> Thanks for pointing this out.
> You are right. The commit id I sent was incorrect. I mistakenly used the
> git describe-style suffix g1d51b370a0f8, but the actual git commit is:
> 1d51b370a0f8f642f4fc84c795fbedac0fcdbbd2
> The short commit id is:
> 1d51b370a0f8
> Sorry for the confusion.
> I am also re-checking whether the kernel image was built from a clean tre=
e
> and whether there were any local modifications when the crash was reprodu=
ced,
> so that the reported source line numbers match the exact build.
> Thanks.
>
> ________________________________
> =E5=8F=91=E4=BB=B6=E4=BA=BA: David Hildenbrand (Arm) <david@kernel.org>
> =E5=8F=91=E9=80=81=E6=97=B6=E9=97=B4: 2026=E5=B9=B44=E6=9C=8821=E6=97=A5 =
22:06
> =E6=94=B6=E4=BB=B6=E4=BA=BA: Zw Tang <shicenci@gmail.com>; linux-mm@kvack=
.org <linux-mm@kvack.org>; akpm@linux-foundation.org <akpm@linux-foundation=
.org>; hannes@cmpxchg.org <hannes@cmpxchg.org>
> =E6=8A=84=E9=80=81: kvm@vger.kernel.org <kvm@vger.kernel.org>; linux-kern=
el@vger.kernel.org <linux-kernel@vger.kernel.org>; pbonzini@redhat.com <pbo=
nzini@redhat.com>; seanjc@google.com <seanjc@google.com>
> =E4=B8=BB=E9=A2=98: Re: [BUG] WARNING in workingset_activation triggered =
by KVM page fault path on Linux 7.0.0-08391-g1d51b370a0f8
>
> On 4/21/26 13:17, Zw Tang wrote:
> > Hi,
> >
> > I am reporting a WARNING in workingset_activation() triggered by a
> > syzkaller C reproducer on Linux 7.0.0-08391-g1d51b370a0f8.
>
> g1d51b370a0f8 is not a known git commit id.
>
> Do you have an upstream git commit where the line number
> include/linux/memcontrol.h:381 makes sense?
>
>
> --
> Cheers,
>
> David
