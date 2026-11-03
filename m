Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=91.218.175.127
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793713515;
	b=LXNRCBMJqZ+LafwYKTVKxLTHtfOGEpvJW5V+NBwpsNJ340Q2EpwR2+49Y1iR96GJ4Z1D
	 AVWxQxJPCxid9p4CiUqCZxfIYrFgauhIKG7XddZzmNxcLbarE2p4bnlOcG9jFsfME1dtI
	 e3WHOZ2gwsf72JgzAEgAnPXRlkfpl5Shvh/VOOOwU6N5MO2lr9XOsEYC5WYVHFwJgop6w
	 DWJjQFMBMzk1suPxRu1+3DxdPfzzHZsYSD1TiYubcXBWxjhc8Fin7O6C4POxrzUESMB1e
	 8qv60mRRcB2whbgGrzfQNlqEYbbu7dY0fLH/G0wvE5JlLRjNd6lJi9wdnzV+cN7qEVQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793713515;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:Received:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Received:MIME-Version:References:In-Reply-To:
	 From:Date:X-Gmail-Original-Message-ID:X-Gm-Features:Message-ID:
	 Subject:To:Cc:Content-Type;
	bh=7JATDHeSysjhrflLAzQ9XRWSKRJGHXy+wbdwm4zZP4o=;
	b=o+M16iws0+bpYUgmXcZH5uktoi0dMIFy33ITLEkkBRq7dn6FLJbn/BwwTcX0/KH50vpp
	 cV+0OzceQEmTWKuUMuxjtGV/WNFTaxPBvvgFFBKsuAeN2+C6vDXQ8qXgkKy/Sfs+lQW+U
	 Nk52aP9byVtmicBvxcV63WLUhScCQezPW7CPxMVULjbgMhNF7CLkI9hmTO/NrBiR0E3fr
	 M2qUrTroZvLs31Il9ONDjSRK3R0uN/+9uY9oY6hKR7U6RKzVqGnV3AUJaOlzhpTAZxhKg
	 OC351m95gVYE4LEagpJLTUjQ4FmqUL1jxvQcSDjb9b3N6yFMQW+knQKP6Fy5BIcuaiQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b="G69lKP/E";
	arc=none smtp.remote-ip=91.218.175.127
Received: from mta0.migadu.com (out-127.mta0.migadu.com [91.218.175.127])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C947D606A330
	for <kvm@vger.kernel.org>; Tue,  3 Nov 2026 13:45:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C947D606A330
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=G69lKP/E
X-Envelope-To: kvm@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=7JATDHeSysjhrflLAzQ9XRWSKRJGHXy+wbdwm4zZP4o=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1793713512; v=1; x=1794318312;
 b=G69lKP/EZ+LNWB+iaC5oKH2GdBCOw5/Top3VNudCX3t0ZgHD6rlY8R4FBun/Slo08Zn+QDqr
 3WVn15U3mtnMPMuLUnzsMsqjDL5jPmHK4sNKGymeaGlsZpIEjZEOMDQ2Epc3dEOo/GAQJxwtGOX
 GhIevum2eDq+2w2eJQLtQp/M=
X-Envelope-To: kvm@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 29762eed316c4973;
	Tue, 03 Nov 2026 13:45:12 +0000
X-Mizu-Trace-ID: 29762eed316c4973
X-Migadu-Flow: FLOW_OUT
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-5be58ad9600so7349e87.0
        for <kvm@vger.kernel.org>; Tue, 03 Nov 2026 05:45:08 -0800 (PST)
X-Forwarded-Encrypted: i=1; AKwUvBzVUWb6Mw+cdxLcqlVT5zC08BvY6HN/TI4w1xVk9cFoFoq+Iuyk1COyJWi1B3lQ3Cy6MIw=@vger.kernel.org
X-Gm-Message-State: APuU4Z9SSyLsmJwEfBYTOy+01TWsm3rSN0IYtecQiTxP5UMrv9Re7IcS
	CjhSo/TcEkGV4x1iorve3TqeIUFFaFxOBrm+8WeijIqDoeNAIFNZtTDOT0A5+2NmhzUyMjoVZRb
	AeULt3KfhB//t73g/sLH5JzBt21bYcm1hqAvkDTor
X-Received: by 2002:a05:6512:3e06:b0:5bf:a49c:ddde with SMTP id
 2adb3069b0e04-5bff0efce9emr111926e87.10.1793713507212; Tue, 03 Nov 2026
 05:45:07 -0800 (PST)
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261102194454.4086911-1-sascha.bischoff@arm.com> <20261102194454.4086911-5-sascha.bischoff@arm.com>
In-Reply-To: <20261102194454.4086911-5-sascha.bischoff@arm.com>
From: Fuad Tabba <fuad.tabba@linux.dev>
Date: Tue, 3 Nov 2026 13:44:30 +0000
X-Gmail-Original-Message-ID: <CA+EHjTx6RuEs7gP=kUMJEJ-ktC_p0UNxG38rq3P68Xyo8xOMag@mail.gmail.com>
X-Gm-Features: AclHuK_8x91av0-bAi-LcSEBarsfA-5SHr6ALUzPfLF0-91WlZxDuJwLvudbzOc
Message-ID: <CA+EHjTx6RuEs7gP=kUMJEJ-ktC_p0UNxG38rq3P68Xyo8xOMag@mail.gmail.com>
Subject: Re: [PATCH v2 04/16] irqchip/gic-v5: Add ITS MMIO register definitions
To: Sascha Bischoff <sascha.bischoff@arm.com>
Cc: linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev, 
	kvm@vger.kernel.org, maz@kernel.org, oliver.upton@linux.dev, 
	joey.gouly@arm.com, suzuki.poulose@arm.com, yuzenghui@huawei.com, 
	peter.maydell@linaro.org, lpieralisi@kernel.org, timothy.hayes@arm.com
Content-Type: text/plain; charset="UTF-8"

On Mon, 02 Nov 2026 19:44:42 +0000, Sascha Bischoff
<sascha.bischoff@arm.com> wrote:
[...]
> Keeping the ITS register frame definitions together avoids spreading
> register-definition churn across the subsequent KVM ITS emulation
> patches.

nit: the re-tab and the XDMN_EVENTs rename worth a mention here?

Reviewed-by: Fuad Tabba <fuad.tabba@linux.dev>

Thanks!
/fuad
