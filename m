Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=91.218.175.190
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793714244;
	b=pZDGg0b+9TL9qNmo3wRjEGo5Bovc3IKF+/S22oDXri7SwYKAdWj3JDveWeuzrpAdysO0
	 Ewl5vpCUWpgSbnnlYfpDjt9XTUcJkHktOhZ0ZEJrXDpMipZVeZthm474PUX++OL8nRejU
	 TZ4FAML6GQuIgWm5UKIDrD+LFmaMy8Rrsm397npB1s+o2zk3lLIjKJ6wohi1RM9PgiHDq
	 Uk/Iob+GCn+TosgR/P5+xguWEEHvLNFSCeVtpWIe/pO8yyji9KEgubD/Ty1Hnrts6+aIJ
	 s8RL1LQv8AYhwVHlYWjJAVqFczdlt51CHQuFIMS6OIi7OaMtiAExwLmRoK+7r35EeWA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793714244;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:Received:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Received:MIME-Version:References:In-Reply-To:
	 From:Date:X-Gmail-Original-Message-ID:X-Gm-Features:Message-ID:
	 Subject:To:Cc:Content-Type;
	bh=tyERGr5hdOOoKX6h8lJLvesFYUWczrxWlktN3GBL91w=;
	b=EgqXs5uo96z5EP5+N0RzApU8nZOtdLy8xq7ZiBBzFXa2fK0F7TQfyPyxXXb3Uhfjwz8T
	 gbOsVF8qq+WBr64STggoYjnEvWfNp8nF0iUZU/05t1YnBkeMH0QKqur363kQlIjZeTap0
	 ygRNZwrK3ttF2eW2DHnbtiWyphzHlwGSpU1nrEaLlXNiFxbTn1Df+dthZeo5ZjaAkBaLI
	 PRfTwuW6D4QX26n3eKv4TG1ikFGxnLZKo542pFbohG5vYyG+UD4ZZBSpKPbXQ7YxOQU+b
	 TrHkPzUknmpebI6oZ/WwV+nqfsl7W22s6b019nLZmyNyqRv3jcQ3O1DBZAxCdKyJkLA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=T6CAbVoV;
	arc=none smtp.remote-ip=91.218.175.190
Received: from mta0.migadu.com (out-190.mta0.migadu.com [91.218.175.190])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F1EE606A328
	for <kvm@vger.kernel.org>; Tue,  3 Nov 2026 13:57:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2F1EE606A328
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=T6CAbVoV
X-Envelope-To: kvm@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=G9LToFbCiWp9wS1VO1jBKDgeZl6HQaIVAnBp5WasFrg=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1793714240; v=1; x=1794319040;
 b=T6CAbVoVuo/EKcp7NqskWwmR+PnmS2CM9DsJTZCbhqrgNGjIm1GtyjzUlg82YPTuAXB55Gzr
 9+gWRrj9A5MwCupV97B294JQwsj0ZWm25fhCOeqOXWAZN1iFIfRlnFAOlnutLsaKf2tlHQVxOO4
 nw05wbK+wki0ccWRXPWl0Y4U=
X-Envelope-To: kvm@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 363417e43c543f66;
	Tue, 03 Nov 2026 13:57:20 +0000
X-Mizu-Trace-ID: 363417e43c543f66
X-Migadu-Flow: FLOW_OUT
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-5be58ad9600so7471e87.0
        for <kvm@vger.kernel.org>; Tue, 03 Nov 2026 05:57:17 -0800 (PST)
X-Forwarded-Encrypted: i=1; AKwUvBxE4QwwnUx7qsNnoaMUmhPFEnEHWC3eiX2QxAXR33XsnMdl2wgd1QO64HO9x3qMZ7REjxc=@vger.kernel.org
X-Gm-Message-State: APuU4Z+BkcCtMlJZCwzZBr1vvcUD+IPj5VByAYW9TVjB9yqdmL4Lrqhm
	4YGpmgYR7zBm0GYFY8JgH6SJwHKK1hANHiKSodUgBvJgfDcWUwxkW8ANa/qtEEjgNPUI5XPKkQX
	C3Duj3F/NCeNqWTNtXE1b/FQSbGJ+yEFhQYh8iohi
X-Received: by 2002:a05:6512:1087:b0:5bf:c0d0:8fff with SMTP id
 2adb3069b0e04-5bff0efda80mr92373e87.11.1793714236905; Tue, 03 Nov 2026
 05:57:16 -0800 (PST)
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261102194454.4086911-1-sascha.bischoff@arm.com> <20261102194454.4086911-10-sascha.bischoff@arm.com>
In-Reply-To: <20261102194454.4086911-10-sascha.bischoff@arm.com>
From: Fuad Tabba <fuad.tabba@linux.dev>
Date: Tue, 3 Nov 2026 13:56:40 +0000
X-Gmail-Original-Message-ID: <CA+EHjTzCH=8RwJ=5FXB=Hw7_qWYmYN9qZPFzFs3ShEcVjiBXjg@mail.gmail.com>
X-Gm-Features: AclHuK-svprfnHONOILI0GBqj01szuLcNL1Pgm3q7EqTgPF9NwQczUK83_h49Hw
Message-ID: <CA+EHjTzCH=8RwJ=5FXB=Hw7_qWYmYN9qZPFzFs3ShEcVjiBXjg@mail.gmail.com>
Subject: Re: [PATCH v2 09/16] KVM: arm64: gic-v5: Add ITS MSI injection
To: Sascha Bischoff <sascha.bischoff@arm.com>
Cc: linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev, 
	kvm@vger.kernel.org, maz@kernel.org, oliver.upton@linux.dev, 
	joey.gouly@arm.com, suzuki.poulose@arm.com, yuzenghui@huawei.com, 
	peter.maydell@linaro.org, lpieralisi@kernel.org, timothy.hayes@arm.com
Content-Type: text/plain; charset="UTF-8"

On Mon, 02 Nov 2026 19:44:47 +0000, Sascha Bischoff
<sascha.bischoff@arm.com> wrote:
[...]
> diff --git a/arch/arm64/kvm/vgic/vgic-its-v5.c b/arch/arm64/kvm/vgic/vgic-its-v5.c
[...]
> +int vgic_v5_its_inject_cached_translation(struct kvm *kvm, struct kvm_msi *msi)
> +{
[...]
> +        if (!READ_ONCE(its->enabled))
> +                return -EWOULDBLOCK;

Should the plain stores to its->enabled should be WRITE_ONCE() to pair
with this?

Thanks!
/fuad
