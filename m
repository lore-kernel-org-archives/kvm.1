Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.103.43.31
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795323141;
	b=Bs0s+Um43911zIq2snK1xdz1OuXsTOU3Sxq8W1AJiXFEQc9YwI/roaj3wHzmlBrcHm62
	 1hCVmrPWN32OiZx28Pxk8ThkgL84brbAPNAHWP2gMeCXKsmAjNKqQzuV7JuDp6W1fbvkM
	 /T8Bu6563rgMnpYCgDRekHCrdSdw88jV3XdQefGOsQ4sQET5aLCJBYXDbCFF6lGkwP6YP
	 gICKjrdd0VZk4vOx/lVrgDDk43CngcbAuCRfD7yup5/A+tghOtx41pTIr79dSkBIObZBa
	 tQjA6eZSAK/LB+4MMcOJQQeUsdQsrYVaiCo4vEF5lm0DH7sYOLcFTj5FZA0gPijrbUw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795323141;
	h=DMARC-Filter:DKIM-Signature:Received:Received:From:Subject:
	 Message-ID:To:Cc:In-Reply-To:References:Date:Content-Type:
	 Content-Transfer-Encoding:X-ClientProxiedBy:
	 X-Microsoft-Original-Message-ID:MIME-Version:
	 X-MS-Exchange-MessageSentRepresentingType:X-MS-PublicTrafficType:
	 X-MS-TrafficTypeDiagnostic:X-MS-Office365-Filtering-Correlation-Id:
	 X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:
	 X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=NspUs3nGW2o7d8+Igj6p0K9/WWnYNAbDC+bpU9eRVps=;
	b=aTS3WrV+0aZqPkSUiG07Y+oBzAO+Xy6cZjKZ+tw4KGZBrmAbSIkVpk00NJlgV4B5B7qg
	 zmoenSirxhAyb1vhpFFFB85hwFGtWBvtq+jAAfS39A3E8o+ByXpP9uo4bsg4s2xJKuX1y
	 tBPleShOSpWIKDDrYRQNNdKyIJ2e47eOGwlR98Edlwt+hJBHuTlxfjmjo7W09wltrIAva
	 gvz1eH15Ng+e7tZN9mBLEWilnRxIDGwGq0DVeStR+LzuoY0oZ16OYPjbQ4/pEWTLzXpa1
	 B7idU/IRhwJPN280GbqM4WLSflb0/9ZzGIBFfoEYjhHBwH9wUYHxlOYajxVeZDe9haQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=hotmail.com;
	spf=pass smtp.mailfrom=hotmail.com;
	dkim=pass header.d=hotmail.com header.i=@hotmail.com header.a=rsa-sha256 header.s=selector1 header.b=pvUDLzTi;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.103.43.31
Received: from TYVP286CU001.outbound.protection.outlook.com (mail-japaneastazolkn19011031.outbound.protection.outlook.com [52.103.43.31])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81618606A320;
	Sun, 22 Nov 2026 04:52:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 81618606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hotmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=hotmail.com header.i=@hotmail.com header.a=rsa-sha256 header.s=selector1 header.b=pvUDLzTi
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=c1WGr7gZGZ2jcSnFC1mT96/bRzjkifAqyO466E47RK5NKZ7T2U4Rf/T6bLuUbs/4k+4wq2XgLJmSepFYs8be4vwxev7+n/0PbYMqJYfVWOVt4p/DroAi4H/5bXgET3bZkpNvupA2s45GKbNDAIBA+VqGAoLN29y04IrK3d87uJlBrF8m49C9GvlJo6MuwiFj8cidUyQGxW/KA/59mIqTVtT8f/Or9d2owu3j4Hq9MdUh0BF+vdrWO6u6pbKB5a2TsXYYBJqPl+B+0tizthr95vGQ3zCoh5qn9oL65gg+8c2U+KV5Il3WFly3PdJoKcASJybPkC+72HHUCQqKMC6cTQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NspUs3nGW2o7d8+Igj6p0K9/WWnYNAbDC+bpU9eRVps=;
 b=wW3qAFhSanNvzfd3xQzm4AbmOTwtJaJmdCwFsAe2WxpmFyJg7fW7KB8nc1WBJfJfYo/1zZOgmBFK79kiVM/qoL23sdpfCz3B1NHQpIgtXvQzGvDDlAoHkX5ZEU2jJv1ppN+2UngEkKwZ3oEgOA4k6uMlpgdc+JJfmWC0snXnOvLdQ59c2BnPjhrWOS53bm4U/23ILImo7RM1UazGrazmEYlr/YiDoigQO47ZGIsZHRI/VBFibCAPdF2MvtyF4dLlRHkICi0aH31ezT0eqJHmp0wLjFOROJqfCmjpE1LQzZyQoZXMhyA2Ph7YXUvTDXwUvXsQWZhuZU7g24r5NgyWMg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NspUs3nGW2o7d8+Igj6p0K9/WWnYNAbDC+bpU9eRVps=;
 b=pvUDLzTiaj7x99SFnerfu2M617ASLYZXdnR/77H49jvRJBWSDPdoID0vEtjnWEtbKoHzbvYS0RstDsvohH1XRfb+uHAQLBxgtRzrmMSu9gdmJEeTS1Ue4JPhVu+qZRp/u7W9U6dPkrsfWo99YT/1Oonh2KAswG7knQjdCUOH+PqNNcpwJgtHkKFYFQFwtrVS+AoZRI2RsK1WaPnQyAVQBVmFSXQmvvXOc4+jz13KVtydp+Y/5SW5coueDZZ/ISDvHHOIvNmyC2kxm7JAKtcz6YqdJ6WVAzQJgFADUm6OEs7WqOGCFVfqV4JKjxkCXeC/rIygqdGq4qmYg30H3B+cHw==
Received: from OS3PR01MB10251.jpnprd01.prod.outlook.com (2603:1096:604:1e1::9)
 by TY5PR01MB18121.jpnprd01.prod.outlook.com (2603:1096:405:3eb::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.639.13; Sun, 22 Nov
 2026 04:52:15 +0000
Received: from OS3PR01MB10251.jpnprd01.prod.outlook.com
 ([fe80::7edc:2a40:7b8f:56f9]) by OS3PR01MB10251.jpnprd01.prod.outlook.com
 ([fe80::7edc:2a40:7b8f:56f9%4]) with mapi id 15.21.0639.012; Sun, 22 Nov 2026
 04:52:15 +0000
From: "Jiaming Fan" <fan.jiaming@hotmail.com>
Subject: =?us-ascii?Q?Re:_[PATCH]_KVM:_x86/mmu:_Prevent_hugepage_recover?=
	=?us-ascii?Q?y_on_non-guest=5Fmemfd_private_GFNs?=
Message-ID:
 <OS3PR01MB1025187BCC2CA35B063090CCFE7462@OS3PR01MB10251.jpnprd01.prod.outlook.com>
To: "Ackerley Tng" <ackerleytng@google.com>
Cc: "Sean Christopherson" <seanjc@google.com>, 
	"Paolo Bonzini" <pbonzini@redhat.com>, "Thomas Gleixner" <tglx@kernel.org>, 
	"Ingo Molnar" <mingo@redhat.com>, "Borislav Petkov" <bp@alien8.de>, 
	"Dave Hansen" <dave.hansen@linux.intel.com>, <x86@kernel.org>, 
	"H. Peter Anvin" <hpa@zytor.com>, "Fuad Tabba" <fuad.tabba@linux.dev>, 
	"David Hildenbrand" <david@kernel.org>, <kvm@vger.kernel.org>, 
	<linux-kernel@vger.kernel.org>
In-Reply-To: <20261120-gmem-fix-gmem-max-mapping-level-v1-1-108788914fe8@google.com>
References: <20261120-gmem-fix-gmem-max-mapping-level-v1-1-108788914fe8@google.com>
Date: Sun, 22 Nov 2026 04:52:06 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: TPYP295CA0027.TWNP295.PROD.OUTLOOK.COM
 (2603:1096:7d0:a::12) To OS3PR01MB10251.jpnprd01.prod.outlook.com
 (2603:1096:604:1e1::9)
X-Microsoft-Original-Message-ID:
 <802a808f-87e7-4eac-bc62-969aa399d451@milk.local>
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: OS3PR01MB10251:EE_|TY5PR01MB18121:EE_
X-MS-Office365-Filtering-Correlation-Id: 63686a1c-88ce-4888-d10c-08df485460bf
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|6090799003|19110799012|8060799015|25010399006|4140399003|15080799012|41001999006|16041099003|23021999003|22091999003|24121999003|25031999004|55001999006|5072599009|24021099003|40105399003|53005399003|440099028|3412199025;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?UGhmdmtmWmdET3kyeVQrUG80a2tkbEg1cVZKZUI2RWVXdEtJMm54S2xZdi9H?=
 =?utf-8?B?Z1FWcWdOU2ZJOTdQOTZMSE5SNTBRdnd4cWlzaWxnQURTMDN4WnZhUGkyYS9V?=
 =?utf-8?B?cEEzOEMrL3ZKY1U2cU1RVnpoVklGRFp4dGM5N1pncnpqRlRaZGRRdnAwNmFO?=
 =?utf-8?B?Wkpqa3djR1U5WFdRb2VKZzBtQTJjYnQyKy8vMjN5SmdHU1N4a1pFRDVhT1M0?=
 =?utf-8?B?a3JLNnVhTGFFZmhwaTZTMnpNSThzamV3eXRpdllIN01ydFFKYzVhVFQ5d2Fl?=
 =?utf-8?B?OGM5Rm9FOGFYVU13eFJ3dDFheXR3TXV0aHJQa2I1TVM1bDNMb3BmYVFFVGg2?=
 =?utf-8?B?eWhsN3ZYeGgycjVwZ1lLU3ZWd084MDduRjh6cnF4RW5GSEMxTld1OHFiT2NL?=
 =?utf-8?B?WG1EOGh4dFRyalVSV09oZHFqLzliSzAzaWgxdnl2R1ZMUDBmMm9xM29ZNURT?=
 =?utf-8?B?dEJlcXJZMm1nQjhzR0ZpT1FyMHV2YzhsaFprUk9jMlpXamorMUtLTG43NEpG?=
 =?utf-8?B?dHBvQnh1aVBTMFVrdWd5SU5aUDJUZ0JnOEl2K1k1Nm84czdhcmdHYld5YTQ3?=
 =?utf-8?B?SUpycnFZTjN3RWNQVGE3Y3lvVjR0cHpPOU56UUtkT2pGbzU1QXVFS2RoWFZJ?=
 =?utf-8?B?c21kU0V3akxrNEthcTRid0p0YnM2MG5BSURKY2FqK2FEbDhMbmJ4TXRxendt?=
 =?utf-8?B?YzVzSUJWckNjRG5QeVJFRy9JOTNBS2FCMEVidW9DdG0wdktiT285Wko3anFm?=
 =?utf-8?B?TWFZbEpwalo1eGtadnlWWklmZThpc2g5OG1MTCtwaXZTb2RhelREdlNqd3NM?=
 =?utf-8?B?OGxHbWRpT285NTd3bHE4VldlQXBDRDZYTmNPdk1TeGNqVHpneGY5akZlSzJE?=
 =?utf-8?B?V1JIMEQvYjdzYkFld0s4UE9XTzVncmcrSWF0a2JBTGI0bCtscEZwSlpMdTBk?=
 =?utf-8?B?ZFQ0TmxXbCtIVkhVQnRwYlY3RG15YkJPcHJBWkd5ZTl6Y1BUc0hLMUNKZFI5?=
 =?utf-8?B?eFVQTkhZdDVaWktQMjYxWS9iUDJ1Rk82bkdDU1hoeTh5TlcrMUQ4Q0NnN3lS?=
 =?utf-8?B?bXkvUVN6TkxiZDN5QUNOcWRjUWFlQU94d2ppZExaaHhkUlI3Nno5UysvNk9p?=
 =?utf-8?B?WW13V3lrZE53VjhBTXhFNnFkYmpEYStxbDNNc3Y1L3J2QXRla3BPZ0ExQUdw?=
 =?utf-8?B?U202bXhqVkdVSU84bmprbSt3dzg1d0RZNFZzc0lBTkdFc1pwZzdPTFlLQitL?=
 =?utf-8?B?TzBPM2t0aXJpc2NndzYvcWZCQmw5WnJaN21SejRvbW5pdDJvaHlZZWhsK1Fo?=
 =?utf-8?B?VEZJU3Y4U0EzcVVMelFsTGI0L3AyRXJCbXdlVDZkOE0yYnlHZXljZXJHUlV5?=
 =?utf-8?B?c2ZYSXdRZUtkYmEzdXFyalgrRHhxdGlTaDdqZWZWU2FMYm9pZ1hLOGdXRitY?=
 =?utf-8?B?aHRmZ1BhdnMrUzZxMmFKSmI2by83MUEwbEpmMzZMcTFCbWJvdG0xZzVFTnJE?=
 =?utf-8?B?RndSLzFoemViVERmMEJrY0dpUDlPS3ZaVnUxa25WRi9FT1RkUTB5TGxoa3Bi?=
 =?utf-8?Q?40nRltJ5jJHXYoCnAlMq0siYw=3D?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?emZTLzNrbmVNNVg2ZGVTM0dwZTBUdnMzVFdWOWVNaFg1ZEN4dnVrUzdyaEFk?=
 =?utf-8?B?c0kzZTh1WXVmcTNFUlhTTHhhRmgvcUp3N1JTM05GQzA2dC84Y3h6T3AxaTQz?=
 =?utf-8?B?WWlKeFBWZEhkYTg3Sm5tMENMM1EwT05ZM1NIajZSWEVHQ0toMVlEeDBSSGZa?=
 =?utf-8?B?ZloySVZlZC9MRmZFYWlieVppWGhLcUZPSWt4WnI0OEdlUGRnazMvMjlSS05Z?=
 =?utf-8?B?dDRFSGlPZU45VldsdjFNU0FZeDFnL085Qm1sMmk5NlhCZ2V4Z0w1Yi9KL1hT?=
 =?utf-8?B?MkliY3RQQkR6MHZOQXRmUTFOVVExRWNPcVp4R3FuTlZFY0xtdW9PYnh0WFhS?=
 =?utf-8?B?YXJwVWZVdyt3L2s2d3ZrTHdOREdXSTYrekNiWlBlNFU0ckQzWVJ1OFhxS1FN?=
 =?utf-8?B?RkQ0N3ZkeGFlcFdTaTlLaG9BN3JGa1FIWkJlVm4wWnd0QUVBQk0wc2pWRnIy?=
 =?utf-8?B?QnAvZ2YrbVl6MGFjV0plY3FKSnIvajVURmdmTHQzRGJFVFMzaWJJdkZ0dUMz?=
 =?utf-8?B?MTlpZEw4VEJzTE82ek5kd3ZwNC8yZVI4ODU5S1lYRnQ5SUkzUHRZQkdPcVdN?=
 =?utf-8?B?NkhQVkdmVTJWVWxPWEhaRXFSc0h0TkE3Q2tMcE5HKzRzSlZzZTZiV0gwOElU?=
 =?utf-8?B?UUdWVkRmMVRPanNHM2FCQ0t1U3l3VkFzaVRkYTJxbEllamdvdjh3akZjYkdU?=
 =?utf-8?B?RWg5dU9TT2JYNkRqb1Z5Y0VqZlZ2YUpwZDBoSS9aclNNQTZSWWg0WmJ4cVc0?=
 =?utf-8?B?SmRXei9lak1WRVNOMksxa2M1SGJwSk9pL0ZLRmdGd0RRYkV1MG1LdXV0UkZO?=
 =?utf-8?B?dmt5NE16ek9ZUDdjSjFiVVVJSkc0T2k0Vk1OeW9wUFNoVVZiUndCR1gxRWpQ?=
 =?utf-8?B?N2lXbzlzQVphMUZCK1dPMTU4cmZneWViemZ2MUtVL3MxamI0ZlhqclUyL1dh?=
 =?utf-8?B?RzcyT2hpMTZqUUpwVDdFZzdtN3lxSytnUW11SUI0NmNsQ0xOTWozYm51YVQ1?=
 =?utf-8?B?VmplTlg4WFh0ZWxWZmY4eVJId2tMQkd3bVIrSEZtRlpnVzUzYzdWSzdHdFg2?=
 =?utf-8?B?TTJxem9YTU5Ncm9WUnVsSUVRU0NrUmFYUlB4OUpJMWJzcW95WklXajFPTDhB?=
 =?utf-8?B?OTBFbFFWQm9aNzhBMzZxZVM3WFZsd05Qa2tyUjZnL2ozd1U5RVFXdFo2Z0Vy?=
 =?utf-8?B?RHpoeXdJeXZ0b0dYVndUK2JzRDNHakkvMkE2YXBzU21aWTRCODZTUzBmTVBD?=
 =?utf-8?B?cW10aEhXU2JUTzEwRkNXenpJMHNYY24wMm1lMk1wY3JsM1BOM0Y1YUNtNjdq?=
 =?utf-8?B?eXRieUMzYUE1SWc1UkdZYzNjWExzNFdUUHA2TGN2N1BFa3NqTXVuZTBjVlc2?=
 =?utf-8?B?amlFODkwZzRDbENuazM4M2dnZUM2c0ljZHFDOGNhZ2FNM3VsMkdSa3pOejFS?=
 =?utf-8?B?WjNMcEJZc0duOEdUVDZ2ME8wazBUWUd2bkV6dXF4S0YrWnNCeUVWUjBHQlNQ?=
 =?utf-8?B?bUxMMndNRHBoR203VURrWWJIdXZjeVMwNWxhUU1tdHFpLzJodW9CUXNmWFRs?=
 =?utf-8?B?RDZlMUsxQ0pOZTl6UUxVSm05L1dMU05MUXR5d0EveWExWnE1dWM2c0MvTDVO?=
 =?utf-8?B?ZVlJOGpvbU8xS1Q3eHRvK3F3a055UHh2TjNZUE5KV2ZYZG5lMXdZaHVNQ3RD?=
 =?utf-8?B?VUZKMG1RTmNnc2R0eUwrWkhtcjBveG5GWkR3YWJUWDliWmJDd1lIcXFtd25C?=
 =?utf-8?B?cTJLcVAxMmtkVy9adkg3RFBnLzhDT0g5Y3JGcUVUSVZtZXM3RmZJeHJvbGVt?=
 =?utf-8?B?QzQwVmszTkhuc29zR2FSWVJOekFRVXVURWNFSysvZU0wa1NvNGVoUTB1YTRM?=
 =?utf-8?B?RndFRWJ0bDNPS3FwdXJySTA2OTZvSFhIQ1RTL3ZPOEpEVlE9PQ==?=
X-OriginatorOrg: sct-15-20-9412-3-msonline-outlook-b83fc.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: 63686a1c-88ce-4888-d10c-08df485460bf
X-MS-Exchange-CrossTenant-AuthSource: OS3PR01MB10251.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Nov 2026 04:52:14.9465
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY5PR01MB18121

On Fri, Nov 20, 2026, Ackerley Tng wrote:
> +		/*
> +		 * is_private (set in VM attributes) should never have been used
> +		 * with a non-guest_memfd memslot. Return PG_LEVEL_4K to prevent
> +		 * hugepage recovery.
> +		 */

Hi Ackerley,

This comment feels a bit odd to me. KVM does allow marking a GFN private
when its memslot has no guest_memfd, since PRIVATE attributes are per VM,
not per memslot.

I could reproduce the WARN with a KVM_X86_SW_PROTECTED_VM on AMD (nested,
not TDX), and it's gone with this patch.

Tested-by: Jiaming Fan <fan.jiaming@hotmail.com>

