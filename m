Received: from PH0PR06CU001.outbound.protection.outlook.com (mail-westus3azon11011040.outbound.protection.outlook.com [40.107.208.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF87E33DED5;
	Thu, 16 Jul 2026 08:09:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.208.40
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784189380; cv=fail; b=QbxHyjpF/wCeKHf4YagPgGnh9OytiLk754xoCRlieiQO7JMcgSypb1O3mDGmLH2VORBhgqyFU1ry4InGMdyBj7xONGUHRn8KbzVQeY5u1NuD66bGBUzoasVFoGWyGilYgHHH66ktFUFh9PfP01gDpN14ner+qJmGbDgy4OgmmhE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784189380; c=relaxed/simple;
	bh=HcdLzik3dcWugPCcyyckkRrRwsvDfUNsa/ZPRgTtiKc=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=R95U0qYGGLvfBFEYefNk2RqJa4VjcFsRIemGYvOD40QIGOxyAMFjLEF0SWOKX8BLoADahZNxGQ166WKfFy1uWDUW6rjVP/W706THXRkmdPyowznq/+MP10U2m4cHmXNULgPw+Tv7GaDqrR8otn0ujcxl4nwlYIz95wR0LDS7xAo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=h653j/5t; arc=fail smtp.client-ip=40.107.208.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="h653j/5t"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EzWIAkPKLUg/E+MAv6wI2ocrz5VcjEgjNaelRMyzNMUw2VtAQRPbyUDnC1R7k7YjReK+TzjxQk+YTHz3ZmNGT4Jasa+8I2//oVCFjp/mJWYDlxu5hAy2eLRC0YhRAiC8IPSSShpl3V5Rt0QLcMELqxeSMVLAS6IhgjrB8uQcorsFhgczAjrUcRVrZA2pZ6AkoX+fD5eXgwUSxkzUYLxtbRMXlZK4aq82blpk+EnQ+X8BBu52v/PJl47YkqhUpWZUP4lu/4IV7LmWLdIDjGlk6ES36luDGfy23o0nf/6U80QFX2EliVz1KyKC5eqLAm0NeXPLJ112ilITqaPtL2csXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=am/IgNydstQQkNhwTyHVG9dbt1FpOE6dMUxwgsBgQ9s=;
 b=xRLUEih1gI4n8y2a8UYLShE4FI9xNCs3IWASvwCUROGaz7PEILNVJw0clb40gE6wosC/PrDGQCrEnq108CS1N94848NBswSyXJTg2ccHxn0FsUhKUllOs7YUIEJ/j71ybR4WJ21PAHn3SJQIZ+DRKerrpdiYbR+OVUqPGd8Az+tFzW5vO0eCGEsT5jNH8a6twj6twKE3pEocKQ9UMiCT5RnNNU9+sxmqJ26EBfyWItni7ey0gHPU7v56RN3eKhR0ahj4RtciwEDQX9pTdeilZcokekoKa91ajyLrC2kiEaOEHfHHvsOSMt5YP4F+Qs8wzUybQ9av546DHFJzUKKY6w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=google.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=am/IgNydstQQkNhwTyHVG9dbt1FpOE6dMUxwgsBgQ9s=;
 b=h653j/5tVFRPdn1l4Y8We5WUmYapX0aJ4TDbUsEBHKy5o4zAgvKCtdyzXDcKAmZqrLn10EcrON5xpWr/VxO+mojMYMUXzszyxWev0uRy+XOCDnFcMoAqUs0GV8AKSlPWNB8G7DleVfUzBErR280z3CyAikK6l5RsPTSqJaxT2e0=
Received: from IA4P221CA0006.NAMP221.PROD.OUTLOOK.COM (2603:10b6:208:559::9)
 by CH3PR12MB7641.namprd12.prod.outlook.com (2603:10b6:610:150::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.12; Thu, 16 Jul
 2026 08:09:34 +0000
Received: from BL02EPF00029928.namprd02.prod.outlook.com
 (2603:10b6:208:559:cafe::72) by IA4P221CA0006.outlook.office365.com
 (2603:10b6:208:559::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.223.12 via Frontend Transport; Thu,
 16 Jul 2026 08:09:34 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 BL02EPF00029928.mail.protection.outlook.com (10.167.249.53) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.245.5 via Frontend Transport; Thu, 16 Jul 2026 08:09:34 +0000
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Thu, 16 Jul
 2026 03:08:29 -0500
Received: from [172.31.178.83] (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.41 via Frontend
 Transport; Thu, 16 Jul 2026 03:08:26 -0500
Message-ID: <b1472f91-7d6a-47d5-8982-cf9eda2ba033@amd.com>
Date: Thu, 16 Jul 2026 13:38:25 +0530
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] x86/cpufeatures: Make AVX512_BMM depend on AVX512F
To: Jim Mattson <jmattson@google.com>, <x86@kernel.org>, Thomas Gleixner
	<tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov
	<bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>
CC: Yosry Ahmed <yosry@kernel.org>, Sean Christopherson <seanjc@google.com>,
	"H . Peter Anvin" <hpa@zytor.com>, <linux-kernel@vger.kernel.org>,
	<kvm@vger.kernel.org>
References: <20260715224030.3772948-1-jmattson@google.com>
Content-Language: en-US
From: "Nikunj A. Dadhania" <nikunj@amd.com>
In-Reply-To: <20260715224030.3772948-1-jmattson@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF00029928:EE_|CH3PR12MB7641:EE_
X-MS-Office365-Filtering-Correlation-Id: 1979e43d-daf8-4e4f-35b8-08dee3119248
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|23010399003|82310400026|36860700016|7416014|11063799006|56012099006|6133799003|18002099003|22082099003|3023799007|10067099003;
X-Microsoft-Antispam-Message-Info:
	3b/PdNXbpLR97ReINUSc4wLSyz2ISyQ84mrrx7+RqLtfQxeaYjHDFQE0vLVqP0gvnQmuIIqFE/BPXD2qIXrI7IhQhi8pz9DZevm9ohodzi3JsoEkhQ1ld4ehGHCXZeIG0roDHYt6ol731uM0+ODk8WpvJMiMZUV/LkH75jwUXdyGMBXcKkXIi0chPLynHHjlT1mqVMXILr3UvVUmH0MqBhWnrypImcjxir4AzHky3rndGf/nX/vjlt9tfCi7sb/oGmDs4qZPhMTsv2Qed/ujfUAR4Q2rga5MGd+FkIWvhMVF/otAdkDbZYiK8rD6A+p4WXPOy1DhPFmXpucueLaug+vF6Tz7qnOMEIhXhB12g1dUAgc1ybhPddy7mOqIBpoGMknwuYjBuNjtIxlVbb8o8IBp60cWRMCFxDk47SfVCaXJNsdyS8EQ8wTEg6Xln7ErhC4HEHWTezKRjeWPpC3Lj4pO0OV1pfctC8AbV6faYM938ovl5/pboN1VOeIxSHPLKC/yd0nixFfjbEnhVHNrhI/7XbNpCJ3p63WMGB5eaLYGiyohD9QA17/DnTnHuV8dWoH5QHmQiE4KgddY+l8AJ+xGEXFlAgIkYNzjiEANGs1TUpOqy1GJTgWYUzo8r5OkS1zYxCJ5YawCI0PiVIBHJfCtX3L071rrN0I7QrlA6lC4X6cX9znoHjrU1TVBCQvFUlULqnDOt32M1yi7e4sPOw==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb08.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(376014)(23010399003)(82310400026)(36860700016)(7416014)(11063799006)(56012099006)(6133799003)(18002099003)(22082099003)(3023799007)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	W+a9leY5a/pqthBugist6pGKMGvModpE2UeZ+gNID1v9o6ES8WKpYqD9ebt5P9DvZqk4q8OF0w0ptv4xDeKS5dA4wE6AehtKObDp8ZjDBMuwpQVrkE2O81smKvGLSu8NNJWjx4aiwpKjk3+nAyAEEBRi/fekRjnQT6AkffO+qorCCm6UX0DibW9OPy6GvipeXKpeWgVVfvc4ysOkvXQmI7Cw7Gakc8/dz1iKC91IxPJG2NZJMx169poJ8Yyr1FPzFzsDhrBfbSpsxau0gpWjh43j/Bki6LNQ0qlf4YBQE+2LWC+UCNpt3YwuFOX2T/Y3xbyhmnSqPV/ez8To81EErqjD2aPkPPcRCVTiBbl1uCo7CodDd4j4wJipVIVtsbs8fCZZ11iw3oh1EWKD0D6CqK01eDDGUVOyQXKG5JHplB3+4NE2mgp2ZIIchEWzFlMm
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jul 2026 08:09:34.0989
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1979e43d-daf8-4e4f-35b8-08dee3119248
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL02EPF00029928.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB7641



On 7/16/2026 4:10 AM, Jim Mattson wrote:
> Add an explicit dependency between X86_FEATURE_AVX512_BMM and
> X86_FEATURE_AVX512F in the CPUID dependency table.
> 
> AVX512 Bit Matrix Multiply (BMM) instructions operate on vector registers
> and require AVX512 Foundation support. Declaring this dependency ensures
> that if AVX512F is disabled (e.g. via clearcpuid or host capabilities),
> AVX512_BMM will be automatically cleared as well.
> 
> Fixes: de0bfdc7137d ("KVM: x86: Advertise AVX512 Bit Matrix Multiply (BMM) to userspace")
> Signed-off-by: Jim Mattson <jmattson@google.com>

Reviewed-by: Nikunj A Dadhania <nikunj@amd.com>
