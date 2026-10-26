Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=95.215.58.100
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793002903;
	b=IOXteFxe34ZzZGbZq7WgQhONEJAKDl90eMQDHPo/C6KA7H3IozSWPxmpIfvqZ/7hBKdG
	 dQ2Vp0hoSJIJUNGbjZJg/CfbSYpV11ONhUXc87+2MNIKeuMKaCaDEwK6ejP20px5fKsZv
	 Ljlzip2zsxoC3f2C3q4uii8Oro5dKSpA2muiJoe2skDzhyXpn7vOVG1E89igq0WqUgp/a
	 Bp23WpIC8ECTqMTigo1za2pSNFFsaJOydwSZ8cFsWJNRrWVXTjibCywLPdb60pZ6+WVqp
	 nC5d3bi1SnwsFnNZS33klcSirUUEuWUvQrh7nBT9DraoTAptfApweIHIRtm1ErNX8Vg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793002903;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:Received:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Received:MIME-Version:References:In-Reply-To:
	 From:Date:X-Gmail-Original-Message-ID:X-Gm-Features:Message-ID:
	 Subject:To:Cc:Content-Type;
	bh=HeN8sKTlUL/VwaqkACE76c/cgf/RcKGyONBxScYlrEc=;
	b=csmRF+cb2NVDIVEXUu7VOi60QOb1ybHUh+uCkVTqw9cwPEU5Ibio56HDaoOnCGXwhuBH
	 SmXtu9fchO6iciFjtotzkgu8s9XpONJdXZQJfcLj7mm03oLvJUcfOQYrCfho3TskgAX3J
	 VAgGfZEScbojw3DHx9irAehLE8yCcv/gbloIDi6QhgpF+j3kvAvihPAVQ4t9D4bMZnBdo
	 bsL7wZHvV3YU6lxHbip+lonN58Ue98Y9Nkp8D/O52fOC7wo+vT0Wd34h+F/D6V7U1zMrF
	 kaZvy5vZS4WM9B9ttx8CfIuZTTh1nszZS62LGl4RwgEBd4l3WByuHELs4hIIYvqbMjQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=q6Aw1b8e;
	arc=none smtp.remote-ip=95.215.58.100
Received: from mta1.migadu.com (out-100.mta1.migadu.com [95.215.58.100])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F5E4606A31E
	for <kvm@vger.kernel.org>; Mon, 26 Oct 2026 08:21:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2F5E4606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=q6Aw1b8e
X-Envelope-To: kvm@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=HeN8sKTlUL/VwaqkACE76c/cgf/RcKGyONBxScYlrEc=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1793002900; v=1; x=1793607700;
 b=q6Aw1b8efW++iuQUWre8az/96BUp5KZwbzMtYVxMEyW9rXKqHTmpAzkaDHqSZcdMP9ZdnVo0
 CTfDq/xXJzBmxhcOHj9qc3HMk50c4m6jP1Ds0maOj1yqsz2nTCCUIrnMkis28OKrK6R+40/iQ0R
 4RsPNCDXl5j4/et/j7cGzsac=
X-Envelope-To: kvm@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 40465b0bc632989d;
	Mon, 26 Oct 2026 08:21:40 +0000
X-Mizu-Trace-ID: 40465b0bc632989d
X-Migadu-Flow: FLOW_OUT
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-5bcbb378fc9so8607e87.0
        for <kvm@vger.kernel.org>; Mon, 26 Oct 2026 01:21:39 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvBxPwY5sQ03RsV7azcfH9zbEbg9ZNYtz4xKWTvjeDBpFDRwjg8ZgEOFeFoIBsrWkidoHf3A=@vger.kernel.org
X-Gm-Message-State: AFq9FYLSZQReWoyKgVGq8k7LNJ5J+nniHjZZ4i/8jVqXn6dtEQ5ibwTa
	DKQbPmCrhDJiBbkyIt2ZfnkpELPQNAKykQD1ZL+e+NK7QvRkDLZNA0SczPKfQe2AbqhU+UILdkD
	0Sdo388u/EqREBf/5zbEjeJj5mHDq/YWqFzwhklBB
X-Received: by 2002:a05:6512:3091:b0:5be:4d73:e44d with SMTP id
 2adb3069b0e04-5bfb79db1f6mr139727e87.5.1793002898251; Mon, 26 Oct 2026
 01:21:38 -0700 (PDT)
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261026-b4-vncr-mapping-test-v3-1-7c094a00d46e@fujitsu.com>
In-Reply-To: <20261026-b4-vncr-mapping-test-v3-1-7c094a00d46e@fujitsu.com>
From: Fuad Tabba <fuad.tabba@linux.dev>
Date: Mon, 26 Oct 2026 08:21:02 +0000
X-Gmail-Original-Message-ID: <CA+EHjTy=bU1ygvgYiwKiWpxP4XTY_QEmkMgW=Bxd1pxyFZ0qdA@mail.gmail.com>
X-Gm-Features: AclHuK9mNQcdy23LyjVrKUw6ZiFaEhEa1RjPtCWEqLpOPj2wxuYrSqZs8yklhYY
Message-ID: <CA+EHjTy=bU1ygvgYiwKiWpxP4XTY_QEmkMgW=Bxd1pxyFZ0qdA@mail.gmail.com>
Subject: Re: [PATCH v3] KVM: arm64: selftests: Test VNCR translation invalidation
To: Itaru Kitayama <itaru.kitayama@fujitsu.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Sean Christopherson <seanjc@google.com>, 
	Shuah Khan <shuah@kernel.org>, Marc Zyngier <maz@kernel.org>, Oliver Upton <oupton@kernel.org>, 
	Joey Gouly <joey.gouly@arm.com>, Steffen Eiden <seiden@linux.ibm.com>, 
	Suzuki K Poulose <suzuki.poulose@arm.com>, Zenghui Yu <yuzenghui@huawei.com>, 
	linux-kernel@vger.kernel.org, kvm@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	kvmarm@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

Hi Itaru,

On Mon, 26 Oct 2026 03:10:10 +0000, Itaru Kitayama
<itaru.kitayama@fujitsu.com> wrote:
[...]

These are from v2, and I didn't retest v3 since it only makes the
changes I asked for. In cases like this, feel free to keep my tags on
the respin.

Tested-by: Fuad Tabba <fuad.tabba@linux.dev>
Reviewed-by: Fuad Tabba <fuad.tabba@linux.dev>

Cheers,
/fuad
