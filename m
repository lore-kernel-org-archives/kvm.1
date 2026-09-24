Received: from SJ2PR03CU001.outbound.protection.outlook.com (mail-westusazon11012007.outbound.protection.outlook.com [52.101.43.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38452407CDF;
	Thu, 24 Sep 2026 11:15:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.43.7
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790248533; cv=fail; b=M4jB723HwBIB3vMEaUtt7c+Mep8DdJdguqce0Z8eh5AST/w5JiYmrkLO+NvO8n/CX3mi/vwZpCAMysmO+y9M+LG0ydqaCO3/4OIC8U9/NsNvgilblLaxQMN184JvqzITenFsRxnZy+wy6SAxlZnpKN9fhkTtnJY1ygxRaGZKOGs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790248533; c=relaxed/simple;
	bh=+YOcHY4BEjrCMqN6YSHRdM8yHSm4jCR1m2ACyfmb9js=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=h3yvKar5YGMXEQY9yUdyzVjpf/t7RSNPWVk2siWBY/Gy8ELD5ZgL+TjtUp99q+8MAL8K2nOheGQ1GQJUHkg26B5jDlogA4EC3Brl7168Dw3WalAUbG5jDEt2krUgJ9+fg9puKrhz3sluB6s+Xfx0pDaoG+5ApuHM6R1ZK+dXTdw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=mnEjbHLf; arc=fail smtp.client-ip=52.101.43.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="mnEjbHLf"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wdkZ9cdo1y0jzA2YkYgtrZQxW6awtimuKfuZDXylAcbSAkgZCgchAnYhcgxPb0TN55laSXKkCwJWzY5eVQRV9yXqPnsfuZA5CLUJzDyLgzHeG3kx8ZV3OLqJtlM1JPme5fNbN9o7sPtVEuAV5iCIqLreInLrktDtJmbmuQI7EJRMWU8Vwkj3XxpSKXPcofHeyeAORQ6qrJB9xfxx1HNQsbU+kVllkeSYf+Hn4/VKKH5mQT034UNgaxBAPLfLgklNNDIrQdJYJ0DMcvArMyx9G0RzDgBZyaltIxBQW5QC8gl8vROZ9yOCM4qvG6P+NTBqYpiF/N7Yg5bNA4xn4n1LLQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+YOcHY4BEjrCMqN6YSHRdM8yHSm4jCR1m2ACyfmb9js=;
 b=XGh/rhjvdS8bJjHtkU9k3TVb6fhrDQ3qmvcVN47o3tLx2zOfIv5lvLDozlXZAiNxdFdHJjNAdEZyQiRjuTcdbYhRpEbdcbe/rmBTkXBP9L1jAvzRPk6hqqH2btQUx5E0YjhOp2a075gC0MjewogV3MrQlTlKGOp6vmxryqUoYxajzt0N/CqIkYWGj1HJnCP9aa4mW5ubhJFr48B4h6zDGr9+gFtL4JYO3LxVwNtXH0Rh43GOlfVjU7vLna22wI+mVWmqQCiXIatdCWJezNeVJxkJenDN4CDOwyyAS10iXGj4u9/1gCW3L5y7WcdHGTK2f2AiN3kZrxiu16BVqCxdew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+YOcHY4BEjrCMqN6YSHRdM8yHSm4jCR1m2ACyfmb9js=;
 b=mnEjbHLfHXnA8pznqRzImrJmQh1TJnkhqUq/GUn4Xwf8xCFxduuJc3iqVJu/nKQ8dhh58zGwC/+6SpodYfgluuaqQ5wxW80mDTsBdS8OaRZjzkdLs/dOvtouJtpeTBVut4TstrfLDgnRXrsce2HlBmc2qKviZob6j1WSawDgJN0=
Received: from MW4PR03CA0075.namprd03.prod.outlook.com (2603:10b6:303:b6::20)
 by CY8PR12MB8265.namprd12.prod.outlook.com (2603:10b6:930:72::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.18; Thu, 24 Sep
 2026 11:15:19 +0000
Received: from CO1PEPF00012E65.namprd05.prod.outlook.com
 (2603:10b6:303:b6:cafe::13) by MW4PR03CA0075.outlook.office365.com
 (2603:10b6:303:b6::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.451.18 via Frontend Transport; Thu,
 24 Sep 2026 11:15:19 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CO1PEPF00012E65.mail.protection.outlook.com (10.167.249.74) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.451.8 via Frontend Transport; Thu, 24 Sep 2026 11:15:18 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Thu, 24 Sep
 2026 06:15:04 -0500
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Thu, 24 Sep
 2026 06:15:04 -0500
Received: from [192.168.1.3] (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.49 via Frontend
 Transport; Thu, 24 Sep 2026 06:14:57 -0500
Message-ID: <43fb3d8a-0736-44ae-bd7f-01e701d4b7d9@amd.com>
Date: Thu, 24 Sep 2026 16:44:50 +0530
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v10 00/28] KVM: Enable FRED support with KVM VMX
To: Sohil Mehta <sohil.mehta@intel.com>, <kvm@vger.kernel.org>,
	<x86@kernel.org>
CC: Paolo Bonzini <pbonzini@redhat.com>, Sean Christopherson
	<seanjc@google.com>, Jonathan Corbet <corbet@lwn.net>, Shuah Khan
	<skhan@linuxfoundation.org>, Thomas Gleixner <tglx@kernel.org>, Ingo Molnar
	<mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, Dave Hansen
	<dave.hansen@linux.intel.com>, "H . Peter Anvin" <hpa@zytor.com>, Xin Li
	<xin@zytor.com>, Andy Lutomirski <luto@kernel.org>, Peter Zijlstra
	<peterz@infradead.org>, Andrew Cooper <andrew.cooper3@citrix.com>, "Tom
 Lendacky" <thomas.lendacky@amd.com>, Nikunj A Dadhania <nikunj@amd.com>,
	Shivansh Dhiman <shivansh.dhiman@amd.com>, David Woodhouse
	<dwmw@amazon.co.uk>, Chao Gao <chao.gao@intel.com>, Binbin Wu
	<binbin.wu@linux.intel.com>, Zhao Liu <zhao1.liu@intel.com>, Yosry Ahmed
	<yosry@kernel.org>, David Matlack <dmatlack@google.com>,
	<linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-kselftest@vger.kernel.org>
References: <20260911213659.2025974-1-sohil.mehta@intel.com>
Content-Language: en-US
From: Shivansh Dhiman <shivansh.dhiman@amd.com>
In-Reply-To: <20260911213659.2025974-1-sohil.mehta@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF00012E65:EE_|CY8PR12MB8265:EE_
X-MS-Office365-Filtering-Correlation-Id: c3a4cd40-a92c-4d83-68b8-08df1a2d1e0d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|7416014|1800799024|36860700016|30052699003|23010399003|10067099003|22082099003|18002099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info:
	4+/Uy0cJHSX3rRgVCaD2vngN+e9Bx9DjRzRg2nnnlZrWPS8c4BrYuWH6mPspegzkNiZS/3m+AtzddOWXlLxrHJ39ZSEhirLFbLr9J53X5UVodWd263bfquceguAFZ2ofq3RKJwjNuh+Mk+z9CHev//no4tJBTt9Zz2V7LAvb+FEt+rWxtkOb2PtN8VZJRVzU8iv5xxNO3UMns51i08tIB6IzCZqQ58eRT6MP/hMGbsMZVWT/4/0rkSzTduJKyzhmqxb4zQTcEKBBq0ksPi9VSoDa20FqyAlF/3QRQZ5oWybwxGBQS/w6BeJmyivq5VNgLsqTCNe9t4ySh+BnG1yNmj0loV0uyOiRgDrf9wMk9mBdmbKhkvd5HaBd2sUHq2IzGcMV/9gSL7EjIo6WNO2VJPrwaiUrIV/1H/6ghchmXO3GZD986l0BYlitOyUoeccYgA9gjrTnJyJNPmnfYv16FIvFNm//KvKH29scH0S71oNkhafLeNpTUCy8KdQVQMU+nC4dvcoayoQggGLonUSMya7FfejLfgMg2mOGutAez1WHERlXN4NdtCqt7wfDtt0VOCrF3z6MAhhr47ysrwhOumyms1q6pHFex8svyQ2ojr4/UXRiDZPgucU7lfoTBF68hFq6XnbbhesxN2Z08bGEVB5YqcIPWaAu5Q4SpqNjl17I8mCvbb+e5HvJyVaLTINY27xeRSL9WJwrSFA5Lru8kg==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(376014)(7416014)(1800799024)(36860700016)(30052699003)(23010399003)(10067099003)(22082099003)(18002099003)(11063799006)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	MP4Xa21R5JrTq/5t4+/FxQRWub/UBxjj3aFUpgUcuqbQw3/X+igIUcE6cxHb25mHKMFTFpoJq77y02LsWFd5w7qYsfsKXU4kUtl54j5rDDcL36Kd9b1hg1lfaERcQ5frVrwtZS5GB/ggrysZydwZsibzFHXD5RhJDP7MypyCV0HjlCoVD2Vc4uI6n4m6m1sQpLDmfVN320vm/Z00kTOXGZSjASst7alt8Q1w5uuqLMEPlw4ZlnyCZfom1cdOKlh8kYJOybjhEOAYRrhN9muNFMicCRkwxaREP+x3REuPWRslQGJtg4R83AJH9pVhQeHSM7/FNcvasklxYIeqpAsNt5WrQr9zcjfvAdBqx88YPjFxdnKoP/+TgnFydgKmtOjkfDxoKI9zAybTvAhjRZj+uY+VTJXjg5GUSu4yDJ0Q7OJgRp1VoSi4AMxNZd2jAP4h
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Sep 2026 11:15:18.9225
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c3a4cd40-a92c-4d83-68b8-08df1a2d1e0d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF00012E65.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB8265



On 12-09-26 03:06, Sohil Mehta wrote:
> Opens
> -----

> AMD compatibility: The SVM enabling [5] builds on the same common
> plumbing but I haven't had a chance to look at the series yet. Shivansh,
> please let me know if there are any incompatibilities. I assume most of
> the opens apply to SVM as well so resolutions would help both vendors.

Thanks for the series Sohil. I've been able to run SVM side of vFRED with
changes rebased on top of this series. So, no incompatibilities in common
plumbing as of now. Will let you know if anything comes up.

Cheers,
Shivansh
