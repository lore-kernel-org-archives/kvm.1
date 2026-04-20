Received: from DM5PR21CU001.outbound.protection.outlook.com (mail-centralusazon11011006.outbound.protection.outlook.com [52.101.62.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F011939F187;
	Mon, 20 Apr 2026 22:59:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.62.6
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776725995; cv=fail; b=ULTIsoFQSOctVuqazUrUGciN2wdcRDoqXlcGxbi0sA55ODfvgMvb1eNDzFvq654ozbIK54dnbdoKKdUku9A+zVv7iZ8nLvz3yBXyHB71N3wPXv2tsR1fUNK7PobJBv/lqt2MuVbVbcBLILbQ07nNtm/cqsV2CK8lvTXvyyxDkeE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776725995; c=relaxed/simple;
	bh=bT1uaXSq6A48EJjYviDIec9PJEU9n4XgeF5ueh9dX7k=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=IqsCi5fOzGexB7Sj9L13ARGHbKWs6SbI3eKhtOEnc8gDEnazIcpV68FQ+OFCQv5nxMunIZ9x4z0+Dd8+1TynllOTafObte2FPiOowisifTefdy/VkQC8NCNpFO5Jzvv0t9N8HWV5vOqBVWIL1NdbnU8JDJ1YOddK8ZmvH0hsST4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=wmS2CC0B; arc=fail smtp.client-ip=52.101.62.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="wmS2CC0B"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WsS21OvGu5OVlKPZHTdz45MHOscKwGXdrAHe4pSB//X064BOSUcxENcZQp1O3e4F4VW8QcPH7LYNiUpQztgzLoMmhXZZ7rrDkulyNzzFH7G5WFBz6w6Y02MQTmZ4Rlo81Zbxh8PI1oBuf08iW0cRIW1nl0DsxffnWa4kPCwLfpOlPCi6f4Jz9n/kBmnIYz1ota6FJgxplcAJ8xVxC0nqzDbP71Wa9U+4MMd8Ij3JGHs3s5v7FI2ugE1aiPSSHmwx70RaduJQTtmYAMCPRd2fqmnxKHjcsiKgqEzYEGN4PpMGlZUcNy5UZJ3o53D04Lbt5e2ADgNWp1vvWVLYX9YsUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kVz8NbI7iziwkkkCKiFMkNXm5MduZbnB7ZfYFGHZSv8=;
 b=iUcn2iEvEl3LK2hXU2LV+0LZr8Kkz6cQK0btXL9DU312idoR+9/4l1eXwHvOQZVZt12IWqHuhIXrmSGXsJeG8LroxSBYyc3iWU17xJYswRVqj+9uKdPgSIvNkMH0rQ0JqXbShpLuK6nHtyTMsLMONLeg62WI1yRgTz8X2hpLzp0YYkGqcxRkZwXnVB5D6jKAAmAkpgr5Pi5zceG6RmdkteWZXoaPKN1BZF5Cc25jq/paPRrcL5QmcVZnhNtUEjuq8cN+Hg7/9N78q8A78cIJB8e5GsREwKwB8uART9HmVvFAlLwZq3n1wwzauNPW9tPDNeKiGG7CqFe4kRo+plOiXg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kVz8NbI7iziwkkkCKiFMkNXm5MduZbnB7ZfYFGHZSv8=;
 b=wmS2CC0BWgVDcHNSm6iYtNnzHfNXPMfOWrsMYZ2DWun9TEDa9mdyFE0LzrA18BcvyYKfx8lKWR0am4AH2tS3CjwSYVmR5b/LjOIcSLAEC7KgRLcN69uNn9/kppq52/hS3mBCG+MCuPsRzQhTSyepeYQoRJzykBAbJvh6IZGvWgQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS5PPFA3734E4BA.namprd12.prod.outlook.com
 (2603:10b6:f:fc00::65c) by DM4PR12MB6012.namprd12.prod.outlook.com
 (2603:10b6:8:6c::5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.14; Mon, 20 Apr
 2026 22:59:46 +0000
Received: from DS5PPFA3734E4BA.namprd12.prod.outlook.com
 ([fe80::d03f:ffac:bea5:143c]) by DS5PPFA3734E4BA.namprd12.prod.outlook.com
 ([fe80::d03f:ffac:bea5:143c%6]) with mapi id 15.20.9818.017; Mon, 20 Apr 2026
 22:59:45 +0000
Message-ID: <99a2da36-6a21-4a99-98e0-3c9a4cf7ecf6@amd.com>
Date: Mon, 20 Apr 2026 17:59:40 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 00/16] fs,x86/resctrl: Add kernel-mode (e.g., PLZA)
 support to the resctrl subsystem
To: Reinette Chatre <reinette.chatre@intel.com>,
 Babu Moger <babu.moger@amd.com>, "corbet@lwn.net" <corbet@lwn.net>,
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
 <39e0c786-cc35-4555-bfb9-ff7cd758c423@amd.com>
 <b74cfe34-e23e-49e3-beb4-d5639d42d5cc@intel.com>
Content-Language: en-US
From: "Moger, Babu" <bmoger@amd.com>
In-Reply-To: <b74cfe34-e23e-49e3-beb4-d5639d42d5cc@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: CH2PR17CA0023.namprd17.prod.outlook.com
 (2603:10b6:610:53::33) To DS5PPFA3734E4BA.namprd12.prod.outlook.com
 (2603:10b6:f:fc00::65c)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS5PPFA3734E4BA:EE_|DM4PR12MB6012:EE_
X-MS-Office365-Filtering-Correlation-Id: 4ba6c2fa-420e-47fb-b5c2-08de9f3083a4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|366016|1800799024|921020|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	11lthWyhLu10hSL4y1bhLYFkqx0WrTSxLuOGD7C9vaxuuUokZEAxwkMoKen3zaPpi+irDwqf+JlRk0uZG/F5NBmI1U/EndISvmpTEFj5bGHlqS52m0tFsgwmh2zZbUcJzI53Kzv+3BRPANvbWZlioTcFc4HHPz84AGrHibMfZ/ALPu5NkxUYI/2ArppPcD9Bbgpvach7AgWPcBJ28VUMMZc83af4fCp7nDhg7fIxlXbiVdNGxSLmlxzyfGsGraBroKqQB7dRgUDa4Y4YVgPARvkKGEBIhE6VbunD8Bh4U91sP53YQyhcX2xhphGU8SOH4EAMbSEV8jMsYb99Gw56SLfRdYcOgDoSQ615udC+nu6JtGjMNmVW/LQJ/JbAORSHALtpZVw/tPmXz6q96eNxxU78CqLh7Qe3X09LPTHEA4XP2MjzNgE3/qzztl5L+gtNuNYeRnZEGVAGsoAjHBZy4FwXgVM8n57LyL6Wcepy38+LOiUDYnQPo1soIjpyupBXxAw4fBX7DQEIjx1rWZwgWBEGuuIiiheN02Ml2Tac2c2EVTKH6ix4ZsxnhDWK5hJRhxCujXayfxRwcTlGu61+RcOCYlrJ+cBEQz2woinsevynAmIlmpJ2aBdQZWvQ9j6FkHTgxYfl3FNaV+wIuhY5FEXXQdizUdaEKI3UzLHG7zTRj8/ZUvMjfcMp9Dje3X4gzMv9jXVxk2RkAx9raHGoZ93sZ6Xq821BnsIoa27fs9q98bBYKH9rMJGA5cM7ZuEJISS7f/2wQ8PCV9YoFvkKpQ==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS5PPFA3734E4BA.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024)(921020)(56012099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?TGxRN2ZlZTB0eVpmaVl1ajdHS0NtK0VKbTNabm1pQjgrRGF0Z240QXRuT3NL?=
 =?utf-8?B?QXJqZ3drS2Jkclk2QldQNUhmb1FJa0tZZXdGbWI1c0VvdGo1QmRQU005cFZo?=
 =?utf-8?B?YWs4YzBRcVEvM1crTUMxcFlGNERLby9MWCtkdHpIaDU5R0wrZHppYUVkN0xl?=
 =?utf-8?B?ZHBiMHFBSFFzWWZ0bTJqMGoyWlE2S2NyRzFnZ1pLOFVqQVZNZXVmRzRnVFdW?=
 =?utf-8?B?RVg5VFk2RU16cnVvRWdHc0pzVlRpRk9lOWhjdmcwanlwckQ3b1lYWWVoalAx?=
 =?utf-8?B?eXJ0Y3cwcFJwRk1CcS9kQlAxWVBZTWJpN3lyeXU4VkRwZUtNMDNUTmsweGs0?=
 =?utf-8?B?VmpwMXAzMGs2S2tFaXYrUDlhcDJ5eC9EVzZGdGNwOVFJVkVoQllDYzJqWFZZ?=
 =?utf-8?B?c1dyaGxQNmVEek12WlJodE8yYWhZTHlRVzlDV1B5S0dQNnc2TEdmVWVwSFRn?=
 =?utf-8?B?M0doeGV3cmV5OE9wZjRLc3lBVzQ2c3JXWlJDcTZyTDhPeG1hNGp6VW1sNDgv?=
 =?utf-8?B?RnU2R0Q3Q2VXVnN5L1paOE9ic2xqMUFteFhyaHlhUXU5UjFyMy8xa25yYzRX?=
 =?utf-8?B?Uk5yWDRrbHVnb1l0RnhsSEVtMTgzcjFRb0ZHUDVWb2txWVhSSkxkeXA5NFNW?=
 =?utf-8?B?SVhnbm5CVHc0R2MxVkw3aE5ST0VHbERkcU50eEI5WU5DNkd2SE5rVjhQT3R0?=
 =?utf-8?B?YTZuRWV4QkdBN003RGFOaUphenRVUHg2WmRqV3B1V3FvWTJnSnBTSUhGMG9N?=
 =?utf-8?B?c1UyVEhVU25hZUh0YnpiUVVlS0VrWXhNMGU2bDRkZ3krcTMxeTBsSlhOeXp1?=
 =?utf-8?B?b0d3ZjVXQ0tLWUZLaStqSTlFd09scU14ZmxtMnd4MUh2THd2cGpST3M0Qlpa?=
 =?utf-8?B?ZWEyYWcwWkJWWW1qbWhWc081c2UzNkdxRkwvUXdHYjhSU045RVhPajFsQ3FV?=
 =?utf-8?B?SFZTNVNQdVp3dHY3MitNRytvRWp4V2N6SXcyNFdTT3kxTEE2WTdHaEtLeUI1?=
 =?utf-8?B?eEh0dklIamppbHVTUXdORm93ZitwbzMxakc0Ymp3YzVTQnB5Y0tkbWprcFdF?=
 =?utf-8?B?blVubW5qMXdSbDFuVW44M2d2ekptWWFpS3p5dWdCLzZhUk82R0ZEZWdreVh3?=
 =?utf-8?B?Kzdlc2FWYWhmcGxSa1AwZ3JLSDJ6NmMyVDBYRDEza2tGekxZdjNGS0VSRkRT?=
 =?utf-8?B?VnBJbjhNNVV3OS9Pd1BkVGM4UVF3UGkrbS8zSW1ySTkyS3BFTm9pYzFzL0Nj?=
 =?utf-8?B?eU0zYis3RUJoL21QSWREMThLdDRlYU9tbzN4WlQ4MDNRZVlNZW93RHB2Sk1k?=
 =?utf-8?B?cDlzdGdQam1qbFZBd0Z4dnFpZHNYUHM3eUtZa2xFbVFHbzlQeVkramVMVmo1?=
 =?utf-8?B?QjV5eWZmOFdMUlg1WWo0SHJIRDZsQUt2eVJaeTcvWHBJQmNwZWE5L0FlbjBB?=
 =?utf-8?B?L2NSa2lqWldISmowNmZzaW1tUHJhK085NEpVbnppZlh5WUZDZFl2K2NxY3NF?=
 =?utf-8?B?MXJ3MjJ2ZHZtZUt0NlR1MHRacUxaK0FZVDJIZmxvWFFxRFY1QlNzQWlOQndp?=
 =?utf-8?B?aTRNekV5a3pUVlhnL2MzNGh5blhwRjQ1K0RSSzFBc0tjM2tFMnlldHlMSUhs?=
 =?utf-8?B?NUpVNjA5U2VtZlRvZ0xlRGFWbEZDMmQrdFRSY09zQm5FQ1NPTnNBaE5CWmlQ?=
 =?utf-8?B?MklxWDZVS09haHFYU1NEaThCUkxxbHo4RVp0K2JNeVZtMXA3RThSQ3A1U0Nu?=
 =?utf-8?B?VjJ0amlPWEpaaDJjYzg4ZGlDSW5oT0dyR3dsODdYdU90cDZFTkRTWXU2eHFN?=
 =?utf-8?B?bG0wYnBMZmwyazZCVHhsQXVBZC9JbWVPTDNPb1pxQnVXb1JXVTlReDg0UDBU?=
 =?utf-8?B?ZW1EUEJPVjVMUEE0ZGdqclVGYTEzSlJDVlFvSUQvVDdpVWlKZzZvQmdqN2w3?=
 =?utf-8?B?anN2ZXMzV25WenBOL2NYbGtrSDIydG1ESHBtQ2FJdXBLT20weUNlc2s0aENI?=
 =?utf-8?B?eTQzSlViQVpnaS9zLzhicFBTdGFLdm5MTE1jNU5SRVdZOTlKYjR0MVg4RGxE?=
 =?utf-8?B?dXZyTlA3c1RNMzcyQjg4YjdVSm5zZVFnNEJCbHh5eFJhSE9tTDZZc2pzUFlP?=
 =?utf-8?B?Q21JaUFhOVlpZ2VYSFZua0pETjY1Zm5QeGo5VVRTNE9saFZBUVgxb3QrR1Fm?=
 =?utf-8?B?WDRkT1ZDTWM4enZaZllvQU91TXNNWHFkQ0wwcE0xMFdFUmZEdCtsQWpDMFRy?=
 =?utf-8?B?YnlzSnVRVXV0TVpTSkx5MUxOV2diN3NjWGtxQTdHa1F5N0VHeEtzdmJtQURC?=
 =?utf-8?Q?dANBCKNkc5lKbWEm+c?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4ba6c2fa-420e-47fb-b5c2-08de9f3083a4
X-MS-Exchange-CrossTenant-AuthSource: DS5PPFA3734E4BA.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Apr 2026 22:59:45.5791
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: c58vt1pkicOVtacv/HOfRtZ2u/B2l4MFjuhpoAE90423rNd3Kn+pl5mrashvR4zh
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6012

Hi Reinette,

On 4/20/2026 5:03 PM, Reinette Chatre wrote:
> Hi Babu,
> 
> On 4/20/26 12:38 PM, Babu Moger wrote:
>> On 4/9/26 22:41, Reinette Chatre wrote:
>>> On 4/9/26 4:42 PM, Moger, Babu wrote:
>>>> On 4/9/2026 3:50 PM, Reinette Chatre wrote:
>>>>> Hi Babu,
>>>>>
>>>>> On 4/9/26 11:05 AM, Moger, Babu wrote:
>>>>>> On 4/9/2026 12:26 PM, Reinette Chatre wrote:
>>>>>>> On 4/9/26 10:19 AM, Moger, Babu wrote:
>>>>>>>> On 4/8/2026 6:41 PM, Reinette Chatre wrote:
>>>>>>>
>>>>>>>>> When the user switches to either "global_assign_ctrl_inherit_mon_per_cpu" or
>>>>>>>>> 'global_assign_ctrl_assign_mon_per_cpu" then "info/kernel_mode_assignment" is created
>>>>>>>>> (or made visible to user space) and is expected to point to default group.
>>>>>>>>> User can change the group using "info/kernel_mode_assignment" at this point.
>>>>>>>>>
>>>>>>>>> If the current scenario is below ...
>>>>>>>>>         # cat info/kernel_mode
>>>>>>>>>         [global_assign_ctrl_inherit_mon_per_cpu]
>>>>>>>>>         inherit_ctrl_and_mon
>>>>>>>>>         global_assign_ctrl_assign_mon_per_cpu
>>>>>>>>>
>>>>>>>>> ... then "info/kernel_mode_assignment" will exist but what it should contain if
>>>>>>>>> user switches mode at this point may be up for discussion.
>>>>>>>>>
>>>>>>>>> option 1)
>>>>>>>>> When user switches mode to "global_assign_ctrl_assign_mon_per_cpu" then
>>>>>>>>> the resource group in "info/kernel_mode_assignment" is reset to the
>>>>>>>>> default group and all CPUs PLZA state reset to match. The kernel_mode_cpus
>>>>>>>>> and kernel_mode_cpuslist files become visible in default resource group
>>>>>>>>> and they contain "all online CPUs".
>>>>>>>>>
>>>>>>>>> option 2)
>>>>>>>>> When user switches mode to "global_assign_ctrl_assign_mon_per_cpu" then
>>>>>>>>> the resource group in "info/kernel_mode_assignment" is kept and all
>>>>>>>>> CPUs PLZA state set to match it while also keeping the current
>>>>>>>>> values of that resource group's kernel_mode_cpus and kernel_mode_cpuslist
>>>>>>>>> files.
>>>>>>>>>
>>>>>>>>> I am leaning towards "option 1" to keep it consistent with a switch from
>>>>>>>>> "inherit_ctrl_and_mon" and being deterministic about how a mode is started with
>>>>>>>>
>>>>>>>> Yes. The "option 1" seems appropriate.
>>>>>>>>
>>>>>>>>> a clean slate. What are your thoughts? What would be use case where a user would
>>>>>>>>> want to switch between "global_assign_ctrl_inherit_mon_per_cpu" and
>>>>>>>>> "global_assign_ctrl_assign_mon_per_cpu" to just switch rmid_en on and off?
>>>>>>>>
>>>>>>>>
>>>>>>>> This is a bit tricky.
>>>>>>>>
>>>>>>>> Currently, our requirement is to have a CTRL_MON group for
>>>>>>>> global_assign_ctrl_inherit_mon_per_cpu. In this scenario, we use the
>>>>>>>> group’s CLOSID for PLZA configuration, and RMID is not used (rmid_en
>>>>>>>> = 0) when setting up PLZA.
>>>>>>>>
>>>>>>>> Our requirement is also to have a CTRL_MON/MON group for
>>>>>>>> global_assign_ctrl_assign_mon_per_cpu. In this case as well, the
>>>>>>>> group’s CLOSID and RMID (rmid_en = 1)  both are used configure PLZA.
>>>>>>>
>>>>>>> ah, right. Good catch.
>>>>>>>
>>>>>>>>
>>>>>>>> Actually, we should not allow these changes from
>>>>>>>> global_assign_ctrl_inherit_mon_per_cpu  to
>>>>>>>> global_assign_ctrl_assign_mon_per_cpu or visa versa.
>>>>>>>
>>>>>>> resctrl could allow it but as part of the switch it resets the "kernel mode group" to
>>>>>>> be the default group every time? This would be the "option 1" above.
>>>>>>
>>>>>> Other options.
>>>>>>
>>>>>> Allow global_assign_ctrl_inherit_mon_per_cpu -> global_assign_ctrl_assign_mon_per_cpu. As part of the switch, reset the "kernel mode group" to the default group.
>>>>>>
>>>>>> Allow global_assign_ctrl_assign_mon_per_cpu -> global_assign_ctrl_inherit_mon_per_cpu. In this case switch
>>>>>> to CTRL_MON/MON -> CTRL_MON.
>>>>>>
>>>>>
>>>>> ok. Could you please return the courtesy of providing feedback on the
>>>>> suggestion you are responding to and also include the motivation why your
>>>>> suggestion is the better option?
>>>>
>>>> Yea. Sure.
>>>>
>>>> We need to allow the switch between the modes. Otherwise only way to reset is to remount the resctrl filesystem. That is not a good option.
>>>>
>>>> Allow global_assign_ctrl_inherit_mon_per_cpu -> global_assign_ctrl_assign_mon_per_cpu. As part of the switch, reset the "kernel mode group" to the default group.
>>>>
>>>> This option is same as you suggested.
>>>>
>>>> Allow global_assign_ctrl_assign_mon_per_cpu -> global_assign_ctrl_inherit_mon_per_cpu. In this case switch
>>>> to CTRL_MON/MON -> CTRL_MON. This option basically disables monitor (rmid_en=0). It is less disruptive. Move is between child group to parent group.
>>>
>>> ok. I am concerned that this creates an inconsistent interface. Specifically, sometimes
>>> when switching the mode the kernel group will reset and sometimes it won't. This inconsistency
>>> may be more apparent when writing the user documentation as part of this work. If you are
>>> able to clearly explain how this resctrl fs interface behaves (this cannot be about PLZA
>>> internals as above) then this could work.
>> Started working on these changes. May be it is better to discuss this before to avoid one more revision.
>>
>>
>> The current mode change behavior is very restrictive.
>>
>> For example:
>>
>> # cat info/kernel_mode
>>        inherit_ctrl_and_mon
>>        [global_assign_ctrl_assign_mon_per_cpu]
>>         global_assign_ctrl_inherit_mon_per_cpu
>>
>>
>> # cat info/kernel_mode_assignment
>>       ctrl1/mon1/
>>
>> In this state, we cannot change kernel_mode to inherit_ctrl_and_mon. The expectation, however, is that inherit_ctrl_and_mon should always map to the RDTCTRL_GROUP.
> 
> Could you please provide details behind the "we cannot change kernel_mode to
> inherit_ctrl_and_mon" statement? Why is this not possible?
> 
> I do not see "inherit_ctrl_and_mon" to map to *any* group though. Expectation is
> that when user changes mode to "inherit_ctrl_and_mon" then
> info/kernel_mode_assignment would become invisible to user space.

Ok. That is fine.


Sorry for not making it clear. Let’s consider the following scenario.

The system boots with these default settings:

# cat info/kernel_mode
[inherit_ctrl_and_mon]
global_assign_ctrl_assign_mon_per_cpu
global_assign_ctrl_inherit_mon_per_cpu


At this point, the interface info/kernel_mode_assignment is not visible.

Next, lets create a new control group:

# mkdir ctrl1

We want to designate this group as the new kernel-mode group.

First operation: Change the mode:

# echo "global_assign_ctrl_inherit_mon_per_cpu" > info/kernel_mode

At this stage, only the kernel mode is being changed. However, there is 
no way to know which control group the user intends to assign to kernel 
mode. All we know here is the selected mode.

After this operation, the info/kernel_mode_assignment interface should 
become visible. But the question is: what should it contain or point to 
at this moment?

# cat info/kernel_mode_assignment
??

Next operation: Assign the group

# echo "ctrl1//" > info/kernel_mode_assignment


Now the intended control group (ctrl1) is explicitly specified for 
kernel mode. In summary, changing the kernel mode requires two distinct 
inputs:

- Selecting the kernel mode.
- Specifying the control group to be used for that mode.


Hope this makes sense.

Thanks
Babu

> 
>>
>>
>> A similar issue exists when switching between
>> global_assign_ctrl_inherit_mon_per_cpu and
>> global_assign_ctrl_assign_mon_per_cpu (in either direction).
> 
> What similar issue? Could you please provide some detail to help me understand what the
> issue is? Isn't this what we just discussed in thread you are replying to? That is, you were
> looking at developing that interface that I viewed as "inconsistent"?
> 
>>
>> The same problem also occurs when modifying the kernel_mode_assignment group. If the current group is an RDTMON_GROUP, we can't assign another
>> RDTCTRL_GROUP without changing both mode and group together.
> 
> Same problem? Still unclear what the problem is. So far three problems are mentioned but I am
> not able to decipher what the problems are. Could you please elaborate?
> When modifying the kernel_mode_assignment group I expect that the interface
> will only accept a MON group when in "assign_mon" mode and a CTRL group when
> in "inherit_mon" mode.
> I do not understand what you mean with *another* RDTCTRL_GROUP. Only one group
> can be assigned at any time, no?
> 
> Reinette
> 

