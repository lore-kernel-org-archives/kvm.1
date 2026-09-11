Received: from PH8PR06CU001.outbound.protection.outlook.com (mail-westus3azon11012061.outbound.protection.outlook.com [40.107.209.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACF4A3B774D
	for <kvm@vger.kernel.org>; Fri, 11 Sep 2026 19:18:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.209.61
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789154305; cv=fail; b=SRJvOiXAUkQbCMR7Vu/DN5PHikzVaatOQdDnxV3Kxb7RpT/CnpS2t0rbKke55S+0WwoWRbWP3Nye/NulO/fcCVWJwXTTvRBQK+VxRmUvH6wQqzSg48vNfaR6OH5X7i67n1tnS3X7ZBJC9ceAiWn9qClSJHSFBd6bT1vmD2VQ4do=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789154305; c=relaxed/simple;
	bh=8WqW/lbqjf5uPuziS272Q2OSxroo0pmOf/+ImEDczgw=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XXW6JQEQJM/+fjTVNNjnfXopax5+aDBeQljuNig3IEy99un4KVPTR9GMJbTf1bKJ2XTWlBxKEUeTLEJMPc09mFJvteSGcd0Zb9Ndv0HsgCkntKXGa6DEZ5WxcY8efVmkDTZWcfaxgCcgenOnRN6Ftaw23V0JQu6SxEfn/ilQ9Lw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=k99UwYoh; arc=fail smtp.client-ip=40.107.209.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="k99UwYoh"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HrCRF61xqV9nPIsy2ob7aPT0FisRoJSSeY5ZGEjTNH58dDi7h9Rc2yd4zZFlhILmFRULXFPLERxGtKsUbO6dCk3TYoAll543HJGz4TUrLTQwlR3L7HZTxNfX41maK01PnJCHD2Um5QVTCF5OmMCWohu2VSOyhNoAyfFHUmRl2OGK0kd0IZqPMZ0/LXDlgUHIzDkQ6S+IVYglO8lM7mz4dYTfqV9U5Uh3yTsIuRw60URz4lexXjq2iVrER340bPn8Ez/NhheAKErXnTozp2d/WAW3iL36nyvDO0w/qBPc1q/sXEFKHbA7grBeu2VS4tuG5PQyHEYBePLJM4Jn/4LGdA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Yp5duncyBPdx6BAIt2E0m6c91i9iqDTphcHUsTiaro8=;
 b=qCsl3yswGdxLn1D7oH3tKuwlsEmMOaW8z8M3qgHjPKRc5URk2Muc49JxWFsOU8VYRVSjjF4UVN4B7quJdXGw2uXElEVAtnknN/EO29QxUTv2AHszuoDVVYx2N1/kYjEi3FlOFMPmrdSEYln+9eEzPEk/KL6ahBFWaX7MS7hP95aREC2MzFs16gmd3X4jmhhBHrk7EXq3eNIdmMcktgUwuYaJ3Y8iyLBWnZZoXAZmdJ+26EKkz1HX6i3EwyQ5hvfGEXfE8VoXp/1VsTN4nB3vQkS9CE3XNP4637GZO08FOBtEeE4h3ioWFmXaz33VOLFqN+FNeU2wkLwdc/EcVLmIkQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=redhat.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Yp5duncyBPdx6BAIt2E0m6c91i9iqDTphcHUsTiaro8=;
 b=k99UwYohLZWknpKBCnDdSbFPtR8BKESGkTNaF/cZUnbPBEHJrByzzWm6bpfJ88CMKVMAenKI/HWxTH+fpsMYD5+aVNXurWXSZLhaLYlZwJcZg1k79QQP0tNpQPoJjMMsnkb0MhJkE895uNjHYh7vaQYo9gbxYNvdCLnFg3NaG9o=
Received: from BLAP220CA0016.NAMP220.PROD.OUTLOOK.COM (2603:10b6:208:32c::21)
 by DM3PR12MB9287.namprd12.prod.outlook.com (2603:10b6:8:1ac::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.10; Fri, 11 Sep
 2026 19:17:58 +0000
Received: from LV8PEPF0000005E.namprd02.prod.outlook.com
 (2603:10b6:208:32c:cafe::9a) by BLAP220CA0016.outlook.office365.com
 (2603:10b6:208:32c::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.406.9 via Frontend Transport; Fri, 11
 Sep 2026 19:17:58 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 LV8PEPF0000005E.mail.protection.outlook.com (10.167.245.138) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.406.5 via Frontend Transport; Fri, 11 Sep 2026 19:17:58 +0000
Received: from localhost (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Fri, 11 Sep
 2026 14:17:57 -0500
Date: Fri, 11 Sep 2026 14:16:41 -0500
From: Michael Roth <michael.roth@amd.com>
To: Markus Armbruster <armbru@redhat.com>
CC: <qemu-devel@nongnu.org>, <kvm@vger.kernel.org>, <pbonzini@redhat.com>,
	<berrange@redhat.com>, <pankaj.gupta@amd.com>, <isaku.yamahata@intel.com>,
	<xiaoyao.li@intel.com>, <chao.p.peng@linux.intel.com>, <david@kernel.org>,
	<ashish.kalra@amd.com>, <ackerleytng@google.com>, <lpieralisi@kernel.org>
Subject: Re: [PATCH v2 19/19] hostmem: Automatically select set
 guest-memfd=on for in-place conversion
Message-ID: <nk7ba26g7klayyzttksanzdbwrbbke4o7uusof3a4hgwd3cq2i@ngk52svj7vhd>
References: <20260908205236.838281-1-michael.roth@amd.com>
 <20260908205236.838281-20-michael.roth@amd.com>
 <874ifzos2a.fsf@pond.sub.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <874ifzos2a.fsf@pond.sub.org>
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PEPF0000005E:EE_|DM3PR12MB9287:EE_
X-MS-Office365-Filtering-Correlation-Id: 642e281b-fb11-4de2-c8d1-08df103963d9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|1800799024|36860700016|376014|7416014|82310400026|6133799003|10067099003|4143699003|11063799006|56012099006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	NMjzbIyK9IEXEtIG/z4eteOh3qPZ/iMc83CL/+1EXiOUyl1yuIrp3UWNyaI7AyETZj2PmUm7ocpfWW3XGlCEZ5xvSNx6r4FbKREtM6CRj+RgC1WCh6OB7q9R+ibbB5KIiR/HJEOtiXBQprqvOvVRxxORz+XSx8PQZ612cT0mPNlVrdQqLyT5qKCfPhHOL2BFjYLezIl3fjtChF2pwUA9ogfMEOcbrZLF+pmu0SIV0XyOeHxuj0ghiR4bRLpY+0+UuKsN55KvwODAOBXkJS9whi7vF6PlJmK6ctKL7Me7EaQpCi+IkVW7i20NcR2rR42j6T+ay0oZ3KftAVM94yIwpPEq5XsihdDlqG/8u+7lp+pP4o0SxU3zwNfiiidRArzqDZYlRwKY+zfZMAqd3wkVMHQmc5SxJyfmVyFONdhM4Qk+yKN0mwBtYBKRr39bbPz5hUnyGn8+FEvzA/ut5t+Cxy/VUlAjrcGz7SXHGdFgH0xHD3RzURCWDszBQP81R7VTDptX0J485uC77quUpJYL2pIwbpzpyDBFTlNzmplaMy8KXqyMBffxEvzk4FUF8BNDF1G3XhvqNK+yGWSd7cBKiITnx5y05J0go4Vm+W6FHU/OhtBkiwCvGCEopMQemR/bP2fhHh7JvhCTLUOJQafCoUEQb06sFl2Y9btU/LRZkjxCv0m+YTBMi6EHQEQwkkfnCV1dinS0Mjj5WqL+MgF7Fg==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(23010399003)(1800799024)(36860700016)(376014)(7416014)(82310400026)(6133799003)(10067099003)(4143699003)(11063799006)(56012099006)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	j+S6v8YgJHP61esjlL34OyssxA71qkH4e0VbcX0N3tvYd9AMmxyxUtgCvD/ucqCH0ZY7QPnWfKmM3uFi7TltcBtT7CA+SSsmS98RkZ0o3zS+WLUuh3ed02QVdhnjJgsml620gSmYwAyAxF6uI30uQDoe5yhJTaOPbTGcFVpUukqsXBcevVvsPfDb//TMkmdv3fXueTuyBqvaQdFyd6cTwtDm9GvKj6Y5eFOyGUtcsLbP6v9386EGBZu0019vf97axdJKfx21lyPcz8ou309ZfTE6mqs8DK7S5RDPpDJg+Z8jpgxSh56WkgaZLnKmh3qVYotha1Y7fxvbh52UIS40wU1DGl2GLy9yrGlH07pUvEO+EbUZ2gv0nnhAR6YRrxXeryDRYSDsLIotUZ1Z9ik2aIsLoaEjaXRf09fRfTr5jNW82JzYE+xvN6HlkIpcg22z
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Sep 2026 19:17:58.3854
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 642e281b-fb11-4de2-c8d1-08df103963d9
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	LV8PEPF0000005E.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PR12MB9287

On Wed, Sep 09, 2026 at 08:30:05AM +0200, Markus Armbruster wrote:
> Michael Roth <michael.roth@amd.com> writes:
> 
> > When in-place conversion is enabled, both the shared memory and private
> > memory must come from the same guest_memfd instance. Thus, the
> > memory-backend-memfd options must in turn correspond to a guest_memfd
> > instance, e.g. guest-memfd=on must be specified. Since there is no
> > use-case for enabling in-place conversion without setting
> > guest-memfd=on, just set it automatically if in-place conversion is
> > enabled.
> >
> > Signed-off-by: Michael Roth <michael.roth@amd.com>
> 
> [...]
> 
> > diff --git a/qapi/qom.json b/qapi/qom.json
> > index 20d6fefb04..32df7cb794 100644
> > --- a/qapi/qom.json
> > +++ b/qapi/qom.json
> > @@ -772,7 +772,8 @@
> >  #     resizing of the memory (default: true)
> >  #
> >  # @guest-memfd: if true, use guest-memfd to back the memory region.
> > -#     (default: false, since: 11.2)
> > +#     (default: true for Confidential VMs with in-place conversion,
> > +#     false otherwise, since: 11.2)
> 
> What does "Confidential VMs with in-place conversion" mean exactly?
> Which configuration settings need to be set how?

Will make sure these gets covered in guest-memfd.rst as well so it can be
referenced here.

> 
> >  #
> >  # Since: 2.12
> >  ##
> > @@ -781,7 +782,7 @@
> >    'data': { '*hugetlb': 'bool',
> >              '*hugetlbsize': 'size',
> >              '*seal': 'bool',
> > -            '*guest-memfd': 'bool' },
> > +            '*guest-memfd': 'OnOffAuto' },
> 
> Valid values change from JSON true and false to JSON "on", "off", and
> "auto".
> 
> If @guest-memfd was already in a release, this would be a compatibility
> break, i.e. a hard "don't".  But it isn't, it's in the series this is
> one based on.  So it's merely a "either avoid or justify in the commit
> message, and avoiding feels easier to me."

Sorry, didn't mean for there to be potential ABI breakage here, I was somehow
under the impression that OnOffAuto accepted 'true'/'false' as a backward
compatibility mechanism, but that's clearly not the case.

I'll plan to switch to OnOffAuto in Peter's series so it's defined that
way from the start.

Thanks,

Mike

> 
> The doc comment still uses true and false.
> 
> >    'if': 'CONFIG_LINUX' }
> >  
> >  ##
> 
