Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=95.215.58.172
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793002218;
	b=qtGhp/08NN149bZPvyRkvSgm004+m+d7K6ou0ngVTuRV5M0wOk1jK2xsgylDVxVPWvYP
	 wGfQbQWGI2ftlL8iOlFZBxQ7ueqU5wZ4w2qb5Kyg4m35zUPph2pUDvjXAR2OTIRqoC4eO
	 kKpnM8XnCZgKu3InmyJJA9inRnBi2H/HCgwlTab1eJGSfx9QTN2NBbQ+9Qy90b0+xQ8Wx
	 h7r6BbgUEFbYw9mQOG+XSiM8vUlelLGC4iTRLy40eAp8CL0IySzPAmZM+AZxhdyYUFQHg
	 n6cmSvIiQ5xRZcwBNhxkPEb5udTVpUdiSxqwRp+1OA4FqHD7yRFTcnRe7n5oXKhPIkw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793002218;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:Received:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Received:MIME-Version:References:In-Reply-To:
	 From:Date:X-Gmail-Original-Message-ID:X-Gm-Features:Message-ID:
	 Subject:To:Cc:Content-Type;
	bh=SU/p59HmrY1l63uWO1J6fBGj9iSaP1sfb4BVk3OH0dM=;
	b=sdTem2FoQbUJfr3hyCSwZe0ViBZReheftt9Z1IoFlq46zbI1zIPq72mnhOiOZz8g2D7l
	 6W9ne1BE8OMYmRPtJwd/juu2FzOUXnZ+wcwx/em49Ae2ZdiYRVeAlFs2MPwl5SaA2WCvR
	 tJzcD+PT1LZ5pk2UESFYQRPyFVWv/76nFpwk5R3doRsniZTRszqC5H44BelMj/uDgSnko
	 g0VH1rXp8+u8VDQWIilEGm2wlwWrrxm7McycvLcUWL0WSFjroiMrBGFqqIV/O9hz4UBMV
	 8NkDCxFf2LiLUrYNF/M4YiEDn2tj7F4QugX7glj7iVjtIRm903uyWsQIGs3kaizFlEQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b="JivXV/uP";
	arc=none smtp.remote-ip=95.215.58.172
Received: from mta1.migadu.com (out-172.mta1.migadu.com [95.215.58.172])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E52B606A321
	for <kvm@vger.kernel.org>; Mon, 26 Oct 2026 08:10:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2E52B606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=JivXV/uP
X-Envelope-To: kvm@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=SU/p59HmrY1l63uWO1J6fBGj9iSaP1sfb4BVk3OH0dM=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1793002216; v=1; x=1793607016;
 b=JivXV/uPxz7cg80nrzqcgoUz12nR6uhuUlQ4//2Rl/eG3J6Cm9yy2qVIuqF18Su9RqNdVGsv
 lY4EaWoM5LIQQnbwmKr9CYOITehKJjKWEvO+9vvwzBO0krMFhvPrk5vinQR4jA5A/y/cZW4V4ee
 OL1TrhN4r4rfLquwOPGO1uS0=
X-Envelope-To: kvm@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id cf45f50629a58979;
	Mon, 26 Oct 2026 08:10:16 +0000
X-Mizu-Trace-ID: cf45f50629a58979
X-Migadu-Flow: FLOW_OUT
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-5be4a7b9e6fso6233e87.1
        for <kvm@vger.kernel.org>; Mon, 26 Oct 2026 01:10:10 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvBxY3f76Ckk8XBqvIuRNttWZup0tSkxMekzEJ1XAuqOhC6YxyJWpu7PJE02/yd+vdoGnNJY=@vger.kernel.org
X-Gm-Message-State: AFq9FYLbBOxlrsX6xrvLF0HtayckdJ4PPX7F3513frBlGEeZkJYvni5K
	IUROeSSorE1UDcYejNNn+yL1Ibov4VO/eNDS9yMkM6MqUfOCgSzGQXbNRIx1qUEmz/iWQakTpVC
	72FFmRripOn/GSTjzw+q9YPuvmOTS2gvTACS7Vn9m
X-Received: by 2002:a05:6512:3f03:b0:5bf:a28a:f2d9 with SMTP id
 2adb3069b0e04-5bfb79dafd3mr111700e87.4.1793002210084; Mon, 26 Oct 2026
 01:10:10 -0700 (PDT)
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261026012128.2270251-1-sashal@kernel.org>
In-Reply-To: <20261026012128.2270251-1-sashal@kernel.org>
From: Fuad Tabba <fuad.tabba@linux.dev>
Date: Mon, 26 Oct 2026 08:09:33 +0000
X-Gmail-Original-Message-ID: <CA+EHjTzF5PsNt+riasW-SK-nhkLYh3kojMFyCEqs372-Mficnw@mail.gmail.com>
X-Gm-Features: AclHuK9ieRbKRZ3vlLRpK7x9lOVSGw-njZY_CzO5qLbrpHOtyOHbR5m8v7LhEMQ
Message-ID: <CA+EHjTzF5PsNt+riasW-SK-nhkLYh3kojMFyCEqs372-Mficnw@mail.gmail.com>
Subject: Re: [PATCH v2] KVM: arm64: selftests: Skip unwritable ID fields in
 the failed-run test
To: Sasha Levin <sashal@kernel.org>
Cc: Marc Zyngier <maz@kernel.org>, Oliver Upton <oupton@kernel.org>, Mark Brown <broonie@kernel.org>, 
	Joey Gouly <joey.gouly@arm.com>, Suzuki K Poulose <suzuki.poulose@arm.com>, 
	Zenghui Yu <yuzenghui@huawei.com>, Steffen Eiden <seiden@linux.ibm.com>, 
	Paolo Bonzini <pbonzini@redhat.com>, Sean Christopherson <seanjc@google.com>, Shuah Khan <shuah@kernel.org>, 
	"Lorenzo Stoakes (ARM)" <ljs@kernel.org>, Itaru Kitayama <itaru.kitayama@fujitsu.com>, 
	linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev, 
	kvm@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Sasha,

On Mon, 26 Oct 2026 01:21:28 +0000, Sasha Levin <sashal@kernel.org> wrote:
> test_idreg_frozen_after_failed_run() checks that changing a feature ID
> register after a failed first KVM_RUN is rejected with -EBUSY, and does
> so for every field of every register in test_regs.
[...]

I tested v2 on the FVP AEM model configured with no AArch32 at any EL
and with PMUv3, under nVHE: set_id_regs fails on ID_DFR0_EL1_PerfMon
without this patch and passes with it. It also passes on QEMU (which
supports AArch32 at EL0) under VHE, nVHE and pKVM.

Reviewed-by: Fuad Tabba <fuad.tabba@linux.dev>
Tested-by: Fuad Tabba <fuad.tabba@linux.dev>

Cheers,
/fuad
