Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=95.215.58.252
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793713339;
	b=W+V4v/gXHtvkPLIlA6Xrle6ve8wueFpehj9fDAuZJ6y1ERi3+9aE1/Jcq5/7CbABxuqn
	 kLVngB6Yq8p8Bm4Vb0aaitjqUsbTiK2dOXTDgwHl5vQ8FQpUiC8zUJEY51L3lioQIy8ff
	 HkX51vgL/W04y5DGQDqXT7+LsAtgQrPWjHURUq0qLeT9pwHXq4M+VKn/Ga4JP8/SX7efC
	 wFImUYSwJo9ObVO+JkdrZ0Ah/GEL4oZWMn7bVyqgm4aIOz6YMYvK9MuRn1WZ7z81gkazV
	 K5OrAhiJLCUJaIt3MRFniwCzDibw/mzoB3HUdPdwkKjthjRnSmMjTrX84GnBGas0/0Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793713339;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:Received:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Received:MIME-Version:References:In-Reply-To:
	 From:Date:X-Gmail-Original-Message-ID:X-Gm-Features:Message-ID:
	 Subject:To:Cc:Content-Type;
	bh=Q9qnXfHVWDfmE9hIzIuxQlA5TNXMmk+3sfayKRD7PX0=;
	b=NoJfvvxzucmCLkPGaIJzSGqi7V7fmCLHcgw3aMjQ64SZsjtQ0GUgU/YfRhAC7ataf21J
	 UqIsGXP0dC+RoRDCt0tUxwKYASmXhw6SnW32TqrobAuoiOdPNXB0y3uJVE5Phv6fhfdwn
	 V8bsvh+u0jt/YPJ05j/ft1ZSKTdsdgHSkCNQAQTCihwcFOND857v/piqeEcxQUczmRVza
	 bT8M8pdfv0RuujVrfcGZeUEc4DrJXz33Rks3FagTcMGNgPzCIchm82mNkZnLxEEpjkU4t
	 scgDQMHT15mCRKNNxFT6D/Y5ln2MU59J4RrNhPj0fSVlpTR/5J3bB9vkKe+y5mvdCAw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=LrKY1t1M;
	arc=none smtp.remote-ip=95.215.58.252
Received: from mta1.migadu.com (out-252.mta1.migadu.com [95.215.58.252])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5B24606A326
	for <kvm@vger.kernel.org>; Tue,  3 Nov 2026 13:42:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D5B24606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=LrKY1t1M
X-Envelope-To: kvm@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=Q9qnXfHVWDfmE9hIzIuxQlA5TNXMmk+3sfayKRD7PX0=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1793713336; v=1; x=1794318136;
 b=LrKY1t1MCN7jjtz+TQkZQ/1Ftsq04U9A9gAfR7GX66J7a4DzGCztH2sgpsHnI1+7qIVBNK0O
 Yqxca9h8+zQWyjkz3E4d/9cw+UxQ/dR79FrxO3quHzEThtlpcDzxQIHqycLuT45hqT9Y75f/ZwQ
 1sxXRjbkx/fgm7CfTL3HN/kI=
X-Envelope-To: kvm@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 0ada72d8aea6912e;
	Tue, 03 Nov 2026 13:42:16 +0000
X-Mizu-Trace-ID: 0ada72d8aea6912e
X-Migadu-Flow: FLOW_OUT
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-5bfca2a2af4so5738e87.1
        for <kvm@vger.kernel.org>; Tue, 03 Nov 2026 05:42:11 -0800 (PST)
X-Forwarded-Encrypted: i=1; AKwUvBxbMt6OStTYm+cSKr5J/M9sm3Aq7T6OKAkOXXiUlo3iwX9U9kSdaw6OoC+Z+DZE+D+RKUg=@vger.kernel.org
X-Gm-Message-State: APuU4Z/xmWTD+G0bSK8jZrHqWuTO82YkqYen4MDyfNv2OqhrQqYAAX2G
	uSGbSi4plrMdWwQadozx/qsvgIyekAaUJk+thFZo8zsNdExVlTHOf5/3mwGYgzZJipN6ShbUZB4
	AJ/nGwJ1cRYMcyc7yy0DmSwHPlRiXD6c4yDD7eTOw
X-Received: by 2002:ac2:5385:0:b0:5bf:f060:c0f3 with SMTP id
 2adb3069b0e04-5bff060c331mr94794e87.12.1793713330954; Tue, 03 Nov 2026
 05:42:10 -0800 (PST)
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261102194454.4086911-1-sascha.bischoff@arm.com> <20261102194454.4086911-2-sascha.bischoff@arm.com>
In-Reply-To: <20261102194454.4086911-2-sascha.bischoff@arm.com>
From: Fuad Tabba <fuad.tabba@linux.dev>
Date: Tue, 3 Nov 2026 13:41:34 +0000
X-Gmail-Original-Message-ID: <CA+EHjTzKKG-F4aCRiCQsJOspZJWgKA6PjVasEcf_qP7W7H_Z_A@mail.gmail.com>
X-Gm-Features: AclHuK-eWl8epl3U-D4A5JlaL5YUw0LbIVdH55Fk5BPVD-YR5A-BnAm0yAolBPA
Message-ID: <CA+EHjTzKKG-F4aCRiCQsJOspZJWgKA6PjVasEcf_qP7W7H_Z_A@mail.gmail.com>
Subject: Re: [PATCH v2 01/16] KVM: arm64: vgic: Split out common LPI allocation
To: Sascha Bischoff <sascha.bischoff@arm.com>
Cc: linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev, 
	kvm@vger.kernel.org, maz@kernel.org, oliver.upton@linux.dev, 
	joey.gouly@arm.com, suzuki.poulose@arm.com, yuzenghui@huawei.com, 
	peter.maydell@linaro.org, lpieralisi@kernel.org, timothy.hayes@arm.com
Content-Type: text/plain; charset="UTF-8"

Hi Sascha,

On Mon, 02 Nov 2026 19:44:39 +0000, Sascha Bischoff
<sascha.bischoff@arm.com> wrote:
[...]
> Initialise LPIs as Group 1 before publishing them in lpi_xa. GICv3
> LPIs are Group 1, and another vCPU can find a new LPI as soon as it is
> published. GICv5 does not use the group field.

Two nits: the old vgic_add_lpi() already set the group before
publishing. The comments in its_free_ite() and vgic_alloc_lpi() still
name vgic_add_lpi() for the GICv3 path.

Reviewed-by: Fuad Tabba <fuad.tabba@linux.dev>

Thanks!
/fuad
