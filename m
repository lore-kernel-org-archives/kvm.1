Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6749296BBC;
	Mon, 23 Mar 2026 05:38:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774244312; cv=none; b=DgmDHulJSohWuVhWILD3sjx4wvRoTcOx4VWja4TBz1sTq4fai5BWCLGHjJO9FGCZZld0AeBlO1Jem0NdEVy5Ch2+AjillTccf9MhptvqIIJxTX7ToACsdkxCQLt6w6xN0jPWW1ZR05MYaBfizVticVgJsy2tzwXX+mfxpYVTsoM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774244312; c=relaxed/simple;
	bh=2K67U6HuJpZW+k4qIcO3CebmX5wenLfMQiR0nz/xUCI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ZJUSASQnhmskeSKrwEBm72eUx9qdkSf6/HS6mDOKgoKMbGL3L+2oB7284zlUamXowJCSoaUAXcHC7Y2NOJY6aRPVpLZ9N+G+8bXKZomJ+NAnUqfcrPjg5MmmcPqVcolcja5sgKHR3zT5fVzDJu2DnTgrRkzbIM1ytksKa4OIUbs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=VTurPXoi; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="VTurPXoi"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1774244310; x=1805780310;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=2K67U6HuJpZW+k4qIcO3CebmX5wenLfMQiR0nz/xUCI=;
  b=VTurPXoiwFxPu64L365QT9ykAlsF089KuTRBq3KmPMvmv8/n7nu2dAL6
   xr1cRhNro1AIpaPyyUdA4TONrMXkTrFx2kZDDw/2OhuSR07oJ/y4Zsl2u
   /t6vrxjeki6pMwJVgnT5R9j/BBT4uqKBtCfKQfHpSmD2x0zBgbLK+g5P4
   r26MHEkqNhOOvCQYsMLJTGvjxMjqADR2EV7+qFkGVUGijQb0wb7DRJE0o
   yQOuDSNYBw600RbEDVGlJU1IIL6fg6hcaFzXNES66wCYA+SEzVFgVk34b
   oOZlcS2uRO+jf5gwzQLCgTO+1VKoctnd+B6+hTgzCBdHbPsD+gaMM/C9p
   A==;
X-CSE-ConnectionGUID: u2q148lwRpOkm1pvX8jv4g==
X-CSE-MsgGUID: mSDweGnXQN2tcCe5docIcw==
X-IronPort-AV: E=McAfee;i="6800,10657,11737"; a="92618045"
X-IronPort-AV: E=Sophos;i="6.23,136,1770624000"; 
   d="scan'208";a="92618045"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Mar 2026 22:38:29 -0700
X-CSE-ConnectionGUID: qJkpuzKURAauUSUmwdryMA==
X-CSE-MsgGUID: fOA+XavbQyK4IiTMqjjSwA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,136,1770624000"; 
   d="scan'208";a="222994038"
Received: from intel-fishhawkfalls.iind.intel.com ([10.99.116.107])
  by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Mar 2026 22:38:27 -0700
From: Sonam Sanju <sonam.sanju@intel.com>
To: Vineeth Pillai <vineeth@bitbyteword.org>
Cc: kvm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	pbonzini@redhat.com,
	Sean Christopherson <seanjc@google.com>,
	dmaluka@chromium.org,
	sonam.sanju@intel.com
Subject: Re: [PATCH] KVM: irqfd: fix shutdown deadlock by moving SRCU sync outside resampler_lock
Date: Mon, 23 Mar 2026 11:03:53 +0530
Message-Id: <20260323053353.805336-1-sonam.sanju@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260320125633.2290675-1-vineeth@bitbyteword.org>
References: <20260320125633.2290675-1-vineeth@bitbyteword.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 20, 2026 at 08:56:33AM -0400, Vineeth Pillai (Google) wrote:=0D
> I think we might have this issue in the kvm_irqfd_assign path as well=0D
> where synchronize_srcu_expedited is called with the resampler_lock=0D
> held. I saw similar lockup during a stress test where VMs were created=0D
> and destroyed continously. I could see one task waiting on SRCU GP:=0D
> =0D
> [   T93] task:crosvm_security state:D stack:0     pid:8215  tgid:8215  pp=
id:1      task_flags:0x400000 flags:0x00080002.=0D
> [   T93] Call Trace:=0D
> [   T93]  synchronize_srcu_expedited+0x109/0x140=0D
> [   T93]  kvm_irqfd+0x362/0x5e0=0D
> [   T93]  kvm_vm_ioctl+0x706/0x780=0D
> =0D
> And another task waiting on the mutex:=0D
> =0D
> [    C0] Workqueue: kvm-irqfd-cleanup irqfd_shutdown=0D
> [    C0]  __mutex_lock+0x413/0xe40=0D
> [    C0]  irqfd_resampler_shutdown+0x23/0x150=0D
> [    C0]  irqfd_shutdown+0x66/0xc0=0D
> =0D
> The work queue was full as well I think:=0D
> =0D
> [    C0]   pwq 46: cpus=3D11 node=3D0 flags=3D0x0 nice=3D0 active=3D1024 =
refcnt=3D2062=0D
=0D
Yes, You are right. The kvm_irqfd_assign() path has the same deadlock patte=
rn. =0D
=0D
=0D
> There were other tasks waiting for SRCU GP completion in the resampler=0D
> shutdown path. Also, there were other traces showing lockups (mostly in=0D
> mm), but I think thats a secondary effect of this lockup and might not=0D
> be relevant.=0D
=0D
Yes, that matches what we see on our side as well =E2=80=94 the primary dea=
dlock=0D
in the KVM irqfd paths causes cascading failures: workqueue starvation=0D
leads to blocked do_sync_work (superblock sync), fsnotify workers stuck=0D
on __synchronize_srcu, and eventually init (pid 1) blocks in=0D
ext4_put_super -> __flush_work.  The mm lockups you see are almost=0D
certainly secondary effects.=0D
=0D
Will send v2 shortly with both paths fixed in a single patch.=0D
=0D
-- =0D
Sonam Sanju=0D
