Received: from SN4PR2101CU001.outbound.protection.outlook.com (mail-southcentralusazon11012016.outbound.protection.outlook.com [40.93.195.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC7CDEEB3;
	Tue, 25 Aug 2026 05:31:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.195.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787635912; cv=fail; b=Zh6IW4GBGsiFj+jiEVyNaGQ2svvCzfusWMWFz50VQxVTHsc1SyCNWRra3JEQalw+7A0U7AIFsvPVBttLjGO4fFRmBTm5hzbk+7l/DDDkl5UxEaMx76w0EIP11NSCPRWkDNG+q8y7JDkTqKiFOfdojysWldjyGPaq3eZ0HnCGzoM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787635912; c=relaxed/simple;
	bh=k9XpU49YE9yM6XDAJenbZQvotzxIxpwnDJJou+m6mKA=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=YvPkjILhkV9tfhqOwMyzDn2k3XUa13mhWab/uMi9useJEvhj4PHz7dv+s5CKTcwfTY5pFSIhGTdoMvhWiwlpZnSTtx9yz10erj2Dxf/RmThGDWGM/Ib2z9aibYULVdVMwzypCVDc4VRHfxx068yFHEO5u3P+Pb0Bi0/9V7k2Uqo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=BMqSYqcB; arc=fail smtp.client-ip=40.93.195.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="BMqSYqcB"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mXgNnoY+OGoDatPyhHsd8B+6kwi2DUfZhTxNNJtW6DOLG2MzthtaN9iJlYECAsl71UpjtT173TUMCIRoypShbVFu+G+MZutsufTbjC9oaaZhM7LFY2k12PxgPEZKKq/WQXpYhTLJvnX40YaH2jzkj3gRR552Q7IPJW8oTc8XqjgsbDkScw9/4NhW86SF04Did9xJ9hF2CjAYlSUxOhmrfNIRgdN0T5MDGT70U9G8TShcTbabvh+zVs+e0M8xRW/1GgVAF75N1l/hHTmp81XG8xp1LiI5yvzmFYgFD33T5NVsRg0TghLOBskS2t4amCyS3Li6vw9m+jYQJZ/WvQBn0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BdgvTlcFWP6g7hPNoejHtX+U0NiZ6SdX+8oVtxlMzsY=;
 b=P41lJXXy+c9ItPQ7UdBGWgQO8xtkekf3NIpEQmWxraP2jnGvATqfxgbBzkTfRqb8utBEqseSr/Bm9zT3MuOBVA5/T6EBEk35nKv1tcMdKD+HMQjUvjpJTaTCuuI+dqfguDArGyo8ew5Pi9DPwNBNhhXYNw+eapVT2bpSY/LJ+E18fjzCbwHhC0QjEKCBE4iLgEEpuHKuDz7LmKWfXE1BK71bxfYr2We3lbN5eO0STNiGqDZhxDedJwAIfiQdJnJB5jYVZN1NMYzj6nNrsQklVSiA4ake4zJqWKAyJwXx9V/Y8TSvFyp3Tq3VXhXRU2SJgl9T3Tu7aVRXo+lDhQb3KA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 149.199.90.133) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com;
 dmarc=fail (p=quarantine sp=quarantine pct=100) action=quarantine
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BdgvTlcFWP6g7hPNoejHtX+U0NiZ6SdX+8oVtxlMzsY=;
 b=BMqSYqcBDmvDuZTEgRKrRItP5RuZbn+wwjK+c9ApFK9EyvSOYtotuHUiDOEM0DKABp+4rcFyLA2ETtJSuUDKmRFXh62c+iY1tvIbExMgmEPdFYJXD6Nc5eblpB42XovFEtOZN8Cr+TU5QL25E1zDs+GblYSy3o4qJuDn24Os44k=
Received: from BN0PR04CA0126.namprd04.prod.outlook.com (2603:10b6:408:ed::11)
 by PH7PR12MB8156.namprd12.prod.outlook.com (2603:10b6:510:2b5::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.12; Tue, 25 Aug
 2026 05:31:45 +0000
Received: from BN3PEPF00022BBD.namprd04.prod.outlook.com
 (2603:10b6:408:ed:cafe::b) by BN0PR04CA0126.outlook.office365.com
 (2603:10b6:408:ed::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.339.12 via Frontend Transport; Tue,
 25 Aug 2026 05:31:45 +0000
X-MS-Exchange-Authentication-Results: spf=softfail (sender IP is
 149.199.90.133) smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=quarantine header.from=amd.com;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 amd.com discourages use of 149.199.90.133 as permitted sender)
Received: from satlexmb08.amd.com (149.199.90.133) by
 BN3PEPF00022BBD.mail.protection.outlook.com (10.167.248.117) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.360.3 via Frontend Transport; Tue, 25 Aug 2026 05:31:44 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Tue, 25 Aug
 2026 00:31:44 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Tue, 25 Aug
 2026 00:31:43 -0500
Received: from [10.136.18.168] (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.45 via Frontend
 Transport; Tue, 25 Aug 2026 00:31:38 -0500
Message-ID: <894e34f4-5d57-40af-86d2-c167e44f81be@amd.com>
Date: Tue, 25 Aug 2026 11:01:38 +0530
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9 00/22] Enable FRED with KVM VMX
To: Sohil Mehta <sohil.mehta@intel.com>, "Xin Li (Intel)" <xin@zytor.com>,
	<linux-kernel@vger.kernel.org>, <kvm@vger.kernel.org>,
	<linux-doc@vger.kernel.org>
CC: <pbonzini@redhat.com>, <seanjc@google.com>, <corbet@lwn.net>,
	<tglx@linutronix.de>, <mingo@redhat.com>, <bp@alien8.de>,
	<dave.hansen@linux.intel.com>, <x86@kernel.org>, <hpa@zytor.com>,
	<luto@kernel.org>, <peterz@infradead.org>, <andrew.cooper3@citrix.com>,
	<chao.gao@intel.com>, <hch@infradead.org>, Shivansh Dhiman
	<shivansh.dhiman@amd.com>, "Dadhania, Nikunj" <nikunj.dadhania@amd.com>
References: <20251026201911.505204-1-xin@zytor.com>
 <930eccc8-23ca-44c8-b91d-3567708e317f@amd.com>
 <bed0bce4-1438-439a-9db3-79ac29467e5b@intel.com>
Content-Language: en-US
From: Shivansh Dhiman <shivansh.dhiman@amd.com>
In-Reply-To: <bed0bce4-1438-439a-9db3-79ac29467e5b@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF00022BBD:EE_|PH7PR12MB8156:EE_
X-MS-Office365-Filtering-Correlation-Id: 08e191a0-c29b-453d-a809-08df026a267b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|7416014|376014|23010399003|36860700016|1800799024|10067099003|4143699003|56012099006|11063799006|18002099003|22082099003|13003099007;
X-Microsoft-Antispam-Message-Info:
	D/u0tzaGg8+thtpEl4nLGAcN3kMq7wWjUWsychoD7aFUdonpNxfwsiFpjg6w2svM/hzauOnt5nlYUBLj2K6RfS3TTCZ15kanom4Wwb2v3/Qflsa/HXcoBZLKfmfxwmhW4uUZ/uCwhA6FIMpfeCFCqLyXKMt8xME5h+Bdf57cQogVBgmEcEg4IIBUJXNqCzQMD8AR/UNKnEbWEH48oRlDfyyHgdj9Uu2ycLm3i1gwTtZQuddK9IpAUDJfVhhED36uyw+i+B0+1oLT2k1Rp7ja1We3vrocmrtC2cj+3XYN6Jlj2oi+QFSBnlH7UPTTYJcYXyzNVBJ3ulp82xIJkJ7Ij51QbzvSQYesKrZGiRFLJn/yQmh6YlJo6zGx8doIBmI8jpBT9wbCVs/C2wXhjsqEkssQL/KB80GNdfspf9dmHkfd0MEhCy1hND9+LRYgzKsfeSMWB/hYVKQ3nUg5efGP3mth9MqSjkHKJQQ+mr6dNZ3Q4OXY89TRiaB1AsvWU0ocugDBD1f7qPOD6R1HIFa2We/SKlAOZqpozXeIUDsYxjPXHvlb9AKKAX7OvtwecudO/PMa/5ZiNbF6p6K+Ogy1XlFpNusFxw01RCIsvf0z0pyh8syfjPumb+Qm6VteozrL3qc4secvuSOF1FGVZIg5ACVKkY0Xg2DmjkeX3Nd+y/pE58ncnNBDOlUjwzpSvF3jycGPiXY536GyG8pPzIjttw==
X-Forefront-Antispam-Report:
	CIP:149.199.90.133;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb08.amd.com;PTR:unknown-90-133.xilinx.com;CAT:NONE;SFS:(13230040)(82310400026)(7416014)(376014)(23010399003)(36860700016)(1800799024)(10067099003)(4143699003)(56012099006)(11063799006)(18002099003)(22082099003)(13003099007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	KxCqxNmbAghCH1hnGWAZGys5Xbyll48WldDPK5AaOnUgJOh/5jt9zf6iN+iZSrWQiYILpG+YxHoUA1s5sjupSgCAGUtYzHiVB56XNvlHaDN0n2JRD14SxL21/sbqlQJPoSf3YGwRKBjiQT/6S6Xi8+zLSxj/YVrqzbUnUwYf8hr/YfrDGZaZJcewMIeNvsuI1Pp9+kjpad/RE8jk2neolKVODNjqYPhSNKn72piraX1z/sRIRTPNunKhoDyyWkMVnKj6XzG5zr7iGXc5Yj15i/sIKeyy8xaJt0uZnKmwi25pjUCx6HOhvuomwjct0rHEMbZ+48VSar7ZLPrAZHoVnQf1xI8hIgz46Fh5cZDYHZ1N68LFl6kEYaO1ucantstqLZ6tt2dDSrmeyJZETG8IW5jXrPDzUiqmMVsauICkXgZE/lb1AcSMGqFsyD6OJ9NG
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Aug 2026 05:31:44.3603
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 08e191a0-c29b-453d-a809-08df026a267b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[149.199.90.133];Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN3PEPF00022BBD.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB8156



On 25-08-26 04:01, Sohil Mehta wrote:
> [You don't often get email from sohil.mehta@intel.com. Learn why this is important at https://aka.ms/LearnAboutSenderIdentification ]
> 
> Hi Shivansh,
> 
> On 8/23/2026 11:21 PM, Shivansh Dhiman wrote:
> 
>> Any rough idea when v10 might go out? I'm about to post v3 of the SVM side
>> and would rather base it on your latest than on v9, so happy to wait if
>> it's close.
>>
> 
> I am planning to send the v10 patchset soon after the merge window
> closes. Recently, I received a set of updated patches from Xin
> (offlist). I am in the process of resolving some minor issues based on
> internal testing and AI reviews.
> 
> Barring any last minute hiccups, I am hoping to post the series around
> the 7.3-rc1/rc2 timeframe. If you want an early look, the
> work-in-progress patches are located at:
> https://github.com/sohilmeh/linux-dev/tree/fred-kvm-next.

Thanks Sohil for the update and the tree. The timeline works for me. I'll
hold v3 and post the SVM side rebased on top of v10 after you post.

Cheers,
Shivansh

> 
> Sohil
> 

