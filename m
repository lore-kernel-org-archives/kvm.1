Received: from CY7PR03CU001.outbound.protection.outlook.com (mail-westcentralusazon11010011.outbound.protection.outlook.com [40.93.198.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5303234E74B
	for <kvm@vger.kernel.org>; Sat, 12 Sep 2026 14:54:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.198.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789224855; cv=fail; b=cy6/t0VU+FsQDaWtCRuDmmW0lfJHHiEQ7SythRxcTUaijKzEJ+7O21I7FKANnpcZ9woI0IHAQne7ajB8oD5JA2HACamQBis/9VZzaOLSsSvEQrOC7EfqeSEbW+AXqLZ4T4xlSsRW+w5bC7uqbpcj2ElKFEg/6a7ppkSZUAd1UO0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789224855; c=relaxed/simple;
	bh=r/ecZ1ucMNLnSQcPiSLGoQANNDHYNHQdO2LtWzWoRGs=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iCzFYcansmK2pTlFAFNEwNEYC/+IF36Y42L+6laXfF7mRjLdSCCz9AH75QP32XUm/MYpQOIDT7rsrNjgZS8BCHxcqjwfVaBt9cy+lSXxytlms5+BNtKcMHVo9R60OsdSfGu5R62zYx5xtaIxN1S6P1S5vrbyDIjNbA6LjYM6dZs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=eUUtsmRQ; arc=fail smtp.client-ip=40.93.198.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="eUUtsmRQ"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vjFkAfrZa2XeR9nOPJVOihooS+mj/Hx7iCOkKJ3nDbiyjn3D0vM1ojtADbymBTtS2IaIiWtsipMjqwCEJ4qDOmKEFfMfNI4U/FzGXFwYs9xYBbZNSsgIPte+R98NxpsobEYMiK+sugPO4GmO8UvUN6YQ4w9qRKBvd3CShALCNQmYUmOZpI553WFEki/qc336XdYZ3WVGHi9EIvILbcz1Miqy1wy+0q41c5MHy6VlvQncTLyNMXfu8cXY3/GDecsmrgNGOFzuzBfYPWPk1N6+FPXiexed/O1EtnjPYCfIMWw6FuhN0NQkSmgytELz3A8OWOwVmsr9nVm7HgnTBVGN7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fKZ8nKlOBn7QGCmr+3S0gVfuAMDFZW7m79d8vr5HX8U=;
 b=GgdMqcvBOteAoWx2/CKwJtLTl6Cw3fhU6mjxMdlN5IZPfxSOdUx2x9XiQr5Qz9BgIXLv+TqKDcIH684ggvrqI9fAI1sS/xp9PSqJorkn2ve7DXwuY42fLlRMqdT3XbDkkK48/moJaVP0yn4/vh4yIN/iHh7C7aRSnYYVU/01krQVYKwYJPPJn+Kd2nwsjApL3izheIkddVqK+7EC88LzEvQJ6KSuNdEExoRnaVQKdTEJI86yFRrAdMCqA5ObMe5DIC1326sHZ3d43Rqx5MYTrWW1oJjysm3lfTc4WhO+0Fko1jBB8NFfWWNY7DCBvk7qYLOB2qVFtwQvwuVRzIqfgA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=redhat.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fKZ8nKlOBn7QGCmr+3S0gVfuAMDFZW7m79d8vr5HX8U=;
 b=eUUtsmRQgFsD+8VKKkHnfUUgNuyqCvAbZfudIsfyJl15cBHoLkGwWtjlRrmPRYSsidYmC7ZN2KD/cohN0NhQafI2zLrI9iSGSKYRE0iVBy1uVdUlheTUWpMiJuFDIDQHrlX1npmPn6uxN1ah3wqgmk8i2C7WKn9+ga1Ayxwmitc=
Received: from SJ0P220CA0007.NAMP220.PROD.OUTLOOK.COM (2603:10b6:a03:41b::15)
 by IA0PR12MB7578.namprd12.prod.outlook.com (2603:10b6:208:43d::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.11; Sat, 12 Sep
 2026 14:54:09 +0000
Received: from CO1PEPF00012E80.namprd03.prod.outlook.com
 (2603:10b6:a03:41b:cafe::61) by SJ0P220CA0007.outlook.office365.com
 (2603:10b6:a03:41b::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.406.10 via Frontend Transport; Sat,
 12 Sep 2026 14:54:09 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CO1PEPF00012E80.mail.protection.outlook.com (10.167.249.55) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.428.7 via Frontend Transport; Sat, 12 Sep 2026 14:54:09 +0000
Received: from localhost (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Sat, 12 Sep
 2026 09:54:08 -0500
Date: Sat, 12 Sep 2026 09:52:51 -0500
From: Michael Roth <michael.roth@amd.com>
To: Markus Armbruster <armbru@redhat.com>
CC: <qemu-devel@nongnu.org>, <kvm@vger.kernel.org>, <pbonzini@redhat.com>,
	<berrange@redhat.com>, <pankaj.gupta@amd.com>, <isaku.yamahata@intel.com>,
	<xiaoyao.li@intel.com>, <chao.p.peng@linux.intel.com>, <david@kernel.org>,
	<ashish.kalra@amd.com>, <ackerleytng@google.com>, <lpieralisi@kernel.org>
Subject: Re: [PATCH v2 07/19] accel/kvm: Add CGS option to control in-place
 conversion support
Message-ID: <rwpsckq6ltabhefmbvuhvxoq5c6j3a6jrctclrqj6nbwja6e5l@mod7xno2q4uv>
References: <20260908205236.838281-1-michael.roth@amd.com>
 <20260908205236.838281-8-michael.roth@amd.com>
 <878q5bosi3.fsf@pond.sub.org>
 <sudqwq5bnygtkqc2cio6rq5khrfi252jcs6jq6i3uzblgtvgq7@3upjx5k5bp7s>
 <87pkyj3tjo.fsf@pond.sub.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <87pkyj3tjo.fsf@pond.sub.org>
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF00012E80:EE_|IA0PR12MB7578:EE_
X-MS-Office365-Filtering-Correlation-Id: bc9d3f53-e564-44c5-05b4-08df10ddb351
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|7416014|376014|1800799024|36860700016|82310400026|13003099007|6133799003|10067099003|4143699003|56012099006|11063799006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	ktF/14ZGWnXAuWruNqiE38Z5CWcLpIyE65CMsNEx8kGKKeolbTI3UpyJqCCQuztaTinFyS9fpziWbUzlRLXTfmPAPz+eNs/JG53r8Bk0HU6wLjzSkydusaqq2WQY6BMYyyfllqW+cLaeEQLvqHUnCjSQyX3QykHD1mL3wY92hQbjXCEAUbZuEes19sPua4Qg/9WIb6erb+/46boI06hW9TO71/wi5s2D/QD0ufQ3DfdOP9YUgdUSV0ls+qmm/y8RO51d6mLd0MO3kVFxZNq4x5WxezLXPFLP2HQSCt6pzGknaSaoK7OTUWchHSOp7UFR3aCktrrEYfOJ97Ygb/ilGRS44V0Oj8Tl+8ztI/XyWpojjPPC0InuqWLPYK/ZsDn3CZSqP6+yikO9Rtz6uPRbmEYgC8fiHDbNYsbWQIM5eHAGjY0UnSgMHAInddDuWn4RVXmFWMkbdnkbe8ATNtXjGT4El03pvVEj16q/bhDeMBmobvblyJxSMSA2/h9SDgI7PZzirDgj9o4zdfgVXVn5Qma1DBaSFz7ntb2z3ajT1f8tfiH1c3FTy7FvksvUlRslQ520+SUEHsxNobROPRgJhlAEFtYyTNzRAtFciPVWip1xajfUsZ1uQewWIH/OusDgH5/6fPQ3GKdn8orR7PhKD0h2yyYv5nGGUPXRGuN5lxeaksjC/G/s6ssOJCZlmJo4rcVJt69F6cAeg/nPTLUQ3g==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(23010399003)(7416014)(376014)(1800799024)(36860700016)(82310400026)(13003099007)(6133799003)(10067099003)(4143699003)(56012099006)(11063799006)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	sGCLicx8yjOIWl4NQqAyu3219jpX/vyWrB1B4mg/pUJoYgCkz0DotHxeeCLQV4BxQn8FMZU7yG1oDVlyWc39kNElptIVdVIgMTnysDFl1dHGL4xFaCkdulr+Bad5AEmF2xQ9k70hYs8PBC2qqaXE/vja3js0mIBXvVhTpVGJjSnTwha9l5nDhKhNrlVrKpfednuRsDOVsI9rUeoMVHCxs4vHhLyaFNNZ4JPX/zK78b7Z+d69cL3guy6IOHSsgIbzhe9Ojr/zWGvNmkFFrPloHazrxxtLZfxSZ4Gv9v5k00aM7pSUhHiezdGhXMPmcqeFZzMxTNm09YAdKH9H4lKXU0sNSses3lwsyDhK1ZrrHC/wAmSJyxVK4I6tEC26WDEMNWiujGpWraIxDcIwNQQhzHAObQ1loCZR7AXoUs79c6hFOdgiLnWFUoZkCLXXkfhZ
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Sep 2026 14:54:09.0802
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bc9d3f53-e564-44c5-05b4-08df10ddb351
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF00012E80.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB7578

On Sat, Sep 12, 2026 at 07:52:43AM +0200, Markus Armbruster wrote:
> Michael Roth <michael.roth@amd.com> writes:
> 
> > On Wed, Sep 09, 2026 at 08:20:36AM +0200, Markus Armbruster wrote:
> >> Michael Roth <michael.roth@amd.com> writes:
> >> 
> >> > For confidential guests, guest_memfd is currently used only for private
> >> > guest memory, and normal guest memory comes from the configured memory
> >> > backend just as it does for a non-confidential guest. It is now possible
> >> > to use the same physical memory to back a particular GPA regardless of
> >> > whether it is in a shared or private state. This avoids the need to
> >> > rely on discarding memory between shared/private conversions (to avoid
> >> > doubled memory usage), and is intended to be the primary mode of using
> >> > guest_memfd for confidential guests moving forward, and future features
> >> > like hugepage support will likely require it.
> >> >
> >> > Add an option to enable this support. Since ConfidentialGuestSupport is
> >> > already used to track some guest_memfd-related functionality (e.g.
> >> > whether it is required for the configured machine), similarly introduce
> >> > this option as a property of ConfidentialGuestSupport.
> >> >
> >> > Also add the KVM-specific checks to enable this support, but leave the
> >> > option disabled until other required changes are implemented for
> >> > CGS variants that intend to make use of KVM's in-place conversion
> >> > support.
> >> >
> >> > While technically the convert-in-place option could be introduced as an
> >> > SEV-specific option, it is a given that TDX will also be introducing
> >> > in-place conversion support based on the same guest_memfd kernel
> >> > infrastructure, so introduce it via a new
> >> > ConfidentialGuestSupportProperties base class that other confidential VM
> >> > implementations can utilized for common options.
> >> >
> >> > Signed-off-by: Michael Roth <michael.roth@amd.com>
> >> 
> >> [...]
> >> 
> >> > diff --git a/qapi/qom.json b/qapi/qom.json
> >> > index 909add4299..20d6fefb04 100644
> >> > --- a/qapi/qom.json
> >> > +++ b/qapi/qom.json
> >> > @@ -1005,6 +1005,21 @@
> >> >    'if': 'CONFIG_IGVM',
> >> >    'data': { 'file': 'str' } }
> >> >  
> >> > +##
> >> > +# @ConfidentialGuestSupportProperties:
> >> > +#
> >> > +# Properties for ConfidentialGuestSupport base class.
> >> > +#
> >> > +# @convert-in-place: If true, the same physical pages are reused
> >> > +#     when memory is converted between shared and private states.
> >> > +#     If false (default), separate allocations are used depending
> >> > +#     on whether the page is private or shared.
> >> 
> >> Any guidance on when to enable @convert-in-place?
> >
> > A lot of it boils down to more Confidential Compute architectures
> > now requiring it for new features (hugepage support and SEV-TIO will
> > require it for instance). convert-in-place=true maps more closely to
> > a normal VM, and not having more complicated memory management
> > requirements avoids additional complications up the stack (like
> > accounting for instances where memory usage might balloon passed
> > expected resource limits due to needing to management multiple
> > memory allocations for a given GPA range).
> >
> > convert-in-place=false will likely become a legacy path unless other
> > use-case arise, but they'd probably need to be super-duper useful
> > to warrant enabling new things on top of it going forward.
> 
> What are the use cases for false *now*?
> 
> Can a change from false to true upset a guest?

Yes, since the in-place conversion support is advertised through a
combination of new KVM capability bits and gmem flags, and those will
only be available in new kernels, so it would break most existing
SNP/TDX deployments.

So we'd likely want to keep convert-in-place=false as the default for
some time, or at least keep it set to false for older machine types that
support SNP/TDX but predate QEMU in-place conversion support. But even
for new machine types where we might consider defaulting to
convert-in-place=true, we'd want some way to switch it off for SNP/TDX so
they can still run on older kernels, because it's not a deprecated mode
(yet) and does still enable a few things that won't be available for
in-place=true for a while (like being able to use THP/hugepages for
non-private GPA ranges at least). But we also don't want to automatically
choose between in-place=false vs. in-place=true based on kernel
capabilities because userspace needs to be aware of which mode it is
running in due to differences in how memory needs to be accounted/managed
further up the stack.

So for SNP/TDX I think a knob is needed, but for newer architectures I'd
imagine they'd just want to enable in-place=true from the start and not
deal with the legacy support....

Actually...I hadn't even noticed yet, but the ARM Realm/CCA support[1] is
based on v1 of this series, and it looks like they'd be setting
convert-in-place=true from the start. So for that series, it would probably
make sense to not expose the 'convert-in-place' option at all (which should
be easier when I rework that option for v3 to be implementation-specific
instead of via a common base type).

Thanks,

Mike

[1] https://lore.kernel.org/qemu-devel/20260903193611.1058589-1-mathieu.poirier@linaro.org/

> 
> > I'll try to work something along that line into the guest-memfd.rst
> > I proposed for Peter's series and add/reference that as part of this
> > patch.
> >
> >> 
> >> > +#
> >> > +# Since: 11.2
> >> > +##
> >> > +{ 'struct': 'ConfidentialGuestSupportProperties',
> >> > +  'data': { '*convert-in-place': 'bool' } }
> >> > +
> >> >  ##
> >> >  # @SevCommonProperties:
> >> >  #
> 
> [...]
> 
