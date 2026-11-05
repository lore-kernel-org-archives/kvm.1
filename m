Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.48.55
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793860403;
	b=kFEPDwqsVZZrjKm8sXb/VXvNvUn4a6fZIXmEroN8ly7W3W/WrLgoG7y2tWT1qhAGCGQm
	 O0W8K9rxJFN8HIQ2UI5cKnnqMRaGScNwxpXVRrCa6WrwohKLJEqVjHk7Kx/Qf732oir1Y
	 pV0PwwL/+KxXMKQPbihCps5bb/FDOWiioyidehTYvO/MPY7YHFc3gMSTkm7ck00jnaQhQ
	 /xRBOBHmJDNqZiiCX5WcOC3oJVafjjZWDcdXeOFPUbkjTitSaXUvXdy4aMZpsIW7+QBh0
	 wrvcjRt5/KcY0xzdKKkS1xSn7W7Y9VSQHSikxlK7w6T4kWQ36GWSCBjbA0l2tZIDz5w==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793860403;
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
	bh=hulaaP/TIv6xQJ+aJhMFyA6B2Lkf4R1eF1P3Xw8q/ng=;
	b=DgetFCKOjMPxHXro3rkHQ8y/VdRa0MToRVsEn+aMWh3Y4U9ZMbvxBdRZRSTL86oilOFC
	 NNKZy1OK7DY/vD48Z5r8wvyH3OKXmvMCrpxaZkPA9meK3mabf4Ysh8MV58RPi6q9tMHlL
	 IzsSyDbQPjXIjqJiVFifaFtUE/dx7UjRmUg/X7IFEykDAK9rMIHbKWjJFEooimSf2bP3Y
	 u8kja0aIRNq5I4MqqarED2hSBR8T9bK+mRtlpnZdfPVWdMqHupfkS7Et5aBq73WZvVzAp
	 k1+iNl+q9eO0qMU9tbOT1GiLsWkXZcfUKxIK9IG9k8lyj2mCgq46T+VzksRCoEN4YHw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=amd.com;
	spf=fail smtp.mailfrom=amd.com;
	dkim=pass header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b="D5/286l2";
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.48.55
Received: from MW6PR02CU001.outbound.protection.outlook.com (mail-westus2azon11012055.outbound.protection.outlook.com [52.101.48.55])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB104606A31B
	for <kvm@vger.kernel.org>; Thu,  5 Nov 2026 06:33:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DB104606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=D5/286l2
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kc4z/xAlASyCM9ifPz/FcHVxwFQldnd3cxxK/vCzzCEFrVwS+8fNVC5dZYTxLvl9zcPFIph3h6fNn+xAAIfum8JVn3dh/ryeu3cGw+ag7JGEcVUCiO1ytNcK6kM47NB7Gq722EN0FFxSiSkNu/1YxdC9JKoSfNviGCi3DaFKfYp5Aujhv93eU+VAVAF3mzh+LCrDTIEloGoa3aTftYVep/tYfgL+gV7l0uNJT+bzb0QbgmQh2r/Yl749utBxHU/6Oe2aFpe3dKg0sTDN1MFV9jb6DSw0GeVziFKKl5b40FnjlO8+Szb6gcopS/rt6Ctw4+2FlF4L7RfW7f9OT2vMGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hulaaP/TIv6xQJ+aJhMFyA6B2Lkf4R1eF1P3Xw8q/ng=;
 b=KlTF7EDniYv0DMGRrAa0AkWjsr1g3YMxiHYTZcT3FprvPWDF87qptEffSyY5wKihjZU6sq+TFGzttqkqTDxJ3Jnl97rIJpLkNij8913NvQwRTruBh8/7k1wcBWlY4VzUy4MQGr/nzNTAnbys58BMEvcLZFUEDc4XN7djNMfo6HHUF91gKI708SDL/HZaQ86Zrc1ss0CQKDN3dYCp8l8Ixc/HSZAhldaKLBFt5+5foLP0VyIzGsn6PzHTnIvycP16Kr69l60uf2uRL+NHffgS4UREMv0qO3I3NhBPh1+PPr8tyZY8K55ncGf27HccVABAqE8RyPSqko4YC5SKscafzQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=google.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hulaaP/TIv6xQJ+aJhMFyA6B2Lkf4R1eF1P3Xw8q/ng=;
 b=D5/286l2XgGJsE7KJM0eVIF2xhzrMvd5VVOPLulgAMoCZMQNq75FCGCfiQr7uFo/Elb+OBi0LxVjEbh1kA+lJJl+jZNGBstBIr75BER7T7QlkKHXUina1dGn4s1zT/1hLzi0UwFZHOPaEF3ofD7hhsQdg1JkUFlUymrgdSfrB3I=
Received: from MW4P222CA0006.NAMP222.PROD.OUTLOOK.COM (2603:10b6:303:114::11)
 by SJ2PR12MB9240.namprd12.prod.outlook.com (2603:10b6:a03:563::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.10; Thu, 5 Nov
 2026 06:33:19 +0000
Received: from BY1PEPF0002695A.namprd05.prod.outlook.com
 (2603:10b6:303:114:cafe::9b) by MW4P222CA0006.outlook.office365.com
 (2603:10b6:303:114::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.592.10 via Frontend Transport; Thu, 5
 Nov 2026 06:33:19 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 BY1PEPF0002695A.mail.protection.outlook.com (10.167.244.171) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.592.5 via Frontend Transport; Thu, 5 Nov 2026 06:33:19 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Thu, 5 Nov
 2026 00:33:19 -0600
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Thu, 5 Nov
 2026 00:33:19 -0600
Received: from [192.168.29.217] (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.53 via Frontend
 Transport; Thu, 5 Nov 2026 00:33:13 -0600
Message-ID: <12522202-c7d5-4390-8726-86d8fe02ec7b@amd.com>
Date: Thu, 5 Nov 2026 12:03:12 +0530
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
Subject: Re: [PATCH v2 08/12] KVM: SVM: Support LBRv2 virtualization for
 SEV-ES guests
To: Jim Mattson <jmattson@google.com>
CC: <seanjc@google.com>, <pbonzini@redhat.com>, <tglx@linutronix.de>,
	<mingo@redhat.com>, <peterz@infradead.org>, <acme@kernel.org>,
	<kvm@vger.kernel.org>, <x86@kernel.org>, <yosry@kernel.org>,
	<thomas.lendacky@amd.com>, <nikunj.dadhania@amd.com>, <sandipan.das@amd.com>,
	Shivansh Dhiman <shivansh.dhiman@amd.com>
References: <20261019210532.378628-1-shivansh.dhiman@amd.com>
 <20261019210532.378628-9-shivansh.dhiman@amd.com>
 <CALMp9eSs3vhi1mmhK=Mj+8R9UXDzvDpHepyDESvQvNxg3YTOkA@mail.gmail.com>
Content-Language: en-US
From: Shivansh Dhiman <shivansh.dhiman@amd.com>
In-Reply-To: <CALMp9eSs3vhi1mmhK=Mj+8R9UXDzvDpHepyDESvQvNxg3YTOkA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY1PEPF0002695A:EE_|SJ2PR12MB9240:EE_
X-MS-Office365-Filtering-Correlation-Id: ad0d732b-ea69-4c88-516b-08df3b06aeb2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|23010399003|376014|1800799024|36860700016|82310400026|10067099003|261022113327099003|261022115727099003|56012099006|11063799006|4143699003|261028144727099003|261021133027099003|261009223027099003|261021135927099003|261021130227099003|261021121427099003|261022075727099003|261021123027099003|261022105027099003|261026135527099003|261026121527099003|261026140227099003|261026130827099003|261102123227099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	JAcKkOmlHgAC8OsJJ5QR4ZpCVq74uh5C5kW2vksFL04FsggkVd+jFlZ+nBXKw+f1xO/8zjr/TGGMlesILWAto80k5Ri67xGDgvWIZkhb1o9g3yLHfZaRwyj6dW+blwCy6B2uxaoGsAjkhAkFwd1Mhvp4iJy1TNRwFRiyBdSqcqVuwJblq+tM1Zfot/7yoUTfkXUUM9aYrIISLcuZSUuJyvj8dLCmnWmU+wjEy5gMAsF+W+RHIIRN661RxprBj+TxtQy04UYHapyn6DkYDx2joScUBVHuECU7ChCGIJ89sboinaDN8FEkkCHE7yA6+G7ul/qdNzbmkNK16VknUWPdIpM2uEquxIPODSEnFQZNxer25/bFh4rdgXAs8O6r9QLCAS7MLq0NpyBjWiOFuqhM8C+EieqMbOCbx6wWVxPLLiEKrVza0IZ+VVPackBQx/DIORA9JuB6bxsuL+ryS/vFI/vrWKXpr8ODXswwldDP6UyoES7DpJJSNSlVPVuq4BmGBXWTqeFRQylOBo7mbX7FcMI7LLm+RplxogBwT8oPptQ3rDjKUTls3onYJOE2I5PDK5k56um/wHEQiB836zD7j28z/S6qt9P+eDNoN7PtPiMML1Wv5OCcbWtrKakjG/GIUD+qcUcqWyRxqNaYoCUX0VRUT1fABIoKyB/p7v0w8EmH1COVNJ6gU8IgvkD5IU6w+jTv0Q4C+insVem/pWhhyQ==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb08.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(7416014)(23010399003)(376014)(1800799024)(36860700016)(82310400026)(10067099003)(261022113327099003)(261022115727099003)(56012099006)(11063799006)(4143699003)(261028144727099003)(261021133027099003)(261009223027099003)(261021135927099003)(261021130227099003)(261021121427099003)(261022075727099003)(261021123027099003)(261022105027099003)(261026135527099003)(261026121527099003)(261026140227099003)(261026130827099003)(261102123227099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	toi6IR9963Yg2tXuNuGgGUcqYjkOXQxObSOTPN+qR6GqSElyIaELeLDzFao8cMPzHptDGbHo8u8JcviB5AwCh1T+P3zLmqsEeMqFmc/VUZr1aG0qPzupGyVas4Q6W2lKqENXgumIVEdAQP+hCNJ9rsu2aF6DNxwSzaMYYx0inswfcYoLVQM3lTddNokF0V+ZA1f0h+6g5Eyb7cTMTur/NAu0zfX9RmzQD71pcp848HgIt/D0wGSAHq/VId0J8UROttBH4yKypLYa8/9hzXE/NT2TF5XKhT5uKYvQFoUiSejc7kPWJmLtrKS2N5t5wUXEC0HykzYQAWdNXXHafXN2YacWfvMSSIZ8+o7ri8FF3CqN7o8GG7vtRFaOGlCjcQux/blA9NZ1A+NLXICSB/BIk/OCL+lyZxhR+jAggkZOhYmnsAaYyW9fz9rLuJwOtZAk
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Nov 2026 06:33:19.5635
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ad0d732b-ea69-4c88-516b-08df3b06aeb2
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BY1PEPF0002695A.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB9240



On 22-10-26 05:23, Jim Mattson wrote:
> On Mon, Oct 19, 2026 at 2:08 PM Shivansh Dhiman <shivansh.dhiman@amd.com> wrote:
>>
>> Add the LBRv2 fields to the SEV-ES VMSA save area and treat LBRv2 as
>> always active for SEV-ES+ guests, which run with LBR virtualization
>> mandatorily enabled and keep DBG_EXTN_CFG in the encrypted VMSA.
>>
>> Signed-off-by: Shivansh Dhiman <shivansh.dhiman@amd.com>
>> ---
>>
>> Changes in v2:
>> * New patch.
>>
>> ---
>>  arch/x86/include/asm/svm.h | 12 +++++++++---
>>  arch/x86/kvm/svm/svm.c     | 15 +++++++++++++--
>>  2 files changed, 22 insertions(+), 5 deletions(-)
>>
>> diff --git a/arch/x86/include/asm/svm.h b/arch/x86/include/asm/svm.h
>> index fb42c6806655..0473e38e33bc 100644
>> --- a/arch/x86/include/asm/svm.h
>> +++ b/arch/x86/include/asm/svm.h


>> @@ -598,7 +604,7 @@ static inline void __unused_size_checks(void)
>>         BUILD_BUG_RESERVED_OFFSET(sev_es_save_area, 0xd8);
>>         BUILD_BUG_RESERVED_OFFSET(sev_es_save_area, 0x1c0);
>>         BUILD_BUG_RESERVED_OFFSET(sev_es_save_area, 0x248);
>> -       BUILD_BUG_RESERVED_OFFSET(sev_es_save_area, 0x298);
>> +       BUILD_BUG_RESERVED_OFFSET(sev_es_save_area, 0x2a0);
>>         BUILD_BUG_RESERVED_OFFSET(sev_es_save_area, 0x300);
>>         BUILD_BUG_RESERVED_OFFSET(sev_es_save_area, 0x320);
>>         BUILD_BUG_RESERVED_OFFSET(sev_es_save_area, 0x380);
> 
> I think the VMSA structure changes should be included in patch 1, with
> the VMCB structure changes (or they can go ahead of patch 1), since
> sev_es_sync_vmsa() does memcpy(save, &svm->vmcb->save,
> sizeof(svm->vmcb->save)).


You are correct, thanks. In v3, I will move the sev_es_save_area
changes into patch 1, with the VMCB changes. Patch 8 will then
only make LBRv2 always active for SEV-ES guests.

-Shivansh

