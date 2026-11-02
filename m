Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.93.194.35
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793627619;
	b=xyHWfmAwFgH8WIP67T/DlPZhU/NT1O1ev80fhkTjW3EkWiNtIszO9uEkXqTg+HhW9tLY
	 OUbkC428emdahspnuV1mLWTIwV0BbZyuc99oWjTWksqYKjhu/fyb86mKTq88iYPxOzu+1
	 ga9pxB7Nkzfwm8h3GQOuQmBeRtRi4nM4XmQuo6HMRmsBKtoIcISCpHSb6fNkwI+5FuqOn
	 +PpKfzu6l1eSkgamShwPCagDj63gKFY87xo5XA9h2EqJ3oTKxnynhNIC/+Sj8qVUBYf6n
	 WJTDc6C8XoVWBhkaPfQMP3AOAkdF4pY05GrxklpAd/emROdg+9b/2WdCb8oxIZMlqMw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793627619;
	h=DMARC-Filter:DKIM-Signature:Received:Received:Message-ID:Date:
	 User-Agent:Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-ClientProxiedBy:MIME-Version:
	 X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
	 X-MS-Office365-Filtering-Correlation-Id:X-MS-Exchange-SenderADCheck:
	 X-MS-Exchange-AntiSpam-Relay:X-Microsoft-Antispam:
	 X-Microsoft-Antispam-Message-Info:X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=87dMOpBO0neNYmwFh9hYpn2UyZlP02JeGpeUedI7B1k=;
	b=GpA1ntUAm6AD49qezz0w2188Sz73avOTadAvv6z8oS6arHtNNETTW+E+k29YQHiPzYu5
	 JBip7YOMCgsEXWeIF8zJDJN90c+jiEPlEHOPxqiCUVuUmF2JbARelLH0ME6rgPzv/mVSW
	 iORIjvvhirKGr6VkQxEqiYjO5Uo/qVQSJ/cYSxfOBx8zek7zuuvcvPf+IOIUMCx5PXnFz
	 B45YuwMieBkjXHqvDS+rebXq7j3aUcCKPe6HKBArIFZivqFW5NP1w5CD7SlOUs1Y2VGYI
	 0+u4nwhal4sp7Txm0S1xKQ0DmmCpC/Fd7gWqz566Bk+i6K41+cmRQKyFK+2vCAXD+yg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=amd.com;
	spf=fail smtp.mailfrom=amd.com;
	dkim=pass header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=Ai2xfCya;
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.93.194.35
Received: from SN4PR0501CU005.outbound.protection.outlook.com (mail-southcentralusazon11011035.outbound.protection.outlook.com [40.93.194.35])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3B14606A324;
	Mon,  2 Nov 2026 13:53:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D3B14606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=Ai2xfCya
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yndNuwvx1+GzNeTVOFz3Z4v5z1KngzfTnpOKSDAWnTz15vNcPtiHaNYUI2ywaZJ0MLQaYU18T+KDvInyN//RTPyJzjOaI3ZahW9X7M1PmcZIu6PXGb3WpOFN9fFTGO+jWPDflFGkmmLfIf4FcpssR6p4RsmcDO1P4/bxiVNFBCP9IQmfqriAOrNOtsMpQVaodT7deloA+rirzll7cYdTf9Wo3fLy23VyolUBwW8GiwzSydW3tI9croAHXCDyJakTpSXgO/JJSDVt4p0fm4TD50AfyBmqqjDFAfZmUkkq5o17ED1CTGWdE7BJMJOOfs/jOJbMLRaiM92P1PPAEyWf1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=87dMOpBO0neNYmwFh9hYpn2UyZlP02JeGpeUedI7B1k=;
 b=iYWH/bSCfbeesie08LK6qcfd2i8sR5eIN40JdKPUbB7+PW/7adRx1Kr3FqolVLDqHzJnegEhIcyq1Q/BYxJiHnOQLIqxR7HDMy9KsdIKOf6FoIxrZUlRUa/uFa/vW2KJP4egeqlr2NBB9RTB9SESR7gWqGsVyBBZmiJMm+rbxDHmF7MJjTXpgQ6E63Ak6PMfWA2sjzHaO0o0QYugTp6BEvz6E3+wLJJGCbQu6XOKPhrJdHQTXWwFCevtT9FMAg3qjUFDamP4dWPBxNwG5/QhcQjpIxx25Hae3vJWVOfvQ6ipGLw/D6PkD71+OFISSxOF+z4L9fkP3w/HUDt0a8Fumg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=87dMOpBO0neNYmwFh9hYpn2UyZlP02JeGpeUedI7B1k=;
 b=Ai2xfCyasJFwT8ko/JrMhM2CEqteethWQzlxXqvaKKpOW/CjgXU7QTzsR/y5YdoWkhGElBwUvnFhz8hl+bB3DC9tiI4kNe9bB+tYoZYCBrxCuXmlrXCVtQS+jAiB4OKvQ/CA8LnRVY7zij8oFE79CcNA1HRhqjuUMe2om25twVE=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB5713.namprd12.prod.outlook.com (2603:10b6:208:370::18)
 by DS0PR12MB7771.namprd12.prod.outlook.com (2603:10b6:8:138::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.11; Mon, 2 Nov
 2026 13:53:34 +0000
Received: from MN0PR12MB5713.namprd12.prod.outlook.com
 ([fe80::cab0:6260:dd96:3fd8]) by MN0PR12MB5713.namprd12.prod.outlook.com
 ([fe80::cab0:6260:dd96:3fd8%6]) with mapi id 15.21.0569.011; Mon, 2 Nov 2026
 13:53:34 +0000
Message-ID: <0384373f-711c-4851-9d0e-b1a1e3d1d1e0@amd.com>
Date: Mon, 2 Nov 2026 19:23:27 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 03/16] KVM: x86/pmu: Rename reserved_bits to
 eventsel_rsvd in kvm_pmu
To: Zide Chen <zide.chen@intel.com>, Sean Christopherson <seanjc@google.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Peter Zijlstra <peterz@infradead.org>
Cc: kvm@vger.kernel.org, Andi Kleen <ak@linux.intel.com>,
 Jim Mattson <jmattson@google.com>, Stephane Eranian <eranian@google.com>,
 linux-kernel@vger.kernel.org, Mingwei Zhang <mizhang@google.com>,
 Shukla Manali <Manali.Shukla@amd.com>, Dapeng Mi
 <dapeng1.mi@linux.intel.com>, Xudong Hao <xudong.hao@intel.com>
References: <20260827223755.143247-1-zide.chen@intel.com>
 <20260827223755.143247-4-zide.chen@intel.com>
Content-Language: en-US
From: Sandipan Das <sandipan.das@amd.com>
In-Reply-To: <20260827223755.143247-4-zide.chen@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PNYPR01CA0078.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:2b4::9) To MN0PR12MB5713.namprd12.prod.outlook.com
 (2603:10b6:208:370::18)
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
X-MS-TrafficTypeDiagnostic: MN0PR12MB5713:EE_|DS0PR12MB7771:EE_
X-MS-Office365-Filtering-Correlation-Id: 94520793-796d-458f-cb7a-08df38e8afff
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|1800799024|23010399003|366016|6133799003|10067099003|18002099003|22082099003|56012099006|11063799006|4143699003|261021121427099003|261021123027099003|261026121527099003|261022075727099003|261022115727099003|261009223027099003;
X-Microsoft-Antispam-Message-Info:
	Uqx1fxGFS8fcHWkZb0DyZ310EWwsJ48FU/eldOMoJ1h3RjsLSDcFR5Lroy5lM6gNL/vsYhFty1D18FMwgj+Ag/urtIPvEzxK/1sgMDWW+jLIsk6VP1RQJjllyCMNXI9uDU7scvBHv5TUz3e8jV4BhlAItoyyqz9RrON+hCHUrNfy8GGiCKS7fZ6z6m/8OhwZWddU5o8n6zQXMSQO/y8z1nm1K/0HDTLx4w8zJQPB3ZkcRy2BJhDb7H+6N3IImUk7qO6FvhfaqzKjgMHxyhIpV7B6J6jyoZ7AUgu4wGh1eUFLbu5dSWKsDQkTE8bP8/Tu1F++pECdMENprzZc6WLmw80JQV4S6zfJT8twsdyIeid4GeV+rfS9hm//lWpjHOslYgi32GY6BOet9ITKBWlHInzyLJJtGX9ZXtSthxLurHX6OwUB2xrX+0TZI0uoiKL4I+JzTgJRtkDYZirXvkdTD7r8SuL1ZPS9FqgD663gM/rQ+LAjp/XVPfUScZZlOSHLA4zly74d+qQjb4oiOk5xdXei0WnaQ3vOkh6fN7bfcF1dvHBDBu0ACQD4xX63/AEjg52Czcs+ybGsu93LRZdHhM2FBlM+V/0VV15xAg7vo/RlZvyRUWXLreufBepZs6sx75wfC36iYCRc670koJKAktl3dBUBEfeoF0fRx2VTeL4=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB5713.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(23010399003)(366016)(6133799003)(10067099003)(18002099003)(22082099003)(56012099006)(11063799006)(4143699003)(261021121427099003)(261021123027099003)(261026121527099003)(261022075727099003)(261022115727099003)(261009223027099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?eGlLdm5uak9GK2lLM3crck1BRk5SVEQzV20zeERjUmlNcThlbkw1TXA2OTFo?=
 =?utf-8?B?S2tBUFQ2eUdaNnF1a2R0c3ppZjdwSDNxZjg2YTNtdnNnbW1vRC9xZGJ2eTVr?=
 =?utf-8?B?Q1pjd3E4NTBXYzRQM25PNzVjajdpVUJ4Nmk0WUo2VlZycVQ1MG54cE54bVJm?=
 =?utf-8?B?eEs5TVlvdnQ4dVB6SE0yb1Rlbk85WWhIcmVQU0h6TkRFQVJwVEdVb1Zra0M0?=
 =?utf-8?B?RjdIdElVN2c3aVdOWFlZZmIxdDdwUGV6NDBIdkRPMjNGeEJVLzNJbkN3QlF6?=
 =?utf-8?B?bTVMWEQ1MTRzUTF4VmljNmJOV2c3QVFuUDZVUUk4aEFnUGl5N1RQaVhwWStL?=
 =?utf-8?B?NVNkVUU5Tk9pYWQwRWhrK2FmUzcxSjdBOUVxcWdDbWdsWEhqM3RJUGFzMFFl?=
 =?utf-8?B?Y1JpeDFJWWVHMXJkMkh6Uk4zbXV6OGhYeDMySFZld25RUmFwQjhPdCt2alFt?=
 =?utf-8?B?UXlhUEdOK0ZUWG9XU2l4NHlXVXdZQU9XY0hyT3RkajR0dWJhYVpVK2N3bUpD?=
 =?utf-8?B?SGR5QnkxWENyNU01Q0J2dW9FQTAzeU82TU9xNGFMc2g5TVpTRG9aY2RPZzhy?=
 =?utf-8?B?SnFaY3FCWFRhTWdYS1VEMnlRUW9hWDdoNy9Ga2kvSi94S1pSTmVuN290R2hF?=
 =?utf-8?B?TGRKamVZeVFMR0luNVd0V1FKajk1aDJkVjFyNXdQdTlHVlV2Q0NOSmVtZGJH?=
 =?utf-8?B?YWlVZ2dCU2d2TzJzQ1FkbVNuM0xmKzk3OXVzdU1jWUJGcG1hTXAyWjh6QmE2?=
 =?utf-8?B?bFNlYjVOaGJCZ2xrSHBFUE1MR1hZZG1ZYnF3TGpCRkV0b1c4cEFsT1o4U2pq?=
 =?utf-8?B?c2Z0bDVRdTNHTU9jMTZ4OGs1bUlrbkhPYXA1a0NLWERYL0RpRmFwM2hDRWJP?=
 =?utf-8?B?aTY5T3pOekZ0WjFwcE56ZFViaUJsZFlER2FkODBEZzJEbzdNbFFPRHhoazht?=
 =?utf-8?B?Vm1XSG9RMzdveTVNeWtlS0drbnk0RHBteTlqNTVvYjJSK2tXblg0M3Y2b201?=
 =?utf-8?B?UUdWcHV5SHBCUDN1SGZsMy9tMHkwNENhK2VDRFN0Y2J4WFhZRExMbXdBNG1M?=
 =?utf-8?B?dTFQNkNYenc0eVNkQi80a2JGRXpSNTJqVlNLQ0xlcXNHcnNpYUw0VXpRZEgw?=
 =?utf-8?B?TE1WUDVQTldldEdkclVKb0dMenlGbkJ4Tm1teXhPS1FJb2QrY2JGdU9Wei8y?=
 =?utf-8?B?bHcvV0hDTnRUclpKZTJmTmtFU1N3SHVub1RlTEdFK010Nzlqenp6NStnUmVT?=
 =?utf-8?B?bzhLWnNvU29mSmcxdVAyMW0zelNjdlNUMUZSMDN0OUczNGtUZlFoL0MxcmJv?=
 =?utf-8?B?b1ZnNDM1WUlNREtlbVdtZysvVmRQTUN5MjV4cWczNXg4dTJvTjhWbUJQbWRi?=
 =?utf-8?B?WnFTNTBWZFk1RzBBa1BCb2U0b1hrV0NBRURxWGdDRU1FM3RRLzFUVFhqWlJQ?=
 =?utf-8?B?MURFMEhLNTlmdjQwUEZKS0h6d0xIWU9LR1U1N0p5SVlFTnVkTGswb2VoYlZK?=
 =?utf-8?B?VWdQYlBUbWFoSVdyTG1rSzFqM0o1ZkVEaVFYb3kxYXo0VEE5L0pZVnU2aDU3?=
 =?utf-8?B?UFdNU3dicXY4Y2pmYmdEWitJWFpRTzBrMFZ2ZnhTTVFoa0dSb3V0V3NaYzFx?=
 =?utf-8?B?eWJvcnBPSkVTWEpOQnhmTnNEZlFkMXBCNDBJRVZ4T3pzeVcwVU1Cdkw1TlJC?=
 =?utf-8?B?Q3ZMU0EyQjFMVnRvb2RvY1JURWNLYmIzZTh2em9rQ1J5bEFNRktIclVLK1RD?=
 =?utf-8?B?ajcxQjhSL3F5Q2lOcWZhMWl4SUlMdXpJU1ZtakhnWnBKWU43L0NQUk9xQXZv?=
 =?utf-8?B?Lyt6OVVTZHl6QzM0S1lRaHUrUGRuaS83SnNjWE9CSjJmbHBqVFhLQmhlMjdt?=
 =?utf-8?B?aTkvMjBhcEJKYU9SMnVnNWNpZVYxMTdoM0g4bzJWdFFoK0k3VEF2QUdtY012?=
 =?utf-8?B?dzBaVXowR0JxbVAwUTdUVFhxcHB1TEN1eFJ5TlFpUUowV1doYWJiMW54aUJL?=
 =?utf-8?B?MHlKUDJ2cDE0UXdqL1QvSGwvLzFZQllNTzM5Skd5cS9WeDhtd1h2R1dZOHZ2?=
 =?utf-8?B?VFBrOVo5bDg2bGRlL2tsNGNlZFViZW5aVzEyUUtQN3pIVlNlczljTnlrdXBn?=
 =?utf-8?B?U3dLQW5rNnlLaVozYXFOdzBzaFIyYkMvSDFnS1VwMkNQR2xqNzFjRldyWWdn?=
 =?utf-8?B?MTJrckFBQi9hUlFXTGcrQ2xkYWZCMnFjSEVsSjVxWitqV1RlTDNHSnM1enAw?=
 =?utf-8?B?bm1TNW9WT2h6RGRPVHlxN2VGb1FkTEJZLzdEUXVJdGN3T2JsbXhWazZla056?=
 =?utf-8?Q?4yrXUapouL8TGAS6Lr?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 94520793-796d-458f-cb7a-08df38e8afff
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB5713.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Nov 2026 13:53:34.7610
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: orLrexkThzrsHU86eeN8o86FciCIitMb85WZFocE8obhtIKoxI4Mu19tz4XK/5rdIwDwDrc9NzmgKh8nGXxOJA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7771

On 28-08-2026 04:07, Zide Chen wrote:
> This field stores the bits that are reserved in guest IA32_PERFEVTSELx
> MSRs. Rename it to eventsel_rsvd to better reflect its purpose and to
> align with other field names in struct kvm_pmu.
> 
> Opportunistically, replace the magic number 0xffffffff00200000ull with
> macros.
> 
> No functional change intended.
> 
> Suggested-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
> Signed-off-by: Zide Chen <zide.chen@intel.com>
> ---
> v2:
> - Replace magic numbers in AMD pmu->eventsel_rsvd.
> ---
>  arch/x86/include/asm/kvm_host.h |  2 +-
>  arch/x86/kvm/pmu.c              |  6 +++++-
>  arch/x86/kvm/svm/pmu.c          | 12 +++++++++---
>  arch/x86/kvm/vmx/pmu_intel.c    | 12 ++++++------
>  4 files changed, 21 insertions(+), 11 deletions(-)
> 
> diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_host.h
> index e473796da7d9..90d80483df7f 100644
> --- a/arch/x86/include/asm/kvm_host.h
> +++ b/arch/x86/include/asm/kvm_host.h
> @@ -580,7 +580,7 @@ struct kvm_pmu {
>  	u64 counter_bitmask[2];
>  	u64 global_ctrl_rsvd;
>  	u64 global_status_rsvd;
> -	u64 reserved_bits;
> +	u64 eventsel_rsvd;
>  	u64 raw_event_mask;
>  	struct kvm_pmc gp_counters[KVM_MAX_NR_GP_COUNTERS];
>  	struct kvm_pmc fixed_counters[KVM_MAX_NR_FIXED_COUNTERS];
> diff --git a/arch/x86/kvm/pmu.c b/arch/x86/kvm/pmu.c
> index 8f2effee3b7b..964e74bdaaa7 100644
> --- a/arch/x86/kvm/pmu.c
> +++ b/arch/x86/kvm/pmu.c
> @@ -989,7 +989,11 @@ void kvm_pmu_refresh(struct kvm_vcpu *vcpu)
>  	pmu->nr_arch_fixed_counters = 0;
>  	pmu->counter_bitmask[KVM_PMC_GP] = 0;
>  	pmu->counter_bitmask[KVM_PMC_FIXED] = 0;
> -	pmu->reserved_bits = 0xffffffff00200000ull;
> +	/*
> +	 * KVM is not able to emulate the AnyThread bit due to cross-VM
> +	 * information leakage on SMT cores.
> +	 */
> +	pmu->eventsel_rsvd = GENMASK_ULL(63, 32) | ARCH_PERFMON_EVENTSEL_ANY;
>  	pmu->raw_event_mask = X86_RAW_EVENT_MASK;
>  	pmu->global_ctrl_rsvd = ~0ull;
>  	pmu->global_status_rsvd = ~0ull;
> diff --git a/arch/x86/kvm/svm/pmu.c b/arch/x86/kvm/svm/pmu.c
> index c18286545a7a..52224872e0d4 100644
> --- a/arch/x86/kvm/svm/pmu.c
> +++ b/arch/x86/kvm/svm/pmu.c
> @@ -163,7 +163,7 @@ static int amd_pmu_set_msr(struct kvm_vcpu *vcpu, struct msr_data *msr_info)
>  	/* MSR_EVNTSELn */
>  	pmc = get_gp_pmc_amd(pmu, msr, PMU_TYPE_EVNTSEL);
>  	if (pmc) {
> -		data &= ~pmu->reserved_bits;
> +		data &= ~pmu->eventsel_rsvd;
>  		if (data != pmc->eventsel) {
>  			pmc->eventsel = data;
>  			pmc->eventsel_hw = (data & ~AMD64_EVENTSEL_HOSTONLY) |
> @@ -214,9 +214,15 @@ static void amd_pmu_refresh(struct kvm_vcpu *vcpu)
>  
>  	pmu->counter_bitmask[KVM_PMC_GP] = BIT_ULL(48) - 1;
>  
> -	pmu->reserved_bits = 0xfffffff000280000ull;
> +	/*
> +	 * AMD PerfEvtSeln registers do not support PinControl, and KVM does
> +	 * not emulate AnyThread due to cross-VM information leakage on SMT
> +	 * cores (as on the Intel side).
> +	 */
> +	pmu->eventsel_rsvd = GENMASK_ULL(63, 36) | ARCH_PERFMON_EVENTSEL_PIN_CONTROL |
> +			     ARCH_PERFMON_EVENTSEL_ANY;
>  	if (guest_cpu_cap_has(vcpu, X86_FEATURE_SVM) && kvm_vcpu_has_mediated_pmu(vcpu))
> -		pmu->reserved_bits &= ~AMD64_EVENTSEL_HOST_GUEST_MASK;
> +		pmu->eventsel_rsvd &= ~AMD64_EVENTSEL_HOST_GUEST_MASK;
>  
>  	pmu->raw_event_mask = AMD64_RAW_EVENT_MASK;
>  	/* not applicable to AMD; but clean them to prevent any fall out */
> diff --git a/arch/x86/kvm/vmx/pmu_intel.c b/arch/x86/kvm/vmx/pmu_intel.c
> index 322a3ad580dd..11c9161dc853 100644
> --- a/arch/x86/kvm/vmx/pmu_intel.c
> +++ b/arch/x86/kvm/vmx/pmu_intel.c
> @@ -385,7 +385,7 @@ static int intel_pmu_set_msr(struct kvm_vcpu *vcpu, struct msr_data *msr_info)
>  	struct kvm_pmc *pmc;
>  	u32 msr = msr_info->index;
>  	u64 data = msr_info->data;
> -	u64 reserved_bits, diff;
> +	u64 eventsel_rsvd, diff;
>  
>  	switch (msr) {
>  	case MSR_CORE_PERF_FIXED_CTR_CTRL:
> @@ -433,11 +433,11 @@ static int intel_pmu_set_msr(struct kvm_vcpu *vcpu, struct msr_data *msr_info)
>  			pmc_write_counter(pmc, data);
>  			break;
>  		} else if ((pmc = get_gp_pmc(pmu, msr, MSR_P6_EVNTSEL0))) {
> -			reserved_bits = pmu->reserved_bits;
> +			eventsel_rsvd = pmu->eventsel_rsvd;
>  			if ((pmc->idx == 2) &&
>  			    (pmu->raw_event_mask & HSW_IN_TX_CHECKPOINTED))
> -				reserved_bits ^= HSW_IN_TX_CHECKPOINTED;
> -			if (data & reserved_bits)
> +				eventsel_rsvd ^= HSW_IN_TX_CHECKPOINTED;
> +			if (data & eventsel_rsvd)
>  				return 1;
>  
>  			if (data != pmc->eventsel) {
> @@ -545,7 +545,7 @@ static void intel_pmu_refresh(struct kvm_vcpu *vcpu)
>  	if (entry &&
>  	    (boot_cpu_has(X86_FEATURE_HLE) || boot_cpu_has(X86_FEATURE_RTM)) &&
>  	    (entry->ebx & (X86_FEATURE_HLE|X86_FEATURE_RTM))) {
> -		pmu->reserved_bits ^= HSW_IN_TX;
> +		pmu->eventsel_rsvd ^= HSW_IN_TX;
>  		pmu->raw_event_mask |= (HSW_IN_TX|HSW_IN_TX_CHECKPOINTED);
>  	}
>  
> @@ -584,7 +584,7 @@ static void intel_pmu_refresh(struct kvm_vcpu *vcpu)
>  	if (perf_capabilities & PERF_CAP_PEBS_FORMAT) {
>  		if (perf_capabilities & PERF_CAP_PEBS_BASELINE) {
>  			pmu->pebs_enable_rsvd = counter_rsvd;
> -			pmu->reserved_bits &= ~ICL_EVENTSEL_ADAPTIVE;
> +			pmu->eventsel_rsvd &= ~ICL_EVENTSEL_ADAPTIVE;
>  			pmu->pebs_data_cfg_rsvd = ~0xff00000full;
>  			intel_pmu_enable_fixed_counter_bits(pmu, ICL_FIXED_0_ADAPTIVE);
>  		} else {

Reviewed-by: Sandipan Das <sandipan.das@amd.com>

