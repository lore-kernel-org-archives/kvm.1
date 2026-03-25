Received: from PH8PR06CU001.outbound.protection.outlook.com (mail-westus3azon11012054.outbound.protection.outlook.com [40.107.209.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6E742F8BF0;
	Wed, 25 Mar 2026 09:40:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.209.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774431603; cv=fail; b=S3iIjUFhwNJcD9+ZurT06/91ElJ1J9sU9HJuLiurRP8wI6z2GKxBtmnPgdQgERfV0B54vBmrqohPNdB1zW/IIk6xdeCE+gWE7jj6q8yzljJV2N51vzNycbnYTPITCM6lB6gxCus4dFQx2f2fSJzErgkHfhVL4HYbysc0MKi64oU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774431603; c=relaxed/simple;
	bh=0JlYPdzqKNxVAcv2UHUO/q1RQv3VjC6bBTi/539CJf4=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=B71RqHOQ61FbljSulsR9ifZrnfEus71unyGaESGWY5xVZ+nlp9WIUFjCvU2c6/Tdm+H0oXtjczPpH2vHcgxXwj3J2Tux/XyihzNv5hhQUlufN7DLiKqdllITvH1BnYgFuikV5QAUmO62f32PFe/YpKRhpfPTYPOyF2SqYwvfYz8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=NzCeP5GJ; arc=fail smtp.client-ip=40.107.209.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="NzCeP5GJ"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=q9wAHITRU6AQ7jGwqU3vItuOKcr0OKuIVz5ejBU8cu9q3BzjqjheXFkMElZzp3J33F639KjIYfsNqbAtyL0Ybb5392OtC/Qdw8ytOouB6ZaWurXAKMm64IBNfHpWP8YGhclglVg9fJvPhyQxklrW+sL1eN6cW0wEHhuSyXAGNc6Glc84KypZHQB2jNqSS8vt9XTuiE60ZoxZkhyh/79GYMyj5dS3dWhGnPGX/3zwsl8ygX8j4QSc991fjSnx2HebdXK5Ovl+P11zIWbYyoxW/ptJzhjAmit+iRqg1IWxjHAcPetLJtJg1nyrh9xFoSeWhE4H6p0CDIs21ODloDnbWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UkTPRLjGSoV8l595pakU20jGtisCJGf9AKbmtUIj5Ko=;
 b=RKfRgMWUC1NvcmRyt7wkErs1+UK4dZanSD+d2KeEVfyUeZGaZ1MlsagklHGiHJUQyt1h1B19gfvvy8TkNKc3IlJU40QDkj78WzGwfks0Kn1RnypSj9fALuS+OnM/rKIrDqp4+J08UaidUpPHJ/8jMNN3vtAyMtlmWRDNUFvgZalml00uQasAKASN4F1wFJfdDgqr1ZYP3bef3nlDsZxP8YFG6BtHZbp9ZDUNzDjYHzOQqO42Tul9nbTS+DxCCwuA/DkL1GuGCVvwSD4VKtU+no0nkkdHKewZkfKZjWD64hWBwS4yGFRM8pTAcDzTAcTHjtVZ6tR2uXlZh/Zso1eh5A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=redhat.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UkTPRLjGSoV8l595pakU20jGtisCJGf9AKbmtUIj5Ko=;
 b=NzCeP5GJIUJiYIRIiKLBsjUZSkNIpz0PMg3vC5Lv+kpBl6BbdsM1kN/VLcWMert47tMCWH3ytFtyiDxOrdmzekYpheZRbxYbhqEvpoA88clqqbKcmj2OO5nxRFh+tv0E/XCEBb2QJCYIbxWjRm4MZb3raIOmCXU38A3ySUCmIuM=
Received: from DS7PR06CA0017.namprd06.prod.outlook.com (2603:10b6:8:2a::24) by
 CH2PR12MB9543.namprd12.prod.outlook.com (2603:10b6:610:27f::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.19; Wed, 25 Mar
 2026 09:39:57 +0000
Received: from CY4PEPF0000EDD2.namprd03.prod.outlook.com
 (2603:10b6:8:2a:cafe::1b) by DS7PR06CA0017.outlook.office365.com
 (2603:10b6:8:2a::24) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9723.32 via Frontend Transport; Wed,
 25 Mar 2026 09:39:53 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 CY4PEPF0000EDD2.mail.protection.outlook.com (10.167.241.198) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9745.21 via Frontend Transport; Wed, 25 Mar 2026 09:39:55 +0000
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 25 Mar
 2026 04:39:55 -0500
Received: from [10.143.206.35] (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Wed, 25 Mar 2026 04:39:52 -0500
Message-ID: <e9c64748-7d72-46a9-be95-6003160ec06a@amd.com>
Date: Wed, 25 Mar 2026 15:09:51 +0530
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 20/22] KVM: SVM: enable GMET and set it in MMU role
To: Paolo Bonzini <pbonzini@redhat.com>
CC: <linux-kernel@vger.kernel.org>, <kvm@vger.kernel.org>, Jon Kohler
	<jon@nutanix.com>, Marcelo Tosatti <mtosatti@redhat.com>, Amit Shah
	<amit.shah@amd.com>, Sean Christopherson <seanjc@google.com>
References: <20260321000931.1947084-1-pbonzini@redhat.com>
 <20260321000931.1947084-21-pbonzini@redhat.com>
 <ca466041-18e6-4935-aa0e-8c1501e120df@amd.com>
 <CABgObfYL5T1K6VUQPjor+G-GjOoKGaGS6rcX0wriOa27ipG51w@mail.gmail.com>
Content-Language: en-US
From: "Nikunj A. Dadhania" <nikunj@amd.com>
In-Reply-To: <CABgObfYL5T1K6VUQPjor+G-GjOoKGaGS6rcX0wriOa27ipG51w@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EDD2:EE_|CH2PR12MB9543:EE_
X-MS-Office365-Filtering-Correlation-Id: f0a92415-f5d1-4961-ae1e-08de8a52790e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|36860700016|82310400026|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	OLQNiGWo2RfJzcy5SCqHCyW37lRVoYTBrMP7glX+3JLJuR/n31p/tsZkYZ/U99jgWcoDg2Q1XMlOlpVe9m3LpDnzyRX3pHFJOLMK8H/9pUkq5JyeAzrSs39Ya9/1z8sFxqlhnaPhMj5LYkAIIcTcZOvwhqEKFBCcLrwBB3e7JeqhM8+pkOknSvOj1u/qVlZZ1JBdQ5KXbIlNca2A4M1Ncx4znq67N9KOIqsSpii0jKzq0B1keQOzD7QRPTG2zRuOvugCJh4/fiLLrgoo/ZKxU8GEp81qg6Rseqq1KKwdnzniwSMg2DrgbmNGg04V7ga+Eao+GiE6GgDrUokFk/3LNht0RxhmPC3xtHwPjFaK9GsFSx28KRycNhboGLIijl713HU19yGWgYtYeQiOOWXxYRoJI5GmbjRVkS+J3VhrNeCvu0eGmDnh+5l01EBX6tDIww0TYJpZJd0NgszmXiTsPRKT0usvLNXjjjESblHC8s7CUTibLeAO4sUvACy86J/3BJKoO4L/ptdl12BpPuQYaQaah4lBYzqHlp42Lk9ZEO3/Hfy2SLr4/NX9ay5d/uBceCNcqVnKgY5irGNfkjcd4skwaJGSm230cteKNfQZ7sLpD4kG1amad4WLpXf4uWFMgV7hmRPtXBghZL1uLUMUpyC/8xjETlYD3LLuDo6kX6a8bcuWTvuT6ZegaOoFk7RtAukewJjG7QTZahd2M1e7OWeo/1MfT9Ys2H+NJbvlt9EFdrxyDHDz5FLbk/5sdqFYdxAUgzOKRj9hITCcz0pZrA==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb08.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(1800799024)(36860700016)(82310400026)(56012099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	PKaWc5zKjLjf5aD9nbqoEaxwL3LZBZAzHAor7PvUVlKPB+fw2UuaKLOzHyXn+iXg7OJNGVets7Mn52+IbLP42j2XP+YXxiH+z1v6vhuEmtCx2S3dEpeoTc7IMASazrUFxHy1K8Qtzmfuc4ltsL/8yuIZiPHsA6ddIDgFITTsRyNiFgIPl9JfFv54Avn0cvf18awUlGLFrLhpJmecTNiW1637Kl/H9AgCUBUG7XRnMyb1rsoQpVjujJMpzF/tbi5fxomdZ337ebXyKYxpW6K536DcDqiFNXFQigja5KmPNeObEs4vVIBHj2CP/XtEkydlkB5FfKvLoqtt248oI12OojpW16cFggAGeW3hQ69nQiMjisG7+pRXpyhc+oTQOFU8pjohKyJ4Ib8BekY2TC2UJ7TPRa88q8eR4aCK9KtOUJbbi/qtQVs/TXNs8dChYJy2
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Mar 2026 09:39:55.5226
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f0a92415-f5d1-4961-ae1e-08de8a52790e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000EDD2.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB9543



On 3/25/2026 2:59 PM, Paolo Bonzini wrote:
> On Wed, Mar 25, 2026 at 10:26 AM Nikunj A. Dadhania <nikunj@amd.com> wrote:
>>
>>
>>
>> On 3/21/2026 5:39 AM, Paolo Bonzini wrote:
>>> @@ -1184,6 +1187,10 @@ static void init_vmcb(struct kvm_vcpu *vcpu)
>>>               save->g_pat = vcpu->arch.pat;
>>>               save->cr3 = 0;
>>>       }
>>> +
>>> + if (gmet_enabled)
>>
>> if (gmet_enabled && guest_cpu_cap_has(vcpu, X86_FEATURE_GMET))
> 
> No, this is the non-nested case (vmcb01) and I'm enabling GMET on
> purpose for easier testing.

Win11 guest with memory isolation stops booting after this patch. Boots if I pass gmet=0.

> 
> guest_cpu_cap_has(GMET) only matters for nested guests and is added by patch 22:
> 
>         vmcb02->control.nested_ctl &= ~SVM_NESTED_CTL_GMET_ENABLE;
>         if (guest_cpu_cap_has(vcpu, X86_FEATURE_GMET))
>              vmcb02->control.nested_ctl |=
>                  (svm->nested.ctl.nested_ctl & SVM_NESTED_CTL_GMET_ENABLE);

Right, I noticed that.

Regards
Nikunj
