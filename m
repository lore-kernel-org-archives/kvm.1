Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=95.215.58.133
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795521817;
	b=cUDyVP1p5bDqk7KE5Ss/o2dxdBUsZVFALPzgwR5cERrwsEc03b/KBdaDM/Pm4H/Ie6w/
	 uiSlxUjnhu4JKofhOdNH4lC9yIQzZS0w8j3F0HKckxDajC6ee2SAA6Ekfkh20qrfRnAa4
	 vdFAVvUTyYG87YBI1GSxn3K9N9SLVpH78hTNwmNal6VwO3SXaGJOEV3t/19t8Ylhg+kLu
	 Fg7AJt1u5GsoPnBgWUPNCKhGdATMPqxoBMfNPRZ57jxZZGrZmpk67AkPRh6DzR/LJzTaV
	 wEXuahC2ei6Htr+pNFSWZ0mrzfXDNoBN833V8OToZomXdFTJieYkmhFfwD45RvWDuOQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795521817;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:Received:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Received:MIME-Version:References:In-Reply-To:
	 From:Date:X-Gmail-Original-Message-ID:X-Gm-Features:Message-ID:
	 Subject:To:Cc:Content-Type;
	bh=sr8kNtZUVcrLtCrf+RT8Hi9gA3/tGSBNUGobytTqIAA=;
	b=SbA8oGu4GH9T6sUnIfvUjcM6De0gAFJ20v1AOO2ITaA2EUmrzB61xCN5tivDUntbbIlf
	 4YnxY3huaiNkwyokB0ZsGF/YpWPw6zVHfM9psFowL0SHvyWyO5eSlx2jJ2iVY3P3qWUM3
	 pBWT2caL1YPexJtt0OfOpLhBHboHCSFi9LBd68nf4/Yyj9y3YmfJ531uDviyzsQSSBtLf
	 cHrIRw9sSwZxzcZplWDqCuFxkIiPxM40YwPd0TgJ+L7BpmY0FyLw+XwBfaGSTfpzb72q8
	 wqWzaPaBXCtG99gRFJ6A0ja11eGJW1x2B8KWoP03CNPW0prEmNqod8H7rjvuWoI2LnQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=uirWn9No;
	arc=none smtp.remote-ip=95.215.58.133
Received: from mta1.migadu.com (out-133.mta1.migadu.com [95.215.58.133])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DA4F606A321
	for <kvm@vger.kernel.org>; Tue, 24 Nov 2026 12:03:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3DA4F606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=uirWn9No
X-Envelope-To: kvm@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=sq+1U9QBpgUl6gibIVwLvQO1miis3EZ+uRylCpz45Xo=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1795521814; v=1; x=1796126614;
 b=uirWn9NoEnOAGA1QLmhh6dTHi2v2AHIaOs+2kXHIz2N7rAVPplSsN0iZzCh86DSUnHvwCvtx
 GPnZ1o5blQZheFcSII6SWzio4UeyBm3MYx0a74jJNq63ViidFf9YJpI8y469b03pnVLbywnLPHC
 bifBMoiPmc5b0leJKYBO5UT0=
X-Envelope-To: kvm@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 75a0bf2bf8f8c286;
	Tue, 24 Nov 2026 12:03:34 +0000
X-Mizu-Trace-ID: 75a0bf2bf8f8c286
X-Migadu-Flow: FLOW_OUT
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-5be58ad9600so22969e87.0
        for <kvm@vger.kernel.org>; Tue, 24 Nov 2026 04:03:33 -0800 (PST)
X-Forwarded-Encrypted: i=1; AL+hErFbsiEs7VES3ts2iqnaW5A2KKLclOLmVFyIEKQS2OfVR5EUFqbEnbo5tYl2cl1Mb29iFqg=@vger.kernel.org
X-Gm-Message-State: APuU4Z+qBGNmA5gLdDuxPC+PpzbHzCi/b+7g3nNyowZyZOibCUbl8368
	DramrVgLBrZtLTlY9uKvJQLUi2J5AadLHmE4bdi6OpMGAuBztH5xcEPqZsjKLb6fjhUNwi7PG/g
	3u1L2YEx35dHVMZC2qnKScc0vPsgGYzQgh/UdiRlu
X-Received: by 2002:a05:6512:3d1d:b0:5bf:f0fb:2c9c with SMTP id
 2adb3069b0e04-5c1c8256cebmr422660e87.5.1795521812773; Tue, 24 Nov 2026
 04:03:32 -0800 (PST)
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261123192457.8700-1-maz@kernel.org> <20261123192457.8700-4-maz@kernel.org>
 <CA+EHjTynhBzhjrFzd514Sycib=1rmh7JqYp0xSPVBvurk6Sm-A@mail.gmail.com> <86a4myzeos.wl-maz@kernel.org>
In-Reply-To: <86a4myzeos.wl-maz@kernel.org>
From: Fuad Tabba <fuad.tabba@linux.dev>
Date: Tue, 24 Nov 2026 12:02:56 +0000
X-Gmail-Original-Message-ID: <CA+EHjTyOzMofQ-7exH65h1G0jCtNy=f9MsW2ORSpLpF4J8xZ5w@mail.gmail.com>
X-Gm-Features: Aa3M54o_qgTofyawRoobP2Y_UigNAYnryN0_2l63uok4neYEvOqeAAfM8d_tF7s
Message-ID: <CA+EHjTyOzMofQ-7exH65h1G0jCtNy=f9MsW2ORSpLpF4J8xZ5w@mail.gmail.com>
Subject: Re: [PATCH 3/3] KVM: arm64: Drop open-coded GIC idreg sanitisation
To: Marc Zyngier <maz@kernel.org>
Cc: kvmarm@lists.linux.dev, kvm@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, Steffen Eiden <seiden@linux.ibm.com>, 
	Joey Gouly <joey.gouly@arm.com>, Suzuki K Poulose <suzuki.poulose@arm.com>, 
	Oliver Upton <oupton@kernel.org>, Zenghui Yu <yuzenghui@huawei.com>
Content-Type: text/plain; charset="UTF-8"

Hi Marc,

On Tue, 24 Nov 2026 10:50:11 +0000, Marc Zyngier <maz@kernel.org> wrote:
[...]
> However, I want to know whether this change is an acceptable behaviour
> or not *from an ABI perspective*. We have several options:
>
> (1) delay all idreg enforcement to the same (late) point
>
> (2) keep things as currently done, meaning that the GIC fields are
>     special and sanitised at a different time
>
> (3) say that idregs can change at any point if you change the
>     configuration of the system, such as creating a GIC
>
> I'd be tempted to go with either (1) or (3). (2) feels like a total
> bodge.

(3) works. The GIC fields can already change when userspace creates
the vGIC. The final ID_AA64MMFR3_EL1 only depends on the order if
userspace sets S1PIE or S1POE without the features they imply, creates
the vGIC, then sets those features.

(1) changes one thing afaict. A VMM that saves the ID registers
between creating the vGIC and the first run, and writes them back once
the VM has run, would get -EBUSY where the vGIC's GIC fields differ
from their reset value. QEMU and crosvm copy the registers as a block,
but I don't know if either ever does that.

Reviewed-by: Fuad Tabba <fuad.tabba@linux.dev>

Cheers,
/fuad
