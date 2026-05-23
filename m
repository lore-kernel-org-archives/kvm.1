Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09DC02FFDFC
	for <kvm@vger.kernel.org>; Sat, 23 May 2026 08:03:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=170.10.133.124
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779523424; cv=pass; b=RoGg0cG4mnwiJ07gazzJw1ubsNAdYzWVOt6FqT+Id4XJ0E1T5IrG6G1VNTCf4m3CYm2JXAhUxERMkpZOu3wAbF9rqwUAa7gFlxM4Sm1mIWmj7ntf+1Y5X8n1ZGhThsCJPPJWR2mgUvWBxmfdwnKPGQfcepJpPhRl/EArwLlsdS4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779523424; c=relaxed/simple;
	bh=qz6D3f3YJ2k4+mQtE6g0uFyZLHw2nxe5jE72RTocq8g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nMfC1VWEUtkOqm6udekzfJV2QfpyK51K1PkfrGLGvHO8c8i+bGwUl0ggL9ydzxZfvANpq7PQtZdpXmdwUkOaaQi0xsOwkKTYZDmba5LKyyeKDyJLR85mjT+GWGM8e8KaChdGUeDLn38BfBxt1s53LOlOME7CJ9sYLfo89D3G9ng=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=TmXWnTrE; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=Qi13rRP+; arc=pass smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TmXWnTrE";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="Qi13rRP+"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1779523420;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8kCCPSR7eAbezRrY9EzmdTOQTokcL1TCE2C4CcBHkS8=;
	b=TmXWnTrECwQicLVh2U4s1iZn4V5As7wyHW3noteoEkX+bBzylXKXYvV8j2NV17zR5GFixA
	R46TrqMIz7KgFZIlbh22KnHmtbMjUHF6hvolvAT6JIVpjkgfhzBq3PQ2cDp12uFLFY5JKR
	mRcbDE43QTbsExtGI1PtyWzSQJz0FI8=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-340-ZSR4ExgGPbiBrsW84vKiuA-1; Sat, 23 May 2026 04:03:38 -0400
X-MC-Unique: ZSR4ExgGPbiBrsW84vKiuA-1
X-Mimecast-MFC-AGG-ID: ZSR4ExgGPbiBrsW84vKiuA_1779523417
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-48d127eb013so36906765e9.1
        for <kvm@vger.kernel.org>; Sat, 23 May 2026 01:03:38 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779523417; cv=none;
        d=google.com; s=arc-20240605;
        b=ZQD+JKFpLS4Viv7ioYABNSKIS6QNFOoH7mj/aDuBtFgb5gDb9KGQvNZODVJnZTsHjK
         QPdkZfZLciCfFiiU4kyehkbR+4MWnqiE6zp7Ejc6bU6M76QcNxl9AkaglvEOwFAC2IV5
         hFiGYysBm5+0NAHVd3CtzSpiYwP34Gs2YMuUludmF/WdLunfTLDwa38Gqzr0/A9a0U4Q
         bxv48ADa2qSId5FbcuiErWTswbE+JOMQe+hst62faiPNSW1aXxoVvASEspnPiqcln/rC
         +Gj2X+0MANVybtv13LP8QYEYSjohRlkDb6PhhnQ0hAggRIU9oo0ciqyCZBYCNNZYrIU2
         LUYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=8kCCPSR7eAbezRrY9EzmdTOQTokcL1TCE2C4CcBHkS8=;
        fh=47FBMO1rHY4kkKIycu/tOedqbMmxdyFKxUHEq53QmcU=;
        b=E8pPx0v30t5sqxjveaz+uDR9bnWOIzwtMI0T/f5rrozWnWOhZjhpFA24k3qflJR4bt
         lq3Qu39qYJdMud484gpcDciQlvoi6GGthvu8uBXvOZ1WRFB8rKuWyzW1beyHuofbko3L
         LK+4Y//RbW1l58GTK+8cYKE2pezDIJfyhuNndbs8JoXXsoyW7WEG7z3bcENixUTeZ6eT
         6LiIfZNytJ07ZQUg/rkiFsnZa77tBoQC2MFvLLQnM386UVNaD7hOBqZcIg7oq0AvWEAX
         GbDUdgneAGf7a2rpg1CAC0kr3d91kegBLTTm0LkzphKVR9MHYN6fBQ+YpiiGgUgcSUbj
         cZbQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1779523417; x=1780128217; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8kCCPSR7eAbezRrY9EzmdTOQTokcL1TCE2C4CcBHkS8=;
        b=Qi13rRP+n1qBS9fs7pZ4EA+bPbL98i/jtJzEWO2Vj4Bu+PSGOsC4X/E5BZNR0NCfLe
         JusLpjhZ659mQEe7TNX/puPAcDhBa08/7GvL1Jaa4xjeLOkF6yu/GK0W/mXTytWPAL1F
         z4TKWx94sSSYEk3tXVXfkgsaEcj92qxmhafIX+PuWToMYs4dQwnBJForS/qDruYccH2z
         PJZa9KgJJ9lgdu6V4FJNQ5H4ALro0ZqMy0MeGbFXCcZbcpbh4c3A9yS1ZovSA8ZwExkQ
         PR192E7LT3mbtc953YJzzh1EeootQJ6fjXFJrjG923OEidwtZQbIkXqZSzFCd9s+hG2j
         Kj+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779523417; x=1780128217;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=8kCCPSR7eAbezRrY9EzmdTOQTokcL1TCE2C4CcBHkS8=;
        b=nyAwkxwfMsFcHriW8wjrYSxCG/67gANC2UVTvpTYAhAAX5/17FiiGDkKek7fFh+j9p
         Z8Xk709MsBf1PjxOonsmjVsRfeOePqpaue28anuJIdPjzOkkgqYePgYFNHHox2POLf2U
         NRds+kQyDls5AlcP7rUx0IXIa+nYQrEMeIKiW7SAj2azyEMI5HdQlFJdiUVzGOQeJy82
         R3LLeKUQ8XyYqlttht/6beLIkZmWEJYEb1BIynmabBsuzjSO8rhVvgcI1D+3dbXLBDEQ
         Sx/7MZOWOHrts6EuSxvrX5Zx8c37bexgfY4DROkno4dKF13OfqJHGuSpvUoEgszt3FmR
         AUiA==
X-Forwarded-Encrypted: i=1; AFNElJ8HhExdSdQWDR4U4moMNda1i9k7zGs+VkHv0S152KqBPVpt4eCGfxk0WxUZFPdzqE7cjKk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxQb3nufy++JsKbPpaB+gI1bZfoCEX8kuMWfNrQiNPOsD5bTsSE
	ZC5iUTuO5zujIPM+Hzmn8Runt910+i2dBQqQ2YS+x7DVABw7tOYC8Ou7mu9hqzE9a3AHzXkiy66
	FDOBE0er7xlkeFfVNj5weyY8zx1vt3w2XOkJpWyBcKZYFeIqVKczaBYMMaZq5K1P9yeZlKf14bT
	9isi16zISEv6Uyb0Jan+64cxzEg2zn
X-Gm-Gg: Acq92OH2XNdwMTMVwzmBsTNDr//WPvYGwh2+NYQsdWaMRg5slrMyC1i2bi0Q45Uvs59
	U1RA/Eyy13F4Ha65emiotWq2wocBxP1U3BYZcmlrAK45OGdfaLWhyZkgGSpNyBZsVbk6k3laLMC
	mNL9FMmj5imcjBhXqrkK5YBdZTt0ZkbObmNglORjNrxSDdiF7/KfBEyfYzyudn0Ifgt8gWqwCWG
	q5QnwbIgl+przmU0Ik9f40wkpaWGKllp54UVXltipOKjV0dDegeyXqL9yZWrMQY+4hAlj/QtpS8
	GpwR/Ug=
X-Received: by 2002:a05:600c:5298:b0:48e:51f8:eb39 with SMTP id 5b1f17b1804b1-490428e0b24mr103916315e9.28.1779523417121;
        Sat, 23 May 2026 01:03:37 -0700 (PDT)
X-Received: by 2002:a05:600c:5298:b0:48e:51f8:eb39 with SMTP id
 5b1f17b1804b1-490428e0b24mr103915625e9.28.1779523416685; Sat, 23 May 2026
 01:03:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260520072518.504865-1-maz@kernel.org>
In-Reply-To: <20260520072518.504865-1-maz@kernel.org>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Sat, 23 May 2026 10:03:24 +0200
X-Gm-Features: AVHnY4JSA0Bs3_rwKjWLijly1xMqn0yNDirfiVv1I4mSWo8k1UBJzXBC_g_e__A
Message-ID: <CABgObfb4UiufkpDOP6yyAYNjBYnSZvZpi6hfqXoEX7dqCPBk3g@mail.gmail.com>
Subject: Re: [GIT PULL] KVM/arm64 fixes for 7.1, take #3
To: Marc Zyngier <maz@kernel.org>
Cc: Michael Bommarito <michael.bommarito@gmail.com>, Vincent Donnefort <vdonnefort@google.com>, 
	Will Deacon <will@kernel.org>, Yuan Yao <yaoyuan@linux.alibaba.com>, 
	Steffen Eiden <seiden@linux.ibm.com>, Joey Gouly <joey.gouly@arm.com>, 
	Suzuki K Poulose <suzuki.poulose@arm.com>, Oliver Upton <oupton@kernel.org>, 
	Zenghui Yu <yuzenghui@huawei.com>, kvmarm@lists.linux.dev, 
	linux-arm-kernel@lists.infradead.org, kvm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, May 20, 2026 at 9:25=E2=80=AFAM Marc Zyngier <maz@kernel.org> wrote=
:
>
> Paolo,
>
> Here's the next set of KVM/arm64 fixes for 7.1. Continuing the trend,
> we have two AI-fuelled fixes, both of which are stable candidates.
> Additionally, a minor tidying-up of the hypervisor tracing descriptor
> validation.
>
> Please pull,
>
>         M.
>
> The following changes since commit effc0a39b8e0f30670fe24f51e44329d4324e5=
66:
>
>   KVM: arm64: Pre-check vcpu memcache for host->guest donate (2026-05-07 =
14:12:42 +0100)
>
> are available in the Git repository at:
>
>   git://git.kernel.org/pub/scm/linux/kernel/git/kvmarm/kvmarm.git tags/kv=
marm-fixes-7.1-3
>
> for you to fetch changes up to 1702da76e017ae0fbe1a92b07bc332972c293e89:
>
>   KVM: arm64: Fix nVHE/pKVM hyp tracing error on invalid desc (2026-05-20=
 08:08:37 +0100)

Done, thanks.

Paolo

> ----------------------------------------------------------------
> KVM/arm64 fixes for 7.1, take #3
>
> - Fix ITS EventID sanitisation when restoring an interrupt translation
>   table.
>
> - Fix PPI memory leak when failing to initialise a vcpu.
>
> - Correctly return an error when the validation of a hypervisor trace
>   descriptor fails, and limit this validation to protected mode only.
>
> ----------------------------------------------------------------
> Michael Bommarito (2):
>       KVM: arm64: vgic-its: Reject restored DTE with out-of-range num_eve=
ntid_bits
>       KVM: arm64: vgic: Free private_irqs when init fails after allocatio=
n
>
> Vincent Donnefort (1):
>       KVM: arm64: Fix nVHE/pKVM hyp tracing error on invalid desc
>
>  arch/arm64/kvm/arm.c            | 4 +++-
>  arch/arm64/kvm/hyp/nvhe/trace.c | 9 +++++++--
>  arch/arm64/kvm/vgic/vgic-its.c  | 4 ++++
>  3 files changed, 14 insertions(+), 3 deletions(-)
>

