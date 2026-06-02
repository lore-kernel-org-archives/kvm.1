Received: from mail-vs1-f47.google.com (mail-vs1-f47.google.com [209.85.217.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 988F3279DCA
	for <kvm@vger.kernel.org>; Tue,  2 Jun 2026 02:21:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780366879; cv=none; b=XW9KNU0lL+pmzWKenRT7n+rkA2zYIkOBu1V44Bk5/Nhzk9sqlDsY8goGHYfoTbW5JMi2GCupJAqQlZM9q/7T4rK7BN3NZO8SZC9ozwaY/w0pbYL12yWfieDHRranHaBwOElTFmdrjjWJTIiPOEbXSF9edP0xpS/KDS4wdxdo2RE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780366879; c=relaxed/simple;
	bh=PrIPNB/ZdWya4fDyk1Zzn0krb+Mm5Kh2RtvQyw3dttw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=mltBD5qk6sguoOrpWZZrWwNPPvsMkYn9QiNq7jyFGIeEkQbpOQGn6aoJ4MLaozkcYTOKXvmJNzHLTp+fDXrQxaHJTV9t7Fd9dpZLWL2Um8DWw+IjIU6bf6JuhsEdYG6TtOGoUyUaNosRhu6d7/bp1cIuNN7YpU0Pcw9//aycvmY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=allelesecurity.com; spf=pass smtp.mailfrom=allelesecurity.com; dkim=pass (1024-bit key) header.d=allelesecurity.com header.i=@allelesecurity.com header.b=WTn9ddI1; arc=none smtp.client-ip=209.85.217.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=allelesecurity.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=allelesecurity.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=allelesecurity.com header.i=@allelesecurity.com header.b="WTn9ddI1"
Received: by mail-vs1-f47.google.com with SMTP id ada2fe7eead31-6ca16bbc52aso714292137.2
        for <kvm@vger.kernel.org>; Mon, 01 Jun 2026 19:21:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=allelesecurity.com; s=google; t=1780366876; x=1780971676; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=oqSK6KHimFMn/wufhN+V/HaPMlQTvUnD2P67uwmnzDE=;
        b=WTn9ddI1KUkikn5IhKhTuGTB+Kie4QrZZiFDTs7txGejSaNzqAcRQRXdqYaMXesrJZ
         YvtTsvF64Dl8eesGAnSAaApN5WXtaM8iHTl4eXvYtaZom+g+b7ha7kv/pUf8AhAUdI4v
         2aLgviB0GKK2BEJcLRxIbQANQpi22kLGPxB6I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780366876; x=1780971676;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oqSK6KHimFMn/wufhN+V/HaPMlQTvUnD2P67uwmnzDE=;
        b=JHixE6GhdklBqfSnGhr5zw8ZOiuKE4GNprYqwn19DJsLoqZ9WhwaSdtIP6/j9dxamH
         EPHXGr3/RpD5dVEuCBFcNqI/2zfGefQGYl9ThOKYRQdJckZ3SKAiAIFFfJ3WZtDfF/AD
         qiyzE9crjSSbV0inmkepR6Z7ByzNqp3OLVdtr8Ak9vYLSge90DTLSmOG9klMYoWgzGEs
         bPfx2B4JEbLLeN0hznYv+jabPPg6DsJLCkdTuOdsYzcwMAUsiCVxSR7OF25DSW/2YNxL
         OIczGkJNOjo6MsGks7avhBh3MUnhY0FmCEGfY+Ryxe8EqhGJusbiZOQ/vpaDpLBX+lPb
         VPhA==
X-Forwarded-Encrypted: i=1; AFNElJ9iEqBEK7tJAYdtuJapGLooWB7JBJoynzT2MjIP39ToA/EzaoZyWQmNBOE24HKEjE0b79c=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw+DC9WYpuTKNlST9WeKnqKMfZeT51YlEib6tXdlD8/wO9bjmIc
	w40USDdHh12avnd8cB6g7OFSCE2Uuyshe1+ZQbg+Us31mdHrUg3dXwTISJOugRWBK4FwhgL/yh4
	MLPUZIU4=
X-Gm-Gg: Acq92OEwoWv6EM4OT2l7lWnQQ4SuzuO0qPm76Q+/B2Og4rtdqW2O/lwOIDMTQFkKH+P
	OdvEJdj2R0veRnJm+j7F2FR/qiL5nL9hbNMfbvNxUgijIbZDhR7mbzJo+AiUPoW4uou21fEdRaa
	CRwC8YpR762AqEIMkIz/U7F7MHLWao/lMi1VCoPBGHDpv/153LK+iTWaUCUwLfyyANMm1mQMSsf
	b8Yjy+7axhK2mEzJhDtxuyELguL9qIGiy60LEaJNLTsv46iqsRVXJPtXaEFvoTBmoMXb1+bPmSF
	xKYy0lJPKJq6umMtaVEzRgNMS8pZoOl4itzy1DlF7z+k8Z8HUpl321Eya+s2U3NsfFo6F6Ikp8d
	4TLfHLyWahsfifB/xphaPs66E+4Isv5y3x5lP/2UtDg2VhGpq85QW32UcmY5Afp7fqdSCUOQS9y
	XzzqpLuKRiWJOGXpPbLAVNg391tkhakJzdiAY0TA==
X-Received: by 2002:a05:6102:4a93:b0:643:80f1:33d8 with SMTP id ada2fe7eead31-6c694f50a1dmr5989468137.4.1780366876493;
        Mon, 01 Jun 2026 19:21:16 -0700 (PDT)
Received: from tarski ([179.105.152.38])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5a1c3c784a2sm3648243e0c.15.2026.06.01.19.21.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Jun 2026 19:21:16 -0700 (PDT)
From: Anderson Nascimento <anderson@allelesecurity.com>
To: qemu-devel@nongnu.org,
	kvm@vger.kernel.org,
	pbonzini@redhat.com,
	zhao1.liu@intel.com,
	mtosatti@redhat.com
Cc: Anderson Nascimento <anderson@allelesecurity.com>
Subject: [RFC PATCH 0/1] target/i386: Add support for KVM APERF/MPERF passthrough
Date: Mon,  1 Jun 2026 23:20:47 -0300
Message-ID: <20260602022048.752453-1-anderson@allelesecurity.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hello,

I have implemented support for exposing and enabling APERF/MPERF 
MSR passthrough for x86 QEMU guests when running on KVM.

As of last year, the Linux kernel supports providing a capability 
to disable APERF/MPERF read intercepts [1]. However, there is 
currently no native way in QEMU to instruct KVM to activate this 
capability or expose the feature bit cleanly via CPUID.

My patch introduces the `aperfmperf` feature flag via `FEAT_6_ECX` 
(CPUID.06H:ECX[bit 0]). It ties into the existing power management 
framework, so when a user enables power management via 
`-overcommit cpu-pm=on` and passes `+aperfmperf` to the CPU, QEMU 
requests KVM to drop the MSR intercepts.

For testing, I passed the feature via Libvirt XML like so:

    <qemu:arg value="-overcommit"/>
    <qemu:arg value="cpu-pm=on"/>
    <qemu:arg value="-cpu"/>
    <qemu:arg value="+aperfmperf,+invtsc"/>

A FreeBSD 16 guest is successfully able to read the changing 
values of the MSRs directly without exiting to the hypervisor:

root@freebsd16development:/home/user # cpucontrol -i 6 /dev/cpuctl0
cpuid level 0x6: 0x00000004 0x00000000 0x00000001 0x00000000
root@freebsd16development:/home/user # cpucontrol -m 0xe7 /dev/cpuctl0
MSR 0xe7: 0x00007fdf 0x22480f90
root@freebsd16development:/home/user # cpucontrol -m 0xe7 /dev/cpuctl0
MSR 0xe7: 0x00007fdf 0x2b8b48b0
root@freebsd16development:/home/user # cpucontrol -m 0xe8 /dev/cpuctl0
MSR 0xe8: 0x000050de 0x49270831
root@freebsd16development:/home/user # cpucontrol -m 0xe8 /dev/cpuctl0
MSR 0xe8: 0x000050de 0x4ad66ae6
root@freebsd16development:/home/user # 

I am looking for feedback on the approach, specifically if tying 
this directly into `cpu-pm` makes the most sense to the 
maintainers.

Based-on: QEMU v11.0.50 (commit 5611a9268d)

Anderson Nascimento (1):
  target/i386: Add support for KVM APERF/MPERF passthrough

 target/i386/cpu.c     | 17 ++++++++++++++++-
 target/i386/cpu.h     |  2 ++
 target/i386/kvm/kvm.c |  5 ++++-
 3 files changed, 22 insertions(+), 2 deletions(-)

-- 
2.54.0

