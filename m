Received: from DM5PR21CU001.outbound.protection.outlook.com (mail-centralusazon11011041.outbound.protection.outlook.com [52.101.62.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BF0B39D6CB;
	Mon,  6 Apr 2026 22:45:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.62.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775515535; cv=fail; b=sE4F4k6T1BZn2dvWJcVs2fihfyfaSXVMyB4WB9Q6MBdDIOeDQ0eomxPabAGLSYazJokfC8hv1/n5eriPdJ/4yUtKmZTrVEMShxOyJcfR4N2XAx9xsKYjrJf9zLMRaF1XM4DH27zselWBvPHvi7rp9GdbOCAteiWM87y8q9Ek2rI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775515535; c=relaxed/simple;
	bh=PDdeXShL+r9kBDc27B9GWLuV31Opmv9S3bQLCqSQwSg=;
	h=Message-ID:Date:From:Subject:To:Cc:References:In-Reply-To:
	 Content-Type:MIME-Version; b=d0UfwdigkHuYl+wmV9aDHmLFCKSLlzIjEFNtp2hjPmh99eVUFGDn2p/9ZGbj/VNj2024YaNSV2F7FhMlmdAJXVsBJt0VO995hlLqJ9jCH5izCXbKmSV9PNW+85yB4ex8qoqSMroJNf+5q17GN7cqqfvqzDHGx5fthAMMW1G6sh8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=ookMz1ZF; arc=fail smtp.client-ip=52.101.62.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="ookMz1ZF"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cowPQxO2nzXznKqAtRCTdCAUJinRp08K8RO+Rjb+uEiXzM764QsFCJwiFVdZfPtFGrghgL3KU5olYHg32z0342ACjXtcWymovWvKliS64O77osqLt4yeTGbpuhK3coJi+4M5UkshUhmxj2MB49FcCvf9yHQ6AH7RIvBjZUn/C5Ed6eMEMQS+P1WD1k6YNvBWWH12qxIWs+uYAW05v1RAANQv22G461BXUJDB0GSPM1QigsAAqvreiIOFZXh2sh2dGTPelVLIM+EDZP3a7XBisJg61WXLHh/GPe/5s5j1I0CuARCtAxh99DOaonDB6FKPskIsl9J6qIF0PZZXkEKcRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=g2X/xbUxNFJDipzl454fRp29iYOXUdIsFBAGoEhu+Ng=;
 b=B3+HhCKzkmqOXnzTSvQSumveLwAvztR7pXfIP2DlxvpglP84mb1nO6mTln4p7799RMeF/A0UNedHY6/NGdRWSAhaH2BA+PpVJZxB+tjDml5IDuFEOFrYZySVNjqXLkRa7ldxMscyj2qclTqWMrVMDXWP4HlXhR3ex29lapiWEd6ccMKmgE7vuvlq3huXxFcy4LF8sNdJS3G+LkH2olLMYuy2V4cciLed0hhspdJWsguunEK1vI5mk/XQXEjiKMbiNrTli5MsunoQ1nWfCSgc8SXUPXJWvZe7BOo9mjZy303yt+j0kho1yxPBFQ9L2Fxo62d4m638hCgOAyZLntoywQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=g2X/xbUxNFJDipzl454fRp29iYOXUdIsFBAGoEhu+Ng=;
 b=ookMz1ZFPSYN16fl0rGx/hEUVjkPNCJWFPd0+kX5WWHoiEnlEWg2V6zG6iEtE+426IqLrMRd0ug5/PjKTB7vjfeJ6fEgyCwV2Xz/QH6BNQcBy8ObT9Sb797tXETLYri4APiZFMN29zvaDCGJ7KtHySe/csw10JtmiOytTx2EhQY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from IA0PPF9A76BB3A6.namprd12.prod.outlook.com
 (2603:10b6:20f:fc04::bdc) by SJ1PR12MB6051.namprd12.prod.outlook.com
 (2603:10b6:a03:48a::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.20; Mon, 6 Apr
 2026 22:45:30 +0000
Received: from IA0PPF9A76BB3A6.namprd12.prod.outlook.com
 ([fe80::e192:692b:abba:8c88]) by IA0PPF9A76BB3A6.namprd12.prod.outlook.com
 ([fe80::e192:692b:abba:8c88%3]) with mapi id 15.20.9769.016; Mon, 6 Apr 2026
 22:45:29 +0000
Message-ID: <5a740f47-d3f3-45af-9d8c-ebcf3dd89c0d@amd.com>
Date: Mon, 6 Apr 2026 17:45:26 -0500
User-Agent: Mozilla Thunderbird
From: Babu Moger <babu.moger@amd.com>
Subject: Re: [PATCH v2 00/16] fs,x86/resctrl: Add kernel-mode (e.g., PLZA)
 support to the resctrl subsystem
To: Reinette Chatre <reinette.chatre@intel.com>, corbet@lwn.net,
 tony.luck@intel.com, Dave.Martin@arm.com, james.morse@arm.com,
 tglx@kernel.org, mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com
Cc: skhan@linuxfoundation.org, x86@kernel.org, hpa@zytor.com,
 peterz@infradead.org, juri.lelli@redhat.com, vincent.guittot@linaro.org,
 dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
 mgorman@suse.de, vschneid@redhat.com, kas@kernel.org,
 rick.p.edgecombe@intel.com, akpm@linux-foundation.org, pmladek@suse.com,
 rdunlap@infradead.org, dapeng1.mi@linux.intel.com, kees@kernel.org,
 elver@google.com, paulmck@kernel.org, lirongqing@baidu.com,
 safinaskar@gmail.com, fvdl@google.com, seanjc@google.com,
 pawan.kumar.gupta@linux.intel.com, xin@zytor.com, tiala@microsoft.com,
 Neeraj.Upadhyay@amd.com, chang.seok.bae@intel.com, thomas.lendacky@amd.com,
 elena.reshetova@intel.com, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-coco@lists.linux.dev,
 kvm@vger.kernel.org, eranian@google.com, peternewman@google.com
References: <cover.1773347820.git.babu.moger@amd.com>
 <14a8ad0a-e842-4268-871a-0762f1169e03@intel.com>
 <47c0db32-d0e0-4c53-90bd-b74863d233dc@amd.com>
 <88eebfac-5286-4788-b244-911c659c0439@intel.com>
 <30deeb5b-d2ec-4f85-aa4f-c21400df3486@amd.com>
 <83ae0c18-5c5e-4b52-901d-4126fe7c141b@intel.com>
Content-Language: en-US
In-Reply-To: <83ae0c18-5c5e-4b52-901d-4126fe7c141b@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SA9PR13CA0065.namprd13.prod.outlook.com
 (2603:10b6:806:23::10) To IA0PPF9A76BB3A6.namprd12.prod.outlook.com
 (2603:10b6:20f:fc04::bdc)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA0PPF9A76BB3A6:EE_|SJ1PR12MB6051:EE_
X-MS-Office365-Filtering-Correlation-Id: 6e5b6f23-d686-4626-9f6c-08de942e3426
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|366016|7416014|22082099003|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	deCoBVEGyodssgUjkmQEu5uLZVxnxFsG2MKcKSPn0lC+rmJwNMQ8i+KaZZWUxHH8tJtgpfw50z0jViEsYXPxcKcshUkq8eaLNhBtG9ECE2FiH8gmWQpWGClkaqgBwPzWvJxveUD5hU0Lk45HWd0bXYqspHDBIFlC/2LFNSQwMxlhBYfuZI6MMEwqEnD3QC4fiHfsGH3a8TSw+FDVrjbNhu0mZvcTsGejGX0XyyO78zqYITOWCL1KiHOydTavchdu3xu/+YckPzPyjMK0P/f2/47lEdS05cvkoapPlbAoKayeJtjejKHzyFOkPrh+RGXBGKiSjrcGVLcgLa4ZAKzRG98eIXnDF1geGCT+f16wSMltOAc4BGisuX6wsaOO81S0SwiGowNSZTd9XfTl0MbmuKFdpTvOtq+OxKsGm/li9tWGTDi0CdBzz2qSEEtYDLM17uqsK9GDhIqpx2xzTEqUAzEEx1clzh7vAcR8YnmylAVi2EUBUOLgvrpkHqmGq69V39q5EFbIb/vD8JqPO2awU7vcnpNPjHIUg2UjprIjZMKAvfLq6/yPv/Er+joPuoe8Y6D6z93WZtHxFcsXI8vcxKOsHshDKqt2PTjd9lmq5x/m/dzXLUPIT16rFdSoPzlYrscs0HF4d+ubVBCpKUohrXb7SEClESXD6k7qggzOQ8mKyp8khytMoC51EYE0KCewgCL6/q9g77JxQqjkRNwz4g==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA0PPF9A76BB3A6.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(7416014)(22082099003)(18002099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?UGEyMUhQT1FKdGtJTk5pL2RwSjJTSGJldVkzb2ZPVDlhUHk4ZEx3QjlGK2or?=
 =?utf-8?B?dnNpYzQ4RU9DTFkxQVhtRFJkLzU4ZW9ocGlHaVdybHh1dlBDeTlneWtObG1n?=
 =?utf-8?B?M3NRU0c3U0oyeVZWTUUyd2ROYi9wUjRONlRXVFVMK2JrcFEyb1Bxa1VaNTBn?=
 =?utf-8?B?MVpPMEFRNjh0NEIyKzBWbmxRa0swb1NtQmRsblBKM2puOHVuRXVOdGR1aHhD?=
 =?utf-8?B?TEJVazI5eENXbFBITlFBTVJDeUpEM0Uzak50cm5xRzBHeHdrUDhxSHZUTmhB?=
 =?utf-8?B?b1VSMDIrK0ltSkt3emZYSlFLcC93SUo2QTFOMUNES0cvcXd1dVlDdFVaWUY4?=
 =?utf-8?B?cFdOV0RtVTdBNGVSS0U4NTNTcFEzeSswczdRUG1xbVozR1lmdFh5U2pMZUNQ?=
 =?utf-8?B?M3d5Q1orYU1WSDRsY29USytiOHJqZGhEMVYxdnNtZXpoQVlnYm9hV3MzOHNn?=
 =?utf-8?B?YmJTYzV0NHI2K3BIdTJkU0trRkdhWkdXa3JvU2plV20xMzNNWjhvZjdqZEFN?=
 =?utf-8?B?aFMxNjM3L29qSjB0dHRxTGp5RHAyckRGY000RUFIOUdJWXZIZ2RsZWE2N3pp?=
 =?utf-8?B?NnE2ZFBqN1IzTlRzazc1S1NYR1h4eXZmMW1rVkRXV0tKTXRnQzlnMzFqNWpT?=
 =?utf-8?B?c3lOUUdlY1ZvdjU0SWlzTjdHa3grN25nMlFuL0pBQzJoL3czZmJiZG85Z2xu?=
 =?utf-8?B?QjhWMkc4S0xsVnYwbG4vZzVOZ3JHOHRRQWFRdElDYWJYZWQrano0dDRpQ0cv?=
 =?utf-8?B?V2FTbTVLdmpObDB0WW8rMDVjS1NUVlN6cFZNb1VGMi9JbzI1ZDBVQngrc2tB?=
 =?utf-8?B?VmJZMnM0S09vTDd0K253NTRTa2grT0Ria1d2Z3ozb2J6b2hCMlcydlpsVGF6?=
 =?utf-8?B?UC9tWjA3Ums5S00zSGJJNmNTOTM5RVF6U2E4MGxMMTZZbXRJOXplRk9tQzMv?=
 =?utf-8?B?OG9uYzR5eVJUNUhMamR6UThZZHJHVGYwR0hZdmlJMHF6T1JZazExV0hyRC9t?=
 =?utf-8?B?R0dTMVBkdHAzUzF5b1hUNExKdjI1NkdySWgwclZlNWtTbWU3K1ZkSldWZXhp?=
 =?utf-8?B?cG9DYXZQcXcvTnNWYTRPcXNOYnVvSXRmRE9zSFJJMUNHOTk2emhZZDNEanN4?=
 =?utf-8?B?R3Bwd2NsZEFkeDA3ODBiYTIwVUV6QnVWYURCa3NhY1RJZUxKaUxkbExiQUlw?=
 =?utf-8?B?bnlhVklzcE5xZ0RvNHUwWUZWWFovMng4SkszOE5valg0ZlJkWHQwWWdZTTYw?=
 =?utf-8?B?d0ZlOXBwMGl5YUNibXcvcGdFOTd2WUlTZGZ4UDk0OGU4SXJ0Q3dEWStlVUov?=
 =?utf-8?B?NFNMOE5LVk91ZnphYVpZL2RBd3JSQmJoZHY1cGIzSGtuNUZzMUVrMGZGcmFS?=
 =?utf-8?B?MEsreTRlSGUvZFM4OG05dmYvenI5VWVYMmRJZ2F3bUNDMllYMTRVNDJ0eDV2?=
 =?utf-8?B?ZW4xZWIrQzB1Z2xwTFg5SWxDS0F1TExnQ2tDUGRSZ3hTc0Q5eEt3UjZBMGRu?=
 =?utf-8?B?emZSU0xnMVB1TFJzaUNtU3JBY0ZYWGwvbUlHSDFCMVd6UkdnVFdSdmVjZ2la?=
 =?utf-8?B?Z1ZVSU5LbC9qQWkrNTUwM1FkOCtHVkJvMU9Pb3oxN0hablhvTzJvWjhIT0Er?=
 =?utf-8?B?Vnpua0FFOXk4OFIvSjJiVC9NU0dJYW5yU3ZTalVDVnUrNGVMTGdyN3drSDhP?=
 =?utf-8?B?TVNnTE5TMGVKdXhjQnpCSXMvdnJHdEFyMGJwK3lwcmFEU3dUWlV0MmhuZ0xj?=
 =?utf-8?B?T0lFRXk3WXpMMkpRcE14V2NScUJMdEhKMnN4ZUY4NTdHcWwvcDJJMWZYTjZv?=
 =?utf-8?B?bUozRFNhRnNIbklZV2lCenlNcmRGeGJaR2hCTFBrdTcyb0FzaWREeHFrSElJ?=
 =?utf-8?B?RllxYVkxRlhHeUtiWnMyM1FMaDRaQ0dpdFRxN3ErTmVLaDJsZFZGb3VtUHRy?=
 =?utf-8?B?d2NJMStaUlVjTG0vRE9NZlJqZFkrN0Y4Ni92aEg1Q0xqVmVQS2NWWWM5b1Zw?=
 =?utf-8?B?eC9lSmhXRDZtMUNacFh4WmEvKzl5MHlodTdwd2lmSVRsM3Q5Si9oZDV0ejVB?=
 =?utf-8?B?US8xWDNnTlNmdTROUEI1UjNBUWtVSW9XdHErT0lpZ05DRVlWY2JJQ08wT1Bl?=
 =?utf-8?B?VHpJUmIwY0R0TFJ4RzNjdEF1VmVyQmlySWVWdnRxT01FZU51TFRidnkwdkJV?=
 =?utf-8?B?V0hWSE1DeG9KaUNadW82L2lQTit2WUtub0dXMTR2RUVOZmtHSjVPV1BDMm4v?=
 =?utf-8?B?RXJvRDlxaTNIcmlndmYvVmRQdEFVRExDV2tpc3dLRHltaWd6eDNQam1YSjM3?=
 =?utf-8?Q?gX5uMGmZ58VICMcm4+?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6e5b6f23-d686-4626-9f6c-08de942e3426
X-MS-Exchange-CrossTenant-AuthSource: IA0PPF9A76BB3A6.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Apr 2026 22:45:29.8764
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zeJQHTNO+fJsuI3Psk+1gg710mAiidc8toLHjHDD6KPJKZ0PPqiY11IWUGiAF4zw
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6051

Hi Reinette,

Sorry for the late response. I was trying to get confirmation about the 
use case.

On 3/31/26 17:24, Reinette Chatre wrote:
> Hi Babu,
> 
> On 3/30/26 11:46 AM, Babu Moger wrote:
>> On 3/27/26 17:11, Reinette Chatre wrote:
>>> On 3/26/26 10:12 AM, Babu Moger wrote:
>>>> On 3/24/26 17:51, Reinette Chatre wrote:
>>>>> On 3/12/26 1:36 PM, Babu Moger wrote:
> 
>>>>>>         Tony suggested using global variables to store the kernel mode
>>>>>>         CLOSID and RMID. However, the kernel mode CLOSID and RMID are
>>>>>>         coming from rdtgroup structure with the new interface. Accessing
>>>>>>         them requires holding the associated lock, which would make the
>>>>>>         context switch path unnecessarily expensive. So, dropped the idea.
>>>>>>         https://lore.kernel.org/lkml/aXuxVSbk1GR2ttzF@agluck-desk3/
>>>>>>         Let me know if there are other ways to optimize this.
>>>>> I do not see why the context switch path needs to be touched at all with this
>>>>> implementation. Since PLZA only supports global assignment does it not mean that resctrl
>>>>> only needs to update PQR_PLZA_ASSOC when user writes to info/kernel_mode and
>>>>> info/kernel_mode_assignment?
>>>> Each thread has an MSR to configure whether to associate privilege level zero execution with a separate COS and/or RMID, and the value of the COS and/or RMID.  PLZA may be enabled or disabled on a per-thread basis. However, the COS and RMID association and configuration must be the same for all threads in the QOS Domain.
>>> Based on previous comment in https://lore.kernel.org/lkml/abb049fa-3a3d-4601-9ae3-61eeb7fd8fcf@amd.com/
>>> and this implementation all fields of PQR_PLZA_ASSOC except PQR_PLZA_ASSOC.plza_en must be the
>>> same for all CPUs on the system, not just per QoS domain. Could you please confirm?
>>
>> Sorry for the confusion. It is "per QoS domain".
>>
>> All the fields of PQR_PLZA_ASSOC except PQR_PLZA_ASSOC.plza_enmust be set to the same value for all HW threads in the QOS domain for consistent operation (Per-QosDomain).
> 
> Thank you for clarifying. To build on this, what would be best way for resctrl to interpret this?
> As I see it all values in PQR_PLZA_ASSOC apply to *all* resources yet (theoretically?) every resource

Yes.  That is correct. PLZA applies to all the resources.

> can have domains that span different CPUs. There thus seem to be a built in assumption of what a "domain"
> means for PQR_PLZA_ASSOC so it sounds to me as though, instead of saying that "PQR_PLZA_ASSOC needs
> to be the same in QoS domain" it may be more accurate to, for example, say that "PQR_PLZA_ASSOC has L3 scope"?

Yes.

> 
> This seems to be what this implementation does since it hardcodes PQR_PLZA_ASSOC scope to the L3
> resource but that creates dependency to the L3 resource that would make PLZA unusable if, for example,
> the user boots with "rdt=!l3cat" while wanting to use PLZA to manage MBA allocations when in kernel?

Yes. that is correct. It should not be attached to one resource. We need 
to change it to global scope.

> 
> ...
> 
>> Yes, I agree with your concerns. The goal here is to make the interface less disruptive while still addressing the different use cases.
> 
> I consider changing resctrl behavior when values are written to existing resctrl files
> to be disruptive. This is something we explicitly discussed during v1 as something to
> be avoided so this implementation that overloads the tasks file again is unexpected.

Yes. Agree. If required we need to introduce new files (kmode_cpus, 
kmode_cpu_list or kmode_tasks) to handle these cases.

> 
>>       Background: Customers have identified an issue with the QoS
>>       Bandwidth Control feature: when a CLOS is aggressively throttled
>>       and execution transitions into kernel mode, kernel operations are
>>       also subject to the same aggressive throttling.
>>
>>> Privilege-Level Zero Association (PLZA) allows a user to specify a
>> COS and/or RMID to be used during execution at Privilege Level Zero.
>> When PLZA is enabled on a hardware thread, any execution that enters
>> Privilege Level Zero will have its transactions associated with the
>> PLZA COS and/or RMID. Otherwise, the thread continues to use the COS
>> and RMID specified by |PQR_ASSOC|. In other words, the hardware
>> provides a dedicated COS and/or RMID specifically for kernel-mode
>> execution.
> ack.
> 
>>
>> There are multiple ways this feature can be applied. For simplicity, the discussion below focuses only on CLOSID.
>>
>>
>>       1. Global PLZA enablement
>>
>> PLZA can be configured as a global feature by setting |PQR_PLZA_ASSOC.closid = CLOSID| and |PQR_PLZA_ASSOC.plza_en = 1| on all threads in the system. A dedicated CLOSID is reserved for this purpose,
> 
> Also discussed during v1 is that there is no need to dedicate a CLOSID for this purpose.
> There could be an "unthrottled" CLOSID to which all high priority user space tasks as
> well as all kernel work of all tasks are assigned.
> If user space chooses to dedicate a CLOSID for kernel work then that should supported and
> interface can allow that, but there is no need for resctrl to enforce this.
> 
>> and all CPU threads use its allocations whenever they enter Privilege Level Zero. This CLOSID does not need to be associated with any resctrl group.

I misspoke here.

> 
> The CLOSID has to be associated with a resource group to be able to manage its
> resource allocations, no?

Yes. We need to have resource group schemata to enforce the limits.

> 
>> The user can explicitly enable or disable this feature.
> ack.
> 
>> There is no context switch overhead but there is no flexibility with this approach.
> 
> Flexibility is subjective. As I understand this supports the only use case we learned about so far:
> https://lore.kernel.org/lkml/CABPqkBSq=cgn-am4qorA_VN0vsbpbfDePSi7gubicpROB1=djw@mail.gmail.com/
> 
>>       2. Group based PLZA allocation :  PLZA is managed via dedicated
>>       restctrl group. A separate resctrl group can be created
>>       specifically for PLZA, with a dedicated CLOSID used exclusively
>>       for kernel mode execution. This approach can be further divided
>>       into two association models:
> 
> So far this sounds like global allocation since both need a dedicated resource group.
> Whether this group is dedicated to kernel work or shared between kernel and user space work
> is up to the user. There is no motivation why CLOSID should ever be enforced to be
> exclusive for kernel mode execution.

Yes. That is fine.
> 
>>
>> i) CPU based association
>> CPUs are assigned to the PLZA group, and PLZA is enabled only on
>> those CPUs. This effectively creates a dedicated PLZA group. MSRs (|
>> PQR_PLZA_ASSOC)| are programmed only when the user changes CPU
>> assignments. This approach requires no changes to the context switch
>> code and introduces no additional context switch overhead.
>>
>> ii) Task based association
>> Tasks are explicitly assigned by the user to the PLZA group. Tasks
>> need to be updated when user adds a new task. Also, this requires
>> updates during task scheduling so that the MSRs (|PQR_PLZA_ASSOC)|
>> are programmed on each context switch, which introduces additional
>> context switch overhead.
> 
> As discussed during v1 any changes needed to support per task assignment would
> need to be done with new files dedicated to this purpose. Do not overload the
> existing resctrl tasks/cpus/cpus_list files.

Yes. Sure.

>   
>> I tried to fit these requirements into  the interface files in /sys/
>> fs/resctrl/info/.  I may have missed few things while trying to
>> achieve it.  As usual, I am open for the discussion and
>> recommendations.
> 
> Many of these items were already discussed as part of v1 so I think we may be
> talking past each other here. I tried to highlight the relevant points raised
> during v1 discussion that I thought there already was agreement on.
> 
> The one new aspect is that I assumed this implementation will only be for
> global configuration and assignment. It looks like you want to support both
> global configuration and per-task assignment. In the original I did not consider
> configuration and assignment to occur at different scope so we may need to come up
> with new modes to distinguish. Consider the addition of two modes as below:
> 
> 	# cat info/kernel_mode
> 	[inherit_ctrl_and_mon]
> 	global_assign_ctrl_inherit_mon_set_all
> 	global_assign_ctrl_assign_mon_set_all
> 	global_assign_ctrl_inherit_mon_set_individual
> 	global_assign_ctrl_assign_mon_set_individual
> 
> Above introduces a "set_all" and "set_individual" suffix to the original two
> modes.
> 
> global_assign_ctrl_inherit_mon_set_all
> global_assign_ctrl_assign_mon_set_all:
> 
> 	Above are the original two modes but makes it clear that when this mode is
> 	activated _all_ tasks run with the assignment.
> 
> global_assign_ctrl_inherit_mon_set_individual
> global_assign_ctrl_assign_mon_set_individual:
> 
> 	Above are two new modes. In this mode user space also assigns a resource
> 	group globally but then needs to follow that up by activating every task
> 	separately to run with this assignment.
> 	One way in which this can be accomplished could be to have "kernel_mode_tasks",
> 	"kernel_mode_cpus", and "kernel_mode_cpus_list"	files become visible (or be
> 	created) in the resource group found in	info/kernel_mode_assignment. User
> 	space interacts with the new files to set which tasks and/or CPUs run with
> 	PLZA enabled.
> 	
> Even so, as I understand global_assign_ctrl_inherit_mon_set_all and
> global_assign_ctrl_assign_mon_set_all addresses the only known use case. Do you know
> if there are use cases for global_assign_ctrl_inherit_mon_set_individual and
> global_assign_ctrl_assign_mon_set_individual? The latter two adds significant
> complexity to resctrl while I have not heard about any use case for it.
> 

Yes. I agree. The changes in context switch code is a concern.

You covered some of the cases I was thinking(xx_set_individual).

How about this idea?

I suggest splitting the PLZA into two distinct aspects:

1. How PLZA is applied within a resource group

2. How PLZA is monitored


Introduce a new file, "info/kmode_type", to describe how kmode applies 
in the system.

# cat info/kmode_type
[global] <- Kernel mode applies to the entire system (all CPUs/tasks)
   cpus   <- Kernel mode applies only to the CPUs in the group
   tasks  <- Kernel mode applies only to the tasks in the group

The "global" option is the default right now and it is current common 
use-case.

The "info/kmode_type -> cpus" option introduces new files "kmode_cpus" 
and "kmode_cpus_list" for users to apply kmode to specific set of CPUs. 
This lets users change the CPU set for PLZA. The PLZA MSR is updated 
when user changes the association to the file. No context switch code 
changes are needed. This will be dedicated group. The current resctrl 
group files, "cpus, cpus_list and tasks" will not be accessible in this 
mode. This option give some flexibility for the user without the context 
switch overhead.

The "info/kmode_type -> tasks" option introduces a new file, 
"kmode_tasks", for users to apply kmode to specific set of tasks. This 
requires context switch changes. This will be dedicated group. The 
current resctrl group files, "cpus, cpus_list and tasks" will not be 
accessible in this mode. We currently have no use case for this, so it 
will not be supported now.


Add a file, "info/kmode_monitor", to describe how kmode is monitored.

# cat info/kmode_monitor
[inherit_ctrl_and_mon] <- Kernel uses the same CLOSID/RMID as user. 
Default option for the "global"
assign_ctrl_inherit_mon <- One CLOSID for all kernel work; RMID 
inherited from user.
assign_ctrl_assign_mon <- One resource group (CLOSID+RMID) for all 
kernel work. Default option for "cpu" type.


Rename “kernel_mode_assignment” to “kmode_group” to assign the specific 
group to kmode. This file usage is same as before.

#cat info/kmode_groups (Renamed "kernel_mode_assignment")
//


Thoughts?

thanks
Babu

