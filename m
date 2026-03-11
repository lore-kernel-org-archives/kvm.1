Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 504CC3E3C7D
	for <kvm@vger.kernel.org>; Wed, 11 Mar 2026 17:42:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=170.10.133.124
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773250954; cv=pass; b=iqupVLc68cMapbtGDhZ860zq4aGxCrVTVP0im7vhEE1MWu4S0MQx8YOLol4WkIcXo5qMY/IPRF8fZWzdQhn9YgWd13lAKWHme+SiedJroa9yytMc7WxYciZuk7Omh4ksc0DQdXUCCFQn4/gKi8T2iJE6hHwNSW1BpPW1fGc8n0k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773250954; c=relaxed/simple;
	bh=LLYPzxfgc41WbA2qy2EZKJW1VA/IzQfrt0W5nMgLqYk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=C9UTpy7+vGU6kX9/aVxpScdx9JKnivlDER6eB/1ys1lZTLbmrW23TuDVNLSOd7fokXiVwsB70ampMKsEwlhuZoBOsJ0YB4vBtHWQlEcbuFmL8bES2dSIE9fEgq6a4YnVkbPfqc385I5CG5a/O6XpfefpnQwDERkoQXsTNZovfK4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Q4CpDG1V; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=dj2sLG6s; arc=pass smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Q4CpDG1V";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="dj2sLG6s"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1773250951;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=F/YbJZ5mStPYPfrX4lrd1txozK+dMfvbgcpYGh/3eQE=;
	b=Q4CpDG1VykLGG+pRFoRcggNkWiPrxnmwWGCq0pE6AY+erlJYIkTv/6F8U333BJuaIqx0t3
	e7nlKajo14i9qjyhOAI67iy4fzyzD751HXmntUEMo9YKUeh7TzfjhYDdvBY8I3kj+kIENm
	XtEWGE17OKOwdlLR7sym3SkSg86r2ao=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-512-EgGKdxLvOVWtc83K-xfV9g-1; Wed, 11 Mar 2026 13:42:29 -0400
X-MC-Unique: EgGKdxLvOVWtc83K-xfV9g-1
X-Mimecast-MFC-AGG-ID: EgGKdxLvOVWtc83K-xfV9g_1773250949
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-439cbfcfc21so149170f8f.2
        for <kvm@vger.kernel.org>; Wed, 11 Mar 2026 10:42:29 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773250948; cv=none;
        d=google.com; s=arc-20240605;
        b=SFiI/sz1phnFqh/eNeRAggeL26IRdbKoBGiA1iKwl2mf1yBjJCgf2QlMltJ02GcqKX
         eTRnhk2FEIoG3egpw9y11XFENgIR/SxFCaMVNAWnu1vEgQWHiBRMOSUXhTgDO0ZNIASP
         AsLXs5klMPoU4++yxjOvIYdCJu9mW8mFc+8mR3WmjFzBfR1JzhDANMx0XkjlveDi/kgm
         BqwE9SJTVwIV7WapfgN7Ru/L9nprafiYlAD/WWKGzc7Mpih+9Qf/0wV1FckEUr07s6xd
         4tnMVUuaFf9dR0ZZIaBHA7/iNANK3trq7EqgmlFRnFgArsm1Reo8nT9jFq9F7L1+BRWz
         Ar6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=F/YbJZ5mStPYPfrX4lrd1txozK+dMfvbgcpYGh/3eQE=;
        fh=3JbqrmY4LJjfzDvXb/SqUcVyhkXlZopwU0HKPS0x6hc=;
        b=KWG6Y3xAbf/HCMpP2dl/xTZ3uFzBWNcfhV0HoeWc1wkr7CKC120HgB5M8hklWy04Px
         y9qJvvqBedt58XGQyX+Y7stDVeoq9JKKBYuJzbdtRlDlwp3dXYmPfwuBAEUzOmg+/l3U
         lKUaXefTomBryAsT8/kX1qdheitNqr5C/jgrt+1TGcwpRnmXrWfkfIqcx11Iod9eHRCQ
         zMVk2utSc9nsq03KDUiaDr6ERM24c57ovby7mGkKJQPxJhglwn7jxUn0lXnzw11kmCRw
         OPI4tq2Gkx0Zd2DgvtPQhy/PpcqQHcKORBhJFnQTw2CP62VXDE7cMnfyb0DC9WfibBqX
         wfNA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1773250948; x=1773855748; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=F/YbJZ5mStPYPfrX4lrd1txozK+dMfvbgcpYGh/3eQE=;
        b=dj2sLG6sdNwfWo+xVuAWdu+A2ZQy+TOb5B2URzp9Q4QiG7EgfB2w87ehZDf1ZxT2zU
         75ZebBcvkLfVcDwzEzwtaGRbFp3HoX/aBys2/qTM6xJFuiv2PJygfPO2fcjGuOEEirZk
         Xzfxj2fb7SYQbV9ZD+1CNYUzLhCYHL845AEzR+2vPrEo6SsBocKugEYkKh15nFilfKwz
         HBEAU28FGE0GDX5ybipy+KTPVFFQXHw0fd83VAth8+QZ+gUT1tPWmUviCZ1VwoQZjvNv
         VSfZLgu1ZX4b0Qk5BeunpFRupcWbAXW74pJ/o5acjdwGulBaEPYJFsKgRUkATqmRUx1V
         stpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773250948; x=1773855748;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=F/YbJZ5mStPYPfrX4lrd1txozK+dMfvbgcpYGh/3eQE=;
        b=jnKRtOejdryfAR3ujkk5F4Ut28f+vPt7HdrmaO6fi/tvcVK0GmGjHupBsZGJ4D5MfM
         KHJQb9BTeAe3+jxUXJkHf1TKALrAY4csDjnyXSWdt/0PxVGl4Zh19v7wqSiWXyohkaTf
         oGWJYh7Z/FGxjCxHptWY+7E1L2sy38F9CVA9bi0KfIFGs7+rmmzcIFuyDxKTtOVRW2aN
         H5VjzW801PI572ZKPD9HhNURrU4Z9sghp/zDc5eur6PLxK6l0GuQBLoSEbeqCcOPeoa+
         2yXIdcfZcigf5CpC0QsI5m0uSGF7dZFHgQaSKkhZ7GEC3aaYC6dBsHkRB50zT+8ZYI2S
         Kheg==
X-Forwarded-Encrypted: i=1; AJvYcCV0oOiQ16T4VVkxmJqmkzjfhvu3G8odKuvvXYvRwfhqf30C3mRNBJH4wHrueVxAs3GqFU0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz992wrWbLMveBkiXzUROQ+asbB1m/ZmtceEU5GwlxdUlKw3nBR
	HQ7Fx7kEsL/FLiC6JftJwoY4zvmxWFeImnI3kouRITAwPreiqyXX50beyth9EpgrHRivI8zTL5a
	46qR72a8zWUY3jJzTB6ASAeEoMw+FyJqmqv4DY8ODyLX2mO4DML3MmljmXu7s4NzEPB4adU0dkF
	4XpdCJpoHfmi7sDpEMfNycgREma5Os
X-Gm-Gg: ATEYQzz6vki4uCBm8CDBXzs0dlvl8KRa8Ld2WVZes5UPS/s8hh1g7zNDs5BmANbuvIO
	QK7QBreAlDJuDFg6w7iqqQov2mx6sQThjJQMk2arTa4SeiMexZD5YZ0K7tAkYU5MWP4dBF9EZjT
	7/46+ST+ax3zsOyExek2IlBJvqRJsg8Ny9EV0U2tNFvlEFS1wbL3PJdJ9ujr6xazDLVWEy4q/zM
	dTDxvMe1b2drMAXblEN95BduKjE+FJH+senqMJ/Xwi4gQtFWTqPD0W+vEQLUGI7CfvPpZOwOpN3
	bEgcCic=
X-Received: by 2002:adf:f745:0:b0:439:fdd5:10b5 with SMTP id ffacd0b85a97d-439fdd510eemr1093015f8f.39.1773250948574;
        Wed, 11 Mar 2026 10:42:28 -0700 (PDT)
X-Received: by 2002:adf:f745:0:b0:439:fdd5:10b5 with SMTP id
 ffacd0b85a97d-439fdd510eemr1092976f8f.39.1773250948152; Wed, 11 Mar 2026
 10:42:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260311173902.329537-1-maz@kernel.org>
In-Reply-To: <20260311173902.329537-1-maz@kernel.org>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Wed, 11 Mar 2026 18:42:11 +0100
X-Gm-Features: AaiRm53T5yAtX5ypUWcyuTtUjMCgSXyDtjqh-7JRGZz496zaXdK-3JoiKSNnA38
Message-ID: <CABgObfbQrLf_UJHU58vmAOZx=FgbM3TVhvqq-FEabeaain1XXg@mail.gmail.com>
Subject: Re: [GIT PULL] KVM/arm64 fixes for 7.0, take #3
To: Marc Zyngier <maz@kernel.org>
Cc: Suzuki K Poulose <suzuki.poulose@arm.com>, 
	Valentine Burley <valentine.burley@collabora.com>, Vincent Donnefort <vdonnefort@google.com>, 
	Joey Gouly <joey.gouly@arm.com>, Oliver Upton <oupton@kernel.org>, 
	Zenghui Yu <yuzenghui@huawei.com>, linux-arm-kernel@lists.infradead.org, 
	kvmarm@lists.linux.dev, kvm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 11, 2026 at 6:39=E2=80=AFPM Marc Zyngier <maz@kernel.org> wrote=
:
>
> Paolo,
>
> Here's the third set of fixes for 7.0. Two fixes, both related to the
> pretty large vgic rewrite that went into 6.19. One is affecting
> interrupt deactivation, and therefore leading to guests locking
> up. The other is affecting CPU hotplug with pKVM, leading to the
> onlined CPU not booting at all.
>
> Please pull,

Done, thanks.

Paolo

>
>         M.
>
> Marc Zyngier (2):
>   KVM: arm64: vgic: Pick EOIcount deactivations from AP-list tail
>   KVM: arm64: pkvm: Don't reprobe for ICH_VTR_EL2.TDS on CPU hotplug
>
>  arch/arm64/include/asm/kvm_host.h |  3 +++
>  arch/arm64/kernel/cpufeature.c    |  9 +++++++++
>  arch/arm64/kvm/vgic/vgic-v2.c     |  4 ++--
>  arch/arm64/kvm/vgic/vgic-v3.c     | 12 ++++++------
>  arch/arm64/kvm/vgic/vgic.c        |  6 ++++++
>  5 files changed, 26 insertions(+), 8 deletions(-)
>
> --
> 2.47.3
>
> The following changes since commit 3599c714c08c324f0fcfa392bfb857c92c5754=
00:
>
>   KVM: arm64: Remove the redundant ISB in __kvm_at_s1e2() (2026-03-06 10:=
42:21 +0000)
>
> are available in the Git repository at:
>
>   git://git.kernel.org/pub/scm/linux/kernel/git/kvmarm/kvmarm.git tags/kv=
marm-fixes-7.0-3
>
> for you to fetch changes up to a79f7b4aeb8e7562cd6dbf9c223e2c2a04b1a85f:
>
>   KVM: arm64: pkvm: Don't reprobe for ICH_VTR_EL2.TDS on CPU hotplug (202=
6-03-10 09:48:45 +0000)
>
> ----------------------------------------------------------------
> KVM/arm64 fixes for 7.0, take #3
>
> - Correctly handle deeactivation of out-of-LRs interrupts by
>   starting the EOIcount deactivation walk *after* the last irq
>   that made it into an LR. This avoids deactivating irqs that
>   are in the LRs and that the vcpu hasn't deactivated yet.
>
> - Avoid calling into the stubs to probe for ICH_VTR_EL2.TDS when
>   pKVM is already enabled -- not only thhis isn't possible (pKVM
>   will reject the call), but it is also useless: this can only
>   happen for a CPU that has already booted once, and the capability
>   will not change.
>
> ----------------------------------------------------------------
> Marc Zyngier (2):
>       KVM: arm64: vgic: Pick EOIcount deactivations from AP-list tail
>       KVM: arm64: pkvm: Don't reprobe for ICH_VTR_EL2.TDS on CPU hotplug
>
>  arch/arm64/include/asm/kvm_host.h |  3 +++
>  arch/arm64/kernel/cpufeature.c    |  9 +++++++++
>  arch/arm64/kvm/vgic/vgic-v2.c     |  4 ++--
>  arch/arm64/kvm/vgic/vgic-v3.c     | 12 ++++++------
>  arch/arm64/kvm/vgic/vgic.c        |  6 ++++++
>  5 files changed, 26 insertions(+), 8 deletions(-)
>

