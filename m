Received: from out-181.mta0.migadu.com (out-181.mta0.migadu.com [91.218.175.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DC1A3CF1ED
	for <kvm@vger.kernel.org>; Mon, 27 Jul 2026 19:28:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785180487; cv=none; b=AN1uBC/b9ipD4oZEbM1t4eZr9Q6RGY5LuX9sKOXMTgP1v1nIhTyIDAAacECN6DXkzuYAmagKVcB/UexF7Dmm/BEFXRQwQNUYkkcXT+uRBx528ALxEAE/I9Im+u81EggCTCIjw0vpaRN+L/N/98w96ytBCNCXxCKnP3exwxTRzPY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785180487; c=relaxed/simple;
	bh=QCrE+iGXfZD6zD5R9MwWECEg7w8b/yqHCg7oz9hQ674=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mVkMZ1P3s9PaKeBo9gONPz1l2ReGuqhI1haHpTX07mo6YLTrRzc84d1u0UBths1ew2/lOjRMc39syVYYOHZmJgWfte6FwpzEe2tQAgiEHNxtB1L1XYGjUYuqw+j6ZOfn5QD/IKfN48ZY4PI9DAWadpUXHLDrHUh8fpMEIPK5lpI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=jlQ0HYr1; arc=none smtp.client-ip=91.218.175.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="jlQ0HYr1"
X-Forwarded-Encrypted: i=1; AHgh+Rpz9vvSecue3NeDbSwTTm383zzROOTra6jJYrHY5Sxhp8U3JtbKdL5d9FzuiO0VS3rkCC0=@vger.kernel.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1785180483;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=TzFyIvdETtvcgqgQWIorf4OEXGTCx8wQba8CPFyKDaM=;
	b=jlQ0HYr1JAl8o/jJS7iXveRE31YKN5vR8pjW8r/d05zQB5wEYaK59A+PpUXEgYocalj6M9
	ZSK322KqJ6RiaN7QBFIcrHHa8b/N/V4gxImy7PHABp2aRFO2vEBhJoveP+h6g66wtZpIUA
	Ky5rCf8Eu16VjY1kyfJBd2FBaSshIfo=
X-Gm-Message-State: AOJu0YwEWrq1zx7kRgtWvpWt77cDfQGe0EE7zynKkuz0Bnb5QrTTz0ns
	HWLwoWe32qw4sLks0JrLHRT46nVkSYPvXq2OlaXXSeCMvn6LfKUEM0fdapGerlxogDwWLkcM89O
	J/d3DRLk3jcTqr00gE/8kzNdQOCGppainWZeoFxAW
X-Received: by 2002:a05:622a:901c:b0:51c:ae6:a57 with SMTP id
 d75a77b69052e-529a76e10b3mr37835361cf.11.1785180477336; Mon, 27 Jul 2026
 12:27:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260724104819.1296803-1-sascha.bischoff@arm.com> <20260724104819.1296803-39-sascha.bischoff@arm.com>
In-Reply-To: <20260724104819.1296803-39-sascha.bischoff@arm.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Fuad Tabba <fuad.tabba@linux.dev>
Date: Mon, 27 Jul 2026 20:26:00 +0100
X-Gmail-Original-Message-ID: <CA+EHjTxk_OnWEd_2w-w=Ub3ANXdHhqx_ai52cjy0vMo5bGOnfQ@mail.gmail.com>
X-Gm-Features: AUfX_myJCmLEFpem2D6VmQMOVasWlfXcuLnqXXpU_yqxlWvcIJNtla0GtSeFpRo
Message-ID: <CA+EHjTxk_OnWEd_2w-w=Ub3ANXdHhqx_ai52cjy0vMo5bGOnfQ@mail.gmail.com>
Subject: Re: [PATCH v4 38/48] Documentation: KVM: Add docs for KVM_DEV_ARM_VGIC_GRP_IST
To: Sascha Bischoff <Sascha.Bischoff@arm.com>
Cc: "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, 
	"kvmarm@lists.linux.dev" <kvmarm@lists.linux.dev>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>, nd <nd@arm.com>, 
	"maz@kernel.org" <maz@kernel.org>, "oliver.upton@linux.dev" <oliver.upton@linux.dev>, Joey Gouly <Joey.Gouly@arm.com>, 
	Suzuki Poulose <Suzuki.Poulose@arm.com>, "yuzenghui@huawei.com" <yuzenghui@huawei.com>, 
	"peter.maydell@linaro.org" <peter.maydell@linaro.org>, "lpieralisi@kernel.org" <lpieralisi@kernel.org>, 
	Timothy Hayes <Timothy.Hayes@arm.com>
Content-Type: text/plain; charset="UTF-8"
X-Migadu-Flow: FLOW_OUT

Hi Sascha,

On Fri, 24 Jul 2026 at 11:59, Sascha Bischoff <Sascha.Bischoff@arm.com> wrote:
...
> +      -ENOENT      A userspace SPI IST buffer was supplied, but there is no SPI
> +                   IST to serialise/unserialise

I do not think -ENOENT can be returned. The branch producing it in
`vgic_v5_get_spi_ist_desc()` needs `!ist->base && userspace_buf`, but
`vgic_v5_validate_ist_attr()` runs first at both call sites and
rejects a zero `spi_ist_addr`, and a VGICv5 VM always has an SPI IST
by the time this attribute is reachable. That leaves the
`userspace_buf` argument without an effect either, so this may be a
code fix rather than a documentation one.

Cheers,
/fuad
