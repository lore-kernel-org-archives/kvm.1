Received: from cvsmtppost104.wmail.worksmobile.com (cvsmtppost104.wmail.worksmobile.com [125.209.209.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15DED340287
	for <kvm@vger.kernel.org>; Sat, 31 Jan 2026 16:30:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=125.209.209.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769877027; cv=none; b=UVApKD+wCPbFgP+AKBjFxIBrIMWxD+QIuJoXDfRqVeEbGYcCZZ/epe7Tlik5yjcWrbvkCFJQBClMvgUxtPMqq4uzC4M75C2/9YtMqOrtETSeMqH2dsol1ovOsvPwskVh/Xm521BlVrB7l9WfAmykt6vpUAbgwOi0JdHeFx/Nhds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769877027; c=relaxed/simple;
	bh=3LmEhxfZZ1pkxaOheX6kmc6n6T5JvQjCCvxVqkSNd+o=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=C0dCKPOonAbfODbvhPuo4UIlO3YsogHmf94WHQPd8WTxt8K3vg0dcQLJvoZhqwv2R/UVbJnatb5iPhIXiOWx9mBAmjvE2h5+rtuHBPyatoWpyW0yZAz/OM2+9DE5+P6VQZiFwiESfEisRyNhvB4ePUZiUbGrLQO0faeVPZyvg24=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=korea.ac.kr; spf=pass smtp.mailfrom=korea.ac.kr; dkim=pass (2048-bit key) header.d=worksmobile.com header.i=@worksmobile.com header.b=w6YB7qiZ; dkim=pass (1024-bit key) header.d=korea.ac.kr header.i=@korea.ac.kr header.b=RmE1uc8J; arc=none smtp.client-ip=125.209.209.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=korea.ac.kr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=korea.ac.kr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=worksmobile.com header.i=@worksmobile.com header.b="w6YB7qiZ";
	dkim=pass (1024-bit key) header.d=korea.ac.kr header.i=@korea.ac.kr header.b="RmE1uc8J"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=worksmobile.com;
	s=s20171120; t=1769877019;
	bh=3LmEhxfZZ1pkxaOheX6kmc6n6T5JvQjCCvxVqkSNd+o=;
	h=From:To:Subject:Date:Message-Id:From:Subject:Feedback-ID:
	 X-Works-Security;
	b=w6YB7qiZryQt81Zg8kqXhsWnypOt3d6TPDOrY0p2hM4/Is3TSAsjtAjo3aDD6Dcqh
	 UzvCZSK3GeKwRCDOuVZSdfxWfY54spXUoPnJiBChdAczXEJ13Ss1cja/6eSCQUOQOe
	 A/ZNngSEdZ+fkqGhDEieVJo8MMDfR9mOlLFzCnvA2wMxL7CTfog1lPEUzH5kBKPqRg
	 zbyVSov9Rb4PCS6ArJ30mdKkPLnkNxezGaeCO2wU2lrskCFZz2HVTDj6zh+jwp9mbm
	 YAlFhKFaHBsIdSHq2X1FDIvXfxCS/hMp9fOJtBCJkwhxvI6ILICdfSO2E9AR4cNTLG
	 Kj1vLHTOCvoSg==
Received: from cvsendbo006.wmail ([10.112.11.111])
  by cvsmtppost104.wmail.worksmobile.com with ESMTP id GMOXetHzToOx1vOSpXqKfQ
  for <kvm@vger.kernel.org>;
  Sat, 31 Jan 2026 16:30:19 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=korea.ac.kr;
	s=naverworks; t=1769877019;
	bh=3LmEhxfZZ1pkxaOheX6kmc6n6T5JvQjCCvxVqkSNd+o=;
	h=From:To:Subject:Date:Message-Id:From:Subject:Feedback-ID:
	 X-Works-Security;
	b=RmE1uc8Jd3Ta/8/aC9DrtaYL9Keswd14fK6J1d1MtjFbXW3eHlJCX8f68H49YD/gi
	 3NMkFw9lN/muORXmUG2qlvh/iZvNc0wCAU8cpZfcZ6IoYKHdQcnV7OypvdVKQtmM7x
	 naCJTGE0B+FPeN/PUcAEt0F/fjL2zEDZd5I/qdVc=
X-Session-ID: b1qsfs-aQ5iOjsPg6dZFgw
X-Works-Send-Opt: EenqjAJYjHm/FqM9FqJYFxMqFNwYjAg=
X-Works-Smtp-Source: AdKdaAvrFqJZ+HmlKxMd+6E=
Received: from s2lab05.. ([163.152.163.130])
  by jvnsmtp401.gwmail.worksmobile.com with ESMTP id b1qsfs-aQ5iOjsPg6dZFgw
  for <multiple recipients>
  (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384);
  Sat, 31 Jan 2026 16:30:19 -0000
From: Ingyu Jang <ingyujang25@korea.ac.kr>
To: kvm@vger.kernel.org
Cc: seanjc@google.com,
	pbonzini@redhat.com,
	Ingyu Jang <ingyujang25@korea.ac.kr>
Subject: [Question] Dead code in KVM PIT ioctl error handling?
Date: Sun,  1 Feb 2026 01:30:17 +0900
Message-Id: <20260131163017.3341753-1-ingyujang25@korea.ac.kr>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi,

I noticed that in arch/x86/kvm/x86.c, the functions
kvm_vm_ioctl_get_pit() and kvm_vm_ioctl_get_pit2() always return 0,
making their error checks unreachable.

Both functions (at lines 6408 and 6433) simply perform:
  1. Lock mutex
  2. Copy PIT state
  3. Unlock mutex
  4. return 0;

There are no error paths in either function.

However, their call sites check the return values:

1. At line 7164:
   r = kvm_vm_ioctl_get_pit(kvm, &u.ps);
   if (r)
       goto out;

2. At line 7190:
   r = kvm_vm_ioctl_get_pit2(kvm, &u.ps2);
   if (r)
       goto out;

Since both functions always return 0, these error checks appear to be
dead code.

Is this intentional defensive coding for potential future changes,
or could this be cleaned up?

Thanks,
Ingyu Jang
