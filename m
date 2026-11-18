Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=95.215.58.191
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794999503;
	b=s4z9YXPK3HtAHDTkQZ2YPzZEoodXkfl2Qo+OvUceKw0TbG0QPZ8ATFa/+geysKBBvJs+
	 Y/sImYLj58zSCnFD8VPX2f1zeMpC8H1jZk6JIG7B+8HD9MG/0e7MbwjZ7Oy8V6RuVtZU3
	 SB+60wgm3jG6oNb2Yd26QU1KTVSkO1Rh6EqL2IJxIaS7sdbwQgIL7uiTvkiGY8jEWY6/D
	 ke5LgFEL6cdYFatM4Vwd86IlmGP1BEGDUayRYSwWAvPA8FvfjOIYbvBPc2Pr9k7x0DqP/
	 RYe5YtGn7tc4PrGpDZKj+KcJrRtfY6/AUwTP2yQAvIFbaC2HbuP3O0uZWFn7vf7aLNg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794999503;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:Received:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Received:MIME-Version:References:In-Reply-To:
	 From:Date:X-Gmail-Original-Message-ID:X-Gm-Features:Message-ID:
	 Subject:To:Cc:Content-Type;
	bh=ji0Sy7yk69gklaMPP5Zc2g+qgmHVYq7bGDR02Mw+y7w=;
	b=kZ5UMc3xUct2koePZuSNlRfBLwhINlQIHo8wgEZJ5FlBmAR3M5m/cYG+yWLn7g/emMON
	 rpYpi3SqPDl/6Qgo0paU5Kw1GJYb2CA8vgugA5YkqnKFrihbCuv2L+IEYxyAdeHn2ZQOr
	 qnvWtcu8t2CO5H9Cjk3RJHPAssI+EoUdXHZuwJKezwISSQsL6Ze6QSlw/wljpj5mMJGuk
	 hLPLS1F2G71p5jm+3RwBF+cYKXbCix8tlBEnDLNw+HxFRVZaX4ppEgKRiewNJBP2JA2tR
	 pPMExEER7yBe7G+KcSlQ8gKjn3fsf11jg3A0vcoPxDMUKYwfNdj0GHj4BYUByWN9gIw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=vt+IfZIZ;
	arc=none smtp.remote-ip=95.215.58.191
Received: from mta1.migadu.com (out-191.mta1.migadu.com [95.215.58.191])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C6A1606A31C
	for <kvm@vger.kernel.org>; Wed, 18 Nov 2026 10:58:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8C6A1606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=vt+IfZIZ
X-Envelope-To: kvm@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=ji0Sy7yk69gklaMPP5Zc2g+qgmHVYq7bGDR02Mw+y7w=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1794999500; v=1; x=1795604300;
 b=vt+IfZIZJOS0URSsZzPpdtdsks8eAAoXxtanAnia9tpoLGYih90ndeL65criPFR/mMaeZzbf
 uzD1nRpduIpEsqu6Fxvs3Q1n9Z22EIz+r2sA3w68RgfwEhFr9pVOp1v3bW/3HKMBCT+aNvk+OZG
 lEpOXQMrET0YpQ+nqPVdmU4U=
X-Envelope-To: kvm@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 4d49598557f855cf;
	Wed, 18 Nov 2026 10:58:20 +0000
X-Mizu-Trace-ID: 4d49598557f855cf
X-Migadu-Flow: FLOW_OUT
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-5c14bc5a743so6822e87.0
        for <kvm@vger.kernel.org>; Wed, 18 Nov 2026 02:58:20 -0800 (PST)
X-Forwarded-Encrypted: i=1; AL+hErEecVYWVJdMCJCxDZavQusSx/iolSasSz9gT4d5wFbJdkmMafVswy/ulFekCdEdtSvT8mI=@vger.kernel.org
X-Gm-Message-State: APuU4Z8UYwT4VRMYP/iDnHOScpLkelRAypAHsWf5dnkTxKD4AWuAfBwY
	uO/8GvHpht7yCTBvuTNMLrMhmjZd/DDRAzX2n7GbIBoYoHwEEGDBBaN/XQkqrDr/g6VYrf7CzzO
	8o1C+0voSpsmVgoy2RyYVpZAddShte8amENbi3vrz
X-Received: by 2002:a05:6512:2346:b0:5c1:6e17:16fc with SMTP id
 2adb3069b0e04-5c1a985f78cmr169644e87.2.1794999499497; Wed, 18 Nov 2026
 02:58:19 -0800 (PST)
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261109084854.840576-1-fuad.tabba@linux.dev> <20261109084854.840576-2-fuad.tabba@linux.dev>
 <86bj7n1bzx.wl-maz@kernel.org> <CA+EHjTwJ9XTCfrfBLgGjed3GrRtiTnk-ErvPSwU-AhvyTVcnsw@mail.gmail.com>
 <867bia1kab.wl-maz@kernel.org>
In-Reply-To: <867bia1kab.wl-maz@kernel.org>
From: Fuad Tabba <fuad.tabba@linux.dev>
Date: Wed, 18 Nov 2026 10:57:43 +0000
X-Gmail-Original-Message-ID: <CA+EHjTxMVXR11s5_U5144hdpYStkd1-gi1P2HK6DLnn5D4RW8Q@mail.gmail.com>
X-Gm-Features: AclHuK8nMc23WqG7bzjhLPz1LETcOHXAsv2Kso31Kz9QH-6JXZhmhiORkbvHHMI
Message-ID: <CA+EHjTxMVXR11s5_U5144hdpYStkd1-gi1P2HK6DLnn5D4RW8Q@mail.gmail.com>
Subject: Re: [PATCH v2 01/19] KVM: arm64: Hide generic ptrauth from protected
 VMs without ptrauth
To: Marc Zyngier <maz@kernel.org>
Cc: Oliver Upton <oupton@kernel.org>, Will Deacon <will@kernel.org>, 
	Catalin Marinas <catalin.marinas@arm.com>, Mark Rutland <mark.rutland@arm.com>, 
	Paolo Bonzini <pbonzini@redhat.com>, Sean Christopherson <seanjc@google.com>, Shuah Khan <shuah@kernel.org>, 
	Joey Gouly <joey.gouly@arm.com>, Steffen Eiden <seiden@linux.ibm.com>, 
	Suzuki K Poulose <suzuki.poulose@arm.com>, Zenghui Yu <yuzenghui@huawei.com>, 
	Vincent Donnefort <vdonnefort@google.com>, Quentin Perret <qperret@google.com>, kvmarm@lists.linux.dev, 
	linux-arm-kernel@lists.infradead.org, kvm@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Wed, 18 Nov 2026 at 10:55, Marc Zyngier <maz@kernel.org> wrote:
[...]
> > It's in this one because pkvm_id_regs depends on it. The test checks
> > that GPA and GPI read 0 in a protected VM without ptrauth, and it
> > fails without the fix.
>
> But that's a *test*. Nobody runs tests as a production workload.
> Delaying a fix to satisfy testing makes no sense to me. If someone
> screams that their tests are failing, let them scream, safe in the
> knowledge that you have fixed the problem rather than the symptom.

Ack.

> > Would you prefer that I send it on its own, or with the respin of the
> > features series?
>
> I'll cherry-pick it directly.

Thanks Marc,
/fuad
