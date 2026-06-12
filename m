Received: from CY3PR05CU001.outbound.protection.outlook.com (mail-westcentralusazon11013044.outbound.protection.outlook.com [40.93.201.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C6EA23EAA4;
	Fri, 12 Jun 2026 05:34:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.201.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781242477; cv=fail; b=WGzJfgnUPP0NEOiu+ghTkn5ivRAau2MSc5tQn64e+STkzuepdniCeQC3uQX+mssYeNLOEhmwsZpUQoV3y57kbSj8Vcn10fh5oqVhKwr7pKdLd/f963xcrzhQ4rBquZkqIFkF6bc83FuHjgeTj0uCSluvK9H60tn0G+eqL+4xZc8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781242477; c=relaxed/simple;
	bh=0U7qhu8DhPD2OoPQAZLHvQV12AE9mDSYk2d/aqFpqBY=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=C//eXjAj799qYIADARPQPfoYaPR6cLR9+YNNdaQh4jkQnQxG93I1o1F+6OmFz6OxTr26IsAdmx7xYF1B7tak5w1sNkfpe0zD8elGf33WcU7eSK3DXJ43+QWCog9zzrGO6NwADfUdXuat6HTSIKG4rFPXpJVy89JsP03XzRyfKjg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=csN/PUul; arc=fail smtp.client-ip=40.93.201.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="csN/PUul"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tlECit7iBQKQblxMwCcopQ0Mik2RyI/h9ixIsXrtdgxLISE9xWBR0VNZlh1tasUbx3V3z/hNvj/O5hiH6gNwl+hBdxa/c8YME5mzAP91ofV4M4wzKxnqi+vcX2wvneUmhkTANRMfkfIL2P+p/F/6Ei2MwkWzDgie8urP9CFkQkRt1TtouJT5BSD2S80FmBywfFOCg7UtTEmj+38JS5KIxJxfOhFzVgADn48BkWUlyce7jm/djXELyfRZBVTWJCh+Dtv8ctkOeY4NDgV0vbellHCDNQHKgmCR8l4OQuyx/OsTiXTtxRE3bebCXLn8Cwb63Kb+dE1I+K7hWQmyWdS0FQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Tx8J5tAPbkK25L2ne8Wbt20H/iSocxAMvfiC3cLcN4Y=;
 b=ik0dGVrCVUpnCLSX/1MplttD65WWbbGe95aqDSuiuRf2OaKeqMPFH1JVfSS7nmfYrgqcAO0PCuWWkGUDdntoV8Q0lxtAGgC/KRz0ayqUblWGOlIacAW8qkiXtqM2qIWg3uQEv4f1utUEB28/GwbZCoomqJFG8qxjYVGZvBmSX6FMSaJM1M5BV8sIgMbBx4GZVoiO6qU2lJGwLfXF/jcCYqK7miscKj5KcnGfx9XbOjki82F8YLfh+n7TlrtJCIcLN4OO1usDYGUL9mjmSB+N2LDjyDZbGEbopIQ0X7jAvacIwaFe3NtWz3orN94cb3zEFvsikIHB9RiJ0JTi1Hz+GQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=gmail.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Tx8J5tAPbkK25L2ne8Wbt20H/iSocxAMvfiC3cLcN4Y=;
 b=csN/PUulPavR4u/zT6zcJIvmZMq7yMhDd8SfCHGGd3t3fM9mYCPrnp0XhmFB2c8qG3MkeOcUVz8kNqLopzeFUThMuPRcQRORinv0uinYAP2yoAQHSZGTz/2VgHd9dwKQaQQaXs6dLmKANG92bghv6qdzuykh8TByrvJWkDp0yD4=
Received: from MW4PR03CA0325.namprd03.prod.outlook.com (2603:10b6:303:dd::30)
 by CH3PR12MB8510.namprd12.prod.outlook.com (2603:10b6:610:15b::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.13; Fri, 12 Jun
 2026 05:34:32 +0000
Received: from SJ1PEPF00001CE2.namprd05.prod.outlook.com
 (2603:10b6:303:dd:cafe::66) by MW4PR03CA0325.outlook.office365.com
 (2603:10b6:303:dd::30) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.113.13 via Frontend Transport; Fri,
 12 Jun 2026 05:34:31 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 SJ1PEPF00001CE2.mail.protection.outlook.com (10.167.242.10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.113.7 via Frontend Transport; Fri, 12 Jun 2026 05:34:31 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Fri, 12 Jun
 2026 00:34:31 -0500
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Fri, 12 Jun
 2026 00:34:31 -0500
Received: from [10.136.37.196] (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.41 via Frontend
 Transport; Fri, 12 Jun 2026 00:34:27 -0500
Message-ID: <ea1dc50a-062c-4607-acdd-3c42373b2430@amd.com>
Date: Fri, 12 Jun 2026 11:04:21 +0530
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 01/10] sched/fair: Add EEVDF lag credit primitive for
 nominated next-buddy
To: Wanpeng Li <kernellwp@gmail.com>, Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>, Thomas Gleixner <tglx@linutronix.de>, "Paolo
 Bonzini" <pbonzini@redhat.com>, Sean Christopherson <seanjc@google.com>
CC: Christian Borntraeger <borntraeger@linux.ibm.com>, Steven Rostedt
	<rostedt@goodmis.org>, Vincent Guittot <vincent.guittot@linaro.org>, "Juri
 Lelli" <juri.lelli@redhat.com>, <linux-kernel@vger.kernel.org>,
	<kvm@vger.kernel.org>, Wanpeng Li <wanpengli@tencent.com>, Richie Buturla
	<richie@linux.ibm.com>
References: <20260612013355.59231-1-kernellwp@gmail.com>
 <20260612013355.59231-2-kernellwp@gmail.com>
Content-Language: en-US
From: K Prateek Nayak <kprateek.nayak@amd.com>
In-Reply-To: <20260612013355.59231-2-kernellwp@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CE2:EE_|CH3PR12MB8510:EE_
X-MS-Office365-Filtering-Correlation-Id: 1a2427c0-f39d-4b8b-92ad-08dec84447a8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|1800799024|82310400026|36860700016|23010399003|6133799003|18002099003|22082099003|11063799006|5023799004|56012099006|4143699003;
X-Microsoft-Antispam-Message-Info:
	Wl+qIJP+m18GOlFOqEEc817mn0zXNtxC7rWMBbtYjvaqhAGhzRO0mBCAuMUkixtqOifTA2Y7sJSMhNXWr01JHIAV1kgP//E1DYqVbHJl7thep9LYBawm/LFiSVm9OwEphdslc6a09hBmwcEJ/favoGxjXlKBRw9sxL5uTAZVlPrmN77yp5OyOh8eVkSLLSlpza8dHe7XMPLwHuHc6Xg41hnDs5igAP8+R4h5BlsuU4dYgBUQTZkpN0KMIgndfRc1EtAHavVfTh1BP7xJI6Ipq38baj5G42MA9oNr/YSkzrodS08x0gjjVGlGgfhcA7j9vjWuWCOv2mZSdDwgFaqAusS4NN1aqJIcAZmzjl3mY5FktBKS+beWBSlq2A/xuj/vZNHN9+NtjmOJVm9aBUQoW3WtajxvnI1xrL9eNDlKSqTXqpfmRiLT9MIFzvThTinjpg49mVUwc1aeZ6LE8Q3apTXCTt9ftTtDcfnNUQiBsSS8FqW4w65bIp71/sOVGV7p5Kb0+nOEQlX6AOzuNGI7Q8OD2FhOsACJDS1/e76wSxeALs6QztcPum9/tIS/M+3X7EpPiq7fcKVuSCpdIZruHIbTYFjcCrRrrAl4v21dXlTliH4Csx6Ge7EUvxnOl4qPuV/RZn3LgrwxGMayqjc5rGWL7iIxRJT4O4+wTnlONkLugYhHg98OrTREvkXi8CHy/QJ/RZEUmwUR4c18+qNN8YI8TIWTE2MtByhQSPd24bQ=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb08.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(82310400026)(36860700016)(23010399003)(6133799003)(18002099003)(22082099003)(11063799006)(5023799004)(56012099006)(4143699003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	YhuOQpn9bRf+QTOho6CGuaY6pblEFnc3VqEmTLp+8dBgY+D6ItB+fZrSOquwtvUFYetz2FKBgEQtO0pJV89boBrY7QU6p7AjCCTF/fE+VHIF7rqSKX3rWC1xnMivikXsNGjSFXp6TlX3cMbP8OBk6/V8zyJJIyexq1ZzqQsAnTF0z17+dX9d3iuUTR8vVvDhjl/nR5ESlypJ9OXu0Ciylq75moXJkUxuuYsPX1TRWx1WQn/2f84iTupXUV3i7OZO16hN5ZJDKon0oDx1nwKjjTKozRKvl8XNzvAnxO/l+zXjaIrghsy0fhpQX75IgpEF1lG38qUYjaEbK8O7U26HmXzlST7OWtehvMKDiz1UptebxCc3jRInScYEzdyD+fyQMe6+ft57SaADJmS8fl9DX4Lo5FZXuS0t0vfcqorqoaegKNDdRmCOonWbWO2qVOVm
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jun 2026 05:34:31.7594
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1a2427c0-f39d-4b8b-92ad-08dec84447a8
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00001CE2.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8510

Hello Wanpeng,

On 6/12/2026 7:03 AM, Wanpeng Li wrote:
> +static void __maybe_unused

I would suggest adding this with the first caller to avoid having to
jump between this and patch 3.

> +eevdf_credit_entity_vlag(struct cfs_rq *cfs_rq, struct sched_entity *se)
> +{
> +	u64 avruntime, credit;
> +	s64 vlag;
> +
> +	/* Callers gate this helper with YIELD_TO_LAG_CREDIT. */
> +	if (cfs_rq->nr_queued < 2)
> +		return;
> +	if (throttled_hierarchy(cfs_rq))
> +		return;
> +	if (WARN_ON_ONCE(!se->on_rq) || se->sched_delayed)
> +		return;
> +
> +	update_curr(cfs_rq);
> +	avruntime = avg_vruntime(cfs_rq);
> +	vlag = entity_lag(cfs_rq, se, avruntime);
> +
> +	/* Already eligible: nothing to do. */
> +	if (vlag >= 0)
> +		return;
> +
> +	credit = (u64)(-vlag);

What is this random credit and how is it fair? My suggestion on the
previous version was simple:

   Task0 -> yield_to -> Task1

- Task0 is eligible and has +ve lag

- Task0 transfers lag to Task1 and makes itself ineligible

- Task1 picks the proportional lag; It may become eligible and get to
  run but there is no guarantee because that is fair.

There is nothing fair about simply making a task eligible just because
someone else decided to call yield_to() on it.

> +
> +	if (cfs_rq->curr == se) {

As mentioned in my reply on the cover, I'm having a hard time
understanding how this can arise when we make sure "p" is a TASK_RUNNING
that is also "!p->on_cpu && p->se.on_rq" while holding p->pi_lock and the
rq_lock.

> +		/* curr is off-tree: in-place shift, carrying any vprot window. */
> +		if (protect_slice(se))
> +			se->vprot -= credit;
> +		se->vruntime -= credit;
> +		se->deadline -= credit;
> +		return;
> +	}
> +
> +	/* Queued entities are left unchanged by this helper path. */
> +}
-- 
Thanks and Regards,
Prateek

