Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=170.10.129.124
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795002520;
	b=CfqdY/VeKdI6ZBE0x6Y4oqvmT8nBxWRb0kwGSHrW/Hu6WX4OZxjHKZsk4idx0uyuirjO
	 BwXqvz1cWzvZms62k6JaXmfZ70kcLtaVSsOsDaE3KF8Zhj6I62hgO0oZ7tKZC640QQG1H
	 ceRHbOb7JQIC6mvleGi4aBhTKdkWtb/lmcAn8Guk74r/1CPp3VLUb+cD6zdmhcryZpZhV
	 b9YZiD0TkveYX5qOS18jfLAZfrVwFykDNRvslDLo2NOBv7vaRWHQnVRUtlXh5Jl2XD2KB
	 R2y3+uuXfJ006vHk03Sx4AXSMyxSzdbNR8LzGfUempytgprA1EaXC1835RkHxWDQtDQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795002520;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:MIME-Version:References:In-Reply-To:From:Date:
	 X-Gm-Features:Message-ID:Subject:To:Cc:Content-Type:
	 Content-Transfer-Encoding;
	bh=bi2h3dY/MV8U5pTy3jhwXZFsi/LuLq7ueTPIx6UlnTo=;
	b=g8PjE4N4b5k8ggkhf4v1LROw83eW23BkptaRGNRzxqvXYZAe7wuH0wk80nb7O6QMnqiK
	 qprqnj4yLcG0VOJw0UGV1HxnE2R5c2dJ2+cwyKr2ZfEXkeWBOaUCfOaCkayPqkXs1FnIc
	 hzEG1SNUogokYkMiQaxXHJRESfTK1alhtHGc0/e69HyLO8Jm53nPamKyGrWZ7skbSw6vN
	 UE42vGSs+jHoM10SrAtT2+q4s+u0qIm2f8kFfgAO70aSC2edyMd3dLnJ8qfgtdiHkUI4m
	 LGTiCy6ZSyuP28QDQxmhtu9b7FEx9sxQxjbb/4TeUtTVln5nCtXe5p1kmQPXTyf2bJQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=MOboHHby;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=b9U1X+n6;
	arc=pass header.oldest-pass=0 smtp.remote-ip=170.10.129.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F9E6606A320
	for <kvm@vger.kernel.org>; Wed, 18 Nov 2026 11:48:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3F9E6606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=MOboHHby;
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=b9U1X+n6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1795002519;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=bi2h3dY/MV8U5pTy3jhwXZFsi/LuLq7ueTPIx6UlnTo=;
	b=MOboHHbyJ35oOb6B0yXPSBMkxuCxSy20/HU0am4Qeil0R+2Ig5K+1ols+UUWrYfiG8E95p
	sXZ4sx3NzLF8hF2ko4Qx0aA/t5Nq+gOtsvcDEaqrGyu/JohB6sbGtBFPOeEFvagtb0sY/S
	7jJxUswbat7pYYz69igmBRctmSS/RCU=
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-551-4pCJnmxJNNi1LsLEMG9zvg-1; Wed, 18 Nov 2026 06:48:37 -0500
X-MC-Unique: 4pCJnmxJNNi1LsLEMG9zvg-1
X-Mimecast-MFC-AGG-ID: 4pCJnmxJNNi1LsLEMG9zvg_1795002517
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-3ae72da2f57so1151547a91.1
        for <kvm@vger.kernel.org>; Wed, 18 Nov 2026 03:48:37 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795002517; cv=none;
        d=google.com; s=arc-20260327;
        b=dTZASlr6joSwmTTUb+8flhsKpu/SHX1qFIRnxiWOGQAGbVKuMF8XGggb5/cPnIKGJd
         kUlumgaym+4jeJTeszzxSmTpj4PiohjoM/R5LL21ZqILpFcrw8wt8uceU40FPD98eQRV
         xubh8bbjV1GKNqjfaISAXMtXq+zfaivbxRF6f8cqSrx3E+WhYXMvz+SkmwfGLG52uYIQ
         FiZb1NLQSnZaVWlforko2rSW2u/MLYvb33VI6TnomlhoU+Hcsiu6kL6eg88Fidzg4+9H
         gflA+ABhnwJoC4bTC1Av1tp4+ziDf8sinArM6IEkv1+b6VCakMfDXJgAlwW/Uk4oLPe6
         pPTQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=bi2h3dY/MV8U5pTy3jhwXZFsi/LuLq7ueTPIx6UlnTo=;
        fh=DB3M43CqWp65L9tDO5Q77z6HddY8uWGiwBFbV8/UAXY=;
        b=POyVYjefaZoT/fp4kcefuBkYxkPPhWPsT93WCVa7bEWzullmu9YZ6UTjStNsIIh2g2
         LlWRhHeyNT5xltC8wi0p4d7it16if38KoKgmL2nb9AChaW9eX1B5feRcTdz1M0/g4wJ0
         bnQb8P/+GovUSYjHL7BEmZphZSRR5+xDgFN9yA7PCFISj/ULQFNXeHYsfV9CcpMPM2iR
         O8mvez8gCi1u/XAMhupaXfji83584LB6O7Azkoaox7kaof4PcVNI229NUnc6kf6QgzEv
         tttt9hg8OGcs6idZS6uv5GLgO3zrDt80d5r9VWRv25s1yjcGg2gdd0w43AYxn2qwoXA7
         9mtA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1795002517; x=1795607317; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=bi2h3dY/MV8U5pTy3jhwXZFsi/LuLq7ueTPIx6UlnTo=;
        b=b9U1X+n6xWG0saynKKIBdiOIHp0WnH90B8WrvdS+lyFXat3VTvRo2YcXmsD3V/ekAE
         vyzj6Hh0jgJc199FV51GSp9YzneoiCZjjx+68OdHLwwGEap7jneBVR1dB70W2hJ863R9
         9pIo2ils8+pbbuVjUtaCjKwhqMRbGfAsp8KYRybMsuaPNgUrnypG91qf+sErV2siFrBO
         tXmQYLQhMq6wIIRgVWch90CbBoWRPEE7z5h3HbTDgbi6Sjnudcy/V+1gDbQkxzr/WL+i
         tYIrIeufxppaNObWkDJvJBNrOslE0780EIwSq0RkPMzKZM0/fZJLXn9JRE50bSwScMXr
         2c/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795002517; x=1795607317;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=bi2h3dY/MV8U5pTy3jhwXZFsi/LuLq7ueTPIx6UlnTo=;
        b=CAkoJ4mWWi4hWXO2zREh9o5tNNKpzYFtT83pKUF7MuOd7TMdk/TsW+iP8P64xQ8zGO
         9ex9XUYLqqC2vp9+v8nOhO255dJpCrCDmXqSU78uzaHxzUJ2M5nG+KZCs39g/XTGiiQ/
         QyH106TAef5p+SoFsjxrOIVWsAr/57q3bVPs61Ex8yFzDbVGm/q0B43jst0L7KvkzpKv
         d6BcJbBDJi6NaCeBoMEvKAHVSKm/ImOVXIEX4gMhGTMgV3SdHIVhy2evGtEtSGUZjy/W
         SsatQVPFm/udauLxAjS2c3iQ1+wCQOj+FZwyw33CXzWwhib4r683AHXW9a5zmuGYmpMy
         E9Gw==
X-Forwarded-Encrypted: i=1; AL+hErFrwxoZKY7Zt2mp1tcVsBpKFVXl9JVRiXsgNJvTP3r+PsfrfdK5LgvG4gK+2a79EmKEYsM=@vger.kernel.org
X-Gm-Message-State: APuU4Z9ATpSdj22lfNoFgvp0MvRCPB4zSQsPJtPd7y5+GxzCV6pr7r0e
	b+zPMB3UhS2gO9DOnYSA9DnX/J1Npo4REVjIVcp6sl/mV3ksRfV5j1hWusnVaxeJZndXR9IO9M9
	cbxRuflGmgBpdHk2jAV7mlKqzYK5qK7U2i/MsA/G5kztBz6xwu254gPc7OsdkMs7TYRqvhX1mdH
	r/+jj9GsasdVI8dX2eM9LFg+19aiB3
X-Gm-Gg: AZFdTZcDB41VwdtS43NRM5UEYl0pbpVkShcaRaMNXbB0z/9bery7p5qqISy3e9/EXM0
	TjVQWvJgxyG2E5JF9ZJhVHzkl8Qg20+V+cNG4rFJaqleA3e2GrzkW7sgBZeXzEvWRLXLRB/mn5l
	0okMIR6B2Pa0JCDDdiuSEVsur7md8gUc2CpZfbke8WOVetLB2aEnh5hOsFtS2OZ2RGRstNIGuA7
	kYCKOArW0/+64Wp+4WT+l2TPnM13dRD5RmB2pO3oWeUbiXtsVCQ95/0Kdlp
X-Received: by 2002:a17:90b:3b41:b0:3ac:a139:1b14 with SMTP id 98e67ed59e1d1-3b3d07e0e94mr2527727a91.57.1795002516696;
        Wed, 18 Nov 2026 03:48:36 -0800 (PST)
X-Received: by 2002:a17:90b:3b41:b0:3ac:a139:1b14 with SMTP id
 98e67ed59e1d1-3b3d07e0e94mr2527703a91.57.1795002516247; Wed, 18 Nov 2026
 03:48:36 -0800 (PST)
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261118114226.26178-1-naa@amicon.ru> <2026111856-snowboard-unknotted-8b75@gregkh>
In-Reply-To: <2026111856-snowboard-unknotted-8b75@gregkh>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Wed, 18 Nov 2026 12:48:24 +0100
X-Gm-Features: AclHuK_SkztaxopbIwr99Ro1CdCVO091ex6AgTNU_eGvL9UQpODpc2_cWbFfUrs
Message-ID: <CABgObfaQnCtORj=EwjSWNAaoKZ=D7mO7BqgGfCQx_qJit1AKVQ@mail.gmail.com>
Subject: Re: [PATCH 5.10 0/5] KVM: x86: Backport shadow MMU GFN and role fixes
To: Greg KH <gregkh@linuxfoundation.org>
Cc: Artem Novikov <naa@amicon.ru>, stable@vger.kernel.org, kvm@vger.kernel.org, 
	seanjc@google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Agreed, 5.15 has the fixes and it should be old enough.

Paolo

On Wed, Nov 18, 2026 at 12:47=E2=80=AFPM Greg KH <gregkh@linuxfoundation.or=
g> wrote:
>
> On Wed, Nov 18, 2026 at 02:42:21PM +0300, Artem Novikov wrote:
> > Backport the shadow MMU fixes for CVE-2026-46113 and CVE-2026-53359
> > to linux-5.10.y at 3a323bc22b88 (Linux 5.10.274). A linked child is
> > reusable only when its GFN and complete role match the current walk.
>
> Why are you running KVM on 5.10 which is going end-of-life 12 days?
>
> Please don't.
>

