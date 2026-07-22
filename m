Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEF2F43E486
	for <kvm@vger.kernel.org>; Wed, 22 Jul 2026 21:55:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.8
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784757337; cv=fail; b=dc5n1J/rSv2s0MOEfdHfFZ6jsbVpoWI2KDGC7GhjFovvUYo7OBpFqLE4kAk7UtbY/l87DkfYPosT4Mt1mQCWgSWjtBkwefdJnGuCZxwYiuOsG1jZ2st2eEFZawMpeliicHnS0T9wAVfa48TcZo2k00jsvxtEPekij03eMh21PCE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784757337; c=relaxed/simple;
	bh=WwmKR8hvFGbL3KTCxHbJou0fv6MJRXJ1qpO/3gLhs60=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=T8XyP/x0WHzyZwd9iVLzqmB6N6V/lG22UXvXmFQNzI0ujIin5KrOCLlbNSyv946dygq9K8C5jhMWzBixXw6CNMpvL0tOLBKeGl2oIFRf3LhhI4n+Cdb8b8odnCfIpUMYd0veiEdZRLxlePeonWcBAMtOu7nk7dkdyc18+RMX3fo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=S2INi76K; arc=fail smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="S2INi76K"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1784757336; x=1816293336;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=WwmKR8hvFGbL3KTCxHbJou0fv6MJRXJ1qpO/3gLhs60=;
  b=S2INi76K+bvRZceWz7koV9iBsQHmdFfMY4uvSZqxZQD5vom7AXdpaibT
   k8JomCq4y1XrphJc61/O2nFQC/qNVtkYZy/V53UQG3zUVqbpKcOaadnYo
   b2Ba2d7rxf+ymWOn/Ez8zfow5jvEidxVYxm89V7WW1NgrCGzInY60jYaQ
   GBnQi6CvU2HRr0jxInD+LQgNZca26ePM8HN9So/KbfveqqC1kJgm/h0k/
   hG/pHuLk7kIYb9m8HnCEZEZfG2AkBvK+f19rR0mwifWxE3rV/IB3E8Zrk
   /XvcJ13hIBd5i72RiBXXB6+NHS0z9naNkN0g4BxoeBauGHB41HW2CwJMV
   g==;
X-CSE-ConnectionGUID: U7Pec81qRPmo4zk4Ai5uzw==
X-CSE-MsgGUID: TcQcqCaATfij6xsVmRRutw==
X-IronPort-AV: E=McAfee;i="6800,10657,11854"; a="102950822"
X-IronPort-AV: E=Sophos;i="6.25,179,1779174000"; 
   d="scan'208";a="102950822"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jul 2026 14:55:30 -0700
X-CSE-ConnectionGUID: xd/7rhsCSU+gHHK6P4v2Ug==
X-CSE-MsgGUID: W4btTI74Qx60PUcxjSKAXQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,179,1779174000"; 
   d="scan'208";a="256421001"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by orviesa006.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jul 2026 14:55:30 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Wed, 22 Jul 2026 14:55:28 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43 via Frontend Transport; Wed, 22 Jul 2026 14:55:28 -0700
Received: from BL0PR03CU003.outbound.protection.outlook.com (52.101.53.15) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Wed, 22 Jul 2026 14:55:28 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZEOCEcPCLsqapGuYVteng6TE+nYgipgAyRcQVyP0ZWcrBE9k3bYkuERSQTQfbCqDx3y2hHAFI2GtQ/ZGP+30Q1h5AOY37MQVdtrLC02HJgZc3ofFVmtblv2e1EUtcjjfr04CVGTmGo5KZoHF/0YeuxZjToA872QQCJynuLHp5rTLfSedT2t69lS4LWBMKKdgamJXzX+Bxr10PD11ArlEZ2Ybuaexc++bSTkXsbdlwygIKa2dAf6EH0oKotLR1TriF+Lci+hJMqWhn2mT+8X6QfRBn1sQLGaLSmwUoHpb2CRf7uqcBga/8xD6hiEsacf9WU2Mtgeh3sq6FnODSlL8qQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7ddH6qwnArh54o+Qqzk3okGv9OWBdhgD/sjq/Tc2k2Y=;
 b=IZrQlFdbVugD0WmVPcxJsZhIR7fe/PaT5c+APh9Bt5jgwxWwT4xBoQtDHJhVLjMjwR9YbP1ZZMg3HM/0aXeZivSxUg9Tg76POfVnE9cG4R4y09VDPbhnHs6MzeBrhoHkePzkAR6oyxqMlglpmSIAMHJ3yN4Ii4GADFbV7h2ztUdoWDHqYNqa2dvS+ZXIv/X416OtbDwCnXR5LUZVOsEoGML0droUFLo61cYS8OCUDVdB0SZHrZVtqXNMM0fgt5IxOzDKa6Jmc13ScBnAmQLv4uVemyLP8IHgCaXyfuy1qKSUNHBkcDYE8U9DX5d6RBOE9xVxNbnIziNZ+rE4V8b7eg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7925.namprd11.prod.outlook.com (2603:10b6:8:f8::18) by
 DM6PR11MB4724.namprd11.prod.outlook.com (2603:10b6:5:2ad::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.245.10; Wed, 22 Jul 2026 21:55:26 +0000
Received: from DS0PR11MB7925.namprd11.prod.outlook.com
 ([fe80::60af:89a0:65dc:9c84]) by DS0PR11MB7925.namprd11.prod.outlook.com
 ([fe80::60af:89a0:65dc:9c84%3]) with mapi id 15.21.0245.009; Wed, 22 Jul 2026
 21:55:26 +0000
Message-ID: <85609d16-f744-492e-a457-02849fada16d@intel.com>
Date: Wed, 22 Jul 2026 14:55:24 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 17/20] KVM: x86: Expose APX foundation feature to
 userspace
To: <sashiko-reviews@lists.linux.dev>
CC: <kvm@vger.kernel.org>
References: <20260720171949.498680-1-chang.seok.bae@intel.com>
 <20260720171949.498680-18-chang.seok.bae@intel.com>
 <20260720181244.E4AA41F000E9@smtp.kernel.org>
Content-Language: en-US
From: "Chang S. Bae" <chang.seok.bae@intel.com>
In-Reply-To: <20260720181244.E4AA41F000E9@smtp.kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BY1P220CA0024.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:a03:5c3::9) To DS0PR11MB7925.namprd11.prod.outlook.com
 (2603:10b6:8:f8::18)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7925:EE_|DM6PR11MB4724:EE_
X-MS-Office365-Filtering-Correlation-Id: a2bdf539-9bca-42b5-7462-08dee83befe3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|23010399003|376014|1800799024|4143699003|56012099006|11063799006|10067099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: t670kXk2q+/uh2TLfYutcLnjPOSW7FhFfG9fOwLkpMvlcETJnc/Ffe+m3GRoH5IPezxh+TCDqucBwp9+q5PSJdw895WoK4Ca3AqJ2A/Syj8N36IfIpFwh8v/E2AAMZ71I3nWhkOaL4bAlFnp42C3fZu2ZN4oeebtGq+Tktnr7EdThsGmvU6hGkYNrcoWaBnSHDanHs/f4uYC3LOwVIVrgUpmHElQUuM/I1N6g3mIAZBGtm7/S0up29ppJct25XzVZgRKYk/K3yhlWunHVPg/oDbAoQ4F3yCu8xGdSBpK6cuOXSo+bi54I4rw6Ucz1AD/sNc8lbdaQUVbYZZdG18cHDPe+ZrtxJOUwjHwBt7XHLuQeSfI78GDgeQKN5/B3V7Y94yQJ1Vr17gj+H9c3Co7FX9MNaEsBjSY/yh1EBJlIOmb48UjAHLvec8/wy8x0sPpM7LTAX2rSrI58Gq4uiKFKOjFaH1OOKqkpk9jwS/0ZPJK0ccKc3351oHPNlHK/NV52FB+vBW6oqkCxgYHon648q5E1AY+no3SRvU9LZf3DCX2Iu63ls7u1yD7SiOED7IfN8tLSG3bJzIvlT//DcCY4FAp28u/C7/ux4V/rgDEQdY2L6UmhWd/QRivEs2PZggvfJaXIeWze0fQaa8HGIGGEuA1nmV2hHHDld+aGn54Yrk=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB7925.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(23010399003)(376014)(1800799024)(4143699003)(56012099006)(11063799006)(10067099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TWJ6OW8wWFlWNGViUFl0ZEFNQmZlTENMMEtCWXN2Y1B2Z2twdTU1elo4Y3Rj?=
 =?utf-8?B?M2lBc1ZiaXRORk5LbU5QYTh6SXN4T25MZ0w4bFZTZkE3eDIwNmUrWCtXclJu?=
 =?utf-8?B?d2ZIYlQ1MGM3RWhFKzMzZlBmdTZsaVY1c20yZms5LzJiODJlNzNrdWtDWGl6?=
 =?utf-8?B?dHdtZlhVYzh3WlJZZ2JZSE1KUDBPdUh3Y2ZpamdsZ04xOWh6UlcveE94QzJ4?=
 =?utf-8?B?c1BZM05IRmMwUW1QeG1KNmxBeHFTNWpDai9PYUl4TWVBNXZWbkZyanZGa0V4?=
 =?utf-8?B?UmVTVVcyMk5nVU5rRElKMWFVbGVaNjhzcjVFbUE0alczenJIYnNNOHVlZVFr?=
 =?utf-8?B?d0pZeUUyTlpXTUxKQVdGOFVJM3ArRTM0cXVnUXVTV1o4dFdWbm1MRjJkSlZB?=
 =?utf-8?B?UW5JWjE5OTRCa29xSlhJRUpxanIrbVhleGlvYndVVS93Y1hwalRHMFkxa28v?=
 =?utf-8?B?cGVTdVZ2RXFOV2xGVUhyYkxXYURVSVBhUmNNT2xiRlZIT0hVQklWK0RSRlBX?=
 =?utf-8?B?UmtrRGt1aTduVFA0RHFpVmZDM2c0MzdBS1RleEQ0T0xyanVRbmhreE02akV0?=
 =?utf-8?B?eVBhMWR3c1A0YUw3ZUNPd3hVZkRqZ0lPTDB6U0tTTkhKQ0srNzJkODRnS1RD?=
 =?utf-8?B?ZUNUWGxJT2tBUjVaR0hmeFl0OTB1a2o4UEZ4eURVMUNUckpmdmxkWkJaYURa?=
 =?utf-8?B?TDdMYk9NRGNTTVRnM1F5bGNpNXpkdGxkM1ozT1MwMnNRNkxQbEt2WnZWUWNK?=
 =?utf-8?B?NFpCb0NlcXNZOWpHY2VjSWJaVWJtZEkyUXJJVTVvZ2NZZUNMR1FMdFJZaG1L?=
 =?utf-8?B?ckV4SXE2L3hjTlRzR0NIZXQ5VGF1RHFEcHpyeHdtZzBuQ1d3Ylp5Q2xYZmVC?=
 =?utf-8?B?aTB0NHhDcDJGSzd4cWpraldPSFZDSWFUR3I2M0FnRDJiR1A2UzVCMHJSSUlw?=
 =?utf-8?B?V0hwQkdRWXg0eUZJZzUvVmFrSUFtS1h3TFExUllzQXc2eWZKSFAyWk12aEdo?=
 =?utf-8?B?THNSWG9wVDEySkIzMTczSlJIbFhMcW1aYUQ5S0JFN3cydjVncEUyeVlEMUZL?=
 =?utf-8?B?WjRJc00vY2pPdkxhUW5QL0pnVVV2Qnh5VkdnMzMrODR3M2ZOelpaSW5kSWRJ?=
 =?utf-8?B?MzE5bzJLSno4eEdQdmxnaE95THpuNFNyRVpJVE8vazZ6ODVhNVlCdnJLU00r?=
 =?utf-8?B?N043RWtEK2R4UFR5RkxsM3NxYXczeFYrNk1VNzRaN2VxNGRzL05zQmhOWFIr?=
 =?utf-8?B?OElmQnNmTGpvNTI0NzVVazlMbm1RMGg1WGQ2UFlaL1FMQTFQTWFUWG5FRExa?=
 =?utf-8?B?ODlGZHM2ZElnVlhmY2RYMFovOFBJWWludUlaaW9RZ2NDK1JEWnpEYmxZeCsw?=
 =?utf-8?B?dDgzejRIeEVNRjFIRXFWN245Q3VMSVRXZzg1UkhQNUpMaVJFRVIwWUxPcEdV?=
 =?utf-8?B?RHFxYUpEWTVMQ0xqZW1vb0pZYlExZVh2TjBIMHlRZWtSSlo2Uzh3dlVPWllV?=
 =?utf-8?B?dHRNSjdtZVBVZjNCdUljZ09kUWJtTUM0bXhyWU5VOFM4ck81aHo2OTRTY1JP?=
 =?utf-8?B?ejJYL2VYNFIvbjNyWUtoNkZibTZDMW5aWXBYeXZMazZMVHkxNlNCMlByMm1O?=
 =?utf-8?B?UjFiSFhqdlFSbXBJRCszNGRrR0ROVjdTV1RXb0NnNU9MSjQ3aGN6K0w0aGpH?=
 =?utf-8?B?eGZZejI5NVVPbmJ2QzRaZTZ3bDRTS3dkNzk4azBZWnBRSnpuMG1jUTVhRXpq?=
 =?utf-8?B?TGpQUmZZanY0TGJBODNWUnFaWU9RK3N3U3RzWGFTbnU5d2Y3QmI0SzhyVHFj?=
 =?utf-8?B?ZEM0cUlNMThNMERUYVJJZGM5aHcwR3o5d2Y1SEw1UFdtK1JCOUUyRjZ1UXhI?=
 =?utf-8?B?bGdWcm9WT0prZ0F3b3hOUU1XZzUzaEd5NzlXMmFTSnpXMVQyTTV2aEM0ZlMy?=
 =?utf-8?B?R01HS3pFajdqSHF0ZVd2eEpoTzZucG9PbDRJWjF5b3RmNFIwTjlFUzBHUmdm?=
 =?utf-8?B?SlRnK3Z2MG1iUS9Yd0J4eHJ1MkloanBwcVAxWTZTKzFVZHJTRUVjdTVUdWtY?=
 =?utf-8?B?WXZBVTJieEw1c05VRWFGMWJ5a1pqRVNBUmVNK3BFdW9IL01hSktudFNIdHpq?=
 =?utf-8?B?NUgza29MeFB5UU5DaVdKWDQ0RTd0MjBpY2ZKbEMrdUJnK28yREpIWTRTRlpt?=
 =?utf-8?B?MzdMNXhEVDRzc0d3WTl5cDVKTFQxWTZjYmlJbUZxZ2FxbnN3bTcxUzRJSkFO?=
 =?utf-8?B?TFIrdzQ0VnNLM0ZhOXh5UjJZS25tN1lMazJRaVA1T2JTZ2hhdjdLa3EwUzl2?=
 =?utf-8?B?VTlUd09ZYk0wS1E0Yk9lMGU4bUwrNllITWVJOUc1NEt3ZEVEeW53dz09?=
X-Exchange-RoutingPolicyChecked: mqGJpJl43QHyVfw7J8zWfyRd5MVzDc9gDunJ8LQeGedUNdibIZIZneplBKbgsnQH6ZAY+CnmqGd0MYF0LrwM0AIuTN1/WeXUnR4PKMb9s6MzJFdcJGRSORxqbSIlX57Vxfg85FaHC+aLagIkzZC4Et6pod7SCpaZeHYWu4KYhPrDZHO8NL5O7JlP5Xpl7B4VWb4bKuhIXMlAkMT9TihgaeosEmLh1xSk5mIMrJQf3IJXMb8khF2rMkSFyUI0NAAMv0tFmEGSRqo8VzwkVRjEaBxKHSw72P0i9ePN9HaIYgtJXuFrsE8N7WWR8aEeB1kNu03X2+RWgUTC8BKT8T6+Og==
X-MS-Exchange-CrossTenant-Network-Message-Id: a2bdf539-9bca-42b5-7462-08dee83befe3
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7925.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jul 2026 21:55:25.9892
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qtdsaZaoG5DAtMzlKaf9JjZBOT4lSC9+RIXryzM1sHh6rtcVhqkrAso8bh8m8dzLAlXwInAxJ1WEtvNpl50u8DqtWmavgczqlgI8pW3d6aU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB4724
X-OriginatorOrg: intel.com

On 7/20/2026 11:12 AM, sashiko-bot@kernel.org wrote:
>> +	/* APX sub-features */
>> +	case 0x29:
>> +		entry->eax = entry->ebx = entry->ecx = entry->edx = 0;
>> +		break;
> 
> [Severity: Medium]
> Should CPUID leaf 0x29 also be added to cpuid_function_is_indexed() in
> arch/x86/include/asm/cpuid/api.h?
> 
> Without adding it there, KVM will not set KVM_CPUID_FLAG_SIGNIFCANT_INDEX
> for leaf 0x29. This causes kvm_find_cpuid_entry2() to ignore the
> guest-provided ECX sub-leaf index when resolving this leaf.
> 
> If a VMM populates leaf 0x29 index 0 with APX features, a guest querying
> index 1 will incorrectly receive the features of index 0 instead of
> all-zeros.
When a bot internally raised this to me, I didn't think it much 
necessary as looking at the userspace counterpart. But it may be safe to do:

diff --git a/arch/x86/include/asm/cpuid/api.h 
b/arch/x86/include/asm/cpuid/api.h
index 82eddfa2347b..f38d5e8a3c05 100644
--- a/arch/x86/include/asm/cpuid/api.h
+++ b/arch/x86/include/asm/cpuid/api.h
@@ -182,6 +182,7 @@ static __always_inline bool 
cpuid_function_is_indexed(u32 function)
         case 0x1e:
         case 0x1f:
         case 0x24:
+       case 0x29:
         case 0x8000001d:
                 return true;
         }

Thanks,
Chang
