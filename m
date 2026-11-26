Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.201.56
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795685290;
	b=HUxnUMKLx8yROPvSdKlUC3Pw7ZtWsGZT4tynfIuvrXu0td2U5yVRsSRtB8f/PPACnReN
	 IXiOWGFbZ0yHIFE7b5iOqQxFlbcniowaKpPZdzoK9cm4sqijm00rJcXb861NEE+ERL3KK
	 sL3ayyxjt1/MnwSTiKxSGbMVJUGgkWoN5W3d4fpBrfqJopbMcLOD9BMiwuzO8zcG+1uFM
	 CUEI46Ceqq3++omIuTIwFVhpSMlAqJSLkfwQ28KfmpHZgbc72xt0xaITQmz/U4qupL4i+
	 5bPngh8lxWio8vxT/K/Ab089cV4tVPmBEtGDyqDM7L4GwIy7rgTljDyee4+d2uvOZTQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795685290;
	h=DMARC-Filter:DKIM-Signature:Received:Received:
	 X-MS-Exchange-Authentication-Results:Received-SPF:Received:Received:
	 Received:Received:Message-ID:Date:MIME-Version:User-Agent:Subject:To:
	 CC:References:Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-EOPAttributedMessage:
	 X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
	 X-MS-Office365-Filtering-Correlation-Id:X-MS-Exchange-SenderADCheck:
	 X-MS-Exchange-AntiSpam-Relay:X-Microsoft-Antispam:
	 X-Microsoft-Antispam-Message-Info:X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-Id:
	 X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=v1cMb3TS+ag4WuSmw2ebvlf9Gn+4AXj9dSVhjTXBiOg=;
	b=1p/yUxakhH1M5RmuLiH7l6mXglhWCGGbEMeKL/PXNv3cgP/JKKEImgl+EDITuUcqLiGd
	 pvcaTLIJIIGti5W7cVct2Jl9/dLPtNSIct+EsyOKvRb3wSOgpN7zLyBZXdTmUS7jS0/X8
	 FmdwKO01TTYzzHr60lAyETc6SfDAoy2Ol0OCdg8VOg3jz23Kupi+5wuKIe9SzwyDLLgzg
	 wptgUWlzXHKRYO7m0GV0gQsNvZr9UrqONvTRP+ZtP3gTTlDrjox7ZDEtI31PD6MG4/9+o
	 VR+WolOP/cRudcBqgOlW5t7H56BZS6QvLFYSX1bCTH5jY0Rv2YoEkf6wVV2u1GCGaVA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=amd.com;
	spf=fail smtp.mailfrom=amd.com;
	dkim=pass header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=oxlwK7S4;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.201.56
Received: from PH7PR06CU001.outbound.protection.outlook.com (mail-westus3azon11010056.outbound.protection.outlook.com [52.101.201.56])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DDB0606A333;
	Thu, 26 Nov 2026 09:28:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2DDB0606A333
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=oxlwK7S4
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=K8rrqCChTX05d5Z/PpJXmNIi3NNqax4Dsh4qxTQCIXiPhQjZ2kWb5PrxlEEh6KmqPyXlFmLd37VnVgESUjDJ0WYhua0xx3dyFRaOWPH7DyLqmwPyUdw8xPlySn+TcUImuRA7EGf3VAKCIJvpBoSt5A+J0CZFj6TgcicFkemlDg0eValR47644EmZR/k5P2+BunqlgLZK5/rts47i7OHNx3b3lWXw3WxzK/EZhnkVkyKzwCZYD84xFeNzqQM4BfZOqJDnzEc/SQARfYr1sqleZMtikO+csNvNPhfkddv0BYqVyYMe7SS5VT0poM80+WKR9zd+uHDC/fOGcLusmL10AQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=v1cMb3TS+ag4WuSmw2ebvlf9Gn+4AXj9dSVhjTXBiOg=;
 b=I61OIfvw0Ow+dT6+VwqKIS2JvgB2AryoakQpUWFlDXlV8FT+Y99XzG+6hJsHC4hUr6e/XfsGmUFGNRCPJ3zH9Ioo/UWC8ghtUjMQItpNRdb7OA4Nusos7CbIlQzysW+bwwMPrMhcQYF72QOos3eyWdBr1rMbBOdTXVzWFu7Wpq/t5of4Lin5EwrPHzuHF/IdiBtCPBikecMklESejZyMGLUHhTJCRt7ogd1fc0zicrc1+FDnI3wnYKx568W6mb2g76KDfvXaJ2j0t+/S37fMAIAmSYqO/2i1WyGb1+08ZkTXtOhvrNvlglJddWTz3m5LhaE57aHlqshAVU9+62HJLg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=alien8.de smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=v1cMb3TS+ag4WuSmw2ebvlf9Gn+4AXj9dSVhjTXBiOg=;
 b=oxlwK7S4KtihXKtYEnTPHhDHRWF9mnP//qQAiXMN+YDbm5M0IenkkaN9uIVBEPfMHBovVNviyNbaByRC2wzfBSa/xXrGtk6WN2DBWAZYMyrofb3Styu+LzUoRpx+apd++gg5j2ZEX3P9SrGt5YXi0PLtnxkn6/Uq0HDJ/MbRw04=
Received: from PH7P220CA0128.NAMP220.PROD.OUTLOOK.COM (2603:10b6:510:327::15)
 by DS5PPFB297DAF97.namprd12.prod.outlook.com (2603:10b6:f:fc00::65d) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.662.6; Thu, 26 Nov
 2026 09:28:04 +0000
Received: from PH1PEPF00062F2E.namprd03.prod.outlook.com
 (2603:10b6:510:327:cafe::7f) by PH7P220CA0128.outlook.office365.com
 (2603:10b6:510:327::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.662.7 via Frontend Transport; Thu, 26
 Nov 2026 09:28:04 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 PH1PEPF00062F2E.mail.protection.outlook.com (10.167.243.135) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.688.5 via Frontend Transport; Thu, 26 Nov 2026 09:28:03 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.57; Thu, 26 Nov
 2026 03:28:01 -0600
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.57; Thu, 26 Nov
 2026 03:28:01 -0600
Received: from [192.168.0.101] (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.57 via Frontend
 Transport; Thu, 26 Nov 2026 03:27:57 -0600
Message-ID: <e1b1d00b-b53a-4c6b-a746-72ed2058134a@amd.com>
Date: Thu, 26 Nov 2026 14:57:51 +0530
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] x86/sev: Skip DR7 write during kexec when it would
 trigger an unserviceable #VC
To: "Kalra, Ashish" <ashish.kalra@amd.com>, Borislav Petkov <bp@alien8.de>
CC: <tglx@kernel.org>, <mingo@redhat.com>, <dave.hansen@linux.intel.com>,
	<x86@kernel.org>, <hpa@zytor.com>, <thomas.lendacky@amd.com>,
	<Srikanth.Aithal@amd.com>, <kvm@vger.kernel.org>,
	<linux-coco@lists.linux.dev>, <linux-kernel@vger.kernel.org>
References: <20261116230335.1161521-1-Ashish.Kalra@amd.com>
 <20261123234341.GCawTPrczGd6iM_Uby@fat_crate.local>
 <47cb97d1-5919-4ee7-ad67-6039551304d6@amd.com>
 <20261125041925.GCawZhzVbU3ngXnt5c@fat_crate.local>
 <5acdbdc5-0c9e-4db8-a21c-fa011ba0bd57@amd.com>
Content-Language: en-US
From: "Nikunj A. Dadhania" <nikunj@amd.com>
In-Reply-To: <5acdbdc5-0c9e-4db8-a21c-fa011ba0bd57@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH1PEPF00062F2E:EE_|DS5PPFB297DAF97:EE_
X-MS-Office365-Filtering-Correlation-Id: 1c85ec3d-c1b4-4ec6-5000-08df4b9f9293
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|1800799024|376014|23010399003|82310400026|261102123227099003|10067099003|11063799006|4143699003|56012099006|261021121427099003|261026121527099003|261022105027099003|261022075727099003|261028144727099003|261021135927099003|261026140227099003|22082099003|18002099003|3023799007;
X-Microsoft-Antispam-Message-Info:
	P+eVfJOOnQ0MCvMPNePTbK/gWbfn91tViECFjxYVfteAui+6wcVPMaYibH9B+Ux284OgkwiC4E0teRpFzsSBE7lKjCBxu5W3y66TJfwSBcwHUBajw/Doilm8Rhm6PcdjYCnDZOwTvjiebtka8w6MicUu+7O4CafUjI2N+E+DpU6xBiNBhM3xKF9Ekmh/dTc6XdX9KNHeJwm08O4hagqpWCc0KUE2pxVlSrsJIuNhEUbLNuWZEaBKrd0OAq+YtX+K31HNeapGsBprvNSw3m1hNhNm+f0+jZwGFnn1n0M6tNjdrrg/Wtf0FX8Aj5GKof0EJtbqjMSfRoB1bfEUyL+/xg2D8dp6BbL9r8y7rSWrtQp0NHpt47cgk5sxX1rTVIx8944GqY7Ebuh15NdUSkE03WytXCI6YKyZs+iQfNrt5CRJiS2uwC4cUiK3Jwy58dW/XWFH8HY5/YSjOHZ/Z8HfOGbqV19f0W0cbDuBMs9pOF1JBsw8Lr5Ygu+gFvl0nRLmLu32UUBqsFHEvnHGDSzdkg0Exv1YWpy7jxofnQVo2hzBweoqEP78BSBe8e3Lu1p/2I5g1zH0A7CB+LIIAcn7JqPPTZK5nThUGYGu6IeAc+rVDIG11clccHiihESIt1jPxnXNfm9wJ5ImFuRjck06NF6fw1csL+GrFxfl2uicx2d5pOD0/0WvcEWmrsfy1SLsFWYvCs0DF7HkuvoCWVZgsg==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700016)(1800799024)(376014)(23010399003)(82310400026)(261102123227099003)(10067099003)(11063799006)(4143699003)(56012099006)(261021121427099003)(261026121527099003)(261022105027099003)(261022075727099003)(261028144727099003)(261021135927099003)(261026140227099003)(22082099003)(18002099003)(3023799007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	b1CNbIxy9UWnmzgMIwp5zrM0+nVG1kraxO/ASEWYBBlmRZQUQbfZAce/H/tXJvimR2f8sK7Bjxn7Z0rhMfPa4agpyayKz3ICAcASD5IyXzBCQfoS6N4ukcHaoVGBF0d1EiHACIfhbyo4PjEzQzWr/UZwFcDcYVO1vqfodjsdMpctBY4kB8xDziB9qn7bOosKpefUfnaCCtKcg7KklgWhBvW4jugkQ3TnL3BBtyUlncn3fG04pb8XQdYSmfzLA6LDMeZh/WocJDR52SiZZANOX1pwbrIVdu3mfwzv0K54LpugyS/5oG+imeZKf6du21qMWASj3al7e8u6XjK0wp6kuOak0hlUSyvb/Ea6bp1mv82B3sIOWCdSqj0zeEDu5aj/yn5tkU/iAm6yzF1JFXFVJNrDkAfceAUZfsT8w3K5Cx0BQQKBkauoGx3AccoPJeJN
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Nov 2026 09:28:03.9777
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1c85ec3d-c1b4-4ec6-5000-08df4b9f9293
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	PH1PEPF00062F2E.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS5PPFB297DAF97



On 11/26/2026 1:59 AM, Kalra, Ashish wrote:
> Hello Boris,
> 
> On 11/24/2026 10:19 PM, Borislav Petkov wrote:
>> On Mon, Nov 23, 2026 at 06:22:09PM -0600, Kalra, Ashish wrote:
>>> On the "bogus VMGEXIT": before Nikunj's change, __sev_get_ghcb() returned
>>> the per-CPU GHCB, which snp_kexec_finish() had already converted back to
>>> private. The host mapped that GPA, read ciphertext (exit code 0) and
>>> returned GHCB_ERR_MISSING_INPUT, but couldn't write the result into the
>>> private page, so the guest saw its own stale contents, treated the call as
>>> successful and moved on. The DR7 write was simply dropped. It worked by
>>> accident.
>>
>> Oh lovely.
>>
>>> As for using do_vc_no_ghcb(): the GHCB MSR protocol requests are meant for
>>> specific guest-initiated operations (protocol negotiation, GHCB
>>> registration, page state changes, termination, etc.). The only one that
>>> corresponds to an intercepted instruction is CPUID, which is why
>>> do_vc_no_ghcb() handles only the CPUID exit code and terminates the guest
>>> for anything else. There's no MSR-protocol equivalent of a DR7 write, so the
>>> no-GHCB #VC handler can't handle it.
>>
>> Well, can you fashion something with VMEXIT_DR7_WRITE and a dummy GHCB MSR request
>> to the HV which is innocuous, just so that it can satisfy the flow?
>>
> 
> We could issue a harmless MSR-protocol request and then skip the instruction, 
> but the request wouldn't carry anything about the DR7 write. The hypervisor 
> would end up in exactly the same state as if we just skipped it, so it would 
> be an extra exit that doesn't actually communicate anything.
>
> So how about doing it in the #VC handler: once the GHCBs have been torn down, 
> route the #VC to a GHCB-less path that decodes and skips DR7 accesses, completing 
> them locally, and the kexec then proceeds normally. 

Agreed on handling it in the #VC handler rather than in do_vc_no_ghcb(). 
If the DR7 skip lived there, it would have to decode the write and advance RIP 
itself, and the startup code doesn't link the x86 instruction decoder. The
runtime handler already has vc_decode_insn() and vc_finish_insn().

> This is safe: without DebugSwap, 
> KVM intercepts DR7 accesses and only tracks the value, it can't load it into the 
> encrypted VMSA, and the kexec'ed kernel writes DR7 again in cpu_init() anyway. Any 
> other #VC in that window, which can't be completed without the hypervisor, would 
> terminate the guest with a specific reason code instead of dereferencing a NULL 
> GHCB, so it gets caught explicitly rather than silently skipped.

Regards
Nikunj
