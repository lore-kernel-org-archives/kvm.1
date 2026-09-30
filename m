Received: from CH1PR05CU001.outbound.protection.outlook.com (mail-northcentralusazon11010042.outbound.protection.outlook.com [52.101.193.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DECF3B3BF2;
	Wed, 30 Sep 2026 19:50:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.193.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790797832; cv=fail; b=onBOFK2Zg2Yk1FLczkKs4qTd+Ulat08JCP1gK5JQXiQkPlfpICSLznbv6C9MscGQDzmnfUIzqgZZLTk3AXkXLO4fAT9LwH12ZvvmCqd4Fq9F+rH/OwiqqmEtW9S/cr7cNudSCK0xhROt/WfsiGzESVSUoXpItf0eHIpWsq5V0NU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790797832; c=relaxed/simple;
	bh=S2TbGVZC/3dXsnzdvCVsE7Czddgyfe+cfA3rDzohUAE=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=E/ubc7GyLrFqQQADUytPlg0RR/quJBeFPqJNVxsnwRhhYJVNMFVY5/T1VPGuX6WNDl5MI8lHfoB4jW+HrWMc5BHm6dwpbqY4Ni/Blm6ZbEYovCmGSooHHgeBzsVRoGdE+2DSHAVGM8BV/QUpayHW1O40/N1Q3TS5zEQiSmryw3E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=eP4dAZh0; arc=fail smtp.client-ip=52.101.193.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="eP4dAZh0"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ubEDMmIfZm6iysx0uvYT/lPGsauUV1zsIMqBnxhQi+JACDnNawBJyBig8BopVaM1QvYO9pS3yU8rYsbmtvrH0HAEU2hOmAsdIeBW7k8BvzggqwpOmm9ZPL6opznxu0d/Vc1TJHn7sQ6WcYQl+CyDiakiVPxnJxRpUK6K7g9YhnPO4PdWh/uSMq/YFDtpTF4KcGM0D/NuUzZk/dFmPpk1pdnldp9oa3HpjTQcFUmdElWmhAqOqHTPivjl5gJrC5tQLj5cO2AQMl0PRtu73M2xI1bfR5v+woi9AuU2dSW9Q/jaCDhd4C1KGWXqt574T+15lsCXoRWVwD/lh4ooSU0hQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=odvSB4RLkqMKwmTFHDGyo/V0D5ZEN/9a9iY/fCPkp5Q=;
 b=U8znirBp6vVp9T08ifSal6XXRapVH63/ajVNQCGzrJkkZPma9y1FBwt073HrzLdtHKadEPIBaHkoaDmo82bTjKaREp+gyV2UxhwSoDjDHC75bfhCK+axKDjeMZKb99SxFzhFqUCw97lHUEhOLn258xx7SwXD/nc70mZkZH4HCEKVO1BY9SasqJA7vZWSjpBthnEJy56b8862QzPlO0Ew5dQ+zfkS8zSoH+PBSjGC6jXW4xGm3OXmVnRfDIHbet35R4OdgoCB9KIMkukT0QiMh9+q5I6VLV1SJma+OicYuk9zxlkuNcFwWVTOuNtqYFnybKTX06M/Jz82/M9/ikVL5w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=alien8.de smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=odvSB4RLkqMKwmTFHDGyo/V0D5ZEN/9a9iY/fCPkp5Q=;
 b=eP4dAZh0MtMQd4Qik3SoOte0m8k3HxaoW8SZSvODiwcVWKo2gu3NeuNBLwzvDUQYnVeWjpFjKjXr1Gz0WP1EZGVllHoapCzM17Ec4aWt3nHJsXFdUzuNamFxTLNQ/PQVQYCuihkHdVhhSfza2NDhqceJLrZ+DaR738Fjdg4+WtA=
Received: from CYXPR03CA0034.namprd03.prod.outlook.com (2603:10b6:930:d2::9)
 by CYYPR12MB8892.namprd12.prod.outlook.com (2603:10b6:930:be::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.15; Wed, 30 Sep
 2026 19:50:25 +0000
Received: from SN1PEPF000397AF.namprd05.prod.outlook.com
 (2603:10b6:930:d2:cafe::42) by CYXPR03CA0034.outlook.office365.com
 (2603:10b6:930:d2::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.472.15 via Frontend Transport; Wed,
 30 Sep 2026 19:50:25 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SN1PEPF000397AF.mail.protection.outlook.com (10.167.248.53) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.472.14 via Frontend Transport; Wed, 30 Sep 2026 19:50:25 +0000
Received: from [10.236.30.85] (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Wed, 30 Sep
 2026 14:50:23 -0500
Message-ID: <ec3073de-74b5-4321-8ca0-5d00ac288816@amd.com>
Date: Wed, 30 Sep 2026 14:50:23 -0500
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 2/8] x86/bugs: Allow spectre_v2=ibrs on x86 vendors
 other than Intel
To: Borislav Petkov <bp@alien8.de>, Sean Christopherson <seanjc@google.com>,
	Paolo Bonzini <pbonzini@redhat.com>
CC: <linux-kernel@vger.kernel.org>, <x86@kernel.org>,
	<linux-coco@lists.linux.dev>, <kvm@vger.kernel.org>, Sean Christopherson
	<seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>, K Prateek Nayak
	<kprateek.nayak@amd.com>, Nikunj A Dadhania <nikunj@amd.com>, Tom Lendacky
	<thomas.lendacky@amd.com>, Michael Roth <michael.roth@amd.com>, Naveen Rao
	<naveen.rao@amd.com>, David Kaplan <david.kaplan@amd.com>, Pawan Gupta
	<pawan.kumar.gupta@linux.intel.com>, Dave Hansen
	<dave.hansen@linux.intel.com>, Nathan Fontenot <nathan.fontenot@amd.com>
References: <20260826223510.3669875-1-kim.phillips@amd.com>
 <20260826223510.3669875-3-kim.phillips@amd.com>
 <20260909210101.GBaqHJDWSUnpjqNcyB@fat_crate.local>
 <9b85be41-db5a-4bdb-95b4-beffb05a5ffc@amd.com>
 <20260930030650.GDarx8yvplZzQtGDBz@fat_crate.local>
Content-Language: en-US
From: Kim Phillips <kim.phillips@amd.com>
In-Reply-To: <20260930030650.GDarx8yvplZzQtGDBz@fat_crate.local>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF000397AF:EE_|CYYPR12MB8892:EE_
X-MS-Office365-Filtering-Correlation-Id: 9596e0fa-ebfc-4ea6-0384-08df1f2c1206
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|1800799024|376014|36860700016|82310400026|4143699003|11063799006|10067099003|260925022911599003|260925021911599003|260925021311599003|56012099006|5023799004|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	kG32NsbvZ0dvFHB2qKi6iA0HKYrHthKnvVemShYlYEz3XcmnWbIZnl242TpKv9uz3+7uxtnvGeC2o50J4NzQho2yUYsoGqjzIXS7plKqOmPX3pUr4r4On172zRsh9Z6S3hQhSlri7ZigDWVz3ygy1nUHp7/2O62Eqq+oulO0E017nWH2Rkg1xGFUeIzYocQNS/iR5ZAqHj80qm+HS8FFmFCXVh3rf+9jSuGvNGC1S/IZZ7iogQ94YOvbOlSAP6XGN2f3INH9sZ+uLfZbJIQHj0sdvW6px5e8v8vvQEYUYKCT1qpXx7bk2kT8dlA+IuVk7uNWJH9lJjKbMdemqdatd7FhHqmA9ln5pD4EG4CpMxEjpwgh+uYTqWAYqj+XVdCGRxWkLsFhXY5YYi8BgU3hjrjslOdg8BjdMetIHI1p9otZWz+HgMqp4Vxf7r9XP9gV6LuXNBCYF50sWr2NB1EUraFII3kuGYAsmPHDHGGnI1nFAPQ7RA1O37pWxH0uiyfokzsigT4GxRpvN/niMshZfj97pVoYKhpKssop5Td23ULB5VKvMBtMz+jN3A8ylJKxru28fhr48C7ghHNGIOopYT0ntfGsqSb++OJDHKqrH/of9UI4CSJt2JeZPOY0K9lWauSEjyAqJrjQISPDIUk/X3Ua7Ek/hie1Wr1B9QZR/2bFuDy3WVZuUXQMkxLh+Zz7bBGpRfphFOWj2LCfdNkOlg==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(23010399003)(1800799024)(376014)(36860700016)(82310400026)(4143699003)(11063799006)(10067099003)(260925022911599003)(260925021911599003)(260925021311599003)(56012099006)(5023799004)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	WTJ8/Szf5OUkVqZkSbs6b01+7mFkJFcAt9K7SwIV5KImsfPHWbhvJjoY9NMgrHwPKPs/YEBNBahrVIzmpfH89CPk2wC141weM2paEKGz5UglAwp3IyscdJXqa6qcmOkTArF9gy+mfMWg5c2dM4jBY0UyJui4vDfqo8gzKUb32b15yKs8UpMz83CYylDH3SPeKUzjgu+mGbt9PPUcM4YdEFxLHIIK2PbQllREAxf1MESrIiuyRyfAHVDj+NOqRiSQgj4khrb3KFzf91Wa3C/BCbpTI9j8a65g+cY704giUAIbARsMqWh6aSGgfldqPC0s0A9zVcQdW28JDZyoN63RYwORH5kbBR5L5vbQNdzM8cYGZX2Rm0fLZJXadTzOSobki1VodEbwts8322cEBgKJH8mYZIb0AspYY8dRH9PHy89VsHsdR2h+9ioUYxY70wrH
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Sep 2026 19:50:25.0552
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9596e0fa-ebfc-4ea6-0384-08df1f2c1206
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF000397AF.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR12MB8892

@Sean, @Paolo, Please consider merging the rest of this patchseries 
(patches 3-8), as they can go through the KVM tree directly as-is 
because they does not depend on this or the prior patch 1/8 other than 
for performance reasons.  Thank you!

On 9/29/26 10:06 PM, Borislav Petkov wrote:
> On Fri, Sep 18, 2026 at 06:01:55PM -0500, Kim Phillips wrote:
>> SPEC_CTRL.IBRS is architectural and behaves on AMD just like it does on
>> Intel, but the kernel offers spectre_v2=ibrs on Intel only: the option is
>> rejected at parse time on other vendors, and MITIGATION_IBRS_ENTRY cannot
>> even be built into an AMD-only kernel.
>>
>> AMD's SNP BTB Isolation needs the kernel to toggle legacy IBRS in order to
>> optimize the VM exit-to-re-entry path, and right now there is no way to ask
>> for kernel IBRS on an AMD machine at all.
> Same comments as to the other one: We need:
>
> - a proper use case which is *actually* useful to users

How is optimizing the VM exit-to-re-entry path not "*actually* useful to 
users"?

If BTB Isolation users want to use BTB Isolation, they'd want what the 
AMD APM recommends: To use spectre_v2=ibrs: what is wrong with that?

For this Node-ID getting cpuid script that causes lots of VMEXITS:

for i in \`seq 0 1000\`; do sudo taskset -c 0 cpuid -1 -k -l 0x8000001e 
 > c0; done

I get these stats:

v2=(retpolines), btb-isol=off                   v2=(retpolines), btb-isol=on

8135634850      l1btb-accesses          8237924785 l1btb-accesses        
           101%
2292830105      l1btb-misses            2479438191 l1btb-misses          
           108%
2254370689      l2btb-misses            2462526637 l2btb-misses          
           109%
38479671        l2btb-hits              16912146        l2btb-hits       
               44%
2292846687      l2btb-accesses          2479437240 l2btb-accesses        
           108%

6.591965727     seconds time    6.410626779     seconds time elapsed 97%

v2=ibrs, btb-isol=off                   v2=ibrs, btb-isol=on

9079195678      l1btb-accesses          7735439435 l1btb-accesses        
           85%
3420759821      l1btb-misses            2264575904 l1btb-misses          
           66%
3385686214      l2btb-misses            2226743253 l2btb-misses          
           66%
35073337        l2btb-hits              37834099        l2btb-hits       
               108%
3420753266      l2btb-accesses          2264587491 l2btb-accesses        
           66%

7.019508776     seconds time    6.408415958     seconds time elapsed 91%

Does *that* help?

Kim

>
> - have it properly documented in Documentation/admin-guide/hw-vuln/ along with
>    the potential impact so that people can make an *informed* decision whether
>    they really want it
>
> Without any justification for the added complexity to what already is
> a maintenance nightmare, there's no point.
>
> Thx.
>

