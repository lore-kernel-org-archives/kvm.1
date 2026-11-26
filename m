Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.52.40
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795675218;
	b=2Mrlo4APjzz4u9c7ibPp8Ke22NtlIEpj0BxzY5/KQ2QlWs7ZQs2KtJVxqq1DdQ9rtrj4
	 Lyf7wDgs4i7K3UvPfz0QViwnxd/H4+KitA/Tgk2YvkA6zS+ZTG7/wLUD8k+O8FOVtlgg5
	 mXtkSoSHu9Kwg62cnUnPfGDNY16CXo8iag247NWkl7oeGXM+lca0D7DDf3KtEML6RSDgQ
	 z9wgMYtdmefnwsj9XdZWj9+vBT3Uz8fnVPmGyC0aeceuyVPQed2p9GRApa2rgJnQgfNJg
	 CkkwkVc9WYqb/7eCR2/yOCf9A1h/J/JUFbALr6rD7cTzwqO/GR5tzkHdSMDRqHz57vQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795675218;
	h=DMARC-Filter:DKIM-Signature:Received:Received:
	 X-MS-Exchange-Authentication-Results:Received-SPF:Received:Received:
	 Received:Message-ID:Date:MIME-Version:User-Agent:Subject:To:CC:
	 References:Content-Language:From:In-Reply-To:Content-Type:
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
	bh=RyJoepLiFTYI0G9IT0RxRtFBUhJWoH1cdp1rGibRLcM=;
	b=M6iokL2WymtRPL7TiKlwX07AiJ6ArOSVB9Yw8GoIFrOncfWj8976j1DvCTdsPy8L8BJ1
	 ppAHiCH0emnuQmEZuEmCpedBKPEc9TmxvOmLIRntZe/KFbf4YeLFz+a3ah3564MlF6gyb
	 Z53zMq5JkHv+TgEgW8K20T3r9O9lqBgzx3ZlcuP/xAO72uJOV4pUYV7B/TrdpkCYnNGWz
	 Nx9seuhxkwNK0egOE355vyaVW2EP+iHocYAyeQvC197iADL8/ReRpAkfyGE1I7zTVLRGw
	 U8Q4dwpYNvDDpSLkhp76+Yq+EuwOErZgdLY/T13/mPGtes5DVyHnHh8VklDpu65RXvQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=amd.com;
	spf=fail smtp.mailfrom=amd.com;
	dkim=pass header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b="Y/PMb30n";
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.52.40
Received: from BL2PR02CU003.outbound.protection.outlook.com (mail-eastusazon11011040.outbound.protection.outlook.com [52.101.52.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 973B4606A31C
	for <kvm@vger.kernel.org>; Thu, 26 Nov 2026 06:40:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 973B4606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=Y/PMb30n
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nZLcVkaZsG7Py6pODf63qCfag1V81IrUCw3dNIuGZ2EAQGRH/veNokC85BGhWg9i1o1CsNoR10wv0ye/Sun7xtvwZMRncOWdLlWiAZR6HTndzhoCLH+OccZm1B3bBhZ3WqRCQkAsz/coP8pj9xajyYaMMLvQgmgt4xBOXL3YOYP+4GhbG/iozg59uF+1Z31QcGjdZREoxvkmyubqwXvSVrdykFI6ToJM10aX9NjXAzfHdALnb6y/rkIYMLMOjr1+Q6q9exoY43WshMBNmUVab0Db6vlGB+/w1yVRi1+0muSdHD0YKo25L1ILzQoZ7qLqT1m/g+xyWa0gxwTz3l25TA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RyJoepLiFTYI0G9IT0RxRtFBUhJWoH1cdp1rGibRLcM=;
 b=i2DrqdB++VwJNqrFgTG51cZ/C1n2S2J1yR0NAaWj4Pa8sRCpTIA1rK6t8VxH1sEGY1uRp40LJ7ySUX/o6hhhRvFbGTcWmLcPCEyB2reguqGSjgANbDq/Y67AURVbGzzsB1nxqRPW5sW2ITqwrYGmXbHO1vbRoutYji9MBElFM++o0We+wB/3nNNbdGr5K1vHTG6ItLUH5tn5C0Aps1LTP9W22KMG6zxEBDLQG0M0knWOtv2PNj/0EQ3z+zRdxTvb/U+pr8p3EKh5vtmWNyP08PTJvq2gpJ9Y9NcPdJtPlwFKyHpJUYC7FVtasBBZGl01wXRwmsQr2zmlhNcK3F0OJg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=google.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RyJoepLiFTYI0G9IT0RxRtFBUhJWoH1cdp1rGibRLcM=;
 b=Y/PMb30nS0dBH7o/SMDLmaDinADktW+4QaOhEihN61vDRuqPPDaSPMMBUgUCUfa6qIOny9R08o4uRIjE9leFoZSTGjuiNxCzPObgfgwgoiSepfVITlh/VlI5LmBv5wn9aWhwMPXGWI0XlgwyJw7O3IG41J9XqCt5lcEuGf+bqsw=
Received: from SJ0PR05CA0163.namprd05.prod.outlook.com (2603:10b6:a03:339::18)
 by PH9PR12MB498472.namprd12.prod.outlook.com (2603:10b6:510:42c::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.662.7; Thu, 26 Nov
 2026 06:38:06 +0000
Received: from SJ1PEPF0000231C.namprd03.prod.outlook.com
 (2603:10b6:a03:339:cafe::9f) by SJ0PR05CA0163.outlook.office365.com
 (2603:10b6:a03:339::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.662.6 via Frontend Transport; Thu, 26
 Nov 2026 06:38:06 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ1PEPF0000231C.mail.protection.outlook.com (10.167.242.233) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.662.3 via Frontend Transport; Thu, 26 Nov 2026 06:38:06 +0000
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.57; Thu, 26 Nov
 2026 00:38:05 -0600
Received: from [10.85.42.177] (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.57 via Frontend
 Transport; Thu, 26 Nov 2026 00:38:01 -0600
Message-ID: <9f4125e7-887f-47a5-afbe-4e56273e7212@amd.com>
Date: Thu, 26 Nov 2026 12:07:55 +0530
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
Subject: Re: [PATCH v2 10/12] KVM: nSVM: Pass through LBRv2 MSRs to L2
To: Jim Mattson <jmattson@google.com>
CC: <seanjc@google.com>, <pbonzini@redhat.com>, <tglx@linutronix.de>,
	<mingo@redhat.com>, <peterz@infradead.org>, <acme@kernel.org>,
	<kvm@vger.kernel.org>, <x86@kernel.org>, <yosry@kernel.org>,
	<thomas.lendacky@amd.com>, <nikunj.dadhania@amd.com>, <sandipan.das@amd.com>,
	Shivansh Dhiman <shivansh.dhiman@amd.com>
References: <20261019210532.378628-1-shivansh.dhiman@amd.com>
 <20261019210532.378628-11-shivansh.dhiman@amd.com>
 <CALMp9eRVB4gYMgjmTj4Hh4fo6VY+6_SWHrRYXcA1QLrtCkf-eg@mail.gmail.com>
Content-Language: en-US
From: Shivansh Dhiman <shivansh.dhiman@amd.com>
In-Reply-To: <CALMp9eRVB4gYMgjmTj4Hh4fo6VY+6_SWHrRYXcA1QLrtCkf-eg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF0000231C:EE_|PH9PR12MB498472:EE_
X-MS-Office365-Filtering-Correlation-Id: 058c1788-7b0d-41e2-f3be-08df4b87d45d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|7416014|376014|36860700016|1800799024|23010399003|4143699003|261009223027099003|22082099003|18002099003|10067099003|11063799006|56012099006|261102123227099003|261026121527099003|261021123027099003|261021121427099003;
X-Microsoft-Antispam-Message-Info:
	nCMOO1RP10y+eEs3cfD33MHGVeQemgpJUwjjAZj6MFGNFfo7XTMxlhVDHYZnlZuVj1YDsFfwqq4QbV4gpgvBXx1wstCWDZp2hI6y30ncPCD8IrxTBdxycmmt4szJUSVBzFBfy0D7jlmewA0Gnt/Smjp1E8aw7V7mGphDpt+g95jPGs3vRQ5fxLTCR0nHKLyEEZACtzOd3ZW/lNEZMJRLKQEKnaeuquzYQuCaXDGNl8lzvBEST+5IIQIyhbE9VM8K1QvQIE29KcffcrI3TbGV7kk2XJw5qL6zhiwNJYAXUouAZbqiwWWh/hUiU1RQejGYKvddAoicxowm8vOQz5BY2OQM+u36/7arXPgpGz1pQae5A21w119Iz4YczcylLgxI/wajt81mtwPDCES/55esMMtwvSO/iYaLT7PHNEkmxbiyxJVv9iLvnKs0wwF8hOiXWjxXTqbU6kKln8fIH0WgnZhybQRfjjX24J8gcAYv03+KPF52/TCTYPdngfJZFJZX3KCA+oy86QHfnVeRbTKjNMJ+dPYissWJH0BAP7eUzYl19bf0vnBk/sRjJdoiFyxevexz+k9deJtLknugcL9SDVXGHEbCYQbI4aTGNHf9qpew189s1t3AwTOw2XkGVILszJlGuxt5fBU8tjV5qTYV3FW5y3wgCoJ+cF4QRhf9MKiRy90Vpmw32aeKrzTHhDFF
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(7416014)(376014)(36860700016)(1800799024)(23010399003)(4143699003)(261009223027099003)(22082099003)(18002099003)(10067099003)(11063799006)(56012099006)(261102123227099003)(261026121527099003)(261021123027099003)(261021121427099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	QogkZ8lIqKq8qDZX4vxR5GbaXJkeMXSkAZeN7iBozL9TK0hF/wskUrMby+2ph68mK0uUwInE5RWGVFoJbupqorm3XM9KgUeE9v613bu4dkfIScpLiEYQVJYdvJ8XqWAjkpCktBuiAxBRNWbS4z1cpVEaheVdTr0xy70mLSP6hO01cJl1OAO8vM63Da18gPxe0YnJV88fqZUtDZYQQZ3rNHlS07flTR/wzTGWUsPF6a5sBL/3Y98L+u/hVulvYXmXD9q/5K3Ew/un16+KNy9zvpCmD3dG8JVFy4x7Gx9vOiR2BGGwIkHoIVd52GaqX/jgpVij1WoIE8e/MaxAj9jweyl8YdaEsdM+iOEiHQJdK19AFGb32VVam1Tc8KfX6SKAZcb130GDUSdkd5oXVIzPFSm8ehggHsejv4LclbFt1deEZC1Ef3sTD3suIC6wMIcq
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Nov 2026 06:38:06.4226
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 058c1788-7b0d-41e2-f3be-08df4b87d45d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF0000231C.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH9PR12MB498472


On 20-11-26 04:00, Jim Mattson wrote:
> On Mon, Oct 19, 2026 at 2:08 PM Shivansh Dhiman <shivansh.dhiman@amd.com> wrote:
>>
>> Add the LBRv2 MSRs to merge_msrs[] so that their MSRPM bits are merged
>> into msrpm02, letting L2 access them without taking a VM-Exit. Grow the
>> merge offsets array to 12, as needed by 32-bit kernels where each offset
>> covers 16 MSRs rather than 32.
>>
>> Signed-off-by: Shivansh Dhiman <shivansh.dhiman@amd.com>
>> ---
>>
>> Changes in v2:
>> * New patch.
>>
>> ---
>>  arch/x86/kvm/svm/nested.c | 23 ++++++++++++++++++++++-
>>  1 file changed, 22 insertions(+), 1 deletion(-)
>>
>> diff --git a/arch/x86/kvm/svm/nested.c b/arch/x86/kvm/svm/nested.c
>> index b356a091e320..84154f353935 100644
>> --- a/arch/x86/kvm/svm/nested.c
>> +++ b/arch/x86/kvm/svm/nested.c
>> @@ -209,7 +209,7 @@ void nested_vmcb02_recalc_intercepts(struct vcpu_svm *svm)
>>   * Hardcode the capacity of the array based on the maximum number of _offsets_.
>>   * MSRs are batched together, so there are fewer offsets than MSRs.
>>   */
>> -static int nested_svm_msrpm_merge_offsets[10] __ro_after_init;
>> +static int nested_svm_msrpm_merge_offsets[12] __ro_after_init;
>>  static int nested_svm_nr_msrpm_merge_offsets __ro_after_init;
>>  typedef unsigned long nsvm_msrpm_merge_t;
>>
>> @@ -253,6 +253,27 @@ int __init nested_svm_init_msrpm_merge_offsets(void)
>>                 MSR_AMD64_PERF_CNTR_GLOBAL_STATUS,
>>                 MSR_AMD64_PERF_CNTR_GLOBAL_STATUS_CLR,
>>                 MSR_AMD64_PERF_CNTR_GLOBAL_STATUS_SET,
>> +
>> +               MSR_AMD_DBG_EXTN_CFG,
>> +               MSR_AMD64_LBR_SELECT,
> 
> Why add MSR_AMD_DBG_EXTN_CFG here? L0 only disables interception of
> MSR_AMD_DBG_EXTN_CFG for SEV-ES guests, which don't support nested
> SVM.

You are right, thanks. The entry has no effect, because L0 always
intercepts DBG_EXTN_CFG for guests that can run nested.

-Shivansh

