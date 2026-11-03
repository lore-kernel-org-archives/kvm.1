Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=95.215.58.118
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793714097;
	b=StlxZKdfqTlA6DEcJY0Rs4t9+vDh00XqAZXgQLijZ/eCJfotm6yxYY1uJVYJ1kuvWY9z
	 ab4dtHh82FaqdvfJoHESg0bKLzR8d2sojKzkp+F6yDzYYfc7/7J4g2Ymkro6GlHWCzXUo
	 tqV7DtXOIR3Du09CmeGt7Z+4CU1tWpWVjfmO/Vibi71AFAtjAIVMS17RLmg0PEafGYNWS
	 0O58HAyNh4mk86VzRlAO/uo7FgJ2DfR1B2XlVZm66PjByFzZ54VGx2c93iRXQ3843Lhdm
	 djhVe8I87VZ7ubfrnuzhCUoThn+OuEPm1L8RSyUvFMb4ZS4F2+Y22dKyYGpvbceb27A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793714097;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:Received:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Received:MIME-Version:References:In-Reply-To:
	 From:Date:X-Gmail-Original-Message-ID:X-Gm-Features:Message-ID:
	 Subject:To:Cc:Content-Type;
	bh=txfyUbbk7S6wULCvktRyIt/cKzs3N8dY80CwO9mVhmQ=;
	b=CZKKsYwU0cVbqDlOLVNbp+Dynt7jXdIm8ojy8DQ0ojvuyoV9tNwnKiVEzr/vY4OdMdjB
	 RjahG6E5bURBu8u0keKzPgwNSoIVn0vTSTJqX++K0SU9++RKTKCNaskVMUV/bAt3h41Fa
	 wnAcr0BYoXC2vu0BG3ICaXy0qu2UHimWZaTwEv2+R/XoMH+hZB9YR1WJQoOqUMe+qdrD2
	 oYQT6JPa6+NuoQ7yXeBLgW3kpUNUXYxpcd+POsimPDv+QVQrzWEuiH052sti91ME01wh/
	 gvugkMTOaRFO126gx3Caih2FOkV7FpGKtc3wWcQkwEhbRm481gcel5JOBONykSNtATw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=hEkRqH1S;
	arc=none smtp.remote-ip=95.215.58.118
Received: from mta1.migadu.com (out-118.mta1.migadu.com [95.215.58.118])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFB96606A324
	for <kvm@vger.kernel.org>; Tue,  3 Nov 2026 13:54:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org EFB96606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=hEkRqH1S
X-Envelope-To: kvm@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=ujFyUsSp/zUZUClWo2l35wPvTBRekRlNepNILaDkzbA=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1793714093; v=1; x=1794318893;
 b=hEkRqH1S1g+wxNzMk7nquRKKHkKIjqi8y0X8TAO8FDCl3h2URIkzsbQLZjL1MnJxYfT+mCME
 1/kCNvzdMNgl0ily5MqOcJIeSmvvHV4YINLyihHK8kNaLCV4VAX3sYwPOABv76CwciKOOvRGEk7
 HjgUfHtDFjpv3VoTnBnv/cVY=
X-Envelope-To: kvm@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 87b554ffa9cddb81;
	Tue, 03 Nov 2026 13:54:53 +0000
X-Mizu-Trace-ID: 87b554ffa9cddb81
X-Migadu-Flow: FLOW_OUT
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-5be58ad9600so7442e87.0
        for <kvm@vger.kernel.org>; Tue, 03 Nov 2026 05:54:49 -0800 (PST)
X-Forwarded-Encrypted: i=1; AKwUvBzNQ6lJdxwf1kkcPUG/h25dcBThLrSkdaTIpDBHbS07ZHxZD12Q0zQmb8YLSNj+5Osi88Y=@vger.kernel.org
X-Gm-Message-State: APuU4Z92161U8sFFg67HpAHY1FE0Ao+Cv5bp/0yINRcNtLd3HUI2kdEu
	mBGev4ZkI5vAKiFJB95z8brFPXGiHNLR5JPiiw+aDaKLowlkBxFdpu0o65BrxGD2eBALsOkrBXk
	3nm+sI33pAkG9TXMOAMVJhBv3FH3JA/vY+uo0HGZ3
X-Received: by 2002:a05:6512:a91:b0:5bf:b7d1:6478 with SMTP id
 2adb3069b0e04-5bff0a6d4a4mr137754e87.1.1793714088498; Tue, 03 Nov 2026
 05:54:48 -0800 (PST)
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261102194454.4086911-1-sascha.bischoff@arm.com> <20261102194454.4086911-9-sascha.bischoff@arm.com>
In-Reply-To: <20261102194454.4086911-9-sascha.bischoff@arm.com>
From: Fuad Tabba <fuad.tabba@linux.dev>
Date: Tue, 3 Nov 2026 13:54:12 +0000
X-Gmail-Original-Message-ID: <CA+EHjTz8A5FQwwFdaf6+w=hs2pEEp+HkaGrLLJnjOzV+sq+Sjg@mail.gmail.com>
X-Gm-Features: AclHuK-wIMoHSmRAGSQfIwrf9SSkWPIjCKlZxQFL7L_HnSVtO2Gkt-bZrl0MzVc
Message-ID: <CA+EHjTz8A5FQwwFdaf6+w=hs2pEEp+HkaGrLLJnjOzV+sq+Sjg@mail.gmail.com>
Subject: Re: [PATCH v2 08/16] KVM: arm64: gic-v5: Add ITS translation cache maintenance
To: Sascha Bischoff <sascha.bischoff@arm.com>
Cc: linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev, 
	kvm@vger.kernel.org, maz@kernel.org, oliver.upton@linux.dev, 
	joey.gouly@arm.com, suzuki.poulose@arm.com, yuzenghui@huawei.com, 
	peter.maydell@linaro.org, lpieralisi@kernel.org, timothy.hayes@arm.com
Content-Type: text/plain; charset="UTF-8"

On Mon, 02 Nov 2026 19:44:46 +0000, Sascha Bischoff
<sascha.bischoff@arm.com> wrote:
[...]
> diff --git a/arch/arm64/kvm/vgic/vgic-its-v5.c b/arch/arm64/kvm/vgic/vgic-its-v5.c
[...]
> +static int its_cache_add_translation(struct kvm *kvm, struct vgic_v5_its *its,
[...]
> +        old = xa_store(&its->translation_cache, key, entry,
> +                       GFP_KERNEL_ACCOUNT);

nit: fits on one line.

Reviewed-by: Fuad Tabba <fuad.tabba@linux.dev>

Thanks!
/fuad
