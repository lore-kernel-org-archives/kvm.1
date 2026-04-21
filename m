Received: from CY3PR05CU001.outbound.protection.outlook.com (mail-westcentralusazon11013042.outbound.protection.outlook.com [40.93.201.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4DCB364924;
	Tue, 21 Apr 2026 18:20:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.201.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776795612; cv=fail; b=b22uICYPXdCvSt2O0vR7XeUDrLQn6ZTsT/RErmc57iu9/uBGSSLiT8SQqlxa7K5HOwafIVapwNEbhetdzOa8NLmOsJG9H2s+iOToJa0vXOApCNh0LTnQJ0LViD2IPJxmrgerOVOwGKttNP1s8IzZrmYMWASdad3uOM2cYufO2Bs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776795612; c=relaxed/simple;
	bh=8uRzXK8eLCDJR+fJ71dg5r1MFZq3WZ/HhyVXmPom3hI=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=DCV1IBvb4Ni4g3Jh56GdHu3EwxyPz6QDJNWuWkPxOFuws7tzTqsbGQ7nZ14OdE3QerPS9qbHkh+2lf2GaJH/HCvWMAxbM/PKBp8utna7FzHvFhNtbzFtsRIHDePoIF9Sy+uQ1u4h3+7J8NJRHjxnlGtNO18/ZvDET08ZLC7ZOj8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=WhmIz4dg; arc=fail smtp.client-ip=40.93.201.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="WhmIz4dg"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Jnla+PXoDlduBv+VH3CXMOIhaLWXluDIILIk14pUsY1qxihdMLfbIPoxHiyuCGwSLSK8NB1wU+hw7ZVRDGkKQC2X4zvySLTMenQUhNKtGp4FeVJq50y3Ml/3zePpP8S8R/xWF0+ErSVPguvZx+Q89OyQeq5OsVkullHlzNOYVAdR8s+QP1wStScjpjKal7CYbmr8TScFv1vKwFpiaP3hY532W4/YdmLuJctrMS0FMAAz2CpCSuwAnwXDVe/qLur+mXlqNHI/TtBybnYs5vhrazU7fx/WD/gEBNuRwItC6/9qjfbksi6zl703KhorSnIqVJsVyYzTZT9n16JTgpHCQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hQegl5TPQ2xwlVDYvzRyJ1va8YLcdUSzvqbcxYijmKs=;
 b=tTJZKaexUhgV+nTph0PLR+73nQcXC6er0iAFWi4173csEZDb/MqA/m+Vi5CFhLSJhlaH+/P7E98iqHXj6AQHQFSXiGy7VuRcoFRWUzJrAxU2EXtwJsT/eJznOgLVypvoCzZ4UN+ufX7aW0xWg8FPK1GrJFZvlK0RaxF6Mw/2Al0uSMplNHD+vwoL7d1l8DMBdGLPfNTavDLgSPaBcESZAaHOVDhYdf3AFc84rUAEGi2v4kUY1fIvO5BkPUbdFNGISI/fHC98fk/j4CS/cocCW9ThVOLFIu7VA/6jiiMF+6YfcrgdHpCji22SPCm4pkdBe89Wh5EpkGKMgxd40sAZYA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hQegl5TPQ2xwlVDYvzRyJ1va8YLcdUSzvqbcxYijmKs=;
 b=WhmIz4dgY0XNeUBaTGcgz53DRAIix39ld0l6m3Ml+kcWcrbp9RhRR/e8zmVy+6J/fskfxF6dvrsS6Zx6q3dZVxK+8aN5rogYpnl7xF9X1Le2BQn1szDcqnQujby07RolV96VnF7Unb1/pVt4dFNHydWJraVI44y4eO3NjClVpGE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS5PPFA3734E4BA.namprd12.prod.outlook.com
 (2603:10b6:f:fc00::65c) by SA1PR12MB6870.namprd12.prod.outlook.com
 (2603:10b6:806:25e::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.15; Tue, 21 Apr
 2026 18:20:01 +0000
Received: from DS5PPFA3734E4BA.namprd12.prod.outlook.com
 ([fe80::d03f:ffac:bea5:143c]) by DS5PPFA3734E4BA.namprd12.prod.outlook.com
 ([fe80::d03f:ffac:bea5:143c%6]) with mapi id 15.20.9818.017; Tue, 21 Apr 2026
 18:20:01 +0000
Message-ID: <d693f797-65f6-46ed-bd49-beaeee2da858@amd.com>
Date: Tue, 21 Apr 2026 13:19:57 -0500
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
 <72297351-2954-4318-81b6-7de409e5552c@intel.com>
 <20aaacfb-9601-4343-a5d5-f3df6152155b@amd.com>
 <43880b7b-b390-4e7f-8c2a-46cde9e3b051@intel.com>
 <bb9f62f1-0c79-4d29-9866-c39d08c3a774@amd.com>
 <5a273b0f-8225-4e9e-924e-884183734659@intel.com>
 <73c46024-4cf2-4f03-9268-d4378825fa87@amd.com>
 <973067bf-6e6c-446a-a81a-713840d701a9@intel.com>
 <90f4a692-1c27-4967-bf12-ec3cb597681d@amd.com>
 <68a551ea-d9f0-436a-9bef-e35fd027bb95@intel.com>
 <39e0c786-cc35-4555-bfb9-ff7cd758c423@amd.com>
 <b74cfe34-e23e-49e3-beb4-d5639d42d5cc@intel.com>
 <99a2da36-6a21-4a99-98e0-3c9a4cf7ecf6@amd.com>
 <741aa53e-461c-4a1a-a701-6060d42012f8@intel.com>
 <e8530c71-fde2-4522-8b46-a24efb13b681@amd.com>
 <71099958-1ddf-40dc-8a3c-aa13d0c56fee@intel.com>
 <e624f652-f0a6-4926-a0ab-c4486d41eb6d@amd.com>
 <8d969f11-4a7f-4e36-b85a-c3ed714fc603@intel.com>
 <a46f4f2d-e3f1-454f-b94b-c54e14e45a69@amd.com>
 <0334ba64-71b3-40bd-8cce-9f0f119e7dc9@intel.com>
Content-Language: en-US
From: Babu Moger <babu.moger@amd.com>
In-Reply-To: <0334ba64-71b3-40bd-8cce-9f0f119e7dc9@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: CH0PR03CA0350.namprd03.prod.outlook.com
 (2603:10b6:610:11a::24) To DS5PPFA3734E4BA.namprd12.prod.outlook.com
 (2603:10b6:f:fc00::65c)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS5PPFA3734E4BA:EE_|SA1PR12MB6870:EE_
X-MS-Office365-Filtering-Correlation-Id: d50b0cfa-f50c-4c71-3196-08de9fd29a20
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|1800799024|366016|921020|22082099003|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	PeDIcF9S3I/ksEgDkiuTHVe2PUwqrotq1LYHIh1RWE6MoYlsw2Mka2QiE6rFqrHrG/vIbhacFGQsyoUBVnwr7G01e8RLyMai84vPH7LZJXHTJnRrXNfwGjWQTpWvzN6o5fYwSZkVVugDz5MtBCSGRsJYwx1nBPul6cUNv0EPVEifAM7xvhnhwWcShzOtR8TqtV6FseYRYx4yIMDQ6m1deJUHC4b5JzZWMWxKfSUhwru68oG5EAPED1ootm4HrePYPRkhlmh5CfYiSU3GqMg3q+8JmLcYGcVJchygfOL4p4hUZVcwIAPCNPzj0NutkxA+EF1iZ5cwgPLwQptJwYLlpAIIclL/ZCn1Liq8LLJ0lULa+YVUdPYGsGmKG+7WZHsGLP5LQ6CkUZglJlbwUWgs5w4Yg2L7kmN/fPK2d7/1SL04nThHYd4YuaajX0lMOP51E4e7LdsHkF5EFVGT7s1FQUTf9Q9MQJ4Yee6r/6HFqnMMJ22R980NFCuC4VeLGLAPnvRTOqZnnPLjtzSchw3srV3OjoH0zOvF7k/Y4pQwftCKNBoujc97+hjThPxyNc2AhSfKlyJ1OZZzFa5wpUO70bSTeIEUeXOOAyW48IplfJ2/5vNClMGQ8DwUbKYhq8zudT2ZCyCdwWJZzKXlKhnjXmBYkaw7Lm1PZHSoBaVTT3FUKnfwdtL7gF+DxCVaJOIdtsxzrEckbn3qNEDVMwnZoUeatYcrxqtI6WQKP0/b/LO0lE1Cfywnqz9or541WdCcr6ADS3axTUd+1HFIMLEsStYA9s+/7GwGjzjSDcQrips=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS5PPFA3734E4BA.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016)(921020)(22082099003)(56012099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?TXFuVHE4djBwRWJwVXdXZGQ3Sm1jVm15WGlUT0hsQkpGQU4xVTRGNXlBUGZO?=
 =?utf-8?B?RVdYYlRvelcrMzRqd3QzN0haaTRuRGZ2ZUNKUFVXL2UyOVpFMVR0ekhQVFNO?=
 =?utf-8?B?MlM0T0dPcHd5Qm00Ny84NGVKbHpPYzAyOEJ3V1JuOFEvVVRjRW4rTlhHYTFv?=
 =?utf-8?B?UkxxQmZ2dzJFVHBDVlcxU3VRMGFRZEhTS2MwTzUwS3VueXowR3dzSDlNVUli?=
 =?utf-8?B?RXVWUVc2aThPMTRXUkFoWlBDZkJheFJYNnFlRi91cU1NK0pmc01UM3Z4aWtC?=
 =?utf-8?B?RG5yNjJxYnlRZGJMTWVqSVljcllqbFNqdllkMThRWHFyVnNVUzMyZksyR0pJ?=
 =?utf-8?B?Wk8zK3FORTF3VHpMOEZpQ3NPNkt4Y0xVcEZoWERSK0IyM2JSbWRDT01IdG5l?=
 =?utf-8?B?VDVGc1UvUzdZQ1g5QkN4SnlnSHBPSlBxTFh6UDRDTkZKY0lnT0NRZzRIc0dq?=
 =?utf-8?B?QzJCQkFEU2lkdGFneklhUzVsZEFZY0QxMHUxaWdIbTRJZzRYVEU5Tk5nN2d1?=
 =?utf-8?B?Y21GWDB6T2ZjbGE1cWpZNFFGVlBzYStFbjFBN09BMnE3ZjJOL1A0WWVJMmhj?=
 =?utf-8?B?TGVua1MrSTZxdW9BS1RsRTJwcmxhcG8zQkg5Y0xhditFVXZqS21UUWsvbzB6?=
 =?utf-8?B?SmRQZW44K1pWZkkrY0NvZlpPbUd2YmFtQnJJblpMR0xuQUcrMys4MjU4elFh?=
 =?utf-8?B?L2l0K3hwZ3RWT3F2NWFlOG9WM1ppNHpvQ0dRSFpiYWtpYzUxVzhHQXpsTFIz?=
 =?utf-8?B?dXpnRmVqSWd6VXc2aXQ5My92amtacHBzTG00NFovMlZhZHNOTXMrcWorc29j?=
 =?utf-8?B?eDZ0K2JxSVhMSnJMcWFUbkI2ay9MZjZYVmEwZm83aVdpUGZaN1lnYURLRWNR?=
 =?utf-8?B?RVpXbTRuUHZZQVlJNHBHRC9jeFFqTG82WHdidVdYZnNmTmN3aThnb1V2cW9I?=
 =?utf-8?B?b1pvQVY4RHdlS3NGYTh3QllBdCs4Q3d0c2QySndJOGEyM0QrRjEweTdKakR4?=
 =?utf-8?B?T2Y0YjRxQzZOSFR0K3FRVCs0aGR1V1JBUjVjNXRxOWRLcUtFZFZONVRWTDhF?=
 =?utf-8?B?ZmtURmRWN2JGV05zUmFMNDAyeDBSWEZqeUZHNi9mWk5vdWZScHZERSsxN0xE?=
 =?utf-8?B?TUZDTVRDYy8rLzJKZFdpbkoxN0hjKzBmbk85OXBGL1lyMCtUZ05xb1dKUzN4?=
 =?utf-8?B?dHgxSGR5WE1IaUNJTXIwT3VudWE4THhaYktqS0JCZndLYlRWTzgwb0x0bldO?=
 =?utf-8?B?bytnODZuQ29WeUpkQlJ1V29JaWZFc2ZYZTdRTzNDMHJORnY4L29rb25LOXRk?=
 =?utf-8?B?R3IvVlpITklsS095czJ3ZE1TSnEvMUdsYlZrbTZCcDE1U2Z3cGxLQWZaTDR4?=
 =?utf-8?B?YzM3ZkNrUngwcmliVVlyZzZHa1FFL2F2U1lEdDhzSVlhTGpSV2NWWGg0UEV4?=
 =?utf-8?B?L2ZFc2dzSFJxcFhpeWlnUkZpdFE5ZUQ5cjNsaEFXREpDczkzV01KdFZyUHVR?=
 =?utf-8?B?RnhxUS9zdzhSN2h6QVAzWmpGcEJWWUpJcVlLc2JjTG9CMnh3eHBNSTk4QWcr?=
 =?utf-8?B?cTZGZmRCazA4a3orKzNJSTRnMnppdnEvN2tMOFBwV1BSNlRIWEJqQnhZYnUw?=
 =?utf-8?B?Tkd6cEljMjVNMDdYb0R5ZmF4b1BlcDZOQm8vSW1aK0plNWJvRFhvSDVEald6?=
 =?utf-8?B?SUhScjlLdm9sNXlLcHVkYjRQTkpxa3J5YVlZcVpwSGsxcVhBZXgwUUc2VVlZ?=
 =?utf-8?B?bm1USHpSNVd0aExzYXA5TVNUak8vQlN3Vkg3YWJtdjFXRVlOc1RQYTdyQ054?=
 =?utf-8?B?YzNQNjBZRzFtWnVFTlVkdjZyTWkxUlNKRi9VWC9WNURFSkt2SjJpaUR3WDVv?=
 =?utf-8?B?TWVVeXoyUmk2cXVUcHVZTTJEM1RoTVJwTi92M3RodzA0OFdvVWsvSTRlbmtz?=
 =?utf-8?B?ZTA1ZjFRaTBreHdUVFhMZU1WdmZ3dHhPY1RKNFdmQW5CNElHclY2c3Y2c0Vv?=
 =?utf-8?B?dk5yODRyVjhZZUFZeEtVNHFuK0RrQTVVNDJyMXU2dFdXSXczTy9xWDVOTTla?=
 =?utf-8?B?MFduK2JHQ0xEU2hTWnY1c3QwNUlKY0NWbUJoZSs5Slc2SzVnelFSQ1Q2Mjcw?=
 =?utf-8?B?UmI4YndsSk8yN3ZxY09wZ0tLRkRXaGVLSTFXd0ZCRUhneE5IWURoMGtYdU9Z?=
 =?utf-8?B?TEJDS3k2K0Zna1U5ZjZRT1E2LzRrZUNlQzhtVkt3WWp5ZUlpY1RnU1czMyt1?=
 =?utf-8?B?VHdFTDh6QjdtNVZya05YSEQ5WlVmaHo0cEl6TWRGVStrdVA5eFNIb0lNNzU3?=
 =?utf-8?Q?ey/zs0NNh5PtpVeuvJ?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d50b0cfa-f50c-4c71-3196-08de9fd29a20
X-MS-Exchange-CrossTenant-AuthSource: DS5PPFA3734E4BA.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Apr 2026 18:20:01.2946
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: n7AGL4QtR3mvHLUSoczfiiX822jW0YP+VK/bZwSfUPJWmmM37xplIgq0GVdL/wMW
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB6870

Hi Reinette,

On 4/21/26 12:35, Reinette Chatre wrote:
> Hi Babu,
> 
> On 4/21/26 9:46 AM, Babu Moger wrote:
>> On 4/21/26 11:15, Reinette Chatre wrote:
>>> On 4/21/26 8:08 AM, Babu Moger wrote:
> 
>>> It sounds like we are saying the same thing?
>>> When considering all the sharp corners I agree that keeping kernel_mode_cpus/kernel_mode_cpuslist
>>> seems most user friendly. When doing so there is no need to include CPU assignment in the global
>>> files.
>>
>> Actually, I was talking about removing _per_cpu extension also as the per-CPU requirement is handled inside the group using kernel_mode_cpus/kernel_mode_cpuslist. It can be documented.
>>
>> global_assign_ctrl_assign_mon_per_cpu -> global_assign_ctrl_assign_mon
>> global_assign_ctrl_inherit_mon_per_cpu -> global_assign_ctrl_inherit_mon
> 
> I see. The goal with this name choice was to distinguish a global mode that
> additionally supports per-CPU assignment from a "true/pure" global mode that
> does not support per-CPU assignment.
> 
> If resctrl ever needs to support such "true/pure" global mode that does
> not support per-CPU assignment then resctrl will need to either come up with
> a new mode that does not expose kernel_mode_cpus/kernel_mode_cpuslist or
> make kernel_mode_cpus/kernel_mode_cpuslist read-only. The latter adds the
> complication that user space can always change the mode of a file so resctrl
> would need to add corner cases for that.
> 
> To me the "per_cpu" distinction is useful since it make it clear to user space
> that even though this is a "global" configuration it additionally supports
> per-CPU assignment for which user space can expect kernel_mode_cpus/kernel_mode_cpuslist
> to exist and be writable. To me this makes the interface clear and intuitive.

ok. Sure.

> 
>>>>
>>>> # echo "global_assign_ctrl_assign_mon_per_cpu:group=ctrl1/mon1/
>>>>
>>>> Why do we still need to keep the "inherit_ctrl_and_mon"?  By default all the groups in the system falls in this category it is not plza enabled group.
>>>>
>>>>
>>>> System boots up with following options if PLZA is supported.
>>>>
>>>> # cat info/kernel_mode
>>>>         global_assign_ctrl_assign_mon_per_cpu
>>>>         global_assign_ctrl_inherit_mon_per_cpu
>>>>
>>>> No groups are associated with kernel mode at this point.
>>>
>>> To me it seems useful to be clear to user space on what the current mode is. If I understand correctly
>>> above default scenario essentially means "inherit_ctrl_and_mon" but instead of adding it to this file
>>> we will need to add documentation that describes to user space how this file should be interpreted.
>>> It seems easier to me to just be clear via info/kernel_mode itself on what the current active mode is?
>>>
>>> I think something like below will be more intuitive and not need much additional
>>> documentation to understand (I am just adding the "uninitialized" as an example to match text
>>> printed in schemata file during pseudo-locking ... even if there is a group named "uninitialized"
>>> the lack of "/" could be used to make it clear what this means?):
>>>
>>>      # cat info/kernel_mode
>>>      [inherit_ctrl_and_mon]
>>>      global_assign_ctrl_assign_mon_per_cpu:group=uninitialized
>>>      global_assign_ctrl_inherit_mon_per_cpu:group=uninitialized
>>>
>>
>> Sounds ok to me.
>>
>>
>>> I also think an interface like this would be simpler for user space to use as it (user space) switches
>>> between PLZA capable and non-PLZA capable systems since user space need not associate existence of
>>> the file with some kernel mode state in addition to actual content of the file when it does exist.
>>>
>>> I assumed that info/kernel_mode can just always be made visible and not depend on PLZA
>>> capable hardware. This means that on Intel and Arm this file can show:
>>>
>>>      # cat info/kernel_mode
>>>      [inherit_ctrl_and_mon]
>>>
>>
>> Yes. Sure.
>>
>>
>>> For Intel this is accurate and also for Arm if I interpret the Arm implementation correctly
>>> (see mpam_thread_switch()) in  https://lore.kernel.org/lkml/20260313144617.3420416-7-ben.horgan@arm.com/
>>>
>>>>
>>>> # echo "global_assign_ctrl_assign_mon_per_cpu:group=ctrl1/mon1/" > info/kernel_mode
>>>>
>>>> # cat info/kernel_mode
>>>>     global_assign_ctrl_assign_mon_per_cpu:group=ctrl1/mon1/
>>>>     global_assign_ctrl_inherit_mon_per_cpu
>>>>
>>>>
>>>> # echo "global_assign_ctrl_inherit_mon_per_cpu:group=//" > info/kernel_mode
>>>>
>>>>
>>>> # cat info/kernel_mode
>>>>     global_assign_ctrl_assign_mon_per_cpu
>>>>     global_assign_ctrl_inherit_mon_per_cpu:group=//
>>>>
>>>>
>>>> How does this look?
>>>
>>> In addition to above I think it will be helpful to add a clear indication to user
>>> space on what the current active mode is, for example, via the [] characters.
>>
>> # echo "global_assign_ctrl_assign_mon_per_cpu:group=ctrl1/mon1/" > info/kernel_mode
>>
>> # cat info/kernel_mode
>>     inherit_ctrl_and_mon
>>     global_assign_ctrl_assign_mon_per_cpu:group=uninitialized
>>     [global_assign_ctrl_assign_mon_per_cpu]:group=ctrl1/mon1/
>>
>> Something like this?
> 
> How about making it clear that the whole line/configuration is active, like below:
> 
> 	# cat info/kernel_mode
> 	inherit_ctrl_and_mon
> 	global_assign_ctrl_assign_mon_per_cpu:group=uninitialized
> 	[global_assign_ctrl_assign_mon_per_cpu:group=ctrl1/mon1/]
> 
> 

ok. Sure.

>>
>> There is one problem here. The mode "inherit_ctrl_and_mon" listing not consistent with others.
> 
> It is difficult to predict what resctrl will be asked to support next. One possibility here is
> to make it part of the original design that the first field is the "mode" and the following field
> contains that mode's global properties of which there could be more than one. Above shows that
> the two "global" modes have a single global property but we could just try to be safe with some
> documentation that states there could be more.
> 
> Consider for example some hypothetical future where the file looks like:
> 
> 	# cat info/kernel_mode
> 	inherit_ctrl_and_mon:some_unique_capability=true
> 	global_assign_ctrl_assign_mon_per_cpu:group=uninitialized;other_property=val
> 	[global_assign_ctrl_assign_mon_per_cpu:group=ctrl1/mon1/]
> 
> To leave room for growth the file could start out by, for example, appending ":"
> to "inherit_ctrl_and_mon" to indicate that there are no known properties yet?  Something like
> below. Would this be more consistent with the others?

To me, it might be clearer to simply document what the default mode is 
when kernel mode is not enabled, and omit "inherit_ctrl_and_mon" from 
the display.

That said, I’m fine with either approach.

Thanks
Babu

