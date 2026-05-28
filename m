Received: from mx0a-002c1b01.pphosted.com (mx0a-002c1b01.pphosted.com [148.163.151.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D8292512DE
	for <kvm@vger.kernel.org>; Thu, 28 May 2026 18:32:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.151.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779993156; cv=fail; b=QaPwZRuUYL4Vtva+MqKqEhbt7ufUSgb2HLyLReHAd8sXsjXSgdcAiOHx2c8p08ZuN7DXmxMTj1ygmfbIMM2KcygvzxUOOkBn8LwhZx23J6wJ67szmjvan+mBfVeuASs2BIcetMYsL31jB4oQL8mtO1u7vzfI7wBQrMa2r6Qwhls=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779993156; c=relaxed/simple;
	bh=zwjlSDMmWCb1//nIqCGAy+oGAWz8bR1lvv9dbS8PG1A=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=O6ycNJEWbl578wVB0iM+G1EfT8eUi8PVz02xcKPcRGD1r3kmmYfWa1Q/1g9dAy0+dLvyZkKKCD8iTSl3iSTvO8DR0fyFn7geRxVV9OFmmIeUyuGayAB7SoVcyq9clPZwLkAIzJ862ltD3QKAamm73QwLiidGQSvJFVdzptxaqPw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nutanix.com; spf=pass smtp.mailfrom=nutanix.com; dkim=pass (2048-bit key) header.d=nutanix.com header.i=@nutanix.com header.b=ZCgr9TTd; dkim=pass (2048-bit key) header.d=nutanix.com header.i=@nutanix.com header.b=v7Ss5KJP; arc=fail smtp.client-ip=148.163.151.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nutanix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nutanix.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nutanix.com header.i=@nutanix.com header.b="ZCgr9TTd";
	dkim=pass (2048-bit key) header.d=nutanix.com header.i=@nutanix.com header.b="v7Ss5KJP"
Received: from pps.filterd (m0127840.ppops.net [127.0.0.1])
	by mx0a-002c1b01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64SFUD431950296;
	Thu, 28 May 2026 11:32:26 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=proofpoint20171006; bh=fdnIjNVTFMLGf
	JLDNB17Pm2ptWFNKyoPEt2mDJrigz0=; b=ZCgr9TTdJ8WZMgLfDmKhMNJptVYSM
	wU1i4kNIjzFs8z2FJTjzMZt74rSst1oRH3DspgHRdWDA3N6hcW+hHhRw0bMmtn7c
	4AT9O+8MWJEfj05WXMdH6aPp0/hk4uxClqKNanpZs5x39mURgOWg5YkFOJ8rVgcG
	ieAHIB9xzhrWfvkdd+bjBZzCr6pT7+QISLqXyyfpTW0aEHXpvQ3jvFuHJrfvf7aP
	RFmAZXu3Ogoz1xCfuWobdfnUvYTJsrSTuAOuRN7hBDZqBo4EANpNTyt7UC/lznJG
	orcn6p5BH2nEasJfqo8PGPZZhvlhUOPg7LzJYFZ54IlpT5PwLokjDc1/A==
Received: from mw6pr02cu001.outbound.protection.outlook.com (mail-westus2azon11022095.outbound.protection.outlook.com [52.101.48.95])
	by mx0a-002c1b01.pphosted.com (PPS) with ESMTPS id 4ee7wmaq8d-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Thu, 28 May 2026 11:32:26 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=W0B8odQEOZdJrFQtIlXgUGeTPEvrRx2btLLgt0CTQGcmaYtuthQS+YXd26ndjRszHdgCtqBpiIgS58gzPNhyfGrqBAmLpCRUs/4OiPMVD/zOTYd8QRifvXqqpEEN2i9lg1z8r0gHfkHCxuhnn0Mo93sGQHTB2dLb79DlJAGloLwAFd/ljqdYmtNcVLUGuvvtjnpkAjBqgd/TBHRRivGEBy74fbcl/L0ixsMPausM6HE2Cn2dV2pwItUPRbtlsNnrDy5xrnXpg/OKO6s2vJ5JJ+O23k9EIjottFswBMSHx5NHBZRqM1llhTWyuilQJTb44bP9d3il9KejKiYMW1edlw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fdnIjNVTFMLGfJLDNB17Pm2ptWFNKyoPEt2mDJrigz0=;
 b=RFzhuIfJdm3rtTrlAH52y+e6Y0u/NII2pxPf7YFvkHHh+jKaPob1+A2RibWYns3YXSXx6LW4HdQ0d+N356/Va2UBJGB7SXY378xpy+W5VoMngGQVRdRcsBieq/ddsLLetKRhDNobOCfrQOYpRo1YfJYedzSvw7JsPdbfAOF70DQZwX7Hu0p/zfXivZD4SRpdrcoVunYK/zfbLS9j0Hx/bK14N+Oodz1SMn/4lurz2GEx0Jchx7oPWi7HNqKP97qYD1118ALCSfTwziloTU5yPsx+wxttcxS/96Zwth3qeCqBJkrGjXwoLKEaz3IyHE1kpF+p00Sjr4DCEOuMQFj8QQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fdnIjNVTFMLGfJLDNB17Pm2ptWFNKyoPEt2mDJrigz0=;
 b=v7Ss5KJPuXxAk3fADjl0cMlJ3Z+6cv8q4wuiesbJM0glyE430dkdauU6NCik46m40zv/+BhC76EQ1LSsXtQJQs11iwkYdjMF2QcFwg+AB9jHNCY/1eLOnG9kAg3gQr/9ds4ynZKDkVuXZycVAMsnTVksX7PdBkd+uKgIGObYpUEXVBztA81xVMyzRUgdmAy/2htQPxTaJnxGTFEifU8f3g0/3om/y9FE1a9nKKr3xeda1s60afgLFxtfUAljsRHignBQvwmK3CpCuVB3eAlqwlmReeiJlsQ9fiuCZfzdKp8SGdAVqq2w3Zu4UZChmI0dqOKV705IqiZW/WUuOZdeUg==
Received: from LV0PR02MB11133.namprd02.prod.outlook.com
 (2603:10b6:408:333::18) by SA3PR02MB10999.namprd02.prod.outlook.com
 (2603:10b6:806:45f::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.12; Thu, 28 May
 2026 18:32:24 +0000
Received: from LV0PR02MB11133.namprd02.prod.outlook.com
 ([fe80::10e5:8031:1b1b:b2dc]) by LV0PR02MB11133.namprd02.prod.outlook.com
 ([fe80::10e5:8031:1b1b:b2dc%3]) with mapi id 15.21.0071.011; Thu, 28 May 2026
 18:32:24 +0000
From: Jon Kohler <jon@nutanix.com>
To: Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org
Cc: Jon Kohler <jon@nutanix.com>
Subject: [kvm-unit-tests PATCH] x86/svm: add comprehensive tests for GMET
Date: Thu, 28 May 2026 12:24:10 -0700
Message-ID: <20260528192410.1047581-1-jon@nutanix.com>
X-Mailer: git-send-email 2.43.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: CY5PR20CA0004.namprd20.prod.outlook.com
 (2603:10b6:930:3::17) To LV0PR02MB11133.namprd02.prod.outlook.com
 (2603:10b6:408:333::18)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV0PR02MB11133:EE_|SA3PR02MB10999:EE_
X-MS-Office365-Filtering-Correlation-Id: 0fb2c83c-253a-4746-6230-08debce77659
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|52116014|1800799024|56012099006|6133799003|18002099003|3023799007|38350700014;
X-Microsoft-Antispam-Message-Info:
	pl0zVAl5hPqFbDUbDQCpCYzny24z/Sdafe1ym2n0T5+9q7UhrhvTBeB20fCizWe3gSHeNP6HKLnH27opXzchIRWnHLDGUz6LRp9jf6DGYBWbeuAfrq0usLqCSP5Sms/1DFxR3EM02Ltx4ZnMzkRAs8lzi5GuuqRU9tHBgMuZ+855Wegm3wztubUXSYKkbkk7aoCRno+W8ttswvXLNEPzRlRloBfbRgZ8BotiJeNBre72HCGzKOkoL0A5d+nYzBmJwXgTjoRPurF8Rr17UXeubKJRM716gUEeBNvzuo448y5n4yavFJL+doRvidbeo4HtF25Dd5Na1d67GseeWArNVrj29sruvB078MnXDELHyaftAOvjx+yzWfEEmlmYEbsbqbk1X0XeYvGu6tSqnXAeJpOcF/847uWrZiPyL2Dm8mD4cz06yvKT26UhML09A9AZgaYok3xhz7iJqbG4PZ7WNL+oniNcHaoj2ljeIU4sEJCjhW84QF3+wR2kx+XfoiobPBXQrGdV0/uJxBdsAXJQoAsyQI7q4aV0S6xNlUFDr8qc1IVgp92yVa67QFFVmzRaD+rM7igQuSDq6s4A5WcB0MK9GhJNmOD6gZTOz8/WmJDXh92TqyMbxNL8Fe4D9RfAjIp8xAZ6bovKNHPmjARrnGkm6hpOmn60QVRw0MAuRjVJjaN3Ef6lr1AAHGFN9ODtJj0fdjXv/luDEwUxJWwq2plryzqPB+jbTGIZBNWnXfDmwI5NdxX2PR9HnpDD0cpp
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV0PR02MB11133.namprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(52116014)(1800799024)(56012099006)(6133799003)(18002099003)(3023799007)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?IMJnd+u9POz2l9knybLgReWu5SytkfvlM7y2i98g5/tpuzAxziboIdjoU2Vz?=
 =?us-ascii?Q?BmwJ18wOJyPLcFcDcuNXHwC/CJfv0vV/0dFA8Acaf7JHP9Tv7IE5imBbgxvW?=
 =?us-ascii?Q?Au508+VNZkzDJBul+eVaR2tFj7CpyYE+YGfm5hziMIHS1flHTuSE9n2gOoSD?=
 =?us-ascii?Q?11A0azv7rE5ZmbTd+8qXyWfDzis4IpqTCmZAB4P9v8dUJ2PxWpX9J1KDngq5?=
 =?us-ascii?Q?LL6OWST7ip+bK1qvCGqFzD9ROeRqlz9MyVmxWZQiAWJFp+ahZSu0log/md3+?=
 =?us-ascii?Q?PMVbuPOy4HkAty5uvvRHfzlN3wmCvaIzWrewgHR/V4qG0E2po7chUfzvYD4+?=
 =?us-ascii?Q?TyzAcz+lEqiXLTI+EXwuVsAKicMkCWeC92g3EAc95hszQ2TI77OT81gNexhM?=
 =?us-ascii?Q?d1rROG3KnreatV+iKBGWFlx/thtlcxBdq/MH8eZgolEu5T3hOT0wpN+3ZCRF?=
 =?us-ascii?Q?jswbqtiRP6nlGL3fr5G7q/byT2fSheLUe49g5XfgzK68gAwg3+x6YNvXH82X?=
 =?us-ascii?Q?i0aFYbGxXtB2RqODkcIlBqZw0TG9MSI6NiF9VyZPrKe9Io8weFkayJTx7Ebr?=
 =?us-ascii?Q?XKeeR6q4FgP3UN55rzUPHfcYEnLkHrb3QsioISkRFFSoIhLlwwPc2j103aEq?=
 =?us-ascii?Q?C6LePWVme6VWb41hvZDFoTqRpFX9kadnVFxShVZW8GmfjqdKlOUTzLW+9San?=
 =?us-ascii?Q?08JviHrOdahp9/TXkrDP94bXap7XRJAAESuoG1mp/Qt+wkNHd4I8SXQSam8I?=
 =?us-ascii?Q?LMnLMdsq0kEcHNR2memlu5S3aX9yh4Un2lY2OqcPB3ZxCAkCGxmPIW2Xyah2?=
 =?us-ascii?Q?1HpEK3X5ynQ2I8zvZL0UoAAviS1WLdzzjO7qsitguT5PgMQKnM0SFdfQBK8H?=
 =?us-ascii?Q?3uLv5YuBBV2SZ6iqC6tg39iPe0l9oFu9ueT79/M9XGBC/Pc4g9NeIgQBV5Ec?=
 =?us-ascii?Q?oBxaV/q0Wi/vKhiZGo7i9amsZYwqkdkTfWcQK1+D3C620pjAACjeKBPCnI+L?=
 =?us-ascii?Q?fk28XYHkKUQn4BO9SspJB6Ja4ozyR+Fq3YEGsptiWqO9BaK8h8rCsNm7zhkR?=
 =?us-ascii?Q?J7kCigGQRv+XsWrSDkoQoon138luYp6+RK3cO2WMqtMLLsnrt9c+RxdaaN3X?=
 =?us-ascii?Q?p0gV3Rh4weXGF1S7rXQI9ywylIZTm8WVMBykUwDToBQCYZCz0bEVpHWJpOma?=
 =?us-ascii?Q?slW5Lr8LJ11AZkoi9dEgSfDutwD5w4B4bSGLfQELgiGNNBUd8PhTAxFIYW1S?=
 =?us-ascii?Q?aZlEyvKGmhG9QisZSFvslqE8pWPvtH2b17GC2jOMcFndAQZw66oTZd6PQ8UU?=
 =?us-ascii?Q?hpr5DcLByC2ILPZDLOD+ZyLuKDr3rFSuy/1rehmcpBzo9/Ve+gbwAPoHqP4x?=
 =?us-ascii?Q?eyyYLLfdkHeeLFdRx0HzZsvZZ74VWRZzvpVc5CsZh9iGaFyxRz7XuGV3sAaJ?=
 =?us-ascii?Q?QwoQhs85MPPTkRX3nvlC6JmvnIgKBKtnTmaCUBJ8LTYz+MFDtC5+EGY7E1Ir?=
 =?us-ascii?Q?+C+oVjcG7Fdk03IoTNcH7yjbytuoywPrfuoCc0n8Kpz2qK2zMIhVWizdegF9?=
 =?us-ascii?Q?zLRoX0j05dECKwzEaP7pJRgAAvPxY8rxrFx+f75RfKo3TI7lgmQ4mT1FPyFY?=
 =?us-ascii?Q?uc9JzOZRtto+PPplXnLcLhQF/Qu7d5SouYUgQFMREB+b8U3GwLeCYdE2l1t/?=
 =?us-ascii?Q?SjJ1xAvzADBJ7vT08W4Pc0/3sOUONEuUhsNnP/jYYZ5pVGd0n4eSxqDc8LYB?=
 =?us-ascii?Q?81Q3f3nMLqiVhLJXa153/605Q0+oz0Q=3D?=
X-Exchange-RoutingPolicyChecked:
	N2zUbuxeae8WQNgxE2QmNznz3d+TynTn5F5ukSPdhySBgqFaJP0tNGb5L+3ds47pHnEwpvv90TKcIq/08FD4h6bR1fjg9jLTqzuEX4J5hupkf3Qj3w6XgFV2zXaouGsG9il6GRYoRzlx6h77PfqnoQypAJlR+NjDT+ecmA4MOmIZbAZUke+7w1djRa7kVEmSYllHC2+NXeO3hvrfMILOIvzHV9SUzisGCMAK1ZhE71noS34GTaGkFQGFcQEmzwRdrQKoWLXoEA1HCzDFj4HPW0HA6s2rHXjKOxe9z2IEHWFwGHSKXhiHGE6Xyowvmq+n/MR0AKZ4wWUZ6rYoRb9EkQ==
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0fb2c83c-253a-4746-6230-08debce77659
X-MS-Exchange-CrossTenant-AuthSource: LV0PR02MB11133.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 May 2026 18:32:24.3172
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WyYqF/E1OEU/wG2YhlurNVqtPzjJLRNJ4RwYoFNwydvOy70YueK1VtHd9RBpeGPSyiWm/Cc7XbaYneM2r5XIE8jt8KQNIFeGQjUiEhX+8cU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR02MB10999
X-Authority-Analysis: v=2.4 cv=I7xVgtgg c=1 sm=1 tr=0 ts=6a188a3a cx=c_pps
 a=kd6AeByrnEODuFk93iyKgA==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=NGcC8JguVDcA:10 a=0kUYKlekyDsA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=VofLwUrZ8Iiv6rRUPXIb:22 a=_-M8LpHI31CeLmyZm6wg:22
 a=64Cc0HZtAAAA:8 a=4gIjQoroVgEPG_B87LsA:9
X-Proofpoint-GUID: 182JoLPe4beFXdR8Qn7ILnkjl2K3QitD
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTI4MDE4NiBTYWx0ZWRfX213jJePYYs1Y
 X9gLZruyF78VfVakdcsb9e47+3lJVEhy9DD7iWAMw248KLtvJLOvCJ9snN1yLj4Re3LulRrxNGE
 m0vALYbrAsw/jv/ZL7PNG+4Cm0jFtD6zaHz880O6MbycDA12jiDKZ6/4N74xkx/RqJZSxlrzM0L
 OIuYLglSzKidJjf7EU28hiKuf88nLlgVp+6Bwz9bDuQ4J0R8S8PhQKYPt+hhG0XQid7055fsLhr
 24mk+3vxQpcHzAH4Ia4tBB547850mp+Lnx4F/po4XVc8lr5G9qW/KCZ9QBSlqSBGLlFWXCELqNA
 uq5qqzr2VK0vCe8bA7cesdj7swhT1ZSEW7qtaWpEmlMBKdzyv5CdfvxhHVf5+KTVqc05CtN1WDn
 FFwrGBu4YMXXN+C3GgJkcMMbzTg4lIULfz+i+bfxGcc6PDGTTFGmffahvcLu2cXFjsvreYKAtyI
 uw99EtNeHCvGmjsRjpg==
X-Proofpoint-ORIG-GUID: 182JoLPe4beFXdR8Qn7ILnkjl2K3QitD
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-05-28_05,2026-05-28_03,2025-10-01_01
X-Proofpoint-Spam-Reason: safe

Enhancements:
- Improve code comments on all GMET tests explaining the setup
  rationale and polishing up here and there.
- Update npt_prepare_gmet_pte() comment in svm.c to document GMET U-bit
  semantics (U=0 allows, U=1 traps).
- Add report_info() calls to every GMET check function logging
  exit_code, exit_info_1, and expected values so failures are
  immediately diagnosable from test output.

New tests:
- npt_gmet_rw: verify GMET does not affect data reads/writes (U=0
  data page with GMET enabled should succeed).
- npt_gmet_ring3: verify user-mode (ring 3) instruction fetches are
  not affected by GMET regardless of the NPT U bit, similar to the
  MBEC OP_EXEC_USER -> run_in_user() behavior.
- npt_gmet_large: verify GMET traps on a 2M large page with U=1.
- gmet_transition_v2: verify GMET on/off transitions with U=1 code.
- gmet_matrix_v2: systematic NX/U/access-type permission matrix.

Signed-off-by: Jon Kohler <jon@nutanix.com>
---
 x86/svm.c     |   9 +-
 x86/svm_npt.c | 384 ++++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 389 insertions(+), 4 deletions(-)

diff --git a/x86/svm.c b/x86/svm.c
index beb57f33..283d14ed 100644
--- a/x86/svm.c
+++ b/x86/svm.c
@@ -43,6 +43,11 @@ u64 *npt_get_pml4e(void)
 	return pml4e;
 }
 
+/*
+ * Set or clear the NPT U bit on the 2 MiB code region.  With GMET enabled,
+ * U=0 allows supervisor instruction fetches and U=1 traps them (#NPF).
+ * GMET does not affect data accesses, so page table walks ignore U.
+ */
 void npt_prepare_gmet_pte(bool user)
 {
 	extern u8 start;
@@ -51,10 +56,6 @@ void npt_prepare_gmet_pte(bool user)
 	u64 *pte;
 	int i;
 
-
-	/* flip the U bit on the 2 MiB region where the code is loaded.
-	 * the U bit is only used for execution, therefore page table accesses ignore it
-	 */
 	pte = npt_get_pte(address);
 	for (i = 0; i < 512; i++)
 		pte[i] = (pte[i] & ~PT_USER_MASK) | mask;
diff --git a/x86/svm_npt.c b/x86/svm_npt.c
index 9b46237b..fd8e4f1b 100644
--- a/x86/svm_npt.c
+++ b/x86/svm_npt.c
@@ -3,8 +3,10 @@
 #include "vm.h"
 #include "alloc_page.h"
 #include "vmalloc.h"
+#include "x86/usermode.h"
 
 static void *scratch_page;
+static void basic_guest_main(struct svm_test *test);
 
 static void null_test(struct svm_test *test)
 {
@@ -92,6 +94,11 @@ static bool npt_gmet_supported(void)
 	return npt_supported() && this_cpu_has(X86_FEATURE_GMET);
 }
 
+/*
+ * GMET null: enable GMET with U=0 on the code region.  U=0 means supervisor
+ * instruction fetches are allowed, so the guest should run to completion
+ * and exit via VMMCALL.
+ */
 static void npt_gmet_null_prepare(struct svm_test *test)
 {
 	/* set U=0 - no failure */
@@ -107,6 +114,12 @@ static bool npt_gmet_null_check(struct svm_test *test)
 	return vmcb->control.exit_code == SVM_EXIT_VMMCALL;
 }
 
+/*
+ * GMET NX: enable GMET with U=0 (supervisor fetch allowed) but set NX=1 on
+ * the code PTE.  NX still denies execution even though GMET would allow it.
+ * EFER.NX must be enabled for both the NX semantics and for the I/D bit to
+ * appear in the NPF error code (has_pferr_fetch depends on EFER.NXE).
+ */
 static void npt_gmet_nx_prepare(struct svm_test *test)
 {
 	u64 *pte = npt_get_pte((u64) null_test);
@@ -136,6 +149,12 @@ static bool npt_gmet_nx_check(struct svm_test *test)
 	    && ((vmcb->control.exit_info_1 & ~PFERR_USER_MASK) == 0x100000011ULL);
 }
 
+/*
+ * GMET U/S: enable GMET with the code region at U=0 (allowed) but set U=1
+ * on null_test's specific PTE.  The guest faults on the U=1 page because
+ * GMET traps supervisor instruction fetches from U=1 pages.
+ * EFER.NX is needed so the I/D bit appears in the NPF error code.
+ */
 static void npt_gmet_us_prepare(struct svm_test *test)
 {
 	u64 *pte = npt_get_pte((u64) null_test);
@@ -160,6 +179,363 @@ static bool npt_gmet_us_check(struct svm_test *test)
 	    && ((vmcb->control.exit_info_1 & ~PFERR_USER_MASK) == 0x100000011ULL);
 }
 
+/*
+ * GMET read/write invariance: with GMET enabled and a data page at U=0,
+ * reads and writes should succeed because GMET only traps instruction fetches,
+ * not data accesses.  The code region is set to U=0 so the guest can execute.
+ */
+static void npt_gmet_rw_prepare(struct svm_test *test)
+{
+	scratch_page = alloc_page();
+
+	u64 *pte = npt_get_pte((u64)scratch_page);
+	*pte &= ~PT_USER_MASK;
+
+	npt_prepare_gmet_pte(false);
+	vmcb->control.nested_ctl |= SVM_NESTED_GMET;
+}
+
+static void npt_gmet_rw_test(struct svm_test *test)
+{
+	volatile u64 *data = (volatile u64 *)scratch_page;
+
+	(void)*data;
+	*data = 0xdeadbeefULL;
+
+	if (*data != 0xdeadbeefULL)
+		generate_ud();
+}
+
+static bool npt_gmet_rw_check(struct svm_test *test)
+{
+	u32 exit_code = vmcb->control.exit_code;
+	u64 *pte = npt_get_pte((u64)scratch_page);
+
+	*pte |= PT_USER_MASK;
+	npt_prepare_gmet_pte(true);
+	vmcb->control.nested_ctl &= ~SVM_NESTED_GMET;
+
+	report_info("exit_code=0x%x, expected VMMCALL=0x%x",
+		    exit_code, SVM_EXIT_VMMCALL);
+
+	return exit_code == SVM_EXIT_VMMCALL;
+}
+
+/*
+ * GMET ring-3 execution: GMET only traps supervisor-mode instruction fetches.
+ * User-mode (ring 3) instruction fetches are NOT affected by GMET regardless
+ * of the NPT U bit.  This test verifies that ring-3 code runs under GMET.
+ *
+ * Setup requirements:
+ *   - NPT code region U=0 so supervisor code (test harness) can execute
+ *   - Guest page tables need PT_USER_MASK at all levels (PML4E, PDPE, PDE)
+ *     for ring-3 to work, since svm_npt builds guest PTs without it
+ *   - run_in_user() IRETs to ring 3 and executes the trampoline function
+ */
+static uint64_t gmet_ring3_trampoline(void)
+{
+	return 42;
+}
+
+static void npt_gmet_ring3_test(struct svm_test *test)
+{
+	bool raised = false;
+	uint64_t ret;
+
+	ret = run_in_user((usermode_func)gmet_ring3_trampoline,
+			  GP_VECTOR, 0, 0, 0, 0, &raised);
+
+	if (raised || ret != 42)
+		generate_ud();
+}
+
+/*
+ * Set or clear PT_USER_MASK on the guest page table entries for the first 1GB.
+ * The svm_npt test creates guest page tables without PT_USER_MASK (opt_mask=0),
+ * but user-mode execution inside L2 requires it at all page table levels.
+ */
+static void guest_pt_set_user(bool set)
+{
+	pgd_t *cr3 = current_page_table();
+	pgd_t *pdpt, *pd;
+	int i;
+
+	if (set)
+		cr3[0] |= PT_USER_MASK;
+	else
+		cr3[0] &= ~PT_USER_MASK;
+
+	pdpt = phys_to_virt(cr3[0] & PT_ADDR_MASK);
+	if (set)
+		pdpt[0] |= PT_USER_MASK;
+	else
+		pdpt[0] &= ~PT_USER_MASK;
+
+	pd = phys_to_virt(pdpt[0] & PT_ADDR_MASK);
+	for (i = 0; i < 512; i++) {
+		if (!(pd[i] & PT_PRESENT_MASK))
+			continue;
+		if (set)
+			pd[i] |= PT_USER_MASK;
+		else
+			pd[i] &= ~PT_USER_MASK;
+	}
+}
+
+static void npt_gmet_ring3_prepare(struct svm_test *test)
+{
+	npt_prepare_gmet_pte(false);
+	guest_pt_set_user(true);
+	vmcb->control.nested_ctl |= SVM_NESTED_GMET;
+}
+
+static bool npt_gmet_ring3_check(struct svm_test *test)
+{
+	u32 exit_code = vmcb->control.exit_code;
+
+	guest_pt_set_user(false);
+	npt_prepare_gmet_pte(true);
+	vmcb->control.nested_ctl &= ~SVM_NESTED_GMET;
+
+	report_info("exit_code=0x%x, expected VMMCALL=0x%x",
+		    exit_code, SVM_EXIT_VMMCALL);
+
+	return exit_code == SVM_EXIT_VMMCALL;
+}
+
+/*
+ * GMET large page (2M): create a 2M NPT mapping with U=1 over the code
+ * region.  With GMET enabled, U=1 traps supervisor instruction fetches,
+ * so execution from the 2M page should trigger GMET (#NPF with fetch fault).
+ *
+ * EFER.NX must be enabled because the I/D (fetch) bit in the NPF error code
+ * is only available when the host has EFER.NXE or CR4.SMEP set, even though
+ * GMET repurposes cr4_smep in the MMU role, the I/D availability check uses
+ * the real host values (see has_pferr_fetch in kvm_calc_cpu_role).
+ */
+static u64 gmet_large_saved_pde;
+
+static void npt_gmet_large_prepare(struct svm_test *test)
+{
+	u64 *pde = npt_get_pde((u64)null_test);
+	u64 phys_2m = (u64)null_test & ~((1ULL << 21) - 1);
+
+	gmet_large_saved_pde = *pde;
+
+	/* Replace the PDE with a 2M leaf entry (PS=1) with U=1. */
+	*pde = phys_2m | PT_PRESENT_MASK | PT_WRITABLE_MASK |
+	       PT_USER_MASK | PT_PAGE_SIZE_MASK;
+
+	test->scratch = rdmsr(MSR_EFER);
+	wrmsr(MSR_EFER, test->scratch | EFER_NX);
+
+	vmcb->control.nested_ctl |= SVM_NESTED_GMET;
+}
+
+static bool npt_gmet_large_check(struct svm_test *test)
+{
+	u64 *pde = npt_get_pde((u64)null_test);
+	u32 exit_code = vmcb->control.exit_code;
+	u64 exit_info = vmcb->control.exit_info_1;
+	u64 masked = exit_info & ~PFERR_USER_MASK;
+
+	*pde = gmet_large_saved_pde;
+	vmcb->control.nested_ctl &= ~SVM_NESTED_GMET;
+	wrmsr(MSR_EFER, test->scratch);
+
+	/*
+	 * Expect NPF with fetch + present (0x100000011).  Errata 1218 means
+	 * the U bit in EXITINFO1 may be wrong, so mask it out.
+	 */
+	report_info("exit_code=0x%x exit_info1=0x%lx (masked=0x%lx), "
+		    "expected NPF=0x%x with info=0x100000011",
+		    exit_code, exit_info, masked, SVM_EXIT_NPF);
+
+	return (exit_code == SVM_EXIT_NPF) && (masked == 0x100000011ULL);
+}
+
+/*
+ * GMET enable/disable transition: execute code with GMET off and U=1 (should
+ * succeed since GMET is off), then enable GMET (should fault since U=1 traps
+ * supervisor fetches), then disable GMET (should succeed again). Validates
+ * that KVM correctly invalidates/updates page tables when GMET is toggled.
+ */
+static void gmet_transition_guest(struct svm_test *test)
+{
+}
+
+static void gmet_transition_v2(void)
+{
+	int exit_reason;
+
+	if (!npt_gmet_supported()) {
+		report_skip("GMET not supported");
+		return;
+	}
+
+	test_set_guest(gmet_transition_guest);
+
+	/* Phase 1: GMET disabled, U=1 on code, should succeed */
+	npt_prepare_gmet_pte(true);
+	vmcb->control.nested_ctl &= ~SVM_NESTED_GMET;
+
+	exit_reason = svm_vmrun();
+	report(exit_reason == SVM_EXIT_VMMCALL,
+	       "GMET off + U=1: guest runs (exit=0x%x)", exit_reason);
+
+	/* Phase 2: GMET enabled, U=1 on code, should NPF */
+	vmcb->control.nested_ctl |= SVM_NESTED_GMET;
+
+	exit_reason = svm_vmrun();
+	if (exit_reason == SVM_EXIT_NPF)
+		report_info("Phase 2 NPF: exit_info1=0x%lx",
+			    vmcb->control.exit_info_1);
+	report(exit_reason == SVM_EXIT_NPF,
+	       "GMET on + U=1: NPF on fetch (exit=0x%x)", exit_reason);
+
+	/* Phase 3: GMET disabled again, U=1, should succeed */
+	vmcb->control.nested_ctl &= ~SVM_NESTED_GMET;
+
+	exit_reason = svm_vmrun();
+	report(exit_reason == SVM_EXIT_VMMCALL,
+	       "GMET off again + U=1: guest runs (exit=0x%x)", exit_reason);
+}
+
+/*
+ * GMET permission matrix: systematically test all interesting combinations of
+ * NX, U, and access type (read, write, exec) under GMET.
+ *
+ * With GMET enabled, the NPT U bit controls supervisor instruction fetches:
+ *   U=0: supervisor instruction fetches are allowed
+ *   U=1: supervisor instruction fetches are trapped (#NPF)
+ *
+ * Data accesses (reads/writes) are NOT affected by GMET regardless of U.
+ *
+ *   - Read/Write to U=0 page:  should succeed (GMET only gates execution)
+ *   - Read/Write to U=1 page:  should succeed
+ *   - Exec from U=0 page:      should succeed (U=0 => supervisor can execute)
+ *   - Exec from U=1 page:      should NPF (GMET trap)
+ *   - Exec from U=0, NX=1:     should NPF (NX overrides GMET)
+ *   - Exec from U=1, NX=1:     should NPF (both GMET and NX deny)
+ *   - Read from U=0, W=0:      should succeed (GMET doesn't affect reads)
+ */
+static void gmet_matrix_rw_guest(struct svm_test *test)
+{
+	(void)*(volatile u64 *)scratch_page;
+}
+
+static void gmet_matrix_write_guest(struct svm_test *test)
+{
+	*(volatile u64 *)scratch_page = 0x1234;
+}
+
+static void gmet_matrix_v2(void)
+{
+	u64 *pte;
+	int exit_reason;
+
+	if (!npt_gmet_supported()) {
+		report_skip("GMET not supported");
+		return;
+	}
+
+	scratch_page = alloc_page();
+	pte = npt_get_pte((u64)scratch_page);
+
+	vmcb->control.nested_ctl |= SVM_NESTED_GMET;
+
+	/*
+	 * Make the code region U=0 so supervisor instruction fetches are
+	 * allowed under GMET.  Data-access tests below manipulate the U bit
+	 * only on scratch_page.
+	 */
+	npt_prepare_gmet_pte(false);
+
+	/* Case 1: Read from U=0 page, should succeed */
+	test_set_guest(gmet_matrix_rw_guest);
+	*pte = (*pte & ~PT_USER_MASK);
+
+	exit_reason = svm_vmrun();
+	report(exit_reason == SVM_EXIT_VMMCALL,
+	       "GMET: read U=0 succeeds (exit=0x%x)", exit_reason);
+
+	/* Case 2: Write to U=0 page, should succeed */
+	test_set_guest(gmet_matrix_write_guest);
+	*pte = (*pte & ~PT_USER_MASK);
+
+	exit_reason = svm_vmrun();
+	report(exit_reason == SVM_EXIT_VMMCALL,
+	       "GMET: write U=0 succeeds (exit=0x%x)", exit_reason);
+
+	/* Case 3: Read from U=1 page, should succeed */
+	test_set_guest(gmet_matrix_rw_guest);
+	*pte |= PT_USER_MASK;
+
+	exit_reason = svm_vmrun();
+	report(exit_reason == SVM_EXIT_VMMCALL,
+	       "GMET: read U=1 succeeds (exit=0x%x)", exit_reason);
+
+	/* Case 4: Write to U=1 page, should succeed */
+	test_set_guest(gmet_matrix_write_guest);
+	*pte |= PT_USER_MASK;
+
+	exit_reason = svm_vmrun();
+	report(exit_reason == SVM_EXIT_VMMCALL,
+	       "GMET: write U=1 succeeds (exit=0x%x)", exit_reason);
+
+	/* Case 5: Exec from U=0 (code region), should succeed */
+	test_set_guest(basic_guest_main);
+	npt_prepare_gmet_pte(false);
+
+	exit_reason = svm_vmrun();
+	report(exit_reason == SVM_EXIT_VMMCALL,
+	       "GMET: exec U=0 succeeds (exit=0x%x)", exit_reason);
+
+	/* Case 6: Exec from U=1, should NPF (GMET trap) */
+	npt_prepare_gmet_pte(true);
+
+	exit_reason = svm_vmrun();
+	if (exit_reason == SVM_EXIT_NPF)
+		report_info("Case 6 NPF: exit_info1=0x%lx",
+			    vmcb->control.exit_info_1);
+	report(exit_reason == SVM_EXIT_NPF,
+	       "GMET: exec U=1 faults (exit=0x%x)", exit_reason);
+
+	/* Case 7: Exec from U=0, NX=1, should NPF (NX overrides GMET) */
+	npt_prepare_gmet_pte(false);
+	{
+		u64 saved_efer = rdmsr(MSR_EFER);
+		u64 *code_pte = npt_get_pte((u64)basic_guest_main);
+		u64 saved_code_pte = *code_pte;
+
+		wrmsr(MSR_EFER, saved_efer | EFER_NX);
+		*code_pte |= PT64_NX_MASK;
+
+		exit_reason = svm_vmrun();
+		if (exit_reason == SVM_EXIT_NPF)
+			report_info("Case 7 NPF: exit_info1=0x%lx",
+				    vmcb->control.exit_info_1);
+		report(exit_reason == SVM_EXIT_NPF,
+		       "GMET: exec U=0 NX=1 faults (exit=0x%x)", exit_reason);
+
+		*code_pte = saved_code_pte;
+		wrmsr(MSR_EFER, saved_efer);
+	}
+
+	/* Case 8: Read from U=0, W=0 page, should succeed */
+	test_set_guest(gmet_matrix_rw_guest);
+	*pte = *pte & ~(PT_USER_MASK | PT_WRITABLE_MASK);
+
+	exit_reason = svm_vmrun();
+	report(exit_reason == SVM_EXIT_VMMCALL,
+	       "GMET: read U=0 W=0 succeeds (exit=0x%x)", exit_reason);
+
+	/* Clean up */
+	*pte |= PT_USER_MASK | PT_WRITABLE_MASK;
+	npt_prepare_gmet_pte(true);
+	vmcb->control.nested_ctl &= ~SVM_NESTED_GMET;
+}
+
 static void npt_rw_prepare(struct svm_test *test)
 {
 
@@ -469,10 +845,18 @@ static struct svm_test npt_tests[] = {
 		.supported = npt_gmet_supported),
 	NPT_V1_TEST(npt_gmet_us, npt_gmet_us_prepare, null_test, npt_gmet_us_check,
 		.supported = npt_gmet_supported),
+	NPT_V1_TEST(npt_gmet_rw, npt_gmet_rw_prepare, npt_gmet_rw_test, npt_gmet_rw_check,
+		.supported = npt_gmet_supported),
+	NPT_V1_TEST(npt_gmet_ring3, npt_gmet_ring3_prepare, npt_gmet_ring3_test,
+		npt_gmet_ring3_check, .supported = npt_gmet_supported),
+	NPT_V1_TEST(npt_gmet_large, npt_gmet_large_prepare, null_test, npt_gmet_large_check,
+		.supported = npt_gmet_supported),
 	NPT_V1_TEST(npt_rw, npt_rw_prepare, npt_rw_test, npt_rw_check),
 	NPT_V1_TEST(npt_rw_pfwalk, npt_rw_pfwalk_prepare, null_test, npt_rw_pfwalk_check),
 	NPT_V1_TEST(npt_l1mmio, npt_l1mmio_prepare, npt_l1mmio_test, npt_l1mmio_check),
 	NPT_V1_TEST(npt_rw_l1mmio, npt_rw_l1mmio_prepare, npt_rw_l1mmio_test, npt_rw_l1mmio_check),
+	NPT_V2_TEST(gmet_transition_v2),
+	NPT_V2_TEST(gmet_matrix_v2),
 	NPT_V2_TEST(svm_npt_rsvd_bits_test),
 	{ NULL, NULL, NULL, NULL, NULL, NULL, NULL }
 };
-- 
2.43.0

