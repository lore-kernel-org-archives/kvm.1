Received: from mail-dl1-f43.google.com (mail-dl1-f43.google.com [74.125.82.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07FE435DA73
	for <kvm@vger.kernel.org>; Thu, 12 Mar 2026 15:26:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773329176; cv=pass; b=uNG5fMawV661BLr1nsHn/F+RPYVw0jWmeF9ZoEf5hgjGDOojHaroe+VxcTXMsVGfkM3QR54eACJKf2A529rpXbEJHdmrz4UE/i7gw89XxfRHGEBJwaLIppn/cDPnKLATzYXl6XqNDEG5XuXu9uRkpfHuVDglazY5qoPEBqIV4Sc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773329176; c=relaxed/simple;
	bh=NLjwGsHlk+dRfPl5Lz1YqZqOgqwc9hRYCnD+KjfOKTM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=du4gs0toX0u/FuRmdq8GOsMhAs0F5miDv7V80HluzmFTEM4gP6HKP8wt9jEhCVMYWYNBS6Qg8fL+LF/2ghoEQaYiEulCVV4tKuZWE7bi9DekRynFlHrrCg6Fu5TgJhdo3ceU4Z7lF/YHZ2TFzQ+5c5n4dmz4j7MWkmRCfYQUz3I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=kLayBTey; arc=pass smtp.client-ip=74.125.82.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="kLayBTey"
Received: by mail-dl1-f43.google.com with SMTP id a92af1059eb24-126ea4e9697so9288c88.1
        for <kvm@vger.kernel.org>; Thu, 12 Mar 2026 08:26:14 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773329174; cv=none;
        d=google.com; s=arc-20240605;
        b=LBlixecuP3hRBHDnFISQTKryALdxg7fa5cD8Gl4zHq2Ak89QNB/IpuhpuJkkwWjKXU
         9bTS36eqft+Wtgxz4W0N6w0w/GXtwOg35Z8VF9mUQMKAJf5vzPpeT4z44idP9O82XtQY
         evjFsH5k2/BeQjIQAPx7D8gmzTqciwrjn8K42C4uIpEJgWh6/iqBtqtGKY7eU9XYmwVT
         sMCZBOQxejLohaFTgxK9HA1/MdWCK1qYklt3l75h58GtRsOjegaaO8BrvZ8WOxrUOjMV
         UaOnOAQ5JUL/fnXorsPjJbTFP30qlxbCDFxsnfKe6/H3qzSOpzVebY6tjMMBGYSKxJ6j
         ZbRw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=+tX46ywRQrGiR+sEEMLYlISgAc/P64iJUL6bhRRSjrw=;
        fh=ZEX+NKblt10Jbechtil69xsm3lan0yiQaxJ3av+1ZXo=;
        b=M4oB2j4v/E0mpfSXtEYzNSAMmXimbJQvX58N7vHvwzQ2o2FIHuxYbGV1CK+yf0uKOS
         xMgkCJiC4pnpThRxFXsK50GLJUE+nRy6fi/UEj6HJPis1bKZi5VXOuWfAZett4G4OBIo
         y7KvJqFmcFVfYUU7wZ2DnonrKXKF12xGsHEmfxRETpC5cPP+h5uLqrv/GyFxPTAyUc0k
         tcKy57XjCmKqQhY5BEiPUawRip8AQwSK3yHzIWIT4PZBU/XVbQAT++dAak94X4cnfNm2
         CxGa2aL34uKF+X7pd+egMxs2SsbdB6oWYoHiJ06nvZEltCrYEcDGlJWDXr7yeNWIb47e
         BXzg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1773329174; x=1773933974; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+tX46ywRQrGiR+sEEMLYlISgAc/P64iJUL6bhRRSjrw=;
        b=kLayBTeykWui79v0AP6sDYi5dklaic52EpzIWZbo04WLJZ+UuAFvha2n9yAcSaER+s
         BNUrz7E69XE1ybxMAcwlWrc7KK+yzixONp+O/1VZoCoonWil9LfSRwjXPB50r/HDntBy
         PpDBsaNzfr0OZP0bRSBeMQW5W/B2WgmP30dyJl1p59wYa+UbUI9Xlov67HkMH7jE/kPM
         atWb+KlhdnK5rtM0e575t/M1+41Avjkrhk6gj+yRglOKVt6INoPEJeiFG6NLRXel3iEx
         GfOIgHc0/zs2jUBnfrlboEr88gaMVEHigHGfbXJaQrGHjfqHi/TFapV5SdaJVXFYBdhr
         DiKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773329174; x=1773933974;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=+tX46ywRQrGiR+sEEMLYlISgAc/P64iJUL6bhRRSjrw=;
        b=JUuNLgoXogrcFPDLRvrTUzCvmCFZNM8vG+i5dycz9mSz/rR7fsZHgmTzQuZDHP0hWd
         DOolSDOd0u6P49+3BKHJRXmy/TD6m6FR/SAqZOYv0XaO8yjS1qDVUqMo+muxRkzJRkbQ
         dir5tcSF3S2tGAjg3WLu8vogyLakFihJhpXZHidpyLr98bbfLKx9xCxpAUvZwPWi5t5D
         zES8oClV9Kw3zaZwdpgqf5/jc8TvbUZFXZROSwwO/WO/P5vVZZ4ejv2VHY69m2fniMn9
         3yrEhQv75hXYRrVqf6kOL9YL1d2HgDymhW1A7T+gKq1GpgDykjQptw7FLK3AIWOCx+jX
         YRgA==
X-Forwarded-Encrypted: i=1; AJvYcCVrIk2tSZ/MCROr/VJsxyZfDnWh+vakw1+b9bkk0exYx5Txx08TxfLneTTRD1oxgBsi+8M=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx9Z3XqtSyy4W2hZMXfy6B98SYenIOH9LmRYhKfwW5fdmH7EtWq
	ZcCo4w5PKkHEFzTigtNwKm/u3goCKnqoZfmAU0hK+Pqr1IQC/XOH1PC9QfcmjiwxS0ldsDXdYQy
	FM5dfxfi3zG3YyXshPi8JVYAuZDCkP/O2Hxa77pUS
X-Gm-Gg: ATEYQzyyM+RPICHOwwA9BzUFWh62aRqlSN+Zf7tJ4miXm0GmZtTXqpfhHeBbR23mUCY
	RtpgPrOBQfG38TQr93I/9mvKCtC5hywaID5XuMeyWGcBPOvr294bf6EzfAHzYkL1IMDv6sVRwyE
	L4Y6JY3BR09TRZjwXxsn6Mq2ib/O++igVDbzX+Gwks3dnODTiEQaq7qirh2wRUAhFc1m5v5AzFV
	3t33uGWociIGWuZ3ZTRO3MNKOcbpukauK8GZWFmaWwiBunpKBqzFG0ZqHkpQlRnh8wdKfBEcVJi
	SDLgdf5ee/0twddEZQ381LKBCPsvjNdJuERALcJv
X-Received: by 2002:a05:701b:4243:20b0:119:e55a:808a with SMTP id
 a92af1059eb24-128edc2f354mr113223c88.7.1773329173422; Thu, 12 Mar 2026
 08:26:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260212143606.534586-1-chao.gao@intel.com> <20260212143606.534586-25-chao.gao@intel.com>
 <abFlCkNd7tqaUyAP@intel.com> <d664ac9445b1c7cc864dead103086341c374b094.camel@intel.com>
 <abJ90EMUnEAy763n@intel.com>
In-Reply-To: <abJ90EMUnEAy763n@intel.com>
From: Vishal Annapurve <vannapurve@google.com>
Date: Thu, 12 Mar 2026 08:26:01 -0700
X-Gm-Features: AaiRm503LUBcief4sac2Y1wxyiNh-NpP2rk1C1kobpRnod9RsgX__R95s5kuIco
Message-ID: <CAGtprH-tAohbEuQ=BBx=MeUv_hcWmbTADcLMfyi7cVHGo+0ukA@mail.gmail.com>
Subject: Re: [PATCH v4 24/24] [NOT-FOR-REVIEW] x86/virt/seamldr: Save and
 restore current VMCS
To: Chao Gao <chao.gao@intel.com>
Cc: "Huang, Kai" <kai.huang@intel.com>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>, 
	"linux-coco@lists.linux.dev" <linux-coco@lists.linux.dev>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "x86@kernel.org" <x86@kernel.org>, 
	"dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>, 
	"tony.lindgren@linux.intel.com" <tony.lindgren@linux.intel.com>, 
	"binbin.wu@linux.intel.com" <binbin.wu@linux.intel.com>, "seanjc@google.com" <seanjc@google.com>, 
	"kas@kernel.org" <kas@kernel.org>, "Chatre, Reinette" <reinette.chatre@intel.com>, 
	"Verma, Vishal L" <vishal.l.verma@intel.com>, "nik.borisov@suse.com" <nik.borisov@suse.com>, 
	"mingo@redhat.com" <mingo@redhat.com>, "Weiny, Ira" <ira.weiny@intel.com>, "hpa@zytor.com" <hpa@zytor.com>, 
	"sagis@google.com" <sagis@google.com>, "Duan, Zhenzhong" <zhenzhong.duan@intel.com>, 
	"Edgecombe, Rick P" <rick.p.edgecombe@intel.com>, "paulmck@kernel.org" <paulmck@kernel.org>, 
	"tglx@kernel.org" <tglx@kernel.org>, "yilun.xu@linux.intel.com" <yilun.xu@linux.intel.com>, 
	"Williams, Dan J" <dan.j.williams@intel.com>, "bp@alien8.de" <bp@alien8.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 12, 2026 at 1:48=E2=80=AFAM Chao Gao <chao.gao@intel.com> wrote=
:
> But I agree that following the X86_BUG_TDX_PW_MCE is better in consistenc=
y
> and extensibility. So, here is the refined patch:
>
>
> From 46e89a50803d6568eb60bd8ec866ac3fd9f6e6da Mon Sep 17 00:00:00 2001
> From: Chao Gao <chao.gao@intel.com>
> Date: Tue, 10 Mar 2026 18:49:41 -0700
> Subject: [PATCH] coco/tdx-host: Don't expose P-SEAMLDR features on CPUs w=
ith
>  erratum
> MIME-Version: 1.0
> Content-Type: text/plain; charset=3DUTF-8
> Content-Transfer-Encoding: 8bit
>
> Some TDX-capable CPUs have an erratum, as documented in Intel=C2=AE Trust
> Domain CPU Architectural Extensions (May 2021 edition) Chapter 2.3:
>
>   SEAMRET from the P-SEAMLDR clears the current VMCS structure pointed
>   to by the current-VMCS pointer. A VMM that invokes the P-SEAMLDR using
>   SEAMCALL must reload the current-VMCS, if required, using the VMPTRLD
>   instruction.
>
> Clearing the current VMCS behind KVM's back will break KVM.
>
> This erratum is not present when IA32_VMX_BASIC[60] is set. Add a CPU
> bug bit for this erratum and refuse to expose P-SEAMLDR features (e.g.,
> TDX module updates) on affected CPUs. Also, emit a message to clarify
> why P-SEAMLDR features are disabled for affected CPUs.
>
> =3D=3D Alternatives =3D=3D
> Two workarounds were considered but both were rejected:
>
> 1. Save/restore the current VMCS around P-SEAMLDR calls. This produces ug=
ly
>    assembly code [1] and doesn't play well with #MCE or #NMI if they
>    need to use the current VMCS.

I see that significant discussion has already occurred regarding this.

My question intends to better understand the current state, Do we have
a known scenario today in upstream implementation where #MCE/#NMI need
to use the current VMCS?

>
> 2. Move KVM's VMCS tracking logic to the TDX core code, which would break
>    the boundary between KVM and the TDX core code [2].
>
> Signed-off-by: Chao Gao <chao.gao@intel.com>
> Link: https://lore.kernel.org/kvm/fedb3192-e68c-423c-93b2-a4dc2f964148@in=
tel.com/ # [1]
> Link: https://lore.kernel.org/kvm/aYIXFmT-676oN6j0@google.com/ # [2]
> ---
>  arch/x86/include/asm/cpufeatures.h    |  1 +
>  arch/x86/include/asm/vmx.h            |  1 +
>  arch/x86/virt/vmx/tdx/tdx.c           | 12 ++++++++++++
>  drivers/virt/coco/tdx-host/tdx-host.c |  5 +++++
>  4 files changed, 19 insertions(+)
>
