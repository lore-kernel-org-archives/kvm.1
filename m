Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.218.71
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795187509;
	b=cIz4ivKrQLjr/pScmmTmfiesoSwR3CZMiCfTVZ+FCJAl5nxo6yqOS54ilK3JYAzverEy
	 khyk1OGwwSL3954QOFvJcB1Z/U7lfGy1E94fG0Ek/38v7JuMLJlE5rC/edGwDh15avxgX
	 RsOFtGPBkc5WfwEZqrNTQMgPQV/XgTtk5iUyqxxk+BcarXs7Uz1gSB36MJvPcdMKQrntv
	 MQuWOUO7n3npnE8wQiUZMu+Y367O1ZNjGm4Y4vv2phFvokTwQgBygfWqI+6nvXnh7j6xW
	 frmIrVGg9ALBwyav2cOb+qzKVsiTP0/O6WW5SM58ih91Q2ySbVHT/Mgatks7agPvVSw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795187509;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:X-Mailer:Message-ID:Subject:From:To:Cc:
	 Content-Type:Content-Transfer-Encoding;
	bh=9L5DYVZJmCTJDhX0/RtB0BzmznmCbVTr+mYGMw33Evs=;
	b=aZudtBjjBHukjiUNgYIFzmauE9O1M9ciQOca11HmRYa9/e9x0DkqyeqF+NKGyIY0+8iO
	 l2duQLBtnM9QpvQTOq6f7t3Xd7kiTbJCuuf6UVROUfolNmDY4K7fn0LQArszIc0P4i8U2
	 NLcDqAMe3ZJrRImTROBBLaX0gZZ8e31Ck+0mEmT7TEtT9g42rOKw+KJl0ANP+4RpPssfX
	 hhmf7iBCuh6Ow2pfuZy3W1yqEdYrC7NdocbWRSk7S1dZ4k/NPyrjhP1PuGcA/g9GdOm7g
	 I87eGLZWMLJpd9kXVTmf2DrLaGqqRncLMCmu/ds8wnID2abfUkl7oNauz6N3IsV2RNA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--stefion.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=ZXa1F42C;
	arc=none smtp.remote-ip=209.85.218.71
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com [209.85.218.71])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72262606A32A
	for <kvm@vger.kernel.org>; Fri, 20 Nov 2026 15:11:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 72262606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--stefion.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=ZXa1F42C
Received: by mail-ej1-f71.google.com with SMTP id a640c23a62f3a-c508f61e492so84480166b.2
        for <kvm@vger.kernel.org>; Fri, 20 Nov 2026 07:11:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1795187507; x=1795792307; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:from:subject
         :message-id:references:mime-version:in-reply-to:date:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=9L5DYVZJmCTJDhX0/RtB0BzmznmCbVTr+mYGMw33Evs=;
        b=ZXa1F42CV8EvlXMpcNdvdH3rAUyDMIKxyQuxbWmODfEAlrPkm5gY5G82sDTRUZ5uzv
         35TZYhgHC2PIPneKtcXQ70b9m4NHXau+C9PXL9HT0GhzsQWBmluwa2STfULgVVDt+zgu
         xbA230ph485ISpYl1i9zk4dD9splPYG3JNlj/vn7MZCAI0WQrV5j0altX7LIhsHxU+rR
         sA+zhTjlxHUGn+pJVOWpRJuzzp8J6tYLDsClad0cYKONX5aVvLXMcUUA8owtm6p53VFu
         vWxlOT6M5GKa7A5ivvGjsoOiABW+nwQrmTy+4TUB/FNV8RtRkcwbgGbzm883mZwN6N2R
         OAEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795187507; x=1795792307;
        h=content-transfer-encoding:content-type:cc:to:from:subject
         :message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=9L5DYVZJmCTJDhX0/RtB0BzmznmCbVTr+mYGMw33Evs=;
        b=woB4+wGcDx+vfuRI7vy9YLGW2PYK44KosOn81rPXaOzcRjtToS3NP63XOJ5M5zE3Tx
         VETDvpuHuhNunIeCmTk3ngOA8lYDDrMRb5WBqSfX0HVh2gAa4Aj+qfRnj4/mClB50BRC
         VdLk/rd16ulT9OVxHX9UISm4VoULE9PaVzNMddS1P5U9pGjWv7KWz2t2NDBn+genAkml
         K+nHit3Ms/Z992qINrbBmRBQe0zueOscTA4X0QhJWJjWnQ5GRVnpI+cVNsJcKk3JbgkV
         N0qiAMxru4nGiIuv61aBSChZ808rljUODvscfu6qH8EQlOCCyJNNU8IZVaZVJnSAhvNW
         M5gw==
X-Forwarded-Encrypted: i=1; AL+hErH6VqYyM+LmiZWP9NxMLHtKglNSxD9jl5uVA1hVGOTYp4Y7uPnmpTwcWs4SJxFyqTF+P0U=@vger.kernel.org
X-Gm-Message-State: APuU4Z9uqe5m5rlta94S7M8x2L78gbHDkwJzx+1Y128WnYeqOaBC7hil
	ty1vJIOnAq3RgashpWgKZXpwmEVxKED7Ipw8EGEYHCuE0z1JDsxmLOeorJrKpeAc0gKAudDmAQv
	Dj4KhTs3Gaw==
X-Received: from ejnw20.prod.google.com ([2002:a17:906:52d4:b0:c46:7c51:47a0])
 (user=stefion job=prod-delivery.src-stubby-dispatcher) by 2002:a17:906:69ca:b0:c50:f024:5219
 with SMTP id a640c23a62f3a-c513ab48468mr252861866b.40.1795187506339; Fri, 20
 Nov 2026 07:11:46 -0800 (PST)
Date: Fri, 20 Nov 2026 15:11:14 +0000
In-Reply-To: <20261109084854.840576-1-fuad.tabba@linux.dev>
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <20261109084854.840576-1-fuad.tabba@linux.dev>
X-Mailer: git-send-email 2.56.1.809.ga0b61035b5-goog
Message-ID: <20261120151114.3708208-1-stefion@google.com>
Subject: Re: [PATCH v2 00/19] KVM: arm64: selftests: Tests for protected VMs
From: "=?UTF-8?q?=C8=98tefania=20Ion?=" <stefion@google.com>
To: fuad.tabba@linux.dev
Cc: catalin.marinas@arm.com, joey.gouly@arm.com, kvm@vger.kernel.org, 
	kvmarm@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	mark.rutland@arm.com, maz@kernel.org, oupton@kernel.org, pbonzini@redhat.com, 
	qperret@google.com, seanjc@google.com, seiden@linux.ibm.com, shuah@kernel.org, 
	suzuki.poulose@arm.com, tabba@google.com, vdonnefort@google.com, 
	will@kernel.org, yuzenghui@huawei.com, 
	"=?UTF-8?q?=C8=98tefania=20Ion?=" <stefion@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Fuad,

Tested this series on top of v7.4-rc1 under QEMU TCG (-M virt,
virtualization=3Don,gic-version=3D3 -cpu max -smp 4), booted with
kvm-arm.mode=3Dprotected (protected hVHE mode).

- All pkvm_* selftests pass. The only skips are the self-hosted debug
  (breakpoint, watchpoint, single-step) and SVE cases, which pKVM
  doesn't expose to protected guests.
- pkvm_id_regs fails with patch 1 reverted and passes with it applied.
- Each patch builds individually.

Tested-by: =C8=98tefania Ion <stefion@google.com>

Thanks,
=C8=98tefania
