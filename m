Received: from esa8.hc1455-7.c3s2.iphmx.com (esa8.hc1455-7.c3s2.iphmx.com [139.138.61.253])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E051739B955;
	Thu, 10 Sep 2026 04:52:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=139.138.61.253
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789015939; cv=none; b=MQVBeeYJeJpJk5TARjHR9GlH4DPLDIUhQH+q019fp8wOfafMp9mg8hlA50uS8imSLLdpzYvr0+cyFSmQcAZJozhYOeeanbAkVRoO7J/2naPmcqRwGkIknR9WWPHdLiiBhGKeVjqAPMuBh7i1h+kvFlyxX+6EQS+LAIcBY6zf+6s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789015939; c=relaxed/simple;
	bh=nBF6tOIyB/K1smAps/PmomhzUk3BKaarthp+S5mLB4w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gMz1S7+g0gZW/P9I5jqoDC9MJOpEZDrzp8mlOCzTw/k7sHEKBDKZRbwYepEXj6jm5Y7KHgUaExVL0aKJxJSgool7hifHz2wlTioINszvm8b/uaoYJIy1XHg7t51zY2YkdiAT4wZHLoC8GAKiwP2XAOIo9sXfDXA54qYYn7dbJoY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fujitsu.com; spf=pass smtp.mailfrom=fujitsu.com; dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b=KyfpSydD; arc=none smtp.client-ip=139.138.61.253
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b="KyfpSydD"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj2;
  t=1789015938; x=1820551938;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=nBF6tOIyB/K1smAps/PmomhzUk3BKaarthp+S5mLB4w=;
  b=KyfpSydDnhZZBa8E2jvgPGAQbLnnEB5gE0Grm+KCGRV0fOSTLxp1zmKT
   LyzRETyrJuKz+XNwxgIsI1WvM6Ik00jIMUxI8dmCORccLO7yoIygNa8O9
   ET5TetFpHVc8+NySKV0ROnFGfojPI5pOWT8lsebd63ZS6gx9o2xM8g4JC
   CLi4pCQVXlgo1Sv1U3Jt76FCyDIyNNBr1tbBeqjPXsi0DkhU4XP6tuovc
   VUqr7nBfgQdAUr/9+Z+7DocqhGH73XQcAyWzyXvhoiTjbvfb/bQ5OpeJ5
   b9d8fSXHY0q5HImGqBDET2EBKyXrhwPZ1IjPGXXX9EUKWU20FSmHWGtkd
   A==;
X-CSE-ConnectionGUID: Wwa20AORSJymJa3yaQMbsA==
X-CSE-MsgGUID: LEa5AQ2AQgylLx6VRXUPQg==
X-IronPort-AV: E=McAfee;i="6800,10657,11900"; a="242525105"
X-IronPort-AV: E=Sophos;i="6.25,271,1779116400"; 
   d="scan'208";a="242525105"
Received: from gmgwuk01.global.fujitsu.com ([172.187.114.235])
  by esa8.hc1455-7.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Sep 2026 13:52:09 +0900
Received: from az2uksmgm2.o.css.fujitsu.com (unknown [10.151.22.199])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by gmgwuk01.global.fujitsu.com (Postfix) with ESMTPS id C1D231C1C737;
	Thu, 10 Sep 2026 04:52:09 +0000 (UTC)
Received: from az2nlsmom1.o.css.fujitsu.com (unknown [10.150.26.198])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by az2uksmgm2.o.css.fujitsu.com (Postfix) with ESMTPS id 776FD18000CB;
	Thu, 10 Sep 2026 04:52:09 +0000 (UTC)
Received: from FCCLS0092175.localdomain (unknown [10.9.22.105])
	by az2nlsmom1.o.css.fujitsu.com (Postfix) with SMTP id DEF3B821217;
	Thu, 10 Sep 2026 04:52:01 +0000 (UTC)
Date: Thu, 10 Sep 2026 13:51:58 +0900
From: Kohei Enju <enju.kohei@fujitsu.com>
To: Gavin Shan <gshan@redhat.com>
Cc: Suzuki K Poulose <suzuki.poulose@arm.com>, kvm@vger.kernel.org, 
	kvmarm@lists.linux.dev, maz@kernel.org, will@kernel.org, catalin.marinas@arm.com, 
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, steven.price@arm.com, 
	aneesh.kumar@kernel.org, oupton@kernel.org, joey.gouly@arm.com, tabba@google.com, 
	yuzenghui@huawei.com, linux-coco@lists.linux.dev, gankulkarni@os.amperecomputing.com, 
	sdonthineni@nvidia.com, alpergun@google.com, fj0570is@fujitsu.com, WeiLin.Chang@arm.com, 
	lpieralisi@kernel.org
Subject: Re: [PATCH v17 0/7] firmware: arm_rmm: Add RMM v2.0 base RMI support
Message-ID: <aqI3Cewih7oobhdG@FCCLS0092175.localdomain>
References: <20260907095942.1140734-1-suzuki.poulose@arm.com>
 <ap-C6NLnxuWWTMzi@FCCLS0092175.localdomain>
 <9086ca6a-5dce-493f-ac76-487dedc60758@redhat.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <9086ca6a-5dce-493f-ac76-487dedc60758@redhat.com>

Hi Gavin,

On 09/09 20:52, Gavin Shan wrote:
> Hi Kohei,
> 
> On 9/8/26 2:09 PM, Kohei Enju wrote:
> 
> [...]
> 
> > > 
> > > [1] RMM spec : https://support.arm.com/documentation/den0137/2-0bet3/
> > > [2] This series: https://gitlab.arm.com/linux-arm/linux-cca.git cca/cca-host/fw_rmm/v17
> > > [3] KVM CCA v17 integration branch: https://gitlab.arm.com/linux-arm/linux-cca.git cca/cca-host/kvm-integration/v17
> > > [4] Gmem inplace conversion https://github.com/googleprodkernel/linux-cc/tree/guest_memfd-inplace-conversion-v12
> > > [5] TF-RMM https://git.trustedfirmware.org/TF-RMM/tf-rmm.git main (commit: 134266ae)
> > 
> > I understand that QEMU-virt is not intended to model a realistic
> > production platform and that QEMU-SBSA is generally preferred. However,
> > I sometimes use QEMU-virt to test functionality quickly because it runs
> > slightly faster than QEMU-SBSA.
> > 
> > I tested this series with QEMU-virt and found that RMM initialization
> > failed during boot:
> > 
> >    [...]
> >    INFO:    BL31: Initializing RMM
> >    INFO:    RMM init start.
> >    ERROR:   RMM init failed: -8
> >    WARNING: BL31: RMM initialization failed
> > 
> I also ran into same issue and attached TF-A patch leads to a successful
> RMM initialization, please have a try to see if it can resolve your issue.

Thanks for the patch! It works perfectly for me on QEMU-virt.
Much appreciated.

Thanks,
Kohei

> 
> 
> Thanks,
> Gavin


