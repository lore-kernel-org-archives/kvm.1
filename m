Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.41
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795629013;
	b=0nR6BKKwpd3ZrxZqug3oYwwFkgqIYt3QsQZEqZvknpO5s9URp1rkZJaVRDTTu0mR7TIC
	 uBF2E+E0f3lTcPVNKH5ldl3CJOC8CgejJ1q4ABTujjiTqKTInpJhGY/mIRt0udOI3Yzo0
	 7FpKdps38myp09T9SO3DR0ALUa2aG2RguUTCRbrd/lCtkfuO1zxbd7YYlVNs/iSFWDa/o
	 CKOQmiQERtZG0kBcUyf4HTWFZLp8uKhF+4KOkRiCbJusOIwjxrs6McCLgi+axB+xOHXah
	 Dzt+fvlnGoENANvrp6xdVPVvonCMlOiwhjQsIn2oOrIHOUOCNk/N1P6dV0j9iXuY9/Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795629013;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=5p6EFOjA87jcLwyx8NSrFxBVW8rVsjMVihvg88PSe5s=;
	b=HeEOBUcsgdSeiO7/adnvUjqMgfzaO1NSW6bEyyvOpTmhHaBK/kELnMXL3/P2nkqewWpv
	 xjmwSZ6VGWiETfpztMsarNFyF/cSUKVyzNjRx34fkwi90rcDzLo9ZBvm3uVo11v3EOM+N
	 T8CgfUdH5NoliaCsWgyFtd145yCwuAX9l4BEM6tfJpRtgmqXf27aKXvTg9VgHbFTYa/ya
	 E7O26KkwVrrnG3M5aVARYP2e24xU8hrL7q+zMqP4R91g7OtvVasSQ7weX5BnwIf6oV8qc
	 1504XQTaYGXGdwr+dAJx1pBdIN9bOcKLPAkgq/k4mSAOmCcKFbu2yb+Li6sHUR/3wLg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=qOdt7XT6;
	arc=none smtp.remote-ip=209.85.128.41
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EDDD606A321
	for <kvm@vger.kernel.org>; Wed, 25 Nov 2026 17:50:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8EDDD606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=qOdt7XT6
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-4bb69f5b161so39656825e9.0
        for <kvm@vger.kernel.org>; Wed, 25 Nov 2026 09:50:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795629012; x=1796233812; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=5p6EFOjA87jcLwyx8NSrFxBVW8rVsjMVihvg88PSe5s=;
        b=qOdt7XT6AmJlJ13xR8ibcNY90NxkMQsSCVutgz6do2AQU8yTSn7KmFZ3h6/jUbS3D7
         NrP3a4QOmDUo0dPWTCbAfqpdvzy0Ya+giz/eQdVBe/tP+zjx57P3eTfvz907U+ckSJkW
         ELPgiOnacITgVBQHboZcN3XzUwbmy/zQ4oGdinHf3RTHNF2DQemNgbtIX2lhkPJcaNxR
         yUnb9XMSfVUgkb2S0n1SL86Ru3p9Uvz8lD3Q2ndUoxyPNE+HfGLBwKZxeurNMvYyT1YK
         nyj7SsajYULSp12v+xKj2okHBXD/+Xm1D5NYMArOeCTf/aU3zjQfxzQM0qjPCAVCZxWU
         l2xQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795629012; x=1796233812;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=5p6EFOjA87jcLwyx8NSrFxBVW8rVsjMVihvg88PSe5s=;
        b=Zau63uVFNmPWsuQS5VpzRdudCLlKhKh0a5virLrQTzJPn8a2H7SVqoZYITaxSHO+/b
         J0OidRP2Gyrw5xCz8DX3J2Bx5T24/uO24FFIIDzgz2401jFYCAOibqbirBYh6uY8Iy83
         IjtT3y8k0+Cdmbr9yjoWeawCmPK+/nxLiOOCkuqOuwPMrSX7VD57a9i4hd20vwldtD6e
         xIxCOlPYlYtAe3rhGlxltconzWbz3MxQkxgylTNMI8SIclJgqbK1FFe2oDPmrMg/Zm4v
         FzVsf/CF5oV7JrIUbeAIC+AhoR/1+q5xwN1KFA4uaPnePBVS0mjc7V8/HISSRJaSwdUW
         y8ag==
X-Forwarded-Encrypted: i=1; AL+hErErSdly1Ok6ihZ2+QDTssgGsoUZQej63KtsI5TAjrLK1yXL5sCkcp4vZA4KJF5S1fsMNcY=@vger.kernel.org
X-Gm-Message-State: APuU4Z99wNfJ0isZBRWJwr1WoRquAoEDGmLys4iuc/Yv0xzK0OdIzl4K
	vCrGos13Plxt8iM08TjWNKWSqGCJkL3HpUxA4ZyL+y4udVVMpoCQNGuP
X-Gm-Gg: AZFdTZcDMJ8y4U5BjHHe/TSGRIabbS381SN3e4yzd9QRS28AekqrfC7NUmPDsc/6z2r
	coWor0Zmc1VjCMwAECsx8k/Hjvvph5vx1XVZlz4bBl1T9wKK0qSHosjgidXylO69pJzDlN3/BAv
	VBnjVFha2lPSJTQVq4MWCrasBA+8l4vhZb1Luu1EeUqfXFvCM8ll2iiBB3ryJ6VRcK/Wd38B71D
	flmzfixRJV4mn7/5JZp53GxIWNQHKl3BhYlanZhRHRIFC6gtsiCNfcP+pNuOoWxUeK8X0ZKnzdR
	Kz9Bx0n3pZ9Y0cj1b43FDJNRBL3gbFX0VAsMKTZi2Xx/xEGtvYHtOYT+vsmBCsNtl6cWjZvwEot
	QrFT9KXMODmNzHCvEZsyLtGv2X/6BwOLoJvayTT8BnZ/kUuIaADesuWJkvJ6xD8ObOFf/fQkk3/
	MNCDC8N+wGy1TXxPXZXRaQ/rNt1alKP0gdqYZTjKsks2DoQLfcKVZc769mBkk5k87JeZPHqD01t
	h+ipxxSHvZiQy1C5aVkT6Ddk+EqIvSEBp2TFf6QaAhw0JDJuILpfgcfPK+G80LOsmwOx9bFNnMh
	hv2xzrjjdbXNhMwGPF0dqukfWRyB0TPxkW3bgFMtcJO4iLPtsoM2CpCa386IxEmvocJYJ5fi3mq
	8gRASCSQekWAOMDO7nDX1LNXe
X-Received: by 2002:a05:600c:83ca:b0:4a1:9661:14b5 with SMTP id 5b1f17b1804b1-4bb888176eamr378604125e9.29.1795629011682;
        Wed, 25 Nov 2026 09:50:11 -0800 (PST)
Received: from PKL-HASEEBA-LT.. ([39.36.25.192])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb906cdcc1sm301652845e9.2.2026.11.25.09.50.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Nov 2026 09:50:11 -0800 (PST)
From: Haseeb Ashraf <haseebashraf091@gmail.com>
To: Eric Auger <eauger@redhat.com>
Cc: Haseeb Ashraf <haseebashraf091@gmail.com>,
	Peter Maydell <peter.maydell@linaro.org>,
	qemu-arm@nongnu.org,
	qemu-devel@nongnu.org,
	kvm@vger.kernel.org,
	Haseeb Ashraf <haseeb.ashraf@siemens.com>,
	Eric Auger <eric.auger@redhat.com>,
	Marc Zyngier <maz@kernel.org>,
	Mohamed Mediouni <mohamed@unpredictable.fr>,
	Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Volodymyr Babchuk <Volodymyr_Babchuk@epam.com>,
	Khushit Shah <khushit.shah@nutanix.com>
Subject: Re: [RFC PATCH v2 0/3] arm/kvm: select an nVHE-only EL2 with SYSREG_ID_AA64MMFR1_EL1_VH
Date: Wed, 25 Nov 2026 22:50:05 +0500
Message-ID: <20261125175005.805533-1-haseebashraf091@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <63fcaf35-5d3f-42fb-868f-9fcd644bf494@redhat.com>
References: <63fcaf35-5d3f-42fb-868f-9fcd644bf494@redhat.com>
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

Hi Eric,

Thanks for the feedback.

I agree that exposing VH as an exception is appropriate for now. KVM
does not expose VH through its writable ID-register interface; it is
selected by KVM_ARM_VCPU_HAS_EL2_E2H0 during vCPU initialization.
Keeping this explicit avoids prematurely adding a generic framework
mechanism for which no other field currently has a requirement.

On the second point, my wording was imprecise. KVM updates the
guest-visible ID registers automatically after vCPU initialization, and
the guest sees the derived ID_AA64MMFR4_EL1 value. I referred only to
QEMU's cached isar.idregs[] copy, where the framework currently deposits
the explicitly requested VH field but does not re-read fields derived
by KVM.

Thanks,
Haseeb
