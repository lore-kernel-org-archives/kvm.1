Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=95.215.58.19
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793713377;
	b=GSfWfvLJPoOdX984nhRVL9aeuwzP2da/JyFkGSGWYd24SK9vhRmWJoWpVeKGYf7q7uCQ
	 0O7qa4Od46SFfxCuy0l8W4Fb5qmkXSfL/SZhisvEGZYTfPL/oq+50XeN5M5vLPLeuVR1R
	 lqPBFFg0OLyJE5tpmEtxXY3uvVcM6OItFLMGr449jfJfeKvlQXvzEHnZREFDDCAGvJsJv
	 LS1MGi83wTtF/GLWZpGMlmdqy/bIxjjG2KewcW1MDszCQQ4lE9KeOaBJS4H7fNj01NVj2
	 vj6ApSehlH0l58hij4CIKwNtvGNIsortmFpDz//eQBFVycrgWxB+KXcs+tjMIM0j3+A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793713377;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:Received:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Received:MIME-Version:References:In-Reply-To:
	 From:Date:X-Gmail-Original-Message-ID:X-Gm-Features:Message-ID:
	 Subject:To:Cc:Content-Type;
	bh=XDGk/1b1zaqZV7qJByvDevo3UbcM8JCHCc2CfWtcNfY=;
	b=Or2vULEvo5IeEBTzJvi06TZWALw6f5a0DofGNqGxkcDJKw/O219DeYGR7wKAcGf1Kjt8
	 sqJ5urdcA0NWnT5TBJxwLsKRXd2s29cJv39GGpjkrlpcGnNwhgbojv3p08EjXLaqkzEzr
	 uvDpCLuksVX2nkpd+xhJyRRKZK23ONRkHGa18MxIziQpoQkvUlNv26g8nEAgs1dS+mOsH
	 16AmVCWbjEnBtvwmIWXj2taSpeW+LCsVz8ImaOTo3u/wV3SRgjU2WxwSm2OJ7C3dyJsCd
	 Hv2LMNDL5b8zWcUNqOYNNP0Ed1j/V9OjMgd413WGxxO7qpqTcx2Ifz5wu4queG2Iz7g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=RKf4Bfn3;
	arc=none smtp.remote-ip=95.215.58.19
Received: from mta1.migadu.com (out-19.mta1.migadu.com [95.215.58.19])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54075606A324
	for <kvm@vger.kernel.org>; Tue,  3 Nov 2026 13:42:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 54075606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=RKf4Bfn3
X-Envelope-To: kvm@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=XDGk/1b1zaqZV7qJByvDevo3UbcM8JCHCc2CfWtcNfY=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1793713374; v=1; x=1794318174;
 b=RKf4Bfn3a5TovjZ3tR0IIvMDKoKKDVZXe2nu89Xx9KwZa3DRajm1MPXBCgjgOQVjRqrcv8HO
 PQqMrT0Pb0zyaDqJjDqI5NE3+BT87/p/OVA588hEmNqgJv3ytfMKT2WcTSKgddF13D7Rzc7Acdk
 4xZdEW2R+lGlZ6WiIXW3Je7k=
X-Envelope-To: kvm@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id cf82971125ed46c9;
	Tue, 03 Nov 2026 13:42:54 +0000
X-Mizu-Trace-ID: cf82971125ed46c9
X-Migadu-Flow: FLOW_OUT
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-5bfca2a2af4so5743e87.1
        for <kvm@vger.kernel.org>; Tue, 03 Nov 2026 05:42:50 -0800 (PST)
X-Forwarded-Encrypted: i=1; AKwUvByDRbKrbYiXkCwbYemGci2I1M1ZMIlxLvsRnmSDY80UzRFN5on3RsydB+P4xtg7zM8fA9o=@vger.kernel.org
X-Gm-Message-State: APuU4Z9JkODoWllIKJKcT0Bj2GiMPVLw+qkvF8Nk8zWnz/AqFo0yn0eJ
	4Y6OH6ry85X+zVT16efo47PXCk//QgPlMlsx8f5G9tsn0Ia0cLW0pUJwHnChiH4OZHdG3B7SQKt
	lyqWp6FXwAy8V5BzoU6jhs+UUqTd1Jsyrr8Pe81EY
X-Received: by 2002:a05:6512:2c94:b0:5bf:d10c:ab94 with SMTP id
 2adb3069b0e04-5bff0551cecmr153064e87.11.1793713369309; Tue, 03 Nov 2026
 05:42:49 -0800 (PST)
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261102194454.4086911-1-sascha.bischoff@arm.com> <20261102194454.4086911-3-sascha.bischoff@arm.com>
In-Reply-To: <20261102194454.4086911-3-sascha.bischoff@arm.com>
From: Fuad Tabba <fuad.tabba@linux.dev>
Date: Tue, 3 Nov 2026 13:42:12 +0000
X-Gmail-Original-Message-ID: <CA+EHjTzqNuuwOp3hXnSZw0rFX1vQAn5HZx9UG=DbiH3VAH=K_g@mail.gmail.com>
X-Gm-Features: AclHuK_Rsw6J4kK5YQayTAqwk7a9tn4wa7atO5obFEHkCeocR8wt7l4zy7C7St8
Message-ID: <CA+EHjTzqNuuwOp3hXnSZw0rFX1vQAn5HZx9UG=DbiH3VAH=K_g@mail.gmail.com>
Subject: Re: [PATCH v2 02/16] KVM: arm64: vgic: Pass opaque device pointer to
 ITS MMIO callbacks
To: Sascha Bischoff <sascha.bischoff@arm.com>
Cc: linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev, 
	kvm@vger.kernel.org, maz@kernel.org, oliver.upton@linux.dev, 
	joey.gouly@arm.com, suzuki.poulose@arm.com, yuzenghui@huawei.com, 
	peter.maydell@linaro.org, lpieralisi@kernel.org, timothy.hayes@arm.com
Content-Type: text/plain; charset="UTF-8"

On Mon, 2 Nov 2026 at 19:45, Sascha Bischoff <sascha.bischoff@arm.com> wrote:
>
> The ITS MMIO callbacks currently take a struct vgic_its pointer,
> which ties them to the GICv3 ITS. GICv5 needs to use the same MMIO
> dispatch path with a different device structure.
>
> Pass an opaque device pointer to the callbacks and cast it in the
> GICv3 handlers. This does not change GICv3 behaviour.
>
> Signed-off-by: Sascha Bischoff <sascha.bischoff@arm.com>

Reviewed-by: Fuad Tabba <fuad.tabba@linux.dev>

Cheers,
/fuad
