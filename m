Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.160.42
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794560995;
	b=fJE2aj6H05osz+H/6MaCbq6Jt2ypOgQPylmecQG1wY/x/UfKXbFB2QqTDt5uHeD6852A
	 92A5axL1QG2kMVcvTzFOcKBIDdNtX1pGQsJyyaUX3inv4kTuupiLyUCb09hlxln/4Uf7W
	 cVaQL4n1wBrENdmWY1zNhyn2+HnohMZEgoYbrzpyS6QnlQt4GYnOuua2mkYIkKnnNYONG
	 5xLaToXJZRmqPh3/Ie+dyCyzCwsXOAWpNBEAzIaHj+1vmUOXyhkaBmtIXlG15itvvtRWJ
	 fsQfa4CuQyQZdTxScmkUTEZIcMvAWkXF2Zw9MYt9GSyWkhuqZ540ldZdRDSi0PuFUqQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794560995;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type;
	bh=guR2kn0I9WVyI0WwVW8m8P4IC07cc5z6OUtXdezJXW0=;
	b=mLJ+KQxglUIgJPH1QlCpnrWXEl61hzfvPyY5p1Nb/JUmf5VKgnKYt1l69ehSKrsZ6fN5
	 MNLrsi48qOmLup1gM4MeJQsDfBDCWoQcHurTnQsFEAADNYYn2HvRXBZKmugZ7z7q8kC5F
	 GuZAho8gRbTqHlFg4fmlADjnyEbJgwoJMxnRfionCDY1fE3JNwM47AZ8y0L8NMpNnAT4U
	 KELYDV79LCEWcxiTm0pLQnl0cssQFF/3G6Mo3n+zhM0UPHlZUA/IMPl7a7qHhrH8u3cB6
	 tH9x8W1pVGRx2vRfr7mQ5wJWBayKqDtJHsHdbWenAtu/VJTibtYyMrLyKvvXlTtsvxg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=flashbots.net;
	spf=pass smtp.mailfrom=flashbots.net;
	dkim=pass header.d=flashbots.net header.i=@flashbots.net header.a=rsa-sha256 header.s=google header.b=cVF2s76c;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.160.42
Received: from mail-oa1-f42.google.com (mail-oa1-f42.google.com [209.85.160.42])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1C4E606A321
	for <kvm@vger.kernel.org>; Fri, 13 Nov 2026 09:09:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A1C4E606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=flashbots.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flashbots.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=flashbots.net header.i=@flashbots.net header.a=rsa-sha256 header.s=google header.b=cVF2s76c
Received: by mail-oa1-f42.google.com with SMTP id 586e51a60fabf-4adae3eb4d3so659720fac.1
        for <kvm@vger.kernel.org>; Fri, 13 Nov 2026 01:09:54 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794560993; cv=none;
        d=google.com; s=arc-20260327;
        b=T5slQ83e/i18pLhstHuVQqPn/t2q/iij35sgxRtPDQIKwfFhBrsrngfnKOhtqjWB1K
         VFeq3fpm/ZsgxbeWuGLiUjNtmIrzlDQW0az3OIICSg7b/9+2gHZi5AIjQUn/d0K04yf8
         0k+tJj1QaiAWaJV4wC0itnlBfQqGEY4EH39RdhiDVWzZpq9pvJ6iXbzZBoMdWCwliOoD
         hSzz4W6lDktecwz/4wiTyRNEOEaAjAbMfV7/48UwkONhNY8142yg4HC0Q8QyuZsHlN2o
         RR6K77kPNYsea/il/c7Po+v5tPn64DG3ewkglKHV+sI8B2tFri5T96+P3iLsHhvSyhRZ
         +C5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=guR2kn0I9WVyI0WwVW8m8P4IC07cc5z6OUtXdezJXW0=;
        fh=VGrl2tmIHnraSvBH1Qm746m+QPITjmboOfPD91GKS+I=;
        b=pHAf56SwEMSCraDMIg0CcC1PRvpftSKPuhdAYZtHY4bc6HsPyhgzh3PvymX2I+cJct
         iD+LWUBAID3xtxecQ0WBr4JAmSo9x8jznbHIx4bQaAbYLGdJBfPaLgiZ/NBN6ZfjEKIu
         nIwcg1WY4eiaPDWtH+NLvACb+DtKsE+LOXHhSzkOknBusEnmvhg1zvPSzTFSB72rsZPb
         8sTKN9LnDFGGvhw7LAn+MH1KFRn3xMqFYTAGDtfc5bEYrvQvkf4EcNiGeFwJE2/s6ieE
         rUoR1l8McPYxtwE0dOj1WkzOokej2tJ95hGBW3WR4oj/lwYfEIoC6DighKXv7It8PiGh
         H32w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=flashbots.net; s=google; t=1794560993; x=1795165793; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=guR2kn0I9WVyI0WwVW8m8P4IC07cc5z6OUtXdezJXW0=;
        b=cVF2s76crrUEBSBW36t5JDEzTv4J7cNTCDmf+lJz7rwwx6KqLEpuy73WkOOYTKprwL
         yqKWkmIv4Kl7sLZFr8Yds98KHN4fZwFGhK8sFRSJ1S455RdEsUYCuGVMDkqFDjVaEsvS
         wCO5BrPQr4RwKdUm2+HSF1rsKJHm2mMV3CWFpmU9gtMpsTS1Z5PCRx8kvfvxZENN3/3X
         +sWEFmk6kdzZeQSm2hzNJet/YI4aB3FL93uHee3qfThMFp+f1vfx4xOwk9BeR28Jm7Bx
         2fHT5JxtJthzpRgDW0upHqz8gcyDOba1Y9X2fySWkzASsU9nZirNvgZ8E0ZOIEU37DQc
         u8FA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794560993; x=1795165793;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=guR2kn0I9WVyI0WwVW8m8P4IC07cc5z6OUtXdezJXW0=;
        b=ge9dTWSxy1twm5xwdfn6odW1v5UyYBZOspMYj26cicFML1QPFR+Zz1rZyM9FdSrB1p
         UIneglg4B4UnZ8tJQpf6yQxopNoBOSC8qXh5wa62EUdLpcjM1jSQWA4SeyKZn6l52Vth
         NEU/X6q2Z3tHWG6bCIR1X0GlkYIKJxtLx4llRA9FdKeuR7FyD9SaI1WqDe4T28wWF/cw
         vk0UTBLifXHqO1vqB2zD8xcbtjL0h/crHHrVfLwWDivdEjAH2gAYGQwP86d7py4Q/DoL
         R0T+dzhoQVmnD8IoFVZD+SoSL32vBlDIMJQrH7dzcGSJAKXfElBPeubq4zznp7vMv2Fp
         0pBQ==
X-Forwarded-Encrypted: i=1; AL+hErEnr3HE/+dVgScms2LlawwR3L0WXmRQfljUL1Ff2JOaJA8A88/vMXDAPuMOV/jjVvreU3I=@vger.kernel.org
X-Gm-Message-State: APuU4Z8NfRf/jpS/HlLFVpU6E8VzIZJPXSECsQFep/mXYvBd6QSamJew
	ookIz7PfUl/QrxCMbsg3ki0hj4YFQMdMvPvt3wLTO0/uKwZcqIQdRPdH2mODiKTt2h0Z/v9e4Gt
	wYbCvwnvq4M4bNM1NSrvcpIJ4kHkjKPv8DTQlgkITPg==
X-Gm-Gg: AYBFou0tzurTRBj7DncDXGaX6+E7H5DS27G73qz9ytB1oKog1cDeg2Dnm6b4HzJHH3i
	Nwg5gzLSkAmmcK4oMyjyBjkQHFmINkhQ7AgjxhfkipnQJmLllNdcq4Q7xO3b68K68loCj1U5tf/
	YyxcdiZOSWP1CPhDQ0ag8fRyDWDBb3X0Fn/tqhGHTIveLdOko1cqphaTXgKcy0Mfd+l+UAn1fMs
	dRFLxbJCrsNO+snCnEqyw89ugbn7vMraPqpi/uYDgjvQDg+9GTMohzIH4IrRwE/lOYWpkg46e+o
	dir92ASN6LQaxX5TQkec7bIfwCOySYxlqJ1wWhkLOuLYW/xlpT7Vny2nNdy85E4QvXqH4535Ik+
	GoK9m06raI5mqfxgV6n1QsvcwiwTMcjXxltaBvUIC3EnxdyHvAgTje22OHiFCqN6A+oMFH2xtcz
	E7n530leGwHN3/S1niEtntpDkOJU8UVfI9p2mQKH49V7aVlOw2tdfpgC09uaIwHQazRGTI00OlK
	Q==
X-Received: by 2002:a05:6870:e135:b0:43b:b245:30ac with SMTP id
 586e51a60fabf-4afdf492b47mr2095487fac.16.1794560993407; Fri, 13 Nov 2026
 01:09:53 -0800 (PST)
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261024-tdx-guest-quote-poll-v3-0-6a83bb767314@flashbots.net>
 <3b582cdcfe37f1d01ee71611ab2611f845261089.camel@intel.com> <CAKV3HMM9BKpmgWeFqRqamAsqqiofj+TG4DrOEHmbUyE0FjA7+w@mail.gmail.com>
In-Reply-To: <CAKV3HMM9BKpmgWeFqRqamAsqqiofj+TG4DrOEHmbUyE0FjA7+w@mail.gmail.com>
From: Moe Mahhouk <moe@flashbots.net>
Date: Fri, 13 Nov 2026 09:09:41 +0000
X-Gm-Features: AclHuK8gjoF7QTD6gz3W2dlc8aBwAvH7LfNyoPplzwlNGb-GET7hpsX60d1d4kI
Message-ID: <CAKV3HMOnY9LXvtFjnNKzfhVwxf7v-ZqDrRfceyLeVLP82x=bnQ@mail.gmail.com>
Subject: =?UTF-8?Q?Re=3A_=5B=F0=9F=9A=A8ext=5D_Re=3A_=5BPATCH_v3_0=2F2=5D_virt=3A_tdx=2Dguest=3A_Fi?=
	=?UTF-8?Q?x_and_speed_up_the_wait_for_a_Quote?=
To: "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
Cc: "thomas.lendacky@amd.com" <thomas.lendacky@amd.com>, 
	"sathyanarayanan.kuppuswamy@linux.intel.com" <sathyanarayanan.kuppuswamy@linux.intel.com>, 
	"kas@kernel.org" <kas@kernel.org>, "Aktas, Erdem" <erdemaktas@google.com>, 
	"djbw@kernel.org" <djbw@kernel.org>, 
	"dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>, 
	"linux-coco@lists.linux.dev" <linux-coco@lists.linux.dev>, "Miao, Jun" <jun.miao@intel.com>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
	"stable@vger.kernel.org" <stable@vger.kernel.org>, "x86@kernel.org" <x86@kernel.org>
Content-Type: text/plain; charset="UTF-8"

This is a gentle reminder; it has been 10 days since my last reply
without feedback. Do you have any thoughts on it?
Kind regards
