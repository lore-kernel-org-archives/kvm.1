Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=115.124.30.101
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792476077;
	b=chjhH3UVWuBryywpBLcMAKV+bDHPS3Urfi8YHm1sxFTeBuTC9gkvPOn/hrunfDimpW4z
	 0QNxV8jMny31t2mchdz+Faes30TgC5TYoJIlbMtiMeXyRUSHSICNFpxHZUg3DgnmaI2hZ
	 F/1ZKSMr0KN7vByDenvHT1cLmkCy97DQdk7ZcBHElNKydN36CTuaGHHWTGygnMEA1KgUN
	 rEiCQXO64fWxkCt1AWL0sEJnCKvCU3fap6xLpg9k+wfc392Rmom8WeoXkMoRMqbeprU+d
	 9FUSk9mQzgyqL39MqIBhUp9q3y18gma8WpjoG0YQsHVu9+wwciVsRpMQEbtkbAez13Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792476077;
	h=DMARC-Filter:DKIM-Signature:X-Alimail-AntiSpam:Received:From:To:Cc:
	 Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=AtM1JSq2AwHFCfq7O+aQY84HuktOB9TVoaq5FtQEBXA=;
	b=LYHezmRVomDazRXKAT20Mp/6XsLvBy35bmYbX77NEyygJxZu9ngzbxJoYHQQG+3bIyKk
	 OwDHJZqU1+H3/EFk4Jt0EMTNtZZEjhpJKnte7nqncopYN4gHUmsJ4p4UyoV/g8xn+Xam4
	 Abx3JLSDAnbX2TfPlO0H9/wfGtkZcHfy80+E6ugf8lroy7ZwXLGZOji+UJ9pcwqsZw3Lp
	 161f3RzppoxTpBdPhGBA/kbyQmGSt/kGBqV224QL1i562Zl4TAzYSh39+99IDUgfhS0ai
	 ecXvqYp4t8dWZjbs3/RUezYqd28FWg14X3nkSJBfTYHTV0MZpFDHL95lkWBIPQHeu6Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.alibaba.com;
	spf=pass smtp.mailfrom=linux.alibaba.com;
	dkim=pass header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=SRZznF6E;
	arc=none smtp.remote-ip=115.124.30.101
Received: from out30-101.freemail.mail.aliyun.com (out30-101.freemail.mail.aliyun.com [115.124.30.101])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60317606A31B;
	Tue, 20 Oct 2026 06:01:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 60317606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=SRZznF6E
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1792476067; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=AtM1JSq2AwHFCfq7O+aQY84HuktOB9TVoaq5FtQEBXA=;
	b=SRZznF6E/RpUtcJPMRV6ng2yRAOBasXSquv0ez6xzaMLe7jYl4KidRmTjaRr8qA1gMmbIV6W7y3f1qSin8KbML6ejFFhxHd/zyTyqNAMzC2qcJQ6kNC2PF4Gt/QjsIjZQuRKh8CMUJ8IEkWSvBkiQM+ot9zc/1Jo/hGNvODybkY=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R171e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033037009110;MF=xiang.zheng@linux.alibaba.com;NM=1;PH=DS;RN=14;SR=0;TI=SMTPD_---0XDBuaMa_1792476065;
Received: from localhost.localdomain(mailfrom:xiang.zheng@linux.alibaba.com fp:SMTPD_---0XDBuaMa_1792476065 cluster:ay36)
          by smtp.aliyun-inc.com;
          Tue, 20 Oct 2026 14:01:06 +0800
From: Xiang Zheng <xiang.zheng@linux.alibaba.com>
To: Paolo Bonzini <pbonzini@redhat.com>,
	Sean Christopherson <seanjc@google.com>,
	Thomas Gleixner <tglx@kernel.org>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H . Peter Anvin" <hpa@zytor.com>,
	Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
	Shuah Khan <shuah@kernel.org>
Cc: Shannon Zhao <shannon.zhao@linux.alibaba.com>,
	kvm@vger.kernel.org,
	x86@kernel.org,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: [PATCH 0/2] KVM: x86: Fix stale RTC pending-EOI tracking under AVIC
Date: Tue, 20 Oct 2026 14:00:51 +0800
Message-ID: <20261020060053.25011-1-xiang.zheng@linux.alibaba.com>
X-Mailer: git-send-email 2.50.1
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

ioapic_lazy_update_eoi() exists because AVIC completes EOIs of
edge-triggered interrupts in hardware, without a VM exit.  It clears
the RTC pending-EOI record of vCPUs that no longer have the vector in
IRR/ISR, but identifies those vCPUs with the current redirection entry
instead of the delivery record kept in rtc_status.  A guest that
retargets the RTC after such an EOI therefore leaves the pending EOI
set, and every later RTC interrupt is dropped as coalesced.  A guest
that relies on the RTC timer interrupt to advance timekeeping, e.g. a
Windows guest without HPET and with an unused APIC timer, then loses
its timer and hangs.

Patch 1 makes the lazy update consult the delivery record.  Patch 2
adds a selftest that reproduces the bookkeeping failure without a
Windows guest: userspace injects GSI 8, the target vCPU handles it and
writes the EOI, the guest retargets the RTC, and the next injection
must still be reported as delivered by KVM_IRQ_LINE_STATUS.

Tested on an AMD host running Linux 7.3-rc7: with AVIC enabled, the
unpatched kernel fails the selftest at the second injection (status 0,
coalesced) and the patched kernel passes all 64 rounds; with AVIC
disabled both pass.  Not tested on Intel/APICv.

Thanks,
Xiang

Xiang Zheng (2):
  KVM: x86: ioapic: Clear stale RTC pending EOIs using the delivery
    record
  KVM: selftests: x86: Add RTC EOI retargeting regression test

 arch/x86/kvm/ioapic.c                         |  19 +--
 tools/testing/selftests/kvm/Makefile.kvm      |   1 +
 .../selftests/kvm/x86/rtc_eoi_retarget_test.c | 155 ++++++++++++++++++
 3 files changed, 164 insertions(+), 11 deletions(-)
 create mode 100644 tools/testing/selftests/kvm/x86/rtc_eoi_retarget_test.c


base-commit: c03c1a14507dfaf8b856c2608f9ac216021fc222
-- 
2.50.1 (Apple Git-155)

