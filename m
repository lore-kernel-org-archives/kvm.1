Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.193.54
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795009099;
	b=RqFT03wKKJuu+ffxtj6sAw+7LcyI3R7v9PnVvQn85FkJIAO6BpX80uah6yddQDHunvCB
	 cN36AQwHJ24R9ZpqSzzbbQYxuIovK4PfCaFvwEpQB9sI9oBbf/UqZNmVzzZTfbyvrzqKY
	 BgI3ssrU5kLGBJtxEvVeeB5ASdv9BC/uBE/Ecd52p+/v/K2cU5GmE4m9WEK5bAoeis40S
	 VMGLFLZyJBdS2Awwf8646/7lQflb8rdOrFGJ6xUDe/pyBrXNS30YLJ0/o9IMoGAev/5+6
	 gJvI9ZDwVeOD1WZjjJ3OYY6F5TezBrW8oUiyRlqRWTpoVnjqtHe7m6+R6IUlQmXP7jw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795009099;
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
	bh=MZtEcaIppMDBd1cZitd6PMcUKFXc9RAnfMO93CkMjgM=;
	b=cOSfVXdtcei6nQA9NBG4CEzrUNgyb7NKvDGmH9iCjmXvtXcO8FTb+RZo0ZeVb1bFL1Aa
	 mg2R5II61oByQDBaQI9Q1zcwdSjhTzvOqw16lUZ+DV1V7EDbWMd9TPqriZ6HeA7agpq/+
	 dO0f0aaFLfIOufwQLX1N2glF1dMezd2dHfFNGZW2rxbirMoAmneKDOhl8MMeJ9LyOMAzk
	 ht2JRf3rsN871OI4wgDDQYViAbmtATI3CDPHvpWiHLWbkrqwZRDbs5Wc50eWRWWwSMM/7
	 UdcXY03EO++8uMbE0zgwEkcu5xnnTy5ai4DYEhwA/WZDrPTrPpOBeFObYtNxnZu3CZw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=amd.com;
	spf=fail smtp.mailfrom=amd.com;
	dkim=pass header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=CiA5pA7f;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.193.54
Received: from CH1PR05CU001.outbound.protection.outlook.com (mail-northcentralusazon11010054.outbound.protection.outlook.com [52.101.193.54])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A66C606A325
	for <kvm@vger.kernel.org>; Wed, 18 Nov 2026 13:38:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8A66C606A325
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=CiA5pA7f
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=w7IpjtTVgGYWlFyu5WXSBMZLVItBi4gn+PHTO2NyD4dgeZFmYwM2HwRWZnOLgLj3vpKy9oAsGNd75O6tW8vpL8FKKYFXFgcSNtZbUJhYc1R3S8y0q5V4ZJ/4dLGLNqPPy96s1mrmHP9HD+GCGeQhDKs+f72Ork2OGXzioNrR1ujA45mUed9xh+ZiYnJk60m8RwdMDi6LABHS2R0T5jd3Q4TXXAyuz3qu9aL799IquvQTCBKZ5m417+9WHOfblOLrtCpV13jqMrttWye7y2ZtvaYZQ2jO25Ub7IyewjWXADUDOJIj4q00iJeFK8+x4OuPKGw8d0Goliy1NnzvzEbE6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MZtEcaIppMDBd1cZitd6PMcUKFXc9RAnfMO93CkMjgM=;
 b=MZRtoolD6/EXAZ6cjii2vcES/24zH3XtkKCEwg0CcyGttwzbXANdjQEQxQpKQrUGwLE7M1MSpPlYQ6KRarbki9SjGc6aYYKJdY1MM/YNGC/5/7A641h7hlOk3vhqgaIHjkY1qe92PBz6UeXSFeAoUqjnBJ6PTmljC2jqAdcY9af8tMf+95P1H3B0YceQ7VDVPm14DdVb1XBBKUvnG2XV3jTGXIC2Apf+/hBbUWAYH/QZTv/COmhfeB4hG0Env1pZ08WUZCzGPE+kkhXHyimGKKHJ34uaWTZJsfn2Cm2BsUE3BQFUeWun3JXtebjFXyffrwPFxwyu/LI4gUQ/+a/XzQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=google.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MZtEcaIppMDBd1cZitd6PMcUKFXc9RAnfMO93CkMjgM=;
 b=CiA5pA7fM9eRxqhsNASsXqbWiDqq8fU3f+j7gIJDdSK6BNKMpQeNcrqGDJ53VS5hIp2ZgfkT1o6SNyC0xdaFe5Sd3ZuANmJaXU//K4vXppxJEyoKh+6zy4/WLBOu6FpWQpIR33qe6yhYEzDGJsBycaj3Lz8mH2QfE4vdo/UJEdY=
Received: from BN1PR13CA0030.namprd13.prod.outlook.com (2603:10b6:408:e2::35)
 by CH3PR12MB8076.namprd12.prod.outlook.com (2603:10b6:610:127::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.14; Wed, 18 Nov
 2026 13:38:13 +0000
Received: from BL2PEPF000352CE.namprd02.prod.outlook.com
 (2603:10b6:408:e2:cafe::f) by BN1PR13CA0030.outlook.office365.com
 (2603:10b6:408:e2::35) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.639.8 via Frontend Transport; Wed, 18
 Nov 2026 13:38:13 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL2PEPF000352CE.mail.protection.outlook.com (10.167.249.136) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.615.4 via Frontend Transport; Wed, 18 Nov 2026 13:38:13 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.57; Wed, 18 Nov
 2026 07:38:12 -0600
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.57; Wed, 18 Nov
 2026 07:38:12 -0600
Received: from [192.168.1.98] (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.57 via Frontend
 Transport; Wed, 18 Nov 2026 07:38:08 -0600
Message-ID: <0cec5ebd-fb95-408c-8e21-dab3389ca083@amd.com>
Date: Wed, 18 Nov 2026 19:08:06 +0530
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
Subject: Re: [PATCH v3 8/9] perf/x86/amd: Remove exclude_guest check from
 perf_ibs_init()
To: Jim Mattson <jmattson@google.com>
CC: <seanjc@google.com>, <pbonzini@redhat.com>, <mingo@redhat.com>,
	<bp@alien8.de>, <kvm@vger.kernel.org>, <x86@kernel.org>,
	<santosh.shukla@amd.com>, <nikunj.dadhania@amd.com>, <Naveen.Rao@amd.com>,
	<dapeng1.mi@linux.intel.com>, <ravi.bangoria@amd.com>,
	<peterz@infradead.org>, Yosry Ahmed <yosry@kernel.org>,
	<manali.shukla@amd.com>
References: <20260310060022.15120-1-manali.shukla@amd.com>
 <20260310060022.15120-9-manali.shukla@amd.com>
 <20261008193818.839995-1-jmattson@google.com>
Content-Language: en-US
From: Manali Shukla <manali.shukla@amd.com>
In-Reply-To: <20261008193818.839995-1-jmattson@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL2PEPF000352CE:EE_|CH3PR12MB8076:EE_
X-MS-Office365-Filtering-Correlation-Id: 378a7107-0496-4ac6-38ac-08df45793167
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|1800799024|376014|36860700016|23010399003|82310400026|56012099006|261022105027099003|261021121427099003|4143699003|5023799004|11063799006|10067099003|261026140227099003|261026121527099003|261022075727099003|261028144727099003|261102123227099003|261021123027099003|261009223027099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	Jju3zAsx9DFI606TJCwr77Ryryj777ppKCSA8qyCMwn2sYkr0BoOcAGc39kZOGi9VIAkTy5wcm288o5LtKHcWsxBbR93NDt0PFwFVzovVJv7UcEKln7Oa+emCX3t2+ezjkJAAY2SutzBiPuKwQ5LcSlpLaBJDdZI/rvnaj8wm8eZ8us8jg+kbfkobTiQy+9uR0XAdBO1f+4s02cDZ1hLeB66rQIJSPZSPMyZk4SjaXUscEFT39bx9aVQJ0lM850KQb7WjzdU4WiE4D9Qm+9kegU5wCZvm6pLmCLWw7GnJmTwysOxKKjcz2J++4WM6GaV0PgQuvpmzbCh2mJ3BUyCepeW7Kvk2SH/muc6a82IOw8PfXKyEgynHtd/m8UNFxxFVlMxC3DECLYrste0BbtVCfjffE+M/wR2WpiZ+P4Skgp9IEGawCpwlfnt5rUAZpYPvQoUM1nRx6XGUBZ/rhGCjgNn9C79T4gLfPbBDrMu4KMjCMeV1SN39So6db4Ee5WQP3WYJXfZBMHo9kSawPR/QzDrWdwTgzBI6LQdifyObA2eSp8qKFXo3TMzfcgPJjI6CnAHWpLVtYKVs4VF8hZlYMXFoXDK5E2s9iMG19DlMyo9qgS9AuVvYc8E1YFgeauAiNv0G8y4STY4PnQ73YepFrzRAcMdH820UBnRkwSH//kroIF94SrO+Aj6i2eqMKaYceJ3NkEps98JJjcduHCGsw==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(7416014)(1800799024)(376014)(36860700016)(23010399003)(82310400026)(56012099006)(261022105027099003)(261021121427099003)(4143699003)(5023799004)(11063799006)(10067099003)(261026140227099003)(261026121527099003)(261022075727099003)(261028144727099003)(261102123227099003)(261021123027099003)(261009223027099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	xH9pbhZQPdXUi5NaGPwJJ93EmSeMm4LVkPuaQlDLNmE4XyHE6HgUia5Rq4lAQA3sfgi6lFDKOsX2TGJ60qWR5PrEiwfKdvzTqMSqqTBIytjrFcA1jXWHQ5GBI1KeBCvCk2SVUnIgJLNaePeeXluzeQdoZUO/YDh15o/FiKcoOsPUT/ZDUqQ0Xu9pPD8v3fyzJ6vEmTYwx3baX57MYB/lRvGX/Tkb2LxBiOdCd2vALbvKWl0PrVUhvHLdNAPLT4Dhpf05aXQBhWpeK3LQ5zz4D8GVVN/+lqa19MBofkeVSj6df9KEkjbMFXSdN5uNrBZU5O0R1nis5/A4BfNRodWEJYoOOwsFwYMvxSkzUhLX2g3VUU+8231AFMb/MtEfw0ejsHChmKChS0mqkuMpM6aO3W1B4GxvDQxR7Tih0m0lVsIO9FrCbIi53Ew9q07COSXN
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Nov 2026 13:38:13.1676
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 378a7107-0496-4ac6-38ac-08df45793167
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL2PEPF000352CE.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8076

On 10/9/2026 1:08 AM, Jim Mattson wrote:
> On Tue, Mar 10, 2026 at 06:00:20AM +0000, Manali Shukla wrote:
>> Currently IBS driver doesn't allow the creation of IBS event with
>> exclude_guest set. As a result, amd_ibs_init() returns -EINVAL if
>> IBS event is created with exclude_guest set.
> 
> s/amd_ibs_init()/perf_ibs_init()/

Ack.

> 
>> With the introduction of mediated PMU support, software-based handling
>> of exclude_guest is permitted for PMUs that have the
>> PERF_PMU_CAP_MEDIATED_VPMU capability.
> 
> This software-based handling applies only while a vCPU with a mediated
> PMU is loaded (perf_load_guest_context() through perf_put_guest_context()).
> The core PMU also sets AMD64_EVENTSEL_HOSTONLY for exclude_guest events,
> so the hardware excludes guest execution in all other cases. IBS has no
> equivalent, and nothing in the IBS driver or in KVM stops an IBS event
> while a guest without a mediated PMU runs (for example, when
> kvm_amd.enable_mediated_pmu=0, or when the VM is created with
> KVM_PMU_CAP_DISABLE). After this patch, perf_ibs_init() accepts
> exclude_guest=1 in those cases, but the event does not exclude the guest.
> This seems like a problem.

I agree this is a problem. Previously exclude_guest was never supported,
so events with exclude_guest set were simply rejected.

But with mediated PMU, we can not keep rejecting them. Once IBS PMU has
PERF_PMU_CAP_MEDIATED_VPMU, a mediated PMU enabled VM can only be
created when all host events are exclude_guest, so rejecting
exclude_guest event would mean host IBS and mediated PMU enabled VMs
could never run together.

How about implementing exclude_guest in software for the guest that
doesn't support mediated PMU? KVM would disable host IBS before entering
the guest and re-enable it after exit using perf_guest_get_msrs().
Something like below:


In the perf_guest_get_msrs(), for each active exclude_guest event:

 		if (ibs_caps & IBS_CAPS_DIS) {
                        rdmsrq(perf_ibs->msr2, ctl2);
                        arr[nr].msr   = perf_ibs->msr2;
                        arr[nr].host  = ctl2;
                        arr[nr].guest = ctl2 | perf_ibs->disable_mask;
                } else {
                        rdmsrq(perf_ibs->msr, ctl);
                        arr[nr].msr   = perf_ibs->msr;
                        arr[nr].host  = ctl;
                        arr[nr].guest = ctl & ~perf_ibs->enable_mask;
                }
and in svm_vcpu_run():

        msrs = perf_guest_get_msrs(&nr, NULL);
        for (i = 0; i < nr; i++)
                wrmsrq(msrs[i].msr, msrs[i].guest);

        svm_vcpu_enter_exit(vcpu, enter_flags);

        for (i = 0; i < nr; i++)
                wrmsrq(msrs[i].msr, msrs[i].host);

Please let me know your thoughts.

> 
>> Since ibs_op and ibs_fetch pmus has PERF_PMU_CAP_MEDIATED_VPMU
>> capability set, update perf_ibs_init() to remove exclude_guest check.
> 
> s/pmus has/PMUs have/

Ack.

> 
> As I said on patch 7/9, please squash this patch with patch 7/9.
> 

Ack.

>> Signed-off-by: Manali Shukla <manali.shukla@amd.com>
>> ---
>>  arch/x86/events/amd/ibs.c | 3 +--
>>  1 file changed, 1 insertion(+), 2 deletions(-)
>>
>> diff --git a/arch/x86/events/amd/ibs.c b/arch/x86/events/amd/ibs.c
>> index e075c5ed136c..47f4dc0b6341 100644
>> --- a/arch/x86/events/amd/ibs.c
>> +++ b/arch/x86/events/amd/ibs.c
>> @@ -327,8 +327,7 @@ static int perf_ibs_init(struct perf_event *event)
>>  		return -EOPNOTSUPP;
>>
>>  	/* handle exclude_{user,kernel} in the IRQ handler */
>> -	if (event->attr.exclude_host || event->attr.exclude_guest ||
>> -	    event->attr.exclude_idle)
>> +	if (event->attr.exclude_host || event->attr.exclude_idle)
>>  		return -EINVAL;
>>
>>  	ret = validate_group(event);

