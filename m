Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=95.215.58.158
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792565311;
	b=hxYhFMWR5EKKCyU8czYWDshPugAzoi7d3jQ0ueDQSw7a+AIZ2cO1ZBRvjDhVs6oYDalp
	 GAznF1oD2oTDr1UAJydwLrAJ/a33sx72bGH4kSgWe7VMPVAk+uzqH0xhVZnq+WyUVvnis
	 NNY4fMWm4jBJM/sbKQqRKCgQeW3YASGg0foCgXTfiBndRyEopK2RdAQPhmq//IOrCEqpD
	 pIAkjx/PLbjEEQ846DF8b6XhwKV8QxW2HBMkx60iFocz2oLxER1FbEAW9+UVXKUFxLz75
	 tg5P/Wsfgr7p1GgID5pcPH9ijq9LqKGK8TE/izTLHY5JNAjrFmDWKNr4a3IC54rLjUA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792565311;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:Received:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Received:MIME-Version:References:In-Reply-To:
	 From:Date:X-Gmail-Original-Message-ID:X-Gm-Features:Message-ID:
	 Subject:To:Cc:Content-Type;
	bh=ERCu28HOlccXBiT0hxEnKDMxA84fNeRxo/vPze54s84=;
	b=lWDmGtLFD0h00H0SErs7p0kJ8YNxml6+8eteNsMkqF7tXthSYQgBfqGx1SOT2s0LTWGk
	 WOieg9WzBOyV5l+/HyIdOUuamm1UBsJVTbRaEkFjfeUpBjEb8x0WAF58b2bsY7qX5eS9P
	 BjXis4O62R2S5UvQeQBPAmC0t2agu/kQxaE8gQWS/Cke3+KEHpvDWha+OjPTjXpsYaMxR
	 /RBBPcotNytMdVaB9TKEoamPZWvoonh1KxN8PtEwEiB3yfz7tf3HnOyXXgCxJFcyx9g9O
	 8gcOIkxJJA+J/2s7nNJ8beYsbHaT3omWNp2cl6abjUbnKBYYszRhCQk710SntiwHNxA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=LN7Z+wTU;
	arc=none smtp.remote-ip=95.215.58.158
Received: from mta1.migadu.com (out-158.mta1.migadu.com [95.215.58.158])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08836606A31B
	for <kvm@vger.kernel.org>; Wed, 21 Oct 2026 06:48:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 08836606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=LN7Z+wTU
X-Envelope-To: kvm@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=ERCu28HOlccXBiT0hxEnKDMxA84fNeRxo/vPze54s84=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1792565309; v=1; x=1793170109;
 b=LN7Z+wTU4LbsAlrEhrHk7tOV/1RoKGGEBz+pmbNleJa6Ry+BxnRD7G2iQ8/+cbm9leSYAp+y
 nGYzRYGreZD7mdqUQSg797epLoV1jEUtysacpIMmbJPy2nCSaAfACQLUtCw0S65W8zMlNPDyj4h
 ejNvsFmxidzVz3jL88/sRrrg=
X-Envelope-To: kvm@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 2118d0f06fbbbac3;
	Wed, 21 Oct 2026 06:48:29 +0000
X-Mizu-Trace-ID: 2118d0f06fbbbac3
X-Migadu-Flow: FLOW_OUT
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-5bcbb378fc9so6512e87.0
        for <kvm@vger.kernel.org>; Tue, 20 Oct 2026 23:48:28 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvBx/MfeRKwpxrbjTANSK5erN/xWa/2oDCOpIsIohQZA4QgDU0ePLSgs5C04kdDaKv45aH8A=@vger.kernel.org
X-Gm-Message-State: AFq9FYKGCMockXkF87i4Sm+vwpYTEi+FEx7A+BuootQeiHQEtlYG2XoE
	pQXm6WRV9WtxcRw/w4ElyUGuOpticAV6pkzeappCgrcjBU4q48H/9UHm0utDu1+BuXchIqp/XqL
	ysbzLw+R2RaSx46pjG+M2E903jLmfC0/bFi/yMnuL
X-Received: by 2002:a05:6512:290b:b0:5bf:63a2:27fd with SMTP id
 2adb3069b0e04-5bf63a22a04mr171664e87.1.1792565308065; Tue, 20 Oct 2026
 23:48:28 -0700 (PDT)
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261020163923.1407856-1-sascha.bischoff@arm.com> <20261020163923.1407856-3-sascha.bischoff@arm.com>
In-Reply-To: <20261020163923.1407856-3-sascha.bischoff@arm.com>
From: Fuad Tabba <fuad.tabba@linux.dev>
Date: Wed, 21 Oct 2026 07:47:51 +0100
X-Gmail-Original-Message-ID: <CA+EHjTx5Gk2aBFUAzAP8pa_kggwPhoJOvkCT6YtLg0dbQEBSZQ@mail.gmail.com>
X-Gm-Features: AclHuK_-J6_HJSmrppsH8jrPBh30NkV5zsuQqfHdht3jCK3LseUqzQwdv9UJsgk
Message-ID: <CA+EHjTx5Gk2aBFUAzAP8pa_kggwPhoJOvkCT6YtLg0dbQEBSZQ@mail.gmail.com>
Subject: Re: [PATCH v3 2/2] KVM: selftests: Reject GICv3 ITS with a GICv5 VGIC
To: Sascha Bischoff <sascha.bischoff@arm.com>
Cc: linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev, 
	kvm@vger.kernel.org, maz@kernel.org, oupton@kernel.org, joey.gouly@arm.com, 
	seiden@linux.ibm.com, suzuki.poulose@arm.com, yuzenghui@huawei.com
Content-Type: text/plain; charset="UTF-8"

On Tue, 20 Oct 2026 at 17:39, Sascha Bischoff <sascha.bischoff@arm.com> wrote:
>
> Check that a GICv3 ITS and a GICv5 VGIC cannot be paired, regardless
> of which device is created first. Skip the check when the host does not
> expose a GICv3 ITS.
>
> Signed-off-by: Sascha Bischoff <sascha.bischoff@arm.com>


Reviewed-by: Fuad Tabba <fuad.tabba@linux.dev>

Cheers,
/fuad
