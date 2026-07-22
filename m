Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D804743D4FA;
	Wed, 22 Jul 2026 22:01:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784757709; cv=fail; b=tN81nPMuOzG6Wac3NlZkrgw/KS/7TVXC028quyTgqryOWPjD1FtZU+u5iz1Byl5rArTLeXFRrDar6yqOYPLh6RQnCgVbbmtp3mV65Mrj7qB1Kp9iZYOn4PEuJGhmQBYENM8dgJuMx39/2TmemMqRnuHae5LRJNNO5dkdoXNdP40=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784757709; c=relaxed/simple;
	bh=RJv4f/Qsf49LcGm1Ox5Skzny8UMYxqGr1WfghZu0T0Y=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=ZCDi05Xkst9ZNNVDt/fOZGSvhUKQyBgb5NKFvTz7g1MimuruMrRHmM8kYjMK0iBOcYSLNRLYCXmaBeuaDqwR/95W3wPWLeedxtpcQ5v6UDAJjY8sIlgF8yoX/05shDSiHRdgAOcOEscI76OOcPxMvt5lutMi8yP6ZRxHP0ri2bc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=fnzDCpam; arc=fail smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fnzDCpam"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1784757707; x=1816293707;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=RJv4f/Qsf49LcGm1Ox5Skzny8UMYxqGr1WfghZu0T0Y=;
  b=fnzDCpam1nCBejM6jA/VQ4xkU6o3/TKxkYuJG0SdIZvffpSrUENzMebq
   /i8ZrS/jdgVHkNBrdmS1/xXOAH9yC1B5qWkIjvKSy3I+eWn52yEGNeKcS
   itNBPFrFtNR8wTw/NCNBNn9cbxOgDBCz3QNNWQSjIzTSQdGMLdCuWzSbz
   OEJ7Lck6PeRx2m7dlkFRlo7OxwenB/uEsvinDoxmzLI2ojz0Sjp9hw5pC
   Idrj6+X3kbZWEgjyfHOlfxcHHz6KWA5YrndmYhUlSrvV5ECh2oJ/k8a0R
   qveahiz1likufrTbP0OkqAZouDa+1LzuSR0dbH6ryyptYTG2eBN4dFgCD
   Q==;
X-CSE-ConnectionGUID: fZIPaHvITk2gk/OvVzexbw==
X-CSE-MsgGUID: sA3raLN+Q6SB2jeEXUyMpQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11854"; a="87946658"
X-IronPort-AV: E=Sophos;i="6.25,179,1779174000"; 
   d="scan'208";a="87946658"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jul 2026 15:01:43 -0700
X-CSE-ConnectionGUID: 4mwc6dWXRyyMwsyeqivBjA==
X-CSE-MsgGUID: 0tichjx6TUyx1CFI8Ey4Bg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,179,1779174000"; 
   d="scan'208";a="262545671"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
  by orviesa005.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jul 2026 15:01:44 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Wed, 22 Jul 2026 15:01:42 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43 via Frontend Transport; Wed, 22 Jul 2026 15:01:42 -0700
Received: from CY3PR05CU001.outbound.protection.outlook.com (40.93.201.6) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Wed, 22 Jul 2026 15:01:42 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aYZD/Wa9avEvwJwyufmOjfm46L34Or1MEuE/S/a7bLXNdGD9KBYUiqvT7kacqp/0m/1Q9QlHMQ7cjRCo7qy8XtdD+/Iu5vQQCsNdseK3KRFDd+ISsWueHO9Lqk650AzdLZGkuoNomUBGOykRHvdHwNNniA7UOOruajsQf3HqIj6CvftVYfO3zLopma72yOLbENyRc4o/Q3oHwafPq76aQxLfXY4JwtmkAe31mSEOtOpkp6IjXKqPPgR7JJVMQ+81o2UcZAI5TbjSTQL6wltUP0m/lCgr+RH+QNmJgB8Vhklez4bB48+Su8atWEudMO7Kh/37jwEZB1LKZf+dOY2Jgg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6lLOlxtM++96nw0UU3v7AmBqy0DSOVv2IPemT9EzQ1Q=;
 b=TtAGTtGxcauJP1XmHZXxmu3t5puefou+vxn/MgmHBR63/7NXnb63ihzMpvly5VWJz2Aj0NeAxziBfUAei9hTOk41wXzKLTqVbqV8GsMjKijLBuwMJD4JeGcUVf+BSsldsHAuGhaAPnmMJlhAZP3bNTI9xOBiH5yS6QYZBdReFqBOSA4OECEzD4fp/+H4JD/p0gtW2sU1HoFSvBfZJYQztvq76Tx34zRaaNvHyFtMfjgYsKqNxbjLJYCEb9ueidxSlrLd3b3YhCSdBYXnYuMiE9fDK7g/0GtFIZLbEuL3TiQpom6ZTfro2xHMQ3S/0BAwd4GusJS/E0nAfdtZ3hrq5Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7925.namprd11.prod.outlook.com (2603:10b6:8:f8::18) by
 LVUPR11MB9833.namprd11.prod.outlook.com (2603:10b6:408:39d::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.10; Wed, 22 Jul
 2026 22:01:40 +0000
Received: from DS0PR11MB7925.namprd11.prod.outlook.com
 ([fe80::60af:89a0:65dc:9c84]) by DS0PR11MB7925.namprd11.prod.outlook.com
 ([fe80::60af:89a0:65dc:9c84%3]) with mapi id 15.21.0245.009; Wed, 22 Jul 2026
 22:01:40 +0000
Message-ID: <e0072646-f255-4fee-9fb0-a213aa2e7206@intel.com>
Date: Wed, 22 Jul 2026 15:01:38 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 00/20] KVM: x86: Enable APX for guests
To: Paolo Bonzini <pbonzini@redhat.com>, <seanjc@google.com>
CC: <kvm@vger.kernel.org>, <x86@kernel.org>, <linux-kernel@vger.kernel.org>
References: <20260720171949.498680-1-chang.seok.bae@intel.com>
 <081e6523-04c8-439f-a251-37a5647054f8@redhat.com>
Content-Language: en-US
From: "Chang S. Bae" <chang.seok.bae@intel.com>
In-Reply-To: <081e6523-04c8-439f-a251-37a5647054f8@redhat.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BY1P220CA0013.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:a03:59d::17) To DS0PR11MB7925.namprd11.prod.outlook.com
 (2603:10b6:8:f8::18)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7925:EE_|LVUPR11MB9833:EE_
X-MS-Office365-Filtering-Correlation-Id: 385ca162-ecf3-4cab-b36b-08dee83ccef7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|23010399003|1800799024|11063799006|56012099006|4143699003|10067099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: apacLwMYVRaAgV2mriQ55ksaAE3lcxGdqAb6pDmYdTf/EyGibPg6H9kKdpHqD3H5KHdSKt4KEt2W/ElL41G3D8u437ECwnyX0nETqc54HSKeD8JZVHczY93R7x/5gxIljqWF6T4UnTrmkaMRPFmpjyyHx/tb5fnUqD2TRIIgXGAEF+7VzmYwW+pbvQ+0AO44yAShc7rEYdpZntYYD3gmFLDbkjyQeOo5iQ2UJFQJ6GIREju9sA/Yzb1hyqA0qFXRsUOA5KVxclz6nOkODqU2yzOJ028x9yIfTyvGtCqZUUpSQttxw6HzMxps2T5mfVKvkP8T7sUOSo1CaRi3e6vCH3TZgLsh9z75TS6QVHaQAt3l+BdlUUaGdwQe0OO6vtzWzwMMzsPMzJw0qgs2Nd07AOaTMyrXRbCz81rbQSkxN/S0OLOKHF8Q6FpBpGL1GNwXr+cmuYjfhGqQULVEVFHX6a2/4FycXiGsFvyVa4Oce3iwroNcnk/nHb8lbl4fubYIoGKNtEwxrqzYL89t/Nn3E7ASq3BdNngNEoiAhLrp7DGa9s1cDehlR6xBerIreB3llKFK09w9afW1T7j8SaBgL9PzDnxA4JRJxV8fclVwZB3Tc42QZZDagpOr1SHn+T7o7a5KSYxV8RQmuLmApGgPcNpl8g9VVo43JOsXNAXyovU=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB7925.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(23010399003)(1800799024)(11063799006)(56012099006)(4143699003)(10067099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?b1pJTGVYdm1uR2gvLzBCTVU4Yy9sYkl1YUpjc0lpOXlEQTErSmFmMlYvZTZz?=
 =?utf-8?B?Ny9oMU4ycDY5cDV0dzBwWmVyemVDTFlORFVlYTZXSTVpRkVFUU9HOUd0d3ho?=
 =?utf-8?B?WldBeU1JUVRCaTl6OXA1N1NrTTdoc2xzcVNzbDZ2YjFSeFhPY2pZZ1IzRXpD?=
 =?utf-8?B?UEgyUjhqbGtQV0F4QU9zNTNiTm5FeS96eHhuVzI3QXhlWGxxQUpMMTdHSmJj?=
 =?utf-8?B?MnAyWmYySVluWkpxVVVwdlVlZ2dONlRhdlZCR1N0b1hrUkNKRXJrSE9ZQWlY?=
 =?utf-8?B?UjNMWmRFWjJhUjdTcmp4M0xDb1ZVZTkvUTB6NXJ2NkZKU0thZGNZNlBKUjNE?=
 =?utf-8?B?NnAyNTY1bFhmenpPOEF1N1RLbTZKd3lYY2JSZ2kzSDZYRlpqWk5lU0JrR2Y3?=
 =?utf-8?B?Ly9iWnVpOFc2djV4Tk1WQU5oVElRQjh5eGJlcXdRVVNtNGNVbWYvTjB4Umsy?=
 =?utf-8?B?YitZaUxqcEZzVlJGanFUWEF6czZIaHVjenUrcTdwazBNblV6bklqVGlUVmZX?=
 =?utf-8?B?amhNRC9aUlJiTFBrTU5HaDd0SkZLa2lLQ3hCQUJkaGJ4RG5PWWRCZWo4ZVk3?=
 =?utf-8?B?VjZWTk0rc3UrRDFJNTRFWXJtS1kyMHBFS0p1cm00T3RaM1hiYjk3YUpkaFNY?=
 =?utf-8?B?ZHV6RDA5aTZ0VG5XeFNFenlUNjB0WU5Jb0VVUDgrYjZZa0JUWjB2Skd4bU9L?=
 =?utf-8?B?T1Vna1ZLcHRzOFlpaDlmRlF2VHFmd3hVOENjNFZmSEt3VGpETHdRbmEzWGlB?=
 =?utf-8?B?TGI1UStBY01VNkdUODRKSEljY1dFbkhJengvOW9ycmVoVHRuWFB6elpSMXNv?=
 =?utf-8?B?ZUtFbGhNTWxQbXdDMVE2SlpSUWo2Nk41QmlCUy9lc2RyME1UaEgyazRDY29L?=
 =?utf-8?B?SWttYk5VZUhsR2hSd3Q5RHJycEhTVGVqcHRGSUk4dWpJeXVsaXB4NEdFL3h6?=
 =?utf-8?B?MDVJQ1MybHM3OER6RGl1bkVhVnBvcWplbTVBNEJPZHB0eHpPaXcyTTdJUDJy?=
 =?utf-8?B?b2xjL1VFc0VwcEI5MnpLTHZKeGlBVHEvV3NPaVNsU0w4OTdKQmpFR2lzaE5Y?=
 =?utf-8?B?cTl4VlNQT1A2RGdTZWhwaEN1eVhURTBxUHFXL3RIUU8zd0hxd0tGVHdYaUJS?=
 =?utf-8?B?MUYvNk1JalY5cXU5QW5GRTBBbDczUkdOeUZqd3REM25yL1FOSXVaVkdXSnNQ?=
 =?utf-8?B?Z2JFQWIzMVhLdVYxMllYb3VtRFF3K1F5bFE5TmN0UUZlQlU4b1ZLN3FENEE3?=
 =?utf-8?B?bE9nZ3V6c3JnOWNQT2oyckFvRklhQmhtMGVCaERZVElWdFo5Q2NnWWtaRlVY?=
 =?utf-8?B?c0pFREV4SFFqMVBBa0dud0VYWU1KMjFqS3ZHb0cyWDRHZmJETGNtTkptUlJF?=
 =?utf-8?B?bUZ4SzhSKzlYenVXcFYrUDBhU3VjcmhaUUJ1VGI5c3dLQjR2WDV5V1R0V1NP?=
 =?utf-8?B?ZnF4dXZTUEtrNEJ6YlArNTl5TGNiRXY5cjhRM3BCL3FEWEJ5emluYTZWc3pl?=
 =?utf-8?B?WTRPWCtReE5jNDQ4RjVGZXAyOGlUMzBQV3JydmErT1VQUnExOXE5Z012Uzkx?=
 =?utf-8?B?WU5OVW5NYXBTTHJNNXo1alprQmk0S0dkb1paNVFQdVlCVndVWnU5V1ZYUG9r?=
 =?utf-8?B?R1pROTNUcitTbk1jcXZlSThzdmtzNmYzUzdVVTRVZlBHbVZqckp3NWw1SGFJ?=
 =?utf-8?B?QkkzczJxc3NkNFJoNCtQbmpHa1FKZnFFaFRHQkNsYTBYR25BRWg0a2EvRGNC?=
 =?utf-8?B?NE1Wc3I3bm5PY1JDTHgvY3R1TDhXdFUzQXIxSER5NXBidkphcFRobzRKKzJX?=
 =?utf-8?B?ZzQ2WDFsOFZESUk4Sit0cmozUzBqclZnY3FhQVRQeG81QTY0bHNpTWU5Mlhr?=
 =?utf-8?B?MnpsZjJxUEg4dFNwYlZFZktiaUF2SEtyNE1nZ2FpMTVUKzdKais3OW0vdXlX?=
 =?utf-8?B?RVpHRFVYSDQ5cnFKRnFnNFRSd05PTmR2UThWaGlIWlE3OW9aSTNDbDZSZTc1?=
 =?utf-8?B?OEVwemhuMnlGeWFMVjAyWTdQai9ydS9NR1Zod3l6YmovdmxudW52NmY5VmxM?=
 =?utf-8?B?R2ZtZkxKMmtKblVLcUZncEtJcFc4cTREakVpTHJhbnpheEdZOTNwVHVTSW5J?=
 =?utf-8?B?RTgzY2dzUk1XRWs2T09IRExLNHFmQWZvcUsyQ1pmSjhQNUYzMEVsWWFXYmlL?=
 =?utf-8?B?azBVTHFlR2ovM1lTVDFzd3RuYVM1NUtrT1lxYmdraXEwbmlMVVdoWTIwT0sv?=
 =?utf-8?B?QlUzNVlPaGE2M0Q5WHk2ZmQ0WTFNNXFYVmN6aS9TZlZWendaSWgxK0FsUG1V?=
 =?utf-8?B?R3BmM1JxT01VRSs4RjYwR0E5eXAwSWJYMzc4UGxHOUN1MHJRMm1Sdz09?=
X-Exchange-RoutingPolicyChecked: Z6ve7ADBrrh8biNY1eRGiGDUx+LB7kf1BmMCQThVp/774aUdARhpto3XiuKfhOCHHMRg1FucqT9ZkdEiiV51vBgz5UsnUuyeOUmTDM6bpSqx64teqj9i28xy5VLTMAQevoWkDG0oHbb2H3J8kqHZQIe1fZlDHHd3jHutye6j2HnNUwXngjN+tHwPguLySzIT1rmEgCuUKyXdZxZ/Un/p1rCwiLebmJFLRn3MkdxTChHKLeJyAddE4UJW7ooqJXoH8XjRgI/Saq5BtS7MfvqzwbD16KI5hQ+BDautRmqwp9Txx2RKV62UaIVzHipfEqb7xSTd7ADwC992LNNzehQdUw==
X-MS-Exchange-CrossTenant-Network-Message-Id: 385ca162-ecf3-4cab-b36b-08dee83ccef7
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7925.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jul 2026 22:01:40.3579
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xPIa3bsxg9D5WrTiE2p4B9ugVLxY/N3Cw/LxPt2iYhk9bz5GUC180j+AJM4nvn6bMMqlRwqR5TRusMnUVF7DDQdimhL6ND43SIsT5EdulSk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LVUPR11MB9833
X-OriginatorOrg: intel.com

On 7/21/2026 12:09 AM, Paolo Bonzini wrote:
> 
> Thanks, will review.  Sashiko was a bit drunk when doing its thing, but 
> please give a read to its comments in case it found something important.

So far I could take a coupe of points:

   * Patch02: "register restore" => "register save" in changelog
   * Patch18: add `case 0x29:` to cpuid_function_is_indexed()

Otherwise, replied back there.

Thanks,
Chang
