Received: from PH0PR06CU001.outbound.protection.outlook.com (mail-westus3azon11011070.outbound.protection.outlook.com [40.107.208.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F11113C1994;
	Tue,  5 May 2026 18:30:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.208.70
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778005833; cv=fail; b=rs9eVfdHwuoGtYTLPnfJ3a9S9COVoFfTsQTA5+u2Mym7+8rZtYT/vhNu/LRW9i3W0smLQdPGkCmGvo83YZNFmmZ2CKkKv64bVtuLRf27qcJoVmIGyTQ5JUKxgbDHxlSVlVaBbNOUy3kymA0Z72eurEuGhAp80u7eLNWDtiozlHE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778005833; c=relaxed/simple;
	bh=MDIddYyq9t+KcQh1/Bge/9Y6iK/lzSZJ7b45Z2bwe/Q=;
	h=Message-ID:Date:Cc:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Qf/9757uEcjM3O896YmIaER3zV0IUtoXkXGx1aJ0P0448cfbFwYKAcl7HKVY5luqsV3eUBoA7UI7o0046Mk6dXBYhJCrOdZYicUlyw0Y59b6nu52GAcNP8tbiIFjk8UYFHdN5i75dwgb50kzM92Mqb5wjcyKrPxT/EDhwze7S2I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=citrix.com; spf=pass smtp.mailfrom=citrix.com; dkim=pass (1024-bit key) header.d=citrix.com header.i=@citrix.com header.b=sIbIz3yU; arc=fail smtp.client-ip=40.107.208.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=citrix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=citrix.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=citrix.com header.i=@citrix.com header.b="sIbIz3yU"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uKtWe3KxY+wMFhqMXTaa95Xw+aLvD6Zy/UptaN9b9UiIgjWMLifq0e4f+G54rmvzHes7dhq+4aYwbr33IyhOi04zCtdEuoSTiMZxFAob06/hN2uTte1YFuiLYqo1B0fUZT2RIZflV2PJiw7Nh+Zm4f3aBY2fwY91kL+VGEg9EZRGTNczav3d+jVKcX8TC1uhr4X8XjjwqXT+s5sw0Za0F11Gzi9vx9UTvb7JUMqvlhpXh8lJHEa+xqa0wvSeIKWktwuLaiJbR3v0j06CSu/VWemoDPsYIE+21OZugO79hbAR9NLn0qsFL2vL/7pfSNkVUgNAIcs/d9NT8Scf/4wSZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dwyT/2EeSc+JSlY9yMUNw8Zbs0ILPaxYnY6xPjAJZUs=;
 b=JtVgydJnFudGuRYD2JPh0MFQVxBPidfiU4YXGV7xdlGsJ0VgqXAGa8SMyvqtaSvALp1tpqB9xTPMnVFQz0QCVRjpp8WFpdUTUyyd9OYtBw1PKLPU4075be6FKUigHoUpS2IO3GkcKOk7P7Ajo2uH/NAWIv9MX1CEeu4v5imXozH8KSToPVWgTljo2/nCaK7dW3COj1walXfuvnw4MZb/1uRMyps0/TfESqRCk4H8FvzKwuiszbOILWx+lGLciBEKgQi3iWPxeGWEGUzog041IUHIp77z6HGHE9/AKJ9Avr94f8RV/q3bdEa22PCcT8S/cEeJfJeE++cwcqdhk6Th1w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=citrix.com; dmarc=pass action=none header.from=citrix.com;
 dkim=pass header.d=citrix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=citrix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dwyT/2EeSc+JSlY9yMUNw8Zbs0ILPaxYnY6xPjAJZUs=;
 b=sIbIz3yUteGEXQuSn+UvTa4sfnIqoyvRN59kAlW5kkzWvg43kHphlVCUihuduVVu18/3y7GIM2pIRbZg3zny1x9Q3qMIomqXQUEOuowPG+bLZZU0H0nM6UEXSCoHr7PorojO1Zvm0wRJ5wS4el9ptf/wkjIGNXswgWu+yY05LeA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=citrix.com;
Received: from CH8PR03MB8275.namprd03.prod.outlook.com (2603:10b6:610:2b9::7)
 by CO1PR03MB5795.namprd03.prod.outlook.com (2603:10b6:303:9b::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.27; Tue, 5 May
 2026 18:30:28 +0000
Received: from CH8PR03MB8275.namprd03.prod.outlook.com
 ([fe80::a70d:dc32:bba8:ce37]) by CH8PR03MB8275.namprd03.prod.outlook.com
 ([fe80::a70d:dc32:bba8:ce37%6]) with mapi id 15.20.9870.023; Tue, 5 May 2026
 18:30:28 +0000
Message-ID: <f4cb5f8e-caf5-4513-9538-edaaea20de2d@citrix.com>
Date: Tue, 5 May 2026 19:30:21 +0100
User-Agent: Mozilla Thunderbird
Cc: Andrew Cooper <andrew.cooper3@citrix.com>,
 David Woodhouse <dwmw2@infradead.org>, linux-kernel@vger.kernel.org,
 kvm@vger.kernel.org, linux-doc@vger.kernel.org,
 "Saenz Julienne, Nicolas" <nsaenz@amazon.es>, pbonzini@redhat.com,
 seanjc@google.com, corbet@lwn.net, tglx@linutronix.de, mingo@redhat.com,
 bp@alien8.de, dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com,
 luto@kernel.org, peterz@infradead.org, chao.gao@intel.com,
 hch@infradead.org, sohil.mehta@intel.com
Subject: Re: [PATCH v9 00/22] Enable FRED with KVM VMX
To: Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>,
 Xin Li <xin@zytor.com>
References: <20251026201911.505204-1-xin@zytor.com>
 <7f93eb25874ddd13a1ad6e3c75785f11041c8b7f.camel@infradead.org>
 <DADE0E58-DD8A-4206-BF54-1DA87864117D@zytor.com>
 <afojoHJSlqqm2Ges@wieczorr-mobl1.localdomain>
Content-Language: en-GB
From: Andrew Cooper <andrew.cooper3@citrix.com>
Autocrypt: addr=andrew.cooper3@citrix.com; keydata=
 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
 6+ahAA==
In-Reply-To: <afojoHJSlqqm2Ges@wieczorr-mobl1.localdomain>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: LO6P123CA0048.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:310::15) To CH8PR03MB8275.namprd03.prod.outlook.com
 (2603:10b6:610:2b9::7)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH8PR03MB8275:EE_|CO1PR03MB5795:EE_
X-MS-Office365-Filtering-Correlation-Id: 7928cac4-cd24-4599-de86-08deaad461a2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|7416014|376014|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	3kmuyKJYA+CbWwVS88jydW/C22dMAnjdlwlVDepVLTUYIzfWD26khygRJ3NzkwZ9TyzaJMfa91/FAXSxjt0Cup8Fnq5HP17kRJRdOIQvsSMC9Co9JoqV72GU50uCDLYDOrYv6IjxkpYg/eyEpinvhte8IwizY9cEnqM3wCGQFJ79NAYfVmHGYhNvGJjIcinSdrOzu244iB9YyiiFhXwCOn6vs/sIDZZQfUQcp50z/TaJK3TIUV3Pd8Edp1yxaviBI8F3eM/0V/v6ntHVudJkNct1UiLDia5I408JlAUE3H6a5v6KmS3evyLI/SrLIoBBfnZP8dduInS6nn+Wa092tR00Af/wjg9DNX4UfiyOanmhUErvvFg1ItnIC3ncMSHy1bri3KSUsdjh3YO/vG8tzosxshj5wx/Yv6Pl/59NNhARGRGvvS2SuW1Sn3dw0YFUz9EavFvqgl3XKxW5XpxoyiIc3zFo8t81csNCayDzHU8jmsgg/rFmas5BzeXMqIF4BA4UPCcGuAETl9rr9/F7sQHXz0LGQfyOgHYnE6PvLD6QVfdAT7dRCN+EkjydkkSvu/XtoTh7AJ4r2LNMasLp0J3emptEOGLWCT73b1THC82i5fiEDNKlgOtIY7Pyc0gbUQeg3eIRmqoGQnqi26CIovdjZMuasrDrQribtUdHIchweSdioIT0zKxUkzbDJtSX
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH8PR03MB8275.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014)(56012099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?cGV1bFpiRW9JZTRiSUNnaGNtdXFmZUUxNy9PeENYUHB6Z2tEWHpMZWVZWlJV?=
 =?utf-8?B?bFdGS0hqMTVjNVBpVkJrOFc3c3VSckRzOXJ6NGFzdmo3SUhFVGNhWXFxWDMy?=
 =?utf-8?B?Y1RhbERmZ1k3SHczeVJZTGlIRHNtM3dDV3IrMi96bWVrR0R6TTZETE9xQkNn?=
 =?utf-8?B?cndyTHhnbE1XUzdtT0o4NU1mZi9yZ2RENEdRZEEzRmRVUUZadm0vTjJhV3Jo?=
 =?utf-8?B?SUtoZi9hWE1UbVdUQXc0SitGb2JsdFZ2U3k0Zm5KZkRCMTRPdWZWMXFRK1Vo?=
 =?utf-8?B?SnQvRHpDZ255ekpJM2RHYnNPRlFWK3BRR25uOTNyaFBnZUNKZHg5dHl6VHR5?=
 =?utf-8?B?K2JmRE9oa3JEOWRTVGJ3N09qT3NsVHVQZEVha2hjYmhob1BmVEM4ZUR0YnNo?=
 =?utf-8?B?ek9rdWxoQjJQRHJlMXgybXJkYWk5M3lMS3Zpdkc3c0E1NE9Ta3ZsTkQ4WEZw?=
 =?utf-8?B?NWxSYUFnSGdaaXlMcCtGZ1YvYTlVRndUMHNnRSs3YnVXZFhKb2NWcmhBcmtL?=
 =?utf-8?B?V21DSFo4VVBreTJUUVVtSDdpZFBUUDdLaHdaZlVHTkd4Wk11SUhya1poZ1p3?=
 =?utf-8?B?T292cmJwdkFIWlZEbSt4aVRwZVFJeTJpcHJXRFMyWjdNdE5NdkRVQU1NWWhk?=
 =?utf-8?B?VlF5M0Q4ejhiT1JvRytQVjhmZng4VC9oZWoyMkdabTBQLzlQNzcvT0E5SHVv?=
 =?utf-8?B?d3NyU1ZRUGdMMTM2TEsvcTFuWG1YMlZQNElIU3pZbXFLQThpM2FvdGNlRlph?=
 =?utf-8?B?ZXNVOUJBNFFVZE5GZ3RibXRXeTd4cjZKWEhGNWxHQUk5aHpjN2dTMkN5Zm1p?=
 =?utf-8?B?SnU1QjhZRk81YmVkTUFETWZkNkFNRzRDcVViZTBqVzJVOWJZV3hMdmRnWWpl?=
 =?utf-8?B?QkZTeGMvRXB3OHFUZlFpQ2s2S0t6dWtyc2g0R1dPaWMzcWIyL2pLZ05LMVIv?=
 =?utf-8?B?THc5ekdNRDdwNVlZaENoRDE4Nm1RV0M3NVArV1NKQWtGMmdpYVFqczh4SXdx?=
 =?utf-8?B?SWNsbzNFanFKaENEdkdxYklRY2ZtQU4xb0Q1M3hucG9sUWlXQm5LTHZjeEcr?=
 =?utf-8?B?ajNBS2pyUG95TzhVeUxPdUF5VjJPZ05pNG1FYTBhT1U1aFZnTTA3S2UrUm1R?=
 =?utf-8?B?NmZzTEVEa1VIR0xscmpWNkRXUEpKRTVlOVNzdklnV0JTRFlRckEzMU5TWFpj?=
 =?utf-8?B?b0E0am1xZUVvMnR5cHlPRFd2MUlKS3RWNnRHNzBOTHc1S1VaUXc1MXlPUFpP?=
 =?utf-8?B?NGxiZnJEUXJqK2EvSDByVHRWZFV0TjdUc1FHOHNtR2Q0R2xBQ2NLQXEwekpL?=
 =?utf-8?B?SVNxVk9WSk1xS3JEbGVZZ0pYWUNnWDdxeEJ0YlVpQ0hQSncwZHFuRzdOcEJF?=
 =?utf-8?B?Q1p4OTk2NGZVcXZVNlVKakNtUUkrTGtTam0rRmZidHY4SzBuU2VkMytNRjVv?=
 =?utf-8?B?VHJLdVdKbGdia1doS1ZmRm4wQi9ESWlQODQzem9KRm9oY3Y0cXgrNXlaMlVD?=
 =?utf-8?B?U3U1TjNPbWdpbEJZandpUkpuZkhSL1FETmRJdWRVQ2F4cmRDVmhxamRSRDJz?=
 =?utf-8?B?RkZBbDN5U1FkTVhZMDBVWGVQZTVoODNCRlVBaEVHcnpTWFN6c2xWWEVqRGgx?=
 =?utf-8?B?c3NIZFZvMnBwMmNtZ29GTXV5MjZCTVJNSGFKR05vaDVUaTRCZXM2OEUybkZ5?=
 =?utf-8?B?b09tL1FKejNhTnBiTVByd3RTVWtCOExTVHNLdnM4dVBaWUZvUFY2Z21iQXg5?=
 =?utf-8?B?eWZYaHhGeHhGQVBzNzlXaUVZcFpHbXFPa0dKNmRReGZMajhycXc2VmlRYms1?=
 =?utf-8?B?YmpZL201WWZOdVYzeG84Mml0Z2J0OEV1OGxsZ2gwb3F1L0FpRFV3SEEwQ1Jt?=
 =?utf-8?B?dnZ6ZmZmOW9CK2p4Y0lJWXd5VW41QWhWRGJheDhvSUpyaE5EZmlYS2pIT2ps?=
 =?utf-8?B?MHUxRTBoZmxqNmNZQ1dvZFFQTXdRN2tZVHR3bmZUc1lyRzVCSFVsVVVVaVRM?=
 =?utf-8?B?RVYrMkdieWtGZnQzcXcreGY4WTFocXlJelVBT0pyUjliYmJtT2U1VGxuZ0Zs?=
 =?utf-8?B?bGtKRHZ5VzdEUmFBSXo2RlVMc25yQ2wyUytWaUxpRUc1YlRYVklQRHRET3Mv?=
 =?utf-8?B?QkRab2lRMWhKQnR4aytUYS92TGpBMWozc0JtL1FiTmdTNXgwRXozM3hialhN?=
 =?utf-8?B?aU4rU2J0Sy8wK1ZRRU05czdhT2ZPTURhL0xFbG5tUlJtL0JsaU5kQWUxVi8w?=
 =?utf-8?B?VDkxbUt6N2djNjFtNnZDczFuL3RBUE1BVFg1Wk1uVlNIa3ZUTTF5NVc3K05S?=
 =?utf-8?B?Y0I3VkpyVGQ2NldYUHg5UlFaYWQ1KzRZdVNjYjZXVjVRalN0UjNHaDVvdmd5?=
 =?utf-8?Q?xS6tGtQgw26dzby8=3D?=
X-OriginatorOrg: citrix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7928cac4-cd24-4599-de86-08deaad461a2
X-MS-Exchange-CrossTenant-AuthSource: CH8PR03MB8275.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 May 2026 18:30:28.1939
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 335836de-42ef-43a2-b145-348c2ee9ca5b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +EjNJDxP+yML1vRmQcsIcY7xFQvCjlSmO53XZFimvwcUKD/w2zGqppRFLRmfJNMmq1UEf7W9UkgIYUbBLAkW5sf32EfNVUXTRwlZE2CU6Tw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR03MB5795

On 05/05/2026 7:04 pm, Maciej Wieczor-Retman wrote:
> Hello!
>
>
> On 2026-04-23 at 15:56:54 -0700, Xin Li wrote:
>>> On Apr 23, 2026, at 7:35 AM, David Woodhouse <dwmw2@infradead.org> wrote:
>>> Here's one to get you started (untested as I haven't found suitable
>>> hardware to test it on).
>> Same here for me now :(
> I ran David's selftest on a PTL laptop and ran into a couple of issues.
>
>>> From bd465aabebcb124e09a26fe9f4c861354febabe4 Mon Sep 17 00:00:00 2001
>>> From: David Woodhouse <dwmw@amazon.co.uk>
>>> Date: Thu, 23 Apr 2026 15:20:11 +0100
>>> Subject: [PATCH] KVM: selftests: Add FRED event type classification test
>>>
>>> +static void __used fred_handler(struct fred_stack_frame *frame)
>>> +{
>>> + fred_ss_value = frame->ss;
>>> + fred_saved_rip = frame->rip;
>>> + fred_handler_called = true;
>>> +}
> fred_handler() has problems getting linked:
>
> 	/usr/bin/ld: /home/maciej/linux/tools/testing/selftests/kvm/x86/int1_fred_test.o: in function `fred_entrypoint_kernel':
> 	int1_fred_test.c:(.text+0x104): undefined reference to `fred_handler'
> 	collect2: error: ld returned 1 exit status
>
> I guess the .pushsection below makes it a different translation unit? Because
> getting rid of the static keyword takes care of the problem for me.

The problem is, being static, fred_handler() is eligible to be optimised
away, because the compiler can't see that the asm() refers to it.

Dropping static is the right fix to make.

GCC 15 can now do references out of global asm() to identify the symbols
they use, but it's going to be years before this capability is safe to
use generally.

>
>>> +
>>> +/*
>>> + * FRED entry points. MSR_IA32_FRED_CONFIG points to the page-aligned
>>> + * base. Ring 3 events enter at base+0, ring 0 events at base+0x100.
>>> + * Since ICEBP executes in ring 0, the CPU enters at fred_entrypoint
>>> + * + 256 = fred_entrypoint_kernel.
>>> + */
>>> +extern void fred_entrypoint(void);
>>> +
>>> +asm(
>>> + ".pushsection .text\n"
>>> + ".global fred_entrypoint\n"
>>> + ".balign 4096\n"
>>> +"fred_entrypoint:\n"
>>> + /* Ring 3 entry — unused, no userspace in this test */
>>> + "ud2\n"
>>> + /* Pad to +256 for ring 0 entry */
>>> + ".org fred_entrypoint + 256, 0xcc\n"
>>> +"fred_entrypoint_kernel:\n"
>>> + "movq %rsp, %rdi\n"
>>> + "call fred_handler\n"
>>> + ".byte 0xf2, 0x0f, 0x01, 0xca\n" /* ERETS */
>>> + ".popsection\n"
>>> +);
>>> +
> ...
>>> +
>>> + /* Test 1: ICEBP (INT1) — should be EVENT_TYPE_PRIV_SWEXC (5) */
>>> + fred_handler_called = false;
>>> + asm volatile("lea 1f(%%rip), %0\n\t"
>>> +     ".byte 0xf1\n\t"
>>> +     "1:" : "=r"(expected_rip) :: "memory");
>>> + check_fred_event(expected_rip, DB_VECTOR, EVENT_TYPE_PRIV_SWEXC,
>>> + "ICEBP");
>>> + GUEST_SYNC(0);
> The above event type test seems to fail and return 0x3 instead of 0x5:
>
> Random seed: 0x6b8b4567
> Testing FRED event types with EPT fault on stack
> ==== Test Assertion Failure ====
>   x86/int1_fred_test.c:120: event_type == expected_type
>   pid=16646 tid=16646 errno=4 - Interrupted system call
>      1  0x0000000000413349: assert_on_unhandled_exception at processor.c:659
>      2  0x0000000000407d36: _vcpu_run at kvm_util.c:1703
>      3   (inlined by) vcpu_run at kvm_util.c:1714
>      4  0x0000000000403104: main at int1_fred_test.c:207
>      5  0x00007ff8d4c2a1c9: ?? ??:0
>      6  0x00007ff8d4c2a28a: ?? ??:0
>      7  0x0000000000403314: _start at ??:?
>   0x3 != 0x5 (event_type != expected_type)
>
> after a little digging I think the issue could be this in arch/x86/kvm/x86.h:
>
> 	static inline bool kvm_exception_is_soft(unsigned int nr)
> 	{
> 		return (nr == BP_VECTOR) || (nr == OF_VECTOR);
> 	}
>
> Since ICEBP(INT1) results in a DB_VECTOR it's not take into account and the
> check fails. Then in vmx_inject_exception() INTR_TYPE_HARD_EXCEPTION is picked
> which is 0x3 when decoded.

That's a real bug then.

> I think you'd need to add another check in vmx_inject_exception() to handle that
> DB_VECTOR too. Simply changing the event type if the vector is of DB_VECTOR type
> fixes that problem but then the selftest fails in other places (assert
> fred_handler_called and saved rip vs expected_rip). I didn't yet have the time
> to figure out what could be wrong there, maybe you would have more of an idea :)

#DB is intercepted to mitigate CVE-2015-8104 (systemwide DoS).  But, to
start with, check that the test passes when #DB is not intercepted. 
That's the basecase for architectural behaviour.

When #DB is intercepted, the type in EXIT_INTR_INFO needs preserving and
forwarding into ENTRY_INTR_INFO, because that is what distinguishes an
ICEBP #DB from other #DBs.  There's no way of recovering this detail
after the fact.

On the injection side, some #DB's are traps and some are faults.  ICEBP
will have a fault-like VMExit but need trap semantics, so like other
soft interrupts, need INSN_LEN adding to %rip.  But, type=3 #DBs need to
leave %rip unchanged.

~Andrew
