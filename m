Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.52.43
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795522663;
	b=QJ2ZGiEJ26G2+sD2KS5YDdBiq0mTTMG31rNalPN61iHIK4WOYmlwP3AfTUybMoQJPWkp
	 1juxx4FG7dxFmLgvQYNObOqYDaFtI/CS4axbN8Qbs4nERNlw/96d4Lw7P12G4ZUN7+cLp
	 w4Wbl7TnuHElNyEcxgXWffjQnyE3j9ocoK8j+UroDp/hSWf+cRLrVkZKudc4ZCslUyEcq
	 uWaoYDzDW1d8ZvEVINqveWPt4cnOLD0OOdQD/PWhxe861uki6CInh0PLWa68BBCdu+mNU
	 9ZDn4MKIhWAuNL+/nXPq+1eSZR7/AJD4iFSyAExLq9JuaqJg/O9OJdzrqS+ai90ZhLg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795522663;
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
	bh=37QvHzgiQ+0e28/hXtcZ3cGWMdFnsX+G9UHfcdJbw2M=;
	b=Yo1Y5/y7qdKhA9eC4vAy3lYj7gjlGnFZ2bpQMfkXdP3w/a26u4CrfT7Wqq0s8qsmVyEj
	 Rg4KPeQH/W1kWbmIoA92EZ8KKC9FAtl80JG+08TEHKxe+8JORrW3kP+f7iGUanL3vfF2D
	 rHM5VpfrHErN6DTursPJ7CDajSpx2HUyR6cw8JmFV+QpJcupA5FmpCnirOu1kzk+RXb4U
	 FE1Z2OLVwbBxheQ+eud1W8dzNJ+//KSTyNMh69zG1LjOwP6YCl3niCqKaORw5VY4m7ZF4
	 82OGe9G2pJcMZKdtLD58MAfARVicyWeQu3CcVQqCFJVvQi+UzhO4v/3cDgah7Owgepw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nvidia.com;
	spf=fail smtp.mailfrom=nvidia.com;
	dkim=pass header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=ggy9r8tG;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.52.43
Received: from BL2PR02CU003.outbound.protection.outlook.com (mail-eastusazon11011043.outbound.protection.outlook.com [52.101.52.43])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21151606A31E
	for <kvm@vger.kernel.org>; Tue, 24 Nov 2026 12:17:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 21151606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=ggy9r8tG
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WXQ2WDHlDuL1YgGucjPWnWbEHKKdCTookQSUzZPswoGmow3yvBMri0qFXKPrgjB9hxZdgJvslYO9PEZtr+FneeVThyDw4nryCd+tAbzxyO3ONrEXkK9xzHNdBHkBgbGLtZCsSUd3SJ7V2hx6VAFYu2UD9BIciQMRb0wmbGPBLuZ2dvi4gXcD/IOLtheWq9EPsZlZh8upO6/vWKKnE2U4sTeF0jE0gXhb+AoDRSZrAge4JI7yT46f2npPlDJqh5lJeud7V2XYIgGz6NMzFyQpw1PWKOrIziyLcvUMzJ2DBlOKWEANqIhoYA//hBT6PCprfEbVo7CYUS3DTZeDeVzfsg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=37QvHzgiQ+0e28/hXtcZ3cGWMdFnsX+G9UHfcdJbw2M=;
 b=O6tuGEHj0316ajA9wxH/+y/Q4RVg6NvYX1k0wHj24Pt2Zw2+RcY0cAYGscI2t9MphYI2urhjaM9nig/d80gFqomIE2pLFaYEKbjCISSFlO9jsxylXiQnCi3oxz3fyo30xVPGN36JZfcJBmav2JyYsFmHgagGLwbEVnvMXmGsZ5a1xxMu5/bTEbe3FDL+DSAIGHa9AHgovu7mK05pEpnhYQVwdOFLYqiR138Y3AUctJYjllARFw+pjr5Wqt4gJjr8PrsSme9AqhU/yWIovTWdkPp1ff7FMGYMT12dcZ8KX51y92Mvy5adJjiGz7pUffqVOYka4GP0VcMVvzotEP1exQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=gmail.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=37QvHzgiQ+0e28/hXtcZ3cGWMdFnsX+G9UHfcdJbw2M=;
 b=ggy9r8tGjseWETKMYJMopwc9Tme+yAF6SpnFwHivmb45Dl1Nz0lcT0HBy7zFJ4zDW/RA36d1i3/kUfiB7JjeGVoX7x6NLApyA48ZnE62WXhz7SOHNMpbYazW4dJx+leJDou1Dz62t1A+/voD85qh42yY7G1HKLaiiuu9NgfHKPqV6oBxt+5cQVNhUoVKj+d6u3iXEHd3EmuXRIjuo2UF/yRp9rkNNdkh5j7+0GvqdV/irL39DrIKJjhwHEsM42Lp5VmbKwR7xL/GIzL+7ODSxkvr/l1RkrCVkWugT6coJ7XXzBXx38sGxt8ayfCrIwia+s87D/qz9p7uXZ4Fu/BwlQ==
Received: from BN9PR03CA0374.namprd03.prod.outlook.com (2603:10b6:408:f7::19)
 by PH7PR12MB7817.namprd12.prod.outlook.com (2603:10b6:510:279::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.639.14; Tue, 24 Nov
 2026 12:17:37 +0000
Received: from BL2PEPF000352D6.namprd02.prod.outlook.com
 (2603:10b6:408:f7:cafe::91) by BN9PR03CA0374.outlook.office365.com
 (2603:10b6:408:f7::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.662.6 via Frontend Transport; Tue, 24
 Nov 2026 12:17:36 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 216.228.117.161) smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BL2PEPF000352D6.mail.protection.outlook.com (10.167.254.6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.639.5 via Frontend Transport; Tue, 24 Nov 2026 12:17:36 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.57; Tue, 24 Nov
 2026 04:17:13 -0800
Received: from [10.221.209.237] (10.126.231.37) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.57; Tue, 24 Nov
 2026 04:17:11 -0800
Message-ID: <a92b82de-bf82-4bc9-9403-6ec23fdcb5ca@nvidia.com>
Date: Tue, 24 Nov 2026 14:17:08 +0200
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
Subject: Re: [PATCH v3] vfio/mlx5: Read the resume buffer pointers under
 migf->lock
To: Qican Ma <goonsomeway@gmail.com>, <alex@shazbot.org>
CC: <jgg@ziepe.ca>, <skolothumtho@nvidia.com>, <kevin.tian@intel.com>,
	<kvm@vger.kernel.org>
References: <179551955962.71139.3396358892015584482@gmail.com>
Content-Language: en-US
From: Yishai Hadas <yishaih@nvidia.com>
In-Reply-To: <179551955962.71139.3396358892015584482@gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL2PEPF000352D6:EE_|PH7PR12MB7817:EE_
X-MS-Office365-Filtering-Correlation-Id: 077c0ffd-496b-4e0a-306b-08df4a24ed21
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|36860700016|1800799024|82310400026|376014|261022115727099003|261026121527099003|261022075727099003|261102123227099003|261022105027099003|261026140227099003|261028144727099003|261021121427099003|261021123027099003|10067099003|11063799006|56012099006|261009223027099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	Kspe2PlCZ7U1n2QluKtkyisLug+kJthg7pt16NB+bvwgIq9EkYzJlrxYrtJ/mToEdpfPg4k8VX4Y9XmBLW8AWYqf44qFjLz06oypTq4v9xTM7+ca4uYLNMt2FmwIYoD4Jx656UstUDlFwvaZM8wlqxtcpw8g2lrTbimKBcVpX8soNFKU+g05Z0Jl2JJ8JJuO0eY85oLQrFBmkKJTzQnVzfI62DnDZX6Gyvrdm8Bb4PnwDNkeVQt1jwJ9pR6RcRqW32m/G6xmAqs2anwgt8UvNCKRA12UeHBWyZCa6sivoI7Crt2V6Q8fdW97zcwR1RAmy1SltLmp4xfBPheV8PBXY0efTTjVD3cPVlHuckgiZ8Nwpj2i5YUSD8/u/5Rr93RvjkU3aJlDSNKvyoUDuZAu+tM5nM+NJdca+89zChdHCFMdnYDHikvKfo1HCtg9qZFiW1v+fY8fQ8yOEPv29NcwJXIC6h3x/psqiRusGx4sUvGSshI8TsWH3CGx7oTqkZdR1mL2cWk/zAidYSNV5rVJeUZnjhet6FxzJhn3yG88nNH01Lhe66keFZ68YqzE1X1mu831+4R8MaPogPtwmdMVpVCVShmZhDsSbv5NDT6HCHCBKYpCJK/rJGuhwyBtmHm6bJzBPPxTcw/aJJzRGsmt4BEa6A5vyWeXCR23JKAmrdYD2jTfRHHJpVfz7G4v+Eza5p7d9a8JAyWW+/RGwAI19Q==
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(23010399003)(36860700016)(1800799024)(82310400026)(376014)(261022115727099003)(261026121527099003)(261022075727099003)(261102123227099003)(261022105027099003)(261026140227099003)(261028144727099003)(261021121427099003)(261021123027099003)(10067099003)(11063799006)(56012099006)(261009223027099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	wBLeK8H14L568Q7bqXOIOc5FB8Tf8yGI7aGo/itWcCNWkGCqZZBQRT0C8MRSAGuL64TEkPI0GwO40luIl/armR9adPI/QLoDjzOqzdwdaAWMhsQWuANRM99Cywkxw/REnndJWpVuQC/4sehzCK3g4kmtXqVx2uvdgN5hAKvueXkbWRj5WJSpLKLxYPxdemmvY6dnmkDGhIIE9YkZtjVNC9iRQ/73yQkYy22VeSmvKhOr5W0eG+1QJsHeqmzmGe5MS0Dic87H7T5Cp26yVIfLYxe2ODiIKRlSWMktVqMUtm6wZGHnHq58tI9gqrf2AiUSMFsZB6dPwSHylCg64UcQdD5upXCF0csVcDIV2Cj5kqDv8F7PG8FKJncbYQdbmBUXlulBMhWc2sPngSzGdKdXm+85BGLeTelZK6qD05rPS85vd5uUOQaFZuA0H2ZR/NHS
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Nov 2026 12:17:36.5761
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 077c0ffd-496b-4e0a-306b-08df4a24ed21
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL2PEPF000352D6.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7817

On 24/11/2026 13:25, Qican Ma wrote:
> mlx5vf_resume_write() reads migf->buf[0] and migf->buf_header[0]
> before taking migf->lock. The migration file is opened with
> stream_open(), so concurrent writes are not serialized by f_pos_lock.
> A racing writer may free and reallocate these buffers in PREP_IMAGE or
> PREP_HEADER_DATA, leaving the other writer with a freed pointer.
> 
> Read the buffer pointers under migf->lock, after the
> MLX5_MIGF_STATE_ERROR check.
> 
> While at it, move the f_pos check under the lock as well, as f_pos is
> protected by it. This is not a functional change, as f_pos is never
> negative and can't get close to an overflow.
> 
> Found with an LLM-assisted code review tool and verified by inspection on
> v7.4-rc4 (b6a9fa34ce4). Build-tested only due to lack of mlx5 VF
> live-migration hardware.
> 
> Fixes: 34e2f27143d1 ("vfio/mlx5: Introduce multiple loads")
> Cc: stable@vger.kernel.org
> Signed-off-by: Qican Ma <goonsomeway@gmail.com>

Reviewed-by: Yishai Hadas <yishaih@nvidia.com>

Yishai

> ---
> v3: correct Fixes: tag to 34e2f27143d1 and rework the commit message per
>      Yishai's review; no code changes.
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

