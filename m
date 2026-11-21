Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.52
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795255004;
	b=VeNzJACXrx0HrfvyMhrlX7ivNHXZ1x6wJQhx35+IDhIxkSwz3BHCsL27Gb0Zp5ahLuC3
	 JWoIZPcdgobFhot8+HHOtCtE7bdOcxgw4Vsvja2oc1IyHyWy4ulvsr1C/gQY/BDvV7JRI
	 oVNBheNLtoAoZmn2dwA9OPQBu6D9zKoLe7Gn/IrYRvrR3ZQsFQaZH6/HcRoxvQxuAFOSj
	 YoyGK8cQJZhssxD+wm9orjDjyhvV0DGgEbeSPK9wm64Sra8NExpB/oRJaJhklqlJzL+Lc
	 bilE/p+KBREa85E+AMULDT/IzizuuCKKSIf4Yq/Sa0tdPhJYB7tCHJOqLoe1AdmKcxw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795255004;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=mjaLMzSfEvQAVnmmmaDH+RrdPNS8d+XwRyrHjllT/B0=;
	b=KdDgngGvrh09HyaQ2j7vE5cIIJYsXoKBekjjJ9oGYk4zhAIZhDQyq5z9ixApjbP/sXas
	 v+0FBxmCOLyRKU2Sr8Rn3FVvzzM/XQaCtq18mzN8TrGFsVks3uClxILcG/cMAW4FdldT9
	 bG9MFqWVQDt7eMMZdqJjUsCpVuMz3ARzseU+nqJ1N/K41Pxjxkr4jMLgj+Ql/4btkFt72
	 2afKsR6oR9jCAJB6QMR48YcC93wN0yoFT0CyZtCl0yA5XpLfgoLkdOfS227cnW+R39UFx
	 1VHjihfbH8lGriSKU+/khQxpBt0FHgJZl592MSOQBSN7sVX+Bnqh/z8pJvoUSgS7coQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=XMArjb5U;
	arc=none smtp.remote-ip=209.85.221.52
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 875C3606A320
	for <kvm@vger.kernel.org>; Sat, 21 Nov 2026 09:56:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 875C3606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=XMArjb5U
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-48e09aa5264so915442f8f.2
        for <kvm@vger.kernel.org>; Sat, 21 Nov 2026 01:56:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795255003; x=1795859803; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=mjaLMzSfEvQAVnmmmaDH+RrdPNS8d+XwRyrHjllT/B0=;
        b=XMArjb5UXaKkPiWfJkArNuPz1tRdDA+/NaJkSAHtWQATC2Gdvu1Bby8rnPZMYLaBBk
         6QS5ZJsXsFYu4csbJ0p7+vwLJXjm7ZQ5gsDlil/zt10wrcR4n5Kc7bq3zaD2S/SOm/cT
         zS3aOIDF8yjfTwIK8BAcWaCebCVy1f2Q3ogXLrCrldd8ZJNR8qVmzQ/SD/ThqswSNNS6
         eKxUfgfEVQDXo7mzQZAiFkfLCSR2cGdLUTlLncPV7z35h+eFGr6Pd0FqECregm0bdtOG
         zFhxJhzQwPivMWHwiL42+fpIoD9doc2dDM2sh5RiSBKDYUQNrdaOgjDlt6GOUVAXatDx
         9imw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795255003; x=1795859803;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=mjaLMzSfEvQAVnmmmaDH+RrdPNS8d+XwRyrHjllT/B0=;
        b=JA93WxNE6lEqqp1JhLRHd3zK8v63vbmJDUnVIBIpE4h0UZzrCDLKAKLwRwBI+DKpyB
         QHku0R0odpyT+44xuDX1Nebg9zYp5Glu4F+X4GWzbVzGEdsJLoCedsRscZc41FkkIvzH
         bt85MgE5bTAkQKuV4Wn0IH60e5Zsw9/sGuTB2tziEveUa9/5HWIKWcQBL5C+X6s5Wu0i
         Sx4Qi6/FIww/r1cO3W1flVhz+cyAiD5F1GvkMR70LVYoNHVtcQ1bIlL4FO+P1AYM1RrB
         xJvJxVCVmjZZIwEimwU4WVEExDPzLwu4ORyGWWRtPWu3zkX9vsGwpf5YT+eUH1FtX+1/
         yEXA==
X-Forwarded-Encrypted: i=1; AL+hErE9SQl3s/8YuAA3il/duj2mE3FjkP2EP8vVRLg0zp59h3aVKa60r97AKJRkjjXgXee3Lm4=@vger.kernel.org
X-Gm-Message-State: APuU4Z8E74VZJA71tLUtMAdaFExaxCj1WAyMm1HCzpgvzC+T/M7S4U4q
	n1fN8+IKJvhmiiZ2qZjmN+EZpNZ5/C+JVn3q2YagVekAZig1kL0YQCLL
X-Gm-Gg: AZFdTZcYnhvffzKwWRJ8irfvL7P+Bbvij8trEIuw0hwiisZ0Q5ITRwcabVn3vvijy9f
	TxG2bMw1+JP68UbmN6HeOPXoVAEhmsgw5Zoo6moi5GxBR+AUG6mP8n8//T8S/NSNxBn+uUbKGf+
	62NiDqZBFgykixlzZjetB3TPlLoyGoClK7FwS72WGLaDKpMavDce4K+iYesmc3UFb6iicPypwnB
	U9VpJaKe7Xmml202GzT29X4JX5XvvAkaczrC1y1k6u7Yc3XnmN8iostVbdAGlj+5c1cfT6Z+3Ln
	dM49VtrPVed/O+s6LSeos8lgOjlr2Z+mQ/sbdG98iryh/H11Rt/7z2jK/s9mv6WVuGQ5xVCoYYS
	u8idEBAVnBblrLQnGyJ+i6LNQA4okHRqvddn1XhmBe8tAu+1XBUFNL94cWwCeqWogecYb8N32/k
	evqyGgltt93SXnQMMJwhj3yyOQjDxTXQ61iUxJiMk5AHYEOOTpZHtDqh+a13mzWBw3IHqk16uIQ
	nwnHMQoBpzucmAOWD+f5DCWH3JRVGy7Re2HcM8bE9y3e30TDZjTqmBwofgB3BWoubqNf5fuXSmM
	iXdy+RWzSScvWNSJP5ienDHrUDqQ7zIRDI96yDBJac7pBLqznXNdzuN3yT6/0GjnqkfCGPGjHTl
	W0LZEu0mzAaJjm6j7urZjU20u
X-Received: by 2002:adf:e010:0:20b0:492:b221:ac38 with SMTP id ffacd0b85a97d-4abb2ce4bb5mr8957776f8f.26.1795255002703;
        Sat, 21 Nov 2026 01:56:42 -0800 (PST)
Received: from PKL-HASEEBA-LT.. ([39.36.59.78])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4ab658e2e6dsm10741748f8f.6.2026.11.21.01.56.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 21 Nov 2026 01:56:42 -0800 (PST)
From: Haseeb Ashraf <haseebashraf091@gmail.com>
To: Peter Maydell <peter.maydell@linaro.org>,
	qemu-arm@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Volodymyr Babchuk <volodymyr.babchuk@epam.com>,
	Haseeb Ashraf <haseeb.ashraf@siemens.com>,
	qemu-devel@nongnu.org,
	kvm@vger.kernel.org
Subject: [PATCH 0/1] hw/arm/virt: add vhe option for nested virtualization
Date: Sat, 21 Nov 2026 14:56:35 +0500
Message-ID: <20261121095636.289814-1-haseebashraf091@gmail.com>
X-Mailer: git-send-email 2.43.0
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi,

The virt board currently enables VHE whenever virtualization=on.  There
is no way to expose EL2 in nVHE mode to a type-1 guest hypervisor.

This series adds a vhe machine property, enabled by default for
compatibility.  Setting vhe=off propagates the requested mode to the
guest CPU, limits TCG's advertised VHE feature, and requests the KVM
HAS_EL2_E2H0 vCPU initialization feature.  Unsupported accelerators
and KVM hosts fail clearly instead of silently ignoring the option.

Validation was performed on an AmpereOne A192-32X (Ampere-1a) machine:

  - KVM with L0 kernels 6.18.29 and 7.2.11:
    - Linux 6.12.67 initializes KVM in nVHE mode with vhe=off and VHE
      mode with vhe=on.
    - QNX Hypervisor 8.0.5 detects the requested EL1/nVHE or EL2/VHE mode.
    - Xen dom0 boots with vhe=off.
    - Xen does not boot with vhe=on.
  - TCG:
    - QNX Hypervisor 8.0.5 boots to login with vhe=on and vhe=off.
    - Xen dom0 boots to login with vhe=off.
    - Both AArch64 KVM functional self-tests pass.
  - TCG-only, KVM-only, and aarch64-linux-user builds succeed.

Thanks,
Haseeb

Haseeb Ashraf (1):
  hw/arm/virt: add vhe option for nested virtualization
