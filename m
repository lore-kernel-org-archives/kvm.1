Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.173
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794237536;
	b=rkZGCw1BSPv3/oXyUR6hv/1oiOEhb8AkbThOGEjLomM2W7nenI1AaQESsXxOJiOq4si6
	 TP8gf4t+mVd80s4jviLZ0Ex9hYEVyHQIb0Xo5CONyP1Ovu82c1YKuGjvFB/aWQcJSwsGx
	 KvS3oDnc5CNvx8bl8btsyrqvNAkeMuEDdXbN1l3hMxldj8ssDlKEGCA2Pyj6OLVqs/2B8
	 hq7XsLQhPo3CmwibvSRjU/xBq/hEsZfpaFlZeh9iI3QvMfqV4KBSo4mqUDko/anf1lkW7
	 T7y3SmXrz+XxpeFTBRkBGFf7BYwttToBpHtH38WepU/ZVoyXsDjvANxw9IQXxgn98IQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794237536;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type;
	bh=f9wv2OOOJbDsoV9vVvgPBb4vz12HSkZX91pkBozPdw4=;
	b=h61BRknG4qk3tc5gYvGJPGWJ45plY8goWUDZOIGMsXo4terejCNOvk1khEKEtTcxWigs
	 dSYBfbG3m6HuESIZVDITDX/bLSyoW4EhsPnQ/xsiGOHvX2yW7Hz11EA0l46N/awLuQNm6
	 HnIWjIuwV3qnNpKA9bpJC+Hh3Pcv/12H2alGtccPwyUeqJI4Kn3O4g2dtld5SAnRkThv1
	 rwWZ6gbTm5yYo8R0gzDY0cSrOHOfO/voNfgu67kT4H450ItnQ98ZhvBBcwA9RAyCuDbU8
	 FbWvI81DsPk+XPQ8z1CKdx/farepMDzI51WEXe1M9tKCp1fCvtTFkVJo8uvJgCpYmAw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=c8ij8Tv1;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.173
Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com [209.85.208.173])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D92BC606A325
	for <kvm@vger.kernel.org>; Mon,  9 Nov 2026 15:18:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D92BC606A325
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=c8ij8Tv1
Received: by mail-lj1-f173.google.com with SMTP id 38308e7fff4ca-3ace304021eso8538501fa.2
        for <kvm@vger.kernel.org>; Mon, 09 Nov 2026 07:18:55 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794237534; cv=none;
        d=google.com; s=arc-20260327;
        b=AhhuLFXTpOp25qW65LHpHx4EwBZAe5UAhSaMD+1BegU2i+F8T92HJ6fjbsdeTZCp+O
         h+meQJvxt0ttko894q93FDweEnffZr3aPkYnsRSofym/2c2zfIoXyo2XeDmwXjOBLMhn
         3SFtzCMUF22khwuhLS2VYIy9RJ2LrZv8pcm5mMg6HbKSf4UUp/njxtO148DdBdBQTiDq
         bcMl260BUWZJF7Le2azqWvEduc7aPgJo9XMf2cBvBCrykynSU2GE45w4qufKkxl6Dwtm
         ualn8p+R71SFiigMPl2TaJ9SRAeKYVWAp18HgJWOAQTtVoVSAu1sAtBjVrCuvVjhk2gY
         a5LA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=f9wv2OOOJbDsoV9vVvgPBb4vz12HSkZX91pkBozPdw4=;
        fh=Hl0hri0jQoIzlMNQx2w98pX5A0lTI9PFtUfkwCFeihw=;
        b=KTa038XxEgWhgIpEYvPzLiaEpb4F/65qtDOy+U9vBC8gK9Em4mR758QHOP4Uke9cF6
         BvJhlxnpAgQ3Lj5M9a/PSVNX8FMzIIV/IxCY6MCD/rAUTonD+8F7u69jZRKQqHVWfGw8
         BfQv9PUjVbVIy6uL7aqkyacKkFwT6f/UlTVgiWdmIJdI9yYedc1xz9P8o3Smdfmn315g
         n5zrupp0DFCdBLlC1jMwLKDT6Ch2xaucbH2lfedQ+6v0+l8b6dElRrFyKW6PnoDm4HpE
         V9tsGImasJZHbLvgmqhaUFZUT546I3GTxwlVx5EgUKgacvMKYyMS3ngqh18qmgjDEegr
         CnUQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794237534; x=1794842334; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=f9wv2OOOJbDsoV9vVvgPBb4vz12HSkZX91pkBozPdw4=;
        b=c8ij8Tv1gkIXOZsIYNgr6YkyMRuFdW/ewb+EHycKB4Fkp1ZkZUOaiSuRTYItYKkj4X
         oX/OZkV/NX5baT22/mAJNIBN4STZnDboEJC2cDEL7lmk7EexFB9YfnedNwc8jFvptmEr
         YC9FshEhENipTaUv/bWfw6vy60EpL6WZD8MpDzRjXSPaJzzCQD4IsEja8SwdYklOyqQy
         PtU5wVsBCfYekTtilM0jV5picQAowqt3r3yqYXRK0B6bPVW/L3WHAYg0g2YOuXzDa1Q+
         +a31ptsx/lHNjs2W0aOO4n5yqPxC3JjlEZrf1s6a/ad1698sxr2K8nurKOIW1LUPYJBs
         nKcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794237534; x=1794842334;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=f9wv2OOOJbDsoV9vVvgPBb4vz12HSkZX91pkBozPdw4=;
        b=v19uxmWNgljUHXqiPdbeifMTxUfw+C++FC/6TzOeB/Cnv+MIBa9Ock+07hiAvVwa4F
         4GQ6eLFEO0thFReETycGBONhIi3mc5Kcj7zvbYBU47AE33riHE+RMWcP86a3cPf6uTdo
         nIAB7ohh1ycIGH6ujyIPtejGQBlyb7eWSmhL+rtACsjWurEJBN2Oo5qsAfO7VZhVIkBM
         2gp5L96i3iHxlJZ/UmBQuJ3wVimXxslm8K+TEL/GhbWOQDsd840BTb40/J2uhQA4xUrC
         CpmsRc2Pw/v/Xo3KPc535lIqmvAJJ4ngoqf1mQGzMWGYfaUTdwcoM1h7hrsWWi/cX/+W
         HBBw==
X-Forwarded-Encrypted: i=1; AL+hErE5uzyu3rUpvWGdkZW/r3HR/IvMG0cagVATvdHNEaiCHbpjkzO+sNIxuCppsmGClCaCSQU=@vger.kernel.org
X-Gm-Message-State: APuU4Z+r43sby6tOxRPMNBrGGpU24sh6h1XF0tj/zzb5/+sPAFaETy/L
	hDhMrEiMoXpXLhpe/wj5dxo9StOzifSQI+URYImjUXCNxNY0rWIzXPD8FTOB8KLJ1ASXmSw25Ua
	1HJishb4/8FEPNdWsLiE0xawfY8/SDlE=
X-Gm-Gg: AYBFou2hG0D9p6TMCDaszYIERpzZyLpADvMS5weSjmbicHbmiKC82MT/XWfLuuZiCGP
	Mf2kfvyn4xrprlWb/KZTZZRznDEHftMI8sKT1m0OW3CxtGti6pUbWaofeSgFq7bCVRtjpO0Jl23
	MgxMTNArg1/kpSpb/kr3Gs7RGgKSRN2rXCJT0aGOYKGX0gWN/vUZRX2tLirrVWa+8CCDMQa90I4
	uaPhl9+freEstwh2+kTzdG0KRgLAAjdL3KjI7NTHE6RDhuU9BQWOv1rh2mtP4KfyLj3ZrLl00SJ
	DkG2qosGJ6Up+7ZQ5SCBEnZ48rsMH8JDsecg/HhPJ+E8eGk7is87jpfeRUgbu1BfHUCI98d7kbg
	aPNwoTOZMsoa8520yjFhAiG58mddgfQ4dCu3YjAUqw1JkA6HxNLKZlnhGEJY=
X-Received: by 2002:a2e:a5cb:0:b0:3a6:622a:2cad with SMTP id
 38308e7fff4ca-3adfa40ab84mr9712381fa.10.1794237533641; Mon, 09 Nov 2026
 07:18:53 -0800 (PST)
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261106190401.468289-2-oss.patchbox@gmail.com> <e597eb85-6c80-416d-bee6-2498ac06de5b@linux.ibm.com>
In-Reply-To: <e597eb85-6c80-416d-bee6-2498ac06de5b@linux.ibm.com>
From: Yuho Choi <oss.patchbox@gmail.com>
Date: Mon, 9 Nov 2026 10:18:41 -0500
X-Gm-Features: AclHuK9xISIrL9ID9x9MQ91_XwCy5vI6jq1cGcjDxinZF-wje8KKP6ZM3M4rjLM
Message-ID: <CAGG=RgACO5r_SXcx26tUuQ96b_sworbA2QQPctGTw=QibKpwoQ@mail.gmail.com>
Subject: Re: s390/vfio-ap: NIB unpin when the IR bit does not clear
To: Anthony Krowiak <akrowiak@linux.ibm.com>
Cc: Halil Pasic <pasic@linux.ibm.com>, Jason Herne <jjherne@linux.ibm.com>, 
	Harald Freudenberger <freude@linux.ibm.com>, Holger Dengler <dengler@linux.ibm.com>, linux-s390@vger.kernel.org, 
	kvm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Mon, 9 Nov 2026 at 10:06, Anthony Krowiak <akrowiak@linux.ibm.com> wrote:
>
> This has already been reported via an AI bot patch review. There are a
> series of fix patches that includes a fix for this. Short story is,
> the AQIC resources will either be leaked to avoid the wild DMA
> write - which could occur in this scenario - or they will be freed to
> avoid a
> kernel crash under certain circumstances.

Thanks for the kind explanation!

Yuho
