Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.52
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792654304;
	b=BfbWSN8GKaji0pTqCnYaTGpIrKt79GEhMbYi0/gr9X66/iycyTpn2Bln7LnNqET0Q4az
	 BZk5lPPfgfCuazHIogDbkXyCtnERPfd2rIFuUkSbvF9EU5jtPJs5fGN8aocGSaP8Hau8s
	 ZqWL+RHsyWIKU/gjIIR7pWYHEcOHgZMOFRXewR/WFYqOQzDeTeHYLFxNB4yJrWAV1ijIP
	 g26/7Dlqb3C8814UfeCxYh72i8yT16HjNb8487l1rEQJLnsW6yUEvkwlRyHI+uP5XySjO
	 nrsOkKjjZ/kg27zR3XJ3KSE/sZakswBoSlusECejbPdoqv7/gRukNrDxWQw7zX5jlWQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792654304;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-ID:Date:
	 MIME-Version:User-Agent:Subject:To:Cc:References:From:
	 Content-Language:In-Reply-To:Content-Type:Content-Transfer-Encoding;
	bh=Jveg2/e8slfpAkmKAr0Gu490QRow+isSNa+l0aksVMo=;
	b=ey/dfUXgJBIuvmRPzDphsj/ULGWDQEb+/hPJY40xd/29sTHoFa3r+4/t37ofT7/N5+ui
	 4ohLa4M0l92BSfpTgDb6NUYbzt6v6vquEt83IJr+zeYvhyJvNjLSPv8KuFsjLoGBNNdh7
	 4JDPaaHgaouIg21S677uWbI6G74aba0lhT+syTStPbaYm6q1+AmScR5FJZs25PlS5S5kl
	 EDjwEzvNEt0DwEQWmahHMFuc4DJhCbCMvt4fi0uJBZQ4d7VoQ/8aEh9I8F0IM4CEZvCKZ
	 K2a/FpIT08vkzZPeIS/FeK7f8tPyZutatdAboviSqy8uTs8CtVu03BPaQ4GcZCJPxVw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linaro.org;
	spf=pass smtp.mailfrom=linaro.org;
	dkim=pass header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=CYpMiwDN;
	arc=none smtp.remote-ip=209.85.128.52
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DEA7606A319
	for <kvm@vger.kernel.org>; Thu, 22 Oct 2026 07:31:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8DEA7606A319
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=CYpMiwDN
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-4a1fe9efc0eso17152055e9.2
        for <kvm@vger.kernel.org>; Thu, 22 Oct 2026 00:31:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1792654302; x=1793259102; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=Jveg2/e8slfpAkmKAr0Gu490QRow+isSNa+l0aksVMo=;
        b=CYpMiwDNUSEoVjYiBHwIEo6/fumMGE0xFFO8mPuw0xwJDyhvGoEb6A/sL1zlxdAvVM
         RIcB6SVBrxVk4vi9/YSV4ipjwA4CenuHphnWGP66461IRZ35gvhRj6FA3Vl2c3dJ/ekr
         JbAsyixvarhCZsgJZoDf3LsGFwL/6YJn3U3MKisIyHEgPmve3ZJkLrFhT79zNKLryCNh
         KAVh3Gjs7vwxiCBGW6Npp7ecr3hSf22tBfsaJlW9Qwqy4ejFBePagCV1mZgc3LRF8Yfj
         0c9zC5d1Urm7qjfCgCbj8Ikeccdn6FypS05i2NoEFqTACQMABVihMMDAESnMZlejq/Kx
         iNuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792654302; x=1793259102;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Jveg2/e8slfpAkmKAr0Gu490QRow+isSNa+l0aksVMo=;
        b=oUG3FHtDXmUcZb5XYZNcQr9ICmvoXfu16jk44AAx4xWsofdBNBpPp7d/ZHQ5r3OVyA
         tacFR3fWx1tgxpGrVfTlDmn8a4peJr72FmlzgiOYO+lzTRCwz4LUPetz8m7xwtnUIZ9K
         aqZgP5hj6/tPDRpV0NxFpP9Yvi2ZU3aIsMt91Yju6/8oDb/PiD2xtLA654kgy6Yq81g7
         rlkmkcYCP6OT2wuGPG+B67NCJokHkzLtJy8ePrxObr2pDdyrKyqeMgZs8z/Oem+LKHnD
         zolho5Z+KI1S2viqMUtYYsiVcJDjugXpYgL9QCg5PXCITQfvadn4qsnEITJ8x8TTO3gg
         2LLQ==
X-Gm-Message-State: AFq9FYJ1k8tIGPE/iyg6CFuHiUvgR8tDn0BZ+Zd2GRv0tKaJZT1DeFG9
	A7X2qXQTix2XUzhTmwFqx7jFmi6WxTSKDRJazc0eWp4mjKhKNZBJTb7InxOoBB80Zxg=
X-Gm-Gg: AYBFou1PaiHS8OmJ+r+7jQH9EMnFXsAbQ86s6W/FWzVv3kiUy5WHE5lEpcn90o9sX1i
	HVPeM7niU0qxhBcc5qjM4Drwgt0SOUBmpQk+CwCyPjzmaT48WcqjtSkDp+ZrOqobrrX3kpTd+eX
	SG19zbDbwJnBPDYf9M4zGo/BE4nmTDqIBA9hX3/kbor++LfvyQtMmrcTIygRKKNjrnPwioTLMVd
	L9IK3LYCvfFH1QsVqttkSXiXl7BpbzG7v2fwMg8W9Rf0aRIBjjnWhlD0z9s/dg3gFyPcGgVMxRn
	qD1+tdzD+8DbrkgcHCL4cYKvdVtrp2MnvAk+qSLt6NQuYqzgOkUD6uRdgGVRFYoFkTr0d8gTyxl
	I7glJw6yHO6gPWVYJY5Hd09xAh5xHjxujBsSUdf44FecU0DVOyyfWyMj0NfIuGWwGx0zvpKfuiZ
	4eXkB8LOZoo2KcOl+0WhhX5M2qCyhwyDJ10nrC91OYOY1T7qIlIf46ocx4UxWanfAjlJylV5dFR
	kGvSCdKSuhviklsQ1NPrPy75EA0cpIVecHh2N3Mww6RysRbRuOJp5Kudi9K3GSUR1aO11p50GGO
	1vGm7/axgHukkPaEgiPBRGiAdUY=
X-Received: by 2002:a05:600c:1f95:b0:4a1:e722:a0a7 with SMTP id 5b1f17b1804b1-4a1fdd19dddmr96405335e9.30.1792654301828;
        Thu, 22 Oct 2026 00:31:41 -0700 (PDT)
Received: from [192.168.2.121] (pd95f64bf.dip0.t-ipconnect.de. [217.95.100.191])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a203a56ac9sm53211585e9.14.2026.10.22.00.31.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 22 Oct 2026 00:31:41 -0700 (PDT)
Message-ID: <89b2fca4-2409-429d-b69e-a367634092e5@linaro.org>
Date: Thu, 22 Oct 2026 09:31:39 +0200
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
Subject: Re: [PULL 00/10] Firmware 20261021 patches
To: Gerd Hoffmann <kraxel@redhat.com>, qemu-devel@nongnu.org
Cc: kvm@vger.kernel.org, Stefano Garzarella <sgarzare@redhat.com>,
 Marcelo Tosatti <mtosatti@redhat.com>, Markus Armbruster
 <armbru@redhat.com>, =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?=
 <berrange@redhat.com>, Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Zhao Liu <zhao1.liu@intel.com>, Ani Sinha <anisinha@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Eric Blake <eblake@redhat.com>
References: <20261021163239.1131460-1-kraxel@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20261021163239.1131460-1-kraxel@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/21/26 18:32, Gerd Hoffmann wrote:
> The following changes since commit 8967b2fe1b2aaae3c29e207d85fab901d580a2dc:
> 
>    Merge tag 'pull-9p-20261019' ofhttps://github.com/cschoenebeck/qemu into staging (2026-10-20 07:04:06 +0200)
> 
> are available in the Git repository at:
> 
>    https://gitlab.com/kraxel/qemu.git tags/firmware-20261021-pull-request
> 
> for you to fetch changes up to 966572648f246483b2076149b4fb9d665789409a:
> 
>    backends/igvm: fix parameter area entries leak (2026-10-21 18:26:52 +0200)
> 
> ----------------------------------------------------------------
> - igvm: fix policy handling
> - igvm: misc minor fixes
> - igvm: add command line parameter support
> - hw/uefi: fix pkcs7 wrapping typo

Applied, thanks.

r~
