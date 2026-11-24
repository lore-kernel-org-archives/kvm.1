Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.93.194.48
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795512349;
	b=me4mEJ3IINnISWxNnhWX2bEsAA7HGVTXkAtR0WFuem6o8SJHApp1WGrcDq0Xo/YYapMu
	 Hzf529Gm6WG34U3qDz1gnOxbiOfr1jO8nGlwyGHS7T+kmAbyevynE9FiaTzDuJmlNjfcZ
	 Hwq4XEXclHpMCUvKNHzceSfX0ofl8GlJbcRFvzITlCM6xEOUK5wH1oidVAWPxVpd+xf3p
	 ImEDn+yq/MJZ03tTWUSTsMY6WPnkKZvIx8BN7AyTKDd0ZUCXo3OfTOrAQgyNiTKH8tItz
	 TAvSBkCb6jK+xGzovHeYupL5Ge9qd7d0Q/+jK9P8lfv0BFLOfa8ztiEKPAJ2qTIdW4Q==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795512349;
	h=DMARC-Filter:DKIM-Signature:Received:Received:
	 X-MS-Exchange-Authentication-Results:Received-SPF:Received:Received:
	 Received:Message-ID:Date:MIME-Version:User-Agent:Subject:To:CC:
	 References:Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-Originating-IP:X-ClientProxiedBy:
	 X-EOPAttributedMessage:X-MS-PublicTrafficType:
	 X-MS-TrafficTypeDiagnostic:X-MS-Office365-Filtering-Correlation-Id:
	 X-MS-Exchange-SenderADCheck:X-MS-Exchange-AntiSpam-Relay:
	 X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
	 X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-Id:
	 X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=wXmG0zdwH9xqPqArQBged4cPxsvHOofTCISDl5mNgBE=;
	b=W0N7wZdeDq8QIcz6l3+Z0Y0io+9qD5waFoMiL7x847CC6aJ5iGxMC1iBxD8anMPFUKls
	 ryrjQylCfDa3AnSNPFMonr6QIPYq3Zpf8WolCFVKJ2z2oqtI3OtYOaa9VhncaQiU7Krwr
	 WvBqSV3YY90ILMxA/0H+egPC1Inz/LvENUcO3cGBlORhox3Au7HEQ7cTpJGTygJTgPYAX
	 EiDFppXxJ0m+wN5qOcajagJHZ7uvTTxLQ4WdGxIr4aXHXrxp+DQGfexs/tBgya1SU9RFM
	 p3Kmgz2QhitURAONYrvaBDsN6TzrymsQQtgcXuqoNmTRhTL+9LEyxMMl522XrlFikcg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nvidia.com;
	spf=fail smtp.mailfrom=nvidia.com;
	dkim=pass header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=D10DacUT;
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.93.194.48
Received: from SN4PR0501CU005.outbound.protection.outlook.com (mail-southcentralusazon11011048.outbound.protection.outlook.com [40.93.194.48])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 083EB606A33B
	for <kvm@vger.kernel.org>; Tue, 24 Nov 2026 09:25:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 083EB606A33B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=D10DacUT
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RFlI8olhKCVo1I/OtcvVSS/AhRP/3kTGR1Q0KZYhgvx/nmL8IB8PneUSY+fn2fRzv4eV3N1uWuBFEfr1y1yliL9Fi+hojovUSHOy0darN3yDxaH8Jo6oqCr6cznYISye4QGItlB2rrX103xJ4CBQamFkk0jLEvkLRBb2jEAlbtafvxPnPbBapIXjIpxbWlv8D/q+UbAmk3kCaPmCjuur3y4yz9a5fMxmICUdX2e3j++gT74hvMB2B8JB9zcKEtC1W2mo/6uqkcsZKLwvOEDvrmqZBFndpLH3DhjzvnauIsA8mN1Uz+nxqTPSsKg/lJhirHkB/+eByDkd4oZI+7tzSg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wXmG0zdwH9xqPqArQBged4cPxsvHOofTCISDl5mNgBE=;
 b=TnPOJuFusw9v8Pi9YRRbbGBcQmhmVOrTj4cPB5GkpmhFEKAAISdJOVpk2xocxqauvYH+9/fSAm83GlUtFJwhTXrOZ3S/yL1Q53UNIP9iy7HUHSHKfN+14emjK8tDoNWFXnJkssY3VYleqm8D5sYWwqZAADDxK6gvkG4mSRaPq0nRd7I8jfLSE6niVKzkUh+fTjUqlKfYB4ZTI7xEUsTgojAGLtPJ+jDG62FCX5MiR+XR9bHgUWemDZUb1qJb1RRfLNAcgq5cXYuF4cdnoaR4cwuDCWLTSCK/NeXHQvQhHdnDhac60E9c4igbvhhYR8mLQA6eknpti4Abuuv0aNh25A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=gmail.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wXmG0zdwH9xqPqArQBged4cPxsvHOofTCISDl5mNgBE=;
 b=D10DacUTgXan/42HLJvNzjHma9YCmGlnDnzySAtd9QIKkPNLS5KxRrdGzuHsbNQrfSlSy3F1382sd7qDEUIQ96R3A87BCErnSy1/WyfI9WR4jGd7xiMVTbLtzWQQY/fZqnuIwozmzGSoqN56okZwvlUaB/rwdJAT50c+v8QIfpVmQes+CYARz/GzR91h9ert6KvL7M0uZoK/Y9wS7otVvw9vR1afI5KzJAwyjPZ/sg9h5gGxZ8kxD8cGyeT7UmCiSh3Yx3QFmpSNhDF7H81Oqu5MCVqQbZ+pwHSSGEH2BbxQWoTbWb2TiDAMBTUid/5x4pzmBXGlrsH2blffU+QAug==
Received: from CH2PR02CA0030.namprd02.prod.outlook.com (2603:10b6:610:4e::40)
 by MN2PR12MB4389.namprd12.prod.outlook.com (2603:10b6:208:262::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.14; Tue, 24 Nov
 2026 09:21:43 +0000
Received: from CH2PEPF00000140.namprd02.prod.outlook.com
 (2603:10b6:610:4e:cafe::69) by CH2PR02CA0030.outlook.office365.com
 (2603:10b6:610:4e::40) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.662.5 via Frontend Transport; Tue, 24
 Nov 2026 09:21:43 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 216.228.117.160) smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CH2PEPF00000140.mail.protection.outlook.com (10.167.244.72) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.662.3 via Frontend Transport; Tue, 24 Nov 2026 09:21:42 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.57; Tue, 24 Nov
 2026 01:21:23 -0800
Received: from [10.221.209.237] (10.126.230.37) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.57; Tue, 24 Nov
 2026 01:21:21 -0800
Message-ID: <3cac8cb0-d598-49af-be35-0ead813af486@nvidia.com>
Date: Tue, 24 Nov 2026 11:21:19 +0200
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] vfio/mlx5: read migration buffers and f_pos under
 migf->lock
To: Qican Ma <goonsomeway@gmail.com>, <alex@shazbot.org>
CC: <jgg@ziepe.ca>, <skolothumtho@nvidia.com>, <kevin.tian@intel.com>,
	<kvm@vger.kernel.org>
References: <179550684160.38664.16653575201489890045@gmail.com>
Content-Language: en-US
From: Yishai Hadas <yishaih@nvidia.com>
In-Reply-To: <179550684160.38664.16653575201489890045@gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF00000140:EE_|MN2PR12MB4389:EE_
X-MS-Office365-Filtering-Correlation-Id: 944fdff4-a122-4260-8af5-08df4a0c5aa0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|23010399003|36860700016|82310400026|376014|1800799024|10067099003|261022075727099003|261021123027099003|261102123227099003|261026121527099003|56012099006|11063799006|261022115727099003|261026140227099003|261021121427099003|261028144727099003|261022105027099003|261009223027099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
 p5ABOVtQdl5kZ2hTNxZEvyk7z/DjqTzu0XZymH97Oj7i+9MWhEOXqCPCfW5NTzyJu0Ky1OPGGa9jMC+far0aoTfW2Cd/M6ohsPv+KbouEs4RsUMvbne34lafbur1G3uWPnRW6nGNq6cxiUNMXUReBuSLI2yBIOa7a4JwZFPxx9K5fzmTCPVvjcQssWJD2S0mFfC9DDI7nzg+l83ZcU9YKOLqorqQa7McYbHNAu1K9Ui6u8exqT/UtuLhUrw8i170VhZbvVGckrsEP6TInLg0FqOqHFSHL3/b40MYr3zY48Hx8FRz8CnKB3jYYRzOQPm0SdkIJkv1JEmqirDCjXI2m4b1KEDpa6yQaUfBzKv/2fw2ptAd67p9rMfHYUvWPu2oNE8MWaeuDJPa1HkOgbnU+i4SVMQbzfDfrrzd/ZWMUYyIPT0NH2t3PJkxoVsI56+hZ6cPg6NuxqC0HK/zJEU4NgcEzl2a/nELIkv3KIBp/QOz+SxCX5Ql/GRCNXcX9nA375IRP9dYA9qKGaX1nPV5cHtkGJCQZkpZKRXJhBKgWJMvEchz9/vHFHmfF+ZbMEVUFDr/Yn5+giysp4i7Qpg+EgztO9+IO5cgApEov5aWK+fDcXyvml0e1jKpEy3eDrVOMU+dLvssISgTs9HZZ8SkYOThu6S6mtoMFNFd1s/+SSppCtdxNN7OIas+BtYwzpShotxGOXGbdAomkTRQTN8eVg==
X-Forefront-Antispam-Report:
 CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(23010399003)(36860700016)(82310400026)(376014)(1800799024)(10067099003)(261022075727099003)(261021123027099003)(261102123227099003)(261026121527099003)(56012099006)(11063799006)(261022115727099003)(261026140227099003)(261021121427099003)(261028144727099003)(261022105027099003)(261009223027099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 chIT1G1g8QJsJyh6OGJCKX3E7WCC28Y3whypffjI5m2GmbS28ZB9Zp7VdlnYPM0E1VRqfk4hUGofKLEWXP/cKZ8PnThKM97BABxioLIGm3MxLL77L71/ERwe9H83jrYzuDvzIiPaymWUGYjIWZFdZryX1kcqzCjH7oN8D2tLY+pRCTI8DDPPRXy4mOo63wUXBdSe+hNi9J1AFkr+Xt4RNZkRUSdvayARwDgkg4v5E1WXcUu45IPkUAu99g60YeYd0CDz9+HhVQOawrNk+cKimAX3mf6bAmaJDHNI9EOr6eSJo7h3/2MLcqu5UY5Ln6mwu46CDuUm8v/TjOLgNr/7xsKssoRYNb3V9kCKpCtpt34j+aXxlQ7UIXmoJ0/coh5PUwFbUkkzD9lYf7v7C4EaCtAkxKSSTq3789OhCWz9f5hxiTxOMuORrYqHTgZ2Cmin
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Nov 2026 09:21:42.8926
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 944fdff4-a122-4260-8af5-08df4a0c5aa0
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
 CH2PEPF00000140.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4389

On 24/11/2026 9:54, Qican Ma wrote:
> mlx5vf_resume_write() caches migf->buf[0] and migf->buf_header[0] and
> validates filp->f_pos before acquiring state_mutex and migf->lock.
> Because the migration file is opened with stream_open(), FMODE_ATOMIC_POS
> is cleared and concurrent writes on duplicated descriptors are not
> serialized by f_pos_lock. A racing writer inside migf->lock can free and
> reallocate migf->buf[0] or migf->buf_header[0] in PREP_HEADER_DATA or
> PREP_IMAGE, leaving the unlocked caller with a stale or freed pointer.
> 

Right, the cached buffer pointers can go stale.

> Move the f_pos overflow check and buffer pointer reads under migf->lock

Moving the f_pos check under the lock is fine, but it doesn't fix a
real issue. All other accesses to *pos are already under the lock. The
early check can only see an older value, which is never negative and
can't get close to an overflow, so its result is the same.

> after the MLX5_MIGF_STATE_ERROR check, matching the pattern used in
> commit 4ec5e932e636 ("vfio/qat: fix f_pos race in qat_vf_resume_write()").
> Set done = -EINVAL rather than ret = -EINVAL on invalid f_pos so the
> migration file is not transitioned into MLX5_MIGF_STATE_ERROR, preserving
> existing behavior.
> 
> Found with an LLM-assisted code review tool and verified by inspection on
> v7.4-rc4 (b6a9fa34ce4). Build-tested only due to lack of mlx5 VF
> live-migration hardware.
> 
> Fixes: 6fadb021266d ("vfio/mlx5: Implement vfio_pci driver for mlx5 devices")

In that commit, resume_write() had no cached buffer pointers at all.
They can go stale only once resume_write() frees and reallocates the
buffers, which was added by commit 34e2f27143d1, so it should be:
Fixes: 34e2f27143d1 ("vfio/mlx5: Introduce multiple loads")


I would suggest something like the below for the commit message in V3:

vfio/mlx5: Read the resume buffer pointers under migf->lock

mlx5vf_resume_write() reads migf->buf[0] and migf->buf_header[0]
before taking migf->lock. The migration file is opened with
stream_open(), so concurrent writes are not serialized by f_pos_lock.
A racing writer may free and reallocate these buffers in PREP_IMAGE or
PREP_HEADER_DATA, leaving the other writer with a freed pointer.

Read the buffer pointers under migf->lock, after the
MLX5_MIGF_STATE_ERROR check.

While at it, move the f_pos check under the lock as well, as f_pos is 
protected by it. This is not a functional change, as f_pos is never
negative and can't get close to an overflow.

Fixes: 34e2f27143d1 ("vfio/mlx5: Introduce multiple loads")
Cc: stable@vger.kernel.org

Yishai

> Cc: stable@vger.kernel.org
> Signed-off-by: Qican Ma <goonsomeway@gmail.com>
> ---
> v2: resend via direct SMTP without line-wrapping corruption in the diff.
> 
>   drivers/vfio/pci/mlx5/main.c | 17 +++++++++++------
>   1 file changed, 11 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/vfio/pci/mlx5/main.c b/drivers/vfio/pci/mlx5/main.c
> index 18a6d224b1f..ebcc22bcb75 100644
> --- a/drivers/vfio/pci/mlx5/main.c
> +++ b/drivers/vfio/pci/mlx5/main.c
> @@ -884,8 +884,8 @@ static ssize_t mlx5vf_resume_write(struct file *filp, const char __user *buf,
>   				   size_t len, loff_t *pos)
>   {
>   	struct mlx5_vf_migration_file *migf = filp->private_data;
> -	struct mlx5_vhca_data_buffer *vhca_buf = migf->buf[0];
> -	struct mlx5_vhca_data_buffer *vhca_buf_header = migf->buf_header[0];
> +	struct mlx5_vhca_data_buffer *vhca_buf;
> +	struct mlx5_vhca_data_buffer *vhca_buf_header;
>   	loff_t requested_length;
>   	bool has_work = false;
>   	ssize_t done = 0;
> @@ -895,10 +895,6 @@ static ssize_t mlx5vf_resume_write(struct file *filp, const char __user *buf,
>   		return -ESPIPE;
>   	pos = &filp->f_pos;
>   
> -	if (*pos < 0 ||
> -	    check_add_overflow((loff_t)len, *pos, &requested_length))
> -		return -EINVAL;
> -
>   	mutex_lock(&migf->mvdev->state_mutex);
>   	mutex_lock(&migf->lock);
>   	if (migf->state == MLX5_MIGF_STATE_ERROR) {
> @@ -906,6 +902,15 @@ static ssize_t mlx5vf_resume_write(struct file *filp, const char __user *buf,
>   		goto out_unlock;
>   	}
>   
> +	if (*pos < 0 ||
> +	    check_add_overflow((loff_t)len, *pos, &requested_length)) {
> +		done = -EINVAL;
> +		goto out_unlock;
> +	}
> +
> +	vhca_buf = migf->buf[0];
> +	vhca_buf_header = migf->buf_header[0];
> +
>   	while (len || has_work) {
>   		has_work = false;
>   		switch (migf->load_state) {

