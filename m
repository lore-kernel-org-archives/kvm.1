Received: from PH8PR06CU001.outbound.protection.outlook.com (mail-westus3azon11012010.outbound.protection.outlook.com [40.107.209.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96CBF288AD;
	Tue, 28 Apr 2026 19:24:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.209.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777404293; cv=fail; b=S6S9Pck1/rKJ466P+2TQ9xRtsHz1LwNWCtixOektGtE6y7HQ9z5bgeOZ5Z0/FaDOU2SrKNqs2ptc1ArsepYAMbUHjL9juC6gHwyZvz5NOcAPTeRp0Px/0el0KI5rHfyyv7ymowG384zxQ1ZBhGeL7m/Jrle4jAAgi/V7WkAmwIs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777404293; c=relaxed/simple;
	bh=P7Gq4zTeCKk8QZogeoT7zzft4D3zBRRXIYjYqw7xlnM=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=szZ7SGgB4kxZPmqo5OIsoxeGHDh5WGMGl17YVVKMZXy35BWYlKxX5fMZCuIrMWavx5U4xqjnf0lVlY1J8+DEKMRyZqJippVkegagg/re/fd2AZGfCFy6IOexAu0YwahBMgoJr1OB692aGVg09InVn4VxqblPFCa0pnTarhp8wVU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=GRu6cqWY; arc=fail smtp.client-ip=40.107.209.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="GRu6cqWY"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uhy0tt+botZdcFrqtthTKveSeGD86XbVvUzjIfMDwcs6Utlc7YikR8S2PJUfxbTgD9n8PwsbR317MKkgoq303gCy1he23JYoY6KEb9Ce7FKEdCGC0INi6yfPur12qhRZg5M/FcB+ZuBLAEVqlLhiFZ48ohGUvFm8zXpPSRb7D2iiUogKInuFgQsNwbpwvZPyUxaA0xsqRZF4B2vzYT7jwS87xHtcLNiRuEkUVquxaw+npfw5Deg8TCVBRFNdpIw6M/k9QO1O0KDkgcz1AHu65/blnoUUmSoZugbfZVYa72dgoPSqu2l2rzGM8TqPnunCT5EPw38M6sVDYFZe8dI1mw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QpQoVwh/bLL6eneyB9XQZp7s9ymrW+90SNU4ltyHo+c=;
 b=aWgRVqzsTsKda+5bT2rFMW1Q9AxxPLxMrrludTCspxSalYto5haGBGTU3Oofw76LSRMcArvBx6ZLR7I0K0BbVGwXvnAFlzKK42NksVzg4XaHuGA58T2NrdGvPuveyCt3A7zPqC5t2m31wZme6woSGIXudwIzhtMHvMwlyM1IQdk06OqHwu4h2hpDeMSQ8fwcphf6FQofkglFH83V3CcVLe/hFI8DSERAlmCairQK5HS+PnnSaE9IwsUFoUeOGfEVaRHzFj6INyIm5GxKJ4WCWUBuls9qjUEzEgy05CYaTmKFOYml6g0UsVQY6Zgpry2RDZfa4BYwkTkjCrcI+CydRA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QpQoVwh/bLL6eneyB9XQZp7s9ymrW+90SNU4ltyHo+c=;
 b=GRu6cqWYZP7CwV/IPnKqVuE6C/vMbFtvHdlT49P3oj00OkSaECp62agThKgc5BONZRMJF7ZORG4hWFJsklpCJF/64/na2pWQ+nJHfV0phGg6WaETsmZfjVGu/90UOVYRcJ1QkxnSXJiBwVaPOw+xBPgAveY9ed/AY4jbxQdTqI8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5070.namprd12.prod.outlook.com (2603:10b6:5:389::22)
 by MN6PR12MB8566.namprd12.prod.outlook.com (2603:10b6:208:47c::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.17; Tue, 28 Apr
 2026 19:24:46 +0000
Received: from DM4PR12MB5070.namprd12.prod.outlook.com
 ([fe80::f3f2:852c:78d5:9353]) by DM4PR12MB5070.namprd12.prod.outlook.com
 ([fe80::f3f2:852c:78d5:9353%4]) with mapi id 15.20.9870.013; Tue, 28 Apr 2026
 19:24:46 +0000
Message-ID: <c1e1f24e-3407-444d-b17a-9c543d8d3edd@amd.com>
Date: Tue, 28 Apr 2026 14:24:44 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 5/7] KVM: SVM: Inject MCEs when Restricted Injection is
 active
To: Melody Wang <huibo.wang@amd.com>, Sean Christopherson
 <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Joerg Rodel <joro@8bytes.org>
Cc: linux-kernel@vger.kernel.org, x86@kernel.org, kvm@vger.kernel.org
References: <cover.1777048608.git.huibo.wang@amd.com>
 <51f8c478c5fc09b3bdeb8329c682a01fbe0ea5db.1777048608.git.huibo.wang@amd.com>
Content-Language: en-US
From: Tom Lendacky <thomas.lendacky@amd.com>
Autocrypt: addr=thomas.lendacky@amd.com; keydata=
 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
 WiyqywZI5g==
In-Reply-To: <51f8c478c5fc09b3bdeb8329c682a01fbe0ea5db.1777048608.git.huibo.wang@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH0PR04CA0087.namprd04.prod.outlook.com
 (2603:10b6:610:74::32) To DM4PR12MB5070.namprd12.prod.outlook.com
 (2603:10b6:5:389::22)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB5070:EE_|MN6PR12MB8566:EE_
X-MS-Office365-Filtering-Correlation-Id: 14609414-86be-4fbc-b2db-08dea55bce96
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|1800799024|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	Tdqg2iev1R70wcvQme/zr2wO/j82vHFgSPw04pn/SjB6KMkXbzBPaFtgIuQ98plWk6ZHh5gcuTbGTsOmo1M3Us9BbyYePxusew1bbGgG/1I5dECJQnPMPqOLG5h3D00fPfScUY3ZIh3U0k2t+7saL4B7uqOy7cQMQJyeEDODPKZ5cmISbFY9JpbvpZDzYLvn+08Rfo8ibOb/d+vIG5kr/PMHkGcIn1VUDOzbwc/eoatXk3kr4BU6LKmFqnkiBSbVleQOAU7m8yHZUoBZanJKQ55zS7LU3GrQbSH0RrlfYgP/vDm+lWDrFA2POL/ihPMCddMBQIjPHPfo9qkatompEldgbCjIiuXor/+5c9cJtKitpHvrz/W2+NGhTZH5MjVLwF/ENUeFI8201W/uIMcc0jI1HorTYFPs19rvYXEpdPN6h92/lR1pf4UkSOKK9x9fBqTTaKUT9DvjwMoIA00wZ2Grm3rTmMh4yGigb39Pfaz6R+pIXVQDhUS6zk60PGotb7Dd5e+DCxXVyY9QBFFRmRhxF1bq4AZ2DyiMZcsdvx8n4YTWxSh+eLzcX2MlCDDwWhJns2yeB/p9sIbEvtGDw29j7qv2K1zfGRP0m3clWTZjFpreT7hH3VBcbmxZVDzBXeb1OcoZ5Q6VCgxlGnQM8D4M4pHbaQi7QIelTHeSVrqxEJVMtwEttoJ40KIPBo4X+hkh/+BoZyEvv//CPbZn3os4SPXrtuWqno/i0G7lKGQ=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB5070.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(56012099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?cElQS0VxcGg5QzBvRE1uK1JrR0QrVUYxSXdWM05yTmhaeHFtNHBZNy82Mlk4?=
 =?utf-8?B?cmxwRTZidTdlQkVxUUMwNUNDQ0V1K2FCOW9IWDhnaXZiQUE2K1FEanZsT1FX?=
 =?utf-8?B?Mk9oSXFqb0VIcHNGWkVzQ25mTktlUGRZVWdiNTlTL0VwYzV4T1hNVTVTMWNK?=
 =?utf-8?B?dzdVQmtvd3d4OHlpalJGaWtHRDFobGVuVXU3RmVKeG5xVmVIeFNQbE5KWXhj?=
 =?utf-8?B?eDc1V1JvakFDZ2pZcjlwRG1GUlVyeVpadnZSMmVRdXo5d0wyUWRscU9yanMv?=
 =?utf-8?B?VTBjSGY2b2Jrb0V0SU1udzYwVGVkTzNOdnJDMUR3L3Awd2ppM3dnRjZNOERu?=
 =?utf-8?B?QkJuUXB4UHFUNjZqdFBPekF6SWhTWWhHTTZtcEIzcnlpSmJjNnh4TERicDdj?=
 =?utf-8?B?NXZJQ0lxNDl0ZjUzc2hEanMwUlp6Uno5OVJhMFNLMEJVODArT3M0R1JzelZL?=
 =?utf-8?B?NW5OTDFRL3dIRm9QZTBVYjhUOUhEbmdxZjUwcFRyR0ZUQnd2VC9LcnNVdWQ1?=
 =?utf-8?B?QjZUSEFRYjByVi9wOG8zQzJPQlNZeW1GbXlZdU9MbnRTU0wxbm15MndLMXdt?=
 =?utf-8?B?OTA1emo3aDA4LzNKMU55TDV2NG9HbC9vY3d2NjhGNXUveFZQb2VUM20xaWIw?=
 =?utf-8?B?TElEQ1l6SE5mVDVZRXh2a1MxaG81QVBleFBPZjVqdzA1UDM3TWZMU1FxcU92?=
 =?utf-8?B?MEFuSnFEYjA1R3o1a2ZMZ2xBdnVEQXEvK3V1bThLZVNpcG5LS0ZYaUZOUVhS?=
 =?utf-8?B?ZEVzQyttWjhxWUtTMlB4RWxxelB5SXh0TGNjWHJJenN5NTJzNjRNRkxhRGRK?=
 =?utf-8?B?cG1KYlVxQzhCVEFXMGtYOG1JMVN0dllxRnpoS1lhNlBpR29yT1RodTQydVFr?=
 =?utf-8?B?MS9BZjRpZGdDVUw2WjdIUFRQNnlJTGQ0Q2xrNmVYRGV1cm9ia01ZUUk0YWZZ?=
 =?utf-8?B?ZVgrbEFHSWsvR0poZ3lqa2NCZ1FrK2RORnBsQ0dUODAxa3hYazY3d1lsR0Zj?=
 =?utf-8?B?TkdKSU5ORHdOM2Ntb0YwOS90Q2xOeDF6RjdnRkdzWDQ3blRMMGUwRDA4Ukts?=
 =?utf-8?B?elB6VzRwZGIzREY0SWQrb3M0a2RDUzFrTHdOOVRWVGsvSmRoQ1RDSjdCQVBx?=
 =?utf-8?B?K3pYci9YU3hyckVNZFhVVXlPanhNa0E1bXZJZkRFbnU3Wm5UKzlDdUZVb3F6?=
 =?utf-8?B?TUF4MmFJREw1bEFUc1MyS3oxKzdKZjhqWUYrZGlCb0dONkw4UG5FNjBTc3lW?=
 =?utf-8?B?YldkRVNEeDA4dEV3Y3Bhb0NGMkV2VzNNNlNQbFVabHY4Y0lGRFBIeW5pT05T?=
 =?utf-8?B?cnRQWFdxc0RwOUdGWkJaZSsybXFHNncxeGUrRmcyb3dUeUNHSk5ncHBIMkhG?=
 =?utf-8?B?Tnk1VTg2MlpSWGtlelRmR1pnMHN5Vjc4VjN5MFRMWTdwQVU3SFF6R3NvOHJI?=
 =?utf-8?B?NWQxNGVqY0JYK1FVZlZodDBCRU1mVmZSdG10TDZWL2NHWTB2eFp0ZkovQ0d0?=
 =?utf-8?B?UmFJa1lhYzMrMTc3dmV0bnZrV3BBS2RwVU5RMlZzTEozTUZkdVZaajVZQmww?=
 =?utf-8?B?N2d6b3ByVE5FSm5jVlN3STRkYjB2WVJLMkwybStJTWhuU3U1QklvK21hV05V?=
 =?utf-8?B?Yi9VVk1idkxUdU1MNWRPSkJqS2FBcUpuYzdFVEJKa1c3d2hDcHd0OEg5Sjhl?=
 =?utf-8?B?V0w0Tmd3T0FZaHJUbCtEeEd1T0tLUUhMaVRYUlVYTHdmTmdIT2xQcE45Mlg3?=
 =?utf-8?B?aVNNVE5aSDh3R25QL29XNnRlUThTNlJIcXhwMFRDdWVFeFcwa0g5b2N2WEFY?=
 =?utf-8?B?TFYreHdXMVAvMjQ4ZzBEZFBEUnVyYytPZFhlREhIVGY4bG85dlhvUGEyUkcz?=
 =?utf-8?B?d3MrUmcyU3hTQnJIeWc1d3ZxdUJaNCtlaS8ydlRCQWdCTjJzc0FJK3VhbG5i?=
 =?utf-8?B?ZFlRcjRPU0kxekY2ZExZT3FoNGpnUVdCVkJVRkZDMm9tYlhTZ2dDeGU3bkIw?=
 =?utf-8?B?VW81Mlh1UVl5cmhybXM2Tzk4Q0JyNElNWUtXOFZ3TXhvUjRjWXlpbDFPcU1T?=
 =?utf-8?B?Tmg5ZERoWXc1aEtTTHJURzRyTDBSZnByemN5cythb2tnelRwakhkWUl6STd2?=
 =?utf-8?B?NnUvVFBMZ1JQUElpSlJ3VUdUeWNlNERMS0loaUkzU1Q0MEplQ3ZkeXI2czR5?=
 =?utf-8?B?UVlyd0lNNi9MVWdQVTUyMkNJMkJVRjBRQmlacmNvQ0F3blRJME1HWTUva0Zs?=
 =?utf-8?B?YlhuZ3BLWEZpUXN1Y0pLTnIzOXFUN3lTa0d6ejY2SVN6RHhOQ3NVZHdIYkRv?=
 =?utf-8?B?N1lxL0cxZWRHV0lvUk1FdHhaeU1NNzVVNi9zUExvKzJqd2VEZHdQdz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 14609414-86be-4fbc-b2db-08dea55bce96
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5070.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Apr 2026 19:24:46.1483
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: f+3F2b4l1fo8YJSCM+rq3nqKMwI28ROCNNEWwd8B9s0a1wbWukvl5NmzmH9KQxOgPFgi0Rfwv+6vfxfEQ/BtTA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN6PR12MB8566

On 4/24/26 12:42, Melody Wang wrote:
> When Restricted Injection is active, only #HV exceptions can be injected
> into the SEV-SNP guest.
> 
> Detect that, and then follow the #HV doorbell communication from the
> GHCB specification to inject the MCEs.
> 
> Co-developed-by: Thomas Lendacky <thomas.lendacky@amd.com>
> Signed-off-by: Thomas Lendacky <thomas.lendacky@amd.com>
> Signed-off-by: Melody Wang <huibo.wang@amd.com>
> ---
>  arch/x86/include/asm/kvm-x86-ops.h |  1 +
>  arch/x86/include/asm/kvm_host.h    |  1 +
>  arch/x86/kvm/svm/sev.c             | 16 ++++++++++++++--
>  arch/x86/kvm/svm/svm.c             | 17 +++++++++++++++++
>  arch/x86/kvm/svm/svm.h             |  2 ++
>  arch/x86/kvm/vmx/main.c            | 10 ++++++++++
>  arch/x86/kvm/vmx/vmx.c             |  5 +++++
>  arch/x86/kvm/vmx/x86_ops.h         |  1 +
>  arch/x86/kvm/x86.c                 |  7 +++++++
>  9 files changed, 58 insertions(+), 2 deletions(-)
> 


> diff --git a/arch/x86/kvm/svm/sev.c b/arch/x86/kvm/svm/sev.c
> index 61e1e54deb07..2483357bdd97 100644
> --- a/arch/x86/kvm/svm/sev.c
> +++ b/arch/x86/kvm/svm/sev.c
> @@ -5371,6 +5371,8 @@ static void __sev_snp_inject(enum inject_type type, struct kvm_vcpu *vcpu)
>  
>  	if (type == INJECT_NMI)
>  		hvdb->events.nmi = 1;
> +	else if (type == INJECT_MCE)
> +		hvdb->events.mce = 1;
>  	else
>  		hvdb->events.vector = vcpu->arch.interrupt.nr;
>  
> @@ -5386,6 +5388,11 @@ bool sev_snp_queue_exception(struct kvm_vcpu *vcpu)
>  	if (!sev_snp_is_rinj_active(vcpu))
>  		return false;
>  
> +	if (vcpu->arch.exception.vector == MC_VECTOR) {
> +		__sev_snp_inject(INJECT_MCE, vcpu);
> +		return true;
> +	}
> +
>  	/*
>  	 * Restricted Injection is enabled, only #HV is supported.
>  	 * If the vector is not HV_VECTOR, do not inject the exception,
> @@ -5454,7 +5461,7 @@ void sev_snp_cancel_injection(struct kvm_vcpu *vcpu)
>  
>  	/*
>  	 * KVM only injects a single event each time (prepare_hv_injection),
> -	 * so when events.nmi is true, the vector will be zero
> +	 * so when events.nmi is true, the MCE and vector will be zero.

This is confusing. I think you mean to say

so when events.nmi or events.mce is true, the vector will be zero.

correct?

Thanks,
Tom

>  	 */
>  	if (hvdb->events.vector)
>  		svm->vmcb->control.event_inj |= hvdb->events.vector |
> @@ -5463,6 +5470,9 @@ void sev_snp_cancel_injection(struct kvm_vcpu *vcpu)
>  	if (hvdb->events.nmi)
>  		svm->vmcb->control.event_inj |= SVM_EVTINJ_TYPE_NMI;
>  
> +	if (hvdb->events.mce)
> +		svm->vmcb->control.event_inj |= MC_VECTOR | SVM_EVTINJ_TYPE_EXEPT;
> +
>  	hvdb->events.pending_events = 0;
>  
>  out:
