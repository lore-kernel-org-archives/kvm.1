Received: from MW6PR02CU001.outbound.protection.outlook.com (mail-westus2azon11012007.outbound.protection.outlook.com [52.101.48.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B5B943F0B4
	for <kvm@vger.kernel.org>; Thu, 16 Jul 2026 13:20:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.48.7
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784208025; cv=fail; b=jvy7wgC0glv7ryEJ7tiYg+IodEIouMS4MiVoZeENQQH9i9v2KKi9OI8oCw9q6pd5Dfx7Ecfj2lNUQssZNanWPeRYv53+i8Cz5+9QHZPysjdqEtGqLc+csIbTMS7ufjz+8QWtrFmCuGYtreNzPFIBh+XT7w20S3gkcNWyWb2Toho=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784208025; c=relaxed/simple;
	bh=tztH3XIAYMCEl3zPVefcr0mX41eatP9Q3AR/XVLizkA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=qm1m9lt5Tau6twqHX0Xzn/xOO/seNog5TGnn9iCz2O+yxpUtfDp08rLTSvWj2p/dUG7cj9dheqDs8WzW66VHH1yLYrJUKnAegfFULNwi7zrS0+Zzr+wvpTNcxqH15BhrX7xqimay1KMFUuJX38nqFbeuOfTedzdk5Bs//KHFrQU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=M1fpFEb7; arc=fail smtp.client-ip=52.101.48.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="M1fpFEb7"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=O1rtmkhaEjGwOlTxt1bgGIh8gZhtMfJhTaORWkBlyqWflJUV+h0rK6AQ/sSdsJ4W3Dm+swpVkowzh6fvEvM0bwRixqt1ImgfPqz9qXqUGC17hc1TgNg4dfxMDfuXpjsjytr0CTDYkxvwSTFbf551Pxin+UtRSxVQTazeijzuwV10ay4pxmA5/UOZJq+dUMSS7phC00tcbuOv9p41QEjWPCN7pIOQVxyqKQv1lLz7O/hNRFlUI1Zo6hFeWfx5jTAKsiTMFSOZAPHXLA6RQTR+/usDT6L5MY+T+2Nvm6lfd5Dp07U06EyeYqdqbnxg3tA+pSbDaTZPhGC1Yy8n728mMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=V6QmMsP8sv5HcBVpeymr/cdtpPEq6EbYHva42aKNnDI=;
 b=EVhwZSCOc7uk9pBk95s/CM2/fikd+aBDocMpsyTAYX2Gqj9xf10AzSsXleIk1/4shzlC0b8AE39hRQMtXDUhOc9Pihk81QFhSj29IdibYmlwaRDWTZjZjwmKtSlzrkZV5eT5XiLPqoB57sNWq/K4JPnr/X2+u87+h9ynmP+J1Y4Xirk/IW3c7/b277zgbx1OWcte+r2WVWCl7rX2g+YxtXYnJz6+NlKRS3AU7HVLABJg2BcDwqet9tN27YRwXQ/8t7a+HkzC7fBFVXKD4KcJQNl8AyolvpFPsP6ZQA9vBDOWlSI6SMZ1aJ7gFbKSSIydM1fBQIlTJ0KS4wrToFPP4Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=V6QmMsP8sv5HcBVpeymr/cdtpPEq6EbYHva42aKNnDI=;
 b=M1fpFEb7Lsbn+hTbuaxqDsfYKJZ6FDcGl5ZYZ8/0LrFbx8o4fh7xpTb0uv5mYda3r4cIHyk8YpLKpptu+fQEvdhVMH5gDkLV/mNrrsUcQBhBHxz1Ea/URFmYfdwwqkBpl0tLgpzHuesdsfvcWJWJ6jA2gh4fsIExTwv995vBsx62l8PhIu+C/BGk5s7OdNqoE7sS7laut08CFAV59Jzm3UYUEMeb16xr4Qs0sfaGyNTxvJ0ZxZhJtMmmnf2jXXHBq8NUcHzYLvp5aCzLEJX3ij+nCbWpsfcUvlSfeZ3q67o/3mG74c4mb4SfCnWxk9TwMgGmoSpUC5cmzxwlBOtpzg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by CH8PR12MB999206.namprd12.prod.outlook.com (2603:10b6:610:35a::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.12; Thu, 16 Jul
 2026 13:20:21 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528%4]) with mapi id 15.21.0202.014; Thu, 16 Jul 2026
 13:20:20 +0000
Date: Thu, 16 Jul 2026 10:20:19 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Aaron Lewis <aaronlewis@google.com>
Cc: kvm@vger.kernel.org, alex@shazbot.org, dmatlack@google.com
Subject: Re: [PATCH 0/2] vfio/iommufd: Prevent scheduler warnings when
 unmapping large regions
Message-ID: <20260716132019.GM3775915@nvidia.com>
References: <20260714210303.3967981-1-aaronlewis@google.com>
 <20260715181133.GE3775915@nvidia.com>
 <CAAAPnDHkJabsf7haMLX7bp30qxcbXc_81y8mw5t-3bNWdm4LmQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAAAPnDHkJabsf7haMLX7bp30qxcbXc_81y8mw5t-3bNWdm4LmQ@mail.gmail.com>
X-ClientProxiedBy: YT4PR01CA0365.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:fd::16) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|CH8PR12MB999206:EE_
X-MS-Office365-Filtering-Correlation-Id: db9b0e4d-14b7-422d-3b68-08dee33cfc7b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|366016|376014|1800799024|11063799006|56012099006|22082099003|4143699003|18002099003|10067099003;
X-Microsoft-Antispam-Message-Info:
	InoFcdJZMicBPHJrSCTaPKxIYnQ52u94fPKxSGiIGvLJKuScFpEnByOCTQdklEoHsVo94tmYjABSq/6PFXeEcFLtOP5uonohZmvKY2sGndTXCqhj8XkuaE8u3TmgP4PbyQyIm937U+Im1SQm5Pcx5RSGgLjGVOyuNIl/6QBFK0G81iQErarA83bYV5eKzEK+fJSuIKlNop442JgpuLOhVNYJzRuOkqyWpjnYCtH/F02jqYQWhImNTFBr/xsRxoFG9jxJt/9wYFV8fl2t4jMu3Vy9B2EHpcRAk9YJ/y9eO6BmXUTMdyVNG4L9gy7iQGkx8lnRj7XvwyBRqMWO+DO+YXHuEbnvRnkolmHTm0n22mZVwDaXZGH3BNpQ/Wh2Hw8UbghDqKbXXzbsY/RkE/JZwokXBp9fMTNfeH5obVjQB9cFIKPp9G/gwyC/0SBJA5zubME4HQ5AVE65Nedmiks4U2KxauctI9GPqqxTFUU6X7ZEZ1DiiyTYjmnj6TKqbVQQRe7kugwX/y9p8eXQOdl5wTsEAv1mdahWZSL0PX5daQxKgmWURWnfVUmdvap1PqSzsUwcTN3yoCSmnRCTfSqqwWi/pAXRRIPglbzBjCbkj8bQRnTjyvSjxsvOBXmn3l6P1VhAmb7fam+Gn0OHZi6yySqiK2t1amzySAQW2Um71kM=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(366016)(376014)(1800799024)(11063799006)(56012099006)(22082099003)(4143699003)(18002099003)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?MVdVZHUzUG1LYS8rb2FMbzNxTmZUN3gyWTJsdjZRUnZ5OWcwUXl3bEJFUXdS?=
 =?utf-8?B?L2FBQnRudDg2UHdnWWdIVW1kNW93Qnd3eWtHTi9MbjZURHhxazFBbys4K29P?=
 =?utf-8?B?c1BLRWh5ODBnZ1B4bDJHblVhdnVaV2UvalR5SmpXVkkzK1Z0TFZwWGErUHBF?=
 =?utf-8?B?QUxhSDFTdFB0Uk50U015aVZnTXhXcG9HVGNJWVRhb0dkRDhoQzJhNUMwT0xa?=
 =?utf-8?B?TGRpWktpSXR5aUJYKytoTkJWdmY3N1FtR0JPaW8rMWpBZlF4QWg5MzhqTW9S?=
 =?utf-8?B?eGZaV2hUUXA2c2NjZTVkQ0lEMmVuTUtqckYzZlY1N1FRM3M5N1BvU3g5YW1C?=
 =?utf-8?B?QXQzUWVxT09ZTUVGaEsxK3NUb0RlNmEzSU9tUHBycXB0elk1MHNEbjdtSG5G?=
 =?utf-8?B?bXdJcXBua3BxWXVFQ0ZrOGg0bk5QYnVtZUtzWFZXU1VNV1dJRjNZK3VpRGZI?=
 =?utf-8?B?bHlwcWJFQjZpMjJRTVd4akhSVGp4a2FGeHB3OUMxNGEvTHBPQzBPUnhUbGFt?=
 =?utf-8?B?SXNGYjU3Y1E2TWFBclNJc3A3RjErRkFPNWNCS0FHWWxKS042TmpvbmdvUncz?=
 =?utf-8?B?QlJQMVJ4MzlwQ05qQ0JmUUFYRTd0eHB6MlExZXhIeW52SlpneHdrREs1UUFD?=
 =?utf-8?B?OGRuOW5jVW9ZcU8wVkV2UnFWRHBPOVRxY3NIUmdtZFFFdlN6QUxCWlRjZnpB?=
 =?utf-8?B?M1RhL0hrVVJZTjNKU3ZpQ1k5YVpzOUFQYkJlV2M0WGpwZXBkeFRUQlppTDVO?=
 =?utf-8?B?eTA4UmQzV1ZyYXd2VUgvcjFDdTFnOFZSV05XT2owdGlDSWhENkg5L2RNcDZL?=
 =?utf-8?B?YUtHVFIwTTZBdEFiZG5acnMyQ0k2eE5xNTg4bWpNbFFiN0ozc1FEZVowTHJx?=
 =?utf-8?B?ZlpIcWQxOUxxVzNmL0dMekhxQnlHRWxYOGdJWG1yWmJCRGprRUd6d3c5V2VR?=
 =?utf-8?B?MnFyMFh4L3VlUlpsUWN6UkFXcld0bUM2R3pjUlIyUGNlZlR3OFZ6NjRvaEhs?=
 =?utf-8?B?L2ZVeDZZWm1yV0hSV0ZqWTZnZjJzS1Q3MlN0U3ovaDlNR1kvRWpVckJaU3NV?=
 =?utf-8?B?a0NQcFN4UHBzRVhmaWsvd2hlL2lVVnBUZXNESHhUZTJhT0d4M1QxZEYxa3M0?=
 =?utf-8?B?dTFhMUlNeEhoUlhWKzdLdXlJa0NuUWtMTmx6Q1NpYkhwTVA2SGUvSVdUdUJi?=
 =?utf-8?B?T3lrRGJmV1p0bitFTG00WGJkaDJ5d2lyekpqWndHbG5jVm9MSFJNaXhuT3lx?=
 =?utf-8?B?V3dzYkVueHJVUVgxdm9pb3puSVNRRmk5ZGRTK2tkNXg2YzhXYVNlTEtKWXlj?=
 =?utf-8?B?cHNaM1hyQk0xRTR3RWpzVkhDNWdYbDFYdmJPeTRSdkFmYnVpQnJkWkVwczhS?=
 =?utf-8?B?ZmhLemRZZWxrd1lPelV2TExYR3ZaVHB4RGtFQ204aWtRdDdEV3gzQTdGMGZT?=
 =?utf-8?B?bjBUaGRWamxISVorWDBXT1kxWG9pUHV3S2Q0R3hUOUxGNTlUWTExMjFqUzls?=
 =?utf-8?B?QW1EditPaDd5Q3NzZGJNdlhodXo1SVhzRUVCK1pQajRDNkJVWlkvS1UyZHhq?=
 =?utf-8?B?b0N4SlR0aG5JU0J4S3hEQ3lkN1ZLVFNyZDZmZUFpVCtDK3RKWDcvNnVWVm1v?=
 =?utf-8?B?K3JHR1F6MUVJTGx2UmxjZldOK09QZ1pyQUF1UFdXRms5VmlPRU9uR0ZLODZp?=
 =?utf-8?B?WEI4NjI2R251OGpjbGo1MUROL1ppSW02MGJZUmNHRThGZE1VdDVtbWJTbk1G?=
 =?utf-8?B?U3E3NU5jMUc4K1l6b1FYOHJKWXBHcWEyS2J5TEMyRDJ1Rmx5ZXhMZlh4OENU?=
 =?utf-8?B?ZmxERlVPZEt1anB4ZUpDR3BiODZUcG9tTDduakMybGMxNGgxby95M1RnLzJh?=
 =?utf-8?B?Q20zS2dsVXZ6Y3JkR2piOVRuMGkyTVNYYkVmNWpqM2FsaVNDSEdlSWRhdXNp?=
 =?utf-8?B?RUs1R2JwOWNtTXBCMzVWVktXdzhUVG11THp1cVh5b1d2c3gvWjJjSHV1cWVa?=
 =?utf-8?B?Rk13QWpoZy9kK2tMTFQrcFBYYTBIOW9OWFRTZHRJRCtLOWxXNVZyLzRleTBE?=
 =?utf-8?B?MnFoVjF2c3RETjN2MjhoRjVNQW9RMi8rSVNiSWpVMWl3TXY4TTNJN0pBSjFZ?=
 =?utf-8?B?TXRyNkRQQU9ldjBKd0RmdVVwTHV4aEUxNlQzUmFpVVNwQUpTVzRUdzgxUFlL?=
 =?utf-8?B?c1YyOE0yY2syOSs0S3cvSDhYZ0tNdmlIY040VU80NS81bzZ4dlZOcW9YNlBS?=
 =?utf-8?B?YUFNRUhZOUZHQ1VQMVlVYUQyV0sreVA5VGZRVVVKZFk3RHRDYWZIdnl4azFM?=
 =?utf-8?Q?zgDixoxj8p98a5S69O?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: db9b0e4d-14b7-422d-3b68-08dee33cfc7b
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jul 2026 13:20:20.8335
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ts60rLx2oXvFUhIf476TlTKzrGKDUEVnY1cbrSjA9tdgCUIdV0mg4IqeQ5YWZUkA
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH8PR12MB999206

On Wed, Jul 15, 2026 at 03:07:42PM -0700, Aaron Lewis wrote:
> On Wed, Jul 15, 2026 at 11:11 AM Jason Gunthorpe <jgg@nvidia.com> wrote:
> >
> > On Tue, Jul 14, 2026 at 09:03:01PM +0000, Aaron Lewis wrote:
> > > Both the Type1 IOMMU and IOMMUFD can be guilty of not playing nice with
> > > the scheduler during DMA unmapping on large regions (e.g., 256GB). Add
> > > rate-limited calls to cond_resched() to ensure this doesn't happen.
> > >
> > > This series was tested using the selftest proposed here:
> > >  - https://lore.kernel.org/kvm/20260701203311.326798-1-aaronlewis@google.com/
> > >
> > > And profiled using the bpftrace tooling proposed here:
> > >  - https://lore.kernel.org/kvm/20260630141152.3757722-2-aaronlewis@google.com/
> >
> > Given this is the same issue on both in the some place, I wonder if it
> > is better to try to get this series done:
> >
> > https://lore.kernel.org/linux-iommu/20260603151804.1963871-1-guanghuifeng@linux.alibaba.com/
> >
> > And put the cond sched inside the iova_to_phys_length() ?
> >
> > It would be fine to do things in steps, like add the
> > iova_to_phys_length() that just does the loops iommufd and vfio have
> > today with the additional cond sched inside which isn't such a big
> > task.
> >
> > Jason
> 
> Ah, I think that is really what I wanted, but I proposed a solution to
> get feedback quicker.  I'll wait for that series to be merged and
> reaccess if a cond_resched() is still needed.  I'll follow up here
> once I've had a chance to run these tests again with it included.

It seems kind of stalled, so IDK if you want to propose just a bit of
it that would be fine too

Jason
