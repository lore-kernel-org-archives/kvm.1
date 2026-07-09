Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1DF5478846;
	Thu,  9 Jul 2026 17:26:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783617997; cv=fail; b=VQ+eGinDiamv06H8rzkqPVpOo/cXnkEpta3hDB0vteGtuhqwZezMNUI2a47IDwhWifZZ0G+DZ+3bUIxbkbZM+b3r/Ua1FO09N2+61dpX7Kspl7I0VmDPC94MYCFWIFCnooM/i6aK3w7VVKNMKzC+KfG8hXlkkrzih0jaNhNOxSI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783617997; c=relaxed/simple;
	bh=BUcu62eirr5VFr5yqjGQ5KobFzlXd2LEa38Ycw4KKfI=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=JKFwhRo2Z318imr5nj+ZsjpRDoFYu/ld4azCiSVRq62qeP4/fDcN4P+E1IvFfAtFZiARSK4govtSlBqVYPWIROw0ml8O7wG1x2cYHZHH016ABE8hIBBDUVhXXb7DIj6VactCZnFy/R+0/ksh/PZWT83/EN4tI9zNvkTmA6iV+1I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=N1Jj9PUw; arc=fail smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="N1Jj9PUw"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1783617993; x=1815153993;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=BUcu62eirr5VFr5yqjGQ5KobFzlXd2LEa38Ycw4KKfI=;
  b=N1Jj9PUwXkc4da2ew4KVzr4UkAVJ7MVnALYYdDZnyfo2Aaj5oOl60qa1
   OBEHBmMRv2D3xKZmhXr/wEkH2fXvni/LiX+TGjkvtbtEUwam9N/gF2j5c
   /BfLCkfi+0LAcJ3om9UV11mxiZkF2548J0tlM6vRvZtAfKeD5pJpOD+ej
   jfGGeR4+IwdcBgYpqOxGqTm9Lomd0HYdQpqfQo0qYKkaeTPOEMG0ZzCUQ
   jjVqjmhE6myISrjo3QgHbUsnnMXBL5xz8qz3sGhymLouRp+G7gJeHegX9
   0xBWxQfEk4u8SWY39Qj00NZWQ8vONNKsB6b+cxcHVoKkexwkdhpGQlnTT
   A==;
X-CSE-ConnectionGUID: Wq43F7ePTWyykHvuHwTC0Q==
X-CSE-MsgGUID: pLnjMk8jRh+WG9gDN9SJGQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11841"; a="88224472"
X-IronPort-AV: E=Sophos;i="6.25,154,1779174000"; 
   d="scan'208";a="88224472"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jul 2026 10:26:32 -0700
X-CSE-ConnectionGUID: a3NBGMWNRuKvAxZypIO04Q==
X-CSE-MsgGUID: +grrloUVQ3Cdcph96griuQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,154,1779174000"; 
   d="scan'208";a="250649756"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by fmviesa010.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jul 2026 10:26:31 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Thu, 9 Jul 2026 10:26:31 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43 via Frontend Transport; Thu, 9 Jul 2026 10:26:31 -0700
Received: from SN4PR2101CU001.outbound.protection.outlook.com (40.93.195.39)
 by edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Thu, 9 Jul 2026 10:26:30 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IiB41IM0jkl7dU+6IO9kPUFn6t4U31yMr6RZxscY+Na/fXqj+S4nqjOhUVoNQGA8S353GMxgaKms3ntMMVTlxA+2HkKBwqo7XQ2WvrIz4sm3Zal1/okCGG62ZuQIaKNR8bDion/56gFhC6DGkjlWNiFjUAodC+dPNDxr0MdqTeTOc0oGF5Sv5JF6N/YjBilQJ9/b4aj6KAc+dKtS/AQmPN2440sIcODVisugF+x6uIM9FBDya4Mf3931DBUcE1K7x/o0K31bIANsk/37aJSxJfV/IN5m4XDwl1XE1Xqzl5+KlwJ5B1e8XGsc7J37Q3sPA+61DXs4qmsEjvxnwPX2ng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cgY+ONm/zqM2qTrpOTkl2165gBk/sjOG9hrboF8XPJc=;
 b=HSkRzQC784ot8wPe0hOmtcIaVqEmNx6MqDIpmVQV7WvnYtsecbdKVii7Y0mhxC3wp2ZWARLrHkVoPnshOmF89dF109mSvs7KVF0wQPRRPyQEHXJ9NtGxx+jwYLxS5P7Y9bAaecbiJc2MczyYGRAsazPfqOo/zBNXYScSKjdqygLb0I2zSJZ79ZxjBqQNEaWJqsUZAAwBBvbraCnX+nYvfb252ixSpeWl8iN7Br1UuKRXmRA32ghsv+3X+8uEd6+DVZVwYx9kSgWOeLB/avKiracAbgp/TDWUH6qTG214nDV4zJWgoIFPyGn771yhisyHn3FCXpZvgbEtSqEZlKuM6A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7925.namprd11.prod.outlook.com (2603:10b6:8:f8::18) by
 MW4PR11MB6838.namprd11.prod.outlook.com (2603:10b6:303:213::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.10; Thu, 9 Jul
 2026 17:26:27 +0000
Received: from DS0PR11MB7925.namprd11.prod.outlook.com
 ([fe80::60af:89a0:65dc:9c84]) by DS0PR11MB7925.namprd11.prod.outlook.com
 ([fe80::60af:89a0:65dc:9c84%3]) with mapi id 15.21.0181.009; Thu, 9 Jul 2026
 17:26:27 +0000
Message-ID: <45c4c50c-b2b5-46c8-acae-55ae60eb9afe@intel.com>
Date: Thu, 9 Jul 2026 10:26:24 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] KVM: x86: Remove AMX-TF32 enumeration
To: Zhao Liu <zhao1.liu@intel.com>
CC: <linux-kernel@vger.kernel.org>, <kvm@vger.kernel.org>,
	<pbonzini@redhat.com>, <seanjc@google.com>, Binbin Wu
	<binbin.wu@linux.intel.com>
References: <20260708210118.402005-1-chang.seok.bae@intel.com>
 <ak9/XEGJhm+sViKH@intel.com>
Content-Language: en-US
From: "Chang S. Bae" <chang.seok.bae@intel.com>
In-Reply-To: <ak9/XEGJhm+sViKH@intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR03CA0174.namprd03.prod.outlook.com
 (2603:10b6:a03:338::29) To DS0PR11MB7925.namprd11.prod.outlook.com
 (2603:10b6:8:f8::18)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7925:EE_|MW4PR11MB6838:EE_
X-MS-Office365-Filtering-Correlation-Id: 03d0240f-7c7a-4081-c9a0-08dedddf34fd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|23010399003|366016|22082099003|18002099003|4143699003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info: 92/FnmYS+gmtOJZB6Q4PG6cAjjomizFuT0xfrVUXKCol0Vl9MHkTaKJXK+xWSK7Famnf8oL7e0uMVx200jz/ofKEUXTbmjWCCdVIPrvkxeRbYwxSCwXwHOcmaFMSQJ6Pu19ku52Po7KUoCgdvEeltvYFOP2jkKk5KS4Gp28NC3GhknLf3dIq9FRPD+ztN8JSXTbGCX3VfhRuRdwWgt2Wm3bAsQ0qB62RxAjsJSV8sNsy2FRX16UGqqvImNLXOe20BQIGNpKpG6uZpb95Mdc9DdNraaMr1YKcZOrVHGmWet6W72HTur3QqXYovZ1tCUiPigeaX2whN9vnnGe/m/zukkXRopo33TTCAHTGps+4lMF8gLXIUQxvynPwCSdC63VcjaxLx/mjutJf12c54SrtmQOrKQtTdWpSf59NCt3qvD4qQDJdocb5ynVK5XrKG/dG96taENoQGDOoTfzMR3z5kLEtFGoCSKqHMEr5cBQA7kT/t4YKF3mWa0huDwnzdjtuQhYlP9KsleiQ8XpX0ufRUPfc/TQaRFpK/GzaC4hw7Da3LuYgsrsLmxePeTbfb6c4j6rhT65+QWVZCHvhERJh4RFif5nzFmsMeRmB9cBJT5JHy0zFMln3t3OCREoSQMgU35sThLuJT03PZ3upyvZD6QEPbxj/CMfK5sM36YgEBu8=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB7925.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(23010399003)(366016)(22082099003)(18002099003)(4143699003)(11063799006)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MG0wQkhBZ2RRdVVkdklVZ2J5MUpGNE1PRU5ybHY5Qi9JWFVBdFI0TVJ1aDJG?=
 =?utf-8?B?T3l6U3Z6YlYvV0tzMWtnVXUralV4ajBpQkRoQjk0WUFsYjVIZnBRL1dsdFQ3?=
 =?utf-8?B?NDhnR3l6dGpBZXJhTnBUT2pMWUJpQzZNRGsyMWVOMlRrUy9EUEdKVW8wQWJN?=
 =?utf-8?B?eUVQWjhrbGJWaUx3UGxpbVNHRjQ2QXVKVmYzNlNJaWlGS3M4MFNzTWtlR0tI?=
 =?utf-8?B?RzFRdlJKUTNVUkxXenNxTTA4QlVxWFR6WmNqUzREclVaUjlLVlRra0FNU0Ez?=
 =?utf-8?B?QWF2RWU0NTcrSTFhRG1vakpNQjVwUlkra0xCb1FRb29Ob09DVnNLVEpEVXlx?=
 =?utf-8?B?d3VJRldoMzMvQ09yQ0xqWkdodDk3VjUzQkM5YkcxYnh5SEZBYTgxTEhtV0U0?=
 =?utf-8?B?dmV4ZkVMR1RIazFod2ZUek02dDJ5SmUrZDBHeERmRWQrVHp0VFAybTIyYXly?=
 =?utf-8?B?Y29telE0VTBzaVBvMlN5dDZnS3VLTlhRTlg0M25FR2Y5S00xK01VRFpkOW52?=
 =?utf-8?B?akhiL0lGaUtOekZ4Nnh5Rm5jMk9xMHp5TVQzWmx0eWZGOFNzSDhhRUlTOW42?=
 =?utf-8?B?Q0YycmxrSGFDWWZDZW84Q0hDYmhtRGRDWlliYXVQT0g1dldTNmdzcWROaWVG?=
 =?utf-8?B?OC90QUJIU0FRa3BocVljalBISXM5eTkrWUNNN1lkYTF6YkhtN3NYRWgrZ1Nh?=
 =?utf-8?B?a0ZyUHI0ckF6RmFzYlNmSW5KbjdBdlYydE9lUDd6RytTN2w3blZQWVQwdkVG?=
 =?utf-8?B?TStHV3lpSWR4dm1VNXVkeS95dXZtVm1USWJzM2p5K25Hb25sRWVFM0k5UmNY?=
 =?utf-8?B?RkJpZHdqVG9rSkdSWG90RTJXMDB5ZC9JUlgvcGFtYjQyQmk2b1JsSmdtNHZI?=
 =?utf-8?B?MFJBd1lINzUvdTlsUVRVaks1dUV6QU5ZdVVJMVQwOUl5YVpQbjFJNnpVaVdE?=
 =?utf-8?B?Y0xTNHZrK29GMWlDSDBiZm02dWVabFZhMy9NaHluUTNCQ212L0dMSDNTaXpI?=
 =?utf-8?B?dmdiUEFtSnRZQVZPcW5zbzZXTFB4ZEgvcUJzTjZqWThSRkRCbUtPcHo2YktF?=
 =?utf-8?B?WGVRV0ZuY3Y3QWdhOHVMbCtWanA4d0ZLSmVmNjArNHJyUFgvbW1JS0hmMDlo?=
 =?utf-8?B?VHQwVjdsd29ST3lnYjFCdk5ST1IzK0VCb21PNU9GTVVMd2U4NzFtcmtpSHF4?=
 =?utf-8?B?ZEZSblc1VklvM2gzd1ptblo2ZXRtU0NpUWIzeWpTTVVRMTJneExiU1lKZGJH?=
 =?utf-8?B?azFSaTRtVEg2M1cyMUdJYjF4a0c3STMzU2w1eHlNaHd3VXpHRS9LcTd5NXkr?=
 =?utf-8?B?dUVFVjYxdkdKQ0hDcUF2YzBxUlJXQXJEOWMzRmd6Z1U2ZXdWMGY2bnZQKzgv?=
 =?utf-8?B?SFJ4VEc4dWlNMURST2NrcXBUS3JWOHNIK3psb0Z2MTNocTRNeWpHQXRJZXhp?=
 =?utf-8?B?MjV1Ny9VNVNoSEZqTm1SY0NQY1Fybkl6KzU1ZnlETVQxK1pubExLU1BGVWV1?=
 =?utf-8?B?NVBiOHhqRDdpb09JYkI4Mzh6SGFHMHZvU1R2UjduUEZMckE1SmYvdHh3aGRz?=
 =?utf-8?B?aU5oYUdHcUlMdml6Vk92S0lBem4zb2FiZi9IRTNUaXJlZTdoMk9CazZtSXNk?=
 =?utf-8?B?KzJXTnlLQUt5VisydTlGY21HbFY5cUxSN203bTk5dG9iQjFDRGxXeWtYeFVE?=
 =?utf-8?B?UDdXN0lld0pycFRCMUk5M2xqYzgreHRGbGFTb3IyVTVPZk5rWDdNWHBmQU1T?=
 =?utf-8?B?ZTF3M21ScVZBeTBxVVhtOElqS0k3MVJNTkczV3NZRDBQci9ZVVMzTTd6U2cx?=
 =?utf-8?B?eXo0czQxV29mbzZNcUE0bVhXQS94MHluV1gwaXhjU05DWE1WVGwzSWptWVda?=
 =?utf-8?B?b05MTU14NzdxYlY0V1lhSUZGRllLMXZnQUd0eG1zWFFmWUNhdjRXNmVlOXRC?=
 =?utf-8?B?dTl1QWlCUHptZEtybzk5ck1JU2krMUpZVFUwRDdvREd1K0xEVFJaS3U2dE5Z?=
 =?utf-8?B?bnUvVVF6QnVLL0pEN1ZHdXRiTUNPYzJNeGQyNHczTWM0eUt0bUhPLzNmQXd5?=
 =?utf-8?B?bStlQ2YvTGxsMzBoNTJIZE1qUzd6OW14cG54Y2tFTHRDVGs0N2F4dUp4WWtB?=
 =?utf-8?B?ZmFEZmV0V3RhbTRXT2lybUErdXl0Wis0YXVJUE01SnZKdUJtV0RidnBTMU5l?=
 =?utf-8?B?NGpqdWh3RkVXemhaUjFxZkpGWDBSTXVyL01ZMXR5TTNFYUxQcUhtMHZDM2xY?=
 =?utf-8?B?T1BsYmQ5M0dCRmJHc2tSbW9vSXNXYk0yYVJGTlQvaVpGQXI0NmoyZWhpWnA5?=
 =?utf-8?B?ZmZ0L3crN1FpS1gyOGk4TXZQeFJ1dm5teE1KMDVaWFY2R2RvbFZaQT09?=
X-Exchange-RoutingPolicyChecked: qnCn483HIQ2U4DrA+9b0Xi2E0FBD0BE7iQx06aUiu8aiz4i8xXind0UMWYe5Kqn59Zonsf1hAFdpWBudcgEzebkaAY+CHKKC1aLW9913HsteEaFXAP83AmhAzu+hEWRjHxRrRcwxiSsTbfcKc5taBhhFL9ufmJcSpOPEsBUm1i/9Ix+WAcDt6u64LIX8lx8OI2jI2IOKpUPMug9eI4QhjjUxhprprAyC3gHgZuEWUifXP+awJSfhErn8r8wC9rr77IhiwzJYwHpkPGkX3H2k+mR+Z8WWD235e69jj7W4uKeuDeybkCM8/hY1W07iEuKIs+dlG7fzhkgJkCsmu2hqwA==
X-MS-Exchange-CrossTenant-Network-Message-Id: 03d0240f-7c7a-4081-c9a0-08dedddf34fd
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7925.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jul 2026 17:26:27.2089
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: okZSPE4RiyhWCV1eRv5+aNbsUjQf8N/tpODWqQAbqYT1eA5118RfvUmannQNCXHHjEqDjed8dcqN99WwsS9gcp15NHsMxYyCKmoo1ljUhQk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR11MB6838
X-OriginatorOrg: intel.com

On 7/9/2026 4:00 AM, Zhao Liu wrote:
> 
> Reviewed-by: Zhao Liu <zhao1.liu@intel.com>

Thanks!
