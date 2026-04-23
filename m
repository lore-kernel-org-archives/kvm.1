Received: from GVXPR05CU001.outbound.protection.outlook.com (mail-swedencentralazon11023106.outbound.protection.outlook.com [52.101.83.106])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DB11364055;
	Thu, 23 Apr 2026 08:52:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.83.106
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776934377; cv=fail; b=Q3+m1UTaf08YQhLS+T4WoQhYGtxH7y5dq7QVw3Pg1vGzBAP1sWL5uaD66rJ2BQzWa2tb15sWBEycCtiAQQbj3F+G/87Av1+PhBQiYTQRuzUZcDp5lA99o6zvB0yUo1o4YU3KRaWQbvnqa+E0IhxSP6xFbe0DmSTIBB4pw2/Nf/U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776934377; c=relaxed/simple;
	bh=+3ujqsvMmKoc6g5x/GU1vHB6Un3OwMpnZzGajeKx0Tw=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=RKfce3XF0wjh5GjNsE+HPWHYW4a1NBd0F1Pf2kzdqNxBpZ4EQiWmyN27i4RMTS2NqVZZwioCQQ7VrojVY0DO5G1YCGmsM0XYqAZ/+FTz4BOSqkIdgn/gKxzwh3YNbSImHtDGpsctxhVq8MhDKTA/Ti/m50mu0uf0zG2eP+r0/Is=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=virtuozzo.com; spf=pass smtp.mailfrom=virtuozzo.com; dkim=pass (2048-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b=JggFkmOQ; arc=fail smtp.client-ip=52.101.83.106
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=virtuozzo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=virtuozzo.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="JggFkmOQ"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=v5qCZh772j6Y82VxPQEGPcUY/frpjstgJ65uH+HccP57gpeO9neR99C0tSIn45E1wZi7p6Pi7zbIhGj8yTulxAt6ao2EEsEet7PloB9x3HzaTsg5s6tmA9f0C6HpUUiTmIQ67JvAwPz8UDjxE7ns6DsJU1/SkF3VovBHT2IfZTK7Tp6q0qeKFhGkNxs7cF7wbQ4ZiccggbDVwpA2he6T9JUT05np8GqEZXE+F8yf63VM0Rd5Zu9iB/e2F/JVkwEIDVwo4bgxPPiVFlQzcVCeJ+rfvQQZ7XihV38UcWKWzsWd0ilUPn2tQoh8wV/uazZxf2T0WGAiKwEl4kLBR21JTA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pqzxpOZqXuMLXZompzGfWUOdedXJ7TZjOwrz/w13nw0=;
 b=up+SGWF0o50EzhJ61i5nug0hPLJhwUZFb4LWVv66BU87LNDuaoiMnMoxkCWWX+HRwoYgMXcfZrah3xVwx6MKKyCa0KRZMnMnrRnMY/Y7zLEli207OJxrNVWT7CKCSJ5+Ckneq522sqtzO8bmdbAPuukxhkpTaSCsxHerp2xCcwSWNA4bBQG9uzgiaWh2OrePC61+dzRKubBtYiqHjEBooTYbiS5TzfOZaLYuizRYHIoc2/KEy0QHArWzYZ8cRWnzaU/o822+Oq6LQILHmHg1os0tk6NhsqKHZZWKa335GUuj9VL37J17yd/Y0atsqFTiNSzlaZK7WAYtIzRPEbGMmQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pqzxpOZqXuMLXZompzGfWUOdedXJ7TZjOwrz/w13nw0=;
 b=JggFkmOQvuRORtMvyNzrg4P9u7yeTUr3Lw6Lf/ICH1wi/7HeXcd4xCHuSvmz0kcrqG+f/WcV5k8U/Hi5j3z8lpzEugwzHru8BeAhazEmup1EXKMqM+vEBsm9piPEn4BkvNInY8v/sLOMD8ab99jyOVhQ54kkrFiCHUM/k8334LbvRjrUrZd6js/LJ8XytSNm4HzhgC1Vl8PgUo2w3wA0+JPHKT1iDj0hHaemkT9KbBcpXhDl30DXJldi0jPjD5L6JbIDYHEJaogJiz9zcKOUlbGeBraYLta1df6nJb/8ff7EZo+yz3AGbqEBcUM0RBwaYBbYjcaUEaqfsUeqHkQ1Gg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=virtuozzo.com;
Received: from PA6PR08MB10708.eurprd08.prod.outlook.com
 (2603:10a6:102:3c7::20) by DB9PR08MB7421.eurprd08.prod.outlook.com
 (2603:10a6:10:372::5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.21; Thu, 23 Apr
 2026 08:52:52 +0000
Received: from PA6PR08MB10708.eurprd08.prod.outlook.com
 ([fe80::1999:c6db:dc55:494a]) by PA6PR08MB10708.eurprd08.prod.outlook.com
 ([fe80::1999:c6db:dc55:494a%6]) with mapi id 15.20.9846.021; Thu, 23 Apr 2026
 08:52:52 +0000
Message-ID: <71d71392-fa97-4dcd-bc39-9fa5bd8e4f5d@virtuozzo.com>
Date: Thu, 23 Apr 2026 10:52:50 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 0/1] KVM: VMX: restore host CR2 after VM exit
To: Sean Christopherson <seanjc@google.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org,
 Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
 "H . Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org, Pavel Tikhomirov <ptikhomirov@virtuozzo.com>
References: <20260422175000.1544258-1-khorenko@virtuozzo.com>
 <aekZxVXzxJ_sj4Ev@google.com>
Content-Language: en-US, ru, sr
From: Konstantin Khorenko <khorenko@virtuozzo.com>
In-Reply-To: <aekZxVXzxJ_sj4Ev@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AS4P190CA0053.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:20b:656::17) To PA6PR08MB10708.eurprd08.prod.outlook.com
 (2603:10a6:102:3c7::20)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA6PR08MB10708:EE_|DB9PR08MB7421:EE_
X-MS-Office365-Filtering-Correlation-Id: 53c95346-138f-4441-0637-08dea115b409
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|7416014|1800799024|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	oNIIKNYrJ0Uwmw+HnRtfEHGTfOtAlYj8BNM3DbLLxpM/kkTF9kx0fTT8jTw0q3zW0OqfIywJhF8+73pPW4cjFsZWJSvFFQqKhsVMEhUVmzZOLrt7eA72GQaRBnrZg2/pha60PiozJWPRoKk9kvZ0GnUk7n5FlFJzeAAFF5N3EWhWOR9b120d3DiXaLlt0pvJvt9iw2NvkVNrqwhttoAPJDP098pZir8UIUxrsTywVgU179OgB2JWo5Z9dpqpMDXVqyjUEKJlVXRhM/6d0p900CgTNcQzWJawLauKigt/di9ooNBbMlPjr2KjMvK2vYzTHcJDKkjA/Q8a8EXSIBS2UabD9YKFLfrqUwI79EnXuJtgvHvATRy2Tjx7S41HYgnI+npoSTC5S18TBIH3alAdzV+WDxdWs+b3lqLJ8WR1ZFhnNAIuUtng7bmlArWM1XwBvOn5ycyA4UALl6rcrDYVbc461BgWsPo/n+Gf8B1xaGC0xewYKgXI3ovB3b6kQTgtSnMWJDDpjaGUk1uujYdjGTSIzTmS7oFRDpMpdXa74k85opPJ97Ha+daJrof4rH9rJEW+uNHWhexG1M3Z7KGz61UlPPc3xNtXV0qZ3bvFKYXOG3xJBT/b4Qw8nAsWMYURzqQNht0qSfqnYh+5sQHwnetusRih/Tx8+8zcPc/8Pt+EbUb+J8806LrhEpD57IdRXFnshgqrz3N2MGQ8Pj4bRknkG8cmX+BKv5eOUprmOkA=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA6PR08MB10708.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024)(56012099003)(22082099003)(18002099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?S1FESWdhUTBOS0JVK2JtQ2tDQ0xwdElSQWJKQU1kUTBrRjlIN0NnMkM4TFdy?=
 =?utf-8?B?L2lXeUw1YmZTU2FQMTBoaXNINHpPY2ltcTBuSEtqYnFkUUZsbWJvQ1BFRUV2?=
 =?utf-8?B?bktGV0tqdWJ2V291UEE2WjJpVUFLNE1kd01KRWNKZWtMa3MzWXk2bWtjMk8v?=
 =?utf-8?B?bkgvNjJhdWl5SlZtblAzclZ6bmlFVzRmb01mcDVPVktPanUxNUJHd3F2V0Nj?=
 =?utf-8?B?MDJCcGZPUjl6di9wUGU4UmNBMnhOQjNlcDJNY0J0aEltUjU0SVB0bWhkN2o5?=
 =?utf-8?B?aU1yQ1VqWlVHckIvNUYwUm1McklJdUVIZER1L21MNC9HaGZHL2RtQm4zc0Q3?=
 =?utf-8?B?YkN6ek05NThNVjhldy96R1RHejdJclZIREgrSmJSQ0Vvc3RJWjJXM1VyZ3Rj?=
 =?utf-8?B?Q3oxQkZoOXluTWNoMTU0eFZGNVhDczdTa1dWa2Zvd1pwYU5JamJNWXoyVjlq?=
 =?utf-8?B?eVhtUXRYS3ZSOFIwOXV3c2pheXdEK0ZYYU5sb0dveWVuT3hVNWtsdWRHaVRR?=
 =?utf-8?B?NkJWOFFjZGNFY3NBU1NBMUN0SDc5bU4vY0ZJVlR3clhEc014VjhsL3FWNCtX?=
 =?utf-8?B?WENpYm14bnA1V3IrNFFqZjRNYTVRWE56M0IzN3gwUnljeHJIRGhvMHpqenNF?=
 =?utf-8?B?QUNzOFdwVmZQb2k0QmhXVzk0VzN3cE80OC91SkRzWE1CZ1IzRGlDWUNQeUV1?=
 =?utf-8?B?ZWVMVjhyZlBKZFZ5TEZtWkhFQXNxWU1TYXYxK1hDYTYxYkZvME1GcHV4b2hi?=
 =?utf-8?B?eWwzTGFVbUJxRkhKOXI0OHQzMlJyYXNaM1VZUnc1UEN5U1RjTmtzUC9kV2Vm?=
 =?utf-8?B?c2l5ZFRsMmhVN3IyaGJrMEhzamRnbE9BL1dzZk5QS3FPc2VhTjlsY2k5bFVh?=
 =?utf-8?B?d3UybHIvZDF2MFhiUjA5NjNzSklZZzlTRkpuZ2tZMy93dVdrNjFSVkkvSzVv?=
 =?utf-8?B?ZlNZb2xSYVRLWVEvNjdQOVIrM2IvdXAvc3pNeWZTc2pibTJvVzFyUVNMZ2FX?=
 =?utf-8?B?L3RZS1JpYVdYaEhnRzBwbHl5ZzZ5RzZhaG5NbTVidWF6MGlzMDJMYk9HYm9q?=
 =?utf-8?B?dVZVZi9ycnROdEpFcys4WmdaTTNGVXRwZFdqN3ovNGVoUHVyK29SdmFqVXJU?=
 =?utf-8?B?WWxzeWdkM0g2b2ZZYXFlaTVXYTBmcUI3N0tLREVkaTl0bzJpTUM1MTNuM2ZV?=
 =?utf-8?B?anZjRVgzUVZWWEhncDRtNGhDOExXRE9GV1JFVGQwM3JDVEtyOHZmajUyV1dy?=
 =?utf-8?B?bTVsMktNVUtXQWtQWmpmaFRQcHRSTFJwcjYwZDI3RGg0cGxBbGZ1aWJMY2lw?=
 =?utf-8?B?YVdxaWZBbTRkSHNZbk9lcGRSZUtrRmhrTDgyUlJCUGtWaXYvNFJYL1dqV0lJ?=
 =?utf-8?B?Q0h5RXVMa1h0SlFEdndHaGt1SVFjTGt2VHpTRmJnV3dBSk1VT05OdnZycWZx?=
 =?utf-8?B?RDYySlYzQ3JNdFFseThWazYzMHNjMTFRenFuRlRWUXcrRWdIZ3RKNjZJMWZO?=
 =?utf-8?B?bjhZc0hIemQ4bm8rWUVDOHJrejc2Q21PK2pkaFhGdWhsTTZNUmJYeHIyeXQr?=
 =?utf-8?B?VXdrbFVhYXRxMnYxN2g1MVZROERUZFA1UG1pTHhBZlhDSCtxK0pUVnNQcG5M?=
 =?utf-8?B?NnlSMzc1M1ovdDhFZTRwd2M5VkNUbXJVdnFsNjAyY2Z2T0tXR3REQTlYanBq?=
 =?utf-8?B?LzJCb0lHQzg2NHQzZFB1VjlON21XZDNHNk8wSUFrVnhJbXJTcjhxdlAzWkZw?=
 =?utf-8?B?VE9BZFFDUmIzbEM2WXVTSXZOYkZGMmtWeG9zZzZOSTRPeVd5K0V5cGd0QnN1?=
 =?utf-8?B?Z2dIOXhwUUhHY0RNMEVqOUdzbGVjLzlSVVRLSGkwdnJGNFAwN3N5cXdTSmQ2?=
 =?utf-8?B?eEU2U2xkeVdqNlE3NTBDYkZaTXlHRy9KeW1LNTM0VzRoZ1o5UWNXbFV5ZU9t?=
 =?utf-8?B?Vis3SnFKc0wrZ0FDaUp1MHdFWVdTYm1tS0x3dHNZYnNPMG90NTc5U2FMb0V2?=
 =?utf-8?B?R2hOdGkwTThyQktiZk5nT29VR3JWakxPbVlpOEV0SVdtWTBtNFVEUWhKL1kr?=
 =?utf-8?B?aEQ0T084OVo2SXRkQWVZVEdpWWJSRlFiZStXZ29qNE9abFgwY0JhMWFpSVNO?=
 =?utf-8?B?c3Y3UWRIK3liYkY5cVBXM2xaRkkwZVBxcmhpU291TnRQdjFzUUtJQU5GcVFo?=
 =?utf-8?B?UUc3QjRuS3dBbFliOGVGMEpIeFZhRXJXTW9WbEg1TEF1Qzlub2JTVmtOcDFG?=
 =?utf-8?B?WWZEWXRCMmw1Q1BaOU9kR0Vkcy9WQ296UEl3WU5UUWZCdmRFTUVZSXhBSmRs?=
 =?utf-8?B?Y015bHNhSUtUUDRkbHRzTGlEY2tBS0txYWpEQUdIN05IdFlsbUhJUT09?=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 53c95346-138f-4441-0637-08dea115b409
X-MS-Exchange-CrossTenant-AuthSource: PA6PR08MB10708.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Apr 2026 08:52:52.2288
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aNuZhPdBxc/Tyw5CmkxR4LeUlFemiB0BudNzssnqYeArsCd9GL424pPAc2CwXEVHsGQ3p+KAqLTXKkvhLuBLHw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR08MB7421

On 4/22/26 20:56, Sean Christopherson wrote:
...
>> Patch properties:
>>
>>    - Hot path impact: one extra register compare in the common case,
>>      one extra MOV to CR2 under unlikely() when the guest modified CR2.
> 
> That's not unlikely.  The odds of guest CR2 matching host CR2 are basically zero.
> In practice, this likely adds two extra CR2 writes on the majority of entry/exit
> transitions.

Thank you very much for the review, Sean.

Agreed on the window: the patch only narrows the exposure, it doesn't close it.

I also mis-sold the cost. "One extra MOV to CR2 under unlikely()" is just wrong, how could i think of 
it, and thus it becomes expensive on a hot path, you are right.

With both points in hand, the patch doesn't carry its weight.
Dropping it.

--
Konstantin

