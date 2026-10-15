Received: from mta1.migadu.com (out-192.mta1.migadu.com [95.215.58.192])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F83130E858
	for <kvm@vger.kernel.org>; Thu, 15 Oct 2026 14:00:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.192
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792072842; cv=none; b=p+/sSvULssIBrfz8e6+nShEdNVrVV49jy9KEiaTDRjNf/hQf7jPTN7B4zZd3t3T/wYgEymL9c2/6dfpxdLPdwCg6cV/oP2uqC44dGOc/Ev0K8mSUeRQOeISeUo/C7ylFNKglwWBD97AZFGFgUcFs1yTfEI+3xP/p8yWfXE6NyWM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792072842; c=relaxed/simple;
	bh=6Ntld4Igh2eWgn+gJwrpP12iCF/OrSpwwkSoEGWK6QQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UchslGdFOpG6Pv5Ss5ZDFtl3XSKLB94IGqKP70sPfTRnL9p+6HDvrcsj3dFKba926n3WqeBd+cMLg+yWP25Hjcki0t5fyL7MUzWe+xi8Ko7RQCMi94fdKVnOFJWeXcY2monPCEOlLb1Qm3fysTs+1bf8JubOA2E1bNwUYq1DrQM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=i8WN1qz5; arc=none smtp.client-ip=95.215.58.192
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="i8WN1qz5"
X-Envelope-To: kvm@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=6Ntld4Igh2eWgn+gJwrpP12iCF/OrSpwwkSoEGWK6QQ=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1792072837; v=1; x=1792677637;
 b=i8WN1qz5ZUrN39SIFdMOgrxJU2yxe3XcmDKkxLDMr17EP5J4b+h97pcIo+201BQkPmINsAIE
 qXTzPSptVwEBSsp0PKYueKb1M8VVaxx7kZv+ZDMnEKn0UjWPb5wbUnejrYetpM4EhzuWcS4MCx1
 B+Ep5bPQ+yrVpJmmR/2Ouais=
X-Envelope-To: kvm@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id de2811613f9d1551;
	Thu, 15 Oct 2026 14:00:37 +0000
X-Mizu-Trace-ID: de2811613f9d1551
X-Migadu-Flow: FLOW_OUT
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-5ba429b64c5so5113e87.1
        for <kvm@vger.kernel.org>; Thu, 15 Oct 2026 07:00:33 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvBwsa+83VjYjMkme1NKoxtpSZwfSfyCP/4e2YqEydh9jbAuQenxDkrxbALfTDBbzq28pwl4=@vger.kernel.org
X-Gm-Message-State: AFq9FYKH6H66ZYyg/wbDIt//d/E0T51ome8tiF8erMvN00nZehXzeEu5
	VdK4vf+wcag710cqL9kLFsu1IQO6zoS3k99hBJVF6B/LdgSqLXoxyqnB9P3Ms1HsNDGc9gQ//3Y
	j4hHMJwhA68DyMgVqIrXvc1aNoUbkLsspZTEf4QCd
X-Received: by 2002:a05:6512:3196:b0:5be:3607:3a97 with SMTP id
 2adb3069b0e04-5be3e077786mr116198e87.0.1792072832985; Thu, 15 Oct 2026
 07:00:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20261015100539.1011760-3-maz@kernel.org> <20261015125713.2650696-1-fuad.tabba@linux.dev>
 <86ik33137e.wl-maz@kernel.org>
In-Reply-To: <86ik33137e.wl-maz@kernel.org>
From: Fuad Tabba <fuad.tabba@linux.dev>
Date: Thu, 15 Oct 2026 14:59:56 +0100
X-Gmail-Original-Message-ID: <CA+EHjTz2nsHkYkXOprZ9obYmTQeKrcue1S686CwCjWvLhtjmvQ@mail.gmail.com>
X-Gm-Features: AclHuK_p_jA27OTWFMOxJa5ERUC2ySPYnnuaQE4YLlcy6i2zl-d3p83lu3UB5OY
Message-ID: <CA+EHjTz2nsHkYkXOprZ9obYmTQeKrcue1S686CwCjWvLhtjmvQ@mail.gmail.com>
Subject: Re: [PATCH 2/7] KVM: arm64: Move OUTSIDE_GUEST_MODE publication past
 context being saved
To: Marc Zyngier <maz@kernel.org>
Cc: Oliver Upton <oupton@kernel.org>, Joey Gouly <joey.gouly@arm.com>, 
	Suzuki K Poulose <suzuki.poulose@arm.com>, Zenghui Yu <yuzenghui@huawei.com>, 
	Steffen Eiden <seiden@linux.ibm.com>, kvmarm@lists.linux.dev, 
	linux-arm-kernel@lists.infradead.org, kvm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Thu, 15 Oct 2026 at 14:52, Marc Zyngier <maz@kernel.org> wrote:
[...]
> I don't really want to make this vgic specific, as there could be
> more. But I can more precisely describe what state were talking about:
>
> diff --git a/arch/arm64/kvm/arm.c b/arch/arm64/kvm/arm.c
> index 8b46fafdd3494..7ce9f3bfa7fff 100644
> --- a/arch/arm64/kvm/arm.c
> +++ b/arch/arm64/kvm/arm.c
> @@ -1390,8 +1390,9 @@ int kvm_arch_vcpu_ioctl_run(struct kvm_vcpu *vcpu)
>                 kvm_arch_vcpu_ctxsync_fp(vcpu);
>
>                 /*
> -                * All the state has been synchronised, let advertise
> -                * we're outside of the guest.
> +                * The state that was pushed into the CPU on entering
> +                * the guest has been synchronised back, let's
> +                * advertise we're outside of the guest.
>                  */

lgtm,
/fuad
