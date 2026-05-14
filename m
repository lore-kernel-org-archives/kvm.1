Received: from SA9PR02CU001.outbound.protection.outlook.com (mail-southcentralusazon11013003.outbound.protection.outlook.com [40.93.196.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D979282F35
	for <kvm@vger.kernel.org>; Thu, 14 May 2026 04:14:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.196.3
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778732089; cv=fail; b=A4M4gcpqrrUIjIoCnRIVBbFrvEHyYCgQzU20qPKkv0ww74rCT4z14moODmRSihxZL7TbxGaj3oR3j9KwGIY/NK20rmU8hrB1xJQybdKqaGYOEv6BupZPVkJ+NLol0I5g6Yv9g9nzMGn0i0nSR2eJXDXcyBexDx7WbeWpieW4lJw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778732089; c=relaxed/simple;
	bh=ZhcKFcvNHqmy8xlKBhjLur7lGzDdhXxXtiLuMREgKqI=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=sPhQjfy9rLWelmUK5I2PS+uDtzRpZmxg9WJr4KATIJzWc7R8A4h1pMUTYqDf20hBZMq/B1ZfzQBsZ4dIUcdisGP/Sp1DIoE6jdrQXaltfKgj1e5cMTSmlsWpv1MXbuR053SzWB0v5MugDOmB0awgrmullgy0GA4VeMpRuhEg9ww=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=pE5oNNcE; arc=fail smtp.client-ip=40.93.196.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="pE5oNNcE"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KsHUVXwyWKfj3DiYLi6AxjTE0ooNhXxtCTIPOwTKAvcXN6U3Kb5IkE3TVo1pMUEQat6qDor0X96b1BvN4PrF6aTfaFgJEBMEfY4UDrnz/PhUXLCflwFzh5QOrAvPDKAd2u4rjH1JIpVtZdPZPU+zNxHnbdMTiwOOriDwuQlHJCWP0RUbV2p0zC9VTUHBrJ2Xu2zivVib9Nxa4zkaeNRW6fkCiGpNTcR9qtv1Ao/8IZZq4bFhQ4o8pS+4Wy88GrsSZZz2ozc62/enB7V9okpKH32Lk2hC8xf0xk0+i7zUgiSWh11ainZnVVG0t7JKhenMKtkq/ITfAstXGNOLo+Jpbw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=THRZ5NJ4Y/UuzV/qmthz0w9S1dZd6ZZWM3bKLQj/GFk=;
 b=dQSwngHIhPRrY/el56JGJW48vTROtbJClgCB/ncNyEGwhkKr4eT2FSpDoFvpKWHh2D31tEE7m3vB/4mmfP6f11aXgLHeKQ4iYJbsAntQXtnSCVpU7trpnKBLKjIzzWrdQGU5/BugOAG7xNOWuv7NwuLnPco7/CV4APZVpMZKO0oZkFngcMoa3TgT0d6HrU3HHx3gbw/S9bDV4ozp1z5MMF9nrFjKJT0y5sz8xjPodrZH3OHHBm0xcJc0TmpFXZDWwpdZDwQE+SOVgWnVE+Azy8Op5wVAI+Lk4A9Lpyi1TAli22TiumkW0BpKQy2aKvTG75b7/hTP/fbgKYTI0faygA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=google.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=THRZ5NJ4Y/UuzV/qmthz0w9S1dZd6ZZWM3bKLQj/GFk=;
 b=pE5oNNcEgVowk9j8uzhsAB5aekgQznKFfW8dpTVwNrO3cR4CHkDH+Twg3VflZ9xhRdlyMs29EVksb59Qp4B0S0aQI/KyFvs1GUHdN2Sad0KKvMyIseAlzmxlseR8XKrVfwt7cRkPuHe++kRGLbOcSM4WAebM/Dc4J3Huxi6JHBM=
Received: from MN0PR02CA0005.namprd02.prod.outlook.com (2603:10b6:208:530::26)
 by DS0PR12MB9399.namprd12.prod.outlook.com (2603:10b6:8:1b8::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9913.11; Thu, 14 May
 2026 04:14:44 +0000
Received: from BN3PEPF0000B06B.namprd21.prod.outlook.com
 (2603:10b6:208:530:cafe::9b) by MN0PR02CA0005.outlook.office365.com
 (2603:10b6:208:530::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.25.18 via Frontend Transport; Thu, 14
 May 2026 04:14:44 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN3PEPF0000B06B.mail.protection.outlook.com (10.167.243.70) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.48.3 via Frontend Transport; Thu, 14 May 2026 04:14:43 +0000
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Wed, 13 May
 2026 23:14:43 -0500
Received: from [10.85.45.10] (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.41 via Frontend
 Transport; Wed, 13 May 2026 23:14:41 -0500
Message-ID: <2f86d83c-e727-4be0-82ee-9a76e77c4ab6@amd.com>
Date: Thu, 14 May 2026 09:44:40 +0530
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 7/7] KVM: SVM: Add Page modification logging support
To: Sean Christopherson <seanjc@google.com>, Tom Lendacky
	<thomas.lendacky@amd.com>
CC: Kai Huang <kai.huang@intel.com>, "kvm@vger.kernel.org"
	<kvm@vger.kernel.org>, "pbonzini@redhat.com" <pbonzini@redhat.com>,
	"joao.m.martins@oracle.com" <joao.m.martins@oracle.com>, "bp@alien8.de"
	<bp@alien8.de>
References: <20260407063245.2755579-1-nikunj@amd.com>
 <20260407063245.2755579-8-nikunj@amd.com>
 <34cfe5e8-756a-435a-a73d-54bf69801161@amd.com> <aeeS7LDPJ6NCy3Uw@google.com>
 <3e4641288d7791919abf1a5b02b80431285484e5.camel@intel.com>
 <aegWmKk8uK5r10dM@google.com>
 <977e805339a29ab789650aa18cd320dd1e9e0c25.camel@intel.com>
 <aejLG_w8H16EifMj@google.com> <6688fe2e-c723-404a-80e1-3f4c5f5cc4c6@amd.com>
 <cba2b1d2-f361-41b0-9990-af840f6e0726@amd.com> <ae_EBMJVuNA8PaW5@google.com>
Content-Language: en-US
From: "Nikunj A. Dadhania" <nikunj@amd.com>
In-Reply-To: <ae_EBMJVuNA8PaW5@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B06B:EE_|DS0PR12MB9399:EE_
X-MS-Office365-Filtering-Correlation-Id: 48ac1304-3a41-49e6-f2a7-08deb16f53e1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|1800799024|82310400026|376014|56012099003|11063799003|18002099003|22082099003|4143699003;
X-Microsoft-Antispam-Message-Info:
	+jNAipn9RqjDAhdcixQyhCk3pYQhnosnfJX/k+2sYWKEN6gJWVJkUY/rWUIPFbbMvj92xX2M2E5lSQ2kOAUBov1zm2SMWdPKw66tqm06Kdr/E4c8GyVQXFSBAv8PlTk6JEqy3i58ZDlmwqRWqWtK1lGYoaOiPMsrKkaMlUJnc8oeFf0r+81sPnGpKM4FOySCYmWlaJDe4V7J0QNNiV1jSwZPm0YD1WYXIkgPlQeQ7iv7fpyp0Y0cwqUnNFWZTYlskbs0A3a61cwzaDXyAEui1ddOqJljOfK7++9yyJOteceVKsbATLA43uuc9GY7Fq7gwnZ8fBPyNxwMv/vQuJ9EGR4gPBtWLTYl2JnThJ/FQjc99KOfe8z3yNHzB3K+ZJTlRaF18kzjDdbcn9T+6SlW5yG4a8SOFMXSmdBUGeZVZC9/BguftsA3A0GfcybSvzAp8zKXQPjvLLcPxy7G3ETcht0rVUDVjwfzId6OyHEafhlm31jLhtM6oHjmk+O663X0bYl2qUZtM3IwnfpDcdxZLedo4dL/YSGH+MWXwEXVBMgGmen4cv217Tro2MIj+rt+gEx/qurptN6IIotQqxkOPhecAtug1h9uKYb0JkkBcypwUF8Pl4/3rmoSpw4GU/sCVxt7JD60k67cT06P6jgKWgnPdrf+DEOKIoA+A6e8suSbFbR7jf5sWTP1y8sZq0Tl8FoNVoQRy1KoHcpbMxmgi908mSNbN5Hij5bTYXmJkg4=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700016)(1800799024)(82310400026)(376014)(56012099003)(11063799003)(18002099003)(22082099003)(4143699003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	Hgl0p1pnog+ZC7mkq6XPplmu/GDtGWdYEY62kM7Kbrx4UOLoYD/gVGGVPGlTBBFTS0IHuYUprKrae+stbGix1db73V4ARdXIjxvINsZDunfnOotXByljg2j2gJCQJW0GcezsxNrINIuLbxjN4U7FluRtw/g20J2ej5ZdUapMT4mftOwsQsox1Yw7PioBtKdIsuWOQKPcIe/Ge1tdAbAFHRa9bvq9ntVxIxF11ULGH5/mDrsnjELTxLFyl1h+/WR5q9d7EVaiJeH17VtjKs+67LWhYC9HL9cSErQ6UXdltITYh+j/IwWkWBUUiJAFWYFZrP//DA5gcgKHoxV6w/UX+HgIQuHhQ2VVj+lWabidQeh7vz6eu/PqpirQhaNkCnJv/vIQTA6Qi0VNNnozhsakrkER3T1ySF1ikD4VCCrIGWMvQld4jj2+PQ0JlYxV1YGL
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 May 2026 04:14:43.9582
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 48ac1304-3a41-49e6-f2a7-08deb16f53e1
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN3PEPF0000B06B.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB9399



On 4/28/2026 1:46 AM, Sean Christopherson wrote:
> On Sat, Apr 25, 2026, Tom Lendacky wrote:
>> On 4/24/26 11:25, Tom Lendacky wrote:
>>>> Now, maybe the APM is trying to say only the save area is undefined, in which
>>>> case PML Index is fine and can and should be left alone.  But if that's the case,
>>>> the APM needs to be updated to make explicitly clear what fields in the VMCS are
>>>> and are not valid after SHUTDOWN.
>>>
>>> I'm checking to see if I can get clarification on this.
>>
>> PML_INDEX will be valid even when a SHUTDOWN is intercepted. I'm working
>> to see if we can update the APM to identify what would be valid and what
>> wouldn't be in this situation.
>>
>> For a triple-fault SHUTDOWN, the saved x86 state could be inconsistent
>> because the CPU stopped in the middle of a sequence and redirected to
>> shutdown. Everything will be saved, but it might not be valid x86 state.
> 
> Yeah, I assumed that the APM wording was an overly-broad description of why guest
> state would be garbage.
> 
>> The question then becomes are there fields within the VMCB control area
>> that are based on x86 state that might not be valid (e.g. V_IRQ or nRIP,
>> etc.).
> 
> FWIW, even a conservative iset of "these fields/areas are guaranteed to be sane
> and consistent" would be super helpful.  The big problem right now is that the
> wording reads like the entire GHCB is suspect.

I believe you meant VMCB above, not GHCB. :-)

>>> The APM states that the VMCB is undefined after SHUTDOWN. PML index
>>> could be anything:
>>>
>>>   15.14.3 Shutdown Intercept
>>>   When this intercept occurs, any condition that normally causes a shutdown causes a #VMEXIT to the
>>>   VMM instead. After an intercepted shutdown, the state saved in the VMCB is undefined.

The anticipated APM update will clarify the wording as follows:

  "After an intercepted shutdown, the VMCB control area is valid (with the
   exception of offsets 60h, 61h, and 68h) and the VMCB state save area is
   undefined."

Based on this clarification, I will initialize the PML index only during
reset and leave it unchanged in the case of an INIT event.

diff --git a/arch/x86/kvm/svm/svm.c b/arch/x86/kvm/svm/svm.c
index d9dc725786e6..f5a17274868e 100644
--- a/arch/x86/kvm/svm/svm.c
+++ b/arch/x86/kvm/svm/svm.c
@@ -1216,7 +1216,9 @@ static void init_vmcb(struct kvm_vcpu *vcpu, bool init_event)
 		 * svm_update_cpu_dirty_logging()
 		 */
 		control->pml_addr = (u64)__sme_set(page_to_phys(vcpu->arch.pml_page));
-		control->pml_index = PML_HEAD_INDEX;
+
+		if (!init_event)
+			control->pml_index = PML_HEAD_INDEX;
 	}
 
 	if (sev_guest(vcpu->kvm))

Regards,
Nikunj

