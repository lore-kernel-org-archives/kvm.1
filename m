Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1021D3EA947
	for <kvm@vger.kernel.org>; Fri,  5 Jun 2026 03:50:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780631434; cv=none; b=tod9XpvznbtCbwHt+J+ErNERWMxqlRt9A2dNHA1YO74bWSfHPx826UriEVBvHy1E/PrPcjGg1lxaMyr/JFLq734yiwdcb0zTKVBxFf/z1cKdkKyw8AGg03IQNWHSeRstyFizM47DcA9F42kCzPDOUGAYbqYillGmP6Sz7QojhOg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780631434; c=relaxed/simple;
	bh=OzGiLhv6mH0UTVkPefYL9cM+XAnRKT5wM9cHyi6P9Us=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tvApg4HaOmNlRlXPGBjGX8pWxGk3PW84MpC1UP/h7jXWyrUl5WvczAzBr3gVPmkVDSt88LySD6GVSpOj5TXgAIwJQAOOEkZxZgEBHUByCSIyX6AwncHe6tH73Zcr+5hCGF8atAJQuCVdC8WAsEvH/Moxfoxdv7GZ8ExYE+07pK8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LPE01rSR; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LPE01rSR"
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-8422a92b6d6so774686b3a.1
        for <kvm@vger.kernel.org>; Thu, 04 Jun 2026 20:50:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780631431; x=1781236231; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=FBpzua9UFewjkDMOiANBoxTvSsSeBFno2QoKdiR8KiI=;
        b=LPE01rSRD6SAf8OG4NRG/Nez5ekf+thyh9OFENYHtHq3DWbiJDx2U1Ow6Vo/03/QXk
         qRLOsGORQcyaBcQSmarbq3bW0IT3cMEegtbzFuYLOYaANjBVKcbGUP3hf84ZfBldmEsJ
         /ySTFKFQ6X5sw35FhUh4pLNkTBS9dOPEDL/mqlkSSMfPR7nRoqJSb1cxPzWOaXDantCh
         wpvuP5oHYdPGtbd/JsayF9j4AYCwRhhka+SPxXfDf/MXawwGasBRRbqhjA9IZvuSpj9t
         hGnxU6TAoyG5D3pODulR7z/FJCbxX0ohR87diB48jJA9sbdjO5Gf3T7svhVbNFRB8iig
         dyIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780631431; x=1781236231;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FBpzua9UFewjkDMOiANBoxTvSsSeBFno2QoKdiR8KiI=;
        b=aNH4qmgwLz0CNaph1sNdMbQQAImAkETgC3o30FwgiUJLph0BIRb4rVviDthEcuzIKB
         XmXs65x/yaFF3NpzVN1YLofjvJo/6Lop6Te1UF3ckpUajliHmgH6bnt100nS6uWq9LP+
         mlPaYMO0QdQsQMFRwHfw4OMqAQlywb5gTsT5fnXDkxUnv5jDZu2LghXk1Nmuwh28KB1G
         ZpkrV53lbIUJRWyLEw+b1rYtpseGZcL9SwlKPSnEWWkULeioNkA7aVvbKypey7ZbA5GW
         DUh2ygscJUnvigUWimCITgNDNanOUM+gw0q9+YVv5EobHLxR6dJH02xVUGqOjsKRwrkJ
         oTNw==
X-Forwarded-Encrypted: i=1; AFNElJ+WcJwrAYd7EFDUAYj0me9McADuzrFIcYqiANN5XmvuR5DibCjNqgJjOa4dzVJS7EfU9wk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwtTNY71yTXIYl4T7DlMS3CBNTa+eFybVo7uhMwGQmExPZH53WC
	EJJ1CMevqMVZXjw8luYgqJ6FqwLMu1lGAXtnybYva5aBJKu4RhNTAYG6
X-Gm-Gg: Acq92OEcicdsdusELfauL/NybOeyNQjYFAEGNlAmYFN24gvnBg+H+NvozMJMicIeA35
	MycriTUHOqHlzA+2xfSjtyoi2l/YShp0RAOpOeTDRg9Y2AzKJlfB55irMCrOoOwPb13BnT75LrK
	f7ND+vJ/hVH6s6iBaWl0SzyRAB4Tv7OO63P0XF0y+SC8j6h4qKNdQUHzBsZQPHQfmTrIG62uznr
	2JD3kR2Qbd5ETmdrx7m7XkxodiJFv1bgoOPsRl0UhylQWFwgZTyjtJncl2HRBDc9WO9wtpXSAz8
	zIL6y94tZGPMECfJ2L90oG/P/XNbMxzXjUCgBgGmiL5XuFsd7pMmdO021Gqx9mSgjz1Lz17fsjD
	nJvsiXH4/PXPZLL1mLyH8mRXU9dKP0uNzPfjsQG8SE5fD2K2+38o5aS34QmXQypuxZm3Uiykk6O
	Xru2xXUBlkBT4DgszfkSOklZhyEOcifRMTIw==
X-Received: by 2002:a05:6a00:148d:b0:82c:1cd0:2f7e with SMTP id d2e1a72fcca58-842b67ed4b7mr606788b3a.20.1780631431110;
        Thu, 04 Jun 2026 20:50:31 -0700 (PDT)
Received: from localhost ([2001:19f0:8001:1b2d:5400:5ff:fefa:a95d])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-842828cb2bdsm8106793b3a.41.2026.06.04.20.50.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Jun 2026 20:50:30 -0700 (PDT)
Date: Fri, 5 Jun 2026 11:50:08 +0800
From: Inochi Amaoto <inochiama@gmail.com>
To: Guodong Xu <docular.xu@gmail.com>, Jonathan Corbet <corbet@lwn.net>, 
	Shuah Khan <skhan@linuxfoundation.org>, Paul Walmsley <pjw@kernel.org>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
	Alexandre Ghiti <alex@ghiti.fr>, Zong Li <zong.li@sifive.com>, Deepak Gupta <debug@rivosinc.com>, 
	Anup Patel <anup@brainfault.org>, Atish Patra <atish.patra@linux.dev>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Yixun Lan <dlan@kernel.org>, 
	Chen Wang <unicorn_wang@outlook.com>, Inochi Amaoto <inochiama@gmail.com>, 
	Conor Dooley <conor.dooley@microchip.com>, Shuah Khan <shuah@kernel.org>, 
	Christian Brauner <brauner@kernel.org>
Cc: linux-doc@vger.kernel.org, linux-riscv@lists.infradead.org, 
	linux-kernel@vger.kernel.org, kvm@vger.kernel.org, kvm-riscv@lists.infradead.org, 
	Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@sifive.com>, 
	Conor Dooley <conor@kernel.org>, devicetree@vger.kernel.org, spacemit@lists.linux.dev, 
	sophgo@lists.linux.dev, linux-kselftest@vger.kernel.org, 
	Andrew Jones <andrew.jones@oss.qualcomm.com>, Charles Jenkins <thecharlesjenkins@gmail.com>, 
	Samuel Holland <samuel.holland@sifive.com>
Subject: Re: [PATCH v3 11/15] riscv: dts: sophgo: sg2044: Add Zic64b ISA
 extension
Message-ID: <aiJG85NxiVQWOAQt@inochi.infowork>
References: <20260603-rva23u64-hwprobe-v2-v3-0-5529a7b28384@gmail.com>
 <20260603-rva23u64-hwprobe-v2-v3-11-5529a7b28384@gmail.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260603-rva23u64-hwprobe-v2-v3-11-5529a7b28384@gmail.com>

On Wed, Jun 03, 2026 at 07:12:06AM -0400, Guodong Xu wrote:
> The SG2044 cores have 64-byte cache blocks, described by their
> cbom/cbop/cboz-block-size of 64, so they implement Zic64b.  Declare it in
> each core's riscv,isa-extensions.
> 
> Signed-off-by: Guodong Xu <docular.xu@gmail.com>

I have confirmed SG2044 supports this features.

Acked-by: Inochi Amaoto <inochiama@gmail.com>

Regards,
Inochi

> ---
> v3: New patch.
> ---
>  arch/riscv/boot/dts/sophgo/sg2044-cpus.dtsi | 128 ++++++++++++++--------------
>  1 file changed, 64 insertions(+), 64 deletions(-)
> 
> diff --git a/arch/riscv/boot/dts/sophgo/sg2044-cpus.dtsi b/arch/riscv/boot/dts/sophgo/sg2044-cpus.dtsi
> index 3135409c21492..2ac4a41bbc3a7 100644
> --- a/arch/riscv/boot/dts/sophgo/sg2044-cpus.dtsi
> +++ b/arch/riscv/boot/dts/sophgo/sg2044-cpus.dtsi
> @@ -31,7 +31,7 @@ cpu0: cpu@0 {
>  					       "svinval", "svnapot", "svpbmt",
>  					       "zawrs", "zba", "zbb", "zbc",
>  					       "zbs", "zca", "zcb", "zcd",
> -					       "zfa", "zfbfmin", "zfh", "zfhmin",
> +					       "zfa", "zfbfmin", "zfh", "zfhmin", "zic64b",
>  					       "zicbom", "zicbop", "zicboz", "ziccrse",
>  					       "zicntr", "zicond","zicsr", "zifencei",
>  					       "zihintntl", "zihintpause", "zihpm",
> @@ -67,7 +67,7 @@ cpu1: cpu@1 {
>  					       "svinval", "svnapot", "svpbmt",
>  					       "zawrs", "zba", "zbb", "zbc",
>  					       "zbs", "zca", "zcb", "zcd",
> -					       "zfa", "zfbfmin", "zfh", "zfhmin",
> +					       "zfa", "zfbfmin", "zfh", "zfhmin", "zic64b",
>  					       "zicbom", "zicbop", "zicboz", "ziccrse",
>  					       "zicntr", "zicond","zicsr", "zifencei",
>  					       "zihintntl", "zihintpause", "zihpm",
> @@ -103,7 +103,7 @@ cpu2: cpu@2 {
>  					       "svinval", "svnapot", "svpbmt",
>  					       "zawrs", "zba", "zbb", "zbc",
>  					       "zbs", "zca", "zcb", "zcd",
> -					       "zfa", "zfbfmin", "zfh", "zfhmin",
> +					       "zfa", "zfbfmin", "zfh", "zfhmin", "zic64b",
>  					       "zicbom", "zicbop", "zicboz", "ziccrse",
>  					       "zicntr", "zicond","zicsr", "zifencei",
>  					       "zihintntl", "zihintpause", "zihpm",
> @@ -139,7 +139,7 @@ cpu3: cpu@3 {
>  					       "svinval", "svnapot", "svpbmt",
>  					       "zawrs", "zba", "zbb", "zbc",
>  					       "zbs", "zca", "zcb", "zcd",
> -					       "zfa", "zfbfmin", "zfh", "zfhmin",
> +					       "zfa", "zfbfmin", "zfh", "zfhmin", "zic64b",
>  					       "zicbom", "zicbop", "zicboz", "ziccrse",
>  					       "zicntr", "zicond","zicsr", "zifencei",
>  					       "zihintntl", "zihintpause", "zihpm",
> @@ -175,7 +175,7 @@ cpu4: cpu@4 {
>  					       "svinval", "svnapot", "svpbmt",
>  					       "zawrs", "zba", "zbb", "zbc",
>  					       "zbs", "zca", "zcb", "zcd",
> -					       "zfa", "zfbfmin", "zfh", "zfhmin",
> +					       "zfa", "zfbfmin", "zfh", "zfhmin", "zic64b",
>  					       "zicbom", "zicbop", "zicboz", "ziccrse",
>  					       "zicntr", "zicond","zicsr", "zifencei",
>  					       "zihintntl", "zihintpause", "zihpm",
> @@ -211,7 +211,7 @@ cpu5: cpu@5 {
>  					       "svinval", "svnapot", "svpbmt",
>  					       "zawrs", "zba", "zbb", "zbc",
>  					       "zbs", "zca", "zcb", "zcd",
> -					       "zfa", "zfbfmin", "zfh", "zfhmin",
> +					       "zfa", "zfbfmin", "zfh", "zfhmin", "zic64b",
>  					       "zicbom", "zicbop", "zicboz", "ziccrse",
>  					       "zicntr", "zicond","zicsr", "zifencei",
>  					       "zihintntl", "zihintpause", "zihpm",
> @@ -247,7 +247,7 @@ cpu6: cpu@6 {
>  					       "svinval", "svnapot", "svpbmt",
>  					       "zawrs", "zba", "zbb", "zbc",
>  					       "zbs", "zca", "zcb", "zcd",
> -					       "zfa", "zfbfmin", "zfh", "zfhmin",
> +					       "zfa", "zfbfmin", "zfh", "zfhmin", "zic64b",
>  					       "zicbom", "zicbop", "zicboz", "ziccrse",
>  					       "zicntr", "zicond","zicsr", "zifencei",
>  					       "zihintntl", "zihintpause", "zihpm",
> @@ -283,7 +283,7 @@ cpu7: cpu@7 {
>  					       "svinval", "svnapot", "svpbmt",
>  					       "zawrs", "zba", "zbb", "zbc",
>  					       "zbs", "zca", "zcb", "zcd",
> -					       "zfa", "zfbfmin", "zfh", "zfhmin",
> +					       "zfa", "zfbfmin", "zfh", "zfhmin", "zic64b",
>  					       "zicbom", "zicbop", "zicboz", "ziccrse",
>  					       "zicntr", "zicond","zicsr", "zifencei",
>  					       "zihintntl", "zihintpause", "zihpm",
> @@ -319,7 +319,7 @@ cpu8: cpu@8 {
>  					       "svinval", "svnapot", "svpbmt",
>  					       "zawrs", "zba", "zbb", "zbc",
>  					       "zbs", "zca", "zcb", "zcd",
> -					       "zfa", "zfbfmin", "zfh", "zfhmin",
> +					       "zfa", "zfbfmin", "zfh", "zfhmin", "zic64b",
>  					       "zicbom", "zicbop", "zicboz", "ziccrse",
>  					       "zicntr", "zicond","zicsr", "zifencei",
>  					       "zihintntl", "zihintpause", "zihpm",
> @@ -355,7 +355,7 @@ cpu9: cpu@9 {
>  					       "svinval", "svnapot", "svpbmt",
>  					       "zawrs", "zba", "zbb", "zbc",
>  					       "zbs", "zca", "zcb", "zcd",
> -					       "zfa", "zfbfmin", "zfh", "zfhmin",
> +					       "zfa", "zfbfmin", "zfh", "zfhmin", "zic64b",
>  					       "zicbom", "zicbop", "zicboz", "ziccrse",
>  					       "zicntr", "zicond","zicsr", "zifencei",
>  					       "zihintntl", "zihintpause", "zihpm",
> @@ -391,7 +391,7 @@ cpu10: cpu@10 {
>  					       "svinval", "svnapot", "svpbmt",
>  					       "zawrs", "zba", "zbb", "zbc",
>  					       "zbs", "zca", "zcb", "zcd",
> -					       "zfa", "zfbfmin", "zfh", "zfhmin",
> +					       "zfa", "zfbfmin", "zfh", "zfhmin", "zic64b",
>  					       "zicbom", "zicbop", "zicboz", "ziccrse",
>  					       "zicntr", "zicond","zicsr", "zifencei",
>  					       "zihintntl", "zihintpause", "zihpm",
> @@ -427,7 +427,7 @@ cpu11: cpu@11 {
>  					       "svinval", "svnapot", "svpbmt",
>  					       "zawrs", "zba", "zbb", "zbc",
>  					       "zbs", "zca", "zcb", "zcd",
> -					       "zfa", "zfbfmin", "zfh", "zfhmin",
> +					       "zfa", "zfbfmin", "zfh", "zfhmin", "zic64b",
>  					       "zicbom", "zicbop", "zicboz", "ziccrse",
>  					       "zicntr", "zicond","zicsr", "zifencei",
>  					       "zihintntl", "zihintpause", "zihpm",
> @@ -463,7 +463,7 @@ cpu12: cpu@12 {
>  					       "svinval", "svnapot", "svpbmt",
>  					       "zawrs", "zba", "zbb", "zbc",
>  					       "zbs", "zca", "zcb", "zcd",
> -					       "zfa", "zfbfmin", "zfh", "zfhmin",
> +					       "zfa", "zfbfmin", "zfh", "zfhmin", "zic64b",
>  					       "zicbom", "zicbop", "zicboz", "ziccrse",
>  					       "zicntr", "zicond","zicsr", "zifencei",
>  					       "zihintntl", "zihintpause", "zihpm",
> @@ -499,7 +499,7 @@ cpu13: cpu@13 {
>  					       "svinval", "svnapot", "svpbmt",
>  					       "zawrs", "zba", "zbb", "zbc",
>  					       "zbs", "zca", "zcb", "zcd",
> -					       "zfa", "zfbfmin", "zfh", "zfhmin",
> +					       "zfa", "zfbfmin", "zfh", "zfhmin", "zic64b",
>  					       "zicbom", "zicbop", "zicboz", "ziccrse",
>  					       "zicntr", "zicond","zicsr", "zifencei",
>  					       "zihintntl", "zihintpause", "zihpm",
> @@ -535,7 +535,7 @@ cpu14: cpu@14 {
>  					       "svinval", "svnapot", "svpbmt",
>  					       "zawrs", "zba", "zbb", "zbc",
>  					       "zbs", "zca", "zcb", "zcd",
> -					       "zfa", "zfbfmin", "zfh", "zfhmin",
> +					       "zfa", "zfbfmin", "zfh", "zfhmin", "zic64b",
>  					       "zicbom", "zicbop", "zicboz", "ziccrse",
>  					       "zicntr", "zicond","zicsr", "zifencei",
>  					       "zihintntl", "zihintpause", "zihpm",
> @@ -571,7 +571,7 @@ cpu15: cpu@15 {
>  					       "svinval", "svnapot", "svpbmt",
>  					       "zawrs", "zba", "zbb", "zbc",
>  					       "zbs", "zca", "zcb", "zcd",
> -					       "zfa", "zfbfmin", "zfh", "zfhmin",
> +					       "zfa", "zfbfmin", "zfh", "zfhmin", "zic64b",
>  					       "zicbom", "zicbop", "zicboz", "ziccrse",
>  					       "zicntr", "zicond","zicsr", "zifencei",
>  					       "zihintntl", "zihintpause", "zihpm",
> @@ -607,7 +607,7 @@ cpu16: cpu@16 {
>  					       "svinval", "svnapot", "svpbmt",
>  					       "zawrs", "zba", "zbb", "zbc",
>  					       "zbs", "zca", "zcb", "zcd",
> -					       "zfa", "zfbfmin", "zfh", "zfhmin",
> +					       "zfa", "zfbfmin", "zfh", "zfhmin", "zic64b",
>  					       "zicbom", "zicbop", "zicboz", "ziccrse",
>  					       "zicntr", "zicond","zicsr", "zifencei",
>  					       "zihintntl", "zihintpause", "zihpm",
> @@ -643,7 +643,7 @@ cpu17: cpu@17 {
>  					       "svinval", "svnapot", "svpbmt",
>  					       "zawrs", "zba", "zbb", "zbc",
>  					       "zbs", "zca", "zcb", "zcd",
> -					       "zfa", "zfbfmin", "zfh", "zfhmin",
> +					       "zfa", "zfbfmin", "zfh", "zfhmin", "zic64b",
>  					       "zicbom", "zicbop", "zicboz", "ziccrse",
>  					       "zicntr", "zicond","zicsr", "zifencei",
>  					       "zihintntl", "zihintpause", "zihpm",
> @@ -679,7 +679,7 @@ cpu18: cpu@18 {
>  					       "svinval", "svnapot", "svpbmt",
>  					       "zawrs", "zba", "zbb", "zbc",
>  					       "zbs", "zca", "zcb", "zcd",
> -					       "zfa", "zfbfmin", "zfh", "zfhmin",
> +					       "zfa", "zfbfmin", "zfh", "zfhmin", "zic64b",
>  					       "zicbom", "zicbop", "zicboz", "ziccrse",
>  					       "zicntr", "zicond","zicsr", "zifencei",
>  					       "zihintntl", "zihintpause", "zihpm",
> @@ -715,7 +715,7 @@ cpu19: cpu@19 {
>  					       "svinval", "svnapot", "svpbmt",
>  					       "zawrs", "zba", "zbb", "zbc",
>  					       "zbs", "zca", "zcb", "zcd",
> -					       "zfa", "zfbfmin", "zfh", "zfhmin",
> +					       "zfa", "zfbfmin", "zfh", "zfhmin", "zic64b",
>  					       "zicbom", "zicbop", "zicboz", "ziccrse",
>  					       "zicntr", "zicond","zicsr", "zifencei",
>  					       "zihintntl", "zihintpause", "zihpm",
> @@ -751,7 +751,7 @@ cpu20: cpu@20 {
>  					       "svinval", "svnapot", "svpbmt",
>  					       "zawrs", "zba", "zbb", "zbc",
>  					       "zbs", "zca", "zcb", "zcd",
> -					       "zfa", "zfbfmin", "zfh", "zfhmin",
> +					       "zfa", "zfbfmin", "zfh", "zfhmin", "zic64b",
>  					       "zicbom", "zicbop", "zicboz", "ziccrse",
>  					       "zicntr", "zicond","zicsr", "zifencei",
>  					       "zihintntl", "zihintpause", "zihpm",
> @@ -787,7 +787,7 @@ cpu21: cpu@21 {
>  					       "svinval", "svnapot", "svpbmt",
>  					       "zawrs", "zba", "zbb", "zbc",
>  					       "zbs", "zca", "zcb", "zcd",
> -					       "zfa", "zfbfmin", "zfh", "zfhmin",
> +					       "zfa", "zfbfmin", "zfh", "zfhmin", "zic64b",
>  					       "zicbom", "zicbop", "zicboz", "ziccrse",
>  					       "zicntr", "zicond","zicsr", "zifencei",
>  					       "zihintntl", "zihintpause", "zihpm",
> @@ -823,7 +823,7 @@ cpu22: cpu@22 {
>  					       "svinval", "svnapot", "svpbmt",
>  					       "zawrs", "zba", "zbb", "zbc",
>  					       "zbs", "zca", "zcb", "zcd",
> -					       "zfa", "zfbfmin", "zfh", "zfhmin",
> +					       "zfa", "zfbfmin", "zfh", "zfhmin", "zic64b",
>  					       "zicbom", "zicbop", "zicboz", "ziccrse",
>  					       "zicntr", "zicond","zicsr", "zifencei",
>  					       "zihintntl", "zihintpause", "zihpm",
> @@ -859,7 +859,7 @@ cpu23: cpu@23 {
>  					       "svinval", "svnapot", "svpbmt",
>  					       "zawrs", "zba", "zbb", "zbc",
>  					       "zbs", "zca", "zcb", "zcd",
> -					       "zfa", "zfbfmin", "zfh", "zfhmin",
> +					       "zfa", "zfbfmin", "zfh", "zfhmin", "zic64b",
>  					       "zicbom", "zicbop", "zicboz", "ziccrse",
>  					       "zicntr", "zicond","zicsr", "zifencei",
>  					       "zihintntl", "zihintpause", "zihpm",
> @@ -895,7 +895,7 @@ cpu24: cpu@24 {
>  					       "svinval", "svnapot", "svpbmt",
>  					       "zawrs", "zba", "zbb", "zbc",
>  					       "zbs", "zca", "zcb", "zcd",
> -					       "zfa", "zfbfmin", "zfh", "zfhmin",
> +					       "zfa", "zfbfmin", "zfh", "zfhmin", "zic64b",
>  					       "zicbom", "zicbop", "zicboz", "ziccrse",
>  					       "zicntr", "zicond","zicsr", "zifencei",
>  					       "zihintntl", "zihintpause", "zihpm",
> @@ -931,7 +931,7 @@ cpu25: cpu@25 {
>  					       "svinval", "svnapot", "svpbmt",
>  					       "zawrs", "zba", "zbb", "zbc",
>  					       "zbs", "zca", "zcb", "zcd",
> -					       "zfa", "zfbfmin", "zfh", "zfhmin",
> +					       "zfa", "zfbfmin", "zfh", "zfhmin", "zic64b",
>  					       "zicbom", "zicbop", "zicboz", "ziccrse",
>  					       "zicntr", "zicond","zicsr", "zifencei",
>  					       "zihintntl", "zihintpause", "zihpm",
> @@ -967,7 +967,7 @@ cpu26: cpu@26 {
>  					       "svinval", "svnapot", "svpbmt",
>  					       "zawrs", "zba", "zbb", "zbc",
>  					       "zbs", "zca", "zcb", "zcd",
> -					       "zfa", "zfbfmin", "zfh", "zfhmin",
> +					       "zfa", "zfbfmin", "zfh", "zfhmin", "zic64b",
>  					       "zicbom", "zicbop", "zicboz", "ziccrse",
>  					       "zicntr", "zicond","zicsr", "zifencei",
>  					       "zihintntl", "zihintpause", "zihpm",
> @@ -1003,7 +1003,7 @@ cpu27: cpu@27 {
>  					       "svinval", "svnapot", "svpbmt",
>  					       "zawrs", "zba", "zbb", "zbc",
>  					       "zbs", "zca", "zcb", "zcd",
> -					       "zfa", "zfbfmin", "zfh", "zfhmin",
> +					       "zfa", "zfbfmin", "zfh", "zfhmin", "zic64b",
>  					       "zicbom", "zicbop", "zicboz", "ziccrse",
>  					       "zicntr", "zicond","zicsr", "zifencei",
>  					       "zihintntl", "zihintpause", "zihpm",
> @@ -1039,7 +1039,7 @@ cpu28: cpu@28 {
>  					       "svinval", "svnapot", "svpbmt",
>  					       "zawrs", "zba", "zbb", "zbc",
>  					       "zbs", "zca", "zcb", "zcd",
> -					       "zfa", "zfbfmin", "zfh", "zfhmin",
> +					       "zfa", "zfbfmin", "zfh", "zfhmin", "zic64b",
>  					       "zicbom", "zicbop", "zicboz", "ziccrse",
>  					       "zicntr", "zicond","zicsr", "zifencei",
>  					       "zihintntl", "zihintpause", "zihpm",
> @@ -1075,7 +1075,7 @@ cpu29: cpu@29 {
>  					       "svinval", "svnapot", "svpbmt",
>  					       "zawrs", "zba", "zbb", "zbc",
>  					       "zbs", "zca", "zcb", "zcd",
> -					       "zfa", "zfbfmin", "zfh", "zfhmin",
> +					       "zfa", "zfbfmin", "zfh", "zfhmin", "zic64b",
>  					       "zicbom", "zicbop", "zicboz", "ziccrse",
>  					       "zicntr", "zicond","zicsr", "zifencei",
>  					       "zihintntl", "zihintpause", "zihpm",
> @@ -1111,7 +1111,7 @@ cpu30: cpu@30 {
>  					       "svinval", "svnapot", "svpbmt",
>  					       "zawrs", "zba", "zbb", "zbc",
>  					       "zbs", "zca", "zcb", "zcd",
> -					       "zfa", "zfbfmin", "zfh", "zfhmin",
> +					       "zfa", "zfbfmin", "zfh", "zfhmin", "zic64b",
>  					       "zicbom", "zicbop", "zicboz", "ziccrse",
>  					       "zicntr", "zicond","zicsr", "zifencei",
>  					       "zihintntl", "zihintpause", "zihpm",
> @@ -1147,7 +1147,7 @@ cpu31: cpu@31 {
>  					       "svinval", "svnapot", "svpbmt",
>  					       "zawrs", "zba", "zbb", "zbc",
>  					       "zbs", "zca", "zcb", "zcd",
> -					       "zfa", "zfbfmin", "zfh", "zfhmin",
> +					       "zfa", "zfbfmin", "zfh", "zfhmin", "zic64b",
>  					       "zicbom", "zicbop", "zicboz", "ziccrse",
>  					       "zicntr", "zicond","zicsr", "zifencei",
>  					       "zihintntl", "zihintpause", "zihpm",
> @@ -1183,7 +1183,7 @@ cpu32: cpu@32 {
>  					       "svinval", "svnapot", "svpbmt",
>  					       "zawrs", "zba", "zbb", "zbc",
>  					       "zbs", "zca", "zcb", "zcd",
> -					       "zfa", "zfbfmin", "zfh", "zfhmin",
> +					       "zfa", "zfbfmin", "zfh", "zfhmin", "zic64b",
>  					       "zicbom", "zicbop", "zicboz", "ziccrse",
>  					       "zicntr", "zicond","zicsr", "zifencei",
>  					       "zihintntl", "zihintpause", "zihpm",
> @@ -1219,7 +1219,7 @@ cpu33: cpu@33 {
>  					       "svinval", "svnapot", "svpbmt",
>  					       "zawrs", "zba", "zbb", "zbc",
>  					       "zbs", "zca", "zcb", "zcd",
> -					       "zfa", "zfbfmin", "zfh", "zfhmin",
> +					       "zfa", "zfbfmin", "zfh", "zfhmin", "zic64b",
>  					       "zicbom", "zicbop", "zicboz", "ziccrse",
>  					       "zicntr", "zicond","zicsr", "zifencei",
>  					       "zihintntl", "zihintpause", "zihpm",
> @@ -1255,7 +1255,7 @@ cpu34: cpu@34 {
>  					       "svinval", "svnapot", "svpbmt",
>  					       "zawrs", "zba", "zbb", "zbc",
>  					       "zbs", "zca", "zcb", "zcd",
> -					       "zfa", "zfbfmin", "zfh", "zfhmin",
> +					       "zfa", "zfbfmin", "zfh", "zfhmin", "zic64b",
>  					       "zicbom", "zicbop", "zicboz", "ziccrse",
>  					       "zicntr", "zicond","zicsr", "zifencei",
>  					       "zihintntl", "zihintpause", "zihpm",
> @@ -1291,7 +1291,7 @@ cpu35: cpu@35 {
>  					       "svinval", "svnapot", "svpbmt",
>  					       "zawrs", "zba", "zbb", "zbc",
>  					       "zbs", "zca", "zcb", "zcd",
> -					       "zfa", "zfbfmin", "zfh", "zfhmin",
> +					       "zfa", "zfbfmin", "zfh", "zfhmin", "zic64b",
>  					       "zicbom", "zicbop", "zicboz", "ziccrse",
>  					       "zicntr", "zicond","zicsr", "zifencei",
>  					       "zihintntl", "zihintpause", "zihpm",
> @@ -1327,7 +1327,7 @@ cpu36: cpu@36 {
>  					       "svinval", "svnapot", "svpbmt",
>  					       "zawrs", "zba", "zbb", "zbc",
>  					       "zbs", "zca", "zcb", "zcd",
> -					       "zfa", "zfbfmin", "zfh", "zfhmin",
> +					       "zfa", "zfbfmin", "zfh", "zfhmin", "zic64b",
>  					       "zicbom", "zicbop", "zicboz", "ziccrse",
>  					       "zicntr", "zicond","zicsr", "zifencei",
>  					       "zihintntl", "zihintpause", "zihpm",
> @@ -1363,7 +1363,7 @@ cpu37: cpu@37 {
>  					       "svinval", "svnapot", "svpbmt",
>  					       "zawrs", "zba", "zbb", "zbc",
>  					       "zbs", "zca", "zcb", "zcd",
> -					       "zfa", "zfbfmin", "zfh", "zfhmin",
> +					       "zfa", "zfbfmin", "zfh", "zfhmin", "zic64b",
>  					       "zicbom", "zicbop", "zicboz", "ziccrse",
>  					       "zicntr", "zicond","zicsr", "zifencei",
>  					       "zihintntl", "zihintpause", "zihpm",
> @@ -1399,7 +1399,7 @@ cpu38: cpu@38 {
>  					       "svinval", "svnapot", "svpbmt",
>  					       "zawrs", "zba", "zbb", "zbc",
>  					       "zbs", "zca", "zcb", "zcd",
> -					       "zfa", "zfbfmin", "zfh", "zfhmin",
> +					       "zfa", "zfbfmin", "zfh", "zfhmin", "zic64b",
>  					       "zicbom", "zicbop", "zicboz", "ziccrse",
>  					       "zicntr", "zicond","zicsr", "zifencei",
>  					       "zihintntl", "zihintpause", "zihpm",
> @@ -1435,7 +1435,7 @@ cpu39: cpu@39 {
>  					       "svinval", "svnapot", "svpbmt",
>  					       "zawrs", "zba", "zbb", "zbc",
>  					       "zbs", "zca", "zcb", "zcd",
> -					       "zfa", "zfbfmin", "zfh", "zfhmin",
> +					       "zfa", "zfbfmin", "zfh", "zfhmin", "zic64b",
>  					       "zicbom", "zicbop", "zicboz", "ziccrse",
>  					       "zicntr", "zicond","zicsr", "zifencei",
>  					       "zihintntl", "zihintpause", "zihpm",
> @@ -1471,7 +1471,7 @@ cpu40: cpu@40 {
>  					       "svinval", "svnapot", "svpbmt",
>  					       "zawrs", "zba", "zbb", "zbc",
>  					       "zbs", "zca", "zcb", "zcd",
> -					       "zfa", "zfbfmin", "zfh", "zfhmin",
> +					       "zfa", "zfbfmin", "zfh", "zfhmin", "zic64b",
>  					       "zicbom", "zicbop", "zicboz", "ziccrse",
>  					       "zicntr", "zicond","zicsr", "zifencei",
>  					       "zihintntl", "zihintpause", "zihpm",
> @@ -1507,7 +1507,7 @@ cpu41: cpu@41 {
>  					       "svinval", "svnapot", "svpbmt",
>  					       "zawrs", "zba", "zbb", "zbc",
>  					       "zbs", "zca", "zcb", "zcd",
> -					       "zfa", "zfbfmin", "zfh", "zfhmin",
> +					       "zfa", "zfbfmin", "zfh", "zfhmin", "zic64b",
>  					       "zicbom", "zicbop", "zicboz", "ziccrse",
>  					       "zicntr", "zicond","zicsr", "zifencei",
>  					       "zihintntl", "zihintpause", "zihpm",
> @@ -1543,7 +1543,7 @@ cpu42: cpu@42 {
>  					       "svinval", "svnapot", "svpbmt",
>  					       "zawrs", "zba", "zbb", "zbc",
>  					       "zbs", "zca", "zcb", "zcd",
> -					       "zfa", "zfbfmin", "zfh", "zfhmin",
> +					       "zfa", "zfbfmin", "zfh", "zfhmin", "zic64b",
>  					       "zicbom", "zicbop", "zicboz", "ziccrse",
>  					       "zicntr", "zicond","zicsr", "zifencei",
>  					       "zihintntl", "zihintpause", "zihpm",
> @@ -1579,7 +1579,7 @@ cpu43: cpu@43 {
>  					       "svinval", "svnapot", "svpbmt",
>  					       "zawrs", "zba", "zbb", "zbc",
>  					       "zbs", "zca", "zcb", "zcd",
> -					       "zfa", "zfbfmin", "zfh", "zfhmin",
> +					       "zfa", "zfbfmin", "zfh", "zfhmin", "zic64b",
>  					       "zicbom", "zicbop", "zicboz", "ziccrse",
>  					       "zicntr", "zicond","zicsr", "zifencei",
>  					       "zihintntl", "zihintpause", "zihpm",
> @@ -1615,7 +1615,7 @@ cpu44: cpu@44 {
>  					       "svinval", "svnapot", "svpbmt",
>  					       "zawrs", "zba", "zbb", "zbc",
>  					       "zbs", "zca", "zcb", "zcd",
> -					       "zfa", "zfbfmin", "zfh", "zfhmin",
> +					       "zfa", "zfbfmin", "zfh", "zfhmin", "zic64b",
>  					       "zicbom", "zicbop", "zicboz", "ziccrse",
>  					       "zicntr", "zicond","zicsr", "zifencei",
>  					       "zihintntl", "zihintpause", "zihpm",
> @@ -1651,7 +1651,7 @@ cpu45: cpu@45 {
>  					       "svinval", "svnapot", "svpbmt",
>  					       "zawrs", "zba", "zbb", "zbc",
>  					       "zbs", "zca", "zcb", "zcd",
> -					       "zfa", "zfbfmin", "zfh", "zfhmin",
> +					       "zfa", "zfbfmin", "zfh", "zfhmin", "zic64b",
>  					       "zicbom", "zicbop", "zicboz", "ziccrse",
>  					       "zicntr", "zicond","zicsr", "zifencei",
>  					       "zihintntl", "zihintpause", "zihpm",
> @@ -1687,7 +1687,7 @@ cpu46: cpu@46 {
>  					       "svinval", "svnapot", "svpbmt",
>  					       "zawrs", "zba", "zbb", "zbc",
>  					       "zbs", "zca", "zcb", "zcd",
> -					       "zfa", "zfbfmin", "zfh", "zfhmin",
> +					       "zfa", "zfbfmin", "zfh", "zfhmin", "zic64b",
>  					       "zicbom", "zicbop", "zicboz", "ziccrse",
>  					       "zicntr", "zicond","zicsr", "zifencei",
>  					       "zihintntl", "zihintpause", "zihpm",
> @@ -1723,7 +1723,7 @@ cpu47: cpu@47 {
>  					       "svinval", "svnapot", "svpbmt",
>  					       "zawrs", "zba", "zbb", "zbc",
>  					       "zbs", "zca", "zcb", "zcd",
> -					       "zfa", "zfbfmin", "zfh", "zfhmin",
> +					       "zfa", "zfbfmin", "zfh", "zfhmin", "zic64b",
>  					       "zicbom", "zicbop", "zicboz", "ziccrse",
>  					       "zicntr", "zicond","zicsr", "zifencei",
>  					       "zihintntl", "zihintpause", "zihpm",
> @@ -1759,7 +1759,7 @@ cpu48: cpu@48 {
>  					       "svinval", "svnapot", "svpbmt",
>  					       "zawrs", "zba", "zbb", "zbc",
>  					       "zbs", "zca", "zcb", "zcd",
> -					       "zfa", "zfbfmin", "zfh", "zfhmin",
> +					       "zfa", "zfbfmin", "zfh", "zfhmin", "zic64b",
>  					       "zicbom", "zicbop", "zicboz", "ziccrse",
>  					       "zicntr", "zicond","zicsr", "zifencei",
>  					       "zihintntl", "zihintpause", "zihpm",
> @@ -1795,7 +1795,7 @@ cpu49: cpu@49 {
>  					       "svinval", "svnapot", "svpbmt",
>  					       "zawrs", "zba", "zbb", "zbc",
>  					       "zbs", "zca", "zcb", "zcd",
> -					       "zfa", "zfbfmin", "zfh", "zfhmin",
> +					       "zfa", "zfbfmin", "zfh", "zfhmin", "zic64b",
>  					       "zicbom", "zicbop", "zicboz", "ziccrse",
>  					       "zicntr", "zicond","zicsr", "zifencei",
>  					       "zihintntl", "zihintpause", "zihpm",
> @@ -1831,7 +1831,7 @@ cpu50: cpu@50 {
>  					       "svinval", "svnapot", "svpbmt",
>  					       "zawrs", "zba", "zbb", "zbc",
>  					       "zbs", "zca", "zcb", "zcd",
> -					       "zfa", "zfbfmin", "zfh", "zfhmin",
> +					       "zfa", "zfbfmin", "zfh", "zfhmin", "zic64b",
>  					       "zicbom", "zicbop", "zicboz", "ziccrse",
>  					       "zicntr", "zicond","zicsr", "zifencei",
>  					       "zihintntl", "zihintpause", "zihpm",
> @@ -1867,7 +1867,7 @@ cpu51: cpu@51 {
>  					       "svinval", "svnapot", "svpbmt",
>  					       "zawrs", "zba", "zbb", "zbc",
>  					       "zbs", "zca", "zcb", "zcd",
> -					       "zfa", "zfbfmin", "zfh", "zfhmin",
> +					       "zfa", "zfbfmin", "zfh", "zfhmin", "zic64b",
>  					       "zicbom", "zicbop", "zicboz", "ziccrse",
>  					       "zicntr", "zicond","zicsr", "zifencei",
>  					       "zihintntl", "zihintpause", "zihpm",
> @@ -1903,7 +1903,7 @@ cpu52: cpu@52 {
>  					       "svinval", "svnapot", "svpbmt",
>  					       "zawrs", "zba", "zbb", "zbc",
>  					       "zbs", "zca", "zcb", "zcd",
> -					       "zfa", "zfbfmin", "zfh", "zfhmin",
> +					       "zfa", "zfbfmin", "zfh", "zfhmin", "zic64b",
>  					       "zicbom", "zicbop", "zicboz", "ziccrse",
>  					       "zicntr", "zicond","zicsr", "zifencei",
>  					       "zihintntl", "zihintpause", "zihpm",
> @@ -1939,7 +1939,7 @@ cpu53: cpu@53 {
>  					       "svinval", "svnapot", "svpbmt",
>  					       "zawrs", "zba", "zbb", "zbc",
>  					       "zbs", "zca", "zcb", "zcd",
> -					       "zfa", "zfbfmin", "zfh", "zfhmin",
> +					       "zfa", "zfbfmin", "zfh", "zfhmin", "zic64b",
>  					       "zicbom", "zicbop", "zicboz", "ziccrse",
>  					       "zicntr", "zicond","zicsr", "zifencei",
>  					       "zihintntl", "zihintpause", "zihpm",
> @@ -1975,7 +1975,7 @@ cpu54: cpu@54 {
>  					       "svinval", "svnapot", "svpbmt",
>  					       "zawrs", "zba", "zbb", "zbc",
>  					       "zbs", "zca", "zcb", "zcd",
> -					       "zfa", "zfbfmin", "zfh", "zfhmin",
> +					       "zfa", "zfbfmin", "zfh", "zfhmin", "zic64b",
>  					       "zicbom", "zicbop", "zicboz", "ziccrse",
>  					       "zicntr", "zicond","zicsr", "zifencei",
>  					       "zihintntl", "zihintpause", "zihpm",
> @@ -2011,7 +2011,7 @@ cpu55: cpu@55 {
>  					       "svinval", "svnapot", "svpbmt",
>  					       "zawrs", "zba", "zbb", "zbc",
>  					       "zbs", "zca", "zcb", "zcd",
> -					       "zfa", "zfbfmin", "zfh", "zfhmin",
> +					       "zfa", "zfbfmin", "zfh", "zfhmin", "zic64b",
>  					       "zicbom", "zicbop", "zicboz", "ziccrse",
>  					       "zicntr", "zicond","zicsr", "zifencei",
>  					       "zihintntl", "zihintpause", "zihpm",
> @@ -2047,7 +2047,7 @@ cpu56: cpu@56 {
>  					       "svinval", "svnapot", "svpbmt",
>  					       "zawrs", "zba", "zbb", "zbc",
>  					       "zbs", "zca", "zcb", "zcd",
> -					       "zfa", "zfbfmin", "zfh", "zfhmin",
> +					       "zfa", "zfbfmin", "zfh", "zfhmin", "zic64b",
>  					       "zicbom", "zicbop", "zicboz", "ziccrse",
>  					       "zicntr", "zicond","zicsr", "zifencei",
>  					       "zihintntl", "zihintpause", "zihpm",
> @@ -2083,7 +2083,7 @@ cpu57: cpu@57 {
>  					       "svinval", "svnapot", "svpbmt",
>  					       "zawrs", "zba", "zbb", "zbc",
>  					       "zbs", "zca", "zcb", "zcd",
> -					       "zfa", "zfbfmin", "zfh", "zfhmin",
> +					       "zfa", "zfbfmin", "zfh", "zfhmin", "zic64b",
>  					       "zicbom", "zicbop", "zicboz", "ziccrse",
>  					       "zicntr", "zicond","zicsr", "zifencei",
>  					       "zihintntl", "zihintpause", "zihpm",
> @@ -2119,7 +2119,7 @@ cpu58: cpu@58 {
>  					       "svinval", "svnapot", "svpbmt",
>  					       "zawrs", "zba", "zbb", "zbc",
>  					       "zbs", "zca", "zcb", "zcd",
> -					       "zfa", "zfbfmin", "zfh", "zfhmin",
> +					       "zfa", "zfbfmin", "zfh", "zfhmin", "zic64b",
>  					       "zicbom", "zicbop", "zicboz", "ziccrse",
>  					       "zicntr", "zicond","zicsr", "zifencei",
>  					       "zihintntl", "zihintpause", "zihpm",
> @@ -2155,7 +2155,7 @@ cpu59: cpu@59 {
>  					       "svinval", "svnapot", "svpbmt",
>  					       "zawrs", "zba", "zbb", "zbc",
>  					       "zbs", "zca", "zcb", "zcd",
> -					       "zfa", "zfbfmin", "zfh", "zfhmin",
> +					       "zfa", "zfbfmin", "zfh", "zfhmin", "zic64b",
>  					       "zicbom", "zicbop", "zicboz", "ziccrse",
>  					       "zicntr", "zicond","zicsr", "zifencei",
>  					       "zihintntl", "zihintpause", "zihpm",
> @@ -2191,7 +2191,7 @@ cpu60: cpu@60 {
>  					       "svinval", "svnapot", "svpbmt",
>  					       "zawrs", "zba", "zbb", "zbc",
>  					       "zbs", "zca", "zcb", "zcd",
> -					       "zfa", "zfbfmin", "zfh", "zfhmin",
> +					       "zfa", "zfbfmin", "zfh", "zfhmin", "zic64b",
>  					       "zicbom", "zicbop", "zicboz", "ziccrse",
>  					       "zicntr", "zicond","zicsr", "zifencei",
>  					       "zihintntl", "zihintpause", "zihpm",
> @@ -2227,7 +2227,7 @@ cpu61: cpu@61 {
>  					       "svinval", "svnapot", "svpbmt",
>  					       "zawrs", "zba", "zbb", "zbc",
>  					       "zbs", "zca", "zcb", "zcd",
> -					       "zfa", "zfbfmin", "zfh", "zfhmin",
> +					       "zfa", "zfbfmin", "zfh", "zfhmin", "zic64b",
>  					       "zicbom", "zicbop", "zicboz", "ziccrse",
>  					       "zicntr", "zicond","zicsr", "zifencei",
>  					       "zihintntl", "zihintpause", "zihpm",
> @@ -2263,7 +2263,7 @@ cpu62: cpu@62 {
>  					       "svinval", "svnapot", "svpbmt",
>  					       "zawrs", "zba", "zbb", "zbc",
>  					       "zbs", "zca", "zcb", "zcd",
> -					       "zfa", "zfbfmin", "zfh", "zfhmin",
> +					       "zfa", "zfbfmin", "zfh", "zfhmin", "zic64b",
>  					       "zicbom", "zicbop", "zicboz", "ziccrse",
>  					       "zicntr", "zicond","zicsr", "zifencei",
>  					       "zihintntl", "zihintpause", "zihpm",
> @@ -2299,7 +2299,7 @@ cpu63: cpu@63 {
>  					       "svinval", "svnapot", "svpbmt",
>  					       "zawrs", "zba", "zbb", "zbc",
>  					       "zbs", "zca", "zcb", "zcd",
> -					       "zfa", "zfbfmin", "zfh", "zfhmin",
> +					       "zfa", "zfbfmin", "zfh", "zfhmin", "zic64b",
>  					       "zicbom", "zicbop", "zicboz", "ziccrse",
>  					       "zicntr", "zicond","zicsr", "zifencei",
>  					       "zihintntl", "zihintpause", "zihpm",
> 
> -- 
> 2.43.0
> 
> 
> -- 
> kvm-riscv mailing list
> kvm-riscv@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/kvm-riscv
