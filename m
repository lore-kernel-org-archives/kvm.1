Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=91.218.175.251
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793346199;
	b=rE+som2w6VPlLl0XiBTLaafKKT2FWgBDCeAXCeGIVm4kw8Ac7oMnzpVwdcvKP8ZrSvDe
	 IPViDwWaiSQBdKG6fWgReMgaRAw8yuByYh7Aa07DeA1AXg1Q8tcObw8Ahf743w6Opwd/b
	 qBUYgG54O1a9AWk58wFIntaPDAup632fzFTNAwDlNfv/U4qa5OrPpwYqZJp87WZ70uVZ5
	 rIq3yYqDKmFI9eAge0uSROV/DmUWwAuOB696jNnmTpOfsGnWbIPKlUPOzntazdWY87Sg7
	 e9d87kv781fUYpLyCNW6XXQh8ysjwMcb/vlu5tDGFoE+GN56lFOQj1yoGE/tOvG0GqA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793346199;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:Received:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Received:MIME-Version:References:In-Reply-To:
	 From:Date:X-Gmail-Original-Message-ID:X-Gm-Features:Message-ID:
	 Subject:To:Cc:Content-Type;
	bh=Ic/DznHWY6qYKyiKcZAzEYcjT1Csqaqbv7FtlV+91D8=;
	b=M7CtQ8eNpUJOtdNi16DF7jwC1fMJwLXsHkmsHViCgw+5bk0jv7RLoGRMUlK93mP0Fhid
	 o89kf0rLak+UO5eud4bpUFMVsPFHtdmQUxW5lWZO85dXcwYKyMXxuB/k5s9Gvz2dRRNfY
	 etOL50E/j8WA15Yt5sCPUUetCF/cWyzT0gfHMURUHuii4QGv7iPDYJfPC3Kc0e+KgMj1D
	 1HSfyco4po1hCiRBI5oBZhPaeD5gV1NO/TDvdOeSngfJiCaVgqC+8WADGoJlbtxIU315O
	 QBvt41A/6w20IeQ2Jnnvu6xWV+8dlWMEeH6tH+kmYNXEOTKU9mUIH3/YuEqozP/IFag==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=UJD397DA;
	arc=none smtp.remote-ip=91.218.175.251
Received: from mta0.migadu.com (out-251.mta0.migadu.com [91.218.175.251])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78D85606A31C
	for <kvm@vger.kernel.org>; Fri, 30 Oct 2026 07:43:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 78D85606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=UJD397DA
X-Envelope-To: kvm@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=Ic/DznHWY6qYKyiKcZAzEYcjT1Csqaqbv7FtlV+91D8=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1793346194; v=1; x=1793950994;
 b=UJD397DAGzB7WG2IBio8AWzpHInDQct6iq5idWJfbz3lhm171lKD9mwTupI3MgBLVVtH/f2q
 mmRBVllq4jeJ1WfeVFs0JmhTJtXpclcGzejsJYxoXVmVwVHuASqgKYTjFtl8igzf6KoGZyAfe9u
 kBeFQtwDeCKk3ryoLmfLJ/5A=
X-Envelope-To: kvm@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id de4240e212a954a3;
	Fri, 30 Oct 2026 07:43:14 +0000
X-Mizu-Trace-ID: de4240e212a954a3
X-Migadu-Flow: FLOW_OUT
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-5bfca2a2af4so3858e87.1
        for <kvm@vger.kernel.org>; Fri, 30 Oct 2026 00:43:10 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvByHZd4cRCWvksoPpOkNx/pLtIUyGFFyeGfU5f6eCekQlHAfKYvoBWp7tttmQSC5BTr60jM=@vger.kernel.org
X-Gm-Message-State: AFq9FYLKZ7ZSOViwx8CP22RhlePBONdzpfTAQFYRuopKUKjvClP52+56
	31U5ymkDf4fjcmHcQWWGgR/Dj+QgaWI5b1veGG7OW+6gFu4uu8uDjN8Fjm69T4RdibrvlFmXGz/
	wIV3VbtZTgHpKYsG2XtOHjc9aSrxbSflMETz6X0DL
X-Received: by 2002:a05:6512:39ce:b0:5bf:dcd7:86d9 with SMTP id
 2adb3069b0e04-5bfdcd78993mr28332e87.16.1793346189429; Fri, 30 Oct 2026
 00:43:09 -0700 (PDT)
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261025075138.2919734-1-fuad.tabba@linux.dev>
 <20261025075138.2919734-2-fuad.tabba@linux.dev> <auO3Kiykovvs279e@arm.com>
In-Reply-To: <auO3Kiykovvs279e@arm.com>
From: Fuad Tabba <fuad.tabba@linux.dev>
Date: Fri, 30 Oct 2026 07:42:33 +0000
X-Gmail-Original-Message-ID: <CA+EHjTzvCAStFp4TOBJZ2dEi9GT_S0CW0i7HzB4Q_+qLbv5Uew@mail.gmail.com>
X-Gm-Features: AclHuK-iAV_pLdWc4hp6CdmUshGwwfxe2S4f_ErlrqMD7iHGLjhkPDfxfT1tlNg
Message-ID: <CA+EHjTzvCAStFp4TOBJZ2dEi9GT_S0CW0i7HzB4Q_+qLbv5Uew@mail.gmail.com>
Subject: Re: [PATCH v2 1/5] arm64: Add override for ID_AA64ISAR1_EL1.LS64
To: Catalin Marinas <catalin.marinas@arm.com>
Cc: Marc Zyngier <maz@kernel.org>, Oliver Upton <oupton@kernel.org>, kvmarm@lists.linux.dev, 
	linux-arm-kernel@lists.infradead.org, Will Deacon <will@kernel.org>, 
	Joey Gouly <joey.gouly@arm.com>, Suzuki K Poulose <suzuki.poulose@arm.com>, 
	Zenghui Yu <yuzenghui@huawei.com>, Steffen Eiden <seiden@linux.ibm.com>, 
	Mark Rutland <mark.rutland@arm.com>, Yicong Yang <yangyicong@hisilicon.com>, 
	Zhou Wang <wangzhou1@hisilicon.com>, Arnd Bergmann <arnd@arndb.de>, kvm@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Catalin,

On Thu, 29 Oct 2026 21:14:18 +0000, Catalin Marinas
<catalin.marinas@arm.com> wrote:
[...]
> However, does this need a plain cc stable? I assume you want it to go in
> with patch 3 but that one only goes as far as 7.0. Same cc stable in
> patch 2 which you may want to limit (or add both as dependencies to the
> cc stable in patch 3 when committing).

No, it doesn't. Patches 1, 2 and 5 are only there for patches 3 and 4,
so none of them need to go further back than 7.0.

Marc, Oliver, could the tag on all five patches become "Cc:
stable@vger.kernel.org # 7.0.x" when you apply them? I'll respin if
that's easier.

Thanks!
/fuad
