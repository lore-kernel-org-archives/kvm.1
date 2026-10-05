Received: from SJ2PR03CU001.outbound.protection.outlook.com (mail-westusazon11012056.outbound.protection.outlook.com [52.101.43.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17C734C8C48;
	Mon,  5 Oct 2026 15:43:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.43.56
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791215033; cv=fail; b=VjpLTqOzaIfZlgMiSqnb5k7RskP3dLMrrx7WpzyXh8A8GEQsG8yQK+zLQAEAfxRi9FnBLapaQkD7lsg/Voi6nB3NRy1ykLUsbKYWzKsIUfJRXPjq/k8Ko0MXwghWbCb7GBBlGaS8jH/ExIceujmJptsojPsh5Qhu702H7NBOzpc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791215033; c=relaxed/simple;
	bh=HKFEWozLpsNk28YjYw9Hj8UFEqMd3S7qGZWbL/ylw54=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=ecQfOC4qD99qKs7KR+fCm7wqHuM/NJ5jBGucpjqQ0LKn81IEQUDVoee14Mub8reRniU46JIABoMokCGvM+iKrlUrbAENJUnsuicYKJTPuRK3xj+86DWz4EUQz2hrh8OJGpEmSoI7pQSCPnZ5Jbe3UI/GCFpf/wKEp0rLD5jVJCU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=CHpkXPHY; arc=fail smtp.client-ip=52.101.43.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="CHpkXPHY"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xK3n63hBnsWXinNBh1OIJH8VqgWfwjVYDNVemKsaj01Yc/oupc+KIDJt8BGTB42llutjx9iq8PsrpF8i4DvOfHLwuHdSTGBQ37Of3TENS8YFCm8790fmmLNpsYwZzJWlan+n4bUi1t/RNMJq1hHLjqVhMMN7Trmh7fvnZqjipDyEhFX8MUJN5GkQGVVQPDofcdQEZEDlVBL5H9QpFqMMahqMXImNSC6jrNTOnRPtoEmxwVpvVdUDw0YoxJhX6v81GW9+/2SGB71O3SeUMY06azzYaCXBrGZZW667hRAfMkrHW1I2kO0Chi6HUDjp6AdCCaf5KQPVs7Tzl9DUNwmJaw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LJk3rb76VWGWfDHrH9B7JdJv/7OhzjK2lCU2YqKpjJc=;
 b=dQulp2ANU40BJ9CFfRuTovhQyhqjVOEnC3PXXC7P7kONxwWcTjMsTvRhW/XC1qTFhjmBbp9vC6d8CRy3DMoMJav0OO3HBrVwniZqJCceaM1b8UFCJTl0XD9CyjnOJHQN0SVWNYBe7vsabswsZujKNK/Tfh8Ppo4gBof0kvxNTkh+iPzOl8ocAzWZohKsGO/8iVBV/pFW4clalgRzaKg/5Lw7n+bhXguHuGbW1HQcqyyKEVWlbHyeMsbKfqbdu3xCZIKTKUPc2P2KPU1EvN9aG/SWTUyr7nk4XS32yaIZGwOf9npuozz8sCnuxmzo97SRqQdGfn9vTmwYlunejLww2w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=snu.ac.kr smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LJk3rb76VWGWfDHrH9B7JdJv/7OhzjK2lCU2YqKpjJc=;
 b=CHpkXPHYq+MsBZpjclGvLhTZ75C7GEU4aBsr3CTTsYKUb+2GbTlE6E7IHCKI/aPLQC2ldSIofW4ovQPxg8baQpkKypd2und4b+amMP5hq4gN1gGb03Ptr7Uf+kdpxBuYMBtE3CRT2kNjD3FanC3PNY0AGoC874MKh5HfTryJvC4WkVgc7SyHnYLKnj/XYwbRvQ1AL4f/Uk2w4gnoXTjy/laJtYDM41wpQzv0DNjsfdVDDi5HnWccvT7RK2C/++UVZFgE2gEpuG6bzsD7o1+XBsT/q7KhN35NmyJmncsOBrRPZ5b4Weo+z7iazMLx8K2kNzmDpyFCVGIiw/FCqNdbAA==
Received: from MW4PR04CA0138.namprd04.prod.outlook.com (2603:10b6:303:84::23)
 by PH7PR12MB7379.namprd12.prod.outlook.com (2603:10b6:510:20e::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.20; Mon, 5 Oct
 2026 15:43:43 +0000
Received: from SJ1PEPF00001CE9.namprd03.prod.outlook.com
 (2603:10b6:303:84:cafe::4c) by MW4PR04CA0138.outlook.office365.com
 (2603:10b6:303:84::23) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.472.20 via Frontend Transport; Mon, 5
 Oct 2026 15:43:42 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 216.228.117.160) smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 SJ1PEPF00001CE9.mail.protection.outlook.com (10.167.242.25) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.472.14 via Frontend Transport; Mon, 5 Oct 2026 15:43:41 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Mon, 5 Oct
 2026 08:43:12 -0700
Received: from [10.125.200.122] (10.126.231.37) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Mon, 5 Oct
 2026 08:43:09 -0700
Message-ID: <d4477773-a95d-4cc4-8d10-edf1f7b215df@nvidia.com>
Date: Mon, 5 Oct 2026 18:43:08 +0300
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] vfio/mlx5: Fix boundary check in set_report_output()
To: Seongjun Hong <hsj0512@snu.ac.kr>, Jason Gunthorpe <jgg@ziepe.ca>,
	"Shameer Kolothum" <skolothumtho@nvidia.com>, Kevin Tian
	<kevin.tian@intel.com>, "Alex Williamson" <alex@shazbot.org>
CC: <kvm@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20261004-vfio-mlx5-fix-boundary-check-v1-1-1d3b8e55e23f@snu.ac.kr>
Content-Language: en-US
From: Yishai Hadas <yishaih@nvidia.com>
In-Reply-To: <20261004-vfio-mlx5-fix-boundary-check-v1-1-1d3b8e55e23f@snu.ac.kr>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: rnnvmail202.nvidia.com (10.129.68.7) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CE9:EE_|PH7PR12MB7379:EE_
X-MS-Office365-Filtering-Correlation-Id: 5b088726-ef2a-4621-b8b5-08df22f76e7a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|36860700016|82310400026|1800799024|376014|6133799003|18002099003|10067099003|22082099003|3023799007|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info:
	noH6lMe6eRxY1J/ZIz0JSfQIv/Vn2LzBzpf/OOHUupSSS5pGfUIzX4BfAlT4I0rE0Kna9V7RSpb+W+EhD+iraIAU/wpINWx020Zt4TCYV51fkARD3m2shOx5FLNdVSdReb2gUltFEynQlj8U+Qa5Vo2ppeMy7nXKaOFxFoDdts9o0Oi8vwqQT8QmAygxIYzDRyTSTkCUJTXfajEcU+Qmv6BHLG8cyiZ2M+9zHGcJSUcYilTqXJIDokZCwn4xfp1aVoXrYonhzZe4PivzwDjaXXGTyoqquxW/k34MVPgam3LHl/EJXJ54k3t2nNTODrO3qtTgKjAca0kSqZBwLNYPR1yYPBsGg13JfULzOnO3wHMBnljgL3JcNCy4SnW0N9NODFHD9RX/p39EJ8lBpVGnzSyv6zgEUsPZHrtcX0ZrsMP0N4rhDvDVjZLMSMtMXfTrbn1QM1iFB4DnKYBrn/JNjyzNloQle4JEOIgFnrTQcLruQmscEBQTmwS3DdwPzGDz3jITB/QiyNdDAuTqEWVOXJfB8+tJlQXxKYB2lF/lD7hRN3xuAGAxzz3WxhzyVC2Y72rQB+pdz3GB+dlOU2/mnV0oig7Cekgi6UGLrxFK0BSSkVwcgRiC5juRamLnIF/I7qTaSIqcoDUl6wFiWz05e58JET7qPVj0WdIw2P3edV0P9nczqOn7pwfMoz2FQDQbXlJUNo6CIRqqRFYLAYW5Nw==
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(23010399003)(36860700016)(82310400026)(1800799024)(376014)(6133799003)(18002099003)(10067099003)(22082099003)(3023799007)(11063799006)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	IMow+fz2hD28socSss3rwc8PBfM8vO0sJlnDrg1/Y6Mx8/8tSA4nrkt1fbwfmOBwmsaT1Id3igt1XMCAnc1XJ3RkPkd7zAWoYC1H1SEZZNviFtDyJktyzqwUEO56jcL3o2EdeVPwW1OZhECP2IahZcHGQRlvROOMQA5FaBNdNAMTepLW5261m3LhnDdL4ZRYqe6F8fPNScEt/NPqpgWKGkKgBs2bsIGmc0nkOH9iV7HopGpy39t1FSVuKAC/41a4DTOAYx87nv0mjzTkDwHJwaVVmfNrST5ez8CcBmvbuK9TOxq+mcdLxahkmxZwDTDCuzqEY5/M7ZjaI97fcjMM6FW7jnbmVdk3p7rxvkT25OpV3QHGzAwGRWESvF98ku0W5aoe4HhWV8epf7y7Sxtvr7UeN0BSRkBmgeBTqmpXyf2PqfXPiIYTywRVkgYhFd7c
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Oct 2026 15:43:41.5320
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5b088726-ef2a-4621-b8b5-08df22f76e7a
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00001CE9.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7379

On 04/10/2026 20:20, Seongjun Hong wrote:
> Use > instead of >= on boundary check of recv_buf to avoid the bug which
> the full message in the last slot of recv_buf is ignored even though the
> received data size does not overflow the recv_buf.
> 
> Clarify the second boundary condition by removing unnecessary division by
> entry_size. It directly shows that size should be within qp->max_msg_size.
> 
> Fixes: 9c7c5430bca3 ("vfio/mlx5: Align the page tracking max message size with the device capability")
> Signed-off-by: Seongjun Hong <hsj0512@snu.ac.kr>
> ---
>   drivers/vfio/pci/mlx5/cmd.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/vfio/pci/mlx5/cmd.c b/drivers/vfio/pci/mlx5/cmd.c
> index 5fe0621b5fbd..a49531666e6d 100644
> --- a/drivers/vfio/pci/mlx5/cmd.c
> +++ b/drivers/vfio/pci/mlx5/cmd.c
> @@ -1644,8 +1644,8 @@ set_report_output(u32 size, int index, struct mlx5_vhca_qp *qp,
>   	int i;
>   
>   	buf_offset = index * qp->max_msg_size;
> -	if (WARN_ON(buf_offset + size >= qp->recv_buf.npages * PAGE_SIZE ||
> -		    (nent > qp->max_msg_size / entry_size)))
> +	if (WARN_ON(buf_offset + size > qp->recv_buf.npages * PAGE_SIZE ||
> +		    size > qp->max_msg_size))
>   		return;
>   
>   	do {
> 
> ---
> base-commit: 6addb4f385570ebc11c4eb499a4f1c149f313e84
> change-id: 20261004-vfio-mlx5-fix-boundary-check-4839d6aecbe2
> 
> Best regards,

The patch should include also Cc stable for the first condition.

Reviewed-by: Yishai Hadas <yishaih@nvidia.com>

Yishai
