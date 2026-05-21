Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B27C6349CEF
	for <kvm@vger.kernel.org>; Thu, 21 May 2026 10:14:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=170.10.133.124
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779358488; cv=pass; b=I3Ei1ouVpEpSN1nmQcGslO1YHY7ywF5fTJ2iq4YAO9Z5YjsPspICjvjLdo8Qwt2bUIdc7VC5PNXM+FYro10GGAhhUhTFiYxdoLIhbE+1NUOozqZBSZ+4VSFG7kfpD/YoWBCTFbZ81/DsRiNqJVdiqEItUxuDhRLMoh22NaLZn0w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779358488; c=relaxed/simple;
	bh=jfJfUfZwkITuj+A72mVqrRYAUJYPdxaAgybuk5Y89QQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ElLqrsUPLDznGauS5+bnSX6QbMYOnj7mHUYOaMIHQx83ub1hmmE8cT6wsZolv7wVPnBRLEeqBWcGgkF+Uf/ZFGkx3iKAaGyNb7DndnK+q9dTAy1r9r/wV+Iaq9FMnY9383eegUVr/OFMo2Xc29I4WUMW2JQipAFro92Ec7S9IqE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=T+tJQpWh; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=Ba60+Whv; arc=pass smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="T+tJQpWh";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="Ba60+Whv"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1779358485;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Zh/94NiySJS5+4ZOJOdPVe0OXy5U8uoR7He4qx0GnS8=;
	b=T+tJQpWhgGaAsTX+ny7/CmXE3TyBmcFEVtkkjWdfYZq8z7DJ4dr57Xl/cPnS1cd3p75oD+
	g820+th2Hlm/bUftOGp7PTCIForeoL8Feh+OsnikLqaeBwZ4/TxigE8+vx0RrI90K2MwAb
	eknKl/CM3e5eeOHZFuI5sFOOEw6ZYro=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-342-mEVVtTNvM9eOjhp5HH0tzQ-1; Thu, 21 May 2026 06:14:42 -0400
X-MC-Unique: mEVVtTNvM9eOjhp5HH0tzQ-1
X-Mimecast-MFC-AGG-ID: mEVVtTNvM9eOjhp5HH0tzQ_1779358481
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-43d7730e9e3so3457841f8f.2
        for <kvm@vger.kernel.org>; Thu, 21 May 2026 03:14:41 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779358481; cv=none;
        d=google.com; s=arc-20240605;
        b=SVxrCbmB6O8fw0qPBTOKzOqMta8q2eG2llCJTxcH3RhWkoA4MN0feQxSmcT+Bef4HS
         c9U6uQNDXTxOMEj3ibDznz3xzLaxBFDvlW/ejm1qW/Pn6TKOsYEym/+xlB81O7gH+RgD
         YyfnKaeuPNOD+Xqzh3zHsJdu4g4uYhwnZ+WL5/oM30Zegn/VdvoK7CULAMHBZ8Kw/anV
         Dher7hZZeTaUgJXvGRp/BqlH2XSJD8FeArwH9XlkBL5950fnuJUU0mv36CcBQ+QqRUGa
         vtRzIF1rkZ3bSCzds+EjnhKfl2/MD4JRlz+h262OVtCSzCVBZtxuaop1oyukyryDKPpd
         BsRw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Zh/94NiySJS5+4ZOJOdPVe0OXy5U8uoR7He4qx0GnS8=;
        fh=BsAc4bVYH068yoEJO05UMYtzp63y3tIU4Sb9q8Hu/fw=;
        b=DAQKIA9lu+mCQqCWIQH5Mfihfv9hOHLpJ0QPoNZs85dkTwYxhuUVs9scoxXzuQTdSe
         KXOPs9hQuasIZGmx0hFH6b/whyh3T1Jode1Z4j9YMHn+y4C7Tzd5/5YXWH8RaFV+DDkb
         V+W37pXTqC7OoU3faVLq2nDW6GIyD7DuhyD9U9LbstwqhE6LAmuMQHdf/tIj+PjW608I
         inRMXUheggvZzOq01A4SbJEXbgFYz3xJpkBNcnS7RWGw2pXkffjNVGNN3Y7NA9r70vSC
         f/OgLbB3pbv3AJg4TT6svnn72J8v2dCtVo+2iHHGY6ZF9DF9gYsbpURENcTkb8kKFmhO
         hNWA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1779358481; x=1779963281; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Zh/94NiySJS5+4ZOJOdPVe0OXy5U8uoR7He4qx0GnS8=;
        b=Ba60+WhvkSahT+qQddrnWY2L5T2zkwZlnvUJH4LXBk83JEwbER31j3XG3hA9+cq3H+
         y8k4wbqyRA4lfIp/UPyuPlY2pCOjJ+kf7pIl338OqCT8Kh4xOl87ilEyYyxZ8Ad2xF0Y
         1nv5NVT374jBMwImvI1qUZk0f+8J571Ncp8AAhvmZSffJE2vXOW788yALcbHoH/IPeqX
         3GebiHluViO4qMLzz15YAvzFZwZBnMZjE76VEFTz4M+smrLgld1Y2QVa8DVeqbn/ytDm
         VNwn1B30eTgNsYkBYb0ROWN+MPwYLvIiApRhq/9HW2S/FtMRgx4xwlDmJrR0Q4+BxiGE
         924g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779358481; x=1779963281;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Zh/94NiySJS5+4ZOJOdPVe0OXy5U8uoR7He4qx0GnS8=;
        b=F4yZBBx6X+IEMuy2mABylg4qZBptypYnXm6X0O9FUtqAPeJoPsjlVsN56axQA6eOgw
         DSOQXdhueawd1RWnx+frU4/nqFwLjUMWorrAj56iIjH5MZdO2/KSYgTajXS4hEFjflAm
         yk25BiFF20UxBnohhn6khg3TkAWo1hzdnRhmwygc4/NM1l09bkczF+Vgr52qkh2FDaik
         A+Dj+nzNvNhc1Cw/LnASCOqMCw1T/UAZNxOc3xAXUO+hshJwiUl4yKxh3VizYPKu9s5n
         XWlwaO8Jy0c5PhVoYGBIOMLse5D3ivB0pneLNiem9V6cl2fBV8svQMmQM2ABLu6zlF3K
         tYeg==
X-Gm-Message-State: AOJu0Yxe4eVLrUTqZsu5ozj1Q6JQ8vdoyJnsmblCdHyoaEaHLWIh0NLz
	ow77tiAewkj0g6oX0KbcASbV4qLHZrvIyu0VhyY+Y36AqSVyZIXUFN7kX5Yfs+jE5MAl3w6luoN
	2mha125eC02tXgDdxlbHOHjADk5jcibRjXX3WbAASqtE00laWIjdsy+v237Oe3R68+d9oE1iZZM
	wBDFtMjPaqIh/C5OHTLsWUzX8HOosVwolL8wZBqFIy3g==
X-Gm-Gg: Acq92OHaH1jR81AXc7Ooai9UNtgUn7e/18QVof2cpIRG5zpS6leQr18hqvumXqlQ6A4
	5YB5tIQl4Lt06u9MUVg6uAqTaMSxLoGu0wW+yVDGMi2niXPRmI+2epns1RQ+UYyuH2jChw3mC09
	FxZ9Qq9Rhj04BrvAlZzJi/nR6DgBXrZHMohAr8YwR+Qjq6P2XL5o/u+B/aFKShOcEMQsQCarV09
	pPPxxhmww5euTJW1Gn2JuAvq5sNLboU/lVgHFkdNH9UXIyHfYCo+8OLfZp/V43HzisAMj/fE3Y7
	iQBiayM=
X-Received: by 2002:a5d:598c:0:b0:448:8db5:410b with SMTP id ffacd0b85a97d-45ea3ff7cccmr3249766f8f.20.1779358480738;
        Thu, 21 May 2026 03:14:40 -0700 (PDT)
X-Received: by 2002:a5d:598c:0:b0:448:8db5:410b with SMTP id
 ffacd0b85a97d-45ea3ff7cccmr3249732f8f.20.1779358480373; Thu, 21 May 2026
 03:14:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260514210500.1626871-1-seanjc@google.com> <d2f3be07-b930-402d-bac5-63a21877f6e2@redhat.com>
In-Reply-To: <d2f3be07-b930-402d-bac5-63a21877f6e2@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Thu, 21 May 2026 12:14:28 +0200
X-Gm-Features: AVHnY4JaccDWvWSxEEeH34wnCZL6jEJ0SEWorNTU484sSbVeU4nt3cvD-xL0NgM
Message-ID: <CABgObfZJbfqtpyh-fxPcni8EUmsmauGgUCsmcfZmq9h3RGMjMw@mail.gmail.com>
Subject: Re: [kvm-unit-tests PATCH v3 00/20] x86: Better backtraces for leaf functions
To: Sean Christopherson <seanjc@google.com>
Cc: kvm@vger.kernel.org, Mathias Krause <minipli@grsecurity.net>, 
	Andrew Jones <andrew.jones@linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, May 21, 2026 at 11:24=E2=80=AFAM Paolo Bonzini <pbonzini@redhat.com=
> wrote:
>
> On 5/14/26 23:04, Sean Christopherson wrote:
> > Finally re-posting Mathias' work to provide better backtraces on x86, w=
hich
> > was blocked by a fatal bug in the nVMX SIPI test that was exposed by th=
e
> > stack frame side effects.  This has been sitting on my local system(s) =
for
> > something like 5 months, and I all but forgot I hadn't posted it.
> >
> > Most of this series is cleaning up the nVMX and nSVM to play nice with
> > multi-CPU tests.  Then to fix the race in the problematic SIPI, abuse t=
he
> > VM-Entry MSR load list to atomically detect VM-Enter (I'm still proud o=
f
> > that hack).
> >
> > For gory details:
> >
> > https://lore.kernel.org/all/3bac29b9-4c49-4e5d-997e-9e4019a2fceb@grsecu=
rity.net
>
> I'm applying patches 1-18

... there are some

memset(regs, 0, sizeof(regs));

that have to be changed to sizeof(*regs) too. Fixed and pushed.

Paolo

