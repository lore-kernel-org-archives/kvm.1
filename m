Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.128.175
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792759066;
	b=4Mx0zejuehKa3MsCJKuA/T9uczm3EkzfDvra/U0HikuNvX/NQ0DerWymOc+AjyHlX0/E
	 4cXh02Z1p/4buMiM4+DHKk4LfpoMdq8DtQXbME9yvzLW2q/BiOleZYPPNvpQz2mtNYQQf
	 0JJED3JZAYrXQC/O7pI8QHWrv+OQS6N2/seZWaTrp3MjKYJ5+mDOJCl79+6kXlErZOmNw
	 XOeAhpvD1E6eoVoqp7E/5o3ZlgYXYBSDoYiCxztlbMZk7B10YTGrPeA2DKh8w9K9L2nlJ
	 xGHFoTTAXTPQw+rroOvcLqiQJJG1QY3YuN85oN/ZSiwqErwtz0N18PkOkbB2p5K0SkA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792759066;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type;
	bh=SUkoX/3bwjFpT0dyc8UcMdZ4lcBpeSlTtzlkyvLE7Jo=;
	b=ZUchPj1TuZBExnGnjVLJdyWmHdlv4bQoMBNXUdxsMtTLqMX/Y0r7Odo9HQsBbLYg1284
	 pyK3ycXFC1AbVqQos3AIE0sitprPAaXKHYImIdLllm2/MK0qwW2WkVNk2htj8URjSd1VC
	 kdOdXUqWFgOvdYlZe4MFjFDFQKIM6olwRbfJIjh3zcm74y9SKnbpsORNCZnSLzmtUun7A
	 Vs2s/lHtrKUo1OX22Qr3TizFcC8GAoCTOrLXuqNiRhmigMOp9S2sja3wP3uO5+PcA/SXk
	 FK8ABz1L7aiqArs2zAOs8skMNeOUv7cM/Yf3blMTSvinXAqQqW45V2G7Z36HrFf5FbQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linaro.org;
	spf=pass smtp.mailfrom=linaro.org;
	dkim=pass header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=btiCmEJH;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.128.175
Received: from mail-yw1-f175.google.com (mail-yw1-f175.google.com [209.85.128.175])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA320606A320
	for <kvm@vger.kernel.org>; Fri, 23 Oct 2026 12:37:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CA320606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=btiCmEJH
Received: by mail-yw1-f175.google.com with SMTP id 00721157ae682-8ab37e44643so5816427b3.0
        for <kvm@vger.kernel.org>; Fri, 23 Oct 2026 05:37:45 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792759065; cv=none;
        d=google.com; s=arc-20260327;
        b=B5bmB7OJYML/o5otNBelvyBVi7Zfn5t2i2LDiU+0+CgZSxBXfzLgla0y70JwTtWoy7
         gCrJVlQ5pBVRAnGKUBYe8cnjFt/SbS/MCzxB6H/TqeifYGgl5CETLZsap5Hiy6aEsHDT
         RC4QBlNXTqllRcu+csB0tc3ZsiBIDg3ZW2p9Mds7XD+juZSgypOqPPezcGxGz9XvV3ML
         U1PDpG0AQR3RcrORFhr762ZGdGnjqs9WsmacehhCSJICK2LHEkmyv5uqZJfPP5sihbTX
         zGf1ObgoZtfpsbBnv6gQ5HCw5qI09/nOQy1OZEn1w6jrI0mIewERBlje2Jsi9DLU/qAw
         6l2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=SUkoX/3bwjFpT0dyc8UcMdZ4lcBpeSlTtzlkyvLE7Jo=;
        fh=KSh07ZqORoKnvUtgoQC7+D4YocMuAq4bywMWhPL34VE=;
        b=PfC7ikvpfmrDnOHikhLf4lzl62F3DN8owlpWViD7JRp1QvzPs4QstxT9U6XXlCQDXi
         PNnzRbWsYyg30ov0nU8uQsukQszIrdNAL5oHXdPGSLI/RelOUxO1cUEVGYl2z8ySk8aZ
         cTnFdMY6ywtkJlA/PweA+erOKLJOLJ9W2hNCQqHfr0jteClSF+kCbj/rwLArmbuY0fB2
         rHUtFc+Kskc/CJT8/aefDZ49DXGLVMZmJ0mvji9paWJBbNXWYkJy4eOzdFt1w03cEa8H
         u6BgcA8Y3GsuHtuM4/ECXG+8noO0BG9EBsu8RR4tz1Ec9+qdeSZAx26nMa4xWpz67rB9
         wGjQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1792759065; x=1793363865; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=SUkoX/3bwjFpT0dyc8UcMdZ4lcBpeSlTtzlkyvLE7Jo=;
        b=btiCmEJHnnSl54m+ixp7ckRRV6ZDXw/zxrvPejbVZhvc8jFCCv5cMTQKuI8bOY/ZTe
         mgyrJGsEvUYCWQdf8WLaL3CNaQvU2Oo3N8A0/Q3GMEEs/9ziHJC8ySxIOtU/D7o8CHbB
         W6iOzk2XM6eqWd4OMt3Brwmit0TKgBN4838mF7he1r2Tp/O2XHN0qRy+UjWr8MSqlyKa
         n1x2+NOPUso3l7weDDi/aiZybSmOu69UgWJDufF7OF+cluSmYFvgAYCzFmCZVyaKiP2n
         vO5TSxfJpVhKGstJ297OSQeApn8Q0CRNnIe1MOA3GiAXPlyKHfJ+TD4JJitrjV9xa/Pw
         Zaew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792759065; x=1793363865;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=SUkoX/3bwjFpT0dyc8UcMdZ4lcBpeSlTtzlkyvLE7Jo=;
        b=ZI9MGUyuPJ2KR5FKyREy4E4oE2ZkD99WOzLbLX4QDSLeUm/0402EYbyvSlapiDKCbz
         HKh9koNQQxBIblxluYNplLqfFjTI8dxS7ngkZcObhoqlnGVwmOqOGvXihtTwWM5v6Yj1
         mGenBXlYHetOA3a5q9/v5vrTb2awhdiHBtg0I0R0mrxoaFzNVgHuD+zvBce05f8mV1zb
         v3qXCOcfKp+MtzcV3dACJbLuTddTF+RzvuLYjMURuyF1dxlw7HwHgSU6YzSHJi5PyRDv
         oD77qIuBRmRMLnnNhQxAwMqGAVijw75lFaIJbV4e8uQTxP8Hf0RH/IrRmE+KL6imMkN5
         m39A==
X-Forwarded-Encrypted: i=1; AKwUvBzAqo9GHwyiNZ9PhMMCnrMiLGfZhgHucqLljAUb9kk9otmpFh54Z61slTxp/G7bAh+YUAM=@vger.kernel.org
X-Gm-Message-State: AFq9FYKgycz9YzE3JeBLxnsSz09voi934+GdUbijaNBGCmuafTLAJbYz
	GB0QLTWTtRPr4w11hEuvwcJvl5MrJj5MRL5inZiwtgMtz0JP5FGfKUZdctydU0MeM06LmXTEtE+
	OHK5fwk0ILPkVmxxAdgWekAb56TkdyWhRdS/KdAVA2w==
X-Gm-Gg: AYBFou1lUDVCBRW4c+cYRqy9hk9tqCyekWE1ka3hfEO9kMLGDVIHORvvBEk5iYGvOz0
	SNIiytnsoisM6cwDtHsDRO4VJADrH3dAVcUONU7THj22Qg2ZAz25yOQZtjxb01Gj0WNxW6e2pRv
	yrFDYcdVWoYey5P5OZDuJkR1AzfXStph1Q5N6RWsERi7G4DziAAZCtqWvlYIGxaUdy6us+pz0vS
	x1eIbAU/Lcgd5YyRNn4DrhDzkCJnjt5OcSpQFibpICP0Vcq645g664vRpRS9549s9NdgpZAa5oU
	//lAPxn+R+arHo7pBSMPL4VeyYDu212Mpsj/rmDofFDvPDEofBvZzGAZ+bvXVyr3iqtlryqHxYk
	S7/n2utZaC8et0DAEDQH4HwuHUWyxU2RML/p0DGGuYauPiR76cMz+wlP0XdTh6LUdykaMUGlcM+
	Uv4mPHDsu4MSPuJ8FnjGSPkw==
X-Received: by 2002:a05:690c:550c:10b0:8b1:3606:65f6 with SMTP id
 00721157ae682-8b157d96b4cmr11350167b3.64.1792759064577; Fri, 23 Oct 2026
 05:37:44 -0700 (PDT)
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <cover.1792728982.git.deepagupta@nvidia.com> <529fc7538b61d0d2ea9a984087ff1d616dd65624.1792728982.git.deepagupta@nvidia.com>
In-Reply-To: <529fc7538b61d0d2ea9a984087ff1d616dd65624.1792728982.git.deepagupta@nvidia.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 23 Oct 2026 13:37:32 +0100
X-Gm-Features: AclHuK9ojQv69OAZTrmG7kBHeUcigZauSSNPGVhBPnbTfN_tKVHRQ_dcXo19pmw
Message-ID: <CAFEAcA8tV-Qc_GHxyCwaU-c0h5n5hcTCU07k0bvGiT8ePFu4FA@mail.gmail.com>
Subject: Re: [PATCH v2 1/1] target/arm/kvm: handle KVM_EXIT_ARM_SEA and report BUS_MCEERR_AO
To: Deepak Gupta <deepagupta@nvidia.com>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org, kvm@vger.kernel.org, 
	kvmarm@lists.linux.dev, pbonzini@redhat.com, mchehab+huawei@kernel.org, 
	jiaqiyan@google.com, oliver.upton@linux.dev
Content-Type: text/plain; charset="UTF-8"

On Fri, 23 Oct 2026 at 06:22, Deepak Gupta <deepagupta@nvidia.com> wrote:
>
> Linux 6.19 added KVM_CAP_ARM_SEA_TO_USER: a guest synchronous external
> abort (SEA) that the host cannot attribute to a firmware-first (APEI)
> error record is returned to userspace as KVM_EXIT_ARM_SEA instead of
> being injected as a virtual SError. Linux guests treat that SError as
> fatal, so on a host whose HEST has no SEA-notified GHES source every
> guest-consumed memory error currently panics the guest.

So we already have a mechanism for the kernel to tell us about
memory errors -- the BUS_MCEERR_AR SIGBUS code path. Why do
we need to have a second mechanism that needs more code in QEMU
to wire up to have the same effect? Can't the kernel tell us
about memory errors in just one way?

-- PMM
