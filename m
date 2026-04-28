Received: from CO1PR03CU002.outbound.protection.outlook.com (mail-westus2azon11010020.outbound.protection.outlook.com [52.101.46.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D308B477E3B;
	Tue, 28 Apr 2026 18:19:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.46.20
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777400382; cv=fail; b=BctDogn+w7mYtk5bU+06gSHySAFwY7XcafVe+u5bKwaqk6AvTA2xV0aIcHNAiTm+QA5bnm6TzB50OqJFT8THyOTeeXKAOfd3tC7y4kzkEilgvywZPx+7xKeKLyoLz4DxWGU8bqmtY9jzdLlS6ERj81lXQWtfkNNnS23qzFusNfA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777400382; c=relaxed/simple;
	bh=O0N9KVYIk7L8BqMXidTh5VNPuj9wVkC3l49CndlgVgk=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=J2HJBf+auv+CF30JIQ2dj9lDdFy2FvjB42QbpC3WI00iUTIRmvnTG0bS9hY0hD7AQY6ljqE7zZ27mHbsKTsGxG+diTeWlLVEBzhhRFTfyE6afIWF40dgLQoM7dpcOnvVgqBxFipPO8OwshzOZ1Gc49hIuypKhG1iJkqcuhJT3Ds=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=iqmqiL8e; arc=fail smtp.client-ip=52.101.46.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="iqmqiL8e"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qcE7k8Rbz66pfrDNkWJGxyfyzQFm0Xab1+rQcGC183OERP/cZvqqdedn5tqYBjwt1a8LMYWkyB088YiFWdiM+c9UBEb94qodVaJF49IkOFXioCnuMMZPhTFhuhGE+71jZ90ChYU9CWdknG3HET9o3L7ELrEv5yf2/Hy75Q4PVcB4d0E2iUgfq2Y0cez3uH3du5DEl5BkcyO+fsZrR/+n8QR9gw+47LT80/7xRr3mfYqsEZ0RtOwyCpu9IzEarLpL99TQdQ3yXDOYjhq9w8tAw9NRa3zB2xatcNLELfJx9wp790TB2v63DzaTjUCMbfaTn9yjeP7QoeHuvNqBx3dSOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=U6V36Bbx7AsqJsUkuBtZ6xFSNnei/jdgKtIr6Z7CboA=;
 b=xOCybSrn1TLoxxQWxcjEeM9sZAfWiTTtZ8l253ViFao3XcjF2p7cUCkC0j7UVSoDVdjpnu74rpBA0pJkWYQ1xWVlmco4ofwefLXXS+ldse4AlGHUFN84Vg6Tqmu4k1u2kesbLuk/dZQGqwsiqQirPAQflauyXCzy10r2IHsjH/LZtSP5GktupjeTuQSfetobHFOfNjPGcLeHvDJB6SKWpbJJZQ7W9F+g6UoyCFgE4eS8r+LDustYn1HQIpptIg+anWzVyA3LqVljNZc7FZKCkrWGtmPbpVBIMKapKcW/kK2mIqIP4Iw2iBBG0UfeE9btdk5Bq16IdB0EPcKejfSGUg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=U6V36Bbx7AsqJsUkuBtZ6xFSNnei/jdgKtIr6Z7CboA=;
 b=iqmqiL8eyMkrflCCjh87KWeosqyl6Hxup7Zl4U1nrUWqPGPNojHuotZmKOaLGbfggonZG0GlLcFLRMbO0RVOd+KhRklNGC4x1cCe9eNbMS8gYPtbK34mt0/tLqLaWFlQ6CrZ4kUxVu9NeEIC0BS5q1vdBy+PH0K83yeiDVyqsWw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB8106.namprd12.prod.outlook.com (2603:10b6:510:2ba::9)
 by PH7PR12MB5620.namprd12.prod.outlook.com (2603:10b6:510:137::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.17; Tue, 28 Apr
 2026 18:19:38 +0000
Received: from PH7PR12MB8106.namprd12.prod.outlook.com
 ([fe80::95d6:81b:325d:1923]) by PH7PR12MB8106.namprd12.prod.outlook.com
 ([fe80::95d6:81b:325d:1923%5]) with mapi id 15.20.9870.016; Tue, 28 Apr 2026
 18:19:36 +0000
Message-ID: <86c6c75b-45f6-4f38-8b3b-9afaa2f1854b@amd.com>
Date: Tue, 28 Apr 2026 11:19:35 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 5/7] KVM: SVM: Inject MCEs when Restricted Injection is
 active
To: Joerg Rodel <joro@8bytes.org>
Cc: Sean Christopherson <seanjc@google.com>,
 Paolo Bonzini <pbonzini@redhat.com>, linux-kernel@vger.kernel.org,
 x86@kernel.org, Tom Lendacky <thomas.lendacky@amd.com>, kvm@vger.kernel.org
References: <cover.1777048608.git.huibo.wang@amd.com>
 <51f8c478c5fc09b3bdeb8329c682a01fbe0ea5db.1777048608.git.huibo.wang@amd.com>
 <u4vvzt56ldo2dfhrdo3nwzw46ktqtngob6ng2qbgypqeyxcbmn@akgecfbqkloy>
Content-Language: en-US
From: Melody Wang <huibo.wang@amd.com>
In-Reply-To: <u4vvzt56ldo2dfhrdo3nwzw46ktqtngob6ng2qbgypqeyxcbmn@akgecfbqkloy>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR05CA0002.namprd05.prod.outlook.com
 (2603:10b6:a03:c0::15) To PH7PR12MB8106.namprd12.prod.outlook.com
 (2603:10b6:510:2ba::9)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB8106:EE_|PH7PR12MB5620:EE_
X-MS-Office365-Filtering-Correlation-Id: 72414cc4-dc81-4705-651b-08dea552b464
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|22082099003|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	T9VMQHUzP37j1gL423XEEyF7DG6LE5EOxsqfXDMa6WLuVKDJ2Kh+sWY8SThILPTYmZFnxfFFc6OG8lkBCyocW1Czr4eshipBeKfNwnfht9wx9K2fDzaPqyMkuwJQsa3KFKm4dTutVBlBT+CQsY3gNP4yLN+/9oknUbVM5TUbYhAm6etdkvCyWbZG5XhlDh3NBzdyVL0+S7BwvvpzJl9KkSg1VOp/CSuXvnPm99vchR2KQYw76zkRCq/EWkb/IoeFiDrhZJJdSO5lV+7Uy6y/JXb0ZwLxbzIvYbhb6WAf7NviQbbF7t2+ab54513gw6p00eETqE2k1OnN3Wc2fznNly1H5g7/SXK/cq7bUw6Z/6C97dku5iwUONGG/peaFXAvePAc0BNx3kBXpIdujX9ByzJANW5e0xiAekb0T2CxFPgUmTH5hfDXvx0NpwPFM2qKt4eU/e1gOorwHYQUUilvt1E8WQK7aUxbbChC+pffKKZMGmlH04X2xLc25QJqPHZVlP/4r/Zy3QPp0TPhT1zHsetsy3RK9aqH5iYsz8EeOHMrEwMtS9F0jm1arBtNEN7orjQ7CQpicAms2JbnCqXZm/Nt3m1yFmR3aWuBgcxzqG63rI5PLBSuT+oe0C7Z7Rx/IpGMzVJSpj+8bMe9Al8BRzlKiJghJpVS42NSdBcG0W7HIV9l2holcGBuO+uLB3NVQnTQXuwRtebMv9AK35dq0gP3GQnEqDpqJUtwHCe/vWc=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR12MB8106.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(22082099003)(18002099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?dDdJTGUwMlpIRWhzcCthM3orYjE2aFd2QUtqZVp2QlkwOVprWVlpand4QUdI?=
 =?utf-8?B?aUJzd1RFcGVYVkpjNEJyOWJjNFNVbHJUejZ5TDltZ1pWTXVtS0JFS3pYQ3pM?=
 =?utf-8?B?ZHBSZzkwUmdPdE50VkpTaEpoOGI5YXk1a3g2TWYzNEtIblRDcGR4YVlZNWNv?=
 =?utf-8?B?Z0pwVE9DbWtuWmVCK0ZXa2k3bkY3YVNNVk1MZlpjMkRBVG1KWlNOdURjbHcx?=
 =?utf-8?B?cTBWRk1rNktRdmhBUVIxS3NMZ21Vbkd2a1ljTjhzUUFvUStQaitXclQzYUFD?=
 =?utf-8?B?U29JWmM2cVYydVlYREh6aHBPUjNTRG1MTlMxc1k1eCtlU2lSUSt4MTUvWWlU?=
 =?utf-8?B?SEZ4SDNIdElQcVcvdjZoeG9uVG05bjRrT1Vxd0x3cXpQcXJEMWdGSlpGaDBh?=
 =?utf-8?B?dFkwdkJoRTRkcFVxOXplZEFCdm5KZ1F4NUc5d2ZiNWNFaTlNajF5S2krUUhP?=
 =?utf-8?B?SnFJdG9IMm5NNmNObjlFdXg0ZDMxMTAwR3drNEhiZ1lreWdMdnlQTTlXUVBC?=
 =?utf-8?B?dHg5cDc3SEM5SjBHbFZ1TDdraHFRSzM4d3NhRmFDTm42VWVmUEZ0cnhBdTdi?=
 =?utf-8?B?cVVlSWhkcHlVL3FLb1o1UmcyaU8wbVRXOFE0ckIyd2gxbC9UUHpsclZuaUUw?=
 =?utf-8?B?aTZNL29IaHlFdFNpa2ZHQ0ZQL1hlam8wd1dvcDc4OGVBT3lUTjFwWGZVc3o4?=
 =?utf-8?B?THhINGZsTVdZNGxOcDAxRWJFbU9DK3BDVmNoYmU3Z3FQU3Z3MFhHVlJNU2dU?=
 =?utf-8?B?eDI1c2VTTWF0cFNFQm5GUmRHNGxRTVJKOFA1US9iaDQxMFlOSFdya1BWTFdP?=
 =?utf-8?B?RzlFYSttb1lDZGN3ckVGaHA2MHM5aGVqMERCTDh6TFhyS1R6VzhsQWU0YjhB?=
 =?utf-8?B?OXQwMnpWakxwZnpYMzlEUStMeDg5NzdCeWNpM21WdExwdUlOcDJBbDdXVVhH?=
 =?utf-8?B?M0x5d2FpMTdSRThXS1d6UVl5TmZvdk9MNzJEVm9KTm0zRVY2eU5uVWsxYW8y?=
 =?utf-8?B?S1BEaGRxZ1NQL1lzY0lId3ZVSDNzblE1UXZqNm0wb3NJNnRqZWNsOVg0Qm9B?=
 =?utf-8?B?ZkVHdWdPMXpXek1tMWR3SWZYMFZjTjFUdlRxeEtEVVA4TkIyVEJaUGRKbHMr?=
 =?utf-8?B?Rjd0M3pEQnY3MVVPd2VWR01nOWRTQ3FkZk53azV2WmpQT0FKcERRelFVQnox?=
 =?utf-8?B?WG91U1RwbExLS0taYXJyK2VKdGJTcVRQM1c2Y2VQa3loaDd2OGc1UGhjUWRu?=
 =?utf-8?B?eHpORlNPL1kxR0ZHMElrMjVHYkpjR0tSWlgzRmVxR2IyR2RxeHlSeFQ1dHdR?=
 =?utf-8?B?akVxRUpna0VMSjY2aGZXQzJMYmtnZHAxeGF5R25ueXpCMHZId09mdmJlK3o0?=
 =?utf-8?B?R09QeVc4RjlmeERNRG5rcCtZSzk1QitIWThuanpuWHB5eXBHOVFzNE5MY1FE?=
 =?utf-8?B?K2VsSXBUTlRxL0p0ZG83ZDBuTUpuSTg2VytwYTFmbmR6b0JEU0RSS3JOaENo?=
 =?utf-8?B?WklqTjdId1BKN2FYZVZoUFQwdW15cGIvUkpUQk9pcjhnZ1ZIME1jamtGSStS?=
 =?utf-8?B?VUlxRm4vL2owdCtTOHdybmUvVlRUU2VBQTYyZTNibC9ibTV4bm45ZGVYVmVo?=
 =?utf-8?B?bnhvZmgxc3lDRFpyam82Qzd0M2dOdzV6dW1rM250cEFmejRBbE5xQU1TNWFL?=
 =?utf-8?B?RUdDa01Id1djZEZaTEJwd3FQNy9nYVRlcDZka0dyUkZYVWhHeDFJRXI4eVVp?=
 =?utf-8?B?aGRqdDZkbG9jb20xVW1Qb2JmNm90YUFwcXhWUTF3dE82bGVyY0IvQUlWelUy?=
 =?utf-8?B?QmNBb2VxUDdNelZuTVVKNmx0ajU4K2NvOThWVW1jYzZOMXJDY2ExM3c5U0Fs?=
 =?utf-8?B?WlNEYlM0MHpYcVlHZUhONHhkT3kwK3pXaTlFMDdBQWpucmZEWW11TWU1b1cz?=
 =?utf-8?B?LzBqdm5CQ1U1Q081eDBMSnQwQnRqemg4SEtIWkJUajg1Q0psK2lHNzJvYmNa?=
 =?utf-8?B?MGdvVWo5U2tqdFlwc1hOSzFHSjEyUUJjWGxDeGh6V1F1SUYyamdkb2xRTzFE?=
 =?utf-8?B?N0JUVzRrNDJLbjVraWxGaFQzNGlSazRzd2s4ZDg0NDFnL2o4cksrZzFJYlM3?=
 =?utf-8?B?VHdwQkpTN3pjZzZCMnA5czZPOVlFM0V3VTlXVmtaYlB0T2FYRm4wdENHR2FI?=
 =?utf-8?B?bWVUd0lwTWp6bDFoOEtyaTRtaDVQQThlRFRHZHEwNFd0Sk0xanBrM0lDb21K?=
 =?utf-8?B?Y3JmdE5Ma1R2S205Skdsem5UVmVJRkZ0anJzU0JvdVJzQnIvYmJIRHYzdG1l?=
 =?utf-8?B?SFZWaHF1cUZZcXhOMmhmdWU0VVZkTnVXeEZWbDFpREQzYW8wZWNwUT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 72414cc4-dc81-4705-651b-08dea552b464
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB8106.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Apr 2026 18:19:36.7511
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IL3z9Arr6PrK81xsdhsyYe3etvS75m1SSGpwwocV2AFK6pzmC0dAs8XkwRwnrePUABA5UUtiZAeSjc78WOKlCQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5620

Hi Joerg,

On 4/28/26 3:50 AM, Joerg Rodel wrote:
> On Fri, Apr 24, 2026 at 05:42:09PM +0000, Melody Wang wrote:
>> diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
>> index 0a1b63c63d1a..420f1ec0dcfb 100644
>> --- a/arch/x86/kvm/x86.c
>> +++ b/arch/x86/kvm/x86.c
>> @@ -10789,6 +10789,12 @@ static int kvm_check_and_inject_events(struct kvm_vcpu *vcpu,
>>   			kvm_update_dr7(vcpu);
>>   		}
>>   
>> +		if (vcpu->arch.exception.vector == MC_VECTOR) {
>> +			r = static_call(kvm_x86_mce_allowed)(vcpu);
>> +			if (!r)
>> +				goto out_except;
> 
> If this path is taken the warning at the bottom of the function will trigger. I
> think the target needs to be out: instead of out_except.
> 
Yes, I think you are right. If MC is not allowed, I should simply return 
directly instead of noodling through the rest of the function.

Thanks,
Melody
> -Joerg

-- 
Thanks,
Melody

