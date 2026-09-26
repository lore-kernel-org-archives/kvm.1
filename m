Received: from DM1PR04CU001.outbound.protection.outlook.com (mail-centralusazon11010070.outbound.protection.outlook.com [52.101.61.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 446AA217723;
	Sat, 26 Sep 2026 02:15:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.61.70
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790388949; cv=fail; b=fXr4H7rAAcJvpVa+LobnooYxr+LggB93A/kiqaw522G8Kjqng146ljqX/7cUJkTYwEaUWBpqUtmVFG9A7PSTO+abhv5hXt4r2KyEdDmMxJvbMdKJIn/zqpeBTE5Ne/Zgc57b4OOV++ckSlKnz3lMDLXozB1jMmu5s+oRR+IBmI4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790388949; c=relaxed/simple;
	bh=YlZI1wxjIQIJf0VRu+Ak1rxaNHhTM0wuyokx1nUzSKE=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=aMFXEW8EVYpmJMAe2Dxc292D35xuClhs8jLVDLC3SrHgMyVxN4jtFszPkVRdCU8MNdQxmsXzYBuEM4DbpAqAbXhnwhAtW12k4L8orV5vbHjQMQt4eEhE2+XP6ku2nDmnDqxjeX99hiTz8hYTDUARdk/kIzazUsnaCTV8XsoNznc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=BNp1KEfl; arc=fail smtp.client-ip=52.101.61.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="BNp1KEfl"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pIeEz1cVZJ0RR57oES5EoZ4U81VnpgnsEegluEvVRO598Q2wdWs93Bedd2AJMThaKhQluF7RIAfQSmxNxdju48oRfc7rLTaPaBzvvYUvl/1oflttf+r4zhfdbe8C4G1KmEiUoor/lBIH2KmVyvdyLoEdD0zYCGBzjCfTFZVPTjPZSg/MZGfvMYiwCJKVel4J6lHQXwEmBjO4j3fOrr1ebrh0kd5YP/b/6TLp2PkNi9JHN+Iwp70Rq7aB45JzB1/umbxPaJrt+ZenLfJaWOED0IpthXExnmeoP40n6NCCqjykZyhe2wzVPes+WeVbZctMX4wCrVxTkvEI7RSHhyntXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0UjugWSf+gQvFKdqZCuoCUY1pkhgaK+5KpuH47rwndY=;
 b=rxqUOms7tOByG7cE/IUCkS1eCQ5GYBG+4ukGIvB679CnIl1AHbKkPp0Xy9Rlfa3AVNStXwaGOLZXFODm+ZqqIvD+KmCrbbDEeYK6Wpu43YPdAib2p7e77L1rgyBfqI0OifJkwaeHAwvn4m74M7eWIoEfUTnwmw+KysVfhPbm4n5U8T7ZnHoPlcY8OJAf9LYWFYLZM9Djtp/0Jneefb9EqtK4WFGrBYRw2568aGjXgIuRYQNgLAW40dhm3+rOpVYVsBwM6GVSOaV/x90LSPNLiWhK3w/NsL34EkXidV6/zj+cPxTGIDWPDor3apr5ChGCS9463m0pD+ejyNHk0q+pAA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0UjugWSf+gQvFKdqZCuoCUY1pkhgaK+5KpuH47rwndY=;
 b=BNp1KEflcILNTOaLMgBZShudPduQ1crDghCmoPU2WaCqaXkBP2bHdofDdUWBTgsW6E+oZkF3wyYnR6SCM2yDhnra8aY8IUt0pGntVDK0I+r5O/P/8tREahJ52yLAXDmQVPTU4VBTJpe0uCNDBIF4aa6NFNdAbeMxend/OxnCuPo=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS0PR12MB6655.namprd12.prod.outlook.com (2603:10b6:8:d0::12) by
 DS3PR12MB999241.namprd12.prod.outlook.com (2603:10b6:8:38e::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.19; Sat, 26 Sep
 2026 02:14:56 +0000
Received: from DS0PR12MB6655.namprd12.prod.outlook.com
 ([fe80::cca7:d50e:86e3:24fb]) by DS0PR12MB6655.namprd12.prod.outlook.com
 ([fe80::cca7:d50e:86e3:24fb%7]) with mapi id 15.21.0451.014; Sat, 26 Sep 2026
 02:14:55 +0000
Message-ID: <4cf2033d-0819-4b71-ba42-d9c3201f3856@amd.com>
Date: Fri, 25 Sep 2026 21:14:52 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 1/8] x86/bugs: Allow forcing Automatic IBRS with SNP
 active using spectre_v2=eibrs
To: Borislav Petkov <bp@alien8.de>
Cc: linux-kernel@vger.kernel.org, x86@kernel.org, linux-coco@lists.linux.dev,
 kvm@vger.kernel.org, Sean Christopherson <seanjc@google.com>,
 Paolo Bonzini <pbonzini@redhat.com>, K Prateek Nayak
 <kprateek.nayak@amd.com>, Nikunj A Dadhania <nikunj@amd.com>,
 Tom Lendacky <thomas.lendacky@amd.com>, Michael Roth <michael.roth@amd.com>,
 Naveen Rao <naveen.rao@amd.com>, David Kaplan <david.kaplan@amd.com>,
 Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
 Dave Hansen <dave.hansen@linux.intel.com>,
 Nathan Fontenot <nathan.fontenot@amd.com>
References: <20260826223510.3669875-1-kim.phillips@amd.com>
 <20260826223510.3669875-2-kim.phillips@amd.com>
 <20260903040330.GNapjxkgMd2Ey38egR@fat_crate.local>
 <01b57e61-df45-44a6-848b-c19eae226ad0@amd.com>
 <20260924014517.GEarSArVM12m_ZshhA@fat_crate.local>
 <67fb182c-4baa-4b3e-b59c-64cec20839c2@amd.com>
 <20260925164748.GAaraltFwtJs59WAsj@fat_crate.local>
Content-Language: en-US
From: Kim Phillips <kim.phillips@amd.com>
In-Reply-To: <20260925164748.GAaraltFwtJs59WAsj@fat_crate.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BL1P221CA0040.NAMP221.PROD.OUTLOOK.COM
 (2603:10b6:208:5b5::15) To DS0PR12MB6655.namprd12.prod.outlook.com
 (2603:10b6:8:d0::12)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB6655:EE_|DS3PR12MB999241:EE_
X-MS-Office365-Filtering-Correlation-Id: 2db22f80-0fa2-4736-c797-08df1b73f4f6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|23010399003|376014|1800799024|10067099003|11063799006|56012099006|4143699003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	MLjuGnVb8aiAy8dcjBoC3zFpiMPIXXGJ+HBHwlIZGeGQCZmp8g66sx6FMXpyDtG4kMuAFSN+Igqcp7b6q2o4NaeTQeeDYRB332r9CznnHgTVRnwQqUtCOycPbbBGu4c0N2hrz5rJRgKuzjuFFhy/Qr5HvWJTNapVT/eAN6bdkRbkz5oiWGnhvMOylLkdZbn2o0VJuLvgvJFzNyfzmpKBwAowfF/W9/JkjQbOpIelv2dCpPK6MF3/8elqFvsfFhCawBOm2QSDvELkH1pXg7pawfp4AMvwKYnqmzv3kGL+bG7jWnuXaQmJqD5A37isxo5UDmgatvWKSOgp/0l311wu7OjHtn7Er3KVhJMml+1DUiQtVBfU/t6qxy5MyVZP1gD5wWs3DWB6NvLy17yxoTKPpke+FLIjQQ/uS/0NGwpujG+PuTzdEgzVHS9lw+PeK9RwpJzmlYTl0m0k+lCtqBgi9zoZWubEoWVSVKZjpkL8VpWkHHeqHOqw/fQUjHnfajSOKz8sR8ka5s+QXWpaMRYMYLD6hS3jG3Et1au/A6QsOT33R05x1pyxG3ahU9II8q/9jJKTneMWSEiZyYaEgFI5eDNA4NTQ/dxs+d2MzbgdqfHKU1KX1wdEXtmPorz4DZMBPIGYKNXukuS4F+wQhQeNG054erek9/IkaiRe9r/GWls=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB6655.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(23010399003)(376014)(1800799024)(10067099003)(11063799006)(56012099006)(4143699003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Q3RSQVZZaitEV2NHUnhna1V3NWRjOHNNSUpUa2ZxVW5PV2grTm1Od0hrb3JG?=
 =?utf-8?B?aTlCUXZ2V3hVNnBESG1SNEg5NStZTTF2MlRSTXNXb1hrVmxlVEx6TFRoQkYr?=
 =?utf-8?B?SGR4MS83N1cyRzFaTUxWSmx0a3phR21tdEJna0tCN25xSkFrVTc5RytuOEs3?=
 =?utf-8?B?OHVaL2hFVHZMZ29BdFdZcjdIV3BIVFoxL3QzMEhraXJtUDFXNFhBcUQvUWJD?=
 =?utf-8?B?TkJUT3UrckxQeDVaWDN1RTN0ZGEzcnhWeCtzQk0yQVZjRUIvRHI5OVpOZmVO?=
 =?utf-8?B?RUtXYzBiUXBGdHViNUc4bE1PWlhIRDYzL3pLSUx1OHpBZlhRU20vc2FZekZP?=
 =?utf-8?B?Zi9LQ0EvM3FGaHBtdEdxaldKUjRmRzhodHRsVGVwcVNLd3I2MGhMdlpwM3Ny?=
 =?utf-8?B?NGRXRkovWFhuRkFYa2dQUWIwWGlYZnlGWU5jcnNzWEJhVmFJTTcwS0xjdUhi?=
 =?utf-8?B?TmthK0FKWWJhRGZ1NEszcTVLdXJzbnJiV2R3V2FHVkhwRjc2T1RGOEsvaGRh?=
 =?utf-8?B?S29PZ3pIa2JkQy9XZWIxeGt1MlduMnJQTks1ME40VC9GZTg5VjFETEZXNEFM?=
 =?utf-8?B?NmpibktTOXlkR24zd2F0UlZiV1FlMTFaRzN0bG8xMWpKeG5jUGNKc3ZYVmln?=
 =?utf-8?B?empaQjdaSWNHTDgvcnUxRWVkK0cya2xSenloV3BISVZFcUR1TmpCSXdCbFZY?=
 =?utf-8?B?T3B0aGdPb3NSQUFPc3JOcmtQY0YwMkxQYmYyVFE1Nm5ORDR1YmF3TkVuNVhU?=
 =?utf-8?B?MTBrVEgzc0pxc3ZKQ0V0cm9sQ3BhdWlidGk2NThSOEtOOU80dGJYcUQzcFJ5?=
 =?utf-8?B?VmIxaU9rbUJSc0FQc0lzbTIzTE82Nk9jR0diV0RjY0FxenRWNUw2S0JCSGM3?=
 =?utf-8?B?OTI4T0o2ZDdTajQvS2dYY1V4aVd0NEl2UlFUYVR4TUtleDhLZnNZa1NUQmlp?=
 =?utf-8?B?MDNkdHdVZFFaR3l3WWxUMGFoQzZNRUFsVEozd2VXcjl5MmlaUFJIdnBXYXFD?=
 =?utf-8?B?NnFZZzJUN1JFN1Y1KzY1NDAweFJlN0tzQmVBQkxVV1h2Um9wQ2V6Vk1GUEY1?=
 =?utf-8?B?Mm5BbkgxTmpkRjJwMGh1QTAvMmRYVEJoREpzZmlDU1RHRXZUTTlkRGpiSWZH?=
 =?utf-8?B?TmVDOFlnUXBRM2hvMjFVTlVJYnpLWEh6ZXlTUlltZ0ZoVkJKcUJCV2pUcVpz?=
 =?utf-8?B?Z1c1eUVGOEV6YXZhNG9FYlBrSGE1Ly9QMVFZVXo4UVhoenhZVjh4djhQMk9L?=
 =?utf-8?B?WWd3VDh3NEM3eTh2Yis1OFFIUGVUYytYVUFOSFV4emZ4RzU2RnROZmVxUEV2?=
 =?utf-8?B?dlpkRzdYQkl1Um1KMWcrZFYxVlRTMEM5M3cvcytSQnl5b0t2SlRVYnE3YU43?=
 =?utf-8?B?VVNLN3NCbnhmaVhMNUQvR2wvVlMxQUJLblJwZHZjLzlzbExOZ2VhWUNibFN5?=
 =?utf-8?B?bnp0RDArWXc3LzMxU0hxTlFsMGJlZVRmYm0xZ3RDdnJQWUt3VzdicGVSekFL?=
 =?utf-8?B?eWhUSU4ycUs5Rk1SS081SXl4UFBLajd6dk42azljMUhRY1pGOC8vRVRGVFZq?=
 =?utf-8?B?amxMa004Z2dzVmFrdFBJcDZYOXVtL0Zyc0hIKy9INm1oUERHQm5BOFdHZVVa?=
 =?utf-8?B?RGlSRWIza3BIeHhjalJTcGFpYVUxTGF0ZWd1d3N3WW9PcERkdmlKUHlNZkhX?=
 =?utf-8?B?b2tRNk9qanJvTkpxN0Q3TWM1QTZmR1RYWnl2MmhIR1V5NTlLZTM1RzJkNjRR?=
 =?utf-8?B?STNmU0VKQUY1aGNKd1RuRTlaWnJURlJOUU52R1dIZjk2TVRIYnZZQ3FlWTFa?=
 =?utf-8?B?VDcwVFhZWkxaOGV6KzYvZU5ibzYyTytmeXo2eXo2ZTdyZU9JY25LREJycGh3?=
 =?utf-8?B?b2ZxcVI4QS93VDVnbjFETy9PbWRIYTVGQjExeHM5bTZ2dGRnRmZrRFhBVEJP?=
 =?utf-8?B?dXRubU1VajhSaTZHWUk4T1NsQVhpSUN4akFTTVM3cXNMVS9oSFc1aHBWdVFX?=
 =?utf-8?B?a01DUGg3aGR4UDdRL0FBcXZ5R2EwQ0llbE9yYngrSlFnbisxcmVHYmp2eU1u?=
 =?utf-8?B?eTBaNk9ERVNPT2ZmUFZacHJrOS8zaklmWEgrWDVlMEtWVFYvSkgrRnU1S3N1?=
 =?utf-8?B?UnhsY0EwVi9WQXlEVzZkbWFEck5vdGhLWVBYeFRTOG4xMUVrOWtIb1YzMGZm?=
 =?utf-8?B?S2RoY2dqU1lYRmU4Uk5tQy84aTJweFd2MWRMejd5QnF2YWg2SXpiOFpZU3lE?=
 =?utf-8?B?QVVDSFFjdlhDTlZoRHVudDhKdGNyVGQrQVhqd1dyZVNEOTAyZHljQmQyUVRy?=
 =?utf-8?B?a080L0FEMlR1eEhOdDM4UDd0L3hMRjVnRG5ad1ZBQVlmaFh4NXdxQT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2db22f80-0fa2-4736-c797-08df1b73f4f6
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB6655.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Sep 2026 02:14:55.6741
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6Qmkk5VevONm8XCds5zu7xrSGgiy3iABcZJ7ftM/dK/B62MAkUNllCFNsat62aBvlIfh7ORk+dzRBZt4MNuVug==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS3PR12MB999241

On 9/25/26 11:47 AM, Borislav Petkov wrote:
> On Thu, Sep 24, 2026 at 01:45:52PM -0500, Kim Phillips wrote:
>> For a guest-dominated host that trade plausibly goes the other way, and only
>> the admin knows their deployment.
> 
> Just holding down the current arguments here *without* AI:
> 
> We have had an internal discussion in the past about this already. It can
> potentially cause performance disadvantages in certain scenarios.
> 
> If this is ever going to go anywhere, I would like to see:
> 
> - a proper use case which people are *actually* asking for
> 
> - have it properly documented in Documentation/admin-guide/hw-vuln/ along with
>    the potential impact so that people can make an *informed* decision whether
>    they really want it
This patch can be dropped for now then.

Please continue your review on patch 2/8.

Thanks,

Kim
