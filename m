Received: from DM1PR04CU001.outbound.protection.outlook.com (mail-centralusazon11010006.outbound.protection.outlook.com [52.101.61.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CDD03BBFBA;
	Wed, 26 Aug 2026 23:06:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.61.6
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787785572; cv=fail; b=Q7zpF8ZbGgsHQ+VFpPk8TppWlEZA0wWzGrYa0wGMio24HTz7ExFYTYGhJzWe0wLko/LnmqdfBCTd7b7Gn0nJbS3ICH17uPfurWT8A9uzp6X7I5b8pwMdLk8lYpaVS+FojJ8ycIneTkyQCsJ/8LteoaytYbW/uNjgT7aoC7KHdZY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787785572; c=relaxed/simple;
	bh=lgJB+QsdKyKnaxeZ5yZ9jqDc/9S35hCIqyq7zQcIt84=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=M1CHzLgp4fWdrkQ05NN4okM7tB7VGYxFyhS4+RFmATg5JIj+heeuE5Kr/dd2TwymjSL9yFGg/EuLiJwR8XZuqZkduvsBl/84/mCAIeDy27ZHg0MKgtmEK1U9faKoPu8ry+jlS05bZlUdsSYu+6BNyp6Z6j7rJJRFj9fzodk/bGQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=F7IhGDIE; arc=fail smtp.client-ip=52.101.61.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="F7IhGDIE"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Wd5fnwt/Ib8v8hmuUni1tutSEoZBgDVB+yQrAsh0BKUiTY3DByvGgpgvSpqi8Asa2Zf5Him3Qb574ZbpKVXsHDfjtI6EmwIb8yeG9yPcb+Pjc2GvP7W9x+8UK67j0xtC+cszXZTpekWC5o6IbcarqPt2Iftmn2mODBVXgn0Gj9BzH04BhbDg+Lc78TGMC3QcNjUkOkVAvYNjH9fiWOX1X1NezdHuBW8BNQ+JVJ9hMMu3adx1EBn1ORc8gHbkeey343CD/ZRLSRYlbXEBQEPHcVqdDS2cx6vwSR9ikzaByVV0AHqPH+taWKbvLDLUZTDHwTqB2/SDXqd3NoJ8GWK6yA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DrPvVN4A7VuHXVQYd1XJkp2aiKcqD7B7jIJWHCkZ3Ng=;
 b=JVT8dnkJcqNifkfJZTixpvtfA7lyZuw4zVRqprYOz8xxsWiw8cs2Kf74fJpuFcvQLO+19lPSs2TsMyHYWOukqlGX2kS+KFHIPBYObXLqRVuLiGh5zljeaX25a4nsyJuskjHPVmrybafHrWvLXtJzlKRr1s/gQOqKC73vH5zWXTjLA7okvXXqHMTHxjyryjgSgh6NM8iaJd1QhxyuCW/vFTEOKTYJ6WVXxoXJKklIhpN9KMU3KVBq0JFmyLVi0DrJ3dXb9vDzpBUcyJ5h6avrftDjt1rOksUO7UI+zNVnlNibax4p2EbReHS+X2ihOtjfaeOXTI5RXjW8ufoe24jzLQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 149.199.90.133) smtp.rcpttodomain=linux.intel.com smtp.mailfrom=amd.com;
 dmarc=fail (p=quarantine sp=quarantine pct=100) action=quarantine
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DrPvVN4A7VuHXVQYd1XJkp2aiKcqD7B7jIJWHCkZ3Ng=;
 b=F7IhGDIEGe5VCkAxcpsyKJqgDYMLLPyEZXJshEufJhFj+GM8Su5AheRTH6sACzj0UfhzGZwUzMXjuu87+pbtgEzbTY/losvPdwztDYS4fZqmBWuazIUn/K9m79yZHIcPSRwYg4Tk8babnDUKrtbTs0mo+7vcDvOFTyGl3FC6zLA=
Received: from BL1PR13CA0235.namprd13.prod.outlook.com (2603:10b6:208:2bf::30)
 by MW3PR12MB4393.namprd12.prod.outlook.com (2603:10b6:303:2c::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.21; Wed, 26 Aug
 2026 23:06:06 +0000
Received: from BN3PEPF00022BC6.namprd05.prod.outlook.com
 (2603:10b6:208:2bf:cafe::9f) by BL1PR13CA0235.outlook.office365.com
 (2603:10b6:208:2bf::30) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.382.7 via Frontend Transport; Wed, 26
 Aug 2026 23:06:06 +0000
X-MS-Exchange-Authentication-Results: spf=softfail (sender IP is
 149.199.90.133) smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=quarantine header.from=amd.com;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 amd.com discourages use of 149.199.90.133 as permitted sender)
Received: from satlexmb07.amd.com (149.199.90.133) by
 BN3PEPF00022BC6.mail.protection.outlook.com (10.167.248.219) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.360.3 via Frontend Transport; Wed, 26 Aug 2026 23:06:06 +0000
Received: from [10.236.30.85] (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Wed, 26 Aug
 2026 18:06:05 -0500
Message-ID: <f1d8833d-7c7c-473c-baff-62dd2fe54270@amd.com>
Date: Wed, 26 Aug 2026 18:06:05 -0500
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 04/10] cpu/bugs: Allow spectre_v2=ibrs on x86 vendors
 other than Intel
To: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
CC: <linux-kernel@vger.kernel.org>, <kvm@vger.kernel.org>,
	<linux-coco@lists.linux.dev>, <x86@kernel.org>, Sean Christopherson
	<seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>, K Prateek Nayak
	<kprateek.nayak@amd.com>, Nikunj A Dadhania <nikunj@amd.com>, Tom Lendacky
	<thomas.lendacky@amd.com>, Michael Roth <michael.roth@amd.com>, "Borislav
 Petkov" <borislav.petkov@amd.com>, Borislav Petkov <bp@alien8.de>, Naveen Rao
	<naveen.rao@amd.com>, David Kaplan <david.kaplan@amd.com>, Dave Hansen
	<dave.hansen@linux.intel.com>, <stable@kernel.org>
References: <20260804235611.4053375-1-kim.phillips@amd.com>
 <20260804235611.4053375-5-kim.phillips@amd.com>
 <ga63o6nf7xebndlo66qqasjx7axpopyph7ilkwhvx3enfaqs4w@r4qfr6eo6kcw>
Content-Language: en-US
From: Kim Phillips <kim.phillips@amd.com>
In-Reply-To: <ga63o6nf7xebndlo66qqasjx7axpopyph7ilkwhvx3enfaqs4w@r4qfr6eo6kcw>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF00022BC6:EE_|MW3PR12MB4393:EE_
X-MS-Office365-Filtering-Correlation-Id: ff2b93cb-c947-4e7c-2071-08df03c69bd7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|36860700016|1800799024|7416014|23010399003|18002099003|11063799006|4143699003|3023799007|22082099003|10067099003|56012099006|6133799003;
X-Microsoft-Antispam-Message-Info:
	jpKW6w/XEp5Xu9NduyREaT3dpYDKFz3kmHqjNHKecjIKp27b7A5sVFEvVJz5zheGHg2Wy7QN00EghHWJaN57Mva3OU6OkXsV9im2Lbannp0AgVDc7G3gZXRGtJcZGn+l5UATfqoZSGjWw3fIOVEy8DJJGOPVWxqM1E40qNdSu3qhG+85/GsATO9lTIQ/KqZx3CZqJ3iGZMayzt500Zt1b33KgQfZj4zTntnaIBJD/PequDF6CHvIAhMiEwYsIbgq7ymMNe08NS9RKPPGywlDp3BgcVfiTfLYVuXmlwnNgKoc8BSl4qipMwHuM6RvzuZ1/ZmRJOi/4KA2lfwfRjPErYX4gAcEGtcCzBimaOmkEa3q0dmfq/2eOYYRIOP7kIy1Z/5uxd1Wx6gq145XVyXyx5jIoyTGZ7QWe5NA540WaPJDgGe/xV5MRJyN9H4LQpcBQnUZzgZ4RdLbPF9TFaTvt4dCt5i++BDydJq3L5jdyS/J0lGdHRGc4AZeWjHBa8QKhxeq+q1cGLP6aS01XmY6tjh6M9H52HFFhLj334ZDjBqkuvP9OdSNMYvU9XPRqzguLz70uw4fbCWKBXbSHDG39/KP9zuKQGqfzamSU0jITS7uryX7DrBtrBZ8fE2R0z3T7+iOtB2IAO5jpfqHoQmMXFDJF6S9MUbrLWLYEVEUhm8BdJoScgWhbxpfsDR/j+3e0BbFw5xz44M4qP95cwse6Q==
X-Forefront-Antispam-Report:
	CIP:149.199.90.133;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:unknown-90-133.xilinx.com;CAT:NONE;SFS:(13230040)(82310400026)(376014)(36860700016)(1800799024)(7416014)(23010399003)(18002099003)(11063799006)(4143699003)(3023799007)(22082099003)(10067099003)(56012099006)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	r1n0xUjvsBHpBtrGIsNrqWDct23onaHxMKqUB+8XQqpkZPrQ7DOtSvcGNyktbfPo79OBjVvOq5EZ8cnxcUuKT8rca3H+b4kLen5QmaagJU9HjHJZbH64Isd/wbkVo/ThuW7nE2Ocb/1WmckxWq5DIrLWn2Gs0ZIWh97CVmUlHGrknquo4pDFK1UwtOQ9DdTngC5z2JzBUJAlg6nPzCmNar6yDQsfO7dRy8xWlmGPIfIKn7xPsAZqv3Wagh7V6lJKG+cprGD0Z7oQrRJPHrvwTQnRNHv/O8kP/LegGqDojD2ZSYiEDAjmU+RlVfIhue0uU01/dqzzcOx/5f7bDwH2mdqkgNdBLvqxkNNFn9YUYpvzImRF+GwM7H9+EqC3aYnA8Jc5ce9lEQ4TfhEY5EObXIdR0lkpVodBNmbTOyG+yFbD/NmeR/aFJPZLgNrcvP1u
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Aug 2026 23:06:06.1154
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ff2b93cb-c947-4e7c-2071-08df03c69bd7
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[149.199.90.133];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN3PEPF00022BC6.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4393

On 8/18/26 8:17 PM, Pawan Gupta wrote:
> On Tue, Aug 04, 2026 at 06:56:05PM -0500, Kim Phillips wrote:
> ...
>> @@ -2297,13 +2299,26 @@ static void __init spectre_v2_apply_mitigation(void)
>>   	if (spectre_v2_enabled == SPECTRE_V2_EIBRS && unprivileged_ebpf_enabled())
>>   		pr_err(SPECTRE_V2_EIBRS_EBPF_MSG);
>>   
>> -	if (spectre_v2_in_ibrs_mode(spectre_v2_enabled)) {
>> -		if (boot_cpu_has(X86_FEATURE_AUTOIBRS)) {
>> +	/*
>> +	 * head_64.S preserves EFER.AUTOIBRS across boot, so a kexec from a
>> +	 * kernel that ran in AutoIBRS mode carries the bit into the new kernel.
>> +	 * Explicitly set or clear it to match the selected mitigation, regardless
>> +	 * of which mode is in effect.  The boot CPU does this before
>> +	 * init_real_mode() snapshots EFER for the AP trampoline, so APs inherit
>> +	 * the correct value too.
>> +	 */
>> +	if (boot_cpu_has(X86_FEATURE_AUTOIBRS)) {
>> +		if (spectre_v2_in_eibrs_mode(spectre_v2_enabled))
>>   			msr_set_bit(MSR_EFER, _EFER_AUTOIBRS);
>> -		} else {
>> -			x86_spec_ctrl_base |= SPEC_CTRL_IBRS;
>> -			update_spec_ctrl(x86_spec_ctrl_base);
>> -		}
>> +		else
>> +			msr_clear_bit(MSR_EFER, _EFER_AUTOIBRS);
> Clearing the old kernel state should be done well before the mitigation
> selection starts, below already does it for the SPEC_CTRL MSR:
>
>    void __init cpu_select_mitigations(void)
>    {
>            /*
>             * Read the SPEC_CTRL MSR to account for reserved bits which may
>             * have unknown values. AMD64_LS_CFG MSR is cached in the early AMD
>             * init code as it is not enumerated and depends on the family.
>             */
>            if (cpu_feature_enabled(X86_FEATURE_MSR_SPEC_CTRL)) {
>                    rdmsrq(MSR_IA32_SPEC_CTRL, x86_spec_ctrl_base);
>
>                    /*
>                     * Previously running kernel (kexec), may have some controls
>                     * turned ON. Clear them and let the mitigations setup below
>                     * rediscover them based on configuration.
>                     */
>                    x86_spec_ctrl_base &= ~SPEC_CTRL_MITIGATIONS_MASK;
>            }

Thanks, I've addressed this in v5.

>> +	}
>> +
>> +	if (spectre_v2_in_ibrs_mode(spectre_v2_enabled) &&
>> +	    !(boot_cpu_has(X86_FEATURE_AUTOIBRS) &&
>> +	      spectre_v2_in_eibrs_mode(spectre_v2_enabled))) {
>> +		x86_spec_ctrl_base |= SPEC_CTRL_IBRS;
>> +		update_spec_ctrl(x86_spec_ctrl_base);
>>   	}
> Nit, I find this a bit confusing. IIUC when AutoIBRS is supported, you want
> SPEC_CTRL[IBRS] to be set when legacy IBRS mitigation is deployed. If you
> move MSR write down after legacy IBRS mode is set(KERNEL_IBRS), you can do:
>
>            if (spectre_v2_in_ibrs_mode(spectre_v2_enabled)) {
>                   if (boot_cpu_has(X86_FEATURE_AUTOIBRS) &&
>                       !boot_cpu_has(X86_FEATURE_KERNEL_IBRS)) {    <---- just adding KERNEL_IBRS check to existing code
>                            msr_set_bit(MSR_EFER, _EFER_AUTOIBRS);
>                    } else {
>                            x86_spec_ctrl_base |= SPEC_CTRL_IBRS;
>                            update_spec_ctrl(x86_spec_ctrl_base);
>                    }
>            }
>
> Otherwise, a comment explaining the intent would be helpful.

Right, also addressed in v5.

Please take another look.

Thanks,

Kim

