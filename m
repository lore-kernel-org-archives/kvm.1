Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=95.215.58.177
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795513466;
	b=MFSUf3KdsAxxlSgYWug6y73KuNMPowQIbKPkac7OIyMaSgyO01XIPo3u+Iy44SoggxIE
	 vpAdKvYE0tQRglob1Io0wh9n1ItstGUYafXLLqLvj4op3pUWAE3djonHGTqlCQtuTZ/D+
	 1ymHY9iimhmGr49xGYw3OK6zqIekCy/P7Z9BItm8Dx3YxYX4QzhfuisNCtCeXsKEZ0HvL
	 ZDFDVuOyNRMxWV6X8koK4JLZeMHXUWXUcAI2ej9/sBq0lum8YHUbmJeXUIYfOz37IUZnc
	 c5EBPTS6vCH55Aod2aqgu/o2rPReRG0UA5a9P9xzRKQRx3+Div1V25ebC1HGPXB4qzA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795513466;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:Received:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Received:MIME-Version:References:In-Reply-To:
	 From:Date:X-Gmail-Original-Message-ID:X-Gm-Features:Message-ID:
	 Subject:To:Cc:Content-Type;
	bh=t2pMZHTPWQHTXaMIuwvZv4SwKto2BO2qab0ldpAoWoc=;
	b=v/KclxOheGwLYD62YnEuemVAwofy07B7D4dft9dp638HVzNgxfY6eYIW9T4rfjijJ2l3
	 lqFRP3NpVGnDkp/ibeVryz06VKI3zvfHosTLsNEH/EFem+i7WaOSAK5uezjXd6pWw7Z0y
	 B8wBusWs1r1FrTKRibCQiT9JOsksrf+IWzQhVXML4TL/Q2GvZ4hrW1F85IxBOnLdMFngt
	 9PkuXgOVCntvbqYFkmdx+9izlojgVYQpAbNAPzZFUm4WRpfWn2hJgJbgJqhBp061Ou7lY
	 zfmw1oFOPsPzBCwQeg0lOVLiZ84a5mvXbnos94qaim2hGqti4JsAQlAEHqsQO2BCUaA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=tcc81SHn;
	arc=none smtp.remote-ip=95.215.58.177
Received: from mta1.migadu.com (out-177.mta1.migadu.com [95.215.58.177])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45560606A6A2
	for <kvm@vger.kernel.org>; Tue, 24 Nov 2026 09:44:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 45560606A6A2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=tcc81SHn
X-Envelope-To: kvm@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=t2pMZHTPWQHTXaMIuwvZv4SwKto2BO2qab0ldpAoWoc=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1795513462; v=1; x=1796118262;
 b=tcc81SHngnUZu2BwMqJZpcOvHE0fcrLU6Rr1jcxJnosGkwmCvSOG7FCgVVvsJvkAWYMywRuI
 c8WS2OM2T4u3gQ0tZmFfU50BhZTbSlS3wFuMqbipu+RwgajemwGmnOpOBHSmIyZsWvlOUl+M21m
 PUbH7VDpidN4tq/qv4HFXFn8=
X-Envelope-To: kvm@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 5ca4befc85038237;
	Tue, 24 Nov 2026 09:44:22 +0000
X-Mizu-Trace-ID: 5ca4befc85038237
X-Migadu-Flow: FLOW_OUT
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-5c00d7ac49dso16230e87.1
        for <kvm@vger.kernel.org>; Tue, 24 Nov 2026 01:44:22 -0800 (PST)
X-Forwarded-Encrypted: i=1; AL+hErHxk5GsnrLHumu/TBPoPd8S4nESvbYgExXVhHkRydeEF1mFXMwcKeKeb7/D35Dstp44X2c=@vger.kernel.org
X-Gm-Message-State: APuU4Z+N2ekoMRIUoOEKtUuhzM/ZLQNYVAH+dfc1cSxttCB7XL+Rgk5O
	TJuxl+Igs6g42z5y1qgulEDrac6GoUAs97HgZUWHFFBvfHtYHi63gPJioSCmpXmxbRX6EIrF65E
	aK6YxLs5ufHvp6qVMp5NUiFonXjaWiDjCcq869jAS
X-Received: by 2002:a05:6512:1282:b0:5c1:a880:e5b9 with SMTP id
 2adb3069b0e04-5c1fbb1e9acmr387548e87.7.1795513461120; Tue, 24 Nov 2026
 01:44:21 -0800 (PST)
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261123192457.8700-1-maz@kernel.org>
In-Reply-To: <20261123192457.8700-1-maz@kernel.org>
From: Fuad Tabba <fuad.tabba@linux.dev>
Date: Tue, 24 Nov 2026 09:44:00 +0000
X-Gmail-Original-Message-ID: <CA+EHjTyton41ATTfGNDdF7KU0_9xvGuPx_EP=TeA7n8cMuA-2g@mail.gmail.com>
X-Gm-Features: Aa3M54pK544jqTysiDZQ3nSJIC4yYFvop17y-HAYPW-8_pI4HirsHCc0nJyGc48
Message-ID: <CA+EHjTyton41ATTfGNDdF7KU0_9xvGuPx_EP=TeA7n8cMuA-2g@mail.gmail.com>
Subject: Re: [PATCH 0/3] KVM: arm64: Convert GIC idreg sanitisation to the
 confic framework
To: Marc Zyngier <maz@kernel.org>
Cc: kvmarm@lists.linux.dev, kvm@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, Steffen Eiden <seiden@linux.ibm.com>, 
	Joey Gouly <joey.gouly@arm.com>, Suzuki K Poulose <suzuki.poulose@arm.com>, 
	Oliver Upton <oupton@kernel.org>, Zenghui Yu <yuzenghui@huawei.com>
Content-Type: text/plain; charset="UTF-8"

Hi Marc,

On Mon, 23 Nov 2026 19:24:54 +0000, Marc Zyngier <maz@kernel.org> wrote:
> Having started adding some sanitisation code in the idreg department
> with ID_AA64MMFR3_EL1.S1P[IO]E, I'm back with some more and trying to
> wrestle the GIC into submission...
[...]

Tested on QEMU, booting protected and non-protected guests on pKVM,
nVHE and VHE hosts, and running the set_id_regs, vgic_init and no-vgic
selftests on the nVHE and VHE hosts. Also ran the vgic_v5 selftest on
FVP, with and without GCIE_LEGACY.

Tested-by: Fuad Tabba <fuad.tabba@linux.dev>

Cheers,
/fuad
