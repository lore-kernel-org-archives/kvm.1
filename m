Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.48.59
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794409944;
	b=ij/tiugWSG/RToiVGykY/BKapLKgYiGHGx1IVhMfoaEnnj+7VptFyF8DjtotPJIm5J7i
	 yGSAzuNRsD313/BdP3pv2V5lsvfrNlBTs/11ev8c5scIT62JWg3bbAYCi3HfZX4RacV1s
	 bT+Bvn0CAMzYNGC0ljR3EuJ1K1HNflALZ6bDVoTPkNMGRoBJBiMPz3LMnUWgEZoJdaduQ
	 FdzlvO8vMzDSMOCFkKSbq1VAJX0rX2nIEokN1iT+xCIaScYk7nMIBFrFQJFUiSQcjxvcO
	 JCew9a0GB/VQlBFKkS5fnWi2OyYtZpLNOZlXTAbmAkZGGVDJqAVbhjs5Y2g7w7UOahQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794409944;
	h=DMARC-Filter:DKIM-Signature:Received:Received:
	 X-MS-Exchange-Authentication-Results:Received-SPF:Received:Received:
	 Message-ID:Date:MIME-Version:User-Agent:CC:Subject:To:References:From:
	 Content-Language:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 X-Originating-IP:X-ClientProxiedBy:X-EOPAttributedMessage:
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
	bh=mn9ld1gVFfd6wg4+Ebt8VC8FCqe18cp2d4DjwP94yec=;
	b=hXE+Uol1VzO1eJ3eJC9MNP/57spMmIwIWBn14lLs5K/4LOoeHD5sx5oOjidjOCHreINo
	 4DU7rVddwfC1d7OWUxhbVAZsa4hsrJsRgVmXn2J2tgKjsIirovO2JsKsXSIbyrB7NMF1X
	 EGaYtIPafJsHrSJ5+ZNMUgwItvfe/uywP+AggC5xVT9Bq61DX8/oivdq0qkubWEzee5+F
	 dXqpNFA3nY+T062Z4rxYTi/+Lj7orGpRFXX8IK2NawKr1Cu+iCE3Mm2n+rZTYVo8I2mlL
	 SU/zkY2FnfKXISp2JPFY72BsQJ+MO9F38T1q8N/kPGXK89ffs+hJ4exqjqSMm+RAv/A==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=amd.com;
	spf=fail smtp.mailfrom=amd.com;
	dkim=pass header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=XblU7YvE;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.48.59
Received: from MW6PR02CU001.outbound.protection.outlook.com (mail-westus2azon11012059.outbound.protection.outlook.com [52.101.48.59])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8ABE1606A337;
	Wed, 11 Nov 2026 15:12:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8ABE1606A337
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=XblU7YvE
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=u788tGm356UXizfppci0Z7Vd5XDJiulSG6MJ8C3NbAalJQYIQBIt/itqBhCIhuD0hj2U5sDvxzivVIwfkmMrsFV4yd9qkdZtygGL2ykTJWm8cFQ3PcFjWxsrmvQiKmRBDpfJQjXsIZH4Zr/VbfhRq+p3WXh7nFFBW4lyXJh2/IT4GsVFh9mI5F0ykxjETI/+9EH2XbeFjT6YoyxXNjuqp1Z1MMQpacRkAjTjrWzkyba84AJ21MjxWTPGxQ488TNlx7zS0HrttZhaIqSUPVVs7K1JdCaOlqg8cpOb0z20GWNsZg+b+PXAKf/DTME/f+Outcfv8mVhqJJMvx9mxIPTYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mn9ld1gVFfd6wg4+Ebt8VC8FCqe18cp2d4DjwP94yec=;
 b=WmB25WIS9UMDHpTwpQbJs11+yt9A5z3Q00YlsCFNXo4TnvojyXaDXPVoZkpLWGmumMZSX53toKlgwXG33/evy5jknYhO+PQkYAYnMVZDMYkpCZSiN/PwCmsHPJ7MB/Aw8uYFji+stDei8NDjRwFs9F9dIongZL6oy5U36FP7d/XR/9RmwaiHgDMGajqaQe5AgEEXsSM1Wg+J22nnJ9hIzJjh+3TmJ7zxMbOiNyFRZLSNX/xsnC4nm73g9rSKOMGsX86JBudP2lKFHK5kc6IuYoGmX04MO9VbkG2cJ0ucjKCUcQksu2MlsJ4gWXK7OdR74OHVpmHeGzkF1J4wrss2dA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=google.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mn9ld1gVFfd6wg4+Ebt8VC8FCqe18cp2d4DjwP94yec=;
 b=XblU7YvEPZCfnQXcLiBMIc9oBMSm3MRSU/rrX07+Lw73WGxpuNJUN6mFRkfupwl0MfSaXNUZOgLgp3ESyPw4vEQFLXcSj0ZlqYN5YELHuRh1eT0TJeDS/ofpaaY1Z7n+Q64P8HjMXGDPKwNjbBzr+N73XJArq4Vnb99TW18Jumw=
Received: from CH0PR08CA0007.namprd08.prod.outlook.com (2603:10b6:610:33::12)
 by IA4PR12MB9833.namprd12.prod.outlook.com (2603:10b6:208:55b::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.9; Wed, 11 Nov
 2026 15:12:20 +0000
Received: from CH01EPF000BE942.namprd02.prod.outlook.com
 (2603:10b6:610:33:cafe::3a) by CH0PR08CA0007.outlook.office365.com
 (2603:10b6:610:33::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.615.8 via Frontend Transport; Wed, 11
 Nov 2026 15:12:20 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CH01EPF000BE942.mail.protection.outlook.com (10.167.244.134) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.615.4 via Frontend Transport; Wed, 11 Nov 2026 15:12:20 +0000
Received: from [192.168.0.108] (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Wed, 11 Nov
 2026 09:12:15 -0600
Message-ID: <771dd3be-0c64-4d40-8dd0-de63b3867f70@amd.com>
Date: Wed, 11 Nov 2026 20:42:12 +0530
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
CC: <sarunkod@amd.com>, "H. Peter Anvin" <hpa@zytor.com>, Borislav Petkov
	<bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, Ingo Molnar
	<mingo@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Thomas Gleixner
	<tglx@kernel.org>, <kvm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<x86@kernel.org>, <vasant.hegde@amd.com>, <suravee.suthikulpanit@amd.com>
Subject: Re: [PATCH v2] x86/kvm: Use RCU for svm_vm_data_hash
To: Sean Christopherson <seanjc@google.com>
References: <20261111122128.12998-1-sarunkod@amd.com>
 <avSD4O4AELPcmhqb@seanjc-mac.roam.internal>
From: Sairaj Kodilkar <sarunkod@amd.com>
Content-Language: en-US
In-Reply-To: <avSD4O4AELPcmhqb@seanjc-mac.roam.internal>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH01EPF000BE942:EE_|IA4PR12MB9833:EE_
X-MS-Office365-Filtering-Correlation-Id: 2b0ca4fd-1d59-4971-58be-08df40062e8c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|1800799024|82310400026|7416014|23010399003|376014|18002099003|22082099003|4143699003|11063799006|10067099003|261028144727099003|261026140227099003|261026121527099003|261022105027099003|261021123027099003|56012099006;
X-Microsoft-Antispam-Message-Info:
	MqJxdh6tKmJ7XqKChQxmB5WT6c7zty6LBXOrbZw8ZduTXZZF9zhbC4EvzUHibdcWIJQnjmCZz7BZvg0q79mQAS/bOMSaxUXibsyafVrYvkkggNseTMXzBKj2s00JewPKpIoKDlvDmuNDds0m7umaqjDNa2zEkkddJcmj9CVZ/M1ny/Z7/IwX9/r6XLohOphdkvTONJp4yIE/6esCq7X2xgYWwQUVdJ+3g2VrL8e8K23sL7/XXhse1D/ogL+tHJdSVQtKda2GkJGVzRYyxnr9IasgttBykA5Ru1+IdNEWsd0rWi7Nm9Yzfhfnr8bUn5IzhjX7M9IsOH+rC6dCsoFKXTe6CZl4m4ZFvXGl8+cFqJeRPOSfKCCmLogySzf9ZiXlyX90YKD6juzx0Pm5R9XLR2ATgXbztUYJsTik9aukF3LcEA1P+ElhU3JcqpKM3pggUKagYv93L2XhLpJVRHvuP1yPrGqG+F0Wdit9jdxYKLhNyqV1vtkostByJz+NsOn90AJjnDXR1i+N/YXYfRsLCPzQXw2Q3MkigL5hpkkz7eiqku4/QVMR0c2TqQdgYVSfb57WQuoVsWnPiuXxqFTC7n6PBmQIBNLpFvP8BkxAfxR49GOXzko03t5wKI0eic8bWwMMV08CJnbSkBR6jpNNWEfW2EayHvCVfdgV+jHtFAzfe+RZ2UV5mu/yBBbOPJaPzrE159TkiU7t5e5dFVu6lw==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700016)(1800799024)(82310400026)(7416014)(23010399003)(376014)(18002099003)(22082099003)(4143699003)(11063799006)(10067099003)(261028144727099003)(261026140227099003)(261026121527099003)(261022105027099003)(261021123027099003)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	1U0Qwa0D1E+zknC7rEzPozuk3Gf5dgRZdHloc8tPA6JQS1wHCRJaPVksXLRrlBaeu9dFgQglPhekBqXAZIMyZcEFCsbgNebPzJOaQyS3VIg3trOKKcUhLiWVWdZ2S5uFjB7qEj28zcewISbdnPYKS3ARFEs9Cr+wwDkIR8VTe9+Iayeis7m6wCZsh6qdGE/icikcrepivS+mkJGw3q30zeVSKwFQZffLpfpb7fDF6YU0YXk0jCUEtxtVbif4V/o2p/cXfijb7WmboGZn3nzeVde16rHOl/msx6XI/PNTkuWw/5VUl+jiKKrgnPwKd3pXGBVGp13voQmgjAL/eOrrQv69l6d2cgJcBK1+wL+FDLOpntShLDYBxmQmrHjYmM/iZjI+XXFt43piid6hJ7QRxq64qCMf4/KTqjwEvCYu2BoMwG8iALlo4lsQ4oAJoAJR
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Nov 2026 15:12:20.4283
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2b0ca4fd-1d59-4971-58be-08df40062e8c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH01EPF000BE942.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA4PR12MB9833



On 11/11/2026 8:34 PM, Sean Christopherson wrote:
> KVM: SVM:
> 
> "x86/kvm:" is specifically for guest-side code, e.g. arch/x86/kernel/kvm.c
> 
>> Changes since v1:
> 
> In the future, please wait the "normal" amount of time before sending a new
> version, e.g. a day or two for something relatively simple like this.  I.e.
> treat feedback from Sashiko like feedback from a human reviewer, and don't spam
> patches.
> 
> There are times when it's acceptable to break the "don't spam patches" rule, but
> this isn't one of those times.

Hi Sean

Sorry about this, did not mean to spam the patches. I accidently sent
wrong version upstream, thats why decided to respin it. I'll be careful
from next time onwards.

> 
>>  int avic_vcpu_precreate(struct kvm *kvm)
>> @@ -373,9 +373,12 @@ void avic_vm_pre_destroy(struct kvm *kvm)
>>  	if (WARN_ON_ONCE(!enable_apicv) || !kvm_svm->avic_vm_id)
>>  		return;
>>  
>> -	guard(spinlock_irqsave)(&svm_vm_data_hash_lock);
>> +	{
>> +		guard(spinlock_irqsave)(&svm_vm_data_hash_lock);
>> +		hash_del_rcu(&kvm_svm->hnode);
> 
> Eww.  Don't open code scoped_guard(), e.g. this should work:

Ahh right, I missed that.

> 
> 	scoped_guard(spinlock_irqsave, &svm_vm_data_hash_lock)
> 		hash_del(&kvm_svm->hnode);
> 
> 	synchronize_rcu();
> 
> I'm a little hesitant to put a full synchronize_rcu() in the destroy path, but
> in practice it's should be ok.

Thanks
Sairaj

