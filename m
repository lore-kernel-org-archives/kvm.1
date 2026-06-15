Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6BB718DB26;
	Mon, 15 Jun 2026 01:20:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781486433; cv=none; b=l1enXqk5jR86Aelbhz0pJAtoId8LgJ171KPnT/6S6NbodHB4OEkqDlRDCebv+fqetwq81pvKVKbIDag3gFDrSs6EyyYCrOAFOTBsBjECqV9dhlE8WAR3YQj9RZi69fkOoa2krbeM+kKBuLZ+1M5IwYnEldzntAanJQLCH5JEQHA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781486433; c=relaxed/simple;
	bh=EvaH+h58GYm4IQiMvlgenwEoK1ZGDPeyN3jeqXhLUw8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NCTwy2S/iR0lc3CkgzyfO1k/I9JSLFtBIE0f1ar7/K9Ff8Jo/cyUygoYYhJ7j8VX7yQlmu/PUo6JrhO0YnWlQKsWH8Zq4uT7BvzhAfMSFNFZTfQizGbmj/E7M8oIvqyeZeYCYdESxf8g8p5QwrT5G4DYlswMHgPSDsjrUsPP//g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MXsx03Wd; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MXsx03Wd"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EF2281F000E9;
	Mon, 15 Jun 2026 01:20:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781486431;
	bh=rYwZ2eVwOLWaAkHwno3LEyxTco9cvFVt3Q1mmJlReC8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=MXsx03WdITf3HmhydUJ5OgLaBLMaOPcBcBuaaknFTU+pFovh4q4XfVpGTDNjnrTZ0
	 YS1kq51da+JmogOuO3uZeyw7zVfkNE41FmDX9Di8SMow0AgMua7o1ZP7NgiDNxjuqX
	 l1xsT1vZc/uJA7BM24vbEkFL2TKwirUmPw9+iZKPvWAufBxgprFX6HxBiRFbSBc7b4
	 uuYrzzjcNsltJAeQCx4M0UBzMN4YcgTbR1sTm0fEQl1iBreBf+pV+8vaNAPzLsAF6M
	 8ac26hwL+1RIkpxZTXfcWXAjDxkTMuJDmtvfHcPpZeKd89e7nJQNrTe4aRcxGc6LAG
	 p413kxgkTuC+Q==
Date: Mon, 15 Jun 2026 01:20:29 +0000
From: Yixun Lan <dlan@kernel.org>
To: Guodong Xu <docular.xu@gmail.com>
Cc: Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>,
	Zong Li <zong.li@sifive.com>, Deepak Gupta <debug@rivosinc.com>,
	Anup Patel <anup@brainfault.org>,
	Atish Patra <atish.patra@linux.dev>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Chen Wang <unicorn_wang@outlook.com>,
	Inochi Amaoto <inochiama@gmail.com>, linux-doc@vger.kernel.org,
	linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
	kvm@vger.kernel.org, kvm-riscv@lists.infradead.org,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Conor Dooley <conor@kernel.org>, devicetree@vger.kernel.org,
	spacemit@lists.linux.dev, sophgo@lists.linux.dev,
	linux-kselftest@vger.kernel.org, Palmer Dabbelt <palmer@sifive.com>
Subject: Re: [PATCH v4 10/16] riscv: dts: spacemit: k3: Add Zic64b ISA
 extension
Message-ID: <20260615012029-GKA1003249@kernel.org>
References: <20260611-rva23u64-hwprobe-v2-v4-0-3f01a2449488@gmail.com>
 <20260611-rva23u64-hwprobe-v2-v4-10-3f01a2449488@gmail.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260611-rva23u64-hwprobe-v2-v4-10-3f01a2449488@gmail.com>

Hi Guodong,

On 16:12 Thu 11 Jun     , Guodong Xu wrote:
> The K3 X100 cores have 64-byte cache blocks, already described by their
> cbom/cbop/cboz-block-size of 64, so they implement Zic64b, a mandatory
> RVA23 extension.  Declare it in each core's riscv,isa-extensions.
> 
> Signed-off-by: Guodong Xu <docular.xu@gmail.com>

Reviewed-by: Yixun Lan <dlan@kernel.org>

> ---
> v4: No change.
> v3: New patch.
> ---
>  arch/riscv/boot/dts/spacemit/k3.dtsi | 48 ++++++++++++++++++------------------
>  1 file changed, 24 insertions(+), 24 deletions(-)
> 
> diff --git a/arch/riscv/boot/dts/spacemit/k3.dtsi b/arch/riscv/boot/dts/spacemit/k3.dtsi
> index 4ac457399b583..b5aa983f0bfa1 100644
> --- a/arch/riscv/boot/dts/spacemit/k3.dtsi
> +++ b/arch/riscv/boot/dts/spacemit/k3.dtsi
> @@ -35,9 +35,9 @@ cpu_0: cpu@0 {
>  					       "svinval", "svnapot", "svpbmt", "za64rs",
>  					       "zawrs", "zba", "zbb", "zbc", "zbs", "zca",
>  					       "zcb", "zcd", "zcmop", "zfa", "zfbfmin",
> -					       "zfh", "zfhmin", "zicbom", "zicbop", "zicboz",
> -					       "ziccamoa", "ziccif", "zicclsm", "ziccrse", "zicntr",
> -					       "zicond", "zicsr", "zifencei", "zihintntl",
> +					       "zfh", "zfhmin", "zic64b", "zicbom", "zicbop",
> +					       "zicboz", "ziccamoa", "ziccif", "zicclsm", "ziccrse",
> +					       "zicntr", "zicond", "zicsr", "zifencei", "zihintntl",
>  					       "zihintpause", "zihpm", "zimop", "zkt", "zvbb",
>  					       "zvbc", "zvfbfmin", "zvfbfwma", "zvfh",
>  					       "zvfhmin", "zvkb", "zvkg", "zvkn", "zvknc",
> @@ -76,9 +76,9 @@ cpu_1: cpu@1 {
>  					       "svinval", "svnapot", "svpbmt", "za64rs",
>  					       "zawrs", "zba", "zbb", "zbc", "zbs", "zca",
>  					       "zcb", "zcd", "zcmop", "zfa", "zfbfmin",
> -					       "zfh", "zfhmin", "zicbom", "zicbop", "zicboz",
> -					       "ziccamoa", "ziccif", "zicclsm", "ziccrse", "zicntr",
> -					       "zicond", "zicsr", "zifencei", "zihintntl",
> +					       "zfh", "zfhmin", "zic64b", "zicbom", "zicbop",
> +					       "zicboz", "ziccamoa", "ziccif", "zicclsm", "ziccrse",
> +					       "zicntr", "zicond", "zicsr", "zifencei", "zihintntl",
>  					       "zihintpause", "zihpm", "zimop", "zkt", "zvbb",
>  					       "zvbc", "zvfbfmin", "zvfbfwma", "zvfh",
>  					       "zvfhmin", "zvkb", "zvkg", "zvkn", "zvknc",
> @@ -117,9 +117,9 @@ cpu_2: cpu@2 {
>  					       "svinval", "svnapot", "svpbmt", "za64rs",
>  					       "zawrs", "zba", "zbb", "zbc", "zbs", "zca",
>  					       "zcb", "zcd", "zcmop", "zfa", "zfbfmin",
> -					       "zfh", "zfhmin", "zicbom", "zicbop", "zicboz",
> -					       "ziccamoa", "ziccif", "zicclsm", "ziccrse", "zicntr",
> -					       "zicond", "zicsr", "zifencei", "zihintntl",
> +					       "zfh", "zfhmin", "zic64b", "zicbom", "zicbop",
> +					       "zicboz", "ziccamoa", "ziccif", "zicclsm", "ziccrse",
> +					       "zicntr", "zicond", "zicsr", "zifencei", "zihintntl",
>  					       "zihintpause", "zihpm", "zimop", "zkt", "zvbb",
>  					       "zvbc", "zvfbfmin", "zvfbfwma", "zvfh",
>  					       "zvfhmin", "zvkb", "zvkg", "zvkn", "zvknc",
> @@ -158,9 +158,9 @@ cpu_3: cpu@3 {
>  					       "svinval", "svnapot", "svpbmt", "za64rs",
>  					       "zawrs", "zba", "zbb", "zbc", "zbs", "zca",
>  					       "zcb", "zcd", "zcmop", "zfa", "zfbfmin",
> -					       "zfh", "zfhmin", "zicbom", "zicbop", "zicboz",
> -					       "ziccamoa", "ziccif", "zicclsm", "ziccrse", "zicntr",
> -					       "zicond", "zicsr", "zifencei", "zihintntl",
> +					       "zfh", "zfhmin", "zic64b", "zicbom", "zicbop",
> +					       "zicboz", "ziccamoa", "ziccif", "zicclsm", "ziccrse",
> +					       "zicntr", "zicond", "zicsr", "zifencei", "zihintntl",
>  					       "zihintpause", "zihpm", "zimop", "zkt", "zvbb",
>  					       "zvbc", "zvfbfmin", "zvfbfwma", "zvfh",
>  					       "zvfhmin", "zvkb", "zvkg", "zvkn", "zvknc",
> @@ -199,9 +199,9 @@ cpu_4: cpu@4 {
>  					       "svinval", "svnapot", "svpbmt", "za64rs",
>  					       "zawrs", "zba", "zbb", "zbc", "zbs", "zca",
>  					       "zcb", "zcd", "zcmop", "zfa", "zfbfmin",
> -					       "zfh", "zfhmin", "zicbom", "zicbop", "zicboz",
> -					       "ziccamoa", "ziccif", "zicclsm", "ziccrse", "zicntr",
> -					       "zicond", "zicsr", "zifencei", "zihintntl",
> +					       "zfh", "zfhmin", "zic64b", "zicbom", "zicbop",
> +					       "zicboz", "ziccamoa", "ziccif", "zicclsm", "ziccrse",
> +					       "zicntr", "zicond", "zicsr", "zifencei", "zihintntl",
>  					       "zihintpause", "zihpm", "zimop", "zkt", "zvbb",
>  					       "zvbc", "zvfbfmin", "zvfbfwma", "zvfh",
>  					       "zvfhmin", "zvkb", "zvkg", "zvkn", "zvknc",
> @@ -240,9 +240,9 @@ cpu_5: cpu@5 {
>  					       "svinval", "svnapot", "svpbmt", "za64rs",
>  					       "zawrs", "zba", "zbb", "zbc", "zbs", "zca",
>  					       "zcb", "zcd", "zcmop", "zfa", "zfbfmin",
> -					       "zfh", "zfhmin", "zicbom", "zicbop", "zicboz",
> -					       "ziccamoa", "ziccif", "zicclsm", "ziccrse", "zicntr",
> -					       "zicond", "zicsr", "zifencei", "zihintntl",
> +					       "zfh", "zfhmin", "zic64b", "zicbom", "zicbop",
> +					       "zicboz", "ziccamoa", "ziccif", "zicclsm", "ziccrse",
> +					       "zicntr", "zicond", "zicsr", "zifencei", "zihintntl",
>  					       "zihintpause", "zihpm", "zimop", "zkt", "zvbb",
>  					       "zvbc", "zvfbfmin", "zvfbfwma", "zvfh",
>  					       "zvfhmin", "zvkb", "zvkg", "zvkn", "zvknc",
> @@ -281,9 +281,9 @@ cpu_6: cpu@6 {
>  					       "svinval", "svnapot", "svpbmt", "za64rs",
>  					       "zawrs", "zba", "zbb", "zbc", "zbs", "zca",
>  					       "zcb", "zcd", "zcmop", "zfa", "zfbfmin",
> -					       "zfh", "zfhmin", "zicbom", "zicbop", "zicboz",
> -					       "ziccamoa", "ziccif", "zicclsm", "ziccrse", "zicntr",
> -					       "zicond", "zicsr", "zifencei", "zihintntl",
> +					       "zfh", "zfhmin", "zic64b", "zicbom", "zicbop",
> +					       "zicboz", "ziccamoa", "ziccif", "zicclsm", "ziccrse",
> +					       "zicntr", "zicond", "zicsr", "zifencei", "zihintntl",
>  					       "zihintpause", "zihpm", "zimop", "zkt", "zvbb",
>  					       "zvbc", "zvfbfmin", "zvfbfwma", "zvfh",
>  					       "zvfhmin", "zvkb", "zvkg", "zvkn", "zvknc",
> @@ -322,9 +322,9 @@ cpu_7: cpu@7 {
>  					       "svinval", "svnapot", "svpbmt", "za64rs",
>  					       "zawrs", "zba", "zbb", "zbc", "zbs", "zca",
>  					       "zcb", "zcd", "zcmop", "zfa", "zfbfmin",
> -					       "zfh", "zfhmin", "zicbom", "zicbop", "zicboz",
> -					       "ziccamoa", "ziccif", "zicclsm", "ziccrse", "zicntr",
> -					       "zicond", "zicsr", "zifencei", "zihintntl",
> +					       "zfh", "zfhmin", "zic64b", "zicbom", "zicbop",
> +					       "zicboz", "ziccamoa", "ziccif", "zicclsm", "ziccrse",
> +					       "zicntr", "zicond", "zicsr", "zifencei", "zihintntl",
>  					       "zihintpause", "zihpm", "zimop", "zkt", "zvbb",
>  					       "zvbc", "zvfbfmin", "zvfbfwma", "zvfh",
>  					       "zvfhmin", "zvkb", "zvkg", "zvkn", "zvknc",
> 
> -- 
> 2.43.0
> 

-- 
Yixun Lan (dlan)
