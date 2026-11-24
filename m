Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.56.12
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795542291;
	b=zmOPJvdzwdNmnl4WHyq8leV1N5QtRE9HsTQkU1lTbyj4/Jy0kCbjDGG+XbtM1+2TAK4g
	 LC9utbkALW0kcjVlYqCI+X+AvhndDcuURcO/I43pn83yQeNlLunXsh7YK7LOsuPcgp3W5
	 BzLMCKIqOtx2VOFu84uk1XONa8bZfacFUceLhraYq0LR/nvsoEbGIN9Ch5GT8xHGvHTas
	 v8ZHLR6qPwKi7V+ySeXrMksJNxwutDh2lBmVsyQBdKMLplDzcjTMlfwQDp23j1SpWSfQ4
	 8DD7UwACHBlGYfSJSMmFgwSZ7WAZ23sypONF23N03472wMe34MQZuU6Nmx0eFSh6l2w==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795542291;
	h=DMARC-Filter:DKIM-Signature:Received:Received:
	 X-MS-Exchange-Authentication-Results:Received-SPF:Received:Received:
	 Message-ID:Date:MIME-Version:User-Agent:Subject:To:CC:References:
	 Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-Originating-IP:X-ClientProxiedBy:
	 X-EOPAttributedMessage:X-MS-PublicTrafficType:
	 X-MS-TrafficTypeDiagnostic:X-MS-Office365-Filtering-Correlation-Id:
	 X-MS-Exchange-SenderADCheck:X-MS-Exchange-AntiSpam-Relay:
	 X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
	 X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-Id:
	 X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=eobYjRFrPZpIZ4y1+1ihmTA/GUxAqKNIvjcdB5x3Qg4=;
	b=2/VGS9mTNQlo0v5Yyg5kYimamP1f6umCRcxhep0M+ZekqhS2MNoySJLHyHmSJJFAcLAM
	 CQINpsDWjWEQeYKIequ5jZ6S/chsuPqgU7A48h7u8ERAFf6YqTJv8aPk0FRCWWnQi1fEe
	 LnobC0SCF4P0ZDzptN740pNeqrsKGl9ljXAskPEthnD2ayGm8Tp4cFkdbX1DwGVcZbq4x
	 KAffebikCf8OOqXf8JBR1bsduRRPlLgdHm5IEk4w2bo8I6CNmUyWIT+60HSW4QpBAkw5r
	 +L/OizHt8kb05Z50mQg4YHuqQ37iJSF+c+Z3PtOwtbytjLqhOXe1jpg36gFEQh1WsjA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=amd.com;
	spf=fail smtp.mailfrom=amd.com;
	dkim=pass header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=ZMJQllMy;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.56.12
Received: from BN1PR04CU002.outbound.protection.outlook.com (mail-eastus2azon11010012.outbound.protection.outlook.com [52.101.56.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 484BD606A31E
	for <kvm@vger.kernel.org>; Tue, 24 Nov 2026 17:44:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 484BD606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=ZMJQllMy
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=P3XHKiaueWEScHibPBT9mrrjQHrRUfxRa8G9QrlvNu0KEcD9rrDeusUo5MA81SA0XBn7oBwv7Y32nVhrq2z/wiWz7TDFH3ETfKWug1gSrBlZt18zROp7UDueeOWoM/MUnQTF1rNxT6BcRyKGXYRsHP7hbQ9KwJEqTrmODNgH/4ttc5cGqQI65vhknrIW+4tYq5yk19NIt49A6owJ+lwctQc3G3JqHoPMq09LKWJqV9unLOy4emq6M9IqOjvBC8cZ3fYD4lV549fT8I8awNCBWaBX4w2J2kRkO36Cnb/cd83CMZ/fq0D3c9bxwAuLO5f7aEgpVer1onAYd8RvIYFa8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eobYjRFrPZpIZ4y1+1ihmTA/GUxAqKNIvjcdB5x3Qg4=;
 b=FxRArFSHL0Njg47c17XS7dAR102zmpby0z2SXRtGmTu/QyhVyO5Uq3fxpzKX7nFWUdLiID0GuRDo2UcJKaFc9XSP+10Jbmnlz9FN7UloSLlEgbrSpK5Ry9qxbrL1upJTvha7v8lIbe+Gs8idsggrICAVGEeX59u1butkvCt/OzrUWDrSBUGWrYN1cUoZHbn8PC7LADu00Ymad9WZ/wi09BQKyuEWxsuqGtLBanWLeRq6pHgd1gd2czTw7RgWVYtAV4cdID99J+hsk32tYBbiGewrBftkb7kuCL/o7Fpeej6cTPb7eRPblPQ5O6oaSGWKe6D1yWGIcMf1TOUq8wpH6g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=redhat.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eobYjRFrPZpIZ4y1+1ihmTA/GUxAqKNIvjcdB5x3Qg4=;
 b=ZMJQllMy+CU1zKA4tWGKGazVL0RD6ozi1jqV051KpiQvr+btkqWdiu0W+0vGlumItDxo++Gjz5GaXdvL2vPOKwX6+TAwitQNremHaMfaEHcYnmL+XR30oqDflz+M2vDF9KapCbsKzwvizY/nYQSZI7nneGIFzhIwi8e31tQ1Vuw=
Received: from BN1PR10CA0006.namprd10.prod.outlook.com (2603:10b6:408:e0::11)
 by SN7PR12MB6911.namprd12.prod.outlook.com (2603:10b6:806:261::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.639.12; Tue, 24 Nov
 2026 17:43:34 +0000
Received: from BN7PEPF00000097.namprd03.prod.outlook.com
 (2603:10b6:408:e0:cafe::9c) by BN1PR10CA0006.outlook.office365.com
 (2603:10b6:408:e0::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.639.14 via Frontend Transport; Tue,
 24 Nov 2026 17:43:34 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN7PEPF00000097.mail.protection.outlook.com (10.167.245.75) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.662.3 via Frontend Transport; Tue, 24 Nov 2026 17:43:34 +0000
Received: from [10.236.181.204] (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.57; Tue, 24 Nov
 2026 11:43:33 -0600
Message-ID: <4d2f11dd-46e4-49f1-97e3-30ea79244fbf@amd.com>
Date: Tue, 24 Nov 2026 11:43:32 -0600
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
Subject: Re: [PATCH 0/6] QEMU: Add support for AMD EPYC Zen6 and Turin-v3
 models
To: <pbonzini@redhat.com>, <zhao1.liu@intel.com>, <mtosatti@redhat.com>
CC: <qemu-devel@nongnu.org>, <kvm@vger.kernel.org>, <shivansh.dhiman@amd.com>,
	<babu.moger@amd.com>
References: <20261029195623.2209-1-Benjamin.Cheatham@amd.com>
Content-Language: en-US
From: "Cheatham, Benjamin" <benjamin.cheatham@amd.com>
In-Reply-To: <20261029195623.2209-1-Benjamin.Cheatham@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN7PEPF00000097:EE_|SN7PR12MB6911:EE_
X-MS-Office365-Filtering-Correlation-Id: 45361004-5723-48bb-905a-08df4a52768f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|30052699003|36860700016|1800799024|23010399003|82310400026|376014|261026121527099003|261022075727099003|261021135927099003|261021123027099003|10067099003|261021121427099003|261102123227099003|13003099007|261009223027099003|3023799007|18002099003|22082099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info:
	lFk/LtP3pZDIHk4VFbE0EvEw9TGJnAskoj62HmYt+A67uRMzUIuALWvxyMS3ipaVsT6wzTx/HFIVqqd3SdnU7lBArWhvvrc8yDyBXFbkCt5eVDgm7AYMuUUlWObjn3xCHnxjuZz4O5s4rWDeF1PSTz3awXgf0K9DoOt33MvTsMnO1DEmOvppx7F6pj5l4HEbg4RzzWOhLFBMRJnU9MmOumeUU8c+lXNzRL9+Tl7CNtkMEdfP8e3eXzBc0FwXhxduC0WtEf+kz/EHgHKAIkZt6Z3DpTTmRbwoR5SG18FczExLwNBOhuF5qTT6OpZOifd3tImJ6g3MHKdTNevKQA6H5rcwFbKsb9EF5Eb1iJQrW7IBCKKUdUpKZ9+O3DS+j4pNEJERNvgcgEgZdpoe8CBa1Lv3BXj6tIGOiRmOFITmfx56nXT3YLn/PytxVSAhArVyuUNsEzbUrlYccNyEzlIExy033zDV8sgOXIUg4//VihTVhxL3ChVxNxBlaqolIZoau0lwnA8m1hlrnjH7tRmsix2yDgC8WUGykHUF+M28b5YOSEK1A0GY5pt0EoBMuEUKih9514v1W2eScwXKmzZNRXE3ZukfMNwM94V37eZprWif631X/F/BXWIXxoApVMDgs1sZNDxX50KVyZ19WN+d0T+2iZc7OQHzmMAxFmosdFA=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(30052699003)(36860700016)(1800799024)(23010399003)(82310400026)(376014)(261026121527099003)(261022075727099003)(261021135927099003)(261021123027099003)(10067099003)(261021121427099003)(261102123227099003)(13003099007)(261009223027099003)(3023799007)(18002099003)(22082099003)(11063799006)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	PfGvG1jg8j7cJ6Vi7MwfL3FutPzThUJ7nyZ+ggjZxIacv++574SlRXx4RCPlKm2Z3YH5M9b2LcLh4CjN2qtq+gxhDmCNVlU+8WjPjIDcPYymjOPCyjwwcpcRbPo2n06PovgNDyZc9Wsw40u3mWU3e0qqGvBmMZkmte6KVgHSDVgCJWjF3dAqDsafUp0N7+YOXmibITF6k74UaPuwfUQvMDH8Dbe91EMNQPZuIu9/YIi9QkvAMYiUVx1FWbXSbyP6dNiVYvODyCkSLeZbqnFJyySejAN/GrxaFzj4lTOtHni5w7TXfvfbQgKLwUSNJFWR03gaN36tZkoemJSQPn9+3NADhufmyscabEf//nQVEMrozJeiZ2zIbuVwlmxDey1q+in93taHxLge5KDQFSob9Uz087aobuOgDAxjzwpiepKhDB0xC2KP0n7Fx8nWESJ3
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Nov 2026 17:43:34.6323
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 45361004-5723-48bb-905a-08df4a52768f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN7PEPF00000097.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB6911

Any chance I can get some eyes on this? We (AMD) would like for this to get into 11.2 if possible.

Thanks,
Ben

On 10/29/2026 2:56 PM, Ben Cheatham wrote:
> This series adds support for AMD's upcoming EPYC Zen6 CPU models
> (EPYC-Venice). The first four patches add support for the EPYC-Venice
> model while patch 6/6 adds the actual model.
> 
> The EPYC-Venice model is based on the EPYC-Turin model feature set with
> the following feature additions:
> 
> 	ERAPS, TSC Adjustment, Flush l1d, Bus Lock Detect, and Shadow Stack
> 
> and support for the following instructions:
> 
> 	AVX512 FP16, AVX512 IFMA, AVX NE-Convert, AVX VNNI Int8, and
> 	AVX512 BMM instructions
> 
> as well as new cache values.
> 
> Some of these features (ERAPS, Bus Lock Detect) were only just recently
> merged into the Linux kernel. It's recommended to use the latest kernel to
> leverage the full support of the model.
> 
> This series also adds a new version of the EYPC-Turin model (patch 5/6)
> that includes some of the features enabled as part of adding the
> Venice model support. I've done this for convenience, but can split the
> Turin model out into a separate series if needed. The only patches
> required for the Turin support are 2/6, 3/6, and 4/6.
> 
> The Venice model had two revisions before this one, see [1]. Change log
> from that is:
> 	- Add Turin-v3 Model
> 	- Add flush-l1d and bus-lock-detect to Venice model
> 	- Add Bus Lock Detect DR6 support
> 
> [1]:
> Link: https://lore.kernel.org/qemu-devel/20260825162544.18633-1-Benjamin.Cheatham@amd.com/
> 
> Amit Shah (1):
>   target/i386: Add getting RAPSIZE for ERAPS enabled guests
> 
> Ben Cheatham (4):
>   target/i386: Update RAPSIZE definition
>   i386: Add Bus Lock Detect support
>   target/i386: Add EPYC-Turin-v3 CPU model
>   target/i386: Add EPYC-Venice CPU model
> 
> Nikunj A Dadhania (1):
>   target/i386: Add AVX512 Bit Matrix Multiply (BMM) support
> 
>  target/i386/cpu.c     | 163 +++++++++++++++++++++++++++++++++++++++++-
>  target/i386/cpu.h     |  10 ++-
>  target/i386/kvm/kvm.c |   4 +-
>  3 files changed, 170 insertions(+), 7 deletions(-)
> 

