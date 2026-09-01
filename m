Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 519F536729C
	for <kvm@vger.kernel.org>; Tue,  1 Sep 2026 16:08:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.7
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788278925; cv=fail; b=LuYJVQkIhcKI0APWFrPGto9OcnsLymqUv3lqa74QDVFNkhs/lKh7HXN0tVL5KdjF+X3PiWRTXkPfnR+J27VjM3hZrJ9Uo+TRD/ZjsTFNGxIdaMRBeYaJ44J1OOGo9HcxuQfTooeZte4Fy1FGtTkijH9YTm1+ag9RKjNxFRBhLGw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788278925; c=relaxed/simple;
	bh=dPH9io6EIifxCf+8z8n6tnkCmBw44x09JDnphT1IQ/E=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=dlNwuLQEND+Njhryjo8muRIFX80K8USP3cCsLKvMI0E3PYUBugzegsBk7Tq4yW6bTC7CBDf8zK8khY8j/4/3+65QWPDSSYw4OzXQCOEWTp/DcHoTe/qu0wH7JZ3esQAR0jiMmd9DH2C4NOy8+0urpWh7xBY7MU9QaVDe4B2Yav0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=oLCWydv+; arc=fail smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="oLCWydv+"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1788278922; x=1819814922;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=dPH9io6EIifxCf+8z8n6tnkCmBw44x09JDnphT1IQ/E=;
  b=oLCWydv+zPPLMqlmjsds4QHJTRm8jt5vympnYihr1h6kRw6g95fH6TSS
   xZJhP/R1JA9x1ONqbn4SOB6YhYuOkbFMvH3aW9gUVz1HztCChFH5pqEUw
   p+7wU+gMb1ZDyeoe5l+DIfpnZQIQeGUo/Z7EnRki6voDAzkE9gVcYMvZF
   ClRkDWFbhKQLezaQRoaJQn3lrOV8IIWlALP8x/lvTZjTWICgr7xgDq1Vw
   Qn0c2+VzbyvwNVijWWa1Z4Brh3zCsCxEs9tVsiB1gfvv6d2/9PBHsNEP9
   4sAgAUcnF/nI9VBXS7HMKkPJSjILgmfirxGZOFk0CyfXX06h/wWrs00D9
   w==;
X-CSE-ConnectionGUID: 8096B7XBRsWh6C1tY6RPvQ==
X-CSE-MsgGUID: CourJzw1QuinfyZvDitkag==
X-IronPort-AV: E=McAfee;i="6800,10657,11893"; a="114256035"
X-IronPort-AV: E=Sophos;i="6.25,256,1779174000"; 
   d="scan'208";a="114256035"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Sep 2026 09:08:41 -0700
X-CSE-ConnectionGUID: 3HE0SQnVTe+DttAhwL87xg==
X-CSE-MsgGUID: fPHYZpjqTh2Wn7zF9MPrYA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,256,1779174000"; 
   d="scan'208";a="293970393"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by fmviesa001.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Sep 2026 09:08:41 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Tue, 1 Sep 2026 09:08:40 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46 via Frontend Transport; Tue, 1 Sep 2026 09:08:40 -0700
Received: from DM1PR04CU001.outbound.protection.outlook.com (52.101.61.69) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Tue, 1 Sep 2026 09:08:38 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=R7d9VxqYEgl3jj4mAHf+v1X2kdWYvlbC9GngDLikxtX1v4whksARPUXX0S4ZhHsLv0jc0zfbtHR6MY2aZddUgSDArZ+dl+PBCT0P2hzMlbRHsi/i/d4agvRBFYD/PNIxstFXumJOFPV22RkEJ+l/zOpbgRK79mZx+iy+/6jF5avCi5WsK3IIkfZc2GI+lfAFx9jG7dqpS6vIgN+xl2dkDmh7Uhekg2ldKCFbwTPsj58/xVFwbgk5P43PNzjy9CxH09jFRo8NdaFzNuLKY1d4E3Bgi6fXMEjtoX73f7DdcfSq7Jwu/VY2XiBowYeRllKFaXGq9NxUh8BmdWWv7lACdQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+D2TRZRLWNfgIT/qQ3TD+ELpS8RvWbyOQGkFIJE9t7w=;
 b=N5y3pIBFbxzL8zqfwtqrQ7MUcAcEnzLjc9wC2g+SvsPIMcIyb5CnFp5fg+ex/zITV3V0XmALYKMVrFfiUne3dIjlJ3QmkcCxlcLCwpXYDwhWiNbGZ5cJLM3VmYzS+k6TrWYXD4UnaQdayM5TxMP5IPN9dpKeeZw829GcLBuw1jeFkxCPvOEC8M/JNTYsVGOOas9oKP8Fry7lWQbDJkkK/qyqCBkC+aAccZIdLaBqXqWEtE2HyPy2nWoYxZ55ONEN6H2WqfJ6hIdHvmpuFP3a6OeLn1RMCM0j4mTGDvXA3C1NMyl4doNgAAHQ7KSMEuI7IpZQrkeU2jtLkK6eQkfqkg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7997.namprd11.prod.outlook.com (2603:10b6:8:125::14)
 by MN2PR11MB4696.namprd11.prod.outlook.com (2603:10b6:208:26d::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Tue, 1 Sep
 2026 16:08:18 +0000
Received: from DS0PR11MB7997.namprd11.prod.outlook.com
 ([fe80::24fa:827f:6c5b:6246]) by DS0PR11MB7997.namprd11.prod.outlook.com
 ([fe80::24fa:827f:6c5b:6246%5]) with mapi id 15.21.0360.008; Tue, 1 Sep 2026
 16:08:18 +0000
Message-ID: <291cee47-c9a7-41ed-9be4-fbdc1a950078@intel.com>
Date: Tue, 1 Sep 2026 09:08:16 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/5] target/i386: Add support for LASS
Content-Language: en-US
To: Kishen Maloor <kishen.maloor@intel.com>, <qemu-devel@nongnu.org>
CC: <pbonzini@redhat.com>, <zhao1.liu@intel.com>, <kvm@vger.kernel.org>,
	<xiaoyao.li@intel.com>, <binbin.wu@linux.intel.com>, <farrah.chen@intel.com>
References: <20260826035734.114685-1-kishen.maloor@intel.com>
From: Sohil Mehta <sohil.mehta@intel.com>
In-Reply-To: <20260826035734.114685-1-kishen.maloor@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR03CA0019.namprd03.prod.outlook.com
 (2603:10b6:a03:33a::24) To DS0PR11MB7997.namprd11.prod.outlook.com
 (2603:10b6:8:125::14)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7997:EE_|MN2PR11MB4696:EE_
X-MS-Office365-Filtering-Correlation-Id: 497fc0ac-2f35-4fe3-b663-08df08433c8d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|23010399003|1800799024|366016|10067099003|56012099006|22082099003|18002099003|11063799006;
X-Microsoft-Antispam-Message-Info: jWLk91J1xd92GeL0sSnRfkHAct3TcaEVhJKMKWoCuVhpEP2QAck0VL6lbN86+lR2DRAuqaSGCts6NjhhV5hd6KxR3AhYenOFM9bGKk03ISdEO0G5GBSr73ymTB1WDcsVZJyP7JkJljMwfOIcQ+y9yPH1CfrKSRA+npL3vosMILSJDLtQFECmJV8K9fAM7ivRCgwoPjpfcaRA3lbCan/ivD0vBoWQdUMxZ2Kf+hIRWvBSZ9yKt98e5jeIixfTYcKmWylu/vvSJ60F/EteT1b4q+XwdSv0TaCHmLPym1fI9lyCgn66Sy6B65oK6QHZzQTurz2ftTEFvyeA4qdPdY5YFUYu3Qf6rkOzOZNawRL1JIG7lJcfw8pXJmddDh1HYUdra63cfB57nhCJJ4nWFRfCMYuES6T93z+kQDAF2oruunUgcscrJJpDoRgF+fJIJizuWeWUXZHqKYsNNqSE2eAgWIe9xFr2QEz+e3Jwtni2hB5uFODNO6nzcoc4zNPeP7rTAwwusBm3o+Y1/TrsqrdJWaFPPsxL4wkm29CiupxyGcu82LsgkaPXpi8hhZnE9cq0HGAQnoKPBAdalNxIDNWfI7UfTyG0y6aBQbfzhO2Dj6L8guXbgb9S6UhQy78zZ/VFS0w7mmlAAlFClRr5HdvQmhozqIumDnlrrC/R/CtPDXA=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB7997.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(23010399003)(1800799024)(366016)(10067099003)(56012099006)(22082099003)(18002099003)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TEZ4WGdodU94NzRieVZpZ2NjU1FuZGhWc21nVm5Cb0lTSklKaGZWQzlNVHNp?=
 =?utf-8?B?NU9BdXpyMWFWZndJejlvL3pyWVlyMllBeGVvQXUvL2JNSmt0M0tsMkZhek5M?=
 =?utf-8?B?NDFJbysvWUVNZlFtVVVUdEhraHlya1p3dDlhMGZCWnVpSXdNUVFaQmFXLzRT?=
 =?utf-8?B?d0lTOXpUUXJwK2FrSTVPQ3VQbW05ZVoxYTNYMkpSOVhzbmpYbm9WUFkwVnpH?=
 =?utf-8?B?dzNmQy9ZM3ZuRk03N1BweFA0alcrTEZFdk45d0ZnTC9OS0lQRUczNFFxNWYw?=
 =?utf-8?B?VHJHNzJIcWVGOHk0QWUwYmNKSjlkSWtMMVlGL2tpN05aeEV6OG8xOFRZSmVN?=
 =?utf-8?B?OTNxMUtzcXBGQ0Z6UW9WblVIemtZS01scWxSd2NDZEF6ZSsxSFpxSm03aEFF?=
 =?utf-8?B?aHUxZTFlSTdWdk5oVER1akU0YnEvUU9EWHdSUW5sVUdWTXl4Q2VnWFBkYWZK?=
 =?utf-8?B?VXloN0RFdENIcGNaNGt3YjBLRFdrTFJyWE1mcnFnUllBbVZOVW84Kzk3L0Fi?=
 =?utf-8?B?ZEZrYUIwdTkydnRpa3h6Yjk1ZHJvQTNvQVBlRmZLUUhpMHEvUjBSbUx0ZTBx?=
 =?utf-8?B?czFKVzFXVEthRlBWTXdUV2N4UXpRajRLOXBBNk15NzJQaURlVmdCU3M1VVlM?=
 =?utf-8?B?R0dGclBUWC9BQVI2TDlFdzRYL0o5SXJ2bm1pRkMxMk9UWjAyN3g3SjFZeVR2?=
 =?utf-8?B?NDYzNGd5b0MvQm9uZ3RVeFZGRTM5SnExZVVSUm9heVViSEJsdmJQVkZTT0Ft?=
 =?utf-8?B?a3M2ZUhtMTdHV1lSR2w4TVIrZS9HN0VLNDY3bTR4cXczNVlxckdOZjVZcWpZ?=
 =?utf-8?B?TkpzN2NwQkF5d0RvNWFvRGthdVY0VEFIcVZuYjJseE9OWmxmcUtWQ0RhaStU?=
 =?utf-8?B?SzF6Z3hTN1M1MVFpS2F0WXROeVVTSW5KTkRZdDBKQ2xUY1JaaXQ4TXB0YzhE?=
 =?utf-8?B?Rk55S2xscFdWZ1B2VUhMTkxUSGM1ZFcxSk5YdmZkajRBUmNNT0dSdmFobVc0?=
 =?utf-8?B?S25zaWlLdUlDL2JrekZzb1RnZHBLTmFkbWluRXJEdzR4b0gxWENlRTZFbFBk?=
 =?utf-8?B?emV3bjB1azFEN0lDaVBWSEdoZE9rdUlsc0psbXZTSmdyNzBqSDRYNFVjdW1P?=
 =?utf-8?B?R2lxR1NwdzZVWmt4M2NkczdTQVFPQUJncW5mWmZxSXJCc0NXUEgrb1JtQ0l4?=
 =?utf-8?B?bVZ3RWc1OXBOYktoUEdOU1NUeUllNitpRWRWcUY0U01TR0RFMG5WU0cvdUpG?=
 =?utf-8?B?ZExsT29BYmZ6STlzL2tiZTlUT3ZVYnhxT3ROQUdIZjd1SDZwKzdDYk1udFli?=
 =?utf-8?B?MFA2WEttRGZHeHo3MDlsVTJGZlErNURndjB3dUc4cms4RDhqd1NwalVKbnVS?=
 =?utf-8?B?T2J5bXlIb0R4UFJzcjZPSUpaVzRpWWZmM2ZCTitpaWtNZEpSM2R0M056c25I?=
 =?utf-8?B?dzMvbEk2YTZ4dFE4RkRlZlVuZzZaZENDTGx5T3dGcFowRFNGUDcyblhsUUFY?=
 =?utf-8?B?NzR0VXRBTDNMbFdUcnkwZEw3VFF0QlJWUENQYnhlUHZWYSs3YzRTNjgwNVpZ?=
 =?utf-8?B?MUJFLy9sOUpkYWtQVSsyOFVXb0RHd3gxTCtaRGZQaDJRTW9FT1dpajFLRWhL?=
 =?utf-8?B?NDNyLy9DNzlTQ3ZSWGFSTkZRRWM0UmdyTWhNMFU0NE0wTmtZbjJoSlYva1Vj?=
 =?utf-8?B?ME1BbDlnR1V5VDA1S3lSYjBnQThWRnc2VThrb25sdVBrTlY1ZG8rT3kwTDIr?=
 =?utf-8?B?bE5UTkVMQUx4ekJxRlhiY2RNK2ZIWXlROXcybTVpS3k3akYybHdqeXdTeDJH?=
 =?utf-8?B?SEV3ekRadCt6ZnpYamZyY3JTakJ1cTVmUTdxQytMQktObHNVc28ySEorNzhw?=
 =?utf-8?B?MzhGNkF2bXlnMjB3STNvNHhzRGxoSE8vN2xKTVEzK09XaDRUUjRVZEhnbGxY?=
 =?utf-8?B?U3lBbDdvbUR1eDkzN09tSGRXclF0VjJ6UGV6aS85S2dYeGZNWHZGUlptNklI?=
 =?utf-8?B?QVo3K2JlcHFvaDFXeUN2NUh3TXp4TlFGZmlwdUNGT1VmbnVLV2JMcSszcVRS?=
 =?utf-8?B?WjBxK1RPNGRPeXBiallWYVVlcGpUT3hFU1FETXg4MTM1cDUwVUs3TWZTdi90?=
 =?utf-8?B?eGsvNFlmTzlveTRGTHhVSkk1dmNVeDRReVU5Vm5YS1NYVUFxV0dUdkVaT2hp?=
 =?utf-8?B?UEZYSzNDVEZ1RWdVak5SNVBocUxuWmtzU3BycVd4NUc1NWo0c1kxRStpMGhu?=
 =?utf-8?B?Z3pyL0dFeXhFbVlQOVlvWm8weVBua1l1Tzh4OGpQVWdpaTF6dU5IWVBvM2VQ?=
 =?utf-8?B?M0RhS0xBQ1RENC9qV1UvK2lJY0Z0dlFnU1hrTUVBNWtWMmRNWGZvZz09?=
X-Exchange-RoutingPolicyChecked: FFB6ct0mCR5WNtQK3ocgQULtPznKvcrY+fkSmT4No6xFvryYZ505K5ozTtvEwHfg/JZGkLP5DaxgxxqGFAf/6HphcoL3yCXdq3qfjgWfKFO3Idura/G9yE3WDiAf/ljiot/mN7YaDCGX0oz0XE54Es2oIS3j5jMxlyE1qQwMid6CfFZiJ/ptyt4t/JGsSKGWvs2jk97alqxr0RtA3DE/zxyjy+svTrRQrAIjhnMECKxSciF0hjAjRTVrOoWgsMViifqCMN1sd3Zrj7mVeLEEo5S9P7bNKKfJXMw8wkzmgaecApluJt6UGEDKCYdQjpWuT99nF8E7Sb0+Y6hPBqKHRA==
X-MS-Exchange-CrossTenant-Network-Message-Id: 497fc0ac-2f35-4fe3-b663-08df08433c8d
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7997.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Sep 2026 16:08:18.3701
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ue9QJvYSCQyUqVzVQKvN6EYsBspc/CvynG3eqXmU0NLC2GmmfIVdZvvALTHZ5fnArJ+nFFMobZHkVro4K4iqQg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR11MB4696
X-OriginatorOrg: intel.com

On 8/25/2026 8:57 PM, Kishen Maloor wrote:
> Isaku Yamahata (2):
>   target/i386: Add support for LASS in CPUID enumeration
>   target/i386: Add LASS support in CR4
> 
> Kishen Maloor (3):
>   target/i386: Introduce DiamondRapids-v3 to enable LASS
>   target/i386: Introduce SierraForest-v7 to enable LASS
>   target/i386: Introduce ClearwaterForest-v5 to enable LASS
> 

Acked-by: Sohil Mehta <sohil.mehta@intel.com>

>  target/i386/cpu.c    | 26 +++++++++++++++++++++++++-
>  target/i386/cpu.h    |  7 ++++++-
>  target/i386/helper.c |  4 ++++
>  3 files changed, 35 insertions(+), 2 deletions(-)
> 

