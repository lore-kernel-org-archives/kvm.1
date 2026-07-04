Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37116285C8B
	for <kvm@vger.kernel.org>; Sat,  4 Jul 2026 14:26:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.180
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783175217; cv=pass; b=AAsH1oTdTAimB+cmjxePh3hLPsotW6h+lR/5YrmQ4H99sg8bgjfUzAAOMtNDnrq2vnikKBuiCo6FlIZ758RVIT9A6u6Is3CRtJf1cfma4kRc5TuOsuACwlgMsPUHrCb7tRuwikgRVritT9OS2dW2R3vQPrrYSyIg9c7z0E94PDc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783175217; c=relaxed/simple;
	bh=9YDFkrKXe8+xQwIOAGKt+OLc4uyD4YgCdy+nIHJ3u8A=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iYBxyebE47W8AZOqgp/plbgNIFIILwcju/2RUkx81/msyTAohy9Gf4cMxfgiAhfI5skOeV9zL5AZyxzmagj6ETPy3OtqFODguWv0UHgYGdFbHXlxPWBt3ZNrcCV3YYy3ZaDJXBvDU4IgxqY5PDu4cLvjf7nItnva3w3Lx2DLvS4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=M1baawTn; arc=pass smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="M1baawTn"
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-2cacd69a9c0so11498495ad.1
        for <kvm@vger.kernel.org>; Sat, 04 Jul 2026 07:26:56 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783175215; cv=none;
        d=google.com; s=arc-20260327;
        b=c0CGW4mY1wnXM00aFB1gVMSnUyn7bX4vmZLooeXjC5iZV7HCxagShYN+QXJKmXda4d
         vtzmwDXC7q50N1xWskqSiRsCGKh7oYGbi1yBUH/sWWWvHaOSDgcb0Sv8JLuYlJ/psNg4
         2oDhdp8frtCDGP/woV01Fl6ne2xDq6TpHzZLPBTmCVOdoQGbtHStfL+SH+LhdoQBNW7b
         4csGeItmANac1QPpvOpc/n7wNYs9zsMNBRUIk53X5FfyasdrTMjXvUUng0Im2exUVoLO
         ttpGCSso/70HJp7gVQWNQWblo2DBVEr57jQ+124/msxWK3EP7GYA/Yyhk+CO9Es+33fD
         atKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:dkim-signature;
        bh=WFnktr3xnr1z9FtsyBzXxn1YoZbHM5Izj7pi+H56QNg=;
        fh=O8sDm0juuk1mor70vxnbARLM6rx4Yiv6xO0g91TEL6w=;
        b=pP5R0R+96GX6gWVv14uegnPhxDDqaOz8foCCkk5Jn1dtIT+rw1xmDZKNQVj3dthBCz
         uiHUrrpWv3hexdi5wVYCjiSQ06H+v0zZKORC0YVWbapE5+/9q/muL1IHEjmeVNtG9hvU
         4OTBVUh4PY5vniBYW4cE0Zl5m2eA6CE+OkPjUp1cCEacHcbeEBSmMzDpsrwyfeFRH6we
         CFx3E7gy4wckkMk6R2PTX74mIvYVA7w3kevc81HQT1w0o+3uXnRDF37draM6t6m8Lj5I
         O03lsNlvSSJZ9ZYJhsm87s5NkI5WOrXe96y0OgAr7mx6WnnHxhbBiVHwOeLtOD/6VFt2
         ViTA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1783175215; x=1783780015; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:mime-version:references
         :in-reply-to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=WFnktr3xnr1z9FtsyBzXxn1YoZbHM5Izj7pi+H56QNg=;
        b=M1baawTn9ZGAkIeapgq+EKg6iQ3Braxw5mPSq+yOk9IURTYNAjV/izx+ShHHke3+Zv
         61wiMqaIun7SXk6LLntP13lSfZ3y8aiI8dvMwXSBB/Fn2AhCEEAXl3S09Tca3P1j0raE
         Xz/DuZz4yprQNAjIqnnQDj1W0UQZgGEgBGxS/1WYFDnFBl4G00QMvnNFoQ0DLhVzWRlq
         1keiRaipatCWZdJOK/wsWlK1dASpLw5DvK7VAzESrwvoY9TZN1lFfHvQEFfd4xiUjHOE
         ncaD1AhnZPIrWXOPgDJbzTk5xy01dUgPDkPh7mzEP0+IGIshOt5Huc6s2qsE+l0VsMV9
         1Hdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783175215; x=1783780015;
        h=content-type:cc:to:subject:message-id:date:mime-version:references
         :in-reply-to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=WFnktr3xnr1z9FtsyBzXxn1YoZbHM5Izj7pi+H56QNg=;
        b=Wqbn7ZNqpJxqHiwxbhMCZFPup/xlevn5lIDMz/sArgjy4/FK5dErI9Ea7vHlFlS5iG
         Nn9WSM78TVUsEVq6IP2MQmB9VSjXzkUGDgiFNEdHoenyyBnTWL2D4CGu9H3C02NGMHPv
         1I6b5x8SIONW2KklOyUXnDBcHVLCWDWDKPy+jxK5QvH50uQoFm/j3eTHn4J8O0XqwmyR
         G3o8AdsZXNwNOp6QOmx0wU32ma+BBzq6PSD6Gv4Zb0055ILVQlwyuwjWTLaQIepz1hse
         hQWfyJiHKpJa1ZRI80i7jWdv0MSXFjZRbLWP5G3NtrlOVzs1BA1a7ssfsl+bh9PaYkEe
         wUtA==
X-Forwarded-Encrypted: i=1; AHgh+RrzWr9cBi52ToyiJYRgsHI26N7O2fltw0YGYGyLKo3M1A7bgBoEbzd9fa58Le861b5B5Lk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwDeFxTibRYXhEx/X8+W6rEM+sIo2WdcR0XQ+PluxlCJqgSjUBP
	cIOKdpa/GAZrWtiU3bbgOElvGv3iTOqviW44Pm/q7/3RGG47vQMQUPRK/37fprDY5sWMBC1hPLT
	iKFy7R0xX1Tf6h4L5H/J6xOlBhYMLCUVbnhxDF7El
X-Gm-Gg: AfdE7ckG9EuMPgjH2agpXcKGIDFjeBXxT/DeQZvry4mu7py1i/P62a/JrYiXGYl7wE9
	GNmo7Pth6Ebb6JqOaktsEnruS8TLyM9SGuPqCW8glDiKAwbVlpVwHbmRRQd8kZnbaD3WR1UGtHa
	UV49rZlXSMeQnZ3PiVl19fZvnPk8XIaADtDTYPCl+hvX64ECyYa97gnvCRzY+mq6fhw6Zmm9AN/
	Fu6EeqxtsU+uS+imeTiFFq+5wyc2uYruq4RQ5LdgDy0wDv/mz8Tw1kFXQ8X5LbmwcYYW42pigLs
	Y8ZJFzR/lICdgYQsDS5gIZUQ+/FyL6jVy4dSoJk=
X-Received: by 2002:a17:903:1ce:b0:2c6:a012:6241 with SMTP id
 d9443c01a7336-2cbb201b39cmr35063005ad.6.1783175214863; Sat, 04 Jul 2026
 07:26:54 -0700 (PDT)
Received: from 176938342045 named unknown by gmailapi.google.com with
 HTTPREST; Sat, 4 Jul 2026 07:26:53 -0700
Received: from 176938342045 named unknown by gmailapi.google.com with
 HTTPREST; Sat, 4 Jul 2026 07:26:53 -0700
From: Ackerley Tng <ackerleytng@google.com>
In-Reply-To: <20260327160132.2946114-16-yilun.xu@linux.intel.com>
References: <20260327160132.2946114-1-yilun.xu@linux.intel.com> <20260327160132.2946114-16-yilun.xu@linux.intel.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Sat, 4 Jul 2026 07:26:53 -0700
X-Gm-Features: AVVi8CfdRsR_CKNKNIUlkjPTBxsOwA_Mmn0xqA4DX_E8qDCY3KX5iWgXVn3NJRs
Message-ID: <CAEvNRgHauBdavhq68BepiOpJd1_UmBUQTkfsRmNimZycZ4VW-Q@mail.gmail.com>
Subject: Re: [PATCH v2 15/31] coco/tdx-host: Introduce a "tdx_host" device
To: Xu Yilun <yilun.xu@linux.intel.com>, linux-coco@lists.linux.dev, 
	linux-pci@vger.kernel.org, dan.j.williams@intel.com, x86@kernel.org
Cc: chao.gao@intel.com, dave.jiang@intel.com, baolu.lu@linux.intel.com, 
	yilun.xu@intel.com, zhenzhong.duan@intel.com, kvm@vger.kernel.org, 
	rick.p.edgecombe@intel.com, dave.hansen@linux.intel.com, kas@kernel.org, 
	xiaoyao.li@intel.com, vishal.l.verma@intel.com, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Xu Yilun <yilun.xu@linux.intel.com> writes:

> From: Chao Gao <chao.gao@intel.com>
>
> TDX depends on a platform firmware module that is invoked via instructions
> similar to vmenter (i.e. enter into a new privileged "root-mode" context to
> manage private memory and private device mechanisms). It is a software
> construct that depends on the CPU vmxon state to enable invocation of
> TDX module ABIs. Unlike other Trusted Execution Environment (TEE) platform
> implementations that employ a firmware module running on a PCI device with
> an MMIO mailbox for communication, TDX has no hardware device to point to
> as the TEE Secure Manager (TSM).
>

I'm trying to get up to speed on Confidential IO. Thank you for this
summary!

s/TEE Secure Manager (TSM)/TEE Security Manager/

> Create a virtual device not only to align with other implementations but
> also to make it easier to
>
>  - expose metadata (e.g., TDX module version, seamldr version etc) to
>    the userspace as device attributes
>
>  - implement firmware uploader APIs which are tied to a device. This is
>    needed to support TDX module runtime updates
>
>  - enable TDX Connect which will share a common infrastructure with other
>    platform implementations. In the TDX Connect context, every
>    architecture has a TSM, represented by a PCIe or virtual device. The
>    new "tdx_host" device will serve the TSM role.
>
> A faux device is used for TDX because the TDX module is singular within
> the system and lacks associated platform resources. Using a faux device
> eliminates the need to create a stub bus.
>
> The call to tdx_get_sysinfo() ensures that the TDX module is ready to
> provide services.
>
> Note that AMD has a PCI device for the PSP for SEV and ARM CCA will
> likely have a faux device [1].
>
> Co-developed-by: Xu Yilun <yilun.xu@linux.intel.com>
> Signed-off-by: Dan Williams <dan.j.williams@intel.com>
> Signed-off-by: Chao Gao <chao.gao@intel.com>
> Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>
> Reviewed-by: Tony Lindgren <tony.lindgren@linux.intel.com>
> Reviewed-by: Xu Yilun <yilun.xu@linux.intel.com>
> Reviewed-by: Kai Huang <kai.huang@intel.com>
> Reviewed-by: Kiryl Shutsemau (Meta) <kas@kernel.org>
> Link: https://lore.kernel.org/all/2025073035-bulginess-rematch-b92e@gregkh/ # [1]
> Signed-off-by: Xu Yilun <yilun.xu@linux.intel.com>
>
> [...snip...]
>
