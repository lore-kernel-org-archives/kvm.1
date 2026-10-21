Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=91.218.175.171
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792565295;
	b=qyLADjwH25o/w+K9cl3ZCKf6tzIFxUK4Q4Jh2LUBKXb4c9/e+x8s5lBq144kWxFyIdBm
	 KHpDaEuTqHR8JzOqGHXDMOXvZ7rPXSvvgAXB4Kn8ZAIWp/gyidT2WUkZ1Y5ehf972Hsqd
	 ITur4eDI1lKjMmoNPndTPmZBqenPtyqsKpNKrYus37IbKOw0cXXyOH2GIkFT3g9/K0zEt
	 ZZYFtvavjZOzoTcD2gJ7QkjDo4Km4hBgK68HLYsvPTqYT2qPYY5wBbW+5IjL7w8VcySjS
	 TUxYRk8f+b48CPw7FpFNoScG9bC7ZjeJBYZJs4jUgbOVmpzScc//2mUNcn9NVt6ENtg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792565295;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:Received:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Received:MIME-Version:References:In-Reply-To:
	 From:Date:X-Gmail-Original-Message-ID:X-Gm-Features:Message-ID:
	 Subject:To:Cc:Content-Type;
	bh=9yp/fM0ro6tHmyo8E9yuKsYQD4EKEIrb4BvBf4JN4ow=;
	b=ll4+okIzE7FdaDFigJQ1pACkFdhk0XST5heWpNiVPUVJw2sioyYA09c65SUYfcEb9oVZ
	 wGWXMvpm4eT6too4EsP7yAtWpUprq7jEvD0xFq+CJz+x/CGSSmb+UxP4lVNgmYfwjzZdt
	 vr4TMe1u8mLZiiXZoId319RZTD/rIXJ4ySFsurH6/32B18X8vkSdGlywtAzivz9XXzEYl
	 38LBfpbtu/T6sbGxV8zGur8IGg8TcaK0ajzDi3xtoJ0nbh7Evf9ARdAPAZadT9KoYWYS9
	 zO21yIk5qSnKb5sg/tTPhO1W/rs85fVneXAHRRusSP5mDCdW3zkLeumoh4ilhWO4/0w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=da4vocG3;
	arc=none smtp.remote-ip=91.218.175.171
Received: from mta0.migadu.com (out-171.mta0.migadu.com [91.218.175.171])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C55E7606A326
	for <kvm@vger.kernel.org>; Wed, 21 Oct 2026 06:48:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C55E7606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=da4vocG3
X-Envelope-To: kvm@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=9yp/fM0ro6tHmyo8E9yuKsYQD4EKEIrb4BvBf4JN4ow=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1792565291; v=1; x=1793170091;
 b=da4vocG3NysPY8mYu9ao5ZobzszHgd7V4ic6f/1PUsP0FsNQ5H58UpJe7JZLO3gF3xUzCGT0
 OKU8ZN9vFnfIDsU2jqJ8N293mpwYPkjSrADxHjHLNc9KA8eNPpz1Jlhu63gW9jv+vWNp1osIkHG
 RYaXsmTasDVFB8wY+0YoWm28=
X-Envelope-To: kvm@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 676c6f00a9a7cde9;
	Wed, 21 Oct 2026 06:48:11 +0000
X-Mizu-Trace-ID: 676c6f00a9a7cde9
X-Migadu-Flow: FLOW_OUT
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-5be58ad9600so5570e87.0
        for <kvm@vger.kernel.org>; Tue, 20 Oct 2026 23:48:10 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvBwzAbk1WLzQXTYepHwnWq4F8YSoS8P6rpzerxXVVjqz3pAznKQ/uW0C4lM476S7tOQiuNs=@vger.kernel.org
X-Gm-Message-State: AFq9FYJfJ6cBw1L0g+49uqEATRwTBVZZ1+fo8GYIInKLzXEMxqFQbYHc
	qo2BOe4Rzpc8NbATHxem/Qp7qnqFW8qd91z5fOOkGM0DI6abiAuTvcSTNPi+DPtx+R+jBNj7REx
	gT3O9FySEdqqkJDDKLT07fTdgTxQjW7yFenSkTgzL
X-Received: by 2002:ac2:568d:0:b0:5bf:a37d:dd53 with SMTP id
 2adb3069b0e04-5bfa37dde95mr9658e87.10.1792565289649; Tue, 20 Oct 2026
 23:48:09 -0700 (PDT)
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261020163923.1407856-1-sascha.bischoff@arm.com> <20261020163923.1407856-2-sascha.bischoff@arm.com>
In-Reply-To: <20261020163923.1407856-2-sascha.bischoff@arm.com>
From: Fuad Tabba <fuad.tabba@linux.dev>
Date: Wed, 21 Oct 2026 07:47:33 +0100
X-Gmail-Original-Message-ID: <CA+EHjTw_k-v7jB0NA2knArR1wtefZWkhVRgm9T4E=Co6sytEiA@mail.gmail.com>
X-Gm-Features: AclHuK9qbfaij78T_z4eQI7pVHIrgMA1rYSiJ8XdhcOIOhDcFbexzAqkSNQZiz0
Message-ID: <CA+EHjTw_k-v7jB0NA2knArR1wtefZWkhVRgm9T4E=Co6sytEiA@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] KVM: arm64: vgic: Require matching VGIC and ITS models
To: Sascha Bischoff <sascha.bischoff@arm.com>
Cc: linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev, 
	kvm@vger.kernel.org, maz@kernel.org, oupton@kernel.org, joey.gouly@arm.com, 
	seiden@linux.ibm.com, suzuki.poulose@arm.com, yuzenghui@huawei.com
Content-Type: text/plain; charset="UTF-8"

On Tue, 20 Oct 2026 at 17:39, Sascha Bischoff <sascha.bischoff@arm.com> wrote:
>
> On a GICv5 host with legacy support, KVM registers both VGICv3 and
> VGICv5 devices. Without a model check, a VM can create a GICv3 ITS
> alongside an incompatible VGIC, regardless of creation order.
>
> The same problem exists for GICv2 on hosts that support a GICv3 ITS.
> KVM used to allow userspace to create both devices in either order,
> then ignored the ITS.
>
> Record the VGIC model required by an ITS. Reject an ITS if the VM
> already has an incompatible VGIC, and reject a VGIC if an existing
> ITS requires a different model. These checks apply on every host:
> a GICv2 VGIC and a GICv3 ITS now fail with -ENODEV in either order.
> Allow either creation order when the models match.
>
> Have vgic_has_its() require matching VGIC and ITS models, and drop
> the separate has_its flag.
>
> As part of this change, swap the type of vgic_model from u32 to enum
> kvm_device_type. This requires updating the switch cases in
> kvm_vgic_vcpu_init() and kvm_vgic_dist_destroy() to include default
> cases, which we mark as unreachable().
>
> Signed-off-by: Sascha Bischoff <sascha.bischoff@arm.com>

Reviewed-by: Fuad Tabba <fuad.tabba@linux.dev>

Cheers,
/fuad
