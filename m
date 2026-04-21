Received: from BL0PR03CU003.outbound.protection.outlook.com (mail-eastusazon11012022.outbound.protection.outlook.com [52.101.53.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6A46303A04;
	Tue, 21 Apr 2026 16:46:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.53.22
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776790004; cv=fail; b=ATboCOF8LBqiuk+ZYe+K1RraqYlAxdb4VPEws5H5Revte1zII3d3mX0KVdA+LHQKxrwW0uc3oXoodyjHFhdw44O4uLWOMjjcUnsw6JE7QUnJrnXkBFUpPnlqs0TQaoAs+PaDfrU2yV7i8J6Afoq69MOjIc7w+ezYe7PwtUt0W24=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776790004; c=relaxed/simple;
	bh=6WCgYrK6z9nXGm5+xsJiVgiKq85jx0J9lZUJzc6lZjY=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=XPUi4ndVeICWfdyBYE5nTcZt5REDLUFGf7CF9q+RplXXDODP3lDD/9nb4xkhFs/+dnTxcNesmIk+OkUEKHGq4FYGmmezQhVrsFGPKL8ICAHD/sydwEZl4EHCf9qMedOoPEuMi6FyI9slPaFOqndNxRCWH5TRryypGCtHXL4P/+g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=1vFFFefS; arc=fail smtp.client-ip=52.101.53.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="1vFFFefS"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AfzgbAXZObyzy1E5uVx5cbl5mK9dV/LdvdC9BCQ5PxxyAcMxCzs8GY8/bJYF/v+ypY/rr13YglPlTeWGMonbgNvZxHWov55QyZJg2i3SnlfXs3mROzzeuPC/YSbZh3OvDG+elaj443DMugQwx4fJVq1o6nJjlFLyffdVkU8dc8YYUZZQ76ZGkQbV0GFdD0Sb50OkLwiIPtUX/dqb9BMuZeFjeHNsDtAK3MVElduG72JvX89FHsieSYqxe8C2Selg3gtlJUq0ZNwDEyHNaXG0PXMZtiMW3mlDCKUSJo1dtrLRuoABVzTkhpgE0wloMb/7n3vDHJPteOGk6RDVWFD1hg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wZrNaoJue3rLuXs7Jfpxd4PehJHag0pQTskQBxOp+Zg=;
 b=Z6G5UvSKWGLZn6BtnucxItGsGB2RechmRNmgPX+nGlFYbeXzecZoM1TJjxDwJ/L3/4oGQE+vTFegqk3F55ljJiFGgDBMuGs3zvk3x0VwBv/j1C3hdzHVUOiz8d4osKucwG78zZlJY+K8nB2V3DK5SKp5JTkzw33pAsVY57/UIh64U4Jm3f7qyu/HlytKy65lJOe5WKQM/a8XRiCFtuu0BsZUWaWRwvaCec5+YnnBUHvVduuH2muYYvz7whshnx/7UsLLOV9Eqzgro4JSfD/ATXvQd7gnspdVEG9+9jHNrRbWB8Jr3kTUHBmeq6SULH+6WeFm9tVPjKQsHZC7Y03lNg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wZrNaoJue3rLuXs7Jfpxd4PehJHag0pQTskQBxOp+Zg=;
 b=1vFFFefSWfExO+XJninNoJr9qGik4HtBifiaMyK/9wGlhGCnvogLkPr0BjZvL++DvKlG3IiUTbUZlihtDlqdiCMhVyOi57igxhHXf6V6I0XdOvdDeoQs2hQl17KoNlw6wiqO56xwpHmnr0og6dL+kaWWEbz17L5YcB8PqZMcr1c=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS5PPFA3734E4BA.namprd12.prod.outlook.com
 (2603:10b6:f:fc00::65c) by SN7PR12MB7299.namprd12.prod.outlook.com
 (2603:10b6:806:2af::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.16; Tue, 21 Apr
 2026 16:46:36 +0000
Received: from DS5PPFA3734E4BA.namprd12.prod.outlook.com
 ([fe80::d03f:ffac:bea5:143c]) by DS5PPFA3734E4BA.namprd12.prod.outlook.com
 ([fe80::d03f:ffac:bea5:143c%6]) with mapi id 15.20.9818.017; Tue, 21 Apr 2026
 16:46:35 +0000
Message-ID: <a46f4f2d-e3f1-454f-b94b-c54e14e45a69@amd.com>
Date: Tue, 21 Apr 2026 11:46:32 -0500
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
 <39e0c786-cc35-4555-bfb9-ff7cd758c423@amd.com>
 <b74cfe34-e23e-49e3-beb4-d5639d42d5cc@intel.com>
 <99a2da36-6a21-4a99-98e0-3c9a4cf7ecf6@amd.com>
 <741aa53e-461c-4a1a-a701-6060d42012f8@intel.com>
 <e8530c71-fde2-4522-8b46-a24efb13b681@amd.com>
 <71099958-1ddf-40dc-8a3c-aa13d0c56fee@intel.com>
 <e624f652-f0a6-4926-a0ab-c4486d41eb6d@amd.com>
 <8d969f11-4a7f-4e36-b85a-c3ed714fc603@intel.com>
Content-Language: en-US
From: Babu Moger <babu.moger@amd.com>
In-Reply-To: <8d969f11-4a7f-4e36-b85a-c3ed714fc603@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: CH0PR04CA0069.namprd04.prod.outlook.com
 (2603:10b6:610:74::14) To DS5PPFA3734E4BA.namprd12.prod.outlook.com
 (2603:10b6:f:fc00::65c)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS5PPFA3734E4BA:EE_|SN7PR12MB7299:EE_
X-MS-Office365-Filtering-Correlation-Id: 2732f100-46ee-4767-8508-08de9fc58d03
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|7416014|56012099003|921020|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	ZzI72755/QLalw9Yu/Z26dUYy7V4a9GHRMS9A9kG7pJmBvpnzcxK2MTwaostPI5QP1Rt3w5MR5RUbHc6d+yqw5sfRnESQQBi2y6n314U5VMAIBhdVyFPrDZTPNnUaE/tyGyX9j6+Bra++g0F8jZ26PBcVk6m1am6fUXpK1dUdJPOcpX8b6F2a1ETGlI5x1in90umJrBYD570Gg66zJOA6P1iqXzx6yEMELSWDkHshdP5+pKxlTegcl5K9soluPDti0gGyJdTvxMRTFDAou+DDARStR+267ZbKrfDYEC7hP2pDnQkfqlBer6fJN4AO/K1oF9eAZX/lADDkrONCBcF5VMEhb1oLUAfHJiQmG1IMGkvuotgSo29fh6NpNcjCjcmMEYbrOmSM8zrYJI5ppPXiWs5oT47ee/+yvu16eN9D0/yyjF25j/zEFILobWlOGS5NHMKK9QeT1ZsqqQDcNBuOylS/+MpQPDlXQXUt2nloFdeBFevwIOl+YZsID9HO3xhSSPruOGeTzYwIXEnNYWh4P523sf/tcw+XmoQCEm6cT8FrXe4nHDhWefzB8o6kPmXWFGrmbzTXPGJN5xmz1w51LqDawq0Yqy2u0fSJNidb5KJ603Gji8UiLTahwIvt3Qoslez6EB3Wvw3SnFZpS5o4OHI830bpECa+Fv8Z+BxviF4mSwGsbJZuNr/8HCIRfoOkOXZNhlvdcUg3CUdPjcX5oZXuKaoiJbBkK8RG6C/AL0/0MLwiBjNY4cf3vPyRTbw
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS5PPFA3734E4BA.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(56012099003)(921020)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?QkVPTzlWVUVpMVl0ZWlDakxmMjFUWmRiTDZTR2dkdkU2bnVXcmZWWWthME16?=
 =?utf-8?B?RUZ5ODVJME9uc05WR1hFV1p1RXJzTVFCZHVSUmFlMGsxRitoN2VDNy9XN3E2?=
 =?utf-8?B?ZTBrRmdsemVjY0MweFhrUTZjRmVnbjIzRkVhQm4xL1JYa2k3MEhpUllyNHR1?=
 =?utf-8?B?cHhMRkNFNmhMSjI0MzRRd3laUGVHempVcnhQWURlNG9OellJMHdUam5XUXVm?=
 =?utf-8?B?NUdKUWN4bXM0a3B3b0diODVacVQ0ejRrZXpiSnNxaUFqVTNBM1BLNDFNRXdS?=
 =?utf-8?B?WGJnZnh3VnBWS2hjSDlzdk9HRURWOEJHSnRnWHhoeVltSHVsU1dmRk5FQ25P?=
 =?utf-8?B?YjZXZWpnanRlUXM1WmMwVytXaVV4ZzA3VlZKWUdTRVJGbGk0Y253NklDcldS?=
 =?utf-8?B?aDZLUUY3NzR0YXRGTmZnUzliM1R3b0l2aUxCZTVsSEZ2cjh0SjZDUlhURFh0?=
 =?utf-8?B?SVRqbHQza3JZNms2SHdLVlpPdWg1WEFobnlQMWdGV2NVWHdXdGFVYnBhK3Mx?=
 =?utf-8?B?NWxMSE4ycjdMYmJDK1BuazRQUmlXdUVvODFiQUdiSWZQMmQ2d0xwV0RaMnN5?=
 =?utf-8?B?ODBCaHQzcGM0MXl5UTJacERNYzZseWQ1UVZTNWRUZDJRRXp5VUgzK0RWeEJy?=
 =?utf-8?B?aUpFcWtQaWJVVWR1VWE3Y0VFcjk1WXdBczlkMkFwdnYya0hGV2YzdFYyTG4v?=
 =?utf-8?B?Tk9wNlVBQ1dRbS91VnN3NEFURmtUMjNkZm5aQjEzcGowZHFsUk5SZjVrMWUz?=
 =?utf-8?B?OUIxSWYwZXdPUWlqYnNNb01QT25WVjkxeXNEUlRzTjVGb3NMcUEzWmF3eVVt?=
 =?utf-8?B?Y29PcTlzRGNNYkNxK21UZ2dTWjZ1TGhweGI0eVNYc01Ebno3QkZld2NuTDYw?=
 =?utf-8?B?N2JFazFzdm1xY3o1OWduc1lKaWNtS3JUdzhrN1dQYmM1YVZ4TEtZOEFwdEFL?=
 =?utf-8?B?MnczVjVEN2JSTlZ5VGVpYkZNdUVUVU91d2xLWUNCODhxVUcxZjZDZGdlTU5J?=
 =?utf-8?B?d0xXWjFKS2dVUy9DcHNYWVJGUmNCa2g4UGlXYklMQ2pFc3hQaWpxS1R5QlNE?=
 =?utf-8?B?V280U25TQ3IrNWo5MkpOZk9hSklhUzRoU1NIWnNodUJWRUl6dUY1eFBZYjZQ?=
 =?utf-8?B?ZGV6d3gvbVo4b2VTK2ZGdGZKNXRveCs4TUtGci9UT09ORmF2T3FtYjd3L3dH?=
 =?utf-8?B?bXJJdExRR0MyK1ArWmtEeGRrUGlySG5DSHRvZjJyWmhWc3hRYmZCNlNpUnEv?=
 =?utf-8?B?RTI1QnY1NC9FbVVFVGVVdWNYL0xtdVdwV0FrSkJkNitRUHY5UDlxNFdxeUto?=
 =?utf-8?B?WVVvd2dvS25MKzlZK3RIRnRscit3dnVDTkVGS2hCcGR2akN4czJRQXpBQzZ6?=
 =?utf-8?B?ajZqYUZSUXIvWEhWOTd2dkJ4WTNrYUw5TTRXUnZCdVQrZDI0MzNSbkpiZm9T?=
 =?utf-8?B?aHB4ZE85SHNTMVlsL0N5SVY1bkpqaDF6dHZ6QkFTaUh1emFyL2xkNVNTVHlv?=
 =?utf-8?B?QnNEeXpSWjlOMHIwL083bExmWXpkR0cvZ0NUNzBSaWpXSjVPK3lKblJsbGUx?=
 =?utf-8?B?UUx5dWdwNFV1dUVoZEpsb05XUTZFc1l2cmJwcWh3UHhWWU5sRGR1MHhwb3hl?=
 =?utf-8?B?WHFjRkpoWWdwOVRhb3F3M0ZJWTJ6c2cwM3ljbmNBdDQ3RlhldEQwUlhvUHQ4?=
 =?utf-8?B?a1V6RTBQcnZQKzlZRVgzcDBDWDFvRCtkcjM1OE5rUjR1ek9DR2xSMFQ2MERJ?=
 =?utf-8?B?bWNnd2Y0R3Rha09HYmhvVUxEZXhTbStRbm9XMjVGQVVqMmdvT0lsbXhZMVhm?=
 =?utf-8?B?ZHNEY2ltWUMwT1ppa05JbTNYZXBzTHY0dnhRbkFEQ1NITG05bi9aOVhGUnNk?=
 =?utf-8?B?N0kyZTBoZTJUaHA0eTNNSmYweXFwZWFIZW1uUy9EN3ZmeVBxcWxFVVovcUtn?=
 =?utf-8?B?MFNNSE4wSGx5WmpBbCtpYUt1Q3pVVkdpd2dEZU9ZbnhQWVJGK3pPejRpSWts?=
 =?utf-8?B?QTJxdzdNaXY3MWhtdHY3cjdKSHVWSUtCSTB2eUVnVDhxaXBSVi9JRFYyRkFM?=
 =?utf-8?B?UisxNjVxWDNqcXBqcmk0TlZNenhVOG9uV1F4cVQ2ZE5vc09TdjlhTWYyVXdy?=
 =?utf-8?B?QTM2NjNTckV5am05YXhiL3VqTjlXV28rcmJWaVh3Q05iaVlHQzdLOHhhQS9z?=
 =?utf-8?B?RHNVTm5ScDIweHNMdnJ3V2VLMDVDSVBQbFNhYzdNZ1NRcW1GamtJdVEvK0tD?=
 =?utf-8?B?N0FUclB3UnAybnBCR29EQzFDb0htbWlYamwvc0hKRTNXVGZoK1N1VFJwNmF2?=
 =?utf-8?Q?LC7qSwu0n9ZysjtHuP?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2732f100-46ee-4767-8508-08de9fc58d03
X-MS-Exchange-CrossTenant-AuthSource: DS5PPFA3734E4BA.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Apr 2026 16:46:35.8202
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gUO6n8xAWC+ILIrXJRuHev03p8fYzkeQpfDRV2UaBMRJNnaj0TOmtkLaPfLjXpKn
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7299

Hi Reinette,

On 4/21/26 11:15, Reinette Chatre wrote:
> Hi Babu,
> 
> On 4/21/26 8:08 AM, Babu Moger wrote:
>> Hi Reinette,
>>
>> On 4/20/26 22:17, Reinette Chatre wrote:
>>> Hi Babu,
>>>
>>> On 4/20/26 5:40 PM, Moger, Babu wrote:
>>>>
>>>> We already discussed moving back to the default group on every mode
>>>> switch. Doing so here would once again cause extra MSR writes on
>>>> each mode transition, which is undesirable.
>>>>
>>>
>>> Needing to avoid extra MSR writes in resctrl is not so absolute. Consider, for
>>> example, how resctrl initializes default allocations when a new resource group is
>>> created. resctrl aims to initialize with sane defaults and the user is expected to
>>> follow with desired allocations.
>>>
>>> I am not against optimizing, I just want to be careful with such general statements.
>>>
>>> Considering your proposal in https://lore.kernel.org/lkml/39e0c786-cc35-4555-bfb9-ff7cd758c423@amd.com/:
>>>
>>> I do not think we should make info/kernel_mode read-only. If I understand correctly
>>> doing so would accommodate AMD PLZA but it ignores the discussions on how resctrl could
>>> support MPAM ... or do you perhaps have proposal on how MPAM can be supported when considering
>>> your proposal? Even if you do not want to consider MPAM - what if the PLZA_PQR register's
>>> scope becomes per-CPU in the next version of AMD PLZA?
>>>
>>> The idea behind info/kernel_mode is that the active mode it identifies indicates which
>>> configuration files exist to configure the active mode. Since the mode may not always
>>> depend on global configuration, for which info/kernel_mode_assignment was created, but instead
>>> rely on per-resource group files, I do not see how resctrl can build on a read-only
>>> info/kernel_mode backed by a mode and group change via info/kernel_mode_assignment.
>>> Specifically, MPAM support may not use info/kernel_mode_assignment at all.
>>> Instead, MPAM may use something like described in https://lore.kernel.org/lkml/aYyxAPdTFejzsE42@e134344.arm.com/
>>>
>>> Could we perhaps consider dropping info/kernel_mode_assignment entirely for
>>> AMD PLZA's global allocations? Similar to what you suggest, the mode and
>>> group assignment could be done via the info/kernel_mode file instead?
>>>
>>> Thinking about this more since the CPUs allocation is global, these could *theoretically*
>>> be included also (but see later).
>>> This could mean that "kernel_mode_cpus" and "kernel_mode_cpus_list" could be dropped?
>>> Although, this may complicate the interface since user space may want a convenient way
>>> to modify just CPUs independently from needing to repeat the mode and group every time.
>>>
>>> Consider, for example:
>>>
>>> # echo "global_assign_ctrl_assign_mon_per_cpu:group=ctrl1/mon1/;cpus_list=5-8" > info/kernel_mode
>>
>> This looks reasonable.
>>
>>>
>>> Having named fields (a) makes this extensible, (b) output does not need to be split among files,
>>> and (c) "inherit_ctrl_and_mon" can continue to be supported.
>>>
>>> The named fields could be made optional, if group is omitted then it will become the
>>> default resource group, and if cpus/cpus_list is omitted then it will default to all CPUs.
>>> This may not be intuitive since a user may expect that not mentioning a field means
>>> that the field is left untouched. Have you considered this scenario in your proposal?
>>>
>>> As an alternative the group could be made a required field and "kernel_mode_cpus"/"kernel_mode_cpuslist"
>>> can stay? This may be the simplest approach.
>>
>> How about keeping a single option to update the CPUs using
>> kernel_mode_cpus / kernel_mode_cpuslist within the group?
>>
>> Should we consider removing the per‑CPU extension altogether? By
>> default, the mode already applies to all online CPUs, and any
>> per‑CPU requirements can be handled within the group using
>> kernel_mode_cpus / kernel_mode_cpuslist.
> 
> It sounds like we are saying the same thing?
> When considering all the sharp corners I agree that keeping kernel_mode_cpus/kernel_mode_cpuslist
> seems most user friendly. When doing so there is no need to include CPU assignment in the global
> files.

Actually, I was talking about removing _per_cpu extension also as the 
per-CPU requirement is handled inside the group using 
kernel_mode_cpus/kernel_mode_cpuslist. It can be documented.

global_assign_ctrl_assign_mon_per_cpu -> global_assign_ctrl_assign_mon
global_assign_ctrl_inherit_mon_per_cpu -> global_assign_ctrl_inherit_mon


>>
>> # echo "global_assign_ctrl_assign_mon_per_cpu:group=ctrl1/mon1/
>>
>> Why do we still need to keep the "inherit_ctrl_and_mon"?  By default all the groups in the system falls in this category it is not plza enabled group.
>>
>>
>> System boots up with following options if PLZA is supported.
>>
>> # cat info/kernel_mode
>>        global_assign_ctrl_assign_mon_per_cpu
>>        global_assign_ctrl_inherit_mon_per_cpu
>>
>> No groups are associated with kernel mode at this point.
> 
> To me it seems useful to be clear to user space on what the current mode is. If I understand correctly
> above default scenario essentially means "inherit_ctrl_and_mon" but instead of adding it to this file
> we will need to add documentation that describes to user space how this file should be interpreted.
> It seems easier to me to just be clear via info/kernel_mode itself on what the current active mode is?
> 
> I think something like below will be more intuitive and not need much additional
> documentation to understand (I am just adding the "uninitialized" as an example to match text
> printed in schemata file during pseudo-locking ... even if there is a group named "uninitialized"
> the lack of "/" could be used to make it clear what this means?):
> 
> 	# cat info/kernel_mode
> 	[inherit_ctrl_and_mon]
> 	global_assign_ctrl_assign_mon_per_cpu:group=uninitialized
> 	global_assign_ctrl_inherit_mon_per_cpu:group=uninitialized
> 

Sounds ok to me.


> I also think an interface like this would be simpler for user space to use as it (user space) switches
> between PLZA capable and non-PLZA capable systems since user space need not associate existence of
> the file with some kernel mode state in addition to actual content of the file when it does exist.
> 
> I assumed that info/kernel_mode can just always be made visible and not depend on PLZA
> capable hardware. This means that on Intel and Arm this file can show:
> 
> 	# cat info/kernel_mode
> 	[inherit_ctrl_and_mon]
> 

Yes. Sure.


> For Intel this is accurate and also for Arm if I interpret the Arm implementation correctly
> (see mpam_thread_switch()) in  https://lore.kernel.org/lkml/20260313144617.3420416-7-ben.horgan@arm.com/
> 
>>
>> # echo "global_assign_ctrl_assign_mon_per_cpu:group=ctrl1/mon1/" > info/kernel_mode
>>
>> # cat info/kernel_mode
>>    global_assign_ctrl_assign_mon_per_cpu:group=ctrl1/mon1/
>>    global_assign_ctrl_inherit_mon_per_cpu
>>
>>
>> # echo "global_assign_ctrl_inherit_mon_per_cpu:group=//" > info/kernel_mode
>>
>>
>> # cat info/kernel_mode
>>    global_assign_ctrl_assign_mon_per_cpu
>>    global_assign_ctrl_inherit_mon_per_cpu:group=//
>>
>>
>> How does this look?
> 
> In addition to above I think it will be helpful to add a clear indication to user
> space on what the current active mode is, for example, via the [] characters.

# echo "global_assign_ctrl_assign_mon_per_cpu:group=ctrl1/mon1/" > 
info/kernel_mode

# cat info/kernel_mode
    inherit_ctrl_and_mon
    global_assign_ctrl_assign_mon_per_cpu:group=uninitialized
    [global_assign_ctrl_assign_mon_per_cpu]:group=ctrl1/mon1/

Something like this?

There is one problem here. The mode "inherit_ctrl_and_mon" listing not 
consistent with others.

Thanks
Babu

