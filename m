Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.43
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795293970;
	b=RCjL0n/YbQGqUZzIdp6joZ/IZT01AbNulfM8AgWFGXWZY2EdhLLwVW7t1bMGsYQ8X3ev
	 jrX7PohxHnz5zzizAVgEMLMI4VOS99LZIPPuKBcm4ubuIMj7aKL4b7EO2dEFcnx2gFo3s
	 Fe/njWNjB1+56TnoOvgQWHrk9xx66qzjPlzWdgmJIBWAqyKW+wW7T2itqqZr1GhH+W4x2
	 5/64jdzU0J2JbcSeJR2zwPvySxnhbPx2JOvkxIrgy48qLC5F6/aqhQtyk0zzrko0TAo2K
	 GOrk/nnUiwTSl6yd8FyaWG/mKL/Cx8B7wN1ARSEOJSasUxvJ95fE4AnNK0NdWqOWqHw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795293970;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=5CEcBG3blFgFIs0HQDqojA8cBNelrZOI2gSACkV84r0=;
	b=l/z7DdFzFCFbRZaQKM3LGNYSjW+374m0baZBT/+niMf2IZDupfmZECVKNRWKLv5CWCBH
	 CDcE+npmuSOaPJhzMwG839CyxRVdZCD/cPZwjcmwxKItsFHdYqh4XfnJZdK4DWhlsbDq8
	 JsZPpFozmFM/J5zl9G24ILNPlA3K1G4zgLZ1CLuRN5WciFppPPJGe6w8xs5y/HOtuBKTW
	 bEkyYkGJMl6lQlmBcrhnj3e2k4LJGXKqQK9yac5+i2vCtq54bMlb1FSnqN6hcuoyRwUkZ
	 Hry9FvxfAnjmtemsF5kNb/R2ouV/r6db8XFEPibkOFV/HNLDHfiyLEAXt6WWyinNBcA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="eo/BjGja";
	arc=none smtp.remote-ip=209.85.128.43
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9AE5606A320
	for <kvm@vger.kernel.org>; Sat, 21 Nov 2026 20:46:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C9AE5606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=eo/BjGja
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-4b79502c27aso17318185e9.1
        for <kvm@vger.kernel.org>; Sat, 21 Nov 2026 12:46:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795293968; x=1795898768; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=5CEcBG3blFgFIs0HQDqojA8cBNelrZOI2gSACkV84r0=;
        b=eo/BjGjayO6WVRVrBju6qUVHy0khmQU9n94rvAq445RDUlCpxu79owhfWqFzYApMfa
         R5l1EHeYXoMNsfqrliqm9O2L87wJKojtl4JoFaBtMXeqeo+eCipdLYDU1TqAfrT5NBLG
         QlVYkl6cgNRz7sZxjmw7a07rfMtIH5LfY4IHQHj5n0f/U7eiBrCMa7glk45GTeRd+/YF
         eTZVbsFDd9KwAVnqN7ohBDW6oSIE+KVkFrxBYLHJ1dwU68H0L8ax7uroYRWraI6DiYc6
         yNBEwNJcmh0fzWGmr9lvhpC6NJkHN7U3X9LEJvuXUCr/okr0NOQJwDZBHi6cycq1O3An
         V5yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795293968; x=1795898768;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=5CEcBG3blFgFIs0HQDqojA8cBNelrZOI2gSACkV84r0=;
        b=KQX3Ry63rvG2im9cz+ksUcueqMm/Rm66OjFDqiqgWb/M1iCy28dWZonLyS3NwxOUpL
         Z9KL3oyYOR4HXhsX6klO40JTbaciqDNSrpK03x0/77t9z1Kq/ht97mzpEffX35VA7OLi
         0Q2mRaCqFBTt6CHJKGyY2hINJ+vV45jYSccdgpm9BzI962+L2ZdLGwVtEByWzCLIYzVi
         Nw6sqZFLmtrPgZDu3e6szpNe3UbF07qcMBzqA8SQkQcKEAF65EBv8xMubWYQqoBg2I1K
         5SF/wlLZU31yzachURa2qrZRNYqIT66SohTjuqzlv1stuDeC3h1e4PLhxr3ngdOyGGk8
         if4Q==
X-Forwarded-Encrypted: i=1; AL+hErEusgtZxa3QhFw+6fMwTHPk8SB0goCioMRNvLBC21Z5/UX7+zg7PCiJdKtyXHJnQIaU1TM=@vger.kernel.org
X-Gm-Message-State: APuU4Z9nE2ODmEnTFxRT46oKonbKl0ZT6xfsgx+e1vYDIeGTGub4HUUC
	y1GMsrdF+cguJsh17E55Mbd4pkRhHLrmCDobrT7OFYpCTrpUyCC4UGcW
X-Gm-Gg: AZFdTZf6rXWCjuBeNa5FgfsTEuSzvLAMZSzJmEpti3tKYWoKHeONLIaXCVfcELNXtX9
	QFpt6ViixZLSQWbAMefBTkdYckuPeaPE2scLlrnQVh98DmB6h1Kr84Ysj2O1XRwa/E2kHdIY5XT
	M33myrtQCaQd6X/iBO3Yz8yiRQwx8tTQ7mbtN+QudswvLeFNlCyJ0oTxDL4E4xZpnjihmE2i6YU
	XblfGjv0SwvhflRQbN6RLio4dbOQA7dw8Ilkv8+Vk/zIwofLvwijPBW3FXDdz2u/Eec+uSDhC8k
	w38L6B3sjAIHoOmN31zw8DZDo2PMMab/e8dowxRCxNnX0XGHgCccDXVmki2UF05Y9f3JqqXxp10
	SrJWmGUohj3aVO69k23HsDyAiRQBWfiu2EDRgtGA5pnglO4KdP/KgFNVK+oVPYSQY9i+3NlPCY1
	RwuE+aurmUonYHhg1O/geZDrTyNrokyPHTxLwVlXG0zPcikMq+k/0zoZeMc9UaV8/st9teKQ2rf
	pw9+ByaffI2Ba9ESpNKEilGcBTjpicZRU8kNlDoB0xNuFgnK40sHnpDh+B7rqXOhV/xSMVyksHC
	xBterfCO4DwRDFohmrWIRWZnblomQvhtR6WzwwODa+l+BlY/xGXWx+5QAOOa8cZ2jpvdNVDwcJ7
	DsZJvP4vgEm1TgXsZg8SvbBY=
X-Received: by 2002:a05:600c:19d4:b0:4a1:f377:5c6c with SMTP id 5b1f17b1804b1-4bb8880ac6amr157380645e9.10.1795293967927;
        Sat, 21 Nov 2026 12:46:07 -0800 (PST)
Received: from PKL-HASEEBA-LT.. ([39.36.59.78])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb884b39b6sm180652385e9.12.2026.11.21.12.46.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 21 Nov 2026 12:46:07 -0800 (PST)
From: Haseeb Ashraf <haseebashraf091@gmail.com>
To: Peter Maydell <peter.maydell@linaro.org>,
	qemu-arm@nongnu.org
Cc: Haseeb Ashraf <haseeb.ashraf@siemens.com>,
	Eric Auger <eric.auger@redhat.com>,
	Marc Zyngier <maz@kernel.org>,
	Mohamed Mediouni <mohamed@unpredictable.fr>,
	Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Volodymyr Babchuk <Volodymyr_Babchuk@epam.com>,
	qemu-devel@nongnu.org,
	kvm@vger.kernel.org
Subject: [RFC PATCH v2 0/3] arm/kvm: select an nVHE-only EL2 with SYSREG_ID_AA64MMFR1_EL1_VH
Date: Sun, 22 Nov 2026 01:45:58 +0500
Message-ID: <20261121204601.741616-1-haseebashraf091@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261121095636.289814-1-haseebashraf091@gmail.com>
References: <20261121095636.289814-1-haseebashraf091@gmail.com>
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
KVM_ARM_VCPU_HAS_EL2_E2H0 is requested at vCPU initialization.  Guest
hypervisors which only support nVHE, such as Xen, cannot run in that
mode.  This series lets the user select an nVHE-only EL2 with:

  -M virt,virtualization=on -accel kvm \
      -cpu host,SYSREG_ID_AA64MMFR1_EL1_VH=0

Following Marc's feedback on v1, this is built on Eric Auger's
SYSREG_<REG>_<FIELD> framework instead of a new machine or CPU
property.  It is an RFC because that framework is not merged yet.

Dependencies
------------

The series applies on top of the remaining patches of Eric's v11 [1],
which are on his arm-cpu-model-v11-rc branch [2], rebased on current
master.  On current master those patches need two mechanical build
fixes: object_property_add() now takes &uint64_type_info, and
kvm_feature_idx_to_idregs_idx() must sit after kvm_arm_sve_get_vls()
instead of inside it.  The fixes belong to Eric's series and are not
part of these three patches.

Questions
---------

 - KVM does not let userspace write ID_AA64MMFR1_EL1.VH, so the generic
   "writable fields only" rule would not create the property.  Patch 2
   treats VH as selected through a vCPU init feature and exposes it as
   an exception.  Is that acceptable, or would you prefer a generic
   representation of such fields in the framework?
 - Only VH is updated in QEMU's copy of the ID registers.  Other fields
   which KVM derives from E2H0, for example ID_AA64MMFR4_EL1, are not
   refreshed.  Is that acceptable, or should QEMU re-read the ID
   registers after vCPU initialization?

Scope
-----

TCG and HVF are unchanged by design.  The property is available for the
host (and max) CPU model with KVM, when the host kernel advertises
KVM_CAP_ARM_EL2_E2H0.  Xen and QNX already boot with TCG, where
HCR_EL2.E2H is under the control of the guest.

Changes since v1 [3]:

  - Removed the dedicated virt machine and ARM CPU "vhe" properties.
  - Switched to Eric's SYSREG ID-register framework and use
    SYSREG_ID_AA64MMFR1_EL1_VH to select an nVHE-only EL2.
  - Exposed the property only when KVM advertises
    KVM_CAP_ARM_EL2_E2H0.
  - Derived KVM_ARM_VCPU_HAS_EL2_E2H0 from VH and rejected VH=0 when
    virtualization is disabled.
  - Added documentation and a KVM functional selftest which verifies
    that the guest hypervisor initializes in nVHE mode.

Testing
-------

Validation was performed on an AmpereOne A192-32X (Ampere-1a) running
host kernel 6.18.29+3-arm64:

  - TCG-only, KVM-only and aarch64-linux-user builds succeeded.
  - TCG rejects SYSREG_ID_AA64MMFR1_EL1_VH because the property does not
    exist for that accelerator.
  - The existing AArch64 KVM nVHE and VHE selftests pass under TCG.
  - The arm-cpu-features qtest passes.
  - Linux 6.12.67 initialized KVM in nVHE mode with VH=0 and in VHE mode
    with VH=1; both boots reached login.
  - QNX Hypervisor 8.0.5 reached login with both values and reported the
    corresponding ID register state.
  - Xen dom0 reached login with VH=0.  With VH=1, Xen did not boot.
  - The complete AArch64 KVM functional suite passed, including the new
    nVHE-only selftest.

Not tested: live migration, and hosts other than AmpereOne.

[1] https://patchew.org/QEMU/20261030131406.461599-1-eric.auger@redhat.com/
[2] https://github.com/eauger/qemu/commits/arm-cpu-model-v11-rc
[3] https://patchew.org/QEMU/20261121095636.289814-1-haseebashraf091@gmail.com/

Thanks,
Haseeb

Haseeb Ashraf (3):
  target/arm/kvm: Add kvm_arm_el2_e2h0_supported()
  target/arm/kvm: Let SYSREG_ID_AA64MMFR1_EL1_VH select an nVHE EL2
  tests/functional: Add a KVM selftest for an nVHE-only EL2

 docs/system/arm/cpu-features.rst     | 22 ++++++++++++
 target/arm/cpu-idregs.h              | 31 +++++++++++++++++
 target/arm/cpu64.c                   | 51 ++++++++++++++++++++++------
 target/arm/kvm-stub.c                |  5 +++
 target/arm/kvm.c                     | 29 ++++++++++++++--
 target/arm/kvm_arm.h                 | 13 +++++++
 tests/functional/aarch64/test_kvm.py | 22 ++++++++++--
 7 files changed, 157 insertions(+), 16 deletions(-)
