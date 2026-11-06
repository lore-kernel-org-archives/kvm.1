Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=217.140.110.172
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793979445;
	b=KNLXSwTLFOz+Gu6UbuH/sTRTCtckuzGt2GGuXi81xSnEFvtV9g9naKz0cfXisEHQ3HCE
	 cM+AQakJr6u1gbM122UaW3gFz7EqyA9h3ZfEpovhK2E+6Nz79B3/l0IL47HDSX1kuuVzi
	 B57Dxp4z/QmpiqlobPK1X0ZK8Vk4z4AkQ1G5DiR+vZ8y1FP3uzDU4btP/UJ3RLabqYlDm
	 Kh1BzKsRCrLG8VSov5EKYfT9pmYVHqcKOUBTdJ3zJi6Rr3wE9+SSioo6Bixvm7HjaikNo
	 zPt4MgSkHtz6SCuqHmPyZWZ5OZ88jLdUJVOjen3odCFvOC401iEJuLX4unFo1wiUmKw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793979445;
	h=DMARC-Filter:Received:Received:DKIM-Signature:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Type:Content-Disposition:Content-Transfer-Encoding;
	bh=WbInPTtgeVQVaR+YtMP5Ieeyl2biDusMLIdL8tIaNf8=;
	b=QTss/y1JyTyFYqMJlY3efmZgHnbLtAWI6kLs6ljiBVnHS8PortY/50umqgrroHUQfvPM
	 bGfgXCpq7t8qp4LpckDY4sTiB4rW3SnNnfr0k4SN3tBEk1NEjwqcV56buId+uK+Czevwx
	 1gU93YL/U35LtOWnh/k767+BpYloALnktbKRHKHM5NX+QeEybUe/4xiA05HfjWvNMKfUS
	 7e9R7yjS1uCwBbdB1sYD+BuzerQ85wjB3pvAE7VGE4q7xdVelElmb92PcOcblCbYvZKKA
	 D+kuIvOrvtigmdlrsV9Ict8Hh9vWtOFv3uAfJECWZ2hkDpjGAcL2ZEh/+Obq3gOGVnw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=arm.com;
	spf=pass smtp.mailfrom=arm.com;
	dkim=pass header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=WX68Z5yL;
	arc=none smtp.remote-ip=217.140.110.172
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 024D3606A336;
	Fri,  6 Nov 2026 15:37:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 024D3606A336
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=WX68Z5yL
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id DEC4F1650;
	Fri,  6 Nov 2026 07:37:19 -0800 (PST)
Received: from LeoBrasDK.cambridge.arm.com (LeoBrasDK.cambridge.arm.com [10.2.212.21])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 8047E3F632;
	Fri,  6 Nov 2026 07:37:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1793979442; bh=7EK+OV8cc6RynWDVsBo3aQX5rI+zXYDSLKEL403LmQM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=WX68Z5yL6OyzNuu6ZywpIXZrFSwK9X2UJrdZ6ELbVJWB/Rx0VdMU5Rbmy0NZFI+PD
	 m1eJazJZTMQLnD3Wv7gPUGVEW1c51bZ3fbQ9BWbBFFx622ozPIILzlDy0QQ8ZDBTKa
	 ZKgMtPWWAQZ7ODXi1Gn2Q1+KL1k+y4WW/FQyfpNw=
From: Leonardo Bras <leo.bras@arm.com>
To: Tian Zheng <zhengtian10@huawei.com>
Cc: Leonardo Bras <leo.bras@arm.com>,
	maz@kernel.org,
	oupton@kernel.org,
	catalin.marinas@arm.com,
	will@kernel.org,
	corbet@lwn.net,
	pbonzini@redhat.com,
	yuzenghui@huawei.com,
	wangzhou1@hisilicon.com,
	yangjinqian1@huawei.com,
	caijian11@h-partners.com,
	liuyonglong@huawei.com,
	tangchengchang@huawei.com,
	yezhenyu2@huawei.com,
	yubihong@huawei.com,
	linuxarm@huawei.com,
	joey.gouly@arm.com,
	kvmarm@lists.linux.dev,
	kvm@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	seiden@linux.ibm.com,
	suzuki.poulose@arm.com,
	fuad.tabba@linux.dev,
	mark.rutland@arm.com,
	seanjc@google.com,
	rdunlap@infradead.org,
	linux-doc@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	skhan@linuxfoundation.org
Subject: Re: [PATCH v5 12/15] KVM: arm64: Derive the VM hardware dirty mode from dirty logging
Date: Fri,  6 Nov 2026 15:37:14 +0000
Message-ID: <au30Kg7zCnTjoD0u@LeoBrasDK>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <191ab0e3-9913-4927-9f84-c861c8f3bcd5@huawei.com>
References: <20260929103655.85107-1-zhengtian10@huawei.com> <20260929103655.85107-13-zhengtian10@huawei.com> <auimPtktqZ1cwk3-@LeoBrasDK> <191ab0e3-9913-4927-9f84-c861c8f3bcd5@huawei.com>
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

On Fri, Nov 06, 2026 at 06:46:46PM +0800, Tian Zheng wrote:
> 
> 
> On 11/2/2026 11:03 PM, Leonardo Bras wrote:
> > On Tue, Sep 29, 2026 at 06:36:52PM +0800, Tian Zheng wrote:
> > > Both HAFDBS and HDBSS flip VTCR_EL2.HD at memslot-update time. Two
> > > independent toggles allow an intermediate HDBSS-set/HD-clear state,
> > > an illegal combination, and need locking against concurrent updates.
> > > 
> > > Replace both with kvm_arch_update_hw_dirty_mode(), a pure function
> > > of the static capabilities and the number of logging memslots:
> > > 
> > >    - logging && HDBSS-capable  -> HD|HA|HDBSS
> > >    - logging, no HDBSS         -> off
> > >    - !logging && HAFDBS-cap.   -> HD|HA
> > 
> > This last one is gone now, so I guess most of this patch has to be
> > reworked, right?
> > 
> > Thanks!
> > Leo
> 
> Hi Leo,
> 
> Yes, the last one is no longer needed as we discussed earlier in [1], so
> I'll rework this patch.
> 

Awesome, thanks!
Leo
