Received: from mta0.migadu.com (out-191.mta0.migadu.com [91.218.175.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 749AF33F5AA
	for <kvm@vger.kernel.org>; Fri, 16 Oct 2026 07:49:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.191
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792136975; cv=none; b=RWRj4fCSL1ojYwZdiF3b6moSUBh2PvAIDkFj4qgVsUUkXJP06zsQjR2TBU1bE7JSqi3zALZ4E8vfouMyImix0ETBZe+5X0cilFbxiI+nV4LV77gTX7XWyyE2modPiloryC1+Fv9+Jxnt4mNc06qIKLJWSpoxAHeA32M/wmegQ+U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792136975; c=relaxed/simple;
	bh=WZU0ITcIU0RDlLux+WU+QTQ4pBSZPCHTEfxzBG0C718=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IqtIQ+lEtqU0dV/GH8H+RBV8thz4U4hr4fHzJizTWnQPHMcTunXVfpiNCmq/kfDELjAVo398iBjsT/EI5v2MmsG9IoljkvMWCn4yD6hARZ38qgse0rb5AWs/Jc+c+yXVsPFNfHQEO0syAT57P9dNQErLY9RIecnea7ehF8AJav4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=gHBkX+CP; arc=none smtp.client-ip=91.218.175.191
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="gHBkX+CP"
X-Envelope-To: kvm@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=WZU0ITcIU0RDlLux+WU+QTQ4pBSZPCHTEfxzBG0C718=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1792136971; v=1; x=1792741771;
 b=gHBkX+CP4pFqrUTSDHxDWwjgoWT7wSsD2ZGE+4BGMRqj/vC8hGDTuDXWuyFn4YTmdBczNdif
 JHVOYntSScRxjdTpk2Vq0/N9ZhCJnTtHSpyCctTw/iYHMoB7I/inuTVyvLyN3xvjjk2TDD7162b
 Al6pGMLmyK9y6RthakYOvpkI=
X-Envelope-To: kvm@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id a387d096b3b60586;
	Fri, 16 Oct 2026 07:49:31 +0000
X-Mizu-Trace-ID: a387d096b3b60586
X-Migadu-Flow: FLOW_OUT
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-5be4a7b9e6fso3308e87.1
        for <kvm@vger.kernel.org>; Fri, 16 Oct 2026 00:49:30 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvBwsf59j4k1jmNZyYyBWiwZl6Ydz1/83RGtGtqMe4YWViYdK7eNwb6cNLxYNh6vR3GCdxMI=@vger.kernel.org
X-Gm-Message-State: AFq9FYIohMKOdCwqh6sze+nDUWZMsjjq5+cZga8bH7X4gd2+qaWBSI3x
	SMvDRYwJC8uZK1Iua1OwXmvFiPfa93KxoXKGLelo9VC8MptEQgq+OnK8VRTXmPw38+EF6KKz/Gt
	DDnVn437T5KSsJ42MBmOMB1jzkumKGmX0NiE+7MNd
X-Received: by 2002:a05:6512:b95:b0:5bc:b2ec:eaee with SMTP id
 2adb3069b0e04-5be493c4cb3mr93309e87.11.1792136969950; Fri, 16 Oct 2026
 00:49:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20261015173605.1072963-1-maz@kernel.org>
In-Reply-To: <20261015173605.1072963-1-maz@kernel.org>
From: Fuad Tabba <fuad.tabba@linux.dev>
Date: Fri, 16 Oct 2026 08:48:53 +0100
X-Gmail-Original-Message-ID: <CA+EHjTzdN53MvWmvk+KcD2XEthjpgSivGkYAsc7r8JpEb=02LQ@mail.gmail.com>
X-Gm-Features: AclHuK8kpSMVjBqTkfq4Ie2CF_wEvKZrjX3oALmxM5tl73nYKwHuhkhXFGvtnPw
Message-ID: <CA+EHjTzdN53MvWmvk+KcD2XEthjpgSivGkYAsc7r8JpEb=02LQ@mail.gmail.com>
Subject: Re: [PATCH 0/2] KVM: arm64: Cleanup the HCR_xyz macros
To: Marc Zyngier <maz@kernel.org>
Cc: kvmarm@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
	kvm@vger.kernel.org, Steffen Eiden <seiden@linux.ibm.com>, Joey Gouly <joey.gouly@arm.com>, 
	Suzuki K Poulose <suzuki.poulose@arm.com>, Oliver Upton <oupton@kernel.org>, 
	Zenghui Yu <yuzenghui@huawei.com>
Content-Type: text/plain; charset="UTF-8"

Hi Marc,

On Thu, 15 Oct 2026 18:36:03 +0100, Marc Zyngier <maz@kernel.org> wrote:
[...]
> Patches on top of kvmarm-7.4.

On kvmarm-7.4, every object under arch/arm64/kvm and arch/arm64/kernel
builds to the same code and data with and without the series (debug
info aside). Protected and non-protected guests boot in pKVM.

While testing it I found an older bug on a line patch 1 converts:
HCR_BSU_IS has been the unshifted enum value since the HCR_EL2 sysreg
layout went in, so guests run with BSU at 0b00. I'll send a fix
separately.

For the series:
Reviewed-by: Fuad Tabba <fuad.tabba@linux.dev>
Tested-by: Fuad Tabba <fuad.tabba@linux.dev>

Cheers,
/fuad
