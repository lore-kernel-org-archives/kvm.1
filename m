Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11010069.outbound.protection.outlook.com [52.101.84.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F3201F12F8;
	Tue, 29 Sep 2026 01:08:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.84.69
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790644084; cv=fail; b=aHqxGiFWq35Tv1bqHIWnWJN2F9kz22Ak76mtqlQzJOAWlsnW9iV3vSoSFx6qyztTrdgKbwhFB3wOLV8xyUJXcOAwLX9t/8KhtVAOCyO8h3DPLc5otf0Dl8a49tUKgfIA3DIjV6eEUPRybdAnpYfCYztwCLZXYRSgTPC0uqZTtO0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790644084; c=relaxed/simple;
	bh=pOaidSp5LdEjheAHm9cqtz029ZMNzO+UohKaD2ubZQ4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=N9CSgqSk4QPhpqldzL0BYNrrUFE2nqRE32qItUwkcsuIw7++p5luO3Mp1OjMABSvhm15MGDYrmP6pABJjldY3ciBYfFKb4+OHY/sNnDESCQGYifM+9HRqAwY4FKyqvvzhrDpiGlDJu1FGB49AgTHw4gERg34ZtH94tRIXMaqwgA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=Ui6LVGn3; arc=fail smtp.client-ip=52.101.84.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="Ui6LVGn3"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wx53j4xFmGHRVJuxp6rqs9+SkdCAo9HrUGxlyAQ6VsH//fSoNpymL5EELwXHLF+MxorSMKOjmYMMmYQz+PF84jZGYZ/80SZVO8Di/giWufw4vJ10FgTsv41upvi3o0XN5xnmOj78o1/6Md54gP+aK97hI0zKI7z9M7LBOaXiL9vUK1ZJegnjBfQmAHP1bG/8HwSJUcm1CNNYC1veKgzIdandtrpWYemqTgOW4bdlPtppFclZ7tlN/Kqu+kvXDZGb/dETN00arTIV6Ronm+87rfBGsF07kpgzaOA3Nadnr4SBbT8PHTqF8FK45B/z4WHzsgEzu9e567HwDggDXLa4kQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5TvbQB/wjnbpe2c6cso2CQCeT/P/wWxeobwLc2DE0t8=;
 b=AFgwWshxi7fEpBNVgAViS3cHqJPkZmLiPXRKice4M48d23HK2K4XP2+sjBG78JysC002uR4Wwnw+Q+3BH0nJ3KUVmp46QOkqQUuMeyRbTl1pCRRU7YVxznctj3ApAJ/CWG1jxnROyhZg9D8CodZKXPi0C+28cp4HRHhRz/VPBkwf8DA187RDtSRswlcV/TLltF9stE+crmMY7Px9wZSuffulbujNQzv9xmD1396S4el7YhRWDOr1VFKmD0oRvDMm4D727DtLYABJQJrKlVznFdQmyb+nDaPxSr5/NdOMe2M8IMQCN+2uNSRsx3K9aBxUKkE+VX9/itjDQrVOiK02LA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5TvbQB/wjnbpe2c6cso2CQCeT/P/wWxeobwLc2DE0t8=;
 b=Ui6LVGn30UoF4cbbR4ftyfP09oNlmZ8GhxCGhg02WEd177kPIjl9BY4K0fiZRUMRHWWp+bv/0jI01nwe+49kl3iIOf48aY+SuaPm94XSv7I/ZvcK9xmxYFmaLVNH3lYeCHBvwQTdzSevJdFR1CEmO5SIsAdk4GaBD3cNRiKOAF51Zr8NK1Cuu7sciDqqnsCCBMxLHzfY8vRS1fHHaEs3+jeOKITzMPbwgtoZbrOH074P9tK4AlpZ3aNHboEdCXwI0sH6a5Sk5j+3lpeTzktgQVsFtOEsIJWofwKzlPBz2IIZn6l5c23Jr0UPqK3tl4g5qVR/NeNFKaH+gT+g4cPiuQ==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from AM8PR04MB7874.eurprd04.prod.outlook.com (2603:10a6:20b:24d::9)
 by AS8PR04MB9096.eurprd04.prod.outlook.com (2603:10a6:20b:447::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.24; Tue, 29 Sep
 2026 01:07:59 +0000
Received: from AM8PR04MB7874.eurprd04.prod.outlook.com
 ([fe80::ac38:1699:6f18:c5d9]) by AM8PR04MB7874.eurprd04.prod.outlook.com
 ([fe80::ac38:1699:6f18:c5d9%6]) with mapi id 15.21.0451.022; Tue, 29 Sep 2026
 01:07:59 +0000
Date: Tue, 29 Sep 2026 09:12:26 +0800
From: Peng Fan <peng.fan@oss.nxp.com>
To: Sean Christopherson <seanjc@google.com>
Cc: Vitaly Kuznetsov <vkuznets@redhat.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org,
	Peng Fan <peng.fan@nxp.com>, kvm@vger.kernel.org
Subject: Re: [PATCH] KVM: x86: use assign_bit() where applicable
Message-ID: <arsQekT25sIRwjv+@shlinux89>
References: <20260920022649.3145701-1-peng.fan@oss.nxp.com>
 <arsNUfVv0NhKZ6zT@google.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <arsNUfVv0NhKZ6zT@google.com>
X-ClientProxiedBy: JH0PR03CA0018.apcprd03.prod.outlook.com
 (2603:1096:990:74::28) To AM8PR04MB7874.eurprd04.prod.outlook.com
 (2603:10a6:20b:24d::9)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM8PR04MB7874:EE_|AS8PR04MB9096:EE_
X-MS-Office365-Filtering-Correlation-Id: 0a45f4c1-bf07-4446-1cd2-08df1dc61a52
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|23010399003|366016|376014|7416014|19092799006|18002099003|22082099003|4143699003|10067099003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info:
	C8r8RHio3EzJWFbZkK/B2KpRIGQDOtfLEOdSqvRiPwT1eHttr/l6dXDwzGbhxALPb8FkqJxWQcjO7rr1ti6ExtDmKPMQ2E03qpflGdoK/B1ua0mEWGcbc/L47JU1ILDqkgpB4KK5D3nRbnX2wVhH1cly8yw0IMt0xt8eiawwPqrvsH7H0L8oxLm1UiETSkrTn7hY+iG8U7T1Y/YenumPvWh+RsRV1kCYHA+2nWyYuz9auBxy6smJHf04QUc2bW1HwbGAnKh+/cx7GW4IKITW+fZ8LDA9TOZhkiOhyPMTy60VWPWAEBJ5KxI9tEW26TJHYiPNXjdctMab4GeOMzdY2T0rZbbt4c0N/CjSTmWMnB1+yhj2EvVHNb5G39NQt+Pr8CLvqqTqU/WX4pYReajPTNWosZK/ssFJZBL1GZgL5ndqOul5gcqeJcs6BJ5ZmkGpIacdXRfnu4ohtPXJyDHZ8hLS832KzrXBBbj7e9VNdvEoQptEbafndJgF+qjsQ73RXQGnIYFYtzyTnjm+p4ua6mtptS32/HXinK1mGEwXmYXt0+HUCzpqd66o15K7rc3YyjTHvCuWRQcauoAB48ImK1pgbNC0Inw6dXfMKMFIgPTPyvxRhMlhntNbJDSUgEHunnG2LVo56Lp05Mb2dBy7/1lc5AgdvTietKXm2RtOPT0=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM8PR04MB7874.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(23010399003)(366016)(376014)(7416014)(19092799006)(18002099003)(22082099003)(4143699003)(10067099003)(56012099006)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?QXqV5nb6X7HB89i7Tk1mtQGm1fwtTRyrNO7ngTdAAbZSE/1ZZ3reaZG2iS0X?=
 =?us-ascii?Q?XQy+qh5wk3zZjENyxXvVwT4rDJcIvS2TKnSx4R0PJqyHkIRW61HGYui+U9JV?=
 =?us-ascii?Q?H/pysU+G4QjSdEp4K3HQHqO072Z/nCWLw2Bd6xM80iwb/Cu9f7e9q1J/3OG1?=
 =?us-ascii?Q?Y9FhHHztFSifZhtdecb4jnxlsx6jam03o5sgW9eKpRdjonBTvZWjrFWX3e8k?=
 =?us-ascii?Q?0u5VM7TDsrGGPIh0+tHvZ1GcrZKT7Xiz0NDWzZC7CujlvULoAtx1CyTMXSF3?=
 =?us-ascii?Q?27w6zR0P0z6ivRuw3JVLmV678boPfFAiIrZY7yHe2ybfaGsPNFx1fEHa518k?=
 =?us-ascii?Q?1c52srWtFR02P9zJ1rKGNcSjv9b8ZNzGI30CYdhuisHaBgUEcHn1IdNmkF+Z?=
 =?us-ascii?Q?Lj5DuBs5j5P5lMEbogXbo86zsgYwh0jh2qsQTOx/1OTXCEU4GyTAbIRPChWh?=
 =?us-ascii?Q?3zU7evRRRDpjaoskyD3rW09tAhhCh2kVMLk7ZBQwdjhirotYaY3gWRoGeQrC?=
 =?us-ascii?Q?eNPeC4yWLB4A6B5vQQM/hE02lYp1o38U5Gl1FWuv84m3V4BlGtjUJ616NbN7?=
 =?us-ascii?Q?ZIzi6L86cR1jiOsH0PiAlI0nMrJsJLANXeePDpqTlDvrtoPVzk2ZenVz8FYM?=
 =?us-ascii?Q?u+maLYOXbBz2kiD0UXdc3mGhr6eBc0h00Fk9XxoiuHfxeoQ8CrvJ6yn46bg4?=
 =?us-ascii?Q?DFPruuLDs4lPdW+z4VNBZLCMz0WF7c0I6IP9wQMmqoGc859HiaAJxZsyZNx2?=
 =?us-ascii?Q?EJ1vsb302vMIetHdaBKtJkRMlvO0IpHAlS1OTUFei0ZLpS3Fc1mkjZ6WaMLE?=
 =?us-ascii?Q?zyTXrZQHyDNk65xVT8anFS74EuGBj5tLrJPwPeQeCZF2uZKRqrPtfT20zhf9?=
 =?us-ascii?Q?DGWhUvgPZcsUSiF9QB7020Y+5aGgOEDUE+IOb4uR8r7dPBosNOFOi8UYTS64?=
 =?us-ascii?Q?pJpLPX4JX4Xk0E/szo+wZGt2qA+Y/sSgyUXf16KrbdGYa3OBX1wOYwO+swDq?=
 =?us-ascii?Q?0Fdti5EAj3BvJPEyProNNkKslIsKoXKy246UbFyhNsBffQqxkM0NE+q6CA10?=
 =?us-ascii?Q?lhzNc3ulwPNuGVeY5aD5bD4izYFmFjZ3Q1YUoE0eZLcbxYDs0LWX2fhWCSW4?=
 =?us-ascii?Q?zYceazG8ZnY4nvhy6MBgHFnsR3+JovqjmkRzmSo5g49AzU3g6F5+XIt3fzoR?=
 =?us-ascii?Q?fSvaDign0f9PH+2TGCKxQUycBH6huiZYN+XiQdHDBZVndG1flH782EaVkvQm?=
 =?us-ascii?Q?G0NN7NUIBCFTRzXoDt6ZrsFTTolwgd6MbZlf+caP5D6niUow8gieFt8hYEPA?=
 =?us-ascii?Q?/b2Hok1n5Zb/1VAjoidyJ33u9Tt/8LD8U4YuyzTXRLNQUBJyIxvQhwV1mGok?=
 =?us-ascii?Q?hmC7dFBLiyQJR0vNeN9tx0KaVRUalnPsJNw23Rz0ORysM/Zxm/vjQdAF2lps?=
 =?us-ascii?Q?1z9uRh0wlb/3slUJDk5enL2vZZScq758YJBEQ/jRxeQ8zr/MCqTEg0HlYmtO?=
 =?us-ascii?Q?4Jv9RiWe25aMCqvPqXTbPgvr50IilJ98cS8jru4JnPeC6benck1VS/JoaxB5?=
 =?us-ascii?Q?cvr3MA7pjWh6IBEhPj6QhmS6Q48n3MYUF0robjbC+B7nQ9rZg1gW4Dbww1/7?=
 =?us-ascii?Q?5HZGLLVfBvO+KqMuhDie8N11f4xy1SZIJx2hpjhFRxOIVDaT4ZGLNggs0VwV?=
 =?us-ascii?Q?CYAJIAhFx7NW5p8cVAY4fRqciTVeX+6+hdnB+G1lTFAXRMDjl9VfoyyUktNt?=
 =?us-ascii?Q?qrt1d0LKJJXoEtfzZE0cwrH7M3LlhaJvd3IegufLAnt2k6pI15+n?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0a45f4c1-bf07-4446-1cd2-08df1dc61a52
X-MS-Exchange-CrossTenant-AuthSource: AM8PR04MB7874.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Sep 2026 01:07:59.5465
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FsABkKY5yRRL+kuE7Ci103ZUu8dRaebW/6dY0QiLVyRNGK+CYjRQDQZ+l65mcBiYPthDTSLdjp/ByYZQ8U2e/Ag86ITm8ijbZivQ3C52eMFn4Vk2xbZJfx1c/pn24aZy
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB9096

Hi Sean,

On Mon, Sep 28, 2026 at 05:58:57PM -0700, Sean Christopherson wrote:
>On Sun, Sep 20, 2026, Peng Fan (OSS) wrote:
>> From: Peng Fan <peng.fan@nxp.com>
>> 
>> Convert open-coded if/else with set_bit/clear_bit and their
>> non-atomic __set_bit/__clear_bit variants to the assign_bit/__assign_bit
>> API.
>
>...
>
...
>>  
>> -	if (synic_has_vector_auto_eoi(synic, vector))
>> -		__set_bit(vector, synic->auto_eoi_bitmap);
>> -	else
>> -		__clear_bit(vector, synic->auto_eoi_bitmap);
>> +	__assign_bit(vector, synic->auto_eoi_bitmap,
>> +		     synic_has_vector_auto_eoi(synic, vector));
>
>Am I the only one that finds the assign_bit() code signficantly harder to follow?

No :) S390 maintainers also not like this.

>Maybe it's just that I haven't seen assign_bit() much, but I've come back to this
>patch several times, and I've had the same reaction every time.  IMO, this is a
>solution looking for a problem.
>

It might be easy to read if the test condition is just a simple value, not
a function call.

Free to drop this patch.

Thanks
Peng

>
