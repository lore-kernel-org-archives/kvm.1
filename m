Received: from CH1PR05CU001.outbound.protection.outlook.com (mail-northcentralusazon11010061.outbound.protection.outlook.com [52.101.193.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C2A23B42F8
	for <kvm@vger.kernel.org>; Wed, 30 Sep 2026 22:29:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.193.61
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790807387; cv=fail; b=RTKzo0ypnE7YeGz69dJBhD88wreixbSqhEqyR9gEpkWqpR6i9U+lrfGBIc0iEV9vkE8PGg616+XNSekOEagGgH/CIb5TjQU2sFwUtzhPy8k2moKNHlVU9pKcc05oizHdqHd8RjxVMbQXfXV3H4v5l0awfUsJlG0MXzsco9eW318=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790807387; c=relaxed/simple;
	bh=WLZ7p469XxmGA2TJdO9t9hq+LmfqYanAbIPWs7W4j9k=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=vEyYc+TL3whiJ4TEMkVwBjsM4LK4L2XEzMuipUQFpd1VM3T9y75kBo+DhxA95glb3tlwX3WGShUREnTgdRiDkBe2tI5AJNJDggwF2vXD7XOAG2rnvTX5xT4Lh6VPYEvq6N+NUQWBEGjcGvO7ddVzHQEw3bcX8VFJvzvvbrGBYgQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=f8CyAD6Y; arc=fail smtp.client-ip=52.101.193.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="f8CyAD6Y"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NDGd/ugyscK52dYupah3BjS9dMUs5MFXyQE54z2CAyjUJeVjRAWQ0/XjCeDPu0YnhJP0G787NkQW0Ag9hubPg51eDxyvTpTJkY6RaMNL2su00RDjjbUTy8IrjkW5WsLZVLjvrtEFYLpi+KunhGz0thWhwgdusin8eQAv0p/voC0cZDgs4ECKeKSkRhRkqSmFs4y2tWIIBPO7xcdz6BsYw3LoVDj2eReTClVojYWTeShJBdfBx/iK8HHN9V6R82VZ072dLezW0SWj38cbL5auPl+gX8Xv39sgsJTs8guRVhLv/PcOJsRNFM28HtMyz2f+NRCIp6U4n33oS5S/AW8U+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iVLQEU5mk2tH3M3m8KoHm09DqD3x/ZJtCE1jPJU4NzY=;
 b=PJ+fyUHuBWOWnfVLX3tphxKXuH1R4133CmdHs278Do2Ppb5SvRO5L5Pjrj0yVwGDeD6iw1DZY5NON56Z3XxWI9il4zXC8BG8IXnDceUQt7vWOSrRPXmq/NIG9Awuri21kvd5VtDHFTjhLJRqwVpm1XFgnOInNOm2+nws3czomLKhG4qw1UcRRlch5+cm/xTMxx0Ua9zbDlXFW+UdDaZEnZKkAo2OXJjjFw6GjlfDYlFO/czQw4q/D3LxGEYVNwD0tuOMqBi0+Vb0j2SH/NEGh6ZwqhyJXSzSXauOTkzrnOtw+5C+wlMI37HfecxdHlA0libNa3qzrnpA/HI+0CVleg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=google.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iVLQEU5mk2tH3M3m8KoHm09DqD3x/ZJtCE1jPJU4NzY=;
 b=f8CyAD6YZhmUaNrpMZFqoAtuDsgb5w2AHHH1JNOgTZOxALYIeUoP6XHpJsjJGh/ol3OJHnpl2JyvjgSbuArw7XJ4Zc7mPglEPDLeXsYYkiRosBegqdZU6tm3vhStqcKPyyb6r9Z7l6yTpcEuUYgcHKRHM7xHxul90L5r/vQLrsk=
Received: from SJ0PR05CA0141.namprd05.prod.outlook.com (2603:10b6:a03:33d::26)
 by SJ2PR12MB8943.namprd12.prod.outlook.com (2603:10b6:a03:547::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.26; Wed, 30 Sep
 2026 22:29:41 +0000
Received: from SJ1PEPF000037B4.namprd05.prod.outlook.com
 (2603:10b6:a03:33d:cafe::15) by SJ0PR05CA0141.outlook.office365.com
 (2603:10b6:a03:33d::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.472.16 via Frontend Transport; Wed,
 30 Sep 2026 22:29:41 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 SJ1PEPF000037B4.mail.protection.outlook.com (10.167.244.196) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.472.14 via Frontend Transport; Wed, 30 Sep 2026 22:29:40 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Wed, 30 Sep
 2026 17:29:40 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Wed, 30 Sep
 2026 17:29:39 -0500
Received: from [192.168.1.13] (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.49 via Frontend
 Transport; Wed, 30 Sep 2026 17:29:36 -0500
Message-ID: <20b2ef29-c87d-45f0-9977-5a1d9d5bc69d@amd.com>
Date: Thu, 1 Oct 2026 03:59:35 +0530
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 4/5] KVM: SVM: Turn DEBUGCTL_RESERVED_BITS into a
 helper
To: Sean Christopherson <seanjc@google.com>
CC: <pbonzini@redhat.com>, <tglx@linutronix.de>, <mingo@redhat.com>,
	<kvm@vger.kernel.org>, <x86@kernel.org>, <yosry@kernel.org>,
	<jmattson@google.com>, <thomas.lendacky@amd.com>, <nikunj.dadhania@amd.com>,
	<ravi.bangoria@amd.com>, <santosh.shukla@amd.com>, Shivansh Dhiman
	<shivansh.dhiman@amd.com>
References: <20260721050600.87268-1-shivansh.dhiman@amd.com>
 <20260721050600.87268-5-shivansh.dhiman@amd.com>
 <araypKKIb0-Cp_iL@google.com>
Content-Language: en-US
From: Shivansh Dhiman <shivansh.dhiman@amd.com>
In-Reply-To: <araypKKIb0-Cp_iL@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF000037B4:EE_|SJ2PR12MB8943:EE_
X-MS-Office365-Filtering-Correlation-Id: de916c53-aec0-4ffb-5279-08df1f4251b8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|1800799024|82310400026|376014|36860700016|22082099003|18002099003|4143699003|3023799007|56012099006|10067099003|11063799006;
X-Microsoft-Antispam-Message-Info:
	gPrrG+SqpADI6LvLJ9QjeKqQ3JaRvCXeUyfR/uuA9eVtDFGPCwf6yZ9Druubah3/d/XApH+5AVwq2dnxRCP4YcNlrFZyswd+6ISv7w5gXBZQI/Hw5c20rYYZwADV5IB4YysbicQjQ6NGnL5ni4bGD7SknqnR7Tiv/Z+7MfftNg84gKe4NihqeGVCXKcTXyvFCPe7jvCy9Frydd++be6krDk2EjK12X3AVW8/FWdEszoSKJGEewJ5EpxMAOcd4SCYvwRjhDSSvwFXzF5NLh61164zNiYd3QyK5yvgQ1ldFui5WO3s8YcPVpt65WewfdlRpF6DII5gDqceEl/hAbZrsBzrpA6Yb1AagmJhwUhrOlRqL7hqXST6STiaMVkHwEURg+M0OEcVQ/TJ9LCIY2znL8vgqf/9SgnRnQop/p7Ie0faRiHHISlbxIMZmnsCrvT5Q5xEPSOwCEWi1YqkOsz5+2s7+tN2RNkyV1F8JulwgNXAKTSIqocgYCnYonyD9OBMR+DgKwAyNb+Znz+GtWNCkaRt3JIs8zVR0cPpvj3wDCLJqFEK+NA7VjX6criphEoE+1NgHPq+0iW5rX7q1VWJHnpraHN1ssPKGsN2KqsSagITRteR0o7sjya7Ik4yMa5vGVy3uArDK19teLKYiqHx5D4mCEbyEW3Kk16kUzu8D2YaBs6O30xo+Z/L3g1zJy4FhjWn0nTIcLSGqTV4NsB4Aw==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb08.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(23010399003)(1800799024)(82310400026)(376014)(36860700016)(22082099003)(18002099003)(4143699003)(3023799007)(56012099006)(10067099003)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	DnbiSU70hoolldHVykgzk2eI1ICk7s19H1LVXtLPD9bgWKa0BJHYn9LDPU4i5vQpq2gmrYvhqae7CizdKTACNWfetTJk6Ysfnp+bwfWNuI21HwcuMKljM067k739Ezc+3agAMiW4v8Q3UGKzsAq1UvfztwSMXcETzQRCPVcVlKylao4g1nVKDvRgR6MEV7vslpltF1wHdlyN0p3Jm/8C6BMRM26ffLzgrXzyVljgLTOPo2Fda+es6w+gdpkVhNv3nUolKqr1OZCN3ae9ua1UMR3p+ad3z3psWFhQD95zy0BzHnCimNqd49Fy64dSUJdZmBQ08Iaz5kNUqSshZXL9n1BUG09JuTEBNtSH6k7OmlfeLbV1pEtYOWBaREJ0g88Y0H8lINxlbASJ/RaqzV5uB1xax3lzHIjxpC0oTLK2dZoQMp/M6zH6IN+ROO9O5Xoa
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Sep 2026 22:29:40.7962
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: de916c53-aec0-4ffb-5279-08df1f4251b8
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF000037B4.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8943



On 25-09-26 23:13, Sean Christopherson wrote:
> On Tue, Jul 21, 2026, Shivansh Dhiman wrote:
>> Replace the static DEBUGCTL_RESERVED_BITS macro with a helper,
>> svm_get_debugctl_reserved_bits(), and plumb the vCPU into
>> svm_copy_vmrun_state() so it can be passed to the helper.
>>
>> The vCPU argument is currently unused (marked __maybe_unused).
> 
> There's no need to tag parameters __maybe_unused, AFAIK no compiler ever complains
> about parameters, only local/global variables.

I remember my compiler giving some warning about the unused parameters IIRC.
So, I added it to preserve clean builds between patches. Anyway, I'll check
my build environment once.

>> diff --git a/arch/x86/kvm/svm/svm.h b/arch/x86/kvm/svm/svm.h
>> index d52010e4de97..696f1b4b8f8f 100644
>> --- a/arch/x86/kvm/svm/svm.h
>> +++ b/arch/x86/kvm/svm/svm.h
>> @@ -783,7 +783,10 @@ BUILD_SVM_MSR_BITMAP_HELPERS(bool, test, test)
>>  BUILD_SVM_MSR_BITMAP_HELPERS(void, clear, __clear)
>>  BUILD_SVM_MSR_BITMAP_HELPERS(void, set, __set)
>>  
>> -#define DEBUGCTL_RESERVED_BITS (~DEBUGCTLMSR_LBR)
>> +static inline u64 svm_get_debugctl_reserved_bits(struct kvm_vcpu *vcpu __maybe_unused)
> 
> The polarity is cumbersome and annoyingly different than VMX, quite silly since
> most paths care about supported bits, and the resulting code once BLD comes along
> is downright ridiculous.  Invert the polarity so that we end up with
> 
>   static inline u64 svm_get_supported_debugctl(struct kvm_vcpu *vcpu)
>   {
> 	u64 debugctl = DEBUGCTLMSR_LBR;
> 
> 	if (guest_cpu_cap_has(vcpu, X86_FEATURE_BUS_LOCK_DETECT))
> 		debugctl |= DEBUGCTLMSR_BUS_LOCK_DETECT;
> 
> 	return debugctl;
>   }

Checked the VMX side of it, and this looks better. Thanks.

-Shivansh

> 
> 
> instead of:
> 
>   static inline u64 svm_get_debugctl_reserved_bits(struct kvm_vcpu *vcpu)
>   {
>        u64 debugctl = DEBUGCTLMSR_LBR;
> 
>        if (guest_cpu_cap_has(vcpu, X86_FEATURE_BUS_LOCK_DETECT))
>                debugctl |= DEBUGCTLMSR_BUS_LOCK_DETECT;
> 
>        return ~debugctl;
>   }

