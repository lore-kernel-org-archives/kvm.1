Received: from mail-vs1-f42.google.com (mail-vs1-f42.google.com [209.85.217.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87A0330148A
	for <kvm@vger.kernel.org>; Tue,  2 Jun 2026 14:04:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780409092; cv=none; b=BoZ+ttePAKeSt/3QzZ9LtxJ92J1Sl08X6+QvJiaOJEtXswjiUBC4Sy+5IA/bjXTABJsTpz3i3kj1T0cih8pI8FNJL8SviDBICEm90wphsapKWX0G4bHiiB5ssmd9H7KPazAfQLBxxNj++P2H6IyOhzx5KeRKcMKnpgjxA7Tp2xY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780409092; c=relaxed/simple;
	bh=UDuowQtCwyTwvVntr60YB7kyStQLajvYuYLxBG1pkeU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=X1lwmaaNW1qjBjfI4ACP4FBEBNUvlaZSoa1a5o5xwLIAGV2mrYHrXxVSgsB/Wtcyl1hJO+AuFxg7QDf94FTQNue0n/hgIkH2QOJn+FLEkfK6K+3hNxCF04vEgJgY6gV7sAcsRVqMHNvMjnRtsK3C/QgUB/R6uPXkqu6kiIjjdBs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=allelesecurity.com; spf=pass smtp.mailfrom=allelesecurity.com; dkim=pass (1024-bit key) header.d=allelesecurity.com header.i=@allelesecurity.com header.b=MKryWRoQ; arc=none smtp.client-ip=209.85.217.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=allelesecurity.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=allelesecurity.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=allelesecurity.com header.i=@allelesecurity.com header.b="MKryWRoQ"
Received: by mail-vs1-f42.google.com with SMTP id ada2fe7eead31-6c3099b11a9so1557799137.2
        for <kvm@vger.kernel.org>; Tue, 02 Jun 2026 07:04:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=allelesecurity.com; s=google; t=1780409090; x=1781013890; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ujK4eFBt2CiUF6UNRnobhV7dIbSUH85qOD9fCMSIzOE=;
        b=MKryWRoQrPvejhRd+oVhYqM2ZaXiJ8BzHyuqh7N1YYl5UPsCr94ckhKD9ZdOEHtEg8
         /sQjpRm1YRRbjtnITGl3yqqFRjT9Ia0wOMI3N441Tr8OfV5Ot+c4lqXgV9PsjXnBKYfE
         3rdGOaqBVh2IEz6+lakaVsPplcn9i0CYBMStw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780409090; x=1781013890;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ujK4eFBt2CiUF6UNRnobhV7dIbSUH85qOD9fCMSIzOE=;
        b=AKwYe3p1mrrtiPOZZcGNIfmQA7Nx2r88N/HSJF8xDl6KErY9/IrlUNNZVpHTzQ4g/1
         DrQ/qESUVKX03UmYZAI9AOzgqrcPSQl77RyKW3HMoc5SfoeQ5Pa3h8WPmzpC405NVTBI
         /MMgEEV9XOLu/Yzd83gZespu+SltQPL10NTIwgvpM/6xJ1heHdmvrTLTCg2EfQqCaMXS
         CYR2QQvciq+mcDYrxY++12YLYVTlqTAbqQVfKQXlElD/jDVowzeWeeC3Ppbb6obT7k3H
         jx7A+YoNycfhtk+s7+D+HWzpc2fHSwdSJbTYklqP91g/fm6vnY8PuxOkt0F0LAgq7RwE
         KZAw==
X-Forwarded-Encrypted: i=1; AFNElJ8EgKifT8y4jaf8iRBJFVal/DpsLw7NPZt7xaFBNeAfAuEa3P6DhpSs866jS4HXc1VS0ag=@vger.kernel.org
X-Gm-Message-State: AOJu0YzWjKdySscpqUaniBtK2q20o2upPInxWGHUJ6/B4BNNYDBhe6SC
	EIgdq6ayuuRk2Lth0R5iIgJ5P5wjX3wDGb5ilWFzaqPbyuunMMeLH0Elzur0VTeH0M0=
X-Gm-Gg: Acq92OGLZdcAU6Rt4F/bealJs7QUKPjoA8SJVim8cy4ifW9OoLisQ8FHf7P3thvIFwd
	c0dVknHjfOiYd64BYda/PggR2k92yYxYST3kixxNV2BslnSlFGa7yUH3TyYSNRSSMzBmPXa8p+P
	0v+kChyxxN7mB/IZ4FObmkeq5OOOfBqaK7OQ3JwSj4ci3UNOwtnw7UJf8s5rd9q+QLDJ+OHTOrs
	wF60J5RVdfQIrNfASlIzAiiDLbKe+UJAXigPQ/m/8FWaPueNfc9oqr6kR4zEPAHEBTyezS+Cq7y
	0hmdEFHEyuj2QNO5mmowKD7Y6Q3dCpqdFVEp6fc4zwJm9ZAzOmwB6UfWHas39hElQ7pn6iMlaQH
	OI3DCY+U/fnt0o4cCzQCUkroPhJtY7poyS5M4GmCfa7IFkt7OOItaEnsrFzA34oXTWcxrglPhZy
	CZyQMrKK3dVxj4LaOL1tlt2Ao54yjYSBgJe6wLJw==
X-Received: by 2002:a05:6102:61d1:b0:634:420a:ab1b with SMTP id ada2fe7eead31-6c69b82c136mr3593702137.18.1780409090446;
        Tue, 02 Jun 2026 07:04:50 -0700 (PDT)
Received: from tarski ([179.105.152.38])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-6d1ff3909b3sm6097602137.6.2026.06.02.07.04.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Jun 2026 07:04:50 -0700 (PDT)
From: Anderson Nascimento <anderson@allelesecurity.com>
To: qemu-devel@nongnu.org,
	kvm@vger.kernel.org,
	pbonzini@redhat.com,
	zhao1.liu@intel.com,
	mtosatti@redhat.com
Cc: Anderson Nascimento <anderson@allelesecurity.com>
Subject: [PATCH v2 0/1] target/i386: Add support for KVM APERF/MPERF passthrough
Date: Tue,  2 Jun 2026 11:03:46 -0300
Message-ID: <20260602140348.774203-1-anderson@allelesecurity.com>
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
    <qemu:arg value="host,+aperfmperf,+invtsc"/>

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

Based-on: QEMU v11.0.50 (commit 5611a9268d)

v1 -> v2 changelog:
  - Add migration flags

Anderson Nascimento (1):
  target/i386: Add support for KVM APERF/MPERF passthrough

 target/i386/cpu.c     | 18 +++++++++++++++++-
 target/i386/cpu.h     |  2 ++
 target/i386/kvm/kvm.c |  5 ++++-
 3 files changed, 23 insertions(+), 2 deletions(-)

-- 
2.54.0

