Received: from canpmsgout05.his.huawei.com (canpmsgout05.his.huawei.com [113.46.200.220])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 200CD27E1DC;
	Thu, 21 May 2026 01:31:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.220
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779327124; cv=none; b=U49rdmdmdqapkLlVIiAGyz+B842lo9jmr0KpUWVWW/2rtIrWHExaGg+YpIA3lt//mVYzrDtar7G7C+yuIWnp16ArUnaLRTCoFpRHXgDxrFtH4TnaJPJt16v9p76eYpNu5lh0v/SHS1Us0G3f5IOVAe4vNbH+IMqHkTvsgIh2PNI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779327124; c=relaxed/simple;
	bh=jF8sgXgn04GRDwNGSbuyEAo0d8JjA0+nkei72Y70qcU=;
	h=Subject:To:CC:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=oTP6ehjUqRky5c6gBhWX3ToxRqhoQ4CtypuC2Yq5Sfx2Ke+oAncXRmtxD3qw9EnbQg6Yb2flMX6TSTaIT78OegUamnTJR1D30pXTmLw3bxs/59/OJ+us4Tzi3+n71fVrBgSHHfILdPfO3mKPW2LHYDvURGpYatYvtd5WkrN1JYw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=ioUspSJD; arc=none smtp.client-ip=113.46.200.220
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="ioUspSJD"
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=ujtd++1n7QvQustbvlI3/9WH1ZnAAxvQToAjdj5qKFI=;
	b=ioUspSJDKkoNC66iz0+Qa2hV/Ue3IQ+Vth9+KJ9/JtghnMbnUSRwm4s3MRdR77FVxQixQrnII
	wtjETA8sWrJK+/K9ageIjigvqw5WAjcKR5sMlat7k7YzyA8wl687zzizXO5lBqKWfuMjhGBpwwZ
	fAPRvBhmCId2dL93Oy4y1KY=
Received: from mail.maildlp.com (unknown [172.19.163.0])
	by canpmsgout05.his.huawei.com (SkyGuard) with ESMTPS id 4gLW0q4DL2z12LF4;
	Thu, 21 May 2026 09:24:43 +0800 (CST)
Received: from dggpemf500015.china.huawei.com (unknown [7.185.36.143])
	by mail.maildlp.com (Postfix) with ESMTPS id 642A640561;
	Thu, 21 May 2026 09:31:44 +0800 (CST)
Received: from [10.67.121.110] (10.67.121.110) by
 dggpemf500015.china.huawei.com (7.185.36.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Thu, 21 May 2026 09:31:43 +0800
Subject: Re: [PATCH] hisi_acc_vfio_pci: simplify the command for reading
 device information.
To: Alex Williamson <alex@shazbot.org>
CC: <alex.williamson@redhat.com>, <jgg@nvidia.com>, <kvm@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
References: <20260514092026.2018844-1-liulongfang@huawei.com>
 <20260520151146.3a5c7500@shazbot.org>
From: liulongfang <liulongfang@huawei.com>
Message-ID: <1064defe-f01e-dd38-1d78-b997357b400b@huawei.com>
Date: Thu, 21 May 2026 09:31:43 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20260520151146.3a5c7500@shazbot.org>
Content-Type: text/plain; charset="gbk"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: kwepems200001.china.huawei.com (7.221.188.67) To
 dggpemf500015.china.huawei.com (7.185.36.143)

On 2026/5/21 5:11, Alex Williamson wrote:
> On Thu, 14 May 2026 17:20:26 +0800
> Longfang Liu <liulongfang@huawei.com> wrote:
> 
>> From: Weili Qian <qianweili@huawei.com>
>>
>>       The mailbox operation for the Hisi accelerator device now
>> provides a new read function that supports direct information retrieval
>> by specifying commands, thereby simplifying the related mailbox command
>> handling in the driver.
>>
>> Signed-off-by: Weili Qian <qianweili@huawei.com>
>> Signed-off-by: Longfang Liu <liulongfang@huawei.com>
>> ---
>>  .../vfio/pci/hisilicon/hisi_acc_vfio_pci.c    | 39 ++-----------------
>>  1 file changed, 3 insertions(+), 36 deletions(-)
> 
> Applied to vfio next branch for v7.2.  Thanks,
>

Thanks.

Longfang.

> Alex
> .
> 
