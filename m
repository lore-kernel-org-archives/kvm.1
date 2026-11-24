Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=91.218.175.159
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795497805;
	b=vAqE1rZvp35oLryBQAufXREYLYqjLfeUwmOkazEAef8RQHaNUBrc1HHtpY8NvCAbHMDM
	 MgxhX/vYBtF75BVHcxioS+W1wLvyPgoklh86BTbKtdNaOTv7KlHSCQL7ffuEXo2hzOibr
	 KHLzrM0WIVShBjtp8Zt9Jx2TBMi9/pzzKk0MNF8OFOYkO0JkiXicmVTUR7SUMeLYyHIcY
	 xZXbVw8yAASYqoc+lsaGR5n3KbaxFJJ1dsSi2TnTQaHABLM/Weul4qru52///6NcuMxSx
	 Aqmzj8GvjrGxS4hreaCjgTZgEFqO6Ef/LF8MaefEDDJZ5QKnCQ+ad8oz4Gv2EIdC2XQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795497805;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding;
	bh=qEvIk+aHNDceYWGtYqNUvdpoCP1Y0OFLjkamC7OJOgs=;
	b=bGY63Uanv5PwtiumCzhLV1BfbjBcx6mllTgF00pRNuEQuNLtEWtIlC0o15WiG5ADwyhh
	 Lf3tIRenioUVrB3iWO2zrNYFenlU2f2LWMkKJtg5cRarBZ3zfOxSHl5S7eJJ72PlNUNCt
	 o2NlxIeXrxfxVGzceFwoYVpMFYor9HiMZ+2L36WZQ1+Pc/5IkE8rMY5lOAAlB8WfF3sQa
	 ks/UHP9SgEqqz/KbrbEjpRizu3kxLXT9MNf8FOEKZuHyBNixCuHOXMV83shnQu1CPih+U
	 D2DWTv+Ef5SUBYYE/857VfnmmG6P8PueQy9I5WePuhaNt1HEYB/Q0Uu9Wqa9NJKlO1A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=xXPugBxM;
	arc=none smtp.remote-ip=91.218.175.159
Received: from mta0.migadu.com (out-159.mta0.migadu.com [91.218.175.159])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CE81606A31E
	for <kvm@vger.kernel.org>; Tue, 24 Nov 2026 05:23:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3CE81606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=xXPugBxM
X-Envelope-To: kvm@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=DmzO0Sk4kjvl9NzB/hFxZeqrskX83I/OHqCcDGtmZfk=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1795497803; v=1; x=1796102603;
 b=xXPugBxMP+28DxutyNPzKPouigEmCdMrXvYbCshiS2azD8ytHez4mQfLJmcpmUbLWIBVtIKT
 QxCpfl/ewMIMLl6VN7RgzDC0TFqfMWFgA2GHFDPKvPJnG8n+qO25mV/K53ZM2+DdsJYdOHkvnha
 MvcB29+kOzNTTpBtM3EYiSnc=
X-Envelope-To: kvm@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id e92b5db1fdfb7210;
	Tue, 24 Nov 2026 05:23:23 +0000
X-Mizu-Trace-ID: e92b5db1fdfb7210
X-Migadu-Flow: FLOW_OUT
Message-ID: <f634fd52-fe7a-46ef-ad2b-3b4a90b7154f@linux.dev>
Date: Tue, 24 Nov 2026 13:23:11 +0800
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] MAINTAINERS: Add the LoongArch KVM selftests
 directory
To: Gokul K <gokul02k@gmail.com>
Cc: Tianrui Zhao <zhaotianrui@loongson.cn>, Bibo Mao <maobibo@loongson.cn>,
 Huacai Chen <chenhuacai@kernel.org>, Paolo Bonzini <pbonzini@redhat.com>,
 Shuah Khan <shuah@kernel.org>, kvm@vger.kernel.org,
 loongarch@lists.linux.dev, linux-kselftest@vger.kernel.org,
 Sean Christopherson <seanjc@google.com>, Song Gao <gaosong@loongson.cn>,
 linux-kernel@vger.kernel.org
References: <20261123100701.1679376-1-gokul02k@gmail.com>
 <20261123100701.1679376-2-gokul02k@gmail.com>
Content-Language: en-US
From: Zenghui Yu <zenghui.yu@linux.dev>
In-Reply-To: <20261123100701.1679376-2-gokul02k@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/23/26 6:07 PM, Gokul K wrote:
> The KVM/LoongArch entry covers tools/testing/selftests/kvm/*/loongarch/
> and lib/loongarch/, but not tools/testing/selftests/kvm/loongarch/,
> where the tests themselves live. The */loongarch/ pattern needs a
> directory between kvm/ and loongarch/, so it does not match it.
> 
> As a result get_maintainer.pl omits the LoongArch KVM maintainers and
> loongarch@lists.linux.dev for patches to those tests. arm64, riscv, s390
> and x86 each list both forms.
> 
> Signed-off-by: Gokul K <gokul02k@gmail.com>
> ---
>  MAINTAINERS | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index f53047aa8d3c..fed2245b979f 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -14327,6 +14327,7 @@ F:	arch/loongarch/include/uapi/asm/kvm*
>  F:	arch/loongarch/kvm/
>  F:	tools/testing/selftests/kvm/*/loongarch/
>  F:	tools/testing/selftests/kvm/lib/loongarch/

This line is redundant and can be removed.

> +F:	tools/testing/selftests/kvm/loongarch/
>  
>  KERNEL VIRTUAL MACHINE FOR MIPS (KVM/mips)
>  M:	Huacai Chen <chenhuacai@kernel.org>
