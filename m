Received: from CH4PR04CU002.outbound.protection.outlook.com (mail-northcentralusazon11013042.outbound.protection.outlook.com [40.107.201.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D284E443E2B
	for <kvm@vger.kernel.org>; Wed, 15 Jul 2026 18:11:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.201.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784139101; cv=fail; b=aQsFSFbCKqpfj41vw823WHFxEpu1n1Rw8gARaRjwNNXdtRbJjIkkB4igNFrW45FS7ptEK6fmYf9rg7XcoFCgNLb3QTitvbVDGdZai6rgFnqmZO7cRL0Is8yyt0ZF/gawzDV/TGbBAOf5Ye8PJjXaUbYDvTx5qSvxSrhtDQBrnf8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784139101; c=relaxed/simple;
	bh=9sQrJ1b+i/zIdglPirfDZ3u+XcNoPMF/I40xsJRzeEw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=XQHLXFd80B2NCzRvcv7gaxl5Xnt9OHmY0Pg8p3qPmXYitjcWqHB0ixrNDFn1PwQvGjNMw47fbMdP9o37cbEawLidVrFK4g3d9bBdLwi7tBoDE/GyuiGuzCXU1QomxEgNOQ8fKbSH/TUGrhKYu3MHPRO4b4Zbs7KJ4i/GqlnJvH0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=AuTjOiqh; arc=fail smtp.client-ip=40.107.201.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="AuTjOiqh"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gKHA+wCk1TpTClbPa8IfwJwetQ8mqrnzAIlS9ctZexVzfHaq0C+k6AQsYOVshZKj3+G2wupFZpH14VIe1xEBngScXI161chnNqKc9soMsNmPa1/JbPTvjzmuiBEIkcE6EqaD3Dqcs7/PHBlZLQEHOmiwzeXnrCeJvPI2sM/rSMeK5sMmxjFqnPDKGsJQwD7d+xLEa/T3CT4CLcAiDwdSGF6wsF+Urkiee9C7KLwvI5k7CDHTynYorRc2MwbygxQNqMjhKoxyBKwgsBB6jWcEHkKtj6JCa4QcVh8UKopty+gkj4kt3yK/IKf6HthhFPEe3SmADH+ZbpFUk3t+pEhFtg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FDb9kbz6v/WHl+8TI5M5F5vgnszXUwtevJfkTNBxx8U=;
 b=bfLczLTxZQiLontzIhHM7qjuWXjan51z5daKFU43eBwwKZN8DGl7Zojop+jt9yUdZ/+gDjin65xKs3KHrQtgUpzA/rrkZqfwSEk0jeC6PG3BAxj3tr9CD3xv1YpMGGLKvxWfMErMW1X5CcYTOsV+BkrY7yQPExQeQGsV0/noNTtV3FaDMpHknMde5wcCpTdnzMz66/tw29YEej88frSAs16KrJ5WgafiC2GYR7OhVujCg1kuk9yEI56jqXcBZ5DokdCrFEZiSmCDveorjFEwTxU17xtrlKPqfgdnGlIwi5RXZn53g4BS2s3dB1GYQ1BhTXtca1vFoFzfHwYTRlRxnA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FDb9kbz6v/WHl+8TI5M5F5vgnszXUwtevJfkTNBxx8U=;
 b=AuTjOiqhgEFCqr7yFDbrpg+xSg1aKvK7Grme2uVaFWCNtHA1zRw2u8j43hkKmBMSRhrteWHheepQj6IH9ja/Z8xPhbvjChdw6OiTkc36bp6Yi2F1LznNdC3t5t+e2kew9IiGX+tYG5C6rQyylNGsC1BfUgVL1PHypqca8Q/KEzvthaLEWRXlgsp1jMPBbf+Xln5q74qsLKUHAA5gs5YRXTdvpirZPaKNcLpVT772GVZHMo+NcTtPa6YGic0Irbde5Eq63yxGd12GsRQTpjLBGZdfXTmW/ZbTF9i4lwEE6qhkQ3vjrLGFenhXnS22XDq3b0SxwgFrwj2xaWgthEccOQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by CH3PR12MB9099.namprd12.prod.outlook.com (2603:10b6:610:1a5::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.12; Wed, 15 Jul
 2026 18:11:36 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528%4]) with mapi id 15.21.0202.014; Wed, 15 Jul 2026
 18:11:36 +0000
Date: Wed, 15 Jul 2026 15:11:33 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Aaron Lewis <aaronlewis@google.com>
Cc: kvm@vger.kernel.org, alex@shazbot.org, dmatlack@google.com
Subject: Re: [PATCH 0/2] vfio/iommufd: Prevent scheduler warnings when
 unmapping large regions
Message-ID: <20260715181133.GE3775915@nvidia.com>
References: <20260714210303.3967981-1-aaronlewis@google.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260714210303.3967981-1-aaronlewis@google.com>
X-ClientProxiedBy: YT3PR01CA0007.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:86::19) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|CH3PR12MB9099:EE_
X-MS-Office365-Filtering-Correlation-Id: 9ca7d5e8-f743-4c95-8a64-08dee29c8194
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|23010399003|22082099003|18002099003|10067099003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info:
	JdPQAjKVtSMsLTjkEwJKalMa34AhPdm4ZyLaaovTnd96cZUnggv+Dh2h7PdR+84TsBUq/L2bwWkXIenHPt3uvTsZlAE5Q91T5o5XmeFSgrPnPpHUCEL5Ot30tJrS39uSbQtgx/xK8WdVMQI7n1aaKaVr/AcJ4Ym5IOGC0q6+yuYHgoucdF6NF5BCTQDh+nDa8L+66F8n5PgV9fOfk8VAY0aav7x77O7GU3WjRQlypz4doW65pj96H+wq2y4tzN8BElOSDPdG74pOloDGrT/kpKziGXIvfFkNZtzg6vzKw8aNvXiaEv6FuJq06K1qLomN+QdzywLCnAhgEz1lOiQaadxYKfgAmwYdSCEweup83/o4TSqjMAOuA4gnydmyef9uM7yi7p7x2okCmQNvCT1VTFNH6Mfm/GeqXXiS+fA7//g7XY+0CjpZPltZCKaXs3zdceI1jSR92ghvNmzJh1xnWxkwEly2dMYRYFyvLTJwGm6XfOBw5ROdK3FIbg4Sp3SVw7/KYbg8qZjHt1b76a8q8tVMjSnSIt/nhuOBu/kIqzRJMjwHTaOjZxVg+S0zI5bKeARW93UY8l9WBK75GgHt3nwh8GUBgfvOGcgyfmu0/9cxMMbPyoFVwK6LSMuVhpnwZMPGVvv167wynULHks7GF02OaDK/dx19vW/4GLNU+Ss=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(23010399003)(22082099003)(18002099003)(10067099003)(56012099006)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?lR3NKY/iwN7rbTMn23Ax6uNuG2ixgF+ssNIkJcPS/hxXW3aTuLQ5LMj5Uas0?=
 =?us-ascii?Q?Dzis766/nmA6vDp3luTmPgshUSsumFw3uhRHJsI78j6w5XLi3HV/YNjOqdWm?=
 =?us-ascii?Q?Mi6NmTrNCn253fVD7ajqz+IhpnBI4/j7l5KS2gjgX3MAJF4fAXE6GBlfhKBp?=
 =?us-ascii?Q?woM61eHu1wbyCFbdixi7N+l+EQhmE/3ncVwFKM4kYQIihDMOXHK8E7GAbajU?=
 =?us-ascii?Q?SccDi8djjUJ/52aBdy3X2qpglvhJ65zEgKjVWJ4oT8w51haazZL7RJwLnY3K?=
 =?us-ascii?Q?MuGMzDZUj9snQBdmy9DYMuaSI9NNtnRcZ09KpdJ7HCPte9XwzIAW/IR04v0L?=
 =?us-ascii?Q?Og2URuVaNgotRQ066lHujwmMBDrxFDsHLFVPsYx4jGr0EGams7IFyaUbp5AW?=
 =?us-ascii?Q?jpsfq37M3rdOAiuQhnXZcnAYHQIFIt6luxYdWv8i956wkGa/JDq1mNFlwf4a?=
 =?us-ascii?Q?xB2qWzso7PjBbChOJvG3/ZjHZsECztbecAiDWIWXsdtayB6SSaLN32leblQI?=
 =?us-ascii?Q?/UUV595rJjZdDfgz9SzuNvxhHrJoWr/ZmOP/fY1oNv6vl2xs2KUhI6nkcLlY?=
 =?us-ascii?Q?ZoxrtZgDw2KCiwBpB92ll7kvDb13KW3CuKOXtOn+G2ZQsrYJUwK7Ka8Ncs0G?=
 =?us-ascii?Q?Ec3hfA9s13QXMIm8GnaaaMX6S037WFyF5/qLBgo+1zCcwl1kiY0WzH/Rzqo1?=
 =?us-ascii?Q?ojOL0Kv4XZgN0eUHPZ6qq8CBAKn6ciLXdD/vaoKMiHHGe1cdkdqBH0cPhm8h?=
 =?us-ascii?Q?p9Y29/Djd/NgEkMZD29hbKT6Hf/Fe+cigWvC9Mv+UD4+Byeoinmy717JddZk?=
 =?us-ascii?Q?j0TSuBxtEnx8KtQd3b36gfkdK/kuYCw7YcmSmdlnLHnkSmZRetpGba3s4BBx?=
 =?us-ascii?Q?jnRsJnZz8iEPgKtXWosdQrTcVwwXXPfpwhn1uE+iiz4KQxH1aLSakluyhsNi?=
 =?us-ascii?Q?wb2YgDTV+YjyuK3JxP51zGZP88leXyHt/DioROQIKGGXXlszCvVEDBjw8ToJ?=
 =?us-ascii?Q?alJsPXXIbz7cgxDr9wIpAYD0o0DfuezwqY4oNV3MtGlHnOUoPQtjMy6oIqrI?=
 =?us-ascii?Q?eKAkLEiBwTJaBY+TgrCXNSLZ/YLNfE1TCcPRm9VM6my1RYxMUlgFl84ItSuN?=
 =?us-ascii?Q?TNpsrgB2noZ8cd1myYmjL1fbNH6p1ueOt4DOg79Sq4u2ig5P3Hm/Tw5nrYyc?=
 =?us-ascii?Q?sNqFalNzA31898Wjl0lMFKQP7GpLQ4c484JxfPaMHXRrLdcOR5f7Pd+n20kV?=
 =?us-ascii?Q?mclEtOknjmlKavCtobAzFkqEbaAhEby0JGmUvNLFQvyTNkgW43I9qfpc3oi/?=
 =?us-ascii?Q?gk2CzqJVm4S5000C5oVi80i54wYgPddMZOKTLHwhlamIFui/A5E7y32PMY4l?=
 =?us-ascii?Q?SXsZ388zZrDSRDR/ueabEvMgM/a6jYfXsyb3a+q2Ah76Ty2lmI7k7bg2Q5dz?=
 =?us-ascii?Q?3yarU/mhir8LEaayRmjmA0vaI33A/nQdJTGHF4OV0rafGUfulc2STNfBN/ba?=
 =?us-ascii?Q?hsKVp6kNcH7/bsSnzKVhGLqvCoKGBYicyF62vybqqHZOpGfoc8cGT9wlWN85?=
 =?us-ascii?Q?AXpn8O26S8ZpgfadF2mQQc/Ytdpe8kPxzwKUiKGjISiRGC+7ixwBpFqB8U9d?=
 =?us-ascii?Q?jM8TxEu51aT7LAY9bd+sK50j1mhVZmBgeT8mMQ8AI9KUlmjLuQYLza0QMtZa?=
 =?us-ascii?Q?NioQtCP8M2Bgw/jVUIMOP3dVsQZJplGx8AHRipeIxcVJ8q9E?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9ca7d5e8-f743-4c95-8a64-08dee29c8194
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jul 2026 18:11:35.2087
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ytHFRNCsE6cgP+8/CFQJiwqbUOoesk412GusPXYh4HQ5Sv62b3ixueghNOjbejtV
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9099

On Tue, Jul 14, 2026 at 09:03:01PM +0000, Aaron Lewis wrote:
> Both the Type1 IOMMU and IOMMUFD can be guilty of not playing nice with
> the scheduler during DMA unmapping on large regions (e.g., 256GB). Add
> rate-limited calls to cond_resched() to ensure this doesn't happen.
> 
> This series was tested using the selftest proposed here:
>  - https://lore.kernel.org/kvm/20260701203311.326798-1-aaronlewis@google.com/
> 
> And profiled using the bpftrace tooling proposed here:
>  - https://lore.kernel.org/kvm/20260630141152.3757722-2-aaronlewis@google.com/

Given this is the same issue on both in the some place, I wonder if it
is better to try to get this series done:

https://lore.kernel.org/linux-iommu/20260603151804.1963871-1-guanghuifeng@linux.alibaba.com/

And put the cond sched inside the iova_to_phys_length() ?

It would be fine to do things in steps, like add the
iova_to_phys_length() that just does the loops iommufd and vfio have
today with the additional cond sched inside which isn't such a big
task.

Jason
