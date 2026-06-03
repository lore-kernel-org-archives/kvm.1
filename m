Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8C124028F5
	for <kvm@vger.kernel.org>; Wed,  3 Jun 2026 08:02:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780473776; cv=none; b=UKuyKQRkKb2HiW98+twUN/sDw7LCmd+two56T2PMZUTGQFXYeXC4jcbdu8DsUXJsnYadoFai3xEG91V67y1VfzRZrSapxiVBVocdO7qTEY67K9YO6f3y3+WDiyTRp9XiNs4CApSh6JPoPPb+j6bglcudZcjby0f84NnCLPHW1qk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780473776; c=relaxed/simple;
	bh=CUdxL2GR7o7ESdxlvLNeuY25sGeQO0E/Cs7P2N2ze6I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lI1Y8d9kWVer7H8mSRgeNC/4ryxJVRE8XjY04Iij4O4DIh8FGg8s0jPGBMnzLV7mDyxo/oAEKj0k+Cv0TbSir8xAuEJKLvhLOm3XcKSn849IA5Kc7MSWXKnuBmw9PLRri8DYvb/1FRrZvfJzJwUPN6w/T0MD+JRx1UHtUzB0yfI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=redB96i4; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="redB96i4"
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-36baeec21dcso3252697a91.3
        for <kvm@vger.kernel.org>; Wed, 03 Jun 2026 01:02:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780473775; x=1781078575; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=9MuF+yWJKjzDQs0kKZtPPTCGk9WmA5u/lg0Mr9iL+po=;
        b=redB96i4IoIWjKQkEou4hGT+62PH2deHP8oZe2sjYtkJBQ4DC7IKbnJehh1KE25Yje
         iKxmeIXWqHoQzdxenTgktacq8nD4CEEwxrmF+OKAc081SADNd2hfK89k1dRgThWDqrFt
         yRSzaYvoAcXR188CLUIDjEKKc0AkpKJV3AxB3f+PuAgTtC6ta4vfaFuLNeXd3wRhwhp+
         k7Ow1fDsCYhsyzSa9fj9FpIXrPxta6iqWcez4jEBCFkfjpZJBB7NC+ZgdWIZu6s7li0o
         AbnFFhUL5KjAbDjh22DgoeVEF1AThligVvNCdqd26c+qx+NkNRhu8bhacKvxyskMOS+q
         pV1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780473775; x=1781078575;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9MuF+yWJKjzDQs0kKZtPPTCGk9WmA5u/lg0Mr9iL+po=;
        b=nYSFZMhl4kaHHlMz++L3WhHRMUGX4Js4QQHo/kqskvyO0eX8aWbdCEcbBUlRXvw12G
         JWIlmDFBDnrlb71PCbxldWbmCfOjG6HC/9sfkNnVdmMNjH2xqHa7FIylra7HIdvAiT/6
         4kghp9dGyYYZKQ18H8v2N1fui7cJ+78uDFcV8zFICEwRxliD0rdKCz9ohWMqFSgmeZNa
         riGJ7ilcLyMS6DDTVkQO3mfPgZiHVffXRVUPUuAS5Ioc+34ZIgIGjcErQIuly1CnRog5
         DdTcSkP2bgN4ahFtHNAYgcORf66Jh1I6Dkm2ZjYk+aEPkiN7oZU73M1ZyrPKRFyis+6u
         MutA==
X-Forwarded-Encrypted: i=1; AFNElJ9p2uvDPClNH10IOY0L6I3nlFQCUQVBpRRKpHPY02OSEVlRAibucSXx0wRD50bgyweXIQg=@vger.kernel.org
X-Gm-Message-State: AOJu0YyWB7iMjcJsxrZHcr0LfzvcaQs62umO8gr3wC6LlfPaby8JFapC
	PeslNx9IRietJWilPqw4DNeXN1v4CBUrLh6Z6BWhy2jFnv3g5DWvBJf0
X-Gm-Gg: Acq92OHcJdi3/ai96NkRCFfrfxs8B7oN+PxsIoeViZEKjqgTkavwknx2rdQp/MC4WKZ
	R1DS2vg6x7xu9SZUbYiLwyEeAFfWE6pJM9Cet5kDo2P/k07cWoEBFuwF4nR0Vw50aSu6DKVneve
	yyRCTssFIoxkatLX6yl/N6B9AidHd/o1TGXX06k1+jmCpKdpGtVYZx1oCv+mMSAemf1Wlu6SFO6
	ZYhzAA5HwaS8qt9D/pQjwyAZk+Zc3Nb12vC/T+w29mt4Dgb9GhqFlE40djwEZNRU4ej+H4jjZcQ
	v3S3YJfU2vrg7T5EccGRWB9YUs7w9HQUNx1FoggGImMVT6UtttlsDG72/XZBtnzEs3j/TBpblmN
	B1O35ffRsCKYnyFYopxvrfEI1k+2abY7txmhBFdvTSOBNqDDVqN0opEMi97aWgV565I7EIlGe57
	eLHtR614WALMZ0PHwCsbscV5oqytLSSeQFgg==
X-Received: by 2002:a17:90b:5610:b0:36d:9e0b:3801 with SMTP id 98e67ed59e1d1-36e30d1c00fmr2269817a91.8.1780473774886;
        Wed, 03 Jun 2026 01:02:54 -0700 (PDT)
Received: from localhost ([2001:19f0:8001:1b2d:5400:5ff:fefa:a95d])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-36dd98797fesm5144475a91.13.2026.06.03.01.02.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Jun 2026 01:02:54 -0700 (PDT)
Date: Wed, 3 Jun 2026 16:02:35 +0800
From: Inochi Amaoto <inochiama@gmail.com>
To: Anup Patel <anup@brainfault.org>, Inochi Amaoto <inochiama@gmail.com>
Cc: Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>, 
	Atish Patra <atish.patra@linux.dev>, Paolo Bonzini <pbonzini@redhat.com>, 
	Shuah Khan <shuah@kernel.org>, Deepak Gupta <debug@rivosinc.com>, 
	Thomas Huth <thuth@redhat.com>, Charlie Jenkins <charlie@rivosinc.com>, 
	Sergey Matyukevich <geomatsi@gmail.com>, linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org, 
	kvm@vger.kernel.org, kvm-riscv@lists.infradead.org, linux-kselftest@vger.kernel.org, 
	Yixun Lan <dlan@gentoo.org>, Longbin Li <looong.bin@gmail.com>, 
	Quan Zhou <zhouquan@iscas.ac.cn>
Subject: Re: [PATCH v2 4/7] RISC-V: KVM: Allow Zicfiss/Zicfilp extensions for
 Guest/VM
Message-ID: <ah_fkXOLpNHvnmNM@inochi.infowork>
References: <20260601084336.2601675-1-inochiama@gmail.com>
 <20260601084336.2601675-5-inochiama@gmail.com>
 <ah1pgb4S-UoSWhC_@inochi.infowork>
 <CAAhSdy0ZycwjYrKowzaydKhh=fcEDD9-C6TKmb838s0hq8a2hA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAAhSdy0ZycwjYrKowzaydKhh=fcEDD9-C6TKmb838s0hq8a2hA@mail.gmail.com>

On Wed, Jun 03, 2026 at 01:16:14PM +0530, Anup Patel wrote:
> On Mon, Jun 1, 2026 at 4:46 PM Inochi Amaoto <inochiama@gmail.com> wrote:
> >
> > On Mon, Jun 01, 2026 at 04:43:32PM +0800, Inochi Amaoto wrote:
> > > Extend the KVM ISA extension array to allow KVM userspace to
> > > detect and enable Zicfiss/Zicfilp extensions for Guest/VM.
> > >
> > > Assisted-by: YuanSheng:claude-4.7-opus
> > > Co-developed-by: Quan Zhou <zhouquan@iscas.ac.cn>
> > > Signed-off-by: Quan Zhou <zhouquan@iscas.ac.cn>
> > > Signed-off-by: Inochi Amaoto <inochiama@gmail.com>
> > > ---
> > >  arch/riscv/include/uapi/asm/kvm.h | 2 ++
> > >  arch/riscv/kvm/isa.c              | 2 ++
> > >  2 files changed, 4 insertions(+)
> > >
> >
> > I have forgot to add CSR_SSP to the context, will add in the next
> > version. But I have a small question for it: could I reuse the
> > generic subtype or use a new CSR subtype?
> >
> 
> Add another CSR subtype for Zicfiss.
> 
> Regards,
> Anup

Thanks, I will do it.

Regards,
Inochi
