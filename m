Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2D1336923F;
	Fri, 20 Mar 2026 08:01:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773993695; cv=fail; b=FylYMB2JPtmNuqX7afQjMRrMF2ecaThMF8O4mhbk82J3KAcyZDKX8L+t46wo+mEFz7B/upJ+Ows1Y3oySACkEFBmcjA8gEaeeqNNLUwK6jPT8ntXoGhiR73+NDieG23RU2HMBj7vQQX2kiMQXwPEe+v9XowlyuYILOV0FjRCJjY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773993695; c=relaxed/simple;
	bh=NRe1izfTflOzvF9zQuYUngiViU6oSDnRdOCWvhMCs0o=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=A1LAYAvT2py1j6MwgRXGUsRy3/82f+jj72qxm8xKDl51yE8B9jo2NbChj14DwUvGT8QwwUocfRkHlq4ZVSwWAnb+H33Ii3gNk0yhE7xLbb51ShIevkwEDqDdVaAQN3EpiLWkdIgQMzdT/UGl7Ae1SfPWz9mfKNgL/NpTyKVraLE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mdFa1LqQ; arc=fail smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mdFa1LqQ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1773993692; x=1805529692;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=NRe1izfTflOzvF9zQuYUngiViU6oSDnRdOCWvhMCs0o=;
  b=mdFa1LqQYrTLMIMvVwV+4qU9mH+ukYduF0VOAzRj3NqoNIyX/NFcuIqy
   2qb0Z8dsiabYR/i0R+uC5Jude0wzyA2AwRjFkkcXeDNCKYpiW75U3J7QY
   Zyw3mUQUYMSsDOGG104Uzs2P6VjXH/t9YQHnGIGEGqLZKUvLLkvL7Z08I
   k801Oyc8CVa9eA1g0gSyrWf9lQwojbEznbAS4ktXLj+eQKuPxv5yrC4M5
   g/ZbRlKJCXMyexsWJWIT9X0SGRB7Q7G9JqeSB6t6lHG1ZX6iRbNZRLyQt
   g9xhauE6qkGCh6Hl4ZWBfnFgTlJ1k15I9trzH3pw+1Qu8nvUmYt+N8Zlj
   A==;
X-CSE-ConnectionGUID: qbwAKBB/RkayMGtjBrRxVg==
X-CSE-MsgGUID: 7suqltcBT4yenyF+9WeY+g==
X-IronPort-AV: E=McAfee;i="6800,10657,11734"; a="86153456"
X-IronPort-AV: E=Sophos;i="6.23,130,1770624000"; 
   d="scan'208";a="86153456"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Mar 2026 01:01:21 -0700
X-CSE-ConnectionGUID: yd+HR/RqQd2Y0jNLdgtfCA==
X-CSE-MsgGUID: K8khnyzcTlGumYYL4vtNDA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,130,1770624000"; 
   d="scan'208";a="227691009"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
  by orviesa004.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Mar 2026 01:01:19 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Fri, 20 Mar 2026 01:01:18 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Fri, 20 Mar 2026 01:01:18 -0700
Received: from PH8PR06CU001.outbound.protection.outlook.com (40.107.209.25) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Fri, 20 Mar 2026 01:01:16 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NhS3yR/DCin8aWz4k/f65dJw11B4C3TJd4P/wPjmvld10cretzfmlGiSizA9JfOsei1o/x1QJS3irBz/jq/71uCdqL8QdDWW6ZHOJ11fGDbtmJClS6hNAO54AbbTv8L9f2mwJ6AEpeSwOW/ap4cUCUPFF/z+hTCGsOxlIgQbSvTDcl1UO+RiKj2TkDeMgT5P8vRmJlPrUZf2EEMZPgRjVLIYEZm7KQjudGXlnjXgumXVjlHLbZghAdy4GGp8fvuJgbukBoHWrMJX5cU4y5RdHD3cV6YYSAQESE4X2VA5hMRrKu8M4xeobo6aXFuzXicfMBx1YTXK6Zkjp0eOjDppyg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Y2WNZeyv/700ZKoSfCz1GG8JxXivc7T1d20I3+w8Dr4=;
 b=nfA/7Y0i8ZuvkFrwxE3n0/S8rprmV7yZpWeVzVYdhFcenrSLR7QGb42C85RxqRoJJnW67z3GMUNzPG5Wp+0QtoXe/Y7dqSvecElCQjVsHLaGKKUx8aG/uVgAW/TRL9q5Xm8Ro/AiKvZ2rh1uMhqhtRDPrQO2ivGMu4lslxcU9FSppMWDdljLhfMtQW3A8IPSLRwlIyRF+EWp0KmSwZnBl/7CNELhRlZgouI+d0GbjgJdVizd7fJieOejRKRxSyHglpHV5MjqrJdd6x02n1QRrnDULz5o8U4RTorOiDDcabHUuq1UE+JlOKWhsWGsPeUWT3IuPZRpCGYKbi25tcb/2w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CH3PR11MB8660.namprd11.prod.outlook.com (2603:10b6:610:1ce::13)
 by SJ2PR11MB7475.namprd11.prod.outlook.com (2603:10b6:a03:4c9::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.17; Fri, 20 Mar
 2026 08:01:11 +0000
Received: from CH3PR11MB8660.namprd11.prod.outlook.com
 ([fe80::fdc2:40ba:101d:40bf]) by CH3PR11MB8660.namprd11.prod.outlook.com
 ([fe80::fdc2:40ba:101d:40bf%6]) with mapi id 15.20.9745.012; Fri, 20 Mar 2026
 08:01:10 +0000
Date: Fri, 20 Mar 2026 16:00:55 +0800
From: Chao Gao <chao.gao@intel.com>
To: Kiryl Shutsemau <kas@kernel.org>
CC: <linux-kernel@vger.kernel.org>, <linux-coco@lists.linux.dev>,
	<kvm@vger.kernel.org>, <binbin.wu@linux.intel.com>,
	<dan.j.williams@intel.com>, <dave.hansen@linux.intel.com>,
	<ira.weiny@intel.com>, <kai.huang@intel.com>, <nik.borisov@suse.com>,
	<paulmck@kernel.org>, <pbonzini@redhat.com>, <reinette.chatre@intel.com>,
	<rick.p.edgecombe@intel.com>, <sagis@google.com>, <seanjc@google.com>,
	<tony.lindgren@linux.intel.com>, <vannapurve@google.com>,
	<vishal.l.verma@intel.com>, <yilun.xu@linux.intel.com>, Thomas Gleixner
	<tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov
	<bp@alien8.de>, <x86@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [PATCH v5 17/22] x86/virt/tdx: Avoid updates during
 update-sensitive operations
Message-ID: <abz+t1E+/chc05Kj@intel.com>
References: <20260315135920.354657-1-chao.gao@intel.com>
 <20260315135920.354657-18-chao.gao@intel.com>
 <abwAmw_JfpWScKGO@thinkstation>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <abwAmw_JfpWScKGO@thinkstation>
X-ClientProxiedBy: KU0P306CA0049.MYSP306.PROD.OUTLOOK.COM
 (2603:1096:d10:28::9) To CH3PR11MB8660.namprd11.prod.outlook.com
 (2603:10b6:610:1ce::13)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR11MB8660:EE_|SJ2PR11MB7475:EE_
X-MS-Office365-Filtering-Correlation-Id: 7acd3ef8-7650-44b9-3c6f-08de8656d91a
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|7416014|376014|1800799024|22082099003|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info: 42iW5B6SapEeFdd0QkS9jknKyfx/ObWun7ljsApDUECFnZ5yPwSjoSnKi9hmXjKkR3Bndj9bKigf1Lnw+Z1P4fHjSDlfctHU3p8ju2BjQ9rOagi9vuO9WTaEvje84QDEeXqDdIxn6v+6faIEH9gvquwxjyOWYC1Z92fdNUUWty+iIpiTppHRyDP2b1KuOM0Baxs9zU1v2VQej9vuD7xKuaIxuIP+gpgZ47AxR+hDOR7fRVAkW3jLb19wS3j03WsrHtP5d1ZZctw1sidYNdOx45GG0TRAqG5BPbepirenzYtgsvE+RLzVQzVbCNKR79vxp/up0acEyORYnYLXTfig1ssB9U7DIzd+lOABnlguhsAHWuhYRg6DSew/HkF0vxi6u/t0l0FwCDVtkxDa7wUHr1GGW0xte2T28RIZsTy3ugeKB8qlGv5vbRnHu/ifSUUeD8aqYCHU+GIr5uYvkdshWaf9WbtxXUwXJEVcZttiw1kzT6InygcK+VGkjDV8z3tqOXfYm+ZomOLRh4MEyKY6PgGD8aZNcVht7iSjHivehW8AEDRrx+CnMP8cmfdkyztoUNDQbXMD3qDRph/WmIT9mX+FsCF2EHKQDcYJcSw4wzihHSvtHYV33O0j1VpsIvwRfHgSWgQgLQ6o359TNRCSMamPP+6M7NS7JDJoMKQMVBZ3CgPQCREyeiRhESzWFTcddnhVFJOV0avmv4tiy0D21A==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR11MB8660.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024)(22082099003)(56012099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?h7tnlvFy4ENqdGr5u1qRnaENH8au67OmS3CNFwgN5O9ZQfoiZk1R/NKLpays?=
 =?us-ascii?Q?lG1EfiiC14BfuJ23n4o/BwoQoXN4N/CYyy4zPQfIBB2l5PBlc4XHtDQEfl2w?=
 =?us-ascii?Q?f5VmDVBcCrHK4xISmy2aVZtoKg+WpRr259ZxgQLTof7Gq/dhfQTqMH/fM3sI?=
 =?us-ascii?Q?6PQZ5EPfF9Y7PXubqp4BDaVKbu13w79Hpisl+U4EQvUjlccNXTCAmXy3h+fo?=
 =?us-ascii?Q?P8TfpGm+27Qf4g4LD5uvoTVtzP9Y4Q80myzDjPCTrBmwrcLDd5T+IhAga6HE?=
 =?us-ascii?Q?K7E7elRrrPXt+iaQ/yJUn+PrBXmSbhXEPWvxxX0fSEHqyfsCkpshfbuA90Fx?=
 =?us-ascii?Q?8kBfoh2nLpGjlh6I+r53TA+cgnAKTgagKawhA6boOJkfMH5vgyglvBymug/n?=
 =?us-ascii?Q?ekqXjlP9x/J4ZM0PzHKAm19kwwvhylbyS3Rp7K9O332D1Hq/EBBg0xX+DMFp?=
 =?us-ascii?Q?wbEMmydcF7WnCttU//6n39LEcj52A7csAdsxrT6FOUI8dvwY0dweEn5eS13a?=
 =?us-ascii?Q?VFL59gXI1KU8+5Gd5VfFhoA4DP3YYFqORqaylOT7ldHI0n8H/i4g10Dwf+P3?=
 =?us-ascii?Q?sSquoMGYi9JqxQmSqj1+5spXYBYSI4+GjR0cGMOnipnzMNQAgVZM3VB9gTau?=
 =?us-ascii?Q?qX4VmJAkOIPRkML2i0W633+EgEAvvAezab0rkmTGcXH3foHRRweSZHghDXDd?=
 =?us-ascii?Q?kXGVBlnUqFv+puKoVzog5GNBWGq5cA8qjyoaG/JQ+8YVWp8nRiWPAcWjNL6g?=
 =?us-ascii?Q?md2SSN/xgld/sUc7PWJhMQPdrCmww3lUNaRJ7deOp2ap5gJr/Oq6d/qNHRZL?=
 =?us-ascii?Q?0ytN0lfQ/IYK98iAyDhJ2sgZL4EK27XOJ679iArVauaXzLJGSHLphcSPULyA?=
 =?us-ascii?Q?BQIJY/1YaVn+2TeXE1wDFo9CjtGBXWOOKOz9QUoiISFHZbfpXBQ27p+pRgT6?=
 =?us-ascii?Q?APR6rdAsL2uHJQtQd8GmPvwRMcXHB9iffGZJ+3scViJ/s3CeMUQUP4woFMm8?=
 =?us-ascii?Q?ewA7KbCE0p+VfBTXmLjm9HwckxJckmz/S0Hg1hzv9ASg9XHk5eLCoa0UL1W0?=
 =?us-ascii?Q?RDK3t6JtnjU6t4MgTlQSPJ/H4h4pvg9p75seA4BQ5exeNxLhKmSN5h5tEENd?=
 =?us-ascii?Q?5HOSftD3NfBd81JW0KFd+9HmLj9kQFtauB5Y5PO618isRRFxNi8WXH4FgGQb?=
 =?us-ascii?Q?6EdhA+ZsGQnlYLZDujGfOnVdsQHO+tX2BA2uW/J1LJHbbK+6nK8ZZxi+EQp6?=
 =?us-ascii?Q?Dq5tw7A0HcBhjQoNIwr9/fAHtPflYLjSZEmNrT2x6XtpcXmWtTSG+huzqiE2?=
 =?us-ascii?Q?hcPfwZHu6kQMlv+OA2dJhkc18j0ikF/OVdkbZlA5vKO/145qtpINbhS9w4Tu?=
 =?us-ascii?Q?mZ0x2cGSLv5nh6hC4ANq8cWeFe9k+ICe4dry35580behV2VPUmzeVbSVsfiU?=
 =?us-ascii?Q?qAO20iyNCx636cNyQStYFXuxbsnrCYbhwfXMAKUNWVQZWVjShpH53zNNcrqt?=
 =?us-ascii?Q?n+nGUYaWFf/couf2RKKRcAf+Iykh3jpAnuUTu7aR7AHGUMZUe0Dsp50hNNhh?=
 =?us-ascii?Q?j3HmzCpUVyC9gVShFi5ZTSYZwwdu8Pa/LDYiHS+NIn3xuik0UhMg6UgUzj6o?=
 =?us-ascii?Q?jBibClMELzWtMuESI5SGk///ptxQB6H4hSgeLZtj3zA4wjN6/pJ1ie628La4?=
 =?us-ascii?Q?Yq+rXcQezrl27srStsFXqnoqYt38fvrbhAk29fxWj9+hA+Vrg1pxG2VMw4kQ?=
 =?us-ascii?Q?Zw1vllQ3Zw=3D=3D?=
X-Exchange-RoutingPolicyChecked: FRnkSiK4h1qK+ivTw6hQeH5wp9Y3GCi2dwJpbAc79T/LgD0jcey6H/6Tt+ubrDsCH0kiXP5oUEH0W6/e1+efsatBSQTwau9o+Pp2/CXGYz7wUvO+xVJ0HilwzbNvis3A1uYn8Jn7BkdcxwEfRV55MZsdzKe/uyVPTgQYFDBKgl0D0xXpYZuXmKXj+oRDf25gfxvv9YsC+gC15SCVmyFPUK4lfovyEUENcQPD9K93MpCFhY/yRqbBdluZI14diJxV/GWfrEBqOBnKfzg5NzJ4IolUiDcCiNx42KzTmNP5yc54HJ+CHKvdB4gFy0CQicvt2GPDcswvKiaGD5Ync35NDA==
X-MS-Exchange-CrossTenant-Network-Message-Id: 7acd3ef8-7650-44b9-3c6f-08de8656d91a
X-MS-Exchange-CrossTenant-AuthSource: CH3PR11MB8660.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Mar 2026 08:01:10.4786
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Piu1LOYpAdlhoN7dY9baeCzNV27Xyc9UdFDCICSC+rXopsUlRDTJqle4XVHeDzwwn2jqlXnSxGTtFQXLEeuIvQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR11MB7475
X-OriginatorOrg: intel.com

On Thu, Mar 19, 2026 at 02:00:00PM +0000, Kiryl Shutsemau wrote:
>On Sun, Mar 15, 2026 at 06:58:37AM -0700, Chao Gao wrote:
>> diff --git a/arch/x86/include/asm/tdx.h b/arch/x86/include/asm/tdx.h
>> index b3a7301e77c6..4c4f7acd4044 100644
>> --- a/arch/x86/include/asm/tdx.h
>> +++ b/arch/x86/include/asm/tdx.h
>> @@ -26,11 +26,18 @@
>>  #define TDX_SEAMCALL_GP			(TDX_SW_ERROR | X86_TRAP_GP)
>>  #define TDX_SEAMCALL_UD			(TDX_SW_ERROR | X86_TRAP_UD)
>>  
>> +#define TDX_SEAMCALL_STATUS_MASK		0xFFFFFFFF00000000ULL
>> +
>>  /*
>>   * TDX module SEAMCALL leaf function error codes
>>   */
>> -#define TDX_SUCCESS		0ULL
>> -#define TDX_RND_NO_ENTROPY	0x8000020300000000ULL
>> +#define TDX_SUCCESS			0ULL
>> +#define TDX_RND_NO_ENTROPY		0x8000020300000000ULL
>> +#define TDX_UPDATE_COMPAT_SENSITIVE	0x8000051200000000ULL
>
>This competes with other patchset[1].
>
>[1] https://lore.kernel.org/all/20260307010358.819645-1-rick.p.edgecombe@intel.com

Got it. But I suppose the conflicts can be addressed when maintainers merge
the two series.

Dave asked me to remove all (false) dependencies to make this series move
reviewable since v3. So I think we don't need to rebase onto that patchset.

>
>> @@ -1189,9 +1192,21 @@ int tdx_module_shutdown(void)
>>  	 * modules as new modules likely have higher handoff version.
>>  	 */
>>  	args.rcx = tdx_sysinfo.handoff.module_hv;
>> -	ret = seamcall_prerr(TDH_SYS_SHUTDOWN, &args);
>> -	if (ret)
>> -		return ret;
>> +
>> +	if (tdx_supports_update_compatibility(&tdx_sysinfo))
>> +		args.rcx |= TDX_SYS_SHUTDOWN_AVOID_COMPAT_SENSITIVE;
>
>Hm. So what happens if the module doesn't support it? We just ignore
>problem?

Yes. The kernel ignores the problem and leaves the decision (whether to
update modules) to userspace.

>
>Maybe we should just block updates on such modules?

Kai made the same suggestion, but Dan rejected it [1][2]. Dan's position is
to avoid kernel complexity and let userspace handle the check, updating at
their own risk.

I've prepared a patch for the userspace tool [3] to check if the feature is
supported and will push it.

[1]: https://lore.kernel.org/kvm/699fe97dc212f_2f4a100b@dwillia2-mobl4.notmuch/
[2]: https://lore.kernel.org/kvm/69a0c3d24310_1cc5100d1@dwillia2-mobl4.notmuch/
[3]: https://github.com/intel/confidential-computing.tdx.tdx-module.binaries/blob/main/version_select_and_load.py
