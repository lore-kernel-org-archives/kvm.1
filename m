Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.228.6
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792486484;
	b=zIuRXRAP+weCGSo8jaFcgej3oPxDxLpQfHREELLh/ZLN5ig0vY1KcnibBOShpFIYwe6e
	 cN6GGSa1bM0gZdzi+BRy4g0fTfs5SDZh+6jd33/cl94LVRoR3u/6e3sPAmWnESqa+tdYS
	 A2iGG0gNO9ByJc6E4ElXGuN5ojnDQKPpVWIGCylnvmBO9s3mmpidN1ppzEQlP6FJ7aP50
	 LQORg/QCMdVPm88Ks9Q3Sl44/7Wj6slK1YuP6OJnfd6oEQP0sbE7hm3hDXtfOeUxidFWU
	 9W0PHBffeBY5dGRQ5pqJwkZV3LJFh/g/OsJ49KM/+0lGAVkOjurwgPGCKNK/aOWVfKg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792486484;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-Id:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=ANGFYDD6Q8p8RwiaN/nK98Pvd1sOcfyNS+EbCCUesHU=;
	b=Px22LVxpUlLbsWKymQGne63v7nMOLgRhoi5E4G9v83aNH/XTjbbBUxAmjB8Asziu0xW9
	 ceVCG2YDiMd0uMTfTA9R8JzXnP4mHgFtwMC8Ra/MFxGu9n61VbAjVQXw+ImmiBtMTNgu0
	 +mgPHlbXEYHbXMJYr1PrGGIC1pDf2pBAF5hEmkF7ni2dupbhoDDbiQfQwmTkhSodT/Tuq
	 Or6UsK8QAfxU4MbI4pCK01oQi0VJIk7xFhe7kwELV8G5PbcXGHNqi16fEOzIc7V2JLVxI
	 2dFDsvADDjGs8doHt8itkCjhdHK2CYm/WXx8EJcU0X4p0LkstSF3bNIUjJEGSPFk/VA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=QttW8XOK;
	arc=none smtp.remote-ip=74.125.228.6
Received: from mail-pz2-f6.google.com (mail-pz2-f6.google.com [74.125.228.6])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E05FA606A319
	for <kvm@vger.kernel.org>; Tue, 20 Oct 2026 08:54:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E05FA606A319
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=QttW8XOK
Received: by mail-pz2-f6.google.com with SMTP id 41be03b00d2f7-cd613507bd1so373268a12.0
        for <kvm@vger.kernel.org>; Tue, 20 Oct 2026 01:54:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792486483; x=1793091283; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ANGFYDD6Q8p8RwiaN/nK98Pvd1sOcfyNS+EbCCUesHU=;
        b=QttW8XOKDiIhHI/oBYiqq5Z+CDP5yGMTHf5KysLuaCmZKxp++453G05dC104POHm/E
         hsUBiBFlWQLYCOIBmzSDlgLUp3oFvIOPcy14jcZjQrA2CYpviEIdv9FT9jZzdnbqfcOr
         z5/pFE5oB8/u8iLP2ho+WENXIA7gu76vKThA12Ud0XyYHs9nmOu2pnC121sdRndP3dd+
         kTlZHPUkGippGGTQxAvyFLzknORZPO1cy2jDHJ1JgAhhR8ABz1TGWUOd3bfn8czT9HiQ
         U8SZ7BgBwH/YO7OlhoLuskRUfGmInrfRNSLl5lOJ0hUEjnI2M6kOvvphDPagiyv8q1VH
         4KqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792486483; x=1793091283;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=ANGFYDD6Q8p8RwiaN/nK98Pvd1sOcfyNS+EbCCUesHU=;
        b=E9n3akBj2oyPwXyBYmc2r2f79Z24A86+H8KgOMwl7wTbUK8nhmqI1Zyupd8+QxtIlY
         3a4ahuX2QUBYxzb1SE2iHsyLKcnshI5kr4KRGHTmN8oShvJ34wyH4gJvQ5AYU2MsWT5H
         wL9Yvg5xEGrpYZynkML8ItijB31k1WwUv/ZtQredDtBzt1hqwzwPHOSJEauWOsLUqUAa
         mUWkuz37JMixwS46OyG95aUzgCMVGn8sDeCPooaLzG+DR6IdZIMHxuZD3+E2ekosso4q
         JIA/YTb1U+yTf0VP1vWUtzinhoBAun+95j7z+GZkG0qgBfVqXJxskV/b6/iEpQEd6M+F
         DS2g==
X-Forwarded-Encrypted: i=1; AKwUvBzoNiFVuLOz+6Akh9r8d84bFoZSOacLclnt39Foxn979Bi7M0XiJX4YwHGBRCutnY23M3A=@vger.kernel.org
X-Gm-Message-State: AFq9FYISw533cjD2pV65dOwj+7OJCitzp36KOFdnv2/eDMsgMpEE+Ttc
	4Hzxr247KWDR2N7bfcGj1KBLiqpk7w1NtItuGcAQre5O97QfXPxSD4tr
X-Gm-Gg: AYBFou189DphGb/cInhXCvxrqojt9aozPsvViF00TRHPw3gs4T0Q+gKIT4t98c+ZOiw
	zEe3q5rPoPumyKfgQkMT7GXmwHYCmE2I4K6YwXSeX4W0qCHgyphhzPL20F3tXyfOQ7TojwOaiHP
	ExBM9VXIWLQK/wmNeLMqHbBELXt7P7w3ErVjM2OwIYefd2gGg7N0l8hjeQP8uan02ukLeIjVUYr
	5EDpNkim5831Rf54k2mWma/qGkLT6N0bgZ9gm9TteFdf6fsst/ShxJ1Spu6s0idkKndA2/46q4F
	57PoO4aJiFjN4IpLImXjjpU8stOKirwpgt91MBPCMTzGMZpdZW7z0ShzmlRRbi8qqhmBU7rRtkN
	7qqpJimRiImyxQPUQIsaszk7hG4WKdOSNdPPaYxtBeIQkSaXSYUuoc/MijQIqymhIEsbhQISegh
	CWWZ6RN1wCXhh5Xx8gsZ7ln5RjXKhxrkxonMNIfNy8LoEGgBm/N/jeOa1QRAZgPyT/mw97l570M
	kp+GAbbbaIGn9LadMcifrK3Fwf7b/h/vDJkfg==
X-Received: by 2002:a05:6a00:918a:b0:899:465d:c8ff with SMTP id d2e1a72fcca58-8a04ba30b6emr7502084b3a.13.1792486483189;
        Tue, 20 Oct 2026 01:54:43 -0700 (PDT)
Received: from HXDQXTDYHN.bytedance.net ([203.208.167.149])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-89f580173efsm4540237b3a.50.2026.10.20.01.54.37
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 20 Oct 2026 01:54:42 -0700 (PDT)
From: Jinmeng Zhou <jinmengzhou22@gmail.com>
To: Sean Christopherson <seanjc@google.com>,
	Paolo Bonzini <pbonzini@redhat.com>
Cc: Thomas Gleixner <tglx@kernel.org>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H . Peter Anvin" <hpa@zytor.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Feng Wu <feng.wu@intel.com>,
	x86@kernel.org,
	kvm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Jinmeng Zhou <zhoujinmeng@bytedance.com>
Subject: [PATCH v2 0/2] KVM: x86: Wake blocked vCPUs before offlining a CPU
Date: Tue, 20 Oct 2026 16:53:59 +0800
Message-Id: <20261020085401.80296-1-jinmengzhou22@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20260924080648.51014-1-zhoujinmeng@bytedance.com>
References: <20260924080648.51014-1-zhoujinmeng@bytedance.com>
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

From: Jinmeng Zhou <zhoujinmeng@bytedance.com>

A vCPU blocked with posted interrupts enabled stays on the wakeup list of
the physical CPU on which it blocked, and its posted-interrupt descriptor
keeps targeting that CPU's APIC.  If that CPU is offlined, a later device
interrupt sends the wakeup notification to a CPU that is gone, and the vCPU
is never woken.

Patch 1 turns CPUHP_AP_X86_KVM_CLK_ONLINE into a generic x86 KVM CPU
hotplug state that is always registered.  Today it is registered only on
hosts without a constant TSC.

Patch 2 adds an optional vendor cpu_offline() callback that runs from that
state's teardown, after the CPU has been deactivated.  VMX uses it to wake
the vCPUs on the dying CPU's wakeup list, so that they move to an active
CPU and rebuild their posted-interrupt state.

Patch 1 is a prerequisite for patch 2, so both are tagged for stable and
should be backported together.

Changes in v2:
- Reuse and generalize CPUHP_AP_X86_KVM_CLK_ONLINE instead of adding an
  arch hook to the generic CPUHP_AP_KVM_ONLINE path, which depends on
  KVM_GENERIC_HARDWARE_ENABLING=y.
- Register the x86 KVM CPU hotplug state unconditionally, so that the
  callback also runs on hosts with a constant TSC.
- Rename the vendor callback from prepare_cpu_offline() to cpu_offline().
- Use a bare __kvm_vcpu_wake_up() instead of KVM_REQ_UNBLOCK, so that the
  guest does not get spurious wakeups.
- Fix the changelog: the migration is started by CPUHP_AP_ACTIVE
  (sched_cpu_deactivate()), not CPUHP_AP_SCHED_WAIT_EMPTY.
- Initialize the per-CPU posted-interrupt wakeup lists before registering
  the CPU hotplug callbacks that walk them.
- Fix the trailers: add Co-developed-by and put the sender's SoB last, and
  add an in-body From: line for the author address.

v1: https://lore.kernel.org/kvm/20260924080648.51014-1-zhoujinmeng@bytedance.com/

Jinmeng Zhou (2):
  KVM: x86: Make the kvmclock CPU hotplug state generic
  KVM: x86: Wake blocked vCPUs before offlining a CPU

 arch/x86/include/asm/kvm-x86-ops.h |  1 +
 arch/x86/include/asm/kvm_host.h    |  1 +
 arch/x86/kvm/vmx/main.c            |  1 +
 arch/x86/kvm/vmx/posted_intr.c     | 18 ++++++++++++++++++
 arch/x86/kvm/vmx/posted_intr.h     |  1 +
 arch/x86/kvm/vmx/vmx.c             | 16 ++++++++++------
 arch/x86/kvm/x86.c                 | 30 ++++++++++++++++++++++++++----
 include/linux/cpuhotplug.h         |  2 +-
 8 files changed, 59 insertions(+), 11 deletions(-)


base-commit: a500db7819c50db59e55f1b4fa1c3baa5a2616f3
-- 
2.39.5

