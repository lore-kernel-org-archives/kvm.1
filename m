Received: from CH5PR02CU005.outbound.protection.outlook.com (mail-northcentralusazon11012038.outbound.protection.outlook.com [40.107.200.38])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C3A233F5AB
	for <kvm@vger.kernel.org>; Mon,  8 Jun 2026 20:43:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.200.38
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780951387; cv=fail; b=Q/7xw4jyTzdmz3FfLO9J/hlXxkwFdiQBD+0/KfmrSRzmgA9Nlqbk1bKCjlgrftdKH9X+H7v85MRVR7m7SSmXKhvkSep7Mfr7YKES5zmWv/UKlsjNqVZ1SXFfYyYo2gkMNgWweDeKTeK7J0FUmUSy7wUt+/zZCEflMDjkrqCD8Ys=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780951387; c=relaxed/simple;
	bh=I+IWh8PpH4ShDNWcMdUENjEX6235p7MPNHBmEbCJ4Ek=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Enqaba6tHZy49hoL516f6a0jLdluSIlpCChi1bGsM6InxLZ7wQTjAalHzXiq/ofPEZ3llQsZYGsmOMOrLq5cUU5YObrEs9AtnM6PPwienakSCh+fkX5jQlj6NNKTmVyrmbdoo3XpvG+Yh1zW3TR7RLMLT93SOt2W8njxTNVURJk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=xjGQ2J2k; arc=fail smtp.client-ip=40.107.200.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="xjGQ2J2k"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aaQWlMj2OmjyzG4i6XSinI5Az1XEqn+vp1THEOdI4rUbalflcq9WcwIBzC1n3zWsc3VAX8VoaUqGlv2Rlr62t/DjDNhibSxpfDt878etE9og14XpjGUmGRvhyauSUz6jLCaPkRe3wpCspWbh6cfuvmEQCpQM9/jRe8PkJGTaA5PV0BiM88MSpEJT6usmJQTuzEJs4AKLLYrNUSkaKwCXUphZJSVKG4/wRH/KoHN62xlE0kqSjn5aZiiGx72aWG7G/oyRxJVJSkj0YaIzDOFIBV4K1pDB/MLzsHBO8d2G8mmDVHPzIxagOhxu9f1gpxv3npI3QaVKD8yzwCf8obcnSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8VRgWXvT+NiziVGiykTeZz8RUTXsYuDDxEpb+DWwSfE=;
 b=YTb/1Z1lLh7vln1YQmgM0Mb21JLUVUx0B1A0MDyokccnUP1lvSn/rbeeKRpwvzt+5F9mP3lY0uU1VWGdHqBkmblUAgr1aSsFv6H0pIrEO0zUzvyXOD7KuyVTEj616Nhe9fzwaUOhKweEOrfEQEvSY2OP31VqN2R3DAb691GjDQ6pnqEUYgSUFIn8/gQUC4U4oWs4aGRkFyWVdAqiRhuKDb2MA3G/87fVF/SjHI7iGo3rhd/B0WceVagiXEP38a7NfraNZnYLa36/LU1pEurlZw3drImzA9VedCkjxEhk9MsROmJNprLl9HUdBVmM7hoIP/ouLD5DaGORvw5d66o5vw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=redhat.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8VRgWXvT+NiziVGiykTeZz8RUTXsYuDDxEpb+DWwSfE=;
 b=xjGQ2J2khIx/GhkTuYIYMFVZva6Mz8d4ZNVkxnIlbraeLa0v9TW3fXQ0iXWzeqEqxhLZJuGERw6OQ/f9TUL0l99K6YxeALwS0LSkrfCT096+8MdH2f2JlQVlfDvRtZeg/NFNEttIJN4rG1840G+PUIgp1rU1rhPk+5e2g/zy4sw=
Received: from SA9P223CA0002.NAMP223.PROD.OUTLOOK.COM (2603:10b6:806:26::7) by
 MW5PR12MB5624.namprd12.prod.outlook.com (2603:10b6:303:19d::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.13; Mon, 8 Jun 2026
 20:42:56 +0000
Received: from SA2PEPF00003AE6.namprd02.prod.outlook.com
 (2603:10b6:806:26:cafe::7d) by SA9P223CA0002.outlook.office365.com
 (2603:10b6:806:26::7) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.92.13 via Frontend Transport; Mon, 8
 Jun 2026 20:42:56 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SA2PEPF00003AE6.mail.protection.outlook.com (10.167.248.6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.113.7 via Frontend Transport; Mon, 8 Jun 2026 20:42:56 +0000
Received: from localhost (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Mon, 8 Jun
 2026 15:42:55 -0500
Date: Mon, 8 Jun 2026 15:21:45 -0500
From: Michael Roth <michael.roth@amd.com>
To: Markus Armbruster <armbru@redhat.com>
CC: <qemu-devel@nongnu.org>, <kvm@vger.kernel.org>, <pbonzini@redhat.com>,
	<berrange@redhat.com>, <pankaj.gupta@amd.com>, <isaku.yamahata@intel.com>,
	<xiaoyao.li@intel.com>, <chao.p.peng@linux.intel.com>, <david@kernel.org>,
	<ashish.kalra@amd.com>, <ackerleytng@google.com>
Subject: Re: [PATCH RFC 04/12] accel/kvm: Add CGS option to control in-place
 conversion support
Message-ID: <2ein52r6fjl7gulyxuk6qe5nnppt4m5mjyjcjcceacakrviscw@qad6egy4vjb4>
References: <20260528000416.8161-1-michael.roth@amd.com>
 <20260528000416.8161-5-michael.roth@amd.com>
 <87wlwh5p0z.fsf@pond.sub.org>
 <bhawvkft4dhs6aq7jcajyf2zqk2fo6rta37jwit45l3z2txmh2@3yav2up5cthy>
 <87zf15la6q.fsf@pond.sub.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <87zf15la6q.fsf@pond.sub.org>
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF00003AE6:EE_|MW5PR12MB5624:EE_
X-MS-Office365-Filtering-Correlation-Id: 8df30795-ddba-495f-4af2-08dec59e8540
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|36860700016|376014|82310400026|22082099003|18002099003|11063799006|56012099006|4143699003;
X-Microsoft-Antispam-Message-Info:
	r1DuScfe1UMhEeSPWjvnCRw9yhHg06AQWFELPae5mWehK9GT596YthesjcFfoAb50Qslkl97OQUD7qiw6tcWqyqRIxfPCVst3zSHawsiUU2b2VzrIiygYhEYW+UvYbzNNtAu6yMTGmyK/gCnommpN93LhOjDMsKU4ldXec2/T8PtoAl6e/2r8/uWU/fr74uW/eq8fIoQJs628MNgFl0cVvmzxA3PezGEG+b7TNx0J39/XrHUfBdwiNqa0wd5sOrEp4ljTnb1lQIzBlo+3HBjHx+gTIR9DgAIspvKY8uiffT/nJoVcqDisBL93/iPjvraMvBrlEMd6s2EvVbV8LXRevKLAova/9FK8Y3T7ArRatBEIePigQvfCxmTYiyD8hsxn0+SVFJmaHnmvgzRCqonnnsPvLUgKZD6aNAl4eolLHjq+I0Q7t8JfZl+4nrlwI/IXZSSRPILMQMC3r4mutErWYGtNodHQmHzvTOv7fUjEI2Od/al+Xv6WanaaVqAbE+bixi57pLNOnbz2KiggVg/MtAiHTVf8TZU40pVQocj6Kl3vu3/e9weIRIJHidRB9PL8WJM5nGJCgfHHnQzH059Gey+OViZXLJMh0BLhRypxl6VnyKa65RpsQ7wtWvODn0VITEmZ6ISAGSDiWtfpronK+D8UxtdknWU19/ys7+4YZSadxirycqOadL+kw1RLOs5tJPznXG9lxrqJlFmBuIUDBndx4yq49nE1W1Vahf0BUM=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(36860700016)(376014)(82310400026)(22082099003)(18002099003)(11063799006)(56012099006)(4143699003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	qBiAwJ7hsX4eERXeD0HYvVDoM2+/GZacQnSoopEx+7AI3F8MPXMp+ONRgUUpMsGhwBDhyOuEvgT+ttMJ46IojnMP/Cfw5ke0NjXIG/YAfGozD5ugVkbqZUMAvxZQltyHB7t8sZ/sh4ZMW8sop/Q+XX+R+NEgH6w3NcJ7ahLGqPGpb6fmvzFgE0uh06Ce9zASUopIba/qcgbAQow9n3AqQ5+sgHO/YTyzh9nPm6ea9ABhObSVCi5xU2sY5fOyJMZGLYk6U6FCG+S+6veQ96DhcpVK4D+dwvrYlq2ICcQQRWjM32zsxUT0FsUcwFQyHR4UOfl4XzIc6ZjrDNnjuYMlLZzcl79OH+MOmRlyo6w52CwasuQfuqkwjigKDekhQYiw9M6etdECRUNK8fEx/6+o32PKeaKuAoqM6zeWGk04/QWHEUzcxGFafx16rHiJKTdx
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jun 2026 20:42:56.3560
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8df30795-ddba-495f-4af2-08dec59e8540
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SA2PEPF00003AE6.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW5PR12MB5624

On Mon, Jun 08, 2026 at 10:15:41AM +0200, Markus Armbruster wrote:
> Michael Roth <michael.roth@amd.com> writes:
> 
> > On Tue, Jun 02, 2026 at 10:23:40AM +0200, Markus Armbruster wrote:
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
> >> > Signed-off-by: Michael Roth <michael.roth@amd.com>
> >> 
> >> [...]
> >> 
> >> > diff --git a/qapi/qom.json b/qapi/qom.json
> >> > index 502fafeb15..037c078799 100644
> >> > --- a/qapi/qom.json
> >> > +++ b/qapi/qom.json
> >> > @@ -1014,6 +1014,21 @@
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
> >> > +#
> >> > +# Since: 11.1
> >> > +##
> >> > +{ 'struct': 'ConfidentialGuestSupportProperties',
> >> > +  'data': { '*convert-in-place': 'bool' } }
> >> > +
> >> >  ##
> >> >  # @SevCommonProperties:
> >> >  #
> >> > @@ -1038,6 +1053,7 @@
> >> >  # Since: 9.1
> >> >  ##
> >> >  { 'struct': 'SevCommonProperties',
> >> > +  'base': 'ConfidentialGuestSupportProperties',
> >> >    'data': { '*sev-device': 'str',
> >> >              '*cbitpos': 'uint32',
> >> >              'reduced-phys-bits': 'uint32',
> >> 
> >> Why use a base type instead of simply adding @convert-in-place to
> >> SevCommonProperties?
> >> 
> >
> > My thinking was that TDX and other implementations would similarly enable
> > this through their CGS implementation, so I went ahead and carved out a
> > set of common properties that ConfidentialGuestSupport implementations
> > could use the same ,convert-in-place=true option (or set it by default
> > for newer implementations)
> 
> How confident are we in future reuse by TDX and others?
> 
> If there are doubts, refactoring for reuse when reuse happens would be
> smarter.  The refactoring would be a bit of churn, but not all that
> much.
> 
> If it's something like "pretty much inevitable", preparing the reuse now
> saves us that churn, and makes sense.
> 
> Judgement call, i.e. you decide.

Hoping to hear back from the TDX folks on whether there's anything
missing to switch things on there too, at which point maybe it won't be
premature to have a common type. But yah, until then I can plan to keep
the option specific to SEV/SevCommonProperties. As you said, not a big
deal to move it out to a common base after-the-fact.

> 
> > It is sort of tied to the 'allow_convert_in_place' flag that is part of
> > the common ConfidentialGuestSupport object struct, so the property
> > handling is sort of tied to the common ConfidentialGuestSupport base
> > class as well rather than something implementation-specific.
> 
> Valid point.  Not sure how much weight to assign to it, though.

Yah, I was purposely trying to make it easy for other platforms to switch
it on, but if we do for the time being keep it limited to SNP, then
there's probably other ways to go about it.

> 
> > Not sure if there are better ways to handle all that though.
> 
> Work your rationale into the commit message, please.
> 

Will do!

Thanks,

Mike
