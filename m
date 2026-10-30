Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.remote-ip=198.175.65.16
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=fail;
	t=1793393639;
	b=2JNlbRDbDEa9tNLa0LpMtr7ZOXhHXErWMqR/0b1aNhJxtYxJnejNqHAoWs6xlWl0Kt0+
	 +719Wr4WhVs4q6KBqnO2OlNuRErvoPj4ufjBUv1lW1hJtDxUfqwIOxhKd1VoxBvcduwzg
	 nNUHnzp79GkDtqkOnN2KdFDJJPWEtbO495OIiUi9kO5TinXjPaoywdMeSNFwMBgaXiPnR
	 C7ZmPqW9zUC8LPD7Z+b24hVQE+kJnKuKD/7Hm+wmb0DGg7QwhMqBe8We/n7M1BJIvFaJ7
	 dvVy2rY3mNwwkf2y6mfWzi2UwXtI3cKTcWjifyMXXMRfzlkkJHET82YSXQtigmwXknw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793393639;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Received:Received:
	 Received:Received:Received:Message-ID:Date:User-Agent:From:Subject:To:
	 CC:References:Content-Language:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-ClientProxiedBy:MIME-Version:
	 X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
	 X-MS-Office365-Filtering-Correlation-Id:X-LD-Processed:
	 X-MS-Exchange-SenderADCheck:X-MS-Exchange-AntiSpam-Relay:
	 X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
	 X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-Exchange-RoutingPolicyChecked:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped:X-OriginatorOrg;
	bh=UhwtbPFZ7cFdsb1nfTQeZJyB/lwXQENWPnLo6uALBQw=;
	b=c1TY7NtYLWdWSsDB3Hrt0mklu4RUqRfbs2l5krX1XEpmD9wN+L3paPrw6fDLbRWv/fEY
	 P8ZMB9zAhCI2R92tBYupR95GbyaPQHFS7CoOQxm5nScMVfyJnV6HkRlTGKkS//N/x9OsO
	 +VHpngGbTAsVI8FGZBO07vJXhuU9nElegnWLROmBaqc0MoYoUVePpBKa7lVNDF8d0xv1Y
	 S94GdTjJLR4HBSauQ0Ey9QsknLpdlaIr5ez8dRJvFVh2cirk8atsY/sDPxUPjuVqCT40e
	 bmh5rXG7rmT2VliaryTpwgESLSWqrCDnLYrDijMOk91ODW/yo+G3xKnzHKUB0KeYmzQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=nvXb15qZ;
	arc=fail smtp.remote-ip=198.175.65.16
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A4CB606A31A;
	Fri, 30 Oct 2026 20:53:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7A4CB606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=nvXb15qZ
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1793393638; x=1824929638;
  h=message-id:date:from:subject:to:cc:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=JTTmuW0Qf5dffg49hQ0pLw7RpJfgX5pL86M6RLo4JSw=;
  b=nvXb15qZJLXxv4iLYXIEjRGed7Ooz8yDOzzYwu0tdctfw1IhacTGujaM
   yTLd4Jud6I48Is8OxQDli7bpxUlMQNjRoDC1uJx/X3vrCSxMJzCiQpdLw
   trFCGVKfCtRhqLWShPcvNyWqkP/wmBxFoBkHD/rA9BAuBEs6k/HE6RNNa
   dnGSY49FSi0h+NymIYETcoWpXhnNjB6NHtYeo2BVLfygJGdLUBt5bsLei
   LGD/lZX8DrnhyV/qSn1LvaH2z8bt+qig/Bh/IuKIpCUI+Re3O5yw4O7Ot
   jKGWVfJEYgFXR9kjvBBy4f/JsVG748cpyPh09zRDz9ZtnmuC8OfJ++sFG
   Q==;
X-CSE-ConnectionGUID: fZ3HvLsoQjyzigmBrGoEQw==
X-CSE-MsgGUID: iYAqTyc9SVmhaoEmmDhtvw==
X-IronPort-AV: E=McAfee;i="6800,10657,11951"; a="2159058"
X-IronPort-AV: E=Sophos;i="6.27,186,1787036400"; 
   d="scan'208";a="2159058"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Oct 2026 13:53:57 -0700
X-CSE-ConnectionGUID: ncecYJBeRn+soMWm7HFp8A==
X-CSE-MsgGUID: X8qQr6weShysVaHShwNJFA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,186,1787036400"; 
   d="scan'208";a="5426033"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by orviesa003.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Oct 2026 13:53:57 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Fri, 30 Oct 2026 13:53:57 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56 via Frontend Transport; Fri, 30 Oct 2026 13:53:57 -0700
Received: from CY7PR03CU001.outbound.protection.outlook.com (40.93.198.11) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Fri, 30 Oct 2026 13:53:56 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hVlXXxTf00BQjt6gMdQcKdNU5kT3eoa+sGIVtSMOcKkJ427w1U++o1Oe4Zhi0lZC9xUV9tn3Trwfd2ZOjbYB1RKh9OdAUncn117sb0qf++fZu7V3JTncuYWosFONIlNbhHuBCRcpQ2ZCbBs8CJ0MrlBytq6Gb/pEtZbnG6rspHUTw/DJonfeDpOyrRziZ1sxwiEQPZeX5SbGul4v/a0FizK/IWzALQ99QUrIY0TJ/AvaQ48XC6YO1Dz2Ukx601jd6FhmXOmHqr7LtvPVZod2olbpwQvHIHY5TIrMueCJhuv+KSWzJHFRqI2TN0OwKSsGVEbFxzrJ8/FJIsnCHoa4gw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UhwtbPFZ7cFdsb1nfTQeZJyB/lwXQENWPnLo6uALBQw=;
 b=bV+OCEdz95TRh2aiEnp+lqkoUwy/G015+QnuiiVSG0LQ7lDRUXUXsiZU8OaxMPWebQAdGaNuMe39w8nC0DvMmyXOXaco0//orqcQ1X17LZuplfdUFVwbDSGHVIBH1dC3AIxO79klyyR79xlAxazkzqirNtoF5Au6J4dZBApUkcATvM7plFafuFXIXhnmdvXa94PykMd0fzaHGx1E8MIWtabRe3hMJax4H8MCjJEjmtvuHBF/gowmXAVKbs//a4rkVD4+RnPQSWhc15p7ws/uCtBApqxNgoQEWbh1Vi7xJEqRCXskKguPo2AqTRJ2w4D9wsP+XysrJZnRWrK5gCztgA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7925.namprd11.prod.outlook.com (2603:10b6:8:f8::18) by
 SA3PR11MB7415.namprd11.prod.outlook.com (2603:10b6:806:318::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.9; Fri, 30 Oct
 2026 20:53:54 +0000
Received: from DS0PR11MB7925.namprd11.prod.outlook.com
 ([fe80::60af:89a0:65dc:9c84]) by DS0PR11MB7925.namprd11.prod.outlook.com
 ([fe80::60af:89a0:65dc:9c84%7]) with mapi id 15.21.0569.008; Fri, 30 Oct 2026
 20:53:54 +0000
Message-ID: <609c2e22-db8f-417a-93b6-c4fcafe79bc1@intel.com>
Date: Fri, 30 Oct 2026 13:53:50 -0700
User-Agent: Mozilla Thunderbird
From: "Chang S. Bae" <chang.seok.bae@intel.com>
Subject: Re: [PATCH v10 00/28] KVM: Enable FRED support with KVM VMX
To: Sohil Mehta <sohil.mehta@intel.com>, <kvm@vger.kernel.org>,
	<x86@kernel.org>
CC: Paolo Bonzini <pbonzini@redhat.com>, Sean Christopherson
	<seanjc@google.com>, Jonathan Corbet <corbet@lwn.net>, Shuah Khan
	<skhan@linuxfoundation.org>, Thomas Gleixner <tglx@kernel.org>, Ingo Molnar
	<mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, Dave Hansen
	<dave.hansen@linux.intel.com>, "H . Peter Anvin" <hpa@zytor.com>, Xin Li
	<xin@zytor.com>, Andy Lutomirski <luto@kernel.org>, Peter Zijlstra
	<peterz@infradead.org>, Andrew Cooper <andrew.cooper3@citrix.com>, "Tom
 Lendacky" <thomas.lendacky@amd.com>, Nikunj A Dadhania <nikunj@amd.com>,
	Shivansh Dhiman <shivansh.dhiman@amd.com>, David Woodhouse
	<dwmw@amazon.co.uk>, Chao Gao <chao.gao@intel.com>, Binbin Wu
	<binbin.wu@linux.intel.com>, Zhao Liu <zhao1.liu@intel.com>, Yosry Ahmed
	<yosry@kernel.org>, David Matlack <dmatlack@google.com>,
	<linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-kselftest@vger.kernel.org>
References: <20260911213659.2025974-1-sohil.mehta@intel.com>
Content-Language: en-US
In-Reply-To: <20260911213659.2025974-1-sohil.mehta@intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR13CA0124.namprd13.prod.outlook.com
 (2603:10b6:a03:2c6::9) To DS0PR11MB7925.namprd11.prod.outlook.com
 (2603:10b6:8:f8::18)
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
X-MS-TrafficTypeDiagnostic: DS0PR11MB7925:EE_|SA3PR11MB7415:EE_
X-MS-Office365-Filtering-Correlation-Id: 854653c8-cfc7-4d08-2242-08df36c7e8cc
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|7416014|376014|23010399003|1800799024|22082099003|18002099003|56012099006|11063799006|261022075727099003|10067099003|261021123027099003|261026121527099003;
X-Microsoft-Antispam-Message-Info: S/VqHvhZZGRLXrsXGSNtujntRfH4zAfTftjMoDQaIUWZKPDyu7ML0f/Vu3MB5Xn9zE1Jzo5F+1Ef7qA+XRsrDdOtj6kGf/kYEzYSIJHONEdAdxV2Tid7EE5mRuj5HvvE4qPCS3QbAHtOKU+UknXT3MNo98zT3vk4HBBym89HXRF/jEd3tjF8LzpeYUsZ3FLaR2VTgIwR2If7Wrcymhi5Y9VMFo4LRaLQYaXxDJDWQSh4hcA6CRUI+gK6inM8yQ0+DsOo1x5m6fbO+yZ4SwE+gANoFo8lkddsTOP1RXFBRahtneyu4XFJO4k8LvJtouzAx5VJp8LDbpfP++ID/xgGkPUH7rp3ekwtHqKemGmK6r4miDiz1LzLCW8Vka0gQhifCnJ3K36R5eyyAzXqUUaiYjb5D0b5s9lZNhcAQqTaQW9nG61ujF2TDGOk17GvxuQ6vvKIt/26ofuwMe/aByP7/PHPEhMM7zhaYkTPlJJU77tEb4BgQ/a9Dft6IvdWoyjbEGjNuMZILIagbeb5GYWjkMfkUDpnc8/I6SUye2i9/6VNQTPIGWqiEgnm2wBsorIKN5rMWfGbKBMWl6ixdoxyDYwFUG4MX87g7Jpetq0QnJC3BS6+A57L10zeXeBnwVRyjkUhb2bgGfe7x8Q+j8SMe+kVwenxGYz0dB/lJNksMsg=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB7925.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(23010399003)(1800799024)(22082099003)(18002099003)(56012099006)(11063799006)(261022075727099003)(10067099003)(261021123027099003)(261026121527099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cmZXMDhEL0tReENNL0dhZHNEYmY3Q3FTbGF5Z3lNdUtPbUVmMG9CczRZZ1JD?=
 =?utf-8?B?NEh6VGI1anlJTUdYK2QzaFZrUnFrWG1LZFBsY28rRGM1KzR3SVRVU3QxbUVp?=
 =?utf-8?B?N2psSGFhZGkwT2lSa05QUGtZcnZmOEdRdzFKa1dFWTVhb1lkcDEySXNIN3gx?=
 =?utf-8?B?Zk5HcGpJZFNxekJ6cUFqWitWaEVmTDRRVkEvODRKdlNlVmtDYmlNT2p1akdH?=
 =?utf-8?B?cE12ZEdGSFFhQXdzWE1NQmhDWUxVLzcxUFE0RW1rNlVKcWlSak1tSlhtM0g3?=
 =?utf-8?B?TTIzczluVHdkK0ppbDZkVWUwbG5Yb2t6OTdCVEJtcTJqZFV0ck9saXI3dHVs?=
 =?utf-8?B?WkdXbUoxRXFRUnQ1MVkvbU90NDUza1lrY3dPcmdTb1FhUHpvNjB5TlNBNjRp?=
 =?utf-8?B?aXlUeHNsOVp3YUhlS2dnS2lsVUZSdCsrTTdieVVDc3dUTWFvUFoxZy9uOUZM?=
 =?utf-8?B?N1BFQzd4Y2dVcEVjMkFxZWRBS0RqOHhzc09kaFNxUHcvUTVzU0V0bnlSVjZw?=
 =?utf-8?B?MmU3U2FodU16QlBzdlJiQWF5NlcrcDZtVVBvdGdMWEZpM3p5VElQMm5Ka1hw?=
 =?utf-8?B?WGQrcCtjck1BZHpLK2R4VXhEbkEzSzBYSGszMnB5M1FueFM0UEYrMmFvRjVx?=
 =?utf-8?B?ZzgzYnpkZVVQVFdYWGx1QXIyVlhvWDhoMTRkcGNZQ3JsNC96SEZ3eUljUWRI?=
 =?utf-8?B?SmRmSk1Pc25haGRtZFhkYi9GQmRJZlk4QzhQSnNnZU94WnRHdTlZTFI4dVVJ?=
 =?utf-8?B?dVdIcTl6bktHTnVoNHhQYkhLNG1wenRaMTg0UVdROHlWQVZxU2Q0ejVlRE93?=
 =?utf-8?B?ZXM2OWVpUElveUpuY3F5RnFBRFdCamF3OFBHanltVEREUUpDUW5HblJvbVN0?=
 =?utf-8?B?VTBuUEJNVnNSc2w4Wm1JcStjQ1R5NG5JVGoxUk40bWVNYWtwTUh5dTNreTNH?=
 =?utf-8?B?OXNYdTkvVDkrTmttV1FFMzlJaVlmSldtaU1Tb2xYS0dNS1FEZUZOT05qSWpq?=
 =?utf-8?B?VjB2NFdXY2ZJbWM0NHdQTlZQQ3BnNG44UVBWY2psdTd5S2plM2VvS1F3dlBy?=
 =?utf-8?B?UHFocE1rSUR5T1YyLzQyWWxPVWdwMjlhdERvd00zKzFNaE94eDFhT0gvQUdr?=
 =?utf-8?B?V3l4SEtENTdXSmcyQjVqU2ZFNzZWZEV6U1c4RC9icG8vZXgzeFdjUUFrSVJa?=
 =?utf-8?B?UXdCbmNkWHpHdHR6b0lKU1IrbUJvWHZkakN4cUtJZkZvNE4xWkhMWHUzUjdM?=
 =?utf-8?B?SkE3c1NReXo3M2JaZkdjUHlHaDNQMkM0cE5OSUt3OWE5S3l0eHI1NVF2S1oz?=
 =?utf-8?B?blQ3NHdlNE1YQ2VFSE9SNzdURzFjNkpvMENvZHpQQWVaWWJoM3NsaWdmMUZ4?=
 =?utf-8?B?REZBbGxjOTFpdHFCaDl0QTNiSWprSmkwUEkrbFp4MTVxZ2c4ekpqek5MQ2Vs?=
 =?utf-8?B?b29tVzdtUitNbHM0bU05RHl1elhJek43eWYwQzZjSGhIWmY1a2lvVjh1eG00?=
 =?utf-8?B?dlp6S2txNHdtWC9xZlJhZkxCZjhUUTY3WjI4eEswZ3l0NzdpVk55aGx2cWdW?=
 =?utf-8?B?bjM2THJ0cmFrb2lPNjMzeE9RbXJaT2s4VmRDVFlLK245YlhVV0h3dHVGcXgw?=
 =?utf-8?B?eTNvMXExYkFyU0kzNG1hNzgzNko3UjJ6SjFwbDhIdTRrOWV4S09tdm5FR2Vw?=
 =?utf-8?B?alBNSUJ0b1dSRkJHRnVrRVdiWFlrY3JPelpvZHVZeXBRM3BOOWVkdm1GODM0?=
 =?utf-8?B?dzlnbGFISGsxOURpYmhTY1hIclJoOGUxcndNUE1IRUhkMXR1NUJrMVRaeXNu?=
 =?utf-8?B?MzBUMjBGWnRtOGJGUkx6TW50QmZIMGhkbXpCYXdNL3c1YStuVm1IeSthMlFs?=
 =?utf-8?B?UmRkUmdrVUV2VVdPUzA1bHNpbEVuRy9MbytFcmV6SWczc25BaE01ODdZemdT?=
 =?utf-8?B?eWM0Sm5LZXRWbHdwMldVQVh1YnpnaGJ0Rkk1OUxnZGRTT1VnL1NRZjljV3Ry?=
 =?utf-8?B?d08vcXl5THplMVBVLzg3YTY3V2xUTTFmSzdBUTliL1g0TGNYY2I4OHgvRnBW?=
 =?utf-8?B?NGxhZmJ4by8wMUdaUG92ZGQvQ1dSQ1BvVUk2VDJvNzkyalNtaUtxeEVhNGE5?=
 =?utf-8?B?OEUyUVFXRXUzOVNzWkJWbnZlbnptU0NZeTF5ei9YV0Qycy9ZMlcwQVhsZG51?=
 =?utf-8?B?MGlFcGpZSmF5dUpoY2dSdnlnYlcrWlI3SDBQK1g1bVlPRVgxK0xKdEt0R1hX?=
 =?utf-8?B?bTFzNDk4eFpCM2RrdFE5QUN6ZmVQdFI5eWtjSm5kMWlzeWs0TkhuYUNITVFC?=
 =?utf-8?B?dEtmQ1d4V09ISDBPMlBndHpKc2luV3FONUlESTZHcFcrZytsQ2NUZz09?=
X-Exchange-RoutingPolicyChecked: 3pTyDAzKF4KMVVFeSBEbWiGsELWqmaekvEDHkB8mYoWHgqnQLRKizifiEI4cQ10tU+5S8g/4tsbw6CcxnWW2tMaXjPl5iv71V+bKoQ7ZSe0ZL1CrG4DCevpkzYDFgAcqUwZvBKF2DWD87Wh2saMXj1Avewub5eDFw0g0UNVadREnmhm+E1sBXRZfpIl2eb96HugbDZhnfRbutz1bVEq/AHuVIc8wuZxpslFN1nxba5ep+ijjB2dP0bewkoOMCxMydRCHvLcby9Ma8n24X/VsqJH5wFrmhCvGO10WeyhNH0k/8SEamx1ICELVxL8LF1m9Ri30fIf8Czrosq0wzUEqIw==
X-MS-Exchange-CrossTenant-Network-Message-Id: 854653c8-cfc7-4d08-2242-08df36c7e8cc
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7925.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Oct 2026 20:53:54.4100
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LYE9/m/QGsvCJPWdwF8ud5tqfN06IihXqoNhebiskbFbe74KoQXU1GsL1MguOiajonMhXGsk8/KULjQ8qwy6TlAuKfHDLXhNB8Bb82CHCuI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR11MB7415
X-OriginatorOrg: intel.com

On 9/11/2026 2:36 PM, Sohil Mehta wrote:
> 
> Patch structure
> ---------------

Since now at the 10th iteration, and I saw Sean gave a bunch of feedback 
already, I suppose pieces are quite sorted out. So I'm more interested 
in how those pieces could be organized to make easier to follow, review, 
and integrate going forward.

> Patches   1-6: Enable the VMX controls and export the host stacks

These seem to be preparatory changes for supporting the state and 
extending event delivery later in this series.

Would it make sense to put the x86 core preparation up front rather than 
having it in the middle of the KVM changes?

> Patches  7-19: Virtualize the FRED context and advertise it to userspace

I think there are a few sub-groups here:
  (1) patch07-10: Support FRED state context switching
  (2) patch11-14: Extend event delivery
  (3) patch15-17: Handle CR4
  (4) patch18-19: Advertise the feature, etc.

At glance, (2) looks a little difficult to follow. Patch 13/14 in 
particular appear to mix the FRED support itself with some preparatory 
changes. IIUC, the code is saying everything outside of the 
is_fred_enabled() path has no functional change.

Perhaps, the changes outside of is_fred_enabled() could be separated 
out. That would make the actual is_fred_enabled() path easier to follow. 
Also, the part introduces the ABI immediately after adding 
is_fred_enabled(), before showing up the callsite of is_fred_enabled(). 
This flow is a bit abrupt.

For example, extending kvm_requeue_exception() alone could be one step. 
The next step could add the code under is_fred_enabled(), initially with 
is_fred_enabled() as a placeholder that simply returns false. I think 
that would better highlight which parts are actually FRED-specific and 
why this dynamic check is needed.

Since is_fred_enabled() depends on CR4 anyway, its actual implementation 
could then come with (3), or somewhere later. Finally, (2) could perhaps 
be completed by adding the new ABI at the end.

> Patches 20-25: Extend FRED virtualization to nested VMX

Since nVMX support comes after exposing the feature, does that also mean 
the series could be partitioned into two parts, one up through the 
advertisement (and tests) and another for nVMX support? Splitting up a 
complex series like this may make review and integration easier going 
forward.

Thanks,
Chang
