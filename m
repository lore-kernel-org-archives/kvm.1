Received: from DM1PR04CU001.outbound.protection.outlook.com (mail-centralusazon11010051.outbound.protection.outlook.com [52.101.61.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8337A37C0E3
	for <kvm@vger.kernel.org>; Wed,  3 Jun 2026 06:41:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.61.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780468913; cv=fail; b=rS3qDUMCp17yff9KZx+SgD0KsA65RMp/p46NJirc6b6/cGuU1rBeLgMMGA320KRWWEyGv+0hcIcimTWrIyGGBNQ94JXkBu1OmhjpV9V92Gm+RRnYeq8atImx4VNTr9kANEEoloumoMGIn4twaLo4sgOm1MWhkrvx1WkJC64wOdY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780468913; c=relaxed/simple;
	bh=wsx3o95jDtEXKv7yjd0b/ZE9AdAlAOpgtq4g5j2kaNY=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AQ1kk/8i4UN84LnRZn14RS0SGiDTGvUmpbTZRYQ6wjAXiwNrcb2PZfMA72SPwQ7lWi1h0wJKQpVDTE75NZs5oLMuplrZqlkXOVVWHJOyOGVy1+tB3BUzyOeQBN0H69sdgkY8Y3CcptkkTBYiP3mdIUZCERrO3xVc/9J5mVnRzE4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=ChHeF/YJ; arc=fail smtp.client-ip=52.101.61.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="ChHeF/YJ"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BkKVgVhZ7+zNqqbv37atC3DhPGYIb1wnK21DLwbIzaa8zy/6f0Ejo+WK7QpJi7/fkI90GlNlr56tBCiOU3Elk5r7ZmEWEM1O+5vhuPm+8C9EbUNWXLuMeYzVeDio4bkW31yu5SOTbIKGFh9063NA1XDyMqqfiinmSNpWrQJXv1tq2POqNtVahpblPNuRTygSNNFJjRzD4WybQqD0XdS+rCI3ugNrgtVbfa/SCdk4CK2DmsrF4LqUW4Gn76n4l9yKtD0kwQ3QiSIHqZCRaaeOwPq/w7CnWa2zG5ciXw+FFK4hHs/T31QS4gs37Y9BJcJv3sfkH4Z0Fm+imwZt/S12rg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Y+/4FyVVc+zP1BHBgE0Z7UFIWLZkJ9StPB8qjEgJ7RA=;
 b=HQ6stRU54ljAsvND0vyX7zkt6NjNpEjMJf2jvYRltrfMsaB8wmVwe9dB/pd8oy8KaLeWiE2ioXcb1uDgOVJz67D1mO96BrBPdIX8f4WbxDRe7E1GYz+pT8uKaJv4c5Qj22rl4gj4URY+AJBbyYssz/iEiZtM2U5y+N9MON883kd5A9mkcTi8Io7dKYJ1qZfgHFnBLhUBhHpeXXcmsPtgCVJcHjQC9eYMjTKjAE9Nhna+IgA9dmuqiS1pbhiCEuiC2aPBhXuQGaeI0t+OpbS/Ki413VRx5hsCRfLCPedI8TlM7wdy5xefo920gpiV5+Co7w4p+ibC+E1DYYlBGnZAsw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=redhat.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Y+/4FyVVc+zP1BHBgE0Z7UFIWLZkJ9StPB8qjEgJ7RA=;
 b=ChHeF/YJZeO9kSAOXs6/D63Q9OjJ7lxCPHLt+Udv5RWi9+V4BS6JU9dJEncfoR3RGKcvfb7+Ez2WGgIzs+V+MovaxkvEdZMATDuHonoxRqXPHUiydwXUTua/UfDRCayR1T2DxHl2yGcG8NvvVFjva3mNbV2AwWdFG9AwF/FvXBM=
Received: from CY8PR10CA0033.namprd10.prod.outlook.com (2603:10b6:930:4b::28)
 by BN7PPF2E18BD747.namprd12.prod.outlook.com (2603:10b6:40f:fc02::6ca) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.7; Wed, 3 Jun 2026
 06:41:48 +0000
Received: from CY4PEPF0000E9CE.namprd03.prod.outlook.com
 (2603:10b6:930:4b:cafe::95) by CY8PR10CA0033.outlook.office365.com
 (2603:10b6:930:4b::28) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.92.7 via Frontend Transport; Wed, 3
 Jun 2026 06:41:47 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CY4PEPF0000E9CE.mail.protection.outlook.com (10.167.241.133) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.92.5 via Frontend Transport; Wed, 3 Jun 2026 06:41:46 +0000
Received: from localhost (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Wed, 3 Jun
 2026 01:41:45 -0500
Date: Wed, 3 Jun 2026 01:39:26 -0500
From: Michael Roth <michael.roth@amd.com>
To: Markus Armbruster <armbru@redhat.com>
CC: <qemu-devel@nongnu.org>, <kvm@vger.kernel.org>, <pbonzini@redhat.com>,
	<berrange@redhat.com>, <pankaj.gupta@amd.com>, <isaku.yamahata@intel.com>,
	<xiaoyao.li@intel.com>, <chao.p.peng@linux.intel.com>, <david@kernel.org>,
	<ashish.kalra@amd.com>, <ackerleytng@google.com>
Subject: Re: [PATCH RFC 04/12] accel/kvm: Add CGS option to control in-place
 conversion support
Message-ID: <bhawvkft4dhs6aq7jcajyf2zqk2fo6rta37jwit45l3z2txmh2@3yav2up5cthy>
References: <20260528000416.8161-1-michael.roth@amd.com>
 <20260528000416.8161-5-michael.roth@amd.com>
 <87wlwh5p0z.fsf@pond.sub.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <87wlwh5p0z.fsf@pond.sub.org>
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9CE:EE_|BN7PPF2E18BD747:EE_
X-MS-Office365-Filtering-Correlation-Id: 39e60b5c-ecd7-41d3-75bb-08dec13b2f07
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700016|1800799024|376014|7416014|4143699003|11063799006|56012099006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	XRtftpymIomeLlPl78rDGM1BkXeBvFFJGMokntCq4rhpVAhBpA91cNdei9zJ7lunPlNWAqjH3mU2sbRSj8terwK+aD+O/ILle4vVYAxgBMpMh9z3y3i+lgI5CpxpIfmGYKsbV62NG913XtZvu3q5PByruM42iAp+NYqBrmKGo2WtzeLjvaOLbmvAWIGZAlbK5dj0/0HWRNXe3bjdYCMWEqarRbxRPOs6+ENiuTTwI0yw7G+Spz3l2SoSuEKsD8httEE6vd9/eY8j+iVCKpgNBLDS1f2UEa/CGWiCccWvMFqkwYVX90cqcRF+Y9iyXyTJ1UxGP4V6ZS8xGyhmMp8JrqT+519w/3Z70QYkkeTbryIlNCGwRAgby7JR9J0wLH+zVD+494pbnBKwSBfdwLcGRagfsHVUSaznH6eONhF2vXB2YqvCJ3dq8vabL77PAu0GOanIt3+bB2ILrz4OF+7rU5A/dpUdSYG+ZU4CT0QuwMQWafBgsUaG/GeVS6SMJLXDC/JIjUJ0sj2ofJ3SRB7E9oHqGQeskc/RONk0ej9wyRTesMtG80BiDEMhRLamkou0s5wX/MlacggFgsIDHIkjqjj7Sm5A349x9gd2IuQ/0/T+yapKQGev7m+z3+kGM9eRC8CsMpq/Q7N/ODDexAswJ19YC+ohBYo+1oivI2dQD7rhMxkxm1eWsqNQbKIsxOfX5nq8V2+U6BtMpOjshDgV7S2/ObRqc12ZEBrHUuVqoUY=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(36860700016)(1800799024)(376014)(7416014)(4143699003)(11063799006)(56012099006)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	xM9K+QtRHWrD750D8WZAKWnrqA+TL4w/0NwKMkzqhZK0cMn+WBbnA9z/I5wTynQqPHtNEI91dTHPkeK1kijuoLQSHKo9VZK4/lZv1N5iBcEDMgBz5IZ0C0TCXmwyxl/0IOzYy6Yf7hKpbqXxKMIE+H6yIxndvlJIDvgzOHOwnTMUwEGf2lV2tWAOtUhwTDJk+gp8IMpoZTpFXrbz1S6FX047WArebVUeZdLeTNegpSzcVl0ORJjtsbnENU9Dqyz3Po0jxnSbPUJXnwMnuL7VJPnxrTl/511PlrRBYa/npMOwohCXKMuAa/+TMxHEfWZpZzlYS/99/O0pi/R/YgrlvfBoCjhZtkaycVfQ94hSdIPAgEfIjg/4r/Uw5TTIl6L+UTo7iyZOw1GOnZcw8R6PMLjn5bwdkbkoxFy1+lhA2T0EvLjq1wvrhHglu0sb0vov
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jun 2026 06:41:46.8555
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 39e60b5c-ecd7-41d3-75bb-08dec13b2f07
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000E9CE.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PPF2E18BD747

On Tue, Jun 02, 2026 at 10:23:40AM +0200, Markus Armbruster wrote:
> Michael Roth <michael.roth@amd.com> writes:
> 
> > For confidential guests, guest_memfd is currently used only for private
> > guest memory, and normal guest memory comes from the configured memory
> > backend just as it does for a non-confidential guest. It is now possible
> > to use the same physical memory to back a particular GPA regardless of
> > whether it is in a shared or private state. This avoids the need to
> > rely on discarding memory between shared/private conversions (to avoid
> > doubled memory usage), and is intended to be the primary mode of using
> > guest_memfd for confidential guests moving forward, and future features
> > like hugepage support will likely require it.
> >
> > Add an option to enable this support. Since ConfidentialGuestSupport is
> > already used to track some guest_memfd-related functionality (e.g.
> > whether it is required for the configured machine), similarly introduce
> > this option as a property of ConfidentialGuestSupport.
> >
> > Also add the KVM-specific checks to enable this support, but leave the
> > option disabled until other required changes are implemented for
> > CGS variants that intend to make use of KVM's in-place conversion
> > support.
> >
> > Signed-off-by: Michael Roth <michael.roth@amd.com>
> 
> [...]
> 
> > diff --git a/qapi/qom.json b/qapi/qom.json
> > index 502fafeb15..037c078799 100644
> > --- a/qapi/qom.json
> > +++ b/qapi/qom.json
> > @@ -1014,6 +1014,21 @@
> >    'if': 'CONFIG_IGVM',
> >    'data': { 'file': 'str' } }
> >  
> > +##
> > +# @ConfidentialGuestSupportProperties:
> > +#
> > +# Properties for ConfidentialGuestSupport base class.
> > +#
> > +# @convert-in-place: If true, the same physical pages are reused
> > +#     when memory is converted between shared and private states.
> > +#     If false (default), separate allocations are used depending
> > +#     on whether the page is private or shared.
> > +#
> > +# Since: 11.1
> > +##
> > +{ 'struct': 'ConfidentialGuestSupportProperties',
> > +  'data': { '*convert-in-place': 'bool' } }
> > +
> >  ##
> >  # @SevCommonProperties:
> >  #
> > @@ -1038,6 +1053,7 @@
> >  # Since: 9.1
> >  ##
> >  { 'struct': 'SevCommonProperties',
> > +  'base': 'ConfidentialGuestSupportProperties',
> >    'data': { '*sev-device': 'str',
> >              '*cbitpos': 'uint32',
> >              'reduced-phys-bits': 'uint32',
> 
> Why use a base type instead of simply adding @convert-in-place to
> SevCommonProperties?
> 

My thinking was that TDX and other implementations would similarly enable
this through their CGS implementation, so I went ahead and carved out a
set of common properties that ConfidentialGuestSupport implementations
could use the same ,convert-in-place=true option (or set it by default
for newer implementations)

It is sort of tied to the 'allow_convert_in_place' flag that is part of
the common ConfidentialGuestSupport object struct, so the property
handling is sort of tied to the common ConfidentialGuestSupport base
class as well rather than something implementation-specific.

Not sure if there are better ways to handle all that though.

Thanks,

Mike

