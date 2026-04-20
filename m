Received: from BL2PR02CU003.outbound.protection.outlook.com (mail-eastusazon11011065.outbound.protection.outlook.com [52.101.52.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53B083C8731;
	Mon, 20 Apr 2026 19:38:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.52.65
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776713940; cv=fail; b=t1Iz+EYMH+vZJ5GAhZ6PLjaHRrOy73EkH3JQJDF8q81fFJj9pg8gN4w6oe64r6GbOsfgdrOtVR50GmDhnPMa66KR0SXKtOTrnCtr6SRv1FrsC75cXL4Pdc7vkMwFt2s3F1EmlDZPo9ZAFfjhpHwpi3KKsOm+Dw7GpF0gtYiDohY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776713940; c=relaxed/simple;
	bh=3lHt2yMkcCpIA87gu/4YfpwCCCI+/Y8Eo555JeD49Mk=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=d1PfofJUv9LgRbKNk50R9I0ngc1DBpF7We4GhfVsqi8yQvDdCBwzspqOKcaGWXHLeVEfUYs3SntRtOEkg1tvZ2xuBbdIb9TkXgkKng1lWPBuDGgD0WwAsEb4mav4rfEvmqC5bXggsv6T/zVsGVKKOsijWgBIPhp/XA7ASavs+yA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=k35Mf9Xg; arc=fail smtp.client-ip=52.101.52.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="k35Mf9Xg"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dOzfRUuvp0ImqFDFhg2JS5jxSR4nY4ylqk3bbtqmJgTU49tNY2KO1EhE2AzyETQ6oe6J173qF132qiTUHaLUu919EK3vHHORG6Sq8a7DIJB1cG90YsF40cYIlsehb2dr8NW0n6h7BmxmmTMDUijeOm7e/5keGW2hywPj9EdyJjYbUstwI7eGIoFVhR/ceKyXg/ItcP0UN/IiOqBmi051Nb/c6JD2NZr0EmR/CyM3P3MhjYccW/LfzQtGhyI6XPZzzJkSDcDRGlASgZsimhnrdBT6n7AlFO2uufM1RQpqjqVE7zGlvSaGNwvE4pfHtFxgwXsAvqaW7gZnBKrP0TJ/Kg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7EY+1g2Q7Y5dABVUGu/zq4GJgI6zWC0igYPc8MDL4p8=;
 b=MFG+uHCHKUPv+O/1nUxx+llBbdB+++a6MPVeD753pjEqZ9j0dm/Eu0zWYedkpR8B6RwZR1qp7MisaE0CGiWhH7PY7MVPP6eOJDOW0pMfpsUTFr5EeAd65Uhbv/6q5nCs+ZHiJNDbfsceGRwtE/pc685b1CU0NsHV3DMBSLTRyibzPeu7+vecYh/9Rm9D1yrPzQ/RxTwI8DW6c0fr3/dyeTXitIE8nrfaVx50NVkKLB1Rw3MxjUZX7RPCoYDkXSVclHZM+w/nTMTG3cwlSmug9qy6VtDK3ASHo1WYLxaNuyQz9tptwYJb9l9/NPFwQaiaYhb45sJP7GsgMsdkve/e8A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7EY+1g2Q7Y5dABVUGu/zq4GJgI6zWC0igYPc8MDL4p8=;
 b=k35Mf9XgwKbTCBNFNx0g+FXfMe0ihW/y2VZHYzuorO5JvnZ/+r4I+7jbUeHesVNdpbPGw+GrBVMYkl81C8bIGeUaYXL42dlNE6nZDUEhT3kG9Kim4wY00lhmXYCxgrCUuFI05VluH++A9RZJTnzBMI23IAO6rcLuI5hY4eMqSqw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS5PPFCBA542BC8.namprd12.prod.outlook.com
 (2603:10b6:f:fc02::1c9) by MN2PR12MB4390.namprd12.prod.outlook.com
 (2603:10b6:208:26e::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9818.20; Mon, 20 Apr
 2026 19:38:46 +0000
Received: from DS5PPFCBA542BC8.namprd12.prod.outlook.com
 ([fe80::def5:d9f4:18de:b755]) by DS5PPFCBA542BC8.namprd12.prod.outlook.com
 ([fe80::def5:d9f4:18de:b755%3]) with mapi id 15.20.9818.017; Mon, 20 Apr 2026
 19:38:44 +0000
Message-ID: <39e0c786-cc35-4555-bfb9-ff7cd758c423@amd.com>
Date: Mon, 20 Apr 2026 14:38:41 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 00/16] fs,x86/resctrl: Add kernel-mode (e.g., PLZA)
 support to the resctrl subsystem
To: Reinette Chatre <reinette.chatre@intel.com>, "Moger, Babu"
 <bmoger@amd.com>, "corbet@lwn.net" <corbet@lwn.net>,
 "tony.luck@intel.com" <tony.luck@intel.com>,
 "Dave.Martin@arm.com" <Dave.Martin@arm.com>,
 "james.morse@arm.com" <james.morse@arm.com>,
 "tglx@kernel.org" <tglx@kernel.org>, "mingo@redhat.com" <mingo@redhat.com>,
 "bp@alien8.de" <bp@alien8.de>,
 "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>
Cc: "skhan@linuxfoundation.org" <skhan@linuxfoundation.org>,
 "x86@kernel.org" <x86@kernel.org>, "hpa@zytor.com" <hpa@zytor.com>,
 "peterz@infradead.org" <peterz@infradead.org>,
 "juri.lelli@redhat.com" <juri.lelli@redhat.com>,
 "vincent.guittot@linaro.org" <vincent.guittot@linaro.org>,
 "dietmar.eggemann@arm.com" <dietmar.eggemann@arm.com>,
 "rostedt@goodmis.org" <rostedt@goodmis.org>,
 "bsegall@google.com" <bsegall@google.com>, "mgorman@suse.de"
 <mgorman@suse.de>, "vschneid@redhat.com" <vschneid@redhat.com>,
 "kas@kernel.org" <kas@kernel.org>,
 "rick.p.edgecombe@intel.com" <rick.p.edgecombe@intel.com>,
 "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
 "pmladek@suse.com" <pmladek@suse.com>,
 "rdunlap@infradead.org" <rdunlap@infradead.org>,
 "dapeng1.mi@linux.intel.com" <dapeng1.mi@linux.intel.com>,
 "kees@kernel.org" <kees@kernel.org>, "elver@google.com" <elver@google.com>,
 "paulmck@kernel.org" <paulmck@kernel.org>,
 "lirongqing@baidu.com" <lirongqing@baidu.com>,
 "safinaskar@gmail.com" <safinaskar@gmail.com>,
 "fvdl@google.com" <fvdl@google.com>, "seanjc@google.com"
 <seanjc@google.com>,
 "pawan.kumar.gupta@linux.intel.com" <pawan.kumar.gupta@linux.intel.com>,
 "xin@zytor.com" <xin@zytor.com>, "tiala@microsoft.com"
 <tiala@microsoft.com>, "chang.seok.bae@intel.com"
 <chang.seok.bae@intel.com>, "Lendacky, Thomas" <Thomas.Lendacky@amd.com>,
 "elena.reshetova@intel.com" <elena.reshetova@intel.com>,
 "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linux-coco@lists.linux.dev" <linux-coco@lists.linux.dev>,
 "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
 "eranian@google.com" <eranian@google.com>,
 "peternewman@google.com" <peternewman@google.com>
References: <cover.1773347820.git.babu.moger@amd.com>
 <14a8ad0a-e842-4268-871a-0762f1169e03@intel.com>
 <47c0db32-d0e0-4c53-90bd-b74863d233dc@amd.com>
 <88eebfac-5286-4788-b244-911c659c0439@intel.com>
 <30deeb5b-d2ec-4f85-aa4f-c21400df3486@amd.com>
 <83ae0c18-5c5e-4b52-901d-4126fe7c141b@intel.com>
 <5a740f47-d3f3-45af-9d8c-ebcf3dd89c0d@amd.com>
 <3305c18e-9e50-4df0-b9f1-c61028628967@intel.com>
 <c6f574b7-fe5f-49ae-9865-0e4dbb2f9803@amd.com>
 <efc269f8-bf98-4f12-8d76-1fee564be84c@intel.com>
 <0ae2b267-4527-4251-9136-6afdc3fc97a5@amd.com>
 <72297351-2954-4318-81b6-7de409e5552c@intel.com>
 <20aaacfb-9601-4343-a5d5-f3df6152155b@amd.com>
 <43880b7b-b390-4e7f-8c2a-46cde9e3b051@intel.com>
 <bb9f62f1-0c79-4d29-9866-c39d08c3a774@amd.com>
 <5a273b0f-8225-4e9e-924e-884183734659@intel.com>
 <73c46024-4cf2-4f03-9268-d4378825fa87@amd.com>
 <973067bf-6e6c-446a-a81a-713840d701a9@intel.com>
 <90f4a692-1c27-4967-bf12-ec3cb597681d@amd.com>
 <68a551ea-d9f0-436a-9bef-e35fd027bb95@intel.com>
Content-Language: en-US
From: Babu Moger <babu.moger@amd.com>
In-Reply-To: <68a551ea-d9f0-436a-9bef-e35fd027bb95@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: DM6PR02CA0143.namprd02.prod.outlook.com
 (2603:10b6:5:332::10) To DS5PPFCBA542BC8.namprd12.prod.outlook.com
 (2603:10b6:f:fc02::1c9)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS5PPFCBA542BC8:EE_|MN2PR12MB4390:EE_
X-MS-Office365-Filtering-Correlation-Id: 47793191-cc8f-41b0-8e89-08de9f146f17
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|7416014|921020|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	Dd6n6uQTznh1E7IM/WhZHIusJOBil9uQ9+xgAIIyPs2/7SIcLYIBaNtb1Jd0EL2lYTuUB4upNPRhdB5v7FpKmbGEnyf3sYtQlA5rdKFCPS2zPGaN/JLHoKUPLLkuzoxiD0x+V2kRzhDxF3zpX3ccVdW7kyBF0TT3R+4tHWNeCYje1I2EW6APLjMWt1OqM0xbivAtFfFSOil1JzEoicCA0Buhy47YwD5eX06a/2n4RAmAxFMvrsBCLc8rjfZTa9UI4ezMbDLafEewG78Derm4Vt2Z8jNiga/WfC/vryqShi4XmHx0YPamjhDSUHa9rXq5K0uKMd07S8NRDBD71jUfya76QziSFe7/UiUhxBWIZSfyTdAspkjme8glhU0WrhZMNSr4S3btyRLNGB7wu3ErDKc9NrK+KcobpTlPyf5dFdhaRx4j6B/u3AyrGX9PIoZH5nHxeLyBr2rHphDGoBpyEgyadfVoUUE5IBW4HN7R4D0DY0qx1FoR+OlbGsWOlIS0PNPYNkJIoAsJsRzCP6Ryv54rhPgyFRc0qA221mHX4NAcgaWuqSl+8x986O/4KCK4kbnlFx0McmODwPvmW7z5vuPfm7PXJwZB/vGbSHVFYFcS5y8i5ZjiBmKG6ofiEOzH2OK+1W7U9Ilyfxvv10g5BBm97UYGvqrFB83/UpihUTq3xUyxnh7P/BxjuewWyAgfTdVrAKkGo6iYRozXqoC43vl1BLlgpeb0H6/L/ASYBF8pGhe5Gxcc2UPe5o7UmzfY0us5SbleQ5G6z9d7GjlwOg==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS5PPFCBA542BC8.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(921020)(56012099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?UkdZODlkbnU2VTJITk1QZER6K2ZzbmFoeUJxL0xFMk44aEJGbStNeVJlWTZz?=
 =?utf-8?B?N2ZxbHowT1JBZnVtYytiOVNvajlrMlV5eFRNbUdrS1VHTEZZRmlEZkNZQzdY?=
 =?utf-8?B?L0E2dklhV0EwVzd6M2VocEx3NUNNbjZGOHZRbTBJL2t2Y1hEdU5YSUJER0JN?=
 =?utf-8?B?Q2NscXFVRUV3TzFacldQYVdXSGRPZlhnbG1YKzMvaVJzV0Mrd29pQjQwaS8w?=
 =?utf-8?B?VXRvWVluWU1LMDhna093WlNHWnZHZjNDVEZWMThTMm1uS1ltVVM4OXhZb3Zz?=
 =?utf-8?B?QUhPUVNJd3V2blB0RUh5SUJXcUFGd0dXVWNsTG5DUlRlWWI4WGplTU1vNFpi?=
 =?utf-8?B?Szk1SzJ4QlRXazlPQjN6TE9JN0ErblkwaU14M2ozSXAzc0dVWnB0Y3RNYUJy?=
 =?utf-8?B?ZG93WlE5bGVVMUVFcGFLcllCQzZxN3pENzQvcU5hU1BpaXMrR2ZxYzladWdl?=
 =?utf-8?B?Z1BVK01MVWN0MlYzK3NqcWc1M25TdTdIb3ZabDFFaFFjeHBCTFBiaHFSVGEy?=
 =?utf-8?B?VEZGNytPcGpXVDBza2lmZm5zQTE2dEdkL01od2hIdU1iTXVHdnozd1NBMHp3?=
 =?utf-8?B?cDhCa205WDcrZDBONUxwZUYrK2hXYkRvK05mVWY2VkxNbE83WnlQZXZkTUgv?=
 =?utf-8?B?UmVYUDJlVXQ0YXJObzFzZ3hzWG0wRmlmQWVmZUtuYXpoRGhrdFc5VzRJSWZa?=
 =?utf-8?B?YXRhK1F5V01rUjNRZERHZnB5amVqaU5iUUNkbkpnOUFlUUVkYWpIVkgvNHVI?=
 =?utf-8?B?Ny9LV0drN2JYWWhIcEk5VEF4S0tNY1czQVZNOGs1K2w4TSt2eXRISlFBSTlM?=
 =?utf-8?B?NXVLbDhqYmR4N3ZUUkVKMTJodTh3S0hDNGZic1MyK25wRDYrd2RHVmVCc1dz?=
 =?utf-8?B?cFF1UTB3Z1ZZWXRZZGM0b1crYWNlcHp2UzBiN3l6eFp5YzZlSEJvamJ6ZDM3?=
 =?utf-8?B?a3pkUVBBODVKdDdZWkRKZm03c05sckZlcEJLaUxoRGl2L0VCVXBiYUI0anRF?=
 =?utf-8?B?K0N1UWdJTCtuT053NExOcVJSNnc2cnN4OG5EMjBQdWlVQW10ZFRrdE9ZM0JY?=
 =?utf-8?B?OVY1NFRGLyt4OEJzc0k4SEc0RTkrelRxQW1laTJkRHhsVUlla1I3ZDgzWXN1?=
 =?utf-8?B?RjdvK0hQZW1XbE4rT3libVdJT2ZuYUtjL2NtbEFPUlh6SE9VbEVvbEFsNEdM?=
 =?utf-8?B?bDVGVVozcnBNcXppTlR4NUVrT0ZjQ0NsSlZuYmFDZ2lTV29Yby9CMno2bjBU?=
 =?utf-8?B?bjBIWGEzd1NjNkVxaFArMWlkczlkMjAvYnVmYUlOcEZJNEFpa2FtdUdvY3FW?=
 =?utf-8?B?K29xc0xCTzBJM1RDTllHSmJjaFFLVmc2RjM3MFczclZRU2tmZk1hbThTME9U?=
 =?utf-8?B?RGw0a1pPTGxPcGtTNEQ3LytrZ2xQM29vVXQ0RjJ5SC9vMEx2VEdSRDQzVGRt?=
 =?utf-8?B?THBNd2g4ZkVWbTZMZ29SN1BXT0creEVxNGg5TE1hOEhhNGRaV3lON2ZOd2dB?=
 =?utf-8?B?UURKQkFSbTdYQ0VMV0MydUdPZk1id01QQ2wybnBWOXlPUmQza1pkSWRYNG1t?=
 =?utf-8?B?TWsyN2cwbHJoaFREaHBwcnBPdU5DV2JIc0ZBUTVJV210V3JlZGFVUzFmeEo5?=
 =?utf-8?B?ODhIVHdhUXlyWFcrRC9Lb2EzdzBISmJNV3ZMN1Q5UVZOemVsK2NMbFZtV0Fq?=
 =?utf-8?B?Y1ZYcUpoQ1lPZ0pXYVRRcmhBanFRaHRLVW5sUUdIOWdqSkZ4N2xOSGVYSUdy?=
 =?utf-8?B?MlRtL1dubE9GVENWTUtDbXBNOVZlTnNxMDRoVllzZGR5S29qQnRHc1NiaEZP?=
 =?utf-8?B?R0hGZkk5QXFFMjNwcDhsNTNobWRCa1FWVTMzSVduWlRGZE9ycTBqdysrMVp0?=
 =?utf-8?B?MTlzaXBFU1JNZVA3ZmswM05lQURIS0hQRzBydGhiTm1aa2JpSXEzZ2ViaUJ1?=
 =?utf-8?B?NWw2Sis2TVFJWm1BdW82TGQwSGl4SlcyV3lYVXRiWnF0LzQ2YzBScVY4Vmth?=
 =?utf-8?B?WnpSdnZpK0U5QmR0Y1hrVXB3b05tY3BXbjV4cGFLUnViakFhTWZuN1lkRzJ3?=
 =?utf-8?B?UGd3L1ZrZTFZNHQ2YUFhRnBHdkxkc0JTUWtsekhDU3lJSlNkRUw3aENiYy9H?=
 =?utf-8?B?VFYzcTBURkNWT1R1b2FDaVhhNmZlOHNCaHVMZ05uMFBjaU9xYXQzeXJSODEx?=
 =?utf-8?B?cWVwcHpYSk9ZRThackZwY00yUnhGclJNSXVQMEt1UVVCb3Z6SHRKajlHMUlB?=
 =?utf-8?B?VDIzY2ZkekZsOFE0cmgrSHBLSkFFSnlSdS9YUEc2NmdZVEJ5TDAvMGNZelBU?=
 =?utf-8?Q?5g/PmipY2JT8794i6w?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 47793191-cc8f-41b0-8e89-08de9f146f17
X-MS-Exchange-CrossTenant-AuthSource: DS5PPFCBA542BC8.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Apr 2026 19:38:44.6801
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yNUpjnui+Q+ZTX9zuP94cpMDSozTOyd7PcJt0JmRCyv5dkOU4Dw1mU/jCB7WqTEL
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4390

Hi Reinette,

On 4/9/26 22:41, Reinette Chatre wrote:
> Hi Babu,
> 
> On 4/9/26 4:42 PM, Moger, Babu wrote:
>> Hi Reinette,
>>
>> On 4/9/2026 3:50 PM, Reinette Chatre wrote:
>>> Hi Babu,
>>>
>>> On 4/9/26 11:05 AM, Moger, Babu wrote:
>>>> On 4/9/2026 12:26 PM, Reinette Chatre wrote:
>>>>> On 4/9/26 10:19 AM, Moger, Babu wrote:
>>>>>> On 4/8/2026 6:41 PM, Reinette Chatre wrote:
>>>>>
>>>>>>> When the user switches to either "global_assign_ctrl_inherit_mon_per_cpu" or
>>>>>>> 'global_assign_ctrl_assign_mon_per_cpu" then "info/kernel_mode_assignment" is created
>>>>>>> (or made visible to user space) and is expected to point to default group.
>>>>>>> User can change the group using "info/kernel_mode_assignment" at this point.
>>>>>>>
>>>>>>> If the current scenario is below ...
>>>>>>>        # cat info/kernel_mode
>>>>>>>        [global_assign_ctrl_inherit_mon_per_cpu]
>>>>>>>        inherit_ctrl_and_mon
>>>>>>>        global_assign_ctrl_assign_mon_per_cpu
>>>>>>>
>>>>>>> ... then "info/kernel_mode_assignment" will exist but what it should contain if
>>>>>>> user switches mode at this point may be up for discussion.
>>>>>>>
>>>>>>> option 1)
>>>>>>> When user switches mode to "global_assign_ctrl_assign_mon_per_cpu" then
>>>>>>> the resource group in "info/kernel_mode_assignment" is reset to the
>>>>>>> default group and all CPUs PLZA state reset to match. The kernel_mode_cpus
>>>>>>> and kernel_mode_cpuslist files become visible in default resource group
>>>>>>> and they contain "all online CPUs".
>>>>>>>
>>>>>>> option 2)
>>>>>>> When user switches mode to "global_assign_ctrl_assign_mon_per_cpu" then
>>>>>>> the resource group in "info/kernel_mode_assignment" is kept and all
>>>>>>> CPUs PLZA state set to match it while also keeping the current
>>>>>>> values of that resource group's kernel_mode_cpus and kernel_mode_cpuslist
>>>>>>> files.
>>>>>>>
>>>>>>> I am leaning towards "option 1" to keep it consistent with a switch from
>>>>>>> "inherit_ctrl_and_mon" and being deterministic about how a mode is started with
>>>>>>
>>>>>> Yes. The "option 1" seems appropriate.
>>>>>>
>>>>>>> a clean slate. What are your thoughts? What would be use case where a user would
>>>>>>> want to switch between "global_assign_ctrl_inherit_mon_per_cpu" and
>>>>>>> "global_assign_ctrl_assign_mon_per_cpu" to just switch rmid_en on and off?
>>>>>>
>>>>>>
>>>>>> This is a bit tricky.
>>>>>>
>>>>>> Currently, our requirement is to have a CTRL_MON group for
>>>>>> global_assign_ctrl_inherit_mon_per_cpu. In this scenario, we use the
>>>>>> group’s CLOSID for PLZA configuration, and RMID is not used (rmid_en
>>>>>> = 0) when setting up PLZA.
>>>>>>
>>>>>> Our requirement is also to have a CTRL_MON/MON group for
>>>>>> global_assign_ctrl_assign_mon_per_cpu. In this case as well, the
>>>>>> group’s CLOSID and RMID (rmid_en = 1)  both are used configure PLZA.
>>>>>
>>>>> ah, right. Good catch.
>>>>>
>>>>>>
>>>>>> Actually, we should not allow these changes from
>>>>>> global_assign_ctrl_inherit_mon_per_cpu  to
>>>>>> global_assign_ctrl_assign_mon_per_cpu or visa versa.
>>>>>
>>>>> resctrl could allow it but as part of the switch it resets the "kernel mode group" to
>>>>> be the default group every time? This would be the "option 1" above.
>>>>
>>>> Other options.
>>>>
>>>> Allow global_assign_ctrl_inherit_mon_per_cpu -> global_assign_ctrl_assign_mon_per_cpu. As part of the switch, reset the "kernel mode group" to the default group.
>>>>
>>>> Allow global_assign_ctrl_assign_mon_per_cpu -> global_assign_ctrl_inherit_mon_per_cpu. In this case switch
>>>> to CTRL_MON/MON -> CTRL_MON.
>>>>
>>>
>>> ok. Could you please return the courtesy of providing feedback on the
>>> suggestion you are responding to and also include the motivation why your
>>> suggestion is the better option?
>>
>> Yea. Sure.
>>
>> We need to allow the switch between the modes. Otherwise only way to reset is to remount the resctrl filesystem. That is not a good option.
>>
>> Allow global_assign_ctrl_inherit_mon_per_cpu -> global_assign_ctrl_assign_mon_per_cpu. As part of the switch, reset the "kernel mode group" to the default group.
>>
>> This option is same as you suggested.
>>
>> Allow global_assign_ctrl_assign_mon_per_cpu -> global_assign_ctrl_inherit_mon_per_cpu. In this case switch
>> to CTRL_MON/MON -> CTRL_MON. This option basically disables monitor (rmid_en=0). It is less disruptive. Move is between child group to parent group.
> 
> ok. I am concerned that this creates an inconsistent interface. Specifically, sometimes
> when switching the mode the kernel group will reset and sometimes it won't. This inconsistency
> may be more apparent when writing the user documentation as part of this work. If you are
> able to clearly explain how this resctrl fs interface behaves (this cannot be about PLZA
> internals as above) then this could work.
Started working on these changes. May be it is better to discuss this 
before to avoid one more revision.


The current mode change behavior is very restrictive.

For example:

# cat info/kernel_mode
       inherit_ctrl_and_mon
       [global_assign_ctrl_assign_mon_per_cpu]
        global_assign_ctrl_inherit_mon_per_cpu


# cat info/kernel_mode_assignment
      ctrl1/mon1/

In this state, we cannot change kernel_mode to inherit_ctrl_and_mon. The 
expectation, however, is that inherit_ctrl_and_mon should always map to 
the RDTCTRL_GROUP.


A similar issue exists when switching between
global_assign_ctrl_inherit_mon_per_cpu and
global_assign_ctrl_assign_mon_per_cpu (in either direction).

The same problem also occurs when modifying the kernel_mode_assignment 
group. If the current group is an RDTMON_GROUP, we can't assign another
RDTCTRL_GROUP without changing both mode and group together.


To address this, I propose changing the mode and the group together.

System boots up with following defaults:

# cat info/kernel_mode
       [inherit_ctrl_and_mon]
       global_assign_ctrl_assign_mon_per_cpu
       global_assign_ctrl_inherit_mon_per_cpu

# cat info/kernel_mode_assignment
      inherit_ctrl_and_mon://


# echo "global_assign_ctrl_assign_mon_per_cpu:ctrl1/mon1/" > 
info/kernel_mode_assignment

# cat info/kernel_mode_assignment
      global_assign_ctrl_assign_mon_per_cpu:ctrl1/mon1/

# cat info/kernel_mode
       inherit_ctrl_and_mon
       [global_assign_ctrl_assign_mon_per_cpu]
       global_assign_ctrl_inherit_mon_per_cpu


# echo "inherit_ctrl_and_mon://" > info/kernel_mode_assignment

# cat info/kernel_mode_assignment
    inherit_ctrl_and_mon://


# cat info/kernel_mode
       [inherit_ctrl_and_mon]
       global_assign_ctrl_assign_mon_per_cpu
        global_assign_ctrl_inherit_mon_per_cpu


# echo "global_assign_ctrl_inherit_mon_per_cpu:ctrl1//"

# cat info/kernel_mode_assignment
    global_assign_ctrl_inherit_mon_per_cpu:ctrl1//

# cat info/kernel_mode
       inherit_ctrl_and_mon
       global_assign_ctrl_assign_mon_per_cpu
       [global_assign_ctrl_inherit_mon_per_cpu]


The interface "info/kernel_mode" becomes read-only,

The mode change and group change will be done with 
"info/kernel_mode_assignment"


I’m also planning to rename the kernel modes as follows:

inherit_ctrl_and_mon → shared_alloc_mon
global_assign_ctrl_inherit_mon_per_cpu → global_alloc_per_cpu
global_assign_ctrl_assign_mon_per_cpu → global_alloc_mon_per_cpu

What do you think?

Thanks
Babu

