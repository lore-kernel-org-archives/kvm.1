Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 420891D416C;
	Mon, 15 Jun 2026 01:11:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781485884; cv=none; b=uIp55Sg4xFd6wMO2X5mu3P7fZzDZsaembmUEdMgYDNZVU7fbgRRZiNLizP5sJccOsozy7xB2+XFRjQgNqwKkPPTX9+b23bsYNYmQzugyeQSY6oLwK659y4mcT+ojKiNrJzR/Pz1+WLsAqbg8W840wjpaVELW0GjNhs86+6r7Kas=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781485884; c=relaxed/simple;
	bh=fvkw8AnTeqFfJPet5zd38ViFUQFIdOE3Ewp5RPtxVCY=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=K7hwrtA974Ou1/DnTg4RUwv7kLw81FthMzowjyDzWS7/qr1qAmRUCa/e+zsZviQBxYtx9jlu0Cid7eVka9dt8TOWRfv6EmLQ6OULkpKKs9n/oyr7hdgyODIIfgks2t+Yshn081yyhKX/jJ4TgcuOvBvwOSsL9i1nDlUKB3abr/Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=iJ0Yuazp; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=iJ0Yuazp; arc=none smtp.client-ip=45.249.212.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="iJ0Yuazp";
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="iJ0Yuazp"
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=E7ZvbE7BwtLHMzXQlT1GQ43SMkNk7cDPFW0RcMil7y8=;
	b=iJ0YuazpIvf7mPsTmABXDLDD3MERRs48OsH+rxdQ8qjKsgFqrSX1m9zauAyqDXhAA7lPoDWpn
	uwDejTXHrQM/ZHgzmtaqtGrHG4GhP2EvqyMXVZcQJ1TtilVK+RyMkonZaRKx/22pa2zmVoTQMaU
	GB7ttfdvR9V64VEwnfTUq/E=
Received: from canpmsgout08.his.huawei.com (unknown [172.19.92.156])
	by szxga01-in.huawei.com (SkyGuard) with ESMTPS id 4gdsWB2gN8z1BGdb;
	Mon, 15 Jun 2026 09:10:46 +0800 (CST)
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=E7ZvbE7BwtLHMzXQlT1GQ43SMkNk7cDPFW0RcMil7y8=;
	b=iJ0YuazpIvf7mPsTmABXDLDD3MERRs48OsH+rxdQ8qjKsgFqrSX1m9zauAyqDXhAA7lPoDWpn
	uwDejTXHrQM/ZHgzmtaqtGrHG4GhP2EvqyMXVZcQJ1TtilVK+RyMkonZaRKx/22pa2zmVoTQMaU
	GB7ttfdvR9V64VEwnfTUq/E=
Received: from mail.maildlp.com (unknown [172.19.163.163])
	by canpmsgout08.his.huawei.com (SkyGuard) with ESMTPS id 4gdsLG3DmkzmV70;
	Mon, 15 Jun 2026 09:03:02 +0800 (CST)
Received: from kwepemk500009.china.huawei.com (unknown [7.202.194.94])
	by mail.maildlp.com (Postfix) with ESMTPS id C17044048B;
	Mon, 15 Jun 2026 09:11:00 +0800 (CST)
Received: from [10.67.121.161] (10.67.121.161) by
 kwepemk500009.china.huawei.com (7.202.194.94) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Mon, 15 Jun 2026 09:11:00 +0800
Message-ID: <b7a1e71c-c2d1-49d1-993c-c50873b92fbd@huawei.com>
Date: Mon, 15 Jun 2026 09:10:59 +0800
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 5/5] vfio/pci: Latch all module parameters per device
To: Alex Williamson <alex.williamson@nvidia.com>, kvm <kvm@vger.kernel.org>,
	Alex Williamson <alex@shazbot.org>
CC: linux-kernel <linux-kernel@vger.kernel.org>, Jason Gunthorpe
	<jgg@ziepe.ca>, Kevin Tian <kevin.tian@intel.com>, <kanie@linux.alibaba.com>
References: <20260611213539.4100590-1-alex.williamson@nvidia.com>
 <20260611213539.4100590-6-alex.williamson@nvidia.com>
Content-Language: en-US
From: fengchengwen <fengchengwen@huawei.com>
In-Reply-To: <20260611213539.4100590-6-alex.williamson@nvidia.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: kwepems500002.china.huawei.com (7.221.188.17) To
 kwepemk500009.china.huawei.com (7.202.194.94)

On 6/12/2026 5:35 AM, Alex Williamson wrote:
> The vfio-pci module parameters of disable_idle_d3, nointxmask, and
> disable_vga latch vfio-pci policy into vfio-pci-core globals each time
> the vfio-pci module is initialized.  The disable_idle_d3 parameter has
> already migrated to a per-device flag in order to provide consistency
> for refcounted PM operations for the lifetime of the device
> registration.
> 
> Pull the remaining vfio-pci module-parameter policy out of vfio-pci-core
> into per-device flags set at device initialization.
> 
> This also restores the mutable aspect of the disable_idle_d3 and
> nointxmask module parameters for vfio-pci, with the caveat that the
> parameters are latched into the device at probe.
> 
> A notable change for variant drivers is that their devices are no longer
> affected by vfio-pci module parameters and those drivers may need to
> adopt similar module parameters if any devices have a hidden dependency
> on vfio-pci setting non-default policy.
> 
> Assisted-by: Claude:claude-opus-4-8
> Signed-off-by: Alex Williamson <alex.williamson@nvidia.com>

Acked-by: Chengwen Feng <fengchengwen@huawei.com>

Since this change will affect our TPH feature, it would be great to get
this merged promptly. We plan to send the updated TPH patchset based on
this work.

