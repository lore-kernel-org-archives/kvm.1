Received: from CY7PR03CU001.outbound.protection.outlook.com (mail-westcentralusazon11010008.outbound.protection.outlook.com [40.93.198.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E398A3537E5
	for <kvm@vger.kernel.org>; Fri, 11 Sep 2026 19:17:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.198.8
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789154279; cv=fail; b=I/rPoA6w79xt1tFaGhVttAaonMrsItydBwSwht0xiKNX1K0jxAp5Z73Gt/eKRGCRvkNGWMObkeYS1FjGHZMGU6Qll9k9PSz1vWRdXzbLelMfvPIkKVS5blPCTHeaz4yoUy7TE/ZHBAbvdN682loQ43VbosAoh+Ay5pwnwGqImpM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789154279; c=relaxed/simple;
	bh=RQB1fSGiCoyH5O3SXo1Sf3N35MV2ABnYec8X2XfJAc4=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IthLyGcuFGDWTD/X8Smxuu3HdHAj67laepUjFArxbB3IsKTqKxSwo+g7zDPS0DF8KXO1bg+ekodtOtKwrMxGhfd7uu+bnLp9nwW67ud0P9n5bl17z/k4hYycVxjxml+FsbyneqjjiIN9MKSp1MlZoztOonvmcBmsUMxSRlBz46U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=ktj7IyJR; arc=fail smtp.client-ip=40.93.198.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="ktj7IyJR"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iSABUnoABtiykGIVuRuwox53P5YPKGfrWBTbxFhj/uHfbIraYm3a1e/qnp8a7bkcCRzCN/gkcwRuftDGNLVhO+mUQ3idHRLIFmLt/mTWcFprivbfJO9zTmkABWb87qwIo4LpJ0ypR+r80QV0JEqVR/OnN4PsxdDxS3mT7m5xYp7IQgUdfi3mg2EuHFgF1Oji3mr0SR691BMV8Ypu0vVQ42DZOkzHZHsLCnON98UZV/8oGKAWA1tW1lWnQkzK2OIUs1hotvX+DHrROL8wBC4MrUKCTFd3O4Kqc3pDd9M+Q45VgpGcBxJri4tlEUuhuY+EjwM35atBN2gI3UzFFrLa2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nbnRWoY7R8FnA1K/ZO7vdRogpsjk1M7pMklfLRUu7cA=;
 b=RHKmKeGsuV4Niwki1W06CYGCgH6SXXvgdS1bKAjbMGuz4BHC1bqeflk9DDsxY5mTSrbCXSbQhZVQ5KVWFMq1YkmKdSAHon8DlSfA/e2b/uTe1p5OmGA59tAG6EtBspBCAy6SXwQ2cw8N73fZjn4jMGWZAPKOyo5CYO7eYEs0NHRWTkGvJrE5slfuOgoWHAb83pL0zYlQAn4FKkmpLULCHeP4ujkpKTXnZfQjjBGlbDTJo6bk9+m3/za+c4royvcp70KkxUp+HN3o3gd+sJr+LrEaJlhE7eWGfFTmqVvaIAkbvPvkBYEdTcvAqwLYGXErZuCz8gKnyfWBFiAIBTNFlg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nbnRWoY7R8FnA1K/ZO7vdRogpsjk1M7pMklfLRUu7cA=;
 b=ktj7IyJRtphVhELYCE+/QCoMc4luMIhh6S0jMM1sXw2f0xqirPa/k+NKsjgVDyNZg5iPBUT2LFfSlHiUWztjeuIRaopcHHooBesgTjcQnM+GUnXJyI+yqNlC3mDoU/FcA71Clp5aGwMqb8tsPyAguKwLmOk8PmX1y+CSXeW5zZU=
Received: from BN9PR03CA0620.namprd03.prod.outlook.com (2603:10b6:408:106::25)
 by DS0PR12MB8295.namprd12.prod.outlook.com (2603:10b6:8:f6::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.9; Fri, 11 Sep
 2026 19:17:38 +0000
Received: from LV8PEPF0000005C.namprd02.prod.outlook.com
 (2603:10b6:408:106:cafe::64) by BN9PR03CA0620.outlook.office365.com
 (2603:10b6:408:106::25) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.406.10 via Frontend Transport; Fri,
 11 Sep 2026 19:17:37 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 LV8PEPF0000005C.mail.protection.outlook.com (10.167.245.132) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.406.5 via Frontend Transport; Fri, 11 Sep 2026 19:17:37 +0000
Received: from localhost (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Fri, 11 Sep
 2026 14:17:37 -0500
Date: Fri, 11 Sep 2026 14:07:22 -0500
From: Michael Roth <michael.roth@amd.com>
To: David Hildenbrand <david@kernel.org>
CC: <qemu-devel@nongnu.org>, <kvm@vger.kernel.org>, <pbonzini@redhat.com>,
	<berrange@redhat.com>, <armbru@redhat.com>, <pankaj.gupta@amd.com>,
	<isaku.yamahata@intel.com>, <xiaoyao.li@intel.com>,
	<chao.p.peng@linux.intel.com>, <ashish.kalra@amd.com>,
	<ackerleytng@google.com>, <lpieralisi@kernel.org>
Subject: Re: [PATCH v2 08/19] system/memory: Re-use
 memory-backend-guest-memfd inode for private memory
Message-ID: <k5xe5tazooquucs7yrogib2yn32yfosxxtkaxwja26ch2f5bhh@zx6ihjcya2gt>
References: <20260908205236.838281-1-michael.roth@amd.com>
 <20260908205236.838281-9-michael.roth@amd.com>
 <391885b2-6464-4656-9cda-8d05891849a8@kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <391885b2-6464-4656-9cda-8d05891849a8@kernel.org>
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PEPF0000005C:EE_|DS0PR12MB8295:EE_
X-MS-Office365-Filtering-Correlation-Id: 8fae44db-5eea-443a-9277-08df10395774
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|376014|23010399003|36860700016|7416014|18002099003|22082099003|10067099003|56012099006|11063799006|4143699003;
X-Microsoft-Antispam-Message-Info:
	lf6p8LqrPBI3GaTr0DzJN34OTaTeGYmZ5oMn2NyeOGrzFcgNt9J5KRGN13I91zBC8a/e/YR0hUL8ydsid/4UdTbfIL+4rtsrS/xjt7wZHWAIq8V4GVXPV0/ZeQDDuDKrThuM5dZ/9Z+THngbsqnhi2KSmr4IaIMbU5OAoyLtc1SeZw15FBt0RHSQl0xLPViWeNWhwUmBe8h5a6fGYqphntf4g4DguYt3m/sRbNFlqQTsW23JEsIgqd59NODC97PSxh0/AvlAsb7KWOFqonXDxoyC39kuStHQc3Ybk5FGa8f3oomL3sAKCfU4ojqg6ndGal4OCkfSxSwSTxa+jXCRRXUJFMGmLXRdEjsM+phUFC1SS5IDg3AtoFUOJHJ+ipBA4Sg2ICteoTWnJZWbm6o4UT8kIWRIhMqowGAFZjwSHebKf/homp3t6SfIIidAbS3BGdnaCaBFVFbMfUbV9larvMER8DfONvwPSpsu1oaETNSgZFNddSGtHIUQF4bpR6T1wRvr5GkYkqx7eYkdz/X4Yo1C7d9/TVQmBxhMKGfQgtE8QUbJWhNlfmWVgtuqE5njF+IawylO5uFuIKkI60GVeDDBBAhHv7aKW75R2A+Bk5ZwhynQqVdyzZsQcbnWFfl6L2TyKj8TpfhXqgUkvF4TW1NRXah+fwms0Tusmxbla002EmfBMYYWkvao+lOD2UCd6gZf8Zinur/PoU8aXMOI/A==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(376014)(23010399003)(36860700016)(7416014)(18002099003)(22082099003)(10067099003)(56012099006)(11063799006)(4143699003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	afRUXFE2QD4AUY1zVRF2f38EFgw3pdhA+jroZpfaVIW/TOU6geKo4BWMCRfZrIj9hZ4a8oWrK0Ynu1yVm15X32nd8znT8lfoUSiUB7m8BPjsTQHyuwQf6TfGD6esXYKQgJUcjvDYy3X0rkfR0nvw+WdomabAebNArhzQ4277RgQQnlcJL3se3iSliZ5raHQ5Gh6u1fEhSJc9A1GeSnCkSht7iIdJt6Td0iutw8fzwHvF+CsNAWhQobXx2aJFTpOT0ipcDtPaG59ns7q2a+vW9nWd0TGaweD5E8eSQj9u/LEGLL6LqPBwjRPOwULvfkuiK/gwJVfoWhtMVD5+I6o0Mw7S0mKzNQJCWsTO1G7KZyzeR9VdcMv7B73+5HOh1Lr/NA5dWzDv1LtxpcQXkoZqdkJV/MGgWnVyE82WH+ocwp1QcWEgZQ1I9eomnbFkYTX2
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Sep 2026 19:17:37.5903
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8fae44db-5eea-443a-9277-08df10395774
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	LV8PEPF0000005C.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8295

On Thu, Sep 10, 2026 at 10:39:48AM +0200, David Hildenbrand wrote:
> On 9/8/26 22:48, Michael Roth wrote:
> > When convert-in-place=true, the guest_memfd instance created by
> > memory-backend-memfd (when guest-memfd=on option is specified) should
> > also be used internally for private memory.
> > 
> > Do this by dup()'ing the guest_memfd FD provided by the backend so the
> > separate cleanup paths for shared vs. private FDs can be managed in the
> > same way they are currently for convert-in-place=false (where shared
> > memory must come from something other than guest_memfd).
> > 
> > Introduce a new RAM_GUEST_MEMFD_SHARED flag that can be used to
> > limit this dup()'ing to specific backend types like
> > memory-backend-memfd.
> > 
> > Signed-off-by: Michael Roth <michael.roth@amd.com>
> > ---
> >  backends/hostmem-memfd.c |  1 +
> >  include/system/memory.h  |  3 +++
> >  system/physmem.c         | 48 +++++++++++++++++++++++++++++++++++++---
> >  3 files changed, 49 insertions(+), 3 deletions(-)
> > 
> > diff --git a/backends/hostmem-memfd.c b/backends/hostmem-memfd.c
> > index 6576331441..a9759e682b 100644
> > --- a/backends/hostmem-memfd.c
> > +++ b/backends/hostmem-memfd.c
> > @@ -89,6 +89,7 @@ have_fd:
> >      backend->aligned = true;
> >      ram_flags = backend->share ? RAM_SHARED : RAM_PRIVATE;
> >      ram_flags |= backend->reserve ? 0 : RAM_NORESERVE;
> > +    ram_flags |= RAM_GUEST_MEMFD_SHARED;
> >      ram_flags |= backend->guest_memfd_private ? RAM_GUEST_MEMFD_PRIVATE : 0;
> >      return memory_region_init_ram_from_fd(&backend->mr, OBJECT(backend), name,
> >                                            backend->size, ram_flags, fd, 0, errp);
> > diff --git a/include/system/memory.h b/include/system/memory.h
> > index 027ca81bd2..81616bfe39 100644
> > --- a/include/system/memory.h
> > +++ b/include/system/memory.h
> > @@ -274,6 +274,9 @@ typedef struct IOMMUTLBEvent {
> >   */
> >  #define RAM_PRIVATE (1 << 13)
> >  
> > +/* RAM can be shared that has kvm guest memfd backend */
> > +#define RAM_GUEST_MEMFD_SHARED   (1 << 14)
> 
> Trying to understand the semantics, should that be SHAREABLE ?

Yes... I was trying a little too hard to make it jive with the naming of the
*_PRIVATE flag, but I think SHAREABLE captures the intended semantics better
so I'll switch to that.

Thanks,

Mike

> 
> -- 
> Cheers,
> 
> David
> 
