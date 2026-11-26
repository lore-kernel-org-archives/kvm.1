Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.53
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795670872;
	b=UzNwxw/xYTeATeSAFPCXRQ5weKNr/Ea322nQOGTPwFgQWokPz98ROt1YGLsLCL5pClad
	 EziTlzpWogs1KTRReIWfmD8fHOJ5Bm9FjWRev6EayU+G8xB5V/XqHteJO94G7pKrN5zxY
	 pM0AbRLMclZWtU+EPjv6k/xNU8k2Hpp8n+u9TUXqaXdz2+Ws3g0sykevZ4sMZgih0SJs/
	 G7TR2XJC91aglnZyRwdiXtwVJU3NZZoHrAZj/gZendfMXAN7Ju9dxLRfk1tJBzp9EnEX5
	 SshqfM5yzsXNVItsw6TIQDUiM00B5TulAIIVHnOfWx8VWkrrGSAkNYvsigYAAV88VAg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795670872;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=AkjNBLINr97Ghaaxsr3+fYKKHZYr6vV/k1JPP2Uq09A=;
	b=BKKyzfyP4K+dcMamscMzXzws52ZuBPvqFrI5M8fV1wF4ZvkoCgnHBAe5uhPlXDSTGViw
	 gwyOZhGNn3huW5PNMgM+IMKV4TOF73WNpqv324LYL2AKFUMr3HvEZDkjw1wB9Zyi7sJYU
	 k/U4Oo76WAzxK/+aDstZXDuxPDUGHzEs2RoflC48bH46b3X7x0/LU9bbRDBN5D9D7pX4u
	 KUJjTaKXPjP2Wgoti0R5F4KaqXtOSan8BndMHf3gjCFXgY4SuPLiCi/i6tkaqWcTy/Q/e
	 NjErzHQLkMsTtM8lXRIgSlwmlYSagVa8VfYnF9ccs7eWNoDku48m05q4U7BoGjr/mdQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ZBzXa+K5;
	arc=none smtp.remote-ip=209.85.128.53
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06A86606A31E
	for <kvm@vger.kernel.org>; Thu, 26 Nov 2026 05:27:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 06A86606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ZBzXa+K5
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-4a5177d78c7so65381375e9.2
        for <kvm@vger.kernel.org>; Wed, 25 Nov 2026 21:27:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795670869; x=1796275669; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=AkjNBLINr97Ghaaxsr3+fYKKHZYr6vV/k1JPP2Uq09A=;
        b=ZBzXa+K51Pye9EjYRnqJ1kcvggkoeut3SR+LJDDcaNempVVKx/q+MX083dv5qI7TJW
         UvelUbnzilDFRpWKTntLdoZ+qIe4yoDE+Mf045VHTMsoiKWuykSevQeiBGn2/40wU+4x
         1i065hQfv799cP0FmJ7Cm07xdz/idH4cOTDo9aztJmQcoKHJhk3Jt8pFNoh6JW82D3TQ
         O4I7M2Wg3OImYeFw3QsoWfCm3AS0zp+75xYewyFskKWbfkUa0AECyrmL/sQZkdYXfGN/
         GNj+ESORhMFzvoisJTaJ/2d7gfKQEXW7EswjHJqXDOj17IOkRq2xWSdFWIX6lgpolD4L
         TJbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795670869; x=1796275669;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=AkjNBLINr97Ghaaxsr3+fYKKHZYr6vV/k1JPP2Uq09A=;
        b=2ddiEVFozoafOWUTVZrSVh9dru0qgvo2eA306jLiN+TXQssobJDg0PMlr5JqTF+45a
         gw5S/I7ocjLESslG6oOH1of9yLdiIawyfX3YThUs7WOYqSXW36l9ZDE8cNRSGczZ8GMi
         +hA/aP0zD7QkzTHIV9Az7OeEqrjijBsUs4FP/5RBuV0G9Jo2+bKgRseJpCzjwkEt1jm1
         Q2+Fey6dJnx6U2aT8SCt/UCJx0lT1t1SDnm/mJcfg66vnU+AtMIxPy6wgGKK7DZOaWQn
         SrsYD5HbgXIIxXvsDyFCYLoqPHtj8Og2xYMpzZVBT8uXyFmBlSXU7PQWqeD7ZYWpXUdp
         UAdg==
X-Forwarded-Encrypted: i=1; AL+hErGVI3noqXElD4amxWaWz7VLD3ybQyQVAr05TKzmcmlcjgPutTcp10LAatd4JDRSErZYsVI=@vger.kernel.org
X-Gm-Message-State: APuU4Z+g2QMRSTuLI/MgBcaOGLkT+E19zzDKubHZOSpAd0eOiQJhYMbJ
	vpKQn559R23bY2IAekm7LMaSV0gjYEKK/oSVrA81She6K3hfQBz1rPP6
X-Gm-Gg: AZFdTZfeA3L1rWcy/i/3F+7sGQxFAGlDmOe+GehfQBIy+jZ3GFoAwpV18aSINCIFfAW
	wLf9U2xMzti768ak2CflrX/MPtGtrNc2i7XILHAAZBaeqVLhC5FlOrLSjl0h0DZuZHgvfcG5W86
	PHhuBB4BxuW8VWQncYidWDoxGwgpTWDstH93vf7KSz3/11RxUL1wIl6su9L+ujjsY5MPj3VZRS8
	3W5+gAKe2SxVHOuXlAahQHHDvLS8hL6FydnDEwdGOl/7x6biZ2Bg/1YHvo1XYsRzByZTyEAKd4D
	S+MlpvwkMewyoAHrtY9Z4Lz3T/zId7La7BZVHNl972oBjU1EEP336vHNMOz5oMFDpTJqbmPVsOy
	sIIpw4ZyZFt0sCzPZ/HoM71GuEK75olr86AntBm52t+JDv5HMID3bn4Pm/BVpUNBSDVJrulggjF
	A4kxHoiE3ERMHZp77ttUZUhWf7IMhkw5/fOZNSLRixkP/qoqjkWqcUbPVofAdmSXXPvsAOUpahq
	ujsvTlCUnsSpKXMbmdYt/GqPxpbuVEtCmifRVwrzoTgs+aFHQ+f2BLv25bN0wrGvq2l99LLdTyM
	pI1wR+w/LJa1UldNZilVsTc/s3t8xvvSzUVvG8apXAjJ5fHLjrLvupxk5RCOUQtvkinGNF0A+An
	+wqWrUzV1IQ2yyxjqVtpGynmlYnirTT48Yl6lIbfaND+JqA==
X-Received: by 2002:a05:600c:1548:b0:4a1:e00b:a10b with SMTP id 5b1f17b1804b1-4bb88800020mr427751485e9.7.1795670869141;
        Wed, 25 Nov 2026 21:27:49 -0800 (PST)
Received: from PKL-HASEEBA-LT.. ([39.36.25.192])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb853b2437sm808310475e9.13.2026.11.25.21.27.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Nov 2026 21:27:48 -0800 (PST)
From: Haseeb Ashraf <haseebashraf091@gmail.com>
To: Peter Maydell <peter.maydell@linaro.org>,
	qemu-arm@nongnu.org
Cc: Haseeb Ashraf <haseeb.ashraf@siemens.com>,
	Eric Auger <eric.auger@redhat.com>,
	Khushit Shah <khushit.shah@nutanix.com>,
	Marc Zyngier <maz@kernel.org>,
	Mohamed Mediouni <mohamed@unpredictable.fr>,
	Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Volodymyr Babchuk <Volodymyr_Babchuk@epam.com>,
	qemu-devel@nongnu.org,
	kvm@vger.kernel.org
Subject: [RFC PATCH v3 0/3] arm/kvm: select an nVHE-only EL2 with SYSREG_ID_AA64MMFR1_EL1_VH
Date: Thu, 26 Nov 2026 10:27:38 +0500
Message-ID: <20261126052741.90607-1-haseebashraf091@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261121204601.741616-1-haseebashraf091@gmail.com>
References: <20261121204601.741616-1-haseebashraf091@gmail.com>
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

From: Haseeb Ashraf <haseeb.ashraf@siemens.com>

Hi,

KVM presents a VHE-only EL2 (HCR_EL2.E2H RES1) to a nested guest unless
KVM_ARM_VCPU_HAS_EL2_E2H0 is requested at vCPU initialization. This RFC
lets an nVHE-only guest hypervisor request that mode through:

  -M virt,virtualization=on -accel kvm \
      -cpu host,SYSREG_ID_AA64MMFR1_EL1_VH=0

The series builds on Eric Auger's remaining v11 SYSREG framework. It is
based on the rebased prerequisite commit corresponding to Eric's
arm-cpu-model-v11-rc tip e32893ddcbe643d47919f55ae33ff71be2609a77.
This dependency is intentional: a version which works without that
framework would have to introduce a separate machine or CPU property,
which was the approach rejected by Marc in v1.

References:

  - Eric's v11 series:
    https://patchew.org/QEMU/20261030131406.461599-1-eric.auger@redhat.com/
  - Eric's v11-rc branch:
    https://github.com/eauger/qemu/commits/arm-cpu-model-v11-rc
  - My v1:
    https://patchew.org/QEMU/20261121095636.289814-1-haseebashraf091@gmail.com/

Changes since v2:

  - Apply init-driven SYSREG properties before creating the scratch
    vCPU, so full CPU-model expansion reflects the requested init mode.
  - Refresh ID_AA64MMFR1_EL1 and ID_AA64MMFR4_EL1 from KVM after vCPU
    initialization, keeping QEMU's cached model and QMP expansion in
    sync with the guest-visible registers.

Eric correctly pointed out that KVM already updates the guest-visible
derived ID registers. The v2 gap was limited to QEMU's cache/model
expansion view; v3 fixes that without changing the guest-visible
behavior.  With VH=0, query-cpu-model-expansion now reports
ID_AA64MMFR4_EL1.NV_frac=0; with VH=1 it reports 1.

For the init-driven property question, this series keeps VH as an
explicit exception because KVM_CAP_ARM_EL2_E2H0 currently exposes no
writable-ID-register equivalent.  A generic framework table can be
considered if more such fields arise; there is no need to add a broader
abstraction for this single case.

This RFC therefore also asks maintainers to confirm that using a
SYSREG_<REG>_<FIELD> property for a value selected at vCPU init is an
acceptable extension of Eric's framework. If that model is not
accepted, this nVHE functionality should wait for the framework
direction to settle. The standalone-property implementation from v1 is
available as a fallback for the implementation discussion, but I would
prefer not to make that upstream direction the default again.

TCG and HVF are unchanged by design.

Testing on an AmpereOne A192-32X with host kernel 6.18.29-arm64:

  - TCG-only and KVM-only builds succeeded.
  - TCG rejects SYSREG_ID_AA64MMFR1_EL1_VH.
  - arm-cpu-features passed.
  - All three AArch64 KVM functional selftests passed.
  - QMP full expansion reports the KVM-derived MMFR4 state for both
    VH=0 and VH=1.
  - Linux 6.12.67 initialized KVM in nVHE mode with VH=0 and VHE mode
    with VH=1; QNX Hypervisor 8.0.5 reached login with both values.
  - Xen dom0 reached login with VH=0 and did not boot with VH=1.

Thanks,
Haseeb

Haseeb Ashraf (3):
  target/arm/kvm: Add kvm_arm_el2_e2h0_supported()
  target/arm/kvm: Let SYSREG_ID_AA64MMFR1_EL1_VH select an nVHE EL2
  tests/functional: Add a KVM selftest for an nVHE-only EL2

 docs/system/arm/cpu-features.rst     | 22 ++++++++++
 target/arm/arm-qmp-cmds.c            | 38 +++++++++++++++++
 target/arm/cpu-idregs.h              | 31 ++++++++++++++
 target/arm/cpu64.c                   | 51 +++++++++++++++++-----
 target/arm/kvm-stub.c                | 10 +++++
 target/arm/kvm.c                     | 63 ++++++++++++++++++++++++++--
 target/arm/kvm_arm.h                 | 21 ++++++++++
 tests/functional/aarch64/test_kvm.py | 22 +++++++++-
 8 files changed, 242 insertions(+), 16 deletions(-)
-- 
2.34.1

