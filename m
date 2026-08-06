Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB38E8834;
	Thu,  6 Aug 2026 18:32:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786041125; cv=none; b=j/mGXcTtox9w+L0BzY9dx+VpK/HGXFBWPRqTI67KTzn8c9oLFpWDK2UNMyHVgfcsk1PNAVCULrK8H9T2H92GhQ1wnQfDp7jAvw41Ov5CIfPpxd5IoW/8HrV21jGXsdnBb+mTrUcArvMh+JpW624niQExkX+F4Kw26S1FKRv6B4g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786041125; c=relaxed/simple;
	bh=NVCMNynxEQpQ+zcnC1qWUKxNQoVPLtst8DshKcrCiJM=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=TxptSi4DsHwQDXjseUWpfNNuwcW/VTEgr4btf5R9Ch4v0/gIRNZapMmQoCN9e8mDRzUw+97wM++36jkxeear91cAnuoHhxKtr5gbt0hrCW0m+HDZCEHWMlb6ItCQdeDIdC5p3YtGpRSV9mnRRH8TVUsxdwq9/M7/RbH61HzypjQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FhWh+1cs; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FhWh+1cs"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A8BF01F000E9;
	Thu,  6 Aug 2026 18:32:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786041123;
	bh=ATZjqoQT7LRR3mM3kyDT1fKkCMOmzavajpIqeRssK7I=;
	h=Date:From:To:cc:Subject:In-Reply-To:References;
	b=FhWh+1csbKU8E7LYyPtQAIeeCjJQV4o3pExGfcwAYoc7RwkLgkbCRhm8RAis1QhGk
	 YLoBQPAPMjphW1ckP/4jGIDOMx7so2dWoZmYLT+ElGkHARvbBAkKwg/wYfAg5hS1JS
	 dnET2u/vp9YaRinByFs4I2pqwv6Fmn2nboDdhiyjbcp6xmb4CWXFq79k/OsSG0uI0B
	 A1uT1E/S/uJSYSm2kMKFghc9BNK2FCzsNCS4zLh8mC/8mpvt26q/Yc94wdcJWtt/1l
	 ezir/73O14+oh0Gw4gf1ie31BiM/M4BrsWQ+X7SqjG8xmejgXFe5fSRAnDaZfs3DqR
	 qOD8cZSptcaoA==
Date: Thu, 6 Aug 2026 12:32:01 -0600 (MDT)
From: Paul Walmsley <pjw@kernel.org>
To: Guodong Xu <docular.xu@gmail.com>
cc: Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>, 
    Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>, 
    Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>, 
    Zong Li <zong.li@sifive.com>, Deepak Gupta <debug@rivosinc.com>, 
    Anup Patel <anup@brainfault.org>, Atish Patra <atish.patra@linux.dev>, 
    Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
    Conor Dooley <conor+dt@kernel.org>, Yixun Lan <dlan@kernel.org>, 
    Chen Wang <unicorn_wang@outlook.com>, Inochi Amaoto <inochiama@gmail.com>, 
    Chen Wang <chen.wang@linux.dev>, linux-doc@vger.kernel.org, 
    linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org, 
    kvm@vger.kernel.org, kvm-riscv@lists.infradead.org, 
    Paul Walmsley <paul.walmsley@sifive.com>, Conor Dooley <conor@kernel.org>, 
    Jesse Taube <jtaubepe@redhat.com>, 
    Charlie Jenkins <thecharlesjenkins@gmail.com>, 
    Andrew Jones <andrew.jones@oss.qualcomm.com>, devicetree@vger.kernel.org, 
    spacemit@lists.linux.dev, sophgo@lists.linux.dev, 
    linux-kselftest@vger.kernel.org
Subject: Re: [PATCH v5 06/17] riscv: Add Ziccamoa, Ziccif, Ziccrse, and Za64rs
 to cpufeature and hwprobe
In-Reply-To: <20260701-rva23u64-hwprobe-v2-v5-6-2c61f94a695a@gmail.com>
Message-ID: <6aa9b348-931b-e358-6005-7e38f97092ef@kernel.org>
References: <20260701-rva23u64-hwprobe-v2-v5-0-2c61f94a695a@gmail.com> <20260701-rva23u64-hwprobe-v2-v5-6-2c61f94a695a@gmail.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Wed, 1 Jul 2026, Guodong Xu wrote:

> From: Andrew Jones <andrew.jones@oss.qualcomm.com>
> 
> Add Ziccamoa, Ziccif, and Za64rs to riscv_isa_ext[] so they can be
> parsed from devicetree/ACPI ISA strings. Ziccrse is already present
> in cpufeature; this patch only adds its hwprobe exposure.
> 
> Expose all four extensions via hwprobe through new bits in
> RISCV_HWPROBE_KEY_IMA_EXT_1 (RISCV_HWPROBE_EXT_ZICCAMOA, _ZICCIF,
> _ZICCRSE, _ZA64RS), so userspace can probe each of these
> RVA23U64-mandatory extensions individually.
> 
> Reviewed-by: Jesse Taube <jtaubepe@redhat.com>
> Signed-off-by: Andrew Jones <andrew.jones@oss.qualcomm.com>
> Signed-off-by: Guodong Xu <docular.xu@gmail.com>

Thanks, queued for v7.3.


- Paul
