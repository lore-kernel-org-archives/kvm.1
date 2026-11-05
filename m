Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.57.37
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793890137;
	b=AoZo0Xo2bhFrw+pwDMmsRPSts1wAefm2pQvzgCDgdTfsp1D1uJnLlaQUv9igFsQ4KkMj
	 ScYDnKyHE9UslUkWDB9AHFaki8q3D3ZoTodYjw8u9LoPjwGX46rFnVZuXVrW2zDaTkCod
	 1gjlBo+TQSNuAT3lpNI+quYTpaN5b9M+hrfHpgfpjfDaHR2S2hcLLbWXxJxPtNQ8BBEnJ
	 CeTJfaDBfmejk4PnIVocoE095pYhryZovXaXuL38JjAW8DZ0qEt1GHuujaxHvXFXDEMPm
	 FHblUko2P5F03GHE65T9WcDFVr1ABYitre/nPPEvoY2W2fHzEQFpWFTahpvn8N2nJ3w==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793890137;
	h=DMARC-Filter:DKIM-Signature:Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:Content-Transfer-Encoding:Content-Type:
	 X-ClientProxiedBy:MIME-Version:X-MS-PublicTrafficType:
	 X-MS-TrafficTypeDiagnostic:X-MS-Office365-Filtering-Correlation-Id:
	 X-MS-Exchange-SenderADCheck:X-MS-Exchange-AntiSpam-Relay:
	 X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
	 X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=59mzC/SUaq+dWNv6foVeZK1IWurnNKFJ5YtzJpKMSIA=;
	b=nBml1aDG8HtjLIACXAQhSrvHIPJ8gBE0JrSFZd59UQ/4fMP6+opKVQTlQ6Jin6usM32m
	 kkPcEvi6FaCfBpAZW4GZSnsDTmu63h/vsH+AzIpKLwEcffN8sl3fkWsXwMnwIFXZF3OqD
	 lsrJU57O+dtQuw1Foow0bGCDLQiY7r2SzevCdQCbeQjDpKvUDtB3luwba2h53L5YzeDGN
	 fublhogzFINFL6XCS5afX3eSEVJxFYiUFtIZQbCX2TtmhOl2ZwhbO5uJRVVNiD6wPMSyp
	 DvCNjG/HdeL1i0DOjhZj+ckMyUMB/bXFSET55bplNJZA15O+sSrEECrLvuVxhS5jeTA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nvidia.com;
	spf=fail smtp.mailfrom=nvidia.com;
	dkim=pass header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=n8OC4dpU;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.57.37
Received: from BN8PR05CU002.outbound.protection.outlook.com (mail-eastus2azon11011037.outbound.protection.outlook.com [52.101.57.37])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E7DD606A31B;
	Thu,  5 Nov 2026 14:48:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5E7DD606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=n8OC4dpU
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CC6F5NH3N/QeoiegI7vRnP4i2O2Ms6ZBwDTwacN/LTfZJbwo9yUZdtKeBxVBSKiLom2wOWkELLBX5WNcGX3nHWyb/eoj9YiO8gZog/HEYSUxqXwINWxRwC4B9tz76CWngXMWqGt5b0sy7q5W7r/6dHc2QfbtIkQ+7Z5htCVJtIgWt792wFtAIpi1+t81LqjJZ/9bB6KCIQt1/NX61u4bfL7cly/VOvKLPgZjkjm6ofsvZHXSkU0avctKhXp9kb/QCG5ScuU//XL3AG285Ql5zrN+RXxfE5SbZnDfcuGUqIO+ckaBTzz3FgmsZTRDCODjwsPbo67v2WS8UCGnVXPBrA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=59mzC/SUaq+dWNv6foVeZK1IWurnNKFJ5YtzJpKMSIA=;
 b=YpZbA91zcdFBcq2r4ib8KtIxx4PP6+K2wZd8/a9mnoizYGQDLwRb/SFDtNpli+M/DfTfcEX5Cd9BDmOoFqRc9V1ImReG9x+1HvmkYhhWC/0bUjIYKbLpiEqJtT4TNb7H628D+GxzKtwYRlpYFFydDqK7hz7DT8ILNgqYDFXYpMnFS6Dp3AvwoYHv8cENqF4Q3RFCarVN2VzfK1afTYghrl1QLx1LXPobyBYjFcEaYqRt476E7IaL9hr4Zf+af/LoWveeo8sH8G2jwueShiERtfxOuZaNx8Z/uQ5YO64jrvo8vAeVlO4xYUfJjQvanLVaMNIbetaSd3/mpSjJF10L+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=59mzC/SUaq+dWNv6foVeZK1IWurnNKFJ5YtzJpKMSIA=;
 b=n8OC4dpUQBQP2A2Abrk7dpwZvURS/8b1fWx5gi7P384OUwk8CAgGgd4sOox0cj/fti3MdwJoIT/Fuu7KDvpwdlO6xq7sCp3u75WtXgmryi7RHCuTpvmNKzcDEKp9AcAQrUqGPc9wjm4w+d1cBORti9wA03Arx7wn1GLn5P1DCcvHjH0rLCqJgywoJI4BrLq7QyXF4JL/yRg9g/TMTqhOhWb+nxW3vvdE9eSTkrnd4rZCR+uFJK7x11Ex+Uk+D9kAIUwebuU/xI47jmMb7GA7ZloTUio7hUmDopEyBDweRDeIk6Djgx+5uERJWylLzNZ49pE1YYcq0ym8cmkKkeVjiw==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from PH7PR12MB6393.namprd12.prod.outlook.com (2603:10b6:510:1ff::15)
 by IA1PR12MB6482.namprd12.prod.outlook.com (2603:10b6:208:3a9::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.10; Thu, 5 Nov
 2026 14:48:45 +0000
Received: from PH7PR12MB6393.namprd12.prod.outlook.com
 ([fe80::6562:4ede:3d29:f036]) by PH7PR12MB6393.namprd12.prod.outlook.com
 ([fe80::6562:4ede:3d29:f036%2]) with mapi id 15.21.0592.007; Thu, 5 Nov 2026
 14:48:45 +0000
From: Wojtek Wasko <wwasko@nvidia.com>
To: netdev@vger.kernel.org
Cc: richardcochran@gmail.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@kernel.org,
	kuba@kernel.org,
	pabeni@redhat.com,
	mtosatti@redhat.com,
	pbonzini@redhat.com,
	cjubran@nvidia.com,
	kvm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Wojtek Wasko <wwasko@nvidia.com>
Subject: [PATCH net] ptp: kvm: report paired cycles for the active clocksource
Date: Thu,  5 Nov 2026 15:48:21 +0100
Message-ID: <20261105144821.5299-1-wwasko@nvidia.com>
X-Mailer: git-send-email 2.54.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: ZR0P278CA0127.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:40::6) To PH7PR12MB6393.namprd12.prod.outlook.com
 (2603:10b6:510:1ff::15)
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB6393:EE_|IA1PR12MB6482:EE_
X-MS-Office365-Filtering-Correlation-Id: 4f8ca964-2895-4780-b73b-08df3b4be48b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|1800799024|366016|376014|7416014|261022105027099003|261028144727099003|10067099003|261021121427099003|261021123027099003|261026121527099003|261026140227099003|261102123227099003|11063799006|56012099006|18002099003|261009223027099003;
X-Microsoft-Antispam-Message-Info:
	j7MAiWhLGuumf3n8kV0WW3z1tM+wGVJcvVgjfs1PZT1hnPolp7SE6C2x92y7vAulsTVlFAxV743JfeopvXXJCBRiT/r4hSuOkDkAjey0YOsH+NX/UKl/0yc770JnvWTmXz12AJy1oCLmMtPxBYpTQKw7pyrXbRj5Fx2WivTsX/Jan22b9DRsy1Jid5u+MubvByoiwi/7UFTR+kF4qMIGAUGsWYwrIkqzu3UhQBgKFl0WiOQc8lXMmQxsAFAditfcbXvc2pRmbbL3iwu0lXSqEMZgZ//K0G/aJp5bhrVcYXNrEaIQlWy7Gta/BD3hbR+AOaFZb9OVZhTY1ztsxSJ90tcvVyy0J8VaIV3PVK/hThsxJnN1yrDGm8v03RggjEMOwf2vm0nih7AGEiMrKTS+igx/Elj0nqOgPlOSd6E8sEoWwycd8lHC2CglKJiJLGbktj0CLHfM2IuFe4hjGXk7Z9an/F3NHsWHRsgTaah/QpaVZefXr0ulJ62J6j1X2kLBhX4pDwXxVnSyX/0/4APxMh39V5oTvCdB11kg3F2FWqIhc1VOeQuf9E5MBU3sBkz3sWpgTkrCLv+hV8/beZRrk5Vae8QWtxU8JEPikxbM8BCueB/aRSKD6Z91I6kOs4n4aqq5AHKAnhQPuTwrDF1/ZE9L3wfGwygcyA+23mJ1lRc=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR12MB6393.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(1800799024)(366016)(376014)(7416014)(261022105027099003)(261028144727099003)(10067099003)(261021121427099003)(261021123027099003)(261026121527099003)(261026140227099003)(261102123227099003)(11063799006)(56012099006)(18002099003)(261009223027099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?+bz2yPW7sa4ZIok9DZNZW4VRqsXfdZ3CFezY2rMDL5QMDQCm/HDbZGs8E8ro?=
 =?us-ascii?Q?WZkjKynxNIVRAg1BFsw98I48/1GAe5WqWAMRtv/z40wTJn0/4dzK+jLFsn/I?=
 =?us-ascii?Q?VRiYarSQ6Y9zWOFCQLeg0vBQvDbCWSGSxmhTeTksC7Ro3ONXTt8L1b0pOmO6?=
 =?us-ascii?Q?on2noRibkIEb+wrmHTz3139Lnee/qG++LY5UDrlHPub4GUqm5BWsMmpmEkhy?=
 =?us-ascii?Q?XP/H2Bsx1jXQ6v8j+c6lLOEU92D6ypHuULqE5y89/CgS0YWl3UplONGpavdl?=
 =?us-ascii?Q?Vyrh8L+ia0yxXBfe8T7H/hDGhV0pujbSxbraDN/zQt8+bjioo68gkiuLCEBO?=
 =?us-ascii?Q?9ZiOzN+H5qH8LesXNq+rNVU7XSla5GkKYHlXXTyXMpOrNRtqPqmHR5R8/gCy?=
 =?us-ascii?Q?7hMlpoLEiGy23SbSbFOVN1Cf6lsB3uZWQPfHUv2lG5vz9GVLbsWUCSDwIP0R?=
 =?us-ascii?Q?a39hPfoxxHst91IulrMEiUQDtwKVcNArW4QSpC/dng61GhcBTfAQvQE3ftfH?=
 =?us-ascii?Q?U04W1NW3urMU6p8loR04Bf9+rQnzBogtPf9Du5y7ZjCfDyZk1DBZaQITvKJe?=
 =?us-ascii?Q?GvROxb+d9R6ziFVdPKtqgnkiD7xJBLuV3KgertYe5snUKklkYxYaySj4zeW1?=
 =?us-ascii?Q?0enWo2NgnXTutgUnvzb7opd3dPGp5Aign41n9dcGVJSQjp+hOHMHcJV2ldXG?=
 =?us-ascii?Q?MPX+WYNdsuC5c51LbKSmx2K5KlpzVZKM0C6VXhy5/LidfmkkyHmOGNgp5ITF?=
 =?us-ascii?Q?mwRV/fuZYLnGXWsvM0myMqdUr2gvbQQa+eE/66IyXC7fS3I0req3hjFDSpKY?=
 =?us-ascii?Q?o+G7DmOCBwXpos8LBrlZUqk8J34qRSPeEhg0ayRIVskR9hwgB9H4uO/unum8?=
 =?us-ascii?Q?aWDHnRIpFVYPfmAc69cT1uWbyZfJI6Wq88LwEfhIhBguxnX++tM1vI6e1kIw?=
 =?us-ascii?Q?D6fsdnZuWzuPj+UpeTvYznp/JpoLhWwyu6azraAA8uM/OLCfp8rULxAbwoRG?=
 =?us-ascii?Q?RJ+uPcEqU9p63ACWr6puPxYzzpEACeRPtIiK62odjT4uZk5Xl3o2JgDl0M9F?=
 =?us-ascii?Q?BBzT8wBFGVWBO4CTj8/dzOax8/rzNw9sp51l9tdM6j5cRHKpRfNlTawi2BUD?=
 =?us-ascii?Q?ZtxRyJx8j6wZ6aFtyJ/YTdmpbup94QWb3oOqxNEV5Wy4Nxel5EJP0q5qCje9?=
 =?us-ascii?Q?/LBJxK2BufaL9aXf5xChn4iCqka5KYMafRaim549+/J0P6UTQd3AoSsVm3XO?=
 =?us-ascii?Q?OIrm3vK2JeK13OlsaY8iBj88zw+qnnotXiOAygaXtMhadgeAMey8wV7LLrMc?=
 =?us-ascii?Q?OPaatt3WzTSlTy6ZPUWxRyyhWGKgHVG7adF4IqalT9Uxg016ykBC54RcxXkS?=
 =?us-ascii?Q?2tYWnuUIFh8l6IZovteL3gOL8/KgJ4YweNOzYXN4omX4+8j5YzZQH1yjwwwG?=
 =?us-ascii?Q?X03fNrKxP1AuBN8mXzNSQXoSaGuTcfhpj/3RUiGnhGnDBS4CIzkKU+GTkodp?=
 =?us-ascii?Q?1t3qGzM60A0NHQDsjQL0S/lKZUU9rdCBLIfjG52UP+YfNVFmWYpHSBfQm9T4?=
 =?us-ascii?Q?dLQvGfgH3dmvYXP8CSCn/Ea3r72cWzE/Qoq0/KfRrOQx5ISluoXgttmBbA9r?=
 =?us-ascii?Q?dRf6thIYnwgIgvO6AwVXSgsSXlMSawqyGdkVOanXS5gmUSqHUdLRYG6rTayR?=
 =?us-ascii?Q?UuWYJBw9LuVTzzgl7aaKYe2vnv7wkrrTuENkkLjGzim08gpr9W2A/ModlBft?=
 =?us-ascii?Q?Jdk/y2Z8MQ=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4f8ca964-2895-4780-b73b-08df3b4be48b
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB6393.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Nov 2026 14:48:45.5360
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: T5TIA4Wwo6UCiJwe99Udf8JpQAQYnmTNLebZzrQ1E2370ZEX2bMudYXue/dx3ZyP46NSQyUBvo/5GtvNzfwvrA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6482

The KVM clock-pairing hypercall returns host wall time paired with a
guest TSC value. Cross-timestamping needs that counter expressed in the
guest's active clocksource domain.

ptp_kvm always converts the paired TSC value to kvm-clock units and
reports it as CSID_X86_KVM_CLK, so precise cross-timestamping
(PTP_SYS_OFFSET_PRECISE) fails on guests with TSC clocksource.

Return the paired TSC value directly when TSC cycles are requested and
convert it to kvm-clock units otherwise. If get_device_system_crosststamp()
rejects the counter with -ENODEV and the active clocksource differs from
the requested one, retry once using the active clocksource.

Fixes: a0e136d436de ("PTP: add kvm PTP driver")
Signed-off-by: Wojtek Wasko <wwasko@nvidia.com>
Reviewed-by: Carolina Jubran <cjubran@nvidia.com>
---
 drivers/ptp/ptp_kvm_common.c | 28 +++++++++++++++++++++++++---
 drivers/ptp/ptp_kvm_x86.c    | 13 +++++++++++++
 2 files changed, 38 insertions(+), 3 deletions(-)

diff --git a/drivers/ptp/ptp_kvm_common.c b/drivers/ptp/ptp_kvm_common.c
index 15ccb7dd2ed0..e11fcf961758 100644
--- a/drivers/ptp/ptp_kvm_common.c
+++ b/drivers/ptp/ptp_kvm_common.c
@@ -23,12 +23,13 @@ struct kvm_ptp_clock {
 };
 
 static DEFINE_SPINLOCK(kvm_ptp_lock);
+static enum clocksource_ids kvm_ptp_cs_id = CSID_GENERIC;
 
 static int ptp_kvm_get_time_fn(ktime_t *device_time,
 			       struct system_counterval_t *system_counter,
 			       void *ctx)
 {
-	enum clocksource_ids cs_id;
+	enum clocksource_ids cs_id = *(enum clocksource_ids *)ctx;
 	struct timespec64 tspec;
 	u64 cycle;
 	int ret;
@@ -58,8 +59,29 @@ static int ptp_kvm_get_time_fn(ktime_t *device_time,
 static int ptp_kvm_getcrosststamp(struct ptp_clock_info *ptp,
 				  struct system_device_crosststamp *xtstamp)
 {
-	return get_device_system_crosststamp(ptp_kvm_get_time_fn, NULL,
-					     NULL, xtstamp);
+	enum clocksource_ids cs_id = READ_ONCE(kvm_ptp_cs_id);
+	struct system_time_snapshot snapshot;
+	int ret;
+
+	ret = get_device_system_crosststamp(ptp_kvm_get_time_fn, &cs_id, NULL,
+					    xtstamp);
+	/*
+	 * The paired counter value is not in the units of the current
+	 * clocksource. If the clocksource differs from the one this request
+	 * asked for, ask for the counter in the new units and retry once.
+	 */
+	if (ret == -ENODEV) {
+		ktime_get_snapshot_id(CLOCK_REALTIME, &snapshot);
+		if (snapshot.valid && snapshot.cs_id != cs_id) {
+			cs_id = snapshot.cs_id;
+			WRITE_ONCE(kvm_ptp_cs_id, cs_id);
+			ret = get_device_system_crosststamp(ptp_kvm_get_time_fn,
+							    &cs_id, NULL,
+							    xtstamp);
+		}
+	}
+
+	return ret;
 }
 
 /*
diff --git a/drivers/ptp/ptp_kvm_x86.c b/drivers/ptp/ptp_kvm_x86.c
index 6cea4fe39bcf..4dd55c60d2ce 100644
--- a/drivers/ptp/ptp_kvm_x86.c
+++ b/drivers/ptp/ptp_kvm_x86.c
@@ -92,6 +92,11 @@ int kvm_arch_ptp_get_clock(struct timespec64 *ts)
 	return 0;
 }
 
+/*
+ * *cs_id selects the clocksource @cycle is reported in: CSID_X86_TSC returns
+ * the paired TSC value as is, anything else converts it to kvm-clock units.
+ * On return, *cs_id holds the clocksource actually used.
+ */
 int kvm_arch_ptp_get_crosststamp(u64 *cycle, struct timespec64 *tspec,
 			      enum clocksource_ids *cs_id)
 {
@@ -99,6 +104,14 @@ int kvm_arch_ptp_get_crosststamp(u64 *cycle, struct timespec64 *tspec,
 	unsigned int version;
 	long ret;
 
+	if (*cs_id == CSID_X86_TSC) {
+		ret = kvm_arch_ptp_get_clock(tspec);
+		if (ret)
+			return ret;
+		*cycle = clock_pair->tsc;
+		return 0;
+	}
+
 	src = this_cpu_pvti();
 
 	do {

base-commit: 57889a8f6d49fc153aa0017d13086ab736567f8a
-- 
2.43.0

