Received: from BYAPR05CU005.outbound.protection.outlook.com (mail-westusazon11010005.outbound.protection.outlook.com [52.101.85.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3CC73BFAC0
	for <kvm@vger.kernel.org>; Tue, 15 Sep 2026 21:27:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.85.5
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789507665; cv=fail; b=Mu7pqB/GjVrwPB+/8FYAzhT3FenWIICxIWdIrqsoPA8MwrL2itWYYdWf+dnF73d0PFxjbURJTV+fDcS78obcbI+VSmla53/ZP8X8a4/V9C+j7tN9MLnb/6AAtJUwPcVWjL26jphzKXODIMk8C40415rNT3/pNG8REUsi930WZq4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789507665; c=relaxed/simple;
	bh=lXJ6UKcN/c8GyoOlQceygGwQT/e7Dx4sueOeFJ34fk4=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Xw3Vhp5Ttli1t/w70GaxQ6EBlMheQzwr4aoq8D3GQK5eA+DeTwlkcK03msgkj1V2GyY7R1e4TQuCvOzUr2NLmpMzRvkcC+YToKsRAxWp1/NoqLLKU3wZm1jQZg8wXC+sC80B8CEOV/PGKPRuIEX5scyAUCrSJ9N0Tfv6L4Zve20=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=fail (1024-bit key) header.d=amd.com header.i=@amd.com header.b=ThkECefV reason="signature verification failed"; arc=fail smtp.client-ip=52.101.85.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amd.com header.i=@amd.com header.b="ThkECefV"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XpXufWX7jBBCH1o8uHQy/1fK6M/OkzCw35nXwSsfbgDAwnYYt/DFC7KuFWRvRria4ypnseNbfU5b1RA+ydZ/HMm5HvUjdeULV3b4dTxUvGiOQTSVo2Wy2RBr/l6ku4KVp7s7ceT4lOg5R9Kj53R+C1cPaJS4N+Vd8ivZCZpjuNGm0B21ynUf0BHg/yK/ingC635K+DhApVn7KYF8LrH+jE3E5dtcooTw/fijroptksiO4UUElaY+3U/xqJWRKFznlL03A5kpAkWtw7tNurfzh/JfmuPdDcxZv8O598LKXxO5erNF6/tPKDHnJ5E3AhEm5G2qN4ZmfX2EOEzF9AQasw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=J2XM9bJ5LJOvmtgoeKz3wOHAAxZEbHdzwp/+D1Ye7TA=;
 b=rdKqUSwgAdksfDJZF/sqlgguj7GyQSSqCOIbPcY2TUFh35n3LBJTyMZVeZpZRtNa1J76VLDtMgWvUHs91qiizEsy/L+aWx4FwppvefuE1tvhffKTOnHW2AfTzGI/FyGNmfXBRGERm9zYoiGrp2anY2yFE5As5K2fBKpm29P20xneWGTuujLgaJbfpJVChxL0o9WYzquJds2BUx7vL0rkNxETW3IUayQvdAnrkZ86smWn1ezxdpxrL+idfbXP8EawNZQEuV7wKuck1/Nl5xQTmp9JmloCIk7Ges6BpEYXxDxPR4J8QqsO5rpd834t9ZpEdo898WqTKdWFsUNEsyK5DQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linaro.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=J2XM9bJ5LJOvmtgoeKz3wOHAAxZEbHdzwp/+D1Ye7TA=;
 b=ThkECefVWAPF5JyaKQvuVp6aWB8/nnKkYRjTLOQrTb/4tba5kG/L/kBvlz4XpA7FcsIPhrpXdeF0K3v9ADgo2lUQSbFqJgeX/11hZSLbWb1SLmdJu03wOFOjOE7yu9s4TobtamU034Tm+MQ4c3JuQ/YtBWgvpQqSq2gjotprQqE=
Received: from CH2PR18CA0038.namprd18.prod.outlook.com (2603:10b6:610:55::18)
 by PH7PR12MB8780.namprd12.prod.outlook.com (2603:10b6:510:26b::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.9; Tue, 15 Sep
 2026 21:27:38 +0000
Received: from BN5PEPF0004698A.namprd02.prod.outlook.com
 (2603:10b6:610:55:cafe::99) by CH2PR18CA0038.outlook.office365.com
 (2603:10b6:610:55::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.428.9 via Frontend Transport; Tue, 15
 Sep 2026 21:27:38 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN5PEPF0004698A.mail.protection.outlook.com (10.167.245.39) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.428.7 via Frontend Transport; Tue, 15 Sep 2026 21:27:38 +0000
Received: from localhost (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Tue, 15 Sep
 2026 16:27:36 -0500
Date: Tue, 15 Sep 2026 16:01:06 -0500
From: Michael Roth <michael.roth@amd.com>
To: Mathieu Poirier <mathieu.poirier@linaro.org>
CC: <berrange@redhat.com>, <kchamart@redhat.com>,
	<pierrick.bouvier@oss.qualcomm.com>, <peter.maydell@linaro.org>,
	<mst@redhat.com>, <cohuck@redhat.com>, <pbonzini@redhat.com>,
	<eblake@redhat.com>, <armbru@redhat.com>, <lorenzo.pieralisi@linaro.org>,
	<gshan@redhat.com>, <enju.kohei@fujitsu.com>, <qemu-devel@nongnu.org>,
	<qemu-arm@nongnu.org>, <kvm@vger.kernel.org>
Subject: Re: [RFC v4 02/24] target/arm/kvm: Return immediately on error in
 kvm_arch_init()
Message-ID: <rocrppdlgvg6jcolhnlt7z7ilqmthepim66ujg4e5diayw2gmg@s345fbhx3sov>
References: <20260903193611.1058589-1-mathieu.poirier@linaro.org>
 <20260903193611.1058589-3-mathieu.poirier@linaro.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260903193611.1058589-3-mathieu.poirier@linaro.org>
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN5PEPF0004698A:EE_|PH7PR12MB8780:EE_
X-MS-Office365-Filtering-Correlation-Id: bf34ce9d-6921-465c-b825-08df13702a8d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|23010399003|7416014|376014|82310400026|1800799024|6133799003|10067099003|4143699003|56012099006|11063799006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	LSe5yxPsnqu9iNG59bdcNXh6tLHOovbNJ//42tgbkWmCzJmDL3EnmsahtfuKW/IZW9JZpxr9HHM8p/M4keoWKgSLJGc12A0IV4m4trB9DkD8QIrwUXTDNFErRDIw4TEz6p1EkwSGCFKp5dgtmi4lG/l9hy/INl8Z4y+NZf6LbDP0mcl7Yf9Bvl/qWt6/01VGXu1xmh3T9TKWDvyiPxh87A6iNR0iME3fNPhR5uUDwUU2glBOq06OhsplY3T0xIgClKXZv7B4+ZOdCigvPzFP0NHe8CRIyHgQnO1brPgoEBB78F2bBdPtJe+Pxz51Fpopu186MTED+Ty0ZzyktESCEixhlAI0F4Gp8Ec7J7d28YcBOxfHv8/+qw/w8M0irgQIrHVDxQG1oxcNW1KSXCR3t/tda+lQA81Y3fsnFTa/BVxva6rRVs/RZ2Fojhh+mN6MHOIlKYvR6J123+0tvYuBixfC5PGmWLdIdP7JcwJ0dkEodlAtfzHF1bEdkKR38OJqOCMW6bNvizBheWkLvTxYyzFgqOB0zh93YqHkBxpTnJzFf1nmN4/mzCFwe7rRr6aTBihTPGLdEfjJuqFw2TivKCanuBJ5z3GIcmSs2xkHhNc4sFffeo7zfi4rUzVkIy73bJN4i+L2mnbi1B0Obp3pmOPi+D45yhhHiOll6nPrZGuxe3Iv8sNevCpl0CT/JlMLUn9o8mQQp4xxTY8bsFc3/g==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700016)(23010399003)(7416014)(376014)(82310400026)(1800799024)(6133799003)(10067099003)(4143699003)(56012099006)(11063799006)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	dAJwi8ba9AuRmWI7e3A1D0bQxtY7zNYh1T4sNAlbSqV9SZ4NG6WVXHG+H+9nWG3yYLCTxXeHs7pF72Ff2hP9nKQ2+rCqmCoz+ARcyO+D9WE4vEcivIq2Rdde9Y4kV/eFXwMlS5WV26Y8tNnxt5kZqnDgPSLFGXjiX3n3bCT+fX6Ph25AVJTBDJWwogPawSjCAx55QZgLAe3ac/rHvzG9pzR7x4LOm9KR5l0aW1bZ9KjPKdMz5qIKk5zbUHVtRICoslSd6aPRcwNzk8LncA4OX17FN1PsaF9F8Qk1Cy6OmDXOqqHmQYMbYJGkBerN7eeb122inYmoQeHybw6sRXRuMFjRkY081iwNMT58Hb6N3ZLLpgnzyOd+6XJSdrI7rszEqFK5uO+zg9aRYtVV0mucRgQL0oFN7pQug44Q8jIyENu+eQ1LcOsg5t1rq3XKcadE
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Sep 2026 21:27:38.0627
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bf34ce9d-6921-465c-b825-08df13702a8d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN5PEPF0004698A.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB8780

On Thu, Sep 03, 2026 at 01:35:49PM -0600, Mathieu Poirier wrote:
> From: Jean-Philippe Brucker <jean-philippe@linaro.org>
> 
> Returning an error to kvm_init() is fatal anyway, no need to continue
> the initialization.
> 
> Leave the `ret` variable in the function scope because it will be reused
> when adding RME support.
> 
> Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
> Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
> Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
> ---
>  target/arm/kvm.c | 9 +++++----
>  1 file changed, 5 insertions(+), 4 deletions(-)
> 
> diff --git a/target/arm/kvm.c b/target/arm/kvm.c
> index d40a6a985914..ed99be7fd80c 100644
> --- a/target/arm/kvm.c
> +++ b/target/arm/kvm.c
> @@ -596,7 +596,7 @@ int kvm_arch_get_default_type(MachineState *ms)
>  
>  int kvm_arch_init(MachineState *ms, KVMState *s)
>  {
> -    int ret = 0;
> +    int ret;
>      /* For ARM interrupt delivery is always asynchronous,
>       * whether we are using an in-kernel VGIC or not.
>       */
> @@ -618,7 +618,7 @@ int kvm_arch_init(MachineState *ms, KVMState *s)
>          !kvm_check_extension(s, KVM_CAP_ARM_IRQ_LINE_LAYOUT_2)) {
>          error_report("Using more than 256 vcpus requires a host kernel "
>                       "with KVM_CAP_ARM_IRQ_LINE_LAYOUT_2");
> -        ret = -EINVAL;
> +        return -EINVAL;
>      }
>  
>      if (kvm_check_extension(s, KVM_CAP_ARM_NISV_TO_USER)) {

There's a error_report("Failed to enable KVM_CAP_ARM_NISV_TO_USER cap")
under here as well that doesn't have a return -EINVAL after this patch.
Is that intentional?
