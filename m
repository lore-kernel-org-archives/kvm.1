Received: from DM5PR21CU001.outbound.protection.outlook.com (mail-centralusazon11011006.outbound.protection.outlook.com [52.101.62.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15932392823;
	Mon,  1 Jun 2026 10:41:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.62.6
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780310470; cv=fail; b=OAxpOSxJuKcVySywuceIQ/xVDiQp9iGT2OafkQUkUIjq3SwtYtbEsFrN4dUUnYM/XjBXMUGBL5ij+q4aW1rBa9ykZOZkBDKEolEtiCO43Mmi69wgREF/2WEciGAUWBYiyrTAGmNAV1Itvg/lvnu0/YX/mV/68Bangb5VrxACVo0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780310470; c=relaxed/simple;
	bh=gcqMrjxS/37Jcf+m7U97YpNT3/C3gjJgKdoFLfPCTAw=;
	h=From:To:CC:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=NF/5kSNZnrVr+2PkvmySuG9/kGsc7AdROaI7pFvtQdc0XNYQ3DOZbXzC6TpR/Pc3LoktFkciCZ3eVqdTo4NCboeCJI1kK+KYsWQ4T2PKnpPiXiibPZWoUbk4hjcyNccbG+ImK9ByQJlJiOf/SWFsxFE920BglbRXt1LdKcNyneE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=PMbaULee; arc=fail smtp.client-ip=52.101.62.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="PMbaULee"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=seliv3gXzHqtcJ2yj7FKvggMxCZsBcFBqj2Kf+JApCckp2Qd3jED3B5DmApBpiOJ743d5DscR29o76Jf3RFiHcVBmHBgOcHJjxo5h0yxO15hFTXOIk38jMjbUqRxi9Ff4qqX3hfSCceIOnTLqtGqebrki6vSP/EQ0aTO80jmCu50Rnts4kpYefTa/l0XgGre7JvJTMmBaBJXed515uEBLXOvVvQ12e1bcA7mMq2sB88dIz+ckKSxBmp4BU9zpKPPNC0Md3cl9QZURCgBYaQDA5xtrwVEJb6USp0Kxb2e+IGy9gaxqzL6h0MH6RHKIsprKUbc+/uH54GdwUNKmGs4+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=el4RK+7qcGwTehOhzw7cH04JaMQx27gX1w20bw5pWPw=;
 b=rhr8LtpFCwlF78J3Z2eheRNcmG2XpytYVvYoH2dwpALhjfyiufpvA3CJjjM0cGinxkEoeKdoWBQ5XE6MYs23VthLJqc75m5fs0Ojc36ek+fPg/2Vjek5zi8QwoJCMILuI7EoMjiSaiGYMe6aqfS+guNbM84UVGjyc0Q+OuU+qR0+0UIA7wiHPBd1sbsjEc0C+0lEHlOOMrK2LykihqIb4zo4cOCB6YvMMr/Wjg7oFSfbi2mYhZZKlIAZcAQxBXQeAmbvDCzK7h078fEFcJsrr5/vypdrUrFm9nOvgk/H8yIZ4vqkjWlMt488buusNLCJLqxQiabK/2SoWcdgOa9sQA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=infradead.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=el4RK+7qcGwTehOhzw7cH04JaMQx27gX1w20bw5pWPw=;
 b=PMbaULeeBtXP1P53XIKAJwXezvyxtOL9wWStzdm7xh8wvEuoKJAEOjYzkEZ9K1kNsXkgIWlRVryprvUvN6CJn932SDBPSxqELAdvcFlbAg3pWzBHpgqzKmV1rqsIMQSpfQLigU9RiBswOR7+FMd2r6rJgPt2GSFdAZFC21Nqb5Q=
Received: from BL1PR13CA0285.namprd13.prod.outlook.com (2603:10b6:208:2bc::20)
 by MW6PR12MB8952.namprd12.prod.outlook.com (2603:10b6:303:246::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.14; Mon, 1 Jun 2026
 10:41:01 +0000
Received: from BL6PEPF0001AB72.namprd02.prod.outlook.com
 (2603:10b6:208:2bc:cafe::64) by BL1PR13CA0285.outlook.office365.com
 (2603:10b6:208:2bc::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.92.6 via Frontend Transport; Mon, 1
 Jun 2026 10:41:01 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL6PEPF0001AB72.mail.protection.outlook.com (10.167.242.165) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.92.5 via Frontend Transport; Mon, 1 Jun 2026 10:41:00 +0000
Received: from BLR-L1-NDADHANI (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Mon, 1 Jun
 2026 05:40:55 -0500
From: Nikunj A Dadhania <nikunj@amd.com>
To: Sean Christopherson <seanjc@google.com>, Andrew Cooper
	<andrew.cooper3@citrix.com>
CC: David Woodhouse <dwmw2@infradead.org>, Paolo Bonzini
	<pbonzini@redhat.com>, Thomas Gleixner <tglx@kernel.org>, Ingo Molnar
	<mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, Dave Hansen
	<dave.hansen@linux.intel.com>, <x86@kernel.org>, "H. Peter Anvin"
	<hpa@zytor.com>, Shuah Khan <shuah@kernel.org>, <kvm@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-kselftest@vger.kernel.org>, "Saenz
 Julienne, Nicolas" <nsaenz@amazon.es>, Maciej Wieczor-Retman
	<maciej.wieczor-retman@intel.com>, Tom Lendacky <thomas.lendacky@amd.com>,
	Shivansh Dhiman <shivansh.dhiman@amd.com>, Neeraj Upadhyay
	<Neeraj.Upadhyay@amd.com>
Subject: Re: [PATCH] KVM: SVM: Always intercept ICEBP, add INT1 selftests
In-Reply-To: <afy2h3RxiKSBh_Ym@google.com>
References: <e03f092dfbb7d391a6bf2797ba01e122ba080bcd.camel@infradead.org>
 <afycwi4KT6xrQhMX@google.com>
 <beff5bd9-ae7c-4f2e-a718-7c8e92e78e4e@citrix.com>
 <afysu56g2dTFla6-@google.com> <afy2h3RxiKSBh_Ym@google.com>
Date: Mon, 1 Jun 2026 10:40:52 +0000
Message-ID: <85o6hu4k7f.fsf@amd.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB72:EE_|MW6PR12MB8952:EE_
X-MS-Office365-Filtering-Correlation-Id: 82a28917-381d-4cba-6ee0-08debfca45d4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700016|376014|7416014|82310400026|22082099003|18002099003|11063799006|4143699003|3023799007|56012099006;
X-Microsoft-Antispam-Message-Info:
	KWrDt6GNCJC46AmP7RviVq89pq9V9VYZE/ynOoXXydEnm4rlcxVsMG7F0AWFwS6vsTYFzKs0bXOQFL28rY1I3IEp8Z9aoHgHp9C1coGslVZobtyaTUS86fWTjQPjCeLw4614uIXbhywGIEdRL55DHh2xnyJh/LBbuwoxzJgQcHLC5H+sM5aKEyDU3jB1HbHBc/gImDuiUgqvHuZlYfGHAUmLVZf6+pe+FiIpHqgJWvXgk2kpyoPDoLr0LjQhrMeXzqddmrzYcyplCk0mv2+2FH97IAIQN1GtobIH9wljqG1mrNgn9vTFkvDDS7ozqNpsmubiTBYqfYVml+kb68R1yeOc/28QRcOcwI+tlb6qeCg95PEAENHiktO2ahT6+Vfomy1lRdYDmJQ7sCNZlB0T+uLv0k49Vqk63TMPttd0LkM3SXCSvnWCHp76vUZXkC6UJkF4nIpUXzQY1IDoGI99TkYKOag+Xy0E+liXSm2dflDi1z48nTz55pfK3btNngSYHWuywxxAuwetVd/w6AzexhCICchPK/zrjaQtZK2+TzdD53pTSXBdrwbVKxCogqpxdRabWdFW61j1JJOw8d23hcoajjMnU+x595JQqYtpsaMGIVVBC32+JsedRIXM2EOynKB3YywpSD3N3FBNoewcykxqCDpJN3gVpp1ffdtGyQvpHNWlNlxRwpsfMWOUw9yDAiXUH0HTKVMYVQ1tx0g+UFm5KWyAMUfzVKazVVio2vc=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(36860700016)(376014)(7416014)(82310400026)(22082099003)(18002099003)(11063799006)(4143699003)(3023799007)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	sChymLikBxSrDxGuCIHnd8JoJisZSfTergaHGzldq6TCf8ptyMnvUb+DcypV+2kCG6ZGWJjpwnMOmeklTDYRt8i1y+D+3EJEeU0QKJR773hqNdNcd4IUk+SFOGMCyFN5dWyq6KjTMjaVgtqW28AsIEqS2+r1t6NdXPjrso/Kb98BmKf/NUfNpE9tLxZ3CxEgGQkMQQyrUdjfEAQINONFVrEhcY5cvaxmiBiXBxPM/JrTaW1bSOyGmTKgbwHj3gCi+ISypFmaepEair4/FYDNkAaJrmjJvUcJZimxbsGxPWKuPHdRCNstDBSM8VbopeCNy1LSkpJUTtTWsQXeXXZsw6AuRpEuY89Sz4DKciZDNZYE3lGh5dErQK9OsIK3XqTnaQKLB+hr5+stHrSl7AMo7fHZufkFc6g2wkTm/zHcjxpQVnMLISRlDauBmO0dnT/a
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jun 2026 10:41:00.8591
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 82a28917-381d-4cba-6ee0-08debfca45d4
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF0001AB72.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR12MB8952

Sean Christopherson <seanjc@google.com> writes:

> +AMD folks
>
> On Thu, May 07, 2026, Sean Christopherson wrote:
>> On Thu, May 07, 2026, Andrew Cooper wrote:
>> > On 07/05/2026 3:08 pm, Sean Christopherson wrote:
>> > > On Thu, May 07, 2026, David Woodhouse wrote:
>> > >> From: David Woodhouse <dwmw@amazon.co.uk>
>> > >>
>> > >> ICEBP (INT1, opcode 0xF1) generates a #DB that is architecturally a
>> > >> trap, but on SVM it was not always intercepted. Unconditionally
>> > >> intercept ICEBP on SVM to match VMX behaviour and ensure correct
>> > >> event delivery semantics.
>> > >>
>> > >> Add two selftests exercising ICEBP:
>> > >>
>> > >>  - int1_ept_test: verifies that ICEBP works correctly when the
>> > >>    exception stack page is not present (EPT/NPT fault during #DB
>> > >>    delivery). The IST stack is evicted via MADV_DONTNEED before
>> > >>    executing INT1.
>> > >>
>> > >>  - int1_task_gate_test: verifies ICEBP delivery through a 32-bit
>> > >>    task gate, exercising the legacy task-switch path for #DB.
>> > >>
>> > >> Tested on Intel Sapphire Rapids and AMD Genoa. Without the SVM fix,
>> > >> int1_task_gate_test fails on AMD with EIP pointing at ICEBP instead
>> > >> of after it. With the fix, both tests pass on both platforms.
>> > > Hmm, but KVM unconditionally intercepts task switches.  Is this effe=
ctively working
>> > > around a bug in task_switch_interception()?
>> >=20
>> > Not really.=C2=A0 It's a bug/misfeature in AMD CPUs.
>> >=20
>> > When you get TASK_SWITCH (which always has fault semantics), you look =
at
>> > the vectoring event type to decide whether it was logically caused by a
>> > trap, and therefore whether to move %rip forwards before entering the
>> > new task.
>> >=20
>> > AMD CPUs don't distinguish instruction-induced #DBs (i.e. ICEBP) from
>> > exception-induced #DBs (all others), and also don't report an
>> > instruction length for an ICEBP-induced TASK_SWITCH.
>>=20
>> Heh, that explains why I couldn't find an equivalent of INTR_TYPE_PRIV_S=
W_EXCEPTION
>> in the SVM code.
>
> Dragging in a comment/concern Andrew raised offlist.  If AMD doesn't prov=
ide or
> *allow* the equivalent of INTR_TYPE_PRIV_SW_EXCEPTION, i.e. type 5, then =
what
> happens when KVM needs to inject an INT1 #DB with FRED enabled?

I'm checking internally to get clarification on this. Will follow up
once I have more details.

Regards,
Nikunj

