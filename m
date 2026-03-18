Received: from BN8PR05CU002.outbound.protection.outlook.com (mail-eastus2azon11011067.outbound.protection.outlook.com [52.101.57.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 492822DAFD7;
	Wed, 18 Mar 2026 08:19:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.57.67
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773822003; cv=fail; b=DU1joZJntoehVlltmVXHchnXs3iifX0VNjeRd9Y1j+dmSBpCd7b8t/CAUFz6389u87XNd+OY0uC8rjNCTGce3+7xvvzjtzdvKbT817vp0rw7PmpJrE66PgCzRCpApTD0p+/S/w+SXEAbekJuJdzhcWrjBO8hZJ//rpg6YR1gwIY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773822003; c=relaxed/simple;
	bh=g0dnU4/smUdGu9sanJ70ZpDnLxmEXDKHmQpWFhTu9pA=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=UVjHOuDupYQ4sSlBMFEZc1COYYn4bsnSiN+g3bBQB2frNvGjtN7AGcncMYolvBAdbLuX0UElAqJgkQfYS/Du+U8W4Q4g9nIYQbsBOU66aORBxUXJgyB1G9b0bBnPJtyVOdsAgm5UGuEDn+hiOjx4NkiV2fyOvJS1PwGHLqq3dh8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=Z+mXsWeu; arc=fail smtp.client-ip=52.101.57.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="Z+mXsWeu"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hFl7C1Hi/TN9sxo2vAsb5B5HlF5Hv/RcrQJZH10TeMwlQdVltBhZKOxjXtB38lC+Cr/P/k/z4T1Vckfi2+756MGP1qfg+W/oHVEI9H/OIhhquIlOo1NE9OuqqvZpFzVgnDYyEJ1OkCQSrqwKcsm171cECEdRqllNeHipSMrEzAG8CoAx+dTv1RCFfAibxIUSVV142dRPM89obj/m2W8tpOYkCe37spVX9OMvNnbfo6I6kypoKC5HtOMAVkHgrWwDllML6F5CaFB/2yuT7iNYPEiKethWePFCcBU5p19RC6+DNU4ta/EGMYyLOYo82G+ALLjFHsWqOJ6/UOcXEFx42w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=t0eM/SmXUTIuMkn4NFE8Mx1lXgUKaVf173JiZ8dkOgI=;
 b=Ilg6O/Xy/IME83S13ny2O+Fe00Ql60eApJMMz5z5EeWJTCDep/cMyAwNzE08jTX061cFLkjlqGTpaKkCQcM9lwZZ3lohJNu8I3CawOLESVfxVdxsRKwC06Uvf5w0cLGE0EWWCLqhAIDmfW+fFvB4i2j99jHzpIWRZ+zbY+JF/yI4Wc2umxtTzD++zkZYEaMNCDTt6gtucmfaWKCitJuXJK9//8IJanmaXO763kV4MjmfCJntIEeIWsvnuZT3QB8DLskOgSgR34mxRGtVMIaabyd89Lk5lCbiR4sTNe1PZyhAJqfhux/ekgYsgJF2p0v88eRTJ5zKiwOKqoUR/g2SjA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=alien8.de smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=t0eM/SmXUTIuMkn4NFE8Mx1lXgUKaVf173JiZ8dkOgI=;
 b=Z+mXsWeu+NHXSlZ2X2ItGZ6NrWVh9NAUhUZguSmLhip/0g+0c/8dc+R9wdutZ7xFG3lbVprui2AiwqbYsWCpfgeC+AkEkDPdBnUsPgFLgeXow2GPpDV8v1CUgF7zAHQGdzFOlofWL+yO6MgCBjSmfN8lvTSRaNzgdx4qbjsGPiM=
Received: from BL1PR13CA0328.namprd13.prod.outlook.com (2603:10b6:208:2c1::33)
 by IA1PR12MB8517.namprd12.prod.outlook.com (2603:10b6:208:449::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.19; Wed, 18 Mar
 2026 08:19:56 +0000
Received: from BL6PEPF00020E65.namprd04.prod.outlook.com
 (2603:10b6:208:2c1:cafe::d4) by BL1PR13CA0328.outlook.office365.com
 (2603:10b6:208:2c1::33) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9723.19 via Frontend Transport; Wed,
 18 Mar 2026 08:19:56 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 BL6PEPF00020E65.mail.protection.outlook.com (10.167.249.26) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9700.17 via Frontend Transport; Wed, 18 Mar 2026 08:19:56 +0000
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 18 Mar
 2026 03:19:56 -0500
Received: from [172.31.177.76] (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Wed, 18 Mar 2026 03:19:52 -0500
Message-ID: <baa8ab92-c509-41f8-8a81-dc21337ab46b@amd.com>
Date: Wed, 18 Mar 2026 13:49:51 +0530
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] x86/cpu: Disable CR pinning during CPU bringup
To: Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@intel.com>
CC: "Chang S. Bae" <chang.seok.bae@intel.com>, Tom Lendacky
	<thomas.lendacky@amd.com>, <linux-kernel@vger.kernel.org>,
	<kvm@vger.kernel.org>, <tglx@kernel.org>, <mingo@redhat.com>,
	<dave.hansen@linux.intel.com>, <hpa@zytor.com>, <xin@zytor.com>,
	<seanjc@google.com>, <pbonzini@redhat.com>, <x86@kernel.org>,
	<sohil.mehta@intel.com>, <jon.grimm@amd.com>
References: <9fa61b80-0e16-4a87-a0e7-3c3dfcda8f7e@amd.com>
 <55a98b6d-e831-47a6-aa5a-8fe357334f67@intel.com>
 <d0eba3fe-2938-4856-bd9b-0e13972e8313@amd.com>
 <cb492a37-3517-4738-b435-73311402e820@intel.com>
 <ddf407e9-359d-4d4e-827d-98f212589e9f@amd.com>
 <ab5bf7bb-6511-49dc-a65d-86911e0f7091@intel.com>
 <c13736a1-3151-476b-a91c-035383d2a29e@intel.com>
 <541cddbb-22b3-4865-a374-49ba3ba48a5e@intel.com>
 <2b33bf8e-5f19-46c7-b1eb-89fcf74d74f8@amd.com>
 <515d2fbc-f771-4aed-8706-e8ed20d3dbc6@intel.com>
 <20260317165451.GCabmHWxU5MaMXthDS@fat_crate.local>
Content-Language: en-US
From: "Nikunj A. Dadhania" <nikunj@amd.com>
In-Reply-To: <20260317165451.GCabmHWxU5MaMXthDS@fat_crate.local>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF00020E65:EE_|IA1PR12MB8517:EE_
X-MS-Office365-Filtering-Correlation-Id: 9ecdf4c7-0e12-4b25-921a-08de84c723ae
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|82310400026|7416014|36860700016|22082099003|18002099003|56012099003|13003099007;
X-Microsoft-Antispam-Message-Info:
	Mn5cAQ5+HVhj4Mj4hiWNCHKG1FK0CXFAZrAxKyQaSYnv/hmkP8ZT3Ul/wvbQzC+Iqee90IqaYfPoxuxQqfcMSi0rOJdT1jciYSYrKIl4f0zua49jSFXrCzaF4j59HaSgGcOhBRcRU9TYK+dI0g5ppiT6L+fr7XvkCeKtxQYaXKkMn3q8S5dAgAD7oGruoJYDlh5wdpUwcIU8Lij50gZpi5DlcZ0aFecdBGocB2wCsIPQLY8o3Tc0GG9HFr8ItT7xVRhYT5IUMRz/IBAjOg14k1IGISgxH77P2kq6wMcXCSgFyuTMefbpxp3O+HnTSMqJzNIU3yJVTgjHExARDMDowg5vGQf6t2tbs9V7yM1q0ZK3Z4Nx68yYee6W0bR9FzxNIkeAj/HITaVrkrlcJGjrM++y+pmZ5iXf784RjqX/XKd71uonKOng0KxQZ/zQGFPV9NlYM3T+uwyFEsr78rUJzG9x7PaeLDHLk2R8Sk0T2Oh8cI4FgFpvmucFpojHyKgQIT7awZgRndZ0esAdDfuoxNNEBhSenisAbZ35jGO/TXE09Od0PYoch3sgAENaLBNTVF/k4WFQIowZ71TR+ZFZ0xDlsAvU1TX13E1ys1tuNzcWmfoX1e3H6kXV1RRBY5JHJRZ6SmpANj4y9swxlCbzQet5TrSrCoFJUbQayajdGRzUMRJzqAJOh4hyi/1yHkkje6+TC25HzCqWLb9L//Y26BzxE7KzQ0/TZcr/PYAm4a6CLNUgJYF7rIfUHhLuRn7PQCznTZ869F+Tpz7FwMk+8w==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb08.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(376014)(82310400026)(7416014)(36860700016)(22082099003)(18002099003)(56012099003)(13003099007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	Xfi5LLGVJollrEEgAM80QgcKqx1T94SsKrfql7qHNF3GlWqc0ZvPfTZ3jLHvfjIJY3JmSeh5Tk15JBG4laCiCo9QiRz0xZzJEv8bVFvn6olfdFkoxTsBfy8FKVw59R3+HYeAZnDfibZ92A7A2sDvuA5qGFXdX3V+7RxMek4EI/m01UJFLlLf6wvFZgY9RbQoVHrNpuR92UH/yueahPbebN0QiGYxM5XPqdfeeUqF0au6Stt7MBz53uOB18HUNa/DCyRXE0y2AYuB99RNw8IFnaHjwlmtFozfyhLsOKLV03gVIYB2jyYWijy/Y1u1iblLa7FQs32MLrtxc8q5ew2OrcVDmJRpyYOO+9L5yrdUZY74sGFmYTCUYJJuDn+pf8R8L4E+E5OLbgSJ3T8M+7vxVE23zAsDtzfINORO1g/6/juuzVjjVzI+KyI4ILC5x6D4
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Mar 2026 08:19:56.4756
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9ecdf4c7-0e12-4b25-921a-08de84c723ae
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF00020E65.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8517



On 3/17/2026 10:24 PM, Borislav Petkov wrote:
> On Tue, Mar 17, 2026 at 08:31:06AM -0700, Dave Hansen wrote:
>> Please resend this with a full changelog and so forth, and I think we can
>> move forward with it.
> 
> Patch works on 3 machines here, should be good. I'll queue the two once I have
> them and we can hammer on them some more.

Thank you Dave and Boris for the review and the quick turnaround. I’ve posted
the v3 here: https://lore.kernel.org/all/20260318075654.1792916-1-nikunj@amd.com/

Regards,
Nikunj

