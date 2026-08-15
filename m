Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5148D6FC5
	for <kvm@vger.kernel.org>; Sat, 15 Aug 2026 11:39:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786793992; cv=none; b=Dy9q/HGdLPk86Lzbo3RvoJuEvUdEQk2afhKoQwMfCxobY17HZmkhs1JXZNDKFwJpjM5wcqQFxhYV68WCX8Z9pwNd2x8nyQuc6cfeUhvEZ3Ck0FQSIMLprRIm77a0RV9nrPwxh3D5Bk06FStLfbbNCLtYPa7/uwWHxJ9czDmYKxI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786793992; c=relaxed/simple;
	bh=IR0YYfxxWEISJzS6djOa3HjOjfoYQWVxSn+BVN0rc0c=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=VPeFnS5haQdm1Lp+qVFuFdD9b67amGx82SXnslDWTgPJaKB/Q0JFYqVDkmX0P6IJeTY2kCkVJG5ImFMIU5gII20iMPloJPupsTGKrCGEcWeogSnv+WUUwjdaRibR2mmwbQOqZnsZq0n7PIHH7jUnPqJtwFuQFu0vhAEuBbPmCD4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KUKmJI3z; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KUKmJI3z"
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-495757ccbc1so16643145e9.2
        for <kvm@vger.kernel.org>; Sat, 15 Aug 2026 04:39:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786793990; x=1787398790; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=IR0YYfxxWEISJzS6djOa3HjOjfoYQWVxSn+BVN0rc0c=;
        b=KUKmJI3ztzq+BTqIB4p0UFxG3NDio4Lw8N4b4C1qyDqkLPT6VitoDwel2bK1G62Imw
         ttnDxEP52X15wmIKHiJLW06O9B6lgh/Cd3Q7kDhOWqlAe5AVmvnYHLZKnkxSix4WWR4t
         1P/8fkq2F3qgNZHPFQ94JegCbxBMSDXysuH2CHAgrjx9cNx4rKwJs8M0/gv+JGMQ4Dmm
         cEfb3GczA1AWHW47QEDS8RwbeF2dJoP0cJ4uhSNN1SrVTnf5+MlVgejC3a8iW9LulgAI
         C969vpLwfPPNB1D0Q27EgcM68lbM9LpXgAseWqllcFCVB5FJQ1kCbw1JcSAfA1Z6E8kz
         UJzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786793990; x=1787398790;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=IR0YYfxxWEISJzS6djOa3HjOjfoYQWVxSn+BVN0rc0c=;
        b=ZANcosf45e2//+hqZmlOVsxEK2dfJejc5vO+rOHfmqkIIYWHZfkg8bswHv8gPtSYcl
         m8kt3PZvmrfX9z5Dk+S4xDIWdyHOKhfXZ6Dz8uLQk1Tcql7Dqap9YEZ+NGSK+g9hPqEi
         BZRHJePEcUjB8RCR3gEMXwB7ojFUDxLZEIn+Uo9Fx/RUnG7T/BJZ/EfaWHsdHgk/l0tg
         6f5i6i+wAVXAbk6cutTqhqBoswwBMasO1OcojIOh+cOqgy6LU9cjJ5eYGWl0EojWP0gY
         9V3L26BNX3MOvC1mgZcwKBNa5wOr5Sb0tUeMyN0/ENsMokW+g6jU6nUi4+07+dEH51qW
         WecA==
X-Forwarded-Encrypted: i=1; AHgh+Rob8J9A3gUt7fQCyCuTllkkqsPEx3/G6NwQ/MrDYkLuAqHn4vrbT1ggT7L2psI2b7sFOpg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxnxhGoNnTvJWudBg14TNG06++J3dOu79S64gmQuSqb3WueP10j
	wIcVOWw5SlT5b8hHg/AjC1vLern3FwhgQG9kMdU1sCnHRc9cy/Fq1e7r
X-Gm-Gg: AR+sD10oJfaq0lBq2z2aCGFvCsnl+xyunO7JC2SErtyVXFB99jQZpxh3e61GJw3Olks
	7OIk4GcfwBW7DYjHMQeJipkma8NcMQwElOxwOoSdokT8p8+hdpBmaRHY8W6yas/zAbWuOiQ+rcU
	XfooDIsG/hJhaowXjdTY1F/OSKRql32E1LuxmENhuSY9fy9dXpvczGBGbdHrhysMYXoXetTJkZj
	fJNrzMCnVB/o5N9CExghq6U48B28i+eVVtoIhptJVikSMjVhtCRlYclv96i9cw2D7Twko3Rbjl2
	RBcZ8jT5F7PbxCLG8qaO8VyT1ajxsIswaYOY7nEm0GaPjeEydFs7m2BqINXy99ML5YLRJ+E35h9
	S+X0fD4UoLtDU98xQaIw20foWQVe1b+zYdWqNHjwHZE0ZF8bt97c5Wv8ODjGVVtvwCe/5InqPwO
	xNGK7ZFVROsCHHxMCwT5LA9L3CKu2ORXbcWoCmYqtcktcPRCN0NYXoS+lff1PV4Z4WaloAwZVi
X-Received: by 2002:a7b:c348:0:b0:499:795a:c60b with SMTP id 5b1f17b1804b1-499879a3c5fmr131538805e9.19.1786793989489;
        Sat, 15 Aug 2026 04:39:49 -0700 (PDT)
Received: from [10.245.245.10] ([134.191.227.46])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4815f2cc81csm16430398f8f.34.2026.08.15.04.39.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 15 Aug 2026 04:39:48 -0700 (PDT)
Message-ID: <498af8d6a5de3ee05e0216ea075c0eebf88c7072.camel@gmail.com>
Subject: Re: [PATCH v3 0/4] tdx-guest: Make Quote buffer size dynamic
From: Artem Bityutskiy <dedekind1@gmail.com>
To: "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>, "seanjc@google.com"
	 <seanjc@google.com>
Cc: "tglx@kernel.org" <tglx@kernel.org>, "mingo@redhat.com"
 <mingo@redhat.com>,  "x86@kernel.org"	 <x86@kernel.org>, "kas@kernel.org"
 <kas@kernel.org>,  "binbin.wu@linux.intel.com"	
 <binbin.wu@linux.intel.com>, "Li, Xiaoyao" <xiaoyao.li@intel.com>, 
 "linux-kernel@vger.kernel.org"	 <linux-kernel@vger.kernel.org>,
 "sathyanarayanan.kuppuswamy@linux.intel.com"	
 <sathyanarayanan.kuppuswamy@linux.intel.com>, "dave.hansen@linux.intel.com"
	 <dave.hansen@linux.intel.com>, "kvm@vger.kernel.org"
 <kvm@vger.kernel.org>,  "linux-coco@lists.linux.dev"	
 <linux-coco@lists.linux.dev>, "hpa@zytor.com" <hpa@zytor.com>,
 "bp@alien8.de"	 <bp@alien8.de>, "Fang, Peter" <peter.fang@intel.com>
Date: Sat, 15 Aug 2026 14:39:46 +0300
In-Reply-To: <21ffbb7b80c0c654c23a97cda55f43c73e49ba25.camel@intel.com>
References: <20260729122939.1340412-1-peter.fang@intel.com>
		 <e0a90fba3f8424412387aa08f1fdc708abeedc73.camel@intel.com>
		 <80b4ea89ebf17398c3bee21d157c7f97ea32aadf.camel@intel.com>
		 <anxvwV_Pz4UYaxxt@google.com>
		 <86d532f33816cd4fa3e29c40079a6003abf89324.camel@intel.com>
		 <anyiwqi9i0NSv0QW@google.com>
		 <ed4891a59096c59e43a893910c9f17d0ff6086b8.camel@intel.com>
		 <20260812223707.GD1013044@pedri>
		 <6191a69559e58e04c8e3f1efa776e9639796af3d.camel@intel.com>
		 <anz9b6CDkhr5D5RG@google.com>
		 <c697ff1d97fe62882eaf3bd86a4213bf2e79fc09.camel@intel.com>
		 <98dcc8a12f117745a1cb9981dc8f0f1548e9c96f.camel@gmail.com>
		 <4ad451969522eecb445289ca74a88ee73d51336d.camel@intel.com>
		 <8b432c8731167e97432b2e917d0b1c855fedf47c.camel@gmail.com>
	 <21ffbb7b80c0c654c23a97cda55f43c73e49ba25.camel@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.60.2 (3.60.2-1.fc44) 
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Fri, 2026-08-14 at 15:55 +0000, Edgecombe, Rick P wrote:
> On Fri, 2026-08-14 at 08:45 +0300, Artem Bityutskiy wrote:
> > But why DICE-based attestation uses 2-flow design? Could TD run a
> > TDCALL[TDG.GET.QUOTE2] or something directly. No concept of TD report
> > would be needed. That would be my current vision of "cleanest".
>=20
> We discussed this approach internally and in PUCK. The problem is there i=
s a
> shared resource, and so something needs to handle locking and fairness be=
tween
> the guests. Going to the host keeps all the scheduling type stuff in that
> domain.

Good point. I did not think about this aspect.

I am curious if today this is an attestation-only problem or a pattern.
I mean this "many TDs compete for a shared TDX capability, VMM needs to
be involved to handle fairness".

Thanks, Artem.
