Received: from SN4PR0501CU005.outbound.protection.outlook.com (mail-southcentralusazon11011024.outbound.protection.outlook.com [40.93.194.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45B7639FCD1;
	Fri, 27 Mar 2026 06:47:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.194.24
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774594087; cv=fail; b=bE4u1E4534ino+/1QiOZYnXRIFgNetBNPnvIvJUet5uveMBR5API5xgU+8f34kIpglkMWcRQr3gnHhPTLkuY8qbJrNO1FzLHKn6giT/YkKHw8A2cC9AAluDvZpu0+EN9w7NhYSU2DTf3LcS3NVHuGjdtXeU6jGH2JY7rcF1K0hw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774594087; c=relaxed/simple;
	bh=YC6NmWW8f6ReuYPWy/VWSBf8r3qkxPegN588tKBjBRg=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=rYxuPHWBlRdc4WugAXxuijPXXNklYN/BRd+RAqEIlqSRwX15ksQQ0NYpz5UdFT1hRZIv1Y5K0gEPTih7Uw1ETqocToHMNST9WZA1u5UQzsIUlR36FnQx3Pea4VnQrMb6mwmXd06le0lsxDfsIFeYmawG7sqb1M+Fs0tTb0/zyxY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=g7J0GFCk; arc=fail smtp.client-ip=40.93.194.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="g7J0GFCk"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ybgm08RqGN4FPEK5Ie/xr9AlLVGzcSUQYnSSRU/cLlipJHe6iBrn9ykrT8bZMWTk7b8NOHeYUP65xnw1INx10NHGGuLC4+goT8BfVP8FBiuViU/Nq9XcPDMuJWzWVECKRTTB+JWLybrEHcljhb1tEbJboETppAb58l+jdbUsZr+ImaNbt/MO8L7qpHwauARHr80l9tCgWYjur06tW7loYA2IT0dOOcAFqr59WykF3+BGsicYo2hbMpYAhmbDM4sQPiEuNXLbO2//s92C5R1yCp9YhIeuILCDcGDypypYjAXleG+V7IQ8GzVxhikEws5F/Z+MAQVjHsO19Ugq+/Z8Yw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7JPRWR6Z0nVX8Ui7L+VC8GumRq5HxuSYl6huVK2M5wI=;
 b=yTtVIB95LcMOzGhB9xo3fFJJeWXIJEDohhybUG3WKdXUkYV4AnTrwG+khJckkGR9QX9pXHa1IeTrYkm1k3zqN9+wQaj+mJcGaPmDYjSlPIbQ5AAioysu4IjJIPPuLSf/d33cLRmjhShECPq17Aq922u3TZQo0KHDiNgQxteCd2Cu/yILKpPXfjD2w3BCk/zNryjFq2JwfRTBS71j/c99WPf/4vxUOBMQ/sL9ykbfoTmhyXhvrxdnuNbJ9bchZKe1y7pOrfQiDuvGOHf9B3d5Hsm3qxqPiUmm0JIvOASjkmTQJ3geh2bVxmQ6iLhw9kW9C6/i6gjmN1UVQmLfQA/MrQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=gmail.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7JPRWR6Z0nVX8Ui7L+VC8GumRq5HxuSYl6huVK2M5wI=;
 b=g7J0GFCkhlgxmKj36a5+S4Y8Kw2yxGhzqQ9N3rMnvwR+IDthaRL/R9SiRYKKmxDm6VUikFoWg06maI9DiC+1JFM/7oUrd+GXzjhsiqkJWOV6nbJhJ7LNaaq6FZEwUlNMIsrhQFeFvzF/hcGZDfT9UuWnZbXL6QPD6WgEF99cnKA=
Received: from BL0PR1501CA0016.namprd15.prod.outlook.com
 (2603:10b6:207:17::29) by CH1PPFE5ACC0FD2.namprd12.prod.outlook.com
 (2603:10b6:61f:fc00::629) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.10; Fri, 27 Mar
 2026 06:47:52 +0000
Received: from BL02EPF0001A103.namprd05.prod.outlook.com
 (2603:10b6:207:17:cafe::4a) by BL0PR1501CA0016.outlook.office365.com
 (2603:10b6:207:17::29) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9745.23 via Frontend Transport; Fri,
 27 Mar 2026 06:47:52 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL02EPF0001A103.mail.protection.outlook.com (10.167.241.133) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9745.21 via Frontend Transport; Fri, 27 Mar 2026 06:47:52 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Fri, 27 Mar
 2026 01:47:52 -0500
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Fri, 27 Mar
 2026 01:47:52 -0500
Received: from [10.136.45.190] (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Fri, 27 Mar 2026 01:47:48 -0500
Message-ID: <334b098e-5ceb-4a50-a31d-882b64582679@amd.com>
Date: Fri, 27 Mar 2026 12:17:42 +0530
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/7] KVM: SVM: Initialize FRED VMCB fields
To: <ludloff@gmail.com>
CC: Sean Christopherson <seanjc@google.com>, <pbonzini@redhat.com>,
	<linux-kernel@vger.kernel.org>, <kvm@vger.kernel.org>, <tglx@linutronix.de>,
	<mingo@redhat.com>, <bp@alien8.de>, <dave.hansen@linux.intel.com>,
	<x86@kernel.org>, <hpa@zytor.com>, <xin@zytor.com>,
	<nikunj.dadhania@amd.com>, <santosh.shukla@amd.com>, Andrew Cooper
	<andrew.cooper3@citrix.com>, Shivansh Dhiman <shivansh.dhiman@amd.com>
References: <CAKSQd8VQfopKppypoUVhOYNPyvGhR=664aEKcJ7Vu00NNaoHug@mail.gmail.com>
Content-Language: en-US
From: Shivansh Dhiman <shivansh.dhiman@amd.com>
In-Reply-To: <CAKSQd8VQfopKppypoUVhOYNPyvGhR=664aEKcJ7Vu00NNaoHug@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0001A103:EE_|CH1PPFE5ACC0FD2:EE_
X-MS-Office365-Filtering-Correlation-Id: e7312c4e-3b82-49f0-bea8-08de8bccc4f5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|7416014|376014|36860700016|1800799024|18002099003|56012099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	lueETnzWvlbaWoc0kNZAdhAmRmxsPf3IsqW46WGuq687wwGXKjB7nkc2X677NkotevXiN/oSiybzZJf2kyr3kcoXbYjD7SYpYPpPl/1MW5vwsuV3h7zZP6aajod0ySu7WyN5KEpsivZgNSTk5THG/Ggz97DMqOlTsq1iUCIFds0oG+QgKeavkKyHgoAoLpqAT2Xa4zwjmjZMSBwfYOf+7qCxGR+e56mfPCyz96kGPU6sArFiM73j7qcJObFPFx2jhW07VaQFRfS6eFYtUVwzbA0dFwETv8OEZEZMgJ8/PBGGOYmqtajuUbzZWme58TP7sVzpCQ6hC5r8Vc6H9g0Prf1b4O/DdL0UV11sAc/EvTEeiZzU5OaYu0PqmlKeDdlKXFnLM856cgi/a8noLazOxYyKSeqWjqQyDmd5Lajaiu30Q2AO+190X3WKxgUtQl3jKGGSB6eiZ4zXOOEawX8fWMDYYzx2zG94LmX8QSCTGRbC7YcM1GymiKy0fvdiBOWDcUToVVjIkhJN+JW3AxAvqv9+pqzRNot6XppY0OKmzsBpTt9S0sjnxpWnY9xHSXVGTMaP2fBknZT+g4y44SC1edcJmuugf1Y0Ocvaz9bEC8cgIVmWJyOm9BHyfSv8hmhdA1WI1eGdSOnoWQ2dm8zorOT1IID+DP5teKfpWxMDSbAyitASx0zCeEW4KdSmNrE6NhRIKedJIrp944+sxhNDn1xpZJ5eOhEdV+AsM6mqFd68oCbeY/WnqZ6Oi1q7zFpwQ7046mGddWLXpY7F786r/A==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(7416014)(376014)(36860700016)(1800799024)(18002099003)(56012099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	hJsER2/FEJpnkRAYKNz04aaI2cxl0H7UJX1TFaXt87IB0qT6+de+BggxS+n6sZc72kU1ja6ttmRX4bX1k887M9HSu3KYuom4hkjpXxoVpJg4UqlbojDtj4WVU3nGT+t0AkxNJwMR4glkFYUlj0wXps6Dxwpd+fL1PU5o31ZW3tDOsSaDRQINZcxpEVgCyo1ieruzdGo+Z/OwSKgLzTwKW+fr1ztsrQPOQvIBIrs51iyuXWWhWoRiJY8Qavc6v/1+TjyvmhMpjT0gX44X+ynE7szwpbR7S6jIerePaMftf3Kc0xSLNl6tWHWtSfsWuMXWWaHIW3G8vCSfoakLXei9TCvM/7xBJIu20P4gtLbyRePWjI5rpxelLThpwmpW2GjU+6y045y8rltbk1ttIjrA/4ld4fNqdG4j1dp1PLBICDvJRWnuBbIIfv7ZpJ+u3uU0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Mar 2026 06:47:52.6771
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e7312c4e-3b82-49f0-bea8-08de8bccc4f5
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL02EPF0001A103.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH1PPFE5ACC0FD2

Hi Christian,

On 14-03-2026 18:25, Christian Ludloff wrote:
>>> Is this architecturally correct?  I.e. are all the FRED MSRs zeroed on INIT?
>> Yes that's right, the FRED MSRs are zeroed on init.
> 
> Ahem... citation required, please.  :)
> 
> Because the FRED spec certainly claims otherwise:
> 
>   "The RESET state of each of the new MSRs is zero.
>   INIT does not change the value of the FRED MSRs."
> 
> See SDM vol3 #325384-090 @ end of section 8.2.3.
> 
> Getting initialized by INIT tends to be outlier behavior
> when it comes to MSRs – MPX, CET, EFER, FS/GS/
> kGS... but afaik the rest all remain unchanged.

Thanks for pointing this out. After consulting with the hardware folks, it
turns out the FRED MSRs are left unchanged on INIT. I had mistakenly mixed
up the INIT and RESET behavior. Apologies for the confusion.

I'll update the patch to only zero the FRED MSRs on RESET. Will address this
in v2.

Thanks,
Shivansh

> 
> And yes... this will need clarification from Intel... given
> that CET_PL0_SSP = FRED_SSP0_SL0... and it can
> not be both, unchanged and set-to-zero...  8-)
> 
> --
> C.

