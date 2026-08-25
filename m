Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CB8A3DD873
	for <kvm@vger.kernel.org>; Tue, 25 Aug 2026 08:37:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787647059; cv=none; b=aLAz8gLVeoUq8dplraEDrwbhMHzOQ/L6pKIdPlS6MTfmpTuKQ3F3mYwqN9tbaz4FyHQBchF5EbWZ3MajkfujGmk/3Iix+9OS2G3Kf4SNF1wdyZ8ydV2yvKtExT7FIRRCi4Lket9x+1/xq/nEtnf5JY+opO/iaotbWyPnN/RNC70=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787647059; c=relaxed/simple;
	bh=LNRKnRnQJHlCDb1+W1pzp4TUdD4yCD7c1c5RDxUrecQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=r4T2Z7uz69ieY5W1Olab7KY/6HEjhiaoELBDGCcanNLD4WZQbnunoqh2Cec2/iArNjngz5uZZKiSeRAuZ6Gb7aElG5HwYDDi+tX0kxjFXNc+ZkWXh/8oMi1DqFXz9jlNv4U3cx4sXtNmBPW8YrcwiHzmAjRsrELEwBpBbnXDnow=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RfemcU44; arc=none smtp.client-ip=209.85.215.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RfemcU44"
Received: by mail-pg1-f182.google.com with SMTP id 41be03b00d2f7-cc149372c14so3269964a12.1
        for <kvm@vger.kernel.org>; Tue, 25 Aug 2026 01:37:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787647058; x=1788251858; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=rTiqxajFCS8JhT00U7QUj901RHFXVk9RFW4qrD2ZWqc=;
        b=RfemcU44tbcH8f4f99OYambiIcdVQanGCy2KyNHc08dg0VIrNY21rSg5PLIjfbLI87
         diueG5++PhQQwVmwEZ6hXMpvmtUD5z34bDczIL/3ku37TaRE9mbh4ZEZGRyxWcyLeojp
         ogAWLIn80TJ6U2DwWMKs7VPDU5QRcZjaSd9yYrbXJ1MPkkLTbXGr0GLbSVSyzPcWd0mx
         VLXswjKVqdU71GMInovPSiv1zqBjZzIj/9cdfafJ3hOk16rdUQr76ZGksiJr/xo6YsWn
         VaznHh1MFM39huQK18S3PEgbNSyG0F7ncV44e+uLCSz5YVNo4n/CSe5pHQeWFihHvnkk
         Ubzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787647058; x=1788251858;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=rTiqxajFCS8JhT00U7QUj901RHFXVk9RFW4qrD2ZWqc=;
        b=DNZqzbuHD+0iWL/XDXFeIyz4sb9/sG5+X8EgjW3tFfGJ6sNbxF16TigCGH4qth/uFU
         sxTzbg91w9WL6C4ahn/CiqdxQ4QG10CUYXvl8iUBFp+d86wFHjfYEHn29zS8SwZeJ+Bs
         W/sAI+YZQqFPfU2gFkKLUnWqTI1jQlOzBVJDB07+pVE5px2mIuR824u4j05HuSkY8giS
         dMV79dzwJJHx/fNEGxbDWkL4a+nA+PavVE1qKjrYfbf33KkCbiYXQ4pmb0XaG6LsSCcY
         CmqNOTDp5RFl8ZRrTgDt14f58az7WPz9xVA5LPOgsLkMyv7O7IElLSFITESdsKyXxuZj
         TnEg==
X-Forwarded-Encrypted: i=1; AHgh+Rpker6if1eNhWWIgloUUL/yaYAAEodM3/hlL5H0qgCDYSR2hguQwTRDxGtw3up8II8vCxc=@vger.kernel.org
X-Gm-Message-State: AFuF++kW9U6wOOh3RWPO/eMCC6cBBGCG1cZv0NJHcLyA3tOUknMSr0zN
	hWeSq/lUc9Odj0eEdSGV7TdvKg8//wfgPsQKTcJPHFbhLy0lErJGoLmt
X-Gm-Gg: AR+sD13RZX5V85LxMW4uy4R7sjU17qDV0D+wBrdt0J/Wajk2LjOA4th2QpcIqKMgTF1
	HAR6R6hhNY8yATQ8SOHH3g5tpM2v4tUt86G1KrfPQU5WumZVMq2a01kwgAGZPYUfQB5P/ORDo68
	pkuvXV9sRei28Nthb8+bKh3Ukk+zPANGev3cz46QeU3cyenSUJFwtEQwtykaHliM8G56tvhgHlF
	Si2Y4eqynLFOtYXbVIpIgYvUcF7zbkOshnzUmEeGyNKJLWLvMwlYkP71rRvYRHNQDxFqv9bt8sn
	zbORJQyHjLIEHhchpQdNhqjv7jx13OFdLcAOVDoa5DJi1pHRb4baEpuYZkJD0gxL2VveF7vw+cd
	7IgyoIrbOOmmrDBRNrRHjz/5zFb9d1kHtsgBnuPD0WAtfeN7gX7YZ3U7eWF1IHCekyCInk+RViP
	rhrO3LffHCheWbF3EHMbsUF0OvNQsoqUf+L+hcRXtO2MrL40MGOFnIxbwOForSRmcn0T75hhGdo
	qt8mOHFlE/7
X-Received: by 2002:a05:6a21:320b:b0:3be:b0b3:3962 with SMTP id adf61e73a8af0-3cd9125ad6dmr10437900637.9.1787647057741;
        Tue, 25 Aug 2026 01:37:37 -0700 (PDT)
Received: from fedora ([61.74.238.173])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cc199e60abbsm1835887a12.23.2026.08.25.01.37.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Aug 2026 01:37:37 -0700 (PDT)
From: SeungJu Cheon <suunj1331@gmail.com>
To: Anup Patel <anup@brainfault.org>,
	Atish Patra <atish.patra@linux.dev>
Cc: Paul Walmsley <pjw@kernel.org>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Alexandre Ghiti <alex@ghiti.fr>,
	Andrew Jones <ajones@ventanamicro.com>,
	kvm@vger.kernel.org,
	kvm-riscv@lists.infradead.org,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Shuah Khan <skhan@linuxfoundation.org>,
	linux-kernel-mentees@lists.linux.dev,
	me@brighamcampbell.com,
	SeungJu Cheon <suunj1331@gmail.com>
Subject: [PATCH v1 0/3] RISC-V: KVM: Fix PMU counter handling issues
Date: Tue, 25 Aug 2026 17:37:16 +0900
Message-ID: <20260825083719.643970-1-suunj1331@gmail.com>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series fixes three issues in the KVM RISC-V PMU implementation:

- preserve firmware counter values across stop/start;
- report failures when writing snapshot data to guest memory; and
- fix perf-backed counter accounting across read and stop.

The changes were tested with the existing KVM RISC-V SBI PMU selftests
and additional tests covering the affected stop/start, snapshot failure,
and repeated read paths.

SeungJu Cheon (3):
  RISC-V: KVM: Preserve firmware counter value across stop/start
  RISC-V: KVM: Report snapshot write failure to the guest
  RISC-V: KVM: Fix perf-backed counter accounting across stop and read

 arch/riscv/kvm/vcpu_pmu.c | 33 +++++++++++++++++----------------
 1 file changed, 17 insertions(+), 16 deletions(-)


base-commit: 0a0d1d55dad570724bf8c7ea83409639cfb4be9b
-- 
2.52.0

