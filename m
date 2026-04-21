Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF4BA3D75C6
	for <kvm@vger.kernel.org>; Tue, 21 Apr 2026 13:52:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776779578; cv=none; b=YwWPjsAe/EG6fKPt0gUtlWHu0PAH6dHh8L/G2KcR8ylzoma8+td5e/teofE0a51Dtw16fV0GqwFewZ1iT46ZTegPZAaMaVCnVC3Oe+HjhKud1xssQmMQBLKtZQDzecdO0K+ZI4TL8EWBHEPHaIcZfuv+azlMTkq9HTP7nN2QTr0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776779578; c=relaxed/simple;
	bh=r+WwHEnqkbBMU0GIdnMgG7lQPhDE+bh/j2FW8OmYQ3w=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Rnq0EPtAWchJy1lguZpep39UP4qkEc/zEzCrR2QmYCarOihp973o2XYsn+go35eZHcIYOauUGwV/mhSUBQu9LDvzahkj6xczgByx7dUYxFG6XuZ7i6Qq6H9VB8RXAED/BvkFH+/A8LTYUcoR/iM+238/mv076m7m83kTmhOHa6E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=e29tGDTi; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="e29tGDTi"
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-35d90833cacso2692757a91.2
        for <kvm@vger.kernel.org>; Tue, 21 Apr 2026 06:52:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776779576; x=1777384376; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0u/vOf9MRjGdS+aUvxA7BuDlL6EoYtTCq2GhHcWAQUc=;
        b=e29tGDTicI0AzD9Qq3nA6eOpNN4K+QlufIdoEoHLQDawRTL5+BAhPddr7EAvly6sxB
         sWjFonaG9wb2x10xk8LAylJ0FMJqEf+O78XsRYtwaWkQz+OLzItwUoCYvinaGHn0aYjn
         +2lURR8AIz/r+5Vreq6q+xbb94O2mdppq0V3scnZHLE/HVp4gzcuZQSDabQJEbA50+Vc
         g2Ex/m8kU+zszlmzEc0qStToDTCnm5qQLHb5PEhdsoFycBq/y4kGPS5z9uGm304fkP/F
         sd0/RKooiHp0ZQaaxccN6r3IvjaT/Um/iV2g+j5qKnMswiOVNl+L6LfPm9RZz/ZKnODu
         iZIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776779576; x=1777384376;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=0u/vOf9MRjGdS+aUvxA7BuDlL6EoYtTCq2GhHcWAQUc=;
        b=McAr11VXOef2cHi0G85cXxjUyl3C0PdxHCk/4zrW9Ys3oV+s0hrS4RbSrxXA44yWgt
         9eJblFqYxjU6LHzX2UP14guk2qEfFm/httmoX5zlAX35S3o6IHF/LbGOLa32e+svSX3D
         8GjP4eMsCBN9H1VcyrKKAMbcdueMq11D8Ku1RpnOmEIVgMLUX/Bka12TftZIEU5DqRw8
         HaBiO+sgtSHN7P5fJgywcmFCI95MWS5ykpYah36LtuO/HpzZB4BG99hlPyJD52Q8kxza
         Ij+jV1wVV+3c3rG1qckWAVQTw7NhuZtL/Ami3WJvgsLIYg95xx8T7s7QeVQ38DluaRJU
         mUJA==
X-Forwarded-Encrypted: i=1; AFNElJ9j1WTF0sJyOJy6KCqLa/cOaPeBkEHncFqylfwVFpAbrvYANsE8wSSzckiJZ9bMuWWKQK8=@vger.kernel.org
X-Gm-Message-State: AOJu0YyUZNlIyKFphhrzKhYL6+1rwRpWyFZ0zTrTwMWoqifMKiZbNTR3
	9uHub/6MEMO57eCi2iP1Pw+Eqwsy0nDvQJfBMbaz584Yw3fayfRkYeU2
X-Gm-Gg: AeBDietqpwWf7TlK2ACTJ787YbqfluIogJ9qvYP43nuHYimpdoERhIci65TJKTH4gDI
	q7+1mcc0LUQ+wpEstWpuPKruqqdJ1gpqbrtaUm8EYiO1sluwTUy92BN4O664sisWpEYIKFwOVeY
	weG1hGnp3PHjDGjK2A6E3n3RGazmeNH/sgBviIiDoeM4WKPgmoFbFPQy4EJupRXDZTX/fKYCMpA
	W1budSE8u2vKS0RUuqra+Lo64L7GQWZhV/vs1fjnKraHEutuI9Ib/TapnI95mssAA/gz2dpj+pH
	XfeoJVAd8KlOMyh4btqMTGh8sB+vzVqPeZ/6Np6OChQuwSYEXizhUyZGlGA9ne/b6V7Jx0MmOBB
	EF4YVaEpx2PUqFKNIpQt4qjvzo6mHzjPpCcr2i0YpEG05JhwvX2lrqwdsrmyQ78xf/IrrwSHXnU
	9ZlaVfdHH2FnX19nybQPw3Ajc5vEeKNXBGfq9hril++DaexYirLr1WVl8=
X-Received: by 2002:a17:90a:f16:b0:361:4521:d311 with SMTP id 98e67ed59e1d1-36145221bbfmr11784735a91.18.1776779576240;
        Tue, 21 Apr 2026 06:52:56 -0700 (PDT)
Received: from BF-202508301248.localdomain ([39.144.124.41])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b5faa33486sm165571555ad.33.2026.04.21.06.52.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Apr 2026 06:52:55 -0700 (PDT)
From: Jiahao zheng <jahao.zheng@gmail.com>
To: steven.price@arm.com
Cc: alexandru.elisei@arm.com,
	alpergun@google.com,
	aneesh.kumar@kernel.org,
	catalin.marinas@arm.com,
	christoffer.dall@arm.com,
	fj0570is@fujitsu.com,
	gankulkarni@os.amperecomputing.com,
	gshan@redhat.com,
	james.morse@arm.com,
	joey.gouly@arm.com,
	kvm@vger.kernel.org,
	kvmarm@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-coco@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	maz@kernel.org,
	oliver.upton@linux.dev,
	sdonthineni@nvidia.com,
	suzuki.poulose@arm.com,
	tabba@google.com,
	vannapurve@google.com,
	will@kernel.org,
	yuzenghui@huawei.com
Subject: [PATCH v13 00/48] arm64: Support for Arm CCA in KVM
Date: Tue, 21 Apr 2026 21:51:45 +0800
Message-Id: <20260421135145.14789-1-jahao.zheng@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260318155413.793430-1-steven.price@arm.com>
References: <20260318155413.793430-1-steven.price@arm.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Steven,

I've been testing CCA patch series and noticed Realm VM cannot boot successfully when the host is forced to run in nVHE mode (e.g., via `kvm-arm.mode=nvhe`). The kvmtool debug information will be truncated in set_guest_bank_private_gpa. 

Currently, in `kvm_ioctl_vcpu_run()`, running a Realm VM (REC) bypasses the standard nVHE EL2 stub. `kvm_rec_enter()` directly executes the SMC instruction to transition to the RMM. Upon returning to the EL1 host, the code falls back to `kvm_vgic_sync_hwstate()`, where the VGIC save operation is explicitly skipped for nVHE. Since the EL2 stub was bypassed, `__vgic_v3_save_state()` is never executed, and `ICH_*_EL2` states are lost.

To resolve this, I have a couple of thoughts:
1. If Host nVHE mode is not intended to be supported for Realms:
Since RME implies ARMv9 which mandates VHE, running a Realm with an nVHE host might just be an unsupported edge case. If so, we should explicitly reject RME initialization or REC creation when `!is_kernel_in_hyp_mode()`. This would cleanly prevent the undefined behavior.
2. If Host nVHE mode is intended to be supported:
Since RMM should remain agnostic to the Non-Secure VGIC states, the burden of saving these states falls strictly on KVM. However, the EL1 host cannot access `ICH_*_EL2`. Therefore, KVM needs to add specific logic for this scenario. We would likely need to route the REC exit through a dedicated nVHE EL2 stub to invoke `__vgic_v3_save_state()` before dropping back to EL1, rather than jumping straight back to `kvm_ioctl_vcpu_run()`.

I might have missed some documentation or comments regarding nVHE restrictions for CCA. If this is an oversight, it would be great to see a check added in the next iteration of the series.


Thanks,
Zheng
