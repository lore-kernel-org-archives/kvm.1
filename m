Received: from SJ2PR03CU001.outbound.protection.outlook.com (mail-westusazon11012026.outbound.protection.outlook.com [52.101.43.26])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3323C37FF7B;
	Wed,  8 Apr 2026 19:55:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.43.26
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775678158; cv=fail; b=fIUqfQP3HBth9eYAnrSI0ShUvYCKCqYAJ9BAo+Pnt4YH/Or5WUBlBanNwuLV0d9ZhaDoIT77qcV2Lw9T2gDjSAjiLWriudnTEFLinr2PrWWPjkatubC3pOH5QjpeO9fOKpvpughCRTfAon3T/7Um5Ki079IOCTFv4X/ajbnYdGY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775678158; c=relaxed/simple;
	bh=4QKgy1k9quAS8d6oh5zPScod5ZIesGG09yWAFK65H3c=;
	h=Message-ID:Date:From:Subject:To:Cc:References:In-Reply-To:
	 Content-Type:MIME-Version; b=isJ+JBIZJWZMY9W1MgiAxreiM1GWKz8JvhsTyXXYsuQngWUDcmJwg0WtOZ/LIRaGiW5wYZfNFORDPTJ7oyokedipFAKoWTsMfq3vkInfG+LiK7UoPZc0T6sSZF8CmKwmbnsJRAB6RFk2BjvnhzdP7XoIhDKcinslusGbiK7xHsk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=zMP3V8c0; arc=fail smtp.client-ip=52.101.43.26
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="zMP3V8c0"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UMs271O6uyFxzbYYE9d479+b8Tk0gOBqipOxh1Tq1jqseoFMmwhruDrRkeqiFuzjCi09g7MK5Tdq6pICcHmzuBmlb7BLGNMTfODRY0CLrHYYN/48y1Px52g+e5jpIVSN9+qNfEXbSeW1irsHW/8Xy+e+RvJfD0rGyBLhzYkQmC/GHY+DcxZ60TztEkQOBfhN8NUO0Gb+IJtF2N9zG5uDnQX9O1XCLvbQ7+cwzcu5nEEwYsAFkLrO+ueFsc0de7SvdAJDcHIjLIO3weKHsaFCls8W6Egr8YYGcznenFjbgU0n3uITiSgJsgSevy+13emWRYJvnl6ZEEFOkWVonrkgiw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eIdLCM32W4P9TuQ9R7PiU/uaVgAJZwSRIU1qKZUFE/Y=;
 b=E0OOyLK+KSLbHjc73krrxMeHg0y/Ehf7sRdc7YMV1wVsC9T8v2wGYFFWQu5jFjGCTHedsgmdBwUu4K+Z5CjBV6JVqImt8EaGQGFCGKhNKkJECBAizmbzuaMVynUxyn77k4PBozqlONaHi07xLaJzQCOt5+yRUl3ASeQtRzfCz5dhW57xTX5f/sHyVXVknRQaVXWtqxB8WxQ4rHiCHg+1CQMIL6eKqPRJo0ewYTbgOtGEaNWJ8kP1B316xWXDrQ7dqLmqs5c4kjht3F9YiwHGzhrbjbD08I5ZHciKgapNayor4jxa1CJ3+NoePt7TnesFnbNQl/45f1F4f8dQoCIiZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eIdLCM32W4P9TuQ9R7PiU/uaVgAJZwSRIU1qKZUFE/Y=;
 b=zMP3V8c0TOhoZo99I9qyrIEmrigMJE+IUQe4RFkpBNa/t+n0+pPQ6FdoE5UAT/RLkGcD0yVccKM2qiuUilyGL0E1FG1eya7ZujdxeHhJu5pm0XYuGe8Kq32DbpHcBLAXzwQKjTxSz44IGikWtT2QT9UeTUOBPhbsfvxiQLauyiY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CH3PR12MB8660.namprd12.prod.outlook.com (2603:10b6:610:177::5)
 by MW6PR12MB8950.namprd12.prod.outlook.com (2603:10b6:303:24a::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.41; Wed, 8 Apr
 2026 19:55:51 +0000
Received: from CH3PR12MB8660.namprd12.prod.outlook.com
 ([fe80::87aa:52e5:4b72:d5f3]) by CH3PR12MB8660.namprd12.prod.outlook.com
 ([fe80::87aa:52e5:4b72:d5f3%6]) with mapi id 15.20.9745.035; Wed, 8 Apr 2026
 19:55:51 +0000
Message-ID: <9609980e-9862-4cc6-833c-828db4fddc09@amd.com>
Date: Wed, 8 Apr 2026 15:55:46 -0400
User-Agent: Mozilla Thunderbird
From: "Pratik R. Sampat" <prsampat@amd.com>
Subject: Re: [PATCH 2/2] x86/tdx: Accept hotplugged memory before online
To: "Reshetova, Elena" <elena.reshetova@intel.com>,
 "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>,
 "pbonzini@redhat.com" <pbonzini@redhat.com>,
 "Duan, Zhenzhong" <zhenzhong.duan@intel.com>
Cc: "x86@kernel.org" <x86@kernel.org>,
 "marcandre.lureau@redhat.com" <marcandre.lureau@redhat.com>,
 "kas@kernel.org" <kas@kernel.org>,
 "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "mingo@redhat.com" <mingo@redhat.com>, "bp@alien8.de" <bp@alien8.de>,
 "Qiang, Chenyi" <chenyi.qiang@intel.com>, "tglx@kernel.org"
 <tglx@kernel.org>, "hpa@zytor.com" <hpa@zytor.com>,
 "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
 "linux-coco@lists.linux.dev" <linux-coco@lists.linux.dev>
References: <20260324-tdx-hotplug-fixes-v1-0-8f29f2c17278@redhat.com>
 <20260324-tdx-hotplug-fixes-v1-2-8f29f2c17278@redhat.com>
 <56190adc345148396ba6b3e52672e662145f7dc7.camel@intel.com>
 <CAMxuvaytU-pM+rviUbNGWMhvbAYutwvaSXW_O=sn+QfOzF35Xw@mail.gmail.com>
 <7802b50589c80a7276a50cc473c1aa579750a30c.camel@intel.com>
 <CABgObfZ7_w8Q-dW=Sd4YA3P==BuN1edPv7Ty4EpPyU8ctW6RLg@mail.gmail.com>
 <424048885a01dcb6a7ef0256f0dc8a9adb546f22.camel@intel.com>
 <cab5371d-e0f4-42b7-bae9-2c7f981b26b2@amd.com>
 <49e8b24d836c1883e83ad72d1ab279f9e3eb7455.camel@intel.com>
 <IA1PR11MB949557E04741169BA209A69EE751A@IA1PR11MB9495.namprd11.prod.outlook.com>
 <9b1290bbc1283a2f35bdcd177d27ae7aea89151c.camel@intel.com>
 <IA1PR11MB94952B22F6EB648ED7C1AE3CE75EA@IA1PR11MB9495.namprd11.prod.outlook.com>
 <f4639348586233245343005708372230f2d4a2cc.camel@intel.com>
 <IA1PR11MB949508D72B9DB570770FF8B8E75BA@IA1PR11MB9495.namprd11.prod.outlook.com>
Content-Language: en-US
In-Reply-To: <IA1PR11MB949508D72B9DB570770FF8B8E75BA@IA1PR11MB9495.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH5PR04CA0014.namprd04.prod.outlook.com
 (2603:10b6:610:1f4::26) To CH3PR12MB8660.namprd12.prod.outlook.com
 (2603:10b6:610:177::5)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8660:EE_|MW6PR12MB8950:EE_
X-MS-Office365-Filtering-Correlation-Id: 05162ae0-1a96-42bd-2ef6-08de95a8d5d0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|7416014|1800799024|22082099003|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	bLFCusjK7fOcPHmn7+V4slyWdB5CEUsnwPTEAxT8NGv66G/V/vmiZDPNGE4Y9ttsD12+zPkWmcubFdefalPtL/Tll8IoJY8KsgT59OoosPZUEUA2uXzyVCE23VioC2+eMf5NAbNuBx0sgcIfLExlHYQPKkOSvh3Dqv/nMCWp4RFM7w0ugH3O+XI1oP4Sm/NgXS4hi6mA0sIcTz+lMpVgq3Sb+L80j+UXw65mu0LySq6e2K1tfmvo57d5W+wAFb4rZ1Tnw4NJ8TRQD2SWdtcaoGr3MZBb2T9lfIxsdI8ddPR/Y+cVVFvYzua2kOJ936ctlc97Ijo2BNJi3GTuHhekx+RUwBqfrUuq+JjO9rSjJr+Dy0KIPmoceKsTPzAwygzWmLNQryGUy4RQcMrpWdD4AgVc5GXlgusCmoSU1A/4Mr46Bm8ZIFflq2C4nmMTh9N/JoqWgLrdzjbYIn4GcKRsFdB71eJsRN5hvDfC+wXcwqmIIxHMPiNUP59U8HD13ZxBfJThdeIKc2AHSFhoe4FW7xuvFVFSxYEvwkcTQKklIJrZ8Nk6Rg0Wfr/YjvGom2qToQWTQrLpTHg3KubBf2+mK/uGHomxEX56x2khmVyoO4kwvsut+zQS9DaPTEX46jQz6gFaZLST9PpTBOYK7QAE18NPyZtW/7O73j6jkn3J0qrvK9P7Gs2r2JFQ3UuNVIoj5/1ZbZ0S+KDdQE419b1qj3J3LZjtNFhVa9TcnnKY2+w=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8660.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024)(22082099003)(18002099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?NGxCMjk0bGdxRDBqalR2SUpRWTlKVlJiWlkybTNJVUNKdHA4MmNNbWVReUxN?=
 =?utf-8?B?V1lzYXJtb2JFdXI5WmtWZ01XYVljNHR6eU4rYnhGSE14eXlsUEZncmNiOXdo?=
 =?utf-8?B?cmNyQzB4cVFqZnkxTER3NVVwQkZZVGx0bHpFT1ZBUStxSCtaWmwyTTN4U0NT?=
 =?utf-8?B?aVc0UTUzL0tLdDdVTyt0Y3V3eENtVXR1ZWdPRGQ2am9CcjFoYXN6RUVQMTUr?=
 =?utf-8?B?K05hdG1xQy9wTHhmMXRYY3dPSkV1MTl3TjdFTUNUNDBhbDZiMHVkM0tKZmZD?=
 =?utf-8?B?eHQzYkxyMS94a0JSL20wd0VXWm9KQitVL0lxeitQcWxYaElpcUVLUEhwMjBp?=
 =?utf-8?B?V0Vla0ZEREhQZ045Wmg2bllOMDc5WlkxcHprRDIzM2FYb296aDdCdmJCSWln?=
 =?utf-8?B?eXNILzhZUmlCaUZkTmg1a1RhVTZWVHkwd2QwL3JONHNSZURGRnF5Y2dybWJj?=
 =?utf-8?B?d011N0xtb2ZTSmtQSms0eHB1RkR0d01BTUZtd3BSa2ZnU3NaZXhOLzl2SU1O?=
 =?utf-8?B?aHZ4emJmMWlRTnV5V3U4WlMzNWlFWjZSc00vNkhwR3Z1NjBXZXRMd1NuejJi?=
 =?utf-8?B?dThETVpyMmFpZ0Rtcm1rNTRQYUpJQjYrVGV4UjhpeCtCZFB6emhWbzg1TzQw?=
 =?utf-8?B?OEROSkVzWnpsbzhnNHEvampGSHBPeTZDeUhzaWZZZkFPZnVXSFFxS29DNG5k?=
 =?utf-8?B?VzFyQ3BDWXBJTS9ZV2MxNHVjVERYUmdRUGptYVdLNnN2bG5OcktBSWVLUjQ3?=
 =?utf-8?B?MUJTQVQwS2hhaTdBRVVmblZNNnpYWEI5Sis3QmN6TVRkWE1WS0V4Sy9FcFZU?=
 =?utf-8?B?UlVGdmI5QlZjQi9GWmUvUGZUQ21ZM2VlL1A5MmlESmtBMjhmbnNnQ1AwdDdQ?=
 =?utf-8?B?Wmo3cnFJNG5sZ2dnRkVrdHg4RGJBY0VORkorZ2lxYS9IOWRCTlZ0Skg5OWl4?=
 =?utf-8?B?UkZPQ2VQYnRQR2tZM1ZmSkNYeU9UamFrdUQvNVZtVk8xVUE5Qk4vMUNXbFRS?=
 =?utf-8?B?Y2dHOWRiMC9nUWVaKzhncGtjR3d1ZGtoNlVzR2tYSE1OTE0vOThYMVNFMFI3?=
 =?utf-8?B?UHRkeU1JUFBGbVVhL2NmWUN4ZVNKNFhuY1dqWngydUxRQjVVakZUc1dGaUF1?=
 =?utf-8?B?UlcxSjR5Zkt2U3o3VHlkWExza0puT1Vtb21rNlZwTFBFT0UzaDFKTm13NVJq?=
 =?utf-8?B?Zkh4RUh3SSs0UWNZSXZGbnBmNjBZaDg5cDI4cVdNellxcG5wRkpVOUxkazZy?=
 =?utf-8?B?RTdVUE9qU1hNYzYrY3VYLzc4bjRkak0zMGs1TlFnN0N0VWhSUzJld0xnZDRP?=
 =?utf-8?B?YlBFY2x4bzgvTCtXeDJTN0tWY3VVR1pyRFB4Q1drdVFGdTFwa3l2UFN4YXIz?=
 =?utf-8?B?UFpTSm10cjRyMlZ3dnpWdy9PUzF4WmF4RDRUUFVXemtpeE1ZLytkbDNuaEJn?=
 =?utf-8?B?S0w0Wm1YNXRwaDdGenhYMzZuaTZXOS84WXpyamRFWTNOVHdGcDVobG1ONm1H?=
 =?utf-8?B?Q3Z1aER0R0dlSERpVHBkNkVZWmJPU1JPMmVubkVRSGlCVUU0TXJYWFd2UDVX?=
 =?utf-8?B?YUZHbG9LeXA0aHVtWFcxbVY2TGpvbzNQdTJLeTMzMzVabFYyY2NqenRRQ3Uy?=
 =?utf-8?B?ejF3UG1pNmNMcCs4ZUtiL0VKWGhsaDRKblhjODNML3NyZEsySXVYS3JBbC9I?=
 =?utf-8?B?TjdadDRsV2pxU2ltSHdvazJaQnltcDB5Zk81dlNBWndCaUd1N2NFS0NhMDdN?=
 =?utf-8?B?WDhhWnlNSFFZTmtSTzhhUjE0cmkwNkRWRVNpNitIMzk3KzJmQXVpWGRmcm5N?=
 =?utf-8?B?bUFtQ2xoNEExVk9VejZnN0s1M0swU2ZITEVTRW03TGFOSzE1M0JoRDNIRnZ0?=
 =?utf-8?B?TE1SV21wSlBUMVNTRFp2MER3VEhJZGNUcGtYUFQ0VlR1MlhrSFlTZUF3MG9t?=
 =?utf-8?B?ZnV5MzlQTzZGQnk4aG54TUozcTFIc3VYN0ZXOFFHeHdVbEpEdDJUTFVHK3lw?=
 =?utf-8?B?QlpVdnkvdjVFck9aSitTbTM5ZVQ4Yk9iQWJEQTRqc3h2V0hrTUlaSFJCaFZP?=
 =?utf-8?B?b1RiUC9qQW5OYW0xQm5Wb0ZJOWpUTkxJSTZ5Z3JtMFZhZU9vazhVVzVpWU9m?=
 =?utf-8?B?QklmaGpvYktiS3daQlMyNENwajNlUWk1WGhnM0tkaDRHM3N1S0ZzWHdDVTVI?=
 =?utf-8?B?QTVTZnJYanorZWNDMGw1cCtYMklwRHZWalREdDE5Z3lxeDlIT25MZkhKNkJY?=
 =?utf-8?B?R0NQaW5tc29hK0kreFVURW42dDR3U2pZNkFVa1N5Mkx4YSt3dnBkWXhMZGdV?=
 =?utf-8?B?N3FzNDNES3NWRVhBcURnSDI4VjY1N0hRSFdFTldJUFczVDl3dDA3UT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 05162ae0-1a96-42bd-2ef6-08de95a8d5d0
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8660.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Apr 2026 19:55:50.8934
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TNCzjnUjEmbYBJOEA/T6fYpK/da7p99n0wvEAH/gWGycX7kdRnBSTja24HFBJYDIEyo2JNZShw4kSf0zsFme7Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR12MB8950




>>
>> So I'm going to assume you agree that this procedure would not open up any
>> specific new capabilities for the host that don't exist today. And instead you
>> are just saying that the guest should have infrastructure to not double accept
>> memory in the first place.
> 
> Yes, exactly this.

Thanks, I was a bit confused by that too. This clears it up.

> 
>>
>> But the problem here is not that the guest losing track of the accept state
>> actually. It is that the guest relies on the host to actually zap the S-EPT
>> before re-plugging memory at the same physical address space. So the guest is
>> tracking that the memory is released correctly. Better tracking will not help.
>> It relies on host behavior to not hit a double accept.
> 
> I see the problem better now. Then I think the correct behaviour is for the
> guest to keep tracking of accepted and released memory and then allow
> to double accept iff the memory that it has tracked as being accepted and
> explicitly released. This way there should not be a possibility for the host to
> misuse this for an arbitrary memory page.
> 

This makes sense to me. For SNP, it is the guest that performs the pvalidate
rescind + RMP state change operation, so having this kind of tracking should
work well for all of us.

That said, adding to the unaccepted bitmap isn't entirely trivial. The bitmap
is allocated as a flexible array rather than a pointer, and changing that could
break kexec [1]. It might be worth maintaining a separate table to track
unaccepted hotplug memory instead.

[1]: https://lore.kernel.org/all/m3l6gcjmbabudtnqwv6w67t7iz2mpmbjyrpnmiq5k2iyargn5d@nyf2zzxx7yme/

Thanks,
Pratik
