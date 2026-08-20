Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15ABC38837A
	for <kvm@vger.kernel.org>; Thu, 20 Aug 2026 06:14:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787206445; cv=none; b=UiJymOQV69PvKHpbaZ4cmg7/mER6O6nUD0/XvhBIhRDxU26Zgi/OEPBulNCWM5mdH5isi0MsT8CCCbKaG6gkN8SP3Aap0vej0hgpHdkO83lxKgkgECHxtHDEHTBhUN0JUdOFPL9bjzwu5hm+CZTWZYwSqqNmr2gmiJ5jQwMsSeM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787206445; c=relaxed/simple;
	bh=Bhgr5dFf6f+Z+unw8HZ3Mt1UgOTUdxwereqdh8u/eaU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=SFD8W+aVXq/j+EuTs8IXqWiFOLC6dJf3QNyZhFgFDYvXy2TSkwZlQNCkNoJe9D8BnaVgUaHbTia+BZfsSotHvZ3v/Gr/rypdoSoDno9lOvtcAv3BTyFfP0vJIQp06y92S4/eoj/VBd7ysTt5ySHXS1jyOgANL7jGGW8DNjq6GsQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HtDVRO0W; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HtDVRO0W"
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-84faf87d19dso1916960b3a.3
        for <kvm@vger.kernel.org>; Wed, 19 Aug 2026 23:14:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787206443; x=1787811243; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=+UiePDx8/Tsa6DOmKxJI7ngQHE/W8TglAXbeuopL1H4=;
        b=HtDVRO0WXXf0Sp5mF0bdwBTMSaTQP8owUpOJqSxogcfLrclxUxodKq4fX/QZk9h9Sl
         JWqdLWed+awttNIonqq6w+nPrwEk5uoBAGnVUpgUOGsXyzq4zPd6bdC2yyc3MwaoB7OX
         s5W1HDJ9aS4pbZudUxP6+zvCa9DiqL+M2xOB/m9UL1J4uGJjWxjZnEvnEzInYOcLEKkf
         xMJNGSPLnxKK6Zg1mFD110ZtGuMQ6EIUWVKT17H4rDU9VeLT1gQdjC4MtAZ9aHK6YMtH
         KK5lFYRI/l6DV0TxeabBGxpnTtnIlRPIxloBvn1xfkZ/3VZRl0P6uxv0VQodSzC0p9SG
         snYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787206443; x=1787811243;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=+UiePDx8/Tsa6DOmKxJI7ngQHE/W8TglAXbeuopL1H4=;
        b=UCYXdmSKGvbaxr1QnsSLgXFy2RiHpKYIWPTqPi5Rka5RT1glZLukMmEJTyWk7m6x38
         T4rZnrYfKRmtmX3EorS5kd82BHPGAqgzFuydI/irk/ZWkvwtgXHEnZ0gR4U7kw51JX8F
         IRsQXuW0VJcim7WGI8J7HbWWcqimQfRwdiysWevs00t2+d4i5J5ubYwIsYBAjt4Uqs5o
         FiALpFTBmx8rme3LuQOAE11FLY1SCDghTujaWIaQ18cF6CIerbNmBIQWkim4jh1zx644
         b6ZOQq8Vdl658yw5c4QYG/m8bxt+LbavGEm8E80Veo4+RzdNHZLae7ppvmntYkXZfISs
         bATA==
X-Forwarded-Encrypted: i=1; AHgh+RrYqRviuKwDrCSwyk7WN1bqjfYgAVSdAxfqlqjk3RoqmBVZ0k+lgX6iEfUHH5+PVMn6/sU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxoAlcSfEFYtnSaXNajkskCozk1Ty5NYFQFOOqC7g2tf1wQ7e1t
	wG9ltsE1Sv0PeKYaXzPtW6ZgFeWjX/jUZSRnMLOQSVsnc0/MVIc+d9WU3mdz3NSEeT/EbA==
X-Gm-Gg: AR+sD13nFuUxuo03MdQ6rghsrrmZ7BN4uuq15JQX+semFOyDBmBvjMUtbTgE4zpv5FR
	9meE4HKFI1DDHW5F7DG53SR+9jVFKNsDAx6urUnRiz5xEOWYinnkXaifcXu4mCSrmKIZLNJVwd5
	WE7z1+qlVBj66N5mt+kPVGt5Z8k1A4O2KS4B8Rdboi4IBGtrXYtHdyFfxFzUTjfovdDKh32Hc8Q
	7llDsl6GJE4zH2RXdati0BG70VbFowEZ0FxPZSUP8LJuGygbTI2eWBaRQLCBt3PZv3qt9T0g54B
	TgFx+ODhUVhDVtmzDQqSbtxOhFK42wqtoTEs/Jcb8NJYS4sU5SyP6k12tj0LcMYXQrdALBvBcsH
	7sJtj5ViI50glf7g65oW9GpROCF+fE5xtvu5ZA6qRlMfQw5KmSQ47a3YXz6qAXd9Wm6LuLo5M9k
	WuWC+VAU78tNbwhDhcd7dk4/gtwNQ3vQiM9Qpp6xwLPjlz8OZMLdgA2L1FEjOHXnjeJdk=
X-Received: by 2002:a05:6a00:9515:b0:84e:24f:2677 with SMTP id d2e1a72fcca58-851d380a098mr17104696b3a.4.1787206442948;
        Wed, 19 Aug 2026 23:14:02 -0700 (PDT)
Received: from 6a8281486e01 ([183.241.215.198])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-851d3640dd4sm1260483b3a.41.2026.08.19.23.14.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Aug 2026 23:14:02 -0700 (PDT)
From: Saul Freedman <fre3dm4n@gmail.com>
To: qemu-devel@nongnu.org
Cc: pbonzini@redhat.com,
	mtosatti@redhat.com,
	kvm@vger.kernel.org,
	Saul Freedman <fre3dm4n@gmail.com>
Subject: [PATCH RFC 0/1] Fix ICEBP handling after KVM debug exits
Date: Thu, 20 Aug 2026 06:13:54 +0000
Message-ID: <20260820061355.196465-1-fre3dm4n@gmail.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
    Marcelo Tosatti <mtosatti@redhat.com>,
    kvm@vger.kernel.org

KVM normally recognizes ICEBP, advances RIP, and injects #DB itself.
When userspace enables hardware breakpoints, however, KVM reports the
pre-skip #DB through KVM_EXIT_DEBUG.  QEMU currently reinjects it at the
old RIP, causing a debug-exit livelock.

The patch is marked RFC because KVM_EXIT_DEBUG does not preserve KVM's
exact ICEBP classification.  The proposed compatibility heuristic accepts
a causeless #DB whose instruction stream consists only of prefixes and
0xf1.  A durable long-term ABI might instead let KVM expose its exact
classification or advance the instruction before exiting; I would like
feedback from both QEMU and KVM reviewers on that direction.

Validation on an Intel VT-x host:

- Built x86_64-softmmu from current master (ae4f3443209).
- checkpatch reports zero errors and warnings.
- Ran a real Linux guest that executes kernel-mode ICEBP while an
  unrelated hardware breakpoint is installed through QEMU's GDB stub.
  Unpatched QEMU stalls after ICEBP_KERNEL_BEFORE; patched QEMU reaches
  ICEBP_KERNEL_AFTER.

I did not include the hardware reproduction in the patch because it needs
real VT-x, a matching guest kernel build, and a loadable module.  I can
turn the fixture into an optional avocado test if reviewers prefer.

Saul Freedman (1):
  target/i386: skip ICEBP before reinjecting #DB

 target/i386/kvm/kvm.c | 62 ++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 61 insertions(+), 1 deletion(-)

-- 
2.55.0
