Received: from CH1PR05CU001.outbound.protection.outlook.com (mail-northcentralusazon11010018.outbound.protection.outlook.com [52.101.193.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D911B3C8728;
	Wed, 26 Aug 2026 23:06:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.193.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787785580; cv=fail; b=tGyH3tluwi8Fb48dHc9ZpTIDrjK1dJTTLtlaoEtFNSAURmkFBcPrAaJ0xabcWxWrRAcQCgbuUFrHMnpw2kwvol0ZAYGFkpvLNlhbf7htfqcinktFxpo34chAgSShdD4aVMIrSDWwnWXfWUuzeguZV+45HiTaAspX8kGIrYj0pro=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787785580; c=relaxed/simple;
	bh=w/VHB2bk+oZpc92agCjQCXWXzDJGp1lQzrCFzyLl73w=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=S74NS+Wv4Is2Pmi75fPuuzS+T7dwdlmYteFcyItD38DkJx7Am5j1YkqU4WEOYx3Xkg7CtVZWenQZvPvPCqcm8jVAmOxgTq0aHLsu6t0JM/lBPnHR8YKLs7Ndfm3sCu2WffDcyjJNRp32RZMesps/3vFOwhd53YFW5WxsgZeQg2o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=Hmb073UQ; arc=fail smtp.client-ip=52.101.193.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="Hmb073UQ"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wgs+Hynh5r5qQxBgLFA4MIORzG1/FbPMUqo95Toqwud3vAzs0mIauDBTorx9EjTg9QmSqUG6zzZp/rl8EjjUkg/lFLg5Jyo9fGudPUIAtNkk/1Cqx9A/kcNfRYfKH8c/x3hKbpI3iXHnayQ+aPsvaQ7RXA0GBTeKMH0lKSj3IXThlCh4oXDzlW0dYhLKNfNSyjhTDuHyMYg2WApHa/kyATw9A/5djKPaLHwKq4w3xaZgAjzRGk0klWD9+Jsj/KCoIs2BkGN4keyZHfkYzQm3ABBDwkF0QVRTZ9TUGWV2JeDKv1fHTw1Fhl+CSqc7QQHgCMB9IO0irYEFbKLhlr+vbw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hmpSwf6ExcqOJCMMhlyZtDoIP9rap1kkaqOslHjUyN8=;
 b=WL7CkQbI8CoO43+170OU+EmdRxap0DRbZwtRKML1FisKlWTziZxxsdGh76ytcIlBEVN6DomZQ20URCxq/lShz9onbf+vHnhhZStcgSN14fkeWofGy4Gw9M4WPuzs3i9sSGtxxXWvuiUFDCkP6oMvehJsCIDwlmdP33/ln1BNwBZm0x1vzUvtLc+wAGekVzLD5fjLO4v5D21KbE8kklUdZk70doBeRHpgvRWX5/ZErzsLhyBAj1Cz3ed1wfiSku2dSfeQFPYDSvcprqC+Mv9F9p1D+tjSDsbZnVgbBF2geGIpInv3Y4myzWQR3dWkNRoJLgbUc3p5pmTZqTftIgRJDA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 149.199.90.133) smtp.rcpttodomain=linux.intel.com smtp.mailfrom=amd.com;
 dmarc=fail (p=quarantine sp=quarantine pct=100) action=quarantine
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hmpSwf6ExcqOJCMMhlyZtDoIP9rap1kkaqOslHjUyN8=;
 b=Hmb073UQ5MNC0I6+26lPL3h4haH5wxkZvk5NNff1Up//HeiH8oNipgHVysFN3ceUMm3nh9w7xmM2F5WmYN+4ASq6FzuOg76PRvOvsdIxDbTlNiV5FyCRqy8Up4LKCSigWLPFXQA/x3YjYch5wunnWIKB3gMAz0PW0ubxUhJgPPI=
Received: from BL1PR13CA0236.namprd13.prod.outlook.com (2603:10b6:208:2bf::31)
 by DS0PR12MB7996.namprd12.prod.outlook.com (2603:10b6:8:14f::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.8; Wed, 26 Aug
 2026 23:06:03 +0000
Received: from BN3PEPF00022BC6.namprd05.prod.outlook.com
 (2603:10b6:208:2bf:cafe::94) by BL1PR13CA0236.outlook.office365.com
 (2603:10b6:208:2bf::31) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.382.7 via Frontend Transport; Wed, 26
 Aug 2026 23:06:02 +0000
X-MS-Exchange-Authentication-Results: spf=softfail (sender IP is
 149.199.90.133) smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=quarantine header.from=amd.com;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 amd.com discourages use of 149.199.90.133 as permitted sender)
Received: from satlexmb07.amd.com (149.199.90.133) by
 BN3PEPF00022BC6.mail.protection.outlook.com (10.167.248.219) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.360.3 via Frontend Transport; Wed, 26 Aug 2026 23:06:01 +0000
Received: from [10.236.30.85] (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Wed, 26 Aug
 2026 18:06:00 -0500
Message-ID: <776393b0-f35d-4b08-9089-8599eb3fe514@amd.com>
Date: Wed, 26 Aug 2026 18:05:59 -0500
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 02/10] cpu/bugs: Allow forcing Automatic IBRS with SNP
 active using spectre_v2=eibrs
To: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
CC: <linux-kernel@vger.kernel.org>, <kvm@vger.kernel.org>,
	<linux-coco@lists.linux.dev>, <x86@kernel.org>, Sean Christopherson
	<seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>, K Prateek Nayak
	<kprateek.nayak@amd.com>, Nikunj A Dadhania <nikunj@amd.com>, Tom Lendacky
	<thomas.lendacky@amd.com>, Michael Roth <michael.roth@amd.com>, "Borislav
 Petkov" <borislav.petkov@amd.com>, Borislav Petkov <bp@alien8.de>, Naveen Rao
	<naveen.rao@amd.com>, David Kaplan <david.kaplan@amd.com>, Dave Hansen
	<dave.hansen@linux.intel.com>, <stable@kernel.org>, kernel test robot
	<lkp@intel.com>
References: <20260804235611.4053375-1-kim.phillips@amd.com>
 <20260804235611.4053375-3-kim.phillips@amd.com>
 <lctyimdlenyb5kvfxarzajs2ggzkwn4yehxu233lojynqwa7ej@wjur3lh6szlr>
Content-Language: en-US
From: Kim Phillips <kim.phillips@amd.com>
In-Reply-To: <lctyimdlenyb5kvfxarzajs2ggzkwn4yehxu233lojynqwa7ej@wjur3lh6szlr>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF00022BC6:EE_|DS0PR12MB7996:EE_
X-MS-Office365-Filtering-Correlation-Id: 0cd106c3-d234-41b1-c51c-08df03c69903
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|1800799024|376014|36860700016|82310400026|23010399003|22082099003|18002099003|13003099007|10067099003|56012099006|11063799006|4143699003;
X-Microsoft-Antispam-Message-Info:
	F5TOM+vfa0CeMBiBsOgqcGKdFQeP50dlAqe6IrkqqmRJgjoDLsGvhvB0ESlqnHGo8RrAadN3xrGu2Ox60Xyx/ekr19bF3PUkyPeTzzHx+4tWeBxHwpyBmcSASVulOsRA2Cel1W57HaEez4DmWju+YKBrPyx/fd0TQEPFSpOkS9f9EilsfBkvvgO4W2EYMLeY7HzGuExjxyuGEJN7GeWgyo3M+lCnRnpATKKcFRDV0dF+vHqLgtOLfnwS1iY5E5xknzEJ6jXsB3V6RCR8IC9waT7MoJEOFgCS7UQo87moobkXi7RAw80hdcmgjJOKD1XV+q9gqqur+45CUfc4L+iQ4+SPETePomWZkgVyk5Dc9nrCVgNqt+WzoHRhdXvQKHlB4wf/CR6kndNaMQPF5bvjqqKERpL8dUip8GlmJiOlVuA6NqlPZPnGIaw2KTP7LSqZSbzLAvmsEdQlQYdSbBn+Jy1Rr+8hgcp2NCjOGLxQSWlOY7MyhUP+l5APUVO9SMZYUy/Eze6k+c5uAhIB/ps4QdZkwHe+cgfJMMU+cxZpfzQ4sSqy820PngCEZHWbHENE8uY7SKaD8FNNIfSZ4XNoVhDw24iL7IlyFiYIC4fqxOXw1oZNc4V3AOH3MJ7E037yprX95pZhlYK9Iw6xAC8hBgdY/fGl1g4gBNtEERoZC0k1yczOzl1gg/Wef1i/FG7dWI15LgFBFXXditGBe7Fbtw==
X-Forefront-Antispam-Report:
	CIP:149.199.90.133;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:unknown-90-133.xilinx.com;CAT:NONE;SFS:(13230040)(7416014)(1800799024)(376014)(36860700016)(82310400026)(23010399003)(22082099003)(18002099003)(13003099007)(10067099003)(56012099006)(11063799006)(4143699003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	sK18jK6AOui4utiSpalzDAZLsdWcKHHcXiV1jHmEIV9khjJfaETkalhmYuA+gaYgvFoU2GzJ2mUFpLkF6ZNdXLwlI1x+lGXTj2+3jYKjEdytppOXy+MoQ0mw03bgNTZxI1yUJGWA+L2Zf9Z0XY1pKedjioQem7clFJmdlQ9f5aQk1JX52kKApjluXzSxIFRUjtA9RfzfQ327mXaK+Xw/NqHgFA3W409pYNDln6v/BatVB5eCJNTrmJZbfhiyj6iA5LXZjDRlKznblx++B40t0nwxNav0X5MkODcJhyqNu7beRVz1dAeLylv2cugfxfltOte9pKvtiRKjJ6Te2QAbyA5ujo7reUki8CqA01nX7C8hYP8N71ZSTxuKuNGkHXdbqAZFgyHqHxp49aNAxS+qz6JBRjIDTx4ZOs0L+0dyU00suPbNAIr9cn39xvQXOaU8
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Aug 2026 23:06:01.3739
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0cd106c3-d234-41b1-c51c-08df03c69903
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[149.199.90.133];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN3PEPF00022BC6.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7996

On 8/18/26 7:12 PM, Pawan Gupta wrote:
> On Tue, Aug 04, 2026 at 06:56:03PM -0500, Kim Phillips wrote:
> ...
>> @@ -2192,7 +2193,12 @@ static void __init spectre_v2_select_mitigation(void)
>>   			break;
>>   		fallthrough;
>>   	case SPECTRE_V2_CMD_FORCE:
>> -		if (boot_cpu_has(X86_FEATURE_IBRS_ENHANCED)) {
>> +		/*
>> +		 * Don't use AutoIBRS when SNP is enabled because it degrades
>> +		 * host userspace indirect branch performance.
>> +		 */
>> +		if (boot_cpu_has(X86_FEATURE_IBRS_ENHANCED) &&
>> +		    !boot_cpu_has(X86_FEATURE_SEV_SNP)) {
>>   			spectre_v2_enabled = SPECTRE_V2_EIBRS;
>>   			break;
>>   		}
> Can we also account for retpoline availability here? If both SNP and
> retpoline are available, then only avoid AutoIBRS:
>
>            case SPECTRE_V2_CMD_FORCE:
>                    /*
>                     * Prefer retpoline when SNP is enabled because Auto-IBRS
>                     * degrades host userspace indirect branch performance.
>                     */
>                    if (boot_cpu_has(X86_FEATURE_IBRS_ENHANCED) &&
>                       !(boot_cpu_has(X86_FEATURE_SEV_SNP) &&
>                         IS_ENABLED(CONFIG_MITIGATION_RETPOLINE))) {
>                            spectre_v2_enabled = SPECTRE_V2_EIBRS;
>                            break;
>                    }
>
> With this, patch 1 & 3 can be omitted. Also avoids the ping pong: we don't
> want AutoIBRS -> We don't have retpoline -> Lets have AutoIBRS.
Thank you for your constructive review - I have addressed this comment 
in v5:

https://lore.kernel.org/lkml/20260826223510.3669875-1-kim.phillips@amd.com/

Thanks,

Kim
