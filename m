Received: from sinmsgout01.his.huawei.com (sinmsgout01.his.huawei.com [119.8.177.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4C343C3431
	for <kvm@vger.kernel.org>; Thu, 19 Mar 2026 10:35:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=119.8.177.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773916507; cv=none; b=UuexEWrYoTAvgluGQRyEYWHmck9/WsAzZcsuECMhjvhtlsd7ZB+GDjeHxQPI0UBLwHV7bJea2pxNxkAqq2NanAWoljw7pqYShKkHAemVh4odwkl7QX9UexqYZ0fcU26QtJ39g2bPS3njDKbS8rEnQsEMsn5bSflXRgONyOvmxwk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773916507; c=relaxed/simple;
	bh=EgEV/cDsXuL//vUueMkzsJ3jwBmsIY/lvTxKMWJ2PeM=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=iYFGEuO8Vw3pGTIcY+ShZS9qgbWjqAhXsA1b3A4jTZr9vXl7UW7rVx0ZExthjJBTrrpCukOTMOZZB4wCqvzMRcQjbt/uxZk5I+gwFFbU3nxU7l3/tmWqGcHZ5w194kqR/BkOwEWRfQ4Gu9H6LeWg0syI36fy2mmJE0myv4Ms5+U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=B7I6P9lU; arc=none smtp.client-ip=119.8.177.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="B7I6P9lU"
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=axgpoJnH4P9jW2A5jNPwFRoUlFKKAaMI7EAxoj4Hxfo=;
	b=B7I6P9lU+z9Vuau/3wNH1n10uSV13hn3/Su7+IaG2YQ4yEF1OM1RB2qnrefU4r3TY/SaGBI64
	jq4P2yESuTHqXb97F9jBGiaGpLRrqymysITs/qZkOsxoNbitVjosGuDfu+F6foI1wa/4Y4YJifv
	08Jd0wAYiMQNwqyr/0BHCCc=
Received: from frasgout.his.huawei.com (unknown [172.18.146.33])
	by sinmsgout01.his.huawei.com (SkyGuard) with ESMTPS id 4fc26c3XmDz1P7nb;
	Thu, 19 Mar 2026 18:31:20 +0800 (CST)
Received: from mail.maildlp.com (unknown [172.18.224.107])
	by frasgout.his.huawei.com (SkyGuard) with ESMTPS id 4fc29g4fB5zJ46Dk;
	Thu, 19 Mar 2026 18:33:59 +0800 (CST)
Received: from dubpeml500005.china.huawei.com (unknown [7.214.145.207])
	by mail.maildlp.com (Postfix) with ESMTPS id D803740584;
	Thu, 19 Mar 2026 18:34:58 +0800 (CST)
Received: from localhost (10.203.177.15) by dubpeml500005.china.huawei.com
 (7.214.145.207) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Thu, 19 Mar
 2026 10:34:58 +0000
Date: Thu, 19 Mar 2026 10:34:57 +0000
From: Jonathan Cameron <jonathan.cameron@huawei.com>
To: Sascha Bischoff <Sascha.Bischoff@arm.com>
CC: "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "kvmarm@lists.linux.dev"
	<kvmarm@lists.linux.dev>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>, nd
	<nd@arm.com>, "maz@kernel.org" <maz@kernel.org>, "oliver.upton@linux.dev"
	<oliver.upton@linux.dev>, Joey Gouly <Joey.Gouly@arm.com>, Suzuki Poulose
	<Suzuki.Poulose@arm.com>, "yuzenghui@huawei.com" <yuzenghui@huawei.com>,
	"peter.maydell@linaro.org" <peter.maydell@linaro.org>,
	"lpieralisi@kernel.org" <lpieralisi@kernel.org>, Timothy Hayes
	<Timothy.Hayes@arm.com>
Subject: Re: [PATCH v6 13/39] KVM: arm64: gic-v5: Add emulation for
 ICC_IAFFIDR_EL1 accesses
Message-ID: <20260319103457.000047ee@huawei.com>
In-Reply-To: <20260317113949.2548118-14-sascha.bischoff@arm.com>
References: <20260317113949.2548118-1-sascha.bischoff@arm.com>
	<20260317113949.2548118-14-sascha.bischoff@arm.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml100011.china.huawei.com (7.191.174.247) To
 dubpeml500005.china.huawei.com (7.214.145.207)

On Tue, 17 Mar 2026 11:43:18 +0000
Sascha Bischoff <Sascha.Bischoff@arm.com> wrote:

> GICv5 doesn't provide an ICV_IAFFIDR_EL1 or ICH_IAFFIDR_EL2 for
> providing the IAFFID to the guest. A guest access to the
> ICC_IAFFIDR_EL1 must therefore be trapped and emulated to avoid the
> guest accessing the host's ICC_IAFFIDR_EL1.
> 
> The virtual IAFFID is provided to the guest when it reads
> ICC_IAFFIDR_EL1 (which always traps back to the hypervisor). Writes are
> rightly ignored. KVM treats the GICv5 VPEID, the virtual IAFFID, and
> the vcpu_id as the same, and so the vcpu_id is returned.
> 
> The trapping for the ICC_IAFFIDR_EL1 is always enabled when in a guest
> context.
> 
> Co-authored-by: Timothy Hayes <timothy.hayes@arm.com>
> Signed-off-by: Timothy Hayes <timothy.hayes@arm.com>
> Signed-off-by: Sascha Bischoff <sascha.bischoff@arm.com>
Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>

