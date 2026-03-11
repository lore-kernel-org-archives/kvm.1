Received: from BL2PR02CU003.outbound.protection.outlook.com (mail-eastusazon11011011.outbound.protection.outlook.com [52.101.52.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB32323ABA8;
	Wed, 11 Mar 2026 04:18:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.52.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773202728; cv=fail; b=ZgmER04zRKliAX4jaDUoNtULQRZmbUVDUjb77jjs5mmfNiuIolK5kq+W6MEGRGGUy074Uu29nLaw9Mmy4YI4cNOcTjLjanb1YhzikHTu4g6Mxftdm2bFNWhuUoVwSP/T+iyxcyoGW/BIRyAjLaLcrm6L2ZskaZPo0Mxwa33XS6A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773202728; c=relaxed/simple;
	bh=dpcFdS3g2J/yoakrR8frMihJ5mkw4/drAscoot2Upns=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=UBS3atqh+cq+0Rz5022hUpS0DKDnJ/5WvrIHh/wE640riXOavTJmXZKGna3VEnKlaMvsD0yFAqLdEdNHPsbdyrwZLtVHjhnO/IET5VreguD8RGaUfxTLw5BQnPItveGb1aFgKp29OuzzL/S3t+jin82wizI++h5sIZcz8nK5GKE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=y65y9XKi; arc=fail smtp.client-ip=52.101.52.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="y65y9XKi"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=l/wKJAJoiN199jQuuI5W2l0EUWp0PKRrONtFjd+ybEcojj9EhYyUNP1OewqoQ05BRYrLwG6mLSjY7fWW20MXRAtaJgSxs30h1CkHa4I/VdtokZpUWQvxX/9dtUa37l3TqQExVpK9wISMqVP4Mm+/rPyVdLQBw13sF+p4rOtRcVojnw1+6nVmeztm415YEN0X/nZFRU8iTuP84kCvsHp7zxITJuyOhOZQ+bn8fMkvtiWRMS+bbo9QDwghiYy7J6oLTpVr6g5yb3LGa/2jtL079RoI0P5sM/eQ+9gTBP+OmskeYROSJRAI+nyf9FFNVKaVIQC5IbxdohBf1m+0zE8noQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gEQKkGsr5/Vs8FPUI0h4TAgRDsgyAN5jnZxSnyB6CTI=;
 b=PhlduzHG9xSVs/70efcdDgSsPySVDjaTn3oRdYh7+5bcoPnoefaRDZmnLbwiGA/AgJEL/Yw7z+qbV/xC3TCbilAnSUCVEPyPCoU6RwBZRA05d+aDuh1VDoVH1Uf6LisM7FJ0IEt1iyzvHc8MBP99DFRGnWPYFz1CEdImNNXuuuUxSWYV5KnAjjPSyR5nzDsgAwo4ygsdlwr4SYyTnLUz1B2bn6Wzya1aK2wT9MQy8yDusXipiCklpCpL5r3g+aeHfyVEPL+FQ9kdWEO587tpCYVteQkiM7c/LJE4VJDr2nKZZitSARLHp/nvb50RJROONTkz/VHj3vmSPtbIDqaAug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=google.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gEQKkGsr5/Vs8FPUI0h4TAgRDsgyAN5jnZxSnyB6CTI=;
 b=y65y9XKiKlocFpERXvKCjL0vM3uUq9mRi9Ij8xVVl6sQ2ucYVUgZYikfxVoiA4vNh0GXtr3vBcHG5YFrDExhlvhARDKstTAPH1bs7uzyFwCDvAYKlsHw9hIJYU4re+5LRmUZvDn4yKseXLj4J41maJK/Rt9ZfYJjEoi1urLQyH0=
Received: from PH0PR07CA0081.namprd07.prod.outlook.com (2603:10b6:510:f::26)
 by LV3PR12MB9330.namprd12.prod.outlook.com (2603:10b6:408:217::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.11; Wed, 11 Mar
 2026 04:18:43 +0000
Received: from SN1PEPF00036F3D.namprd05.prod.outlook.com
 (2603:10b6:510:f:cafe::1e) by PH0PR07CA0081.outlook.office365.com
 (2603:10b6:510:f::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9678.26 via Frontend Transport; Wed,
 11 Mar 2026 04:18:22 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SN1PEPF00036F3D.mail.protection.outlook.com (10.167.248.21) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9678.18 via Frontend Transport; Wed, 11 Mar 2026 04:18:42 +0000
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 10 Mar
 2026 23:18:42 -0500
Received: from [10.143.207.7] (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Tue, 10 Mar 2026 23:18:37 -0500
Message-ID: <b83bee03-5e7a-40ff-ab7d-c183bedb7373@amd.com>
Date: Wed, 11 Mar 2026 09:48:36 +0530
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/7] KVM: SVM: Initialize FRED VMCB fields
To: Sean Christopherson <seanjc@google.com>, Shivansh Dhiman
	<shivansh.dhiman@amd.com>
CC: <pbonzini@redhat.com>, <linux-kernel@vger.kernel.org>,
	<kvm@vger.kernel.org>, <tglx@linutronix.de>, <mingo@redhat.com>,
	<bp@alien8.de>, <dave.hansen@linux.intel.com>, <x86@kernel.org>,
	<hpa@zytor.com>, <xin@zytor.com>, <nikunj.dadhania@amd.com>,
	<santosh.shukla@amd.com>
References: <20260129063653.3553076-1-shivansh.dhiman@amd.com>
 <20260129063653.3553076-2-shivansh.dhiman@amd.com>
 <aauGTverUvkEJnPd@google.com> <7c5d0db9-5151-4edb-9b97-0f0b268cf36e@amd.com>
 <aa8YH4yzXAXGiL4k@google.com>
Content-Language: en-US
From: Shivansh Dhiman <shivansh.dhiman@amd.com>
In-Reply-To: <aa8YH4yzXAXGiL4k@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF00036F3D:EE_|LV3PR12MB9330:EE_
X-MS-Office365-Filtering-Correlation-Id: 7215dabd-e9e7-4380-ed81-08de7f2547db
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|82310400026|36860700016|1800799024|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	dhhtJfpk+u1nKJOogV6lhsy8lycM63jLF6w9Fx2uhqUA56CV5vhUIidvkoeW/5JNAC0JSPviKWay8hdSmAUvLDZk+HD91CsYj7d71yagsGwvXcjqJly2Z2GwVAifqzQi5ZBnuwEDIZdc5NUlPWlMElQf5Zvjddj8vRj2uKlB7KuRdii/0+YY1NIZQzo8uMkGMjoize3IosxQ2Q19hSLlQ1bozfdTqcJMy5//bq1rZ4o5OBEgqDD4SxylJZWEmKnFAQ/kJ3GjRUXdcWSoImVvkP/Gab/dAj4pLT47mcMh2gdLuYvZooNLvQlhDiI+h5zTI4ubzUv9WJYIdsieDwQRBQpr0gAbADA4iT7LQMA2J+zllFQZ6ssZN5LoUNRN4ZdV8BXcPmS/BnV4wrZthYKLjP8kHqUPB8LFj/pD+WrJgitBmwSDwA94k7lg46h1KIx4OVhI043xB5SzDPxeOEuWEnAWeO96nSDcnFkyTfwa6XivbwRrKGjtc9ydBRROGCriH37Rtdvf8fJY/9M54SH/Ja9Nks27dENLRuX7SH6q3ko9WxqUZ0KZstTwL0bG6dDAwj/ykqP8O6LwAhJhzPgMEzoViMPiHgP5gxRhgDqOiP5f+KGucruCxF5ybHQ6SH6YSi/yNZWE4uYdgDrTIGWWCNPtbg4pdsBMvipNzByKAPVqlQrRC/LKAV611K6P2/cyJh6AX2G4Q7pnX0JNytdBmSIn6Smt01ZPuQmFHJ3OlKs5qyMd4rj5z7Buy5dGLQKqToSGCU6vTrp9J94ixWttZQ==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(7416014)(82310400026)(36860700016)(1800799024)(56012099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	nLk7GMhxKD2FiJoAUCSJPgVQSWzj7oyT47jGUOZ05Q7afH+kuzjJ2swM04qxFggzaUMhElRWAYrAmnoYmV/8SrF9yCURmEQNnCB8LOvLMwJcPJTy/WyPwgR37h9pW0s3KSX0xqpmbjSNZzNvCruvak2L/zc1rTHTUGKUG/DIo9A9cvZPDY7z+H14Say+sttFsMB0dDb394DnMRMQ06+gLTfCP4sPz/tdZKJ5MOb/pIcvhsF+QGZHAjn9JCRs48K4KnVJws/DS2T87vJ0tOSVq41IuavlZCIb5oG+voCohPqvwAzXKbs+JRJ5U/UP83RbkqjrWKYkKAz3P0sbBqq7CCXPEHQY8a+tCX13rkGzLr3/xDIOTUNkJiRb8mk73kZ4zEW1/7HIHeEKb/atlipaqprgRH3m4OzCbjFD550QXSZPDzVQbpdzy3UNmnt2LSIb
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Mar 2026 04:18:42.8939
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7215dabd-e9e7-4380-ed81-08de7f2547db
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF00036F3D.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR12MB9330


On 10-03-2026 00:27, Sean Christopherson wrote:
>>>> +	save->fred_rsp0 = 0;
>>>> +	save->fred_rsp1 = 0;
>>>> +	save->fred_rsp2 = 0;
>>>> +	save->fred_rsp3 = 0;
>>>> +	save->fred_stklvls = 0;
>>>> +	save->fred_ssp1 = 0;
>>>> +	save->fred_ssp2 = 0;
>>>> +	save->fred_ssp3 = 0;
>>>> +	save->fred_config = 0;
>>>
>>> Is this architecturally correct?  I.e. are all the FRED MSRs zeroed on INIT?
>>
>> Yes that's right, the FRED MSRs are zeroed on init.
> 
> Please use that as the basis for the changelog.  "Ensure that a vCPU starts with
> a clean and valid FRED state on capable hardware" is largely meaningless because
> vCPU structures are zero-allocated.

Will do. Thanks for pointing out.

- Shivansh
